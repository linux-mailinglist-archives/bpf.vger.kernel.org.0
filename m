Return-Path: <bpf+bounces-33663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF259248C1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3351E1F23542
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B0200100;
	Tue,  2 Jul 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lni47Esk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DF1D363F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950846; cv=none; b=g3Lr3yP2xvGNJ9/Vg7uGTnibtrDLpbsKfPjttts+bY5jVvdn40HN1ERDnTP1oIjjl1As+mrB7VyqBD9TfdjNr8hnKW8fAM7iCuesDXQAEm7NTQ7I0D+xQx4tLXtSSJwi9o3F6U7hyRHaaW94oeuPhqnWrsevj+p97IK4VLNTFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950846; c=relaxed/simple;
	bh=YklHwUCqBIkSc0D7cVjpAubrumsEbvUXdOf/34uwxCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgZtmrDtLk4EwBDxzoWii/aoe8e024rE2mxmdg5DeZHcelVK2OJ2rKNO+W58aHdc8LhJXuPQLOgXGZvVHw8KSZWHMYIcmmzVdZOnIyf7YiqRDpbkHvgvWMdYCX2wIs7CZevoj5t0gtmfdY//IxA/n9hsO8iEhsUQxXF0wSuAGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lni47Esk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c9229c53b7so2823436a91.3
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719950843; x=1720555643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7x+1gHNMd9VnaM2je0ztd0UYVoFazbeAdAPSzDhH0WA=;
        b=Lni47Esk1wRdAXJri6JoclMCnwh4pD36se4uXsqV6a19gGVgICGs7yj+MF2ajtL/IT
         sx/SI/64AZZbvHKFZdJ5+jMUXYrh+g59PUub/XZM3Cl562QCnyq40P55/0gZhGHc9yA9
         A2rJUyX96NeBiXBuG5AIDr1P+9pEbajIvjVpnv8n8GxBYNNva0hRbevpyM8XVz74CDSc
         KiIkrqmqn5+FFH4FiB9RioVQrdR919INxdOMnAFlngzUGawn6s5x+uEn5Hq5EgGVkWlk
         YsIJksSeSflbGi7RGI/TmMLKhwvBFNpJTuJvrKHsFclRR+zrmyKLKGoWaNow6CChvuDF
         1kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719950843; x=1720555643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7x+1gHNMd9VnaM2je0ztd0UYVoFazbeAdAPSzDhH0WA=;
        b=W2lqhOq2nMJLRd33pWvYMX/DKpbVdOCpnhsBoReTVgnPiphratTuO+GhFatt3at5+z
         RdAbuhDb8XhOdPaZK60fZqq34JZMuSYwvMsGMIML5bCfWIQKRDnfu/2sY15P1IfXx6v/
         RSk9N0ec9CZ8/nZ3UDtdFxoYDlG2bUjZymRyiOPKlnQfg8PwUrl3SVBIbk5SGHE98MZB
         yN45MwXU+30vIQF4x6wTdBNxHC6A+7sFbzcF/C7EtWF9z5BXrNG9RPoCtGsGTVVBWf4K
         GnQ38EMILmlzwMZFaOiq5lMJEHTyCfQd+LaWF/fffi8AhjWmFBOvSggeg0i2xrgXuioq
         nImA==
X-Gm-Message-State: AOJu0YysadmIwuTxYxfXW/j5rxXpNNAVbxiu1qXpYQJm+bu5og49YE3t
	zqwRRr0r2fGZHKf0QiC5+JrAVbnSiMcKvdqxheL4wtV/fUPwDbEf
X-Google-Smtp-Source: AGHT+IFLHcXdrvYh9aKckTTbbVUiC+WcESuDyXAgviPInTNcTzfnbIGCJBNXS3YVLdvGEcfbIM+5ww==
X-Received: by 2002:a17:90a:ce02:b0:2c4:e1e6:d35 with SMTP id 98e67ed59e1d1-2c93d759ab2mr5583489a91.30.1719950843273;
        Tue, 02 Jul 2024 13:07:23 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596675sm88104965ad.249.2024.07.02.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:07:22 -0700 (PDT)
Message-ID: <2e1b61255c9847db5ee54e4a981b980538d91c4c.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 1/8] bpf: add a get_helper_proto() utility
 function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 13:07:17 -0700
In-Reply-To: <CAEf4BzZE8=PsHx7SY_bYJbEvEnt_BRhmxupk6GaRO3DnjDF8Mw@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-2-eddyz87@gmail.com>
	 <CAEf4BzZE8=PsHx7SY_bYJbEvEnt_BRhmxupk6GaRO3DnjDF8Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:

[...]

> subjective, but this might be cleaner and will keep first verbose() on
> a single line:
>=20
> err =3D get_helper_proto(...);
> if (err =3D=3D -ERANGE) {
>     verbose(...);
>     return -EINVAL;
> } else if (err) {
>     verbose(...);
>     return err;
> }

Will do.

