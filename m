Return-Path: <bpf+bounces-29706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C48C5986
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 18:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24301C2121B
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A017F38D;
	Tue, 14 May 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a643j6W4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQtAjVqi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818517F37E
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703348; cv=fail; b=M7qparbJZnWbevnomqbOnBWNShCsIji9xdiRTiVQuxwTxXeuaTTC2/x/inSMhVS8JCEuiwLhfcPI5REKitUl7N3x8r6RGruVEkWmWkvJfcOVUDbuSI+28o8o+UBvSidoZteLwloEFmm5mOrT5o7+OeSMP24eCIvbTOn8o2UFDPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703348; c=relaxed/simple;
	bh=5hSjhbD4Zv3nKfANGRyX/VsH+lMDB1BWuXcjtoOwNZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncNlRMr1b2LZ8V9FAlviGmyaCwTjQIWCIFLgXxe2Uoahs3UZlVRNbC4GB6GtvvSH/d3GH9Fb9pIB464rtM/Zk6zMcIxRS+uMlPsHGS4pol64tzMnfJdM8L006C1LH9iJfljiO/ah+2IikTcQUN1Gd+5NOcCRZuBLfrYYsz+Didc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a643j6W4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQtAjVqi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECg0a7006845;
	Tue, 14 May 2024 16:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oRN5KvTAON5tK3xCmvwgnSv7Ggc4oEvTWF9MHoCBTuw=;
 b=a643j6W4AKse87HCc4pPGMh82Sq3Ly3fFXCgt+un9RpQInJ4/Cot2qiqKkRmovb482fr
 +4bJQiXMvNYkQaeDMzFtqu7rYSPZkFZfT0B681uoFzUxQijSwJFwNA0QwUaNk+p+BqDA
 jg19bCfckqzZGgo7eXrBNj3NYXZ+IYi3Ev7gHzHClJNd1j9BBwPxC24n/aaXHm4I6xx4
 raX0IqJHS6S9n9ZJen2IXXrEZpantmPP2Q+FdFxP1O9P6HgR8eDb775rse19+uI5ynq2
 hLkinydXS9GtLraHxaS+8UGRA+LJMfKV1BSgLqdvzS832j3pYtv1T9tpfjnc6No8IEe9 iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx31sa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:15:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EFuGhX018867;
	Tue, 14 May 2024 16:15:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y47pfgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk83eJop2h6p19mJbBq5vwbfAsYL0lnlHhTBE6ST8MRMU7UqAiOYU0H2aBx+CHaeBdNGHRvexNeHqaXfI6U1tqMwM2EixGKPZEZPybhQLj2P80ku5k/S32/q6fUghNtfSSnGP9v0mnXw+zKVDtLrjOGQKBiCpzaEKvoDJg2YDbM7iJWzCXDCbETSbi3jLI35uDszsP2SjkQuw0C1Ir5fhGqeTrNoFnjvjNDwJIrTXGBm98izAbKDKTlOh46Ea9HNWDEA9+HNqq52AhoDoF0N8KGXa+h9g3hS5Al2Gx92+Xd87+4xUMIKJnKs7QIkjD2UgxJTLp5tRRaC0vv1OZMiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRN5KvTAON5tK3xCmvwgnSv7Ggc4oEvTWF9MHoCBTuw=;
 b=jE7ztr8oYfcCe6KEmI3eySk++d8K962lkdO+prtFieK16iEgL4DQfJ2u9EZqFKOWP/94c+aKYprS+OpSUS0GA7Y9vde4N88+HMUKfoei8ZK2J3RkIRIgjSbh5vGDNF+tEzvQVhgB1MPtFV4UU6KvcSeiTrtYByIjIEhxfozmtzYw0GyfT6TnAHcPkgHr+k1EsSXpboAYuuHocqS41KfxCvOsz4tR1+cOxXwHS43me+/DvyJIwZLRz7R1Qk1zO6E/9Nx60ogc3hGLvruCLKgsSKNIELTAnl2oLE+/qQMxC/BGle88Qks+PAW/cILMav10nv9Hl68qd4Trti1ElIXuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRN5KvTAON5tK3xCmvwgnSv7Ggc4oEvTWF9MHoCBTuw=;
 b=fQtAjVqitlMYGJtVA7DSmzXZuGoNr3ZsLTI8D0FdehuJeXrXXenMektjvYigOGvcz1HDhOBTGuB9hWqe+nERoKSowsU2P4RyiPr3aS039C8KI/9rXlXKgzuO1sSA01cyFef24rVl1Lxrozzjq/Kii7Yz+cDp8Sq/AA4kp03fK8M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6221.namprd10.prod.outlook.com (2603:10b6:8:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 16:14:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 16:14:54 +0000
Message-ID: <819d1223-a7e7-4b42-b454-d80422fca32d@oracle.com>
Date: Tue, 14 May 2024 17:14:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 10/11] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-11-alan.maguire@oracle.com>
 <2e5472ba5b96118b11872a869b251132ca49dabd.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2e5472ba5b96118b11872a869b251132ca49dabd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: a13ee361-f82a-487e-c9f1-08dc7430fd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEcxRzVsandETCs1RjY2TEw3eEwyZVRndk9QQkp6SXdheUF4SUQvN0ZyY3pr?=
 =?utf-8?B?dHZYMTg0eXZGblJ3UHhkVzJJWUlJbVFlZ0dLTUZFcEtkK2JGTWJaL05WcUpT?=
 =?utf-8?B?S21PU1JOZ2V2Y1JFcmI0Z1AwWGppUGsyQWp3TXFzczh2dlJWTHVGY3ZwZEg2?=
 =?utf-8?B?V2JPS3lqeXdSQktRSVFBY25XTThQZDRXR2xqYUdHVGVVa0xXa29NeU9keUZC?=
 =?utf-8?B?eDRkcDk2LzJLckVSNEZTcVIrSjdTMC9jYVltRnpJVndXSjBVQ240VFJYTUtL?=
 =?utf-8?B?MW11TE4zKzNCak9zckZGL0tHWDlpR0dqTnRiV2NMQ1ZTRzQ1MUR2NU9lL1pL?=
 =?utf-8?B?WDFGRW1leFFzTVhLV2NrdGs5RlRXU25RcXR5eU1rV0Fidm1FV1J0ZTNod3Iz?=
 =?utf-8?B?c3hsRHdPUEZBSVRjdzd4WmVGUk1RemR6NDAxZnhBUHZrR2RRL1I0YVdXZjJ4?=
 =?utf-8?B?YVpGZ1U1TFc1RmpaYVdFMXpxM0lWdFI0Qk9RYWR0OEJKWGdrcGtmZmxraHA0?=
 =?utf-8?B?aExKN0ZnNU5nODhVT1d4YWdhRG14YndVWEtuc1dtZ0dnNE04YTJjOG45bGRq?=
 =?utf-8?B?NUdNa2hXVGxzYVh6eUJIV2toSmhJTEJTUlpHbDdRdDFpRjN1UnpDNzBSUWxR?=
 =?utf-8?B?b1R0UHdaQjlZNTJQSmZTK2FjUit5amV6bmp5bW1JWE5aZUZoZGpqWHVaOXNi?=
 =?utf-8?B?b083M29FQ3c3a3B1cnJtOVVKRE5SMCtkbW52WmVLVVRCdWo4SWFtcEhlaDkx?=
 =?utf-8?B?RW9nN2xUWW5UcXpEVTdmRUNyUmg5UmJlWUd6WjNvWi9pSWVMRXBMRnlacHFi?=
 =?utf-8?B?QnRBWmFRYzYrTUluOWYwSlkvSDVyVzdOcGwvMjNrWFJWZU5lR01kK1kwWVZK?=
 =?utf-8?B?L0lFY0pUWDFSVTgycjVyc25wdTg3akk4OFFFS3g0OTlSNmd0emlpZW9kaGts?=
 =?utf-8?B?YXZzQjFDNWhTdmVZMW8xOUxkdGx6ZThXNjNqSkljaS96YldTZFIxYnFEZlZi?=
 =?utf-8?B?NURMRy9uMy9lMUtsNU9qcndQeWp1M2J1bEtBVUM2UjdzNDNPQU96QW5WR0o3?=
 =?utf-8?B?RmQ2QjdkZ2FmL1paT0p0TlpmcHVUU3VuWmpHRGFTTE92ZzlOT1kvR0d5cE1F?=
 =?utf-8?B?T0dMcnZwa29ITjFVcFJzd1BMQkcvZ3YvMVVyYnQ1R0x0SEFKQWcrdU5JUlJY?=
 =?utf-8?B?dGFnMm9JekZzWmFxY1ptNmlRbUlvdkJuQSs1NiszZWQ5RXR3dXArMm5QTkoy?=
 =?utf-8?B?bmtBZEMrVHowdDYzWndkTURWaVBzOWNTanFEZlRibDUxTDJnSXUrRW1uMVhh?=
 =?utf-8?B?MFZ1L0cvNDB4RmVRZkVlTUZtRUx3c3FQNmNrcVVqZkQycmwrVkw0WS9pZmhB?=
 =?utf-8?B?VnZCOHFuM3M5V2JxV3RucGtYbTZiV253TVdyL2FBcDJNYUlWaTF5M2d0N3ND?=
 =?utf-8?B?bkFFK1pSdGhqbjZ3cDJJdXk5TUtNT3EzQUhsanNETUY4K2ZpY2lTa0FOelhP?=
 =?utf-8?B?NTJTK0RQVXVmY0t2NGdSdC9JRnZ2ODE3Z2U1SnVnQTV5aE1tT09oTThEL0FN?=
 =?utf-8?B?SjBCZjZEZDhwUFNMMUlhaWNNb3dGVVhHUlM0bnZIOFc5a2swem1HSmhFQVdt?=
 =?utf-8?B?Qmt3OFdZQVI5czVxdXo0bzVuZEZJNHhtMmhvTXh5K3RpYmc3dUl1Umk5aTFv?=
 =?utf-8?B?a2R6UGNtend3YmlRY3E0RWxzM2dneWxNM1hxZkpqMkl5M0FJSTJ2bkxnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amJ3ODRROHJ3b3l0STFmYVl1a1F0aU13QWx1UGlIcXAyVnlGZ0dzMlBRK2lo?=
 =?utf-8?B?NGlvaE5kazNkaEZCOHhXWXNaZDFOTUhWQkgwMnRkazlMM2JPdVNHdGFuUWx1?=
 =?utf-8?B?NGthU1djK0J6akV6MUlNY2JweDE2dkJMVDBoWmdmODRadXhWVEREalcySUc3?=
 =?utf-8?B?c1FIeTJTcHAvMG02c2RPcFgrU1h0ZlhoZ0c3NHlnSnU4UlhXN1NpQVRyazJB?=
 =?utf-8?B?YTBibS83NCtWeW1PbzZFQnlPNzBJck1nbmpHQnNSUm92LzcrenpZcEVSVFdO?=
 =?utf-8?B?eFBqZnBMM20xSmZPRlpEVWJhcUQ3N2RwYnBFVm8xOG1sbCtiQzdJK2pqNGE5?=
 =?utf-8?B?T1d4eloxWGk0N2c0bW96eVhnL1pWTjcrR2FyTHZrL1ZadDdOUHl6Sm92QmtC?=
 =?utf-8?B?YjVmaW40U2ZvOCtnWEFRYzFpVWFnWW9lWUIvcGpqUnNpcWhVRGt4ZmhsbDds?=
 =?utf-8?B?TWNTUzFVdG9YSmNwcTdEM2Y3UUxieXI1Z2pidzRQUzZWNkhibU1jWTk5TTFk?=
 =?utf-8?B?d2pRQnFQYndISzgzbGs4Z1RKQU5jZ2lxdnFYMEJKMTNDQkI0ZTBIQkdHd3dl?=
 =?utf-8?B?aW9kT0xORE5DbEhUc293MmZoK0xOa3dVOGloVWdzUkI4bForWHZnbEFYMDZG?=
 =?utf-8?B?TFBVM3NPQTRvSlNxVEdhRlQrL3NqWk41WjNzUVQzSSs4Q2J6U1grVXNIVGdh?=
 =?utf-8?B?YmhQdjlWenIwcmZiNzJ1ZFZxeWRkMmxMS21rRGs5TjE0QTZTYWNPeWRHWnM2?=
 =?utf-8?B?aVJEMU1PdE9BZi9nUXBlK2E4T2hMdkF3bnVTbGZGZytCUUFxamNZNzRXbE5t?=
 =?utf-8?B?dGZwKzhEOVpWVFJ5M1h3VndnS2pwY1R5TUhTVHZjT0VBT0JhaG1KVXFlcmho?=
 =?utf-8?B?bjR5UUJDMjlxSnRLSnZxM0hTR0IrcEV5UHFKS2tad2tWNXJvR2FxRnpUaHBH?=
 =?utf-8?B?QTVzV1dQTndHQ25DS1BwM3lxTzVLdmdCVHJhV0RheHZieXl1dXMxbm5pVjFY?=
 =?utf-8?B?ODJnMU8wQ0o0ancxdHQrNGZiNHU3Tnh0aFZzQ3BLV0EvTVBrY21ZQmlQRHpz?=
 =?utf-8?B?Z2NzSzZvbzRwQXhGL0wwV1VVOUVnaC82YUNaenErU2h0R0VZNDkrbUM4blRv?=
 =?utf-8?B?R2c4cmpiZ25pYm95cFRYQzNpbXR4VHk0aGZlWm0vdzJxWldhOG9xQlNPUUlZ?=
 =?utf-8?B?dStHY2ZDaTU1MUhXZGltV2V2STB0WDA3MFZjck9hMW5vMmd3UGp1c0JncjZK?=
 =?utf-8?B?K3RJNWlzZ1owSk9jcWZsZFA4b1I2bUI0cXAvSm02TFNxSjZoR2NRMlV5UVl1?=
 =?utf-8?B?M3hhRXErSUp6UllyQzdHZXBlNFMyU2FockpQbWZ6U2t2N3orRk8rNlk5b2xp?=
 =?utf-8?B?UjA3VVlhQjhuL3JOZjVTU21nVGcwVVh3cTRudHVSZ0xia3BMdjNjbkl3Znh2?=
 =?utf-8?B?R29KTFRzK2Naa09SeWI4dGIxNVVORnd0WUM3cEhDWUVPRlVWTEVtSnlrVVRh?=
 =?utf-8?B?b3ZNalhhUTVVdUJ1ZjhEWERMeVR6bjByTDQ2bXByd28ybTlGd3BNT05RYmJz?=
 =?utf-8?B?RVozTFhxVWtONHVQS3MwM0pwZWgrNCs1VWs5dUg5YVQ2MzlzU3RlUGQya29r?=
 =?utf-8?B?RHZjdzBlL1pDTnVyRnV2Vk9IVXYrVVkrRVYvZy9TaVVHaWpOVEVCclJRcUlu?=
 =?utf-8?B?YTcvODFzL29hWXpHakRoTVRGVG5ieCsyZjNSZVJSNnJSdTFxeWUrUjBKSU9Q?=
 =?utf-8?B?UkhsaXVtMTF4NWVYdVlwc1ozSGhhbEt3MWdIeVl4UXYvdDlKS0o5YkNNU0k5?=
 =?utf-8?B?Qk5OU3pULzlOWER2a1ZFcE5nM29ORnROMEF1NFgzOVJ3Ni9uMWRuZDNCQXE5?=
 =?utf-8?B?b2FLRmw5VU1PYUd4cmY0T2JvM2MyY1JvdnJVRkxkR0ZzQmNHek1SeVBSQkRU?=
 =?utf-8?B?VmpDWHd4MDFXR0JhU2pwbitIUHdhVlIyYUdSMnJ6ZUVXM3ZPRXJUc2pNZUhO?=
 =?utf-8?B?c0JaRGdwcm1abkUyajR4c0k1eExnUE8ybm9qeDIxUXVIb0wxWEczbWRzZXN5?=
 =?utf-8?B?Z3BxT29RcjVyWUFoMEVPekRvMjhCMm1BbDhmVGZBTUpOQndCNEg1Zzl4WFdy?=
 =?utf-8?B?UmQyL3hrYTREY1EzOEMxMi9hZjRtSU5qb0Y5ZUZXSWF5NjJNcm9KekswWlZy?=
 =?utf-8?Q?o/Do7qtjUhHWLWIyK1GprPw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WFqsI7A77o32JDtriAst1OOtR/MMHJYo/HJ1NMZ5wNLvBV/wb+OwnX72tgn2QgEbbFOQ0LgHbEh+3nMsSLPOQh9pHKkx/AzpNjs7VtTS9qUKwltnUxlh7JQXRBp7Gt97sWYTSSbzr2EbfuQkZvfUmBb0XQunOz7RJBA2aNJB06LCO6k0LnUJ9sWtt4qFWtWTkIsJEin1rErjpr03dK4n4Gb1E5ohwwRUstelf6pLarPZX+XtK4DEM/UAfV+fVM18iwKd9U+TPfrBucz3sSwh02koFIKYwn+8KQm9jmzRFAZVEQkidSbTOM9CiIUdfY9n/lfo9LVBNNy/SAHyZ1XOvZFzjB8fabAon9EZElqsi1wsksGCfxZ97QZjV80NEySqeWgpls1kJT/RxHxPHJFDfDeDE267iI3n2yEgNiEVt5tRTTHe1HHDpWgXy6eaBhxX9A+91fLERE3HcxhF5xRziZMYsp5edbmTypFMkfYgigGhZhe48IzxYL5XjnLORVxxfmag459AbrFKChQPYehIfV6L1sBI4w55yitAuHpRVEh97DPGU6uVnH7Wz6mvq7rjQxlUY9/Eo8Ort+zYeABf7gGZY3UooW7yYTK7+sZ8vjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13ee361-f82a-487e-c9f1-08dc7430fd78
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:14:54.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/sMAQOZIuylixkfYPza1puoA2ODw6b+uIuxUii6CZflWQjtyVVzSLXnAG98A2RFvkBrRidrkDmvoX76o9qkdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_09,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140113
X-Proofpoint-GUID: Bvlg6Q8itfMsTWUAGwM8WgmUDlmIyFsi
X-Proofpoint-ORIG-GUID: Bvlg6Q8itfMsTWUAGwM8WgmUDlmIyFsi

