Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20F2D3609
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfJKA3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:29:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44910 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJKA2Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so7989859ljj.11
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=deZb/gvn8tRBWJ8EkwM4ZsgQbv8cKKMpAA2vf6G4xRFrYVAvufEMhW8txzk+WL8jog
         mRr7UCSlsEoukk0CBSI3WVyQH2ebrmaFhmUpX304VfwuEzwcBbYogWTqta96NzGab23d
         K4u1cCqe2+htE/tMhpH0wwPbB+TmlaC0g94WcpLpPrLjELHj2jJyPZ6ogY2MzYAw8D6P
         xiaMOcdpUxjpfkClJCQrCd/Z9r5gWMRFGbTxrsrxqzuBe9eeDepyP96MWN2DtWB+gp76
         Dh5lfo5p3ACqIH0MOgfKt9xTZNOPlHqr4iAdNt7BnklttINOkT2odQBy2BjW8oPe/YK7
         n0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=JI1Jpj2wlFlF9E1X303nbM0PJpkcdMbn/RSz26iz2Wr9x+Y5KibXt5QXG88TniM16Q
         LsLCW0/S4xPykUnJwbzSvUBMxwrKAHN79pXErtV0CAhfYV3gZd5cJUcPInYl1ydiXnlM
         JYywnYjmk/GxbfYUGQIElAJp5pK4tbVTIqpelAWboh5RqTUXOE1UZEDxGL/FUbUBUhq9
         jGTAlI4c+EHVmdQEYNMRe3wFal6LCSshog7E1WWAuF/jbEQcNi6GPGGiZ5ReaNOUuIYg
         kXoyEmiveV2gyTFNUG8PI3IYOxT9qsprisDbbY2lMAwkfsQv+L5+C/sqK4r+zmC2KUK4
         b7sA==
X-Gm-Message-State: APjAAAXqohLs25nPFBz9wcX6XQZWKeirCx7nik4a0wnorPhDr/sV5Xer
        xfgHynzQsQEXiAIxrW+6YWkQjg==
X-Google-Smtp-Source: APXvYqwWFJ/4w/zxqlpX/lyhfjX06c8HYdKUcp1cZYhrWQvMou4/PGZf9SVP2Yk3dHJtL69Dvrhq1w==
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr7735053ljh.116.1570753703648;
        Thu, 10 Oct 2019 17:28:23 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:23 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 02/15] samples/bpf: fix cookie_uid_helper_example obj build
Date:   Fri, 11 Oct 2019 03:27:55 +0300
Message-Id: <20191011002808.28206-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't list userspace "cookie_uid_helper_example" object in list for
bpf objects.

'always' target is used for listing bpf programs, but
'cookie_uid_helper_example.o' is a user space ELF file, and covered
by rule `per_socket_stats_example`, so shouldn't be in 'always'.
Let us remove `always += cookie_uid_helper_example.o`, which avoids
breaking cross compilation due to mismatched includes.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4f61725b1d86..045fa43842e6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -145,7 +145,6 @@ always += sampleip_kern.o
 always += lwt_len_hist_kern.o
 always += xdp_tx_iptunnel_kern.o
 always += test_map_in_map_kern.o
-always += cookie_uid_helper_example.o
 always += tcp_synrto_kern.o
 always += tcp_rwnd_kern.o
 always += tcp_bufs_kern.o
-- 
2.17.1

