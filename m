Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076F93F2196
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhHSU3M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhHSU3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 16:29:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DEC0617A8
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 7so6597135pfl.10
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23NqigPoreurbrTRI3DzstnCrCz1u9qo8AUicrCllIQ=;
        b=F/aXFSEFO3B0S1KjxtCFJ0bHN8UOoU5i9j7QIQ9H4wCLpPExP8i4eq1nUqdGC+vTAl
         qpkYSn/zo5uF001tqNcSIy5OHDEEyNlsMGJFCO4L+E7F3tNOhKH/pjcDNRFmTt4sIiKy
         R+62ZU9GtHuOUMyC4YOREpkj2XaWxyuMRkKPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23NqigPoreurbrTRI3DzstnCrCz1u9qo8AUicrCllIQ=;
        b=NcswYRg64YSkCSn5QmqMdV4H0xwZFODbwUnXWN4+10fQ3mcn3cwZ6gmsRYHbGJY1gk
         bqMUPmj71hkOWul03z/z1CSJBznUYsgdRyjBjidpLEgYvypXh1ydbPHuA5Rn6fYoYtMx
         Mr0Gmp4y70qmIMvz1czsSU/m/mXaUxrJRY1z0vtkjEvR+Wd10RzgIHUI5kph8HoPoSNQ
         xTJgtwQfROR5O2PQIg7Qs4kmgzwxVErsCxx+qrtdiCw6l6Gqch49C7XwvQhYeVeW07SZ
         PU+3M4pvIE33oVgVNMgLep7NQ2aVI1xe+iL7FO4ncBH98ZMDmk1zaA1N9frmwW6yQTEU
         LPUg==
X-Gm-Message-State: AOAM533RKdJYyFlkQpMHAEc3C+sIJdOuS72oMDAEC/zeNGwg1IpCjjFI
        Ig05ZQQ7FXmg1ZPqNX4rsmNeFQ==
X-Google-Smtp-Source: ABdhPJz+KOpZhGJ5FXJOigQpPSgrYjpb97GBUvqFXR+qoBMUxfptkbVry7hNayEJ2a7UzVP906Pfwg==
X-Received: by 2002:aa7:8b07:0:b029:3c7:c29f:9822 with SMTP id f7-20020aa78b070000b02903c7c29f9822mr15973588pfd.33.1629404909020;
        Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k25sm4370211pfa.213.2021.08.19.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:28:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] ipw2x00: Avoid field-overflowing memcpy()
Date:   Thu, 19 Aug 2021 13:28:23 -0700
Message-Id: <20210819202825.3545692-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819202825.3545692-1-keescook@chromium.org>
References: <20210819202825.3545692-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4716; h=from:subject; bh=3b5t4fLR/wEetR2E8Hwk2j3VzU8yz2BgAEsleqg3XAU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHr7o3RE3VXLm1V4wHPPpY4uHLTNlH2i9cpT7/zcX 6bMNqjOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6+6AAKCRCJcvTf3G3AJumUD/ 0f1bg3FbVuqAiMBaS9IMEbmlwImkHFdXvVqAGU0c0JnDVZSLl2o2jU4irNcZfOHOGiyYpNUxA8mBNP Y0BXEwPXwzfEODoS/bKlfvvDB4v5d0nQoewu4eFdhGrxNUqnaYxIf2ZgkWFpbxJQnWNR9PSXhdRv/7 8Xe1K+TlHO/3aUYVYuWA/xyvHtdSpptiyvVf3SzuCCmB1Nxzl1mT2w8+AUzjXJ33G+FItKamDkI9iU fpmEm+7I35jZniX3qbMeW+pB/I1M/xgCAPZSeRkDk+x+5wL+ENoCG8oWONDewGhXmjydCkRSIcCinC Iw5eONYFN8dyEG0CljmQvmUrLMIaIowHZwfIbrnf2We+VJEMYCDc6DwIe6OB/fNutrXM0C7eF9il4z PrdDwnVMQawJ9pmSFF8T8fSvCFQ5IYh7/qiP+bYkKv6D6iBH8sep+aWaGHsPbXJCBTV4MSCj8Htluh T2+HVUM+wthFo1IgE64PMPX1dOnTXs6C/w+96vYw3d8flThTGS4zgwyEIXUBWVuqFeyl6zwyNeC2s8 91oO/WcGpuQ7nfQe/lhNmXygtElyjfy8OrkfQqJzAHjJOr7/h9InrqLU8Q93mnIFEx2mDaWcrJUMYR sQ8w+xtOk+PnA9bV07nr3lpdK4YQX8rffoX2nSX4l2Yc4i2FTP3Z66PxBt+Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

