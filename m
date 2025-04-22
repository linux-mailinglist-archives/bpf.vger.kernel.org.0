Return-Path: <bpf+bounces-56371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F1A95C75
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934EE172771
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830B81993BD;
	Tue, 22 Apr 2025 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVfBChE8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CC10A1F;
	Tue, 22 Apr 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291042; cv=none; b=IyEt9fEp2hH31hcsEU1KA7MK4vUDVddAecdHa04LGi8Nd46Nd5RHoOlzo1uR6Kc8Mk7cI8gv4DkdceiPkKdsph5DTXDOHImctxCFkYkuHnKAocA7W3pj+Xt+7WkCocoVMWIYcpuN5dXi7dmYIjp5r4gZiI1WoPhlokpSCRC2+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291042; c=relaxed/simple;
	bh=5RLdTjUyAjYLFaw5CR7pxZFCn6k3A5c8yPL4CgpdJyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dueX/u2b5PgmraQQW+xAMGLJ6s8X5H4o8xc+KQ+f1dabXQ5WUTdj+q32LW87sCXxmkLesYez3B0vnyY7TYXU8rP5wyzjv1b4lRuI7dEbtGz6q41UVDJprdKZbTD8e7CdZBKveQzZ4IOH1vAUEwFsCpV2D3lRHjLepQ4ByvRfWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVfBChE8; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acb615228a4so751625466b.0;
        Mon, 21 Apr 2025 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745291039; x=1745895839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5RLdTjUyAjYLFaw5CR7pxZFCn6k3A5c8yPL4CgpdJyQ=;
        b=UVfBChE8WuDFyf1GMeAcTXLtmt37otAdtYLeCFmTaIb10QD/bW3W8alUJLQmi01mrf
         ANOO+rMstqTWWXD4eOTbJEfQqwsCOnrorIcIPQLFkW52h4am7uH41hhpwLQ/izaaBCSe
         umabTLctga0kheptl2ouDpRyMgyYFjdOfmKoM5VSt7axNi+HtXIAIUdh49t1QdIQVYz+
         ZVxaMaWy4yKt2pFgAMUD7Xb4BaarKDhvLrfCr1jrIIFZr8VmcvSQNHgePnMPymMYt1km
         2Tlizp8RPXbsTAKxIOxe0ecaDU0rTLXBQkxX/40xtfEoGrEJf9MwodPde/ug/CJ03tJ1
         clag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745291039; x=1745895839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RLdTjUyAjYLFaw5CR7pxZFCn6k3A5c8yPL4CgpdJyQ=;
        b=tdfrGvJVDAhQFWHFHudBPJjJCii+dFOGKKFRgVPzUcO3KgkPukcQNmnlz1vHov4fNP
         BX8V/o+F/+BUGpX3xJucxmD0uoKFPrWk4YxPcO1UNW0EhLNdTYMYXSh9FX/R5Apb5c5k
         /A1Hyzp2WGWuQ/dmLfZ0kfPRDII+ybFsDC/0B6lINV/EhWXgNZUYv8dW2OzKfhBL2KS8
         yuNMeroILyarv15x2S3/IliXTeFaZu7Fz5Cedza5L3ltbmI0hX08mqHw/RT+Kh0BnNGR
         GE6+rSkVzO/sMA361ZzPrmmF/KUGc0tQBvE+T+Hd3zfVInPGR5Qn6rEY46/7YcG6oSx5
         0UEA==
X-Forwarded-Encrypted: i=1; AJvYcCVnbVMqY9G/tioKhBq7o5iQmdb48Wd2KVf2E5QYmX8g1idGlYx4Yi5QvUVziFxNtRd7Bm2MCYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpaiSeIkfA1HXPhNuWb9l0YRxRpHHNahKfZeXQ/sjxhWLF+ZF
	E7i7TJFWIvDUCdr8amS0Skp4cwTHSY22MDVcMUvuCjzSh5Ht26gApUoFGx2YNM3zdb2XJn1vdHS
	ywkZpwrsRHHnWUDp+0yiGzK8/mOo=
X-Gm-Gg: ASbGnctEoxDFDeUIlGOXLseOZiS5sLJjvL4fu/HqRic0GQiOgwrziI1kzQUOXeUIZyg
	wG+zEceMfV2LKrLg1MHX/Hc/dDX/IbW3AgdYj0pNDtgp3MKl97TIV4g/cjcmVfRmr1bqkwbshjO
	nneFDM4aZ7NmO0fki7jDBWNDBBsJMs9yyqoCS9ASgAKVE=
X-Google-Smtp-Source: AGHT+IHOKj5mEvouJutYPJUliBm3+qQRBFMivEYzIadPKAwwSh6AjpGzBEZMCdTpuSAwrax8rUhs40uO4EHvXDhi9TY=
X-Received: by 2002:a17:906:3ecd:b0:acb:b9ab:6d48 with SMTP id
 a640c23a62f3a-acbb9ab6f10mr188060066b.30.1745291038455; Mon, 21 Apr 2025
 20:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-8-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-8-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 05:03:21 +0200
X-Gm-Features: ATxdqUF_koqpxlhO5gahxZndGlfSMbG4vXehPTaVpM9iuj6vDufqm4UdPCxwo88
Message-ID: <CAP01T75mhuTnFGhxZgrsqYmLM13DpzR5C5SM9Q-771-pyaYdjg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 07/12] selftests/bpf: Add rbtree_search test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch has a much simplified rbtree usage from the
> kernel sch_fq qdisc. It has a "struct node_data" which can be
> added to two different rbtrees which are ordered by different keys.
>
> The test first populates both rbtrees. Then search for a lookup_key
> from the "groot0" rbtree. Once the lookup_key is found, that node
> refcount is taken. The node is then removed from another "groot1"
> rbtree.
>
> While searching the lookup_key, the test will also try to remove
> all rbnodes in the path leading to the lookup_key.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

