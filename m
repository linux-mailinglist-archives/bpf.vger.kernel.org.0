Return-Path: <bpf+bounces-37315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79193953D06
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BE31F260CA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CB1547C4;
	Thu, 15 Aug 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVxRQ6ll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D543153BED
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759159; cv=none; b=s6mGCiDMlUKP0N40bJO/tlV11xWdZ3mfXPhB+SdytbB7fjYCE/B+nQ5iITe39emLOZtm3yccQxbk1HTK/d3GYQTp3E6eGRZs8yD4TBc+QlLxThuWdayUjAz7aOn84hIohFvpL77OHpTmGhj9QaDy0IqSOss/xc0r8s7YIgwXbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759159; c=relaxed/simple;
	bh=ruXNFotkSTkyc1RS1cvrqutIxvb2MuwYhcOvO5cMXfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVjPxH7QAFHpYjAfltAyLwwB4VfdO1zcPbMA2kkhiIGksAmrZRjvwo0JH+igjDImoOHzbpFSfDQZbkOiuC+10l4t8dDEriZwdn5Reulvx1fLmQa0enpQYUue19wXoSgBcdPFjpFgmsYaGEaxGSafmqza54o/Xc83rsymbOMEsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVxRQ6ll; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so1063695a91.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759157; x=1724363957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5mi8F3sANVUfyidfH/XlSAladkWYu88QThXsFuklkI=;
        b=BVxRQ6llU5djAgDLtNaw94XwqvbF15ZkJcimeUQPXScTo23+hesyQkD31ZGDy6kv54
         C+i9yhAdZEpNzpAUXDoJYrAgFxSv/KhZ9bzwm6T/FVD45dAC48s2ZXIzWY2FpKWmz1NE
         1ZDKMPWZozGOTMshTFETrpt8TZuf8xGs8db5/m0MwpXDu4cUcqaZIjF9MQb+naAQqfy5
         V55TAjqz6mjFdx9bACNaA7m2ssIZKApFI/QTqNjl675q76T4t5IgkttStvMZnXoIagcW
         dd0ggCMzBi6nO73E3lXqsjQpb1yOh4VSGy0UL4WSOyGsjpFGzWwPRn7sdPQBUyJtTyj1
         DbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759157; x=1724363957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5mi8F3sANVUfyidfH/XlSAladkWYu88QThXsFuklkI=;
        b=qIy0vo7X+tp7JPzcxVNB9mlIrA2LRrsLtvGUknxLbrT9LPCjD5XNhLEAtFFCzm8O4J
         4QPmjewKzoLiPqGtrqJshu8GXuH6P5ynQHW1S4U3pdGz6ZfEGfm6xXTSND6O+aSX4rZ7
         yseEr9ZGe/mbO7CD93eDrB0EYyhb9Wgn1T82SUwutgxE5F7GP+j5iU0IwCAXUoAA28PT
         Q1tmHyQiP40ZbDUV4KGuSkKrZwV4CBMdgDuDr9zR+0BO1cKsNSh+eLFD4erfvSYQ3TXn
         OoggfkgqEnpq7e8K5uYR4Z5DkkbHO5UvkpqaSM1TFR3aJmnOJDsQRaHE/iFQb9FDf8T0
         tbRg==
X-Gm-Message-State: AOJu0YwMvT7MWbGRLgmh5GWBfCTCyA39/fP5jPPVqSluN+/1zGrrDh5G
	AOzQ7ZBIJqXLpO694J7QXF3K8GgGmzbIQ37uKcVtVnHXSUNwIWn3
X-Google-Smtp-Source: AGHT+IETn/SVS5E25dbxbkTY5aZc4NpjEC513l+9CSVLr2wc8nWsAhMbmTrVWq9ybQVSu+EbDTNdbg==
X-Received: by 2002:a17:90a:c38e:b0:2d2:453:12cb with SMTP id 98e67ed59e1d1-2d3dfc1f571mr1165579a91.2.1723759157297;
        Thu, 15 Aug 2024 14:59:17 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b64e7bsm316912a91.9.2024.08.15.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:59:16 -0700 (PDT)
Message-ID: <444747beeb37eed1b173bb2fcb9077eaf543e50f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: mark bpf_cast_to_kern_ctx and
 bpf_rdonly_cast as KF_NOCSR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 15 Aug 2024 14:59:12 -0700
In-Reply-To: <CAEf4BzZDvYEB-qF75vpMbbYLN9rFiTegBsxBXvMxq-UsbANRaQ@mail.gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-3-eddyz87@gmail.com>
	 <CAEf4BzZDvYEB-qF75vpMbbYLN9rFiTegBsxBXvMxq-UsbANRaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:25 -0700, Andrii Nakryiko wrote:
> On Mon, Aug 12, 2024 at 4:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
> > by a single instruction "r0 =3D r1". This clearly follows nocsr contrac=
t.
> > Mark these two functions as KF_NOCSR, in order to use them in
> > selftests checking KF_NOCSR behaviour for kfuncs.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/helpers.c  | 4 ++--
> >  kernel/bpf/verifier.c | 3 ++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> Isn't it now "bpf fastcall" and not "nocsr"? Shouldn't the flag and
> verifier code reflect this updated terminology?

Here is a pull request for LLVM that lands the feature under
the new bpf_fastcall name: https://github.com/llvm/llvm-project/pull/101228
I hope that it would be approved today or tomorrow (more like tomorrow).

Kernel side uses NOCSR in all places.
I can add a first patch to the series, renaming all NOCSR to bpf_fastcall,
now that it looks like llvm upstream won't object the name.

[...]


