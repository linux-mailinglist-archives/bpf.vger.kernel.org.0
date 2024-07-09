Return-Path: <bpf+bounces-34211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DF92B3A0
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2081C21F00
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149431552F5;
	Tue,  9 Jul 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9J5cey7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF2154BE0;
	Tue,  9 Jul 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517001; cv=none; b=KVs91YidCW74O/XOBLgkhZDUdKFhF9ILJ/LErJayId7LSn2O15PbgUJmgVIpXBbjLoTNmW7/Ovd6sQgNjyTRTTDsIv+tSVXSajc0o9RU30XWkHDN9aixgFQW9FNAtyxhbeBIfst8NMImtuMT1zh/lSPyI99AFAYxQdLMg8lopvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517001; c=relaxed/simple;
	bh=gL3UbFjJe1IWH4tlBHletviXN5EpoqVoA1JKkBjrMLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDqIdC1nS0GiLRIZA8FBXBZG8HvLAX1T3e7nwUjwH9FDbF3MFzydZYosJRQbli15aVUGlEnXWtwbAS2MKFAghInX+KCXmpNGCwrfjA220TwdonCD33jLVO0HTxSh8BbG32WtNxHJ/qVTVCuzTNg1GNoosT187QnI7nxDDEwLwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9J5cey7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-446654617f8so1771341cf.3;
        Tue, 09 Jul 2024 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720516999; x=1721121799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u+IB7H3a9ahn1e0BjbmW8xDTsOIOiquV1t1pK9fhKvE=;
        b=N9J5cey7Q1DqgpwhRnmsdLmfQyXiN9z4Twivbh0oqrMu8X6ZlKu7UF2tBhThfTTfUd
         /QXmBHvNnONCOutbIXs9mPmWG5YGP4HxplBffGNXm7b2nrSlz+GzfObBEcVl/ZEa3MRP
         rYaPKjjVNmk6K0lajONjt7n8SLHYU29xrwLfylDJbkhvnW0FxUCtnQY6Az/voCWRXvcK
         9YYNOnb0mZGNkWoagXQDbCclnurgyoDGU9sf7faHSV0N2/lWa89j9buK+H/a5AhZxid0
         WZPGGACvjDgwfoU+/b4Ykiq11Rli8XjSznJCcQQy0KTuSF26QbrFX6B3JF8+V+WCGm81
         ZCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720516999; x=1721121799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+IB7H3a9ahn1e0BjbmW8xDTsOIOiquV1t1pK9fhKvE=;
        b=kspHYfRACmdnqm5sG8qZ70aDEMnAr0dQSUa7rGHgaN6nIbjJgx4Yo/+x0543ocAV5I
         r5wnslM3hQcLjcB+v9960WqF5OZ1Yxz3nxKfKHrKgvqjhTU51WJ07Pd7TTcjP8hNwWpb
         LPvA8kHdJYa38NXjwOANUswOOplrup4b3SdkJpGyV1nYeL2/ZQUKRkR3TezAYp83fG7O
         1MU1v7lN61dIr86/Zu8clXxy4j6o82Of7ldVnekPUlPIDfqW3WC42y0ccNNVCGmIQUnh
         /CMku8vr4J2BC7a3gGFyF5/hF+UnmS2SVhanDp10CXu5SQSqZuvj8COqVIozqeq9gcwH
         KRdw==
X-Forwarded-Encrypted: i=1; AJvYcCWtYZkHC3oFgqrIxLmr7PeZKsvOrndWFXWPtTzM+7lsFC/bS4DDoI7hgDAxsyUws4WDLTy7A6FOq5O83JdLfhznbGTCaUyT
X-Gm-Message-State: AOJu0Yydiqguh4IVd1yjIUD0VAebgLy9awQwPMpR2XxqCnUlmyVBa/hE
	37lADjHmVMuerSik/iLnYxS1coIyXPM6t008tg2LNbd1b9JZuVbJZaP44W+UOTJ1BGRkAZzbTdj
	Fdemz+BclRI/WZztTwqJlDcls9HiPfmhNDnxxrg==
X-Google-Smtp-Source: AGHT+IGBe7xsI82jVqQDroZhlI0ftBglhsQWHCjoICqMmX+krbPU5b+HhdtdBHC9RzU2nKFIeDLYh4qLl9YVfj+ZbVo=
X-Received: by 2002:a0c:f752:0:b0:6b5:600:acc8 with SMTP id
 6a1803df08f44-6b61bc7fa26mr21754276d6.1.1720516998911; Tue, 09 Jul 2024
 02:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
In-Reply-To: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 9 Jul 2024 11:23:07 +0200
Message-ID: <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
To: Julian Schindel <mail@arctic-alpaca.de>
Cc: bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
>
> Hi,
>
> I hope this is the correct way to ask about this issue, I haven't used
> the kernel mailing list before.
>
> Between different compilations of an AF_XDP project, I encountered
> "random" EINVAL errors when calling setsockopt XDP_UMEM_REG with the
> same parameter.
>
> I think this might be caused by this patch:
> https://lore.kernel.org/all/20231127190319.1190813-2-sdf@google.com/
> It added "tx_metadata_len" to the "xdp_umem_reg" struct.
> In the  "xsk_setsockopt" code in xdp/xsk.c, the provided "optlen" is
> checked against the length of "xdp_umem_reg_v2" and "xdp_umem_reg" to
> check which version of "xdp_umem_reg", the user supplied.
>
> At least on my machine (x86_64, Fedora 40, 6.9.7), these two structs
> have the same size (32 bytes) due to the compiler adding padding to
> "xdp_umem_reg_v2". This means if the user supplies "xdp_umem_reg_v2", it
> is falsely treated as "xdp_umem_reg".
>
> I'm not sure whether there is some implicit struct packing happening or
> whether this is indeed a bug.

Thank you for reporting this Julian. This seems to be a bug. If I
check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
on my system, compiling with gcc 11.4. I am not a compiler guy so do
not know what the rules are for padding structs, but I read the
following from [0]:

"Pad the entire struct to a multiple of 64-bits if the structure
contains 64-bit types - the structure size will otherwise differ on
32-bit versus 64-bit. Having a different structure size hurts when
passing arrays of structures to the kernel, or if the kernel checks
the structure size, which e.g. the drm core does."

I compiled for 64-bits and I believe you did too, but we still get
this padding. What is sizeof(struct xdp_umem_reg) for you before the
patch that added tx_metadata_len?

[0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html

> Best regards,
> Julian
>
>

