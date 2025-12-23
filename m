Return-Path: <bpf+bounces-77344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DBCD8169
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 06:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8F230173B1
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EEA1AAE13;
	Tue, 23 Dec 2025 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guDCPsef"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24C2206AC
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466249; cv=none; b=mSVca6aV6yxIDhL8AD1cjs4Sagl7VvQy9zk6OTz11gf50SQy7sNryt5enHQlKXlVBSJudJG9vLg30ShaJKQgN/5x6IiM7iKeOeJRzGfk2tHOywNjl0khEIV1z7NVBkkfSEUkVPnijldyAOrGWlZ//wu1qfB2DAc8Z67bwotx/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466249; c=relaxed/simple;
	bh=lACsEKq2UgK1ddvOmeEGgcR4QHGV5oYvGms3wGLcsnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH2A7+C7cuNwO0Jm6XT+YABR7DJiyvcbsyb+rNTjY347IoT3p+8Nn+yTG+SIbL4wWfayijeclzaR7MBNp2t6uMUTZ1liSG29QEljXc2NDE62PHrlnODPQee4l5qbi8ttjizG1SZKo+Us8xLwp69A0WqEYt/jg7WzDNLRrXVJEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guDCPsef; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbc305882so2346804f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 21:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766466246; x=1767071046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS3f4sfLxkqHKXtlQOxHvxq12vU7P9GHh6T7/dmVA+U=;
        b=guDCPsef17M1NFfYYXUrinyA25x6QJB9sMHtKFTbQIEFr4FzW4RELICYO0gKLkYmdQ
         a4VysVl8grOAiwlN8girbQjMLAXscgNdU249fINfCgcK9QWhO5g9LJeBC7IqCdErk1vy
         H3QSYsP75DbMaYOyE6XWzLIAfelxsfUgP4bI05/PTXYcrnTXOTnByUDEVDJl0lLaazCF
         P+LjQ6wXxbE4hB8vevln5SpThdCTTm1w4GRKPelzcpHBHonROJr5XFjhjnThlmMdGsrl
         JJ0GMgDVxY0zPZBrwK4FL7Sr/4NDee5h9JJJfE5ToNUyc4JxdJXz4aNNt3yha9xQoUJY
         168w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766466246; x=1767071046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AS3f4sfLxkqHKXtlQOxHvxq12vU7P9GHh6T7/dmVA+U=;
        b=CXa4Wql8nslP9hn7SZ4VQjYxvZLab4S4GcV4h+LoX+tF0tsMwhuUASk+xa7ysd85i5
         RIm9eemyyjoOysG1+ln49rK0UHlDy6qAhtwNoPjozfDBVq6o+JqbrBOO3deifghGUFJ4
         oSDe4S8AX/iGVT9y0Q1GsfHJQba1IyqitcQfnUzYMVLPGXHmh12QrgNxkRHc7Y9dT1f2
         71goOmNQEQyr5id4PZO4OJdcbxGJNj1kNe/N19YPqC5cYrxtyXymO0KO2bT214U2NMvj
         a7eu+ILiFA2Pvmlj1dbuxLJ6o1VbF48LXr18ZPONYQa0N/8AZBkpKZez/3dFqNcRIReS
         o0NA==
X-Gm-Message-State: AOJu0YxIkG7BWFVMsl3WgeAOUaANRjD0+qEfpfTR2+P418kTus5xE+mB
	xfiB3vScxjdWSonGwRM2CgxeuwZmOuIYTApIzFqxjK/N6zD8sSiW9V7Ik7clpwlkt65IU1H7N3Y
	I7RvMQEXgDBXuZozvNuPCbAYj1Ui8N9g=
X-Gm-Gg: AY/fxX7XGYTZaroZLDHSU5QPF0lMw2ouNLVbmfkT4AGxchjV7VAJTYwidX4AN0IYa60
	7OrnZtofTk2HIT0GLMV5rjIqC1z1P0rGfKj8v2kyE1IOGLky9M9wO5FJHIyZ+gxudd+KYk1t9ct
	dpFyxwOwSByPRjJXkb7NK4d0ik8ejz6b8SadaNJZzKosdchcbSJXIUTgXcqPTilnWsVQ4egA4bK
	+tf8kHlBDHs17Dcy+ZFyL4IRGotjSVBP2ZwOjJsN68rw6p5hvFghx4+ocg2EnRX2kAr4Hqf
X-Google-Smtp-Source: AGHT+IHaI95YeAOlC8Z9+xlJc/SYB0zTKhw8OBQBdSTOFMoPmPdf2Rcis/aYpv/nHBr1K3nlS/0/vLtStL9ahGKVLxQ=
X-Received: by 2002:a05:6000:1ac7:b0:430:fa9a:75a with SMTP id
 ffacd0b85a97d-4324e605ce6mr15041731f8f.62.1766466245652; Mon, 22 Dec 2025
 21:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
In-Reply-To: <20251222195022.431211-5-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Dec 2025 19:03:54 -1000
X-Gm-Features: AQt7F2qFEtQMMaRMbK-8UWdJW5Bd5-8X9zEnF8qqIWk2kSxXc8G_ByAfvfSrFtE
Message-ID: <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>  int reserve_invalid_region(void *ctx)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/t=
ools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 2b8cf2a4d880..4ca491cbe8d1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
>                 return 9;
>         return 0;
>  }
> +
> +SEC("socket")
> +__success __retval(0)
> +int big_alloc3(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +       char __arena *pages;
> +       u64 i;
> +
> +       /*
> +        * Allocate 2051 pages in one go to check how kmalloc_nolock() ha=
ndles large requests.
> +        * Since kmalloc_nolock() can allocate up to 1024 struct page * a=
t a time, this call should
> +        * result in three batches: two batches of 1024 pages each, follo=
wed by a final batch of 3
> +        * pages.
> +        */
> +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE,=
 0);
> +       if (!pages)
> +               return -1;
> +
> +       bpf_for(i, 0, 2051)
> +                       pages[i * PAGE_SIZE] =3D 123;
> +       bpf_for(i, 0, 2051)
> +                       if (pages[i * PAGE_SIZE] !=3D 123)
> +                               return i;
> +
> +       bpf_arena_free_pages(&arena, pages, 2051);
> +#endif
> +       return 0;
> +}

CI says that it's failing on arm64.
Error: #511/6 verifier_arena_large/big_alloc3
run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0

cannot quite tell whether it's sporadic or caused by this patch set.

