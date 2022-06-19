Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E750F550BEF
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiFSPut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiFSPus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9ABC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so3529986pjg.3
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0+f5gHUcy4bOB49vr1foYREOsrIfIZFQCWb5SF1+Ms=;
        b=PosIsDNdyLPWrPtg4PrzsAVZoAXqL2g++Mki03DgUE/qzNvRlT8FvxmWGhIXyf6B2T
         S+SGm6A/MYaN4Zn5mylTRYZhOedr+gMVV9L3mcYuPJNxgmFgdPDfdhawpUff+Y38Jwya
         Wiw7zb7ZXfLw1RfhEv7uJtWYkhVtM/nG07kn9Q4PDgpVkpXzuZGjfwVCYD1PCstIVplC
         3otx8kHv/cT0JpSNR9jDnw9x6LkkKJEHOLWrGwz/f1QXVprH7lWzBKcAqLQvUO0ZpdFa
         dez3HpGdPF7mH0pBtpM1IEsYhUhO1zgdUcgI4KeKXlM58/nk/5Lr5fsT/kzxW3ErZPBD
         4EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0+f5gHUcy4bOB49vr1foYREOsrIfIZFQCWb5SF1+Ms=;
        b=l6Orc66aqyGwXqDrOjOc4V2BSWRg8fT0Th0etckqxA8N8aCqbstti1IUhLaVk8wYn8
         YXLDEH9pn69HhEw8gsmo0fZkdSnEpT24feB85A5yioj+irr7jojjtFgArhAWn+bE2YuJ
         VyhLck3bhZe2lAl/ankwwpBlT5wntqRuAFK+HKPxiprHHy6HM5KS88Rrn52IyoqHbHoT
         S671UKnrp5ml4AwYtACuCL49+eCNLxuqeT6BzYZuz82LAQcRndryGOn4I08Gr/qNEEzp
         BQqRge5dZxV+DFNUN6yosOxwo4CXLHww+Jucs34M7EvMIRnpLCk2p+3MRVYuqzQLOGrX
         7jxQ==
X-Gm-Message-State: AJIora8O3DmJnxzhtZEYrFM0dVIdMtPliK0Gq4KGvXHK2eUPyfptUtbK
        mxGJotXBFiubN16MaTDdbPM=
X-Google-Smtp-Source: AGRyM1sgtmrxoQfyITPlN/cfCgNmFWaIyPAqg6YjtKB9WTJgFrN1BLBYKOAWHzXeDwKE2MMfkvG0wA==
X-Received: by 2002:a17:902:7d8e:b0:162:22ff:495b with SMTP id a14-20020a1709027d8e00b0016222ff495bmr19627141plm.1.1655653846678;
        Sun, 19 Jun 2022 08:50:46 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:45 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 02/10] bpftool: Show memcg info of bpf map
Date:   Sun, 19 Jun 2022 15:50:24 +0000
Message-Id: <20220619155032.32515-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf map can be charged to a memcg, so we'd better show the memcg info to
do better bpf memory management. This patch adds a new field
"memcg_state" to show whether a bpf map is charged to a memcg and
whether the memcg is offlined. Currently it has three values,
   0 : belongs to root memcg
  -1 : its original memcg is not online now
   1 : its original memcg is online

For instance,

$ bpftool map show
2: array  name iterator.rodata  flags 0x480
        key 4B  value 98B  max_entries 1  memlock 4096B
        btf_id 240  frozen
        memcg_state 0
3: hash  name calico_failsafe  flags 0x1
        key 4B  value 1B  max_entries 65535  memlock 524288B
        memcg_state 1
6: lru_hash  name access_record  flags 0x0
        key 8B  value 24B  max_entries 102400  memlock 3276800B
        btf_id 256
        memcg_state -1

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  4 +++-
 kernel/bpf/syscall.c           | 11 +++++++++++
 tools/bpf/bpftool/map.c        |  2 ++
 tools/include/uapi/linux/bpf.h |  4 +++-
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e81362891596..f2f658e224a7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6092,7 +6092,9 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__s8  memcg_state;
+	__s8  :8;	/* alignment pad */
+	__u16 :16;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d5af5b99f0d..d4659d58d288 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4168,6 +4168,17 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (map->memcg) {
+		struct mem_cgroup *memcg = map->memcg;
+
+		if (memcg == root_mem_cgroup)
+			info.memcg_state = 0;
+		else
+			info.memcg_state = memcg_need_recharge(memcg) ? -1 : 1;
+	}
+#endif
+
 	if (bpf_map_is_dev_bound(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
 		if (err)
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 38b6bc9c26c3..ba68512e83aa 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -525,6 +525,7 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 		jsonw_end_array(json_wtr);
 	}
 
+	jsonw_int_field(json_wtr, "memcg_state", info->memcg_state);
 	emit_obj_refs_json(refs_table, info->id, json_wtr);
 
 	jsonw_end_object(json_wtr);
@@ -615,6 +616,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 	if (frozen)
 		printf("%sfrozen", info->btf_id ? "  " : "");
 
+	printf("\n\tmemcg_state %d", info->memcg_state);
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e81362891596..f2f658e224a7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6092,7 +6092,9 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__s8  memcg_state;
+	__s8  :8;	/* alignment pad */
+	__u16 :16;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.17.1

