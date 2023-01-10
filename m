Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188E76636D7
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAJBqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 20:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjAJBqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 20:46:15 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D662C5;
        Mon,  9 Jan 2023 17:46:14 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d10so5782099ilc.12;
        Mon, 09 Jan 2023 17:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg6y1Fs87+kBhTAphMrODZMR7wjoZTjmP4jc3ntB9JA=;
        b=a5u7F1X3LBVSIFtTj5Av0HOhWzV0MOKgjdqu9aC6bx6UtLALeDSzOKoOoOe+e3wkhV
         LxW8tt5V7UcdHlRmspbI3YQGR/aFQi1RfVW5/ft5Zq10HCFoMwxgfXem5OhrNi+4B3fK
         JoUsItqoTF5mJI8d4rg+czQDuYvzps2qF01Z5yjBemIUVTHKe/auXwLCoPBZnHI+jPU6
         OOSad3IgWc2zux0rnSQbFh/Z6gvmr/ZHaW9v93I35UNEB3k4Xk0jXyYlFVeCe3WODHAT
         poumAzp6HZ19KrPU1FKyz9+/zje3md1DGLbNLsKHjYf/3AXdjKSHEenOkuc+ifR0YNJ0
         PpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg6y1Fs87+kBhTAphMrODZMR7wjoZTjmP4jc3ntB9JA=;
        b=hH2AhlYYvXkj1yVpwk9eOzoYlwbIb6hGNnFzBwCVm7VljSfcLj1kgFhpHcnYuwsRkS
         3WWqvkQKUE0FOhcaImBHtNoH2o35qXJym01J3UWLOV4iarIBU/rsq3qtvVzG6njfWHRJ
         gQKS9g428l4TUWiS8isgqa9PcFH07C+QOfnOztqx1YRkcaiWejETB8AmiAYw0DwbgvBd
         CJKGdCGZfFH8X/FpOenhEx3p48/LKtPhgBXv8+d7n7WhjX4HbE6vXfFGGHmPUQTTk3Jr
         B1Yu5PENyqtPId+Z7a+mjmyxV4rgHaMDF7kVY7lkH0DEfaFwqIOVrZlWORAW14J4GgML
         EX7w==
X-Gm-Message-State: AFqh2koBR7nJI+33MstHkw0socAVTW4CJ55uYmJeJSwdp6g00eiCuEFB
        YW0twWyVpr3NPAlxxtgtVKMpG/DCZd7KkG9s
X-Google-Smtp-Source: AMrXdXuvA8vA+jqlZaO6XX4Bbg9OAHF02rJkjR8f4ojw6iIefHz0kEBESYuY+kf9G6XDBofvdS4Dnw==
X-Received: by 2002:a92:cc88:0:b0:307:10be:a414 with SMTP id x8-20020a92cc88000000b0030710bea414mr41370919ilo.1.1673315173973;
        Mon, 09 Jan 2023 17:46:13 -0800 (PST)
Received: from james-x399.localdomain (71-33-132-231.hlrn.qwest.net. [71.33.132.231])
        by smtp.gmail.com with ESMTPSA id y5-20020a927d05000000b003027f923d29sm3130637ilc.39.2023.01.09.17.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 17:46:13 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Add missing quotes to libbpf bootstrap submake vars
Date:   Mon,  9 Jan 2023 18:45:04 -0700
Message-Id: <20230110014504.3120711-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When passing compiler variables like CC=$(HOSTCC) to a submake
we must ensure the variable is quoted in order to handle cases
where $(HOSTCC) may be multiple binaries.

For example when using ccache $HOSTCC may be:
"/usr/bin/ccache /usr/bin/gcc"

If we pass CC without quotes like CC=$(HOSTCC) only the first
"/usr/bin/ccache" part will be assigned to the CC variable which
will cause an error due to dropping the "/usr/bin/gcc" part of
the variable in the submake invocation.

This fixes errors such as:
/usr/bin/ccache: invalid option -- 'd'

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ab20ecc5acce..d40e31bc4c9d 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -53,7 +53,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
 $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
 		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR:/=) prefix= \
-		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) $@ install_headers
+		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" $@ install_headers
 
 $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
-- 
2.34.1

