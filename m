Return-Path: <bpf+bounces-68421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6432B5857A
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2302A2603
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142928725C;
	Mon, 15 Sep 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc9L3fZz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B9287243
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965795; cv=none; b=ZY3et0Bf713LXAmiCNmC6sKCt+tekozrYiqCJULMfPf1mFMmRZ6oO2I8Khh4D7pUG4MC2x1LTat0oCjJXuXqRcQJs6NJaxIYf/EFMVXsM941sTWNzMpthqfXpt7xP3RAGLhtji7GROt3eS+hAnMueZMXXEG+S97g6xW+UKL8S9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965795; c=relaxed/simple;
	bh=vki4f//YpOA+/DMIEKosPdhpC7X1EIX6rn18AUOJIDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYkqIFo395lso9A114DYHnU9L6kN+M8vhLksRYBT10NpUP6OQQe8xegw3Qys+JSRHdAwfja5prBfzhB96hTmIzP0E65hic8+jdYIYG/RPIHGyGn5lNc9CJOLzsAICNkiMFN+PfgnFDuJaTZV7k16VRDJfJVth0oahWm40O07vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc9L3fZz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso986248a91.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757965794; x=1758570594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/yBS8xqZruyRHXODDMQkHttngIp9wHEWvRKIBk6FX8=;
        b=nc9L3fZzeRDgR4liUamusx+uW9r+rY5mn7V9or3lO3n/DX5QhnP1EizcznIIJdAfYG
         hRYA0lXC+DC3dHF8Vlt7ZKWz0d33EI579c/jj8AnYqs5Rmfbh9pMXwKKZEPDa7mQ40uM
         UgVzGA9D2k8t3WD5XmCntjIi2V6zcNX6rt9kDlzCGb4UJ1SOJAzrKyzNgz6fvaDPknLj
         NRa4FzYcJdG8yT2NIWmNQ0ghh73wuxEZ31ir9EMd7e3Jq3D4Kqd7T2gaSVU0yN+pSN94
         T5g+7ossMGLSLpi2hTYuDdSq4ysdj2zKNjBTvlA/h2D1XYZARICgOt6wdyVTvZTla+zJ
         +KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965794; x=1758570594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/yBS8xqZruyRHXODDMQkHttngIp9wHEWvRKIBk6FX8=;
        b=VqSijrhdia4tax8SAjjiazSvail6FMAhQl+otehXBrSk1tm7t7cohiXOGe8XiuNg5j
         q8VkqH9zrcHRx93uFPttRvJQTdQzWVXOAXuKQsmZZ3vlGBw4pzxVqtDdZvEYGnTJ88XN
         dLRteaMOlVWmp+aYD1/NsrBf9WQmnGtV7jEeDKSGTWfB5aVm5vu2Hm2HECFeVEc8sYXv
         BcyEPcpjfyIusfhmfKEZ0Xfr07EmbVLFSVB1/Xf35tRpNYdRpNe49l9QfJK4jhXyRHbt
         8eQfQODJlbtYIH8/LeWaTV43pu/TSxOVwszj+I40La4aKP9+HVGLvFMWwljngQSmJxer
         k4eg==
X-Gm-Message-State: AOJu0YwORd2Ij370OLLVZcplDVNZZiUnojR3+fC0Bxm8zYrXJbK3bLjT
	jZDdfKyu8JrUSsIpOOeRFNcjmM0L8xrNpcS/eQaUZQh4Adk4JcE3PfB1F0f+oz0k5SDZpp1TOon
	tHcpu+9bDtdZP+O/3j/Lfx2wxVJzWlI0=
X-Gm-Gg: ASbGncs89KGCxqCTQiycD1yBYUI2lrzyzrqvYE1qilGwW1lcgBsFOjRgBSLNUao/W3g
	VhuuAy4DrmxcGLRkOCwubaN/U11bvQWAIpFO4KlebceCS3q88atsfLGygCa1KqDNLPR6p/h3w64
	ixv8dejDLhe4m3WTO4kvyBYN7Sir4syLuAbRihuXAbhVSZbH1G35g4IqGUBsB2kP8Wi+p+2+Sst
	Q3I0zcvlaodifQq4KvNdwM=
X-Google-Smtp-Source: AGHT+IFPR0xNt1SdT9jmYfIls8wuA4gQdU6nOErPR02vY+QbY+RVRV/p069LcMoFMza2ywVDD048srLdsGemFoumkbs=
X-Received: by 2002:a17:90b:50c5:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-32ea10bd062mr660253a91.12.1757965793696; Mon, 15 Sep 2025
 12:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-5-kpsingh@kernel.org>
In-Reply-To: <20250914215141.15144-5-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 12:49:39 -0700
X-Gm-Features: Ac12FXzQ6hNrX8nP9Cv8EeH1bTRHFp3dNUNpYMvmZX34bI4yuZQORu-aBvdlJ5c
Message-ID: <CAEf4Bza4OF5ihhEr_ihW6FQ5JF=pdHukFtgTprsuxYsasAsoKw@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 2:52=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Implement setters and getters that allow map to be registered as
> exclusive to the specified program. The registration should be done
> before the exclusive program is loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf.c      |  4 ++-
>  tools/lib/bpf/bpf.h      |  5 ++-
>  tools/lib/bpf/libbpf.c   | 69 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 22 +++++++++++++
>  tools/lib/bpf/libbpf.map |  3 ++
>  5 files changed, 101 insertions(+), 2 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

