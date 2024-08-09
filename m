Return-Path: <bpf+bounces-36740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EA94C7CA
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A745B2068A
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117188BEA;
	Fri,  9 Aug 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfR4emZT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC73D6D
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164708; cv=none; b=gFfhP7sSL0id4zzq0gFawzPr9C7sumAIPS04+14+OXLcySbKH3CZMvrQvipNxdjip6GiBKea/xFTw7s0U1VPNc1mEWx9Up1dswwJfNEt4Rp4q/n/lU0nDR+LDOmcqHpRKXqXnsOaX7QsTAWV4vyn3UTTBu2tZIluU2hdm/B2Wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164708; c=relaxed/simple;
	bh=IpLSk3jSK5NyCFqJjnJH9W9P1Ev0KOpgLVSsUyuG/TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZTEzlMNeM5s0yvFN/HpFsba4ltla3n5HurX1NWcvHbdKNudHobhLsTVy02pIr/b6OTYBb98Z+n69piscLbEUnFWBqQL0bnBAs7Kyvf/SxrLCntVsRQBWySMzAkllc/v0SK3Wslz8nsrmwfIBL6XY7MrJHgCeQFa6Nnuz+5Moa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfR4emZT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bb96ef0e8eso8415046d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164706; x=1723769506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVANk0qcPcnFzzYVCHvRt+g00d4r6j9NIGZqOCp9Tu8=;
        b=JfR4emZTQ8R3DQrdgEfSB+2HuQhKQw1V9JD/pPvNjvfL3lA1dQSiYPg9MK7uEI0P1V
         FGAGKKBc5+nyRU7qYnMsn2rawnEOj0dP9vlo66YC7N3MhYzbx0xUbKj4JbsSccmrkimE
         6PsnrQy/Ja7jkh4wl3xJozWf2pvHNNyH58Jd9I7zyIYQwPlu9RQVZs8gt5z4CYQPsaHR
         2BA+c8SLOTc8mw5G87075pYFdgoiX1Ghwwan+YnlAia+SJHa4pGxwpdq4JAAGy+tAR+C
         jD7JcIIo98QrXaI1sj5mHY36mJ/nb90n/igYpd42TY4Fv0NpK/A5smrQGZqXaK1HN6as
         ZYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164706; x=1723769506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVANk0qcPcnFzzYVCHvRt+g00d4r6j9NIGZqOCp9Tu8=;
        b=nRCH6/npe10LPIVwp73/msmwCJs0GTHWKCSGZ4A05TVnK36ThvdDvfV+4dnTippk2l
         hGLiECtXCh81h2dRjhc0iy1yEeZRPZB8ZvH0q+qRLT0NRqEUwbgAvXmph6JI/yl/3WEv
         lrRVztXTZkXdCA1pimwJydl+Gqt9tzF8KeMgUxizXKFtbkmT+Llny9xWqcxCIZawgTTk
         qrPWPA29atkBoYF6Zz3BUdkaRdKy9o7xHZs7D7+KiuQZpQ47I99K0aGFPAfNyddbqfT3
         DJSlbHk8dlzcZ45xWIc2geh22I1FvRBht/Sjl+LPQvYmZyMhmZbeZto5uk9E0KD4rYt5
         fiGw==
X-Gm-Message-State: AOJu0YwD9gfBPVRwLJdddGqQ8/Ssf26VVBSrOVD/B02PXth1giC4Y6r1
	Z2iL/4E4+zgPDkqU/A+cfXgvByWLD0HDkKCqBcpgCg3vXk4MVzUY+iRQtw==
X-Google-Smtp-Source: AGHT+IHeIRkem4EAypQ6pWaN/BUemwYKvKCXtphX/iw5loceXIKjOjFDkEj39RKKHSyZ6W4A2Mh6PQ==
X-Received: by 2002:a05:6214:5543:b0:6b5:8dd2:468b with SMTP id 6a1803df08f44-6bd6bd97f37mr51967516d6.44.1723164705745;
        Thu, 08 Aug 2024 17:51:45 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v3 bpf-next 2/5] bpf: Search for kptrs in prog BTF structs
Date: Fri,  9 Aug 2024 00:51:28 +0000
Message-Id: <20240809005131.3916464-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809005131.3916464-1-amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
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

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index deacf9d7b276..afc53ad396ab 100644
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


