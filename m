Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8A69EC7D
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBVBq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3432E6E
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q189so3265943pga.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=p6cdTntq/+UKAYDZkuZMHRxIv+3w64C/qWNBgJKaUx7mX8kqM8YwH+E6u3vu0g6OpE
         TWWS2jzjlLnKe1/Pm0eOyFhOppwqQy/52hY5lZxDa/h44LgXSTyZXbTIMQEQ0jJW2pKP
         EHZN/l+h0CDP96zZsYpIP+OwnJjhzIfZxBJ5yATnZ8H1mTQ95eQMt6hLEwX8m511nUtA
         EsXzPCB/GnUWPfyU/fSdQenBQ/8fcbe9T/Mj3JMciJKe6C8xX1LCHzuLaVYkvEzgHwvU
         qX02XEOCNmyx/3ZadXH1CbKeuuLVD0HXM7H2itudfFjpa1PJzNkzka6IlYY9mRa5U4BJ
         lv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=GTfFTj4EFINXKJEaZlTl8dHR7Vrx3TN0EKnUTkGkOcmzKBxtwUdQ0ClqjP/Rsw78he
         LMTycSUBwZ4GgB6Qe/WgcBbAGZAh4h0OSKlO/ZSy7MlsuLscuYI042PkMP3Z9GSsw9rw
         1sOaW1GD4PN9pVEi0nqmnIlr2Ka3v9OLb99NUeWivkef8sxOz+iV4+CMdNI/urytKr5i
         uNT3iHMzmtVZTNW4U1WsGNEYcFkA/HvoT6SiZYJbJc48ABLKC3KyqoxEzw2bnxo/fvxe
         tlilnF6gDCnqn1S6y8vlVMgViO2YL/xBeCLc/2N/D4hNGbn9bEvb7POvXWAoa8YMexOA
         pr0Q==
X-Gm-Message-State: AO0yUKVjjGfiE5Zi1DFtPeUoBZ+Ha/mxW2s9GtQiQuaE6ojPyrw03RPX
        AAGUbli0vzPiQXnKbTD4inA=
X-Google-Smtp-Source: AK7set+EVw1+CQlkN4CWxt6lNtJn1UDJBGpS/2ScJ7JO6Ot4bX2CkJHtS3WiAzRfgI3HTC6ve9A3aw==
X-Received: by 2002:a62:1b4a:0:b0:5a8:ada1:cc6f with SMTP id b71-20020a621b4a000000b005a8ada1cc6fmr5407148pfb.33.1677030414264;
        Tue, 21 Feb 2023 17:46:54 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:53 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 09/18] bpf: cpumap memory usage
Date:   Wed, 22 Feb 2023 01:45:44 +0000
Message-Id: <20230222014553.47744-10-laoar.shao@gmail.com>
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

A new helper is introduced to calculate cpumap memory usage. The size of
cpu_entries can be dynamically changed when we update or delete a cpumap
element, but this patch doesn't include the memory size of cpu_entry
yet. We can dynamically calculate the memory usage when we alloc or free
a cpu_entry, but it will take extra runtime overhead, so let just put it
aside currently. Note that the size of different cpu_entry may be
different as well.

The result as follows,
- before
48: cpumap  name count_map  flags 0x4
        key 4B  value 4B  max_entries 64  memlock 4096B

- after
48: cpumap  name count_map  flags 0x4
        key 4B  value 4B  max_entries 64  memlock 832B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index d2110c1..871809e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -673,6 +673,15 @@ static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 				      __cpu_map_lookup_elem);
 }
 
+static u64 cpu_map_mem_usage(const struct bpf_map *map)
+{
+	u64 usage = sizeof(struct bpf_cpu_map);
+
+	/* Currently the dynamically allocated elements are not counted */
+	usage += (u64)map->max_entries * sizeof(struct bpf_cpu_map_entry *);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(cpu_map_btf_ids, struct, bpf_cpu_map)
 const struct bpf_map_ops cpu_map_ops = {
 	.map_meta_equal		= bpf_map_meta_equal,
@@ -683,6 +692,7 @@ static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 	.map_lookup_elem	= cpu_map_lookup_elem,
 	.map_get_next_key	= cpu_map_get_next_key,
 	.map_check_btf		= map_check_no_btf,
+	.map_mem_usage		= cpu_map_mem_usage,
 	.map_btf_id		= &cpu_map_btf_ids[0],
 	.map_redirect		= cpu_map_redirect,
 };
-- 
1.8.3.1

