Return-Path: <bpf+bounces-26993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DF8A70F5
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100961C21EB0
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4E131750;
	Tue, 16 Apr 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZwoeB8Iu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cQFelEr1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F8132C1C
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283949; cv=fail; b=uvvn0jsC1N52OPxIlK3haypn/Xp6Q9GOlIT1MUBSnAqltNToe+xLmKl5CzYDnMq/TvzAsOYeuB7g4LYnXhkxOWVTgPqTKgE7s7TBZsePyDYpNaM2fZ8vLE2kssSylMpp3iU7rFtXIVwkJg3dn9upNDCz1BEM0nh3iuIWoSpLIYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283949; c=relaxed/simple;
	bh=3ZX/wO1HAyq2vPHxcnEtF6iiKCBPkAf3GVuJjcrq1Lc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=WItOGeo+rVEU77QOgRwlX91wHrTX42U/vD0ijJMhMltAXJmKGfY3lF6Mg4Tpxzu6uiejTrZZMxkESn9tCdBiB3ja7lntRPFI0z2IfKy3ElqtRl8iuxD8auAb9VU6H8cKLNCtg5FLsO6ZhfzZXNsngbqMeCLHO6v/hDWGeJ+eaQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZwoeB8Iu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cQFelEr1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GGBX09028190;
	Tue, 16 Apr 2024 16:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=N1LV8I6+NBUVHc9LJuhkhq/bEnU489TPvv3cpZ/kbYM=;
 b=ZwoeB8Iud7U6jnx2cPbt04QPlzktpncoKGqdBfC/J/tckgl44/hgSeVGy5B0ZkkBl9V6
 5+iJNY5nfxqPMsM6lsiD3fFjqjGScY2Ed5AK0pFjxsA81C09EIcCjN6ZlKGcsAbDOmwC
 gDFE/Y43cmdZWE8lKp5IMVQ+WqeUcgvVPol7ZkjOdp7atsiv9vsREciNKjDM+kE3yF4C
 i/NgUBvpIubRPJ0uV18MAHnRJco+zno45SXrJ/VmjKy2aZsTEGLkvigD8gC0dNF3mCh/
 ZFmncZfGwi1Mu13KExlGRgN6mW4YYrzL1dzoKx2nTS3EQ0ZLHl9s0CxtzDRW4NLyCS1y bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnudrcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 16:12:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GFlnpf004362;
	Tue, 16 Apr 2024 16:12:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggdqydc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 16:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDdPi0dSIN/k0jHWYX6PT8vegTxGiz+LpuHSan64ZjcKJ+o/yxKop0XUtrKCWJhj6rvh4zFSjBZyCIwhXEYBLXN2jjfEg6rt9YHLsTM9dSJUaH2194MXpoQ7Fc8biwwJ1sZdCQIX7Ab0oMbxxw0FbxTMhsNKiD7qDDrU0YHQpqBwA47Bwt2U4cIjBgM/2eJ/X3a2CJ6xtxvZtZLpknbOotBjX0jsS2bk3N68VFdLnD2460p2juGBaX5EaVJebsKFxBbj5MtbtH69sVNax4INsjzwMbUvTEHvxEdTGvPWWXX9CLaGnKzh1Yz1CqoqCW+yJSUg0uFnTpuu9KkUF/chvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1LV8I6+NBUVHc9LJuhkhq/bEnU489TPvv3cpZ/kbYM=;
 b=my/4eR2T7iwDYHzt6R9KpQ26ZCzMBwJOzNgC2JtITTN1pGTg2GYhakI2FDqQ+GbKJhgDa71nCOSokuHXZ1/6yqDaAA5hmefqpbHQxICcLInykS5Ml4lqimhy2X1PI9iDQkYDhalpgn8KYNXSL+zP1vwHbpWj6k0wZR/PN0LHIOkj7ypnjbeV/qIl8mWWXaO662A5M82xPknrhLcWI2GPg54ThIpnwdQ0dcE7vrPbonNyZ/hMrb4W+5f5xY2qlk17VAaVqe9d5yKA75a0ldniPcKeguOLuYHQbGjBkTCAMLlDrOdEgET3Soq3PixO5hkpUYhFdkGc2OpOhJL900Z5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1LV8I6+NBUVHc9LJuhkhq/bEnU489TPvv3cpZ/kbYM=;
 b=cQFelEr1MnVym5pjBdVBtQJ16DSg+Oo0I3Rk8vklZm3luMTg1kSBxFTBx8sM3kLjfn0X03AiHX/Tfc2wglN5wqIEY3lmAgaR9p+258QeZ1VX5IsbVNTVr6rA0SmhEZH0rDQ3E/RhmJPAOr0bpSDGrbhw7vTdWPlPWdL+tcvkPhI=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:12:20 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:12:20 +0000
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
 <20240411173732.221881-2-cupertino.miranda@oracle.com>
 <72658a81-7e62-4726-9e7a-80dbc0a1ff06@linux.dev>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        elena.zannoni@oracle.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH bpf-next 2/3] bpf: refactor checks for range computation
