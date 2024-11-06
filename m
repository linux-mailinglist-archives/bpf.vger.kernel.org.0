Return-Path: <bpf+bounces-44088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C29BDAE5
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235B71F225E3
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87AF156962;
	Wed,  6 Nov 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM+nuh+R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3302824A3
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855275; cv=none; b=LnBWnzpjOA+AHPQVft2gCkB/dPcO/wEI2OyLt/6dAUlCQWeE3y7Y6CNOd+J2IASnfxjrymorjKHMNLeXs07MDti+gXU62LVOplzJ6KTJWvFNc1liP/b5p6L53mTLWQzq/2hTATg18FnW0ZpUup1yPvEJgzfMSWm6rTJCx7Zwxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855275; c=relaxed/simple;
	bh=Uz7NASBZ3FUZ/NVIbg8ppmIR3f3NurOkayFpFXcfbzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLXXT6v24TLt/+fwXsyu5xLzDNXE0KCrZARufM0jiSiyxTbJW6CJ3XQh3CFUV5xEgNBHusG0oBMC32t0Uj9l9h5jsSG5Ag8Lo7xjBSy1aca9NntbVzN/Y2+08D+6JnIUhCFOFf7ZfETdPRpSQ2EfP2+8oEv5ptfvo3cJSS4KyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM+nuh+R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3ecad390so186253f8f.1
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730855272; x=1731460072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYziDM9Op0LKlQ/oyB6vYS5TbSVxHRcxqnmQFQb6hW8=;
        b=WM+nuh+RrzfMSsdKvqAz63hvJNpezSrJcUskaveHrm0apX025JnbizViKJJGBPach6
         uMnGjXcwi4UNWODO1ULIpkTnNx1upDowPndRMRYWgLIMiGbKUV2ySavs6yAMYSIstF0h
         F3dE3QSGVok5AvCM24hQg3QBG+Cd7yM52geOWc7FRLXBo46fMDi6jII939XvtvD7E+jJ
         fHoQVgL4fiUQutMlEWVHWa1KNJfal+Ypj7f+D2DwaHjDH5iswsWtgShiDBw3c7l8RAad
         1Nf4Gr3lq2VpRa6EsEwCovW+KeZSWcx6pxwiAfJi1liCh2UshZIf8+3NJ7Z3TFvO9L/U
         sAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855272; x=1731460072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYziDM9Op0LKlQ/oyB6vYS5TbSVxHRcxqnmQFQb6hW8=;
        b=W2b8iMtv7fFy44XBAtZ6bXMgtWei5pvfS0UhItPJiz6UJDyUVowMgfMsY0t7IwLCPs
         btG38UvobH5DH7PX3ul+dYMbtPDRY6boLm9/mgS9Op8NtgLebUPyM+JnuTGh/ibpKwmU
         VNVE6lUJ7JDTahhS4Jbub1PFHSKbt00bJ6U4Cgf1u/9H7vGWybdAnaluPxtVRCbKO0a3
         YE5yFfGG+XsTH/ZYIvuDrJqGH9atzw0q/loxisJq9H0kwfmFvwmPw2GbXh7SlOHzhTRb
         KdjRP/WWs+f2IOcT5G7I1iBHQLYust8cr/n8sw1rGqZb/XwZc7Ls1S8iyE3OqfgHCOKD
         DLFA==
X-Gm-Message-State: AOJu0YwrqIAqdXtWFWQM91mJv2R+ryKfvflvDqgdAVUZBudOU+McVzD9
	OnL+IDz/noGQg3z82Baq60bwfw80aKM7KydGMYMj/vHSCQw8LIB/nTHy7xuRox84XXHBil5+LWk
	1iyc7F19brfdgEbEn53hDgXVIIAX7Dg==
X-Google-Smtp-Source: AGHT+IE9ymf48vF9QLbGH9Sb3JA1uo6TO3mYWO3QY+LN3U9Z9Cfx6BS2j2c5Y91dVlr0EEQqOKD2v0vWv6sb7/9gyRk=
X-Received: by 2002:a05:6000:480d:b0:381:e744:cf3a with SMTP id
 ffacd0b85a97d-381e8204881mr540224f8f.22.1730855271765; Tue, 05 Nov 2024
 17:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev> <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev> <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev> <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
 <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev>
In-Reply-To: <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 17:07:40 -0800
Message-ID: <CAADnVQ+ohxtXEc8WufQoJQByRFMSD9427X_dsKWQFBv9dGzveA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:19=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
>
> On 11/5/24 1:52 PM, Alexei Starovoitov wrote:
> > On Tue, Nov 5, 2024 at 1:26=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>> I see. I think it works, but feels complicated.
> >>> It feels it should be possible to do without extra flags. Like
> >>> check_max_stack_depth_subprog() will know whether it was called
> >>> to verify async_cb or not.
> >>> So it's just a matter of adding single 'if' to it:
> >>> if (subprog[idx].use_priv_stack && checking_async_cb)
> >>>      /* reset to false due to potential recursion */
> >>>      subprog[idx].use_priv_stack =3D false;
> >>>
> >>> check_max_stack_depth() starts with i=3D=3D0,
> >>> so reachable and eligible subprogs will be marked with use_priv_stack=
.
> >>> Then check_max_stack_depth_subprog() will be called again
> >>> to verify async. If it sees the mark it's a bad case.
> >>> what am I missing?
> >> First I think we still want to mark some subprogs in async tree
> >> to use private stack, right? If this is the case, then let us see
> >> the following examle:
> >>
> >> main_prog:
> >>      sub1: use_priv_stack =3D true
> >>      sub2" use_priv_stack =3D true
> >>
> >> async: /* calling sub1 twice */
> >>      sub1
> >>        <=3D=3D=3D we do
> >>               if (subprog[idx].use_priv_stack && checking_async_cb)
> >>                   subprog[idx].use_priv_stack =3D false;
> >>      sub1
> >>        <=3D=3D=3D here we have subprog[idx].use_priv_stack =3D false;
> >>             we could mark use_priv_stack =3D true again here
> >>             since logic didn't keep track of sub1 has been
> >>             visited before.
> > This case needs a sticky state to solve.
> > Instead of bool use_priv_stack it can be tri-state:
> > no_priv_stack
> > priv_stack_unknown <- start state
> > priv_stack_maybe
> >
> > main_prog pass will set it to priv_stack_maybe
> > while async pass will clear it to no_priv_stack
> > and it cannot be bumped up.
>
> The tri-state may not work. For example,
>
> main_prog:
>     call sub1
>     call sub2
>     call sub1

sub1 cannot be called nested like this.
I think we discussed it already.

>     call sub3
>
> async:
>     call sub4 =3D=3D> UNKNOWN -> MAYBE
>     call sub3
>     call sub4 =3D=3D> MAYBE -> NO_PRIV_STACK?
>
> For sub4 in async which is called twice, for the second sub4 call,
> it is not clear whether UNKNOWN->MAYBE transition happens in
> main_prog or async. So based on transition prototol,
> second sub4 call will transition to NO_PRIV_STACK which is not
> what we want.

I see. Good point.

> So I think we still need a separate bit in bpf_subprog_info to
> accumulate information for main_prog tree or any async tree.

This is getting quite convoluted. To support priv stack
in multiple async cb-s we may need to remember async cb id or something.
I say let's force all subprogs in async cb to use normal stack.

