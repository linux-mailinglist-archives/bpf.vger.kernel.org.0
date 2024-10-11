Return-Path: <bpf+bounces-41691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9A999A68
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF13AB23A45
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D21EF942;
	Fri, 11 Oct 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BflSVi+X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D88748F;
	Fri, 11 Oct 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613681; cv=none; b=RRbUijfYkJv2/AwY6avMFj5mLGFnGB6kx8c0PGNeKfAT8FpnC3XPA28WdrRvQ9pxoB24g15KYDhu+vYuDnjxz0H95WFuProp8LQhNVgDQtFVIQPS8PtEELXu9Iqo+5iAZSkidISlWvjL6PANS2r0Loq2fiYljcOcRqUxEoJlHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613681; c=relaxed/simple;
	bh=lxqmk4mamwVDAbw1no5BnHpZeZXOn9YDNh3AjARmCDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghTTEC2GwzzM9hnzL4/NCCgeDO4WZdKE8BQSsS5VOKxU6bgGYMQCgweEaep/WmwS11rr2QJeDvBNgB9PfMQ/L0uHLmX/jZoXzKhoAVKE2nHuLI8yS0Arq5kVIB7pJlprQ6PeOmY0nk9Pha0dZGdbKou6FW+ZVjHdBsnsviT28RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BflSVi+X; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e06acff261so1117745a91.2;
        Thu, 10 Oct 2024 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613679; x=1729218479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T1KMltqgg2pspxYEpkZNGwc7Nr6NvNlog7JhEVpRjU=;
        b=BflSVi+XA288F+Fg6Z9gOGKB3EU3JjzBDs64Hl2haThl9QOiav80RKmGBlvHlT6rDK
         E4XSV14mgxgwUnvIBgMF+j6B+23aD6u+vTB9ZQ/zRWyOq8g2mEMLTM8D58UIvEF3clNj
         iW4K5EkKQyEJm5b/dfH+giILkhaHXZkRG79x+6G3rC8HIosoMRIBysEBA/iU8KLZS0v4
         373XNN9YjaHqXMQdWWkQl1jK9kwXu3HzCLDzF1sJ1OlTlYVbuCEN8ATF6BIczD7AnMbw
         lBcn2BNgz+SGHhIduT7ZiuFRaNSUFrIM3Hx5fLRGwjremOCitRkHzeGR109sKG/MTu67
         +8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613679; x=1729218479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T1KMltqgg2pspxYEpkZNGwc7Nr6NvNlog7JhEVpRjU=;
        b=qW1Sj8MibxXnmrlTaHcUpdk8GStHcNWQ69zbeRgADM8/patwcyNH/WBmycKQzBhl2n
         mIhGFjlIVrLHdzUtzmBsMiKlOhpQLi298YGjz4S2gQE7GUXk+F8UVBQyOt+SA9VzEl1u
         Pjqx7bR660dsTB1qLjEUwGzJt7o8kCHiwW6gH87Bm3J7pYCDfavU+IGABfA93rVOdZaB
         GaKw49zXoU6RveCfUAAdwNjdKIRms/WJDuzxjRcb24+/w2vHIE1tgcm/xpN/Cr1FmSZ5
         IOh4zUAaOEMZKNzWhv80AS1LjOxdZCPla1lHJTOpKW65YqoQ7ByXx5+EMcZFxNivRX18
         0aFw==
X-Forwarded-Encrypted: i=1; AJvYcCUXg58H+dl5mO/d5KllFEaNvpaOMqJOyvfn3RjbQbqBCc+lu2nOqPply2AS92+wr9zt8Q/2Rmfem2AGJ/WG@vger.kernel.org, AJvYcCV8DaF3MDozKHq+E2tOgwXjY2kLuUQTr28OJ1pouGkHFefEHE1fF+hMRjvHR7PO6a7K9Gw=@vger.kernel.org, AJvYcCVVp8RP4YeIaQX+/jX8lxHddQIhuO7Uu0M/A+LdyyYkt0xP2mSuKXeeHGFAzl55ImT90aXyzfjAHfcnZFdihRyvZ1TB@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0xZY7kQcHaHIF4xrgo3woPFzYG6QZ8NAKr1pTf7o3ufpv3Dj
	Fd0x+yjdDzzV36s4Shhlk68OjHCEQIB0glt6SYHovDG18rXJxNVM1MrtZAcLjZoWVJ5UR2KoV/m
	5t/hXYq41gia/c5GVQeAfjdaxzxQ=
X-Google-Smtp-Source: AGHT+IGaTqm5eGClIBXELQRXAGQbTtHD3WXnh+R1+4xO5+JpmDk4nFwbI1arpnI6OVSzMG/LRMkiwIyAz08/5O1xdGI=
X-Received: by 2002:a17:90a:fe0a:b0:2e0:5748:6ea1 with SMTP id
 98e67ed59e1d1-2e2f0da18ebmr1732532a91.37.1728613679293; Thu, 10 Oct 2024
 19:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-15-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-15-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:27:47 -0700
Message-ID: <CAEf4BzZ0gOEdYtA5FdZxT_R3mBGBUrGwpvWaMrVQ2AP=bw1c-w@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 14/16] selftests/bpf: Scale down uprobe multi
 consumer test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:12=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We have currently 2 uprobes and 2 uretprobes and we are about
> to add sessions uprobes in following change, which makes the
> test time unsuitable for CI even with threads.
>
> It's enough for the test to have just 1 uprobe and 1 uretprobe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 57 ++++++++-----------
>  .../bpf/progs/uprobe_multi_consumers.c        | 16 +-----
>  2 files changed, 25 insertions(+), 48 deletions(-)
>

[...]

>         /* 'before' is each, we attach uprobe for every set idx */
> -       for (idx =3D 0; idx < 4; idx++) {
> +       for (idx =3D 0; idx < 1; idx++) {
>                 if (test_bit(idx, before)) {
>                         if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_=
attach_before"))
>                                 goto cleanup;
> @@ -866,18 +858,18 @@ static int consumer_test(struct uprobe_multi_consum=
ers *skel,
>         if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
>                 goto cleanup;
>
> -       for (idx =3D 0; idx < 4; idx++) {
> +       for (idx =3D 0; idx < 1; idx++) {

here and everywhere else, either idx <=3D 1 or idx < 2, no?

>                 const char *fmt =3D "BUG";
>                 __u64 val =3D 0;
>
> -               if (idx < 2) {
> +               if (idx =3D=3D 0) {
>                         /*
>                          * uprobe entry
>                          *   +1 if define in 'before'
>                          */
>                         if (test_bit(idx, before))
>                                 val++;
> -                       fmt =3D "prog 0/1: uprobe";
> +                       fmt =3D "prog 0: uprobe";
>                 } else {
>                         /*
>                          * to trigger uretprobe consumer, the uretprobe n=
eeds to be installed,

[...]

