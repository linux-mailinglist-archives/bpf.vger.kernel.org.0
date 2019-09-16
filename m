Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFCB38D1
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfIPKyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:54:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35678 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbfIPKyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1so1762734ljc.2
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=myQi7tUoXKWvWu2Otr2cMzZrUikwx9p5w927Z5U7K18=;
        b=zqzL4JzwdgYet7wSFB53zjRItWpS1hdeN0ygAfE9AmPl/tgeJ6oyvRLjQXycdwZXvW
         0LkJJSRAf4imSOLOE29XGY2MZ3eqllofQcObiDHWP0n70jafz5Etprt2/18so9bAoNTR
         PAxrU/Zo2hoAsOPF39JndhObn/PUwZAIGsIAbIudvGDm7SINJLoGj6UWh+CSx6AR54CG
         cqRWHQ/B4qTgGzo7uNYmgSSKMEPe9rgAJFIAtbz5BnbBBB1x1PXd9E9GZFdPz3dzbqwH
         8ftOXF8bhIMPmwb3IKjgxhtoyYYyFPxole8xysIfutsFzMyg7yF01NS6KpCla5EtW1LM
         4LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=myQi7tUoXKWvWu2Otr2cMzZrUikwx9p5w927Z5U7K18=;
        b=efEOgWA6BbFK9ZSxZ6igFa1kfiYP4TJCx9RJXFeIcPPHYWIAgO3fi2h/7wxDLTn1kg
         vOS4ObXR2Qa5fLnJduxXjRNQ2191CuIKzjrejurd7EeT+OSTJPKX5ldJNQmGhhmBRV1T
         Ccq9Ea2bkKcsjXolSPA77UxEPqs1LS3lXHslHC30WwDUJuM7wfsKnnUmxsG8qX13717t
         F1vy4c4Y7Z8J6apU2HFU74qSlydh6tMAThSukNT1961E6jgixBuCWdkO+VoCdUQdJMhX
         GHcWBYwHBg1AaE9xztwQdMOJ7Sr7HyasEEdkTxqzBLSbMc6uxGDeV/LcAF+5idFW41tS
         a7uw==
X-Gm-Message-State: APjAAAWlkWstQz20GIxMkjHuzL4gXNN+eQbC4ae1uJWKXy6WFOo07VPk
        BqihbP+bbGnIPn5gEIK/0lCcnw==
X-Google-Smtp-Source: APXvYqzNr13KKv1AIr7OpHjlQSQcSa/f7Y9MYJkeX7w54sCZf3/vtF9w89HiJUF4vYPD+fo2fgIN4g==
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr1900577ljl.217.1568631282996;
        Mon, 16 Sep 2019 03:54:42 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:42 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 02/14] samples: bpf: makefile: fix cookie_uid_helper_example obj build
Date:   Mon, 16 Sep 2019 13:54:21 +0300
Message-Id: <20190916105433.11404-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
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

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f50ca852c2a8..43dee90dffa4 100644
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

