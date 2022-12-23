Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D46553A2
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiLWS2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWS2w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 13:28:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F61EECE
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 10:28:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so8065406pjb.0
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 10:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFmJ94vgdYtHsEMf0/KuGJB8O++/BC7ohIyt5Fgn7pI=;
        b=ElgK4ZOatixFeDSXHWG1Ja36Gaa/aRySfgH6IWbKvHwrt+qWRmB8Q0V6Axbh6WUnIS
         95A/hEHYA64Jr/hlfVkIc/NbGXmDDT1rwsY2QZorZnE25auressDUTSkJCD91hYmSBgT
         3B58T79yKrzeMcWOjAtdRIiMm1gQfdBnlNI20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFmJ94vgdYtHsEMf0/KuGJB8O++/BC7ohIyt5Fgn7pI=;
        b=ibU/8bnYsDH/c8XJxGWdH7Wsz4H+A8UpxYRxt+K9v8W9kIntUx+L/oYRPNXTVUgwYV
         uVYf4SGG2xbpE64J2AarEfhQRtIlQ5Jn9mNTJ1r3EDfi0mVMI5RyoqfOklj6rwjcjlyG
         YHxqiB7B4Y54Fh9+cWxhSngA8eqNrU5rKXsIF4Ei9F92sF4CQ8HQczv/uDzB+63E1kvv
         9i3Bs4OF4m09nvyjWRImSkP1lskORjMkt6wstPm43t2FzMQesyFS73Sq/YSdLH2qKKNl
         +XtmGqwpciHSA/UMyiFxG78vWNYlqyiaCV+c/YppJZGSsD/N6VXAdrXO+A6rXZSl9scB
         qSHg==
X-Gm-Message-State: AFqh2kpDSxMe+tbSPkAtWpXGZ1KFtWcEzdBkxw3awPMcJfV5bYFro/J2
        B7W0VmhYBEzAq4rNKtH94Mt3iw==
X-Google-Smtp-Source: AMrXdXvdOaCB6ie+xu0/3TyseJFb8oYp2nnjiDsW9wbBkVz+xBXlhD9nOsqGw7ayHOFxxe0wYLovFw==
X-Received: by 2002:a17:903:328e:b0:191:191f:e7af with SMTP id jh14-20020a170903328e00b00191191fe7afmr11434481plb.16.1671820130175;
        Fri, 23 Dec 2022 10:28:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b00189c62eac37sm2727890pla.32.2022.12.23.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:28:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Hyunwoo Kim <v4bel@theori.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] bpf: Always use maximal size for copy_array()
Date:   Fri, 23 Dec 2022 10:28:44 -0800
Message-Id: <20221223182836.never.866-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; h=from:subject:message-id; bh=t1OBGhUbcR8nf2++QuxM7FqpZ9UFkmqZvOnliSZEUTE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjpfNcsRz8afKnm1B38atDy/LxrBm3b4UZpSVoEyiC oYseHr6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY6XzXAAKCRCJcvTf3G3AJkA0EA CQvcv59+py3Ot0bfishkg0yCD3rI/T6QxpeFBbXklzHVSMjI++zbfBaTXo91O4rwjrC2NoDxEPY0xx D5mr5lj2NDFwNMvff8tSRJyH7COrX9W7wMoHR38Bhp4klOmbWWIeLjL8weeD7vm+17jmOP/PtTo/wM ++vHN/270KNs9+XfDR81LRnRze89Oir88FBWTtQDVmyz1t/ILTosrmkczJ/WhTKOZD8epirnm883Id Ixer5RmOPNpZCNu8H0KM32WKmyClUDMdy5JBIAqCPd8mjWY0ke9b6zhExgu9z6oBLelR/WFkmAs45w ThqMBox1hgSWHHZPD3lPfbaLIdaR5YwO7VHlKdCzgnnt1Vp6KeuoDuOSHoiXpauzS2tB/NW41p+h6M 8C6fFzPZfF8sgLwXRpoOasVGgrdCCZAGd7TE3wS3KcPh7BlM9UI7Yr6O6I8gik9sQCvhis1jsxUmHD Pysboz4zLQPLmA9dhBFWLCBfUpQ8AWk8ytREuiNrPrX1mLI3vKrFGCY12vF0MPvg0h8RWG00+dOwrP XBcasg0ir+Jd3pdQDUwS3AW+t2/WFyJH6Id5UvAJX9t/GzhMYFTAhT+Z8W7AuUI3mhn8Qgih8/6n5l zLTvUzzDuG3+3qhaytMOM265N8GDR2JIsH3tXcSa7B6I0XzQ2+PqoOki0lMQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of counting on prior allocations to have sized allocations to
the next kmalloc bucket size, always perform a krealloc that is at least
ksize(dst) in size (which is a no-op), so the size can be correctly
tracked by all the various allocation size trackers (KASAN,
__alloc_size, etc).

Reported-by: Hyunwoo Kim <v4bel@theori.io>
Link: https://lore.kernel.org/bpf/20221223094551.GA1439509@ubuntu
Fixes: ceb35b666d42 ("bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/bpf/verifier.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..969e61bd6d39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1054,6 +1054,8 @@ static void print_insn_state(struct bpf_verifier_env *env,
  */
 static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t flags)
 {
+	size_t alloc_bytes;
+	void *orig = dst;
 	size_t bytes;
 
 	if (ZERO_OR_NULL_PTR(src))
@@ -1062,11 +1064,11 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	if (ksize(dst) < ksize(src)) {
-		kfree(dst);
-		dst = kmalloc_track_caller(kmalloc_size_roundup(bytes), flags);
-		if (!dst)
-			return NULL;
+	alloc_bytes = max(ksize(orig), kmalloc_size_roundup(bytes));
+	dst = krealloc(orig, alloc_bytes, flags);
+	if (!dst) {
+		kfree(orig);
+		return NULL;
 	}
 
 	memcpy(dst, src, bytes);
-- 
2.34.1

