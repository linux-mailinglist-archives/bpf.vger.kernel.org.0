Return-Path: <bpf+bounces-66075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9EB2DA49
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3841C46CBD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898F2DEA9E;
	Wed, 20 Aug 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S/zUDHwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hwtC+bbV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B21C3F0C;
	Wed, 20 Aug 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686782; cv=fail; b=FfvAacN4G6EDxhL3ClbvvQzxbTcWdkIK3oZBNCQbhjSF5UjBj75BYrVjDyPPfgrZ/qJttk7nzpIY0ejBgoLerxvoykCS1Od3MQJEfDDEue1zv5/00Tb+KGkDUpX4U4VSv0P44owOP5CvQAkK4bmaCNWxTC+Oqv3ZnYtJE38PMGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686782; c=relaxed/simple;
	bh=mMU3rGv0mZfuvJ5HNPEvecFYKbtH9aJ/6/aRAT7PZzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoJWxwrVrGlkah8x5+yOveicpPATXmviC2o9qaUPy21LHmt/mOyhkSE/qxTDy8M1ExtN4a4MB2TDbQ5vnnIFFnFm4+bHq+nr3pwrNIO9GcrBHrXXMs1k/O4sac2fOJGu91VBvhEMnBxG9ShLrVpXD21uBNuDuGPeu+g/6nRv7Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S/zUDHwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hwtC+bbV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAI65T024578;
	Wed, 20 Aug 2025 10:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K6KJNB9VwD1GG9cA2BxXMQhTuKGwZG9LaKvt50c4M9s=; b=
	S/zUDHwQHSxDC8RIHr+ZD96BymQp2dp7ape3QTmOOEaXk+lpLXDjO9G0sYr0AHAA
	SYNORELvj9siTXB6qd3PByCdes8p0QusVq9Dw7sdCBB2ml57vcxq5TRvrWe3oSAP
	C6KqpIe9+ByKKlKl9+xhH3xpT6TJMoZutysLBL//0goOgCMwIgQ8rvtbKUCqAddE
	wNy1DNQqzAygsPQYoNhX12Xi58YlTmjreb2Yv1zmiRYWIzFTGFUu4XoiEtxnJB4Z
	MOO8Bm3m1cg2OHSLPAn9+N8/NI/9R32BcqCkjwO7UuHgxe1I8pVoFTB0IsiHIT1B
	wPwB1IoAggRgV1QrMPBrIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trs0j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 10:46:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA8OOf039497;
	Wed, 20 Aug 2025 10:46:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3qkfta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 10:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1Umr5jeUf2F+hS3aN3D21ys0UOWy0XUcudC+sBWKTUKXhUulTc7ZOiCE3iY/QVn7UpJwnTBgnDnAfHOHUuB1vspkcu/IBFg2QTiKfMjVVeGgf9BTzpFOiXfYEj0qnEyi+SiHNUZn7DDsj7ibxnLJF+I0bc26+v+LjYkD5bAQrIORAfiQekaOg3zlxgUl3p/qb5x/7njB8TbMN68Artc7yLlA7qtZzUrPEwhjOMENmtq27ARaGiec18xxIImalxS7bksA1VzMnbh4BNgOwy7yDvACaptAL307o5N8B4YddWdTSYcwrVTNSWXo/HpfTkNEDAV1Uv0s6O4ztEOnfIGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6KJNB9VwD1GG9cA2BxXMQhTuKGwZG9LaKvt50c4M9s=;
 b=MaM4xJWV2PnOGuOuEVSEPpB9A53ggF0Y5v3HWTCPmfM+iMh3o3V10bEYA6GmWc3GoIuOQg7Gu3ClszgGumLy3S7YB1HZY0QuZ1yzR88lloq+ec8YE86IPNWOkAA0gMd64yo2MBWB26XGn2wpYGmjWWQ30dnYEFv5EtdMvwCSQbQoWxz3ml+IMnU4dFAooMsNby9bLGt3MwkN55KFVAMAKTDqDcfHJHqjVmneOAcxezKm1QCrCvGuoImowUgsuE/TbXYAh5GeHi2UkVy1kTDKf2ZOg2WCeLlI07/pNS1Rbn3NLYp5It2R0VZvNeP8No5CB8ahWCCur3w6Zwsw5n0cwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6KJNB9VwD1GG9cA2BxXMQhTuKGwZG9LaKvt50c4M9s=;
 b=hwtC+bbVwfyhI8q8K33KFPmgAhWmnLbsOjqA1wdrt/br6wjLkb7C/Unw5g10XF2mRrFE5KLbbnyEjgirs8yqhC7+C9Q+b4LKD7Qf4GY+QwE61FOO+19htTZSa32nYDnjhUpOe6CNrGw22EXEmtBC5Yuq8dz0t6gh5wUQ+olXS0I=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 10:46:11 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 10:46:11 +0000
