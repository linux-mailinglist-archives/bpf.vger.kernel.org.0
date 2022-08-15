Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89B5592907
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiHOFQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbiHOFPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:15:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BA110D
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id y3so8301249eda.6
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=X5FUbvuxj8PVnyFFSdRMt8SjQRrihFn6knWM+ab3B14=;
        b=hEqvS5gAgbabob19bw6wrKV0zt4y9lpgzwS3nV6ArZ5VAX+40EyS1/puQiewI9SQn9
         dpe+u0ZbLNYtHB8I9P/QZUm6wAosGl04oCusZPnpBsJMlwrceMneRGjETPgmT+/K2b9x
         swmhCJipEYVlpLxkhPWPHwSP6AbXf/uZGDxBVqoHIhq3gOjP3yRLgmHEsWvGuVLFdY+h
         zGNYiDERpFil76AmTM3oPWm74vfNkq1BwlYe74F3IyTff8OmPrxXG38tbNzBqvMWJpQN
         b6S1wTGi5FjXKwI8Szq6IMoNAW+sXS/N6QZjiaWENVaKtCfRlrD7Ka8RkKRL1vby6zNQ
         YvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=X5FUbvuxj8PVnyFFSdRMt8SjQRrihFn6knWM+ab3B14=;
        b=tsOx97qwOP2rAABOp15IWvsEzs7bc2NDKDRS0GrtLkIN1g9UAHqVROdEZHgHYIKGNb
         tJrtusm7WmLIc4bqtMUZ7f7y9KYBpqEEVRzjRb5JR88xR7KehYtbqsUDKFlyo7kB3JmZ
         qcOS5otLmY/vePCXd0MzQtkiOJ2SEw/4Lv2ZJ5LjMOl2zP0S0CdRcYQcN3NlL9ayOIBz
         9ZAgkiYTXlaxlWWPwY5IW8KBP+EumapXXjnMgrqEryJfR3DHi9mbQH/T1UZOrYx50zDF
         TldAJwBJ+GjDVzTO8PVrjrlrvvagodw1HkQ6hi63RSDiGeGLxOGqjbXvWwqPpFxem4QH
         7V5A==
X-Gm-Message-State: ACgBeo3OQ73GvhOtDg4shqUWDrv++muvkqmMpdBKGGaF6Y3ZYwVacinn
        vyy3jU732mWDKFzOjarHNNm1IwgKhmw=
X-Google-Smtp-Source: AA6agR77yXBhEhdx1+vRK7z9pkDYKcFtKCEXDkMLJgkVLd8rbN+hCUYuHahYo1UAhWOFXHcN/F1LyA==
X-Received: by 2002:a05:6402:2989:b0:43e:91be:fd20 with SMTP id eq9-20020a056402298900b0043e91befd20mr13301886edb.109.1660540543151;
        Sun, 14 Aug 2022 22:15:43 -0700 (PDT)
Received: from localhost (vpn-253-028.epfl.ch. [128.179.253.28])
        by smtp.gmail.com with ESMTPSA id ek6-20020a056402370600b0043a61f6c389sm5984852edb.4.2022.08.14.22.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 22:15:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC bpf v1 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
Date:   Mon, 15 Aug 2022 07:15:38 +0200
Message-Id: <20220815051540.18791-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815051540.18791-1-memxor@gmail.com>
References: <20220815051540.18791-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=memxor@gmail.com; h=from:subject; bh=+8aX5D4a7bbYFTu1lla3mHj6to4wj+b1n2cZKZY+Z1M=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi+dZHqLC7/bIfUbYV40fRjnEBVUXudXYbHBtP1HBC GC+7TlaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvnWRwAKCRBM4MiGSL8RyvaZD/ 4tEElfGgtDfFOUZLBiv0TD0mBhsb9ihf/yo70dAawtguDXef12N9OeNQ4oqn2iKdD04fn/O/crtBnY VMuggfMAnzF5ZI2Mx91tSlnymOEItpg/kC1zkaZ188aQxB5oHN7xt1j6tQiIbgekX1k0E7Dphczena eXvhE6uwqG+SbcKCBvh/jvcqB/vA0SrU7egrdZ0Sw6ZE3sskYRfpNSK4xUrevY1agxiF98x149sZdJ caQKADxysvPhmDyLiUKV2O1246F/cMR76Ali9P3fWGGsd5fVRJEmgd0c0WUrVpnLn1JCDUzCi4NCav CuirbP9NeIJKqIPpnESaeo0bJEzjgFb/ZtlqE6SeXncPLm02p+1EvhE0zRZ9PussV+qkJduIqP84IX Gf+b9LHEQu2iSRD7+XOmXDOrLvU4nsOY0LtcWw1P8TXbXdGKBI+2KMb3AWDSjM1YUbg3Qtn7aVJ7zJ 10ZXMN7Q1HvsKY3FnCsYbCkZo8XNFjUdS/8NA0LWdPvGJoP7CzV7hCwLrHpOmpCRS84XeB2N7i+eWJ F2Kczest9rBWPrrGTj01lImzVnL4a2E2XgDM+XBjrfXSniYlL5g8ldK9yjrjYYqm2O1MYFSNP2+3qz qp9Y38dudgOFCG6S37pW1TlFGIGstz8s7pRFdatDw3qH94lqm2Ke+om5FGdQ==
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

They would require func_info which needs prog BTF anyway, which requires
bpf_capable, so just to be double sure move both these helpers taking
callback under CAP_BPF protection as well.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..d0e80926bac5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1633,10 +1633,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_submit_dynptr_proto;
 	case BPF_FUNC_ringbuf_discard_dynptr:
 		return &bpf_ringbuf_discard_dynptr_proto;
-	case BPF_FUNC_for_each_map_elem:
-		return &bpf_for_each_map_elem_proto;
-	case BPF_FUNC_loop:
-		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
 	case BPF_FUNC_dynptr_from_mem:
@@ -1675,6 +1671,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_cancel_proto;
 	case BPF_FUNC_kptr_xchg:
 		return &bpf_kptr_xchg_proto;
+	case BPF_FUNC_for_each_map_elem:
+		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_loop:
+		return &bpf_loop_proto;
 	default:
 		break;
 	}
-- 
2.34.1

