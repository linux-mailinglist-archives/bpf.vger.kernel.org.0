Return-Path: <bpf+bounces-58185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394ECAB6A62
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877871885DDE
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828C2797BB;
	Wed, 14 May 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKpcLKpe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB022797AB
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222878; cv=none; b=X98pVHuKpayvu+n3DQy+G9l5nsbd8msALbyxRHS4Lkk05js7pxOrrQPH9PR1VhiGpbr4edWYLzI1Pn4TP9NlpGsvsk8qUjrxicJ7+nuufg1GgEAekl+TmjwuRC03dCAVaxRmWhPgpbci/mX8UaHsU8E3ice9TWs4I9arXHVVlcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222878; c=relaxed/simple;
	bh=WanZCUEU17saFHUCImK5SvOnfEJyrCw0R5nmt/u3b9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZa0Lr9vRpVe5AAMbRpnMBbGXoGbZicepT2qI8Pcwoe1nUuEV71v6iL5UOxxiNRJpgJxdvlUUyzzMgziYNWmJ9S0xWQaLOutw0aOzA4ZBeuwa1urU4uOt0KyaXDaEW9vzWvPsrtrGa1mu2BkJvP4jzJOW1tEF2IHaP3OeDB0aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKpcLKpe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso15351575e9.2
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747222875; x=1747827675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2bEsR3Jhbts1r+d6R60nPD4kaKSCsta4QO6+Vgn2ssU=;
        b=JKpcLKpe+Jsusi/Hkf9jm62RUzc+kcDsCw5XF3wOXcFjzCJ68pLxqMYdjd9V/K44h7
         V9TUn8YJuYl1qIvOGviqNpRHYMDwTifXO3FwXFBVcRUZCMI9CSyI8nkGoCsHkWBN+HVF
         Jti9t35Y6bJyu7PhVcqMRUn+OzC5gOawmg1LM55haqEm6ALc7l+Fa7qiPWYRb6bODQ+Z
         QwvwjLuy+IPCYGarWP+ORqtcWmhJfpAe87tNr204vj3priwHwd80/DKRl3VjgBTDVnjS
         1BGaJmRsIYB0g91OfCLYXGTD4JQpPYy2WsQ+Ot/UbaA5Ulj7s8WpcHB+YIkxnVzdVNLG
         amEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747222875; x=1747827675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bEsR3Jhbts1r+d6R60nPD4kaKSCsta4QO6+Vgn2ssU=;
        b=rx/Oi9BM1vBc7bAGKtihrUn5C9x/mxtDbNi52pU7U5jePPBbnO8ZhdggwD/jFTwrnc
         BBTW2SoGHMJziyhOIJ8ULPQsC5ePjcbRjr07r0sEkaxO4fy045RTAPAIRqK2oaNGYqBQ
         OQeNwA80hoLCvDdpxt8IDXCN4zhWTDMG4qScdQe0KQRjxGXEhMq8nPavAFgxCOzaBB4n
         E9oShaTFVtIBQIrFSMKoziXZDTzQc4viGapNA+km938BdTwf0IttiCr8N/+yPkAyeH5b
         JTuDOE3dgE44L27NqqGs6/o7XmJF/wvVpCrfq3EROi3ysMEOSjU4vV/gRIyH7nEln2i1
         4XOw==
X-Forwarded-Encrypted: i=1; AJvYcCUNLgxDsGuIYWCNQdhtmpFsZukVYF2XenvBaTH/PoPAjrpo6Zg2DQsrAifWGkQyfv+nO0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMthQSXktBoQEZ5p6Nhq3lV5k8slFDrWCPQwriqboOsG+QsXn0
	XZhlsggcd+UbNmNIZQQ3i37mBANGCwzhoJrlwhjsufw8H2BysVRK
X-Gm-Gg: ASbGnctqlPzx7EYA5qFRhBXK7bn/7ojhs81HrGAImQZfhoPYnClrSF2VM+3ZR76SoCz
	Z6QFlz9BGnzjAUwm2hEdqUXq9QzwJyclDzdc+woAtbhu9mY9+tXeWLp5KHQq2HMD0DgqjIHkqF2
	t8XF5vYupcXyDr+/acQ7BCazrbl22VIHU63nxJgZ3GU8KqziWoPuCm/L6DH03nSqV/j8UsufTfg
	y78KtonRN7UNk3k0dUSEg2xqeFuuUyqI3dNgZMbQHfsrwLCkxfyaeNtXJIdYhUD+j4ZdgtR/sL2
	J07k7y8bJzMiDO64pPHJ91WhUQJX3ejo8N+5ZUirVEYeHPTQ6OUj/1CQ5CkmyEJ7iuuOAeE4jVd
	oTuBC7L4WP1Rr68ev0wrxORiVZLrpBWoVZLMRLNVb1hfORfNhzeZ6nDSYPbmC
