Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3D525956
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359866AbiEMBWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376272AbiEMBWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A4222C28
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMMKR023307
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lHtBKkfETCynWSNeWawNr5pR4Qsr14vpU29bRyCSVho=;
 b=jrJ5Gic6i5EmQC/qVFBbPzjoBuQbaI/+vOCw8CkVvTXUhAy9R47uQN3I4snkI5d9HGXA
 oN/s+Q5dwt87+Gcq7Qs0wQ2CEfxS7FtnSqUNNn8fS2pfRDoevPaia3kJmlb74+b1GQM9
 AUkpCJI9l6573y/fapFJrZJzOctj1wpmSAQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g17vytvss-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS6yNUBTJZPsy513ub7a+QAj1dcUzmp3cUozJruJOdEAWQkK2Tmg12mNBAoBhNZ7RXOnfqx3SB7oTzAHsPhbub0gfq4bpTSfxXDKr3x8k6GOVu58/I3D9sD4zvxR8aYeaRFlS/pdcaVTAlMB1FQkhPfbzWWWCXQ/EU7S+hndBTg3n28PQsLSsHMLW4YTXae6VsfCbr/RxRe+2u9ajGOq+lMxmJC5g5rTz8LNeA+HuHfh+JBVOwSlqGEwU+ZlsXZR9/De8Ckk6WEWTof28zfihdUkQioEfILAYn5LarPrydnDILmz7sWQESV+HV+2EQ2dS5e2qB4YN8Tjn1D3lpIFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHtBKkfETCynWSNeWawNr5pR4Qsr14vpU29bRyCSVho=;
 b=cgDprRqjBhj6PyV3gt2XVkIKxEnmABMOX1J7f8WezXnH3Ud9F59AykOegShkiMbK3QObJcKEkwRciSD/0WsaXBLc8JG2mHwRRzDlDErDC0FJInX514vZjnoDfBOSz641s75wjvG9gCuhkBT34uCCbdML5ZYArQOMni5xSuNGk7c2ZLPSsIsgl4LLHQgOtBfbo32stah+lr3EAk8hXuQ/89sCItf9hSky192TMUzx8H/3ficoqDJuIDKA3SGWHGQuptMr9jzmwQyzoAwcMzK9Q/lnTMiFvc0C8Sa3aiVtzOQFtIWRJLGulAb2tAuJixhWEF9EvgHnErNgxa+fKNiOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1610.namprd15.prod.outlook.com (2603:10b6:3:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:39 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:39 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 4/5] libbpf: add support for sleepable uprobe
 programs
Thread-Topic: [PATCH bpf-next v3 4/5] libbpf: add support for sleepable uprobe
 programs
