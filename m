Return-Path: <bpf+bounces-27930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFB8B3A68
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA231C241E6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4DF14884C;
	Fri, 26 Apr 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKbw9uwu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u/6iz7lg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46427148832
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143132; cv=fail; b=Oo1XXUQkoZiwrRJp/Wp4TuecqDLgfOKGaowH7sRVvItFZ6WS1k3jAnHJZs0MCw39hld1BJmmaVaJiiA/nz83ftggclmpv+n61PsVE+ZtF5Lyr0UDpysvDQDbETXDmGpuY7tB0bu8pcjuy9iaXCWX426yao37eiuM/UbM8I7jd5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143132; c=relaxed/simple;
	bh=fxtwW+JWtUTKi0qK5R0b+c2du5ubAvgH6sd0QA4GXPI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lSz+swXfgikGpXwjCEIC+zBhTkoMmS7xDySDqo4C/xNBXTL6RuXisgUBVlCv++jpYRvyHaGqAmSUhQlfpwbHE+u4xux2LKdqKfId4eBmqThnqjYcrUSSAhzSjYuBdV2FDluEcTtp1En1yEX+nWO1eMniGtfe2oz8XLW/vy2N8Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKbw9uwu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u/6iz7lg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8SmFT031056;
	Fri, 26 Apr 2024 14:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7KHZoD8gLdwnpgFtG+CdZ1Z+F3fy+j1GDbLgetx2a0A=;
 b=oKbw9uwukCSOl9qq7Ctp/r32I42DQSdgnfZ0ik8BVV40istaPYsB6NeDf6GAVjjPbXCP
 Zd3DilFtFs4DQiROx04T0a7u59Oo9mIjnlq8yigXFGD0VcbkYYU708Gcs9pXnSEFaLDg
 i3JEk3L3s5p+mAM36Q0NmUCkeWy0nbaPxbN2cXZKqkMbuQ5+GbfMsauMTUzRgPWBRsHF
 +m3YeNtb35FpVYCzrjEBHB7HYrmGh/Ggnnlc41nO/3jxmwPmBMcyBkq4E4JjQzxyKvEj
 HTEW7pJT0cugDe6s7YCyGcJCr6rfNJr+HsKOLatcR49+7PtTKFQqRbdI4ZDB1Oc8xujV QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5auwm0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 14:52:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QDLWXW001866;
	Fri, 26 Apr 2024 14:52:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45cgg6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 14:52:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bve5WemPTWC04cT+DS1xpjx4dDmBXsmjghXZzsu9or/ZkopJni5IEGQz0TPdX/cCdyHtsBxqFqijtPWmXkW+tSwE9LjOix6xtET7n71vZM2f76p60GZeNWGnBir8nCw4BjpUV+aM6r5v2AdVkr9og7FMbmtd78BPn7q/t2yu2zTfEFrUZrVEgNCHaHJjHicOr4Q5J8/stNvY0c1j27+rcfK/cm2jA/hjuJQr6XSv/SSuIU+9T5BrEwAGsgZB2MNVft0K86OQksnX3Jfgq4bBUuAUjTpyeGreTgzdoeo/peLxE7TnOBQujuSO3zzPIlEmWT7DULazB+r2HMelVZ2+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KHZoD8gLdwnpgFtG+CdZ1Z+F3fy+j1GDbLgetx2a0A=;
 b=B0vCWNjOKg/41L7ctUUtC8MvY0KY4QFL44YvDcvw+PSodBsrds2IPAD44KVqprs3gxxyKB4GLHvlY3tYO0sJ42v805/XcXC1Tbc+ZRyHR2rhgXo6PSQZiyPv+WCfDjkfx4dw5pBjGYS//eOt86iGqTT3ySTwl0H48nr1mal/gOYvLFzgijuaJpCQzQO9BvL89WKITSarcsaGpTBj2xK4K/rzqgXmV5+qqbtsvGC1K+Ktyya4TLhEtyeOZKREDPkxzFIBJU405yoWc7tU8LXyp7d8DYauBrIIy6U4fHHQRm0fcodtUB0JHyw++QwbkH5Gq1RAkm04BLC9KWaoX7CmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KHZoD8gLdwnpgFtG+CdZ1Z+F3fy+j1GDbLgetx2a0A=;
 b=u/6iz7lgfu6V967YkMj1683ar9mwh+BHQ9dJ6VG7VZ0SATl/V3JqaI4NN7FjaXiOxCyjYmpWVnIXmQre2GvIsM07uNf70K65+LVRmm+TNlPUfKKpQ5EiNkbCOSi+cxc4FIjTiMmzaaGmVXySDaJ6aNbLyDgkeo533wO8XChqGbA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CYYPR10MB7568.namprd10.prod.outlook.com (2603:10b6:930:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Fri, 26 Apr
 2024 14:52:04 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 14:52:04 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next V2] bpf_helpers.h: define bpf_tail_call_static when building with GCC
