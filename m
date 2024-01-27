Return-Path: <bpf+bounces-20499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3E83EFDF
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA6BB20FCF
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7702E634;
	Sat, 27 Jan 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T3YanFJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="valtH65O"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371762E62B
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385561; cv=fail; b=D0ciZVVWT4bSnr3yC1ZXVYz0Y4y7US/wjO9YJihvAy/UceDA4DndbTiY9LPXRJIpJRtRwinbJnjik/Bh4qRRTF9OIFQma0tlvNK1Okd3KiOtAhKH2h9wSnUxxdEE9vQedk4cWKRwbBpWq7rYmISzo6knPGzyiCFLEEK+zsNMOxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385561; c=relaxed/simple;
	bh=Ep3G0s/RVbDnCqS4wuQ98N6FXNTaEAgb2G8nUUfyuxU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EbVlUqxwG0s2wJHxFyf8fs0Jbk5A7nrzH8/HKM8CprcBb0kAj5IsOyw8qcGYBQvOd3jvQ+N+JGZBTLqEmBIpXlrb+BDZ8UM1eICTFxv9BNWya59QP/oZOsy9QVQrZEohaU310aAbNkPapurHuCNvwGZIUVoAVmBaiWkVujkc6Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T3YanFJL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=valtH65O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40RJl6vV027050;
	Sat, 27 Jan 2024 19:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=HWXu0s5DV38VZYI3NIVGyWnmLuwkp8rtYtuEvanZohw=;
 b=T3YanFJLe9VZypeuiW4RbeSM5dT3kzognuk2RuaF/WwVpBNzFQ3UcPnhKkwzNUrG2jIV
 SG4NocglhH1pdI96J7tY0g2IOR99JbDA3latjCyEsiSsblzxJXHCQjf8ma62ZRQ1WuD7
 ay8DLFceSPCvVLJM9BYDTtSF/ZDXN9OAhykByl2y0oVyo/uQtTUCGVRwHVy+w3INiOar
 ddWEm7Bbbu1mgbDJk7jXHPCKHgHNIeCcObz/wtlyYs5RcMMtHdnYGXiQ0Gpip+BtCVKq
 6LyyaExFtOvqERJqHujHKGNEGxMirxyEeMymf+cDtjxqjxipIBwIMBEP7lpSMFyYi5ms CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre28xhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 19:59:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40RHqKEx014767;
	Sat, 27 Jan 2024 19:59:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9abdmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 19:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUYJO3XaXSnfOoSqM4bgR8b3nt8HvPiUemALRXVFcxmouzLDgAx39j38Eca07BhTkFPJ0NHp7xX5d7/5LP1NMeStU8BTckizwGAAjfIjoYYiq4jkzBjjrugaquMFTR1UzO05FxFny7plATmsw2yxe6fjwZDiosqrHFwpx6za6jbp+fuP0NnRV4a/IjJ/FLxzOSwgiGEdE0TSTeaRBdxZzlgwalnCCH3pd/pWnBTHEAl7oFhJYq1b9fhnVmzKkGcEbaBXsS5x0nSbhGeXOPgAgagxWLc7FXUPt37r+rajP53H6x7VQ+1HEtcFdp6crI9znrV0dw/+Y3+SMQqZCfUCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWXu0s5DV38VZYI3NIVGyWnmLuwkp8rtYtuEvanZohw=;
 b=kCFdUbtjwnpoaDVIy1geS8iOTcJjhFvIvReNolkV3mgkfIfkNdu7ak/6tAZmM4GDEjzPpBu+tqvI6YVxMfo+9CazF4KWjaPOHiWP6x1Rg9L3YrAkat37bY+5SGLOEi/cbhQRnRqJIh3GB4RUJq/1+lGyKFfkhdo+9a1VxO3nENloHnD4nriqSqkcp/MNDoARnleG5kh7tQO4kWbBJx1gUc0CY5Yf9AIqKj+RaFhLdDREqkXRqGtGJsbs7U5bDE6FlKC6nq9JBJuqJ9AtO9ZvA1LIAOVRVeHB8iFyg08LL0C9jmvYCqT0PxPMnrUMHGdnkNIjWuHFHYjP3fJTUxa0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWXu0s5DV38VZYI3NIVGyWnmLuwkp8rtYtuEvanZohw=;
 b=valtH65OYiYHNJEuxmdRjYFHGUe3F6hLMAx3LkocwlN/mzSOQx516b/fGJ4Aqj2GdhzUTBD9fNQudbZcPxPolNvbb40Lwn8pXBdQOml10Xv9ZwK3dZRqbTh8U68MlWhg6rl5rNkg0Kqc9xN3vhKbn5jfp5/S49cxf1q9DOdrw1k=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 19:59:12 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 19:59:12 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yhs@meta.com>
