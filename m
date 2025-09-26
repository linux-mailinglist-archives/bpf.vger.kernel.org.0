Return-Path: <bpf+bounces-69800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604FBA21E6
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 03:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C124189A0E7
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AB170A11;
	Fri, 26 Sep 2025 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="qq7l56sJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82873374C4;
	Fri, 26 Sep 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758848673; cv=none; b=IF4RuOnMgyM5t1OF5FVRZqTHrnXPL7h1GAxtAHbMSa8R4kOtoUvMaHINienTgd6fry3mfu7bHisKBn1FvKkC4KGIFdEpeigC6gAFm9KFRbJ4FgXG4DJ828I+LCWmIh/Vh1m+Hmm/0N3LXnJXJ9KYbGP1dOzaO8etimFDQPTzyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758848673; c=relaxed/simple;
	bh=oLmDSJNdpoLwPaidEcnwsYrqjVdl9EpZZx7P1f4xlVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVDPHx33j6EdBb7VUJcNnBwVjnX3EP/Az4JEjZXiJLDmR60Uao202FtyO/ryTcgvreUJrdrpe76PbAmC1Yolh/dEEKhF+O0mRJjFGvAKIRq9L24j5IVCnie7Jgsf4qG0jqHwLlyJmXeLudfeOB1H1FS10hOuw4faCqWXgc2E9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=qq7l56sJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cXsmp1vVlz9stG;
	Fri, 26 Sep 2025 03:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758848666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTLrdj3GZdHnJaUp/nrT7MuKvNwikDSkk9dCd6XBhbo=;
	b=qq7l56sJZBYfZBNZ3i0TiyRp33urO5yqDNzqVohcLxvQhm4T/Th0Qku/rg/vgBlCu7i/CX
	fbW9+y7S7CghZArfrwo4DM9eoyKNRdjQ4YlrOdLO/Qz0jfTgP0rzYSKNHj7WuoZSc80AvR
	eFv/U90wjkgQ1EkRp1plO53BJ7yr+KIsAZP6TTxKq1PAdbyi+3cU0ynldd4Zb/0B+0AoeR
	KJpogVJDtcqFJu+Oll7WqUlRAormfsxk/CcoRF8Z5NZCD9lavMzmDWFFj10Sk72wu/PJT6
	wMNnHwXslWQ5Ykp3UAaiaimT9RK+7bQYaRt6mNyY113QEk2495FRNP1qK3DSEQ==
Date: Fri, 26 Sep 2025 06:34:11 +0530
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
Message-ID: <5fjhzkvgvbpcm2vvqlxhgcobbkiwvo36aalj5lbqrfbznbpynf@jzokg4ba2mwp>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
 <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
 <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>

On 25.09.2025 23:31, KaFai Wan wrote:
> On Wed, 2025-09-24 at 23:58 +0530, Brahmajit Das wrote:
> > On 25.09.2025 01:38, KaFai Wan wrote:
> > > On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > > On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das
> > > > > <listout@listout.xyz>
> > > > > wrote:
> > > > > > 
> > > > > > Syzkaller reported a general protection fault due to a NULL
> > > > > > pointer
> > > > > > dereference in print_reg_state() when accessing reg->map_ptr
> > > > > > without
> > > > > > checking if it is NULL.
> > > > > > 
...snip...
> > > 
> > > Looks like we're getting somewhere.
> > > It seems the verifier is not clearing reg->type.
> > > adjust_scalar_min_max_vals() should be called on scalar types only.
> > 
> > Right, there is a check in check_alu_op
> > 
> > 		if (is_pointer_value(env, insn->dst_reg)) {
> > 			verbose(env, "R%d pointer arithmetic
> > prohibited\n",
> > 				insn->dst_reg);
> > 			return -EACCES;
> > 		}
> > 
> > is_pointer_value calls __is_pointer_value which takes bool
> > allow_ptr_leaks as the first argument. Now for some reason in this
> > case
> > allow_ptr_leaks is being passed as true, as a result
> > __is_pointer_value
> > (and in turn is_pointer_value) returns false when even when register
> > type is CONST_PTR_TO_MAP.
> > 
> 
> IIUC, `env->allow_ptr_leaks` set true means privileged mode (
> CAP_PERFMON or CAP_SYS_ADMIN ), false for unprivileged mode. 
> 
> 
> We can use __is_pointer_value to check if the register type is a
> pointer. For pointers, we check as before (before checking BPF_NEG
> separately), and for scalars, it remains unchanged. Perhaps this way we
> can fix the error.
> 
> if (opcode == BPF_NEG) {
> 	if (__is_pointer_value(false, &regs[insn->dst_reg])) {
> 		err = check_reg_arg(env, insn->dst_reg, DST_OP);
> 	} else {
> 		err = check_reg_arg(env, insn->dst_reg,
> DST_OP_NO_MARK);
> 		err = err ?: adjust_scalar_min_max_vals(env, insn,
> 						&regs[insn->dst_reg],
> 						regs[insn->dst_reg]);
> 	}
> } else {
> 
> 
> -- 
> Thanks,
> KaFai

Yep, that works.

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15505,10 +15505,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)

                /* check dest operand */
                if (opcode == BPF_NEG) {
-                       err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
-                       err = err ?: adjust_scalar_min_max_vals(env, insn,
-                                                        &regs[insn->dst_reg],
-                                                        regs[insn->dst_reg]);
+                       if (__is_pointer_value(false, &regs[insn->dst_reg])) {
+                               err = check_reg_arg(env, insn->dst_reg, DST_OP);
+                       } else {
+                               err = check_reg_arg(env, insn->dst_reg,
+                                                   DST_OP_NO_MARK);
+                               err = err   ?:
+                                             adjust_scalar_min_max_vals(
+                                                     env, insn,
+                                                     &regs[insn->dst_reg],
+                                                     regs[insn->dst_reg]);
+                       }
                } else {
                        err = check_reg_arg(env, insn->dst_reg, DST_OP);
                }

I'll just wait for other developer or Alexei, in case they have any
feedback before sending a v3.

-- 
Regards,
listout

