Return-Path: <bpf+bounces-29299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F88C174B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB214B24F80
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373D80046;
	Thu,  9 May 2024 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NDT2ouZz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436C80637
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285324; cv=none; b=RrLKj1wv5F9bQEA3xhwrkcnRnPRWT6V//x+cDsbbGLa75M8P6EKkiOYtHDFGrAoNkJ6jbitVCxl/7j2n+YJuLG7wZ+klMuvhBdR+gZzfUtXEc8o5viR2lQesoXCxkatER4iO6pin2v9sodIrpen75eXS6PPycy7qqLrcTFJd4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285324; c=relaxed/simple;
	bh=jiZAk5HR5wPgy5aOVjXkVGPvP5lERxl/XkRvrevfatM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDu1DCGyUSXeqIhAmsWgq/FuNdtRWV/JLnBzEhtp0Yaw8pLAf8u6FhOojIU/M4UzJgGNCeDCG0HA6j6o1yoVyAb4c7VgiUMm1Cs3jZ3G9D7Typ80aMhjs6Hs0MUR5KBwRatAr/eDWp7tyxpCbpiOVNc2abm4EvcJm8taVRQw27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NDT2ouZz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61df903aa05so13066917b3.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715285322; x=1715890122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDmvoUGNMm0LV+6uiHByGZp6sbq5qjhyDSOvi5SMvmI=;
        b=NDT2ouZzaEnEJf65Rm8E+zSJIxpG0tCb+lQyrpCCBf+Q0r4yhz9L2dpBILPgUHKX/t
         QLuHAd6RFQKR6FzrwNkjK6IqKrk5xZ8DEh3urFGDGP9dGa9XjXxCy26xUtpYLNNx89KD
         7QdSQCe2lt1lCuJg8GCoiOwm7z33D9TRyPWXCuGf3DMICEKrlYFL5SI1RQ7Zg3b38Sj0
         T2wXyYqTOP3SzL2ZbOhxvBOQTKP8rMbQGU3bipPO8ZOrVcUkCj0SUrZDuzWAwIOyUgEt
         S9lvqM0ifm8uYcJyfkumIKXbSxibF8Ug5SW9XcLzCGJ+wJ0cwKmPQgDnrt3fn+P2abF9
         I4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285322; x=1715890122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDmvoUGNMm0LV+6uiHByGZp6sbq5qjhyDSOvi5SMvmI=;
        b=tag/AXVy0RBNcDegOjMMGj6ZLKKXdLjoAUySIAy/wNKrrFh5TmMSnX3+hjnPNIV2fM
         DicHB4LnZIteNsDHnfH/9CV7Xfm7c5cKtnCvS7n2ZwTLhGG4c0jbwdmLTy+NZrbq969E
         zu0dzyLYFeOmZF8je3uChIpBTCdi4AN6GvJ8YFwHy+lWVbtEp9L8i6jYm64QyWljq531
         AZB4cLG2NFcq3gDBtZTUXAOJbc3qeU+hOmfuBMlrDx0PNgeDedy+AylFJz48L5GHlK1n
         Y+/jM4orYWddlW2zbAaomi96bYguddGBRgZSIVyVQAZVgUV1Sxcr0kWbKphEUKWqY973
         igfw==
X-Forwarded-Encrypted: i=1; AJvYcCXa4Ce19peDigLUT7LaTZzRGrONbTIDaFaewnWJVbaMkUw/R5sCX+SuaJ/IZ0xbALwkQR3x55Ne82ZFLKfYj7J/LOKs
X-Gm-Message-State: AOJu0YxbIVURIK6VXg6AiH9OIvrcijGY8D1bOSV5C842IJjdav3l0B8R
	uydftCDRM1Gi5i//Z8Y/yDJHY90OcKa6k345JK88ekgiweqCqS0KIT4A17wO+8yc6hwPya/CiXg
	BDothO7DZ/5ywMVHXbyLkVymTE+hwwygNrHm4bshuCqqVW9w=
X-Google-Smtp-Source: AGHT+IEgum7HpmFmz3of6qj4OEgzfMl2bUVC+kxJomD6t/Wq8xEHOeAgefbQVL2d9DrUw2+lGcp3mv56ZzEiN9TNcrY=
X-Received: by 2002:a05:690c:660f:b0:61a:7d6e:80e8 with SMTP id
 00721157ae682-622afff97eamr8108917b3.36.1715285321985; Thu, 09 May 2024
 13:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook> <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <202405071930.A3022BFDC7@keescook>
In-Reply-To: <202405071930.A3022BFDC7@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 16:08:30 -0400
Message-ID: <CAHC9VhRcofEGmBAE+8DEkVv0t66xwmMV1kXGtqUjodXryBbh2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com, 
	song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:35=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, May 07, 2024 at 09:45:09PM -0400, Paul Moore wrote:
> > I don't want individual LSMs manipulating the LSM hook state directly;
> > they go through the LSM layer to register their hooks, they should go
> > through the LSM layer to unregister or enable/disable their hooks.
> > I'm going to be pretty inflexible on this point.
>
> No other LSMs unregister or disable hooks. :)

To be clear, it doesn't really matter if it is all of the LSMs or just
one; preserving the interface abstraction as much as possible is
worthwhile and good.

> > Honestly, I see this more as a problem in the BPF LSM design (although
> > one might argue it's an implementation issue?), just as I saw the
> > SELinux runtime disable as a problem.  If you're upset with the
> > runtime hook disable, and you should be, fix the BPF LSM, don't force
> > more bad architecture on the LSM layer.
>
> We'll have to come back to this later. It's a separate (but closely
> related) issue.

It's a moot point given KP's latest suggestion, but just to give some
insight on priorities, correctness is always my primary concern and
while the performance improvement in this patchset is a nice win, the
most interesting part to me was that it provided a solution for the
empty-BPF-LSM-hook problem that has been an ongoing source of
problems.  Yes, we have made a number of improvements in that area,
and I expect those to continue, but selectively enabling/disabling the
BPF LSM hook implementations is a big step forward.

--=20
paul-moore.com

