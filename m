Return-Path: <bpf+bounces-56362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE6A95A99
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDAA189639E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352818BC2F;
	Tue, 22 Apr 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxR+++a5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F82134BD;
	Tue, 22 Apr 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286271; cv=none; b=GBZRxydPzeR/5Vv+LW5iYACV6zPxwyy0MlPUccHIPRnnlBPaPaznqCf2EOUd8SbOAEXIMu2GXDdztjg0DL/ZHC55ssKWpVWz4YudO2LvHKMe1xO8SjrQtXc75zddhGAZ8JYIURN5cLuNkA/q3a3GJeo1GKwg9DO4/vbJh7FbwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286271; c=relaxed/simple;
	bh=JY1g3/MhFC5jdUryaepPudN/DdnY5dop8+gFTmOow00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQwSc66+Zfxpeer6KFcOywywcBk9F5cNgDoGS7lsBn1JFu5a7zgY3vmk7OT8iPvExQ5R1LVDNh9Y2W8d+rxE+3DfQQCZ5FluUL6ETxx3TvJ0s2vCG+hRmOA6K5+BzOpz2R5fUz4Y2i08AlmBiPRUMdlQs7xbTcq0RaO+LVTTmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxR+++a5; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so5806529a12.2;
        Mon, 21 Apr 2025 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745286268; x=1745891068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4h4TbY8Znfe/dR8gB7rAZNuUR7bnGOkg0xdG1pb23lI=;
        b=FxR+++a5AvNloflrUE+3tEaUoAreHqVRXWxxI5/IYg2RL5uP7mxQM5Ce+YtT38J7+Y
         tM/MWULPnKvaodTEZtXkhGNqzfDK7zTO0cdROw1CFnPuNFtg8aRMHNFKGcfHlVgo16iD
         h1md1DIaqvlVXh9An5nIL9J5r1W5ZEPczhTjktHi+U7VdTXHc2Qt9f89ROn3aaeO6/X5
         Ci633wWEC5Cu+fOKi0YGRWG1A3qgPE0e5lKgQxt/Pl90ynKRiHuk675J7OX7mIdRiMQu
         NPIaQbZJDZidpvBaH6kLGUJdKRhxmCHIw9/L3MjXVio60MS0XGnVIO3VF6v+SlDgekB2
         kwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745286268; x=1745891068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h4TbY8Znfe/dR8gB7rAZNuUR7bnGOkg0xdG1pb23lI=;
        b=IF4OJ8PLJJ8tB9V/1hxxCz9H5n0+SF20SalMRwCVJbfsPhs/wtHCHB4zm3FDej0xiq
         80pYEnixN8r8m4tGKN/olg9IgfO/QpAfzT/1bEfRM2+cpmo2evE6ccEG4FCjb9h/3vli
         3HQ23rcpaRF9xFsCuhi3XGJ9jXgpjtnkp+l/sNut96PYDjOVChH9V9b+QyzZF1Fq88sa
         GFCIraVD1npALCfhXAT8lGFhLMmiw4TJ1DRc+h4kfovr+wDckVpx4mkIRYEIbunuTvON
         g/QfDvfNzmBdg1xXKjNbsU2hORjVsiaEr6ma73IGJCYQV2N2eQqEpqSOPSB7MtFzhJGM
         uKhw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLiAPa+c2xSKTD8wMD9GnLjOeTvZKAA5/B3n/t9XGpyWcDoPa4LkvykcrJK7d9WrvcAgIC48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPh9wNEyFMmRY1k53wrdhrPcciZBuxEziByPSDSmtSsNgGm+0K
	+39oHP5LJYZclq7RGkOPrdOmNYQU/5qPb+aW2IjX6XrXipgAjYBcLyhqnastcFZpJO2SnqeHK4e
	Q3UnPmk7O2xune3ZoKNdHkNm4+9s=
