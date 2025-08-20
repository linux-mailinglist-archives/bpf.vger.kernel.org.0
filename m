Return-Path: <bpf+bounces-66116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E72B2E7BE
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EC5A202FD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE4334377;
	Wed, 20 Aug 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6BDsE+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4C33471F
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726766; cv=none; b=CEVB78cwGxGUzylryA5hcNE10CjkJWbRrWOi20LGi0O5zvOGCNRdsDH1Oqo/rV0SYaBWdTHwaehOgVkhx12ln7/dbLFqzWMi0Bw1j2co2qkCzsyqU48onzxiULncPmTQsGBqDQX6gS6wwn2IexCB1L30asKxpO+H5Ti8uMtV//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726766; c=relaxed/simple;
	bh=j5xSaCKdH1D6/fdRm2rk7pQ9RVWXMY6EtgcCikMgTEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBDn2OjLe1gBYNXwS0HtY2Se4MfuFIByOgHuMhMqUguK/17r3XZaCJiOlOKt/KY3kSnz5d4TBwhy/XIEPC7x9/5c+eOGfolbR4+YSYhOJgb6XUbbtZbBm3zrUMAguz8ziLuXHwXJJqsxM+CSXYy2ufLyXTHnqMAtTYZR1No1WmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6BDsE+j; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so425567b3a.0
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755726764; x=1756331564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XENzd7uKySj6nKmJxsbx14IS23W8qgFCQrpNYel1wOc=;
        b=Q6BDsE+jANo5gEwvIBm5oJD4zD5RRO/mHRim1A6sho7BZtE3EOLIvWcSs2nuChi70O
         ft9PnRF7vTZT8XkzpAykbbFsnjcGhg+1gtIJk92adX0ilTXv/kCQ11tFDoGLfz+Vwdzf
         K+IEYr8RaRt5s1gXuoOIcEiMqcPtGfAzcrAatBwbp8S3SAa5mPEMDd99yOaHWHvVo/v+
         24AYkm1DLYZZkNr7Sn3x2E6gamwStgF1Z9IKWVFaR08xb2dfI6bAphT/IU7kEm7mR564
         et3EZ+8T+Zq+FRTfV4qxK3gIs1y2yPlL0zlRZbuvIg1JNzqOhtpGnE0wglGUx5orVDOJ
         0bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755726764; x=1756331564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XENzd7uKySj6nKmJxsbx14IS23W8qgFCQrpNYel1wOc=;
        b=RYDvR9sEpgH9ZndmOOvSmxcmC4lVbVwTE1NpnmaKhPuuR1scvaN3ZLgk7Rir/GerWH
         0UcHh7kBJ8ATZ8nzO0jy4L8iflka46YMcfZ/BNSqwaUG6JUn7NcypaJEL509W6VzHi1F
         upRC5Z+NCpNGAO59CZMVPdPHNUKgvAXa9/XpGr5Hmdj9YMG/3B1N/1azqp8b6esEbwIG
         SJ7iktnpMS+XW+7uN3xj6b1cXeJR+yq8JHOfHU5k0wLD8u4g/M+EBsdAs/vyiUoYvc0W
         4189TIGvzApDNYOUFuKBBBeGFrsh4mWg0xW1q/4Jwr32Eaecrlu+2fHqXZrRTRHRcYXd
         7Z3Q==
X-Gm-Message-State: AOJu0YwqsxvPGaSqW/t+wc1mxT1A/OfeBT8aZ/RaTM+FPtMHe2XKRubi
	eI2ytmXmduNZ30ry25XZ24gRx0/UR0qaMhT+r5PJaviHCcohGOqEFkxcfQKdu+ZJ
X-Gm-Gg: ASbGncstawVHFD1k2QbcXinGMhB0UjVwF8DlyEx1Acdtlz6vTyWNAtzgQlkWh+5clvu
	EwQsOVh9nkJYxrthv2NuxolpxvRm8HS3YA2/fubbBNa+mceLSYydl4R24ib1f1AUGi6zlKyrheZ
	kW4T3blRCMUN+RX8RrZC6SX3O/QR0rIib4V8gwFa03bRw/JusnD9NRL/X85bgIBmRkfhUMTQwjx
	rjYMH5NQiJ0z0XBSxeP10uowFFShHpZAoCESUA0FT4i1odvKNU2XZi3QfcAA7ua8gz5d/ZJNNm5
	1gx0XOzCVThImM2bqvFWAUc/C+lxQb84ilRjwDXQK9GWFw8NMIkNdv3KkeeX+XdGAlhkm5TZO27
	ygD2f6wui2qO3KzVsjewJi0l3Gn3b
X-Google-Smtp-Source: AGHT+IHwgP0cbD43Y3R8ryo4X5QOuRux5yYDRpEzhwQkzPQ4nGe6cMdrpjKLgCPHmM1b8yJ/R1tJLw==
X-Received: by 2002:a05:6a00:9a2:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-76ea323c2f4mr112924b3a.18.1755726763729;
        Wed, 20 Aug 2025 14:52:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:f668])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d9438sm6194751b3a.21.2025.08.20.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:52:43 -0700 (PDT)
Message-ID: <3dc1c46e5cae319823a43edbefc4f7b1d8e8e657.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Wed, 20 Aug 2025 14:52:41 -0700
In-Reply-To: <CAEf4Bzbwnwj125ogm5u8pY6GNrR0EWLVH9J-diC49aZp3xi9RQ@mail.gmail.com>
References: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
	 <CAEf4Bzbwnwj125ogm5u8pY6GNrR0EWLVH9J-diC49aZp3xi9RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 14:34 -0700, Andrii Nakryiko wrote:

[...]

> > +       system(command);
>=20
> Quick googling didn't answer this question, but with system() we make
> assumption that system()'s stdout/stderr always goes into veristat's
> stdout/stderr. It might be always true, but why rely on this if we can
> just popen()? popen() also would allow us to do any processing we
> might want to do (unlikely, but it's good to have an option, IMO).
>=20
> Let's go with popen(), it's not much of a complication.

I actually double-checked this yesterday:

man system:

> The system() library function behaves as if it used fork(2) to
> create a child process that executed the shell command specified in
> command using execl(3) as follows:
>
>     execl("/bin/sh", "sh", "-c", command, (char *) NULL);

man execl:

> The exec() family of functions replaces the current process image
> with a new process image.  The functions described in this manual
> page are lay=E2=80=90 ered on top of execve(2).

max execve:

> By default, file descriptors remain open across an execve().  File
> descriptors that are marked close-on-exec are closed;

So, stdout/stderr is guaranteed to be shared.

(and on a different topic we discussed, 'popen' is documented as doing
 "sh -c command > pipe", so it differs from 'system' only in that it
 creates an additional pipe and adds redirection to sh invocation).

But there is a different complication, if one tests this with
iters.bpf.o, it becomes clear that the following is necessary:

  @@ -1579,7 +1579,9 @@ static void dump(__u32 prog_id, const char *prog_na=
me)
          snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
                   env.dump_mode =3D=3D JITED ? "jited" : "xlated", prog_id=
);
          printf("Prog's '%s' dump:\n", prog_name);
  +       fflush(stdout);
          system(command);
  +       fflush(stdout);
          printf("\n");
   }

So, whatever.

[...]

