Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07581FB461
	for <lists+bpf@lfdr.de>; Tue, 16 Jun 2020 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgFPO2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 10:28:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728917AbgFPO2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 10:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592317725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AI16rQVkD7Ajxg/nYxiVD6rmlKmGpKvCI2wJJ+04RQ0=;
        b=Zjcp9+1Yi0rPCW9rrJHLm3IRmsbZbt8VeCZrvj1ZntF/K3uVGgJBy+hnMLHRRHhaTYPX2q
        dfrwur1DI5BApIOnMDYv7vDznlVsOveCdRqZ0t7wY/DIXFALUpsUHxj2mhbNfsa9Q628lC
        tXYttNMyYuvOra1rpNR0Ng+LH8JcJjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-w_oY9-AJMvywK5z65a1uGA-1; Tue, 16 Jun 2020 10:28:43 -0400
X-MC-Unique: w_oY9-AJMvywK5z65a1uGA-1
Received: by mail-wr1-f71.google.com with SMTP id c14so8307445wrm.15
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 07:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AI16rQVkD7Ajxg/nYxiVD6rmlKmGpKvCI2wJJ+04RQ0=;
        b=DgnznjPp4byiyC+30EJrHjxK2WZX3KQilycYy/U3CsmIHzhDRWvlVesn/jyOwiNuSO
         7LrUDehdY5zBk82dQ8WtPbI1dU4Djqcbmcxij7f496lHEP/TkfPnDAK3J5uqmkntZJ+j
         kHVCF2B/y2I2jGS+9LUuHX9r3q+RqdTjfKkEGMPgl75Sk48O+LRUu3Gs77GuUiQXhB2P
         q7zFQMu5O+jnfbX0GjBstzLN5Rc0n337smJquLIt12FAicmYgNn/ONLM1fn3EilE6UbE
         PJMqd3QF2cQH03PQOK/A1Ncly0nwkuz0JB55nAYXRDIsoKPT3m+z829rZxL3N+Db3iHR
         xslw==
X-Gm-Message-State: AOAM530OwwuYsvOScAhO+R6CLkM05faA6oGX1+Euqk6NkgnxTRaus9rE
        adLldlk9SXvwS82Lo9owH6TZoCYpUmmIm7My1Mx+E+Rul5n29hFyM314S4DwKSxToM4xGDaFoJE
        bTcFj8yFHwsEI
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr3520694wmi.0.1592317722134;
        Tue, 16 Jun 2020 07:28:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwQmy1lYG/gWNoBlK1yHHWXCKIpburSaJAz2yR+SMxJuNNKnChnO8WdefVi0oKx2gC6DZcig==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr3520679wmi.0.1592317721896;
        Tue, 16 Jun 2020 07:28:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y19sm4025678wmi.6.2020.06.16.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:28:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D1B0D181513; Tue, 16 Jun 2020 16:28:39 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Xiumei Mu <xmu@redhat.com>
Subject: [PATCH bpf] devmap: use bpf_map_area_alloc() for allocating hash buckets
Date:   Tue, 16 Jun 2020 16:28:29 +0200
Message-Id: <20200616142829.114173-1-toke@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller discovered that creating a hash of type devmap_hash with a large
number of entries can hit the memory allocator limit for allocating
contiguous memory regions. There's really no reason to use kmalloc_array()
directly in the devmap code, so just switch it to the existing
bpf_map_area_alloc() function that is used elsewhere.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 0cbb72cdaf63..5fdbc776a760 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -86,12 +86,13 @@ static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
 
-static struct hlist_head *dev_map_create_hash(unsigned int entries)
+static struct hlist_head *dev_map_create_hash(unsigned int entries,
+					      int numa_node)
 {
 	int i;
 	struct hlist_head *hash;
 
-	hash = kmalloc_array(entries, sizeof(*hash), GFP_KERNEL);
+	hash = bpf_map_area_alloc(entries * sizeof(*hash), numa_node);
 	if (hash != NULL)
 		for (i = 0; i < entries; i++)
 			INIT_HLIST_HEAD(&hash[i]);
@@ -145,7 +146,8 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 		return -EINVAL;
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets);
+		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
+							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
 			goto free_charge;
 
@@ -232,7 +234,7 @@ static void dev_map_free(struct bpf_map *map)
 			}
 		}
 
-		kfree(dtab->dev_index_head);
+		bpf_map_area_free(dtab->dev_index_head);
 	} else {
 		for (i = 0; i < dtab->map.max_entries; i++) {
 			struct bpf_dtab_netdev *dev;
-- 
2.27.0

