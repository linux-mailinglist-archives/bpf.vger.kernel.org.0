Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928946E56F3
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDRBoa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDRBn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045C8687
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:42:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54be7584b28so368347317b3.16
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782127; x=1684374127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddXTLGLPlq5L3n42BI32GqoM9UbKxCD+81BzG53VpiQ=;
        b=0MA+38wAROiLJwnnmkOR/8zmb/14kIavQqPqw5eB3G6C7GmifVtBaTDn3Wsfybkp37
         b6dSdIwLTyNCmW3wmimtWhAUVTIK1yom6ecNpdWCmuMN8VINN/r4G1jXgbOY4cu+cZ+a
         Pt2r2hp2yE4x1rZokntaJd0+V/IAOiTEqK0lvMYUT9NoXy+nusYQTLGzsc6+78Z99LtC
         SjL6n9ZideGEO833c88L+9rdxIqF491lV1zcvATg2XLJ7T64aoqdeqgUJwGQDDFLOtda
         4vQypY8y9YjForGSQpK/s/rOXTF8rdgpZ+X4T737iBV7hJiGed/JtsKQjYrD8ZaDlk5T
         P0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782127; x=1684374127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddXTLGLPlq5L3n42BI32GqoM9UbKxCD+81BzG53VpiQ=;
        b=MEt2vG8TlqsoQJgEdELoaedn3iG5cbJfijrTqSMTe4iZLrEX7FcLL/atx0HvWzLs/N
         Y7YY9dVDGtXi4+cq6Ue0A5GiSlXx/TgLXMtYxfWLFEIdgq57PUKkHXUfRSkpq2lWETi6
         dzJT8hNlzTPLMJyRM8MEW0UYISE2g29HzKmOa1Rge0GISFUFhyV3qFdG6OcgjTmS8FG0
         iT0feEjSc5MQNn5vULorPGQKb0FkWv2bw+4p0NMkoWeYbnE5wfPRjauxtAKIsUaebB5/
         BOeGs/xLReFzJZ3PDDjIqIq/SA8DI+LMy+whgPFtxi9gF9bfua0k4QDev4FluFDUdT2j
         /VlQ==
X-Gm-Message-State: AAQBX9dyDp0rdZqNVdjDnLJBWNc31uu9uAx3ZUtxp54PAp9fuzjdnSTP
        qfrPXYWwkAE5RUWH93g7cG0Zwl/8LRs=
X-Google-Smtp-Source: AKy350bwpQo+izJgr59DpjqCYtbKMquWrfrRxB2SDqJN3j5Kmuer+Tdqg9Aw5PoVXSidCg0l3wDXvhOOkII=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:4415:0:b0:54f:9718:1d39 with SMTP id
 r21-20020a814415000000b0054f97181d39mr10593880ywa.0.1681782127537; Mon, 17
 Apr 2023 18:42:07 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:34 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-35-drosen@google.com>
Subject: [RFC PATCH v3 34/37] WIP: fuse-bpf: add error_out
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

error_out field will allow differentiating between altering error code
from bpf programs, and the bpf program returning an error. TODO

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf_fuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 159b850e1b46..15646ba59c41 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -57,6 +57,7 @@ struct bpf_fuse_meta_info {
 	uint64_t nodeid;
 	uint32_t opcode;
 	uint32_t error_in;
+	uint32_t error_out; // TODO: struct_op programs may set this to alter reported error code
 };
 
 struct bpf_fuse_args {
-- 
2.40.0.634.g4ca3ef3211-goog

