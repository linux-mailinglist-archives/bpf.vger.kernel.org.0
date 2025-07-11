Return-Path: <bpf+bounces-63062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82054B021E5
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C37B4700
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6502EF284;
	Fri, 11 Jul 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5nasdxw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF91A4F12
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251713; cv=none; b=p4wMeMtf1UnAeQmWuzZqYb0Afehm0InDLkBmT4Pktu0PZvPm/8VMgrpc8+c6YwxQ0rsyaFA7olYYwITY4ukGE2WF6VWmsV6yQCniInN8Hj0Iq82ExYPbXwIt+IFplw/9m6rQjOb6kK3IQC8HNVgST6PExxCR5IhVfkCEyhSmekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251713; c=relaxed/simple;
	bh=rSEQ8EtKc9rB9830jtM6PTvzpcCKAj+BDYrLIbfBroI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0h1/BAPAnTk2O9s2XTjvQtDZL6BSEFqbizoeOrgbSEQS+/G7JMJQAYBNu1YNR+uFMvDJCHbtJrfBF62KxQWxpbGIe5ttcLQ0+eQu9U6MtMM1C/iom2dVY/uyozc2hWr23n/kemSXZyN5UIcGDZuFyzEw/ud2Tvh7P2xfRMj3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5nasdxw; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so356585566b.2
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752251710; x=1752856510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rSEQ8EtKc9rB9830jtM6PTvzpcCKAj+BDYrLIbfBroI=;
        b=j5nasdxwgEruh25sGUcEsVGKwm+ou0bG/KvM56+y13PHzOgjLIkDHz3oqHb4KU4Rbd
         GBhT9dJBd5PDCwNrk1+X+rCKVVd5W2ZPhIV2R8qIkMCw9UOthsP8zl8Vn/PQKTmHbzcJ
         lUUksj/ONBbnJdCwsGwfeopoCXgztv1BgcjCwtl7iaF/jiwdnQK0ELtxMvdMzcfJuRK/
         i0dHgn8a3ZMZAuqDcKvQ8ofMLg9WQQfKbP2Sc8iOswgmFzRyhFhAYYkDmDsFx7YrX7dF
         83oBnt++3JRtT9ttEIE3/Gj4my2nAHIFaMauH72i8tif9VqUpEf1FjWXoXTcn8Z9rHTe
         CzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251710; x=1752856510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSEQ8EtKc9rB9830jtM6PTvzpcCKAj+BDYrLIbfBroI=;
        b=RrCnCl9kaN5vWXCR9mdbhiTXG/d1ffkUzJ3D+/KogNrSzhGoKc0wFDl9Ik9KT4ksny
         fkvpK3R/Jt6JYIrcF88RM+2i8wwolG1QfWbTp0YlK8A+aZXUKfWL151iwub2n+vdcTpU
         elHALyyqeOP0TwqHIKzXpMV1/PL3xZulXRDPOwy1FnmqARSbxMtByMiuXZSNt2ZuW4KJ
         4sT1NKAm8qtOBRmkRnAtdEboMnMtM4FstlbgCvmSw3G9DzeeMgF7oIB4FO+oB9JTm3DR
         MJb/P6C6FB1lP2dQUHFzaXhfW8V2hszEzHKeujKhGRyGRu8sMPHgO0gmc7lhifoEDcf0
         hOdg==
X-Gm-Message-State: AOJu0Yy31wB7mTrFux8jQvzFSzvlULIvNUEZN1JxRYEXE/SHg1Tw7cSF
	feVM5nzewno4FPoxsVFjoia+n2DJ40LE/Cu7jaq3RQq5ySC/d7KSdrKZQo5M/UiruRaQ7jnrQjj
	f+mudUkFoVYoC2UJeSnLtJy0Y+XFJ68E=
X-Gm-Gg: ASbGncu+BC5sKmIt1FrGEStHQeX1Z1k5VpXUBkHsJ/QPVpw6kRRO/SKSzkqY1+Lubw1
	QlAOCmfzmWUpz/qt5EO1uIN57gFUVmo78yH5AH2LAfpKxGWHomVUrzbEfiDxhtMtYUSxWEnJKCL
	uAScTn6UCyl6X63joqXz2IGfIgYqxEDgchckpeIOxj3xkrEd/ZdBdVryUjQXa+eEiUrsl8Aj6ST
	DhIfsqBZUqMFqKssW9Dk52AWoKxPQNKsyWza6Ux/VkVDf4uDHg=
X-Google-Smtp-Source: AGHT+IEpj08+3lDUFWij1dxLZOK3BfFfFeWro2Tnj34/3jKUV94Cd9zuajpzDttP1rjMOLSbKq3WPzr38BNlN20sqHQ=
X-Received: by 2002:a17:907:d15:b0:ae0:da2f:dcf3 with SMTP id
 a640c23a62f3a-ae701356698mr362050666b.59.1752251709456; Fri, 11 Jul 2025
 09:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191312.29840-1-emil@etsalapatis.com> <20250709191312.29840-2-emil@etsalapatis.com>
In-Reply-To: <20250709191312.29840-2-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Jul 2025 18:34:33 +0200
X-Gm-Features: Ac12FXyhu3Kd4eNw_m7cqVuk-qTHUX1L8zo0htXcJctG9Uuw92uF2xfb2h-sSMw
Message-ID: <CAP01T77XWFt8kjQN64RdZNfk_7M8DtOR1x7iZAT7LbUGJa8j7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 21:13, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> Add a new BPF arena kfunc for reserving a range of arena virtual
> addresses without backing them with pages. This prevents the range from
> being populated using bpf_arena_alloc_pages().
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

