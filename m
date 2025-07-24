Return-Path: <bpf+bounces-64241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB294B10650
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B501E1CE7F8D
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C328FA9F;
	Thu, 24 Jul 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UGICBqT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D628D829
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349242; cv=none; b=uPzw/s78jxIYhe36pFK28DVeD4FqQztLge83P/qdPqgkSDRhiUc9DZGYKuOIgPBqYEA7V9BMg1jyxbXYts/KNXJ1vEeg2CboKZVRjGmFKCWr3rYMXZzRz0Att4nMX3kcZktFKtpO7n8fcKHM8F+FJYAMVY7Coj7yVQIskJ4nov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349242; c=relaxed/simple;
	bh=+ZnY3P2X7S+RjIK7x3kjMud65ddeKN8CGNIBvXvMncQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NnE6Oi0PsxFVl9BX4WNFyHflfEwsTCfsjMRDD1OvrpMAMu4MjEsiDMOyvSh4Ho2SxpzQexdP1Up9yXs2rMcJW5YpjQ/6MirjWa3GbAnp1yREhXTBOlHHHubpxh0T3U/kNB5ZwAr+uIbqTXzEx2RLh1etqOcDJVwKp61Ju3Tk9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UGICBqT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-456013b59c1so4187695e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753349238; x=1753954038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrwKI3F7bGxyMyCeBsCzUls3NPftVxNs1GB3kxRYJM=;
        b=1UGICBqT1ZIWgjiOXCuGr7zQ2PUhDBdeY/6pLHPij1lEpseCP2BOOaLdL6QNVl0r7m
         eMsemEZVgVeWohE71HCszNVOm0L21zODEACYjbRd4ZkFJh5avwAGKRvJLiYjrpyFpsqk
         2FVkPbXxv8cRSX8X9Cm3O573YU3y6Vg+HhnkSLY4bppxhf5V+3UMGwTcb9tyXasVgrXb
         3o7DzIrouI78rOYIlDCMj9pqL28X1x7UN6TYnAIkzxzyJlRmvpV6MrvDzkKCh7VHYzMM
         xleihsh3V4yBoVH6EiMxCrJiLTd2sCD13xJKeOcSspB3BBeNYmY0jhkGav/izNMuM/t4
         eixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349238; x=1753954038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrwKI3F7bGxyMyCeBsCzUls3NPftVxNs1GB3kxRYJM=;
        b=QnoeJiZPcidDJpkxZvmWWrp5tpH/RdkTesXCoOhe5Vd3czFdo6NHHwOs13dQsD72mw
         n4E5l9AlHEZJP8MFt5XP2zT5J91uQPPcGkKEMHRJuPMkDPkxWSh9iGUEpG+YoOzEIqsz
         t4lw/aZ1zzGq+QGZBct8ny75eqIdI1j0dqjAAhSXbzoIGWAMhjpaW5bBzkaoMiJUwS1Q
         2zcXPgkwjimWOSDLrVTPBdMQfulYZ8GVOW1uTNt+BIlyobkQD18a1mP/3VkWwLW0HbOa
         aiIT+mXtpfDxNDEk7zWALEYCq/kB/c0IlhT4It4T3aICQqq1oeWVf1RhXc7OiYjc1QdL
         HG4g==
X-Forwarded-Encrypted: i=1; AJvYcCWr4r7C+S9uxLP8zlJSVnIUsIcfQjhXhsajWHEYYUEx1CRlz+Gzl6xIPzgJLeJ0TdkwIAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzgxahfHU+Bio7wE/N/x/jo6Bd7HQQYOAcZYwmwgOUPylPrHJ
	5yh3iadhCmN0NP3OfJDAclBsjIocCBVGkKQqmA/dysbUAHY7HSdZRae/jfDCjOn+VHvD9s7RRT8
	ASAmnHKIlxYsGejujDQ==
X-Google-Smtp-Source: AGHT+IELtTR5XvjXT9CI/JkCboBp8PAzgWTU7RN+Nu/d1GBEMVnbisQm+epTaSt63SxD8yXeLjeB/JQjltpOZIg=
X-Received: from wmbay36.prod.google.com ([2002:a05:600c:1e24:b0:456:1ccb:7fbc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4022:b0:3a4:d6ed:8e2e with SMTP id ffacd0b85a97d-3b768efff13mr4278297f8f.41.1753349238077;
 Thu, 24 Jul 2025 02:27:18 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:27:17 +0000
In-Reply-To: <20250715135845.2230333-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se> <20250715135845.2230333-1-vitaly.wool@konsulko.se>
Message-ID: <aIH8dULJCe4FUd8I@google.com>
Subject: Re: [PATCH v13 4/4] rust: support large alignments in allocations
From: Alice Ryhl <aliceryhl@google.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 15, 2025 at 03:58:45PM +0200, Vitaly Wool wrote:
> Add support for large (> PAGE_SIZE) alignments in Rust allocators.
> All the preparations on the C side are already done, we just need
> to add bindings for <alloc>_node_align() functions and start
> using those.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>

