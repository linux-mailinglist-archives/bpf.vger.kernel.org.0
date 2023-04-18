Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19816E56F6
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDRBoc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDRBnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABD4218
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:42:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54be7584b28so368343747b3.16
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782112; x=1684374112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnG7XRDx2oVnxRfx5yqwQBjNsF82L1FllZqCFSzhSvk=;
        b=SkI3OL7Xwcb2D8buNw1xsFgokzhAAQBXqENLcRBKEhMxZBceAdT76zRqhUKaAlZRib
         aI6PlfHc5n4ddtN3+6mjTW4Cs8BBdyXGjyExSVPyeQf5XRY0Liaw+CyvPQArNpVYYnib
         TGm738pcBWjnR5XstajeRfCSTCqIp9dGcgPyzLhYYauS/Ba9DT/7Oo4iwDdfQ5MeXhvv
         m9omEapvVlOwz2XNsPXLPYl6qDc4wN5t+WJMQ3+JHgRWz6iur0twsD7zOIFKKeIe51D7
         dw3h5jHufm+Ui9oRM1TAW/H897y1hff2PlchumkhwBxLImVetPWMILw+PxvkA+8WTkDa
         ztcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782112; x=1684374112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnG7XRDx2oVnxRfx5yqwQBjNsF82L1FllZqCFSzhSvk=;
        b=lChPUIv3ygbGOxG9zoWFbWuz/P8BTE5UfUBUqOoUe3y+VhPwdfs+YPPIU8C8uejLV0
         tl5JPgJ+9vhByGzC8aouHLSC0jUQagd6gAdAEtYt+ixgVp7p+2QJYrfNKyUaR1ODW+fj
         OJDMwlyiNtjBGiOqGV2GORRk0RniTpMH5zzPquLjc8Q+82uKN7mSXpsuToLHQZKn45KA
         mPKl2I1fbUNGyijOhHwWCKFVBLCirexlbBAt0r0iIUYKdc6HZYqdsHz6dTOXmYIMjtDP
         tb9VdRNsLT5n9uH8ig4hLDeGLPzjvA5BhfjA3plzD1r2YQwfQF/0zzCRmyEO9KUws1tq
         NCgg==
X-Gm-Message-State: AAQBX9fFSAQvFhVVdxdSlN4AzYj4ujJBQxZz8zILgH5FAvFGysIhv5cg
        lRrISJpNcWngaP5TTrrcko5HCslvoYQ=
X-Google-Smtp-Source: AKy350b7LZaOW7Db/+iu/rILXEm8KL2d9x1YzXYuCbML8M1OSVxY74Uh31fhIpMfF3C/uFjNLKcy7inXoIs=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:e503:0:b0:54f:40fe:10cc with SMTP id
 s3-20020a81e503000000b0054f40fe10ccmr10636927ywl.9.1681782112257; Mon, 17 Apr
 2023 18:41:52 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:27 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-28-drosen@google.com>
Subject: [RFC PATCH v3 27/37] fuse-bpf: Add fuse-bpf constants
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds constants that fuse_op programs will rely on for communicating
what action fuse should take next.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/uapi/linux/bpf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4b20a7269bee..6521c40875c7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7155,4 +7155,16 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/* Return Codes for Fuse BPF struct_op programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.40.0.634.g4ca3ef3211-goog

