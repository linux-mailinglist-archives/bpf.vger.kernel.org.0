Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC506DD5D3
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDKIoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 04:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKIoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 04:44:00 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E33AB;
        Tue, 11 Apr 2023 01:43:59 -0700 (PDT)
X-UUID: bfd18483618a4ec99dc15cad0685567b-20230411
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:427ba445-c29b-4940-ad7e-f76af801a9e8,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.22,REQID:427ba445-c29b-4940-ad7e-f76af801a9e8,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:120426c,CLOUDID:0a8cf1a0-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:23041116435292S8P2A7,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: bfd18483618a4ec99dc15cad0685567b-20230411
X-User: zenghao@kylinos.cn
Received: from zdzh5-qitianm428-a376.. [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1841137386; Tue, 11 Apr 2023 16:43:52 +0800
From:   Hao Zeng <zenghao@kylinos.cn>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH] samples/bpf:fix fout leak
Date:   Tue, 11 Apr 2023 16:43:49 +0800
Message-Id: <20230411084349.1999628-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix fout fopen but not fclose

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 samples/bpf/hbm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 516fbac28b71..7f89700a17b6 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -315,6 +315,7 @@ static int run_bpf_prog(char *prog, int cg_id)
 		fout = fopen(fname, "w");
 		fprintf(fout, "id:%d\n", cg_id);
 		fprintf(fout, "ERROR: Could not lookup queue_stats\n");
+		fclose(fout);
 	} else if (stats_flag && qstats.lastPacketTime >
 		   qstats.firstPacketTime) {
 		long long delta_us = (qstats.lastPacketTime -
-- 
2.37.2


No virus found
		Checked by Hillstone Network AntiVirus
