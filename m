Return-Path: <bpf+bounces-70699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32ECBCAD45
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2840D48070D
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1792741A0;
	Thu,  9 Oct 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V+HOenhW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6326F462
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042847; cv=none; b=IVsjvM5lIxCp9cLyjjVcFKk1yLibXVGyfT/4uGiYiAZTwiyirdG173zgNNR7weSRHh2IaHWiF3TE+LhkKHGPJXK6zsKCVHWRrRwWouRGvY30l0MpKNZWRlaon2d4bqWUIl0HVV1pxou0Tq/hkiJTTE3+bFEvyuWI1ihhLqLosmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042847; c=relaxed/simple;
	bh=q9saZzPxKQgNmhZe1nTPbgY4fDxl3Xft1oscVp8TQKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0CmGOxw+tEmG3OhYvouzvGQCBiNtQ0tDDCWOsON0AnPFSZOxPl9P9+jPcqO6yghMM8wj51agy4iW68evtjbs1WQY9av7/z1QPL4Pe8JDjkE1m2FOBlpF0eVZzD4lCq0NM7t5BX99+nU1kA4W7p3aiDNiSVxWzwZiiC3Blttk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V+HOenhW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so1978855a91.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760042845; x=1760647645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6K/zr+mhgRMW1dEHBSBrEj+cHx1AJJEsB7Xi5fFruA=;
        b=V+HOenhW1D10V5BvnlJoRBteyJanDQugh+2TZIC6oFcES306iSSVzfX5s9RpcVKmNR
         hgl4/uuiOMkTR89DAfok46sekE3MC/gAa49JNM4Y9S6eVDjgBi3peGlRkKvgmX4+Gugj
         VGpnR6nqEdDK0TtvVLbmwDp+FYmaeH7ZAT4MshntwfTEsyFqTt/36k05RU7Awdcah5g3
         zvjU8fPbtvGBOJXXIyGqQSYN2/HNQouVdtLTXcVFreEkmQL7E2eNQ53e7+qdMM8r8vNd
         fDIExpxMWI3SvItzBwTTg0dSUZBktTAfwD0Bo/MT+6lwb6/FfhK9CvvJgDKObEapDKxm
         cx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760042845; x=1760647645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6K/zr+mhgRMW1dEHBSBrEj+cHx1AJJEsB7Xi5fFruA=;
        b=xFL9HU+aVTbSdmAESb0wSMdFCgteAebO9BsRaWtlS4mv6tYObj8L38dn0QGouapUW2
         eQ+D85r7m8BkFQnEksIsG3ikwIA3g2jwfaD1gt/TFlgGpvkDkZkFkbcyHvDBo835WDDd
         QUfIZrZC/6TU9nCQOJgowDuY2fZ42qhuJMfouUZbQBNyfctHcjH+E8DcTWmvyP0h2Qal
         DW19kUihyeBnwk3AxjSHIQ9uuMG1hak7miq0ZoUpM/Ii+9Cf4QiFuJz15xZl3vE7KuUi
         VoCFi+NbDImccmZ+2tGEwZwwQli1+1+DRzGpG7OLVDwWYoElBuo0rcoP3ofwT0De4CZ3
         kVeA==
X-Forwarded-Encrypted: i=1; AJvYcCVORvf4lrAiZQULpZvQARlDSpP0aYwTqBQDlzBWKjpYo1nB3gIHrycCo2M3E1W3Die8ghE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZI5a40TE+xXjnFQG4YJaaEZJbOccptGw5A/k2NpaJaV/NRHt
	ugLcBKQtM00ALSLZ6fgo7OGUwZfVJiDQfTZc7RmCD3wpOVlw3HHTQzNJhFIpwgU0s2+L4nJM/kb
	Wt4K1W2jHglIw379tkWoDh4WuijoMHtwY2Yk0M9wk
X-Gm-Gg: ASbGncuoGYr6V8kP2NUncPVQLtllueUVG/ji14bCV5hy/XnS8NijbpXz56KzDuJtCoK
	AFhBEU7ygHXvn+gFoizYzOB3DJspj92WMTovmHtbUIvvOGIYZY5EbhnGuoRwpsE4bVCCvejdOh3
	cJOibTY51KzwE9h8u+e0Fw9uydUwfmFiWHDOO39war883fod1WTTlcgCxEsrBBVOQP7sHpma6ZP
	etlip0wKOrm5xYmvVtEcnlLTPLMcqE=
X-Google-Smtp-Source: AGHT+IHwcV2uuUwAl2OswF6usdNngeVHs1OU6Qv4WDIoDMFlQQoJQ6qMYB4lYZ4rU5CeU4FuempUIEnPg0uLmZuIgiE=
X-Received: by 2002:a17:90b:1d8b:b0:332:793e:c2d1 with SMTP id
 98e67ed59e1d1-33b5139a37amr11731621a91.36.1760042845003; Thu, 09 Oct 2025
 13:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com> <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
In-Reply-To: <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Oct 2025 16:47:13 -0400
X-Gm-Features: AS18NWArdmWPZMqLgFQiddXgH5voBO_n-fQZZPwVAAdYJ003C0ZIeYDQyt1C9GA
Message-ID: <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: ast@kernel.org, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, james.bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:53=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, Oct 6, 2025 at 5:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Oct 3, 2025 at 12:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org=
> wrote:
> > > > > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:

...

> I feel we will keep going in circles on this and I will leave it up to
> the maintainers to resolve this.

Yes, I think we can all agree that the discussion has reached a point
where both sides are simply repeating ourselves.

I believe we've outlined why the code merged into Linus' tree during
this merge window does not meet the BPF signature verification
requirements of a number of different user groups, with Blaise
proposing an addition to KP's code to satisfy those needs.  Further, I
believe that either Blaise, James, or I have responded to all of KP's
concerns regarding Blaise's patchset, and while KP may not be happy
with those answers, no one has yet to offer an alternative solution to
Blaise's patchset.

With that in mind, I agree with KP that it's time for "the maintainers
to resolve this".  Alexei, will you be merging Blaise's patchset and
sending it up to Linus?

--=20
paul-moore.com

