Return-Path: <bpf+bounces-76463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089ECB582F
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DDD53010290
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D73019A6;
	Thu, 11 Dec 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8gF8ahx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QCqSpsvL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CB205E25;
	Thu, 11 Dec 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448707; cv=fail; b=iqD8+1d5jLBCovAf2kO2jpKpXXKZSUFKiPv3o81ljGYfv9StELA6K/bCVez6tyhxvROM96UO7brfJqzN/zpVeNQbAZdqkKpDNs8W7GngOn5xjE3EP6wKyBwHhSIzXZxkQUrKOEv4o/1ffAKDiq1NgTzgSduCNTdzqX4f+QcX1s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448707; c=relaxed/simple;
	bh=hrk9FnAunmSviowa9Gk3ABb5/Lg8rUnNjI6RVjb4cEw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAbnGnX/xKMc8S2K0O+xqucgBp/ZslAfFZJ28tAa1I9hU/6JWkOWm+zOVXFiAsKHil+G5m+3q4ylfvgQwfJheIuAllJ+WLUurZYYiq+nU3y81QMTNMh0N8NElbBOAOkDNKMxfrV+wWSiCyqQO1Dan3HPev/6CHI1fV50HOKdHFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8gF8ahx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QCqSpsvL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB1gVIl287742;
	Thu, 11 Dec 2025 10:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Gw0gPQ9q0ICtOXdZRaWm0xabNrUZidRhUGWMYMQXlPo=; b=
	T8gF8ahxQwod6fmZqahY7EZ4vHQQGL/ygb8jikus3fYBE6ICecVqOzH2b/VcXas+
	NUFXyxPURO0lGYhvxeW4STSsAEVzL8ksbdRgwo+KcJr/TH5Ls6g7+DuyRNeJ/qGw
	dN71Qv7xwUmA2LQOJ+hB8Gx7w7a20epwynFErnY4Cp1SpRBfYltz7MIpYhmaDqOn
	6VrLObXSleFMfLftvEwjORggfATz0ptWeROOS6XystJW7IpKCYYqyoI50DDAAtE8
	/dWhx5x7VGzFr7ZrSwYkX3qiNSkpXGjsQ2g4hDdYv7AJ3DNHKrISgfClnjBoXRgA
	ps6G8Etu7jJWmyHg52OCPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycne174c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 10:24:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB8RI8E038127;
	Thu, 11 Dec 2025 10:24:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxbndvn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 10:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH4khX0pbqXmz4YIBvbwe8e4Ty2pMiC5LbZ2Iz9DSrXiRm6X0yrmpmMoFbWC2T2UYtRG1Qv5mG7puAaqKwUtIvZDd+MHufH+i+65mzm+i+yraHOk3atB+3nLHUTHpttBeauHucBlg5khBg4Oa+f2KQeFCbnrE8QqjBObakjARcyWctH1rfosvHf8ByzqjjNL4yzOCarBjrAMaOKlZTnw+Z7sNHyDLZle8qMIglDWQCRYbSi5jfL289lu+8IV7DR0t42UQTsm80P0lm5n73x67KVaip2QyQHHzVUWYQnZLspBRx8DNxmzuDRK0sJATODnc1H2H90ECrZmEz9ASMrChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw0gPQ9q0ICtOXdZRaWm0xabNrUZidRhUGWMYMQXlPo=;
 b=i/kl1QPkumlH2mkULse9OlIWqzA8XJ4Nz4BQQf/6joCSjXVuvLyvFuYRrUjpMV2n+ku/xx/FohpuKHzv+PG35Q7+Z3s8fTiJv6nqUzsF6OTZKNNVfBtIS03J1wRM9lZMz9Lg6g3Qk2czSHp4JULvYil7SaYl7V1450BBqw2ArsufqCasKsjabVrb019/RjrVJ1AASxXEVLib3+ToEM1jMyv2unphCuCp8H9hR9MK0QDFgD766SEQ9GrsqWYK1B+S9SJShnPVxQRZIsJeMt8hWJO3DOhcv3tZoW/3SgkG/l1q9t555nZlo9PR4nGjFC2rdNl8h8BQEaXB3tEDcoXUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw0gPQ9q0ICtOXdZRaWm0xabNrUZidRhUGWMYMQXlPo=;
 b=QCqSpsvL4p/M9HzxEcBGiiEw32QTyPw4vrpRbEPZKRE1dyANV9AxLnJ8pmspD0kgKOuVw+pxibs01/dQ7Q6Pl3y4hOwrakhJcuGOjUGsVBiNKOsiSeFKe+3v0rsK71Wcj5CA+Me7TrQ3dttOKi2EOErwouxUIgQfAvqPFjwWEf0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB5945.namprd10.prod.outlook.com (2603:10b6:208:3d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 10:23:59 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:23:59 +0000
Message-ID: <0b56d2e7-5785-452c-a4e0-911e4cae470e@oracle.com>
Date: Thu, 11 Dec 2025 10:23:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 04/10] libbpf: Add kind layout encoding
 support
