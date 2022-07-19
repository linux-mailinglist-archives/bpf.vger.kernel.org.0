Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA50C5796B0
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiGSJwB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiGSJwA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 05:52:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5C275D5;
        Tue, 19 Jul 2022 02:51:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J83SsG013970;
        Tue, 19 Jul 2022 09:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=8SBEQTIeu2Y5+MYu5biXhcWmOh+bumthpz+SFRKRDl4=;
 b=EYCSpyyue59HFaH+RT/F7xe+UGSOJ+4m61b0cS1jQ7tULrjD0ppFd6P5ypzZU2Csh5Sy
 KKrle4Ey1WXw7ooe/Yu0Ssw5BRoA6RI9CJYaYXAioro/4o8P4qAMkaVSqKQYGfqOQUEE
 pNOKmHbRhnW73Eco8UJewnjs7f3htABjlfnpkaJT4GPpb6HUScP/tFIAroNNCGggfB+I
 YGUL1HFneeFlISAa84XGIiseu5lR1BOQZMU/F2UZ+0QWR5CHdp5mFYIBB4HnY75vaxzf
 YI1sqpp0NrrqWd4XvFVwLm4sYiWp8DOk7yEoSHa3AcwiZZ5waQ+ylh+GBmR2PfElOced KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs5qmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:51:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8ZhAX007901;
        Tue, 19 Jul 2022 09:51:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k37abd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPBS21C25R3D78SFHiiG+kOG0rAROgRXyAEXU85wbSGrjAVRjuhLUa1yNbyLVAViIpi0YO1YqCRHyEhmmEqVgWXu732N151OO/C7ZVdUUJ8bAY0eFQW2k0GCQEUq0QNuzpUWD+sOEfvqOppFuWrYnL+0y25rJw6BYLpSY+P1u6wAPLM1i1aSoovPXgomyGwQl9smhPvI1xQtPDmRmKaFCRoIBGpnok1wLVR1rCSkk8RzDlM+Zv8B5Iz/f3cxKN/L/0nwQVXXB0A05g4gTJo5fl92c0Ug2cFXoQII/BKUHgrRO0UCJHj76nBGXfiePNhqB8HtiVP3Rvni3pA5qnk7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SBEQTIeu2Y5+MYu5biXhcWmOh+bumthpz+SFRKRDl4=;
 b=DaSA5XiYl6ByO7WOQhaUy7GG4QuDnHBrotN6Jg1YW3wY1bHG3dtFeVP+QTd1ezZ1uEIFLb4cg19K0hA9bt6gc5vW4JUz11KyfWNmDyMJVdLXZbKCrlSVhNFSE7OMungr42+J4CB4KfYsq0mSaupSy8ITMAJT2/wvOeqbbX3bi+VNghRbdtPV0pw5XKjvU95U2nzvxemGggD3vzo9LHqUj1ne1xXZyy42D++NUuo05dCtj9zrE1iozbXLzl2a2dV0MGB1Ak+v+45gjtd7b0Q9h48iRfdbDVZMJsbH7NsNlZEF+kpq/A635Wk2NupFccyUIIqRuJqFNq+70FEEyV9q8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SBEQTIeu2Y5+MYu5biXhcWmOh+bumthpz+SFRKRDl4=;
 b=upHve4BUdnTTBnpPy/thDK/s2YKv+NrqM9nWujw3mSqvDdpiuyazssfvS0qVi0dhj9X6n0cY2mwFZZjXorBHyOmLd9YPr0gxOXk7nt7SSCT3LyTTHq0VvtTqSlHh2zLrbe90i610bp+2u1MqSHHdc9zgGChXYd16LK+53peemdo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5924.namprd10.prod.outlook.com
 (2603:10b6:208:3d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 09:51:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:51:40 +0000
Date:   Tue, 19 Jul 2022 12:51:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] libbpf: fix an snprintf() overflow check
Message-ID: <YtZ+oAySqIhFl6/J@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 836a8073-bcaf-4c01-60dd-08da696c4757
X-MS-TrafficTypeDiagnostic: IA1PR10MB5924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WngjIa/a5m//Hq2PhA9lRJ91tinPVMiMB8RxM412u6PTdLnL5lkFX+NgpsPFvU7b416jQ/ai4Iv4INxKlt5TEBCUjpeMnVDDd3s8RDMPzOnHEqbY42UcD73Et4D2QPgHZDOQ0HFcC0lwCwsdXxi8HRyYR5wK5M3dQdP2rdiJtd1E/bdpgw3NUfRuZfgDxxFp+kLv1mBZCdbuYB6Rx5l29JskXLXfJmRFdl6eWCpCclyNZjAb/NAms6eJwQ0uhSA8v2Si+uRByoDh6szGLCVE2sUl9rEw9tVCqpmuY/XK9AN0tqmC+xH7cJJAIeEHAasqbAPM4q94Bu+/yGV9WqUqRm4TLeHThSXtLHS2W5kalcIL6U0zhZQh+gIQhh58NHPgiKBjGY696plMep9t6Kqaz+OSll2OJMq0ppWFt6fHNNavJ2aq4Ovkwlh2rMIIU3C1O4/S1MVdq/RUjShRLvYB4mtto2TlEhwsnkUj9jMXiqJCvQmG+LVoGQ0MUa+ecCri3Wl0yvqwwSEp3pbQ5y5urNGdnrd2sE2VxNm9Fka62m+RFHdp7Y9J+z0M7AdVa7v1DBkdzjsQ7vVcpYRNmDLbJc8MWxYTEaDlNQzJ+KDpQyAMz0gBxxW3E156POLpad3btf+z7hzkDmFhoiRbUGgbc6jNruClbRJ7b8QhupAxfhAHSDkFBcGqSxeC1hTVpujrOaftZuIYuVGDA8ujfkjgNBjRLaihZDrpWBU4kxLs2mspaMOX2oj60kDCd7I0qL8w6ZWNx5uWmAPkp7xeNSC++e+7Eve/RBHUaD7Lh8sj2YyNKSMAvVMDr3WbdlH8fYZq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(86362001)(478600001)(6666004)(41300700001)(6486002)(26005)(9686003)(186003)(52116002)(6506007)(83380400001)(110136005)(316002)(6512007)(54906003)(66556008)(66476007)(4326008)(5660300002)(7416002)(4744005)(8676002)(44832011)(8936002)(66946007)(33716001)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uc8Fbu7ocDB7Vq2YyfyO0ukkG+hoCCleca3VIYWQhsSe3A+IxuSbfvKZAAep?=
 =?us-ascii?Q?bK88T1+Do0j0bvnXmdBeRGvlmr6MhVA7gl84+TMS7X+6oJK1lKhkIQeWnUne?=
 =?us-ascii?Q?YkXRbs4KOXFDFuQNw5luKf+KTeVzGcSclzi/Gnh745TXHbT8gxomGdHnHS2j?=
 =?us-ascii?Q?znXfXSmNAymtfFceLTRIn9EF0qxJeI7VngelAcp5UiaiFAJyBwh8kVZWAYNg?=
 =?us-ascii?Q?eBjNWeyCX2TB2DwXKv+BuaS5iuaT9sv4l9QgK+WikEQw6kdVmzXv1KzH4l6X?=
 =?us-ascii?Q?hq0UHOMa5fvelkw1636fu30erfPdm7b3Yue7Z2geTRz3YvRS25thEZudbG+u?=
 =?us-ascii?Q?QPGCbgeWFflKVKTCpOxjEb59oPlKdBhaAYlvRpSfmMsV0WPNAt8Eoj6dMz54?=
 =?us-ascii?Q?VDjUp6IFcaXpaPQfh7SF2wywPMt9qJHPH6ActnrMa+MTtzrvotsDpWOzEMpt?=
 =?us-ascii?Q?0SR91GPxb3erbb3M/GfYSmFh7RpwDDZl3XjXlMFIsRpLBlfWdpRBlcfF6VrL?=
 =?us-ascii?Q?nt88IX3INXkioLirN2oYOCw0ROeKYVm04jPJAM7vaTfm+bL6rvjcX/BCVhV2?=
 =?us-ascii?Q?hKut6OusQB7D5yPZzK2Lq5pBpVB+QUUjQ6BuCFcghpC0qvLQBolLennuWQkl?=
 =?us-ascii?Q?WhIza/YvDP0HY40+lueBjjUCVTue5Lu0CGZ/ap3Nb7M/Z7UJ4AHzPq6re/1Z?=
 =?us-ascii?Q?IrGWRogMYofTLyVv0DTeM7u68ozXzJMixEdues13VFkGa9kPRFyXs0BIeoCJ?=
 =?us-ascii?Q?sKZCSL1XNvYWpiVB2AVl1bBgySUMIiOTBjWwFEnKzyczAAMggWeo9es9BLNY?=
 =?us-ascii?Q?rR3MGRKwsymMXdvz3ArNWzFWPUak2sQQZnL+LMuVKWcwkOxwUFvjyJ4Jt6ow?=
 =?us-ascii?Q?XzenFj8CGNPM+j0PRS7ad+8xkKuQjy7PmGMzZ//4BbNw3+RITZ/Yx/1kLOTZ?=
 =?us-ascii?Q?K+vIYmcN97XIpEO/D0HvP5Dqp0TaWeKN4sZ7w+3ZWHojd8Y/faRpZEp8W3En?=
 =?us-ascii?Q?supTAXt8zwMWC2yBBJwe3eE5cyb1Ng9dswWi8ful9CkDQn4hs+Wxa0z0dTSv?=
 =?us-ascii?Q?iw+sNG+RmVeMUZZtcxsduRX7KakWpUfeNHLiTJqGlAQctoNCiEcnTTaTY3gu?=
 =?us-ascii?Q?SK8XD8hf8R04vfgmmb2rj2uDdF+LhBLQhCjuMf/vXYjJel8nANTCwMMzaCUg?=
 =?us-ascii?Q?3TZVZUefoapyYnl7mNl4d8owaPtE7GSPTPq7EECO8OXJUbBdIr29zmjxO4rx?=
 =?us-ascii?Q?37eG6kks0xc2tSavWeCNuPTzIvJWJ3lMZMasa9wztlrHT9iImRkTy6UdAvDA?=
 =?us-ascii?Q?Z7j+UNtf7YlY/25jdliuXNLCUOH/OhuNSn4sbMd+2svuoYhpfqiLmveUnrgZ?=
 =?us-ascii?Q?zmks/7xuNhFId8pDZ1zK4hqaGcx5J/PBE9/mI2eosdH8BUsZf4XNXXsil8GL?=
 =?us-ascii?Q?1Zw+aqG/CYK7V5onUa8UtlZiwgufmOFcwxDa+MPdE2q5BvsNPTN+6PqG7yNw?=
 =?us-ascii?Q?OKtOG+ZpHIc1+x14w+XoRKRGrtC3Iyncg63XzdGySbQ3aL9/+OhA96gPcK/S?=
 =?us-ascii?Q?gGl6+phGiA8h6O6H4oUwDkrTMMYsHF30UL2OI1LjOjmUyzh2YuesKzlYLUqa?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a8073-bcaf-4c01-60dd-08da696c4757
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:51:40.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMNaA/wB44sowUzcAp18o/3N47jMDfg/AqGYYWYKYQk60sHxZFAUeREBuEKLD1iATwe12YfX5hpW/bJh9TsEtqxTtW87vZo98DxKP/K+ckw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190041
X-Proofpoint-GUID: EqevhmE_7WywY38pUX0dHZ0XJCgxXLCG
X-Proofpoint-ORIG-GUID: EqevhmE_7WywY38pUX0dHZ0XJCgxXLCG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The snprintf() function returns the number of bytes it *would* have
copied if there were enough space.  So it can return > the
sizeof(gen->attach_target).

Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/lib/bpf/gen_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 927745b08014..23f5c46708f8 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -533,7 +533,7 @@ void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
 	gen->attach_kind = kind;
 	ret = snprintf(gen->attach_target, sizeof(gen->attach_target), "%s%s",
 		       prefix, attach_name);
-	if (ret == sizeof(gen->attach_target))
+	if (ret >= sizeof(gen->attach_target))
 		gen->error = -ENOSPC;
 }
 
-- 
2.35.1

