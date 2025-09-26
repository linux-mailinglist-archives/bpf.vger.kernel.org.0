Return-Path: <bpf+bounces-69801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D02BA22C4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 03:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540D0162E27
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AB1DF254;
	Fri, 26 Sep 2025 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="oET5dYmh"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3034BA35;
	Fri, 26 Sep 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851788; cv=none; b=U4Hm7zkLRnMeptWFIbpYs1e/ops1KTq7zugZeOpkVlZJGF0/7WQlSQIgP51hq2RTEpVKctWoIQ/Ke8SiT7/CpFdKzrO2DNNacqxEcF8I2nq7AxBGCi2Y2mlPICS8lzpVIpdj6UNABKIkfwHTdCj1eseYufDgzONQWyrXm/uyxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851788; c=relaxed/simple;
	bh=7oZJFXsTWT5oYeOGxzQNWCiMQvQXOZw6Arh9U6lC1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiZ6TY8/9+UD/S3+HSTGPSlDYUalSGIDej1Ffnouz0TKa2ZFOtfpdjcheH1+pBEs7hDv8i+ONXVPV3E99sQ6Aafrvjwd9NDbpmCGyw8JXAkvZ168a/0icF+igj/hhURCzaQKWMaxG3cExzQr8uDDr29L58VM01JYqsl+l3YzZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=oET5dYmh; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cXtwk6pTYz9tYL;
	Fri, 26 Sep 2025 03:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758851783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXkul67qbIi/sjuQ3RZkWGCkK8QBcl1GR0mT28ksjCc=;
	b=oET5dYmh6G5asRa56xLRozZtIt30IpsAn0GpIzFy7kOsmBE9fmhVxtKMR/Woh6L8wWPRH+
	/tp68L+gT0Gs1WP+zKseeeLEl6tP8X7knjZsN6hh4TjZvKZrqKFbbJNWlnga39HZRmqBAI
	bvoiH0vSt5j72nccXPDSQExzjMb7urdXfpWjw9UA2ELoVErmLPaM9+H4XqYiJ75r65W4pt
	3heQcBOxpDEe957bUo1dcMHXa9/4IiynRa/JoRvRLNUeLSZHVxkAWekKKfh5WWpTR0zok7
	5eh6qVk8CM+meFSqFbet4qGxZR3jQ4aVl2FOcNqxQtS4ZXalhnDQc4Sdmko9CQ==
Date: Fri, 26 Sep 2025 07:26:14 +0530
From: Brahmajit Das <listout@listout.xyz>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Message-ID: <cdv7vgob4ulsmmgmyklgoi5ttzyhby6zmlr2s2kjq6m2dxrnpi@7c2umi7pfhyg>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
 <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
 <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>
 <5fjhzkvgvbpcm2vvqlxhgcobbkiwvo36aalj5lbqrfbznbpynf@jzokg4ba2mwp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fjhzkvgvbpcm2vvqlxhgcobbkiwvo36aalj5lbqrfbznbpynf@jzokg4ba2mwp>

On 26.09.2025 06:34, Brahmajit Das wrote:
> On 25.09.2025 23:31, KaFai Wan wrote:
> > On Wed, 2025-09-24 at 23:58 +0530, Brahmajit Das wrote:
> > > On 25.09.2025 01:38, KaFai Wan wrote:
> > > > On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > > > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > > > On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das
> > > > > > <listout@listout.xyz>
> > > > > > wrote:
> > > > > > > 
> > > > > > > Syzkaller reported a general protection fault due to a NULL
> > > > > > > pointer
> > > > > > > dereference in print_reg_state() when accessing reg->map_ptr
> > > > > > > without
> > > > > > > checking if it is NULL.
> > > > > > > 
> ...snip...
> > > > 
> > > > Looks like we're getting somewhere.
> > > > It seems the verifier is not clearing reg->type.
> > > > adjust_scalar_min_max_vals() should be called on scalar types only.
> > > 
> > > Right, there is a check in check_alu_op
> > > 
> > > 		if (is_pointer_value(env, insn->dst_reg)) {
> > > 			verbose(env, "R%d pointer arithmetic
> > > prohibited\n",
> > > 				insn->dst_reg);
> > > 			return -EACCES;
> > > 		}
> > > 
> > > is_pointer_value calls __is_pointer_value which takes bool
> > > allow_ptr_leaks as the first argument. Now for some reason in this
> > > case
> > > allow_ptr_leaks is being passed as true, as a result
> > > __is_pointer_value
> > > (and in turn is_pointer_value) returns false when even when register
> > > type is CONST_PTR_TO_MAP.
> > > 
> > 
> > IIUC, `env->allow_ptr_leaks` set true means privileged mode (
> > CAP_PERFMON or CAP_SYS_ADMIN ), false for unprivileged mode. 
> > 
> > 
> > We can use __is_pointer_value to check if the register type is a
> > pointer. For pointers, we check as before (before checking BPF_NEG
> > separately), and for scalars, it remains unchanged. Perhaps this way we
> > can fix the error.
> > 
> > if (opcode == BPF_NEG) {
> > 	if (__is_pointer_value(false, &regs[insn->dst_reg])) {
> > 		err = check_reg_arg(env, insn->dst_reg, DST_OP);
> > 	} else {
> > 		err = check_reg_arg(env, insn->dst_reg,
> > DST_OP_NO_MARK);
> > 		err = err ?: adjust_scalar_min_max_vals(env, insn,
> > 						&regs[insn->dst_reg],
> > 						regs[insn->dst_reg]);
> > 	}
> > } else {
> > 
> > 
> > -- 
> > Thanks,
> > KaFai
> 
> Yep, that works.
> 
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15505,10 +15505,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
> 
>                 /* check dest operand */
>                 if (opcode == BPF_NEG) {
> -                       err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> -                       err = err ?: adjust_scalar_min_max_vals(env, insn,
> -                                                        &regs[insn->dst_reg],
> -                                                        regs[insn->dst_reg]);
> +                       if (__is_pointer_value(false, &regs[insn->dst_reg])) {
> +                               err = check_reg_arg(env, insn->dst_reg, DST_OP);
> +                       } else {
> +                               err = check_reg_arg(env, insn->dst_reg,
> +                                                   DST_OP_NO_MARK);
> +                               err = err   ?:
> +                                             adjust_scalar_min_max_vals(
> +                                                     env, insn,
> +                                                     &regs[insn->dst_reg],
> +                                                     regs[insn->dst_reg]);
> +                       }
>                 } else {
>                         err = check_reg_arg(env, insn->dst_reg, DST_OP);
>                 }
> 
> I'll just wait for other developer or Alexei, in case they have any
> feedback before sending a v3.

Just my 2 cents, thought this looked cleaner

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15497,7 +15497,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
                if (err)
                        return err;

-               if (is_pointer_value(env, insn->dst_reg)) {
+               if (is_pointer_value(env, insn->dst_reg) ||
+                   __is_pointer_value(false, &regs[insn->dst_reg])) {
                        verbose(env, "R%d pointer arithmetic prohibited\n",
                                insn->dst_reg);
                        return -EACCES;

-- 
Regards,
listout

