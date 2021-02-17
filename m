Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5C31D37F
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 01:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBQAvA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 19:51:00 -0500
Received: from www62.your-server.de ([213.133.104.62]:57322 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBQAu7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 19:50:59 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCB2o-00030x-HA; Wed, 17 Feb 2021 01:50:18 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCB2o-000Tew-Bj; Wed, 17 Feb 2021 01:50:18 +0100
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20210216141925.1549405-1-jackmanb@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <80228f01-c43c-f121-0b80-bb368b530111@iogearbox.net>
Date:   Wed, 17 Feb 2021 01:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210216141925.1549405-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26082/Tue Feb 16 13:17:58 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/21 3:19 PM, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 16ba43352a5f..7f4a83d62acc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11889,6 +11889,39 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>   	return 0;
>   }
> 
> +/* BPF_CMPXCHG always loads a value into R0, therefore always zero-extends.
> + * However some archs' equivalent instruction only does this load when the
> + * comparison is successful. So here we add a BPF_ZEXT_REG after every 32-bit
> + * CMPXCHG, so that such archs' JITs don't need to deal with the issue. Archs
> + * that don't face this issue may use insn_is_zext to detect and skip the added
> + * instruction.
> + */
> +static int add_zext_after_cmpxchg(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn zext_patch[2] = { [1] = BPF_ZEXT_REG(BPF_REG_0) };
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	int insn_cnt = env->prog->len;
> +	struct bpf_prog *new_prog;
> +	int delta = 0; /* Number of instructions added */
> +	int i;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (insn->code != (BPF_STX | BPF_W | BPF_ATOMIC) || insn->imm != BPF_CMPXCHG)
> +			continue;
> +
> +		zext_patch[0] = *insn;
> +		new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
> +		if (!new_prog)
> +			return -ENOMEM;
> +
> +		delta++;
> +		env->prog = new_prog;
> +		insn = new_prog->insnsi + i + delta;
> +	}

Looks good overall, one small nit ... is it possible to move this into fixup_bpf_calls()
where we walk the prog insns & handle most of the rewrites already?

> +
> +	return 0;
> +}
