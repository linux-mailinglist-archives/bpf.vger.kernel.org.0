Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D566871FC
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 00:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBAXgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 18:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAXgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 18:36:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B43EFD5
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 15:36:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5066df312d7so4849567b3.0
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 15:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdmQjOgdEPEomlaYuZNs5rB82C53IErD5soDy0uEmLA=;
        b=A93UGIeHRMzDPB41AOVxG4CUIJrkvjqRuG0Y4YbuIU8duD8KtLuGOc/NiWMxDmu9Gf
         CihsrdMtiwRShrod/1bzwMlduO15bSqISLbsyO8p42vDaMNAbUQinOeX2KdEofgUw9+O
         rGNnkfnUG8RN9ueMWcYUHSWrxcwSNLYImUZKtLcUWT70kV+AddvhHaALWLXQcm6eDVhb
         DRv+qLjTmrAEcIFMguz2hSGogASisAd7nVnkkS488Eiy02ap/DIMYSXfidVZO8wWcMlM
         2+1mpI61NzUriO8TBBjAgXDR57IVazZ7birHIL7KKGtUwl5HPBTuXr8rKJc53J1iBwg+
         P8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdmQjOgdEPEomlaYuZNs5rB82C53IErD5soDy0uEmLA=;
        b=iH4tP/TZvM0WCoa5LdgY5SfWP8eFYGC3TaOlcT+c4clRLQZ9bYri9XvdJt0MVQOaDc
         CaBi68ye0f7ECHYcstT/9UijRbl6+l0wEuJnUmDhSoPW0HVVfMKgiS2NrDQcNXC1eN0o
         xoguT0y382b4ITsjzo6g9qjEZaAtbnT3SC3rzXU+3QNiCEo996EybDrU8CrG1jzY2TH9
         0dUFRy24PPbePWfhnk+ZLyLBNAABH3S8YSpNdZl7IAkXSDqpi4Aqga1JM6JNt2BfxpZx
         rt50IjKhtHFPn/1YasG5S42BymF3bZCyHOQaFdc3UYmrWSkG4Lo2Ybx//FrDMc+eLkWV
         VNuA==
X-Gm-Message-State: AO0yUKXuELgLZoPH3o56SwuP+gspnOoe2d/B+TqwbXaz2XD91yCNKLd8
        zVZWXelIfMQahh7LIo8eC4bCVK5WyKr1yvtCUG+4GcWVnA+Yj2qjM2mkP4Rmc6zFa0DK3rf9Din
        3j3n9zDU0V29yDNJtfXuuRu/kohKkYsPlDETckoq97CZBMOvKFQ==
X-Google-Smtp-Source: AK7set8q8wcuVHU8pfcOIJ/k6v4JyV5KhWYTwsQpi6/mf33wicILIsOGKsm6vY/qreSpjAXEkkx7rJM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:ab46:0:b0:853:676b:baa7 with SMTP id
 u64-20020a25ab46000000b00853676bbaa7mr179151ybi.460.1675294602217; Wed, 01
 Feb 2023 15:36:42 -0800 (PST)
Date:   Wed,  1 Feb 2023 15:36:40 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201233640.367646-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Don't refill on completion in xdp_metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We only need to consume TX completion instead of refilling 'fill' ring.

It's currently not an issue because we never RX more than 8 packets.

Fixes: e2a46d54d7a1 ("selftests/bpf: Verify xdp_metadata xdp->af_xdp path")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index e033d48288c0..4be615fb7975 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -205,9 +205,8 @@ static void complete_tx(struct xsk *xsk)
 	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
 		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
 
-		printf("%p: refill idx=%u addr=%llx\n", xsk, idx, addr);
-		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
-		xsk_ring_prod__submit(&xsk->fill, 1);
+		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+		xsk_ring_cons__release(&xsk->comp, 1);
 	}
 }
 
-- 
2.39.1.456.gfc5497dd1b-goog

