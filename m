Return-Path: <bpf+bounces-28047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A478B4D93
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C7B1C20EB1
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A074410;
	Sun, 28 Apr 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kvH9hdNy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MzwoKTi0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A310F1
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331007; cv=fail; b=sN4bVxOYKkc4eTyquYk6D+C4BoR1Cny9ks9iM16jPxgOFXPEU3HAgIR5oolw7sSveGfk2ADI7CmkUKviXPvFgDMh5jteKQI4mL2xMKN07TJmsSh2CvDIv4v1RMsU2VNobFy8LMb8uHgXuXTT+1hdblsXO04dI6cGB8naDZ2HmeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331007; c=relaxed/simple;
	bh=NW2LDc5dL8GZrwMc8JfQYjs+tSXNuQb02NMG7ZOOjXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QKNeqYbnM0ZV6UPGDezgNOJfEoT7hDWFDaGcG45dffqZBdakNt0woDmX2lqwXLilqlV5uCmfnLWlcB2BggVscvbe8FuLw7D4B6nrlIqMvCqpAJyr3c7c2CryTLDPuZrooYolGQpV3p1Ak2+t4+JXGBoEeK14XCbQer+xuGU5keI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kvH9hdNy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MzwoKTi0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43SIct3U026822;
	Sun, 28 Apr 2024 19:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7SI87LiCNRgrvg6MwwOwWTOtNEnW6TuRF5rHg/UNhSg=;
 b=kvH9hdNyUQWcXNnLdSxbepkhrsbHOpIuxmKUvcikpV4fuV6D7CRqu5vZQjNcZFZw3tbI
 P8tqIN4CpEkgoCKtM/HgvQh8H89vbR/GEVz9BVFqxAIKkuSQuF5UWwPfJu92sVg4laSn
 PMv4GX9+1eiFEMsfLV/GrZzrCMBPdxj+rR7CQbgnFAEZXx9n19rfpR7nC6HwqcooG/Oo
 kO0jLPSXG32vKj7uDctu0aLQS5MyJUVk1a1R+Jr1ap/sxh2M+4Tqe3lghqLS4Nwnmv10
 FTk8/STvSl8lku8vb1aNNnbt5bm2FaQ3G0b+uQ9HoAU/U1MN9zf4SsRYzeSqDJvGPppl xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv1c42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 19:03:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43SDwQNH033247;
	Sun, 28 Apr 2024 19:03:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt569y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 19:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEXr84FIsVR5gHVA87y6teQ/5tzB4bJu/8VXs7tQlFrKYhapQqbMfe3DkMvf6qhLCEJANBYXehB2dRBG+8I5enb8p2cuKAr7arXGKkev87s93600U76jrYJj0KzwUvWwE5esZY0Z/7oD/PEOhYp7nOQ+NthlwmjA0iVZ8aj58yzdNYjtUm79oFJjZtsAnV2aEPrJBezA4yNE5xF7Mm3HqAiqLl5bXYZW8o6Sd5qr5pBpdQBv96DZRC3UF7KL2wZV0v9EpFBOHt6HKbqolQOhJBmYfkGcoYWhOLQahFTcrKm0Nl0TN2ZWKMtqtD4xvwRcj/7F+OgPMfDe3L96HexYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SI87LiCNRgrvg6MwwOwWTOtNEnW6TuRF5rHg/UNhSg=;
 b=Ae5NkqMxMCAn34u4NtG5MzmnheUYddloeLpHogwgrUA85twcv8jYaAS9eb/O+JcOaxRlX2UdPuvNg1lnIfHYwLXA+QBvME17TICWrQXbaEweq0fKKEWWd8X3cjnkh/qKmC56n7X733meAXdaelcdcFidmWqUpwFGsaaxOk6y4rTqns0vhatDt42BvlCzZfryAfGSMmApyvQJRZd2q6HM7rx508rMPQwqxa8QFgbzrrwh5OM/lf7JflDgGVAFyQq0hwWW3eFgc4T7IrwE3akkbZbB2UvFPWH0zZCIs+tHzd8HBFb4IajU/OG4koQ9QMwhKHn8V+mTKZyEyDd4y0+pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SI87LiCNRgrvg6MwwOwWTOtNEnW6TuRF5rHg/UNhSg=;
 b=MzwoKTi0338RJTOoMC40Amo9UOwfbtQr0ZtuUydVF3X35GAHEPE+AMh597wOz1B7Rmz0qaKPb6qw2VGDW4gUjDoItqv0X9c9J9L0IOsLVkn/JK6rH4odmQDydE6jnox/k7o+5STIPjLlLHdeoyOoazb6q4w+ZzGNLnOy5uQv63Q=
