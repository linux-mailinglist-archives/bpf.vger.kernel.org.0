Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56648628DE4
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiKOAC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiKOABw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:52 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B9117B
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:51 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d20so11589125plr.10
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shrual+sQARxwS3Eq7Ztga+SseY41SgICBVkPEePOJw=;
        b=UuDscHsaHn//91RFnebGFO9YuZnZppJMmX6OWuXsHIEl7vG6g6FU6vYr/wL1GsJ0fK
         /k1BSGVBU9LAjS++MmMP0rTVIt+ythOuvC+ZujMeiy1NGw5J66/xB0Y9ivng4BVWtzkT
         raqj3SzuLb3sC6uT897TOoDHa+eD2bFLlruoqg1siiuGBbRe8F6APlcrmLq7ksRo+7zf
         gV9NleA2smEuvtrxq7iWrTvVa1fYGFZK+4/chBffW8hJOfbqwbp+eWXejZvBzVA9QGRY
         5KVOCG8oxJaCUTqMz7A/HihNvT04Rwdzj3ljOcUBEHo2d2c+szGN+X8a17hrEFzXvj8u
         7lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shrual+sQARxwS3Eq7Ztga+SseY41SgICBVkPEePOJw=;
        b=6s02xDwB8fO4SjRF8gwOpxoGcs0u5sg/Eb8ocfzjNi8DEMmrBbnwxIiyY8G1asvztW
         RqJek7xwgA8Faa+roJWYeA6EPkdnsWrEf0tOrWIDdRcfpAZcb5Fmo6n019TqSq/+cJFZ
         C1W83fr7qqD1JlTgXEuHa1zqcNgkBx7hI+2KeW3j/zRp6X748iSnNaJeDcXWRT+ZvqOy
         csamfSiDJu7XG0o34fcTjY2g8WfWcfUHc8pEZ8DdfimQfSyLCyAa8WUiByjmXJqg3pnO
         stZ71RMw4IFt0fvlbFuKuYVZVn5RH2Rsy48Ak1/ghOATRvL2y1+/qupZX0rLaRjGH7D/
         b4ag==
X-Gm-Message-State: ANoB5pmrWyE1vu7Zayvcyoig7aNO0p7p7vqWzGY03jZSBeSyDZI9jXBU
        go6uwIdA/nhpnCkRU58B/QsNfH4BVjt4yg==
X-Google-Smtp-Source: AA0mqf7NmhvyU7fTrJJZG/mDle+GM35ltFxQoW24sQwrSfJBDgDKbdOxVSDh8fKfGdM4Oiwgd+y28Q==
X-Received: by 2002:a17:902:9046:b0:186:6d69:6e01 with SMTP id w6-20020a170902904600b001866d696e01mr1399423plz.160.1668470510862;
        Mon, 14 Nov 2022 16:01:50 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b00187022627d7sm8138104plz.36.2022.11.14.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 6/7] bpf: Use memmove for bpf_dynptr_{read,write}
Date:   Tue, 15 Nov 2022 05:31:29 +0530
Message-Id: <20221115000130.1967465-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=memxor@gmail.com; h=from:subject; bh=N/5OHsSmqeJt/icLLaIXxrEti8S0MTFqAak+Q5xdCLw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaCHlIzGsrCHiP/KWFyiEayLnP4gu1RPG73YYTF R3bxX+GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RykOYD/ 0XEhkk4fp69NkS+BPkrw22TPHKgQNuVsL6IMqg3R361EgA+L6EwmM9679oghwSexV9T1kxo3yCnZsT XYEHp2L1yUtOGPmOj0IEMSNgntcQypTDChWC8m3mat41PsO3ni/gynETvw6V4CtzSaUGszQ5nAjlrC aKvp0aPWjFcA8qtAvuwR+gCB9YzSO6NvTCPaIa3ANBFmG2xc94GOVVmnx/J4EycIF28I8p2Lb14htw 4bwF54Af85RydIL1NgbBcuosB5b/hnVYSooA/D3gN2bq+xI9E77ExWOiEes1NnsTBK3LTVhRBmEIJK gp7SkfuJdNPH66MYUuNTWwqTEVC60Gsq1HLNGN9GesqTBuOsYJ8Y99RtWxge/kXx4Fc8R48JDk8/iW 1atqnZzFDllQ5YhSXfkcUUwm5DqMv2VK6yTdI2dQkt807tymYBgWmRfukEbcre9j3mbmeRKz2SQJoN Xwy2ku7pSCqjRVlHyN639gZB21Zfw/KxYtQnjRUz6UWkLSzN8RNNqCHY5tvNyWGRsRSn6CfFiUy6Bv LBzcLn90CtbRHVFL1g3HuSZpnl9dkfapVJY4VKWiBmGC50XZGqXfJ0ojgWMOPn4TpuxnwlAxCl4TJ2 8oRTI/2l5Oio+zvintk/rk6sxTPex3t43NOH+WwUXg4jGVaPDj7ZZex/f3Og==
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 714f5c9d0c1f..1099ed1e7712 100644
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
2.38.1

