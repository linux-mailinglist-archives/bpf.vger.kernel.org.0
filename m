Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972C35AF5F
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJRqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Apr 2021 13:46:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D98C06138A
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 10:45:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l123so6380341pfl.8
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOcwjd+VByxnc6jA0dFZtIlTEfII8EELqqbSkdJEgpA=;
        b=khL1Y965T0lGW8Fyz/fub8F/bM5VMRkygANCo13iXw0KudvjxSjVGo/hyHEsh7usFe
         mHJ8QPV2EDZYG+oOAiMQmkt8e2lFJ0d7Ga18mkD2AV5P9Qeh9zsATfWuK1eMkd+b/kD9
         rt3noW8g9osVOIa1QcwktmjXFoT2AxW77kSMx79eNmA1Vw8te2vdLxa7VSxR9/NpzmKh
         bPBc8CVfozNRrOLOQsIiQ9mLclG8/Dv0IEAVazpt+/bWaijise/2PkO1yHxTf8UHgDfv
         eoZ9WT4T2H9jxQrUJTEA6uwtav7qclZ7SJLMxcFL/0vONn33/SGbmx0zK3CnguuBzL51
         1rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOcwjd+VByxnc6jA0dFZtIlTEfII8EELqqbSkdJEgpA=;
        b=IAChATCNFRYhKjD8DKQeadNMgRLD+5KCRzXZpjxWXY2v0lgEkmDwQ5wjxNKcl1ObrU
         xU2j3OM1ViWPrOaGOhb8Uw+O3uoVSpEaNnqhQUzTHhftcbn+WrL+5ayUJSeJMh2KJJYt
         o3DY1LR9ahm4hyRbELNgi31rZGZYefHnKS8s/M4MdNHKZ1U6JG3RvolTt4fbJLEG9EVi
         IBb7gvo6v8fu78BHHtnOQTvT4MktnXu1K0FXnOHQBUmk5S8vu/NzX0Z/uWZN0P0zzuO9
         1TimpQjkaQEtATa5vCVNWdiwcfAOqS3Us20SG83xuRa1lteQphm+N4Lvog6OjA4Ax6K4
         M07A==
X-Gm-Message-State: AOAM531mb/2t2H6RbbpFAzOgNKnlfMVwoqK1HCBscTWDVotIUVxmMqPW
        yjjwIHikwAeV/htBpaTzoIWGxsHCfHOgPsILYYA=
X-Google-Smtp-Source: ABdhPJwyDyJ6WzCdiFHbyohahL4meuEsqU3UjPfcIGdNjgOHc2guSRUCymwQ+VCYnyJlUocakN2Smg==
X-Received: by 2002:a63:fb12:: with SMTP id o18mr18197427pgh.438.1618076757203;
        Sat, 10 Apr 2021 10:45:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id 196sm5442639pfz.82.2021.04.10.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:45:56 -0700 (PDT)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, Yonghong Song <yhs@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next] bpf: Document PROG_TEST_RUN limitations
Date:   Sat, 10 Apr 2021 10:45:48 -0700
Message-Id: <20210410174549.816482-1-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Per net/bpf/test_run.c, particular prog types have additional
restrictions around the parameters that can be provided, so document
these in the header.

I didn't bother documenting the limitation on duration for raw
tracepoints since that's an output parameter anyway.

Tested with ./tools/testing/selftests/bpf/test_doc_build.sh.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
CC: Lorenz Bauer <lmb@cloudflare.com>
CC: Song Liu <songliubraving@fb.com>
CC: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 49371eba98ba..e1ee1be7e49b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -312,6 +312,27 @@ union bpf_iter_link_info {
  *		*ctx_out*, *data_out* (for example, packet data), result of the
  *		execution *retval*, and *duration* of the test run.
  *
+ *		The sizes of the buffers provided as input and output
+ *		parameters *ctx_in*, *ctx_out*, *data_in*, and *data_out* must
+ *		be provided in the corresponding variables *ctx_size_in*,
+ *		*ctx_size_out*, *data_size_in*, and/or *data_size_out*. If any
+ *		of these parameters are not provided (ie set to NULL), the
+ *		corresponding size field must be zero.
+ *
+ *		Some program types have particular requirements:
+ *
+ *		**BPF_PROG_TYPE_SK_LOOKUP**
+ *			*data_in* and *data_out* must be NULL.
+ *
+ *		**BPF_PROG_TYPE_XDP**
+ *			*ctx_in* and *ctx_out* must be NULL.
+ *
+ *		**BPF_PROG_TYPE_RAW_TRACEPOINT**,
+ *		**BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE**
+ *
+ *			*ctx_out*, *data_in* and *data_out* must be NULL.
+ *			*repeat* must be zero.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
-- 
2.27.0

