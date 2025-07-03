Return-Path: <bpf+bounces-62249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4230AF7160
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045861C21E2F
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8A2E610A;
	Thu,  3 Jul 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EvBC2a4p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234282E54C6
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540451; cv=none; b=Hd8heHEaCCg8vsjfnWA49vPa/eMfAN+wV67ZEMi/gjhW3dKZEaExj6dG92QZzXBy/sTABhbWVTYzkLy85BLt05S7kG+otSjIMUuEseWI9FS62hsa3YpJM8CqMGPJ2jOTwrxEs+ihWxwvEo5TIfOQgIxZ6WS7TQI5q2x1Ren8TqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540451; c=relaxed/simple;
	bh=pq71cQC0uBkTrByxknfDokTuXj4TZF9Xo9CXv4m2J1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoSFUz5vpZEaqcwex1iFxVy0hoV97iUntAVDOpyXYJZWkd2waFmqeFNk8OyLJDu5p4q7uLIrU3XQ6AO1zjMB7FSvvvPWPvN/PPgAMgHPBfLUEFADlpb3rUC/v5rVsYaCV6SrM7fE6PqDPskyvct6UX/fVNugkBjDQmmYTC+4pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EvBC2a4p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9876779a12.2
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751540448; x=1752145248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ov9dvzlRKndQHh6tUxnGLDmEEkae5LZqZBxHgs9G6wc=;
        b=EvBC2a4p4yVPF17ZTbttUn/Z6FCvl8eQN6r+J730B2YMXf1nfvwlulY2zIfq5NFYvD
         9H3A48hEhiFqU7/+FkGB0YePmg68PynUWsmhDOkm7fVOO/uHnW28uJ5VgZ05dtceoNMv
         Zskh8Kug/tPZiI+EBQ+QTQwfzFECXamfzx6U+Z4i4DPo0TP3f4oo3s1uFRo5YymCiJUp
         YeOH/BfO7Q9qIu/Orkqj6sGB9JvDIXnWYgKFUX3vFlX3ELkylkqtaZvxlMj8u53TK68Q
         L1EsxKkM8fulrbKDQfHLHR+jD5Xd0P74fIYeBRA2ONll8xeGijMnHpzCAzZQyayTOW0I
         ijrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751540448; x=1752145248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov9dvzlRKndQHh6tUxnGLDmEEkae5LZqZBxHgs9G6wc=;
        b=ezfUAL+lDSMTY78gYXFkLSQ7kIzoGek/BwawcAG0LC3kL5NCLbEcjCiqY1NBa5Iysy
         +0AOQPCQRHgJIM7nsg7wliwiejxwMnPK8zpQyv+Y0ho8XJz8GddzUTeqAQFI4XfC26xh
         gvkSoTGWe/PSGtKGWVbLtVwsOwIMp5fcz990hVMNs2QdW5LOwPIuthZP8kJ5frY/w2bO
         v9ZSAmXXxEaU9czTLf3S/a+5qqiWOL8wNdvnpbjxdCjWpPXgvcDJpp4z6CvpoeYJcw5r
         GqhikMfED7toUQvTM2QfGdF8LGaiwr+qqZDIXCFMxSIPUqllsnFeW33SCMbGSiil9aDF
         jaUg==
X-Forwarded-Encrypted: i=1; AJvYcCWJtcBmawxFiKgqmkrZzkYicTgvm2wXNTWfDvoUFhA0IVs9uJSId/1TSvHDw0qHkc3G36E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1y0m4cp1etwG+1mH3n8OebsIL7e/NTqILIMpLeRG9YRFmHDog
	xuLR19Hc82ZHmqAVhROYCMp8k7q1G1Y5FgG8X7tlI8+Ja/ssBTFDbI653IhRDaLI3wUacg262f1
	ikMUb3BBbH/0kZnXZ1hDsRTEegYc2/iMtHBeyHpvIHw==
X-Gm-Gg: ASbGncsOgDET2WbcDC8IAu+JukeDl/zHsgxfoGoKVQv8rDlGwLb7U22I3AJAYU+FGtz
	YotVd+WrHCPpLMN/YXdqHjIEgsrqtq/NL3lKtvVYrKsw0m2am7i+0lewRSh2oYz9xnnNuqSMrbo
	WeFn0TIrCVQyP4Vygrpcyl2PJ01shDNv0NzAzYlPY0aK06prxcPhpqLqds8/2PgpHc30Nc
