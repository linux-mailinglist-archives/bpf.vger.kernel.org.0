Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBABA6C9364
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjCZJWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCZJWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F099032;
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bz27so5883656qtb.1;
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqlnazOt7kJ3822TP+aL3SiF//u+HTRXad+baVnErHY=;
        b=ULRmL+goUMzVI5YM5Y3Tyb6Q3Ydk4wgw8+6UtQFRH6EdEXFLldFizOc9kXUV0CRl/o
         OwLu+mZCMJ7VUWMBNtO9bEU3nRuILHZtYR6BYOzE8dPY2AUmKxv9/8WJEF138QpnKxsa
         +kAu7TUP7430uq1suJArrJQU+HQ+6vvvKQhK6HCCsAovvHrMlr9FG0Xchxfk5jHwV+q/
         zmPpsOwGDOG8odIJR86LI5L++nbeSpoPDyXGCHaykARBdbfNBazeOlLoirujo51KSOmN
         ROb48wG0E2fmz2aBbOsjusCsoJPCq19F3r9/D8m9KLog+wmLgTpS0/8d1C112df0pn8D
         VmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqlnazOt7kJ3822TP+aL3SiF//u+HTRXad+baVnErHY=;
        b=PTi/khpkbT5ftwnbkTRCemBQfJ1QETMY8fksWmgu0Ea1wA3/CO76z9M0RzaeJ+oecj
         V+BrXn6aDpvF9+RgOjxqjAfxppFjgO+SmHkZDZCMKA8ZD9juXW+N14neuGcLA/XnfArO
         8dNucy6Vhp1pMw1dYfMRfDUl7t5SUU3h1c2aquNCmYsv3KveiiaYEkEIVydr9O8p7llJ
         33XwS7+1T6ibQYVvtvXNBhuvjU1e9yQpET9VjsqPQc7HqCR54wKnDonPeEzitGt0DIii
         0Nu4kRd2kH+BObXj+/64vyR6YE8g+HkTH41CYbTYdkDVRn6BB08evRIBpDzx1XaGmnyo
         CsVQ==
X-Gm-Message-State: AO0yUKXteKmKXvdFMKhTEvIU9GMFO7m3BbS+wv1blKuis2MznGbd/dYx
        pm7/TDsHDaI3zhWSCqohpXI=
X-Google-Smtp-Source: AK7set+qWJoVPRpZDJF9uabDzOXssV1aMtfo3xOWWbAi38faUnSMo8mfC7IGQwWLWU01/6M+R0ifFA==
X-Received: by 2002:a05:622a:c6:b0:3b6:2c3b:8c00 with SMTP id p6-20020a05622a00c600b003b62c3b8c00mr15120345qtw.66.1679822538836;
        Sun, 26 Mar 2023 02:22:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:18 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 02/13] proc_ns: Extend the field type in struct proc_ns_operations to long
Date:   Sun, 26 Mar 2023 09:21:57 +0000
Message-Id: <20230326092208.13613-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In struct proc_ns_operations, the field 'type' is the new namespace
clone flag. As the newly introduced CLONE_NEWBPF is more than 32bit,
we need also extend this field from int to long to adapt to this change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/proc_ns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ec..555c257 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -16,7 +16,7 @@
 struct proc_ns_operations {
 	const char *name;
 	const char *real_ns_name;
-	int type;
+	long type;
 	struct ns_common *(*get)(struct task_struct *task);
 	void (*put)(struct ns_common *ns);
 	int (*install)(struct nsset *nsset, struct ns_common *ns);
-- 
1.8.3.1

