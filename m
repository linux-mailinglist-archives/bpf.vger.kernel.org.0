Return-Path: <bpf+bounces-35951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD394003C
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B4CB2203C
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666318D4DE;
	Mon, 29 Jul 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZhU5ZkBx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4718D4B0
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287819; cv=none; b=KxknqJIypgS/IjqpXv1TG72PdN7u5SAj0VGRNjreD2Ug4cxLIEg9fM8JhtYa317DBnQdc+alZ/vmBR33muZfuTjibWiqfdcAQABB2e+toVYtN/9DGJ/43tSABCe78DTg+EDjvdZNkM0WVQqldyBdtDy0DvodSLl7Faf5+LX6pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287819; c=relaxed/simple;
	bh=uIJLnIGDgHiwOY+EWN5WBZVqPwL+D43aRBBbMXmgfZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqBM70uO+RrxMr0WTisgLX5UZfpSHRojRLCUj5rAczS0aOvYIDkbZZM6NHlmi7+GoPZTj9056rzp3neMfEilw1KglVDG5wm/AMsX0IjYHvekv4RV02pNf07W4NntRQeys1T7T3VS9h2kE/p4kIpmPK5IT8FpbGy3ibRAFkSSZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZhU5ZkBx; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e087c7ef68bso2133605276.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722287816; x=1722892616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fALvn/G9I42sSFKWi+Di1wKfzMY+rQ5ZRHFmVfS90lk=;
        b=ZhU5ZkBxboFE0Romau32/vctNoFWlPUBNl6xrtwsXIMUV+a88FOOGc44wLCr4BXLdx
         GS7nTi5AxsiamV8yEqFy0YDfw4zMVzb7jwhOBFqavV+jt+ymoUcCL23G3qrEkpA2WX/8
         ZppMHVFiyybOa9TTO0VX5Yp0wpoSdXIdJ4RFuXNWnDQSMgN7hjWR1NzYZHi6E9fLlCkB
         9n1BqTedcvHnoqclVcEBY76vWZ86qZu0WV8WoC/VS2MMpA8baWxCC8TifQjDzy3AX5CG
         qdhtgcnqPDoZoOyevOt4HJV6McY05f/ZlPbQvLXzc13s0IlW/cmDlPtOQwp5BntYF1Cw
         0RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287816; x=1722892616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fALvn/G9I42sSFKWi+Di1wKfzMY+rQ5ZRHFmVfS90lk=;
        b=a4nYBVrv0aRuvx7XT+oLZv9qOOn7OHdkb7r3DiFXV7KRVB7erwgsEVvX43y58Px60w
         TCvgb9Gcg+xVzHmLq6R2+KE3d3wJrOcJt42XggrsDC5L4yXw7ii2wBVAbQ2kURQUuIMF
         0WVHo0EwLu7az9uhBZR8+LduvCrBqm7jvUtTgGxDHfCKmsxU+Rp5y8SnZ/b/oPl9WANr
         +JCfhBkY9p1QG72k5otTgBuw1HMQ4xWj8rWEjgaOvkQptNz91DCS6agZz+to5/vGIF7c
         uBqN6IqefOrUHU9vsG443KAVkp2VrT7mWheOCFIkxkZzwEUQ7DUGHzr5LhDxEvUmoc1e
         eP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDE4FwjpjGGkaApcwfrqcSf2+QqLe7gRVXnpgkUxSFeC+C+nQW7y+oLzdg7S7O/BABTc8UnpD6Fp25fKWzy6+7W24y
X-Gm-Message-State: AOJu0YwdFEDXyhMJVXLO40xu8ZGQ6W/JBFAp8VOlG8297C57Fl/j7AIy
	DqjkWowdIh3AYvDGfV9qJXZ5rSKkT01ZySBQS8YEmAM2snsrWh6e3qpkXGEa5M5fAgcAfuVcRDE
	pJxJiQLrj/zMucUYyUt7F/RlJpjkvJDnjb50H
X-Google-Smtp-Source: AGHT+IFabk8fk0C7XzqlqZkwYX25Z9yQwQ+VHu0bzqxh0S2HEvaTwSRhWALDsTMypjabqfygtPhITuNexJK850TcmJE=
X-Received: by 2002:a05:6902:1029:b0:e08:7950:5d2c with SMTP id
 3f1490d57ef6-e0b545e3cb5mr9954293276.49.1722287816722; Mon, 29 Jul 2024
 14:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
 <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
 <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com> <CAHC9VhRXoDtuKyNnQav+qNeqh76-YYSo2V2r6dDYYrk9E0oPaQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRXoDtuKyNnQav+qNeqh76-YYSo2V2r6dDYYrk9E0oPaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 17:16:46 -0400
Message-ID: <CAHC9VhQ6cdwMZbQTSJ=1K5U58xQxQb=Tq4AvgmyQHPKB4a861w@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jul 11, 2024 at 9:59=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 10, 2024 at 7:15=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
> > ...
> >
> > > > > A static key guards whether an LSM static call is enabled or not,
> > > > > without this static key, for LSM hooks that return an int, the pr=
esence
> > > > > of the hook that returns a default value can create side-effects =
which
> > > > > has resulted in bugs [1].
> > > >
> > > > I don't want to rehash our previous discussions on this topic, but =
I do
> > > > think we either need to simply delete the paragraph above or update=
 it
> > > > to indicate that all known side effects involving LSM callback retu=
rn
> > > > values have been addressed.  Removal is likely easier if for no oth=
er
> > > > reason than we don't have to go back and forth with edits, but I ca=
n
> > >
> > > Agreed, we can just delete this paragraph. Thanks!
> >
> > Okay, I'll do that.  I'll send another note when it is merged into
> > lsm/dev, but as I said earlier, that is likely a few weeks out.  This
> > will likely end up in lsm/dev-staging before that for testing, etc.
>
> Quick follow-up that these patches are now in lsm/dev-staging, I'll
> send another note when they are merged into lsm/{dev,next}.

One last update, these patches are now in lsm/dev and should go up to
Linus during the next merge window.

--=20
paul-moore.com