X-Gm-Gg: ASbGncsd4gnQqKcSHAGAWtT8bu395E5bKI+4C4X8sOvOP2wRUkTGdz1w8nLb/Vab/9t
	tYvxpuuukMTwD+cwD5ExhRo+HZN90y/GdtQ2pbJgaBzc/7xZzkgFuaKiY+fWXkXfJcilFZ2pXH2
	a3lP958rwwYHeK6zyadIIB3fVaZqLA1IM531Kv4GSKrMM=
X-Google-Smtp-Source: AGHT+IH+3u+Vu4bFaUBa6pl7bA2TSfeNZz9QBKUAwcn5lqpOBVlv4nK6Ywycd4ayshCND08ePMKYBPwWIoDNl2caUew=
X-Received: by 2002:a17:907:3da7:b0:ac3:c7bd:e436 with SMTP id
 a640c23a62f3a-acb74dd5869mr1209055366b.51.1745286267466; Mon, 21 Apr 2025
 18:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-4-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-4-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 03:43:50 +0200
X-Gm-Features: ATxdqUGMbONhDBSp6SSFH7_QFy3bmQ8EeY6eI7tGzcGiKYNTh81Zvh9qVz_pTlI
Message-ID: <CAP01T76vnejd27gaxW1oNiEhT96Yp0j1JEs8iXb13UW6ep5XJQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 03/12] bpf: Add bpf_rbtree_{root,left,right} kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:47, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In the kernel fq qdisc implementation, it requires to traverse a rbtree
> stored with the networking "flows".
>
> In the later bpf selftests prog, the much simplified logic that uses
> the bpf_rbtree_{root,left,right} to traverse the tree is like:
>
> struct fq_flow {
>         struct bpf_rb_node      fq_node;
>         struct bpf_rb_node      rate_node;
>         struct bpf_refcount     refcount;
>         unsigned long           sk_long;
> };
>
> struct fq_flow_root {
>         struct bpf_spin_lock lock;
>         struct bpf_rb_root root __contains(fq_flow, fq_node);
> };
>
> struct fq_flow *fq_classify(...)
> {
>         struct bpf_rb_node *tofree[FQ_GC_MAX];
>         struct fq_flow_root *root;
>         struct fq_flow *gc_f, *f;
>         struct bpf_rb_node *p;
>         int i, fcnt = 0;
>
>         /* ... */
>
>         f = NULL;
>         bpf_spin_lock(&root->lock);
>         p = bpf_rbtree_root(&root->root);
>         while (can_loop) {
>                 if (!p)
>                         break;
>
>                 gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
>                 if (gc_f->sk_long == sk_long) {
>                         f = bpf_refcount_acquire(gc_f);
>                         break;
>                 }
>
>                 /* To be removed from the rbtree */
>                 if (fcnt < FQ_GC_MAX && fq_gc_candidate(gc_f, jiffies_now))
>                         tofree[fcnt++] = p;
>
>                 if (gc_f->sk_long > sk_long)
>                         p = bpf_rbtree_left(&root->root, p);
>                 else
>                         p = bpf_rbtree_right(&root->root, p);
>         }
>
>         /* remove from the rbtree */
>         for (i = 0; i < fcnt; i++) {
>                 p = tofree[i];
>                 tofree[i] = bpf_rbtree_remove(&root->root, p);
>         }
>
>         bpf_spin_unlock(&root->lock);
>
>         /* bpf_obj_drop the fq_flow(s) that have just been removed
>          * from the rbtree.
>          */
>         for (i = 0; i < fcnt; i++) {
>                 p = tofree[i];
>                 if (p) {
>                         gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
>                         bpf_obj_drop(gc_f);
>                 }
>         }
>
>         return f;
>
> }
>
> The above simplified code needs to traverse the rbtree for two purposes,
> 1) find the flow with the desired sk_long value
> 2) while searching for the sk_long, collect flows that are
>    the fq_gc_candidate. They will be removed from the rbtree.
>
> This patch adds the bpf_rbtree_{root,left,right} kfunc to enable
> the rbtree traversal. The returned bpf_rb_node pointer will be a
> non-owning reference which is the same as the returned pointer
> of the exisiting bpf_rbtree_first kfunc.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

