Return-Path: <bpf+bounces-35098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D4937B7C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B72834A5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460E146A6C;
	Fri, 19 Jul 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1C5kGof"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786E250EC;
	Fri, 19 Jul 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409683; cv=none; b=G83RFzLCVH4VOEzdx0jshRhGNIzJMW/rF2lbY7lZlJg3GXVf3cvIxYbS76Gzbex39wA720CQkdMZ/Lj7k7f+A/ZFozY02euhzjXkQ75GYSBkz2tYmt2cm2nqbbstt/AGZ4XumkVldPgnqiIp2LExFAYM8Nxr8Noy57KC7MkVi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409683; c=relaxed/simple;
	bh=MB0aCVmUQ8UX3TZWM489FzGEjJexdFys+uUChjT6zMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bR0Hq4gVYhZedKdDRSOJl+tVVd9W8FRWec5cCEHpj/jYJ8k4VzVGtLiSSqkxJh+VgLSkD1yJBC+t9y1srIEeqCv968wpdNQ1ti6me4Z+SsdRwxnNOQpN/Ud/CcTWLToAabl0e3L2Flu2mWzKJrdep/EVU999dCqUk2ZVm5bzUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1C5kGof; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f178351d4so102234785a.0;
        Fri, 19 Jul 2024 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409680; x=1722014480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnnoqihdiiFXM0iLp5z8P7RVvEO5j7eMHztDecgJH/k=;
        b=Y1C5kGofdbwUmGaCMaMVL2yCuemq8s126P5CjFiC1FglfP1WLrF0XSQNimlZEVPD0t
         aU1gGHJPdy8akKojUMzU0MI8JVFl/bZJZQQ5mPpypvcCO1aePqUqz1Wam+pI2Y0gHj/Y
         CwiOsimgtRF6mETwVV43Is5WVOmw+M8dYSxqAmMUcY9ghKj5j7apS00Q+pQl3GxdRRno
         I1MKBBbS+HUBs6/kEcTpbAMQqbUNX3lghbVMpfa0+zbb6EKLPe1X0Q5XBZoIQM2uFj+c
         9tCPTEEDhg6erlM7D7xcexieDl54j95OCiiAimiLN0B63ki3SsAWVUe5nyZ/zvhsY08H
         YEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409680; x=1722014480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnnoqihdiiFXM0iLp5z8P7RVvEO5j7eMHztDecgJH/k=;
        b=hnjJH54I2iIUgMv46KTDq4gojwXVhR38oGX7jtB61rsfhsFNXO+HP8mxgwvsW0WfNy
         AKUeyosakl0GlzsW656LJbrc1pFBw2R/EGT6yU1UqfyMfkAZJ433DINCn3eEPbtV6s0G
         wTvTSOjcIhMEUg3oK3K3+zMRyt4D/M5xVwN6PbCSn81v35nwBW8Xeg3kQRI9qnyVzXoe
         KsMhofVynl3qP+YbwQACwd7i4Iy29zJUNl1jG+LbhWsbuUfY7PqARnR7F8VJRGgLjGaI
         YHuZFSCKMTkccHk6uRvUAhtbJuG9XsaIeUWvesFMEn84+bpx94V5RVzq9Gvkr/6+DdCS
         aQjA==
X-Forwarded-Encrypted: i=1; AJvYcCUX39MAH6c5HglaeaMn4OJZSqmQrtaRE02zsYzREHtP6f225ZXrtvADHpO+6zqP2UiHUsEh3buTjh0f82T0y1k8gM+CeokXCbA0bPNhEPGFd3eRFK7ZSVRMsY7I
X-Gm-Message-State: AOJu0YxqUphDaZdbmzg27YwMKFJYh8SoYwsoxw9YXswSrtZB1uTAiM6b
	cnJFueiFwoSe6faBS/y8WSfN3heBzwSXTUlZVEAOJFRqy49DXNuIMffpEA==
X-Google-Smtp-Source: AGHT+IFm13LtSr5S4O3rZvUNck/f1UflPgKIWkpuBfrH6AtVZb5KNAWuRGCiHP+7OlFp3SNzJilxBA==
X-Received: by 2002:a05:620a:2584:b0:79f:77b:3a20 with SMTP id af79cd13be357-7a1a132c7a5mr62959785a.20.1721409680370;
        Fri, 19 Jul 2024 10:21:20 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905eb1dsm109706485a.89.2024.07.19.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:21:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	sdf@google.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	xiyou.wangcong@gmail.com,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	donald.hunter@gmail.com
Subject: [OFFLIST RFC 1/4] bpf: Search for kptrs in prog BTF structs
Date: Fri, 19 Jul 2024 17:21:16 +0000
Message-Id: <20240719172119.3199738-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently btf_parse_fields is used in two places to create struct
btf_record's for structs: when looking at mapval type, and when looking
at any struct in program BTF. The former looks for kptr fields while the
latter does not. This patch modifies the btf_parse_fields call made when
looking at prog BTF struct types to search for kptrs as well.

Before this series there was no reason to search for kptrs in non-mapval
types: a referenced kptr needs some owner to guarantee resource cleanup,
and map values were the only owner that supported this. If a struct with
a kptr field were to have some non-kptr-aware owner, the kptr field
might not be properly cleaned up and result in resources leaking. Only
searching for kptr fields in mapval was a simple way to avoid this
problem.

In practice, though, searching for BPF_KPTR when populating
struct_meta_tab does not expose us to this risk, as struct_meta_tab is
only accessed through btf_find_struct_meta helper, and that helper is
only called in contexts where recognizing the kptr field is safe:

  * PTR_TO_BTF_ID reg w/ MEM_ALLOC flag
    * Such a reg is a local kptr and must be free'd via bpf_obj_drop,
      which will correctly handle kptr field

  * When handling specific kfuncs which either expect MEM_ALLOC input or
    return MEM_ALLOC output (obj_{new,drop}, percpu_obj_{new,drop},
    list+rbtree funcs, refcount_acquire)
     * Will correctly handle kptr field for same reasons as above

  * When looking at kptr pointee type
     * Called by functions which implement "correct kptr resource
       handling"

  * In btf_check_and_fixup_fields
     * Helper that ensures no ownership loops for lists and rbtrees,
       doesn't care about kptr field existence

So we should be able to find BPF_KPTR fields in all prog BTF structs
without leaking resources.

Further patches in the series will build on this change to support
kptr_xchg into non-mapval local kptr. Without this change there would be
no kptr field found in such a type.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..967246ecd3cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
-						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
+						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
+						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
-- 
2.20.1


