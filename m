Return-Path: <bpf+bounces-69580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE6B9ABE8
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97BC3AB327
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC018C11;
	Wed, 24 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="MUHZEFJB"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD61311AC;
	Wed, 24 Sep 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728478; cv=none; b=HSx58SIYEYsl+ZixymgYygjOvHY6GN2p/7Ufc5Da6NEXruIhdJgd0VgY6GmOhrc3/T0XL53Xouea0u3JkRGru5Sleb9ptjzlanwFUn86D6Y3MLQba/hRrHlUUhQUOF3lzFcMLB+4IqvsgxtIT1DzU9lSMt5u7gGOZHg0Rh1ZsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728478; c=relaxed/simple;
	bh=oruTVOwqS+pyeenDdFLUFLxtU28+2G+F9Cak8KQH8gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRSnnJPR+67yKKIt/ViLIdRycs5Ikvc3zDHCrtPKgHynGlbcPPjrWDd08q3xvmfoQW+e1/InBC++5vLG4Eb4OXtw4bQP5eSFmGoBIFNlQLaoUjDofo19eroOabq4CNeEEX7X2rdPl/J+DjA67v3TBBh+mQ2jpeKD9GepSvC0YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=MUHZEFJB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cX1KN1r3xz9tSm;
	Wed, 24 Sep 2025 17:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758728472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUcY6dWrJzii9UCjkBsQm4njeVeP/FMhTiIiLYETlag=;
	b=MUHZEFJBFsgaH4/5o640P+9MKZjztmba/YrI5CLWEeLq/kivx7Qvix4W7FM0WJGoL/egk0
	RpGZXuSOpNWSKA5xScI56J0Ux/GJhhfDBAWBxwWJlucWa106gaL+C971564Haovqhg1Xj2
	7claMMRAfVpSb/vfMarZ6Bq4uKvcwKimBPsCU2I06WiRovO9tViOAqi8GLSb7WfPIZEHcV
	QxVuzVApH8v6mxGu25Cx6QiNxoetAnW1yaAgYKmYRztZoOVCR08+9wD8lBOY+bUgJ3mwZf
	2DEp5I2Bysnn3YgdhLrRJSQWpNFIHLVU8hkneIV0D0I54r9By65NAtAcmrSjwg==
Date: Wed, 24 Sep 2025 21:10:56 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Message-ID: <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>

On 24.09.2025 09:32, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > Syzkaller reported a general protection fault due to a NULL pointer
> > dereference in print_reg_state() when accessing reg->map_ptr without
> > checking if it is NULL.
> >
...snip...
> > -       if (type_is_map_ptr(t)) {
> > +       if (type_is_map_ptr(t) && reg->map_ptr) {
> 
> You ignored earlier feedback.
> Fix the root cause, not the symptom.
> 
> pw-bot: cr

I'm not sure if I'm headed the write direction but it seems like in
check_alu_op, we are calling adjust_scalar_min_max_vals when we get an
BPF_NEG as opcode. Which has a call to __mark_reg_known when opcode is
BPF_NEG. And __mark_reg_known clears map_ptr with

	/* Clear off and union(map_ptr, range) */
	memset(((u8 *)reg) + sizeof(reg->type), 0,
	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));

-- 
Regards,
listout

