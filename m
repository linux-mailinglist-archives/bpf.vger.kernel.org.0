Return-Path: <bpf+bounces-70324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6FBB7DE6
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B3E4EE806
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB812DC774;
	Fri,  3 Oct 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqnc70O6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB13A258
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515398; cv=none; b=IQPqY/ETCh771pc8ejHqq0aninI4k5I5MsSEY3RjRYY/io4MvmLaF4CVhXuARswQfP2YMXPCoD2dmGPGcjJvwd64ey66uHGgQdpkyuhVKnKvngcGXzFNIzIzKgTCIwnD2GuK63iQ2JIGjuaS17rW5smG1tQIpAFcmaeetaKSunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515398; c=relaxed/simple;
	bh=exlo52lbDEg7POxTfPdis4zNeae6R3uOLVDidpkeGHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tebvorrYwT6QQi+JV2itpSTW8HIkt07JYN0TcCvX+mW3HmFkm1WzlBsqjlU1DHk6r5wltyMl550Yq97z0DwLmualAXDOc1KKnTWHaL9cy/jMixJ322dIl0LBj2SFt5CcmkfcyT7H+wRep7Qzv+J81L3/uSaJrkS9096eVgyMWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqnc70O6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2698e4795ebso24460925ad.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515397; x=1760120197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NlvWNc8WMjyB873fNGyOw5qWlJKkYrQGSuS/uFerGo=;
        b=hqnc70O64x0DDvJ+bIqprlzh8ogsJUqgB78pXtj+3d2dPpzkeXQH0/ATp0pSEoeM1d
         K/OtX/mswfotOOEo6tO/zyoHYhMzEAYqGd4j00Ql8Ili+PVAYxlHxlnAwFDRt2HjR0BH
         CsZhZru1cvqS7jrW7SfjNLnIOv8nOHvQZIXjlm+vZ6Z7alNXJb9FZdc1UJeo9tA+Kgz4
         gg+2GPgdTLCuxO7EV9CkFC8ZyQoJrW+QAmIA0hADyQ2BSiVOBagqJyTGUzAhxG1vv2FQ
         ZtfUnmSGmFyxc002W+TvjBdCRq+C+IP2TAAbqYi4wpIenDCBdaFnuBS/ZuEUhy0y9tx3
         tMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515397; x=1760120197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NlvWNc8WMjyB873fNGyOw5qWlJKkYrQGSuS/uFerGo=;
        b=Iy9Y6n8vCt/L277sJxXa1nsqxHTsLQznZRTxIRVov1hEU2xj71i1+uFqcJIK42fIwU
         AEJY5pm3l1QGX1ObZ/am2lcMagTA8Ras8fuUORPKHrnQNvVrnvVLRZ2+M2HS6bgdTW0I
         WRzRXn69BI/s495HAHYbCLygSonoPH+5Tl0WVkaU2dRAIznZwv1pFBFhyFhS2TTimBdZ
         K31UxcpBdpEt+1pSmJt1+0sGJR4//W6iuC1qwDiG+kdVBvPSj3gL4u890EfKSRrFjavQ
         iFE8BXGvGCiMdoO+I8cEAmwyD+0wdPFDnyh4z/Rj/i7GFCYed6iQ/jKY9bEjPoS/o1BS
         R2zA==
X-Gm-Message-State: AOJu0YyOdDA7R8VgOc9LHlNI1vQRpkY5eKq/jDVP7oMNwYfsDa5UHoib
	I7QHzWg9HHCeaaNpGpuV53Cp54pfnRDtw+LdLTaeez2kf22vBQGbPXeWNjo3yhXAa9OtslaQLmG
	n4bs+pZSzNSekiQkYewxqzgd2wBz5gck=
X-Gm-Gg: ASbGncu4CpQY8Jlg+hAKZUUYILJ2pqxC2NWSMe+SLEbjCZ7/hMIdNKWZ3mZNRuuNotG
	wvukwwYP5l/2HZmHBtj1XEck3BNstS9GvalhdkqQ6Uu7zUAIdxJmCUD3Td4H56TAOcOBZr+0MeB
	UC3Tp6QgOEUcQEUJhl8Q9A3AyLkqxgYD+sDjabRcM4B6yKbznfmlnMp5vvuNqsiZgS+aD5X2NVi
	+XOMe44LQmECQTi9SuyDkaJlderM2QfDBOJt77vyj4wVjI=
X-Google-Smtp-Source: AGHT+IHPA/xVOBt7bZRXr2yWAgNiTjijhBIo8q/oeVYgJfpboWfOl9K8byDR56MecvObqjzCI4hIkQypf/6Cs5+7N5w=
X-Received: by 2002:a17:903:1a86:b0:27e:ed0d:f4ef with SMTP id
 d9443c01a7336-28e9a6bbc36mr40502595ad.41.1759515396806; Fri, 03 Oct 2025
 11:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:16:20 -0700
X-Gm-Features: AS18NWAXvN967aY9jAcQObtZZiJLGCcfJ6N7GDdbBVSEZBRp2qQKrxtITL4-WzI
Message-ID: <CAEf4Bzav6VYyGBeffaRz36FFqqUank-SsLmWmi24hVjTroTXKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/10] bpf: widen dynptr size/offset to 64 bit
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Dynptr currently caps size and offset at 24 bits, which isn=E2=80=99t suf=
ficient
> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
> across the APIs.
>
> This change does not affect internals of xdp, skb or other dynptrs,
> which continue to behave as before.
>
> The widening enables large-file access support via dynptr, implemented
> in the next patches.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h                           | 20 +++----
>  kernel/bpf/helpers.c                          | 58 +++++++++----------
>  kernel/trace/bpf_trace.c                      | 46 +++++++--------
>  tools/testing/selftests/bpf/bpf_kfuncs.h      | 12 ++--
>  .../selftests/bpf/progs/dynptr_success.c      | 12 ++--
>  5 files changed, 74 insertions(+), 74 deletions(-)
>

[...]

> @@ -1751,8 +1751,8 @@ static const struct bpf_func_proto bpf_dynptr_from_=
mem_proto =3D {
>         .arg4_type      =3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_U=
NINIT | MEM_WRITE,
>  };
>
> -static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr=
_kern *src,
> -                            u32 offset, u64 flags)
> +static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr=
_kern *src,
> +                            u64 offset, u64 flags)
>  {
>         enum bpf_dynptr_type type;
>         int err;
> @@ -1788,8 +1788,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, co=
nst struct bpf_dynptr_kern *s
>         }
>  }
>
> -BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynp=
tr_kern *, src,
> -          u32, offset, u64, flags)
> +BPF_CALL_5(bpf_dynptr_read, void *, dst, u64, len, const struct bpf_dynp=
tr_kern *, src,
> +          u64, offset, u64, flags)

don't forget to update include/uapi/linux/bpf.h as well for all those
BPF helpers

>  {
>         return __bpf_dynptr_read(dst, len, src, offset, flags);
>  }

[...]