Date: Fri, 26 Apr 2024 16:51:58 +0200
Message-Id: <20240426145158.14409-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CYYPR10MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0408e2b8-2924-4ffc-2280-08dc66006faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XP8sYBeUm1mka7pSRUKiyKXnzUUIlJ9jQpTK9t08VQiHa3VGQ2NG4s2k/AbX?=
 =?us-ascii?Q?8slxlc9DvT25kcK1y+H/SL38Ko3yuYqbLW7zv5u7nLdPOBwHUEM3nQZLalEK?=
 =?us-ascii?Q?1Dhve0A3DQxGEmTZ0UXHeI2lOE2xAkwHE5mYMacqbIQYDJ8eHT2Q4ywGMOOA?=
 =?us-ascii?Q?kuTXyjSDV3tw5Fu9nFLb2GVzKQsavcUF7GKMY15BCwL2oShuCmduqW0GH4We?=
 =?us-ascii?Q?uE767L2LSujpWwCfrTNNEE3zTueqZ7kn9qlTxzehowlgYkTS1IoSUrORjjFm?=
 =?us-ascii?Q?Pg9QnhI0QTarYV5uPobKHpeXvdeuYVbhDKz/N31jrBaOlhx2q3TCEObq0E0p?=
 =?us-ascii?Q?9kLZp5lAIPnftnZMPOqCrRlFD6trNKoNEd+iVdf0eo33A1HYQvJ4TVZsLKPH?=
 =?us-ascii?Q?9pe8sOeLY2hAJhdL6oHmNvtfxEAS4xJIAcrohtEaPEaj4p+ZHWN8CohtzgNy?=
 =?us-ascii?Q?ZWlrrGup010120gyUTZGX0Tfbo7zjLq6uSf/wV616+6mhItodV75v28RPRLV?=
 =?us-ascii?Q?bmUR+vhJ4fOYjW8dXcH22DdpDPWzX+lwCVHF43zSCRnQNiIMroZMvV1yl10K?=
 =?us-ascii?Q?ovD57kI/0yt+JUTkoBf7kqNL5/4ff3XddzymOrrjMIZg/QeSyA9DxQy1Bk73?=
 =?us-ascii?Q?lFjcc87azQaxMHiTDSG676AIb6mEKT1H2yC9S56MH2Rjf9SlupfQNIsSqzmj?=
 =?us-ascii?Q?nrviXElOX9UgPx5qPbO6v558y3PStbPWWxyLjwAXRwX9EO933jSP/rouyWU1?=
 =?us-ascii?Q?DTxDYK95GiBADQ0PTVlJrkF7sbwlMpPVsNV4EmmXlLul0hxVaUwl1ZqG8Yfz?=
 =?us-ascii?Q?ACsDdZAdkFZp0cvJZJp9h6hchHta0aVc4dkx/iiXEFrFQhkzGfVuUz7z9wty?=
 =?us-ascii?Q?KA6olSeNB2R/mPkdjrjiQsHDDP/Ebp5YywLKnUJ9mSmBIY5H58gNqRf+q0yU?=
 =?us-ascii?Q?3FpVtnZygLoneeVOUaI76vwmAHxl0nrY7ZFtcTqZpunZWmN4z4NGTFHlpQ4R?=
 =?us-ascii?Q?ptnbJsWNLzcqcsuSU+xhbenvZeQbeHG2Jfjt7O8uWhUoCbx4I1ImXDR3YkQg?=
 =?us-ascii?Q?BsxxVgLcBwibf91GHQIoDzUO7oThju/rVI4GYYNcqOHy5/7PDosQ1VJ9Lkyn?=
 =?us-ascii?Q?e4RF87k4JB1Se+Lews8JIDILZ85dCRsQ9z5nn7CEnEEpOn+JpAN9AeRd6EIk?=
 =?us-ascii?Q?2asih/REJuLaCMD7iXsQcg3RKvoigKdayR7umsCN+tqgdlxIcdWatS3/8K/G?=
 =?us-ascii?Q?CUdRwyqk1ZnS/tbsryR6jd0ls+/dk/opFIuuDLIrDw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NuoA7bsn2YR6GzMlqiWXAoEXDvkxKgFD31PtQk0bVjGN/3D01pAgoySkhmBi?=
 =?us-ascii?Q?Cp0lelibn+96MmlukC+UK6vQN8kKMpntwwxhWdsTDB8xmA+HEIqUJxTNBoWq?=
 =?us-ascii?Q?8f0sgSg51ZMvtehsDEKHQFQwNoFcLELVl4UIfs4FLYZSni2aHn3BEdFipDvf?=
 =?us-ascii?Q?CEadFjDUsKHb0vuhV1/YxwfyGZ0aDPN7lA8VbKTZ9plTTThPKeO+DdLZWn27?=
 =?us-ascii?Q?8fOtDOV6KIoslFlHSWHkSEFiX9bypdS3oneLdVdDs43ZbfNp2KFXYfBHEb9v?=
 =?us-ascii?Q?YrTIF/4wl+06qqxtLqZQ+71WSLd0KunGFyq3v8SN6y1zmXN++Bdgapyhs260?=
 =?us-ascii?Q?DWuh+CViaTsEsUEdyIqapt3DEkeIbLpCfOGFBW90hCgU2P3lDQFvXzn8F/gk?=
 =?us-ascii?Q?Kho9gnJB5oMr5GKe38V7NqUAveQjbSNEZ1DSeBRvdxy0egTYFfyE0E00joEW?=
 =?us-ascii?Q?FIAb5lWU1Dfy006cROXUdg+16vElBi9ZLh6cSAg5JZY06eFEyPHMQ+QPH7PI?=
 =?us-ascii?Q?JtlfzyX5TksspdfFkWGp74CeUKw4rQ0ivtEH+JN1G5YFnrrK9+r6NSnJE57B?=
 =?us-ascii?Q?36EilmyVO5b0M1JleZw78ia5GhIeHwM+IE6Jg7+f0uBxYrGW0OA7OZJy/x4T?=
 =?us-ascii?Q?ug5JYr6ljzqsRWl1VjGOJi/OqeMPE61VE0wnOMusdKq+NqDMAjSucU8Ht7Mw?=
 =?us-ascii?Q?1k0HjLFzNNXCvZ17yRLwOZsPNDOmWP+0Pp41LhxhpEVpjzoHPVaVQljf5Oei?=
 =?us-ascii?Q?5N4rAtbKrDcn5moqtMfqbIR2MhHknNk1IH3FOFMiWN+Z0FRkfMUOk80ObohJ?=
 =?us-ascii?Q?YlH/mCv4XykrIq0ofOPAlMezxFeEGByV19iaXjYsNHZL2wynk2gHs+RwTiMr?=
 =?us-ascii?Q?wMEAOHKbO0QWzM8QS4QKluPGzaIdVgvNvSkVsG6E4U7/YtYAj6tq8sU/zO76?=
 =?us-ascii?Q?g5tPWjhF8GaX+FGd0ri6I+gWpkIQU/as0AqIqhaPmK+Dz4EzAOkGba1adIQH?=
 =?us-ascii?Q?Br+XD1fss1as2l4iPR+DGVMZOluBa3QR7jR8iUG0QP9HWRg5NJmmUFODH2Hj?=
 =?us-ascii?Q?IgJIzh+lC8AvAFKmyHQMA+7fzAWkvBvSuUHBUCVl5W9zjVYSgyq6vANM8vXY?=
 =?us-ascii?Q?8CVfIHueL0UUMlwz25U7I1tfKBzMxK9DA9VZqpDXursntZPAU81U/DpnKnEg?=
 =?us-ascii?Q?C4w6e9HzUeNls0r6IdrfEeZ5QZhxmGdLpnWntfcCf1neslGJPnnVD0vymLvD?=
 =?us-ascii?Q?FPpRrjGzYapkzD6mB1X8PSOIH8eVl22ZVJ6sMqIlrrNDi0dprldq3CGCFulY?=
 =?us-ascii?Q?LOxRlVi6mci3I9blvla21PlYOses89ioMHLrQPU0TNuYHLeEdUN2VeloRvSP?=
 =?us-ascii?Q?nLs6TI3JtkhHoHl2S+qk/cBkWoIwtcT34E8IwqOQkkBDSny6lcf7IL+6LMB/?=
 =?us-ascii?Q?p6W14l6VpePNxQhexs9Panli9pVcyiMCy8GkX61XXurtOa+zDq08uFzhcx2K?=
 =?us-ascii?Q?57cgjbAdL4AaxZxsWiUek4m7N3fo6GuiiytMJ+997nKxrHiSoCn+B61aYL00?=
 =?us-ascii?Q?rujbRE536959Cr3Zm8iSPlc1PnZU0QePAZwn/t57oqYZuK3KXETcXNPe47ZB?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L0D+ZqPbKo/ydIfcKUqP89pdPUvuGLnWfpNKF0zMxq6RiiWvdjLjeULSHNICnYjY8YXELGAlb4HcHX5sjvkc8z5MpMz1rWNdCag9iF80C6K5t6CQN9VYwQfyacoByfe4diGR3mRPmeac6iQyhaMJk/i9QFRO+0gmkwdQIhvdTtP3GiHFB7wSUOUQWtHyhi+cbvVPvVqbqBdHdd6wVmRJw8/kTJ3TjG5nFmu8/PrDG3p/nXIOvfXEU+XJmcTmUGXyBPWGGnOVrUIBuElrBxPPZgZIAgvJz/kjdFLOAe2qPrrXGzo/FvBv4l6Y3Ip6LqrbssRkxfdfBDXzVrmQsd6WhO7KLaD74uT+EdJFoH9v2Qmk4iU9ghQOKg19A5hIwcpYXcJmxuzGIWIQ2j/maerdgC+mauvYHMs8FrBJIDYis4bMahMmmaMZesPqtO+3G0Y2Ie3VR8hE73C41zdDUoSWA4KRzJ3YQbWSXLK9aWW5j9x3qgX2p0K0wrqgIL+ttgMOT/I08dUk8IoAhkgM6qZ1XaVaJPFHjHNfNfkr3B8pOukJuhlAN/vsIqJU4DluMzJ0fQLH7rqTwo+pvqhpC8AyLZ0CW+ZTSbpGhw6gLVjE8aI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0408e2b8-2924-4ffc-2280-08dc66006faa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:52:04.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnHts2zhg76JGxQ9pZn67leIY3R01CTcHabceeor78+zDWRa5za0Q3jEpzMnMX7K9+hWqHJobmERMOIF+Og9qrdAZeLKFvt4yTAXQsea6jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260099
X-Proofpoint-ORIG-GUID: 9zo43j5up-kVlYEnXceiQNmrpgyBIlPS
X-Proofpoint-GUID: 9zo43j5up-kVlYEnXceiQNmrpgyBIlPS

[Changes from V1;
- Add minimum GCC version that supports bpf_tail_call_static.]

The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
is guarded by a preprocessor check to assure that clang is recent
enough to support it.  This patch updates the guard so the function is
compiled when using GCC 13 or later as well.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/lib/bpf/bpf_helpers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index cd17f6d0791f..62e1c0cc4a59 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -137,7 +137,8 @@
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
-#if __clang_major__ >= 8 && defined(__bpf__)
+#if (defined(__clang__) && __clang_major__ >= 8) || (!defined(__clang__) && __GNUC__ > 12)
+#if defined(__bpf__)
 static __always_inline void
 bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 {
@@ -165,6 +166,7 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
 }
 #endif
+#endif
 
 enum libbpf_pin_type {
 	LIBBPF_PIN_NONE,
-- 
2.30.2


