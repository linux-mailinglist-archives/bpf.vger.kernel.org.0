Return-Path: <bpf+bounces-66629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDFB379AF
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0786636547E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008830BBA4;
	Wed, 27 Aug 2025 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QFg1fMh2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wBCdqzfq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596B278156
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756271672; cv=fail; b=UZ0cvBpULLFdUfi8qD5drOcUQa33SLi1wMtRh1JfKFnwX8sl5TnsNW5uqtyl8epa1lqCj2miFZxL8xHhIYR1NflTC2dh+67SesiITD4oFr9a5X2NGRZHgCxrUEO0SgAzMNvIkUt5b3zELmZEbgYpZ7mEkrRii70rM4g0sJSGfno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756271672; c=relaxed/simple;
	bh=edg9VsELdC6cthD/jR/6ZphARJseE4c8BE14TnE0oxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mZQPwmxMpDPmuHw2ZyfKmF3YsQjj/jpFjiqqMcJM7PtdLXaup3TuR0ZwPXJw7I2nkECcQA1LmleKPzbuOV5W4aJSUgOeeBA6qbgV99EQNzAcYH69JYQndaIcPbNUSTUNeU/8cyqGKiYEc1d0swA+F7g4pbxkee0k1/jI5f6i73c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QFg1fMh2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wBCdqzfq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLLdcH004151;
	Wed, 27 Aug 2025 05:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aZq8DWa3m4Ul8UVEBwmewpMI5netWpi7wRu78dvmTbk=; b=
	QFg1fMh21+JIclKcjCoVIcsE3dvsEhzONuiuhZctt6NI05AY4Slk1XQ6cje7HMz4
	KaVGNJq8PFqHVw49b8YEOMTIpgxeqAc4L1jMguM1zpynE435FEeaYzkb2yYrRcOC
	Fi2A/wTONjaeBIQCWR4wV2/diKUJRDDImxVFNMWUKYymQL/P4bTQd+5KyXh2UyNZ
	oyoEK2/h7AFkXNbriyDBd/9hQWltcVfHE10fKUnR6TjAVBLeIv+/p3KKdj2oU5jK
	ChUmIMWBugXoTBdDmFvvXUD+PEWtzUdrDYQl0YCsZsrTR1J5dGrixt73xEWGHy6x
	v6rB6JWJizNxdNj1eLov6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48env2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 05:13:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R4pLPL005068;
	Wed, 27 Aug 2025 05:13:36 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43age5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 05:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6wmln6k3NOnpJRYghmmrtaWqIovp679Z4xUCyy5Llzrdk7yCpkPYGYGY5PFpuin0i/EupL6Fkmt52rcFP66HCg+9S9Z4iAE7jCzfc1I2pnZpF18Os/jpFdKmTsG6RALhV5BmC1Z5ItWoNgbYIarnwkBgsIHqqCUdmEfeuNthV4HDlLssETwGb8IwDknlW1CNzdBW4ZA+eJKFjtUnzu6Ko5b4ZzU726DsGRhHPPnmYO1C3REmU73o76gTFcehbuqnSOS4UYJ1GfQN/QshCU2Kk5kfuNEGZZprPs/2j6R5z+MTfWL+eym1g+86JCodJOfJZQ1uWZjLtUdn/mSvgxq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZq8DWa3m4Ul8UVEBwmewpMI5netWpi7wRu78dvmTbk=;
 b=yBTJTPPqp7MwjMkDvFA+oXgH7KWSgpJswtQVSm/yN3xx3b2HekT77mUMLZSHKKyxiUvFHzOON30GBi6QJNrJi3zH6r6ew0kmxfqnbUJKTqcxPRPB0z9+tZoMv6UFvzXkI5P+jwrcJ7Ht9su1flDbj64bLKcoXkvnWjnbidX0eMxmcN3DvJlYc+ZFp8zn+S86tkKkQbcIQx6R+k2F9Dr5LFWenLg6Flyvl5WmwUoMDQm8r2CI8318lwG6vRpBtcCRs1fJtPBkyIFc81W6k+MApQvPSw0LhWj7NRf5udx8Z8ZUuvaUzHJWbqWYDkHnKgWhpUkgzuXDSh7lDSEJ2fsCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZq8DWa3m4Ul8UVEBwmewpMI5netWpi7wRu78dvmTbk=;
 b=wBCdqzfqrAr8skEGLKuw7JXcRDUn6+YT6jtxfxKHl5r4UtEpfLf1BLB3yEisfd1cpE4xm2Roas2khK4FWKiBHCUtMF6MYIY5fPRvZIrF4ocPka5rdhBZM6VVkedcokekpKWSA06qkFZLgDunT1n6bxgDxvz7nRVE+SB5ow6Kkw4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 27 Aug
 2025 05:13:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:13:23 +0000
