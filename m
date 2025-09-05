Return-Path: <bpf+bounces-67621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B166FB4657E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6685317E1EA
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA32ECD30;
	Fri,  5 Sep 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEKNxvWO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51128000F
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107695; cv=none; b=erv6PlooJ18/1n9WqCZwi7X2sxOAvTxFp4NYn3hRy+krNnuFj7ELZU2RjSdQQm+/wyQJ4rzJ6BuETQDy/nRVDSb5byOeWIg2AzhzBQTsRAihOK+yWtaScEiuk2jLmWK61xMdhSadz8sshyHywpu3h1QkIM+ZqHucAgwRwvJE1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107695; c=relaxed/simple;
	bh=MIok5zpUF/8PvKKupnQKmBddLhItMo0hH0JW2Yk0a98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0FA3eC6tI/epONq9ii7uQc7WVGbXII7hZNhQKmDCwz5mTX95gyq2IyKpu9MwzWL6JZ1Fqck0Ey3u/+MsoT3TpAesMT43xwdkFnHr3qmuRBtyrsKgCXAGZfJTETZS6bft6rpn/7uEDVFZatGUn2xNK+vKyzTia90MP2SrGiqF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEKNxvWO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2095728a12.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107692; x=1757712492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d28W4qaJq6kNxkpCQiVJZrfRYoQK+nOVGnRg1v68db4=;
        b=DEKNxvWOqevsSA7FyHoXTXRK0AOD94nSPWFxnjrgsjQyyqvMJxmWyzypQo8bs0yKUX
         ZIWcZD1tpKNpCRC6f2k7yOu/nFh3Lht6u8Z9x1wEj8gk4PHCOuF5JPuEjaGOk9lqxjSe
         7BlodIDnsTQpzuXsjfFxEYE/5W3aq1qcsz0XWDTkgzqf9f1I3hIpo9IUgHeayIf9ohid
         9PFBKq8lLp3PEXTIQuZE86PcNhl29pa7MUzsoa5qRYsrUhEVXvYrfGlA02LpNtvZr8kd
         3OTMe6EgsPxA3HiHNAAJIr/AqGrMRh4q0thp1PEHYDX3ueNbHnE6ia0/r4jHkOekfZ1t
         KihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107692; x=1757712492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d28W4qaJq6kNxkpCQiVJZrfRYoQK+nOVGnRg1v68db4=;
        b=pFpOFjA3IEqOQ4bLHb14ObjYXpUpePC3pOrttE5ZHqz/Vj9C0+7Bn190LVh0Xqe9GX
         2Rg4AyoUiSMTLuqcd2Dj71q9ZUYoGhGFEtbbr820qWcqkn+kh3tJBmcrMJKnBsnNO2QA
         e+GCOivgJLq5ILvhFrEshOBxzVharNd1Rg9d/zXKwOLwj0j/LJG+DRM3kdGoxsMGfD0d
         9haxMLR0tiwubtDPkSmNFbJkVQNsy+Rjdq/CrMuPqF6MLuYe/MfBJIPEwz8fbqzDlTq3
         u0z5ppP+MRrH7j39RFjjHnJnD39tJqux0PaDkxSIQW6KGLyujmKJo0Bat3jHperko6Ad
         I5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWbznR/FKgDlF6qkGXZR5xpS1f4W0MFSgsBZUhwD+3gy6M2BSIN5x5MWG557Yvb5PhSHFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylcmv7HjGMvJuap9faOGb+a9b37i+NVgvBi7H9OH5azkxS6LmF
	/UMfWzkPfy9hxiMgFmuITTDy0D4tiTzLvSPluE2KRxiCc4r99BQfVTn5MmbedA==
X-Gm-Gg: ASbGncuOI5yfxQvvzymfQtzS/O4MobGwN4L+OV7VXI5/p5Va952zMw4FkLcYLAGKg+A
	Ts2g5bOfMVtz219AYKew2OefPW/aJ+0iYaxC3FVm5LVcodiNazXsmgzOSvgN08TyY4JOl3uttVM
	7ccGQ/O2DA3uVq68H5hGd/V9Sl4SS97sCcSd3wxgNHJi75B6x1pP8+zzsMCROsUO679gWwoFze2
	K1UliLWL0G8a/pYZg/WuEXi1PPokx4YTtFQFuuUaxhxq7nd2lTM4GLFMgdOS33i6EZqBhrQbR0d
	R6zK1gNNcBS4l1/HVlSHdObETOIU6RXVte87IpIoROuVx97zmgaZqGiLnXWhLyQ2Uhfz/q3iL0k
	k1PFwPPH+0pCy0SmcQpDcVzsGm3Zz
X-Google-Smtp-Source: AGHT+IEz987/qo1uKk3QrP10BWLCj4OkNJO7lxwTkEdTprd7dm0ONJ8iBpdMb+Q5sJbncew8QU2uNA==
X-Received: by 2002:a17:90b:5584:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-32d43f936fbmr334559a91.29.1757107692406;
        Fri, 05 Sep 2025 14:28:12 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e673ad423sm17237318a12.50.2025.09.05.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:28:12 -0700 (PDT)
Message-ID: <dd66ef2b3ba7d462b649ef87ebb2e166103bdb79.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: extract generic helper from
 process_timer_func()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 14:28:08 -0700
In-Reply-To: <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Refactor the verifier by pulling the common logic from
> process_timer_func() into a dedicated helper. This allows reusing
> process_async_func() helper for verifying bpf_task_work struct in the
> next patch.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b9394f8fac0e..a5d19a01d488 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8520,43 +8520,52 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno, int flags)
>  	return 0;
>  }
> =20
> -static int process_timer_func(struct bpf_verifier_env *env, int regno,
> -			      struct bpf_call_arg_meta *meta)
> +static int process_async_func(struct bpf_verifier_env *env, int regno, s=
truct bpf_map **map_ptr,
> +			      int *map_uid, u32 rec_off, enum btf_field_type field_type,
> +			      const char *struct_name)

Also, it appears that process_wq_func() needs to have the same checks
as in process_async_func(). Maybe add it as a separate commit?

[...]

