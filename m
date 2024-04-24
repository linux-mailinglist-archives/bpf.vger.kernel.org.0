Return-Path: <bpf+bounces-27758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EF8B1668
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C881C23E21
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31516E888;
	Wed, 24 Apr 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mnAh+/ZI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ayx1wXKz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EF16E873
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998737; cv=fail; b=tKNmpa88oIgMk4WNv9HTIJwHUcoMsUWQG+x7s9CMM8f0A6s3B4r9/li6K7iaKTJ1ZEzrSWDEmWUZIQN5af5xTzB84MCtucpDnEVGBn7qDj8QZGRaMFLdZjlTaIyT+OO4FmZnjn+URz7RFW/exaCU1cNykRQg15yrOVEyYBA2O74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998737; c=relaxed/simple;
	bh=NftqfxbVKVFHAB/cji9B3RFTi5BHLlempe9XlUhF9BY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UgyvCu6W11SuHHauLMScNNxIuUYE+cAQs3XVvTfu5QTdRG89lpvjAPyr0BZ2VNQEXcJHVyKS5pOA8SkBtfCXsW5zuXD9RpuHCdeMaE3fqhESv+zd5JUYa2yT4btDLH4R2UsfA3D/TZ6LmbS7/9wQvjvTkuBYeWIGmNqe2LIm3lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mnAh+/ZI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ayx1wXKz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OG0EAx023154;
	Wed, 24 Apr 2024 22:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7ld2e29SqiyRsWset2VvaYYlSnpUDNTKLEcgf+VeyWw=;
 b=mnAh+/ZIY/7M0kltmA/a2q3YB7iLSFgRCeGqjTxEUTHeFYKU2uoauULuzwiHlQ/qJgpF
 LLUTrO8Qu41egboUdVj+vS8iAwiSjeS2olb+KQPorMMJ6SJHD6Fl4u3DPqfpqaFl9Upe
 fRFGtWOoiyueBSYsU23i8bU4bLvkjQqsQ6estYt5vsQNLBl/q1hWbpes5FU3MkGM9Yi4
 gMRMZ624aDFqcDv6XaB5zNuFg5uTb1v3hqt2u8ZGhemh+U4EVsAV7PMSfvwXfepZ238U
 4VSYVk5vJkiYowMIDHz0U1tNVt1/EYeR87GFX19NyzPzbz8X8sJikGI4e8KSsmkPSfIH tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5ausav1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:45:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OLY6ON035565;
	Wed, 24 Apr 2024 22:45:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459h20a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIgF16K7RgzO5cQa+mlgjYeqGKn+nDCJySbUjmZEkOnb23r1gCMSJA+B9AvS+Myy0K3/4fcLIG1oiuef7qxi/CFEr8P5DXw/Flg7R5kNK796dwVqcqhjDXzPsrhnTFf7DC9wj8yjV52vudqFbsHcG98z0QesJRlZRidAH1SBNoMOJw1o1P5MjNdzBGVMaS0yp7/y1DHhjPWY0sbyv6grRkEQxVnm44+JIpKdhShVTgeIODdwdnfCkEgiZuiWaOvYrdf0r4Frj785y9OejQdX2rDJ9xrpgnntfh2XQvl+Lf+c33I8oCKdJ6YB/BaF7fpFK78wqdZJongdtsZO2C/xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ld2e29SqiyRsWset2VvaYYlSnpUDNTKLEcgf+VeyWw=;
 b=WZsJvSOUeJKdZ1hy+pVAmi8TqGs8smSKdjl4q9C9OiLi/dFWmPs7BLzWIbnkCzJyR58hkYoFMKSDMt4z5MvWx/1MMxu8YNtJhP+Wgv/lgtYD7i6wFrLoilo3C4mpODDGeVymsfhMTaNX4AcfSD0Q/YGAyPonIb+O+F+3apyDz5CkmQMr9IK4S5rLbmPrkV8dqcTJVz2HMqZ3SdJWUpa9YfEXZ0uOBYhkDgDVQQZ7zCRTZgGIHENFKFYEzCSR/FgdjsXXeikfpuv/8xK0gJOpAA1VPnNZOqqag0FKvYNrm0W2W6Rh3Y5Lc0JsPIE0egQaEgYy2Gc8xPZp2EUJnDQL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ld2e29SqiyRsWset2VvaYYlSnpUDNTKLEcgf+VeyWw=;
 b=Ayx1wXKz6MX215N8Zb03PLwKMuj7EeUvoNxmUlrd2UxWR70U8QfGzw47B26jwPg5hQCDyZ/yHruGls+QDxr/4IkCS9eO4/YkjZTLulRyl4DqgQauYh9Y6P0aX0/waYXR0iF853sRfK9Rc9AIbWELatEc6JUtJTZbnzU/0e9tiCg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by MW6PR10MB7551.namprd10.prod.outlook.com (2603:10b6:303:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:45:30 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:45:30 +0000
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf/verifier: range computation
 improvements
In-reply-to: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Date: Wed, 24 Apr 2024 23:45:25 +0100
Message-ID: <87mspi8jne.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|MW6PR10MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 42461e9f-c21d-4c0f-da56-08dc64b03e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QaEjvv1d6ORYhYJ4sfpCbLmgGp/XTagUlGAHR40zpdExxNFvMszGcqWQHOh0?=
 =?us-ascii?Q?cIJNJCzD2Y0wYEFnTCAqKub7jZCBL3TINKV758FZs4zXJB7Cs1rDxGjPk2z2?=
 =?us-ascii?Q?FY6iCioLe2b8lPo6PEam+QkF8VoDRLpirAxf74eIz8peBPt6SNdi9eG0MwMQ?=
 =?us-ascii?Q?JiJl3IvkO8QoUr4ZARB901MMQlDDaG7Lb1ZElIzE9A+q08J4yDuWoYeUp+ZQ?=
 =?us-ascii?Q?bCQ4nf/t11yt87urLwIuA9boAA9TcfGIJkG3tyEHr839brl5Pz3+IP9FG8KO?=
 =?us-ascii?Q?Z7TkabM05E87xX2NWuvlzg/Rsb8/lQ6aFz4SFUGsc+m7WZnp8Mm0K2whntdi?=
 =?us-ascii?Q?yqHPpUjNBJcR5cBsev6WDIzs/ZRopyAlKRTGhweuMNoE5A3uLeTEkj8KEIQq?=
 =?us-ascii?Q?wTtwZrf+wCKlBwOxg3su4sCrCidYr6VfKZMHIp8onUPOTK73G+diWaW6TaG9?=
 =?us-ascii?Q?zbn3ucwQMXW1wTahyCI+ouoVL0uYwy3tb0hf87205vONhA/mtnt8LFe24gda?=
 =?us-ascii?Q?BfJPmHRj2GNyqLQoa6iQG/dDuwUfmwN5jVZ0zQunOXchYWoUMn0yJu7N8WfG?=
 =?us-ascii?Q?mi3QlFBaEZLuDTs2f4PPfFAH9U7En7Aa9k7CyzTko/4YQOHU2MZQQSmjN8NW?=
 =?us-ascii?Q?NBQga01+IUoWl7PsFZCTQdCaVswLNXpzc1/zMFStEAa4zTDmWV1UA97PaZfb?=
 =?us-ascii?Q?tezfvf5uy41Jnt+V4JQVJB1U62ECamc5/7tTwqBlgJEv+SdJny3fQ2ncNXrr?=
 =?us-ascii?Q?rkwbS4gvRnnVl7kxIainG7xBYmbUZB5N8eSy1RxQijV6VF1aGYgKM0qsyguU?=
 =?us-ascii?Q?xsNqRNCap6Ro1Z2/leCsy5yh57geXUUL7R1+84UX7IBx78yOrJBWGLpoIUqG?=
 =?us-ascii?Q?y9UxDJA7AqttRBrC8Ii6AYzktZMK7ggu4tlRq/E6GHdgYD1+5I6k7ST8r6+m?=
 =?us-ascii?Q?i4Hb1vLACpcq1huvpe3VeSnyTq8fOT/SO0bJrt8dZdO8JIQVDaPitpzT+vB3?=
 =?us-ascii?Q?Bh9f4ZHc1GMuaif+EcQzox8hTdGeAG4jfrc8J5+lXY2wA1pWiFNDQNb25l7U?=
 =?us-ascii?Q?6ZRZuKYoKzddru1aAZpGpH9Mxdnn61daAdqUOJ2htiI3mFObabuWr4kk0iig?=
 =?us-ascii?Q?6ZrqTZsmGv+m+MNtyL8m+ACZ4KxplaNqeUepZo1BaDdkCRyy/kHGe3+S0xcw?=
 =?us-ascii?Q?KLi5vZZaXqm6prQAAMk3/srnlCBKnxvbxJGFF5dWr0NG8FYxum7s0gwiAK+z?=
 =?us-ascii?Q?RuLpIYBkVK+/66SkaWUOCHsp1HdaFVQ/6T2BEaZQLg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?id2Eia95bAcsE1BcdvyIv3Yel8RIga5COsqoo2ewPS3l8aQV77oq+/5xjLlm?=
 =?us-ascii?Q?5s9Qx2XP7h99Z6GuyR2nX4hD8SOABcReV2LJTyhEnd2DAnRD8581Oo0Pj/8C?=
 =?us-ascii?Q?AnH2uSFANtJ1BIO3a3Y3jZbYcf96HOP1mcZX+7PBSbLnz70P/CkBW76lySj4?=
 =?us-ascii?Q?XT/h4wvUE9nQm9TkuTaA2IM/RBrsoMjaQ9wlQXS9XTerdaP8JU7z3B462JtA?=
 =?us-ascii?Q?TaqhPmFI37RDNEMdNHd6GhV4wbM2Fr9v7KGfI6n4dVtPxEshOZ3HiR0hG4hF?=
 =?us-ascii?Q?vQ01zF20xQpfvkvtThnU7V15sTB/dif/BGdmanRydE4hUnWit7WyIXO7e+3e?=
 =?us-ascii?Q?Kl+bUJMWMRF5Yg3Yzbbh34a/KfFXOTz+G8XEkYJ/I4nhAl5bQ0ZjnSihUOEE?=
 =?us-ascii?Q?96xVrok51ssGq1pzaJ3F66EVmNziCUESFlEgue34TsQDPwDACJP8xPpY8aPJ?=
 =?us-ascii?Q?3i4ESgBNT4v2zC1XhCLjO7SnW+XT1bnFagt7O9dcUsaGwlYJINT4W/RedfmD?=
 =?us-ascii?Q?9N8cF+Y/KqtVjuYNBMfd8I3mNUBTZUrWKn6vNaOP7VHGeTaadoybjbXvJHAN?=
 =?us-ascii?Q?WYrlY3L0bMvLCKi0je/kd+fGM24wCg0QiBhSvOQCRklrSUKU/JjCv/kcjszy?=
 =?us-ascii?Q?FyWn1MJzPAiib2RuX4ZhNqm6+/uFWGKw6OhgEnDh50Bggg00ozlroXD1p55D?=
 =?us-ascii?Q?THkIl4/o+WzwpTAptnstZkmYEhQba6LVkgEZKNKhQdg9h/puYqEKKFkFYm1o?=
 =?us-ascii?Q?CNrbWWgZUqYL85zkUIjztZXbxrojR5tyxPLisBL++qSOFiukaisiA3BRTXwg?=
 =?us-ascii?Q?RKJE4Qe8ybMHL14nJaPhb89XF27dYAlqA4jAM/ApmrJ3As14BbwBvTn/ENlf?=
 =?us-ascii?Q?Fn72sGdBjwCrfnR7Qllw3vLll8o9pnd+HiNWJONveVAdAFwkwBOKg6uWzrm0?=
 =?us-ascii?Q?o3L3o2DFKr9acGH0cLzjbsfVFtOrUrtMaj2Pt+Ypray+DW0ZF4TpS/iCYtEW?=
 =?us-ascii?Q?XnHzx5vlRhDF7jQBd3OBvd+CI+Hf+kazd9PLYhjmsOQppRkw8rvA/ad80etU?=
 =?us-ascii?Q?gBXoFtXMypjDp2y7cwTpyMudnQav+FETozWJWtJ9u2bovCbMTRu2vT+s6iyZ?=
 =?us-ascii?Q?Htr2h8R7O/wiWhg8qXnZLhFMTpipFQlVchUa+eXUvPlZFgrJH1Xk65crhnvq?=
 =?us-ascii?Q?oghFCcEpiyjHwjaOSqWV1o/FBvK1ntBgC1jwuYryhXcbxVyHRrndMf7iyfjb?=
 =?us-ascii?Q?u6WvmidB8oxQNIhaxrxs9iMltlJdo54juwEBnKwQ0PVbqEkMWmUzxUBJzx7f?=
 =?us-ascii?Q?Vd0+Wsw735xUc5cers89LtKH/Jbxo7k1HJn41JTnOavIvn1YQWfVuJApRCts?=
 =?us-ascii?Q?YZrnRCQ/C+0JWc/c6rDUCOWtbyT8F1c67yeSn7Ghov8+pb9fGqTCnuyBO7hZ?=
 =?us-ascii?Q?UHyh2OS+mnzJ8YBvNmO/GqO0MWnOS+Pt55NqcGH8YP+uHmjD0ayhnM9m9dfZ?=
 =?us-ascii?Q?O6Qent8mIeJpjQmGzDL0fcferV1cI2PQwy6UL+uSSRAJX5EMm5cJp4EuNJp8?=
 =?us-ascii?Q?fON08oz6UKIo5orJTF58HO9q/TErGAns/m/9bIv72hqLbrHpxTjcVS8dZB20?=
 =?us-ascii?Q?UJM+BPgc4qhviK9WzY+cmC8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yxKtih1q9QxB17ZSh4uNP8uHjNL4H8wuDBbUxaBbUJ4UcPlZZdz4D7K+/HksiWdNqCvtQXnBcpfaZBoHZj7Lmd0Uf5nmjCAsmcmzFM/eSCs3h4WQ2538f086U58rq9JtX5KTwEdatuCEzcG+qM9n5C5JyQDCeYTQ21n3nxcJOR6A2JGd4o6uT0ZarkY2Z3aUqesH3mftOOnywjaTQTQ+ltohSc0cnIw+NYZBXO8BVi4HpWEYhx6Q7ZYWWZZlNcjG7cLHJLxvFaS9VZcmPGFd2y7VuCunT94Wt5LNZtP8ipTU35uPxYj9Qu/pF+ApVPHYsGWaVHIOIe3gFGyyE9Z/vJaxxe8GHw05+ptfwaosYlv4T8JwXbZt1xUymXmkFO1sGbtnE+zu01/eUN/2MVuBG/hjmxW5MwK2YBb1TvMeJ8X/s2KJxsM0/r49kZsgYmUqnhTGC3dASzigNgXU3WeRURklzHR9JOrYSbxSjqbfWyRxRpyZW8tpFlU4qWACaTzqM5UvH2O9R0Tqq7l97wAQDxYprsZwiHlQyEPT9z8jdqbXHD+nZcxPenW4c5uKxiWMRK8oi5KSwjI7ORAvnA2MropLJxFXiNyIkvrQrUZ2Odg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42461e9f-c21d-4c0f-da56-08dc64b03e5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:45:30.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oe5go09AEDOksQ2KvlPQpczD7G7sYzs3wLUaR7AFVCIjMvuBPzJ5E/JG9KcR+nZfdq9MT6BACl+39lJfSB+4FFnPh3dlj8pCs6GQH9a/m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240118
X-Proofpoint-ORIG-GUID: TDxffYLUH__qSMdnO9EntZeo8DO1JkrJ
X-Proofpoint-GUID: TDxffYLUH__qSMdnO9EntZeo8DO1JkrJ


+Cc: Eduard Zingerman <eddyz87@gmail.com>

Apologies Eduard, forgot to add you to the CC list in the commits. :(

Cupertino Miranda writes:

> Hi everyone,
>
> This is the third series of these patches.
> Thank you Eduard and Yonghong for your reviews.
>
> Regards,
> Cupertino
>
> Changes from v1:
>  - Reordered patches in the series.
>  - Fix refactor to be acurate with original code.
>  - Fixed other mentioned small problems.
>
> Changes from v2:
>  - Added a patch to replace mark_reg_unknowon for __mark_reg_unknown in
>    the context of range computation.
>  - Reverted implementation of refactor to v1 which used a simpler
>    boolean return value in check function.
>  - Further relaxed MUL to allow it to still compute a range when neither
>    of its registers is a known value.
>  - Simplified tests based on Eduards example.
>  - Added messages in selftest commits.
>
> Cupertino Miranda (6):
>   bpf/verifier: replace calls to mark_reg_unknown.
>   bpf/verifier: refactor checks for range computation
>   bpf/verifier: improve XOR and OR range computation
>   selftests/bpf: XOR and OR range computation tests.
>   bpf/verifier: relax MUL range computation check
>   selftests/bpf: MUL range computation tests.
>
>  kernel/bpf/verifier.c                         | 139 ++++++++++--------
>  .../selftests/bpf/progs/verifier_bounds.c     |  63 ++++++++
>  2 files changed, 137 insertions(+), 65 deletions(-)

