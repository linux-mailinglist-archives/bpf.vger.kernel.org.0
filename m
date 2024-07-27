Return-Path: <bpf+bounces-35787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FB93DC9E
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B5FB21460
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBBF110A;
	Sat, 27 Jul 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu3+8z7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854D7E8
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040583; cv=none; b=jBCy2XytE06KgnCgwo8w4j6x0ciRsgC/vkMaFCTGmpQ2Pg3dTf95gETtFL+YnVAmRbMYBW7426l58UKlPHXzgltbDBGQQc4lvcy2sqVuIQNF5lXgv1ZdWmy67YMX2Cnzi+4TfrMMd3wySVIM35sCuTua0QzvH0gLy5qMRri2V2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040583; c=relaxed/simple;
	bh=N6DOLgzo2vSm1czaf3MoumkD2UqTQhaH54biVlwoZB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac9mG0X4oDVV5RVntRJ43iiHXgsgZ0M3SWIlzxr/W7RnNPsjNgr8WYyINLlyqqHztxslECc6UNjGAmA9BtyOuJsbhjxA//w7Bkl7SZF3r9FV7ye8duqOxTdTgMsD/w1kuzbXGddVrQ/nIXaeMuKQR63PsN9+78zh0ThVQEK8BxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu3+8z7O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf78366187so385088a91.3
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722040582; x=1722645382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6DOLgzo2vSm1czaf3MoumkD2UqTQhaH54biVlwoZB8=;
        b=Yu3+8z7Oc2sciDx4unENDVRqpfyXvVw+Su1ejKwm62LgEoAAh+3dZSp3f101vVKsBV
         F3IZJ0TNxosabU3X8VXpo9TOOaZFzjbJ8q8mfo2zzlyuFI5kjcv7jk6W1vdsyuqFhjGx
         xhvOGVjNAFefdPvsfkldglQBC6kQ8J05/35il83MR6+MAQcbtIsZzF3FvVpi0KjRpL9J
         aNc6Y3sdzE0KvY9NcF9pzY8YMwciBqay+kXPD8TMAYGljpVBcqRLZUOl6xk9eKZ8vN60
         5GxZIjP5fIJaO0PknKW5UkZEoZC/01SBLgiROlqsIYUoPUyGwPpXR+lx1sD2ODggH7Yj
         kZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722040582; x=1722645382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6DOLgzo2vSm1czaf3MoumkD2UqTQhaH54biVlwoZB8=;
        b=bMxbY1oA6tIU4StEbMhq7eJGfwsko4joC1hlvXZ3FFy8ahLgJxQqR7PNODwwcdvUL0
         4/Zcev1rHLgHgIqkgUDsmBC8m5YlUvt0PKFIh+2AwdQeMRPWuOv8TuQRscgjCpozmdSL
         jQhBb6w33O2LfBPDFNlP0inSLm2U4lPDSoiOM/l9d9WFxkKhL9SDGgxVWevKQXxyWgWE
         4Gh6kIEy2/1lj+CLAOKUrwOI8e6roEW0juc2dZm70+qDVohtKRrLGFhDhprOHiNmVShp
         xMg4WwgoX49gvK+aRQ5W0h0f+4bYYO/Bp/umUfB/QXmf62/d8ggbn8mLqKFJ1Gt6qb7D
         C+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRGWlkb5Pd8f/invbitA2yppTlzEUTzv8oKtFw6owM5fNE8eVgmWWbYUJf/lNLLwiQsDI5UB11IARxPqWX16irwJpw
X-Gm-Message-State: AOJu0Yyhzp048YwlqKEPnPp0gDbDYa+vL6eAY1L1JptfAgz23U5hIu1V
	ZadgH69TUgOqkehFJwjJOCXE79CJVuPtm3APi+tmxko5QLU7zjwt0csRiZEQGJ68gafOtO0KBwM
	d7DoUO7O9XfBr53U7n4lhhPdpFhbm+AwsOb4=
X-Google-Smtp-Source: AGHT+IEDveRTEjBkhikQn0+KodLLwquamSLnUuW13hIVekUOCZL63vbIsF3QLEMtRXwVApNPVsbX4f0IybqVPrOwttw=
X-Received: by 2002:a17:90b:3149:b0:2cf:2ab6:a134 with SMTP id
 98e67ed59e1d1-2cf7e60c0b4mr1374751a91.32.1722040581813; Fri, 26 Jul 2024
 17:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-6-andrii@kernel.org>
 <ZqLVxh2Ij6AovoJD@tassilo>
In-Reply-To: <ZqLVxh2Ij6AovoJD@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:36:09 -0700
Message-ID: <CAEf4BzaSNqhXGj88Z8dnVQiVq-HUdN5cbmF1xDAftJyss6WQHw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/10] lib/buildid: implement sleepable
 build_id_parse() API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org, 
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:46=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Wed, Jul 24, 2024 at 03:52:05PM -0700, Andrii Nakryiko wrote:
> > Extend freader with a flag specifying whether it's OK to cause page
> > fault to fetch file data that is not already physically present in
> > memory. With this, it's now easy to wait for data if the caller is
> > running in sleepable (faultable) context.
>
> How does that interact with kmap_local disabling preemption on highmem?
>

There is no active kmap_local when we request a new page into the page
cache with read_cache_folio, because we do freader_put_page(r) ->
kunmap_local(r->page_addr).

Did you look at the code and it looks broken to you? If yes, can you
be a bit more specific what and where?

