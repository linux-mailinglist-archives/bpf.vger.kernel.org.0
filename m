Return-Path: <bpf+bounces-60621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8CAD93C5
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5111E05A3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC092236FB;
	Fri, 13 Jun 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDfSphrd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB41132111;
	Fri, 13 Jun 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835924; cv=none; b=gji6/aGkkJ9ul88PJlgd68uaRGi/1Xstz8k8v42aGAabN+yvIiDMTwlfIMaDrYqAvNTWP4Id46XOXDnzfPhPcT+SL/lgOyBw/BanLfWpFknqwTcYMTH0KhFC7UJnhfWZkHknYISpBlZgPPQcQG/BlX+JpLH4QroN9nazUkA6C98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835924; c=relaxed/simple;
	bh=t7N3BVq9WlE9phwxDsROYWpWt0kQq3OpsSCwh+9ECEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZCccSOc1RmPfryszexKyRfdKA93WtrvXfrFUUOrNr2hqGeYeDVi8sjXrpfi3g6ZJCY8PXyqtUCC5Sorbve0SzcnF06cQoD7//mLVG4UBspR/wb/5q9s7fg5IK/my1rAo4AHlbzdaQxPPHmgyuEKB6LKDOkRFfQhIdSuPd/7/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDfSphrd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1482872f8f.0;
        Fri, 13 Jun 2025 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749835921; x=1750440721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVccLtBUkLI1MEe4KbooOMLXqPFKOC+ce3CE/xpHyA4=;
        b=XDfSphrdQeatcz66ziAHt45KLnwoY5U4UIqaykpHBTVfoswmQm37+A16PAUfyHoxwN
         AxVZ1JLJkA185wHGmR1/hrkH3QIZfIkeiFcjsJdlDjausz6TqGEPBnnE/uojabmepMqM
         OGboH3w7Pah7iu197XLGrGwucLvFN6qLq+4YQwo/tdXIC64ID4rSTh5lF33viT4dzJ6W
         px5hvyai8t4khpnisSO4fe3VWdi2S7j0B77TtYO1i7vLEhlke3X0zKc3UaBoZBaQn/FZ
         itlAx4x0vf+lN9+6Y8BDInKppa5X5w+MQeQfRcG+3xS87X4PsQfQLCm7+w/O11xbBm+A
         A8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749835921; x=1750440721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVccLtBUkLI1MEe4KbooOMLXqPFKOC+ce3CE/xpHyA4=;
        b=mvc2C3q8GlkzL5jlzoKtFICTCJDEbCTrW2YgFfSSjwvDJMjTaZJb8sP5vpTaYDzHsH
         +pYz+qVT1F8oUYZoXRf7zG64Zxi1Voq6YqC5c+FiVll+oOHzIgcdenj8K671jIBBAe02
         5X+cobKgDc0nvL1j0Nn1d/orF4vJ5p3DPHKTz+N2cTCEO8dM4FOlehnx3TYZFqsbkk+D
         FMHHnoRP3QtJzPFm4oZ1yUdtZOVVKsRODEv2RrjsX3yeZWKJAr9Ryt8glFNWU1avJob2
         uR6opXh1FuqIuhjloN+wktV8mQ4OB6Lr0LlmX/nQU4HIIWjfIwiBMY2Wr+d3sf7t/aOl
         hmZA==
X-Forwarded-Encrypted: i=1; AJvYcCU09bDxB+KapWi50O1bKso69bn1jLoum2K5XRfIkMylNc+WRbF8h66RTQFHRzH7n3krWe+WGc0YXc+pB49R@vger.kernel.org, AJvYcCVsHSCczqfVHDN9Ad40s7OwoH60qIW9R8AvlZGEK9+kXMUQdGHscGo5w42gfrxZ1xDDv74=@vger.kernel.org, AJvYcCX3aySYsXyhEElCH1NDU1W9W49865jWOh2+X5rpJ7JklwcWtOlLK/Et6PCxkUQ5a3xAQdD4PRG7PuaJGB0DRN4F5Bpn@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR+1XHskvosUJ0XyYZGxomGUvaOIH4KrC7R3634AQhaDDCuB1
	3xM9aK7C2+t6xvQ4ofm7H5uFnbnTg3416pSSmKDvuqR/mioc8Q9l8jT5h39sVgNnH1nIeAGS2G/
	detLw17mVlAERmmVNB0UHsrpV+C/RAECE6A==
X-Gm-Gg: ASbGncvSZ7U84qJ0JpFYYM6dIRW+L+jQSY4N2RJtS6bMGc70rVN0cwq2NXqq7+kAvSf
	gRF+YsiwV8eXpbtGdWLFyTGrhqG4mKfi0VY6qF19EKNGpzdktXRn9MdB1gcbyv4MQlCTNjEq1G2
	Fys/9f5H28DmIb0Xps+z3IwIkaG6zf3B/8quf+PhrcA1y7/qfumq0XYeMwnC1gDB/Lbo2UR5t4
X-Google-Smtp-Source: AGHT+IE5Txj9vSePCLXk8LXl4X9M2Y15KDj342FLtUVMXpCM6clk44IcqP+eIKErJWg8V6XaAMQaCZngglGDLa+g6xw=
X-Received: by 2002:a05:6000:230a:b0:3a4:f7e7:3630 with SMTP id
 ffacd0b85a97d-3a572e66e95mr638250f8f.15.1749835921053; Fri, 13 Jun 2025
 10:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612115556.295103-1-chen.dylane@linux.dev>
 <20250612115556.295103-2-chen.dylane@linux.dev> <CAADnVQLbpO7PED01OVZXTLib_hBYzwpC5hFyR_WMCCx8obR1Hw@mail.gmail.com>
 <00a22161-1e40-4ec0-be4f-e2c5dadbfe0b@linux.dev>
In-Reply-To: <00a22161-1e40-4ec0-be4f-e2c5dadbfe0b@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Jun 2025 10:31:49 -0700
X-Gm-Features: AX0GCFu5PYm5SWowV-4zYH0VtJdfphoQJYMykfiKk_2dN6Gss3ybOKWkgea3cQk
Message-ID: <CAADnVQKZbVHX_juvWqP-BZ77+TLfF73qnoV-7uDe5LxJsf4=9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 7:52=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/6/13 00:01, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Thu, Jun 12, 2025 at 4:56=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> Show kprobe_multi link info with fdinfo, the info as follows:
> >>
> >> link_type:      kprobe_multi
> >> link_id:        4
> >> prog_tag:       279dd9c09dfbc757
> >> prog_id:        30
> >> type:   kprobe_multi
> >> func_cnt:       8
> >> missed: 0
> >> addr:   0xffffffff81ecb1e0
> >
> > fdinfo shouldn't print kernel addresses.
> > It defeats kaslr
> >
>
> How about print the function name corresponding of the address, or
> don't show the addr info.

Yeah. That would be much better. human readable unlike hex.

