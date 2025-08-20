Return-Path: <bpf+bounces-66065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F143CB2D7FF
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F3A7BC60D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823F2E425E;
	Wed, 20 Aug 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzL9dtVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BF2E3AFF;
	Wed, 20 Aug 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681498; cv=none; b=KEJ/lrHIUP47EE+GBODghbTwNlJPWiR9CZwMbsJeo+wGV8vZUsKMcJnW6eg20tgmUfDxqiRRkQU5aHLj+Tx+PQ064o7PbyTw8sH9zdeupwEVGYPH8J502yOLmHR96xxnpMpm9OljSQ7MSYbK9tpVJAx5ASrvhHcVV+XAcN7gKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681498; c=relaxed/simple;
	bh=G8Q1QWRR0gJ3fgBmnbNhIKOn7vja2odMQbjJmMsdlbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ3ye9TK7wlyNCRj2ETQ5SIDDIUVqsuJGyBX+n3/T5zU4Fg70ADBcFHfvN0ndJRtCxIuco5gu8JMXNhLRSK6/uxfGP+5iu/7Zw+MbzzIgMJhxvVAxALQaphwxjTJMMu5rr8xIWnVlY/nHGEE6Qz5tlZXuheKxVI6hbdx5DN1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzL9dtVA; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so1262142a12.0;
        Wed, 20 Aug 2025 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681495; x=1756286295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8Q1QWRR0gJ3fgBmnbNhIKOn7vja2odMQbjJmMsdlbo=;
        b=HzL9dtVAiW7TH8hUE87V4oJytatbShmnRPnkQznY6IqG1OujKt01EDt4aKe/jO2lpe
         jDD6rsl+j5lXQo8p1yhSW3nSEeoAl5ZL/jtVLPnTpckbeooQKDIIvbscbyzJH9P4B/e6
         Y2CvzKs5gMOIwUm/2/KMzK7/rk1Dh68qnJsDa1rix+zCqqxuTpHACeZd4yoEQw3vmM/m
         XCCAvnH8b970Hgh6T0OBxKw7QGTsH9/YQbFtKXdnIFq2m9vcFfItGTbZJViH8g7KHbJV
         lDxnwV/vnfSMprpKMc9Kj7q7kbdbY77CbiXz/Kde0TPa5lHQyy7kmg0i6tbFc2POE8EF
         t2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681495; x=1756286295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8Q1QWRR0gJ3fgBmnbNhIKOn7vja2odMQbjJmMsdlbo=;
        b=ErOIR4WlG+S/s1/9UJOUlktvZ3hCAN2IjwZ9FZYBu5DQjsplQp1cUDVqCgxy9YgSjz
         jcv5vvmgSkCc/MMMybm0wAw0omXBT4rbSOk8DG+j1Zk30Tr2kYmS2TMlkdus9N29j4z9
         5YmUdEYYzLrpF5dlSySRLHFJ53aGbvC8N7hFELavgDQFfmvrVeg/lMOVPTyARyaGEtko
         eyXydB/B6XjOQlibscwqkkTRr65pKapJSvibe31c+4QmtTKNHjMl2DJ6QmJ8upLLbbPc
         VVSmtUcVG7xPPTR03f2jg5t+jg2s9g+8PoFjc4TLrjO6lTRdq+/bgg+OPEzi0gjIDdwB
         +oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZwbHKswpb4gza9fu0qgEljcnuqlxfqtWMmUfssbleIbuzaO58KWjkady2PO5ltCaWWm74lavwAlvVrMDM@vger.kernel.org, AJvYcCXhCJeAGyoAgT3dP0gFNABEgDUJPcyoPrxSz3eyOHbMhGQjHBAO4BJnwMuC7Rdw3ETSgX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ryYq2kvdIG3AiDV6rhrp7gY/iT6rt2dBQxZ4+VtiZqSQEbt0
	mSEy65IOTyUlKvqZwY2oGFZvv8znqi45Kki/85F61JbHQHDJ4lLf7OwsCT4txxZ7KJ568E1pL+H
	KV74la2fyuOiOxn4P7tpm5pX5/NPhESg=
X-Gm-Gg: ASbGnct3l3il4XdjzyXmz+0DCxisP4s/52ByzNDQ7HKCtVioEp368ooVO7xtVLokZ/n
	I36M+B/C2N/ULJtyAylHwBWSbNKdTZD7q/csnMuPhXlqDVVrsItFG8MzzskcGc8Y+7lz2TzPI5T
	A4rPUwLS50S9z6dpTFenxQddpD8vPTEydADOcZuvbi2m0EIJYf3lzl1kueBK417DCSqkBi768k1
	Z5phkc3FA==
X-Google-Smtp-Source: AGHT+IHQJXOuU+tNL4WsvowWGbczc1m7pTzJ5CkWT4xHDAbbLHqpDDfTYp3NQJwZ4QNOggU00MpfaKGHwmR9rh7aagw=
X-Received: by 2002:a05:6402:2350:b0:615:3667:f4eb with SMTP id
 4fb4d7f45d1cf-61a9755ccd7mr2069826a12.6.1755681494536; Wed, 20 Aug 2025
 02:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-3-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-3-roman.gushchin@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 11:17:38 +0200
X-Gm-Features: Ac12FXzdqMNQq5JRtACKutMxFrrk4Q2rtIYRhFlrV2llWZ3zWUQ7A6pvqVxx7ks
Message-ID: <CAP01T767o1-KyhRLGcm8gXU5GiY8_OtifT6bNVfMuf+MT+3ZBw@mail.gmail.com>
Subject: Re: [PATCH v1 02/14] bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Struct oom_control is used to describe the OOM context.
> It's memcg field defines the scope of OOM: it's NULL for global
> OOMs and a valid memcg pointer for memcg-scoped OOMs.
> Teach bpf verifier to recognize it as trusted or NULL pointer.
> It will provide the bpf OOM handler a trusted memcg pointer,
> which for example is required for iterating the memcg's subtree.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