Subject: BPF selftests and strict aliasing
Date: Sat, 27 Jan 2024 20:59:08 +0100
Message-ID: <87plxmsg37.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA1PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2992c96d-f8fa-4722-d527-08dc1f726e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yZNHhzbmtbz9M55X6j6EdRLheXv8Pf9ZqHUfZK2nYnBgyNC6XvvnqhSuPxLf/dns36FRAD5n8YPi3RPwYVuRx1ep7SOyY0S8SfcoIXD2dEmPE5PKsNgaMQE5yBtF+XpHcjieHZO1ykqOJqu6dfSALUVnd8KbiLVvBfp4UsFDAQ0XJRD9JyhiQVfPNk6dpD085N4AIQWvbFERp2CYVVSy6TDLMKWt6wS43s8zwnIEZj+Qwv1JdtKL/u/DgImXdnjIN9LI6uyWwyz0isONpkblyFYNiKaLgyCNGWcIIu5mwP6XzKI3M8YJYXVUYw0xAJ01aYhRh6MN+PWd1hfo7HaalIcmHn94t0m/1GVlVqgmi2ntElTYVc1Gmz7JtSJZpncgK2H22ENOWMCdJiBdjvRymK8xuN5mAK4f9tt/udCTssecYvYAjiePiA9YKoufKsSjdYGsUl0b+qfnqZKlkwYHEFN5nstxlnJZteRr9CfWFUVXjJiil7Mn/zD8i+iXfZaIWu8XcinYquDgSdp7YwWu1qI66/SZAH6XtvnbVn6zpJq7WFcNJMdnEPbAoo4PVIdeBtmq3V5lzybtfHMknvasEZwqiHd8BaZlA3Sbru8pSpv8VdpH2VF+HHWJ5RgCejK/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(2616005)(6512007)(6506007)(6666004)(86362001)(26005)(966005)(6486002)(478600001)(6916009)(66556008)(66476007)(66946007)(316002)(4326008)(8676002)(83380400001)(8936002)(54906003)(66899024)(36756003)(41300700001)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kGFqLbFwThE3lowmG7MspgR6svZvwK20v5mXkvoxFhSAscBpWPRhqJm214Zb?=
 =?us-ascii?Q?XZMuVUHqu5K265EDfqZyNmm1R7iWQvFx62AnNGXbsBG46/RHZaApfGzyG9xC?=
 =?us-ascii?Q?tDHdRVQhJHAtRnU78e+nug5MJqs/11rpC9F0uDwwWhsU3IcpkAGGS5cjRgYG?=
 =?us-ascii?Q?9eYm0tlr68fZVOJaJ2fQQoa12WvIboMl8wxTEbyDqI4dxhSM0LTsAH3chi8J?=
 =?us-ascii?Q?9zNW8gXfbwnPzYBt3tORT/Jmnhx+dhi6+8P3ByPVJNYpT7xUAlEOwyZJm3uv?=
 =?us-ascii?Q?avQh6J87k7XZR2roMJ5QUvTNoXlUC5NgFWL3oWYWmW7JqfGPli7weC+SrG54?=
 =?us-ascii?Q?utDFEoFOR3bwHvjFoXwp8Ge5G6nHNoBlZo4b4Nvhe1UtmdbAGRCJ7nWNd/tz?=
 =?us-ascii?Q?9EURdu3uONB31C/LFrc/HHru8/qoQMhmkV1auV8MbAgAd1BBUgFGbSoDSyLS?=
 =?us-ascii?Q?c9KxjqSVBq2F173lHVG6bHJiJf6VC2VGHQGPrQ8XlY8KevGKCgzYdrDuZlMz?=
 =?us-ascii?Q?0tRv2ZssSK4aZG/D7iwC4GuwesBu9G1TBieihHW19IuEYw0MecNOll90Vlc/?=
 =?us-ascii?Q?4werH63I2x9SBsdbHtcDK2lyQTNAnkJHbMwFlMcnPAalazxGjwjTC4b5lLnh?=
 =?us-ascii?Q?COvXab/65lbrg6LhHzbKYiho8GZYKvZGkBn5Y3KTww+R2PRW0ChcS7/yvtlf?=
 =?us-ascii?Q?A9EEKnMa/UYTgiXinlUxR81pFaPa8oSapP+gcEfimfsynFQQybyJSjJoOZOP?=
 =?us-ascii?Q?xbY/ZvVEZdtXZFRiBITUWrdG9Y2aQQDcdI1gHX9K+caAXckx33ewY210QF5g?=
 =?us-ascii?Q?KwmUWl5G8JLL+u1YLmBU6HHB5b5yfWRRIUWWX/eETIUcRBemQrJbXbWq5x3i?=
 =?us-ascii?Q?r5a3ouXBwCD90BYBuJmqEtn2Bonku6VDQ8wVfvQp0ACvh32leDYLFGokWIlu?=
 =?us-ascii?Q?Vgm1Hs9zFzHYzpIDZ/vK/q7s0L3xKuK2BRtC51aiBGYCUBWMhGoCBqwMTNjx?=
 =?us-ascii?Q?DsMQT8z0h9vx3MvqaTbDG1t0fZBQ/tfA7DSUgtBNgxwqnPHbZvn+ABOiIV6l?=
 =?us-ascii?Q?M+gWqxnrPcBW+1gNMv/wSwN9Vtv6Ogs+xLOoi8x/fH8hvLKH+SWt/iSBh4pG?=
 =?us-ascii?Q?K8OmS9eTv380qQyW3wXZXYCZuFScb2AoXwAN8qJvstiwDN7MsEoCXsV5A5vj?=
 =?us-ascii?Q?9pj95Uu78K3gNcPPxKLJfUe4POmLueL7RGdsVhi4TYEJKmEb2ZZ5jex9y2kw?=
 =?us-ascii?Q?U4kKQUPrp1crdLR+8MtPRX6qpxc9OT54r/aLYt0I+C/WLVdP8/1y3yu6ChQ4?=
 =?us-ascii?Q?gs85w8+LGo4pdnxeCf7BLrcAVR+Es0FB5tGWG6wisq8b+hrTo8xRS5ut/dLq?=
 =?us-ascii?Q?XzGrhxLZDofPSzz/XSKken9/lb2l7TQbELvPVMk6iPvlnKBM9Jiyasyo1zW8?=
 =?us-ascii?Q?IjzXU5WLc2v3tjVylqtKG35jMXGrEa3ffMZ7A67PGZWy5/9kajx43I8rwNRE?=
 =?us-ascii?Q?fsXJhE/WTahxbN2B80Wy9/dAS732S+/pEtJnChm29ZXaJLMhGEhGFk7kyZ47?=
 =?us-ascii?Q?dErdnul2hacRPXbge+ZclEwG0EHmB5EdNGIEFzZZ1X4RFCjCVHhDRpc7FkEA?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wm+ItcsLEUnU+d6ODwLKF9lrc5BoFDSwuvA8MpsM75YrAASLHyhjh0SBQ2OQKeShDfl4nqmwqTEwaYtAHcoaIMmpEL5BfBhoVAO4YpNREh38/61gW5IjJhoSflJL+rQaXfe6k9mU7g1FWOP6qmfSx2iDS7jwQGC0Kb5p+fTSUSFfpt5Vf3EK17ZK3/yGKjdUB5aKyb/yuimOtk5m0fPG77U5Te2BM6f0I5v/jQ8Cpvsbb6+4cgPydtqA1P6Ow3lnoz5jm9BnRoNn9Hf7+oXKmX6GGItgacXkonKwZR9cJIsmOaeUnVATL4VOE6PjGy9j+dvNFqVlpW650lu5A5jdOvh9YuSY0a67H2A00qthqYYK9mHaZHPhwvBujFuRx39KJT3uYUcXBaWXVhTP+Qxiu4Y9/gDkOjwlQb4M4EPsFBRWriKeKo27Y0AnUKeVNos3UZzzVIwEEDot1QOVNdBCL5UogRN6XQRBIZR81aPCvOfwS/Uf9HF2+MUJbX2b0TmtoB9Jmk2vZ/cr8ov8ftvQypO0EA7+1KSMU8TxNsn3yhBPwyW3P9OdY9nCpLvqdc1/TX/hLwpTFeaCEs3LvGGbKULmSoPkF7LRg1/3g0b2/Yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2992c96d-f8fa-4722-d527-08dc1f726e8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 19:59:12.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAKlQFvU5uBzeULO0k7RAviq9KFsimCaFKBL+yR+cRIMipcBX93G4iJTQw2W2ZoYYMtisIWzOI1wtMVJUga7ODR9/SLVx9eCutrLisVSMw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401270150
