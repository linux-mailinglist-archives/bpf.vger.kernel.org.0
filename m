Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C877561D5D
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiF3OC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiF3OCm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 10:02:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EA68A32
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 06:53:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so17087004plo.10
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1WyPKAWTYMQhNa1H/wwyGLjKjFkJeSD1KyHDnw1/zA=;
        b=e15+1F8sCKCdG8lpWLjOCpzFM5c/6WB0j4+9XsUniFLdn/E7hcfxtkmrpXxRjSpuUS
         gKNWSee0Sq0TIXoQENdoMGf+z+s7M360B5rj60Cr6TezjTQF06QwHg7RA7gRUmXTIb85
         txll3Xf3qGTN0kQdKd/Fiugo+QvL/l08oVSUqYN1GmgwTcafaRMdlRJVhc6Bar7VoWRM
         7qETxlQ/6JEwCfK4OR7oB1UnxZM0/UCVpwcvxTPVdbIFnGqeMvSP2tyU7j8XZXKZyddI
         9F+TQZxePoA3ityyqI1t63fluwyGZlKsbQqnx4WBriBH5okFTkZ/1u6ULbitPqGNVfJN
         shDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1WyPKAWTYMQhNa1H/wwyGLjKjFkJeSD1KyHDnw1/zA=;
        b=KkDJNYD5h5CGoSabxJwLYLX1jtolQarAB2gc3VP+wM/rDXSsa5tot9+Uu5Q020Bwtt
         8hc7aoInGSa38Cmpb6CybYAsLFjPN3nIbpePPBzkHjsJjrLcjgQPGy2rrMYKO4bG1mqs
         HslodUB2j2Du3Tp8S/fveaX1tUzNsUzLpbcJpLVCVlu+rMXfjwYZSkIojVorrXXLnvM+
         N/qGKKf6PNr2ddTe4MYM+Vm4/LFaoslmpz/pviLDHQjYImG3y3NW63/Brs5yKnVb2KJD
         jdywabmR4itX+YCqVXdFPDDEgz6dPTY8suOvYH3YD/pWJJPGCNqKM9XPHuyB/M8TgeD9
         mKxQ==
X-Gm-Message-State: AJIora9r0n0YwpvypzpIGKsUx+5eqMmuHAurVDuysNJg8Nkgs7BxPL0Z
        0ZxSazjWOXXQvDhLSQJo/4JMWRn6Y7U=
X-Google-Smtp-Source: AGRyM1tf0sFi6BmOY9a6B8zBV9W+29QG5MiMWXBqc4bWMzvWpUdykvtYbba03axHHjTKd+Fr1CBqVQ==
X-Received: by 2002:a17:90b:278e:b0:1ee:f086:9c9d with SMTP id pw14-20020a17090b278e00b001eef0869c9dmr12014117pjb.182.1656597182982;
        Thu, 30 Jun 2022 06:53:02 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b0016a17e5fc6esm13500310plb.104.2022.06.30.06.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:53:02 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Allow attach USDT BPF program without specifying binary path
Date:   Thu, 30 Jun 2022 21:52:50 +0800
Message-Id: <20220630135250.241795-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Currently, libbpf requires specifying binary path when attach USDT BPF program
manually. This is not necessary because we can infer that from /proc/$PID/exe.
This also avoids coredump when user do not provide binary path.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8a45a84eb9b2..4ee9b6a0944e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10686,7 +10686,19 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 	}

-	if (!strchr(binary_path, '/')) {
+	if (!binary_path) {
+		if (pid < 0) {
+			pr_warn("prog '%s': missing attach target, pid or binary path required\n",
+				prog->name);
+			return libbpf_err_ptr(-EINVAL);
+		}
+		if (!pid)
+			binary_path = "/proc/self/exe";
+		else {
+			snprintf(resolved_path, sizeof(resolved_path), "/proc/%d/exe", pid);
+			binary_path = resolved_path;
+		}
+	} else if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
 		if (err) {
 			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
--
2.30.2

