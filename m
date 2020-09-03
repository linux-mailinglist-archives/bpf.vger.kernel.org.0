Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38AD25C473
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgICPLC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 11:11:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:41656 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgICPK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 11:10:56 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDqsr-0007EX-S5; Thu, 03 Sep 2020 17:10:41 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDqsr-000Pia-Lz; Thu, 03 Sep 2020 17:10:41 +0200
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     jolsa@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        iii@linux.ibm.com
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
Date:   Thu, 3 Sep 2020 17:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25919/Thu Sep  3 15:39:22 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> On code patching it may require to update branch destinations if the
> code size changed. bpf_adj_delta_to_imm/off increments offset only
> if the patched area is after the branch instruction. But it's
> possible, that the patched area itself is a branch instruction and
> requires destination update.

Could you provide a concrete example and walk us through? I'm probably
missing something but if the patchlet contains a branch instruction, then
it should be 'self-contained'. In the sense that the patchlet is a 'black
box' that replaces 1 insns with n insns but there is no awareness what's
inside these insns and hence no fixup for that inside bpf_patch_insn_data().
So, if we take an existing branch insns from the code, move it into the
patchlet and extend beginning or end, then it feels more like a bug to the
one that called bpf_patch_insn_data(), aka zext code here. Bit puzzled why
this is only seen now, my impression was that Ilya was running s390x the
BPF selftests quite recently?

> The problem was triggered by bpf selftest
> 
> test_progs -t global_funcs
> 
> on s390, where the very first "call" instruction is patched from
> verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.
> 
> The patch includes current instruction to the condition check.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>   kernel/bpf/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ed0b3578867c..b0a9a22491a5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
>   	s32 delta = end_new - end_old;
>   	s64 imm = insn->imm;
>   
> -	if (curr < pos && curr + imm + 1 >= end_old)
> +	if (curr <= pos && curr + imm + 1 >= end_old)
>   		imm += delta;
>   	else if (curr >= end_new && curr + imm + 1 < end_new)
>   		imm -= delta;
> @@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>   	s32 delta = end_new - end_old;
>   	s32 off = insn->off;
>   
> -	if (curr < pos && curr + off + 1 >= end_old)
> +	if (curr <= pos && curr + off + 1 >= end_old)
>   		off += delta;
>   	else if (curr >= end_new && curr + off + 1 < end_new)
>   		off -= delta;
> 

