Return-Path: <bpf+bounces-3428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DF73DB7C
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B111C203A4
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A86FDB;
	Mon, 26 Jun 2023 09:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133A7464
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 09:36:26 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA083
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 02:36:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so39834545e9.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687772180; x=1690364180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgXOZCXKndEggjP9LiNvIHs/0i4ezXkyiDO9lSkZ98E=;
        b=QBR7pbkpc1WjuAylrrlDch3ozXXkHTMaFw090iF4Kv415j+WTDygpbg1Qww6jCJa89
         iDmxc/MpLwrWaTO0Ecx9P1NXAxaKIEfGXPZLPjgpcOWpugIODyagt20rLrXSShcsGW89
         pbqIZuB1ogKYIoX4bH4lA9shlP+VPsAGed1p5xYk5Iw1md+HVnKy6WGa/d2S3FZInmqs
         7ZRbOPCwDbBWK7h4Dt5F9ruZfgdWvazax9lIVtR6Bvv765yJp8e2A83aGOMOSOlm55Wa
         gXcU0D/4OkHb1BQYkmxTpFlWZBKPnCb44d7xMQa1Kv/f01Nh7xj+ESPktf5TU8/wWgMj
         9xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772180; x=1690364180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgXOZCXKndEggjP9LiNvIHs/0i4ezXkyiDO9lSkZ98E=;
        b=W37HTU8diP55gDU0U+BglQC+WO8ZtfkJsDhCkd8jvfOZlFDXyK/ueiBZNT6oS04UDo
         fhmFvUFV5Oa/EienYLi/uOhdxj2PEMrMQCQpJsDBARld5Yn0LQjOFjskhqUQzFjc0uaR
         ojZSt+rdwW53fQqqSVU2yf006izwP7gdvQypvCR6HCY1LQUv3mRpa3lryKVY/rnosbng
         AyxRtF/6n+8rd0IqIskkY5RnnFhxeTOB8S5Sx3qq5O9ELjA0ExV0IE56jd76Dynwb6AC
         6gmu7YkX2AC1k5BtJT4YzZYjtBWohhuNOWnZz2T5XQiwhJGzral115dxpuXb1onHvdmM
         K+AA==
X-Gm-Message-State: AC+VfDzccbHxf6SwvWkbANPTB7Zq2p10Sp5g+2RcVuDpp/z/J388ebw/
	t1VaBuMbQdS1ocP042nVmbk=
X-Google-Smtp-Source: ACHHUZ7xjR3QTDAACrtuVTeH48xC4zIdf+mQ9s9bAN79bZsIbPUAtZkjVkYzOURjoeVHQFh9mG+pxw==
X-Received: by 2002:a7b:cb4e:0:b0:3f7:f884:7be3 with SMTP id v14-20020a7bcb4e000000b003f7f8847be3mr22476686wmj.4.1687772180095;
        Mon, 26 Jun 2023 02:36:20 -0700 (PDT)
Received: from andrea-terzolo.. (mi-18-63-167.service.infuturo.it. [151.18.63.167])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c229800b003fa98908014sm1714306wmf.8.2023.06.26.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:36:19 -0700 (PDT)
From: Andrea Terzolo <andreaterzolo3@gmail.com>
To: andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Andrea Terzolo <andreaterzolo3@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCH bpf-next] libbpf: skip modules BTF loading when CAP_SYS_ADMIN is missing
Date: Mon, 26 Jun 2023 11:36:14 +0200
Message-Id: <20230626093614.21270-1-andreaterzolo3@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If during CO-RE relocations libbpf is not able to find the target type
in the running kernel BTF, it searches for it in modules' BTF.
The downside of this approach is that loading modules' BTF requires
CAP_SYS_ADMIN and this prevents BPF applications from running with more
granular capabilities (e.g. CAP_BPF) when they don't need to search
types into modules' BTF.

This patch skips by default modules' BTF loading phase when
CAP_SYS_ADMIN is missing.

Link: https://lore.kernel.org/CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Co-developed-by: Federico Di Pierro <nierro92@gmail.com>
Signed-off-by: Federico Di Pierro <nierro92@gmail.com>
Signed-off-by: Andrea Terzolo <andreaterzolo3@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..d793a1bfb70c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5471,6 +5471,10 @@ static int load_module_btfs(struct bpf_object *obj)
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
 			return 0;
+		if (err && errno == EPERM) {
+			pr_debug("skipping module BTFs loading, missing privileges\n");
+			return 0;
+		}
 		if (err) {
 			err = -errno;
 			pr_warn("failed to iterate BTF objects: %d\n", err);
-- 
2.34.1