X-Google-Smtp-Source: AGHT+IFq99AvGxW5aLC9eG5GTz/XC5r0d/uxg8Wd9qm18IHSvd8rdkOX3/+DZL2a9gIRJngK/mdb0k4KA/1u3ufWHFo=
X-Received: by 2002:a05:6402:4552:b0:606:c8fa:d059 with SMTP id
 4fb4d7f45d1cf-60e6ccbf0c5mr2412747a12.14.1751540447822; Thu, 03 Jul 2025
 04:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
 <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
 <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com>
 <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com>
 <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com>
 <CAGis_TUNfUOD3+GdbJn1U33W8wW5pWmASxiMa5e5+5-BqJ-PKw@mail.gmail.com> <CAADnVQJp-AtrRj_XESbE5TUj6_dGNDwpRWwu2vEHv1HGOb4Fdw@mail.gmail.com>
In-Reply-To: <CAADnVQJp-AtrRj_XESbE5TUj6_dGNDwpRWwu2vEHv1HGOb4Fdw@mail.gmail.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Thu, 3 Jul 2025 12:00:36 +0100
X-Gm-Features: Ac12FXwth0AL_93FPjmSeTcvedAjmjaHBh1eXmSTqMK8uh_2jpjAenacQlOjT8w
Message-ID: <CAGis_TXJH9cXNe=mveV0cCGiebXy5uJNd7ibCbaPcOsbjDt+kw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Jul 2025 at 17:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> What is the height of 100m tree ?

Because this trie implementation is essentially a binary tree the
height is given by log2(100m) = 26.

> What kind of "recursive algo" you have in mind?

Something like this:

---
 kernel/bpf/lpm_trie.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 010e91ac978e..f4b07920a321 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -33,7 +33,13 @@ struct lpm_trie {
  struct bpf_map map;
  struct lpm_trie_node __rcu *root;
  size_t n_entries;
+ /* Maximum prefix length permitted */
  size_t max_prefixlen;
+ /* Largest prefix length of any node ever inserted. Used for an
+ * optimisation in trie_free() and is not updated on node
+ * deletion.
+ */
+ size_t largest_prefixlen;
  size_t data_size;
  spinlock_t lock;
 };
@@ -450,6 +456,10 @@ static long trie_update_elem(struct bpf_map *map,
 out:
  if (ret)
  kfree(new_node);
+ else
+ trie->largest_prefixlen = max(trie->largest_prefixlen,
+ key->prefixlen);
+
  spin_unlock_irqrestore(&trie->lock, irq_flags);
  kfree_rcu(free_node, rcu);

@@ -599,12 +609,40 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
  return &trie->map;
 }

+static void __trie_free(struct lpm_trie_node __rcu **slot)
+{
+ struct lpm_trie_node *node;
+
+ node = rcu_dereference_protected(*slot, 1);
+ if (!node)
+ return;
+
+ if (rcu_access_pointer(node->child[0]))
+ __trie_free(&node->child[0]);
+
+ if (rcu_access_pointer(node->child[1]))
+ __trie_free(&node->child[1]);
+
+ kfree(node);
+ RCU_INIT_POINTER(*slot, NULL);
+}
+
 static void trie_free(struct bpf_map *map)
 {
  struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
  struct lpm_trie_node __rcu **slot;
  struct lpm_trie_node *node;

+ /* When we know the largest prefixlen used by any node is <= 32
+ * we're guaranteed that the height of the trie is at most 32.
+ * And in that case, we can use a faster recursive freeing
+ * algorithm without worrying about blowing the stack.
+ */
+ if (trie->largest_prefixlen <= 32) {
+ __trie_free(&trie->root);
+ goto out;
+ }
+
  /* Always start at the root and walk down to a node that has no
  * children. Then free that node, nullify its reference in the parent
  * and start over.

> Could you try to keep a stack of nodes visited and once leaf is
> freed pop a node and continue walking.
> Then total height won't be a factor.
> The stack would need to be kmalloc-ed, of course,
> but still should be faster than walking from the root.

Sure, I can give this a shot. Plus we won't need to guard against
blowing up the stack.

