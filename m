Return-Path: <bpf+bounces-6059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E139764CD9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A601C2153C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFBD531;
	Thu, 27 Jul 2023 08:27:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23BD521
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:27:12 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CACD9B4;
	Thu, 27 Jul 2023 01:26:53 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36R5q4Ip006491;
	Thu, 27 Jul 2023 08:25:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s0636cav0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 08:25:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUAiz19+tq5m18SuqhRhsSR/mqKIUbPDwr00k0ytbXsLlUQY/eYL/Uu81Hr/6i6cARkw+JMxrJKlCobohtVLA6aRg5AiifOlaFongBZsLdO2VcW3Bi1RjXF0uFmZVAlyOu1//8lBMM83FeI6Il5yATTGB1TTlhP0ft0xqXYAgZmzshEYZu8oL0RMA4ewquprTQZ8BSrCbeumUa5ItpuhLKHcomjyy6XwvUoETW2fP7HaC7PyWD/rvx+qg38bK4gMuF5nIEc/XcWGlHpNDL3INtO9GHWSC9b59MytoUO012Sn+0OICogn1hlXQiGpXqtePl4BqcY95WY9qzFb68P/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP1P2aVTqNdCp71UT5wobcYp4mbVlbJ6l6pnDfwcIOQ=;
 b=VlYzQktbSXd/LGwd2eKD5wBNgLi79q3qyxheNhe96lowbjmRHlV5nlrkwkB1K9krAShG+T1t4LrrWKjtq4myO6ROI/1aDL9R7iDYCjB5bVXu4dIBQboKRHVsvyGi5NGVlFan24pCCwcUYibU6XkLhIxOoxChGbDgiZo+8Sq/973sffQR5g8KqNYcXIMrDPqbmkANDbLIZBvblqT7uCRhAngqLA1JkWFxBq6LS94ve3ITHskIDor8bus4ynLEWBk6xSA+I4svtjbDDNXL/wRXHz+1sywn20pTloBQ2sqNY8AfPGan0SszRDmT4VG+NM3/M7kygdYuUKFTxqaTc0rL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:25:54 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::c8f6:72a0:67fa:5032]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::c8f6:72a0:67fa:5032%7]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 08:25:54 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off' may be used uninitialized"
