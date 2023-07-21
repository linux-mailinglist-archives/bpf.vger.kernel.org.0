Return-Path: <bpf+bounces-5598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591AB75C307
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA91281B5D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8C168CA;
	Fri, 21 Jul 2023 09:27:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742B14F8D
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:27:40 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19B30C0
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b4749013so12943665ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689931659; x=1690536459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SzaVf3iIkXgT8Et6pffHRJVL/6iJNQI7JYg7ZnqEBQ=;
        b=mvi5teERVDolf5p3bnm438xtUsUMb+w1mfdir+k2KSwoy+8Mn9c88u26jNISEyYc8D
         dwlNqlD64D3d4YJPPor+eJoyzfq2uQhRCSZ1zbCLsEv1FnGRhEY7d4z1tpRrqTvX7P0S
         RPHAm33eMRvh9GqssYADLUhNAtsgWqy1aAS8k0wryu/xhkZIH+j1tCU9bpgMX+uPvWsS
         LcKC8htljno/X2au2EOpgWGCB/CCEVAGqHO8sd45gl52BSjASQF4duPXT8XkkIGD6MAJ
         zngFQyGWRcH1H8zFZX4bwGumeAekMkt88yNZIYReKb5371L3L9JCjrdNj7A+/UStd/oF
         g7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931659; x=1690536459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SzaVf3iIkXgT8Et6pffHRJVL/6iJNQI7JYg7ZnqEBQ=;
        b=GSB/6Puf9fcSwtYuEDrhWdFwP3j11CBOPIYCHh9uA3fetYZxMY4iPZ/e9U8ZhepPoP
         PUKL7FDn8ohpEhGqYcyAUTot6qHcarzljoRgq4G9c8ML9xRxcGWCHAyYffbNONAMLZvw
         XzQLn82xm8Ds+zS+Fy4cTriA/6TiMj2WO9MVLqLuaqLeWiOb9t0XSqQQe6hs2coJzcxL
         QmtyZBULr1DDskt19Y53FOS4lDApUKt9EfFk8vmmHec8uFic7A2FAOkX4r8U8U1/qegW
         UqHfOZN9YaYoes68sxpYYLi6//tZQRCOQ0D13AEHEMfhApOAlL9KcNVd0EmbdUxHv009
         GMYg==
X-Gm-Message-State: ABy/qLaoU4ZFG5XmxR5Pxkmk4n03xqLS1hDpdmbqyr1+V8e25+AOI6QU
	MjuN1KqLGnqnHoudJBY8c+M=
X-Google-Smtp-Source: APBJJlFkuwRH5jyRc1+wu5iH4H/FH69yn+7D3qaqVuQxtlLqX0qom4Cn+rfpYqKYKZuU8ahX0Z1SLw==
X-Received: by 2002:a17:902:ff02:b0:1b8:5a49:a290 with SMTP id f2-20020a170902ff0200b001b85a49a290mr1297154plj.43.1689931658645;
        Fri, 21 Jul 2023 02:27:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1303:5400:4ff:fe83:cf8a])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm2911072pls.285.2023.07.21.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:27:38 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Fri, 21 Jul 2023 09:27:24 +0000
Message-Id: <20230721092725.3795-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230721092725.3795-1-laoar.shao@gmail.com>
References: <20230721092725.3795-1-laoar.shao@gmail.com>
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

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

    kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
    error: uninitialized symbol 'type'.

That can happens when uname is NULL. So fix it by verifying the uname
when we really need to fill it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c3..ad9360d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3376,16 +3376,16 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 	size_t len;
 	int err;
 
-	if (!ulen ^ !uname)
-		return -EINVAL;
-	if (!uname)
-		return 0;
-
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr);
 	if (err)
 		return err;
 
+	if (!ulen ^ !uname)
+		return -EINVAL;
+	if (!uname)
+		return 0;
+
 	if (buf) {
 		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-- 
1.8.3.1