Received: from BN8PR10MB3107.namprd10.prod.outlook.com (2603:10b6:408:c2::18)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 19:03:10 +0000
Received: from BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::fd9:73ad:dfb6:d931]) by BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::fd9:73ad:dfb6:d931%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 19:03:09 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in
 bpf_tracing.h
In-Reply-To: <87h6fo0zq7.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
	26 Apr 2024 20:02:08 +0200")
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
	<CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
	<87h6fo0zq7.fsf@oracle.com>
Date: Sun, 28 Apr 2024 21:03:04 +0200
Message-ID: <87zftdwbrr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To BN8PR10MB3107.namprd10.prod.outlook.com
 (2603:10b6:408:c2::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3107:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: a929c634-791c-4d50-d345-08dc67b5d7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YU0LN5bgMhpx+yzXsjcEGg5sWQV7kO6xDoWc0a8W7iCaAL9qG7Sg7ua1IDgv?=
 =?us-ascii?Q?9JgfzscXc6hYa0mcFiH/RCmcYRdq/g+FMVNic+xadzdAYMGYWt0yMbEDcQwz?=
 =?us-ascii?Q?OPkIO+SblTadY8nv9nLxSKa1DBgmKR2Ki8R+JzsD/7xcXjQHrELPCkaQLUvA?=
 =?us-ascii?Q?dLKuq2ktofg55YCbj0ZIgepRLjEQtJvmbk5Os56Xz/Wsv9gBmknkJAPdEWbw?=
 =?us-ascii?Q?xzAjasFSQWNlFNGfVyxFKZlCgXBgZGD+8XvP2OAAeCjymjtOi6OLwyFSi9C9?=
 =?us-ascii?Q?x3Wu2XGYj5ChdleJeZ1BGazJMswKJGxw6MG0LVbJhlD3Gf/y9lg8lFSRSvGZ?=
 =?us-ascii?Q?FjNasFqAriJ8P7E7aDqjRBNdj9/6wtAIyD8HhSI4G10f2GfDRtUEYMjtJAzr?=
 =?us-ascii?Q?XBV5G7T2xUd8c0uwkgKW5SkRPQvpqxG+jmErNtxNLt6xqzYtcZnPWWNdiUdc?=
 =?us-ascii?Q?PQd30v6MSq0KFWFYd8FT6sJbxeZ+7PgycJgSE7wmhzyxRuAIVyJ/ByEEGhdi?=
 =?us-ascii?Q?RfMKBMMDZXzj7QIPMl5NG+mlBfVNp8OshCWhw28kpA59FMeukzyFcxiMJFBp?=
 =?us-ascii?Q?S+p0FsUwyDFp9ZRoxdixSkm4A8m4+D/iwVVBjvTFAJRKgpr+rSq7RllvKHgn?=
 =?us-ascii?Q?i1bCkSrd2O9Vsvt2bmAZT1I9xq10EbtodtS1fHtFAY6wcRa0G4wwu7R6/pqr?=
 =?us-ascii?Q?u5ki1iA0baHyqv7RRMV+v+SjSdCbQBhxa1h8muEnK0XriNYrDIwS49fjhArW?=
 =?us-ascii?Q?tVe3oZ+fnOBDfwFK1T4vJNUT5w70zk9SNWEopOl7VTp6V0GYhQdQLkG+cT3F?=
 =?us-ascii?Q?/TEZpwhCkF+3UVL+ZXGU8VvOAO+JoOAV+a5/50Jjw5zWcO9Cq+3Vl0IVMgwf?=
 =?us-ascii?Q?960Vk9xMm/RlZUB9zL1TFcALKsBkAyb0njRtP5um5PIdz9xpuUO4aLoMjCHB?=
 =?us-ascii?Q?Q9MJl7ZaOWcDXkeMt6pYGVEDnbXtHB72HRi8LpAroiUDhPyNBYrdtB0wVy7N?=
 =?us-ascii?Q?WN211AZ1oQiYsVOm8gswjI5Yp5/bF9l8cyi7KCSa6V34pODvBBikptKNXaZs?=
 =?us-ascii?Q?57FoeL/a1aeLsmJG9iLFPHUDR803RbvvudnwMuwfhYrVoh3LrFgBATg8jX+Q?=
 =?us-ascii?Q?CbwtVEYJxIhPk3qqPLOHW2/nwG5s9GJmkV6GRZf2fj3LG3XmyX6BBN+0ng2w?=
 =?us-ascii?Q?HRuYuS/VrD5rhz9H0ruF66DiTuoQcWZl5k9Fg/FmLTgW4DMaN5BmrsAAd+Zz?=
 =?us-ascii?Q?wWLw0QPohNe7zFgr0AKQq3Fu0UBUes0KRDJxbN1+8g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3107.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6LG55E8cHjHACe/wNtO4Y7gd/SlgCvF+mnxLwFUjAT/idkVRYBH5SDQljp+C?=
 =?us-ascii?Q?H1KZdzmCb0SOI9jFP3sZF/dOMx95xSSz8BDzG9idJ+bTW1o6K9Geab11XThi?=
 =?us-ascii?Q?5iJcLr4VUrzNPFkicJpvtTjqna+7mwy9rT6sZLHSgle73t0P9Ml4k6v8M+AP?=
 =?us-ascii?Q?lnrey6zShFLAStoB4InaJENfKw0qZLdxCD53mHmvoyf1v1ACysTZl4MlBc4b?=
 =?us-ascii?Q?0h8ziUrioxO0YMCTl5Ag9SvCQhGrg20gnqNNDX79MKYkgsZl9pBAlpE52ywk?=
 =?us-ascii?Q?uLhUJt1DuaRlp8nM2KZLfnl1Q+1fxabOZAdouIQMA4y5r6UrulfE8rHKJ9TP?=
 =?us-ascii?Q?fNJFW6dB7AB2uEvBn+8i647vXUCBJt1sCjidudJrEwMOB1DnyOiU2t2vQ/k0?=
 =?us-ascii?Q?L4zRWI2clJ/ANk1PN4Zt2edGLPyC0fkIMo5qP2+H8NB02tNIcB2VFOmeLpWh?=
 =?us-ascii?Q?vweB26375JMR99O2NhP6XAWln/MRqpCII4tH97U48fetkjIb78WKuu5WAMLO?=
 =?us-ascii?Q?ja/xnF+dgMScLJ5XccVAowcTUZ+w9Fhq8Ap5X38oLrgsRsKoyqmVqc6DO18R?=
 =?us-ascii?Q?l0agpmBZl6crryFdf6HbhsDbUwV2DgcqaG1LYaR6TnoFbz2YIpjJWtaJtqrJ?=
 =?us-ascii?Q?g8J3t2ZAWZfHQUe6rbPQiGMyDKq6X0E6TK5Y6cFccqP0dHIgqlZjZp4yBWzK?=
 =?us-ascii?Q?WN3GJKq3BZYEm0XVmL1qKnTSdLvtasd6aOxS90noddtfPAT2L9TqeQUXVeIj?=
 =?us-ascii?Q?REllvYUuaa3NqG+uSwi3ybbDgjRoR6hItNAswEH4w6Z8O3LmRHUQmFcBIQbf?=
 =?us-ascii?Q?KC4FpDLUknaxiTwEEulGcETLXM1IO6wsVg3/d2YwqkVdwJwArHg3A/OhtkH6?=
 =?us-ascii?Q?/Perg5es4/VGDg3c+c9t+dSQbgi+soKeS5rPOvO4X9DsaTDajTw+gU0A2UAh?=
 =?us-ascii?Q?KtdjERoO65DI1107zpAGqOZGNmrC+JePTQIrA1PoN9tqHfcOl3Hfarhf2+m9?=
 =?us-ascii?Q?pl6SmLnqZnaqajPo8UVp7bDrjqxXUEQ3xd1kni3yD33E4I2qqZ2t1QGrVSTz?=
 =?us-ascii?Q?szjjsm5JoncBDbs4ifgB9iAGT4WPnjuVOyu9TaPFbYUYoFg6UO8eRyc9KX4u?=
 =?us-ascii?Q?/Bp7qqE/QzMjINGtT6KjFYZbwXUnye8Od7+3Iek43fA1SMLj4f32Eo9agU3D?=
 =?us-ascii?Q?cv0aBYwALlGAmfwCU0dfktX2EEfvbka1oipS+DRbHZZ5iGqWdpvtGbdesRhv?=
 =?us-ascii?Q?dLG0RXK1bPF1zpkplSkvXX07a+YQP+b3zyE3pNOzvyXux63nB4+ZiEpZy22o?=
 =?us-ascii?Q?wOhzCM4ZyE8rSUHR9aRrz688Sne1tXLQam4a9HogdZtkE4X+ER2v0KZBGtFH?=
 =?us-ascii?Q?PnCpjNQCLxOc0qltKf7XIZkNEYYTKnzYOID0i0VGX0HGOIOjPmlVFfm/rI6V?=
 =?us-ascii?Q?5c3iphERYZOfuqGQsHzm++FsKv1foSggZZ0znRGt0VhxQmA4re9M7TTIjd/z?=
 =?us-ascii?Q?Jvh1W1dUbF/jXwx+ni2MD8Zhp07g15VS3TpDW/faqSNj5ERmoiYAhfLHt1g2?=
 =?us-ascii?Q?nPmwxy5xI6yAxSILKk9jBlMEzL+YGWk0Y/6xz2DwuJTaCz1LtJoKbmdevexH?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/friFtz7HBCm66o+y86ml29gaRLkY6PmG18PaJ6J4DRGCpBytu0NeAcnkWFA9epKuoPf0HhDG6luS2dvra6KgR5VGeBqgXVTA0NYhC3jAhrsjqoP1gMORNxoxGv9u/8kwEXysnkClUq0XA2in0bgxtOlCaliaHiXDtAIjE0QVOvMwdnluKfpnVEOE2UivvERZ+7Wa2SzJjIKw3rt5nM3i7biQAT25WvyHOVfGzqUnjNhjNCwGNbolPslNo3ZSSaL8da+I3W3+hhWuqwKkpDyFRYYzKvFKAKB5S86cCs/BDy0jIQyy9O/nhO5uxINWgvhp4obFNjnq8VNmDT3c8HQFlleK5hmngj/IrVlzQG8W7oisRgLDLAq2VcU2dPH2obntKzNHh0ZcNcA7Z8WnL2VdxvU2njycjWLJT0c+mOAT88zUm7D3h8p5Yyujw2tcsFF8wHkY9YCXNapoqLtz+GUOPwT2skEEUOyc0D/ZL2jCbBpM054fgoULQ/qOsmzGQbkzLqN97suLyO5brbrgsjdDdg+JZL0L0gnanAJwCTWNy8O+8ouvzfz1c2I0+zZ9B21km9zljhfoY5+VaJBYIv9fnSrIVkTnE04jnJjNPcTYiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a929c634-791c-4d50-d345-08dc67b5d7b3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3107.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 19:03:09.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJQGUJqodbXZegxns+LvhkYwoCp5qPsOVzZ9G9SNKSnxyvGS/QsHernbO6wuxwWfLXBunCDUgjImRWQWRnN3xwucOSBAnkirYs4syag3/RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404280136
X-Proofpoint-GUID: DyJmjoP8DfbIlGXDZZcs3e_7MYsaQga4
X-Proofpoint-ORIG-GUID: DyJmjoP8DfbIlGXDZZcs3e_7MYsaQga4


>> Also please check CI failures ([0]).
>>
>>   [0] https://github.com/kernel-patches/bpf/actions/runs/8846180836/job/24291582343
>
> How weird.  This means something is going on in my local testing
> environment.

Ok, I think I know what is going on: the CI failures had nothing to do
with the patch changes per-se, but with the fact the patch changes
bpf_tracing.h and a little problem in the build system.

If I change tools/lib/bpf/bpf_tracing.h in bpf-next master, then
execute:

 $ cd bpf-next/
 $ git clean -xf
 $ cd tools/testing/selftests/bpf/
 $ ./vmtest.sh -- ./test_progs

in tools/testing/sefltests/bpf, I get this:

  make[2]: *** No rule to make target '/home/jemarch/gnu/src/bpf-next/tools/testing/selftests/bpf/tools/build/libbpflibbpfbpf_helper_defs.h', needed by '/home/jemarch/gnu/src/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/include/bpf/libbpfbpf_helper_defs.h'.  Stop.


Same thing happens if I have a built tree and I do `make' in
tools/testing/selftests/bpf.

In tools/lib/bpf/Makefile there is:

  BPF_HELPER_DEFS	:= $(OUTPUT)bpf_helper_defs.h

which assumes OUTPUT always has a trailing slash, which seems to be a
common expectation for OUTPUT among all the Makefiles.

In tools/bpf/runqslower/Makefile we find:

  BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
  DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bootstrap/bpftool
  [...]
  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OUTPUT)
	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) \
		    DESTDIR=$(BPFOBJ_OUTPUT) prefix= $(abspath $@) install_headers

which is ok because BPFTOOL_OUTPUT is defined with a trailing slash.

However in tools/testing/selftests/bpf/Makefile an explicit value for
BPFTOOL_OUTPUT is specified, that lacks a trailing slash:

  $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf			       \
		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
		    cp $(RUNQSLOWER_OUTPUT)runqslower $@

This results in a malformed

  BPF_HELPER_DEFS	:= $(OUTPUT)bpf_helper_defs.h

in tools/lib/bpf/Makefile.

The patch below fixes this, but there are other many possible fixes
(like changing tools/bpf/runqslower/Makefile in order to pass
OUTPUT=$(BPFOBJ_OUTPUT)/, or changing tools/lib/bpf/Makefile to use
$(OUTPUT)/bpf_helper_defs.h) and I don't know which one you would
prefer.

Also, since the involved rules have not been changed recently, I am
wondering why this is being noted only now.  Is people using another
set-up/workflow that somehow doesn't trigger this?

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ca8b73f7c774..665a5c1e9b8e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -274,7 +274,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
 		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
-		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf			       \
+		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
 		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
 		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \

