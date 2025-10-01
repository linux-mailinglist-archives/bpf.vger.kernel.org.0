Return-Path: <bpf+bounces-70131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACDBB1886
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470EA3C34EE
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFA2D6E53;
	Wed,  1 Oct 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="OXAzqeLT"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D712D4817;
	Wed,  1 Oct 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344572; cv=none; b=AdbJdVEohjO8dS1LlGFeOrb34/+gcLKwtQtQq4zkUHVbLMQspuO/gvptfJtrcXL+Kazx6nrF6MROfLlleHVEW17UYaVs0jfexIS9isqhQ4qy35h3acWH20xQ7UedKBs2WSvu1/5Jyyao/u1JkJ733Hdw5e8iTbdybKHEgd2r1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344572; c=relaxed/simple;
	bh=Br5Z7ENROG1oKqn707oAYXvSDsK+xTeCNh5WoOpFN7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHFzAEKVckD7kF5g7gFrvyNKDPBZikOqLBfusJODTWZwesyIMbFymEto7nNrrnlmaNFctRzZ/EK3UftNeYjbQgStDku184mmz4nP6r7oD8qlevShaTQiqpaAnfJbLSy+by33prA4OI/V2oMIfcNWHXlRU6PaJMk8Qf/6DKsMPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=OXAzqeLT; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ccP9L2lFDz9vC5;
	Wed,  1 Oct 2025 20:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759344566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wKcJ2OvvNFh3Y9n2a5LKoqD7sQGQaZiU9BU8j7joIQ=;
	b=OXAzqeLTtCiTZM1Fy4Q8MlE00zjC0IrvV1v/c+ncTr/RclayEzwv7DfhXMj2uoTFXlYVoq
	wbTecFbEjeWMGjDmAkEfOhty8jeZCtc/gWu/uZOJE/mi1W6GksDZY0g6Ft/O/CPJnPxcUu
	P6J71fx49JLBnUv826UEK6SLMdtl6JuAfrXjwBGXq0HOROn8JXOyrgU8Lb4yZO2KlSEVaf
	z1M6Asc4cK+vbEQEgSWqY53gT9xuIQUgsBdumY34I3D+LYMan9egW7ef/89wws5VioiSim
	0vx5qQGPTAYw4OqiY+RZapxD2RW19Zxp8avY2NPVXt6MZEC0InSi1dePTXg9Gg==
Date: Thu, 2 Oct 2025 00:19:11 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, kafai.wan@linux.dev
Subject: Re: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is
 a pointer
Message-ID: <zq2pmlsmmduelzniwez7hnwygx5vl2byrvtvjfabpjtvrwjcxl@eej2larvujkk>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20251001095613.267475-1-listout@listout.xyz>
 <20251001095613.267475-2-listout@listout.xyz>
 <0a2232a7faa9077ba7a837e066bd99bab812e4a6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a2232a7faa9077ba7a837e066bd99bab812e4a6.camel@gmail.com>

On 01.10.2025 11:29, Eduard Zingerman wrote:
> On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> > In check_alu_op(), the verifier currently calls check_reg_arg() and
> > adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> > However, if the destination register holds a pointer, these scalar
> > adjustments are unnecessary and potentially incorrect.
> > 
> > This patch adds a check to skip the adjustment logic when the destination
> > register contains a pointer.
> > 
> > Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
> > Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> > Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
Thanks
> 
> Nit: I'd made this a bit simpler: `regs[insn->dst_reg].type == SCALAR_VALUE`,
>      instead of __is_pointer_value() call.
> 
> >  			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> >  			err = err ?: adjust_scalar_min_max_vals(env, insn,
> >  							 &regs[insn->dst_reg],
Do I need to send a v4?

-- 
Regards,
listout

