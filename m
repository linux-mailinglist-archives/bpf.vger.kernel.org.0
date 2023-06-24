Return-Path: <bpf+bounces-3350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F873C67F
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90F6281F4D
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65F4428;
	Sat, 24 Jun 2023 03:14:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057267F;
	Sat, 24 Jun 2023 03:14:14 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE1E47;
	Fri, 23 Jun 2023 20:14:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1aa161c3796so1213550fac.1;
        Fri, 23 Jun 2023 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576452; x=1690168452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZj9kRSuBlBukl9uM0KLWNA4kwPzrxPQ9TSaIxf8hKQ=;
        b=S518s2v2/AxnQdou/ec0ySauX36NoAlE9dwdT3v6e56rWscgtPySW+6m3ow/KY0kTU
         ncwz/apbtHT2qzknWQCRRgaxzgvLcIbhsj0oDdwJYCs+l0Do0zYD3OcSJ82Tj0VpLQ9M
         pRB/JitwBMm9gDsd5dl77JE4rHZf7xr9AnNM5ztivU1l1CHKlMHrPHuKOJLZyBpj5m74
         9avVzPuBuPZTK5fUP4KvKoAjaXPqKkB3sUGH8a77AMButL7bm/rx6gPjUhSubwHBQlj3
         d55vTjgiTQjE/2vVBKK0E3Udpek7eISn3EfBbPYanfUNRqs3GRAKMWAOqGJi+0MFjXPX
         QsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576452; x=1690168452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZj9kRSuBlBukl9uM0KLWNA4kwPzrxPQ9TSaIxf8hKQ=;
        b=QblBKYPyz9oQ4ZIIWp1WujDLqls9xNYrCKARYAz1KWXzHNcbbxoGZEIxk2TAP0fVgi
         xuMudFOyhmhkZpBmmQe9U7IL4geE6JrKHpMP4FmzgA/4Kwtc5/F8II/ZVHyrzI2mCzWk
         jct6PotFlLYbgbAMeCIhNF5/YnMCdahePki3iw+5tSE4aQMXq/WArnn/1g1zZJTNNzDV
         dOBD1L36ahbU+9xJYV5rz81iW8qWbYMGReAwXIKFnSSztqssiy/bgD/xBkqPmUFHt2Q8
         Ol/BiW+QHthHeSQpBmeYAY+f+4IU5uqcCvZr+4oMbKgh3uau0gy01RAEeXdwqVwhWEWB
         F0Cg==
X-Gm-Message-State: AC+VfDwYKR+edrQ6+qx6ljvsJqi/0I3zMBg5VsTMZIgQPPOVoKa3KctV
	0oVEPyguZhBSSXkKrv+gsos3kRt7DJU=
X-Google-Smtp-Source: ACHHUZ5d0cUQNzbtP0/2qASt0GxeEAHYs65WJsM2C8LQcbeUMy92C/1iI1zKAN+ogAY1eAAES9n+CQ==
X-Received: by 2002:a05:6808:1cb:b0:3a0:3e86:3c with SMTP id x11-20020a05680801cb00b003a03e86003cmr12249246oic.56.1687576452342;
        Fri, 23 Jun 2023 20:14:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902b70300b001b3d6c86ffdsm239753pls.156.2023.06.23.20.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from waiting_for_gp_ttrace list.
Date: Fri, 23 Jun 2023 20:13:29 -0700
Message-Id: <20230624031333.96597-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

alloc_bulk() can reuse elements from free_by_rcu_ttrace.
Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 692a9a30c1dc..666917c16e87 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	if (i >= cnt)
 		return;
 
+	for (; i < cnt; i++) {
+		obj = llist_del_first(&c->waiting_for_gp_ttrace);
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (; i < cnt; i++) {
-- 
2.34.1


