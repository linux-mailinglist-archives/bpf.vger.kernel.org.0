Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754960D71B
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiJYW2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJYW2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4B76977
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q9so16695479ejd.0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3kHPOaGpPAJ0oeh2OhuYbH6g3Kz5mjKU8RpDZhAE6o=;
        b=gqfBc+LzJh01HvJnsphcv8sQ/dWjW56uFFkx4/2R2x6DwB7eMsLMCNnRHCiazCK6sI
         y/bN7SeHux+Sg5YVzmUbJZnAqW9kiy0TKv7Cehsmd2o6tXv/XFrXuJ1yFA5B9a4KB96Z
         y8L8KvViMjt1XQZLyivgdsTZpVpFi6gXjQ0kgHShUAdirYdAcygAvCvtqr9Khax3qJvo
         2fSaOOg4pd0mpgsAUZf5kcdfLxHXycVvQWaUoICjz8Xi0CHYQ0Oh391XxTjPcBOpSRS+
         cqBRwCn8lYBLzyhUPJRgx3QdG6WNkfdUCjnSCCB2rMypJ7FUehZP7zVCsuIiB6SAyXU+
         +i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3kHPOaGpPAJ0oeh2OhuYbH6g3Kz5mjKU8RpDZhAE6o=;
        b=K/SPwm42RSXmTuNyoRNU4EP7bZb6gnqtpjbNVUDZFTKdj2hSDlvG3Wao/lKU9l5aVk
         uZJPQE7GS6/Ci8Pqney11haeIAwy9Y2F+wRKqf5dlUK+4spb45NdkjtGmLoqxf7cB7QY
         j9zEQFyCHvk0hJA4oD0oaZWyAsJSLQnU2PaUXTD1CmgT/QQEM97Hp5KVDQhUrXq0Vkab
         Ro/rAG0BHrcUo+/po2u/TiXyQTkf5xCMO4LyvuSmzUkvip1jYPRA1YxdOfIeyCi2x+d/
         Su7wrSsTYU9Nqyxw5jw291txncCSO5L3/7AR8MR0EEyy608QFRh2ZqZ/wI0Z+4keM8Js
         4WZw==
X-Gm-Message-State: ACrzQf3YDO7LO1F14/gmyjwBiIwEFZO9+nhK98GspSrwwZb5EIvkDMQf
        /oCPZAAsEtQP1qflambjvzhI/4H2AX6ukv5b
X-Google-Smtp-Source: AMsMyM49phYRFztQVzP3oK3I7YnfH0F7CTkJQfG//ET1r7UAGKGSYVJ1onoLcfAQpkuokFRy0jngig==
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id wu1-20020a170906eec100b00782638476bemr34661780ejb.756.1666736927871;
        Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 09/12] kbuild: Header guards for types from include/uapi/*.h in kernel BTF
Date:   Wed, 26 Oct 2022 01:27:58 +0300
Message-Id: <20221025222802.2295103-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use pahole --header_guards_db flag to enable encoding of header guard
information in kernel BTF. The actual correspondence between header
file and guard string is computed by the scripts/infer_header_guards.pl.

The encoded header guard information could be used to restore the
original guards in the vmlinux.h, e.g.:

    include/uapi/linux/tcp.h:

      #ifndef _UAPI_LINUX_TCP_H
      #define _UAPI_LINUX_TCP_H
      ...
      union tcp_word_hdr {
    	struct tcphdr hdr;
    	__be32        words[5];
      };
      ...
      #endif /* _UAPI_LINUX_TCP_H */

    vmlinux.h:

      ...
      #ifndef _UAPI_LINUX_TCP_H

      union tcp_word_hdr {
    	struct tcphdr hdr;
    	__be32 words[5];
      };

      #endif /* _UAPI_LINUX_TCP_H */
      ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 scripts/link-vmlinux.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..f57f621eda1f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -110,6 +110,7 @@ vmlinux_link()
 gen_btf()
 {
 	local pahole_ver
+	local extra_flags
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
@@ -122,10 +123,20 @@ gen_btf()
 		return 1
 	fi
 
+	if [ "${pahole_ver}" -ge "124" ]; then
+		scripts/infer_header_guards.pl \
+			include/uapi \
+			include/generated/uapi \
+			arch/${SRCARCH}/include/uapi \
+			arch/${SRCARCH}/include/generated/uapi \
+			> .btf.uapi_header_guards || return 1;
+		extra_flags="--header_guards_db .btf.uapi_header_guards"
+	fi
+
 	vmlinux_link ${1}
 
 	info "BTF" ${2}
-	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
+	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${extra_flags} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.34.1

