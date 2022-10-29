Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE42611F71
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJ2CzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 22:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJ2CzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 22:55:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ABD1EAC1
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m6so6326523pfb.0
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qJ7S49lyvTDwTt3B9pGKn80j22VNRERALv+i33GLIM=;
        b=a46NttKTxFJVeKEP0dM7f1ceG9rDOhMGHKQnxUUJMFVzoMrz3QWrUqBt38mmTWnQGA
         8G1JSVaxdV2ultNUYGygLC1wslfCRLrH79sALmI8ORz1+jGNFsRL611hD53/yntVNw4B
         Zkdm1wBz/oX3OLbzldKPiIaZUw9YL8uJwjLBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qJ7S49lyvTDwTt3B9pGKn80j22VNRERALv+i33GLIM=;
        b=CvgeF0JQtvcg1O2fonbJNdLsYFdlTxnjKcYdoF5Xfv+eCBIJABguI/OT15XW07pt3K
         6xZ6Og728vw9t976e47wPfFsOBm+HcNH1cOX5QV8iQBwe8RNfjTHt0htfNxpiPN0RYIN
         v1Vs1vzhuhMiB4h1gs4HfyptAgAR/wQy9ailNB3VGanU2denM+bH9Ow3DIaO1c5jqQiZ
         SirkAyhTx1RMlQYCIsFZh7rhxTAhWkdFkm6Xql4vK8+N8zDM1JeV7ClMM8jTuNY1pkOY
         gYYt5GR2MxYAxtTtWOkBfJBLDbKcExoBkRHCAHSclLT+3DD3X+t7iY4y16XW/cXXcKJh
         tK4w==
X-Gm-Message-State: ACrzQf26EixkBvm9EvUShmxIJmIA2w6OT7BibvUIYNpvVri3GYUIeauA
        61RnGt+XL0e3Hv1pn2n1GA1FGA==
X-Google-Smtp-Source: AMsMyM6uHJfLJTmqpTUJGpVT4+/uLAGaB6HoSdxLoSHvhmHZwW2kNEnJvIGSouS1s5ZG+ccVJbZ7tA==
X-Received: by 2002:a05:6a00:1ac9:b0:56c:e35b:3ce with SMTP id f9-20020a056a001ac900b0056ce35b03cemr2405674pfv.76.1667012075865;
        Fri, 28 Oct 2022 19:54:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ce0300b00176b63535adsm144895plg.260.2022.10.28.19.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:54:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf/verifier: Fix potential memory leak in array reallocation
Date:   Fri, 28 Oct 2022 19:54:30 -0700
Message-Id: <20221029025433.2533810-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029024444.gonna.633-kees@kernel.org>
References: <20221029024444.gonna.633-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; h=from:subject; bh=R3dgFp0WNEaE5DyG4WxLN0RrYSteV9dcGhEkWDiXzvE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXJXnp3Ea19E3WkEr9o8FAh2necyessJ+7If2U/2x vL4vvxyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1yV5wAKCRCJcvTf3G3AJkffD/ 495y2Ah8ie6a9DRLJ56z541wAuD1q1LglGfd3C1cbGoOR76OU5kPPGuDGY8Npallv6VrFij94Z81sA 4zyFjmaROOGYwctXbNfnfbp5rKO7FMsPe+NZ72GoCxuE6dWHc9XOsS2KRMAc4SaeDz8ZgZSVr3hZTX CeMuHtwh0BnXQ8JR4WstYUjUpLWQy4S9kpJJJ2KicSVC8iEWYWkavGVV3zZT4gDE1j4bKhq0FH1iwa iBZ+KB4Ubg7hEgqx/2o6raZKsUlCQLv5C0krkqAeKTisXS/5x4cqu1LYGxE4KKXvKjMyfv+/lXp6XR GXYnwp7rReKyUA+ajg3BVlvXPvGkLW3R1Zd3vUbg4HpFEGF+MkTCsRz5Tvbb4B/M7J9PnIWBEL4g4I dccXIQa3RVocJ/4jixQTLo8BBqkTub/60/5zl5mJVCUdD0Vz7XTh52FqroKRh1Vy1TSDYseP+AZfh+ p0WkmHXJKX9n31sJSgSB7J+rz1bu1syxfbeQf8jMKFgQ+EeH1SxGlNnTbS2DBF2Akh0vNbJMsVNuRr tDAVlwSuRS9YURTtlMBMpJ27+Sqb6mGhKWpkHoqo3hfTM5rjKK8caNpk+TFmRkiXcyFHaNHIAYf33j xCahoS/rV03jEY2g6AYq81K4kUoYC+3ycJMhysPhSQn5B04YHUtjliF3oaEg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If an error (NULL) is returned by krealloc(), callers of realloc_array()
were setting their allocation pointers to NULL, but on error krealloc()
does not touch the original allocation. This would result in a memory
resource leak. Instead, free the old allocation on the error handling
path.

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
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 014ee0953dbd..eb8c34db74c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1027,12 +1027,17 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
  */
 static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 {
+	void *new_arr;
+
 	if (!new_n || old_n == new_n)
 		goto out;
 
-	arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
-	if (!arr)
+	new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
+	if (!new_arr) {
+		kfree(arr);
 		return NULL;
+	}
+	arr = new_arr;
 
 	if (new_n > old_n)
 		memset(arr + old_n * size, 0, (new_n - old_n) * size);
-- 
2.34.1

