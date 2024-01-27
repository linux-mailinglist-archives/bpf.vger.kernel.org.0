Return-Path: <bpf+bounces-20494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946C83EF9B
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61DA28464E
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21562D634;
	Sat, 27 Jan 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YurcRzba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XtDDiW85"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989325779
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706382012; cv=fail; b=kYyrwaknMYV6ztWRMNEYTMSyXrgdkDkvbtacKYODZ5LRptBaMxqUaDfzTgojhSNqjOQrx4IhMMQYQshTiaW+EVVNqmj5g9IajQhMGcSTmK9ujSpJE6vguJka7+ti6/unNmKkJFgEPuRZC9lxpX9Cw5ag1iColjXO6Qy0W6WLXOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706382012; c=relaxed/simple;
	bh=m96JpgfAaNzy1Z42TrcFAXh1dOqyVLelvMIRkxEuVlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=c5CvTrRbaXI50fIxRehDfv0a9wAT8JY4OcNsW4QgnQHh6yxhgsGkG4buO4R2WXdzJFy+lxVcaMFTyblh/uGDoENnAmEC/it3rIopK+10Vt0Y2HKF13QssS9MhRet84s1lmXSKZoUoOWILBf26ur69ZVYaBl3D+EYFIjn9lOk4cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YurcRzba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XtDDiW85; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40RIEFCR015048;
	Sat, 27 Jan 2024 19:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XxqnoF0G+JcYvpl/3YWIp5cc/1nBj3U4ABIe2hzl7Hc=;
 b=YurcRzbaaxqb7Dl5fF23wyI3kdgj/CjtSsGWyP9TIhdRFM2WW6rQleBop4vN83HSj3oq
 lMIWZnscM845KGS4ROp+1Tu+1l4r1LG8MQbHsqFlozp0d79zL2AFLW2rJ2rYC3Q/RpJv
 aUOtzeTcitwaF05a9xU5nKcGdmaBpZafqAtBZguGYYpNBhmgV/ow0LfNMeJF/2W3cxtM
 gcAzRRYDQW3GiX1diE4MHVAC8dR783RZS7LLMCuLU4wk6pwV9lU8aVhUqImZ4kR3FWgu
 SSwfo5mtAH2C7M+jnvuZUqsXV3Q1zoXfY/p+Wy7rHIhb1D+nojO6DsZd+8v09NIrJ/7r Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrc8vv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 19:00:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40RIFHfo014606;
	Sat, 27 Jan 2024 19:00:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9aaf2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 19:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF+TNthKgfkeismqasgeHdrV4+QuNLoCiTk4nRvURRU5a+EknHaf9kwDWEAoHD7nTQBzwt6+GTuFKk5pqIGUeqdcF9Ys8sZu3OkiVPfWhEWvxKDFl5JroYzpkvVFc2LW8VXUY3uxFvtwaE2esk4Nx+T7PCCl2psbrTAfMZPvcjw7sCV9WZSteY5w9/PXnbCf3cM3FV9rZ8vIOp65LxaHm5wmn7c2Lvf7azxi/8uJAWqOMxx+IiaIkbuxMpom5B6Ro8zrvKVKlAL1a8WL2UqNkYBSDFgbURo2PKtLt/x1aoKlB4bKpPndpdBvt6ET2H8L58hgZ+imNRgeH4Pxb4TT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxqnoF0G+JcYvpl/3YWIp5cc/1nBj3U4ABIe2hzl7Hc=;
 b=aHz9WST1TYMOKe0idLBAJdEzbFvEp6TMc8LrQ7xpnZrSQ2njCdprlObJkT5Ncgu5RtsBh65wsKUR6IXr9zV12n/jWXJNtNQmuQjHfUCiBwNs87s/chsA3ACQ1tsKGK+N+sfPSuWE7lUruNrGfhFLywi/6RXSJ01XPAjORS4K1KN8yMnyRE8e7AuPoKqW7J3e0GX5cX5FlXrV0LVD8QYNOCbEeERwEyFSjVwYuksZFfDMRifIuDKf1ltq5K+KoJLWOOlnzS235BegMBngRoZlt6KNzcGSe1ly/H9hjhX4EiTbwWq5aDsAnG2Hces/Yaa5QHNT0T0/VWHd6sJZaYKvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxqnoF0G+JcYvpl/3YWIp5cc/1nBj3U4ABIe2hzl7Hc=;
 b=XtDDiW85Z+Eg7nF1y6jOKH5SJhuNhDDDGkPSCY9DgNxepGpuJQNjmEsWBswO53rhFQDUhkoCBBPfx0jFlRciTfjzg/Or5JRVLnq+KRe061ZNrrK81+unYYQmKlYKDn5/4DVwW4viTC/hODm1LA1eo9o/jRYEznh7BZuAHhNAJIw=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Sat, 27 Jan
 2024 19:00:02 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 19:00:02 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>, <bpf@ietf.org>,
        <bpf@vger.kernel.org>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
