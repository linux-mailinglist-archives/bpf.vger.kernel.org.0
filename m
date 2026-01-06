Return-Path: <bpf+bounces-77995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9ACF9E85
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4C632E3BA9
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368A33F8C6;
	Tue,  6 Jan 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oz4s3K+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="esXBLwIe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DD33DED6
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721046; cv=fail; b=b0bZOjBdRGjL+vvddSO0PYEaxtHozTuCojnihiKKVMCCcDeFhddSOdiUbQ7dlRPZmIC9tntQB6Y8ZJOuIQRbBL7OW7VvYBsjtwz0ipQN7VIDL2q4QRr2tLj2Z1eQL7NdlSSdzOI73ew+AQjBKmDQEmiIc92OE26eCLuuMDeaez0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721046; c=relaxed/simple;
	bh=nMzxWVcSMQ/DM/aoZhtdRleLlgn8db02hBoAFGOi/io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gH5qmCp1IFyeMxJpvXXKnTfEMiwCkQHJdFhZHmP5SUO/ULHd2d3u9hQvORqQVjHO1M+3wXV2wEBnGOt232klk+aDERF0nap/njjTNzFaCTnIc7X6Vp3RrbSkQyNN5sTNxKHUCTpxnHz6T1oIkapO/KUY3sckDRcCeBt86AJpQDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oz4s3K+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=esXBLwIe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606FAUQc3790788;
	Tue, 6 Jan 2026 17:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6RwvekqzHhFrToBQp1o2JjN0io2VzwVIvl88LkcVKzM=; b=
	Oz4s3K+BJ/eBPfkL/n29o2iUprLiBlFxjFpr7i/rtoerpIvn3tR0sOxf/R8pKmMx
	q80SZ6touMogWakA/L2HOWGK5HRWSTvMSv4OFIubnXuDVIsTy0nRK15lgX4pslIb
	YPEKxj9Z6D4v7BBpj9Mz7isAiBBfF2ctNmozOFBl/3N9gTEKsFZos4+1w7e54+Xd
	Ef3QMRT7dj40EHOusQR9oKCOdvqz1ATSz4qMBgsDTUXTQu5xwP4vjEer/VUFxzke
	C/+9swiKAitfH9w08EppdMBg/txfiWpm54mLayH8aFdJU6+ZbKqsTUBAAQz6X7VL
	dp0UrkP0ndguYZCvIuo5RA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh4t188dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 17:37:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606HJbYc034048;
	Tue, 6 Jan 2026 17:37:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8v3mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 17:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhbFdeNTTrzcHT3R9+ZN8dqD7jiq0QE8DnJq/FjnY8r4qfzLYgTuGjuRGF6ld59GfLO/CeaqaexihYSyCVdFya2b5r1TAZ5qTttSBDP3XlAoC/gYdxQJSCa2TItQxX8OpAOvpyU/BAnzvTHELVWmm9mi4VfViyX7flRT1szLliQqn4NDrbuixVfPK5FhkZivr86CvsewJLMpmknNlAnvqTqA/ojXySplNd46sBht8JZUv2zVLoBSqPkrTWjYgIv1n251DtdRpQcGhZy5qfxV2TmOQf5BqLkxE3timFv5LiQDq/MIjP18OJpf9zZnJoqSlHOnipPcUM+Lv7d2mwW3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RwvekqzHhFrToBQp1o2JjN0io2VzwVIvl88LkcVKzM=;
 b=vjI0v2OHqF7rd4o0UTfSzVYcTB8X8RbGEIb+TnYI7GE4cuYzDmteHXjfwP1YB1n8qZbdYXrb3nZHbFZY0L57mz6HOvTP7jDZUmc6DQJWrzb8BxMeMNH8DvdmvhRI73oDQiDJhsM3ehBUyepGCG0TcVaWPKvy8qPhq0KYmJLKeGv1HdFEGY30hyvkrie8cguenmoi+VSCLNMexWt/Xx8w371LUHPu6d5sS2/5Wi5Iygkycm5czmtf75SkmJ/hw9nmsbFKb1S0VzZE4aEFcdPlF5xlQVjD4q8l37V9J1xAAUSwnjh70CU5IXI9/+x3nIgOCi64m0t2PXnjA7521g/rLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RwvekqzHhFrToBQp1o2JjN0io2VzwVIvl88LkcVKzM=;
 b=esXBLwIeM+0ZqOZN8Q4okbZwgDgTDkvZVKJyNDwbm8gxxjsxbAoBoRj7tL6lvjKSFuP8ohmHkcASHV9l9wE4/vqPT48CRncpmRl4ubI/Qj/0F6XfB/HTYnZQAmv9iyEEFIMptK7gjk7adtPDpvMfJMtcUU5Lxk9TtFcYksgM1NI=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Tue, 6 Jan
 2026 17:37:18 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 17:37:18 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 2/2] bpf: GCC requires function attributes before the declarator