X-Google-Smtp-Source: AGHT+IHzgEEbwTpqHTim0jP1UkgrV6RbEFHHR9IKLZBjQmE6xWQcwuQ8A8rp0fTgB7IkzJ6iAXh1bw==
X-Received: by 2002:a05:600c:b86:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-442f20e5ef5mr29293295e9.14.1747222874603;
        Wed, 14 May 2025 04:41:14 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00115f8f671ea56e36.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:115f:8f67:1ea5:6e36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f338050csm26273495e9.10.2025.05.14.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:41:13 -0700 (PDT)
Date: Wed, 14 May 2025 13:41:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Always WARN_ONCE on verifier bugs
Message-ID: <aCSBVzbi3zxpqegr@mail.gmail.com>
References: <aB0WvXLMx5DIivc-@mail.gmail.com>
 <CAADnVQK7m=B7qg_uWV_GguG7NA+H4Wk-Rz7XNckUw0fww8zW9A@mail.gmail.com>
 <1a803587-508c-4e73-9c06-344fb9330023@iogearbox.net>
 <CAADnVQJySbzjgMVC7+ENW=dXuU-CpN+XKHPgb+Q4twuMadmOMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJySbzjgMVC7+ENW=dXuU-CpN+XKHPgb+Q4twuMadmOMA@mail.gmail.com>

On Fri, May 09, 2025 at 10:58:00AM -0700, Alexei Starovoitov wrote:
> On Fri, May 9, 2025 at 1:26 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 5/9/25 12:31 AM, Alexei Starovoitov wrote:
> > > On Thu, May 8, 2025 at 1:40 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> > >>
> > >> Throughout the verifier's logic, there are multiple checks for
> > >> inconsistent states that should never happen and would indicate a
> > >> verifier bug. These bugs are typically logged in the verifier logs and
> > >> sometimes preceded by a WARN_ONCE.
> > >>
> > >> This patch reworks these checks to consistently emit a verifier log AND
> > >> a warning. The consistent use of WARN_ONCE should help fuzzers (ex.
> > >> syzkaller) expose any situation where they are actually able to reach
> > >> one of those buggy verifier states.
> > >
> > > No. We cannot do it.
> > > WARN_ONCE is for kernel level issues.
> > > In some configs use panic_on_warn=1 too.
> > > Whereas a verifier bug is contained within a verifier.
> > > It will not bring the kernel down.
> >
> > Agree.
> >
> > > We should remove most of the existing WARN_ONCE instead.
> > > Potentially replace them with pr_info_once().
> >
> > Just a thought, maybe one potential avenue could be to have an equivalent of
> > CONFIG_DEBUG_NET which we make a hard dependency of CONFIG_DEBUG_KERNEL so that
> > /noone/ enables this anywhere in production, and then fuzzers could use it
> > to their advantage. The default case for a DEBUG_BPF_WARN_ONCE would then fall
> > to BUILD_BUG_ON_INVALID() which lets compiler check validity but not generate
> > code.
> 
> Good idea.
> but I'm not a fan of the new kconfig.
> I'd rather combine some of them.
> Like make CONFIG_BPF_JIT depend on CONFIG_BPF_SYSCALL.
> That would remove a ton of empty static inline helpers.
> 
> For this case doing WARN_ON only when IS_ENABLED(CONFIG_DEBUG_KERNEL)
> should be fine.
> 
> I guess we can introduce BPF_WARN_ONCE() and friends family of macros
> and use them everywhere in kernel/bpf/ where the warning is not
> harmful to the kernel ?

Thanks for the reviews! I've sent a v2 that introduces BPF_WARN_ONCE and
uses it in verifier_bug() to emit a warning iff CONFIG_DEBUG_KERNEL is
enabled.

I've refrained from replacing all WARN_ONCE at once as I'm not sure I
have all the context yet to know when BPF_WARN_ONCE is more appropriate.
That said, we should be able to use it for other cases and introduce
sibling macros as we go.

