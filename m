Return-Path: <bpf+bounces-72946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F0C1DE16
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F34E3589
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7E1D5ADE;
	Thu, 30 Oct 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxu+HoxM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01261B041A
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783385; cv=none; b=g2HwDW3vUMAiTujDR1h2jbgPYAbuBou2e2S7Yc0QAq2C5GsGdMr8yoJDabebfxcGoId7jupuhiBufM55EQIfDSp0xPKu9PgShwiGlJOhfkyO6wqIrJkIMLfcoFRD55F1z9KMmjsPGdA/oonlLUF6F/976FmHUehmScxVLBZblfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783385; c=relaxed/simple;
	bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTUjEB8acmJ2NyihmpcXGnUr/q5Hc7osk9TY/2tO71C5bsEnXjIhZH3SLhQSys+cy1O4sBXnNRnmO0cDfQLfeT8WK1neBC8WXLV+Sy9aDJs235gRJ839p0CxmyugS9EldtPnNBGHifK587BOjSTW/Ik66+rZPTSzwmUUkfYq768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxu+HoxM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47728f914a4so611855e9.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783381; x=1762388181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
        b=Hxu+HoxMkRS31UVo2FKKI9iauD8T4ksstCd9RhFSkOOc8lzizxmnfsMbhb5sNp+sgo
         8KoTvm+AjAM432e++w6cmPIBFMDjS+ZXH36BWww1pIoAhz8N7CYu9ngmW1qtZJgDt6tR
         pdbye4LUhFknFmcvEceIq/9D0BRh6Wi9n1sQlzDc2vL5T71nL3d83YDVFo+V/5dPDi5X
         DS+CqHx8tx4ATgZVv+okvTQ79dEEtYVkagLjwPa9M+vlQ75PW9MGAp0kpPcsuu5zYiDL
         a0ztm8lTOVdKAkYpxOorqLUvCkEOmKgGuvzyS5Pc0VNY2SLoSTFvYsSCA27XyOHJZ4UU
         KZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783381; x=1762388181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
        b=G6uoWPiFHhZW3dT5hoaoFfTrYc0c07dfKcX94UI9l37W4mIYkHCreL6FPifu89V2zi
         eTWvDVBbeLku/1MMpMKm2MTybVrTgXtPzynSMSsPJXYFicrf/wOe+RhKyQpv1ncYpkvi
         hoLeIvhW6Y6xynx4rQt0P9qZyulw9mMmYgQt7EdsW3pEmYgz4mb4OA13q+m8qTTWAGNp
         zqOsK+Ul6I+YEc7eZJ3SQ610UTraGe6SxwDrVVPgAOokPvfox9z4HhCu+r/xiJsnORmp
         e9khi/3yINyMmaAqJWP/0XvgRN+9Ko7wJXBxMY+k7Zrr0/M91osZd1y12IoI1oFhqhfa
         owxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrJVyabUPfz8QboQ5nfwvF46Eqjqcnpdgx8wukMN4cFTq4ovTW4KbWyQiT/ijz2epu260=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXCxvJDXJjc7f28U5ryUkoff2aUiN6roEQOBtA4ZNDy1eE8tZ
	FmCKP8BKm0s32UFj8+PlOacvhlwhTwO5anV7+VRtT37kpps+Bzl0mmfQvIEHsXO/vbM9ngQ6BzF
	Kyn4pbOFx45W27fVTD44n+nvfdCio1HM=
X-Gm-Gg: ASbGncu19FLZEL3qYxW4Wer0jveLIJ4Eo7b+z9tFP5uK6HN3ftPPfYcvjQkXs/+BOrN
	12oqnljsHY2ui7YliuvYtF2yA16BZ4/ltRQGQuvoqxnA4cMjZCBGV3PvALMIGdeBvTuCMGfICN6
	MhP6TD1/Hjdg/O2R+8ZUUWpaJkltoaddX2UWgHEdmEzJOXIYBCi/NEwv3zAEzMMmFfiFRtuRLwm
	Ms75Z2Q2xv18IRSARqPELEB7ODWnBu5O2syDZToldCWUcEGYlcCvpiQPMc7QCOCWuEHOLqVDkc1
	/1SwWL0OlQqtcUWikA==
X-Google-Smtp-Source: AGHT+IF09btOdHcwxJqodVRN+ViMyO/SoklcID7X1FwZ3ORBb9xOqUsCObSUvrzvXw3Kfh27llznbS5xErV22oTfDgo=
X-Received: by 2002:a05:600c:64c7:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4771e18157dmr48056215e9.15.1761783381050; Wed, 29 Oct 2025
 17:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org> <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
 <aQKrZ2bQan8PnAQA@slm.duckdns.org>
In-Reply-To: <aQKrZ2bQan8PnAQA@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:16:09 -0700
X-Gm-Features: AWmQ_bnVnjW4yRQWoj8DDZKSY0nxin242cIZkPvDGi7K7MOsZBTy6KJHgZg6C7Y
Message-ID: <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Oh, if there are other mechanisms to enforce boundaries, it's not a probl=
em,
> but I can almost guarantee as the framework grows, there will be needs fo=
r
> kfuncs to identify and verify the callers and handlers communicating with
> each other along the hierarchy requiring recursive calls.

tbh I think it's a combination of sched_ext_ops and bpf infra problem.
All of the scx ops are missing "this" pointer which would have
been there if it was a C++ class.
And "this" should be pointing to an instance of class.
If sched-ext progs are attached to different cgroups, then
every attachment would have been a different instance and
different "this".
Then all kfuncs would effectively be declared as helper
methods within a class. In this case within "struct sched_ext_ops"
as functions that ops callback can call but they will
also have implicit "this" that points back to a particular instance.

Special aux__prog and prog_assoc are not exactly pretty
workarounds for lack of "this".

