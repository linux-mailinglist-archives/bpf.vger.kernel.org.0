Return-Path: <bpf+bounces-70549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB453BC2DA7
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C61E4E619A
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696123E320;
	Tue,  7 Oct 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCUXaPFq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4B46BF
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875570; cv=none; b=kVf1sYqO37a/NFw0AphM1X80mN+CQ3RWZhXfjPddZhrztgPhUVWwyOEmCb/BrYyYm+gY5tzaPIs+ugFO+6xrb2jZbN63L8tjfBevBDwtpddUu2Rw5jn8M4PLoA5qm3uQrV7ItWVDDybj7EJFGDDhviT6/79ZAPDZiSPqDy2lfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875570; c=relaxed/simple;
	bh=0BrTKfzfWmn/Pi/Zu5OIVoErZRfX91UTWNPIBIWRjEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0kDfdXzSAkNTwXxzlp1t2WNZdNcBQ7G4ATqFNwP1Jrd0ITjwIpAc+Vs3W3gfGAUDCiisGWVtnn7gH+HV0+mZm2XcQ7b1egJtDp8N5X5nTJp5eWkV6DRBQQIXMkeQBNGuDQNPgEMaze5vwnzFv22LO9NxVUkHtF4XctvcgSpkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCUXaPFq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e47cca387so70930005e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759875567; x=1760480367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULOpCHpuzNrV19zhGgpQ5JcoiAZqb22xif0k/8B0pl0=;
        b=QCUXaPFqm7JpTmCH8PHjd8C08XpY6UmqcuIxP161xjlziKONYT2fgn1efIa/aTKs75
         ZMJXNidx/1pobQDH7yAn8Mav2ZNHJK7RZwyXFzrqa5k7bBIf8gx8wYOIp1KhMV5xFhV1
         c53yJuZdBvfX+sTNJ4jGNi0jLu3WKhUNiLOrch9RVo2AwmEfF5JH7UC0hgWRe6hgdeqJ
         SQomfRk8lv0Kh2F0cjVQs5QQ6XT4e93qhU0nJ9bMTeLtrWl6q1h1J+Hf2lVaxF5dhPuE
         JlpBmSJ0v6RZQTBjE1SfAJW+jxQH06WSjtsUHfmZ2H4wIcYgCrDWok3QAzp0LtugBHuQ
         8YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875567; x=1760480367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULOpCHpuzNrV19zhGgpQ5JcoiAZqb22xif0k/8B0pl0=;
        b=uhOI2JfGiD16h1eJToMJ6IC6oBrCXxal5y331VLooJEQcKmvPCw71j6GwLvhLjJl/f
         O0uGGHrEb1qsndd+8dLITBT49jD9iW2+ZF7j1oCvfUFHIdVq2j+DOg4QglcSXD2QxcHR
         MpVm6dsUzWS7bv+/YjHEGzXNkRUWC5/m1wC3xJy7gTQskVq0izaALj3GClqXXC5uN6h+
         kgowYOhtRd0bJ20Yk8geAgJolqYrXKe1Bk/BiruNnZ0U4wW/rlhqF/Km8s7p7UFGOoZu
         jlZ4qIOLuKdbdeZLXkq+0CZZr+pAJOEEvt76uB24cc5hCzBdZx0zmgG+tFVkLElWLqSO
         vSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVz2519BnccZmwdJf/h/Y999XwS1kOfba54LGJa4qSOnvLPP3i67KmiSL0sUWj3R/Dr4+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7Z8P8YZ9UHmrzja4jPFbZMmH/cBQF3bNZdFvJm3x72KvfJ3V
	aUFMjwDjSBBjMzxdn00khnsOQUk1+7Dlldx8H5zoTwhiksE5OdOiFSgj
X-Gm-Gg: ASbGncvA701/8eR939c84JM+ZBW5gpZzI3YTqzGE7PZSVGhUGU9JJzFzbk8C05+ZlJe
	5Qdv8sH/zgurfq6C5jQxEczm4PWEKNwS+2/LMNK65402a2NzjVenqCqSWbuHnr27zTjFc87vUuI
	nYikqn7aLre9+bdwu0u8pzawTl+l7lfd37UfpV6u3kkdNYRSGoo1zueC6b7jVUP8GDEZfxcEspF
	a7yaBhHiAQ96sQaHrdlzoYQFxf0WJat7Fg+VR4ufhhdebWsJP4Db4emUPYAOx4X+pk5qvWIecaE
	KsXtFngeGzfA7ow3AVme529EN31MKc9ESPHJRJtURX8IQrMQbLzP5gfj3G5XHEVKkESKK2NS30Y
	qX1KcQtdWbqx3yAYojkqkdLSD4RnSq8tj4plZpXWjNbrUmh4zDetNn3c15wp1fbzesotgiYUs7C
	IOTG0obAEFrxuayVXEkYw4QG5f1ycoyAY=
X-Google-Smtp-Source: AGHT+IEDEGLMNnwGgvVBfc4QERoDMV+mpYeq7qdLHaAOcddStnLJrxV8oDLrLzZbgg+SgAGAxcOlXA==
X-Received: by 2002:a05:600c:a02:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-46fa9b052f2mr8818265e9.30.1759875566598;
        Tue, 07 Oct 2025 15:19:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d869d50sm27930786f8f.0.2025.10.07.15.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:19:26 -0700 (PDT)
Message-ID: <acb151dc-d65d-434e-913b-7e3d61ea6c85@gmail.com>
Date: Tue, 7 Oct 2025 23:19:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Refactor storage_get_func_atomic to
 generic non_sleepable flag
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20251007220349.3852807-1-memxor@gmail.com>
 <20251007220349.3852807-3-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251007220349.3852807-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 23:03, Kumar Kartikeya Dwivedi wrote:
> Rename the storage_get_func_atomic flag to a more generic non_sleepable
> flag that tracks whether a helper or kfunc may be called from a
> non-sleepable context. This makes the flag more broadly applicable
> beyond just storage_get helpers. See [0] for more context.
>
> The flag is now set unconditionally for all helpers and kfuncs when:
> - RCU critical section is active.
> - Preemption is disabled.
> - IRQs are disabled.
> - In a non-sleepable context within a sleepable program (e.g., timer
>    callbacks), which is indicated by !in_sleepable().
>
> Previously, the flag was only set for storage_get helpers in these
> contexts. With this change, it can be used by any code that needs to
> differentiate between sleepable and non-sleepable contexts at the
> per-instruction level.
>
> The existing usage in do_misc_fixups() for storage_get helpers is
> preserved by checking is_storage_get_function() before using the flag.
>
>    [0]: https://lore.kernel.org/bpf/CAP01T76cbaNi4p-y8E0sjE2NXSra2S=Uja8G4hSQDu_SbXxREQ@mail.gmail.com
>
> Cc: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/linux/bpf_verifier.h |  2 +-
>   kernel/bpf/verifier.c        | 33 +++++++++++++++++----------------
>   2 files changed, 18 insertions(+), 17 deletions(-)
>
>
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>