libipw_read_qos_param_element() copies a struct libipw_info_element
into a struct libipw_qos_information_element, but is actually wanting to
copy into the larger struct libipw_qos_parameter_info (the contents of
ac_params_record[] is later examined). Refactor the routine to perform
centralized checks, and copy the entire contents directly (since the id
and len members match the elementID and length members):

struct libipw_info_element {
        u8 id;
        u8 len;
        u8 data[];
} __packed;

struct libipw_qos_information_element {
        u8 elementID;
        u8 length;
        u8 qui[QOS_OUI_LEN];
        u8 qui_type;
        u8 qui_subtype;
        u8 version;
        u8 ac_info;
} __packed;

struct libipw_qos_parameter_info {
        struct libipw_qos_information_element info_element;
        u8 reserved;
        struct libipw_qos_ac_parameter ac_params_record[QOS_QUEUE_NUM];
} __packed;

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 56 ++++++-------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 5a2a723e480b..7a684b76f39b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -927,7 +927,8 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int libipw_verify_qos_info(struct libipw_qos_information_element
 				     *info_element, int sub_type)
 {
-
+	if (info_element->elementID != QOS_ELEMENT_ID)
+		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
 	if (memcmp(info_element->qui, qos_oui, QOS_OUI_LEN))
@@ -943,57 +944,34 @@ static int libipw_verify_qos_info(struct libipw_qos_information_element
 /*
  * Parse a QoS parameter element
  */
-static int libipw_read_qos_param_element(struct libipw_qos_parameter_info
-					    *element_param, struct libipw_info_element
-					    *info_element)
+static int libipw_read_qos_param_element(
+			struct libipw_qos_parameter_info *element_param,
+			struct libipw_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct libipw_qos_parameter_info) - 2;
+	size_t size = sizeof(*element_param);
 
-	if ((info_element == NULL) || (element_param == NULL))
+	if (!element_param || !info_element || info_element->len != size - 2)
 		return -1;
 
-	if (info_element->id == QOS_ELEMENT_ID && info_element->len == size) {
-		memcpy(element_param->info_element.qui, info_element->data,
-		       info_element->len);
-		element_param->info_element.elementID = info_element->id;
-		element_param->info_element.length = info_element->len;
-	} else
-		ret = -1;
-	if (ret == 0)
-		ret = libipw_verify_qos_info(&element_param->info_element,
-						QOS_OUI_PARAM_SUB_TYPE);
-	return ret;
+	memcpy(element_param, info_element, size);
+	return libipw_verify_qos_info(&element_param->info_element,
+				      QOS_OUI_PARAM_SUB_TYPE);
 }
 
 /*
  * Parse a QoS information element
  */
-static int libipw_read_qos_info_element(struct
-					   libipw_qos_information_element
-					   *element_info, struct libipw_info_element
-					   *info_element)
+static int libipw_read_qos_info_element(
+			struct libipw_qos_information_element *element_info,
+			struct libipw_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct libipw_qos_information_element) - 2;
+	size_t size = sizeof(struct libipw_qos_information_element) - 2;
 
-	if (element_info == NULL)
+	if (!element_info || !info_element || info_element->len != size - 2)
 		return -1;
-	if (info_element == NULL)
-		return -1;
-
-	if ((info_element->id == QOS_ELEMENT_ID) && (info_element->len == size)) {
-		memcpy(element_info->qui, info_element->data,
-		       info_element->len);
-		element_info->elementID = info_element->id;
-		element_info->length = info_element->len;
-	} else
-		ret = -1;
 
-	if (ret == 0)
-		ret = libipw_verify_qos_info(element_info,
-						QOS_OUI_INFO_SUB_TYPE);
-	return ret;
+	memcpy(element_info, info_element, size);
+	return libipw_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
 }
 
 /*
-- 
2.30.2

