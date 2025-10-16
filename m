Return-Path: <bpf+bounces-71127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4935BE4E15
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D411A61837
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA8EED8;
	Thu, 16 Oct 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cch/OOzs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66422173D
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636338; cv=none; b=I7jEa1w1RXSDTpjB6YzL0I5a+HlmT3eAcmS/tgZ/iMRlcZBuPIj/wSgFUMaivYniBqsFliaecCQa8SC0frXSYK3yr6HLM1tNXKvHEstxdVfL8vhpizl/x+DgZEQWFzsNtiJSP91OsyyFzj67A56GKnlBJkKB6mtrZglXvD28gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636338; c=relaxed/simple;
	bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCfUt/L15B7ACk7V+ugEYx6pQ/bpEw3kFpbzat5pl0T/RrCJ8Kmj8MLY8rExfQRQ07q++dT0m1lr+NYkN2YmJcJV4AXqjl5zTADZtU78zb1kX0G7o/t4vKPuShVSQqzv+S7hHPs4ai24yUPv2Ig/vJ/mmEQNA+l+lZzNWBtyvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cch/OOzs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28e8c5d64d8so11168405ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636336; x=1761241136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
        b=Cch/OOzsLYGnR8++ug6EdtB1mGx6D9wxdDbVVMABQ9wM2bDGq8vpURtda3zrV3QSCa
         cCXZO5BACGjFolMfeuVhb+pz/+o2qZB9fgSNyW5L8o08+w6cIZEKzg9MLEGjlGX/jUuL
         8i/XNBLZ/McyNQgv8UThNXXYlvF+tAgzFAZAx5gekEc7opPncyDH3TcGfgiK59wrFTpb
         ZnTwuTHL1Xqk0tPM62kCNyOX5dl48rVr6BSW+e+YXkwHS/xJZgXzH5ynU6jml+YbfAAZ
         8d6xb5WqDuQ6leyyeB+W2cAGxGX2+Af3ySuIgwuxmt6bSn8V+K4MzNDV7zJMG2vBSgrr
         92mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636336; x=1761241136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
        b=Dh7WTgraxFSPBRC/iA5EH7sHECbzQCzwb3SRHPFuqwdfQw41qgzyOnoV5ERONTld2V
         I0d2Jqxjd3i4PKODEipU03YK9J+9MhrxkBpezFUD6f7AxRGiszL4c2WL1IjqIUIAvfUr
         NfEWlqhGP80rD3Xba7BvQ6M24+uGsKKI+nneMDS9v00RFsLeOAIObdUFTE8H7dL5qdyW
         B/szx2p/K0OuOO1MmFgo5rTShvZI05PNZgD3UpY8o/zXC/PHCz1c11x6JHcchSWNIheC
         MFlniKe9AmS81qa9141fjbSJsKs6JDuVWYtjQCMhSS73GyS/72dEutQpyP+xo7/khLSG
         j8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX1g97b3lZks/ltS0CDkutlKXJwL99VKqAZXeFAOjBasfv/vdiIF4CKQ+3z39KVBNKXx7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8cgq0MpXdg7Ik/MNBndMtTpuJH/GwPa/grZDgaMQlrZviit2
	vb4DAdn/XkwpGYFZBs74InZ2i/A617y3yI+71VHL71fbf1pwPUURM5VY
X-Gm-Gg: ASbGncuUA/lkcJD7SlD6mDwHuHAVyZQ2t++PQH9P2uEKZknWqcX5OKFoiG8w4PTg+FV
	je2kvhZyKcnS10ieE+QqSOdxPHyyqmm+N+cP4gcjeoMK9aMz7jRhigNTiS5MoQV3b/4qd5VheNh
	6DNZuqM2yMsDiOR+wbDi/oCJJooN7ldeX8f95VNftVt6WRwKvAk/IyYU5ySRVkxTcC+RkdgQ/vJ
	vYT4IDD9TYPB9odXzCPRXOjEPrYEIFCQyRFWLz3qqwaGhHR2tISJ64TvTfo0tQhzIZd4g1QPn0P
	QV8Fj8w3xHnzOGcdL2mUgdodQDWKdoDlYVK5RTXSsZJwPJDyBe+YN8HBj5BvbezpIX7eJMNNmWS
	ULGD+9mmsywS3iXx0YGd1bIfF0KoK9FN9umI4y4IehnAXZcRgCexlesEFlspRE40z9NcmTcO894
	ESNWJUuRUubL1SroUU1bg+WrVTH0gtAJ0vY5E=
X-Google-Smtp-Source: AGHT+IG8ofuaCOl/tx0AI3xaFGhoKVgfaZ7bskzpCPhaJ0vcwXl5dX0rZWjp9TrndrqOGJk/YTNQUQ==
X-Received: by 2002:a17:902:fc44:b0:27e:f16f:618b with SMTP id d9443c01a7336-290ca4f9b44mr6987745ad.24.1760636336486;
        Thu, 16 Oct 2025 10:38:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe4f:64d:d8b0:33de? ([2620:10d:c090:500::5:b51f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290a382a927sm32356755ad.106.2025.10.16.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:38:56 -0700 (PDT)
Message-ID: <ab6554712b0f23b1a64154910f77ee47fc596c18.camel@gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error
 path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Oct 2025 10:38:54 -0700
In-Reply-To: <20251016063330.4107547-1-shardulsb08@gmail.com>
References: <20251016063330.4107547-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 12:03 +0530, Shardul Bankar wrote:
> When __lookup_instance() allocates a func_instance structure but fails
> to allocate the must_write_set array, it returns an error without freeing
> the previously allocated func_instance. This causes a memory leak of 192
> bytes (sizeof(struct func_instance)) each time this error path is trigger=
ed.
>=20
> Fix by freeing 'result' on must_write_set allocation failure.
>=20
> Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking us=
ing CFG")
> Reported-by: BPF Runtime Fuzzer (BRF)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> v2: Resend with complete CC list.
> ---

Thank you for the fix!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

