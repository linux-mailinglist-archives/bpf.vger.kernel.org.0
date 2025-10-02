Return-Path: <bpf+bounces-70178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B3BB2335
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 03:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C13B2E13
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB12EAE3;
	Thu,  2 Oct 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0IU2CV5s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644CDF59
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366974; cv=none; b=VIjOwHdB2YY1k0/4lj586UiDZAlKjq6UbxSNQPUfM32U1rN4Ru/jtBV0RmkYjkXNS2pCWbUb0gB8EpmBzQ53kn5HWSTrVK12SqYk+Lp5gI+dYZ6H/ZqbXHGobVKt1V0uQeYkNxNz6OuEfCbywXk1YVwBjjMsZo3D8fuFZBEvVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366974; c=relaxed/simple;
	bh=fJCwtgPNSFcKZik/xWzuJ2Nl9DLm4510nRoTtppN+sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDyR1gTqfQyVlS3QXEdJP/5R8WS0C3wdpwTugQ1UzsO8VbVJGY0hxE8LHwSg84ndwNiMin1CKAgSlRqT6uZxGsQ2w8Fr3vl/RuaPqcYlOxYvARcuMlUzhWSqwIX+LUjtSs5Otwzb7/pJZo1nhbhS176+AZthMKv2gWCw7mFcNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0IU2CV5s; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso64041cf.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759366972; x=1759971772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBSLRY4fID/cBiXqIe6h5ynAijHxdNPdDw4ZDrWAVg0=;
        b=0IU2CV5sj5hPfnBH2FVtwOIbgIdQUoYdtcCFPwpBrJ10zV/5kuT72lUi+fx/SrJPv6
         Kswxx202dz+07bb2iSREeC2PVRfT0XHW+tYTs7Y+YLnkWrsCmwcJqoiDQOWpuz+GhbjJ
         6m184GmROfBvUVBj4FhfwMkA2ZbEJmEwAcDAmO5VF4OSMROCXCIywjqApxYBvOXPuatL
         lQEcrn1RI8Rl4e61tKFu/29JIAhk828YPDSTuNBRGFEt/o2HuF94YmGIF53f3lTvmeD/
         hxbCkoHBJ5nN6TVmJ3yiOPsbyP4RMJ3UZ+O+z2Q4m7e4EpYmVasgNhZaodb68380hY6o
         CzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366972; x=1759971772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBSLRY4fID/cBiXqIe6h5ynAijHxdNPdDw4ZDrWAVg0=;
        b=ics0wVpZewZWhA4hfVjMgDgpJw1jGgFSln5x2cA+2+3wOPLQoY/0EO72FqfyqY1Iz1
         15KHUsG6xP+kLj6zFzFa39My+YGd+J/7qwrtzTYD6QhJaT2AOLxYlMWvd7X7qnO1+cL4
         VCiC7IINPhhTf0oolXqpF/4Or9leX4W8bdQwNypOiwQLuo+zDM9ZPtfpQXXFaiUs0i72
         5Eq1vP8iVHe4jM/xoB/9DUjaOzWi/DMHfySaZfbHocUi3cSmVGpj9GppAH7wa/Osb6HV
         nsDGJD7m+GwHIscfXsp+5BfM2sc/enhCy/sxfPTq97nB/ZtM4nSDofzRbHSJP/W42bNv
         Lx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVE/KHlkZ0Cv/0WdtV44/YKTrcN3JcJ6GYksmuOisXcwVVUwMgrB/UrQZ/AJYVJJ7ZIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RUoEDEBDtyPvvOrGji0Ddfrf9yIu0vUhWeSbkaeP6jdCnW1F
	LEMK4hIxm/l/OxL8pvuNUyvpOEixRLsdX9wtNz44MSmQTvRALdbnUaZ19Lp49NNFXqynyVR5Hql
	lowVpVS/+60M+BcBzXtXrHsJzlGzFdzUAVfcfCLNX
X-Gm-Gg: ASbGncvtv8+qpzTf6KunJnawK7BccQ2acuVwiHqcEniEqcXIYnccVbeCX+BgkWwPnyn
	KTlIJv8oTI2e3WSzwU/x7ll6c3Yes19cJio/MnvaXKvIxcVVpO4ayDIiX9YvaGN1wmxx5saGwTO
	gsNDZ2DCG5Pm4eafNQZX1VNsbcj/IW/sFHGsEs4F4RH/7BwCKkix35LpWst6EPZYzXESuQyGXwn
	lkOYa2Tm0NGW4UWGB+XwoWYMeUXyOQH9WbGjOtqra7l4yee23MFamTGQGbbXVyzZIom1KY=
X-Google-Smtp-Source: AGHT+IFKtuOO3BtBnInFtghLuT5oaAytbfqlQqxfSONe+I5mErf4jp5CofBK43lV+XX895cBXqbbRtKUWjZVcfWVw4Q=
X-Received: by 2002:ac8:5d0b:0:b0:4b4:979d:8764 with SMTP id
 d75a77b69052e-4e56c85df41mr1485761cf.19.1759366971654; Wed, 01 Oct 2025
 18:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001074704.2817028-1-tavip@google.com> <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
In-Reply-To: <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 1 Oct 2025 18:02:40 -0700
X-Gm-Features: AS18NWDZeq6U-ZXXr8a17ILJl2kRgvXE7gR_7txM0W8s-hT-w__IrWCljO_KFB4
Message-ID: <CAGWr4cQ6g5xw_iJK2KbyTbSszsf2gacUZ9v0wKAVWnyBAYz9nA@mail.gmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:26=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Hi Octavian,
>

Hi Ihor,

> This patch seems to be causing a null pointer dereference.
> See a splat caught by BPF CI below.
>
> You might be able to reproduce with:
>
> cd tools/testing/selftests/bpf
> make test_progs
> # in kernel with this patch
> ./test_progs -t xdp_veth
>
> Reverting this commit mitigates the failure:
> https://github.com/linux-netdev/testing-bpf-ci/commit/9e1eab63cd1bcbe37e2=
05856f7ff7d1ad49669f5
>
> Could you please take a look?
>

Thanks for the report, it looks like dev needs to be set in
xdp_rxq_info. The following fix works me:

diff --git a/net/core/dev.c b/net/core/dev.c
index 365c43ffc9c1..85b52c28660b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5449,7 +5449,9 @@ int do_xdp_generic(const struct bpf_prog
*xdp_prog, struct sk_buff **pskb)
        struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;

        if (xdp_prog) {
-               struct xdp_rxq_info rxq =3D {};
+               struct xdp_rxq_info rxq =3D {
+                       .dev =3D (*pskb)->dev,
+               };
                struct xdp_buff xdp =3D {
                        .rxq =3D &rxq,
                };

But probably Maciej approach is better.

