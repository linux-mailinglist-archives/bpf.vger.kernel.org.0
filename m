Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D319A602DB8
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJROAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJROAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00B67CAA
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c24so13934901plo.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab69KN2/e44z8xRbQAhKsu+NTn2Sox1wt5+f8LQTZSU=;
        b=aM63/vCM1YqQjxumzUMwmtgft2MBDFGAfHXJIF/D7vkRItgXzeMRMmHSx2QiCxgxM8
         RJaslAsw3amJOvfciJV5ig9m0nZPPr9PJzf+45zEN4gU/fY/fD10M8bHbX11WCKaBqSI
         p1XRJvAEVScgvil7bKtq4gtE454PP0BftCZa+6dHQZIxDVvQhXVpHHBqRUWz45TNg5le
         e4vgI/F4oRsKOCJCgZKW7xLvJnLlZlT0PXqJqqXr+/vt922u/JOCB9HboMqf+R6c8Y82
         cdhlFUnVyfjXOZhavbagNI1AJfnzdGF0FX83zowIYJMGPYj3xmF1Q5WzG8ZqkX9gWL/1
         iM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab69KN2/e44z8xRbQAhKsu+NTn2Sox1wt5+f8LQTZSU=;
        b=p9PEPKEec+XDHj1VfR8JnX93nMwHJtuZEA1tcDraUlB2q58ppxPNARHuvkpX5czT4F
         67TCKU/bGOsrRXY38ysXx2xOhJyU1/oeqM0N7TeGkZw4J4hfKKbnCDWzTBTZnR1lxKg/
         K6IehZP+9PJQyRwzM2ezQIG4dN3J/rKBlCe5+G1OaYxlDYMPyxSAA6aA57/tsc4BiWSS
         +tSFVBwAgk3YzLiC5xR4gQcY0TKXXpTZV8GMA011M7dOAa/mibkJxvvG/gwSG4P+8B8F
         OXa4o59SXzMCZUsE62LAdgnxztmhbmBKP/LPP0r72Md1/9PaM25bF5ZPD6+zcQHM57dH
         N0hA==
X-Gm-Message-State: ACrzQf2TH0JhnjHsLUHfBvJ3fpyBDOqzONApzf8XlQwxTfowaWsqaWrh
        T194gPe82SHw7WyEq0d1p4I/BH+hxvhobg==
X-Google-Smtp-Source: AMsMyM65Nha+HkNct1B+6xzhZHg05h3cr2C54u78Uz0/spGHTudQ3FS4ZfRJ7hx2p4uFZO9Pc2lQ5w==
X-Received: by 2002:a17:90a:65c7:b0:20f:8385:cc18 with SMTP id i7-20020a17090a65c700b0020f8385cc18mr3443147pjs.235.1666101595586;
        Tue, 18 Oct 2022 06:59:55 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id s90-20020a17090a2f6300b0020a8e908dc8sm11448603pjd.4.2022.10.18.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 08/13] bpf: Use memmove for bpf_dynptr_{read,write}
Date:   Tue, 18 Oct 2022 19:29:15 +0530
Message-Id: <20221018135920.726360-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=memxor@gmail.com; h=from:subject; bh=yy0R7WMEdJOFW1d2cPFR+SghjmgeriaKeEiD8vgQa48=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEiI8CDi+t5HXehhdsBZK48eu18pbylvZrWKgzQ tpcCmG6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RyvrqEA C8FzhtAAD0ruo9ZiapgZZtBSyxKC87I8qLEgYnWACofz6GvXbDy1Y6C4vK5NWy84m8ZUdOE2SWRtn5 WyPUDsYIRqbYiiLkgDWWuebCcd/SXVq/GKK/R3q9UDxXSeCOkZe3KmzfSMmnL3YTM4bdLxH9amj74t l0ggn9WVNotAgjrv5fa/n42LygMmnLt8f9f0DxfTG9B5up4ERCB2HTy6YqdPFrg8hg0b0Iw/RAIJUn rKaLMTv5N/IiZyprc/1KRuJsvq0DumLwXrs0x8FT8sG4dTluATPLTg27ru23oYQu4kYVK1+HYy0uCX 6As98zzcMGvlNLybGaJ2U8jhTjFZ+WF1rSBYKcZahFxb8YnxzgC+R+6FJ3HltmI9CZRTwXZMN063gT dVmrfJODoPCRGXr4BcLxrtx1sZhYTnCz6ZL8iPigRLfgNGK6vEyaOd/SRX9MdPxsrv/4TsGEEwz4sk P74pb7ZsI8hVbCv2m//X7xGUoPP7uOb3cL+z0JHPIy2UhHFMELJCScekiUKjfPGcTM38ttLKBNsSme 8XwKnKBUdDJ+nxD1gpI3ULjjMT78ejkaq1yXML4/EYVfx6wv98jZAo6+ST3q9eSgLrfdft3Kt1ecc8 46QRCeWTvvJXwo//u6tYECDR1CmeCOxT12a9nytPg6hUQExC9otfeRtyZ7Ng==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0a4017eb3616..2dc3f5ce8f9b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1489,7 +1489,7 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	if (err)
 		return err;
 
-	memcpy(dst, src->data + src->offset + offset, len);
+	memmove(dst, src->data + src->offset + offset, len);
 
 	return 0;
 }
@@ -1517,7 +1517,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	if (err)
 		return err;
 
-	memcpy(dst->data + dst->offset + offset, src, len);
+	memmove(dst->data + dst->offset + offset, src, len);
 
 	return 0;
 }
-- 
2.38.0

