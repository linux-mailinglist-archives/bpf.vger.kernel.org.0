Return-Path: <bpf+bounces-78674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E5D17572
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A242230388BA
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B715350A0C;
	Tue, 13 Jan 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgcDlR+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E748192B75
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293598; cv=none; b=lAbmqvaQ6hKVsvP8lmpBaw2S5dRqjGvg+BkA47XIX//+gfsUZuKMy818sswyouxF8kWD5xnn4PTeNFkBZjp91KurAMJS2Hf+mANRMOpVJs0zI6oixs9DpuzdltVwSmQB1caUz0HMRMcjvfJmEpUxKLX3uZWVIEsNXPu+6QH7M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293598; c=relaxed/simple;
	bh=ij80Tmnm5KpilE0kihDacIVzqSzHVnDikw8Iz0b/iro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NLluK7tdi/NOFrR0X3pNAr/xiierMmdOQ9IBrfONF9CpuHUPgSD+sIbHvkUs4vDkTHd4Vi/E0rwBDiBCCi4xa7CPBUS8gGvLcbq3uaUFYVM9ZLXf/hySUuOWQ3CokemmabipxXSqWVclj/sO6iIQUFB4Su/fNNXTNMFk3nX73Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgcDlR+a; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso3884264f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 00:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768293595; x=1768898395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+fj7WSVo+++50SkOvqVSUFrjMl6bqMv8voXQsnVi/c=;
        b=HgcDlR+aK5gPLSFdpaq2Kbyqx7aFoL9bPSaxg/5FGcA3k7T0SORghp2Jf3WgAQ6+t5
         xtnqfOsF9C5ymjadXt2HZvoammIbwr7ZR0NGgdcYk8rfP9rrqx7vXeFLfrT8m0bU8h8I
         gf1X1RG/uv1jMHBfQEKaw7lEAxZLkgwV8kW/pRuVptcZ4tm53wx6DZWNyejuduQ17LXb
         FGqO7bi4WTTfZvekHpuwJL5cObHQubgqdss8vugVQqKRXyjh7GL9rC086F128/HhYyDp
         U1oU0vTV6JnAMWxiWSZuho9uXddBe5m76yfGf91WJ6UJXAGjqAz0W3jWfCYlOiGfjrNY
         uynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293595; x=1768898395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+fj7WSVo+++50SkOvqVSUFrjMl6bqMv8voXQsnVi/c=;
        b=uJTsJlscISASenD/TD6ryxx1NmgfLHwqQRrAr/xDJylr2XQUDNfiYYU52X0Qm6xftW
         TjwTwrQFGE6llfieAZdxvG5fj/m9h5uosTW+Ths+EfHdtSlXdZzBxf0hpklwy+mMwqC3
         UKgpiBGmbrgWOqRVhdLQ+E6TW7XDRQj+BSbWqO213Y4x9XzBnV2BaHHUBUB9yTwsazDo
         Ga6teo9eUaLFFonswzdn48S4/K5CylHwZqouHauOeRCPAAXSRgfUrqj3m5nhRz1dc98Q
         CV+//MkF3iex85QWX8Iu7nvBlV41zXE/6J+pfFeepA588Pe8C3TIGCn2iez/+fR8dwJX
         Gmzg==
X-Gm-Message-State: AOJu0YwDarxdZjUexKZ9VTfDl6lVFZ/lnvHwfJZpZhzG/mfLNQl+0PSp
	OzbDNYP1nDDTbxUfES0QdAESU3Etz7cTto4SaKAcyuLwI1phVPKuzThBakIV+Qac4ia57g/p1hd
	wkgVkIK2+Wg8ReeHYSDRDWO7d3l4WKuAmqxN5G2A25Lj8nEVVKnlUV1Y5qYyG/oTdjUbP2F1pKR
	asoEhkgvXq2wpD6LIkLm91fkVBtVZoR0i2UrRbwdEbgsRPOU99aBN/dqz1tDSHRoqn5sMayw==
X-Google-Smtp-Source: AGHT+IEcfMTJ4hLwjoxy/n9lghXub3qsDnSA9dndqQunRT4nmhy4OWxfySRFcVmQH2jusiIOt4eHO9NCYFSDeIf0+mmq
X-Received: from wrbei5.prod.google.com ([2002:a05:6000:4185:b0:430:f5ea:d30b])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c1:b0:430:fdc8:8bbd with SMTP id ffacd0b85a97d-432c375b0c7mr25470964f8f.41.1768293595490;
 Tue, 13 Jan 2026 00:39:55 -0800 (PST)
Date: Tue, 13 Jan 2026 08:39:48 +0000
In-Reply-To: <20260113083949.2502978-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113083949.2502978-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113083949.2502978-2-mattbobrowski@google.com>
Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

With the BPF verifier now treating pointers to struct types returned
from BPF kfuncs as implicitly trusted by default, there is no need for
bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.

bpf_get_root_mem_cgroup() does not acquire any references, but rather
simply returns a NULL pointer or a pointer to a struct mem_cgroup
object that is valid for the entire lifetime of the kernel.

This simplifies BPF programs using this kfunc by removing the
requirement to pair the call with bpf_put_mem_cgroup().

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 mm/bpf_memcontrol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..f95cd5d16f4c 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -13,12 +13,12 @@ __bpf_kfunc_start_defs();
 /**
  * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
  *
- * The function has KF_ACQUIRE semantics, even though the root memory
- * cgroup is never destroyed after being created and doesn't require
- * reference counting. And it's perfectly safe to pass it to
- * bpf_put_mem_cgroup()
- *
- * Return: A pointer to the root memory cgroup.
+ * Return: A pointer to the root memory cgroup. Notably, the pointer to the
+ * returned struct mem_cgroup is trusted by default, so it's perfectably
+ * acceptable to also pass this pointer into other BPF kfuncs (e.g.,
+ * bpf_mem_cgroup_usage()). Additionally, this BPF kfunc does not make use of
+ * KF_ACQUIRE semantics, so there's no requirement for the BPF program to call
+ * bpf_put_mem_cgroup() on the pointer returned by this BPF kfunc.
  */
 __bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
 {
@@ -162,7 +162,7 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
-BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
-- 
2.52.0.457.g6b5491de43-goog


