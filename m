Return-Path: <bpf+bounces-16695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F880457B
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F2AB20BE6
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A026AB6;
	Tue,  5 Dec 2023 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6qTE+4a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAEBF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 19:08:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so29749295e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 19:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701745679; x=1702350479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBfiXNTAHegvEN9OGbE83/Pt9vb6LHcEkO/Mk8Wcjgg=;
        b=J6qTE+4agtQHrdWKOLXBKbzHc3Nvn3ddqcNsmIsm85DSPCLeyGZAnJKAhhld3Jssop
         MIL0P0QgXtzR0MqE+wQ2VgE3jvDT3xefFesfWjh4hIiGJKz50ESrCJX21AgHfBhZ7dNZ
         ksvNBdzw64+BDyP49lzV/XSmdsLUTgCPBolPbDpLBw4qSkmS/+Um2LZZUQRhPirzNzds
         Gq/Tqz0rxH1nR+jKHWwpxIQrotjOJrXtC+hwjn33PRA3Y54ZlHOqtHCmaC3i/OIUsuC2
         oM/KLo4j32ofoixDkImO9hbm0XvTgfIunVIepx1sT9/73aYN0QXmwM9u1UWyGmpY4Gre
         GEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745679; x=1702350479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBfiXNTAHegvEN9OGbE83/Pt9vb6LHcEkO/Mk8Wcjgg=;
        b=W5mUwfUgcr/yB01OI9l2WoGpIxLVF9EERsMzAGbSRvJHtv7Y1D4meLdLYvmVCaHXKd
         9AM7F//SEAd97Zoqi3iKiLz677SZXjNLZxgE9i165SglTV3Vp0vNwi9ij6hGeCgt6BBR
         8CU5w4fAL3ll163lBMJbP1MJX997HdlN7mn/Mt9VYNqnGlXisOs0xJb0HQlYz87TZabX
         NvE8RyMEQBKt3yXfOL5XlhGM+lK1CzZTF55V6tlrW4l+ZdrX3+0EeBVhCKRlvh+TCuJE
         rxfh/JDHI4D8PWSFXKqrA1+NN3KnFHsR+jQA2grZqIe1W6Zu/CZU2N28B4HlaBdlvrcx
         xH0g==
X-Gm-Message-State: AOJu0YwCejnDjWdD+jP8ElzDG4hu7ldG+y9jHT3x7DCXJYpIQAkTWlAQ
	+sUsqLWojNo4UW+zO5E4U8Ao7ZSYXtQ2Wtx+3XMVeOLx
X-Google-Smtp-Source: AGHT+IF7hbTLC/Z/GRmLgDMul2trYRe2j59SJ5tefkHja2LhBXZkiwuPWo4u79Dw+mwRyYjyCn5n0orqj8wbqCKlTxU=
X-Received: by 2002:a05:600c:3056:b0:40b:5e59:f743 with SMTP id
 n22-20020a05600c305600b0040b5e59f743mr1678738wmh.181.1701745678901; Mon, 04
 Dec 2023 19:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113141207.1459002-1-houtao@huaweicloud.com> <b02930cf-9e0f-a842-1031-bbf8b948bfdf@huaweicloud.com>
In-Reply-To: <b02930cf-9e0f-a842-1031-bbf8b948bfdf@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 19:07:47 -0800
Message-ID: <CAADnVQ+aMzXONC7orvUXytNBSQH-T1RDR_K2YDLd2AMY0jaYtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:37=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> ping ?

Please resubmit.

