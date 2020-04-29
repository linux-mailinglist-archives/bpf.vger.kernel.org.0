Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A271BD33B
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgD2Dq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:28 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30762 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgD2Dq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:28 -0400
X-Greylist: delayed 81088 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 23:46:27 EDT
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlh020748;
        Wed, 29 Apr 2020 12:45:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlh020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131938;
        bh=DteiJCZUt2NG8wExdTe91pPdHrA/aKvbxaj6Xacm1fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGJQ5n0TsgIA+7SbtlLK/SyG5wp1UyiGPGn4etQfsl8hqMB3Wnev4btB0sgI0K3Sb
         dDsBMOmjsrnxF/+6k92HnwTKQRxq64dkmAaDzPxYvbyLCzeu/V6y6jEsh9vXxWsfC3
         H+sl2iNX5H4mXOwWi8fyAHEtyoLbbX099UM0+uSQnQVCcTXD7rla6Ls+eo7zCisFcB
         sqKCcFSk+gVtlVq/5Kh8f41CAFOw1Yh6jjcmt3xuS3KJlZ1S24bymXIduBOo2zWshV
         W3ON/0wpBAXPoZMufWBZ6HTyrE1mgo6ebO2Z6spcCInuJIk22GQf1/k4HFvD+qy5yD
         Cgy6FZ8RI6j2Q==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 06/15] samples: uhid: fix warnings in uhid-example
Date:   Wed, 29 Apr 2020 12:45:18 +0900
Message-Id: <20200429034527.590520-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
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

Changes in v2: None

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