In-reply-to: <72658a81-7e62-4726-9e7a-80dbc0a1ff06@linux.dev>
Date: Tue, 16 Apr 2024 17:12:15 +0100
Message-ID: <877cgxz3q8.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e92a07-2e95-482c-d1e3-08dc5e2ffe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7tJ+ivMHiWAuH2ki41fWTp/i24dN6N3SSHR4Hnhdv+2Ui/26xbjrg9vq8oISUY63nj6lqxekcGjXeWKWaPEccVY5dovoMOEeIh3al5LVwZirlTtyJDE/i/B9bDuKHXS4mCnazuuJwiu44Vk30QWMJPJiTJStlsWUFOMnKJBjPQYTx13T6RBUxQU7AefpYIzC3U4iZDzoYPyR/BtolUZ7t35ewjEmVE9Jt/R5DyJ+e8Le1ONxz7bo20r1/iPA0Nx3kaekZfvzkNNjyvBwzc5X8+rz8W/jJaIbt8lsIO9Kjo1fjEpoSAnfM+axRMCvqoz3zedY23LLcJ80pMbP3VxVf+NguPnSi5wREq8aXaZ07rGo58RhhpgRQqHUBkHBr/M5THCohp4xE1Ud+UKvEs7Ovv0q9CT2Ebf+BjG+ik7E2+XQJBReChZ4xc1GX+W0ttgc77BsGwdH1vd2nroVdiqbwDBx0uvGvyGN2UjhmLOnNxSxY0c1I9u5J5Babt8XsnFSELMyQNsUFHhMALtZcR5uGhRxIQyKBSd5FKcRflPb8RgMxeX8tlWMjgpvjk2gRhRmoTeWXBKDSIzcSh/0RF3WeBsAktibPncZjNt9oU/4VI0FLUx6cSfsdBsj2L73V0jNUYrmnK2sWDxHad17NfCQe7Q6Q1MvjpAjiwfCDCCGkCk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FKYLy6JtQkY6xPP0NLe88P1kYdIoFTweZ8X2ASrVTYiKxMQGz+jEDWDo/90D?=
 =?us-ascii?Q?t49QTzhsUqj7GkP/ULCb72cuiBRY3I1+YfDpOu3Fkk8nsR4nOllGaY3djkOt?=
 =?us-ascii?Q?gPCtxuh5A6+SLKjB4ncx+FTnT6WjtuOYUa7L8iumM0sZDJk3O8Oaaz2Fmx0V?=
 =?us-ascii?Q?FgCJ3Q6Ye2hfXxK3nvh+twsGr2IUjUZAsrvorup+UkO+JS1s5N2khXT0sCqt?=
 =?us-ascii?Q?nlKZdf7IS+aVBOtfipM8gtxW6FcRi5zxYKr1+mCdmDaOXxG0ZNYb98rYpuTY?=
 =?us-ascii?Q?SdpQ30mdKdUORfQsSW76GcXcY8T8UbUAhKD75fXMrODPXB9YtACMZ3XZbr9o?=
 =?us-ascii?Q?iW72fZ4R0r0pSk4D+4/cDdtGGyy2QpLYByQebqoWLt6qrnilV4mGXK1bD1dI?=
 =?us-ascii?Q?8/HpaTTA2u+UW7ohnDbXSRdUVb/n+yCzLXQ/oVGrkP8NUjcyXhxBVbH0ZzWS?=
 =?us-ascii?Q?T4WaXHi0mhJCBn9ptz12dsUr96CYkRlqqcfn89ZlT2DeSNUYDUt9TeSinSWv?=
 =?us-ascii?Q?TPzMtGWCCsW5W6D2AG1cr/5ym1vlYUCtYNposbJ11Cg+T73q8V2EVhE86P/S?=
 =?us-ascii?Q?gfRL8URMqs+Gb07ExWKxPbUTgWuTdRB6GlUKmlSLZPilT3zjE/3/cZ1yxU93?=
 =?us-ascii?Q?JSz/N24vnPRulgP02WzI51kCo9b5XbRb2MSCIn2AbS4OzZ2HN4Pztw315eWU?=
 =?us-ascii?Q?aUPnsqlSXM1+dpjDa5xexu7xKGMr5mU3mc3VuFU58L8UNmORillmQ5++tlBL?=
 =?us-ascii?Q?zcBglrGrjcY4KL7aJBvm0Qv/oUzHFsM7loKxrquw3Gi66utvIuQXPc8dtNe1?=
 =?us-ascii?Q?qEKFhavca60Tc7BT1qkAowKs5ueJ+bYgc0ZbkVEjbGsXWOZSUlGb8QT+Txm5?=
 =?us-ascii?Q?Eoe9qisaTvCwo4F80RVAHgBIOaQD0ar3tPBbQBZh5qZGkC+QarrUZhjJX0Cd?=
 =?us-ascii?Q?ij+kYkofb8qidI+8T8NHKfpYEPkI34l63/mBc3eiAJ3yPqkGB7tBy9zx6TKk?=
 =?us-ascii?Q?lzvg7z6jhwLaP1BRJSGnydyvHyl+B/HzMVNvAQqFoNb5S3P2CEh9/HidRgZP?=
 =?us-ascii?Q?HP1W1BcrrPdb2ynC7aSIQXmHI+wt9VnJS0IcFkhUSFFH50Nn1HnutXdXaFML?=
 =?us-ascii?Q?thaHZkBJE2Rx+sbJ+BRVXszfYHvmVpLutfFzigYdDElsXG2TmunLrcWm0NtZ?=
 =?us-ascii?Q?PpQizXpij3XSmsSvHZyMpjXPbNVsHeEGy3mD5bK8DOaxOCoM6mPObOMAUxQk?=
 =?us-ascii?Q?d7T+b9Y4AeNEdNvw1uUZxyy93ySNle499LmeHW95BaI8YL/8HkPNVIBwdaJx?=
 =?us-ascii?Q?mzMPs0sHkz7m5FFCtmpRTjcEegZ0xNHCa6QW3puMDvLBpC2SuNk2Y0WLQEPB?=
 =?us-ascii?Q?m6vzFYwaHVSADLKv3NEkJ8/m2TM5S43Nd2fcX+F9grF94+QKv4s7/dDdgg41?=
 =?us-ascii?Q?YpyxU9XaKC/g5McTB39R47sSCRbE6FuE7jOLvLKu3m+a6+PD+m/Hikz0ZfOp?=
 =?us-ascii?Q?n4HkVl3Kb0MVEy4ti3MispawjQyigZk+ri8nY2FrfjqFnApFQnAHcndbWjI1?=
 =?us-ascii?Q?tvGCzR1E2169W/dQHCIkrjEWQJNS8OpO3W6dj51bw1+Mv/cEgM1kyiTsveBx?=
 =?us-ascii?Q?sndgLjLCFnZDFALgoVdfL2o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h7zcCns5zWtmQ950P4ev8O9Or1F4ybom4USc3esObEpZV8B9xTPuU79Z3tGiwys7ihXndvtEWdt8hyx41IsewrS2DsW56jyI+3Z2SOWLRDL7Ssi9ZTG/qvXFQwZX7pavI257m88+JB3tp15DThfzithxffYX/tj9/nPueq70Wpw38MnuU6LBpHabWfiEsdiOayEqonfcRhHURijI3zXfRGqoccW9hpnb3i2dnqDF07KjftuvUuPykVfwa/voPwJOYS2dhMLOob28Dlmv8rcskPfcEe7gLdujCIr+LOeSI8ac8cV5YeM08EwCjoEn5AqiOHZoRn+/m/FsMIIVEMaCjkhIv8jcUQED5Xf/WgV0YQZQWlje4eMhXxU2tFnlXLA/exQ7YIjgm7MqHgArR1cztvppUCS8ImhCqjDM3bc63DTtRdjj1UD1ewldE/gPvLT11cjA4OqJnVjM/l/BLlRtLn+OiPFf564+5cQxeTIyFmSimiBCrHewsHK6mpsSYa0GFnR287ZrAM8Ub2xy65a9gpGW+R2ZfTRHeS3aNiVnqBGsSQ6Xn9lAQon469kiA7IXfBkPwiEAnpeHAyP41QuQNhTDbvoR0N+WsvAmSeMpnv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e92a07-2e95-482c-d1e3-08dc5e2ffe45
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:12:20.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wvi2U7EdyilEZ5MI9dKEk1acGh+LnV2hh4/K8s+P3zWlGcJbJw3tlKuy7jgsGgm00z2xS29dT1OdJ0FaptmCbJGy+i13zeYC3+1n4ARUvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160099
X-Proofpoint-GUID: N5gjqyYWvQkHaRYO4zTUcM1FcL0xqRLX
X-Proofpoint-ORIG-GUID: N5gjqyYWvQkHaRYO4zTUcM1FcL0xqRLX