Message-ID: <4d051523-8123-4911-9a0d-801a963568ba@oracle.com>
Date: Wed, 20 Aug 2025 11:46:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: "Segmentation fault" of pahole
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Changqing Li <changqing.li@windriver.com>, dwarves@vger.kernel.org,
        Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
 <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
 <7b071d63-71db-49d4-ab03-2dd7072a28aa@oracle.com>
 <979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev> <aKOSqWlQHZM0Icyj@x1>
 <ad67ade4-f645-4121-a4ca-40f9ecb988fe@oracle.com>
 <acef4a0e-7d3b-4e05-b3ca-1007580f2754@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <acef4a0e-7d3b-4e05-b3ca-1007580f2754@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bac4dfa-72a1-4a14-9db6-08dddfd6c6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnVZTjNPSk1QNHNrVWhzU2trYm8yZUVLbGtiK2U0TjFSb2RUWDFuWDZEK29n?=
 =?utf-8?B?NGIwenBRUjdubThSVmEwSXAxRUxzOHJPRkREWE55RTduZ1ZteFNmNTlET3Bw?=
 =?utf-8?B?SFFLMDdOQm1Mc0NNeUI2c25SbTgydmx2OG5hcGpGcGlZbS9TSnZHTFpsQ0xL?=
 =?utf-8?B?VlBVb2JBN1Z3bFhnL3d1YzFjUlZjYUE5UFlRMDFlV3ZUQTdxTkZ6WisxbU9Z?=
 =?utf-8?B?VElKM3BUWU4wL0VPNWNHYXZLeW9NMEQ4VEFuekNCSVRvSHp5WVUzeWtIc3F0?=
 =?utf-8?B?enVOdTNTZFVNbk9UMGRjUWc4NjlvNkYvVjQ0ZmZMaFhEQ2xEVTRFVlFqM3ln?=
 =?utf-8?B?bTZpcHpZYTlDVG1mVTRKZzFyRVgwVi84TmwzQllzY3IvWnM4ZXNMNVdmNkVK?=
 =?utf-8?B?SWt1ZXoyOHZyblZLNCsrZEhaVHp3QVo4YlNkWERpM3hQYlpSYSthbVFWMWRY?=
 =?utf-8?B?VUVQQXZNOUhnSG1lR0EzL2lVL1NaWElHcSs5V0hNMUs3WC9QY2FzdXJ0QW0r?=
 =?utf-8?B?Tlk3TWUrQnQvZzRrYzdHNVlpVjRZRFgwcUtNdFNPMTdPbG9WTzUzMVZFdG1w?=
 =?utf-8?B?SWR3VjMxVnlWWW55eVNjTVhOZWVZUTBaN0c0bHZnOVRrdGRkanBxVkFFNDZI?=
 =?utf-8?B?QjljT2oyVVc3c3BFa04xZlQ5MG9mQ2NSWGJLcFFtSENFaGFkOXM0aHVtMnNX?=
 =?utf-8?B?ZWJjTXpCMW9ESDdpcVh3NXJseXV2SSt1WlV6bU5QYWp0aVRnUTRxaHl5YXdz?=
 =?utf-8?B?ODZBZUVrZERIV24rNlRhaDMzc1Q5Y1I1YjduNnZkS2FZMTAxV1VsZzFVdmo4?=
 =?utf-8?B?MDVXRXdDSW1pN1VuUTY4bFhRRm5tWHFyY3B6S1NzeC9LWmJLa1BUR3loV0dR?=
 =?utf-8?B?aEtOK0trY1dySUIvRzg3Y1pzaVU2SzFjZlpYeVhOOGdMNHVtc0Zpd0N2cllX?=
 =?utf-8?B?emRYTUZvcWhxNVpiZjlhVHh1Y3pVNklPVVkrQUhUUk0vRUZ2TFNFZzZKanYx?=
 =?utf-8?B?OUs5RXpnOVlUaFRUTXM4OUN1T3pLa2pDZWhQb1ZwYTY4c0pxbXdDQlp3aW9N?=
 =?utf-8?B?dVdROGhHZ29xdTg1UDlCK2xqMDBySTNLMXJWY2YrK2hxWFVxMm1EWnU3WUll?=
 =?utf-8?B?RnhFQVFCc0llNWhka0NMYlhxN1Nld2h0dXl6T2hPL3FiSFgzUlJlMHFoM1Zn?=
 =?utf-8?B?VXRrbVJCdnJtdTNOb2FkS3lrMGMyaExaOUs1ZTUxK3dZWXhmaGIzaDhSb0Zx?=
 =?utf-8?B?T3ZyN3FPeUVJRkF6WW1wTS9KY0V4cW1BeVJYUGlVLzFvcHJEV2RzcFlGVVZ1?=
 =?utf-8?B?TStpQkZFbkxnRWxSRi9GQ09VZDVPR0I2QnZhR1QvS202bERNeE96RzJQQmQ4?=
 =?utf-8?B?VEI0WU84Wmc4STlYTk45VlEvVVZEY0Q4OWFZaCs0bS9PZzhUd2FPUWIra1Zr?=
 =?utf-8?B?NDRUanBWY0JFY0FRcjM1WjF1bjc0OUJxUnV6YzVESWptLy9EdXo3RXMrWFZL?=
 =?utf-8?B?QmVNZXpua3Q5ZkdVL3pkbjVOUHRHTm5NeUoweU52MEY1L2VJdnVHdEthcUhL?=
 =?utf-8?B?N3pCbnZxL21lZklCaXNJVDBFQWR4N2JjUFlzYlNIYzk3eFo0VVVLcmQyVjJ6?=
 =?utf-8?B?S3YySEVVYWJ0cDlOUnZ1VmF0LzkxMy9iUHd5ZU11U1RHYWZ1ZVhXV0l6TmJi?=
 =?utf-8?B?V3BjNXJMQlNMVHNBdCtkaGRVTDFiNWV6Rk84QUhGYU80a2F3KzdqMlE4R3Zw?=
 =?utf-8?B?ZUVyNS9Zb3pZdTBVU3AzakJ3VzlRNU0zeXpZSUJWNnhqd3p6dVZtZGg5eVFW?=
 =?utf-8?B?Z0hGbWR0RFV1UllXSFlkYklFWFJjdDF1NldVS2Mxakhyc0dzbG5ueDRZdHlI?=
 =?utf-8?B?TzF6TE5MaVYzcDNmTVpSeS9LbGl6bm5tZXYrVDJkdnlmV3FJN0JoR1AzcTZS?=
 =?utf-8?Q?4NFqqmDiMi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVaektWT1FROXNMczgxQ2VJSTNnSTdpbmlpVDVPUjZDYjVtZGNDUzdSZVRn?=
 =?utf-8?B?SFZjTU1pYU9ZSXJUelJBUm5SaWlON1E3MHJzbkdLQ1VpVDFLTXhVQWtCd29T?=
 =?utf-8?B?Z1V6M0RJQytWZTlodGd0eXlnUWdvUWVuWksrWGdLL1NWdytYYkFnQU1ZQXJV?=
 =?utf-8?B?OEwxS3JtRkUrMEsxSnlUejZkVFcrSWFMZ1B1YjNMN3BpV0Q3bUFTMVNiUVVX?=
 =?utf-8?B?WGo2TmRwN1M2WlhuYThpQ21PWEtwQmcvWnp6cDNjQ3luSS9WemF3NW5lQkZY?=
 =?utf-8?B?bCtkbVNUYlFiSGdXZll6Wjh6QUZER1VraVR6a09aL0VHaWxoVXhMbGJNblRY?=
 =?utf-8?B?NW8vRW1qTjNWc0VkSVdRVWNNOWtjdXpLeGF3aEFqejE5YVBqSE8xZFdLRkcv?=
 =?utf-8?B?TG9VSjJIK0NYUFV3dkRjSFl5QzY2ZEhESU1XMys0N2ZHR1pGdzdJUCtzRUVO?=
 =?utf-8?B?Y2hQZWprRDVQUTRzN1hVQVdtV25hb0ZaR1ljSFZEUE5MeDFFeEpjV0p6RHlq?=
 =?utf-8?B?Y0tKaExiOWduTDBhRDZIY0s3OW1KWWJqMEJ1STlvQzJ3V05wRUFpKy83U3Bu?=
 =?utf-8?B?eWxHeFd1TXJCVlkvc1Jyb3lWYUlnUllxSFEzNmJSMys1ZTVzSENkN1poaUsv?=
 =?utf-8?B?YzZXcWx4aUtVa2IvWXVQNVZtK1o0UDl0WWdUL2Q2ejFOZmZaQmdlRHpveFBo?=
 =?utf-8?B?TXZPclJTMy9NWGlzdG5ieGZRb0I3ayt5Z2NlNnZySitHbklFc2hnb2RyZUVu?=
 =?utf-8?B?azZ6Q3V4OXNUS2VkWFBmWkpKZVVzS1VxZGtjdUVPc1JkakV4M0ttalcwUW5h?=
 =?utf-8?B?K3kyNXpGMVFlTmplZ21ZOGRwZ2NrR0V5VmIyaWtINGU4ZnBoa0FRd1lqOVZG?=
 =?utf-8?B?WUpCVUlRMlUzcEFVeGZYaWxqQTFVRGdKdmVUaTNuTHZNNzFSNFBYdVUwQks3?=
 =?utf-8?B?OTA1ZllLaWI2K20yUy8vRTU3WTJJYjE0SzRwcFpDU05uMmdBWWt5ZkFzQ2lP?=
 =?utf-8?B?eDRodWx4M2VFZ2VLYzV0SUIzUGRPbkZLQzJsdXQzSjJEWFoyck5oQnFONHNE?=
 =?utf-8?B?OXhRcEl6ZHFlKzltLzdEUHY5NHpPWTRoWlJrK0RPZ3JHTjN2UVZSdCtieUZM?=
 =?utf-8?B?MW5JZ0RkVWtlc3NOUkhlL3p5MW43Tk5ObGFqd1RyWkxqaUJ5dUJ4Q21FUnE2?=
 =?utf-8?B?cURYOGJTVm9nbit3UmpUQk91Nm03WHdVVFVDVWJKOHdCd001Z25VbTJjUW9a?=
 =?utf-8?B?WitnMUFTeDB3ZHZPQ0NJZ3RsSm10cUVxbHJTcE9xamdyc0FaSnlCaVNGVVJv?=
 =?utf-8?B?dllnWEdlWFV6a1JnQXlvUlJSM05oZUZrVDlobDRvTDVkVTdocml4WmUzYTE5?=
 =?utf-8?B?YmptRGRFUU9QV2tMaGltSnZ5SWdsanFUT29IR3lEZWlMcDFBV2Q4YStXaDd5?=
 =?utf-8?B?UlNKZXZFckJGSjZ2K2w4MEJiTnpwM3laYnhxdWRoOFVGY1BJdXRldVhkRkp2?=
 =?utf-8?B?aUF2cWpoUGgyMUlOaGRFUzlsMXZlZUNndnVjS2cveVp2MElxT1FJUS9tYUVD?=
 =?utf-8?B?RHJYcGcxckpaZitGRGRqN1RIZE5pbGpPc25GSVdJNXdxTHYwZzhrN1hhZHNv?=
 =?utf-8?B?dWlJanJ2dEltRlBSWmNQY2JDbVd1RzNoK1pqR3BnTCtpSWsyUDN3WjZpOFgr?=
 =?utf-8?B?YXljNkd2UHdzNmZyekdOdHVTZXNmanJJVUN1c0o4VUZnVFd0QWlIM2tGWWNU?=
 =?utf-8?B?blBSYTN4V0FTaXdPTjdERkZhMEk4Wm9pK05uL3hqU1Fqb2pyUHZpcEgvL0tJ?=
 =?utf-8?B?OXlpdnhZUUM0M1ZuU2NqRWZCT0ZId3JpV3ZYbVd6MzJVRk5aMXh0eGY1Y0tS?=
 =?utf-8?B?QUpkMC9VcXFKbTg0d2REYVYvQkhXajNBTXpkSGozb3VIc1V3dTQ1VnpFczV2?=
 =?utf-8?B?Y2h0Q0s0SzZGVnExem8ra3BkYll2NWJIM09ReG9KQlNZVER0dHpQR2VySUJB?=
 =?utf-8?B?UU5JUCtYZzN4dFp3cHN3NWd0cXFCZ2RFMVVYYVN2cmpuMlVsYUxPY2dFL1Zj?=
 =?utf-8?B?d1M3SEtDK0xrdlJCTktjYnRWeFRvcjdKTkhwWDE1bVZlS1dxczFwdHlqMHpN?=
 =?utf-8?B?QmJBbE5BTHE0RzQ2MmdXaVFHU3dMYkE0U0NibUJHdWFzRUVqVFRQWW9HUCtX?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RkkLtxYPpZYu6Qq1G5O8mOZ1OvuXFGfVkhuCecJy2jeCyNW6dHI/GLNcseBCsZNVuGgjJxDSYmMn829xAtex23XRm50+wxzZW3YmtVTABRrtfFKaxIvrpx7ENEaXCIYrGP4LYzNBvRzEfaJ3Ikl/oSBPHbzh23X4nBjesEkNHQz+yvspEBZI3cmexbBuE4mxRnqM0HuR5OWKJSkBPEdg3orpLdqhLT06E8g8myFFJBmtdDZrclISoId6e1M8Pk46+0XAwXnafxDKKGUJ4cbRuYa4ZOwf/N8Lz8QoxODnv93GGWDQcuBBZJ+fWdK8LACBUJV3A9zoD/arJBkmvqJ051XNh/myrlXDxblVE8ns8w2RDIUB6SVGM8mr/SpL8u7QcR3RuHJ0lviU8sSxcDZ21Chis84RVBtvPNhtoEXOaB4ynTJpCBOH8MP5MREcsxzAFS9K6zWb3Olp8UJtKNoDoj8mHuxujAiNDX70pdy4RsnTSWogPAOscZegFmDIDLJwSbE2BLFWUkwQoKlK7uDwWDaAY903dsxlSwPEu1u5YJqy1RiJiFcnAUibN27IHJInTpzfsYNteQtZbv38xz8kte6egh1JzRubUASvkqkKI9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac4dfa-72a1-4a14-9db6-08dddfd6c6e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:46:11.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCi53PkyHWqFQRXXCvi2uZKwQMoeE15+yyr4aZGVrnM7EXS7hAdOLqoM9wDTmXm5+ZaeV09B/fCjl+hTnGf7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200094
