Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121CB6261F6
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiKKTck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKTcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:32:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A011776FB2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:32:38 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y4so4984807plb.2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffBMRisH/b+vAP1Qh1wMiOBQlQqteRIJ6zyoQtDJas=;
        b=ecYd+DOsarDN9nGYeDUQjp32U50kSYUHLt/+HgmV5f7639ZPIcP8m+eFxH/qSl5PIO
         /s+0dhBS+Ec49nujDK6xDIDhKQlWELzxMT1h3A/UMtPqSC7E8czjLgzoQuOIuzdmv78j
         /RID9Y+f+fIGnSnmKHjbq4ILxf7EkcmOHYmXDy8j0toxvqpdstYSgMGVx5jbBwPlyJqQ
         If4d5V+Ei1sJhEk2HCwFALldiMCY6muyyFaUHG94wlFWRDJmhJ4QoqADJfzKWy5NJAKj
         jXz7QC1AMq9PbVqXmzhTydHdbaAWqjYRhgCUqqzhvNmiwTH+5lLJe10R2E/bZ54tl2TK
         DPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffBMRisH/b+vAP1Qh1wMiOBQlQqteRIJ6zyoQtDJas=;
        b=FjbMU+5wLQZ2An3BUt9Ut2qPA8lixnOqvHYI41nWf/9pTqV1D+s0RVIBauD4T6N2V2
         Or5N1LKt3S3obUln1yd3AQd29XEAvD05MHjyzbbo4RMO7GgVJ9v8ARDOvvvqC7SjbT8Y
         wYgRCihXhq8yjKPLCLvsgZp2rIVtrIXDAjHBjVFFaCZ/uTdRHULAod9pVPv05KDkVX5s
         DFSlZqnuYSDjaMy3hj9NusNryYVXWjv6Wl//efhqy0oQoRJE3mVjXnk0yQ42TtPWvpCn
         JYx6Fl3XtiGJJtcNhTCGs9LZQUWpmdysYQ9CoLg/ySrZpe0IRZ0idbVCAcoaBexEWpxk
         Ps9A==
X-Gm-Message-State: ANoB5pm6uXKkdDhMYj7ghp4Yc3VKS73PRTM1CvCjU8Rka+azwVjGq0BI
        chIUyfsAGrIqflJotnNmyewbQtLh9PQv/A==
X-Google-Smtp-Source: AA0mqf6PdF3/ZCYdb9vMhChFTAIDXYzS+tWDI8DhwiC1DQ3x0tEZEr0rZ5pYK+bmocyIXClUPTtzNg==
X-Received: by 2002:a17:902:c193:b0:17f:3da:f19d with SMTP id d19-20020a170902c19300b0017f03daf19dmr3811189pld.147.1668195157938;
        Fri, 11 Nov 2022 11:32:37 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id c65-20020a621c44000000b005624e2e0508sm1909132pfc.207.2022.11.11.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:32:37 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 01/26] bpf: Remove local kptr references in documentation
Date:   Sat, 12 Nov 2022 01:01:59 +0530
Message-Id: <20221111193224.876706-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=memxor@gmail.com; h=from:subject; bh=TQdLtozHcFAX41FmGoXIb11rizNdf5YDECl5nuh1YTs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInYkpbjgYlHHXeNDaXnxMAMbY+CWQTumnO8K0c JvRxkNiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8Ryl3OD/ 0dSZ2FJu0WMinq1u/x8gS5ZHWP1GG4JC0plreBy24v5XcPVx4W0LfoAm2g3uZLXVK1OMaik3BYtzxN dUOuIknUuOWmkyrHLfl4b6EHYE/iXlKkYm6EBRlhFVT6+u8cgEjkLaDxzjcy0MaECsYgxXiSOPUpTL p7xOEwBrFLFd8gys+OOAXhPid+kFVnrSb2paPRKjj7rpBqYxzBnokaUL6npLoLpKpteDhpNQAe5rBQ rpt0Yzvj2PooKtai2dFNQheLq8F8uhjUEb7UKSwieyfy0RnX/dj8xgQxmF0xui6GURdOSOEhSJjFE6 RGrbY2xaIgEiBUyTSuorGJ6YYj7niFlV50l9WsXv4QdUHnsQxHC+Nim1M5WQD49wjvj2gM7lo9OypQ /qaT9AzoGwPZp23Z3MRdS2DybTvgPGgLsc02GEhRw9v6ZVKIbZRIXXwV+Isrv2bqxjwLh49Bg7/ljk +qob6VAMnYfbw9XqEpyiXaVVanPv0TFXNWtxvsbilpLHBJ1KWx0IGaDIcoVDE0RKsGPylIEZTDuWh9 xniAtl7vRpxVbzV8uTTo/YrN3I89zrikPNTAhffY7lemTZoivrkZwB4iXmwBjBWSyPTF3sjvQy6VYJ peGFOVGcsl2PHz/vcAMX5K/+u9qT2/vHR5P13+3x27lLN1jw8/PAgf3Wji1A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

We don't want to commit to a specific name for these. Simply call them
allocated objects coming from bpf_obj_new, which is completely clear in
itself.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 17e774d96c5e..cec2371173d7 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -332,13 +332,14 @@ avoid defining types with 'bpf\_' prefix to not be broken in future releases.
 In other words, no backwards compatibility is guaranteed if one using a type
 in BTF with 'bpf\_' prefix.
 
-Q: What is the compatibility story for special BPF types in local kptrs?
-------------------------------------------------------------------------
-Q: Same as above, but for local kptrs (i.e. pointers to objects allocated using
-bpf_obj_new for user defined structures). Will the kernel preserve backwards
+Q: What is the compatibility story for special BPF types in allocated objects?
+------------------------------------------------------------------------------
+Q: Same as above, but for allocated objects (i.e. objects allocated using
+bpf_obj_new for user defined types). Will the kernel preserve backwards
 compatibility for these features?
 
 A: NO.
 
 Unlike map value types, there are no stability guarantees for this case. The
-whole local kptr API itself is unstable (since it is exposed through kfuncs).
+whole API to work with allocated objects and any support for special fields
+inside them is unstable (since it is exposed through kfuncs).
-- 
2.38.1

