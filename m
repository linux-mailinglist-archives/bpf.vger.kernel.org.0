Return-Path: <bpf+bounces-71946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18DEC02411
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA353A5AF3
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B9246BDE;
	Thu, 23 Oct 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Sx5V46"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769D245006
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234791; cv=none; b=q1cR0W+8YpE6aV3S/b6LB5997lG2vCcN7bbdMUUzV7r/lOv/B0WSdDOknH+g5iyf2XVcR+S+lUbSsJFxGj3vaQKIfUxED9CVbBEdOxDSNMpcSw8bWv7BQV3hyXa8nqZX8m/MdQsjToaXIlgG3nRdhOrnUZRo/wEUPvO+DTRAadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234791; c=relaxed/simple;
	bh=8YARU0Mc53mjXAXyXU5+DtiwbSIY+93yMyj7L6JyaJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru1Ylod1fGcGxH6jKedvpVVC4XcVRSLJzIeyTadVWSH/ojVg/so0aVZDoi29VZajy1DD/T2nTYzgvSzJzZhJ15GvxmG4JveAE+0wiK5blZpiMzhf5YFo5AvSWnvA0Su4/K1uc7YONHtY18JR51y9iIhhU8OhvFbBRTIkExcTaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Sx5V46; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so8326025e9.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234788; x=1761839588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xArOOzRNeee8Y5GZ9VW+Mc5iRqcYPNCt4ydjP08TiyA=;
        b=K/Sx5V4692eyz7CfF7BVrPLY61fN/cIEiAGySGZNoZTAUlEBT+DoPIpLylM8o/3CgU
         MYfwWrlD94VYzDO2VCEL/t0R33JWHz8hOv+92xjXosxCkfyFSAnkv2UwkWTMYipd1IRO
         50aXGOlHLYpdtj2VxIWzQob5oe3wN6LwqwjdEjTP5R2VRd0rumU4mumM39ROBqWpE0SK
         GWAUYX5MtlMqIgLsT2uiD0flbs6y/DXvwy1zcG+zFOsuOSVgtruKSJAdY2O8w0Bu2WNW
         gV1Tsfr3W16pArfufGbHXwpKRrxDpD4QHH99EQK4aMsyjgnfNx2hsSeaLm6qu1EFCZ2a
         nS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234788; x=1761839588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xArOOzRNeee8Y5GZ9VW+Mc5iRqcYPNCt4ydjP08TiyA=;
        b=qWRctOkzDDj7mpOcLdRX/bvnW9PmoIRq/10rMD3S3mmsqAc1TY+pxnIuVHsiQt4L0A
         V36KCPyYMF5QZKm0cFJ4JdK7UpHvy0+dfrtLf1fRhzafceyyrES3McGfd2OcYayMPuRq
         bO300vDfB/cKtZPveftB8wsxXaGn1qfdvT7fvP6oN3I7Zr4PbSIpHzjV8VqwriDU4iAH
         3xWbVkpguCdvEHFUOp59Leri3V13UhEbylEkvLlk5FXqKml25DdiRr8NsKgjdCZJ66j/
         zaEGhMWQBboEHOjYsbW9Z2lYPNwgdI0JaS3ohh8J7f6VWUfRjqlQdsy/DPWoFVDZslED
         nFpg==
X-Forwarded-Encrypted: i=1; AJvYcCU0F17KFjQihzpZRrBKNQFdbshPrIuFTMPIJvYgLrGP9T/Eh9ILaETGS4nFD/+AUGZF4RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNx/GfUwoYDV1LuWs27WkQm/X7QPVru3+LZyZGqF1yZ7RX43nK
	MxwGD9uCK4mZT/+DTXkz33NKKiwOv++ylaBme8FjVcRV2igBIBO3k3bC8SLQExEA3+cydPj3FBH
	9J3xYfjMWg9fmFJ/tcx8zjjmpdOt/eks=
X-Gm-Gg: ASbGncsd4+sRHECv4dXh+fw2aCgkVx3DJOTE+GXKNXD6ej00CzPvXy8Ibq1V7B0MQtM
	ZJuWVHHJ9HVRejxlq7V4JZI04WUFTW4mF1PcrAZPfOTQCAH3xghIDrAbFpDdoxhOAdL6LOgBDPE
	nKTdjJ3L0fYNfjuSxy4wXo4OqitqI3bnOgEGrAljcmekKPYkAtPROqziLITkiIb1OWBbxkAcxxs
	O/e3LCkSxzU+uoU4BuhnQDf2c6ZRpEerGANth4wEqvZnKcAbTcEusme+elyiw3Sh8Z08DL1e59E
	+vLQ9J/v4/E=
X-Google-Smtp-Source: AGHT+IFqNQRd6z8POrKG9gx/vtI8SjdpIQvfuAoFenw4t2LmMth8dsNK8tz5awLWR+F2TTPMKqUjdtFvfI/JaX9BjM4=
X-Received: by 2002:a05:600c:444d:b0:471:15bb:ad7f with SMTP id
 5b1f17b1804b1-471178b04cfmr164550255e9.17.1761234787683; Thu, 23 Oct 2025
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com> <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
In-Reply-To: <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 08:52:56 -0700
X-Gm-Features: AWmQ_bmOQJjLilSjL_d29tKIBtQHC3nGeFUO8NBl8n7PZYVtBGpyQskXLAHTveI
Message-ID: <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:35=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Thu, Oct 23, 2025 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> > > On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > > This patch implements sorting of BTF types by their kind and name=
,
> > > > > enabling the use of binary search for type lookups.
> > > > >
> > > > > To share logic between kernel and libbpf, a new btf_sort.c file i=
s
> > > > > introduced containing common sorting functionality.
> > > > >
> > > > > The sorting is performed during btf__dedup() when the new
> > > > > sort_by_kind_name option in btf_dedup_opts is enabled.
> > > >
> > > > Do we really need this option?  Dedup is free to rearrange btf type=
s
> > > > anyway, so why not sort always?  Is execution time a concern?
> > >
> > > The issue is that sorting changes the layout of BTF. Many existing se=
lftests
> > > rely on the current, non-sorted order for their validation checks. In=
troducing
> > > this as an optional feature first allows us to run it without immedia=
tely
> > > breaking the tests, giving us time to fix them incrementally.
> >
> > How many tests are we talking about?
> > The option is an API and it stays with us forever.
> > If the only justification for its existence is to avoid tests
> > modification, I don't think that's enough.
>
> I get your point, thanks. I wonder what others think?

+1 to Eduard's point.
No new flags please. Always sort.

Also I don't feel that sorting logic belongs in libbpf.
pahole needs to dedup first, apply extra filters, add extra BTFs.
At that point going back to libbpf and asking to sort seems odd.

