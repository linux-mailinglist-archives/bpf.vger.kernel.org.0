Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91106EAF1E
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDUQbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjDUQbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA414F4F
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f7a0818aeso254607166b.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094680; x=1684686680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF2wdY0uirUnTvLTnOfvh/2+qPjtNw3YvfQUsz1mrYI=;
        b=gV3d9lV123bpc+iTV1V0ee+awTsgmb3rDexVrMacQahDbXeLfXr4Ktb/pArdm8yraK
         zqkFfzAAtgv/jIME1bEuKFjjXK5R+KknM1vXg1lwyyyXWEabeBXE7DGTMNeEZnFWq9oy
         cL9JjCcsC8uzcxyztLkilIVyyaaW0WG21icogXwBrzNCHS0v00tF9SS/lpww8+/LdypT
         V4i3eT9r9wuGqMABacuA4c92ViomzIB4Q/T6oZYc3ZVeOzTUq4g0ifmdFgLTB+eMr7eI
         3mgOe1PhnJLnPPyr1mwsSdtDJrkWHy23hJTqFIR4uhLz/AmwTHoKn8Ggb2GaLOmUwoin
         fVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094680; x=1684686680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF2wdY0uirUnTvLTnOfvh/2+qPjtNw3YvfQUsz1mrYI=;
        b=GYE0yjiY8UK+4NJE/f8+C9/jD08Tppwih+dncvEK4cpJ1ghSbh9xB+bKr5P0RwBnSp
         hLVkWdSh3pUl9Y80Opf4mkoQbjuXvx1O8IGDD6P2ci3dfT6X9vPYd/q2QZlYjLa01rUN
         omR7SS9p0pw1w3NR9vRbvGxV2L/npqoPAiMJUDwiF6jVwk+O2kL/vUXksbwU3bW2J5U4
         rkMW654IISoiStH+dVO+QywfIv4ZQI/Zp8tf7IGw6Ohkfj3oAYFmuFbC59KDWlYFFdPK
         5jGxLVP4RIyKDYLSmjjN8eRKokQZ1zOyke8sTbFd+MAxUwflzch5en3skwuPiV5ux2sx
         4HUw==
X-Gm-Message-State: AAQBX9c09Zik090pG0wIkSwZX4lsYCcapFuSvf49LTebeLuMCWb5nUuU
        c9nIhY2UFHRC53+OjhNw6hz46G7Kwha9tA==
X-Google-Smtp-Source: AKy350ZeSk/3JDPKUDFoW4aVyR9L+V317oc2hD55kdCKYmI8hEpYOus22mLCOuxEg8F9vQS1XVO8DQ==
X-Received: by 2002:a17:906:6b83:b0:94f:3d6e:f584 with SMTP id l3-20020a1709066b8300b0094f3d6ef584mr2924115ejr.5.1682094679798;
        Fri, 21 Apr 2023 09:31:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:19 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/10] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date:   Fri, 21 Apr 2023 18:27:09 +0200
Message-Id: <20230421162718.440230-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
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

These were missed when these hooks were first added so add them now
instead to make sure every sockaddr hook has a matching section name
test.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..fc5248e94a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/getpeername4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
+		{0, BPF_CGROUP_INET4_GETPEERNAME},
+	},
+	{
+		"cgroup/getpeername6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
+		{0, BPF_CGROUP_INET6_GETPEERNAME},
+	},
+	{
+		"cgroup/getsockname4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
+		{0, BPF_CGROUP_INET4_GETSOCKNAME},
+	},
+	{
+		"cgroup/getsockname6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
+		{0, BPF_CGROUP_INET6_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.40.0

