Return-Path: <bpf+bounces-44408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3839C295A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860621F223A6
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF820309;
	Sat,  9 Nov 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJsuxmCK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169C34CDE
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117319; cv=none; b=B+NgP5jzq000p7xmtLXBn2YGiL5aWxaMdTWZIZEOwQdV1h2o7EecR027ZuQ3TvGxF/m+DG/vEUSm5MGmNXreFPgrSWL8NaupCJzWbwa9WApOcQJbYalpi7rZvp2NsRLvOJytTOZWpuha9Yvxg0LdEBgjIuZyF5v/BlhBSK+COYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117319; c=relaxed/simple;
	bh=/HLy8uB6d7uyh3xq1DnyerIeoQDTqH+w2h9rIqXGBaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcKnon8hgn+0KW45vtokYPsDiDngNw4kXqGK4Vxk0Yo8JIUubhyas54ljO6SMam6Fv/xTqTIehqNIHoGReCdFh79N3bRbQju7mjqEMfs/Tz4PCxF0Y0fs1A4LkSM9/JiiCM+r5THHHlOKEEdJh0QFKbwmYi2NkCEUcvFnHTil+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJsuxmCK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so24044945e9.3
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731117316; x=1731722116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HLy8uB6d7uyh3xq1DnyerIeoQDTqH+w2h9rIqXGBaw=;
        b=CJsuxmCKiVVTOKX/HXWOnXDTQGrNM2lpxFR+h/ubLF8rFqCrPD+PASvJfOHmGBIekZ
         GgLspNBpkDe0LiCk7di3cP61RJYERLnWxi2BaaPjeN+tontmJlnkXd8jQSN7UvIxMzYO
         Btez7anQmdRFsy+hiHUP/NDJY6THL1+19flUlbgGbar7S3QkJ8CTNT09DIiQhFRYqERp
         pfl5hUATomdikOdg2DjKDiDkOxF0hv6/mtjy1TS0nmL7SjSmd5LtnpCpzFX/MBmZWUmZ
         j3I3qGNKp8nRhcW6SFDZGMvprSe8B4VS0k94akmbDLifgpjwa4yE6BVm4rHKtMgGHqUB
         sr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731117316; x=1731722116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HLy8uB6d7uyh3xq1DnyerIeoQDTqH+w2h9rIqXGBaw=;
        b=itRz9s1GM+GOX4HmjW+rubc90GxG2IegWeJq9AKSoBkii1Odfab8Dvjew1xu6vXq4/
         ogsxNs0rf19jyxOFUrUn5Pb2Xq2xKvKy6fainWFIUpS03Dt705sWw496rTz9rb38Vx3m
         YjVze2GpxI/4+r5JES1rMiSSXXtCUyAE1cEqHUNgl+F0FzxcYrcEFaIFF/lUqlCXuYui
         FHtW5+4GRYac1dZgyWj+62KhbH0yMIa1ngoW6xXSRcunfl52nI/jig4ldOkXhpSW86W7
         Gcp0TRZRjeI4p8/mXqwUJtWPuXNOhVJZ7nVW+m1+ilQAoY+y0BKcmJaj/oXTV/LkwNA6
         wPlw==
X-Forwarded-Encrypted: i=1; AJvYcCUMwZZoF8N7+eNqCCpjEE6TcDembqpjy8z5mJa9tOPB7+/G1Q5YxwYQ0fwGx9CkLn2/3Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxebemLOehvIVOsvhMg8pC6G8GyD+ZHt+ZTKA6Fe2IfHSyGKTvu
	pE85L/4BQUdprhWVuvaLNrpflHihjxVRf6bRYIS5kzO+jjZmHaa/x4vTB4hfKCSisK0nDWUeHXA
	0HBIiMQ+5C3tZQVuN1NJksoss6K8=
X-Google-Smtp-Source: AGHT+IHICI3K4BxaIRGdOnYNUKQt+qRmU3hMZSGUJKRS/bvoACYzs7OWpxRcjT7fSAoEUXmZ6dqLkw45ltw9brV7lM4=
X-Received: by 2002:a5d:5850:0:b0:381:cde6:4ced with SMTP id
 ffacd0b85a97d-381f1880662mr3787045f8f.45.1731117315623; Fri, 08 Nov 2024
 17:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106084527.4gPrMnHt@linutronix.de> <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
 <CAADnVQLPp2bGJQ_A4WS0sYM97xJFkQocK7t5pPN-mDVM=ZY4=A@mail.gmail.com> <2a069b1e-acd3-4fdf-2ec8-287dc8edafe4@huaweicloud.com>
In-Reply-To: <2a069b1e-acd3-4fdf-2ec8-287dc8edafe4@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 17:55:04 -0800
Message-ID: <CAADnVQJe0_kwdYefaJAA0Bh_6CO94xp=2cSTU3Y6SNktiviT=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
To: Hou Tao <houtao@huaweicloud.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:48=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 11/9/2024 3:52 AM, Alexei Starovoitov wrote:
> > On Wed, Nov 6, 2024 at 1:49=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 11/6/2024 4:45 PM, Sebastian Andrzej Siewior wrote:
> >>> On 2024-11-06 14:35:39 [+0800], Hou Tao wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> Hi,
> >>> Hi Hou,
> >>>
> >>>> The patch set fixes a lockdep warning for htab of map. The
> >>>> warning is found when running test_maps. The warning occurs when
> >>>> htab_put_fd_value() attempts to acquire map_idr_lock to free the map=
 id
> >>>> of the inner map while already holding the bucket lock (raw_spinlock=
_t).
> >>>>
> >>>> The fix moves the invocation of free_htab_elem() after
> >>>> htab_unlock_bucket() and adds a test case to verify the solution. Pl=
ease
> >>>> see the individual patches for details. Comments are always welcome.
> > The fix makes sense.
> > I manually resolved merge conflict and applied.
>
> Thanks for the manually conflict resolving. However, the patch set
> doesn't move all free operations outside of lock scope (e.g., for
> bpf_map_lookup_and_delete()), because htab of maps doesn't support it. I
> could post another patch set to do that.

Pls do. It's easier to review incrementally.
For the last year we've been working on "resilient spin lock" and
hope to post patches in a couple weeks.
In those patches we will be replacing htab bucket lock with this new lock,
so moving other locks out of htab lock region fits very well.

