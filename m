Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5CF33ADF7
	for <lists+bpf@lfdr.de>; Mon, 15 Mar 2021 09:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCOIxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 04:53:50 -0400
Received: from mail-bn8nam08on2050.outbound.protection.outlook.com ([40.107.100.50]:38976
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhCOIxe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 04:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6UwW/1Li8JyRzLs+TFan9KbwPLUhtDVJpCGylrBc5B3jCkWf6KCDwmh0eJYwA+K+Ya/z5E/GMXApx6BEdAWkIR00KQZs9uPPc2Ly56ztACw/tAf+6D/Gh2H26JJTpgwM9AqLxO8AADB0glMPaZS2wVY9Iryk/UgzoT4PmAW1knjWL+M24+54N9cPBGV36MCmeyonOTakhv6ifq4imkD8CevKhxNBFtLBnhSAmxT0vKjIpl4ewJcxY56JbZynb9OV2TVxEf7t/05aYtI7FhitWJ7wRtqzw82TE69EiGLSoYj+617gd5UT1dLZLUiRyx/3W3bhL/TrDlmluzQv0hBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Din1U4ynDawHHcQ+RnHhwjtg3VbBEI8S68X36DwxLac=;
 b=dicbwQ03PcM5VzOGGC8qtAmR+aUIE+nZZiDdybOtyutMD1avFEmU8wT/SLGQnWtIsvE6izq1ObIZLrb21AgmtSgD4itMtyn/kP+BRVeZQZ1+agz8NF1vKCT92tGbYqQhLMIcvbbeuXMvbeDG5QUyz0EbL/hqurnJr4Hf9w/tb5yO48LyXP16afu/QIk9vQJgeHJp6Fr+2KS18hVHScX8lOUhgl23f6zKkjLIIcLaNbDY0AatEK8MOqqSOKFJqh5pV/vcW7GZwhoPw8L7c4U75qHm+lVZl7jiStwdUgSdvrsig+kqT/k0EG27/dL/OvF1KFqVVLEFxLIbY7SC7rNTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Din1U4ynDawHHcQ+RnHhwjtg3VbBEI8S68X36DwxLac=;
 b=e7FrHzj+3fpInijlmOX3nltPiOIrbbABH/9Q8pCTAwWcfZ5P57LrnOSM6p59kz0i2mn6DvpAUIa1zce/wf+eUuc2S6QY0QrdW1BfXAjmQBH06kSMHVgeBME9Gn5wICNxQUJw6o25XGBXOEV02y64vYRHECeP1GWcRUwdo4n4KvU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 08:53:31 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.042; Mon, 15 Mar 2021
 08:53:30 +0000
From:   qiang.zhang@windriver.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, qiang.zhang@windriver.com
Subject: [PATCH v2] bpf: Fix memory leak in copy_process()
Date:   Mon, 15 Mar 2021 16:58:16 +0800
Message-Id: <20210315085816.21413-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 08:53:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8081d913-a781-4e8d-84d3-08d8e78fce63
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB520087BEA6E1ABCB36360E44FF6C9@SJ0PR11MB5200.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQLL2BGXeFl6olIvdlVy++4SQ0f4IEPshnV+vUOOgDMX0WmUIkLvpYCka9xv1ZpSlvZIhDvez0mUwOk6Ar1DAQMfZKEJqIPRyY3SGIyAV/tGXGUQSCLi11HrrIV7WI+VNx60MdTNNmPyRFuWgN5o4fX11T1x4bbo1JJnp5Zsahgv1BIa2v7vzGHgpsNlF4QgvFRfsv5c9i4cNZlC3JVgUsFMNZP7/w8I2E2GwtGc38H1jT3Jg7cOKZOk/PNsP7zb403BrKSyp5FT6RFCRgCWiS2lRIqDL6IAuM9bXWqSXAe96BCATtxAbK7lZTt6yiyY5CB9YFhzio2DRwQ3gigq3O7gH1BXL/p9Bg/jwJ2RHzTD5MRzATRU7mTIGKhNGHAcsBrgn46s1deksOBMTrPrLhajFAywYvlm1IShYzL712Qs2gS+9lXfBLCMOyIxloiigxIUQO0qEgonttiAAlCTVU+dth5RC0goe5ybQ3k31ulK7M4PS7v/wnmhC2l7sTFB9wTeopnqfRmcDqoxYcLK8LCzhq0NJ6xz31Xg69ik37lBpRKtDpFGKeSft4UPVhYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(26005)(16526019)(956004)(8676002)(8936002)(2906002)(4326008)(107886003)(6486002)(478600001)(186003)(2616005)(52116002)(9686003)(6506007)(86362001)(316002)(66476007)(6512007)(66946007)(83380400001)(66556008)(6666004)(1076003)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q4E6ZUI8n9GI6J08/tREJEMcW+gLiPQ7DQ5SDXF8jxkHaVZkm7P0zjGCpC2J?=
 =?us-ascii?Q?N/q1KGNlcF/rrN3guLQt8DxQmnXZJru/vL8AKURNFiI8jAdCVOI3yVrmpkGI?=
 =?us-ascii?Q?+NFJw40pl49K5hLo6cBvrcgxhmHwIcGOZEtIdDXB3K7LG1GD1hATmga8nWhO?=
 =?us-ascii?Q?3x73XPmGzO0xo6JGmcjkR3+03D4Cte9oJM9QsOdwUdx9PTxOecyjKWfpJmGB?=
 =?us-ascii?Q?l+YN8GVhlI9obTzw4eQzRy3n+NRHVc0B/i+5/9aVpwvPq+8bD8U7Boak1Ri/?=
 =?us-ascii?Q?GL8RQHQdekPu30IQeG6eKW2QR4yJFDY83Ncg1aEkklFQJDmfTxwvXY+CJ8u0?=
 =?us-ascii?Q?JsDM36XENU/LIQCUqo2Q42WV0NLN+mQ9sw6Sd4cFpUmQsQsW1KDpCpsH5QPt?=
 =?us-ascii?Q?OenTELpenTFb6A5pAAZZnBgUbIZp9UUDmexKtMjYCdUQH1Umi0Eon0DEPHEI?=
 =?us-ascii?Q?Cyf2Wvl4ZzW2H/RUTWl6EM/bJ2+979sDkCNpnvX1wTdmU0ZQfmT3U2kRv+bo?=
 =?us-ascii?Q?kwm9DxEUFm++yC4xTGNkt5q1vLv6jyyMxsH+3e1STRfjmVY/938xrp3VLJ+Z?=
 =?us-ascii?Q?YeD3GIh7bx/0zOrXnsw9s5Qn0baGer/aNoCpTSVkOMeJEnSKNloS7YosY7Xp?=
 =?us-ascii?Q?INzRlTc62yjmJpeBnE05bxaOD9ohQKSJVdyAuo2Ire7P9TbYosLBGy1HFvP9?=
 =?us-ascii?Q?VRCowve75OTXylF6HjEOtCbHbvHps0aU1FmQzCOOKD7+93KOCQGEn5p/pQgo?=
 =?us-ascii?Q?pm4FKMK9RvI48XbYZCyMe6nIiw9khJJKtDMsZARjPW/nW0YJuvQxh8jhiD+l?=
 =?us-ascii?Q?kRlkbypbZlf/rDUifw6kTEqcUtKjgTlTuzAWKhQjaBHlndRo88NaqT0u/pzi?=
 =?us-ascii?Q?cN+r+fcejE2qKt5Wk0Suj2VJER8zTPSzBGjcc49EVt0qlwcg7iJfF+K76+bF?=
 =?us-ascii?Q?Hn6vfo6Q7dW9vCbQi/2ihjsZ9yb+SXdbV8znFFsj7PjIUatWJziTB2vlGq2v?=
 =?us-ascii?Q?9WCjNX6wjjbw7JAmzlSzIezdcc9kQRTbaBuZZEomR24J5QVDsLSuci4LecQK?=
 =?us-ascii?Q?UPy2QaP1Ae2x5AjOuBz5kvcaR4fwyMhmIIvTjMRg9K6gbWjOeFjQofNTfyFF?=
 =?us-ascii?Q?uiMRGQvhfKuMiqmIQgZ3JP/BIOgOySNPRxlzam1XxPeVYIjoL3YLnULaXeyl?=
 =?us-ascii?Q?SCH3u+M55XcNA9I81GBV4JnGyOWxycNqMySssYXniWnx6z8nFPvQTkxhUZpm?=
 =?us-ascii?Q?mIoLvoaMNeQLKM9JACmuZ0LQy3anpVkd2GDUf64YcJTiNIG3nJQureftdsgc?=
 =?us-ascii?Q?tvB19H6ZBXBEUUjfO4EEl41g?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8081d913-a781-4e8d-84d3-08d8e78fce63
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 08:53:30.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp1ArDxdXUcrzao0T6ysxInCxoXTQF7KEU1az/pzGlEhgUadKbw1AIIFlrNsQR4bo61OGhPtDrXW+Lx7IH+/PySTiQnmzxQ6n9UzETw8jKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The syzbot report a memleak follow:
BUG: memory leak
unreferenced object 0xffff888101b41d00 (size 120):
  comm "kworker/u4:0", pid 8, jiffies 4294944270 (age 12.780s)
  backtrace:
    [<ffffffff8125dc56>] alloc_pid+0x66/0x560
    [<ffffffff81226405>] copy_process+0x1465/0x25e0
    [<ffffffff81227943>] kernel_clone+0xf3/0x670
    [<ffffffff812281a1>] kernel_thread+0x61/0x80
    [<ffffffff81253464>] call_usermodehelper_exec_work
    [<ffffffff81253464>] call_usermodehelper_exec_work+0xc4/0x120
    [<ffffffff812591c9>] process_one_work+0x2c9/0x600
    [<ffffffff81259ab9>] worker_thread+0x59/0x5d0
    [<ffffffff812611c8>] kthread+0x178/0x1b0
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30

unreferenced object 0xffff888110ef5c00 (size 232):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  backtrace:
    [<ffffffff8154a0cf>] kmem_cache_zalloc
    [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0
    [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140
    [<ffffffff81559218>] create_pipe_files+0x138/0x2e0
    [<ffffffff8126c793>] umd_setup+0x33/0x220
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30

after the UMD process exits, the pipe_to_umh/pipe_from_umh and tgid
need to be release.

Fixes: d71fa5c9763c ("bpf: Add kernel module with user mode driver that populates bpffs.")
Reported-by: syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Judge whether the pointer variable tgid is valid.

 kernel/bpf/preload/bpf_preload_kern.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 79c5772465f1..5009875f01d3 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/pid.h>
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/sched/signal.h>
 #include "bpf_preload.h"
 
@@ -20,6 +21,14 @@ static struct bpf_preload_ops umd_ops = {
 	.owner = THIS_MODULE,
 };
 
+static void bpf_preload_umh_cleanup(struct umd_info *info)
+{
+	fput(info->pipe_to_umh);
+	fput(info->pipe_from_umh);
+	put_pid(info->tgid);
+	info->tgid = NULL;
+}
+
 static int preload(struct bpf_preload_info *obj)
 {
 	int magic = BPF_PRELOAD_START;
@@ -61,8 +70,10 @@ static int finish(void)
 	if (n != sizeof(magic))
 		return -EPIPE;
 	tgid = umd_ops.info.tgid;
-	wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-	umd_ops.info.tgid = NULL;
+	if (tgid) {
+		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
+		bpf_preload_umh_cleanup(&umd_ops.info);
+	}
 	return 0;
 }
 
@@ -80,10 +91,15 @@ static int __init load_umd(void)
 
 static void __exit fini_umd(void)
 {
+	struct pid *tgid;
 	bpf_preload_ops = NULL;
 	/* kill UMD in case it's still there due to earlier error */
-	kill_pid(umd_ops.info.tgid, SIGKILL, 1);
-	umd_ops.info.tgid = NULL;
+	tgid = umd_ops.info.tgid;
+	if (tgid) {
+		kill_pid(tgid, SIGKILL, 1);
+		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
+		bpf_preload_umh_cleanup(&umd_ops.info);
+	}
 	umd_unload_blob(&umd_ops.info);
 }
 late_initcall(load_umd);
-- 
2.17.1