Date: Thu, 27 Jul 2023 16:25:36 +0800
Message-Id: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DM4PR11MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 18436092-6c89-4884-3c49-08db8e7b186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CP8y1zeLBe9+1ObsYytldcsfURA6l/qRoph8MxFilrwXKDu0StCiPgnQHMOZXOe9Qhyp49KLspIQA98zBr4FeSj+lm6RyDoTBCDQIQllIDPf8RewrzUIx4lm6p6NHgtWF3pNGk70bHiUan6i7XMUuOQYjXtNrShjLCkdMfXx4YSxHNaPW9xcq3nTEK4iOXBq6SZ346VsTE0hP7ITI6mrPDIXVD9cdx6Te2wrXabQNoSl3oqsLo0qXR0Jj7S8Y0P9TU6HJS+RlHbY3vbXTti00wDm59fXao/iysl0Hb/AOk4UJCeIDFPxenhmOdIrFwk6oTgRPQKQG0wmxyNbc2LRuG1nOHLGzxQPUeku7uhh6h9AbORIjcq8agjYtVU21/NEAJUknzg5T3HuJtbpYyoh0YXbe/r7mHU354zXdFlxOSS8+s7EuUhn25nNucTm+pDZlwEpmSPqZUBUVlOZb448JMORPnx2MsOGEKWWZeEKIyme9NSNg2j3uSy6N56pTQWZf17tKLmutIRaWVO4d8qIwgAW+irKVabGLmnvfbiO4urQnGf6FqqSi6DYl8/GfDQKIjI83VTkZ5jiFhWle9RS/aB+8OA1tfP+NqDpCgsvrdlhL9SzmgKclJMbqYi+pzf5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(41300700001)(316002)(44832011)(5660300002)(8676002)(8936002)(478600001)(186003)(2616005)(52116002)(6486002)(6666004)(83170400001)(6512007)(26005)(6506007)(1076003)(450100002)(38350700002)(38100700002)(66946007)(66476007)(66556008)(4326008)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GWVWqqhk7qhEboSEva2W7BASdB919jftOJdhoZoZPtiiZS/g7ZrX38BnJ+uA?=
 =?us-ascii?Q?vXRZkcU85AS30d80kAv+wEC18hKpm2kbXg0U5J/n9XA7G+KxVrveX8i4HzRW?=
 =?us-ascii?Q?7ZBuP+JZmeFrinTNqUXa5jVKiCBBoanIFNmxpxnDBsqd11uvjVrbGJoUedA0?=
 =?us-ascii?Q?6IZ6whkmsEhf4IsHuL7x/hPNvc38Xgr5J0o2CJtFhItRLIObMABPMEIC3MrK?=
 =?us-ascii?Q?sKCsTn9osIklj0pXV4VhIPON7f+JCSurCREfG1KoGNTJuf8HGv/w/vU76DZx?=
 =?us-ascii?Q?YJo4yQSFSj3hoaLeacSL43+Lcon3WGBolkJnsNIRd0+FBxwYSIYbtFN9fr33?=
 =?us-ascii?Q?pd4jYH0B6PNrfXHVJLUAk4LNW6AUjljNJNWqHEvSx0tB0IG9O1OdQu5GGr8H?=
 =?us-ascii?Q?yco+al52BhsJi0VRPjlVwSRbDxXY2HtuIyRGbxkPrBGQi9zIi1ilIayr4ATU?=
 =?us-ascii?Q?bYtOGR8sfGIK7mjxfa4II+uDMX01fBIKG4v6uNlbfaKt7gSPdz6GoGnQrO2J?=
 =?us-ascii?Q?xyf/RNplozkyOy1uzIPWlPjd1vJ/hDXDKqoQX8UGJ1hS/3lBNGdB3uptgH8o?=
 =?us-ascii?Q?WilopTJAPI6zy5lK1t6in66NSxr0k8Sl6hKXyv1YQHa3i7EJSzZA0H09/wu1?=
 =?us-ascii?Q?qktNxd+hL0B7IvBh3XMT9egWyXQmfmzu25adlP+ys7Ix1qKsydSzvyX+9TWA?=
 =?us-ascii?Q?S8/UPK6VDgG5f8HUx00rOMrXnuz+TJLksRjFM9s+MVh1PzAqibJgmfVk58Hv?=
 =?us-ascii?Q?Mn6kl8FPDGAAqiQrUiNhQVb2a9kizybMV7oX4z4nmVL5rF6hLaJQ3aAo8wv+?=
 =?us-ascii?Q?DJ+tsnmxOE2ttXQBSitqLvrYspKFuiQBJiVVDo2aWeh8iMwXYhK9nr/6QAfp?=
 =?us-ascii?Q?E8hkFJ32GXa1W/U79cRSJhfhhXV6SGGcLiEOplij5qLAUP33qtzkNuHW4n7G?=
 =?us-ascii?Q?Z4z/C/roqFqkpefnJwprZd6xIZHzcW2KWMEuEhWgPCGieX7C+x9k4gW/Q7fJ?=
 =?us-ascii?Q?FQDyPJyFwyxj9ifaV/zrW/CI2RdytNjaJOnTkokK/oWZ3XHcFhR4s09La8lR?=
 =?us-ascii?Q?YvrTOP0tScWPPwP8RVcUDTRN+F5/IqogOYgnSaxBeNZb2oL4PLOylpV+GkV5?=
 =?us-ascii?Q?14Qe+ftnysgivZiR/knSzC4CvUvrN8JF0EETZQariQQaNn9jEUqOBiwfqQHD?=
 =?us-ascii?Q?2Q/yEgc2lvVJPzKgKPGfU62rNhc/cA1aNKXr7axL7G8FA3ds8XEA6wTmInEH?=
 =?us-ascii?Q?vXXFR5vZyZlqEgV2Igt5iMeu7sI0pE7JDHk7AisCXDkFORqD8xFu1RUNNDfG?=
 =?us-ascii?Q?tzm8x7Dq3Gv2KJdY3JOIUDNLPDwCUkxRcYg1d3ujID74hcrsQFAVReMDPy3w?=
 =?us-ascii?Q?iZh1girnemEsYhgvIGQJ3RUoKSYZNl+rO48mMrcbRsxHZTia7VQRmgy9cx/y?=
 =?us-ascii?Q?fnuA3LgMQ1OZ8PtmCB5S0qto1Q3mINXCaRlTpL7ZqPW1yjmyymNNiK/of5NF?=
 =?us-ascii?Q?irjPfpI4FUpiSyIRediqm0/aVMCtsF5meA3US06ZzraRvAlKfcPU6Zip3AuX?=
 =?us-ascii?Q?sKexzgonZ3pCZ3jJ5HXKEBraslZ/oCFT4BETg0iJhgq7kZYbRq4XS6ax5GA1?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18436092-6c89-4884-3c49-08db8e7b186d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:25:54.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbxhHihK53INeKku+MFKoCicTisnonlSEpMhNLWUptNo27m+091mvpk9cRKfwWtmTdm71P6KUAsghNnhy6r7eepxWo5e+SVPo7886qbRAXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-Proofpoint-GUID: SLN7q00wkMd_aEcb_NOBzAvGfUtPARJy
X-Proofpoint-ORIG-GUID: SLN7q00wkMd_aEcb_NOBzAvGfUtPARJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307270074
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xiangyu Chen <xiangyu.chen@windriver.com>

When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
and following warnings would be reported as below:

| btf_dump.c: In function 'btf_dump_emit_bit_padding':
| btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
|   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
|       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|   917 |      in_bitfield ? new_off - cur_off : 0);
|       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
|   929 |   if (bits == pad_bits) {
|       |      ^
| btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
|   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
|       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|   HOSTLD  scripts/mod/modpost

Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tools/lib/bpf/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4d9f30bf7f01..79923c3b8777 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	} pads[] = {
 		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
 	};
-	int new_off, pad_bits, bits, i;
-	const char *pad_type;
+	int new_off = 0, pad_bits = 0, bits, i;
+	const char *pad_type = NULL;
 
 	if (cur_off >= next_off)
 		return; /* no gap */
-- 
2.34.1


