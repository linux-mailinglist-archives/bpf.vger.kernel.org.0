Return-Path: <bpf+bounces-20807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4906843B5F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B9B1F2AECB
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CD767E98;
	Wed, 31 Jan 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mw0JvTj0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y63GoPg/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294716773D
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694315; cv=fail; b=qR1UZ1jitjuW0OWzlceLv2LShbsOKtrv2ZSF8gofGBSrZAIA+yWAEtMelk7BJj0wqj8dvBuQRpjPXZc6vTIQ9aDefHkaQ5MtqxijLsTptYNUf51uvtqicQ6405E4Pnv/wOomNUI4pzkLQ0V6V5Xukb+C7CCOoaxU149tyGF+2bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694315; c=relaxed/simple;
	bh=iW/GF1yD6ngqA0GRUauOFBh3vk/J5Z/uNTbJ99Zs04I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=le9U2gLFh+W+3HP12l2WKUu7oYBJn2DjZddUjDgsz16WjT8bPLyBGFxyoatkptyH+sPp/lhvLWgTtel6azRq6RJtC+NnNzTgLMU8nCwBSWzSUFSWpJVJaGYcjjKHtSNr8MJS9BX6+0/tB7dNSPZjmYGrCt14caxKOIVcgaE9/T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mw0JvTj0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y63GoPg/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9ihWm019046;
	Wed, 31 Jan 2024 09:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=VPAfa6F2B3RL6RKPU7vAD3OpUyVNKZDRbpZyPvyiTTE=;
 b=Mw0JvTj0nI9Hdyl+JLkNry9rimpBJaS8+3km9zaNuCh8B8wm7EO79Nnara8Ujc9Y1ULp
 sJ5wRNwAXkWlibm0wvoJWM1IZGtrem/5QzZ2RwOCIfmsVp2z8cVFBe1C1Y4NdOexwpGW
 kM+mELI7WuIayEUVMcXH4mz8/MnKq9V2ZT0OBdC/EuIpGcj6tvlzkrW+l5lDN4J1WJnq
 AOXzewcJSWkQqziNJeHCYGPrK5WCedTlhf9O1V48TjrK93zYc/nnZXftYUbVt1bt5djm
 WvDblZuIM9pjCf2pgscyYb9hpc3XnnK4k8MM1Z5B7hVDJZ47qQKdS6snxqmo16IMn/PW ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrchg9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 09:45:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9XgTo040141;
	Wed, 31 Jan 2024 09:45:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr98t7sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 09:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQqggMRS9cO2Sch5DAZBv0a4ibmJTwsA2gELspHRjMdxzpr3B2OS4FgOzxHqgRwDSmuyQoLq04JLl+aTRi/VPJM1QOwd/HO2DxHb2kBw8qDArN9uLwT1NY3SwRfUam7g4LWR/nFz1YDtQtafERx5ravXHoVoHdoXQnCwBJLSgZRtOk17NkTfexk4nX+TpZ5QiZziyTf6BD0HQqZ6sM/Fg1RfB0b4BE84WqhDPUeDEoAXahFjsycB4tcag1ONExsl6FFWPqygRRxldbJLJL9KpR0sKigeEnPDJj/K+cqSrx/tSmM8VKWJPE0HAYKHkFzROk3LHoh6xFyscU6A1YzmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPAfa6F2B3RL6RKPU7vAD3OpUyVNKZDRbpZyPvyiTTE=;
 b=mofLyCkWvvGTKsasNnnmf4XUY93vC/OjHMRzGLtL6PDr8tdGauT2kAOwRVKHO53Z1tHo01JiqNOJ313iRVarwOETas1ckUBtKt96EUaqnxTCyR8+bnH7sXVXjvaRu2wbvRKADU5uHhnU1amhRHWf5RmR5qSu+Uu25SJG3dFTZIFgHNVnwKxNX3iNtXrBEjuo0rOL7GzuPkAH5oAEVgbB1Sc7WQwI+OKQu+kJeBaNZMXyCvFgb2empE6q8b5TNqk8kEUPOGR19RyXAHJhRZ+5dGdYklkFk5qf073R+3G9Mut9fd6n21KRjh8SbpPLd8eP4JFyrq56KjRYZ/B0Bft+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPAfa6F2B3RL6RKPU7vAD3OpUyVNKZDRbpZyPvyiTTE=;
 b=y63GoPg/SGuX5PdOsHOcch5TCHmJfzc0CtRTm6F6QZnQtXG9NgO+stcVQrXV6oDk/IY1igA0x1Gc3a9QN4KWBtX1qjBmyoiTF+0QMXP+qwo121Z6x11AdhDGIuXgSb/zKvxD38PUDT/vgCv6n59ZCHC8MkNDsPr5XbqvZYaLsOM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:45:06 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 09:45:05 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next V2] bpf: use -Wno-address-of-packed-member when building with GCC
