Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A11646286
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLGUmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLGUmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:42:06 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73144AF36
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:42:05 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id a9so18150818pld.7
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CDnX8EoSYIgJ6yK465jEVxSIns6OgEgCzmYMYB1z3s=;
        b=eIhIsifOtuDDT/e3ofYkkhM18fyqadxfgrLcPSEelEDct7akvmRXj6n8D0G/GMJEyP
         1tJqX5dHkUJQ4ZSXLqi7JDFojlNHy3sOsj7WdAJ7p9frQjfYt6LtFxIB1Psj22bcnb6+
         TvWDxbVIuxvuElXkT6Qy8dki5tbqSjR3EY/yd3XVdvE7A6tp6xEdJBcuvbMKj4S4hvkx
         0iybXbD4RoqD1Um3QOo/7Vyl7pisCzdTC9VyK24BswyBxHcosXc1CrM99ftB9k26rX9R
         vJRXEdqAdZ4xBxFLk8jQC79+jIJaKw2YbuA6BwqqMTTgsSFMjeNx0/4hCr3IQVFryzNW
         z15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CDnX8EoSYIgJ6yK465jEVxSIns6OgEgCzmYMYB1z3s=;
        b=FpcUePM6zPoeST1GM929NkqRgiM+Ap35EHuVmg5Y/amOR2AYscP2Z75Fe2IeE3ZlwA
         2jFCgKdznY25viHVJrNlbHPiotjqEWTpLvMRxk7XhM7fuI57iYE/vc9Guc0dyY1/1byM
         mctsRd3877T4zavB9YyyozUQO4/T+t75xKiPw3jXMRyUIaq9a2HXTf2I5oBmmEZYr/a9
         eBMcrDV574xsO51GiUpHoxVESSkxxSdUUmAROOcCcoyIceZ1EA3+hguPDIOX6zNWJTrV
         6UdsmzffnUsYXlGVsWy62zLq+aw/Wp+NO2zkOeLwHaorSIH4rKaC4Bw8wA64mCKkJzvj
         tbZA==
X-Gm-Message-State: ANoB5pm3xc2fykyzNPLGCi/HUK7L7NK3sw6DhmozJLmpito1lIUXnsx9
        riw6E6ncMp1ku1ePl9QRJqi771g3m04dGEyQ
X-Google-Smtp-Source: AA0mqf7Dr8r5IacTjidNpD+jopyjSrG7WYrYZi8/wp/tW5cvTPcTkqF5D/jcWHI7SMqDLow3shh+jA==
X-Received: by 2002:a17:902:820b:b0:188:9ae7:bb7d with SMTP id x11-20020a170902820b00b001889ae7bb7dmr79837304pln.113.1670445725094;
        Wed, 07 Dec 2022 12:42:05 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7947a000000b005779110635asm1507355pfq.51.2022.12.07.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:42:04 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 6/7] bpf: Use memmove for bpf_dynptr_{read,write}
Date:   Thu,  8 Dec 2022 02:11:40 +0530
Message-Id: <20221207204141.308952-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=memxor@gmail.com; h=from:subject; bh=LDqr3sPsObi4Z0BDbi2OYbns1fiOWuI8Zt27lLRBGeU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOpHzNFoUpEXusxB1IzJKKFNtQBS0EVx1Qhy5ZD DVAs7V6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqQAKCRBM4MiGSL8RyuLkD/ 9BjPxLkmQrKIsQIwOYCNgQfrdC8Trbw4NCwWMxJC+UPqVYf+ikkwxggOSCuH4kuVJ1cC9a5eCm/lGi 0sZeolysKiEC3vjdQ0ysHwZHAb5CKg0xLV/QnOkVe4kUhPooplKyGgNupHqTsGx0Q2ZOKEYgKmwosO xJsr59DgShEunwi/g0XMFjBYf4HXGa0txczMOZ7/M3G8uBQPmY8LMJW6S3gooTL48rgf1/yi2/GzJU jw4uWH8d6zDS8lOYIuHiHx1R2wh0UuZDhysrrLXZEAw7+Ngh4ecIEBsoAzsELFqu5sFVPmiFyH6mK6 0CNInB7EHDclrtqVNhif2w8IyZD0DVW84YXmJjgisgZLlJqyV6Xb7AUgb09VOH66iqTGjXQ2S/MpWi /dcP5G/HompBnNGox3dOXwwxjI6kHf4Ow/B/pzi+klyL3Rold/UhwFxbsQpsVcQfFCjS5osHEsE+Se MMxAOFhXNkZTxF6RRiyQsXMQOvC69ABO6ptzAOY0JxN2K0CsyQENsG8CUz3X0JedO7r1sJ42iXCG3w 9yvL7GWlGfx+PK6viPO+fgCtDxz2uNX/elJxTzIolcW7q4SW2uuB0tcpCUlSe2CY+lQpyLcAuoRQHQ OsC9OfnGCfYSso2QbMYN1z2vMblXYSfbtMfgnk0zCxrlt0h1jPHn7UAMmmaw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It may happen that destination buffer memory overlaps with memory dynptr
points to. Hence, we must use memmove to correctly copy from dynptr to
destination buffer, or source buffer to dynptr.

This actually isn't a problem right now, as memcpy implementation falls
back to memmove on detecting overlap and warns about it, but we
shouldn't be relying on that.

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bf9a6a646254..842229671af0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1495,7 +1495,11 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	if (err)
 		return err;
 
-	memcpy(dst, src->data + src->offset + offset, len);
+	/* Source and destination may possibly overlap, hence use memmove to
+	 * copy the data. E.g. bpf_dynptr_from_mem may create two dynptr
+	 * pointing to overlapping PTR_TO_MAP_VALUE regions.
+	 */
+	memmove(dst, src->data + src->offset + offset, len);
 
 	return 0;
 }
@@ -1523,7 +1527,11 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	if (err)
 		return err;
 
-	memcpy(dst->data + dst->offset + offset, src, len);
+	/* Source and destination may possibly overlap, hence use memmove to
+	 * copy the data. E.g. bpf_dynptr_from_mem may create two dynptr
+	 * pointing to overlapping PTR_TO_MAP_VALUE regions.
+	 */
+	memmove(dst->data + dst->offset + offset, src, len);
 
 	return 0;
 }
-- 
2.38.1

