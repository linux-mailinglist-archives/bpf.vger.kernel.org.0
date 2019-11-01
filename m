Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42339EBC3C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 04:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfKADHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Oct 2019 23:07:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33482 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfKADHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 23:07:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id t5so8820463ljk.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4NA7oWY+NLSOvKPXrREnqcSOAU6R7dAF4VLdVakC2o=;
        b=XrJ13TfkR85FgMuyoy9bMlave+PcqP0pALQ3R2KWa7Dhl45W9kehk0miafOuxdnhb7
         T1hhu1O42gKDfYU6wIUrIG1yY1DQxanX/KlWolucpMOsN6Txi/feBILgW7iOZIMCDze1
         /OXY97va9hOjp0dOUKE9xlCUqRhXBWT7vSOBs1E9pSF30DB5g68kQ/qDFWNjRXIKDG5A
         f4QvYfzbaQP4bTwUvYMXnQiY0Ao3H0QS2416Ehf2pBbVkSjh/fvKvrrShjRl8RWyeutd
         6oR6iHVfru9s+7TqrDNt7SZar9V8ODhokqQVlZ89mzCcuKJMsTWhs3zygddRHFiCnxP6
         34DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4NA7oWY+NLSOvKPXrREnqcSOAU6R7dAF4VLdVakC2o=;
        b=FLAfM4RP3HBKL8hYP4ij4llQLlLfnnva2VtM4RgYxxXSokz4mbzuaxwI7famN8+6oq
         WpPsE+y+Vy6gLk+Wc0WZ7PAuPlurTp2EAWafl8lRjds/jDksSBUdUql6/6IHBA0K6vjH
         Y5tF/rdGeocFsX8ShmDtbmAt17J1qMVxGKS/ae3mYEhCibpPQN/Kq/wkRDQMnDRvfyLR
         AC78ver+ESp5hxZSMyF3BnFuZNx1LQwODGMKcntrha9tRq/5Qxl7/urSdD0amEyOSBIU
         IZ68ZCzSUTB2cHUAcmWzZ9YvXGy1zRZYoXYmq80lxEbj/bjijr2k0wg3vQXBMgOZk1l2
         Z/xw==
X-Gm-Message-State: APjAAAVJn7K7rPnhUX9E8LfcueVRNMmXJziehz7Pwx9HgGBIAk4L+Z5y
        lBALi96Z1OsVDZBbse2dBAGUHA==
X-Google-Smtp-Source: APXvYqy5YFoAiLvCKyldR9WPvpzDJxG1Li08x1Rf/8cIU2I/vo9WLH2bO4PB27a6LjLgPyQk+6Dfrw==
X-Received: by 2002:a2e:9759:: with SMTP id f25mr6352737ljj.173.1572577639912;
        Thu, 31 Oct 2019 20:07:19 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v6sm3926282ljd.15.2019.10.31.20.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:07:19 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     davem@davemloft.net
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>
Subject: [PATCH net 3/3] net: fix installing orphaned programs
Date:   Thu, 31 Oct 2019 20:07:00 -0700
Message-Id: <20191101030700.13080-4-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101030700.13080-1-jakub.kicinski@netronome.com>
References: <20191101030700.13080-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When netdevice with offloaded BPF programs is destroyed
the programs are orphaned and removed from the program
IDA - their IDs get released (the programs may remain
accessible via existing open file descriptors and pinned
files). After IDs are released they are set to 0.

This confuses dev_change_xdp_fd() because it compares
the __dev_xdp_query() result where 0 means no program
with prog->aux->id where 0 means orphaned.

dev_change_xdp_fd() would have incorrectly returned success
even though it had not installed the program.

Since drivers already catch this case via bpf_offload_dev_match()
let them handle this case. The error message drivers produce in
this case ("program loaded for a different device") is in fact
correct as the orphaned program must had to be loaded for a
different device.

Fixes: c14a9f633d9e ("net: Don't call XDP_SETUP_PROG when nothing is changed")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
CC: Maxim Mikityanskiy <maximmi@mellanox.com>

 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 96afd464284a..99ac84ff398f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8421,7 +8421,8 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 			return -EINVAL;
 		}
 
-		if (prog->aux->id == prog_id) {
+		/* prog->aux->id may be 0 for orphaned device-bound progs */
+		if (prog->aux->id && prog->aux->id == prog_id) {
 			bpf_prog_put(prog);
 			return 0;
 		}
-- 
2.23.0

