Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A169EC78
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBVBqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBVBqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE032E6C
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d6so83016pgu.2
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4L8zLEmMO4gVgjC79EcUNMmrd+fUR2UoiFuFPERS2A=;
        b=pmeU3NffNp7hK7taZoa/INyhyQkHHHNiQ3asSO9CNXmSRxL3isLEpNTcHzG6pPfeDZ
         xSkwg/0cE6QxIijWCoOdgC9VLHCM6RaeJhbluzkrg+VCGKhsagDsG2XPaK9NYojs0OBv
         SndDTpDGN5nSEWF/haHNx4KcTXWj/iOpimnedxJ/9lU4WzDg1qUwctm+lmSCGe0tZBv1
         3BCfg91pe7tZoeKsZxsb4R2SzqYWYwS00Fk6xgWyylnzzn3S7KXb9cbc1vpcPKQpMSbQ
         XLY2/I61py9aeuiFsXWjoT2MZmX1n3EoR4RrOqy16x+2kwXcKDEpAM+c+dMkcvfD9g5W
         fikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4L8zLEmMO4gVgjC79EcUNMmrd+fUR2UoiFuFPERS2A=;
        b=U68mMQoMVL86c2nSSK+RNfpNJQZPSWMdDBLqvS/CNiZmaFaC8VqKyZBo1u7LknGJhV
         rzBZL1Jvh3DtJsGoS8wYqSWv9qR33hZ6I54nMmYd+kKUbHSsZCtY8qU4eUlxf5Us/9oa
         s0mmVLbcZXov/0XQ02mQmZq/vPTH5Esr4zoYgru6zD+JWElb16qxg8HDIhRXLULCekfE
         Q7Qv088QnkNmOHQCvHq57n0pLVuCGxW0pz8QC5xM5j/jwtO8+aP3mJp/8aSBCqtPw7rM
         47oEM1AxQIPRxLMiW/maMH6gHK/4b9DcMVqHIa2s/81TWzBfqyXFmJDt/YyZVjMBq++S
         6arg==
X-Gm-Message-State: AO0yUKVQCrkThxkwFDTHnONE1783MPi0vEBfaFmLt95n+iSs2jAmrYyQ
        y+SVnjyRi+ycJpVS1PgiwL4=
X-Google-Smtp-Source: AK7set9MqmLbJeHFZK9OC+Po//rCkMNyB8mSx/YSwrw9IRk4IIoVzjVASw8qq06feC7qD9JbLIg36Q==
X-Received: by 2002:a62:52d0:0:b0:5a8:68c0:5607 with SMTP id g199-20020a6252d0000000b005a868c05607mr4321827pfb.21.1677030397020;
        Tue, 21 Feb 2023 17:46:37 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:36 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 04/18] bpf: arraymap memory usage
Date:   Wed, 22 Feb 2023 01:45:39 +0000
Message-Id: <20230222014553.47744-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce array_map_mem_usage() to calculate arraymap memory usage. In
this helper, some small memory allocations are ignored, like the
allocation of struct bpf_array_aux in prog_array. The inner_map_meta in
array_of_map is also ignored.

The result as follows,

- before
11: array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B
12: percpu_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 8912896B
13: perf_event_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B
14: prog_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B
15: cgroup_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B

- after
11: array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524608B
12: percpu_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 17301824B
13: perf_event_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524608B
14: prog_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524608B
15: cgroup_array  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524608B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/arraymap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 4847069..1588c79 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -721,6 +721,28 @@ static int bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_
 	return num_elems;
 }
 
+static u64 array_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	bool percpu = map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
+	u32 elem_size = array->elem_size;
+	u64 entries = map->max_entries;
+	u64 usage = sizeof(*array);
+
+	if (percpu) {
+		usage += entries * sizeof(void *);
+		usage += entries * elem_size * num_possible_cpus();
+	} else {
+		if (map->map_flags & BPF_F_MMAPABLE) {
+			usage = PAGE_ALIGN(usage);
+			usage += PAGE_ALIGN(entries * elem_size);
+		} else {
+			usage += entries * elem_size;
+		}
+	}
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(array_map_btf_ids, struct, bpf_array)
 const struct bpf_map_ops array_map_ops = {
 	.map_meta_equal = array_map_meta_equal,
@@ -742,6 +764,7 @@ static int bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_
 	.map_update_batch = generic_map_update_batch,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
 };
@@ -762,6 +785,7 @@ static int bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_
 	.map_update_batch = generic_map_update_batch,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
 };
@@ -1156,6 +1180,7 @@ static void prog_array_map_free(struct bpf_map *map)
 	.map_fd_sys_lookup_elem = prog_fd_array_sys_lookup_elem,
 	.map_release_uref = prog_array_map_clear,
 	.map_seq_show_elem = prog_array_map_seq_show_elem,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
 
@@ -1257,6 +1282,7 @@ static void perf_event_fd_array_map_free(struct bpf_map *map)
 	.map_fd_put_ptr = perf_event_fd_array_put_ptr,
 	.map_release = perf_event_fd_array_release,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
 
@@ -1291,6 +1317,7 @@ static void cgroup_fd_array_free(struct bpf_map *map)
 	.map_fd_get_ptr = cgroup_fd_array_get_ptr,
 	.map_fd_put_ptr = cgroup_fd_array_put_ptr,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
 #endif
@@ -1379,5 +1406,6 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
-- 
1.8.3.1

