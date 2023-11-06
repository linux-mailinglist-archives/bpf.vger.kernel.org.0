Return-Path: <bpf+bounces-14300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750587E2AE1
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC5B281511
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6429D00;
	Mon,  6 Nov 2023 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwIwIdXi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9672942A
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 17:22:54 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFDCB0
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 09:22:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa071d100so96039517b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699291372; x=1699896172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVO4sAOUldvg+TEp1bCwrL1tOOGvg0o40qn6OCIZC8=;
        b=VwIwIdXiX+TLbRGw0UvGHUurRaoakukQMkmKW74P0yPY+xlXzMEXWWiOEO9lIGg7hw
         grnI/qVl46gvJd/TOut+dB8kdOwu0fjYs24gQdoYWddP/fXLvS6w7fz8ea9N8Q/3avpi
         1lsqd+3akYpQ4VPgENRbzYLe44b4oupSWrNcvX388tszuJMfeepWAYkP07cenkoS72ui
         vt2y285MhnSyIEYejGXhD6/vZ61OO0ueVpS5YgQ7davB3gMo1VybB56EGtz8iadrl1bB
         FRTtV4sVheNFuqf1wi0cEVW+BgANYhxyz56dUR81/FIfbuLMjRtyTceZcfz00SKpqr6z
         IDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291372; x=1699896172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVO4sAOUldvg+TEp1bCwrL1tOOGvg0o40qn6OCIZC8=;
        b=bPXgkDDhWbNFAZTwXeb/FWeTfCgyb+e8p9qwUor3pE6aJMEYzKg6a48dRAyDPqgaQ5
         eZLpOJsoA0ycGAQYboJ4Fkz001NisjtuNNLU42ysIseNTWmn72HPTCMT95iHqI7K6966
         miFYuwfd54xcxAtpLBaod87BG9Md07eoG4GdUEqfHqEYgB3WLVcCwKT0VB8jKU6d6QvL
         ABMieB4VUlfv5E+ESe8LPk/pwSykPnliYZvYcZmc7LeRDUwZ5Q74GmUpHLQ08qVL+26r
         iMbCtfksyH/p4BE94hiOwzEOzqsJd58owgHCVITgVkOHdZXr8xjsox8fdns+a8ZUM30e
         ADRw==
X-Gm-Message-State: AOJu0YxxwnVPq1fIF+jZrr23qBkQghfd+IAVZIbxMJih/ON9H8puvs1a
	bzMT1ThNFQLpl60mqt4wxQw7C3I=
X-Google-Smtp-Source: AGHT+IEVyhpt7fUPpfetx4DKqxAPIdrCZ9TLvPSLhdEldLH64LuoQvzQ4YdpQ+DKn+WedQWV80lSuck=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4f12:0:b0:59b:ebe0:9fcd with SMTP id
 d18-20020a814f12000000b0059bebe09fcdmr202804ywb.7.1699291372467; Mon, 06 Nov
 2023 09:22:52 -0800 (PST)
Date: Mon, 6 Nov 2023 09:22:50 -0800
In-Reply-To: <20231103222748.12551-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103222748.12551-1-daniel@iogearbox.net>
Message-ID: <ZUkg6rkp0bGz7Fkt@google.com>
Subject: Re: [PATCH bpf 0/6] bpf_redirect_peer fixes
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/03, Daniel Borkmann wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> Daniel Borkmann (4):
>   netkit: Add tstats per-CPU traffic counters
>   bpf, netkit: Add indirect call wrapper for fetching peer dev
>   selftests/bpf: De-veth-ize the tc_redirect test case
>   selftests/bpf: Add netkit to tc_redirect selftest
> 
> Peilin Ye (2):
>   veth: Use tstats per-CPU traffic counters
>   bpf: Fix dev's rx stats for bpf_redirect_peer traffic

Acked-by: Stanislav Fomichev <sdf@google.com>

With one optional nit about indirect call.