Thread-Index: AQHYZmfvOb5TNJ9xM0uvUmh9bzHu5g==
Date:   Fri, 13 May 2022 01:22:39 +0000
Message-ID: <3dc6d472dcb2c50846cda776f122fc99a0e3e277.1652404870.git.delyank@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
In-Reply-To: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff7d182e-f5be-4227-621a-08da347f11ec
x-ms-traffictypediagnostic: DM5PR15MB1610:EE_
x-microsoft-antispam-prvs: <DM5PR15MB161015E267D2F5D9987255C4C1CA9@DM5PR15MB1610.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1/yDrBqsVdEVC8/CGm/q+IyZKCyi55thLXxeKrh5Cve1B1HBuI9s7HOPJ88EWtVItqk+d3Gyg0Fj0mPNaR7S+Ikg4IOrkM9Xr7XNuAOh4zjTTyh2heZ7X1ssFXu0cXZWwtYQIK5Jy/NbXj6lJMA3BbrH/aEXhrZlb/0W63y4q5eH4dx2Z0C3KyYf8IGTAVa0ttan1HVav54lXWwr9p2BMtqkNj9zmZilkUFPo58YZ2qKNItgYaajdm1fSurgX3v3BIHpbpam316GBoF5T3HmEl2xOmaxjy2SnsGpgbROTzrcHME6OnmNUnXe1p4vJloO6FyHjuilDROtfYjHbv54UKJu1m5yegPMt3tXP9ISRmobfV5FVMqG/zJJyoRHVjkZzuS5FVM9DSqtfaYmfYbh7tiRkg3MmUfKiVrjr76q5dP4LUEdDZGPj4lasW66/AXOq+1RqA6KQ0dLwUfJogN9bnAY3saOjCmLLOyTiOVmiIffJJIsYF/skb5QLtb6PY54WiN5S5/575ZrJo9Za1Cca5jok1yon27LEFyT0ryyQMUGreG1hq21D+m6GYmJXc8p7pgecRlffI3ayUyXTqUL0YaCphunyDGA9ly7m2Y8VV1KHcoGhB/pCRhTEScFTspFMt0UfAVRpuN5q485aL24+0CaQ/ApFf9kNAQh59sSX6Y9CYIwseBB2h3vAl9HNJ65HeaexXxJNh/hM+d4w825w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(110136005)(2906002)(66446008)(6512007)(5660300002)(38100700002)(38070700005)(8936002)(508600001)(91956017)(2616005)(76116006)(66556008)(66946007)(66476007)(36756003)(186003)(316002)(8676002)(86362001)(71200400001)(6506007)(122000001)(6486002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?23zmdWnG4R8uMjHeomorxE8RSVpqZkz6ZYUQabZf3c5TVhTzdj7t2/S/JO?=
 =?iso-8859-1?Q?l0ALix53qw5wpH2840CJW4zFCc1Ha/FSjxWwEKf1kwgAuuReeXtaHWV0L/?=
 =?iso-8859-1?Q?OGGqTVx/KPflApgnq7ECR3v1phmiamy2kc5NKXYoTaKtosVYFi+Y9e6ivM?=
 =?iso-8859-1?Q?1ps0CpTt7kd06f+yGLzdE9UZdLIXPr+o+Ue2N32oxgOwCq50ywc2WkNJld?=
 =?iso-8859-1?Q?pSYgiIsBhnsZ1x3D+txGnt6wyjLe640mljzMpF9x0NnIC4DrbonEdVT09B?=
 =?iso-8859-1?Q?8GmewsCj4YlKRDq8oFcDoksMZbKxlS305IdLUZepVV/OVAYzF+6wl0FfBp?=
 =?iso-8859-1?Q?q6MmmcsWyEml/t9rtD2Tle0SK4SAiv0uk+NZPRKLfmuoVvQR/bSymtaBHJ?=
 =?iso-8859-1?Q?X2S7SJfCA9t4EL0PR43oDebA0MFlFDiuYGCUZR7P9aWP1BSWBbaLgbxn6d?=
 =?iso-8859-1?Q?gh26dN20OQALKXB0Uhzd8uBQbdeX1VfM1JfB7tWiWpJV7RNmegLSHRmibo?=
 =?iso-8859-1?Q?UlFuDQ/w8BJ6IbjLv6ZpTCZOLbfJWmVBSWtYYIgTgaHNZsOQpEBafb408L?=
 =?iso-8859-1?Q?rew5B7bJ5VVnTu4g8sBzEfLVEXJfxzocb0zRRCsWVHWiNPZU5CwrLHPRoh?=
 =?iso-8859-1?Q?1bKf8Ce2YA/7TAZuLXM97t2/arTHPvnmCGSGxRG9NuOe0iBW5/3zGHo0/k?=
 =?iso-8859-1?Q?uaSunyl/PMasi3GnFJSicXdgxwl/aYfQtq7x2RHHRm54KE6BwyYTH65Va8?=
 =?iso-8859-1?Q?kFEFqyUNZMDPwqB0qBPlZDNEEQU304Z0vl+LaZGTUZyiP0Zj5L5DEEdaR8?=
 =?iso-8859-1?Q?SGXg/N9pzFXwfh/LWP1KdEjIW2i3qvX0ILg6mi+6V538E9nR69fr4URh65?=
 =?iso-8859-1?Q?hhFF3yjDZFaMxafJwA5aILvVmktyHYYyZkrxtT2lm9eTgyDRULznVxjS8a?=
 =?iso-8859-1?Q?FHKZ+l0tTrLT+UUp8EGXvit5zHUcbu31GMZVhf6zLI52O8rWCe0+V5OSzO?=
 =?iso-8859-1?Q?XoXLLzixacq1mc7KO8kk4E4izgm2790kvn7kNSxPncVvr6IWqfTaJMzcnq?=
 =?iso-8859-1?Q?+m5IQWT8GS5c59UT7LogGV+Ks5nYa/C9mHsy/DQqBl9fK0stIzV5qDD+KD?=
 =?iso-8859-1?Q?LDfaqsuHsZ04eFOlg+Uj9H5Jyp5Obp2EOcxrypo51rSikwt140zZKLNoZW?=
 =?iso-8859-1?Q?uAGnibgLE1RW7SbNshidV5brLMFjhP0wKdqnd9M6IoaBOZoOCgcVxCZ7f0?=
 =?iso-8859-1?Q?y6W+fwpb06r8iXRiErXDXavef8kdJBEvbEEJYg6U8yaKtDLbCLcvb1/gl/?=
 =?iso-8859-1?Q?+NUx2t8aBPCRghpRYiK9n+mTSBeFkPZA8Z/GGjGAZViReArgXpT+fteV4M?=
 =?iso-8859-1?Q?96l+xKxgkDy75JAKnzQo7kPpCAJvxR6ZljzpxbSG4bTuWwIIyCFCoYxD31?=
 =?iso-8859-1?Q?KGq9pZqCyPkUvCXuDp3aBgg9J3NspwzK8NKt0nNlMmZpjT5Y/lcpwoK95Y?=
 =?iso-8859-1?Q?fkhdVLZ3WdrhO6qEpS3XVivW/d/YqG685w+xO+kTIw2EDROwANxSNKBN39?=
 =?iso-8859-1?Q?R0PiVbWew5WxlKaZ/NwsscbtpzP6SKKjL36hjcYYRP0VHK0RQ+ImZ1+V8a?=
 =?iso-8859-1?Q?5vEVtm4OLQ+SfAuOAWj2LGtTHVgltcgQVbrq1Nl0z3Q9ZV4wbc+jJSt1Y5?=
 =?iso-8859-1?Q?5dHxDutfAYg2r6vWIFZev+E6EaVKezVy0U+SzCIysdwzkDk/6me5EvUvxW?=
 =?iso-8859-1?Q?YfXCHr+kd2iSzwfdxs8iBr7ujA1eeifO6u13I4Of9GRZIqrR+y0MXc4957?=
 =?iso-8859-1?Q?YMwRHXt2aq/2Rrh7s+hZnbEfKr4+ayiyX3/neDI5rErYrIgi+1Ua?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d182e-f5be-4227-621a-08da347f11ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:39.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5CohWll6YsEqy+/t4BPHxTKHi7YUZaqyHKMiG/dJVCw3COvwiu63onb2/9vNBO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1610
X-Proofpoint-ORIG-GUID: KU0TqfNcbfLPPhwFZw37lRtBXaTq1W1H
X-Proofpoint-GUID: KU0TqfNcbfLPPhwFZw37lRtBXaTq1W1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add section mappings for u(ret)probe.s programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4867a930628b..54ee6e422f60 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9005,8 +9005,10 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTAC=
HABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach=
_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, att=
ach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -11282,7 +11284,8 @@ static int attach_uprobe(const struct bpf_program *=
prog, long cookie, struct bpf
 		break;
 	case 3:
 	case 4:
-		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0;
+		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0 ||
+				strcmp(probe_type, "uretprobe.s") =3D=3D 0;
 		if (opts.retprobe && offset !=3D 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
--=20
2.35.3
