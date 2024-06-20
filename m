Return-Path: <bpf+bounces-32574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14B910024
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D71F227B8
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BB19DF93;
	Thu, 20 Jun 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="faTj2LwH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GmTSidCH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80B19EED0
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875119; cv=fail; b=Wq9czU7FV1j9f/W/1OPzw4tDVGCStje9nCaCZNY81VL3Gtgq882TYFsVRsU3/Q47GiP8FcuoiVr6Tr2iSKTVGznfGYueY3LwMAgyEgTup7cIY71l1oDofYpaAzZvffZOWPhGLPDzD56W2qpf7Uhv+bZbnU46fket8Ibp/PhoQfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875119; c=relaxed/simple;
	bh=pJ3YtE/pk3kkyiFWCq+YohROon0AX4xfKNusg8Dl4Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubLphDZKzPNXlntQHz0JbNuUa/zHNkN2ZsrPsu2WuQyVXAKvZPQDv3/HCLTgvouBaruh4B9DH5o+eLUpmG9S3ncVseTSog/hQ1R5jLnSCVjaVyEy+uhrsqAc6s80yxmHl/B0dUrmnGfbbGjdDaAMYEvsxXADosmE/mY6iGbcwxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=faTj2LwH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GmTSidCH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FacV018376;
	Thu, 20 Jun 2024 09:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xzKj+un782F9lB/wY70Se5FmVOFOZIZPuO+6gvaPFXM=; b=
	faTj2LwH3OZjh+IEZv/yEHK7VSJTXBl6nOjFGkIXfwTuy3U3tF3LLqLXTC0h2nhJ
	Ou6PBVws1Oew9LLL6wCnK8HkrZ77P7cvzQQLLOV6iv3rW0c8iwG0JX5j/PvFJHyC
	+RCRpWrKo8Ql5EzZn5XcI1E9BijYeV1AiL/VWOz+6r7iKxnyUUKIXsNhiIZf0Zgq
	lMWXk40iDOVwsd2qsc3cLnmNuUxQHdFCoIPZeicPaVVpURmek1edwIDRpcFsEoKx
	8qMH8xmEYoFM/iSGYrja0166ANlx0jYJ+ywmguaeDgTFCDVzqpC9QZemVjAx3VLx
	6DsNWFcbFir7w1ys0MQ0DQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc0as4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K8MQS3034810;
	Thu, 20 Jun 2024 09:18:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1daf4r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLOrgy7f4DyCJkLw2riPpOzwPaHYr7l85wAgZnRyTG6h9R3XFhfqeNB+C8A8aifaMoi/yfxEKP5d1r2jfSbGjpBvVgzpjCP4KYwnScnGwZA9A4E8q8mI7SRav74ehnLC0TOOAO0bu+sjyW8IEaqpmYW0NtQnimNp1Y0dTp7MUZGv+n1fYzNyb03s3pkDPbiBExK71g+l6lJLakeaz3cRG9BiNXmICyCLldL/Q9Hw4AbJ9XYFkalrm29JDT8XNuxY5/K4oDQrcavhivI+IYadX7DJ0bBFBmuDg78j0hv3Or8Xp/P4VlAhRN0pLIx3u1OKDT7Qg41RzqLrHoE/UDjx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzKj+un782F9lB/wY70Se5FmVOFOZIZPuO+6gvaPFXM=;
 b=WqfSp/VdRhV8ZkHpNmQXxpuoBEiqzT+i/lNRi9g2Ib4NyUi0iPQaAd1KZmb8gPZS6X3xuSlgpI4O53+t53ndxnsSH4Q2i+YDuj+wJ2NcwxYO9R3fXHrrtoR/lXTfs9Qb7fJM3E2cOaG4sfAJiwfgXqNxMziTB2bglOHJ08NiPz/I2iMg+8W3FwsTlqin3Xie3KnxNBhZaGb+iv1AJaYHy0CLs4elmv9mswxGca4z5TZjvp2cFZlZGLGZf1f/6LEUTn1mD6PL8SJGJ7b9vTfWPLuIzhiAcoqIryrOPq8erHe94JrWqxf9UhgMOllwFregLIVqX2C5Q3KU0duEPcA4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKj+un782F9lB/wY70Se5FmVOFOZIZPuO+6gvaPFXM=;
 b=GmTSidCHO6UBYYmLIs2ubQIUdaxYlIpTy9i41IT3WXwL8O5HdBRXUN3xdiSDcRydtFMiW4TJCb2534QgSyouq/Pa6+9DVOiqN/FHcAPRmyNT4VfpAXJrujlYcT2oOHQn9pihQdYaEKrq8Vp7vUATV53rlydcjfEI7kECLm+gMeM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6843.namprd10.prod.outlook.com (2603:10b6:208:435::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 09:18:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 09:18:06 +0000
Message-ID: <fd9268b8-994b-4b4f-a4bb-d5852c823152@oracle.com>
Date: Thu, 20 Jun 2024 10:17:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
 <20240618160454.801527-6-alan.maguire@oracle.com>
 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
 <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
 <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
 <9359e765-c341-4164-90fd-78feafed89d5@oracle.com>
 <e17f8c4d644a6f4aa80de092ee29e6c1e5e77c52.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e17f8c4d644a6f4aa80de092ee29e6c1e5e77c52.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 9586184f-137a-4665-c1e4-08dc9109e533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TmxYbXhucldnbHQ3SS9MdEtRa3gvanNoZVNZbWhpMTdiR2txaFBQZGE1Y2NZ?=
 =?utf-8?B?ZmVJZ0tqYVk5a2EvbnhBMG00VHhTYWJFWnA0LzJuSHk2M3dldkFsWit6S2Rv?=
 =?utf-8?B?UVQ2TWVmVm55aDlLNzBrS2tpU282d1lNMjJGNEpoRkcxWkgzOWNvMmxoVEEr?=
 =?utf-8?B?N2UwcVdQVm9CcStuQlFkT1lFK2VtTVQ2S2llc1VPcTMyS2hzRmx1b05JSUNQ?=
 =?utf-8?B?YkVWOUxyUVlIbm9TTDA2T2pWQlphc1RQSlJqVnJ1RzU5MWhCaEVNa1ZGLzNy?=
 =?utf-8?B?cjdQS0p4QzNSSHR0OTh5dzEwYXkvRjgxa1lxcVRVSnNaTDNsb3J5b2hyakcx?=
 =?utf-8?B?TEE2VE43RGEzNFdkb1VWanhZbTZzS1dRM3dyWDFhNWQxTHhYd2JLS3NEeGVZ?=
 =?utf-8?B?RVdvZ1dtUFl6WGVxNE04TVRJTjNiTGdVekRpeG5QZUYzNzhwL3BQeHRkaXVY?=
 =?utf-8?B?bUMwMndmY2pLQmpWR1BCbWNDcGhpOEMwY2cycWNabEdDd0k5Z2RUalQ5OUh4?=
 =?utf-8?B?cW55T05DYVdjVlZlTEhxajdnNkZubFBiSVk4WGh6QzhCNml4UytzMHFaWkMw?=
 =?utf-8?B?bEhjOW1kWnRFUnF0SDl1ZjQzdnVtVVdqTU83UVQrYVBzUmtMKy9Bc3RjWHd0?=
 =?utf-8?B?bUNiUTF4T0ZDVlluVHBkck1ucHNsY2hZbjc3VGV5UW9UNWdMMmZKVE9nSWU3?=
 =?utf-8?B?Tkl1endyeWJWbmtoRVBEOEdkT0VWclFUNEkrK1ZZTXkyUGVyeFpVYXdKRzR2?=
 =?utf-8?B?bGJ5QlUrNExBRmtkeEJCdFIvSysxYWh0LzM1eWZJNlcvUXhEOHF6cFRlcHps?=
 =?utf-8?B?MmgyVzErZ0tZYnhnWVBpNXJtQVZZbk5VRFhMckhySG9hY045M3NzQWJtVTgv?=
 =?utf-8?B?NWgrQkdWbHF4V3R4WDNmcnUzODBPNmlBSUJqekZwN2lXQzdqanBpUUU3a0ox?=
 =?utf-8?B?WGpxQjFxSFV6SDJQdzJtN3ZmL1BtbW9GRU1jVDVvVyswcndzYzRQOGM2KzRS?=
 =?utf-8?B?UUtLV1VQY2Z0NTRRWFRVTDZHdXdZV2hMSGh5dVBOakZPRnBvK0FlQWNGQlB4?=
 =?utf-8?B?TFhVaER6clJuMzgyeUJ0eTN3NE5yS1BZSWxvRVlHb2Y0YlFzUjJaZ1dRclBy?=
 =?utf-8?B?OGxZWVh2OFBWU1ovYUQ1STFuZi8zM1AwZzhjY1M1Ti9PbTU2RTg4Y3RmcTlm?=
 =?utf-8?B?QVFqV2FJUlhxbk9xOFZUZ1VkWmxidFRZNk14MFIrRnpiUzJqelVoMDdHMUhx?=
 =?utf-8?B?QzNweU94bk1xeFN0SU0zTlg1M3MrbGpRSkZCWXdmR0hmNTYva2JYWXNCb3dG?=
 =?utf-8?B?N3RIOHJyMWw4bVcyejVjWDFmaDlJMG5McGpuc0gxMTlhSC9VVStYUHc4ZDlD?=
 =?utf-8?B?bkpSU3dic3BkR1R2U3FQVHNycmdNYXg3NEZEemkzOFNKa3NPTWMyczB0MkNZ?=
 =?utf-8?B?Qm9sZkhEVTg1ekl4U09RMkkvbWVyQzF0OTNkK2dhWC80NE1wc3hUTnN1UG1m?=
 =?utf-8?B?bzdpTXN0OFBOYlhsRnU5NGdXWnhDWHh1TXBTUEIwU3IrUk1JNW1PQ2o5S0Zt?=
 =?utf-8?B?UXlJdlg3Q0FXYXFzVzJaZ0FqSjdXMWM3YklaY0NGMkVnUWd2eW13WVlwUkNZ?=
 =?utf-8?B?eXZmNzZyS0pBVi9Nd0hqTjc1bk1rMWFTTS9acm1PS2t5S0VZMk1kajkyY0JH?=
 =?utf-8?B?RHJtK3c1YzZla2Y0WWlvcjdVSjgzRTBkRWdMbThXU0Nqek1UVUUyQkdmZnp5?=
 =?utf-8?Q?jalDAoFg6lE6Q9aKsHhrJcteq77eavb0ZiRIzRa?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEplaFkzaURvalNkRUlIenAzVXhMcFluN243L3hXV0NNVXQxV0RzMG9ZVitj?=
 =?utf-8?B?QXhtQkh3dll3N0tBL2pNZElNOEFoUXlOcGNoOFcxMkMyN2NiNXI0aWNHK2N1?=
 =?utf-8?B?TDBPNnpJVXRQNHZxUHdQeGhuL0ZOUXMzVWhkNnliNjZLRHBPdHh0R2xOd04v?=
 =?utf-8?B?K05OTmhrTHlIZ3QyN2pWR05Gclp6NzliYS95cVJacHpmQ0ovcDBDcXVTeHVF?=
 =?utf-8?B?MDlsa01sMWFvT2NvNVRrcHpZNDBERURPd05RR1dzb1F0UC9LKy8wSXpBUGg1?=
 =?utf-8?B?SjJlSmVLa2RvYVVZZ09MY00ydFRaN0xyMEgwL1pPcmhWVEVSMkRENVc3bFQ2?=
 =?utf-8?B?VFhTMVg1MkthZitRV0QzMlIraXpYOFBOaEFud3RrNWJuWXJ2VmZwOG9BcGcz?=
 =?utf-8?B?ZVEra05UVDN5dTRQdTBJZnhFZGlPckVrT2dWbUE2STI2eUdhMW45ZUN3THR4?=
 =?utf-8?B?L2VPa0Y2VkRXNXhuSXFLZmgxL1ZyWjVEbEQzbUIxaDc1Um5Ra2hjV3lOb3gv?=
 =?utf-8?B?TGJJc2hqVjNKSWFYRWp2YXROUjdXZkQ1eGVqZjZzWll4YmU0eGhMd0kvOHc4?=
 =?utf-8?B?OSs4QWJRZzRDdW1LYmZXZ3BNYWFEbXA4NjB3YVR2TzNTOU5KNjBDOGdobXQ2?=
 =?utf-8?B?b0pCcWZFajlCNXV0RlNDeTNBanhjVDU0MXV5VmtIa1crL2lad3pGVldHYVg3?=
 =?utf-8?B?U2ZvQXNwM25PRzBsQzBpQ003bGM3L2QzMlJnb1JKTnJGOHNaeHNkOVNZTjE3?=
 =?utf-8?B?RE1JbFA4NmdVc3dhTWYxUUs3ZkJ2NnpBckJRbWxIUnl2S3V1YzFiOFpmeGJG?=
 =?utf-8?B?VVFPZUdTM1hwK1F2VWp5OElZZS9VZ09DbmFMdHE1OWVsS3Q4b1dlRXJWd1dI?=
 =?utf-8?B?cTVJc3lHL0w0VHNZZUFpVWdhNmIyM2JWcnhPM3FoQXNGenUwQVQ1aWVnN0Q2?=
 =?utf-8?B?VHhFYWN0azM5SDhBMExwU2ZpMG45eVpOMjFkR2gyL01YeTU2Q1ZOMGF1WmJH?=
 =?utf-8?B?dEN1V3BiR1hkWDFIdjNPNk1GR2U5RVJlOWhJZjk3WXFab0hQMkgvUEYrY1N3?=
 =?utf-8?B?c3hFNW9yQnRwUGFmK25HamFlZUVhMk1oVmVlb05jTWxPTDg3aWZpeXNiZitQ?=
 =?utf-8?B?VTQ1Y1lKTnZUVGYrcnR2Z1o2R1ZWMnJORW0xRDEvRjd1STB4VnZORHBLYXVJ?=
 =?utf-8?B?SXlJbGQ1YmZobUtLZ1U3R2s5dHJRUk5YVjFhanZaL1lMbG12Rk1UaGhtVmVh?=
 =?utf-8?B?ZFNRZjN6SGorbnZlbnA2SkFQMGw1SWhLc2FxZnFQQStWUTRscVVFejJ2djJ2?=
 =?utf-8?B?bm9QMzdod3FGTG1wK05uR0hEUlBCQlNWcXlXL0kzM243ZjRaVDhtaFF6cE5O?=
 =?utf-8?B?TGlFaVE5aGJSQWQ3L09xY1lGMDVZWUI4N2VKdGw2N3RaSGtKZnJkdXdublpn?=
 =?utf-8?B?Z1Rob2JhVnBGSitEMkh6T2tmWFhJOGJWVkdxNDdiRVpiZXpVSzRWSW1WUUxM?=
 =?utf-8?B?TkpiVEplVUs2dWg4MWtjNlQxRjJocVljYjFkWDQ3cHB4bGRMWGZBbzBLYlJ1?=
 =?utf-8?B?TVdraUNua29Ic20yVW4wejJCZkt1amxQSC93VVlrOEozOGIyQkg3Yy9hRHRI?=
 =?utf-8?B?R1F0NnhTbmZ3TlZkbzU4OVJyaUhyaFkybVBocXBjUmJLK2FPUEl2WWthL0Yx?=
 =?utf-8?B?ZFFGWWZWR0hPWW1OUWtBR1BocnV2WUkySXhLRHk3YXdKaFlxYTJFTTBINkdv?=
 =?utf-8?B?aGRDNnZzZEFwcm5VOTJTZGNEdEtKZHgrNkJHTWhTQ1JaMUxpdFNBTStpVlVo?=
 =?utf-8?B?OGtuNXBBQmp6cWlGUG5yU2ZPTVYxVVdLM0hDcGxSTm9mTGtUaWJZNkpSUC85?=
 =?utf-8?B?WVBtQWM2bzhmVSs1SzVNSmR1UTBmWmtIR1RhNVZPTWVtR1dUMEorTmRuV1Q0?=
 =?utf-8?B?SDk4SDB4UDZ3UGl3bHZDSXNNLzZHcVhHaXE5QmpsMEtMYjV6czA5eC9Ud3hm?=
 =?utf-8?B?aXRjbTFkV0FwaUNTSVhucGFIMmlRR1B1SXNCcTkvN2tJdFlOQzBBS0IvM1c2?=
 =?utf-8?B?bGVKS3M4RmV1YnNXWnRIc1JPTzB4WndJZVdMZVdnY2g0RmpRM29JS1g2L1Nn?=
 =?utf-8?B?SWRoN0pPem1NdFNXRGwvWjQrRHNsR25lYTBUcElYdVluVHd3TlNVSml0ZCtB?=
 =?utf-8?Q?l6u3qsE3dKGH2vLhlv/ySTQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ufqw9bA8HsZb+cxH5fKojuU8IbPlsYCXAv4hs45ILtH2D30s9EU0ssR39XmtX3WqwD+/YFbieBcl8Kh3osAl5gt751arsoUCHv8tJua/AfZP4BbONw5x4DNnj6wfZMoTyDSi/eO47pjJTl2b6/BWQYOuq2dPRW1eKb/fWtG1xmcRaJPixRrWHhm9OCGeUcPhoeloqfoz26idSZrLJR8n9iAiZJ0Klm5rXTDfH3YOh+a7uCRCxGemANF+eTyWo3qLhmb5CDKXaMUhB1jXySpXGcyVaXf4bDWEv8iKkrBCW4Mn4v1k1Yxu6coV9TL1bGHzscwJyMRYuaF/tLDl45CGE6qNozcPdxEb+yNbDWvIJj7TCEjb78a003kOiUAYcK4y9ZaVwhnQWKz/cThM8DeDMmuS21aw2gQiZSOJi//0kX94iCPDCHAQGoLRzBeZgSObBuoNo5HpN5aHcg1F6AN2Xp0XWtf2IGdnx5q72cgj15xApBJ70e2aOJ5tkwqVb9fmW+wO7d9P8g4GXJ8/ca9aX4SGXjKszFaYf5RGv/1XoamD9ulhwIYREBdjzrnG0IZixS7oEWgLzijbkvKWOKEgfnMH/XRhaYKDZnuwFA6shnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9586184f-137a-4665-c1e4-08dc9109e533
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 09:18:06.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngTM2D50GaBlWTH7WSMWs9y1p/1LwYckvu85m7Up8C73ay9CAjYXZu7zGu2tWrmnapGf+Be+ORh2pYdWg+MEUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200065
X-Proofpoint-ORIG-GUID: mh5aqSdTJPAaSB7v6DHWbXBPtamPdKDr
X-Proofpoint-GUID: mh5aqSdTJPAaSB7v6DHWbXBPtamPdKDr

On 19/06/2024 21:12, Eduard Zingerman wrote:
> On Wed, 2024-06-19 at 18:42 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> Sorry, I'm not following here. So I think what you'd like is a way to
>> verify that the dtor actually runs, is that right? The problem there is
>> that the map cleanup gets run when the skeleton gets destroyed, but then
>> it's too late then to collect a count value via that BPF object.
>>
>> The only thing I can think of is to create an additional tracing object
>> that we separately load/attach to bpf_testmod_ctx_release() prior to
>> running kfunc call tests to verify that the destructor fires on cleanup
>> of the kfunc test skeletons. Is that what you have in mind? Thanks!
> 
> Tracing program could be an option, yes.
> I was thinking about some map created by the driver program (the one
> from prog_tests) that could be updated by destructor.
> There is a question of how to pass the map FD to the kfunc,
> probably it could be passed in a constructor for the kfunc and stored
> in the context. But tracing program sounds good as well.
> 
> Again, it might be the case that checking that registration logic
> works is sufficient. In such a case bodies of both kfunc and BPF
> program could be empty.
> 

I explored this further. Even adding a separate skeleton with tracing
prog to catch release is insufficient because the map free is deferred
and the test can have already run by the time the deferred map free is
called. Whatever mechanism we use to detect release would be subject to
the timing of that it seems. This seems like a recipe for a flaky test
and I'd rather not add sleeps etc so I've stuck with the current
approach which exercises the dtor codepaths but doesn't verify release.
Thanks!

Alan

