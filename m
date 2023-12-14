Return-Path: <bpf+bounces-17803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9E8129BF
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 08:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346721C214BB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BC1401B;
	Thu, 14 Dec 2023 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="G0Jo9dV0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B4EA7
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 23:51:14 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE7V7Ae013517;
	Thu, 14 Dec 2023 07:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=EZ29JP7StHK3vgQ6ri
	xU4xJwS1AbNTcbh5Xc9vzCtz4=; b=G0Jo9dV0FbYrYNkOwHWEzEY2JyydTyOe3Y
	O0DJ7+JH5vlZi0uegKWjCx3odj7mpxDfLanK9K7ZZ4U1fHvGCu2wIRPC5cAXqNz8
	V+vaw6E8GjyMY2nBrmn5lDUCJDj3ixXwKcViWWbY35gP0wj3DQQolvswzpEOcbps
	54Us3Gs+bNRBFfw/d3MuBMSg9DwoQARY8RvzS3clRHf9+ugwJ9hyxA0suqyQafrZ
	fC6OFnyZQKJ8FzVfWpXCxzgdMgo11bZpPTIvlOTZ6SyumrqBSWPn4k0q54f214u6
	3M2FTUJieMuoX5+gnwgc8+JtCPGFBLnubp7PRX3xZ6vxCI3B06CA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr7fg7a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 07:50:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU2R2bzMMETM+AYTJ48iYpzFgeQQ7AC+Oo632IR14QZg/oFxKiFKyjwDf+FU+m/OSOVfBmeCND9s7pPPV5vwyuRx0I5/BQL/ootWHDaa6GFr1I4mBwldAIUF+l1d/Zk1wChivyvBiqgR5hdfphoReUU8pRuTNlUEnGA6o4Ari8432dmLSPEDNeHel+lughLzL1MzIOp/jCXrdleCo3Wns0gMAn9LWD2nx+0cprSJjDwAg+X2bVo33C1jrroRcXtfVGGuJR0SDRqh3o2c/PF6iFSwtFi2L8Hr1m0ickTgExlbcfE+/PgVwsfqj2oVi3UdIWtoXKKCaygNs03mMZ2VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ29JP7StHK3vgQ6rixU4xJwS1AbNTcbh5Xc9vzCtz4=;
 b=htNxrXrtW6sg8G8fJ+rzBncFBnu9S/Ve4SCHliuk147mScsw7zDLtdbsiEo3mc2sC/JVMNjyf5+0IQq5M0zviMD2j96Asb3npGR9WXLGC15rluNdvTCbQzr/en/5+7jVan7zDof/MIuQr+z1fZ9Ka31ssY7qNE92NxeBaDuDboJFFs1zrfD2ngi7Ooamf8PJelK2MpAO64CCWvIuYWgvzNvKOC0YJTujByVAO8W0+bmE1nq1qNSQy+V0EcC45x9iLJFdhQ3SVP6MBYhl0ASzS+DLTT3i+f9yKWsd0ghToedrmEpD3PB17b8n2XUMqgR+/LIuqk5pfKC1H1I8E8ztKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:50:50 +0000
