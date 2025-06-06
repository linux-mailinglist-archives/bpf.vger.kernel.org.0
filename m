Return-Path: <bpf+bounces-59821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83544ACFA94
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 03:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5295E173BB4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426291805E;
	Fri,  6 Jun 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiBidvtl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6577FD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171839; cv=none; b=gQxtstoAt7hWtOEz6+5adLxifBj7F6/MVEkixPyNyZNG6mv196qstZWbdSRtGdcP37Jtkyvz1oUnHZJ38IwfEMn7u8Zg5WLbKueF042JsK5DXtidcPwoYZfqUtju9hFPtIudI19mgXjCwCba/CZOkiq7X2tktxVeh4rqd8ZtV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171839; c=relaxed/simple;
	bh=ULpXMi9mthfTNWdQk/fHt66ZBNxln3q316Vrn3RIzV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aujs5fa6787SD5Gfawr/ylqPSzxdVlyKH4hz+4w33MvTyL8B+qxoNCssvejCRFj1JSVdx/rOt1GTDQemG88w6gs8kVyzZgCCe2F3sQQ6pktt//Cwr4Udj4GhveoGo8vsNZC9zrpqt0OWMf79KXTOBdDCFm31He914qHOjVQHykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiBidvtl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so21781805ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749171837; x=1749776637; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3A1xpcBdF+A33LhEw8Elk/wllDEcrIO7HoZNPTIXXBE=;
        b=AiBidvtlUpr+YAyInpN/EVZEhyKp6b+qOw5Pqvk3BJpj/T4eK/hZ8W0f2t51ALJWrR
         4zMEPfZzCYMwdwbWIHMgW14+njTaTvwkIUd2OcN/KXvOnblokEJoJLoa0qU0diE968EC
         LXI5e5lcKEfQiM2sjR4kpKTlUcCWAlY5Mbhno6S69q3kjOMkcPWhIC8vDPfOCkthGRCU
         QWhUhAQhwavag540X42GVPZc4gprTBiTUOwetzvHJtUicNJZx7flVC6Ou5t6dkq9mSee
         g824tA6Kd2kKQIlIZ/HwfdOt1nfGhF8yZwE3f346wdEB1Rfp0ed00fwu8a2PLE2Q2fr5
         ZZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171837; x=1749776637;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3A1xpcBdF+A33LhEw8Elk/wllDEcrIO7HoZNPTIXXBE=;
        b=cfMYm+3LFM1BMeZyZuCuFJ4YzR3sZQ6ibbGe6dPcclEOxEfbHoWSiWMU1zll/3PtyB
         LcKqR6l8UUbHtXIeWZTMqNpD0rSyyDh48yHEqpkU3VHx/3mcE0s1VrY1Ehyuz3qHZmJ1
         iZDGHE+U9TGHbw24iupRMJ7cOJzPIijYUW7M/wFY+BcrbB91ndU/EiyXHIQSvTywpiO3
         JzJ+8N6N4ONGDoOt/gMdfCah82PZNcZ1iDojhoo3zzrBPp9Dn4Q8cqWNMEJvJ9m1REj7
         ULJIV3h7cbGLXA5myzXxll7NhgePDwt0oaXaH8lEdndDJSZH90Upu5rXv4puKzfw6xNr
         wiqg==
X-Gm-Message-State: AOJu0YxWoLoRKBMAvHc/s0DF+1sl4WNo23JfEr76v1/6s/IgnC5HfLSt
	u17L2NGYCV2OU+7gLogU8FUT23L/IyZ9DIUaDDF0DdXPSmHRnWU8W9bJCK0izI48
X-Gm-Gg: ASbGncv6ii/+UOeV0SdtOsnPRkMx2jKlulxan+BGqRdOI0HkYmoQNBUWFcB3G+5j6gV
	SC3GODl98aEuUCGblvEjZShwQcN0PH9gvRNI9X77gvq4Gj/ci7+O9LJVOo2x1SRA1nIem1riQZg
	xdEUHp5C8y87XxNxU2B5xNaQDLsWHkxbzBBgszlAPYaeI7lQ64Xj19OtIjjQgZENt8u831jz1M8
	ZskHThOy8uyntp4di9IrssvuWiLC6YZ9lC7w9D1vr9lgqFRi5k3BJc939Bs74fuNsIk97Sx53V7
	ln7yKYtUwfrjOCZz/g60rolfvi9IXoDxhD4BqcAsGvbyOKA=
X-Google-Smtp-Source: AGHT+IHL11dEOqVVtvFLCBZNPKhh6+uYXMVdQUr31rLtlYXxy6wFZDpPyAXJhrLI0Ma/EtrsAKNpgw==
X-Received: by 2002:a17:902:dacb:b0:235:f70:fd39 with SMTP id d9443c01a7336-23601ced438mr20179125ad.10.1749171837411;
        Thu, 05 Jun 2025 18:03:57 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077fd8sm2092295ad.45.2025.06.05.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:03:56 -0700 (PDT)
Message-ID: <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Thu, 05 Jun 2025 18:03:55 -0700
In-Reply-To: <20250605230609.1444980-3-eddyz87@gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 16:06 -0700, Eduard Zingerman wrote:

[...]

> +/*
> + * Enters new cgroup namespace and mounts cgroupfs at /tmp/veristat-cgro=
up-mount-XXXXXX,
> + * enables "memory" controller for the root cgroup.
> + */
> +static int mount_cgroupfs(void)
> +{
> +	char buf[PATH_MAX + 1];
> +	int err;
> +
> +	env.memory_peak_fd =3D -1;
> +
> +	err =3D unshare(CLONE_NEWCGROUP);
> +	if (err < 0) {
> +		err =3D log_errno("unshare(CLONE_NEWCGROUP)");
> +		goto err_out;
> +	}

The `unshare` call is useless. I thought it would grant me a new
hierarchy with separate cgroup.subtree_control in the root.
But that's now how things work, hierarchy is shared across namespaces.
I'll drop this call and just complain if "memory" controller is not enabled=
.

The "mount" part can remain, I use it to avoid searching for cgroupfs
mount point. Alternatively I can inspect /proc/self/mountinfo and
complain if cgroupfs is not found. Please let me know which way is
preferred.

[...]


