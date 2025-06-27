Return-Path: <bpf+bounces-61776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D90AEC176
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 22:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2533A70D9
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9B225785;
	Fri, 27 Jun 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxCNKlvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9391E48A
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057409; cv=none; b=iJFKW+DAh607eXPJ8Q+3aqK9IB5DS7y6hpuBTRqItEhkPqifIkTsRadi4ikW+WYgiKqCZB3a9oGmsJoOD7QHs2HIFcnlbtEGWR+pIaa0imQt76vGTK3rH2v+b/zXJZKFt2Qq68IVpBnq4ItkafYJVpU3Wmg0owdyjCBfBj2xzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057409; c=relaxed/simple;
	bh=3FfGDP51Cv9M2QulzGiv5Cc4xetKfhdEQfWqRnrmsTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUKk/pRgAVlfIawLSCaJmSS3P3pZ+pZUAbhXZB9uvc6khu9M+b00MRZ+TND8lFdzc9TZ6zu6WnDW3zkZm2iD0SQ+y/52f5aCdd/ZkfmX7nV7SeWupumwZubdFv08DHk7aB9DuHh5NapjskWx33rHb7bDp/WUivP16GBn0O+aZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxCNKlvg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3202392b3a.3
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751057408; x=1751662208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k+/ICoyRVOjdrhSdbQI1RZPRJV9R2PsGg4tkigY2mMk=;
        b=MxCNKlvgCSjp9Ed5p+ibc/bPGKfBJjvOvUUlVySpkgbGObj34EftQ6gCrf7smFv+AD
         tQlLTfjnTjRtSDKWIkRD3wJ2cce+PhJ57FY1fxtLnzzaikXCxPxNP7WNb39HssHdDbC7
         U5VIJx3bMo7QIw5uabRvI0p5n92UNZfe9mZz8TuJep4vfIBskC/ckkpf3et06WoRMoKv
         7Dq+ZRPmVAP2Zth/APpLk8zzyQj9mQIdoCMbyD7yoddFWW1rgkG2XNoBM4ZtksShhubp
         DcxvlUOi/kBgTCbDkulD4mIICZgid0P79xBL/EYYYJdEMFoOdtstfwrTvhDPbfa6CXhQ
         kDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057408; x=1751662208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+/ICoyRVOjdrhSdbQI1RZPRJV9R2PsGg4tkigY2mMk=;
        b=Una8XOTzsx49xBrEsMzotx3LBVBy/taUR6l7dHT+gWwOVH0AWrwZZu4NehOZ+goM/p
         u4qK4/F84TiXMd1aBT7VMStzK59NpDCjkaipEZf2++EI3ffGQ8v2ykaF/ggbEVzrCQ29
         DWdLZnVMHLuSICAtmVBAWpVenkBzjfzDjtw7/xsaupxFPWw0ebuLn+m7r/3C4B6Dm6kQ
         XW7zKg+OvvtGPPLRYddaDu/utf4wEiu7NHwRDT/Tm2QZVzIaTDlrF+qyA6L4gQKGvuqg
         HuW5i6qOJBgOeVsp4OxWieKYzVk3J6RNggCgQTuwVW8QlFM7mm4CHJ6Z5v6bK7vKcYgx
         dIhA==
X-Forwarded-Encrypted: i=1; AJvYcCXCRGjKTMQShbKHCQH1G66NravUJC9MrgERNxr2RMjto5CyqlaAJVoHib6Cr1/Nq1C/B7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXJn2aKEEbZR90taMuD+SHjMbVsw+R88RfSC1HR1NltcZhccs
	EjPcbQ5JH5E3u2WiSZdVS9D38kL+CPOQ0sBCNTKVXiCg22RSaeZvKqqZ
X-Gm-Gg: ASbGncu1N46MKiROukTVvYZH7pgfCkBbwWA8ps/PVpccgf+wbnNOmwFEVgwkXoEDYor
	AHDnDBjQb6E08Wdrs9ZLuo2TjAOKVfzikuhVq989E4W60oQDw9nQCKfI8LRpkvDZbLlEfTuW5kQ
	UnCLXw78Jke+o5WwJoEyRLq6N0ujzYByDRWEWgajPNHS9KF0+OjsBnHwsAcZTLsmuQhnRy82oZ4
	7GaQHYqOuB1v4mFc308pX/g+4AjVo/eZNJkrVHLIbrzOxe04M0pJqZ632RZggm3m/OEZk0MuD5y
	nE49AOn7kvGqtEPUnI1L9RjkSFp6ANqi5tmuWz0PF+7+d7l+DHFekvfpyOU=
X-Google-Smtp-Source: AGHT+IH9abTN9ZBu1V+Xia/yYiggMF2PIIxanKbROw3kDH3T0gM0ZgI5YLW78MHx6aCD86jR2efxfw==
X-Received: by 2002:a05:6a00:4b50:b0:749:421:efcc with SMTP id d2e1a72fcca58-74af6e2800amr6239386b3a.5.1751057407635;
        Fri, 27 Jun 2025 13:50:07 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409cb6sm3008815b3a.23.2025.06.27.13.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:50:07 -0700 (PDT)
Message-ID: <bf34ec5793a4bf243d283be52f8f5cc1dd0dd23a.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix
 cgroup_xattr/read_cgroupfs_xattr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Fri, 27 Jun 2025 13:50:04 -0700
In-Reply-To: <20250627191221.765921-1-song@kernel.org>
References: <20250627191221.765921-1-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-27 at 12:12 -0700, Song Liu wrote:
> cgroup_xattr/read_cgroupfs_xattr has two issues:
>=20
> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a netns
>    first. This causes issue with other tests.
>=20
>    Fix this by using a different hook (lsm.s/file_open) and not messing
>    with lo.
>=20
> 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
>    mount namespaces.
>=20
>    Fix this by using the existing cgroup helpers. A new helper
>    set_cgroup_xattr() is added to set xattr on cgroup files.
>=20
> Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xattr"=
)
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4=
tzcGAnehFWA9Sw@mail.gmail.com/
> Signed-off-by: Song Liu <song@kernel.org>
>=20
> ---
> Changes v1 =3D> v2:
> 1. Add the second fix above.
>=20
> v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-song@kernel.org/
> ---

This fixes ./test_progs -j -t cgroup for me.
Changes seem to reflect logic of the original test.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