Date: Wed, 27 Aug 2025 14:13:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aK6T4B4ohbh-Z9W8@hyeyoo>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com>
 <aKvqT-BAXGkjW7JT@hyeyoo>
 <CAADnVQJ3vhBsRqgYEG13neTuXbSU1hNngYmWHqKCLTRr8+QVhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ3vhBsRqgYEG13neTuXbSU1hNngYmWHqKCLTRr8+QVhw@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0003.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b195c63-9abd-422b-e508-08dde52871e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlBSYUNLcHpEYlJXRjd5d2V0MTV3dDJxUEptNUJ0OGNKOVEraGRmRUtZa3Y0?=
 =?utf-8?B?cGYydGkyTURkVTBHK1NESXIvRktEcDVwUFNvdTZDcjgvSDFIc0l0RHg3Mllk?=
 =?utf-8?B?MkdndVBjL0hSV1IvU0RoTys2c2FTZmNmTkF0OEFhVTB5Y1p6ekNYdmpPcHB2?=
 =?utf-8?B?dTZBSVVzMy9IRTE1Zy95TG1BKzhWalpuQm9HYUVhbUZ3QVRLRDFtbHBWaEYw?=
 =?utf-8?B?ZnhWVlRSQWxHcUZOM3JRWGN3Sld2WW1zd1ZHdlg1aTVVMUhPT0l6dFB6ZnVp?=
 =?utf-8?B?RjhGWDJFajlUdFV3RGpwZjA5TmhwQVpqa01qU3c5MnQzT3M0T05OU0hWWjJ3?=
 =?utf-8?B?L3lYdnM3bzl2UXJ6M3FVaktMVXg0eVFMRE5TTjBrc2swdDNsdVJpZ0l2bHd4?=
 =?utf-8?B?dmdOakphaTZjcGhhZk5sTExVNnhoMEE2R1N5aExIVW9KR3ExK3NQbms2Z3pw?=
 =?utf-8?B?VXpmWk1VTHNsOUdCcVlQVmhZTW5HRkpBb0xxQWxORytQdUlZTHpmM2Y4MUt4?=
 =?utf-8?B?dnp3UXY1M2hzL0t1Vk0vUlZNcUhVUEF0K1NBS1RoNXFCdkJ4MUNRdlQvNDRG?=
 =?utf-8?B?ZDBhVjNVY1J5UjliajVzL3daajhIK0FLYWlkN3ovUU54UUVQcEdYd1lISFNx?=
 =?utf-8?B?TFRrbnVjSTllUXZLSUxTRnpoNTZ5RVl0VWdUeEVPSXVOeVROWmd6bTliZ0sy?=
 =?utf-8?B?WlFCMi9yWTVKR1grQzlqRUxkYWZIcDk0elRsNWtWa0ozZHgydUxTWldLMlRC?=
 =?utf-8?B?VS8rUVFIYmFPTnRWV0dRL3V0R0VuS3hLbWVXY0p3aEh3ZzZlNUIzRG1oeDdi?=
 =?utf-8?B?V2RNQTFrZXU5WW5MNGVPdDBBRUFXZjdMZWVrOERRUlZPN0VxTDRId212c3h1?=
 =?utf-8?B?MXI1dmdGaDBLSC9uTHRWYUNaS2pLcnN0bjZnVjhHTDQvSWlMZ0ROVEd1Z3J4?=
 =?utf-8?B?TXFCV05lZTc2Sk4yTjcwTDBsQXcvQlJkcXpLY3NCRHFHVFJxSEtMd1h3QzVn?=
 =?utf-8?B?WGVJbEhKQ3VNWGk0eUliYUpFV0RJTFFiRjBkSmhVbTZYc1BIUklqRFMwV1dv?=
 =?utf-8?B?OXkwc0Z6eFV4RVI3UkdWT2VYYnVqcGczeUdNRVo5a3RVZUE0QmRhekNRdjBR?=
 =?utf-8?B?V2lxZDVLTkpzdVJtbGpKV291cVJYVldqejltdlpaYkppZmRYWHNxYkRBR2xV?=
 =?utf-8?B?b2YxZ1pybFJmTkdhY3FmeE5NaGp2elN6a1AvTVdUMmlnVm5yZmhma2F4cnhK?=
 =?utf-8?B?S3dZRk9SbjlwN1Y0VGVSaFYxbGRLeXdHTkZHSVZka1NadWJnbnIvdHd2UGN6?=
 =?utf-8?B?aE5FRUczNWRScFVNa3oxcTBWakxpUVIrQ3dDM2c2dkN2RXN5QkFqaGQ5MmE4?=
 =?utf-8?B?MElyZStzVW5SYks4d2ZvWThLdEhPQ0dqdnY1QndyUDNCU2RUL2s1NU9xYTFT?=
 =?utf-8?B?d0Q4alU2Njc0cDJ3Y2pPUDFWRUZZOXAvelFlaFJNYytaUjdDZ0ZQMnRUK0ly?=
 =?utf-8?B?MXQzczNhNDBRM3BUNUpXbEZQdmU2WjJpRVFwaG1QWHExY2VEeGw4WDhsY0Rt?=
 =?utf-8?B?VGdGQWthbjB1WkwrbkFuQ1A2NnJjeDVjRnlxMHBCemZvQ2hMRCtUR3JVM2w2?=
 =?utf-8?B?cjdJU3o3NnZyVUFVWnZYZDdYWmZoOVA3NjI3RDlpb0xQeXpOMnJTMUZNd1ox?=
 =?utf-8?B?RVZMdHQxTGtQbTNDTnE5QUJnY2RzNWw4ZXJZZXBwRVJFejlLVGNib29sZXVN?=
 =?utf-8?B?Nk80NStXUGJkQklqUEhYZVMwWFFzTmZxVlNaZFFmMFpsNi95TDZERzlLOXAw?=
 =?utf-8?B?VHRQc3RuWVBKaFJLYnFtUlkxQVgyNnBDbnBXdmFXNDhEcmNGTFg5VWwxejcr?=
 =?utf-8?B?RjFiOGJCUzhWdUVCSk5Tc0dJLzFsYlBqVXFRY3c4R2VSdVJVbmZ6eHAxNitC?=
 =?utf-8?Q?uWXFV+CLEW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejJRZWVLVkY2YXhhK0hQS0ZUaSt2MlEwUXorcjV1TTNqajUrWlZVV0ltajkw?=
 =?utf-8?B?N1R3MUhYMGt5Z2QzSHdmalRZY1diZDBad2htWlViTXkzdGJ6S2lEZzZ3L0Fx?=
 =?utf-8?B?VjFzbEp0Q1BLTFdBVTZvbmpGS3VjdFRsRE5BeFdVd3RmdEFPWXUzOUMvekpL?=
 =?utf-8?B?MmoxTjZTQ3Fpd1JtMFk0aE5LQVN4TnNVaVZSem1kVFZJT0hyclp0KzM1dkJR?=
 =?utf-8?B?SklyWHRJdjRUWGJJV0x3OCt3ZHN2WXZpVzhEaHgxTkhyaXNvMUI5djNhZEtB?=
 =?utf-8?B?Wkw4QldFSmMrdHp0QlhHODdsYytjcmc0eGxKSlhFTXUzTTFhWVpWMXBCc250?=
 =?utf-8?B?dFRldEFuSW9BZ2dod0t0Q1paMUNNY21oSllRT3A1OWVoM2twenlnZHVpRjQ4?=
 =?utf-8?B?eDZQWWRVR0pCbXdBWVdDL1hRNTcyTVE5UFBvSldPbEdtd2UxSHB0c3VsWnBG?=
 =?utf-8?B?aGdSNHZnbGpWdWlEQ0NBUkJjcjg2NU1lM1U3Tm1sRDBzb1V1RjJST3dJY01V?=
 =?utf-8?B?YzFDdXlzemNBeWFQd3I3bnpLd3BkMTU4bnVvUTRZb05nT1Zpa1UwY3UxY1JS?=
 =?utf-8?B?UXFpcmdmeTZCcVN5Z0NId0owd3VYeFBsSGtrMVdBeGNXMUh4Y1FOVVIxRm1K?=
 =?utf-8?B?TE9MZ25oLzZoenVzZGRseUFoZG5OdS8zMHZ2K1hwVEVXS0EySzlmQm1sUk05?=
 =?utf-8?B?Zm91a0wrTkNrVG1kMVV6ZWJhVWV3bzJWc1dwZUVXY211NXBXQVg5NWpoRHcv?=
 =?utf-8?B?YVQwQWZKTmNNdUxWK1Q4VTBUcFBGN2orZG9rVWVHc2txSTlsekhtRzgwNnN6?=
 =?utf-8?B?Wkt3QitwZlo0eTVETDgwRi9EbmtpZ21ibWZNbnh3RlgzckFLbGhsMGlQZUt4?=
 =?utf-8?B?YkJ0WFVnQ3NCemp3SmpsdXovdGY1YnZCNXFxTFhKZ3BJTnNTM1M2eGV3K0Zy?=
 =?utf-8?B?cVhWOGl6S0RBNGp1clJ6dWsrNGkyN3RvRnJZbk9CaEgwZ0FhWlI1ZnA4cXZY?=
 =?utf-8?B?a042KzJTbTVVQ0xHRTdRVWhjTkZkUDlNNXRlQ2N3MndTTzk1a3NmSE9va2w3?=
 =?utf-8?B?Z1l0VmpmQVNQYTFLT2NHVDU5b0JZZ3pPdzEwQzZlcVlZSHRvQTdBTHN4OGJO?=
 =?utf-8?B?amYzQnJFOGFlVEdOMkZWVXBNUGR1R01DM1R3Y1VSWGd2Y01tVFFVSjZISVU4?=
 =?utf-8?B?ZnMwMEZwcTYrMGZwc3V5TEh1UzZWTURMWGw4YW4yUVdhMnZQejNkdVA5M0Vr?=
 =?utf-8?B?TUpNcElTTlVUUWVvdU1GZVFQZElzSENaMjRaRE9jd2dRRWlwVjFNRG5nQ0R1?=
 =?utf-8?B?MEZ1WUUwc2o4RlpLMUtLeUM0OXNWeXRpQWw2aU8zWmRtMXRoREZwY1Mrdk0v?=
 =?utf-8?B?czVrOVRNSFU0bHNnREVieHJKQmMxS1FudFVRL29lVjlRWHUvM2xMZnV1eVFn?=
 =?utf-8?B?dkRsc29zOFIxWlBVUjlCWlNIL1lqZ09ydGJ6azhYL1pMMzVRbFlET3hKTzU1?=
 =?utf-8?B?ZnZrWlVMTEY3dGNPQ05FcWlQcy95bGo5Tkc5RzFBNlNUd1cwb2tqVSt5NGFQ?=
 =?utf-8?B?djg5WGpYYUY1WlNNRUxkckRUcWJWem93bjRiSFZDV1pFRXFabEF1ZjRBZWZE?=
 =?utf-8?B?YW5DanVTeDBjUExvWEYrUGN3S084b280dEdvRVl6cXV1N1pFcUFva3p2OTF6?=
 =?utf-8?B?ZEl0WEZhczBhSlY5MmJKTTBMM2tEMXluYi9uREp2dGFRTC9YOWx6WDREeU1K?=
 =?utf-8?B?WjI2akhYVUlaMEdjUUNYZkh5SVBoQ05pbXprWGh1OHJIcDNkUHlwUzhjNE14?=
 =?utf-8?B?L1pMRUY1SWgzWThQdFd2OU5SNFpVTDgzZHRTQzFhV3pNUC9nWFpsOVdpNEdz?=
 =?utf-8?B?QWNZUGZ4OXFxUWk4K1duVUtjUGNhNFIrYjBjMm9BZy91UlExMDR0YXdBakRu?=
 =?utf-8?B?Wk40TWMzUENtUVd5U0FJeWZ2Ryt5TlpsQmlTYXI2TXRhNUpESUlBYUpXSkE4?=
 =?utf-8?B?VTZGNmdjdjhEdDl5cHo1Zm5iUllheHlqTVROMXRPNGpXTnBNRWdNdkpmUjd3?=
 =?utf-8?B?b01ZQURUbGt2dWIxcjNyZHFiL3VGR2xOM3ZDMGN0VXFJVGZ5aG5pVVZZc0dr?=
 =?utf-8?Q?CvRqU+DJ3CANQLtRPl0qNcv6O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mlz8CM+1MS1zZmqmWrUASniTtoUxPt4nFx/Jg0H+eNT+6+7o+QZBVjgfQF6wuY0FKRLgjN3z3uuBWuWAb2lWTCus04rxAJ2OSE4JgevHIHein8rJ95Am0ubB8AWziR02lPdL9DAW0IByk6BplNe8rU2nL5qRW1e7BNKzm22U5Z6tvTaJtgtZodizHnCafF3nciLusVDGA4GFI9G0QtK1is+4AB4kbeU8CdPjGQVL5ReYsH4wP3/3SCB6qgOVW4xk0+kWfnIwpnRz86Q/JRXrP3GV8X55G5byNFbKEa5V7e880JTuCSFS/HFqWYlcNYw3bUQuN6yV5JdoFE2mV26FEFNzFAQMvXhwJlWQplA8JXl6y1v0gApVeVmQDDIbbEaMxWkaG+6EsCgIZC8pcBrQqxBBpuE4PLOjsWmTiyM+iuDCSU6bp5Obqa5xWXllUTZxT9GgEuRZ3KhUCEDOnZnhOQzOE70XzFX8enOo0+qmZUBNDLqpFd6FJTto+5uSVzgrdNq6hpy3ouAujvJOQAgzh8VywvIm2r4WPHAa5qR9OBU2Rh3R4SRoBD1XOe1Z/0yCKFuIRkbDsJBB9bTlRwHbOweNqixOLzCpZ3AxrcPmSQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b195c63-9abd-422b-e508-08dde52871e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:13:23.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFH7LRijGBlrslMCevsiaIiOBDMOQsGh3C1hoymfVo37FyYt1qUypyRjtNILPVm3oLNEnHzrKPqVn8Cc00y6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270041