On 11/05/2024 02:46, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 821063660d9f..82bd2a275a12 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -274,6 +274,7 @@ struct btf {
>>  	u32 start_str_off; /* first string offset (0 for base BTF) */
>>  	char name[MODULE_NAME_LEN];
>>  	bool kernel_btf;
>> +	__u32 *base_map; /* map from distilled base BTF -> vmlinux BTF ids */
>>  };
>>  
>>  enum verifier_phase {
>> @@ -1735,7 +1736,13 @@ static void btf_free(struct btf *btf)
>>  	kvfree(btf->types);
>>  	kvfree(btf->resolved_sizes);
>>  	kvfree(btf->resolved_ids);
>> -	kvfree(btf->data);
>> +	/* only split BTF allocates data, but btf->data is non-NULL for
>> +	 * vmlinux BTF too.
>> +	 */
>> +	if (btf->base_btf)
>> +		kvfree(btf->data);
> 
> Is this correct?
> I see that btf->data is assigned in three functions:
> - btf_parse(): allocated via kvmalloc(), does not set btf->base_btf;
> - btf_parse_base(): not allocated passed from caller, either vmlinux
>   or module, does not set btf->base_btf;
> - btf_parse_module(): allocated via kvmalloc(), does set btf->base_btf;
> 
> So, the check above seems incorrect for btf_parse(), am I wrong?
>

You're right, we need to check btf->kernel_btf too to ensure we're
dealing with vmlinux where the btf->data was assigned to __start_BTF.

>> +	if (btf->kernel_btf)
>> +		kvfree(btf->base_map);
> 
> Nit: the check could be dropped, the btf->base_map field is
>      conditionally set only by btf_parse_module() to an allocated object,
>      in all other cases the field is NULL.
> 

sure, will remove.

>>  	kfree(btf);
>>  }
>>  
>> @@ -1764,6 +1771,90 @@ void btf_put(struct btf *btf)
>>  	}
>>  }
>>  
>> +struct btf *btf_base_btf(const struct btf *btf)
>> +{
>> +	return btf->base_btf;
>> +}
>> +
>> +struct btf_rewrite_strs {
>> +	struct btf *btf;
>> +	const struct btf *old_base_btf;
>> +	int str_start;
>> +	int str_diff;
>> +	__u32 *str_map;
>> +};
>> +
>> +static __u32 btf_find_str(struct btf *btf, const char *s)
>> +{
>> +	__u32 offset = 0;
>> +
>> +	while (offset < btf->hdr.str_len) {
>> +		while (!btf->strings[offset])
>> +			offset++;
>> +		if (strcmp(s, &btf->strings[offset]) == 0)
>> +			return offset;
>> +		while (btf->strings[offset])
>> +			offset++;
>> +	}
>> +	return -ENOENT;
>> +}
>> +
>> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
>> +{
>> +	struct btf_rewrite_strs *r = ctx;
>> +	const char *s;
>> +	int off;
>> +
>> +	if (!*str_off)
>> +		return 0;
>> +	if (*str_off >= r->str_start) {
>> +		*str_off += r->str_diff;
>> +	} else {
>> +		s = btf_str_by_offset(r->old_base_btf, *str_off);
>> +		if (!s)
>> +			return -ENOENT;
>> +		if (r->str_map[*str_off]) {
>> +			off = r->str_map[*str_off];
>> +		} else {
>> +			off = btf_find_str(r->btf->base_btf, s);
>> +			if (off < 0)
>> +				return off;
>> +			r->str_map[*str_off] = off;
>> +		}
> 
> If 'str_map' part would be abstracted as local function 'btf__add_str'
> it should be possible to move btf_rewrite_strs() and btf_set_base_btf()
> to btf_common.c, right?
>

We can minimize the non-common code alright, but because struct btf is
locally declared in btf.c we need a few helper functions. I'd propose we
add (to both btf.c files):

struct btf_header *btf_header(const struct btf *btf)
{
        return btf->hdr;
}

void btf_set_base_btf(struct btf *btf, struct btf *base_btf)
{
        btf->base_btf = base_btf;
        btf->start_id = btf__type_cnt(base_btf);
        btf->start_str_off = base_btf->hdr->str_len;
}

...and use common code for the rest. As you say, we'll also need a
btf__add_str() for the kernel side. What do you think?

> Also, linear scan over vmlinux BTF strings seems a bit inefficient,
> maybe build a temporary hash table instead and define 'btf__find_str'?
> 

Sure, I'll have a go at doing this.

>> +		*str_off = off;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
>> +{
>> +	struct btf_rewrite_strs r = {};
>> +	struct btf_type *t;
>> +	int i, err;
>> +
>> +	r.old_base_btf = btf_base_btf(btf);
>> +	if (!r.old_base_btf)
>> +		return -EINVAL;
>> +	r.btf = btf;
>> +	r.str_start = r.old_base_btf->hdr.str_len;
>> +	r.str_diff = base_btf->hdr.str_len - r.old_base_btf->hdr.str_len;
>> +	r.str_map = kvcalloc(r.old_base_btf->hdr.str_len, sizeof(*r.str_map),
>> +			     GFP_KERNEL | __GFP_NOWARN);
>> +	if (!r.str_map)
>> +		return -ENOMEM;
>> +	btf->base_btf = base_btf;
>> +	btf->start_id = btf_nr_types(base_btf);
>> +	btf->start_str_off = base_btf->hdr.str_len;
>> +	for (i = 0; i < btf->nr_types; i++) {
>> +		t = (struct btf_type *)btf_type_by_id(btf, i + btf->start_id);
>> +		err = btf_type_visit_str_offs((struct btf_type *)t, btf_rewrite_strs, &r);
>> +		if (err)
>> +			break;
>> +	}
>> +	kvfree(r.str_map);
>> +	return err;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
>> index 54949975398b..4a1fcb260f7f 100644
>> --- a/tools/lib/bpf/btf_relocate.c
>> +++ b/tools/lib/bpf/btf_relocate.c
>> @@ -5,11 +5,43 @@
>>  #define _GNU_SOURCE
>>  #endif
>>  
>> +#ifdef __KERNEL__
>> +#include <linux/bpf.h>
>> +#include <linux/bsearch.h>
>> +#include <linux/btf.h>
>> +#include <linux/sort.h>
>> +#include <linux/string.h>
>> +#include <linux/bpf_verifier.h>
>> +
>> +#define btf_type_by_id				(struct btf_type *)btf_type_by_id
>> +#define btf__type_cnt				btf_nr_types
>> +#define btf__base_btf				btf_base_btf
>> +#define btf__name_by_offset			btf_name_by_offset
>> +#define btf_kflag				btf_type_kflag
>> +
>> +#define calloc(nmemb, sz)			kvcalloc(nmemb, sz, GFP_KERNEL | __GFP_NOWARN)
>> +#define free(ptr)				kvfree(ptr)
>> +#define qsort_r(base, num, sz, cmp, priv)	sort_r(base, num, sz, (cmp_r_func_t)cmp, NULL, priv)
>> +
>> +static inline __u8 btf_int_bits(const struct btf_type *t)
>> +{
>> +	return BTF_INT_BITS(*(__u32 *)(t + 1));
>> +}
>> +
>> +static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
>> +{
>> +	return (struct btf_decl_tag *)(t + 1);
>> +}
> 
> Nit: maybe put btf_int_bits() and btf_decl_tag() to include/linux/btf.h?
>      There are already a lot of similar definitions there.
>      Same for btf_var_secinfos() from btf_common.c.
> 

Good idea.

>> +
>> +#else
>> +
>>  #include "btf.h"
>>  #include "bpf.h"
>>  #include "libbpf.h"
>>  #include "libbpf_internal.h"
>>  
>> +#endif /* __KERNEL__ */
>> +
>>  struct btf;
>>  
>>  struct btf_relocate {
> 

