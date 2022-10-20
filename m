Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DF605BCC
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJTKDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJTKDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 06:03:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C691D5E08
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 03:03:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b4so33477376wrs.1
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq2rLLl96/8tyv+nUUXg3YJKuCsLEa0hPGeT9j8UWPc=;
        b=rGFstQYSQvWHZtEiabJHlaHgz6AG9sco4ahC5vG1/IxoQgMQjcNyyd79GiId0ThKn0
         oWUnN4NnGIuv8cRgREgBsu9D31e7pHg1Rc1PhQ9Lp+VlctRwMlfmg+Zkl3NvmLs4NwlV
         F1/6J4Cwm3GLVPhbIBYp4OS/I5ipvD9tv6y0MA4FiQTUo/UrMEUQyNg4MwhHQy2/yMwL
         Sgnxol45GxnGfhFenfsLcbLVpJElnBHCySLVqGMaOPOEYjrVNJ4Lpz+wLcivypyxCoBY
         Eu27MOoTIDi0xZl5lJtNVXYeH4cWfToJrRNQIXsfurEWUbY5QLHvNpD0oUEnF3okPwNT
         lo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq2rLLl96/8tyv+nUUXg3YJKuCsLEa0hPGeT9j8UWPc=;
        b=a45gFqkRe66QK/Pg2BCFEuxPTGkKsay4jwTMLrpGVKEdXyYEzBXaELPPYEbLxV8Koz
         Pd8yu9b3abZzqQL3z8622fVmcGDCLbKCw1ZZcfK2n9+nLUMeKewXedjG/z+liOWh99Lp
         HjJ4qVSvumQBgJbQc2Nl+okNduIhopuHtAoK+PDWCr3cn9HQPV+5V4XljUI1loWgqF8h
         g5+8EhfiOcNT3s9ycYwfe9zQfPnjfXZ9Cce2B0/I/ZBp6nreeMbUxPnZbuybCUHf24Qz
         X9AgpMgWCTlkJpB225uef76cm/s5O/rD9wU+LnwL/tjBFKSIdFo2CEAdoJpHaGvzu+yJ
         cO4g==
X-Gm-Message-State: ACrzQf3kSw4sMKEzAJ5Ed8vDvug3D6g2cL66StMK2YbJ0HFMjOHjM5sU
        FXbtj3vjPArndI920eS2WEclqw==
X-Google-Smtp-Source: AMsMyM5RnP5LPmlvTOI4YPvfegJ4PNPr/wuNDOZa8ZShNgmjJ8mq43JeSX4iCYA6aw3O74q1lEAFGg==
X-Received: by 2002:adf:d4cd:0:b0:22c:dc00:7f99 with SMTP id w13-20020adfd4cd000000b0022cdc007f99mr7890079wrk.260.1666260184794;
        Thu, 20 Oct 2022 03:03:04 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003c0d504a92csm2577561wmq.22.2022.10.20.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:03:04 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        =?UTF-8?q?Vladim=C3=ADr=20=C4=8Cun=C3=A1t?= <vladimir.cunat@nic.cz>
Subject: [PATCH bpf-next] bpftool: Set binary name to "bpftool" in help and version output
Date:   Thu, 20 Oct 2022 11:03:00 +0100
Message-Id: <20221020100300.69328-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commands "bpftool help" or "bpftool version" use argv[0] to display the
name of the binary. While it is a convenient way to retrieve the string,
it does not always produce the most readable output. For example,
because of the way bpftool is currently packaged on Ubuntu (using a
wrapper script), the command displays the absolute path for the binary:

    $ bpftool version | head -n 1
    /usr/lib/linux-tools/5.15.0-50-generic/bpftool v5.15.60

More generally, there is no apparent reason for keeping the whole path
and exact binary name in this output. If the user wants to understand
what binary is being called, there are other ways to do so. This commit
replaces argv[0] with "bpftool", to simply reflect what the tool is
called. This is aligned on what "ip" or "tc" do, for example.

As an additional benefit, this seems to help with integration with
Meson for packaging [0].

[0] https://github.com/NixOS/nixpkgs/pull/195934

Suggested-by: Vladimír Čunát <vladimir.cunat@nic.cz>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index ccd7457f92bf..8bf3615f684f 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -450,7 +450,7 @@ int main(int argc, char **argv)
 	json_output = false;
 	show_pinned = false;
 	block_mount = false;
-	bin_name = argv[0];
+	bin_name = "bpftool";
 
 	opterr = 0;
 	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
-- 
2.34.1

