Return-Path: <bpf+bounces-37337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C1953D92
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF87B2765A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8109155353;
	Thu, 15 Aug 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuwZQrlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4661552E3
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762280; cv=none; b=fSetxz1YtX0dBw4d0J41QD/jz5/cW+3PjX4aZhxNiyTjyjUnw0rIXTwNjsqTRjJ7fgTE7OkY8Ym5QUdYkFUqExxsHjFC8DqwEcne1y83hzQ/XUBUfl7XVl59ZEQMDnSuLdGeiEkRcXzZZdP2CtSzfhNIqnRHM1jd/FAh4njEJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762280; c=relaxed/simple;
	bh=iTCwR2qTpcFZePGnAHFaDMbIy46s86ZGQKv6aGcNRVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTn5/AJFCvvHeFF7dfjki3opGyOmWIOBaAXD8Vy+bDLkmiBHkQxO4IslhuIrqLyz4eYFesxLe5yJ24qL+4vflfqNTjytYF4AZSdpK7ZyDkPBEehpoZ9gDuBeD4zZoyLlpzK7xrFHigHbtmmf8h8f7sJVTBzjPMYF2ix+55CBfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuwZQrlV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so1736781a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723762278; x=1724367078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQt+Cbg7xJdU0wx8GT5ACuwZcyO+yZPV346DvdwX0WU=;
        b=JuwZQrlVHE7D0iAkGJtvBySJErySHgCIQE0Oaz7/RafLm0xaiuSdfOBJd9uC/+DR9R
         akqGav/la3zHmO8ZDW6zb10FSvHxKSAmtKf/xRox7Gi74xRxocFrtWUxavWS0cO2SJg6
         L1w/DfIIzv2jUWRgzLgPddcrRoJFgLP7YJK4TgsL4D7k53CQuJOxWWFL/YuqqrE1PEfW
         Bwdt0fu9VcNxMc6TqKw7U/K1Z4hiOVtn6ACtQh9LAWehXJVq61YFy8921Zx0BGN0Xq8K
         DEyEkCflo1PBOkO/ulMBnYe4il2p7XXRou6ssPrdDahUliJEgtMIeDjd/HDDZqvYTthY
         biow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762278; x=1724367078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQt+Cbg7xJdU0wx8GT5ACuwZcyO+yZPV346DvdwX0WU=;
        b=mZfG7hUpjO1oiIVZofhOKWLnsObXj2fz1eUkTKtPL0bdJWNr+rwa98Ruh8UQC21RDQ
         VPX/zUy3x43R9hqKjIJZWZsJd+iD0JzRHr/dnMGcta3ZnNKUyh6m47ZtLti9tBwW9XJ2
         h42fSfV3CwA2Ge9CNF2wHL9FlmTMdndx+3SfXPJRs1ZrzdyjmWrdkakOUlm9z1HqA/oH
         jyzble0AKCY3LWIl1m2G3pJ6eq76F/nFZDNKs8rz8o24RdXs8W/Y3jT+v9OHZfKh6oz4
         HehqA0d5fjupa/XxOjvH47K6mV82TmRBJFzIoJZYCXZaB1dd0X5H0z3krV7mGHty3P7F
         1btg==
X-Forwarded-Encrypted: i=1; AJvYcCVvUV6M+gkCdg9OsQQOglDvVV+gBuSvTk6TBF5ySRveHFKyIMyQN9Fn2Du1af+EolUc1s3ATZo3x/GNms6R2K9CON+v
X-Gm-Message-State: AOJu0YxfkOqmqd1ujuoCqrB1jsfdfIyUcGPOeeVcIjJjEGUgyHOXCHBC
	ShTWZHW+4oPAEKROnXYzL/5lT/IaFsP7DwzcT39EpWZirmYjZ5dUijHnhCzfVyxWcfIvLNvgN5V
	ou+lSLw37EZyyubxwcuVwBa8+cM0=
X-Google-Smtp-Source: AGHT+IHZTEumEao4WT2U6lEyU2/FnGowlvBy0P1f9l3vhOsoR3f90qvUmF+L6E6hZt5Azt+ZeEgXYsjFPM9JsLw1lr4=
X-Received: by 2002:a17:90a:55cb:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2d3e45f688emr1011737a91.20.1723762278234; Thu, 15 Aug 2024
 15:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814235800.15253-1-inwardvessel@gmail.com> <20240814235800.15253-3-inwardvessel@gmail.com>
In-Reply-To: <20240814235800.15253-3-inwardvessel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:51:05 -0700
Message-ID: <CAEf4BzZTZJt6geqB+2HY8ViG0qqrosZe=xH7VArSOuD+zs=j-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: allow kfuncs within normal tracepoint programs
To: JP Kobryn <inwardvessel@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:58=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Account for normal tracepoint programs by associating them with the kfunc
> tracing hook. This allows kfuncs to be called within tracepoint programs.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  kernel/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..8b844d6fd041 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8303,6 +8303,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pro=
g_type prog_type)
>                 return BTF_KFUNC_HOOK_TC;
>         case BPF_PROG_TYPE_STRUCT_OPS:
>                 return BTF_KFUNC_HOOK_STRUCT_OPS;
> +       case BPF_PROG_TYPE_TRACEPOINT:
>         case BPF_PROG_TYPE_TRACING:
>         case BPF_PROG_TYPE_LSM:
>                 return BTF_KFUNC_HOOK_TRACING;
> --
> 2.46.0
>

I'm not 100% sure it's ok to map TRACEPOINT prog type to HOOK_TRACING.
But assuming it is, shouldn't we then also do the same for KPROBE and
PERF_EVENT programs?

Either way, please consider Eduard's suggestion about changing patch
order and switching to TEST_LOADER approach.

pw-bot: cr

