Return-Path: <bpf+bounces-21523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F5984E891
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54481F2F102
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A528DD2;
	Thu,  8 Feb 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaK+fd4F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8462032D
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418230; cv=none; b=qqHp76ivhW6so7poW2yxYaXOalvOx/QuCN6BVNgfnGbA9VJBM1ZxH3Thyv1boGsAXhaMWobuIqptrXaKJQATthFHQZZTEEr0L1RsSytayuPUBd+mRTovdoLhYiDhcAOOLT6nhwYRCzxqep/QmQogoBQpi1yKprCSR/EvMDKpT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418230; c=relaxed/simple;
	bh=UEt6P93iBzne7jj66ZtWbMY9Ynm54TWHWff9P4nKiKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TedTJ+IPQMBfsgJo3nfMJIFtFXePy8BH2OrtJgiK9sDOd4YuJiimC7ELnBdpZ6SpY9GlFYPPnX9jBc+zWlJSjBe4pM8Lk5gmVDTU/zV015nNEDL68hBvd5ehPQtTFQIUfiYc9HilX7AgvE2T0r5IE+cFcfx4Zatmj6TJEVVCHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaK+fd4F; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-295d22bd625so128860a91.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418229; x=1708023029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEt6P93iBzne7jj66ZtWbMY9Ynm54TWHWff9P4nKiKA=;
        b=QaK+fd4F831i/8sj9TPWblKMZXG/TRmEKKjKeu0E01zUAqV3cMd+2rLXyB5w/zAX/B
         mSARj/YRdadbbRcN2LUXGuFRR3kDA/RbsVu55F+V17SjIy6k/xuIlCosB1/EexoGQVDU
         HUY1Z3ZRg4KRdmVXca2VwSMyWB5Zkl/SXOYCUymRhAl6WvzPgty30gZAtFis71akrVpi
         9a6dKeSwetXLaDpPs0951Ur7D4spdpekCQ3vn66Gf5E59GHUI6MEFdv6w1+JYnGNV6Lc
         VWujrgGLuX4U+y+jvXXwy+pictDWCr7hmSQJZ4Xqa6zltAm/5Ju+3rHoRe8o0HyHoDfG
         wQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418229; x=1708023029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEt6P93iBzne7jj66ZtWbMY9Ynm54TWHWff9P4nKiKA=;
        b=USz48TvDfojl7TExVeeuZ3xVhEDphrPAZ4Y8pRevssWYb64v1qk9m3l/5K7ozVe+Tc
         a183jlbRSCWJNbl85LF/h2tQGpCS0i8k5xh/PX2+gVsoeHn6diwVZ88hVeU7f8hMBbwQ
         Joa5S+1Kc7IUV42ZStTHkOiwrnQrrqaz3OJZOGZ61BkCWdLVFBPagBUh+pcH/g5wHDcD
         wUE1JfHeRKU3HhXk2eLCKDH1RaMCdbHUwj0RVIbQF5kAv9ITVyIUonG7OAwHILQQJMWl
         MRFMcbapH+tqY+WQUp4h1LFJs7Dkso+gWgHLyAyvcd3Yx507iMd53OP+tWBEZDYObWql
         Lb3g==
X-Gm-Message-State: AOJu0YwFTjZm1bwHhhQ2dp65yZJXyVv0mRJtO1p6a9nlj6p3dJPHY0sQ
	tdL0rG88P/97vndqYgxJa8Tiqf8s1DmmgxF0q9Xp8y3S8yF6lftRtzTMORTsH04MggBUsK8RQRm
	dNM6WW3ytfpCUe44oUEsDf3BIZS4=
X-Google-Smtp-Source: AGHT+IHvMsdm6AlBQVwK3JE+NZ9k8Y3IiDAwkPLBORdGFTdL/nXC2j1wdq/D6OtCxSC1U8M2VwCGfA27g9wwMBYXWW0=
X-Received: by 2002:a17:90b:b04:b0:296:393d:a5fa with SMTP id
 bf4-20020a17090b0b0400b00296393da5famr164800pjb.1.1707418228546; Thu, 08 Feb
 2024 10:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v86z150o.fsf@oracle.com>
In-Reply-To: <87v86z150o.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:50:16 -0800
Message-ID: <CAEf4BzZ5=E+EFs4vccWr-NPpqHej915w-GQfhSG=F1RaAJXB-A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support to GCC in CORE macro definitions
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, david.faust@oracle.com, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:07=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Hi everyone,
>
> This is a patch to make CORE builtin macros work with builtin
> implementation within GCC.
>
> Looking forward to your comments.
>

Can you please repost it as a proper patch email, not as an attachment?

But generally speaking, is there any way to change/fix GCC to allow a
much more straightforward way to capture type, similar to how Clang
does it? I'm not a big fan of extern declarations and using per-file
__COUNTER__. Externs are globally visible and we can potentially run
into name conflicts because __COUNTER__ is not globally unique.

And just in general, it seems like this shouldn't require such acrobatics.

Jose, do you have any thoughts on this?

> Regards,
> Cupertino
>