In-Reply-To: <006601da5151$a22b2bb0$e6818310$@gmail.com> (dthaler's message of
	"Sat, 27 Jan 2024 10:50:00 -0800")
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
Date: Sat, 27 Jan 2024 19:59:58 +0100
Message-ID: <877cjutxe9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|LV3PR10MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 16af21fc-ff6f-4dc4-494d-08dc1f6a2a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iNv/+rJMC5SO+YotlR7Ws0M6DMtwuXpcpCZ1CCyjImKBF8YH1Z80IuFy4F0DwW8fLb1+lR8Nu7UcjB1O3zCbBsemvotxNQPphhG7+j3oJUyTf+Sk0wHtiFPIqZinsy5McSzDjxw0pnzkqtgFRn3ga5cJIAKLMerwIGLQ3HCK9SB4aI5R3+GjRpHiW1gNie8uVOe8EE0DVpnfMMcO6WEbvyWn+Tx57uiQzGtQcwDN8pU03GWFEUmhC5qXnN3iS8I5UV2dr1EqVmZPlVBlaffG8DMt5ifwSJlgxXhRsNNWupigPk8ilsBiLVtCAooVCfRmFkjrSCpMMcyjK6qNsPR/G1EoZAx7AyCuriYC9c9/co1a1wVCWqdw9iFXmRAa7dY2NF/ld3T9t9nZS9CF2ie0nFDE+qwQD/quVwaiKiRCQx7UYZN73LRfPKsFFzwBi02Vq21Rq1qtzYZb0IbtauPezqb5OsWNGc1u1qw54XDeChazWFrUNzqIuC9TnK8+Gvlzj1x2ikG8xDmkQlAUhy51x8Svfkv3/ZtnYpNTxVKDFgo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(966005)(6486002)(6506007)(6666004)(8936002)(66946007)(316002)(8676002)(66556008)(86362001)(54906003)(66476007)(41300700001)(4326008)(36756003)(2906002)(5660300002)(38100700002)(2616005)(6512007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tiYNd7FinIDdWIG3K2NRX7CsHBgntwixHjXnHh9KO5r0rzITetGoUOdROFaU?=
 =?us-ascii?Q?VnTg0YUvFV9JMh4jNZKFRgHnoIFTHoiJMztOftkRtC+U1F+q8sdNIdCj8UD8?=
 =?us-ascii?Q?+9qdgb5eN4h0k+7D2mm/kDTBz6tSCA8pUVDvIqCbv1i7U9awwzt8z6MR7qmE?=
 =?us-ascii?Q?bv5ndy1O0TzX0oVt4urKXNzVzSColskwIYd9vFaPF8EUqjPxnoJn9XJL7t2r?=
 =?us-ascii?Q?mEQB088GSoOjiIjPGetH0X+J+fkYEc+uAnYuqS9SPOIvZEc2eFT4wUe31ZdK?=
 =?us-ascii?Q?s7PPftbDnXQGS/X6z12lizvWCsxnvbLlU+L9+8kNSKZBCy294Lq9XfdULZRy?=
 =?us-ascii?Q?un02zotFhD4daKqB2Pfm+e+MpTHh1fDlz05OdTQsMy2nBqd2KNhlq0/zaz/D?=
 =?us-ascii?Q?wIEbeHZ0kCyb4GH5Vh2bmQ3dlPgcEdBr8BRCX73ZjhkI+rhm4cOBcfrwxHvH?=
 =?us-ascii?Q?qkwu5XEEmoXe3wtTeuRcfb9TsF4CAe3SRD2vk1MBNHsiRMlHx2qk2R4sk4pK?=
 =?us-ascii?Q?g5GBf0l0pODLBSw3EXKczp1vQHOH8Z9e3363r3fISRfOHT0tL5xkZf+gjnbc?=
 =?us-ascii?Q?ZwBUuxdWtP1vxiIIWqUJqm+LuNJWulRQwXuGXhQTYkL+bG8eVOD4rmYyUEu6?=
 =?us-ascii?Q?UwVlBf6VaroJXOYzhWRQY/KstbH5pHWHT1y1lPe5ZWdXlxK2CmfI8g0aqckW?=
 =?us-ascii?Q?jOc0d+IyfQSepZbX1NoxJxGrBkiTrLuTPpm3l+LZkMtsURXW3oZkIRXmuv7i?=
 =?us-ascii?Q?oP0aeFl8dePmdBgwRa4LinUo/uZ3fd/mZ1uQlh70MO2wUe7TFRlscqMQNnxj?=
 =?us-ascii?Q?ren8lCt9uHQGwl3Q6SorsxkyJADASBKldszzzwU1hGDtk527KAFFy24EHeHj?=
 =?us-ascii?Q?b/Mitui8jzYGdGEBFZ0DPXhjSC3Bxoeq+5vGv6JKHkmklGVzvAugu36Kx1xG?=
 =?us-ascii?Q?ZvEMJQPL+tyPLRj3otd/2MIBenK4CDUzCX53PMfio9Y06tNsqa+EYMB+oZOA?=
 =?us-ascii?Q?U0mFYIOp6fDAOPiWhyB+63jrvzCsQ6qe3rxqSJkjNwrtc9WTvsp3V2JNOmOX?=
 =?us-ascii?Q?9z9vKmwXpabjDz+A5Dl7e5WI6+dENASeq8OQPsZPaNIJQAx+rcLa75hTKiRo?=
 =?us-ascii?Q?HVPy90C2h2oYwdHWipabwqG7nK2zE0eqpOhtk6KN6ijGYJb5Hed6epIKCuLt?=
 =?us-ascii?Q?EtAzDrEiGIIPlULgtcbo/v7+PRLSYInJF8Jtd66wg+sPyv4nzOEPwfgv+XGL?=
 =?us-ascii?Q?u7wdnBlm7Xqug3uHxoF0ObNhuOjRg8rAtR14u4ZnFoTxhT6phfYROPjqNzjg?=
 =?us-ascii?Q?crvWqwKIeZp6PQYZpF23nv5KXaVQO4PxYYN2NI0niSxVNNEcvOTt+rmrqQND?=
 =?us-ascii?Q?mVnCMrZRHWVaSPjH86it6X2z9f9rq3ZVErbCUIwazyeu1K78J4L9lHypj6lA?=
 =?us-ascii?Q?6O6pxEzutx5TlV5kQruzCGHtZOw/FePwivbfIsEY/5Kp5GTLuJDxaAT1ujxi?=
 =?us-ascii?Q?HVDIUKszM13ZESq54oKBqtkbppx8TG680Ept+RgCbs1ZrQsoWYz9VWUCG9SY?=
 =?us-ascii?Q?p3wRTbKgwpd3ElVh+qwpjerZTwDs6DeI9c0f7zpyI6719XrEje2TEDhCGda3?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w9eco1YA1M5ZNTj5V7MMdifS1nPYPAnuDRuk9uvvD5bSOWHdSg1AMCnW0Z+OvawXOBX+UQA3dvw6BOnJqdiMZuFsaCdQq0ENPO1JdhcdsDtx9F5kzJTIKPhpHrX24v+J6BXGFBmbgT52SblTU/zg6vPXaEGFZExejxyu41p6G+X9iUrjE9PpFIu6YCtuazfoUHRYjRr4fK/xjThPx0DlCXJzTQUwe8DdVFs8UMYOJP0bWhmvx8v7zMY49tQyUv9BYheEidetjqRXbb3knayYqVI/URqJr8kdGi4lVuFx5g4PW+7j0g4pH3maI4/TYouf8cm5GQNhLO9FaOgTCiP1jmfThiaBEBDoYc9AhbnJsatgjocG/nTx6j5GUvT31uQlRCPvLFRvqnvGQBRmNkvMgwb2Y66wTHxxllXU+iyPeRTsIonse1SigZlZafwk2c7OZCeisDudTHV1olrZZGuYES2VYjcefMWVnaCF/RTTFeP/Wk8/ILp+Xx1Y18r8+boTzEwxACogHUM6SkxNhURG9aTxvlPqYpDvM5DiUjPmsdM3Siq2qU8O1EPszJcpyX5q7QSheLxAEW7UYfud00+43kCF2BPpr9yeMSb76lcHbuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16af21fc-ff6f-4dc4-494d-08dc1f6a2a81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 19:00:02.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWe+5jY2oeJeD3OZgaAy81cbSPYseOxBsgD9sz2ZyIyZsyAGpliFmSXACd0fGg5OuZnZSsjtNZne4FuQtqaIAaWer3pRjxEPkFeydTJbwmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401270143
X-Proofpoint-ORIG-GUID: asTY740gN_ABQfefwCWTp1OzpEVYWtrr
X-Proofpoint-GUID: asTY740gN_ABQfefwCWTp1OzpEVYWtrr


We do not support any load/sotre instruction with mode BPF_MSH in
binutils.  Should we do so?  What are these?

> Under "Load and store instructions", various mode modifiers are documented.
> I notice that BPF_MSH (0xa0) is not documented, but appears to be in use in 
> various projects, including Linux, BSD, seccomp, etc. and is even documented
> in various books such as
> https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Uncovere
> d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec=frontcover
>
> Should we document it as deprecated and add it to the set of deprecated
> instructions (the legacy conformance group) like BPF_ABS and BPF_IND
> already are?
>
> Also, for purposes of the IANA registry of instructions where we list which
> opcodes are "(deprecated, implementation-specific)", I currently list all
> possible BPF_ABS and BPF_IND opcodes regardless of whether they were
> ever used (I didn't check which were used and which might not have been),
> so I could just list all possible BPF_MSH opcodes similarly.  But if we know
> that some were never used then I don't need to do so, so I guess I should
> ask:
> do we have a list of which combinations were actually used or should we
> continue to just deprecate all combinations?
>
> As an example,
> https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.c#L68
> lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but not DW).
> Other sources like the book page referenced above, and the BSD man page,
> list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources such as
> https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368
>
> So, should we list the DW variants as deprecated, or never assigned?
> Should we list the H, W, and LD variants as deprecated, or never assigned?
>
> What about DW and LDX variants of BPF_IND and BPF_ABS?
>
> Dave