Date: Wed, 31 Jan 2024 10:44:59 +0100
Message-Id: <20240131094459.24818-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: c26e64f6-b5cf-4822-940e-08dc22414dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ibj1wf9Cj3DQA6uf72RC0W/j9QZceZ2lJZGS0mbvYVsuEcVTS7414SEUvlhLNLMJg5emn0oirydeNhdfJXbHRXhhOzolDSgmgvfkQ2r2m6f9q41bQEngvrI/nj0R17ZElJa8C+q62dzCWxEa4dkQgttbcQDCZmHsduZdQqIEyRNziI5TiLcPeuCZxz82nyptQnRNSR+9dRwbZcUgzL5gFSJcEIoerR3UZjUxoFBZ1gz+M5UjkCCZIgUS3vFpSEbcVmMFr2WkREmT0bmIJInBGmnzDB8ZyeheemZKNhkEeZERihP6OY4B6Sdv7Egvrp+2xs+tSowsIlxvFzSu0rekzhp+eUMjPUApL5ieDy8nSmCOxBZq1ql4nvkZ6fTcZxlPKGranzEyV2pwBdN4hKt4xo9j7IJl6FxLqM1jupWkSZ/o84NdTU6ZNk86fgUkCG369oA6D2IWbhEBXQ8/5IV7beVUjdtbZy2toTP1yRrubFoBkFucYCROsi9XBuNULsA2LLIg0bgHxM620BszS+l6j56P0ACoDJcR/IEl2eCIOKmErszuGyNGRozxre/V8DObe2L0lssYIHiEPaeQ9ORUqtbFibw+8IZ5H6KObzxzdhQEY+NcmkG8jwf/YwPuM+AP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(1076003)(107886003)(36756003)(478600001)(6666004)(6506007)(26005)(83380400001)(2616005)(38100700002)(6512007)(86362001)(6486002)(2906002)(5660300002)(66556008)(66476007)(66946007)(54906003)(6916009)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4WHaVXVite14oe7+H2N2kqJAEiTCjhfPCkj3FuZmnlw6uOSFe+52e4lWJuJt?=
 =?us-ascii?Q?UYrpjQ5TQ0CF9+F6xFYl3DMXPxDfLUJYOqJl6SzZRt9nNd0mcUIzSbHiiPG5?=
 =?us-ascii?Q?+RKx21uexK6Qw1fK0Q8oFTXlyRq30XiZb2b9sXP+t+p8BqpgMu4ZCHWS/9OQ?=
 =?us-ascii?Q?mmMu+Osa7uLRpDR7dB8bul5u3ITy0L4N+v7PXl1imgg0dl+xjIYhGTVZyH6B?=
 =?us-ascii?Q?zWlyBYqYhL6w0+gSC6aZqj05B0R/8YkMaZXxicX5EDraQQcMyoGEEsolUNni?=
 =?us-ascii?Q?2NPCN9XHF1fZTfIkebpBv3ELelxWXUnCLsLUrPMM53ZpyXVVgXP4/Z0IdX6W?=
 =?us-ascii?Q?KS2VGsm+IEkxO807as2YyJ7Ac1OieVTQvVoDP74+XjmH1ZHURKrSdcewbW5J?=
 =?us-ascii?Q?Z1pdIYGFYdOlFSa4LpvY1Vt8dEy3kCWPivGlAN8agj+l9//M3QNsnrElFUKA?=
 =?us-ascii?Q?iRL6Ribo9rWau1GVDsyuWuGJ46nh91TEQE0SY06aeJ+tmO+q832Zp6ne5EIX?=
 =?us-ascii?Q?0o5XcoJfa6hWhdz+u/3LZeH9P6nln3fIDve4kaDk3r6KjsVHd/cIgRKA0lpy?=
 =?us-ascii?Q?imaSWRvRmQ2z2TxoqEBM6HEd4c1G1ISKaHyMcpq6N1SPEEmEM3Uk8cjERhd2?=
 =?us-ascii?Q?wxPbaKZUOwYC/z5My2wfE/x5E2hxm+fVek0o2H/JLQnW35Z9Se/ejwYPAkWA?=
 =?us-ascii?Q?0j/mW2UoYmKeuTchWRjtmA9SqKQX/QqIpJWX8Ed68ZzRVvSYv6a+JPV5qX/0?=
 =?us-ascii?Q?ug1IO+KzM1/Kbdcz5IIipb15HSwpis8R0u/LMuAguTxyJqVhgXyPSe0NmeIu?=
 =?us-ascii?Q?GPsq5+BDGhWlL8BVj0rt+sDmAuVBWJyAXtsPTwZU8BKHVLosZ2Yihkugg+jU?=
 =?us-ascii?Q?5TPpKiTvkgvMpn2tl85DQ+HZMtjn48ZEU2ZQ004d4/3Kf3DDN90vkjdtX1Sk?=
 =?us-ascii?Q?P9jBAGgA7M3E5pjltLgr1tPsVD+i4INCRY0v+ltmrFykPmEBRji7XtKdXn6W?=
 =?us-ascii?Q?4C9CVKQ2X+tKA595td2OFyQZDUXFZE2xgmGigMApYbMTORFuSn/3niJf0xVz?=
 =?us-ascii?Q?K0gYgmaYjsE/Dh/2sV+CpFxbDxIDLySlTyCMoIp5PaROOoo/B39VLYIiy4B5?=
 =?us-ascii?Q?q1h8rocFivSoDJ6i++nT4a3twWyXdxg0ZHmFoe0JeP7Gr4Gy59z3sZnkFYn2?=
 =?us-ascii?Q?lgWbXQGM8bEMYvsGnIf0sEFXv3/ZULOV4kQLqEba0IUsXhhCdA9/s80rkEQn?=
 =?us-ascii?Q?eeVjaJbrXIGFRSt0ik4xwrPORRhla69mJ6tAssWK43dLQ/XzUwoQ2zp1jfXd?=
 =?us-ascii?Q?O76UdbLGinvUp9jY5Z2gBXxLKjGawL4MOiWHVLEobPMM71t5HcwsKAsgDcHA?=
 =?us-ascii?Q?lLLqbTEE0UW5hnGrMFFvJuErvZfNZJ7fqpHIi3ToHCl1lmNpjz0SCallfggv?=
 =?us-ascii?Q?1j2/B5WDL5c7O0m/09/RyhRipiR99Pt8Tz+DuJ7AqUsC81TLhSGO99vbLhHl?=
 =?us-ascii?Q?1ktWbswHV+CoR+nWZJXliAq42YR5kKKOpqlBwD73J+8r2jJHpLYNamfdwe5R?=
 =?us-ascii?Q?+fIlp/j8rCwXxRhiDU5ZpddvRcb093Z1PZBZmMtIaRV73tvGV3GPtXmU24Vo?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jg4CBMD74Qmdut4jiFKgd/yxsZljim96aZg3XK1w3hnZKcppLc1LZMH1JbPLrcHtwUpU6R/38URjLQ8d4jhsx1IxVw3xWXt7+yiz7sg1ObQosmsOTo8pAqxfCnB/8QYykhVh+xCKL0k9JNmppvusTwPPrnR32R0CG6zuUkspDFx51hyqaNm0G5gfXl8NiJLKC3RMhu/ZL3/X3+U21SyS6nmF10pJfVkc+7qKZTBViPlWr8stxGoWXZMirn8VHtYpyizpoJeKkVTFfqgulbVjh0c0GQupUya4rpsC6c/ZddAT5Sg5wYpgOoKQwk0d1MRc5WNcngJLRpVNRRHl/Vt/rAyzIicdNUoTtdIQuKzSJRIbVS6CMTs6ah0zY8Hbp1cfco00o2PgvBtC+3Z6q3DS8H3Jke5V/97IYogDQOC1LyCo/pRQTqidZZSJYUZtnY24qwRplGwPRwmXtBXPIX5D3Q/gL8NLS4CPEZ0Q326tlHE4MwsfNpPgRJKQnu3515ZHMTvX5/aEcT3MbX7wPYyXI+ZNXkjXY67MqNrHxNBKkOXtJwZhwRnXYyHvGUZupABAzq3rCEddqXIXGQlcUjn1CB9PYz/gP2IdCBGBbEs9Cno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26e64f6-b5cf-4822-940e-08dc22414dea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:45:05.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryPPFvdMch0Oz4l1anbGq8/gXFLPxvnmPKfHZP9mf1b///V2g8FZkMCGxMio4xpeFu/VhEVlzdVxqdqmyX/DHTg/pDFFDqKiKx3GYGCg0/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310074
