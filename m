Return-Path: <bpf+bounces-47082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FB9F412A
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 04:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F177A2BC7
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 03:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A498145A17;
	Tue, 17 Dec 2024 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijTRTIhP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675C85260;
	Tue, 17 Dec 2024 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734405325; cv=none; b=P5vt/gSEpLWwqGAYt9gf+7iCBVKwYENf3HhK0Vbrd0quUA8Yu5MImpeXF+4u/yg2ySKhLFmJMG00DFOSyZVXKGXZD81Q0SbO5hZl0BFT9AV6rjo+RtllahaouLvbW7EuQap9jCiFHllm8nB3sJclNekeVUuS3ES0wygAkqNfAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734405325; c=relaxed/simple;
	bh=VLIC7bPglVDFk9fMdVDjuDJbgHtTUeUicHgbuv/TqYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCpLeK86fyW9+7VmuJYwVMlPix3uKFXN0gFLkyvlh2J92nl/2i1NbILE55AUcnfXP9/TyeLbP+hG/4VvOx8amecaDpqXh70lsSgicd4ZreuraAkDh2xNLvIWoKUej+SLhF58MGUD6RzpsW0smLzMUOLn4MdKe7XWlIIzdHYFDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijTRTIhP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so4030105a91.3;
        Mon, 16 Dec 2024 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734405323; x=1735010123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJ8chlUVrfKWQ3D6jKT4OyCEToVW0T1l4V7BCtGs1bs=;
        b=ijTRTIhPjmou5saCQZJnKINGdUK49idKXYvCIvDkKxLSkeV6aUJ1dro75U/AMSqqLY
         9tjDgWx7Zh2KDMKCQ47XGTKzHhDf4jfUuXc/c5pk1Kn+bh17/AAVS9GGl2c9V17Ya0Oe
         tiMITp+Wm0hOlZhGjYAMmPgW6p96GbQiBz37T9apgMLuM2Sw4NbWEM92R/JqfkNUYDPB
         9XrmfYv13gwuTIOv2ccLNyH3I9GEvvznHFuBtoelxRyBQ6F5zz2Oi/QeFGurTKydvhK/
         gXKCjw7BxF9L6HuwnlHZM+DlkSwL223mUsG/xSsCWN4lDlZ4HYwMytbPeSd6vQscowsA
         xclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734405323; x=1735010123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJ8chlUVrfKWQ3D6jKT4OyCEToVW0T1l4V7BCtGs1bs=;
        b=Bpg+Wbg7japzYsc8pBDjJQPbS5xdW5xImPLlhNZIoqRbIVVrRYTNY5fVVMAkTrx4O+
         HK8+ZWNUXmRB14tRg+3YliWTUQKnI3/W4fsSI2W1B6uiDHyEuIHoXKNA1nCtkXmd3Q7K
         EfCXi1vY02qBwhWMLPyBHFvzXAjejsyynNZZODPjFvQGF0Em3zZCPFEQckASUby2+ZZI
         5Lhtjuk/TnPk6uEjDKRdYDp4WC0RsgqF5g5y8te+cQdqIVF1x3iem4hmDOAI9ojQM556
         9xe/y1MsuXOVBhvzE6vAmbyGcdJVj2EvSCFg6s35HmuN4DYBf9uq3+ZQy1o+2ohQ+FYR
         Dw6A==
X-Forwarded-Encrypted: i=1; AJvYcCUnotymplw8UrHutFKLYXmFKmdpL93pciZLoIc8dWnI5Vik1HfBGN5PipPJBoGrGw7essI=@vger.kernel.org, AJvYcCXxE2H+D8Wj+QPaRaz17jdLW+rnIuHWFVJwlQLBB8hemsnkmGnjWPtgOY28g+zat1PILt19EmUNDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQfyHK0TZwosO35WMjSl69ns41RdO29c1+Gy3/1JjrkbJpmgU
	XHASg94o4r8/eP79sLwYNW+YiSPdFY7pQtrDDFLo4Q+yJxSy1xf3
X-Gm-Gg: ASbGnctyT9Ptxe44YzbqHm2wheUV07CIDgzGWGht/RnaGx2hLfe6dhKISWQ4ximPdu+
	06/e+Rz+cz7f/jQBK/Db35IC6LgUu4h8PXI/Cki/FKOIAfrGGs+E9CCkP3MsLvVol4BQ18MNBAm
	PI/E3uhC1oZeKDVU/0Yv1zdNXQQWI6WmOilT941/Z4FfxZgqCGWrztIkX6KIRhOx2gxSHSv9RvL
	XrvodPXibKBmaEimlCUWvyNs+/MjEZAeqN1fJf5uoNo+cG2ibfhDA==
X-Google-Smtp-Source: AGHT+IGbXGu9Wb7MW+A95hJbEwMqx5NSmVY6BYW3DyfP09ZIRQNd57ZSauVyXNC36/Ci1w9RQYe/Bw==
X-Received: by 2002:a17:90b:3c86:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2f28fa54f59mr20884882a91.1.1734405323538;
        Mon, 16 Dec 2024 19:15:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d5dasm49543325ad.260.2024.12.16.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 19:15:23 -0800 (PST)
Message-ID: <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce
 btf_encoding_context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
 mykolal@fb.com, 	bpf@vger.kernel.org
Date: Mon, 16 Dec 2024 19:15:18 -0800
In-Reply-To: <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
		 <20241213223641.564002-8-ihor.solodrai@pm.me>
	 <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 18:39 -0800, Eduard Zingerman wrote:
> On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:
> > Introduce a static struct holding global data necessary for BTF
> > encoding: elf_functions tables and btf_encoder structs.
> >=20
> > The context has init()/exit() interface that should be used to
> > indicate when BTF encoding work has started and ended.
> >=20
> > I considered freeing everything contained in the context exclusively
> > on exit(), however it turns out this unnecessarily increases max
> > RSS. Probably because the work done in btf_encoder__encode() requires
> > relatively more memory, and if encoders and tables are freed earlier,
> > that space is reused.
> >=20
> > Compare:
> >     -j4: 	Maximum resident set size (kbytes): 868484
> >     -j8: 	Maximum resident set size (kbytes): 1003040
> >     -j16: 	Maximum resident set size (kbytes): 1039416
> >     -j32: 	Maximum resident set size (kbytes): 1145312
> > vs
> >     -j4: 	Maximum resident set size (kbytes): 972692
> >     -j8: 	Maximum resident set size (kbytes): 1043184
> >     -j16: 	Maximum resident set size (kbytes): 1081156
> >     -j32: 	Maximum resident set size (kbytes): 1218184
> >=20
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > ---
>=20
> After patch #10 "dwarf_loader: multithreading with a job/worker model"
> from this series I do not understand why this patch is necessary.
> After patch #10 there is only one BTF encoder, thus:
> - there is no need to track btf_encoder_list;
> - elf_functions_list can now be a part of the encoder;
> - it should be possible to forgo global variable for encoder
>   and pass it as a parameter for each btf_encoder__* func.
>=20
> So it seems that this patch should be dropped and replaced by one that
> follows patch #10 and applies the above simplifications.
> Wdyt?

Meaning that patch #6 "btf_encoder: switch to shared elf_functions table"
is not necessary. Strictly speaking, patches 1,2,4 might not be necessary
as well, but could be viewed as a refactoring.
Switch to single-threaded BTF encoder significantly changes this patch-set.


