Return-Path: <bpf+bounces-20617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF68410BD
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4731C23D35
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE26F081;
	Mon, 29 Jan 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJR/o0zn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA096F07B
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549347; cv=none; b=nisU1BKDjgED9jr6loit34FIzrF4eEeakr9Pw/442pvuAdW4QPmCQJ5hEfdK0cpzXrlbEAivdJcrGt6bRvFA+kQumRlRQN5ONgungNU4fpk3Wgn3F652RIdWFoSkw7bS1X/9MVa8vsftRlRjqGtKZ0BcICGfs77ufpkCnaPOFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549347; c=relaxed/simple;
	bh=Q6Id3jagLpLYlvLTWqFHefcdhmHGt4X8XV1fntMghF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Higt8JyTfravX4aj90ydUZnlnSormfQDuPWfixKHYUllgO4EEhtpHha0220xuAeYonsWVDRLOwMNd7XYjsPSnGHoQEptMQsp3DcYqmou3xzNM5Ql/sOQyvjy+rCkjcK2JFqMvXKdcmBIRCUB0aqH+UKRO7VTnfZMRWALMDIMbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJR/o0zn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51117c00a69so241414e87.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706549344; x=1707154144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t8UbtVtGoBCVKS01c9nm+A6w/lihPALqHLmDm9CvtkM=;
        b=LJR/o0znMrE3/g9fnyQGpNGYNChq6UCmTO3uSKtzRu0U1YDE5YgaFFb2si0mBPPzC8
         udwghInDFbxQ39YpoGaeST9jv+iOjwBl7c58BxwzAkRRsPfan74PQdm0N26gJp2MPT0G
         g7qZBR16tjwoz+d27DD05VNOn712QdrZofrxgegsMJAJXA8uabMd+z5ThFp90zcXvm3U
         dHa+C9eJFUNOrEUDKXeyiT/MyA21nuQW5PiwFAUg4x1zCRvKpgu4KtC2yelERnXh8gEW
         prY1xpsH7GziA2sFSlJ5YEtQURdEc9TR2OXaLBFiopT53rRjrai24bie1puvdMREdWdB
         P4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549344; x=1707154144;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8UbtVtGoBCVKS01c9nm+A6w/lihPALqHLmDm9CvtkM=;
        b=sGwjS7dhFOTC9R6wJGY+Up5doQ2jAbbHhSm8qlrEJhoPoeZDTdHFno5/SfVDI/x9Ql
         hzv5uBN6qEqISBLUJEN9glaZVi3ARc1bcCklYEmN/w3T/UlgcNWe4UZqDlAOkF0nfeF9
         NsDEFKb5k7mud7FxP6DHXNsB2vzTRACvK4hYVMvnsbHz3EA8AWEQ/YgLnepvT/QG3Iwu
         3Zqw9w/i6vxaLmhQK4LFutFN7eNA045rQG6W/isefMC2nzZXQNoSHnCf2EOzLdKGu5rg
         xar/BvfOGnFDUAx8BDe6Vsvjcy2wQfy/pKcD0nbsgVmOJqz+eoXvRiueTXE4ZyVLn3bn
         6gKw==
X-Gm-Message-State: AOJu0YwxW5rvzVBzD4dtt0aMh20BXx8sOX/Lv6Kbbghhpd49nI0qcwPj
	ErfxvqXWvK4/m4APTdqIvVFg7f/myhA35+FAYWRoP39yNy2gMH67Nl5ctUr0
X-Google-Smtp-Source: AGHT+IHBnQxuCXZHAwtBQp8wrEa+4Gt3YmO+CuUyJ29uYnjGImxNbxObWJeKlQS4PLL+1Y21U1bQVw==
X-Received: by 2002:ac2:5319:0:b0:510:1620:939b with SMTP id c25-20020ac25319000000b005101620939bmr3961138lfh.0.1706549343770;
        Mon, 29 Jan 2024 09:29:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rg9-20020a1709076b8900b00a354e4d3449sm2811532ejc.120.2024.01.29.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:29:03 -0800 (PST)
Message-ID: <2f667db3222d10e229184661a052ff19c66f45c2.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/7] Trusted PTR_TO_BTF_ID arg support in
 global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Mon, 29 Jan 2024 19:29:01 +0200
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 12:55 -0800, Andrii Nakryiko wrote:
> This patch set follows recent changes that added btf_decl_tag-based argum=
ent
> annotation support for global subprogs. This time we add ability to pass
> PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprogra=
ms.
> We support explicitly trusted arguments only, for now.
>=20
> First three patches are preparatory. Patches #1 and #3 does post-BPF toke=
n
> code adjustments, to undo merge conflict avoidance measures. Patch #2 mak=
es
> PERF_EVENT type enforcement logic aligned with kernel-side logic.
>=20
> Patch #4 adds logic for arg:trusted tag support on the verifier side. Def=
ault
> semantic of such arguments is non-NULL, enforced on caller side. But patc=
h #5
> adds arg:maybe_null tag that can be combined with arg:trusted to make cal=
lee
> explicitly do the NULL check, which helps implement "optional" PTR_TO_BTF=
_ID
> arguments.
>=20
> Patch #6 adds libbpf-side __arg_trusted and __arg_maybe_null macros. Patc=
h #7
> adds a bunch of tests validating __arg_trusted in combination with
> __arg_maybe_null.
>=20
> v1->v2:
>   - added fix up to type enforcement changes, landed earlier;
>   - dropped bpf_core_cast() changes, will post them separately, as they n=
ow
>     are not used in added tests;
>   - dropped arg:untrusted support (Alexei);
>   - renamed arg:nullable to arg:maybe_null (Alexei);
>   - and also added task_struct___local flavor tests (Alexei).

Full patch-set looks good to me.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

