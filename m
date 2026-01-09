Return-Path: <bpf+bounces-78412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C395AD0C713
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 013473019E21
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B8345752;
	Fri,  9 Jan 2026 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQsJeCBE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBB2FE563
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997151; cv=none; b=As6iBGe+KGc6SNXcJ6y94QcETjDZgYynMvOkhJduUhnyHXUjtBv+w46jn2S3A9BIP/l6+H/5NUq1ZtLe23iDlXM63nVynwqX79XS+p1fPGyibwv777sZq44VFExhHGapX4oiLJ0NgJ0qvVB99sLVD9vJ5itF0tHxXtQJX8/1J88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997151; c=relaxed/simple;
	bh=HXxJhQEZbqojjBNfqP9Ahoj0bNeTUMNvMD3Y3vWbSvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWyKDX2mdUXPkhokZ7ZZ5V9OcMYypF1gS1t5eX+hgb9NsJuMCNM0/sMhaVk+zq/qjyRHEQIiGkfVvZQXtYdaWJLcZtTkjrQexpbdqFl5Z2VjA6FVCoNuMMRLxiJdMrDyPqU2Pz3YrLzxxe0iDZd/UH4Hhdwsu+3txrOXeHEmsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQsJeCBE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so2501112a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997150; x=1768601950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NqRWg2Malp8dLclQUeexcgnK5Pylr14R0UDsebzVZE=;
        b=nQsJeCBEn7HvO2B6eSgxLV2oronxdAvPX1mb2Cu/AG/QonoKODC0rZXkxn4Xpj545n
         75hbWym1QhPqi+Gti/4NgbjlhZiiPcw9E1c0ADNf76fXkvn28POB+CtCATFHgHNoNQPy
         RcejwKTVQaCnr0ucEK70LnXhJjdhPn2nqaxNnDKfeZXr1m4uPfAT3HSEK5MiHX7X95Qp
         bKpMHay1nOi3HNWFW3URkgj03eMkEoQqvDj7e9sxjwjdcR4Mwz9MDybqW74BmQxC78Wn
         kxrcwHu6+hMc8vyyX+YoQezIk4ai6bLSwCytHpGas1QD3Rvul47+KXkzCLRC8lOr/G4o
         iiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997150; x=1768601950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1NqRWg2Malp8dLclQUeexcgnK5Pylr14R0UDsebzVZE=;
        b=TZvyUtbuxKj6EITBOiC/PWOtFVjwtJJljUHNQUahFnsk9ER+qUux/LIEvZh36tmwjD
         HTxHtqBQXqvZkxafo95mNpd//BlSM891Vi44Vu5VHyn1BsNjG3oGfoKEdQeYlOgOr8nV
         VFak+NeiFsyaTpz7uiIK07rEGu3EsiQvKmrHJZa6uNJIV70Sdpi+TpQ8Hfzak4EyrRQ7
         3DfhVXrpDVGygscQO79EN8bQ3/+kcbsZ3Zd5dRJKLDXp/KyXLlY10zPfOC5CZwzInD+f
         9Nd+5Or1pxl1FVYqxmjRHsfE1v+Nmiu/Lvvpkq/ny1ClDG11B3j14aSns18wULlIHCo1
         VifA==
X-Gm-Message-State: AOJu0Yx82iBvBYQ6pgi0rUc3LjeAthiutsyotlfXBE86cH+u0/CpvRib
	D0dogTKbJ5ORINtDayd4gY++LoskWq6fWD7kT8siCFDApi/Dp15hm6Ns4sBj4fjsDsGMngK18sA
	7G91s8DfeUOOWXS6TwoAuc5TwcPXYXQE=
X-Gm-Gg: AY/fxX6UG3KKJGN3MnzAyefeawpvksY7H9f+DnZLyLY12xKKLBfyRw3tF/Q+a1Upjx1
	hosF5MALVSe99ErTHSggucRCZiv0TiFg9YXDWbAcZ7DpsgVVXfuoYPu69OrHlFGUxlVvjoOZs4s
	XszIa9U380yJUF1qhqVbidj7v7PQ+wJvWOU8760GAjKN9fBKhX4Ab5MkQdy20Jt8w7x5tRHo8jY
	G9LxgR7JVG7Aw7dvTCNby+Yj3BQUddTRhljkcQFiTfaCDH6i9SwlIm4NFj4ysUBrTlFDX8/bLh/
	eP71Tglt
X-Google-Smtp-Source: AGHT+IFH34paCJlCWXXQiC46hDhDjF3eilM4uO6CFJgTGTBSCHZz5nfsKpBpTq4u39MyDU74bE73J8ISPDKzv+haVZg=
X-Received: by 2002:a17:90b:1b08:b0:33b:dec9:d9aa with SMTP id
 98e67ed59e1d1-34f68cae459mr9829349a91.25.1767997150008; Fri, 09 Jan 2026
 14:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:18:54 -0800
X-Gm-Features: AQt7F2rGoKsNy0Bw0C7klpDrA3_utiSOQEJcECgAqGsB7LPmeXop3QRMEh1SLaw
Message-ID: <CAEf4Bzae=+5QDirX20RSAmbEGMhCRE58_=bNij-SbDCe2OiXhQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor __bpf_async_set_callback() getting rid of locks. The idea of the
> algorithm is to store both callback_fn and prog in struct bpf_async_cb
> and verify that both pointers are stored, if any pointer does not
> match (because of the concurrent update), retry until complete match.
> On each iteration, increment refcnt of the prog that is going to
> be set and decrement the one that is evicted, ensuring that get/put are
> balanced, as each iteration has both inc/dec.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 61 ++++++++++++++++++----------------------------=
------
>  1 file changed, 21 insertions(+), 40 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