X-Proofpoint-ORIG-GUID: s9osBW5CMMws7-xcGftFKheOlmVIvkzi
X-Proofpoint-GUID: s9osBW5CMMws7-xcGftFKheOlmVIvkzi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX+jcOLZjkmxte
 A3o48jtTUUJL+mTkBWLnGEC8kMEn6JUoWZh5VflqJ3tr+aAWSUXFElehXXZOQ/POhxVeb+wHYHZ
 IS2DSfT7HGTCRZ7Ev3vnZy1dc2iQCxUZb/XW2azVSQHoxINLRbif2db+512BetNhPANSfDjlsDo
 hbIvbDeN0SJUfMlaf8GguLDVwD62uxGoij7glm53p1D7liFPpZrjH04YeVtlo427puEzVKHwsaB
 obhXimZvktRWARmGPEO5mP4qBKo/Xz09Lf8rDV+2HCyoDFiXYKEMKpAceXcS0G/4/gGzVXS0bVn
 qWazE4Rm3ulGHzxvSN7WZ7jBsYsLWO2aTWkanbdtgVQPIq0FNcz9Rqm5oxn69sefehoswTVIO9v
 p29zoS+5XqWhza+sAc+UST2y10LRfA==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a5a776 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=euN4DauYjHrPqZgfzj0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22