X-Proofpoint-ORIG-GUID: w284vU7U361i04sg6kXROwzUj9n-ANsM
X-Proofpoint-GUID: w284vU7U361i04sg6kXROwzUj9n-ANsM

[Differences from V1:
- Now pragmas are used in testfiles instead of flags
  in Makefile.]

GCC implements the -Wno-address-of-packed-member warning, which is
enabled by -Wall, that warns about taking the address of a packed
struct field when it can lead to an "unaligned" address.  Clang
doesn't support this warning.

This triggers the following errors (-Werror) when building three
particular BPF selftests with GCC:

  progs/test_cls_redirect.c
  986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
  progs/test_cls_redirect_dynptr.c
  410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_cls_redirect.c
  521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_tc_tunnel.c
   232 |         set_ipv4_csum((void *)&h_outer.ip);

These warnings do not signal any real problem in the tests as far as I
can see.

This patch adds pragmas to these test files that inhibit the
-Waddress-of-packed-member if the compiler is not Clang.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 4 ++++
 tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 4 ++++
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 66b304982245..23e950ad84d2 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -22,6 +22,10 @@
 
 #include "test_cls_redirect.h"
 
+#if !__clang__
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+#endif
+
 #ifdef SUBPROGS
 #define INLINING __noinline
 #else
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index f41c81212ee9..af280e197c55 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -23,6 +23,10 @@
 #include "test_cls_redirect.h"
 #include "bpf_kfuncs.h"
 
+#if !__clang__
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+#endif
+
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index e6e678aa9874..d3e439ff323b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -20,6 +20,10 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
+#if !__clang__
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+#endif
+
 static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
-- 
2.30.2


