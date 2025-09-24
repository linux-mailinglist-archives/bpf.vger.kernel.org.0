Return-Path: <bpf+bounces-69593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC40B9B7BD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB663A7C2D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E73191BF;
	Wed, 24 Sep 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="nt8Z5a9R"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E7314B73;
	Wed, 24 Sep 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738511; cv=none; b=kJl/zrwJ8o1e1s27oCV3dZy7gbfwWtKuDk2jf6qv36MSmx+AHLH4jZGaUDpwarmxsiWHsxpwHg2MvghXCl5MK4Q3z84Y44tCxNcew1XkTZXqZDzSEi4MZwhb6erL6udQk8VaQKLwG+4JdEvRCpCnNF9VfAfJFRsXpxTayC2M5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738511; c=relaxed/simple;
	bh=0NTk5hGCH950uL2tgJi4Dyy38Ss0hVa2qWvz52HhoIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6rXAolSi3pQZAUgwrQB5ERiF9mRTzlMi9yJhObqWkNxEDoppbiYZCXeT2IJEWqubasIXtyhsQ7A8pMBg09N7yP8PmRFTggrIVNLL4v2egW3njS3BmcB7aUf+Ffvc3Zc3lVPC6yIFokXcGre4HIO1uU/oN+CsPmypFv+GF/hN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=nt8Z5a9R; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cX52B32t6z9sWp;
	Wed, 24 Sep 2025 20:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758738498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRJ0WiqEOH+Zd2vRY4fC24NhpOqoUsV5gvtEbZCpHiI=;
	b=nt8Z5a9Rt0HbEAdguBEDulUBABRy7yLB7eYp93edloS/cR6+GRR65G8vD1K2RvniXUUrrU
	Nuq9CNBzvRJ2xhG9zRtSJ8MbES0XqkjcptO+KYnFoit9fKTh+QhbudtnP+uMI+Zpc/VJCi
	r0zpmzKDx69tMAmBoqplUdrE+XoEbGkSPOsyy26R1oGvhv9scy07dIi4INXYHaPe03Mc5N
	+9McLYnQEqLwOy+0w9KBwNfGZpI75ihKjNSAUCR5WjY6O63aEQ0HEdDOYVOoROEneHNveK
	JoZo8VGnqDdbUBADUcMOi46vIMyObkTgQM3o9IamBhSBx4ond6e8ZvXz+fKBrw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Wed, 24 Sep 2025 23:58:03 +0530
From: Brahmajit Das <listout@listout.xyz>
To: KaFai Wan <kafai.wan@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Message-ID: <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
X-Rspamd-Queue-Id: 4cX52B32t6z9sWp

On 25.09.2025 01:38, KaFai Wan wrote:
> On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das <listout@listout.xyz>
> > > wrote:
> > > > 
> > > > Syzkaller reported a general protection fault due to a NULL
> > > > pointer
> > > > dereference in print_reg_state() when accessing reg->map_ptr
> > > > without
> > > > checking if it is NULL.
> > > > 
> > ...snip...
> > > > -       if (type_is_map_ptr(t)) {
> > > > +       if (type_is_map_ptr(t) && reg->map_ptr) {
> > > 
> > > You ignored earlier feedback.
> > > Fix the root cause, not the symptom.
> > > 
> > > pw-bot: cr
> > 
> > I'm not sure if I'm headed the write direction but it seems like in
> > check_alu_op, we are calling adjust_scalar_min_max_vals when we get
> > an
> > BPF_NEG as opcode. Which has a call to __mark_reg_known when opcode
> > is
> > BPF_NEG. And __mark_reg_known clears map_ptr with
> > 
> > 	/* Clear off and union(map_ptr, range) */
> > 	memset(((u8 *)reg) + sizeof(reg->type), 0,
> > 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg-
> > >type));
> > 
> 
> I think you are right. The following code can reproduce the error.
> 
> 	asm volatile ("					\
> 	r0 = %[map_hash_48b] ll;			\
> 	r0 = -r0;					\
> 	exit;						\
> "	:
> 	: __imm_addr(map_hash_48b)
> 	: __clobber_all);
> 
> 
> BPF_NEG calls __mark_reg_known(dst_reg, 0) which clears the 'off' and
> 'union(map_ptr, range)' of dst_reg, but keeps the 'type', which is
> CONST_PTR_TO_MAP.
> 
> Perhaps we can only allow the SCALAR_VALUE type to run BPF_NEG as an
> opcode, while for other types same as the before BPF_NEG.
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..dbf9f1efc6e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15346,13 +15346,15 @@ static bool
> is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>  	switch (BPF_OP(insn->code)) {
>  	case BPF_ADD:
>  	case BPF_SUB:
> -	case BPF_NEG:
>  	case BPF_AND:
>  	case BPF_XOR:
>  	case BPF_OR:
>  	case BPF_MUL:
>  		return true;
>  
> +	case BPF_NEG:
> +		return base_type(src_reg->type) == SCALAR_VALUE;
> +
> 
> 
> -- 
> Thanks,
> KaFai

Before even going into adjust_scalar_min_max_vals we have a check in
check_alu_op, which I think is not being respected. Going to expand on
this below as response to Alexei.

On 24.09.2025 18:28, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 4:41 PM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das <listout@listout.xyz> wrote:
> > > >
> > > > Syzkaller reported a general protection fault due to a NULL pointer
> > > > dereference in print_reg_state() when accessing reg->map_ptr without
> > > > checking if it is NULL.
> > > >
> > ...snip...
> > > > -       if (type_is_map_ptr(t)) {
> > > > +       if (type_is_map_ptr(t) && reg->map_ptr) {
> > >
> > > You ignored earlier feedback.
> > > Fix the root cause, not the symptom.
> > >
> > > pw-bot: cr
> >
> > I'm not sure if I'm headed the write direction but it seems like in
> > check_alu_op, we are calling adjust_scalar_min_max_vals when we get an
> > BPF_NEG as opcode. Which has a call to __mark_reg_known when opcode is
> > BPF_NEG. And __mark_reg_known clears map_ptr with
> 
> Looks like we're getting somewhere.
> It seems the verifier is not clearing reg->type.
> adjust_scalar_min_max_vals() should be called on scalar types only.

Right, there is a check in check_alu_op

		if (is_pointer_value(env, insn->dst_reg)) {
			verbose(env, "R%d pointer arithmetic prohibited\n",
				insn->dst_reg);
			return -EACCES;
		}

is_pointer_value calls __is_pointer_value which takes bool
allow_ptr_leaks as the first argument. Now for some reason in this case
allow_ptr_leaks is being passed as true, as a result __is_pointer_value
(and in turn is_pointer_value) returns false when even when register
type is CONST_PTR_TO_MAP.

-- 
Regards,
listout

