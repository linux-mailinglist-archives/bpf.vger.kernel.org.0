Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0B6D718D
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjDEAmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjDEAms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:42:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626B49C0
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so34521193wrt.8
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJKHhiCvSUGB7yfEVdeOcZPbuJuycLbvSt7yxyJPxFI=;
        b=BL5HhYj2BuR9c5rjG8lOO7YpyF2Pv08HHzgLhQODsYNWiXslN2Ld8RzSFU4K6yS4h6
         hpVJ8xo75QxPH8F6scQdpLT/WGxauuLyCGA3ahn8HZGo1fLPnKnM3FPTD40j3ev52S9H
         aJmB2zgs/QzrM8esUAYyUBer1dA6Lgd3fdFjwPd7xYxbCgyA+rk2G/4NBJ5QXGSloVH4
         5JEjSB0O0DkBHK9D+FQkOIP2Z3C8f08yESCsqLwiykHDPujkHDd2aLlpJ6Ngrku8qN4S
         W0FGryRABCJQmF+2pwYhKoSa/lJD9MRP7+31B6HvWhc2DFnKTH7IzG8uZLuREs8ASILX
         LVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJKHhiCvSUGB7yfEVdeOcZPbuJuycLbvSt7yxyJPxFI=;
        b=Wjeq4g7inBEh696xuvUcYJaX/Lgp5MCEWmXMyoRILe0JBvpOnUBOnT2mapWJmQINae
         HUlo3IhqlaYHoug5wBNqI5yiJe7bqKzF9fOZHtkiIsQFYZxmJbPxcJetqKABDRnuFeoq
         3XcDlzO9Y5tC4H88WYHfUOtRRcDNvmuxuhGnyFt7zWYSp8/OTy6A0Gg/XM5V+hHORnLb
         GRvpDXsO4AI34nJBKyiiMF/wiJd85o13QPQOMLNakhtihJxeq2qglDetLUHxm5dR5mY3
         PRonq0leWhYTrgx8OynDXvyitL+pCwHhsr7fSaw1Zj5QpN3W3CdL1ZaPmV9BtvVHixJn
         xbUQ==
X-Gm-Message-State: AAQBX9f88nByBrQlOMjGWE3iwU55BF5596wRDbcZF0ChmgSbE58q/lv8
        FS757YYih7u3biDH9O3ryNaDplce5CT3lw==
X-Google-Smtp-Source: AKy350Y1kG7f5McLnbE7ikFmUKK+O9GWPgmQWwMdWBOVLsxo7+rP4FMwsmriqbcIs0Q47jKhzcrccg==
X-Received: by 2002:a5d:4fcd:0:b0:2d8:a55e:1fd7 with SMTP id h13-20020a5d4fcd000000b002d8a55e1fd7mr2432701wrw.21.1680655362971;
        Tue, 04 Apr 2023 17:42:42 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b002c794495f6fsm13415094wrr.117.2023.04.04.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 1/9] bpf: Fix kfunc callback handling
Date:   Wed,  5 Apr 2023 02:42:31 +0200
Message-Id: <20230405004239.1375399-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=memxor@gmail.com; h=from:subject; bh=ED85LQy7/HWe10Am0kcN0WVhBnx9puiHtcZuAD+qJ3k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPv0vRJvZB9S4CYUPCG7Jl+DWLoRMBFWvGIu pyqdaH8u9GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD7wAKCRBM4MiGSL8R yiA5D/9j+t7XeG2Q8flPmdsQ9Uzi483ZttEOUa8K5mWW3+kL/HJh1flE2QxtmMBWNTlJ2DO5wHV 4Miimzz+TIFkz7GguatmOTgRXOSQpT4dF8eiaPmzkB3ImLfjb+t/QDxUX2vF0beb/2oTTp4eHf4 w1RZWese8/ipmmM8q6H8w6w8FRkaI6g0Bo43N5DOSeDjoC/HXEvd9mFJCs3uHGdF5RkHXETLAwn ZlFztvKdzvmnnhMZCtgURwBV/BZptP/Aq77XFWUMENbq/fBNjKqGptMC9tnWoSgAIQLo4W5holB p61/t2B/qljn0FteSux57HXHcYfrGLRTjoiAixErXqB1z5aFMgSq/lKj8CPlqH9Tv3qIxBEUH+T f/cPFmPAXwZZErsLcRDJKvkbUjSPgyeYGe0yytYuTLLt7DmQkanwmYeGJQiPMwjBS6HFouoB7pd 2BnU6MbqFOXwyheP4yS9ikA9tcUqya1oVmx7n4vU1fR9JUfkrrFKGHZ7txDOGopA79CF1rxkcOq 1RumhGL6agWGH6wZzo6iiSeDKJQoJwYB8O/+Y7y2BauSUAuIk7Fno9+cXvo4UvAGV9w9avBzYcV Qwt/lJXs0DuIyO4SDu+weObxVyP+e5swFSeKCYMr5HLRj1+55b39wRRl4xaDBuqhGacbrMRstoy Dmbqo1Bxvs3V/Qw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

The kfunc code to handle KF_ARG_PTR_TO_CALLBACK does not check the reg
type before using reg->subprogno. This can accidently permit invalid
pointers from being passed into callback helpers (e.g. silently from
different paths). We need to reject any other type except PTR_TO_FUNC.

Fixes: 5d92ddc3de1b ("bpf: Add callback validation to kfunc verifier logic")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f569811f70..693aeddc9fe2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10562,6 +10562,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		}
 		case KF_ARG_PTR_TO_CALLBACK:
+			if (reg->type != PTR_TO_FUNC) {
+				verbose(env, "arg%d expected pointer to func\n", i);
+				return -EINVAL;
+			}
 			meta->subprogno = reg->subprogno;
 			break;
 		}
-- 
2.40.0

