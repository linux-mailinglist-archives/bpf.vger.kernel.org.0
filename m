Return-Path: <bpf+bounces-51342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A18A335F9
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE360166D42
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB6204C19;
	Thu, 13 Feb 2025 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2SZssiF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587578F24;
	Thu, 13 Feb 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739416464; cv=none; b=ZbTMxoJMXZxJ+8kK7qMzZBBQHgNjOZjP/TWdWG+aO8LOcYdrgyB+ZBB7Aecv8WJ4z4OW0uNw44V/aU4hGRgGgHmL5AhbKdDtfV/rwWDJn/ab01xEr62QtaEFLzVs1GXFdUNOcNg5ajcFbLgGEK907EGcl3fZ/xQzYjiHEiFE/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739416464; c=relaxed/simple;
	bh=a17TWC5kXi8SooYfirEvpQM9dthyy53ca5HgvkUSUcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkB5c22ZEHDTr5R3h0B747kGmzupTMAzjqoRloWtecmHEB0/QoFmb4WPl+ueMipZ/QIA4GxsOjRGwGpJw079Kp+JCG7FVRTbEB08x81glUbyQ/xpF8cKEhQn5aZF6g5L1uZzG3RQuKNl4wP+1AYEA3ycCqI7mtaGUxMDOFYynME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2SZssiF; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so4501755ab.0;
        Wed, 12 Feb 2025 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739416461; x=1740021261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKpHxOg9RwQXA9SUV+pRZ7q2WzRIYaV52bs+wo1h0dw=;
        b=Z2SZssiF8ykGDWPxl43sKxEeFtGBzN+7mgPMcrOpPTY3yyR0O8PViKMisDm0o7eizM
         KWb9oDrR3U3dYq1N1mprGxXbtwpyCZSzZkxLbpmTY14Ku2LxCooQouteFTgZtCYy2tZI
         3kweN96zss7MaaCcsoNPvVXL0oJKFP3uDym34DMekIfTD0OJuYjwk5PE+jclUsM6g3zz
         f02ieP8bJqSNaBIyqUpZV3UgGaHeRA+XSYfhzKNWvLqdnrWCxK3C7SAssOS24XlVcaha
         wVFmOjlXzAoe7fr2ETfOWBh+hEAU19FDfS/3xfCG4TIuw17Ts2w/OdrH11lN3WTVX2Dn
         eKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739416461; x=1740021261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKpHxOg9RwQXA9SUV+pRZ7q2WzRIYaV52bs+wo1h0dw=;
        b=L9YQrgvOxNA3x8m4eQwvSfRBbaRmhBCocbld9tLks/0bYS90s46icaTPv02vWtp0B8
         KWu+rbbSG+YUMQ4rbSlQF6KhD9ScqcU118lsxrRo8/PibQ4UiiBOF0uWBTqvZxS36yIB
         f2SRUWY9T7L8m0JVdju1zvYPvvXcucXVhbuPzSdwRhZ6dbZvuRl7uIzFHOzzGokQMuDT
         2KwtTadAv87EMRg7s5TFaEcuUEsk7drTigifcVNpniOjIA5TeYX9+V+pMwxFqqM3N5Q4
         SWrJeqOnzjVrdP99pT3uxaqugibQcVD1S1JwUwP5WvKkzP7f3xY1XUUlhoUF+SvQ148x
         499w==
X-Forwarded-Encrypted: i=1; AJvYcCUQiozhi4A+aZNt0lRhFugbdp4If6QFdCQXzZSkdv1G4mo890xGIeNk+rTFEVx5DUYsVt0=@vger.kernel.org, AJvYcCXbo3CBONGTmMHP7c8LzAcnS97p/zpJxXIULRGF881E93nX6hD1YJHSPBzCQzq2+8BdntlOjYyw@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoyJZP6FEWwoZUwXYp7jip/JJ+5QjhWmAGXPU3McxXaygGGvr
	/fi23Mge7S5sj4kSvSgSzOuz3zUIKFEST18GmjXqT6uEo2fkp1d70ijTpm+j7AHWdP5zflX61f8
	2kuF8QVkCUWWAymTp6CHtNSti4Jo=
X-Gm-Gg: ASbGncuXysxy/3kCWHBhU2KBrU5bpPrE+AIfhKV+RCU+bTmGWuIM2YuxxXqSC/2hzun
	hWMXAvUusnrXDNd+gVkf3Mp3J5y1s7f+e3eyCohedCSgRSJCku6VSMGVHZ50fZHSYFiIcSTbx
X-Google-Smtp-Source: AGHT+IFtkURMwC42nqXnSexin4Ky2x20cmVQsq6s58uORz4A8hZlm0butO2GjiGR8kH84KOo0kFKriArbshC+fzi/Zw=
X-Received: by 2002:a92:c7d3:0:b0:3d1:54ce:a8f9 with SMTP id
 e9e14a558f8ab-3d18cd2214dmr11117645ab.10.1739416461592; Wed, 12 Feb 2025
 19:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-4-kerneljasonxing@gmail.com> <20250213023021.76447-1-kuniyu@amazon.com>
In-Reply-To: <20250213023021.76447-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 11:13:44 +0800
X-Gm-Features: AWEUYZnImYjsBd6-KV_jBvpOwW6jKYX0geDHSZVX5ZTmb2DeUAeH6bZeJ1XUio8
Message-ID: <CAL+tcoBxVyEW_q0d0EBbtk7370dXkrON9GvJ2dr4SpKz-c0VFA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests/bpf: add rto max for
 bpf_setsockopt test
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, martin.lau@linux.dev, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:30=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 13 Feb 2025 08:43:54 +0800
> > Add TCP_BPF_RTO_MAX selftests for active and passive flows
> > in the BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB and
> > BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB bpf callbacks.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  .../bpf/prog_tests/tcp_hdr_options.c          | 28 +++++++++++++------
> >  .../bpf/progs/test_tcp_hdr_options.c          | 26 +++++++++++++++++
> >  .../selftests/bpf/test_tcp_hdr_options.h      |  3 ++
>
> It would be nice to update sol_tcp_testsp[] with TCP_RTO_MAX_MS
> in tools/testing/selftests/bpf/progs/setget_sockopt.c.

Sure, it's not hard to add this test.

Thanks,
Jason