Yonghong Song writes:

> On 4/11/24 10:37 AM, Cupertino Miranda wrote:
>> Split range computation checks in its own function, isolating pessimitic
>> range set for dst_reg and failing return to a single point.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> ---
>>   kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
>>   1 file changed, 77 insertions(+), 64 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a219f601569a..7894af2e1bdb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13709,6 +13709,82 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
>>   	__update_reg_bounds(dst_reg);
>>   }
>>   +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
>> +				   bool *valid)
>> +{
>> +	s64 smin_val = reg.smin_value;
>> +	s64 smax_val = reg.smax_value;
>> +	u64 umin_val = reg.umin_value;
>> +	u64 umax_val = reg.umax_value;
>> +
>> +	s32 s32_min_val = reg.s32_min_value;
>> +	s32 s32_max_val = reg.s32_max_value;
>> +	u32 u32_min_val = reg.u32_min_value;
>> +	u32 u32_max_val = reg.u32_max_value;
>> +
>> +	bool known = alu32 ? tnum_subreg_is_const(reg.var_off) :
>> +			     tnum_is_const(reg.var_off);
>> +
>> +	if (alu32) {
>> +		if ((known &&
>> +		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
>> +		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
>> +			*valid &= false;
>
> *valid = false;
>
>> +	} else {
>> +		if ((known &&
>> +		     (smin_val != smax_val || umin_val != umax_val)) ||
>> +		    smin_val > smax_val || umin_val > umax_val)
>> +			*valid &= false;
>
> *valid = false;
>
>> +	}
>> +
>> +	return known;
>> +}
>> +
>> +static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
>> +					      struct bpf_reg_state src_reg)
>> +{
>> +	bool src_known;
>> +	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>> +	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>> +	u8 opcode = BPF_OP(insn->code);
>> +
>> +	bool valid_known = true;
>> +	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
>> +
>> +	/* Taint dst register if offset had invalid bounds
>> +	 * derived from e.g. dead branches.
>> +	 */
>> +	if (valid_known == false)
>> +		return false;
>> +
>> +	switch (opcode) {
>> +	case BPF_ADD:
>> +	case BPF_SUB:
>> +	case BPF_AND:
>> +	case BPF_XOR:
>> +	case BPF_OR:
>> +		return true;
>> +
>> +	/* Compute range for MUL if the src_reg is known.
>> +	 */
>> +	case BPF_MUL:
>> +		return src_known;
>> +
>> +	/* Shift operators range is only computable if shift dimension operand
>> +	 * is known. Also, shifts greater than 31 or 63 are undefined. This
>> +	 * includes shifts by a negative number.
>> +	 */
>> +	case BPF_LSH:
>> +	case BPF_RSH:
>> +	case BPF_ARSH:
>> +		return src_known && (src_reg.umax_value < insn_bitness);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /* WARNING: This function does calculations on 64-bit values, but the actual
>>    * execution may occur on 32-bit values. Therefore, things like bitshifts
>>    * need extra checks in the 32-bit case.
>> @@ -13720,52 +13796,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   {
>>   	struct bpf_reg_state *regs = cur_regs(env);
>>   	u8 opcode = BPF_OP(insn->code);
>> -	bool src_known;
>> -	s64 smin_val, smax_val;
>> -	u64 umin_val, umax_val;
>> -	s32 s32_min_val, s32_max_val;
>> -	u32 u32_min_val, u32_max_val;
>> -	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>   	int ret;
>>   -	smin_val = src_reg.smin_value;
>> -	smax_val = src_reg.smax_value;
>> -	umin_val = src_reg.umin_value;
>> -	umax_val = src_reg.umax_value;
>> -
>> -	s32_min_val = src_reg.s32_min_value;
>> -	s32_max_val = src_reg.s32_max_value;
>> -	u32_min_val = src_reg.u32_min_value;
>> -	u32_max_val = src_reg.u32_max_value;
>> -
>> -	if (alu32) {
>> -		src_known = tnum_subreg_is_const(src_reg.var_off);
>> -		if ((src_known &&
>> -		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
>> -		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
>> -			/* Taint dst register if offset had invalid bounds
>> -			 * derived from e.g. dead branches.
>> -			 */
>> -			__mark_reg_unknown(env, dst_reg);
>> -			return 0;
>> -		}
>> -	} else {
>> -		src_known = tnum_is_const(src_reg.var_off);
>> -		if ((src_known &&
>> -		     (smin_val != smax_val || umin_val != umax_val)) ||
>> -		    smin_val > smax_val || umin_val > umax_val) {
>> -			/* Taint dst register if offset had invalid bounds
>> -			 * derived from e.g. dead branches.
>> -			 */
>> -			__mark_reg_unknown(env, dst_reg);
>> -			return 0;
>> -		}
>> -	}
>> -
>> -	if (!src_known &&
>> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND &&
>> -	    opcode != BPF_XOR && opcode != BPF_OR) {
>> +	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
>>   		__mark_reg_unknown(env, dst_reg);
>
> This is not a precise refactoring. there are some cases like below
> which uses mark_reg_unknow().
Oh, right I miss those underscores above. :(
Will make sure to cover that.
>
> Let us put the refactoring patch as the first patch in the serious and all
> additional changes after that and this will make it easy to review.
>
>>   		return 0;
>>   	}
>> @@ -13822,39 +13856,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   		scalar_min_max_xor(dst_reg, &src_reg);
>>   		break;
>>   	case BPF_LSH:
>> -		if (umax_val >= insn_bitness) {
>> -			/* Shifts greater than 31 or 63 are undefined.
>> -			 * This includes shifts by a negative number.
>> -			 */
>> -			mark_reg_unknown(env, regs, insn->dst_reg);
>> -			break;
>> -		}
>>   		if (alu32)
>>   			scalar32_min_max_lsh(dst_reg, &src_reg);
>>   		else
>>   			scalar_min_max_lsh(dst_reg, &src_reg);
>>   		break;
>>   	case BPF_RSH:
>> -		if (umax_val >= insn_bitness) {
>> -			/* Shifts greater than 31 or 63 are undefined.
>> -			 * This includes shifts by a negative number.
>> -			 */
>> -			mark_reg_unknown(env, regs, insn->dst_reg);
>> -			break;
>> -		}
>>   		if (alu32)
>>   			scalar32_min_max_rsh(dst_reg, &src_reg);
>>   		else
>>   			scalar_min_max_rsh(dst_reg, &src_reg);
>>   		break;
>>   	case BPF_ARSH:
>> -		if (umax_val >= insn_bitness) {
>> -			/* Shifts greater than 31 or 63 are undefined.
>> -			 * This includes shifts by a negative number.
>> -			 */
>> -			mark_reg_unknown(env, regs, insn->dst_reg);
>> -			break;
>> -		}
>>   		if (alu32)
>>   			scalar32_min_max_arsh(dst_reg, &src_reg);
>>   		else

