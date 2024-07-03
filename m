Return-Path: <bpf+bounces-33821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E0926B0A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513641F22025
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC5191F74;
	Wed,  3 Jul 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUkyZnX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135D1E49F
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043849; cv=none; b=KNd9OWOzSEto77LNywugCszAQb3hDnB1pTp7M8/yAEW8o7PMvRIqSV/Y1IwB3iG5PjtIvzPyg8cjdTTuaY8OwG5CuuldEnijIf+mz/ZxkaZ4gkz5tH/qe19xx4HxI5RCeW5HAnUO/n1D/Po4DvKhUrtZHsEt3KzLeoV6dv992GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043849; c=relaxed/simple;
	bh=qgO09+nZ146TzL1QpgSmwrBrFcZkFg/bvNVTaNHpbNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3PqTKFITn/eXieQU1XzHNwuhECdy8lp3N6fgH9bu4qvWJbdHybaUjVTnE/LThC/5l69aJEf6eoSMfUZYP/PmAeYdHvcROcHvmCtrBV9y7eYpCui1/B6VsrJSNuUzyFwo3QzNPZ9f8PBgQgx1sNYNHZm5n1m2hPLzX9Xg7OaqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUkyZnX0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25d634c5907so23855fac.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043847; x=1720648647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgO09+nZ146TzL1QpgSmwrBrFcZkFg/bvNVTaNHpbNc=;
        b=GUkyZnX0RcyxzamsEmcgrwlUfiOkKG/TgChsuFVLYzVCaeRCVTcgj5hG1Clt13CKhb
         YxgrT2fMV+/XF6zvz484zfvAP7b/O5rAAh5kefLsLAD/tB+q5nHG6vaJUA4AT2Jeyp0w
         ae19wclQiIArV4OrurokfkQoC2JDuZwd6j6HgsNaTtJp2KQ4SSIng5WgrLFbL1lkbDtQ
         +fFBRBZDtYfnLuBgY/N3b0SrtiXUbDAuu4Y8m71YuQ4F2mKmFYyR9csXJbTd4MwVgRlb
         rzpo1U6fn1hPYKSKe2xwxJ2lQur5PG/J5Xo9Q7N5hlZziIaHTgY7tVNeLIWpmlolWpXz
         dsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043847; x=1720648647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgO09+nZ146TzL1QpgSmwrBrFcZkFg/bvNVTaNHpbNc=;
        b=ZnqXE2STgaAx8HXUq5RoVrhH4yXGQmKwKLu84bAP37vRBWY051Odf/OAXuqtxi6qOT
         shsKDB4Uw70auFlg44eDftM9SxeZs1bthbNK1QlA/yfn5jHBnm11Ou46sfmQ/iEO8Uoe
         tXyVRB3Hv84AFXzamQdBooU25dVBNcgIGTGeW7uqEVNjI2KEwPdmT4UX42MSaNrZhuaf
         YOQNo8c4TMXae87c5btM8l7jdfT8f0JcxEvO1P6gC11ymeWqr9VpbmxzBKy/bVYi/xsg
         Tr1TCAIEnyqRveg9g4iTA+DvmYbDTiAg8VnRtXM0bwSvoDelKXZEcOwSTxx8EMLFYC+6
         6wug==
X-Forwarded-Encrypted: i=1; AJvYcCVrCNhOIFxkNKzsKb0RvnOiewz+eAQMkYjJMgDpgWv0eN5Z5y/qXkJaQBwtFDQEjl3DCX1//nLMkcDlum7ojzvvQ0yf
X-Gm-Message-State: AOJu0YxNctDwEcR0FXdFPsg/TEqPKDi1hAw6g8qFD985H65FPM4AXRRB
	32d4PMruwyEtC7/rV9Ab2D3cHP6d5A1qsuL56ABG02aLeVGDp4/4iLG9Jxod13YI6ben3RjuZwe
	AAv63RZlYbQsRaErwAaIBGuHTFE4=
X-Google-Smtp-Source: AGHT+IFcXlSo9X1sMbNJDPngYmbM1XFlpSXXNv8zKnlVwEN2Jrbr4ZCAgXyXCHpVg2LH1QwbFY4E42/GCYN4gV2SGXg=
X-Received: by 2002:a05:6870:b494:b0:259:8bf1:9982 with SMTP id
 586e51a60fabf-25db35dc758mr11220804fac.52.1720043846971; Wed, 03 Jul 2024
 14:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFrM9zsE6Y_uScQyT0XoKy_XpP2JvFu1TSJzrYuA8puejzjGRQ@mail.gmail.com>
In-Reply-To: <CAFrM9zsE6Y_uScQyT0XoKy_XpP2JvFu1TSJzrYuA8puejzjGRQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:57:14 -0700
Message-ID: <CAEf4BzY4Lz7TisvPbyWvRow4viuQvcSEc+d1BVx74nSmVRX-fA@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: Totoro W <tw19881113@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:16=E2=80=AFAM Totoro W <tw19881113@gmail.com> wrot=
e:
>
> More background about Zig. The reason that a structure name is like a
> function call is due to Zig's comptime feature.
> The actual type could be generated in the compilation time and Zig
> toolchain will evaluate them during that time.
>

So, first of all, I'm not sure whether the BPF verifier being so
strict about BTF names is necessary, but I haven't thought a lot about
that. Just pointing out I myself wouldn't object lifting any kind of
restriction there, in principle.

But then for the Zig naming thing. Doesn't Zig have some sort of
mangling schema, like C++ or Rust do? Would it make sense to store
mangled names in BTF then?

