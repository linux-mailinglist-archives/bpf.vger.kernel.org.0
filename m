Return-Path: <bpf+bounces-71227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713BBEAE42
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E38EA588631
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39BE2BE7CC;
	Fri, 17 Oct 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHxhV5TA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63922BEFF1
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719149; cv=none; b=EwIlo1D/yT7FqLrA26YfVKP7uJmz6UvPR3LiH81nMH5ILUXgxC6tLfJnXdnx8TYI7UFzQVVgKlFKCziuxajYj8Bj3fTweb4cpk5pDWVm+/Fgt9NsZIuwun25V3HsRVsyruxb35cxP7tuuHhRIjq0uKCaO8K4l6iLabLLuaXP/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719149; c=relaxed/simple;
	bh=97XYlrfPPPA7pnAqGbv+sCxS9B2VLhK7sUi4Yt5EBjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg5L5vH7enweGshWkFKKNvajzKCAeJ2W5NAJGfyld4UT9ufMcHmI7xm0hX6RpxUxFGqyx7uoWxJ/lmPL7dtDECguze21sWm4ODhNyq+pSl8G7NfSEislh9ZiKgbA7eFOhf+I+PJx7cM7GvQ0wdcl10ieNH8yQSkOJ3ytvpJZ9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHxhV5TA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7501c24a731so26623797b3.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719145; x=1761323945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97XYlrfPPPA7pnAqGbv+sCxS9B2VLhK7sUi4Yt5EBjQ=;
        b=LHxhV5TAP2kVXGJs4GlrbJT7AoDoQ0dVd9kHOHEP3pEc3tRujHq1cmBArDtcFsz1SO
         J3kOUYr3e6Ccu0fIhZewO+8bHZ2rP9byOK6wvC4RpuaJ3zFsL1ALZguHh86m2lyuTeOb
         Wt9y7etXQ7ym6zjJfhy4ZiuCVruS3rOuc2vwFKAoNMtHZJNCZ68D5sv17xo/gwbB28WW
         cC3ItkBUlNI4OfoNbHy8+DgEkUPV6VFknwjHmxT0wsKfqXw1rO5mkIshm5sn6qitTXrI
         kBuPrCblU5VpgNnI1Sn9OirgSpt94Bc2F7Xjdmx/QO7h8jsNBUz+UFWaf6+/wGd0W9mg
         n3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719145; x=1761323945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97XYlrfPPPA7pnAqGbv+sCxS9B2VLhK7sUi4Yt5EBjQ=;
        b=aZM16gNCWyWBkryFoue8EsSqBSVUk+BWmsarb2E/eqYz/c2pmGXspKwgnxctlI+ksj
         LyzJf0oPdjPACXuOdouTvrxiwf5UP9dtFpEgyppIFqxptF2igjO4YgLFirWho1SML8Fr
         lAqu0vTu4ptitg2M97oC58ImcuUSpt6jYJj4U2UZiKcI7ZPCh/rc7/toOdldFarcEIth
         5BxZFijFkPKAFG/FmqeZpqlmAZ7M/xh+so8arHbODmESnwVIDh5d7VBmzotf4j8Eh9W6
         W/sTjYRwhU2pBAbXgai24RWeY7qgyQNAxc8ru+C5bM4TOC1bEvl4oSl53w14u9c+DhpL
         qMrw==
X-Forwarded-Encrypted: i=1; AJvYcCWDqPCk9ew7JzT1oSsV0BYDtqVp3eDbksx4XJ9ZPXvzG1+RvmvMu2s7Dtqlk1z2hcQ8ahE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9uPHGa47pQoPw5AtzuyMb0iUPvLR+pUIL/kUvPaZ6Exn/++8
	K5pYpkDzYDaCxxIuvUMMR31WaYhxcPwRF6dhl1ZerhrZqoxPRj7dj2IMBcMs9gU4rhtDzKGRZ36
	X4AuHBZFZ0hDvIoZQSCgPlbpwp0fP0DU=
X-Gm-Gg: ASbGncvNNj4Yc9yOLW5/jaf8+FabucvdK6eOsS668eTPOA6f1T+F4It9ZTqJkAZ0CX1
	ZCUpwvNYV9iqhDtVyENCRZ0X4loZebz0tSv3GOzK1qBJN9ZrbK7BrKyz49u7MM9Vq1x5ov7GLu2
	W2eDQ0evYd/YhwQ4iSUp6DMgGl/Ijfwyj153UesdSV/f8mYz7ZhfAR4I9+MabcToSoP+0cIayeK
	urzI7QMJ63xmRaA4wLoitippfTPCfxUvpTBvkSIie9iEZ2cPdbg00BYIZBZ
X-Google-Smtp-Source: AGHT+IGbF6Or7zlWoTGIZ3h/T94KL+7kZLzqMPfqm7CoucFcvNehwFJ6VWsVmkFUfXKEHkC2JdQO2xKHcy1NPY44Rw8=
X-Received: by 2002:a05:690e:d50:b0:636:1fd9:d64c with SMTP id
 956f58d0204a3-63e161763ffmr3546513d50.8.1760719144583; Fri, 17 Oct 2025
 09:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016204503.3203690-1-ameryhung@gmail.com> <20251016204503.3203690-3-ameryhung@gmail.com>
 <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev>
In-Reply-To: <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 17 Oct 2025 09:38:53 -0700
X-Gm-Features: AS18NWAw3Wa9xG7OOim-ssXyDjv46PnkgVJRXa0CnpA0NmMXrefKEagBOxvLPI0
Message-ID: <CAMB2axO9GN=EMK2uLxqDLFkNk-V8sA7Rdb9LH3u6xx7fpCTyRA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 10/16/25 1:45 PM, Amery Hung wrote:
> > Each associated programs except struct_ops programs of the map will tak=
e
> > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set=
,
> > is always valid. However, it is not guaranteed whether the map members
> > are fully updated nor is it attached or not. For example, a BPF program
> > can be associated with a struct_ops map before map_update. The
>
> Forgot to ask this, should it at least ensure the map is fully updated
> or it does not help in the use case?

It makes sense and is necessary. Originally, I thought we don't need
to make any promise about the state of the map since the struct_ops
implementers have to track the state of the struct_ops themselves
anyways. However, checking the state stored in kdata that may be
incomplete does not look right.

I will only return kdata from bpf_prog_get_assoc_struct_ops () when
kvalue->common.state =3D=3D READY or INUSE.

If tracking the state in struct_ops kdata is overly complicated for
struct_ops implementers, then we might need to consider changing the
associated struct_ops from map to link.

>
> > struct_ops implementer will be responsible for maintaining and checking
> > the state of the associated struct_ops map before accessing it.
>

