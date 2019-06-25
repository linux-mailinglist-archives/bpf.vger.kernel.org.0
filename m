Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB055541
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfFYQ44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 12:56:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38115 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfFYQ4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 12:56:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so13174440qkk.5
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2p8ityIDaupPl7/OXexNbNC6ZcejjBZ8haavOQvh10=;
        b=B3QW+j4dYV2nDiavFkl+osTt9OxVdbFR3x8sQaa7rc6xmZLpVAexXY5PLGd7+OxnQD
         6DkfaAQzbc74Xo8cvCnwB+PyrUo9HA+6jxfWgOm4C1GiPs9YilskOKlAC2HLPtyEHLrU
         S+OR7s+E5R+KSVnMdF4IubmvXj3ZdP3ZEcwr1UC6HXsDuKRc0u0uLtvatuvoEVDVnhRU
         T/mEGR2un4WCYee2oR8+BoR5j+nKhyvaqTyIUcD97kHzB6SxvKDmer4MAi/sk3hWi+3j
         cEUVyBRY0x7JGdehxgyWHJehX7XgeWPw+3qilnuQCLNFy5I0y+IRAumMOT7w5TW6vLty
         QMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2p8ityIDaupPl7/OXexNbNC6ZcejjBZ8haavOQvh10=;
        b=XvRLWNSvce/PJ9P8Vq5zq9GwIo3Dta6Ove44ciKaYVGE+yUTCOldUKDxCnyYe06rJx
         TRC7fIzRt2eNsCBwqEmu9aeTLd+MTbSeH9A5G5M3zGgwCkPttGDYpj/aXYr85KMofafk
         SXKS0WD3Q2J5pafJQrUz4T/lRhRUKKDptg5KmurpOEeOTiwtF/cb2bAL47T4koAZqiSu
         An2mL8RHgMBMoSkaIkQG+dNovr6c9yFQ49st1QKu+1YgC1OK+S7nP6rCEEb4PzwLKTlS
         AlXafr0dA15d4ttzt52S2MSF2AEGTsSUzXqjFk0H5z0FKIQxBI5SZUJDtSgG7e8Td6Cw
         o7ng==
X-Gm-Message-State: APjAAAWkauHn9/hhD9Svy92sBWrUdWX8TpR1WTN8Mc44PzJXG/UGSYg+
        olLknna6C+vmjreI43cMBISSpg==
X-Google-Smtp-Source: APXvYqxMThCrqiaxhKvM4RAOvEqwYQ2c4112rcXOmOPufAT//6pHLk7iGImUXBfDkzx8CaPdEkAnsg==
X-Received: by 2002:a37:6652:: with SMTP id a79mr40409380qkc.60.1561481814251;
        Tue, 25 Jun 2019 09:56:54 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q9sm6704933qtn.86.2019.06.25.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:56:53 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, guro@fb.com, sdf@google.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf] tools: bpftool: use correct argument in cgroup errors
Date:   Tue, 25 Jun 2019 09:56:31 -0700
Message-Id: <20190625165631.18928-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup code tries to use argv[0] as the cgroup path,
but if it fails uses argv[1] to report errors.

Fixes: 5ccda64d38cc ("bpftool: implement cgroup bpf operations")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/bpf/bpftool/cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 73ec8ea33fb4..a13fb7265d1a 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -168,7 +168,7 @@ static int do_show(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
@@ -356,7 +356,7 @@ static int do_attach(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
@@ -414,7 +414,7 @@ static int do_detach(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
-- 
2.21.0

