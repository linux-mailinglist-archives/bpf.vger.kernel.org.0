Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D6546585
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244938AbiFJL1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiFJL1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 07:27:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA422AE63
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 04:26:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so13749569wmn.4
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99g/H9hORM8QK7xT+vs5uD4GZTI6jZJp2du0cH8N2LY=;
        b=CahFhHENPeNQXpEJhMG/HPnrrccC9bgyah6cccG6vgwSE915ECBBpsIXn6eqxe4vI1
         WpyQtu9gN4B/KUb1Cg9jwk0zZeVl7qa7npP4lMxuH4W8/YmciMyFaovsL5293zcNPX5W
         NzCvKwmPePppGlIwC7o0v2qh4J0uGbxlIJRh2vPUcPJ7yg9XDsNaup8PN9jmAL6hK9ZG
         Emm4YD4qg74WzLh8z8JSBKeFYzRNAtlWFHR0DfAD+w0zAE7XDq1yecFA20He00NMjR6+
         b8gGzENOmBirp+8cyj+80T/ajyAP0DAwk3NR+iknORAvvcIVu7HK55r8aQfsEicdzpp5
         eqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99g/H9hORM8QK7xT+vs5uD4GZTI6jZJp2du0cH8N2LY=;
        b=w9T5B6evT+FfIFxkrFLHgccv8A6WPGBS8RdiRPuYtLSLigsl9A0SxMVGnb9h55Jq/r
         qfzjLASRPQsPxEhWmFuopnCefUF/zbkLcf7yD+PiaWCRtp2gl4JLqWNd7nyBYZcnfhLv
         MDc0NHK0NmuzKI0h3hP8A9x3vsrhU8TMSkIeU2xALISNA35UU69Lsh8ijs9hiag5TGZZ
         4OYs2JMlmF1ecER9UQFfGi8OvGkV1yB3+vRIRdW7l3ieEfrOBUhatFa8HvMm72l5sBCM
         tN31VZg7NoB9g+GfMk4VtoJ+AbpVGzUTxjwzLAZz2RE7RT3wNa9Rl2T4GOGoD8HbL3qg
         0dFw==
X-Gm-Message-State: AOAM5333qmYuqs8XlNVKgmoiUpqUU1p6xhSQ4rWNN+Dr7DzHttBMP8TV
        g40wXpoDVSjNm90lwTBRPyptFQ==
X-Google-Smtp-Source: ABdhPJwsBI+YOWDl8NwJJiNoTpF+Lg6pJpL8aeP2+035r6YnNJ39PCfteQ1I7oOJKsToTdzUqjqa8Q==
X-Received: by 2002:a05:600c:35c1:b0:39c:7930:7b5b with SMTP id r1-20020a05600c35c100b0039c79307b5bmr4744956wmq.162.1654860414169;
        Fri, 10 Jun 2022 04:26:54 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id z2-20020adff1c2000000b0020c5253d8dcsm25893202wro.40.2022.06.10.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:26:53 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Harsh Modi <harshmodi@google.com>,
        Paul Chaignon <paul@cilium.io>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/2] bpftool: Do not check return value from libbpf_set_strict_mode()
Date:   Fri, 10 Jun 2022 12:26:48 +0100
Message-Id: <20220610112648.29695-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610112648.29695-1-quentin@isovalent.com>
References: <20220610112648.29695-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function always returns 0, so we don't need to check whether the
return value is 0 or not.

This change was first introduced in commit a777e18f1bcd ("bpftool: Use
libbpf 1.0 API mode instead of RLIMIT_MEMLOCK"), but later reverted to
restore the unconditional rlimit bump in bpftool. Let's re-add it.

Co-developed-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index e81227761f5d..451cefc2d0da 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -507,9 +507,7 @@ int main(int argc, char **argv)
 		 * It will still be rejected if users use LIBBPF_STRICT_ALL
 		 * mode for loading generated skeleton.
 		 */
-		ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL & ~LIBBPF_STRICT_MAP_DEFINITIONS);
-		if (ret)
-			p_err("failed to enable libbpf strict mode: %d", ret);
+		libbpf_set_strict_mode(LIBBPF_STRICT_ALL & ~LIBBPF_STRICT_MAP_DEFINITIONS);
 	}
 
 	argc -= optind;
-- 
2.34.1

