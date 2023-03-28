Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841CF6CB2DF
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjC1Ar4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 20:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjC1Ary (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 20:47:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4393026B1
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t10so43082226edd.12
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679964471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my0hiBoNMLwVoTp1nluKD0IpMhbNtEuPQTHsBc+Ymfk=;
        b=K4x8d6Pd5rcTgvNlr8nbEx/7imE1hwgn5qC5BfkTrtfwZFQwymngWGbaBkxgtM8Lht
         biJSkDhZDZFt4o8d4tMFH1TiuEZSA7mE4P8MMC9uVOnV/uu6XS4Fwy+PTQ0Y44eVwJLn
         IVEdzZSyjYxJpGyx0B8Okub/nYcx1bWn9eaF84nvm5JpJJ7Fps+Wemmf3UcoDnlZzVni
         IgJcyP0PXYxh707+glk5TOWrkfN3vdNvppJgOIQmEzFsLx/r+A/Oun4EogQhW8B9ZmQd
         tlNTso/tde8ohDl3dpeYJK31XTXsZxpYzm2+GQkGBb/IHJ1Ziwtvl68XrxxDNgvtnEvl
         oZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679964471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my0hiBoNMLwVoTp1nluKD0IpMhbNtEuPQTHsBc+Ymfk=;
        b=D93VP5ufM/Urz9tpXoiauOgJh5q5cZuL08I59jaquAKO5PgyT3oqMRnkHhShiStTGI
         ZaGo+3wQh5ybTOBaLuWbd0lzh/g50PAJ+H3F4w9WAUdzOVKvlol19pbvqJTGy9JMBZbE
         uI3fSULjCrp21k8aTIcyO3eihHKm0MjrBihmGeJ5PH+Watq9AYELrtESUwiU5lpHxIxs
         1k+KznG14h+q81K66fLA7J85WoM0TJr0CoDY3+G1jHYs9e4LBy6YKbfNk6b3X4GlnCZa
         oBUMaWDJzOfguSWd+6LdTqkuJemyxUhF2qWx6CGCW1pp4zZ4/wKyEM7u7SXnRG2q6Ox+
         7wsw==
X-Gm-Message-State: AAQBX9fZM2g3e159+JtjWCwLeCmqnltpppE7ktB0QTt+zV7xkqZbSUi+
        UV/QoG4XNIvJYUn3ZqnMD5nAICxtULRkQw==
X-Google-Smtp-Source: AKy350bvwh9juhop2UxspLR4jDpmJiT1vdffC3Ct/y8SoKpLolMJU8Geub38UOVwpV5be3wk/vroIg==
X-Received: by 2002:a17:907:6e04:b0:930:3916:df17 with SMTP id sd4-20020a1709076e0400b009303916df17mr19732777ejc.0.1679964471303;
        Mon, 27 Mar 2023 17:47:51 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xc1-20020a170907074100b0093de5b42856sm5560175ejb.119.2023.03.27.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 17:47:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, james.hilliard1@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Test if bpftool linker handles empty sections
Date:   Tue, 28 Mar 2023 03:47:37 +0300
Message-Id: <20230328004738.381898-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328004738.381898-1-eddyz87@gmail.com>
References: <20230328004738.381898-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds two empty functions to linked_funcs[12].c. The functions are
annotated as "naked" and go to a separate section. This section ends
up having size 0. bpftool linker merges content for sections with
identical names. This tests if it can handle empty sections.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/linked_funcs1.c | 3 +++
 tools/testing/selftests/bpf/progs/linked_funcs2.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index c4b49ceea967..029bb5022ba2 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -86,4 +86,7 @@ int BPF_PROG(handler1, struct pt_regs *regs, long id)
 	return 0;
 }
 
+SEC(".empty_section")
+__naked void empty_function1(void) {}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index 013ff0645f0c..4547c8dfc689 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -86,4 +86,7 @@ int BPF_PROG(handler2, struct pt_regs *regs, long id)
 	return 0;
 }
 
+SEC(".empty_section")
+__naked void empty_function2(void) {}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.40.0