Date: Tue,  6 Jan 2026 18:36:50 +0100
Message-Id: <20260106173650.18191-3-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260106173650.18191-1-jose.marchesi@oracle.com>
References: <20260106173650.18191-1-jose.marchesi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: d92b5f5f-6fd5-4c4a-1b36-08de4d4a3d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsBEn1X9qe6TUHmkWG712qz9C8j0KFjueIgMamczNcbTMABBdKsHtDx38Izs?=
 =?us-ascii?Q?9Q0SCPRFO8AAUWVvlAoXPUB/jEdVZCAQCn7nP4caYmjITSkgJRYPSrzirsMv?=
 =?us-ascii?Q?4RYNGueK9Fv0mBwl9bWKDYvcIGu8XqLMWcgAhhTbVc3efV/VjuRYuf30t8pF?=
 =?us-ascii?Q?N9BT3tG9YXR131ml16Vh1rHjeyYOPP6LcrZdDfW1AY0gesw0kSRyAitH3XVl?=
 =?us-ascii?Q?INAfKm3KR8zSoDcHQWfxUthIJKUWrCMb9GKFbjSGz4/nlhrvxt6/CvKIfTbx?=
 =?us-ascii?Q?YUFkpQbL9X13kXJ3uHxrziMZ6erBjCwETYdQD5XWj3jVV4cm2mMQXvGBAqPF?=
 =?us-ascii?Q?KSvLM34zck0XB5yxAk5htBLuhZcObiyL2W8FlYXfK0aG+bSoRM79x/3pcmiY?=
 =?us-ascii?Q?g/Z9UAf66VvrSKJUVIVyexZXjbp0RIa1kGqM8bDEGVNdQ6ELCoSjjUk9boa2?=
 =?us-ascii?Q?PYNWCNM7ewnIJKeYDS+8O4b8TmJYz7KgLl64z2BPfeAvc53VycaGs17ThbfN?=
 =?us-ascii?Q?WjMzjHpPh2soSk1cd+n3nwysROui37CCUuwdspFMtOlSI3Tdpxef26ZXLXd8?=
 =?us-ascii?Q?//g+yS8r1391cQcO9Wv80LWP4SrWHDyL46sGirzdCxOEId02tBvW5xODj9iJ?=
 =?us-ascii?Q?eWzraZXjsl0cj9+LEKje4LdKQY7BxiA4YRN8rOn/oKqypGAyn3hzSNpwj3DS?=
 =?us-ascii?Q?0J6a/JdSvDZMg+fT8CUicgOEhzQxcPbxeK5DDpj0nYRyZ7XxT0Y2zVQi12LJ?=
 =?us-ascii?Q?LrNukS9MoEtrnFjH022bbWI4CBHMwU0B1Eeico3zxB831i+W2Zs4BnS9sAyF?=
 =?us-ascii?Q?N3gF/IOVDUbBM9eeLGa0cEGvViRM2X6RttxUcFN/sXzQK3DcDVSZd1dmeFaz?=
 =?us-ascii?Q?61EqcKBMv4qOHa5vlorIry4rmBrYsrn5EMQtr/sle3FmbLmHaEjvef2WwEJa?=
 =?us-ascii?Q?PNR3uqpNjVMa2Mzna8a0rrud/Rl4ki0Hd6enqk0cqZoIyjm7BvwPQfDD6u34?=
 =?us-ascii?Q?fQ1E39yoGnPJy+WmgQADpZG1sDl70e3v8Xu+YEHPYQ4yLSJ5JtFKg3osR/CP?=
 =?us-ascii?Q?e2YKkIuZoHtcdn+iPSDapsA7J0TCTsfepOUKcZr31UFtbMmNFAADsjbr4rzx?=
 =?us-ascii?Q?YY3zNYjE3sVl/pe1s4jT2IXOh2BmfEUFfArVqYwjLuYcen3ZtjzQZyxbx3Uo?=
 =?us-ascii?Q?nIvqfTlcG6wdjViCxn4SBlugCYh6DeWyIexTx25S44pyMdBHfWHpsseeKNmm?=
 =?us-ascii?Q?clRfAoPVYUfy+aQsTh8ibYzSqYzurEJ5QEzLdWYZDGyCNn928wxlNnpMuj2b?=
 =?us-ascii?Q?MW+FbvOFfyOYIzsEbSkesBXiytnKIGbU7w8IV56q/pgpI+Pd+kVDkKw9bwL6?=
 =?us-ascii?Q?CgYD7EY2rkwxWxetGBON0bqABhQmBE07w4MTWPDsRUzZIbcXBWe55LF8lYmt?=
 =?us-ascii?Q?ArEYnMLYfivlBNz8ByIBJQDgbRP68jNt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XocZqvOoUmZvnCewWzfyDtVuy/BLgoEx+L8XDb2Ggj9P9D9HqQNqiUTftBTf?=
 =?us-ascii?Q?jkvJEL0dC/PyWzwADheEIlkIU0eUiVcC8wd/wwprCifhyLCwNG+uRM8uObzp?=
 =?us-ascii?Q?p8+zgsfewA2Zx61abzMWpc01juQZ+s4zrel6UdjxFAHpMDC8QZQ80LRBTZmv?=
 =?us-ascii?Q?a2WF0gfcGhWXDzE3NgvZhls2sf+MCQDJVdV8PB5A5UDOtu2b5spjju3TfN6D?=
 =?us-ascii?Q?GrJszyU1aAe2xz5dCMRt5mgqKyVTuAxRWk3G4bx7TF+AuBCGAX3pOogL7Q/p?=
 =?us-ascii?Q?apo2LJB4Nh/5FN5QCyOUzMPbYlJ35FegzFiSguCUM5eUuFGtX71tC6nGC/xT?=
 =?us-ascii?Q?2daI6p3zPKC4LCYZjmivR1pUZf3RzrieUwntx6S2K1A8SFAncMuY4NhFgPci?=
 =?us-ascii?Q?nikTntbNub8sR7tGH+H/MqGaj0Dd95aEcZspGSlAPw0ItfyUAybbmkKaDO4P?=
 =?us-ascii?Q?WXwTNwFiaZJ2zTZ2iTsUCFGjTngsY6n+PKFtEPMGXvG29W6SdSNzkWjZ8Nok?=
 =?us-ascii?Q?B42iKfhqxZkwMwLYTJykeVLwPpvwRpwmX92fYS+AKRg1Dl6AW83v3JKWS7LP?=
 =?us-ascii?Q?pPsq43rt50NY6rNQ1l2qPJqOqdopWeHpfh8VIz963pOR0ZnOR3X8ZK3WVMmg?=
 =?us-ascii?Q?hC9/22Quzasd+g7HapSte1uCL5tgZihusbf1UFzgYb1WmOJnyrrFInNIKNBJ?=
 =?us-ascii?Q?lac17PS9BEqw/EM7La2klVd4dz1ftM7q+iq/mk1s8Mb29CCKiMLN6M/qyJMN?=
 =?us-ascii?Q?TA1+whHyXbnnRqLZ+Mwna65uOK4Up1M+v61X6I2m0JgxFoc/kabOCeTPjGjj?=
 =?us-ascii?Q?bkYVaOWykAU7fvzkGRpz5JiwEYnGJGfHT2bvl/Mi79Z6FVKCraAl/F/8vz9B?=
 =?us-ascii?Q?FKMbZyUDDKrJQURmYBlYEnmzvWmZ5+LuJsbBGyMfb+zLWhq3IlkUWYlCBieR?=
 =?us-ascii?Q?raoyKXYn/vfCDVK97FhBW0VHydyowzV4FK4NRsTi9PLcsXe2ujXgRYnF21OG?=
 =?us-ascii?Q?EQEZyu0TpVWbzqUCGnXLz7RGg1toB6fYmBtHTvx4RgVTx5tsGZS4NPJ+J09U?=
 =?us-ascii?Q?KcPv8BXRDJqvS4JOX64ekZg+LPBltMm0von9llHtWpxUf4DU0CF79fFm5as9?=
 =?us-ascii?Q?lcbXB1VucBzXzvKoP6Is1YHJDDFY8uOgkpszmI8Kv77VIlgM+1voQhuhzZY6?=
 =?us-ascii?Q?BJjMdXBdRPuoTY52xUEtvplaK39zvPNmE3ZYUDcqWkReDSzT8GnQrmEJQI1j?=
 =?us-ascii?Q?UBglY54WGafEtnr5ZP0qs8kGrSoVlbamRs88yD6d6gvhbzjE68hTmxdhSb/m?=
 =?us-ascii?Q?Yoi3KjN3ilVAHpURaDIFBELhoob3H+lFHbg4ryJ/Q2JKC9QRkhLYtf+iUFb1?=
 =?us-ascii?Q?LIDVDC+cnYsqAKB0wofGYKSKLSeEo8XH+U/gBNbc8UJNhCqzSolO5nWZkfCp?=
 =?us-ascii?Q?FMjyNGutKg+ri7kcng+2kmNGTqZb97Xp/nY8xLExyt/vADgB5mzcSjbrpbS+?=
 =?us-ascii?Q?lPAR9Tk+drzLpAfxwYprbEbgyroee+exmjRcVPntIm3QoHqPOcy8VXuD2BOB?=
 =?us-ascii?Q?pg8QQzyFTWKgFisc7H6efdeR8ggGvjUd+OfJnpM34QKxbQhHNdlF2LCUD/1F?=
 =?us-ascii?Q?vhEFiXf1li6xOvXjjfpFWZMe7H3OTkerBBixfqNmpxe9ZZdQQEG3sOYxGFb8?=
 =?us-ascii?Q?LdHJHk9Jbqcr9En2xXh/4AQr3XKWSXLvMxKwA+iZ+nCPLzedDiKMjxT4zbmV?=
 =?us-ascii?Q?XQaXH/CXkEiiSFRDRBY7oLMFAPG5dFc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tN7zsQL8q0qGKOB/HkHjgZTnS/ZiXw0RxMp7JZAsJ93okcD1qSAuWtOhahZnEFgKoblSQQvc3ZwzDzOUN8rxZKs4gp69ILIMp4HBtmYsbBMNTw+wrt97Ytlj4nzultMWXAK0TlRoRMWh64Vj1iJoVZ8eJbFuzQB4Dwa63kAg3fFB7O4BUI3/+2PwdNK51PYNFHPOULvlQLtNCoGCQC2oSe+Ybb9EX7c3+90FHsAL7Nxe4DlxjSBF1N9aMueRhOvckwaIfZbXnh5AHA772jbXGVDyhz5iHHhFavu5WHPUDSAVR3woYFgf5RgLvblbrmbj0FvHfoRv55XS1p9OibF6OvjaPrmk0H+hEEwkt/714U8/xvmk1163i4e5pIDJOe1bVgBEroCR4rjoywbhlhYSsUIFImaFxbx0ZGmts0L4nGMo7gqxQXBpo1kSuYhphxaXxb4sjdtyQgiZK9oudLtpo471iRV00j8JdMkJNWia6afduC0v2aVcOnIfcZBatBG18Vkhu0+KBgbzSfLxXwm4SDlQM5si7tYGwK2d7GKViTSVQuS1/IJi3hfpBsuPj94f88UN3BkYmryiX4xt2VxnEbdlE8MeMLRwIw8T8U8qTf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92b5f5f-6fd5-4c4a-1b36-08de4d4a3d44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:37:18.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1cMpBfSbdXJaHJQT/xVvBIGvJ2bnavfsKCBufpF6Y66hXZRKcDiPzF+mXPdY2OixfR/CgA3HfjemNDeT+Tkk2yTf5bx3Yz4U1vx7xpwhJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060152
