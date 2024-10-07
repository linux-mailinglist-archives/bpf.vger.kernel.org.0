Return-Path: <bpf+bounces-41156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA05993704
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298491C2179A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291E1DE3C0;
	Mon,  7 Oct 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj+myy04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756311DE3A0;
	Mon,  7 Oct 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328431; cv=none; b=q9xXT30ESLXahFvnw0vyOEo29uYIsw0hJeAw2mJspU8s5bNmty71rsumIfq3B3UPo9L9lmABzn1XOFO6d1vGCWK9Pl4dweZPQXzfhlLfpdQofAwVMpENrQDx76BCKHA0YzudUhETB/Qg2xCrWE1fOwSxxt0GxTCwvyNBkpQQHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328431; c=relaxed/simple;
	bh=qnnDCNwlggsmJ9jsj5T6U7U2C2iWDxXTs7W2CEV7Ojs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxP5X3Wk1SBxoG+w4jcpdWM/vfJa1AyqsCL+s9r4RFz+yDFqUKDf4Rv9iUxbBQ30GPH5P/57qFa43Wy137LHZmifQYUXeS03T7+n814SiHqm5DjWDurqhXqgFcWep9LmRBOxYfg2KPgSTWrMlmUuIVkqNY4tdkPon88Y2PGMQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj+myy04; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ba9f3824fso35709095ad.0;
        Mon, 07 Oct 2024 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728328429; x=1728933229; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILf8t1U6xtrHdbuk89VnoNCYtoM2KfGDywBcZro4lqU=;
        b=gj+myy04XvjCD3lsfVubOSZiVUPNcPI4DTif5kN2brvAo6/3YagnniVfqCEx3MjK7d
         6Z/5X18VyIC8uLV5nu22/QLWbaus83fc46FkR9E+kxZNkUdHLemefAl6X0+44iWsU657
         WmtlU1zAwRPfU+jC1pKNdt1psMaiMDlRBnLl+qNVWRAgozwiCl6F/5XcLcFWFy39sKi6
         tJQJ0TXZD52Jfd8Rvt5fbG+mFT2JAJKT6+PFoTZOVF1sIlFVHhdU6PcAQp+Dex0mtgoZ
         dHDyl2RbX8dcfRUFI21/0ZbsqfYOAnC0DzRKk6dXeQoSGfK8xBPpUsc+IxbZN63z9JAl
         6HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328429; x=1728933229;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILf8t1U6xtrHdbuk89VnoNCYtoM2KfGDywBcZro4lqU=;
        b=Um1W9mVvK6HCRzfbVWxSrDpA+k+ityoroWljbGYtMmiyaadysPMKLSP7m4Pd+l7vvs
         Iq+bvB1hke5eN6CtdW6JPIcDmfoPCOoLuaMiWSo9IxRyYbcSsL//Qe9XEfVdGsWghmqv
         56JPaY2zE/UIrsrMLvV/U04fcju2608MhetrJLcMIrZ8B9wRO0IBqo0Xh5c3jN42c529
         7OblGrzc0FVgkT+knmkO+xTOMrdYKcINwlAKVP5I+Xy4GbwSWtU6mkeWH2+d42bKtuLj
         kv4yzEStLWp4VvB3sIA34za1mAsVlHPdJSWJZHx9lAm7pbfsILiQrcVxjMOUQzDYsLFm
         3IpA==
X-Forwarded-Encrypted: i=1; AJvYcCWG1MpP957shKkPml+J9Y40XlhQNVS0QIdNiMgodlyi1cUHiKvytMRqDF+pwFN3hkK4gdk=@vger.kernel.org, AJvYcCXUC8nrRFR0UdCEpuCqhkH015VIc0VsbOLV0d0Y4QAcZ1riXdPGakFiAKZ6pxEiGsh7Czh+yTiPoNXv7ujn@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpxs8gI4dcX5Yf5NTtLiLrbKx8n/m6LmRxT89TE80FOa+HKRl
	j4Dp8fcxGSDp0ihoR86CPsrAsiqPKNeFXJgpcJOdxhcDmN/Laj/P
X-Google-Smtp-Source: AGHT+IGv8qW+pTZkfZuUNuavVODY9+OzULir5YzJCapvwYBIEPLhFQ1iCh2Q4TKAvhHTynThsMIjEA==
X-Received: by 2002:a17:903:41c2:b0:20b:4f95:9339 with SMTP id d9443c01a7336-20bff17e31fmr152547065ad.60.1728328429458;
        Mon, 07 Oct 2024 12:13:49 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a2bd3sm42776055ad.295.2024.10.07.12.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:13:49 -0700 (PDT)
Message-ID: <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 07 Oct 2024 12:13:43 -0700
In-Reply-To: <20241007164648.20926-1-richard120310@gmail.com>
References: <20241007164648.20926-1-richard120310@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 00:46 +0800, I Hsin Cheng wrote:
> Fix integer overflow issue discovered by coverity scan, where
> "bpf_program_fd()" might return a value less than zero. Assignment of
> "prog_fd" to "kern_data" will result in integer overflow in that case.
>=20
> Do a pre-check after the program fd is returned, if it's negative we
> should ignore this program and move on, or maybe add some error handling
> mechanism here.
>=20
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..95fb5e48e79e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8458,6 +8458,9 @@ static void bpf_map_prepare_vdata(const struct bpf_=
map *map)
>  			continue;
> =20
>  		prog_fd =3D bpf_program__fd(prog);
> +		if (prog_fd < 0)
> +			continue;
> +

The 'progs' variable comes from 'st_ops->progs' array.
Elements of this array are set in two places:
a. bpf_object__collect_st_ops_relos() called from
   bpf_object__collect_relos() called from
   bpf_object_open().
   This handles relocations pointing to programs in global struct ops
   maps definitions, e.g.:

    SEC(".struct_ops.link")
    struct bpf_testmod_ops testmod_1 =3D {
           .test_1 =3D (void *)test_1,     // <--- this one
           ...
    };

b. bpf_map__init_kern_struct_ops() called from
   bpf_object__init_kern_struct_ops_maps() called from
   bpf_object_load().
   This copies values set from "shadow types", e.g.:
 =20
    skel->struct_ops.testmod_1->test_1 =3D skel->some_other_prog

The bpf_map_prepare_vdata() itself is called from
bpf_object_prepare_struct_ops() called from
bpf_object_load().

The call to bpf_object_prepare_struct_ops() is preceded by a call to
bpf_object_adjust_struct_ops_autoload() (c), which in turn is preceded
by both (a) and (b). Meaning that autoload decisions are final at the
time of bpf_map_prepare_vdata() call. The (c) enables autoload for
programs referenced from any struct ops map.

Hence, I think that situation when 'prog_fd < 0' should not be
possible here =3D> we need an error log before skipping prog_fd
(or aborting?).

(Also, please double-check what Song Liu suggests about
 obj->gen_loader, I am not familiar with that part).

>  		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
>  		*(unsigned long *)kern_data =3D prog_fd;
>  	}



