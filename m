Return-Path: <bpf+bounces-68438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED42B58690
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E6F3BBD65
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A6F2BF3F4;
	Mon, 15 Sep 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBnP2SsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694352BD022
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971202; cv=none; b=VHK1AIFD2OcQC+nBkhKTZM9wR14sGutTbHjzXZAckJhRFBfhv+B2zPAemaDiXoeoY0zT1VnZ4VfB+ENXyeMBoSq8bYJ1725YT6FNfFCpoM2CxP0lvVmph1XlbToADbi8NfZjepgqwYuZ1RMl45dycDlB5i8kehj3oqHf9h6CDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971202; c=relaxed/simple;
	bh=aBn7UxDV0vO6Vg3OQXD1w07tW+ibrkneu1OCmYOtdn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDD2lsW5r1HPLOUMBiGYMCH+hAOyvbWekWF268+b6C97Z1u1Es1nqe25MDM5yMz+LXkT0x4fAHQzcXqQlWq3pHzQuD1ebbsytFcCVnF4SmtNcO/2+9/fMhNAN8we4qrW3GxVlrFWCfGMu1Kbb/U/0xZ2nG4kBLcykRTtn/oP1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBnP2SsT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e34f4735eso1885500a91.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757971201; x=1758576001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aBn7UxDV0vO6Vg3OQXD1w07tW+ibrkneu1OCmYOtdn0=;
        b=WBnP2SsTxV8iQVEYim3+/tzlG0T9RY+zKa0C4vVgBKrjLJHL2ce4zz8JaAWVIF4FwS
         QyE09WgKfNREekdFLSxxqGu4Ev6gsqyrYsVP+smdcjIo4o1gopSC8JI5xCBTR3jpr1vx
         lxDJyXxm2x4Y87eq35Jkj1ZwpsM3tooNWG84VMxM7TDR2b5se6F4nJSDyQ/fKuh5UlXi
         E++eOpEvS7eae5BWoFxpYgnvoL0pxiEI0sPNQcqcY+Yo+2t82a1/QYIdWhV00dpM3yTk
         xRVUSNwdudmqY5DdstuB4ujlyNLIWsSsA+sAOZJXz9+T5nKC0Af/IaK3UIpXhA1EUTOz
         AlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971201; x=1758576001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBn7UxDV0vO6Vg3OQXD1w07tW+ibrkneu1OCmYOtdn0=;
        b=hfO0ZS5PBWxMi9dRtcuiDXQe8q+LrUrTm8BQTUC4bFG8pXOxZlDm+BWFoPM6NNbV2p
         DwII10HBtL8+V+v6Lci8TbMnEKunCTLBtSfapdJBrf9ps38FD2i8REA8yem37mVutF6e
         n1I1NHJAzxk0FLJY3n1QrgKS/UW6AUo/tZKQ4E7ObSGw/YSDbkYSErdNYK8Bd2nsqapF
         zS1iHIPOIoByr2F3BjlF2QeWp5XGSSABSK09IjATJAqQKvuRBpWyBXmU5/ky+2P91mL0
         q63YUXYQ/uupuIlPnEyH5siaWnzVd8osnV6B88gBpDfK3V5O1NWHMjSKat8q3sGTWsYv
         rs2w==
X-Forwarded-Encrypted: i=1; AJvYcCV1AWIVhlrI6V1SH5z6wH3Jp3aJ0JDZK6epwagipFfrhYt2DPDbMZ0PAQEqLiL5dYv3X38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyegyHmQeBIhVXy/36KzftKAQaKBKqVBkBsNxWGQEocmlqO7LJS
	njCKyzkUSDU23KT5TbHO1aEfbBYQtOqH4uQJx1YdU8P6cfXXzJS1/0YK
X-Gm-Gg: ASbGncua7P8Ad1hqnZoN1nN2J6007AeSuOHTFk9OxSsR6vNj9ktAs5JolwmKRy3sIey
	5r3Y3HoWFq8ViawHgB4osIaSz8ZLKhei0b6jxXMAAYFJAf0sXn/V2a2oKAEZyZBUBfwIbLznv2k
	ZKOv384mmS7mJEj+iSuhSX4NxpfLMKC6+0G3Awse3U7MokJ4H0e68i+5TuAGaZ4+k+Ve7OKLrhM
	on/WNgM7wciRY7iRSiBqSgmuLZO8qB6rRZDA3gTzLUG4NCTNt2o2Cdv++TsoQgPyLOgGTMqeyzJ
	kXcsvIaenIt+o5335ygmQGQrGsujniF/4GJbmwfB/2y6p2N2KRvXhibZbv3G558qk/zm6zD69v+
	DFamvl5gFVtjOx6qvkYecEJvyuOIYjo5Ld38IjNwK2ggLtyr5qDbYwPMJRmA=
X-Google-Smtp-Source: AGHT+IFUDX6lRTBwKtEo337gYxYUeNnrvzQavEqkA94xgDEKZNMwrY4bW52bsrvbGCjGjqYcMd+rhw==
X-Received: by 2002:a17:903:2f08:b0:24a:f79e:e5eb with SMTP id d9443c01a7336-25d26e455a4mr165661745ad.49.1757971200613;
        Mon, 15 Sep 2025 14:20:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ff5199a91sm87587865ad.73.2025.09.15.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:20:00 -0700 (PDT)
Message-ID: <2d82eb1161c26d2bed6b8cd0c12a9890211aad8f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: extract generic helper from
 process_timer_func()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 15 Sep 2025 14:19:59 -0700
In-Reply-To: <20250915201820.248977-3-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
	 <20250915201820.248977-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Refactor the verifier by pulling the common logic from
> process_timer_func() into a dedicated helper. This allows reusing
> process_async_func() helper for verifying bpf_task_work struct in the
> next patch.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Are you planning to follow this up by converting process_wq_func() to
use check_map_field_pointer()?

Just in case, note that it is possible to ditch last parameter of
check_map_field_pointer() by using btf_field_type_name(field_type).

[...]

