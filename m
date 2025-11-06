Return-Path: <bpf+bounces-73896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E579C3D3B9
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA843ABD2F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DA35028B;
	Thu,  6 Nov 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imYraTti"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDE266B72
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457151; cv=none; b=QecdpRZ3rGHo0hhrbaTswUp7LssNsJyIziVcZLEgenaarOTyAVI8zVu/slpCBnlLM8+VAJo/SCWxQmV+tEBa6i9Vj2dkKFey6w1CuLus1mYI9Vg9jFf2XamFE+BptTCBiosz40gDhv1y4Xx03BTP1PSubrihlx9NyH7Zbsxq0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457151; c=relaxed/simple;
	bh=YqUDK2Z3llERrKSf4kgpSMZ06X9HSELoNCNLaFNzNJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krOiTm8+hXyrKfk71r5uNTh4yBlSApSjW9vstZodbROvjCcjVpHsRolwgS/NdKqYl5XvkZ6dvf32BPzxyxZdRJ/S4W5CC855WbNwmgmz5UjJsejaCxAhZHTGxn/z1ybQT9qZgaZdJpLy4bF31eCCL03ip6jfREYfAQ/VM75glwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imYraTti; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-429b7ba208eso829722f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457148; x=1763061948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUDK2Z3llERrKSf4kgpSMZ06X9HSELoNCNLaFNzNJU=;
        b=imYraTtib4Y58GTqUvo0rmNk8/pSp6rQI3ogYQqj6MaOnhdKgld//rdt4tsG/9a+qz
         U6qntXa+YsxOGqZKGGXFdd6brD457s54qkjyCWJYMV/3esRKkyMLUBLSea4m0jDDDRS/
         4IlBaTi6A4Hrj/DzcJNJBrK7O253nnb7UABUifXjNVe9M0maLuFGOE08HTW8jgrLQDLB
         KOOPo6XyQyVzLBpUInQnw1PUetAUXNxdVLGgPGVtHiKL3hleXbZrv3n4xVJ58XBbMYFJ
         wmRpWkxQz3tU3z1eC17scsNVrMM9wwSFzrSfSy0WNg2f8ajhXt8Rg0MCBQNpyPTj75Cn
         AseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457148; x=1763061948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqUDK2Z3llERrKSf4kgpSMZ06X9HSELoNCNLaFNzNJU=;
        b=VThZDCMD7MGPyU/rLsJIz9Wq0WWkMcHZU3Kc7nzdSVLrVuJX/1MtnweHW7ZzXl8APN
         ZQz/h44aTIe9eaaIw77w2vqkEkZxm1E9FhBPv17ZLwbTpl4c79cNB9FbnTHs0AET9QLR
         4c4MqgFCIN5IlCtPCVfJ5Srdc5YeC/3XKWfnXh0zrScdYje71FpCGfMdsfXnwwOFTUmv
         yWfHZXEj1bCqMekCV7qX8uAkmuS4qAq5Q9t+a/NYV+kCmyLOrCUvQmfbLtSiYzBd9J0I
         b7APNneq/lPdy710077+UE9rmeIJ4dfZo/L+KheQuIca3Y22sL3nPhN4Vucqlvl0FsDR
         gonQ==
X-Gm-Message-State: AOJu0YxK/f+3EkPXrJm3uwnrh1ie+xghlrOLmY2o2jl2XWhNWMFUEYJK
	7Z9YpCWf6wiYPqInusSe1Xf5/3n3Frmmw+G33FOEPbV0jhZaOx/DDupqfTo3rMwkn49yqf/bbiM
	uHYVQxJAXGWehJm5vHwvVClKqecwqRlk=
X-Gm-Gg: ASbGncuTA9B9v4JzihzKUDuBSjSEfleCh4xN+QBQEsZ9AXIk+ndbbR4ae9WyfTACVSF
	ZnyNl4NUXxtx01qy5pV9Ftl8Y9+qYYMdagwjJJZaC11RNkhLZyLF17DA5kGMt//4vyqdRRSUzVK
	I+jeAbydiu1HDO7UYIrANa6EHwUrq7cjA2Tm+ZWk7o2gTpAp1Mf7HQ7xBdrR8T36y69U+jaQyfo
	+TQoHrprcxsm//5LSgjyS1wZHkY/k2tFU6cxubWEtUVmIxDPkkTIQQ5g3mXdSGaCTgQL3bveMsz
	EtT3X5Z8gRwwrJBytO4GRMGAdw9jN1wAIF+SevLUH9TsOM6P4oTpuQKexl8B
X-Google-Smtp-Source: AGHT+IEXQRgWnFsALfDxDA1rFRNDxsKvo0O8zhGaI1ZOkDjeTua7aQruzfJV5/uYolj+DC/9j0wr8ABeUtbJ5fPH2nA=
X-Received: by 2002:a05:6000:420b:b0:429:8b01:c093 with SMTP id
 ffacd0b85a97d-42ae587f46cmr378338f8f.15.1762457147440; Thu, 06 Nov 2025
 11:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Nov 2025 20:25:10 +0100
X-Gm-Features: AWmQ_blwALol_j4wqJjOeuoblhL3Y03bGPHaPxzHRA2NVd-ZlK6lq9KmpUUCMTg
Message-ID: <CAP01T74OKq6b0d94+QsL8iGLe+gTerapqHDY5fzsatR13d-3Sg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] bpf: remove lock from bpf_async_cb
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 16:59, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Remove lock from bpf_async_cb, refactor bpf_timer and bpf_wq kfuncs and
> helpers to run without it.
> bpf_async_cb lifetime is managed by the refcnt and RCU, so every
> function that uses it has to apply RCU guard.
> cancel_and_free() path detaches bpf_async_cb from the map value (struct
> bpf_async_kern) and sets the state to the terminal BPF_ASYNC_FREED
> atomically, concurrent readers may operate on detached bpf_async_cb
> safely under RCU read lock.
>
> Guarantee safe bpf_prog drop from the bpf_async_cb by handling
> BPF_ASYNC_FREED state in bpf_async_update_callback().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