Received: from SA0PR11MB7160.namprd11.prod.outlook.com
 ([fe80::2bb4:7a82:f7ba:9da7]) by SA0PR11MB7160.namprd11.prod.outlook.com
 ([fe80::2bb4:7a82:f7ba:9da7%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:50:50 +0000
From: Wentao Zhang <wentao.zhang@windriver.com>
To: wentao.zhang@windriver.com, ast@kernel.org, daniel@iogearbox.net
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Fix null pointer check in btf__add_str
Date: Thu, 14 Dec 2023 15:50:37 +0800
Message-Id: <20231214075037.1981972-1-wentao.zhang@windriver.com>
X-Mailer: git-send-email 2.35.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To SA0PR11MB7160.namprd11.prod.outlook.com
 (2603:10b6:806:24b::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB7160:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 7063ef3e-d3e1-4259-fd42-08dbfc796404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kdKDZ3F91y42+VjY7AG02UwCeZcLZj1OhfmWo7lT70JLF7b2AlUmlAdvqjbdJHLGoYH9LWSrrCsqJIKfyxgKV1lLDgakjUcvdJH3I4+d+S0By3Xp4m5hrBTsuIl8su17kCY9nlGIIG04kDSL05E1ikK3h3fk39mUX+fqT1YIUc63vHXJQtVZApIxgV74rPtojs7/1GIvqbCmBYYyxKwrdGc0eK5j2sQ5nS/2uNeMJ3FP450gQjCeIrRTuyrVgclxxjI/g5kYxzVR0Y7RxZ/vVe+Jx33NwsJqMtkJhBlaRgDnuCcC15+i0wfgWrUU4L6g+o4IVkSiMtsGJw9Kr1uEQqMEDAwM4S7PLGKJZC+9Dl3TnEzyhfjRHh+EJrE0UmjSDrovtKhfQkTw30SxwDH1td2VBJFq9OBSjNK3eTtIC2281W6SCMUkHBlD8gTW6wySXbJIyI61YHFfQZ48oQ9y0o4S6d6siQ2nnPcBTT+hHi4AEILiDEB2S991FdR3ereNRHmGBWGxQrtD3l1mlDZdOSsy4X85b5/5og+Fo9Jyvpv7qJ/tjsNC7JN8leTskEFjTjJmxkGgNh6wxY/rS2s7zx1A0+S9vLE88G5K5tZNDKwdTLh69TlPkZ+QUywmTCZcsXG93xyjgnZ/ld3yvvBCYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB7160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(6512007)(26005)(38100700002)(8676002)(8936002)(4326008)(316002)(2906002)(4744005)(6486002)(44832011)(5660300002)(66556008)(478600001)(6666004)(6506007)(41300700001)(52116002)(66476007)(66946007)(1076003)(38350700005)(36756003)(86362001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AHrDtEZn6oMypYPpQxqUwqM8Yptm8HzD1SAdEuY1/SXGgci3LfypJuDIQDcD?=
 =?us-ascii?Q?MXy2G/ZrmmY78otSbzuZIIyf/MR9VYGnl8czu7S0c7x7/iTW0zJSe91kZSqn?=
 =?us-ascii?Q?N9joGAbRlaqwX1WH7caw3F6TvoY4VSsUd9twYJBUmQ2aVv3LaXT0oKSo4gS0?=
 =?us-ascii?Q?yhzw6Nb6GvVJWjdaLB3vL0IbJ2KbK+pv3OTPLnMT8RaWVXihWF8NoqghBNb4?=
 =?us-ascii?Q?ocIrz/Z1Ta+SJ8q3nciyt4NlSm40vt5TS+XKi2MR/AdCFrb9mMK+1w2cf5W7?=
 =?us-ascii?Q?EY5OKxNe97LINOgBSzSfLuhFhsSNArTMZDqBOkUgtgm8xCzeg5HB9ckjI0+p?=
 =?us-ascii?Q?5Cwl9WeRS2UQHuy4HKf1mrDVPhwD48nrA7nnDfauyYkFln75lRS3nqL7+lt+?=
 =?us-ascii?Q?68zx4Fz47hSEr9pRvtOhkRrsF0M/I4uStOdMUirikRtkGCyjF5dhn1vHMObd?=
 =?us-ascii?Q?7s1YDmWsqsCnrVl//ixGhZWTuJ+OwSrPVqG9DDPJNUhAu2AqwYx+wApfui19?=
 =?us-ascii?Q?HYKc16fck7WX6pSXJGvZavg61DQk3XglgrE++tipcZgixGdUzxw4+iPbIZP6?=
 =?us-ascii?Q?9WEnaZZ3OOq7hqOBUZdUaDAP8STCjyMu7syWIQUMh+4wTN4gp/ho7elevWgu?=
 =?us-ascii?Q?ESJSHsV3F45pdbsniPYAfzuRapvUE5/iYICnykNARv061bIeZs7RIp4e+6e/?=
 =?us-ascii?Q?bYi0HnlvPOVmfMXdN/+gnaNlFZBfjTkn9HJzfRZwfQaT033NSGi6aUb2m0rL?=
 =?us-ascii?Q?TthM5WmyW9gSAxiE/jLlT/NU/+5sD+xJDfhB5gA/6qO4g3gYTES0OKm9k2kD?=
 =?us-ascii?Q?6Gqe/376z++BMcD+B1p8CPb4vrzqRxvp2skAcjH97w41bPZOvz5UflDFH8q1?=
 =?us-ascii?Q?ouQ6o1BPOzzk4hzcfbXfU7tLqdWD/FV1rpZ+CRxNebbRJfeDPqQ7SCUE3NCT?=
 =?us-ascii?Q?N+Tb0TIMdu2CycNr2klxGkxFYFKXq6uEJEUIlTZIFVKrIdfYpebSLsHz3z4q?=
 =?us-ascii?Q?AXnW7DxZfsgMEkSbk7kQA3Ut/b7W3fYiUMUCGlBAPvO9BnmFr/E0aCxrU0B3?=
 =?us-ascii?Q?4cER1BvcGrn0aVI2yBrCi/EIs2qVL5U6ST8N3/KiiglC4N5UY8PJpVWzai65?=
 =?us-ascii?Q?tjWB5+9WKa/cSNJCG1sop+7Z1oCf7xTiVj2Z47UBgqNiZ0DibZIzuac4m0+c?=
 =?us-ascii?Q?Bw6N5ZNOCTZ+W3T4xBPbaZ8G8WxCZIHTr02qYcBVU6lRzDZ497EMDcjZowoB?=
 =?us-ascii?Q?nmYgRRI5JxzYLRTaR5Z6VOxWaWmmTILjWA4IYPAwdpMwpIVSo/W5f7d05H3A?=
 =?us-ascii?Q?I3R4BkQ5nDJ7KSZZTJ2sjrAlCWdQQW9t09o0yggAfA0fLcpmenXiVUljXS2N?=
 =?us-ascii?Q?z1AJ2iV4IZnK5WAD9Jaw9laZfdexpNvaBbTddMcN+QR98/M+JqcV167uB2T5?=
 =?us-ascii?Q?P2nnI2PTlOMjQJqmMMWmiCD402DzYa6aN19Dnncpbe6R2xWp7AqIRwePesQt?=
 =?us-ascii?Q?cYwV/axXf67IxpBIiR1qCQb9jyAXod2P9xrYH/i0F4SJPvnBVMillntiUEJl?=
 =?us-ascii?Q?tORyeEUjA2gb5xDsPfcixFuCJSvcd3XjB352SKeiiz6BLWw44/5V8GRpaVPW?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7063ef3e-d3e1-4259-fd42-08dbfc796404
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB7160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:50:50.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icnyMpzhvRG0xApGgvd6X/mTv+Cl0TZoHF8SstVILGiouSO/L8xQUuLTuPGAlZOu4UlBj/OUZ1KS3jjY2RPIm0CR2pB88CoOEnZDqu6zyEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-Proofpoint-ORIG-GUID: aMC2TAWFVirtat_pHQ-QeOYcliXnDHB9
X-Proofpoint-GUID: aMC2TAWFVirtat_pHQ-QeOYcliXnDHB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140049

The function btf_str_by_offset may return NULL when used as an
input argument for btf_add_str in the context of btf_rewrite_str.
The added check ensures that both the input string (s) and the
BTF object (btf) are non-null before proceeding with the function
logic. If either is null, the function returns an error code
indicating an invalid argument.

Found by our static analysis tool.

Signed-off-by: Wentao Zhang <wentao.zhang@windriver.com>
---
 tools/lib/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fd2309512978..a6a00bdc7151 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1612,6 +1612,8 @@ int btf__find_str(struct btf *btf, const char *s)
 int btf__add_str(struct btf *btf, const char *s)
 {
 	int off;
+	if(!s || !btf)
+		return libbpf_err(-EINVAL);
 
 	if (btf->base_btf) {
 		off = btf__find_str(btf->base_btf, s);
-- 
2.35.5