From: Alan Maguire <alan.maguire@oracle.com>
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        martin.lau@kernel.org, clm@meta.com
References: <20251210203243.814529-5-alan.maguire@oracle.com>
 <6e0f6354688867327290334013a595b8d548820a7d374cbe607a86cc5bedf293@mail.kernel.org>
 <060ad1a8-a457-4adf-b8ee-f43bd3dd5ac2@oracle.com>
Content-Language: en-GB
In-Reply-To: <060ad1a8-a457-4adf-b8ee-f43bd3dd5ac2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f21528e-299b-48d8-b1f6-08de389f65ee
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eGNiQVI1UFhPUjh4VTh5K3dhSUU2Q1NZTVlyL2dBYmVZcTBlcnZUaVlYNXpp?=
 =?utf-8?B?RHh5LzNzUVA4bWVmNUcreTBTMjI2VWM5Q01ReVVpb3ZtQU5vYkxRYVVxOHdt?=
 =?utf-8?B?OTE0ODhrYUVoOExUWW8rYllhVFRQWmsrYmlGeFpWM051WnB5dXRqZWM3ZG1u?=
 =?utf-8?B?ODIrUW90d2tVYitka0J1K2RyUDArcy9pOWg1N1VqeWpkZHhML1ZaQmpsOXI2?=
 =?utf-8?B?ZEh3bUtaWjdOaHJQR1BXUVdPcHhZMlBrYWhsQlQ1VG5CdW5qNlNmN2hYdnpT?=
 =?utf-8?B?VEZqU1BCd0k3SHR0RktZM0NNMnE4c3hVcTFjeVE5R2piQUZnVVZCcXN1cUZ2?=
 =?utf-8?B?eXY4VGN3WjRFclc2cWJxaUhVbzFodzNuSGttakF6d3laTDRvcmV4cndCYUNh?=
 =?utf-8?B?SFhMZkJOSDIxVjRnZmZtQncvRDVsbVNoMkFTZm90a3pYbzJobUkwN05EaDE3?=
 =?utf-8?B?ZHgxTWIrdDZmVE9VUjU4NU4yQit6Y0FzWFM5dTlTdFV5ckcwa3dBeHZpY0Jq?=
 =?utf-8?B?L3FJN0tPcSsvQVVJY2VpVEx0b0NrV1VSRDVYN3JmUmc1Vm5lQTlVeU9ObDZ1?=
 =?utf-8?B?clRxR21VUDd6TTU4MHFsSnh4T0QwRW52VWtpVDNCQnVlblNEdUx6ZWNsdEp5?=
 =?utf-8?B?L0E4ZUZ4T2RHNjhZemFxWk54TmY4UzBrK0t6Q0NQdFpEdExFaC9HemJVVkRB?=
 =?utf-8?B?M1F2a0ZJY0NWaWF4Zk0zNVlRY29qN3NCSy9VakpSRlRGeEg2TVFRNjR2NytR?=
 =?utf-8?B?dStaUXRJbFRoRTRQMFZ6ME4xRTM1c2tIdk1vQzBLNkFXazZhdi9EY3g1akgz?=
 =?utf-8?B?TzVHWGd5MWltUWpoaHVXNDB6RUpqRi9wcW1VVU9xS1I5UnpjdWc3anQwWENx?=
 =?utf-8?B?UjVIWW8rNU8xYWRXQ2ppY0o4STJraGxGNnpEUjJLek9pOEZjYm9NUFNJUmpF?=
 =?utf-8?B?b2xaYU5lYVhZRG94dHVMWGN6RzJyY0MybkhNZXVHWkJTaEtSUWZYL1hxbTJG?=
 =?utf-8?B?Z2lmK1hOOFY0ZTVxSnpRbHNESmdzSU5jdVhmaEhxUDFKWEVtbXBXYUE1OUp6?=
 =?utf-8?B?UDk4STVvSFpvcFoyN0gxSWJnRUI4aCtqcU1sWnFzZlVESURrbzg4S2ZPalhO?=
 =?utf-8?B?Y3k5MjNLVlBpMnV4L3lxSVczNEt6RXljR3NFcC9ySzZ6aWdROXVtUklkZkJ6?=
 =?utf-8?B?dlI1VER3c2dhZ0VVMGtRcncwWFdPdVV1aFIrQmQ2cDBHZjFWSXYvNkhpcTNu?=
 =?utf-8?B?TEI4Z1RidnNNNk81cFZhN24wY2VDaDZlS3pReG1jcGJ3akdhbEJodm0ySVlX?=
 =?utf-8?B?SDdnaHI3VVNDb3VLcEdRZExGbXlhOWJVQ2UxbDlMd29FZkhzbmhHbThCYzNX?=
 =?utf-8?B?MTZibkZUT0prVzlON1pHelpITDUyUGNNd21KZmJPT1RJMnRYT0xlWEJCNENQ?=
 =?utf-8?B?M0NtS3VTeXVPNElUT2Myayt6dGh1THJqWXJzUzJJV2JuY1g0RmVucDBvS1Ev?=
 =?utf-8?B?bVR3Q2tHWms3cTBiTExWUk9VTFBqSWNIeUFsY3NHUW5zb3dFS09sQUwvK0JE?=
 =?utf-8?B?NVg0ZnEyenhyRFdKNVJuU1lWNkU5Y0p6MkZEN3F2WnZZTjdobWVrQkpWb1Bu?=
 =?utf-8?B?bkFITU4zUXV2VUUzeWkzZEhPN242Zm9ubVRXUk1rRmxhbCt6L2svNm9KK0Nq?=
 =?utf-8?B?NlpSUUxUVWNrNVRzQUdmWk5GMVlPWEpFYWpKL0NEQjlhQ0lqREhSYkgwdFJG?=
 =?utf-8?B?LzZidWJsQTI3RmtjWlB0UWVaVTFYZFByNmJycnRtWWoxM041NnJ3bXN1cng3?=
 =?utf-8?B?WlJOeGplcFNidFVQZUNTV3oxMk5BTDR6WDU3NDZQeThrRSsxS2tiUVZpeUZo?=
 =?utf-8?B?TTRjc3BhYkhSNFhENWVFNEZUKzFTc01qYkpWVHViSG03UDhYck9JQlQrNGlI?=
 =?utf-8?B?ZkJMVElPYW1KaTR3b0NseGlLY3ZORWc4ZmxHZDBCeTBrcHlILzRMZGxBZ2U4?=
 =?utf-8?B?ZTNCc1R1VlZRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TnZLYSt6RmVYWWphU2Uva2NPN3BXQ1N0K2N4RTVrZmlqZVNBSnl0WkhZbnBj?=
 =?utf-8?B?UnJRcjRrQklXTGxrZFVJeEpRMy9lUUhheXdIYVVPVkNwTSswa1RkcnRJVVht?=
 =?utf-8?B?K21UVGZ5b2ROUFdzMkRHOGdLM01rOEJDSlNKOHVhVmNCTC9sdmV6a3c0aGZx?=
 =?utf-8?B?dU1Rc3FiMHQxa1JDbFZ6cXNCbFd5SFJTSnlBelkxYno2UWhwRWlzNVJtZ0s5?=
 =?utf-8?B?Tm9vT2NVVnI2OVJURXg1NFdKTWluSldBMU5WbUhNR0dtSEZER1RxK1F1d2Zo?=
 =?utf-8?B?Q2xwNnBpRW54dlFtdlJuYURCckUwYlgwL0UrQWVBdEIyY0lnelZkVk4wVlNh?=
 =?utf-8?B?ZWZFcldXcTA4RmVJdmdPK1pxN05kaGV5c2FoUGZpZklzSDNwR2liWDY2SHo4?=
 =?utf-8?B?ekZnZzlWSmJEcUlQN0hxSlViRmJoNFp3bXZQVU5pS3RJTkNKM1dGSGF0WC9G?=
 =?utf-8?B?Q0ZXcmJyNzlCYTM0RitYNm1EUnBQSDNteDVuMStFdlcxN3JMQzl0bVFIMTE1?=
 =?utf-8?B?OXNoaFg3dk5QMGl5TWU5ZVVLOCticjI1SWtQZ05EZXN2MjNzaWY4WFpEK1E3?=
 =?utf-8?B?SlBvcUdmYjBtcmw3R1Z4aXRSQkpFdnZqM09PdTVCaUxHS2dIRGU4ckttRmRi?=
 =?utf-8?B?NUpIOFljMU9XVkY0ZE9vTFBVWGJJSHo0b25FbHJoZWd6OTNyajdLMlhEcHhp?=
 =?utf-8?B?V2JpdGRXaTlyQ2g4UFgxT1E3eExUZ1VhYVlWUWVwMG4xN29mMlZYbU02Yksv?=
 =?utf-8?B?RkZWMHkxamJxajl1N1NuZjRwV1NrNDNKUERpNkp3Mjd4bzUwaHhxNm52WW1Y?=
 =?utf-8?B?K0FmRmRCV1YxZ2VkdlVFTlBBVWo1aURLZlptUG5rU2d2Zmh5QnpLUHNyOGpE?=
 =?utf-8?B?WnFEcCtLT1VpWWJDZ3NiNXc0Ris4VTM1d0Z6dzQyNkozVUtSbEhNWDlKZmow?=
 =?utf-8?B?dGxEeVB4T24yR3BHYlpXOUFOSlBBMk85YjhlOUsvTFlpRTZ1L3cvTDVGL2t5?=
 =?utf-8?B?VnByekhjMTcxSXpVR2NaQjR4eEhlNFNkT3RBMzVBSEp1dWpJYXdoQWNraWJM?=
 =?utf-8?B?VTJLL3BNVGgxUGR2dDlVay9ERUp2N2hzMi9rYVBPN0hxbmtjL2hrbzYyMzJM?=
 =?utf-8?B?b3grM0RUOWE2OC9xUDV4RnllOUNTWFZURmVmZmUxcWtxNEdzREtoaTlEQkxH?=
 =?utf-8?B?R3hzeE5sK21MNy9wQW9EZVNIUGZyMlVVL1JzaXVjU1JZWUdkR08rNVMwYjNI?=
 =?utf-8?B?RlBVaHp5NzNrMWg3RGpXUXFoTEYvT3pheExKaDk1SlVtTEpEcFFNZFBubGg1?=
 =?utf-8?B?UkI2ZmRNOElGZ1BnMGpacnBqa2VGSHhLbFVCY3VONllsdDlkLzBhYzhIb1NX?=
 =?utf-8?B?U1pVWWxlRXh4UWUrZ1dEWmJYanNqWmdNUzFXWEFqM1UreTFaTkNWc3BJcEhZ?=
 =?utf-8?B?Zm13MEU2Y1N0bnBidnVldHE5R0c3ZUJydE9WSHhmQkxYUjhrczkxUW16dFNs?=
 =?utf-8?B?SVQ5V1JSNGRzSFJQTXhPRHpLbUhXYkM2Z0NoVzc5RUQxSUZMakM0a21QVkFl?=
 =?utf-8?B?U3FkajczVmRxcXFnVE5kSVdVWk1SMG8zQ1NWeUhJZHppb3d3UzNwd0xJNm5h?=
 =?utf-8?B?b25RTXpvellmYXRYTWhXTmJPMEtOQWVyOG5hQ3IrdWRFYVZqMVRoTnhkaW5O?=
 =?utf-8?B?L3p2MUVCVitWSmU4b0h6RzhmZnpDSmt0SXlrVEJJc3pTeEUxWFpVekgyaHpU?=
 =?utf-8?B?Y1huekhOYlhvNkNYYTRuR3RhV3NrYTl5T09IV2JmamJPQUF5UytSV1ArRkNp?=
 =?utf-8?B?M0lHVC91cVV2bHNYTk93Ri9VU2UrN2M5QUlEdnhXOG80azhmZHR0Qnk3bUFU?=
 =?utf-8?B?MjR5RkhKVEZEa2R5VkhKNGNaTUx6aDM1U015N0p2Qm5hVlFiaFVwQVg4dUlJ?=
 =?utf-8?B?TFZkZGtPM3RYYjVpcEdpNCtjSGJ0NW1HWGZaSFNIanRaaU45VC9vVDZ6SlNI?=
 =?utf-8?B?MXRBd0FDL2loTk9IdEo4akI2N2VDOEd5NW1XcW9RdGxYYzV4RDU4RzNwU2pn?=
 =?utf-8?B?MzVtbmErbndFWHd5c3AyMkx4ZlA2akpCcDZjcnJINWdIbzltTmhHYjJPanpU?=
 =?utf-8?B?aWIvWkZSRGJtbmtHSy96RlBKcGo0VjVGUitoTnEwWlZybmhVQUlkc0ZDUWZE?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nYCzw+Jw0bE6a/skpPggpmN4rzSuJnuy6TuPZlvGCZebr1OU2R325RHikQhUCfyphW5uKAAeVQqA/Hv3sQVFGf7DkRCKwzcUjGqVjQusZizGW5PzLSTcpriF4jheTCWktTKDwQjkYVzgJ8hpCoX3H1tqpnPIQHhIFp0DPRxgrYDmnhAPzkQSBcUGF7I4j7ZV/zQZgAqTkcOC45X9QN3ShltktwylV48r7gAX2eyJ88sW2AdJxxFaqH/tvb928xy7yRWC6BzAC3ZQGjRhSK3MtVPqk44ZjoAk3Y7K63A+aH3rZyGmupiEzh5SW4SKJXe45AMK7xj4umqHbprnkRKBiH06P2QfGKshX5q0JCuZuFCEM1AsLlpdr7sN2I0k9AnxhCoAYmSVNSOiQ1vZWtHcZb+tLdwTSTFk9XE1nfj4ax8mEozh7687VEuK8TN546XY7AFfaQaaFcBS2OMpqbIJ79guhQe0CEpIe36vkGKNnFvsm8LsjmyZL9Ow9ATwuYNf79UOZFUNVmQLUXbeRVvfBrUdQQnWcNgRjzunM5MKZX4e0aao0HwGz+sHwpEdu5rY0GBT6+Y4DM8rB+OSCnrEWm6otRdmCjD02Z2vIZ8ZAuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f21528e-299b-48d8-b1f6-08de389f65ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:23:59.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TILCISFPTXB561rmTz+y/SfCXqs/O+DUXQFf874lvCejK63lOr6GtG9Kik9WQsHe59mFrKh5D36l5qmRQWsvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512110079