X-Authority-Analysis: v=2.4 cv=P+U3RyAu c=1 sm=1 tr=0 ts=695d4851 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=NmLoFmzTNSGNKWesVeIA:9
X-Proofpoint-ORIG-GUID: K8I709ik5c1xczSwEkxFm-coF3ilRkJm
X-Proofpoint-GUID: K8I709ik5c1xczSwEkxFm-coF3ilRkJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MyBTYWx0ZWRfX5Kz5wBVHX9kt
 aKuZbAslKiZ0yCtRS6GqW0C/ghjTlp6VVIHfAwm6IjE7bdG++XYqeLM4g7H+DCb0sqXPjt/bD9L
 1B2gnShD9WjxRtqyweHnt1dAKUXLbjhjJW/Iwpe/vrfM4CFcSVCKNO7y3NoT5wtaExuCvqsBahN
 k21IKtx9kngogCCByRSG3QwexjiN2lZBbqFCItEl/Vrgkl2f/V6GEiZEuQuPoNQlvMUy+TaB4//
 KCj+3CWY5CCWZOwQ/gz4X5PP+gVpYOQseAE71WdvujCW9FJj1C65gs1zKBl3dMe5XvVbANCPp8M
 B0RA6VL0rsB0tvwoVEh6YUc/T5/xi2Xd/ZegsqQ8nZdBPkrAkoIcJJpYx9NdhhBdsyJ/qt71yAy
 wSTrTtZhhu8o2ws7/lELGizfLw0q7G8s8WQvAvyOQ9qCuUuE7wXeIcdjdxPX1xGRLI94m/oRjso
 6w/YYKZl3eGWI0YBwKw==

GCC insists in placing attributes before the declarators in function
declarations.  Now that GCC supports btf_decl_tag and therefore __tag1
and __tag2 expand to actual attributes, the compiler is complaining
about it for

  static __noinline int foo(int x __tag1 __tag2) __tag1 __tag2

progs/test_btf_decl_tag.c:36:1: error: attributes should be specified \
before the declarator in a function definition

This patch simply places the tags before the declarator.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_btf_decl_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_btf_decl_tag.c b/tools/testing/selftests/bpf/progs/test_btf_decl_tag.c
index c88ccc53529a..0c3df19626cb 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_decl_tag.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_decl_tag.c
@@ -33,7 +33,7 @@ struct {
 } hashmap1 SEC(".maps");
 
 
-static __noinline int foo(int x __tag1 __tag2) __tag1 __tag2
+static __noinline __tag1 __tag2 int foo(int x __tag1 __tag2)
 {
 	struct key_t key;
 	value_t val = {};
-- 
2.30.2