On 19/08/2025 20:20, Ihor Solodrai wrote:
> On 8/19/25 10:33 AM, Alan Maguire wrote:
>> On 18/08/2025 21:52, Arnaldo Carvalho de Melo wrote:
>>> On Mon, Aug 18, 2025 at 10:56:36AM -0700, Ihor Solodrai wrote:
>>>>
>>>> [...]
>>>>
>>>> Hi everyone.
>>>>
>>>> I was able to reproduce the error by feeding pahole a vmlinux with a
>>>> debuglink [1], created with:
>>>>
>>>>      vmlinux=$(realpath ~/kernels/bpf-next/.tmp_vmlinux1)
>>>>      objcopy --only-keep-debug $vmlinux vmlinux.debug
>>>>      objcopy --strip-all --add-gnu-debuglink=vmlinux.debug $vmlinux
>>>> vmlinux.stripped
>>>>
>>>> With that, I got the following valgrind output:
>>>>
>>>>      $ valgrind ./build/pahole --btf_features=default -J
>>>> ./mbox/vmlinux.stripped
>>>>      ==40680== Memcheck, a memory error detector
>>>>      ==40680== Copyright (C) 2002-2024, and GNU GPL'd, by Julian
>>>> Seward et
>>>> al.
>>>>      ==40680== Using Valgrind-3.25.1 and LibVEX; rerun with -h for
>>>> copyright
>>>> info
>>>>      ==40680== Command: ./build/pahole --btf_features=default -J
>>>> ./mbox/vmlinux.stripped
>>>>      ==40680==
>>>>      ==40680== Warning: set address range perms: large range
>>>> [0x7c20000,
>>>> 0x32e2d000) (defined)
>>>>      ==40680== Thread 2:
>>>>      ==40680== Invalid write of size 8
>>>>      ==40680==    at 0x487D34D: __list_del (list.h:106)
>>>>      ==40680==    by 0x487D384: list_del (list.h:118)
>>>>      ==40680==    by 0x487D6DB: elf_functions__delete
>>>> (btf_encoder.c:170)
>>>>      ==40680==    by 0x487D77C: elf_functions__new (btf_encoder.c:201)
>>>>      ==40680==    by 0x4880E2A: btf_encoder__elf_functions
>>>> (btf_encoder.c:1485)
>>>>      ==40680==    by 0x4883558: btf_encoder__new (btf_encoder.c:2450)
>>>>      ==40680==    by 0x4078DD: pahole_stealer__btf_encode
>>>> (pahole.c:3160)
>>>>      ==40680==    by 0x407B0D: pahole_stealer (pahole.c:3221)
>>>>      ==40680==    by 0x488D2F5: cus__steal_now (dwarf_loader.c:3266)
>>>>      ==40680==    by 0x488DF74: dwarf_loader__worker_thread
>>>> (dwarf_loader.c:3678)
>>>>      ==40680==    by 0x4A8F723: start_thread (pthread_create.c:448)
>>>>      ==40680==    by 0x4B13613: clone (clone.S:100)
>>>>      ==40680==  Address 0x8 is not stack'd, malloc'd or (recently)
>>>> free'd
>>>>
>>>> As far as I understand, in principle pahole could support search for a
>>>> file linked via .gnu_debuglink, but that's a separate issue.
>>>
>>> Agreed.
>>>  
>>>> Please see a bugfix patch below.
>>>>
>>>> [1]
>>>> https://manpages.debian.org/unstable/binutils-common/
>>>> objcopy.1.en.html#add~3
>>>>
>>>>
>>>>  From 6104783080709dad0726740615149951109f839e Mon Sep 17 00:00:00 2001
>>>> From: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>> Date: Mon, 18 Aug 2025 10:30:16 -0700
>>>> Subject: [PATCH] btf_encoder: fix elf_functions cleanup on error
>>>>
>>>> When elf_functions__new() errors out and jumps to
>>>> elf_functions__delete(), pahole segfaults on attempt to list_del the
>>>> elf_functions instance from a list, to which it was never added.
>>>>
>>>> Fix this by changing elf_functions__delete() to
>>>> elf_functions__clear(), moving list_del and free calls out of it. Then
>>>> clear and free on error, and remove from the list on normal cleanup in
>>>> elf_functions_list__clear().
>>>
>>> I think we should still call it __delete() to have a counterpart to
>>> __new() and just remove that removal from the list from the __delete().
> 
> Thanks for the review. Here is a v2:
> 
> From f3d6b1eb33df182bed94e09d716de0f883816513 Mon Sep 17 00:00:00 2001
> From: Ihor Solodrai <ihor.solodrai@linux.dev>
> Date: Tue, 19 Aug 2025 12:05:38 -0700
> Subject: [PATCH dwarves v2] btf_encoder: fix elf_functions cleanup on error
> 
> When elf_functions__new() errors out and jumps to
> elf_functions__delete(), pahole segfaults on attempt to list_del() the
> elf_functions instance from a list, to which it was never added.
> 
> Fix this by moving list_del() call out of
> elf_functions__delete(). Remove from the list only on normal cleanup
> in elf_functions_list__clear().
> 
> v1: https://lore.kernel.org/dwarves/979a1ac4-21d3-4384-8ce4-
> d10f41887088@linux.dev/
> 
> Closes: https://lore.kernel.org/dwarves/24bcc853-533c-42ab-
> bc37-0c13e0baa217@windriver.com/
> Reported-by: Changqing Li <changqing.li@windriver.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3f040fe..6300a43 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -168,7 +168,6 @@ static inline void elf_functions__delete(struct
> elf_functions *funcs)
>          free(funcs->entries[i].alias);
>      free(funcs->entries);
>      elf_symtab__delete(funcs->symtab);
> -    list_del(&funcs->node);
>      free(funcs);
>  }
> 
> @@ -210,6 +209,7 @@ static inline void elf_functions_list__clear(struct
> list_head *elf_functions_lis
> 
>      list_for_each_safe(pos, tmp, elf_functions_list) {
>          funcs = list_entry(pos, struct elf_functions, node);
> +        list_del(&funcs->node);
>          elf_functions__delete(funcs);
>      }
>  }

applied v2 to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thanks!

Alan

