Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932931B5667
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDWHtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:49:11 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:24251 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:11 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com with ESMTP id 03N7eVeK004486
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:32 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9S000368;
        Thu, 23 Apr 2020 16:39:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9S000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627581;
        bh=YToMVALGZ0JNA1/v+fELxUiPiJLJ9MUFCjYJs4uH7Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/pln6ZqRmDgm/Bssq1alNkuc3Z6L+0VRdRpDBSRfM6rnylBKkpq4N0FhnZAHaBKQ
         09d4dGS1RK79D/dxytzaPXHkugwYmcLh0hfnxdlEMCRtGa0CW+r71QZodx9ox2jEGd
         B/QE/aSCu3/paRvfEhFpPYcJClh8DomUcQgr+0futox9bKYhrpUwpUlQi+BtXI+PTs
         InMpNzc7xM+x36FYrtaQRwJ4N4i7ESf5cQbZFRxr27525RtaDOwQm4ooWQR0EYsHI0
         gLhz3pin+fwgPhwIGuvcIfLLWiUC9iFQLYZ5tpCbhf3MKrJnRgeoaUFpWBhsseUilu
         01mlRhbtRxh6g==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] samples: uhid: fix warnings in uhid-example
Date:   Thu, 23 Apr 2020 16:39:20 +0900
Message-Id: <20200423073929.127521-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix warnings seen when building for 32-bit architecture.

Use "%xd" for arguments of type size_t to fix the warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

This is the same as Sam's patch in 2014.
https://lkml.org/lkml/2014/7/13/152


 samples/uhid/uhid-example.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/uhid/uhid-example.c b/samples/uhid/uhid-example.c
index b72d645ce828..015cb06a241e 100644
--- a/samples/uhid/uhid-example.c
+++ b/samples/uhid/uhid-example.c
@@ -165,7 +165,7 @@ static int uhid_write(int fd, const struct uhid_event *ev)
 		fprintf(stderr, "Cannot write to uhid: %m\n");
 		return -errno;
 	} else if (ret != sizeof(*ev)) {
-		fprintf(stderr, "Wrong size written to uhid: %ld != %lu\n",
+		fprintf(stderr, "Wrong size written to uhid: %zd != %zu\n",
 			ret, sizeof(ev));
 		return -EFAULT;
 	} else {
@@ -236,7 +236,7 @@ static int event(int fd)
 		fprintf(stderr, "Cannot read uhid-cdev: %m\n");
 		return -errno;
 	} else if (ret != sizeof(ev)) {
-		fprintf(stderr, "Invalid size read from uhid-dev: %ld != %lu\n",
+		fprintf(stderr, "Invalid size read from uhid-dev: %zd != %zu\n",
 			ret, sizeof(ev));
 		return -EFAULT;
 	}
-- 
2.25.1