X-Authority-Analysis: v=2.4 cv=F65at6hN c=1 sm=1 tr=0 ts=693a9bc4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=TIFQL6ZO7EhiD_9E0rkA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: gZNrBBCoPrYP9l7hrORndhkBsDzoGxXo
X-Proofpoint-ORIG-GUID: gZNrBBCoPrYP9l7hrORndhkBsDzoGxXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA3OSBTYWx0ZWRfXweZuLX7+N+9U
 ADgutp2tB/bKRasQb/KDtSnRBaSMXJ5kdSKSdN5qDpv2aIGROwFUJ48F/P70Y8XRwU+FVG1VRrz
 8ipQsBVoriAfoI5sinKsKIU7tO+vIp0WkOLE2jb48U/qMwQKQNxX37MrEFbqIXxhyeCoPjJg0BW
 ln6MuDcN7U4617/vk2MISg72kxcOONunonbnwOVHRehNur1Tm6v+1HOo9LcRoPF0FG1v35loDGk
 hH2reBNpoR2vYnN15Qb5g7CjMwM5xgKDAlD9NevhzmtJVNXzjIelnUBmmNqwBr4SMZ78LEEGCf3
 6kIAijpOWDcfiO8Rxo6cUhg+4+yNkA/qcE1+bbykXj902FPsiOsSeiKTySqdlkb6o9EHRAzG5Z5
 uUrUw/dQKYPkArc+YX+hV20FkZy2AA==