X-Proofpoint-GUID: FSJxnqH1OUmE2yQvK6ofleCB5yr_uZ0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXwKrR0DCpCXUU
 WaVt7m5aQliYoFPyKb12Dzeruc5xmvSJQZQJz23GK1fdsoJJq1pYHZSSrw3xhMpuM4TRCpPRhuT
 P+qT30THBdHLSamMJI2oDU+AXGb3dFAi3BOIgS5CHd2QqlITjE18MkUwg182KXsuKxSyOfyaxpn
 Jt6fn9iy4smSDCFdYCAFyU8wzl4rOUoZt95sKpxkDP57tGpygb0V6AQntc3iOos7hDDYXewTXiL
 nNypxTLl9IeBubJvXk6spq+DvtbHfrJuxy51iZTewc869StvmjAY+Ds78urFPZ0AQkuRhbKdSnA
 DONGNu8HQqrkCm/xfuexIe+JaFe/56FXHqXklVU58/N5YDKDXCUDmHAw1BLUnw4xipct8O8hlI0
 VFwRpWWw
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68ae9401 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=mbAx8V0GlmJLmXWHbtEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FSJxnqH1OUmE2yQvK6ofleCB5yr_uZ0Y

On Tue, Aug 26, 2025 at 07:31:34PM -0700, Alexei Starovoitov wrote:
> On Sun, Aug 24, 2025 at 9:46 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 07:29:49PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > kmalloc_nolock() relies on ability of local_lock to detect the situation
> > > when it's locked.
> > > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> > > In that case retry the operation in a different kmalloc bucket.
> > > The second attempt will likely succeed, since this cpu locked
> > > different kmem_cache_cpu.
> > >
> > > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > > per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> > > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > > a different bucket that is most likely is not locked by the current
> > > task. Though it may be locked by a different task it's safe to
> > > rt_spin_lock() on it.
> > >
> > > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > > immediately if called from hard irq or NMI in PREEMPT_RT.
> > >
> > > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > > and in_nmi() or in PREEMPT_RT.
> > >
> > > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > > spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> > > always defers to irq_work.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  include/linux/kasan.h |  13 +-
> > >  include/linux/slab.h  |   4 +
> > >  mm/Kconfig            |   1 +
> > >  mm/kasan/common.c     |   5 +-
> > >  mm/slab.h             |   6 +
> > >  mm/slab_common.c      |   3 +
> > >  mm/slub.c             | 454 +++++++++++++++++++++++++++++++++++++-----
> > >  7 files changed, 434 insertions(+), 52 deletions(-)
> >
> > > +static void defer_free(struct kmem_cache *s, void *head)
> > > +{
> > > +     struct defer_free *df = this_cpu_ptr(&defer_free_objects);
> > > +
> > > +     if (llist_add(head + s->offset, &df->objects))
> > > +             irq_work_queue(&df->work);
> > > +}
> > > +
> > > +static void defer_deactivate_slab(struct slab *slab)
> > > +{
> > > +     struct defer_free *df = this_cpu_ptr(&defer_free_objects);
> > > +
> > > +     if (llist_add(&slab->llnode, &df->slabs))
> > > +             irq_work_queue(&df->work);
> > > +}
> > > +
> > > +void defer_free_barrier(void)
> > > +{
> > > +     int cpu;
> > > +
> > > +     for_each_possible_cpu(cpu)
> > > +             irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
> > > +}
> >
> > I think it should also initiate deferred frees, if kfree_nolock() freed
> > the last object in some CPUs?
> 
> I don't understand the question. "the last object in some CPU" ?
> Are you asking about the need of defer_free_barrier() ?

My bad. It slipped my mind.

I thought objects freed via kfree_nolock() are not freed before
a following kfree(), but since we've switched to IRQ work,
that's not the case anymore.

> PS
> I just got back from 2+ week PTO. Going through backlog.

Hope you enjoyed your PTO!

-- 
Cheers,
Harry / Hyeonggon

