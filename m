Return-Path: <bpf+bounces-11813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8137C0073
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AB1C20CC8
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424D2745B;
	Tue, 10 Oct 2023 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LdI9Vg1q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49427453
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 15:35:18 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE0099;
	Tue, 10 Oct 2023 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YSj7Og7GMhEdxDFXztAZwfRfzfreB00qr43Omn8psvw=; b=LdI9Vg1qcYWMu7L/YG0+MEsMr7
	CHqIGpLjgQSBovApfjNZYfKQQO875Rzb6vTsq2rrObdbwI1+3vXzUn0rmOuWlcWHebidwk/mU0Fw8
	daY1G/8CFraYZFjafpgJy8imIJa8z/fFLBFHjL9MFbKRI01rvr1VX9jPn3AkMD0v/B3Sk1vOWicT0
	6SFQIz5+sRjk17JPCVvoJUpAqfq2ozJHkRAxeUVcuuE0Pg2bfZlEzcX4G9xjP0Zb/Vmm6u9oHrCSj
	h8ctudMOmYgYDNeQ2xreHm6rGpLMz4RtvmGN8Ej24pCiieUwc1pDjtKAxZc++Dcoft3vmdleaYVPB
	FC5qNFlg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqElG-0006TP-V3; Tue, 10 Oct 2023 17:35:06 +0200
Received: from [178.197.249.27] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqElG-000PTn-ET; Tue, 10 Oct 2023 17:35:06 +0200
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during
 check_cfg()
To: Hao Sun <sunhao.th@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch>
 <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
 <CACkBjsbM8=NLwwEUea21vqCrn-w9cn21gL3BNpU4AupYnuCvJg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0c892e68-3092-0b21-3331-a5e3cad43800@iogearbox.net>
Date: Tue, 10 Oct 2023 17:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACkBjsbM8=NLwwEUea21vqCrn-w9cn21gL3BNpU4AupYnuCvJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27057/Tue Oct 10 09:39:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 11:17 AM, Hao Sun wrote:
[...]
> I regard this as a fix, because the verifier log is not correct, since
> the program does
> not contain any invalid ld_imm64 instructions in this case.
> 
> I haven't met other cases not captured via check_ld_imm(), but somehow, I think
> we probably want to convert the check there as an internal bug,
> because we already
> have bpf_opcode_in_insntable() check in resolve_pseudo_ldimm64(). Once we meet
> invalid insn code here, then somewhere else in the verifier is
> probably wrong. But
> I'm not sure, maybe something like this:

Makes sense, you could probably add this into your series as a separate commit.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eed7350e15f4..bed97de568a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14532,8 +14532,8 @@ static int check_ld_imm(struct
> bpf_verifier_env *env, struct bpf_insn *insn)
>          int err;
> 
>          if (BPF_SIZE(insn->code) != BPF_DW) {
> -               verbose(env, "invalid BPF_LD_IMM insn\n");
> -               return -EINVAL;
> +               verbose(env, "verifier internal bug, invalid BPF_LD_IMM\n");

If so please stick to the common style as we have in other locations:

verbose(env, "verifier internal error: <xyz>\n");

> +               return -EFAULT;
>          }
>          if (insn->off != 0) {
>                  verbose(env, "BPF_LD_IMM64 uses reserved fields\n");
> 

