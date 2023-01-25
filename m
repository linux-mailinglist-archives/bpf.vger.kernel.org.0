Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49B67A92E
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 04:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjAYD1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 22:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAYD1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:01 -0500
X-Greylist: delayed 1876 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 19:26:57 PST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF123029A
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 19:26:56 -0800 (PST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P2Xb8n015763;
        Wed, 25 Jan 2023 02:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id; s=S1;
 bh=ihB5xbHp/4HwELF4X4XmY4SLG4KmzU0UMkRDlBD9y9M=;
 b=QYgOYryyfgQenHF7dZaWptKxthHR3JMPjsGdbXJO4BT20BWSCPNI5oZlirNDSGW76fFD
 dgbR8lh7YZ9Him5bW37mVafwdLgFDriewgn76BVPWv8aRmKol+c/TyfRBMH6mbh+QVvP
 bmu0dMQHcw5lg4rijXK/9CRe/3HNq3uKFd/sZQd3yngX5fSzoSsyNCoff9n6zowbF/wL
 uzT62tiZ2Ahwbh/FjeL/jV7ih6npsGjPkBpdzM5vG9/uSwNMxtMrtMYyzoDMYV/w2cZc
 SW37cvrHEFux3K5BCbRjlrwHsej3yG4nvpoMlJAIRVgG6CLhl/31MOaxpocUylZ6QUFi ow== 
Received: from usculxsnt02v.am.sony.com ([160.33.194.233])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n88esuw8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jan 2023 02:55:37 +0000
Received: from pps.filterd (USCULXSNT02v.am.sony.com [127.0.0.1])
        by USCULXSNT02v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 30P2eo6s007962;
        Wed, 25 Jan 2023 02:55:36 GMT
Received: from usculxsnt11v.am.sony.com ([146.215.230.185])
        by USCULXSNT02v.am.sony.com (PPS) with ESMTPS id 3n87ag0wrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 02:55:36 +0000
Received: from pps.filterd (USCULXSNT11v.am.sony.com [127.0.0.1])
        by USCULXSNT11v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 30P2Cug0005966;
        Wed, 25 Jan 2023 02:55:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTPS id 3n87ag6u31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jan 2023 02:55:35 +0000
Received: from USCULXSNT11v.am.sony.com (USCULXSNT11v.am.sony.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30P2tZmg016567;
        Wed, 25 Jan 2023 02:55:35 GMT
Received: from prime ([10.10.10.214])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTP id 3n87ag6u2x-1;
        Wed, 25 Jan 2023 02:55:35 +0000
From:   Chethan Suresh <chethan.suresh@sony.com>
To:     quentin@isovalent.com, bpf@vger.kernel.org
Cc:     Chethan Suresh <chethan.suresh@sony.com>,
        Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH bpf-next] bpftool: disable bpfilter kernel config checks
Date:   Wed, 25 Jan 2023 08:25:16 +0530
Message-Id: <20230125025516.5603-1-chethan.suresh@sony.com>
X-Mailer: git-send-email 2.17.1
X-Sony-BusinessRelay-GUID: hW0QjAZb957YrjxdjTzn-3kTF0TAdveU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Sony-EdgeRelay-GUID: BCsyuaEtORwIYXTADJFxbwyiXmoa4a_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-GUID: F_A55EWvso6C-X6zT7TBAzi3n8kZYpJw
X-Proofpoint-ORIG-GUID: F_A55EWvso6C-X6zT7TBAzi3n8kZYpJw
X-Sony-Outbound-GUID: F_A55EWvso6C-X6zT7TBAzi3n8kZYpJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've experienced similar issues about bpfilter like below:
https://github.com/moby/moby/issues/43755
https://lore.kernel.org/bpf/CAADnVQJ5MxGkq=ng214aYoH-NmZ1gjoS=ZTY1eU-Fag4RwZjdg@mail.gmail.com/

Considering the current development status of bpfilter,
disable bpfilter kernel config checks in bpftool feature.
For production system, we should disable both
CONFIG_BPFILTER and CONFIG_BPFILTER_UMH for now.
Or can be enabled as some tools depend on bpfilter.

Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/bpf/bpftool/feature.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 36cf0f1517c9..c6087bbc6613 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -426,10 +426,6 @@ static void probe_kernel_image_config(const char *define_prefix)
 		{ "CONFIG_BPF_STREAM_PARSER", },
 		/* xt_bpf module for passing BPF programs to netfilter  */
 		{ "CONFIG_NETFILTER_XT_MATCH_BPF", },
-		/* bpfilter back-end for iptables */
-		{ "CONFIG_BPFILTER", },
-		/* bpftilter module with "user mode helper" */
-		{ "CONFIG_BPFILTER_UMH", },
 
 		/* test_bpf module for BPF tests */
 		{ "CONFIG_TEST_BPF", },
-- 
2.17.1

