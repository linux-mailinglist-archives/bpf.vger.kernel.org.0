Return-Path: <bpf+bounces-55929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEB6A895D0
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BE83A2C83
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2492750E7;
	Tue, 15 Apr 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfc2ZjPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34A27466A
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703930; cv=none; b=VP0W2tLWu5mliAZeRo4h+JAZRHqIPTyRsu5V6/cd3LeSKiV2YHLPzUtf3hlb/GXrh0LUbysnElv+IC+kcw2MyPxkv/vueIoRCmhXOlqEAJGD9buvdVMP/QxecKIGwAJXtG8FXc5jPznu5xnloM2E23L1p5WLtu613jHyoPngjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703930; c=relaxed/simple;
	bh=bdmtVKAqRx11srxPm/69BLczxPQcpovNWs44y/mYzAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmlBuM0oeazV+3Fpm4ioYzdJwSZjISpzmmLmzzF4JbO4Jl7GebYxUbpkH7mw7hDTzN9y4bUAVZbEVV8t3vPxAM+4MXjyDh/VrqJtJu4FQXMVvNUVGzTZvK+Rayyfc8/sy/1tDbK0kTB7WUWjC5kxNMjsrKYCKKUMtc2RZ500njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfc2ZjPM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224191d92e4so50272625ad.3
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703928; x=1745308728; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WB+Vn1WbKpIt+E0RXCw7dAnLJBAK0Bz3EQzAPVv7Kzc=;
        b=Sfc2ZjPMjSmLSG2w+aFpICx/6ZsRRxF9nynxMRzM7ebU3/MKGUUfN4TjeK5GoaOu8K
         BNE2MiCm2aQe5+IFklFByvy9IIj5ZzbyZyz5tYhAVRDo8KrPmF2rJVLHzghBxyRKiw09
         5ETk+nZ7P6wvhCl6idIhE9+iEpeel7dmRfJrgbl0w4PbMelzhGraLdIDOwlke/rcRvQk
         IEVrhyGmGAAJml1jAkLehUQ10N+0tczKhy9QiU3pv7zWmcnDjsVcyfNUULMfqO5oedaq
         gVgVj9uHrtqz1aOEIJZ3s1IHfLX7WZOjDIiMQvziW7gM5g8khWBoG6Wf9gIla3wtsE6q
         S9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703928; x=1745308728;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB+Vn1WbKpIt+E0RXCw7dAnLJBAK0Bz3EQzAPVv7Kzc=;
        b=cJmoivaEGigUnxG8Kq8P2QWgJLENRCyoLwzje20Qh3/IoEjVS7uZzajCYmTeLchUmC
         yNk0fBZyTsxSsUlLUU2iqjp9fKrct+qucL8huScfAMapu8eTERIJ99BOmxg0B8lmAU8f
         I73/hXY9c023Y/7UzPFF5A8c1I40L16ihcokRD0TqM6swr5wpHAgIZqdN+U+W4YMQN3B
         GbF2sQxlQkKeLPrE+Wk0kYj7EREfSlHg3yoi1klYKhXkIdpVnW4TKxHng5OsIvM3XXFj
         Ke+Kiu1rwsq+O7Ql2Yp00zxghRraQiQVavpM4baEwnfOn94RxpDkWBVNbVmf2nIi8nDj
         JrBw==
X-Forwarded-Encrypted: i=1; AJvYcCXq+gfWEMbX7KlhvtT6SA9Tmp6dnAc2atgbsTX9bt/hQ/Hi083mlglgLiWxNURXp71Oi+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs96DyBdNja86umC1GAUUP8vnSHKCo1qzLEuKocz9x4w57E+Ev
	F/RjE9sdvyNX7n+tqCW5B/yDUX3pxxzpjpavp7NrNsIqqXsFZKb8
X-Gm-Gg: ASbGncua7fBJp+Ge4fRi7wHrKk7p30e9PNFVjObevZNTP7af1SfR+GDmfY2l/YNFbqx
	11u5EVriz5shAeMAXMbgcy8gleqre26bSkrJJflRiTlZQBenb2DWRZPGqKdHM4Lh/Hswy60tZgR
	IkGlDZkasB43Qv7Mih2RjU+sU5DBpWE1+Xne00D5F+uC5aSzbtgFBC9cCboIf/hTNh9TKWZpYjK
	Aatohw3JD2ZWjwYX/tN69RK1EW5+qL20aYuZrXfjfpLj+ln5cf1PxiJLWX8atyOgXjgC5Jtkzsn
	wBuC4eJmQQ5oicU/7voMSxfiNWDg+aCnXQ==
X-Google-Smtp-Source: AGHT+IFFw0VHfUVoHAxx6oiw9lR0kpnPL5dSLfuP5UmIxgyQe4lQDZIxnUgrm1d+9YpJ7ewEegJffg==
X-Received: by 2002:a17:903:1c4:b0:223:4341:a994 with SMTP id d9443c01a7336-22bea49e9d9mr201924565ad.9.1744703927913;
        Tue, 15 Apr 2025 00:58:47 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308535bb05asm454124a91.1.2025.04.15.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:58:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: andrii@kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  bpf@vger.kernel.org,  mykolal@fb.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next] kbuild, bpf: enable --btf_features=attributes
In-Reply-To: <20250414185918.538195-1-ihor.solodrai@linux.dev> (Ihor
	Solodrai's message of "Mon, 14 Apr 2025 11:59:18 -0700")
References: <20250414185918.538195-1-ihor.solodrai@linux.dev>
Date: Tue, 15 Apr 2025 00:58:43 -0700
Message-ID: <87zfgh26vg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> pahole v1.30 has a BTF encoding feature for arbitrary attributes, used
> in particular for tagging bpf_arena_alloc_pages and
> bpf_arena_free_pages BPF kfuncs [1][2].
>
> Enable it for the kernel build.
>
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/20250228194654.1022535-1-ihor.solodrai@linux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

With this patch and a new pahole I see the following text in vmlinux.h:

  ...
  extern void __attribute__((address_space(1))) *bpf_arena_alloc_pages(void *p__map, void __attribute__((address_space(1))) *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
  extern void bpf_arena_free_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
  ...

test_progs are compiling and passing w/o issues.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

