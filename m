Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCA6A45ED
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjB0PV3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjB0PVU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C722A2A
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so5942097pjg.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=V1VhTdVq/yi8VaxqYBcAmaGIldLBlYmDNHTbQfJ51ZjUuYni7H5iB5VEDkU3qAOAv5
         72qxS+yqTeO5aYyuIG5FFvakkBDDkMPTDE+0QKiJfkWSK//czstDqjcV3sA0PZA74jsD
         V1IpDyayPwLmf0dnmITQ3YsIn6y+VlMVwDfsx/qL2xNXLfBmx2sFnfxIis+1Zv7GxCnK
         cs4aPFJhcRYEL2ISO39JSTKQDC+b2cw5iJ0cwdMA2Ge8yv1cYmpu0DPs+ZMzgXUpX6vg
         iv9O1jRvGSQZJGA3GX2+VTWy+mbwEOTdD6Q2KONfchxh0EIexDJzzpano2D3WkM4XfJr
         YRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=49JRT/jE8pIxyXo0S8INlKYERlyM3LkQ/ay05UFG6mtrI47yXKaB5h4OSunTW6Lmly
         iu5agt9n1OMSX+4+RXO5TZmLVNGUES5/5C3rpY087AAJcMse5jiThnE4yz0aRBZ17V4M
         Rr2cFPz7oFO6YtoByX4r2vDsyW169EAgEx9qhWPEuyFUU3ZsZZ5M6nB8LCPAX5i7otXq
         04hsjzGJZxGFahWY0jzL2etd4aNGUS4dN4jsvJP/a2Ibuzv8Q1NGlllz8zNYY44UFwWS
         NeLLK4zlHb58tjiAarCjNFPpv5WOvbKrtBNOd6d0frEbPS0POM9M5Lr6HJVYsURVTuwx
         svlA==
X-Gm-Message-State: AO0yUKWzRyyA0bTSMw8l/8HkwREnsYUfamnggfas2et6MaVkC+vjc574
        xvn3ENyhd1uuiH0STp1Tuew=
X-Google-Smtp-Source: AK7set+DXiEwTIrO0ppF6lO5LzdmT7W94D4OTf/iKjo55kbMeBIQ+HzZCrsbZSJIibynCFgBaAqntw==
X-Received: by 2002:a05:6a20:b562:b0:cd:9673:9c07 with SMTP id ev34-20020a056a20b56200b000cd96739c07mr1182850pzb.7.1677511275752;
        Mon, 27 Feb 2023 07:21:15 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:15 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 09/18] bpf: cpumap memory usage
Date:   Mon, 27 Feb 2023 15:20:23 +0000
Message-Id: <20230227152032.12359-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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