On 11/12/2025 08:36, Alan Maguire wrote:
> On 10/12/2025 20:55, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 4eb0704a0309..2133e976cb9c 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>
>> [ ... ]
>>
>>> -static struct btf *btf_new_empty(struct btf *base_btf)
>>> +static struct btf *btf_new_empty(struct btf_new_opts *opts)
>>>  {
>>> +	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
>>>  	struct btf_header *hdr;
>>>  	struct btf *btf;
>>>
>>> @@ -1111,6 +1141,17 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>>>  		free(btf);
>>>  		return ERR_PTR(-ENOMEM);
>>>  	}
>>> +
>>> +	if (opts->add_kind_layout) {
>>
>> Can opts be NULL here? The OPTS_VALID() check in btf__new_empty_opts()
>> returns true when opts is NULL (!(opts) evaluates to true), so this code
>> could dereference NULL. Should this use OPTS_GET(opts, add_kind_layout,
>> false) instead?
> 
> Will do.
> 
>>
>>> +		hdr->kind_layout_len = sizeof(kind_layouts);
>>> +		btf->kind_layout = malloc(hdr->kind_layout_len);
>>> +		if (!btf->kind_layout) {
>>> +			free(btf->hdr);
>>> +			free(btf);
>>> +			return ERR_PTR(-ENOMEM);
>>> +		}
>>
>> Does this error path leak btf->raw_data? It was allocated earlier via
>> calloc() but isn't freed here, while btf->hdr is freed. The same issue
>> appears in the error path above at the check "if (!btf->hdr)" where
>> btf->raw_data is also not freed.
>>
> 
> Will fix.
>  
>>> +		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
>>> +	}
>>>  	memcpy(btf->hdr, hdr, sizeof(*hdr));
>>>
>>>  	return btf;
>>
>> Also, when a BTF object is created via btf_new_empty() with
>> add_kind_layout=true, btf->kind_layout is allocated but btf->modifiable
>> remains false (never set to true). Later, when btf__free() is called, it
>> only frees btf->kind_layout if btf_is_modifiable() returns true (checking
>> the modifiable flag). Does this leak the kind_layout allocation for BTF
>> objects created with btf__new_empty_opts()?
>>
> 
> We can free btf->kind_layout conditionally as long as it is not pointing into
> the btf data section (as would be the case for parsed BTF). Will add the check
> in btf__free().
>

Actually the right answer here is for btf_new_empty() to place the kind layout
data in the raw contiguous representation when add_kind_layout is true; it then
becomes btf_ensure_modifiable()s job to break out and allocate sections as is true today
for type/string sections. With this approach, we do not need to allocate btf->kind_layout
in btf_new_empty() and the leak will not happen as far as I can see since allocation
will only happen when btf->modifiable is true.

>>> @@ -1118,12 +1159,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>>
>> [ ... ]
>>
>>> +struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
>>> +{
>>> +	if (!OPTS_VALID(opts, btf_new_opts))
>>> +		return libbpf_err_ptr(-EINVAL);
>>> +
>>> +	return libbpf_ptr(btf_new_empty(opts));
>>> +}
>>
>> [ ... ]
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486
> 
> 


