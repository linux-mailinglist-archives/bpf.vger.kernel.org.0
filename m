Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289395AC664
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiIDUl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIDUlx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F72CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b16so9039807edd.4
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7PDpdrayJx2oEcR06efOUOd3OjU+obEZHf3aU6JRhC4=;
        b=FM3ZEBbdj83tbIXzENXO/V2YJtjdrX+cjFWotS1OvcvWs29dq3AyFV/+PkJOKreQAe
         7FgZtqT/+XFX66NIpIUjYC5xlpTfGlJbjDSPIeHPTD9b013L17XIbdSjcYPTvxNHC1e4
         4fbjLpDOQPk7y923u4uaHs1x6WgGLW25xqD+PhRc6MU00ASM7x8xCvzSFxOmgPF3zhD9
         YlcYgyP/yyEscRAoWsQfH7b1BI0frtGM0k5Efc15QiTd+HVJwWLeXcaEzPnFVxjxRx3K
         mY1fvMc/dwHHAruz5iFNny+aHnsSwXcAO1X5BX2GEeyHojBbWPVLNLZJhhwK/Ojy/4v6
         f6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7PDpdrayJx2oEcR06efOUOd3OjU+obEZHf3aU6JRhC4=;
        b=x7YU1UxJ/65E2ttIcen24Qx87yKL6TS+IO2Ma7lqEif6HUBrZcItsgZvr1IBSu1mGL
         GSQZq1fRojAC8L1CfGdES4zn6XKBq4oouOsfyEG2FB0q2Me44SVH49jm+GM0EaTfJ7v4
         PZ5G/+VttiGq7YXKJu9mwntPdSXakoBcXPuZKgLEalxWwoqWynDHjv3hqDTAP/cLtOr4
         IKgGtOfVCYEnsJnA15UyC6DA40toiVtau3Y+IFcVZKlTpHnFdOoh6JpD0nN+ZHrcUxoH
         c6GSYx5GFK3QGawlL3PRuCU8lFKGwK+vrdGIHprtwCmJ9TOo3AuVjP2DcR4Z0WQq8hJ5
         FP3A==
X-Gm-Message-State: ACgBeo03qhKwl8wTJB1gJqJTA4/9J691luFNnyCaphxeDzE7/Nxip9ON
        a+F26PBceTGxmD/fhE5Tjr1NMekxv8OHlA==
X-Google-Smtp-Source: AA6agR6j7BjlYIutf7gUQrs/mZeDhtQb4iGNQel25eY3uZzK4zCu8UPXe4VGhjH3JfqcuNKdOeH7ow==
X-Received: by 2002:a05:6402:1911:b0:448:da24:5f23 with SMTP id e17-20020a056402191100b00448da245f23mr22967451edz.61.1662324110467;
        Sun, 04 Sep 2022 13:41:50 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7d595000000b0043cc2c9f5adsm1189654edq.40.2022.09.04.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 01/32] bpf: Add copy_map_value_long to copy to remote percpu memory
Date:   Sun,  4 Sep 2022 22:41:14 +0200
Message-Id: <20220904204145.3089-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611; i=memxor@gmail.com; h=from:subject; bh=RjvE7zUDoVrmzzdPuabNNVkyhbnnkYHyX7xfQbvclBY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1vnTIiv0Q1ZMOdg1PVmguvOSjjBmWiVuEeU3/3 ANQkReiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8RyhpyD/ 9pYCkWFVDI8/EZdd65pn+aTt38VjYXtxekYDqMvd/U3UGZa4urMXJQ1K05hc2CTncYTx2Pjfo+Mc2z fOokPb0p43eyGPH0XZOYFz6Xgs69vxilo3SYS57lF8GYwCUscJmidk1Mk5OclJ8h13P3yFLnVMhz3Z PoBqQAqBPTY7rv5yJhtKpncXDyaBbNWjnkcPsDkbYFaBjwpGS9QjBbiU2GPrhiB2dH3U8GWA7je4kC 3XoJDQCdX4ksM+rTuJY7KsCpeIjh38XSPYkCFo5n9qquTJGvKaFmv+3WbW12Zj7KfN8vNlr7No178j 95Dx07N+FtZBDY/eGhBfMgfJrE9mqXTD8fWwkuplGEeoKgdW/yi2b4qiR+YfZzpKgjICK/VzKAg0kf GX3wwnqLI/yozu2QnD1njlqZd/QZsSWdyS/PTJv5+Mex8+bkCIsYoJNW9hCmDXLCF2+WhbNQwoj7Eh BKELnu8R3pLQ1ta/ObnOUFUEJfV2x/tlr/nfXV+YCJUPppM+ur6jHKXbDn/1XZfw9GK40HXnSTjc0/ k+66z4bNSi37UP3GjUUESLkS2kx/7Q7phovt6T39kpqbksyd4TEOLO1MeJ8JbWg8xJTDBLXduG0EOx A0mixPzaDWj2m2lO2aCMmsELCKHIrS+fPo79uaqpsBudIabg42s5WiwoEUTQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

bpf_long_memcpy is used while copying to remote percpu regions from BPF
syscall and helpers, so that the copy is atomic at word size
granularity.

This might not be possible when you copy from map value hosting kptrs
from or to percpu maps, as the alignment or size in disjoint regions may
not be multiple of word size.

Hence, to avoid complicating the copy loop, we only use bpf_long_memcpy
when special fields are not present, otherwise use normal memcpy to copy
the disjoint regions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 52 ++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..a6a0c0025b46 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -280,14 +280,33 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 	}
 }
 
-/* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
-static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
+/* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
+ * forced to use 'long' read/writes to try to atomically copy long counters.
+ * Best-effort only.  No barriers here, since it _will_ race with concurrent
+ * updates from BPF programs. Called from bpf syscall and mostly used with
+ * size 8 or 16 bytes, so ask compiler to inline it.
+ */
+static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
+{
+	const long *lsrc = src;
+	long *ldst = dst;
+
+	size /= sizeof(long);
+	while (size--)
+		*ldst++ = *lsrc++;
+}
+
+/* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
+static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, bool long_memcpy)
 {
 	u32 curr_off = 0;
 	int i;
 
 	if (likely(!map->off_arr)) {
-		memcpy(dst, src, map->value_size);
+		if (long_memcpy)
+			bpf_long_memcpy(dst, src, round_up(map->value_size, 8));
+		else
+			memcpy(dst, src, map->value_size);
 		return;
 	}
 
@@ -299,6 +318,17 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 	}
 	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
 }
+
+static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
+{
+	__copy_map_value(map, dst, src, false);
+}
+
+static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
+{
+	__copy_map_value(map, dst, src, true);
+}
+
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
@@ -1823,22 +1853,6 @@ int bpf_get_file_flag(int flags);
 int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
-/* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
- * forced to use 'long' read/writes to try to atomically copy long counters.
- * Best-effort only.  No barriers here, since it _will_ race with concurrent
- * updates from BPF programs. Called from bpf syscall and mostly used with
- * size 8 or 16 bytes, so ask compiler to inline it.
- */
-static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
-{
-	const long *lsrc = src;
-	long *ldst = dst;
-
-	size /= sizeof(long);
-	while (size--)
-		*ldst++ = *lsrc++;
-}
-
 /* verify correctness of eBPF program */
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr);
 
-- 
2.34.1

