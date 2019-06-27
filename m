Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5F578AC
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 02:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfF0Aax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 20:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfF0Aaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 20:30:52 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB2C216E3;
        Thu, 27 Jun 2019 00:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595451;
        bh=h676S9Dqxd2dIinfuL4at9A3SXQSqkLO10P8sL1ks0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xod1YivPKHnO9cEuRhuZcoJSs19qzP/6TBLf565vLVZwe75zbCMi69QN+cuG5gxCJ
         WhVnA0EvkpUSNDQ9lKjX96FMZuMiRSYFeXxmpF0rhoH9r4/0omSNCbOCsYPuAef12P
         9nSO5C4SODNgcidMnHVLxtvYdsHMmETPDKozpVHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chang-Hsien Tsai <luke.tw@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 09/95] samples, bpf: fix to change the buffer size for read()
Date:   Wed, 26 Jun 2019 20:28:54 -0400
Message-Id: <20190627003021.19867-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Chang-Hsien Tsai <luke.tw@gmail.com>

[ Upstream commit f7c2d64bac1be2ff32f8e4f500c6e5429c1003e0 ]

If the trace for read is larger than 4096, the return
value sz will be 4096. This results in off-by-one error
on buf:

    static char buf[4096];
    ssize_t sz;

    sz = read(trace_fd, buf, sizeof(buf));
    if (sz > 0) {
        buf[sz] = 0;
        puts(buf);
    }

Signed-off-by: Chang-Hsien Tsai <luke.tw@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/bpf_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index eae7b635343d..6e87cc831e84 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -678,7 +678,7 @@ void read_trace_pipe(void)
 		static char buf[4096];
 		ssize_t sz;
 
-		sz = read(trace_fd, buf, sizeof(buf));
+		sz = read(trace_fd, buf, sizeof(buf) - 1);
 		if (sz > 0) {
 			buf[sz] = 0;
 			puts(buf);
-- 
2.20.1

