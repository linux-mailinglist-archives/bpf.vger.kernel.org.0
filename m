Return-Path: <bpf+bounces-28542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C14F8BB41A
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED521C2128D
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE821586C2;
	Fri,  3 May 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPMQgt3K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b9olNSXy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A26134B1
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764810; cv=fail; b=dEAS6B++0R4RfUG7gIcp2pYrPK0Eukbx7OHrhgHrUqlKyusloxSolHBdA2hn7LJ4qpNfj7OopSagoSXpODKoSd6Lg9EN5US6YOE4CcUt/LUBBnssJKV5QtHOy5tmd6lTps/LYoMpAFprN/TqjNJu466wI9fFc1YphyriLgq/bjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764810; c=relaxed/simple;
	bh=Zf3uIl7d0bQHGolqS94VqxUEm2jm8yQX9h+U8L/5DWA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=GYAA8AEC56zn6gXhXeducLXql2KyLIZ/cdtzTKzuCJd4xwcqt0GBQixlM3qXn07sOy9X8cvTvqOVDXtS5RR+YAL14JvGGWP27HxCVIjLrApsQhnPg23M32bDV6Q9owKK5Fp5jCMs+N5xL2ECjWC3xMRy3/L1YFgT66xo/ZL77Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KPMQgt3K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b9olNSXy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443H091i027897;
	Fri, 3 May 2024 19:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Zf3uIl7d0bQHGolqS94VqxUEm2jm8yQX9h+U8L/5DWA=;
 b=KPMQgt3K59uhHNBZgldJ/+dN0ROIj92LBlpCV1oXGeigEx0VEfK2FNmuvF4wbixNuYWp
 9YSq34g90fG8Sq5/TulYJlyz1JM6eF/4xMXE3ihSqP48OhBj4rek6P7BuURX0bt+Qqsb
 J3zBZWfIUD7fe9fMP1cRCY7JtJiujlma2UVgElP4E4sOQyh0Md+8wZM5Q8gwwxMzaAkk
 dbCxDqJRs4TKhSm1bj7S+Tw0MYz/1fE2qWORvTC2sJqDv+jGYhbsXyhFbtAOurAPXqoH
 gt3/01/u4F8t+NowIxFwpSk6EuNb1GOlXcbkmay9utoG+8skEg+dRsQsH/Xdoqtmyvvd PA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54skpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 19:33:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443IGxpo019914;
	Fri, 3 May 2024 19:33:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc918v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 19:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I71C4LpTbjDrpscex/kQFpxOiXknHMIZEfyWOgUcYlnefiZBbkzZ8SJdwhKi1OrZgmDPbaXRoXlXXC2g+iRb/3i3AELYzmxyEDsIDXMJfKfKfpmXE8/2NWN80s4Q36aDCSoTUhNsLWixZJ7MOJsWFMgW9pOXL4a5sHhwrAIJRGOXaBTRIFCl2UCNPxnQnlmHEnPMzzLk1h3qEXxMLcV5OJJWwQcnHfjeNgVyrvJBYmb2PeHYm9hTuFjTv92r2BsXbD8ctGIEeuSaHKhYSxPqbw6rohHJXRdgxvzG7PjP/IGwWRruJeK6nsI2kRtbAAVaydJr2Z61Y/6H+xO1Gx/QDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf3uIl7d0bQHGolqS94VqxUEm2jm8yQX9h+U8L/5DWA=;
 b=iQ8tuz3dDO4t0FxYhSQzOY7nX1yKAS0qWd4FqWXFBNjMReSMu/d0MuUib8c6w3ji5JdsmkDnbA1ZZWLpeLsukwXw7ai2rlmnvlOk9ETxzfC7b6a6d8YnuxCHTv3R0eXjs5SWHBsYlAsBsYfZFQIkgCCnZWZBUmVtkPL59nbSk9bpI5RwgBwRu51vKHSKjy2loX3ufgPI1r11E3SdxmPktCSrRAoowb+q04QUuGQay5mcyo+f5lUEnacxyO1vcnCzZSZ/nnaGW8Xk4lon9WvLZrh+vbPDFlnOnhkfkRvV4aBP48bLyXPqDRTfeQbJXLJqhql3YOFFbIq++ysR/AEMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf3uIl7d0bQHGolqS94VqxUEm2jm8yQX9h+U8L/5DWA=;
 b=b9olNSXyFaOCikwR66U9EV7uWL/YahnVYKfwtNZpnZtJYsfoDMhnkHg195zVuXn1A5zr4oOrIZzbtKTkdYtBPmReozadTsehjquEOpcragg4gh4p/sA+zmqt2GymSImvDnpksr3juIpRE3MhyF2i/uCc/28bggNk4pdO+cpxzeg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH8PR10MB6671.namprd10.prod.outlook.com (2603:10b6:510:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 19:33:21 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 19:33:21 +0000
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
 <87ikzvt22v.fsf@oracle.com>
 <CAADnVQJa9h7fgyHN3sbgpPrV7Kk8O+N2NVL4pF4qbE5xf59M9g@mail.gmail.com>
 <87cyq2u9se.fsf@oracle.com>
 <402d482b9681aa29f0714d9855a3348a78751343.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        "Jose E.
	Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [PATCH bpf-next v4 0/7] bpf/verifier: range computation
 improvements
In-reply-to: <402d482b9681aa29f0714d9855a3348a78751343.camel@gmail.com>
Date: Fri, 03 May 2024 20:33:17 +0100
Message-ID: <875xvuu1vm.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0634.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH8PR10MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: b43ef4ba-b017-4c89-6c29-08dc6ba7e43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KQKqWqZGe1+BhEVOpTFkqtSEnWJ2GNEnfv4V0kJHX41+ce6dfb5SFVOTINHO?=
 =?us-ascii?Q?G0gMgCx7tqSpcQIwErgUPf6GpEM6IR4l3vYD8d/FEuYrQi6CyObVxXdfrnYq?=
 =?us-ascii?Q?JaYGJU9/OJe9EJIkVHcz9cA6vHP0rFyGfiKc70ZyXGTvSIXPURFZt9GK77fm?=
 =?us-ascii?Q?XMhHN2w8d7IYfFH45H9nsdLgjJElqYrFpb/LBMmprNerFZOUWx59Ol7bqByX?=
 =?us-ascii?Q?h3TykY5C0ntQ/oMK7euAfCHWVdVpiGhilKsTbyxreWRcSWBcHUoA/nWCGvEq?=
 =?us-ascii?Q?96u6lwqqNeuqNbbGtenNtrGI8RPMdyi94qKczw0JvEDZGaO/Hs4ND//nBMd3?=
 =?us-ascii?Q?WkLuGnm8G9GQyapC07LxY4W/jMtZZEmKQhatMr+SRZaiehsYUSy33jlk5MVs?=
 =?us-ascii?Q?E6amT6ngCr5PKpvl9L0smPCusidJ97Yr/UkBePs1ATbMdYjX6cIq5gSETdNy?=
 =?us-ascii?Q?4Wp+D/Y8+v7vnBELcDTIiGFYGZZZK9EAvlPLDUKGF9n2oWMv6vbOfVI3siBc?=
 =?us-ascii?Q?A0OUFWaNfqgVOHhemqSkh4YRWXup3DuY3UH1YHDiNQuqg2qH/jhrekseXCGn?=
 =?us-ascii?Q?ngySVCYvn0z28gFIe6jMCWoarr80AgKRX47w0Eiit/xkWiCpNEPZ0yYDc/ke?=
 =?us-ascii?Q?X98Mig+wolp7YfImO5cyL0kiCU09knRJj1PPJIiLyoA/iLMnTGLBs++ainwV?=
 =?us-ascii?Q?Af9bp3kiLvnUz2JYxuMqd88lsxK607Y5yfTSkVMKh33gYq6qZI6gwQw0Kqww?=
 =?us-ascii?Q?fClMff66UpLtLg2HiGWwrZRPxhJ7zjTI1X4xSGT3Onke8udwv9ECtgTjjSO0?=
 =?us-ascii?Q?AlibObrlpOdPvVDh33F1/Ab0c4p1JdLyZie7DKUnnFUWANcbIhiCprO4fqOy?=
 =?us-ascii?Q?6xvdhuApG1npQIE8hFNQi7mYxlcy5adL/sEB/gEoU9yCup7B1dvnWgNuT2mE?=
 =?us-ascii?Q?nH0GfyWP2y0EhLg8iMD5u5WXQfDYmmci53Lq6ROulTLfZavJMHZI0AZCgh7i?=
 =?us-ascii?Q?hIijSzD0XHwEN9Q3lYF4TJjosAen5AL/1x3dg6s4scJ8NVsw+19jvo1Uq+7m?=
 =?us-ascii?Q?7e0vnodb306aJlP7PjxkQ6+tOE9fXcvW8wY6rncfhgecgOedh6DfwcZWysDb?=
 =?us-ascii?Q?gILF9szqtI8hXxGqdQM/zcHKDI0MTZPRhRo53GGLl7xuJoj266lH3cqjElE7?=
 =?us-ascii?Q?EAMleQRxScIjJgBmLydi7ysteoydXXkiC1XlENiItxriKtL2dBVd7tgZXYQy?=
 =?us-ascii?Q?w/fIrLw6No15I/xC4xviJxXxg/QwKN0azRP4WKBOXQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LVteKUDn4BNg8FIXvWJ24DTGRQ6VK8Us26aG3UFJ01MMFbJLMZuZMZWYIgZ6?=
 =?us-ascii?Q?f9goAq2+hUFCLvVnrNLhxqvEeMROwo5jZ8QPS2du4lQHMtxhCSbdcS1hoehi?=
 =?us-ascii?Q?PcgiCspiJek7iu53tHLHsh9MdVCFMT5XSDq470g21MvWvNu0xesyU6M8UaCD?=
 =?us-ascii?Q?yuo0j9jOrf4s7mk010vVkZ0uCd+0tUnmgDZ+7vnOOzLoMV9BL7XaygqYurVF?=
 =?us-ascii?Q?qdY/PWJAD281Je2i1FLDg9idN7T6cDf56FbpPq/mxBP08zycUYblzIS6mFzU?=
 =?us-ascii?Q?TrRLtBkSSuWjp+F09hGlfadXxHLa/dDmQ8WLbvZ7jeS37Db2fiSZYpiBu2es?=
 =?us-ascii?Q?PSW2rOnIj3TgsBTwLZvY5C5HuZYJby5xWfOpqdcmutqQwd8DGaAfKsu9tdy9?=
 =?us-ascii?Q?z7WIymMaoMKao3T2lVB1ZjvPoYfCkSiP/t1sauvEZj5pme+EISvZjZFui1ZD?=
 =?us-ascii?Q?PCEc4BMNoIXq7qTJEFUsqVGjZKUtpxqJl5OBtTP+XJbKLuStBrxcC11soXBy?=
 =?us-ascii?Q?sSPrGlMLGHzI+EsMRorGkgd2R4+LIGvTQOqNdv4UCKsD6UgWnr3MVhdq7zaA?=
 =?us-ascii?Q?NXmM2P8AIlKK78ekVGry0CdLw4WEJmXOEIJHVS8OtFtwg9RI3IFjS08hhNw9?=
 =?us-ascii?Q?+Pp01FzLnZO7Wv0L40Qsohx/c/kGxvNtI0wh9x41CGvq6yhfXk5czF3D6C8/?=
 =?us-ascii?Q?Q2pdQDfz7Dm7NHIaJhmFsUoKmj/uEvMDw3yheyQbEpSz7OjVhtytp8oa2yri?=
 =?us-ascii?Q?tMsHysUUFgiAFwsxGtdiBQaCa5da+w29LHzO2f0JhN3n6zzVfZm+yU7qJ9km?=
 =?us-ascii?Q?suHCrdkBPzISJQKlaVbIKJzXXFjdpIOCLPWNj6n+5JXxYzuF7IqNxwZzY547?=
 =?us-ascii?Q?C2S+AFX4gPNmaDotUfoKIpeXixF8q8F0bNm7sJCZtr1dDGHdtfifJwTllhdi?=
 =?us-ascii?Q?/wrswe5zHvWIF1jP+kAzNiFLROQJbEpoaUGaS2DST1m25AUj8Xq8+OrE6wHh?=
 =?us-ascii?Q?rXK4s7w9diF2HlGM13hVRGDU0zPxAfJ6fhnzNEhV4yuKK87doxknAQmSsbg7?=
 =?us-ascii?Q?sEmRu0V/Lzso/TCrUUcA/VerDbQdIDJNRNrUckVFJcI3OIOS875EqWbgmYAN?=
 =?us-ascii?Q?YFCS8b8Pb0o4TWx3A3yuGioiHqsRNhHWdN8ZFQYXTJGzQGpA7bZkZlcZxerJ?=
 =?us-ascii?Q?0FhqxKJfP4RwhsanZL/V3ffJM8otNPNNhogyTePb3gzhmaQjHbWm8oahpvOl?=
 =?us-ascii?Q?87TYw8MMySCq8ZaytfXvK3PJKY1rATgasX44gAsUcob1M2GE4BQiqh3DxzPf?=
 =?us-ascii?Q?oFVgqao8Yr2D6IBzxUFjWCm1ybcazZUUMKpra97qRcUMiL4u1nxxtkKny2wX?=
 =?us-ascii?Q?3+wso2jVxHnElNEWYQPFq4DAoePrztoNqWgy7GSW3ToV2SyFsUTcLyaucY6y?=
 =?us-ascii?Q?VMwAR3mHZewnNdg4mDLVnSl54TVsMEUNSkD6HkQZMapXS0dgp9eKOP5zJg92?=
 =?us-ascii?Q?hkHrIny9UllkD3RxaDweydOBzPlcRFOEr+Er+crbmPs6ZHChzQV1FldX34xI?=
 =?us-ascii?Q?SmlArOuXnl3j9KOqT8WlomZo1KOzFJ8Ijxb7M/bV90KfzMX7Ke1wIstBwvU4?=
 =?us-ascii?Q?XvpXmyzhQrULIqZfxCW1/04=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BZI6WiHhfWmR3J9tp7kiJI0CNNksEtnWbWqN1UX1yXV9PTSEOBiG7uhb6ZmdcCTXlK98VTL7Ms5YZLEsyTOx+ZvD+QVCe06au4WCgzlg2lRHiJiGqlAUIvWHXVpP07CDv9+RJ1jIgPWu8/xJTQtgcXCeL8pWNGjouoH//odF03RV5j8D5UzNEhB01y3gHp4DOFEydEvkTq/B+Xyq1Sof7EDIhBh11iKX+e0FguYlq9rjtP/VTEyms/ZXpvzA9C787f1yGIhtXqocFsuDZpHfR9YUT6F/OnD6m0B96UlfSg4HCksPoscFr4B4qhubGtF26G1IZesoTyNL0700M7q85mTTfe2TUAk6tMshFiSHKLR5UpOoSUgKNQe3kKJPSVfCwhkEhfzUq6v/UhW8N6mK6ep0gzKDTuNSPVubLffKwG6ML2BWouMmEBmm4LuY/m+5J9O/V/fXVvcf34Q2gimuGbBXRWE0RHGemi8RipNc4ki7mEk4BP0MKmXuDhxBIObbkvpx3NHDjmrXAGmi6e0WEw/4fKTLpuF/XFD97l3TvZ/MhcFS2E3dJaZoECmrepdyZxlYQ2G8CAAixs68gaU+dO7Qm78x+VC/dq/bRa/uRhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43ef4ba-b017-4c89-6c29-08dc6ba7e43c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 19:33:21.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zQmN4Qe/0vfdJXD2DF10Pefij1HrOq6dq74EEaKNpEyAVMX8ndZTX9WCEFEarffn287HTOgW4ZBoCkMHJBtI4lmRdFfYuS/ExWfOTZRxB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030139
X-Proofpoint-ORIG-GUID: m_uYsvx4MT3f7QHApyGNkFwNlvq2Aj3M
X-Proofpoint-GUID: m_uYsvx4MT3f7QHApyGNkFwNlvq2Aj3M


Eduard Zingerman writes:

> On Fri, 2024-05-03 at 17:42 +0100, Cupertino Miranda wrote:
>> Is it Ok to reduce all this to 2 patches.
>> One with the verifier changes and another with selftests.
>
> Hi Miranda,
>
> I think Alexei meant that patch #7 could be moved to the beginning of the patch-set.
> Which would simplify patch #2.
> The main logical structure of the series makes sense to me, I think we should keep it:
> - replace calls to mark_reg_unknown
>>> do equivalent of patch #7 here, remove unnecessary checks <<
> - refactor checks for range computation (factor out is_safe_to_compute_dst_reg_range)
> - improve XOR and OR range computation
> - XOR and OR range computation tests
> - relax MUL range computation check
> - MUL range computation tests

Ok, I will reorganize the code for this.

Thanks,
Cupertino