X-Proofpoint-GUID: Y-it127xXSZplag4_ONKn71A7vj8DFcP
X-Proofpoint-ORIG-GUID: Y-it127xXSZplag4_ONKn71A7vj8DFcP


Hello.
The following BPF selftests perform type-punning:

  progs/bind4_prog.c
  136 |         user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;

  progs/bind6_prog.c
  149 |                 user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;

  progs/dynptr_fail.c
  549 |         val = *(int *)&ptr;

  progs/linked_list_fail.c
  318 |         return *(int *)&f->head;
  329 |         *(int *)&f->head = 0;
  338 |         f = bpf_obj_new(typeof(*f));
  341 |         return *(int *)&f->node2;
  349 |         f = bpf_obj_new(typeof(*f));
  352 |         *(int *)&f->node2 = 0;

  progs/map_kptr_fail.c
   34 |         *(u32 *)&v->unref_ptr = 0;

  progs/syscall.c
  172 |         attr->map_id = ((struct bpf_map *)&outer_array_map)->id;

  progs/test_pkt_md_access.c
   13 |                 TYPE tmp = *(volatile TYPE *)&skb->FIELD;               \

  progs/test_sk_lookup.c
   31 |         (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
  427 |         val_u32 = *(__u32 *)&ctx->remote_port;

  progs/timer_crash.c
   38 |         *(void **)&value = (void *)0xdeadcaf3;

This results in GCC warnings with -Wall but violating strict aliasing
may also result in the compiler incorrectly optimizing something.

There are some alternatives to deal with this:

a) To rewrite the tests to conform to strict aliasing rules.

b) To build these tests using -fno-strict-aliasing to make sure the
   compiler will not rely on strict aliasing while optimizing.

c) To add pragmas to these test files to avoid the warning:
   _Pragma("GCC diagnostic ignored \"-Wstrict-aliasing\"")

I think b) is probably the best way to go, because it will avoid the
warnings, will void potential problems with optimizations triggered by
strict aliasing, and will not require to rewrite the tests.

Provided [1] gets applied, I can prepare a patch that adds the following
to selftests/bpf/Makefile:

  progs/bin4_prog.c-CFLAGS := -fno-strict-aliasing
  progs/bind6_prog.c-CFLAGS := -fno-strict-aliasing
  progs/dynptr_fail.cw-CFLAGS := -fno-strict-aliasing
  progs/linked_list_fail.c-CFLAGS := -fno-strict-aliasing
  progs/map_kptr_fail.c-CFLAGS := -fno-strict-aliasing
  progs/syscall.c-CFLAGS := -fno-strict-aliasing
  progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
  progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
  progs/timer_crash.c-CFLAGS := -fno-strict-aliasing

[1] https://lore.kernel.org/bpf/20240127100702.21549-1-jose.marchesi@oracle.com/T/#u

