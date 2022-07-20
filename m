Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7257BACC
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGTPwZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGTPwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 11:52:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C14BD18
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:52:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c18-20020a170903235200b0016c37f6d48cso10646199plh.19
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fr7GRR2dIQ7nsjUNGqknz8JYIltI4Sht4NkPNkYCvHI=;
        b=P88VrWiQRQeER+tVYpsp0Y1FWxeirIT8XYrUZjFpqF1G582bTqBEIfsyY8cII1EX1K
         XR3L5WGSNNQgAX9O5AM0VBW0g6uHWaWKYyQJ4iJqNKgnFqZRaBeFZnYtU1YOKs/0U2ZU
         Lrf1ogB1ia50NayquPuSDj3Quyg0ud1k4q9xdbDgVWMDLNgacVW6uVKYmHVt32R2hkuG
         MWDsXkE4KoUptMlBvN50Hg4YxL/2cAtGa9ywP4X0WU6Ie6hGNfZzOeDCz6WjaqaVRoSe
         PuazsuiV6g+dP1LJU6S5jm+MNF9CNS5MkqsZrB74rdSwl31Fh6t0U5NxF6jPD2ffUOzb
         JyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fr7GRR2dIQ7nsjUNGqknz8JYIltI4Sht4NkPNkYCvHI=;
        b=EZxtdFPyGT7+CcbpNQDfGH5CbmVmNo9Gqkszc0pUtrOrjkX3haOKJvLPEDUaxpwCnx
         IS22Yk8fBb4qdHYMoS15PJ8Th+kAaJXpP9aQcZkwkCa1YqwmkZgz1RyHHNbXZVrT2NYV
         0z7uNVH9gRPUA8ML4XdMixFiIhS4IWiRT3m7aQEDbggaO+GMUhz9DROIQwxX6YYNxh+i
         hgGYZF35HrXtO+SBK4xicr7nOsN2ujFhS/JZOMuk2PmH32+grSGxVecm7MD7jv3wWH7/
         dUmXJ/vlE0JUXmYyi2BIu96SI4W7jR1jmjZl2nmBXcTuG95koGBN1lD9QNw2DzAaumeD
         1GbQ==
X-Gm-Message-State: AJIora8AvJYjq69F7UXasQgcvCp2wVgTdB1BRPcIZ/MQcqanje5SqSEe
        OctcgX8kBAuTz1X2OlEF+nLRoRi59Pulbtj/9vPdu7StaRjgrd4m7WSb/9pb6P1Y91YDLfAdY7N
        7x0O/sH3UpduHcxKRxX5WHPl9Mxtm/XOAAEMhzuhaTmhwj45UrA==
X-Google-Smtp-Source: AGRyM1tHtFGu+2ZVX0jif83yOvNG02+IoRDTgkapJ7aZm2P7blSH0KJIQ4fHfI9DjlP/ybEPdRGu4WY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:9d8a:0:b0:52a:bb32:528f with SMTP id
 f10-20020aa79d8a000000b0052abb32528fmr40287554pfq.0.1658332342372; Wed, 20
 Jul 2022 08:52:22 -0700 (PDT)
Date:   Wed, 20 Jul 2022 08:52:20 -0700
Message-Id: <20220720155220.4087433-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH bpf-next v2] bpf: fix bpf_trampoline_{,un}link_cgroup_shim
 ifdef guards
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

They were updated in kernel/bpf/trampoline.c to fix another build
issue. We should to do the same for include/linux/bpf.h header.

v2:
- Martin: bpf_trampoline_link_cgroup_shim should be fixed as well

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5bf00649995..11950029284f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1254,9 +1254,6 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
-int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
-				    int cgroup_atype);
-void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
 #else
 static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 {
@@ -1280,6 +1277,13 @@ static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
 {
 	return -EINVAL;
 }
+#endif
+
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
+int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
+				    int cgroup_atype);
+void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
+#else
 static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 						  int cgroup_atype)
 {
-- 
2.37.0.170.g444d1eabd0-goog

