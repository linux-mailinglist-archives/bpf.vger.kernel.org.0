Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD726DBE68
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 05:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDIDer (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 23:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIDep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 23:34:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283E5BB9
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 20:34:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w11so1887331pjh.5
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681011283; x=1683603283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnm4Y66ZcoZchOSGCBlMeDpCilauoV7XGPgRMuOkFxI=;
        b=CDJpQO3aojqSg4ogFtPAEW/etZPFRajlLlpX2B8TAIg9DsXhXs/CC/jsvQX7SaI3UN
         aQaIjxc8qMPkXb+WQe02C8jqV9ObXg1NevRo88eCT9FREkdegGa4qY3XgfolPpqZ0Bb8
         K/5Jt6SBAA1+6oSpEfAbo6UdRyctzXbJApTQiurtwP8AllHSozl8+jx0i7sjf+nqe17b
         CWAMhKzbVOOEL5jI+c4bw4pkXLMt7c6InwVsqFLJF82vF9MFz3ztOGA+wHif09RQ/9QS
         VeDZTWD1hOVl0YaxMU5UsorPI2vSgMNuaOhxsAxysv3xbm6MtpKx0ieYX9ttfYwKrHMb
         7y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681011283; x=1683603283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnm4Y66ZcoZchOSGCBlMeDpCilauoV7XGPgRMuOkFxI=;
        b=b+hvw/VRyRKbyKxIlKgP0XjrjVdOXJEOcWt0vPga6A0Wg/0prfez6nOEgWIckHn+yU
         VQzhFuJLQcvvECCS8vYSujx83OhOY0MTT5SbWE42PTkDGfIIi55N+6jwSBQpM+iNRoJV
         6ts9GRtL6WNXd3k1C4NU2E1tAOa191r+fR44HWJtlRpNUu++RAWbnUeD038jvtrLkQb9
         Sty4ax4uZGayk3HQPRnHh5zM/QE7P3wDwUTiSypUWJvNTyICSWFx7emGQ/7CUfXfMn+V
         Bj9hd8uEgFi7LB8Szx54DNdNgpGtGDdveZhhOtWP49rcPjHnerO2raZeQAC8PHVvyJOP
         3ecA==
X-Gm-Message-State: AAQBX9cldCF/NXmPEbiskj14id99oMsYXf6NFXb4DqW5ZzAJjkoLv+sn
        oz4hAgMDMa7hvOXiBKlUypq+wv1LUqLUNw==
X-Google-Smtp-Source: AKy350aP5dTgYxzNjzbe/JABdBPZK2FkoPv3vjg/2bNjDgCu0Pya+3PUkLZW/d+zzJnIpV2W1HZYTA==
X-Received: by 2002:a17:90b:164b:b0:23d:3878:781e with SMTP id il11-20020a17090b164b00b0023d3878781emr7269328pjb.21.1681011283373;
        Sat, 08 Apr 2023 20:34:43 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001a212a93295sm5185877plm.189.2023.04.08.20.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 20:34:43 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next 1/5] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
Date:   Sat,  8 Apr 2023 20:34:27 -0700
Message-Id: <20230409033431.3992432-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230409033431.3992432-1-joannelkoong@gmail.com>
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
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

bpf_dynptr_trim decreases the size of a dynptr by the specified
number of bytes (offset remains the same). bpf_dynptr_advance advances
the offset of the dynptr by the specified number of bytes (size
decreases correspondingly).

Trimming or advancing the dynptr may be useful in certain situations.
For example, when hashing which takes in generic dynptrs, if the dynptr
points to a struct but only a certain memory region inside the struct
should be hashed, advance/trim can be used to narrow in on the
specific region to hash.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b6a5cda5bb59..51b4c4b5dbed 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
+static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
+{
+	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
+
+	ptr->size = new_size | metadata;
+}
+
 int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
@@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
 }
 
+/* For dynptrs, the offset may only be advanced and the size may only be decremented */
+static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_inc, u32 sz_dec)
+{
+	u32 size;
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	size = bpf_dynptr_get_size(ptr);
+
+	if (sz_dec > size)
+		return -ERANGE;
+
+	if (off_inc) {
+		u32 new_off;
+
+		if (off_inc > size)
+			return -ERANGE;
+
+		if (check_add_overflow(ptr->offset, off_inc, &new_off))
+			return -ERANGE;
+
+		ptr->offset = new_off;
+	}
+
+	bpf_dynptr_set_size(ptr, size - sz_dec);
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
+{
+	return bpf_dynptr_adjust(ptr, len, len);
+}
+
+__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 len)
+{
+	return bpf_dynptr_adjust(ptr, 0, len);
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_dynptr_trim)
+BTF_ID_FLAGS(func, bpf_dynptr_advance)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.34.1

