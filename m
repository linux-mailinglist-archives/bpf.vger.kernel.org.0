Return-Path: <bpf+bounces-30312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1118CC509
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C01D1F2366F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41AB1419BA;
	Wed, 22 May 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHI23F/f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OSajfpqn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8C145B14
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396184; cv=fail; b=dSfnf/ZTqleFuzREc1CfZ8bxsW4QpVc9/h+0VjHCX+jnVWYvSInka5MIw1qIGgZxZLPJ7tnSrJSeqht0XbxuQJeim2HwYNqd/dHqpbj3lgpQgjmyj12EdhD/qWMUmmGHA8Pi93lyHTHxBD8pB0NbBy+lLQiEk7TMqDrKE62pIqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396184; c=relaxed/simple;
	bh=pv0FchkMdwfRpNGUoEUb/QqF5gNgiryxAl71T42/eMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lMozq3YyfhfpJhv+cZL4BeVffSTq6hl0iav7yENd5FlozrGFxMl1I6weuHWBLLCZ/beWd80AcXNxwkA/RAvwuNrf+vOXGdYzly5w5xHi8JVm5IzwoWYCLwcb8DGhB1lIf1md9sHsZLqy5to+oWw3HsRAp1F2AX2T+xpAERcQu9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHI23F/f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OSajfpqn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEo1s8022450;
	Wed, 22 May 2024 16:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tUNLi1MnCL9/ru++rfxQfWG1p9YnsiZAoRFwy1PfS0I=;
 b=RHI23F/fgEaKWfF5ITGtZdle2dM/hfUHlBl0F1Sea6x0n66z0CFTaILdLwumrZwqy68Z
 0we4l72N2IqmzFP6cPlUber4XUqo858nrUYgClGXPIQms7a0veeYPnfcoYBTm/rB289Y
 DHxgMdF1TTlD//6H/+C10IvR2kBaxwpKiYWT0my9Qq0xNDRSQsZjlh+wA8Tu0PEpyiu1
 8133JzkzKAyS/2ARduwnGqCudrdPSrhcXaTWBagrrIu5Ev8p8NVjzX0dXxRCcMKk1TGU
 VqQDXH+FfF/G+nWTa0F3fParO42pURaQ9JMKZ+03Fu4SFD1rqF6peWceAoRB0+isoCqq eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv86gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 16:42:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MFRxru025734;
	Wed, 22 May 2024 16:42:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9rtpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 16:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW7oVW+IJZSmzTkIQyRGxv8ah79cCcyE720vOCUCir6SxADIoNgossy4D8cZh2KZPBKFYAg3tRwHTOq+r2ATySv75n8l6De8SRG5Py+DF6//aBx9z5w7GfoZA8/dpWMfvEQN1utf4bpXHVWPYGOvd6XL97Q74LqnBr8Ym6LAZvoaKR41nvFq02zG184GSBpqDNgY4I2ECtDyx+9dD8lRZxq8CiT1TpRc28PD3Z4UXNtqunm44KjOiVGtWGz4CxDHChfB3RuviE4Asbwj6qGA//OIIBjbssh6WVodOFVBoLCrXcIgbL9MMJiD2qkPWr2se71NigcByFPU1HgtFtrF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNLi1MnCL9/ru++rfxQfWG1p9YnsiZAoRFwy1PfS0I=;
 b=N+Y3Wuy0NH0eAGm/rE+OlazmzF9VmW8q201JR/1kn81UQkwDpq5ag1URWrkoqb89nzksGJ/a0UiFUzbDK+4CqTJCM/FbZk/uCmz1KG0fCbMlYdYetbEUHW40JsihYIZqDjc/QNNbigfzI6vmth9d1qJEU7D2L57siO0nVkNJGTtMNhd4JllRjfsWgM83U+4HaVVnJM/CdIzufd1HuW6J4i3TFmlql5T76NEntCM92tTViNfMCbCqyIQ4z8YoDxJMbV4G0eJHMuM3oGvuTHdFwJJjQdkEdzPioVhwWIqlJsaoBufBRM7vYEBKY29pBBSv3jwIXmRDDsoJN8In5nFRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNLi1MnCL9/ru++rfxQfWG1p9YnsiZAoRFwy1PfS0I=;
 b=OSajfpqnbGtScmBvy+HYEbMlHgfdpiqjEjWa6JSRAF5HX1bu546WG49tp63ckPo7Xy+ZWZO1gd4Cf11PbpU8cSCa4ht45SiBRkj4Fb1mB94zhBpWmSUsxJLGd9LixyuiwtYYjoFUwd9iroRNtkK0OCfASp6p7JlFY8CODYCarIA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4849.namprd10.prod.outlook.com (2603:10b6:208:321::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:42:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:42:09 +0000
Message-ID: <8d1c6821-4918-42f1-b17e-cc56014cb552@oracle.com>
Date: Wed, 22 May 2024 17:42:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <20240517102246.4070184-2-alan.maguire@oracle.com>
 <CAEf4Bzao+YSk9LfyDFVbWY-BKzExrvoAHn_5D37J7Mi2Rna06w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzao+YSk9LfyDFVbWY-BKzExrvoAHn_5D37J7Mi2Rna06w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e0dcee-c1fd-4106-885e-08dc7a7e1fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1VPaThXcVlRM0lZQnpTaDRqblUxeDhDaEd4QU9pWFpLR3pxS0FrTEFQeDdo?=
 =?utf-8?B?dEVqQzgyZDBCTzE1aWcwRTIrVHlsUDNFUGxDbWVIZzBPYmdOTXNiclZ6eVNE?=
 =?utf-8?B?aHA1RFpQblJSRlNCd280eWlhN1ZJaWNmLzJwK25kaWtURm5xWUo0K3hNV0Vi?=
 =?utf-8?B?WG9zVk5UUUZpaWJQand1TEFnc1cyNmFrWTM3KzFOT0h3WEFMdkNrTVZkSnk3?=
 =?utf-8?B?OGRkWm5CYnc0VlQ3dzZoK1hYOE56R2tqbHIrTHJIWnZqYm92OW5sRUErdFl4?=
 =?utf-8?B?c1lwRDB6MFZ0bGczekxQbEFyRW4vYTFmR1Zmd3R3cUxkV0cxM09GSjR6T1JX?=
 =?utf-8?B?M0piQVA5b1c0WThreWREdVowckZ0aW94QnRoRVhGMm8vc1dRbWprbHdJT3JP?=
 =?utf-8?B?Wk1GWXE3YzVYTnNOOFhtb0xxTHlISmtaY1UyWmhlVkZiakxnRU91bWEwaFRI?=
 =?utf-8?B?dnQ5VHpLQlUrcEEwYUQ5M3RCdmMrNFBpa1AxNFhiN2dESVVrV1R0aFM4OUo2?=
 =?utf-8?B?enhiNWZxbGs1TUk1STVhWUZsbFQ5V3l4SWxXZGllTUM1c3FPMDFBUjBCSnFI?=
 =?utf-8?B?UEk5L0tER0JmelArcDZlbnVZS3FvbkhwUUFFUmp4LzBIeUdvYVZLU2xybUMr?=
 =?utf-8?B?alRJeWkyOUZnOUtiSEJ0TXQ1SW5YMWNmeWsvbS80aWkyZkxxYzM2VlZKQ21L?=
 =?utf-8?B?YWRHOVR6S1BOT0RSczBtLzZEelE2bm9WRGxtc3Q2NDRtZm41SEw5NXZBcm9T?=
 =?utf-8?B?OHVGdlVEQVhWN21ZNmR3STBBRmdXWUZhZjlVditzUzNHZ3FKeFhlMVlob0hz?=
 =?utf-8?B?OCs2amYvSnRYMnBuMHhuQXU5QWJIdjJJalFQYjYvRmN2djdOMk92QjF6RW1P?=
 =?utf-8?B?Y3oyL2t5Yit5SWZEZmg0WWpWTHBpVXNnYnJsWjFwOWtiUGJNT3piYzN1Zm9y?=
 =?utf-8?B?S0p4SzkrREQrSnpGL1RvcUtVcWg1eS9mdHNqdlRwVzBpbkRUMDFCc1RYcDJy?=
 =?utf-8?B?WGtFcndUcHJZdTJFL0VickpHNndhdU4vVzF6UUc5WXMvVktQQ1cyZ29GVlBU?=
 =?utf-8?B?TVBKTTRzM2wyWVFuWTVCbGc0ZnMraTFXNWtKODJOWVBtTHBKbWNtT25GM2pR?=
 =?utf-8?B?UWpYZ2hNNVRiSDJ1eXJNb2hiVVZpaG5WUjczSWtKSHpSNFJMb0wyemNxa0pC?=
 =?utf-8?B?dGF2OVNoZThvVW9RRDdZaXRWczlHbXd1a040Q01HU3JtdHNleEVhUGx4Q1I5?=
 =?utf-8?B?WTZlVlFsS3V5K0VMUEZQWDRoTWhFampYWk1vVWd5ZUdWUXc2bWdoVGUwdzZh?=
 =?utf-8?B?NDZwQXdVUjBQWCs4MWtkbm5GYUpUc3dmNGM5YU1Fd3lPbncyZVpJM1poVmdW?=
 =?utf-8?B?ZFFxS0ZzbjA5bmdoYzN1RTlwSm1ZZFNhQzhRa2RhQk5QZ2lXRWVONjVLeHFu?=
 =?utf-8?B?RDhSZm9NSVZMUGZtcG1DY1JIY2hCaUFXRGowZytMWTNIQ0R0aGs0OTRiNWlm?=
 =?utf-8?B?NGdGVXVNcnpwZVhOL1llS054eU9wZjZBdHpLQmdBSnFMSFpnYzM5UUVzc3lR?=
 =?utf-8?B?ZEhyZ0ZuVDNIVTU3bnhNeHNhbnJJa0ZKRms3ZzNNMzd0OFZWT3Q5cmJTMTZu?=
 =?utf-8?B?V014OFp5eWFmdllzeFFKMDhjN1ZvOHZLTjBZeXp3Snl3ZmcyZmJNRm00MlBl?=
 =?utf-8?B?U0FyVENIV1NRTkJNMDBrS0VBalRsaG5UbGlyR2o4T2o1TGVyRXVLMEF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QklHOUo2V3FQcDU4YS8xSXRaYVpsVGJ6S1M0TEQ2SXFMR2JCcVBsTFdvaUs0?=
 =?utf-8?B?Y2Vja3JCSVVzVHBBei83cHZiMVBJZVViVzFKTVNtZHhxYndIS1dHV0FLUWo4?=
 =?utf-8?B?MmsyRDIwUG5sdUZXeDdLdlBIdklTK1lUbW4wSi8ydUZhTTB4YjhjeDJqNER6?=
 =?utf-8?B?VmJ2Z1ljOU5CWVBYNFpvYUJKSm1seG5paW5INEdXYXJyOEg1VEF1amhaZE9D?=
 =?utf-8?B?dlVXZXlHcEJLdDBwNjkvZ0VIOG14SXkyMmpJL2crVXB1WFB4ME9WWkUxRmxC?=
 =?utf-8?B?Vm1iaUdzUE1tTytYbFQ4N3dsZXMxOFFpVmlLY3lkRmRoSXU4R2N5cXdDWG5D?=
 =?utf-8?B?MGFRalh2aUdpcU5GVkVPVUsraUcxZzYrZlowaTc4Z24wV0JRZ0JZWW9JQ253?=
 =?utf-8?B?Y3orQXlmellBdDZieUNMSDF0ZnZaWGpwd3NmL1dOL245UGMxY21nK1d1clJr?=
 =?utf-8?B?MVRTY2VMTWsrNWd2QVgweHEvVTNmN1NGVWRFZFhpV2FBRnB0Y1lQdWxiK1do?=
 =?utf-8?B?b1dKdlMyaE9qQTRnOUp4ZXlzZjdKUGxqZ3RDNE94dnE1Nkx3ejNFY2NhN0Rk?=
 =?utf-8?B?eHVXWGJPT1YzS2ZPWFlPeUtPZ2U0WE92dkVTTHpHc2FBVVBKRlRaczRoSit5?=
 =?utf-8?B?TlRCUW4zVXhzQWQxcStXMzBKd2JUc01seXM0T3pEZlBCOHZhOUZucjhYUmZp?=
 =?utf-8?B?cSt0cU94UjhOc2FZMUR2b3lNRmYxcnFreXJyZDNURWNrTEhhS1RYbG9GZkpr?=
 =?utf-8?B?OC9yOXdNNWdPeER5UVRQV29NV1E4WVM2eFpHc0xjQVJDRzNnd3FOWURqNkVj?=
 =?utf-8?B?V2ZJZkdUbmFMQ3krRHZQelNaaW5LUEJjNytwSTdMMXZkL09pUkgreDltV0tJ?=
 =?utf-8?B?b0xQYUFhTlV2dERiN0RraklhY2lZWnQyNnZ3NHFSdnJrSjhxQzFoTzlCbzBw?=
 =?utf-8?B?MlJ1R2l5L3VYSnFzQ2pnemNTK3puc0UzOGpod2JHRnJSQ0t6OFNZc1dlREJs?=
 =?utf-8?B?eTAzQmtrMXEzeTJ5aURzd3NhVEVEZHh6aWhQOGllS2pKaDdVd2tscXRvSHdL?=
 =?utf-8?B?WEd4OG02M3p6YWxtTXNYN2xqdWRuWHhPSUlwQkdpdUFpWmFiT1d2MXdJQ1lj?=
 =?utf-8?B?OE9EVzBqTzg2VEVOazBjRTR1dEJ3ZkQ3MTAyd1Axbk8ySnZBYktMS2hTRTRv?=
 =?utf-8?B?WXpCOHFWWkxBL0hYZDF5alN5dWtIN2hpSVlvRUVrWjl1Z0cwa2w2a1Z0eDUy?=
 =?utf-8?B?bW0zbFdYZDRKeGxRdExCK2JRclhEeCtXSTBVMzRqS2JpMGNadVI5a0NkenEr?=
 =?utf-8?B?RDJtbjEwdDlJUGtUVitVTkVNalQySURFNW9JU2hyb0p1TXl0Y1RxQW55Q1BT?=
 =?utf-8?B?ZEhaUnQ4UlE0UllGSUNWN1N0ZGtaZElWdnNSdWV6Wk80bzdnb2VYMVpyYVpY?=
 =?utf-8?B?a21hQnJHUU5LbHV2TXVBeS85VEFQQWxXNWlkenFBazVUaXR0Q2pHQWhINWNj?=
 =?utf-8?B?R3lsMUtzbkk3ZmtQZ0RSZUhkNDNmZ1BOSXQrMG9HY0I5K2tDOGtmblhKZHhj?=
 =?utf-8?B?WGFBZlhIS3VYTjJhWWZTTmQ1bnNKM2NvZzlMd3J0dnhrVnBsYS9WTVBmWWZo?=
 =?utf-8?B?NTFlSmRyWFl3UW1FQmdCQW5XblJuNi95VnRQNHBzdWtrKzNjeHlZUnNJK1lZ?=
 =?utf-8?B?bmdIc05ua1RIVFdRZEljcnplVDFYNXVPQTNYYVFTTXY5Y1U5VWtQbXZtdkJT?=
 =?utf-8?B?NU5oYk5CdzBvdHZYNUNtYm0wQ0lqZ0dxd0NMbFJjMGZCUTE3bVIxU2NrTHVQ?=
 =?utf-8?B?em03NXJqam5tMWNMeHBMWXFnN0o1aVFCQ3ZVNmUwRHo4TFJ2NWlNeDlQNkJO?=
 =?utf-8?B?R1A5V2tPKzdRcm1QbnhUUXV6TEdUaG05Mjg5NFIyZDBzU2pOWFdPWjU5ZG5L?=
 =?utf-8?B?U1FYdU0vemZuWXdTU1hjOVJVaFpIRUJXMjJEWGJncXFhSjN4RmtoMHZKc2F3?=
 =?utf-8?B?K1p4dUtuam1tanM0WEYrUEFlbTdnc1p6a3VVR1IyT2ZxS2s0cGduOUxWSVI1?=
 =?utf-8?B?TjJrazZ0cVVTaGd6dHJSbVE3VE5wMlVvTGFicVRYNDBVd3N2YVhiZ3RvUnNF?=
 =?utf-8?B?eVJSeldYSUV6WGFKd3V2UTk4Q0Fwb0tsT0lQRzI3SVZscVlLelpLMjkzUTl4?=
 =?utf-8?Q?+B3E7vpD1JOOa3yWsluk7ig=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uHcDNFL2W2ejL9WptpMxCRgcGqSOczA/BF6Q32HTpxQyiY6JzQADz0zr+h9imbbXpBgpyIWLptc4R8nEG5+5IPddoUPY+CcsJz5wQKilYlxN491MSyMWyNc4veOO3pvekcqmNpRMbhbR4M+Y4eZX+R+xAPKr2Xw1jEo30+XmzilGWdc32rctv4YDck91//Nnxn0lP6YWyPgyTWXqrcxluLTjqp1XxmuUj3kAIbgrJmPD8XoZcChjY7mXr0ANiZ1Bip74fCYytAGLIR3o3d6UpM9H2ExiM0EzAmTT7ZJn10KvjGPXRDiEdJItNHreN8btTkHHyNO9nAcnLFtPEY8iG4JtfpCZTWh31par3NucgpVtSPf8GDSOtR8Im3lkAZEEzL6IddvUkQtWgQtETuIja1aKVLuYHH3JmT9hrPxe3Zp8Psfb3Yjir4+E9GbUeJMaeB1oiwuIArPoPDFzqs9M4FMr0lasU1aFYGabQGS+i58wc9rkmDEsDtMm6G9uCS2MLJfWbG80wfmD4xRwYu6pEI6FQ01ntdlq6pqF4szBhLLd9GDdEM+dBJ0AoloQO7tMq8EXx2Svwf/H3sOrNZVhHT1qmwk+Ds61JiF2TNQ1haM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e0dcee-c1fd-4106-885e-08dc7a7e1fb1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:42:09.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40oHvOyuVJ94LlXFT6vtOfzTKay87vcWoEmfI5MnMQzP4En5asH0d0Zkp1rjoYNf7AN7axtPSnahKbMNtlTlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_09,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220113
X-Proofpoint-ORIG-GUID: zG6HBGmyW2J6VdaWOPNLrm1TSTIMLO_M
X-Proofpoint-GUID: zG6HBGmyW2J6VdaWOPNLrm1TSTIMLO_M

On 21/05/2024 22:48, Andrii Nakryiko wrote:
> On Fri, May 17, 2024 at 3:23 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> To support more robust split BTF, adding supplemental context for the
>> base BTF type ids that split BTF refers to is required.  Without such
>> references, a simple shuffling of base BTF type ids (without any other
>> significant change) invalidates the split BTF.  Here the attempt is made
>> to store additional context to make split BTF more robust.
>>
>> This context comes in the form of distilled base BTF providing minimal
>> information (name and - in some cases - size) for base INTs, FLOATs,
>> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
>> points at that base and contains any additional types needed (such as
>> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
>> information constitutes the minimal BTF representation needed to
>> disambiguate or remove split BTF references to base BTF.  The rules
>> are as follows:
>>
>> - INT, FLOAT are recorded in full.
>> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>>   will be encoded either as a zero-member sized STRUCT/UNION (preserving
>>   size for later relocation checks) or as a named FWD.  Only base BTF
>>   STRUCT/UNIONs that are either embedded in split BTF STRUCT/UNIONs or
>>   that have multiple STRUCT/UNION instances of the same name need to
>>   preserve size information, so a FWD representation will be used in
>>   most cases.
>> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
>>   with no values) is used.
>> - in all other cases, the type is added to the new split BTF.
>>
>> Avoiding struct/union/enum/enum64 expansion is important to keep the
>> distilled base BTF representation to a minimum size.
>>
>> When successful, new representations of the distilled base BTF and new
>> split BTF that refers to it are returned.  Both need to be freed by the
>> caller.
>>
>> So to take a simple example, with split BTF with a type referring
>> to "struct sk_buff", we will generate distilled base BTF with a
>> FWD struct sk_buff, and the split BTF will refer to it instead.
>>
>> Tools like pahole can utilize such split BTF to populate the .BTF
>> section (split BTF) and an additional .BTF.base section.  Then
>> when the split BTF is loaded, the distilled base BTF can be used
>> to relocate split BTF to reference the current (and possibly changed)
>> base BTF.
>>
>> So for example if "struct sk_buff" was id 502 when the split BTF was
>> originally generated,  we can use the distilled base BTF to see that
>> id 502 refers to a "struct sk_buff" and replace instances of id 502
>> with the current (relocated) base BTF sk_buff type id.
>>
>> Distilled base BTF is small; when building a kernel with all modules
>> using distilled base BTF as a test, ovreall module size grew by only
> 
> typo: overall
> 
>> 5.3Mb total across ~2700 modules.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c      | 409 ++++++++++++++++++++++++++++++++++++++-
>>  tools/lib/bpf/btf.h      |  20 ++
>>  tools/lib/bpf/libbpf.map |   1 +
>>  3 files changed, 424 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 2d0840ef599a..953929d196c3 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
>>         return 0;
>>  }
>>
>> -int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
>> +static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
>>  {
>> -       struct btf_pipe p = { .src = src_btf, .dst = btf };
>>         struct btf_type *t;
>>         int sz, err;
>>
>> @@ -1782,20 +1781,27 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
>>                 return libbpf_err(sz);
>>
>>         /* deconstruct BTF, if necessary, and invalidate raw_data */
>> -       if (btf_ensure_modifiable(btf))
>> +       if (btf_ensure_modifiable(p->dst))
>>                 return libbpf_err(-ENOMEM);
>>
>> -       t = btf_add_type_mem(btf, sz);
>> +       t = btf_add_type_mem(p->dst, sz);
>>         if (!t)
>>                 return libbpf_err(-ENOMEM);
>>
>>         memcpy(t, src_type, sz);
>>
>> -       err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
>> +       err = btf_type_visit_str_offs(t, btf_rewrite_str, p);
>>         if (err)
>>                 return libbpf_err(err);
>>
>> -       return btf_commit_type(btf, sz);
>> +       return btf_commit_type(p->dst, sz);
>> +}
>> +
>> +int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
>> +{
>> +       struct btf_pipe p = { .src = src_btf, .dst = btf };
>> +
>> +       return btf_add_type(&p, src_type);
>>  }
>>
>>  static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
>> @@ -5212,3 +5218,394 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>>
>>         return 0;
>>  }
>> +
>> +#define BTF_NEEDS_SIZE (1 << 31)       /* flag set if either struct/union is
>> +                                        * embedded - and thus size info must
>> +                                        * be preserved - or if there are
>> +                                        * multiple instances of the same
>> +                                        * struct/union - where size can be
>> +                                        * used to clarify which is wanted.
>> +                                        */
> 
> please use full line comment in front of #define
>

yep, will do.

>> +#define BTF_ID(id)             (id & ~BTF_NEEDS_SIZE)
>> +
>> +struct btf_distill {
>> +       struct btf_pipe pipe;
>> +       int *ids;
> 
> reading the rest of the code, this BTF_NEEDS_SIZE and BTF_ID() macro
> use was quite distracting. I'm wondering if it would be better to use
> a simple struct with bitfields here, e.g.,
> 
> struct type_state {
>     int id: 31;
>     bool needs_size;
> };
> 
> struct dist_state *states;
> 
> Same memory usage, same efficiency, but more readable code. WDYT?
>

Yeah, I saw Eduard used that approach elsewhere, it's much neater.
However in other discussion with Eduard we talked about moving the
embedded/duplicate validation to relocation time. The motivation for
that is that if we record sizes for all STRUCTs and UNIONs, we can then
be selective about size checks at relocation time.  This is particularly
relevant for the duplicate name case since it's possible a name either
is no longer duplicate in the new vmlinux, or in the new vmlinux has a
duplicate where the original vmlinux did not. In other words it's the
"new world" of the vmlinux we're trying to relocate with that we're
really concerned with, so preserving all size information until we see
that new vmlinux and can spot duplicates and embedded types where the
size checks need to be enforced makes sense I think.

In that context, we mark embedded types prior to assigning mappings, and
don't mark duplicate names at all in the map since it is duplicates in
the new vmlinux we're interested in. So the way I'd approached it is to
have a BTF_IS_EMBEDDED (casting -1) value that the map values would set
when they found a split BTF struct/union with an embedded base BTF type.
That later gets overwritten when we do the map assignments so it never
gets exposed to the user and we can still return a __u32 array of BTF
ids to the caller.
>> +       unsigned int split_start_id;
>> +       unsigned int split_start_str;
>> +       unsigned int diff_id;
>> +};
>> +
>> +/* Check if a member of a split BTF struct/union refers to a base BTF
> 
> nit: comments uses "check" terminology, function name uses "find",
> while really it "marks" some time as embedded... Let's use consistent
> terminology (where mark seems like the most fitting, IMO)
> 

Sure, I'll try and be more consistent around naming here.

>> + * struct/union.  Members can be const/restrict/volatile/typedef
>> + * reference types, but if a pointer is encountered, type is no longer
>> + * considered embedded.
>> + */
>> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
>> +{
>> +       struct btf_distill *dist = ctx;
>> +       const struct btf_type *t;
>> +       __u32 next_id = *id;
>> +
>> +       do {
>> +               if (next_id == 0)
>> +                       return 0;
>> +               t = btf_type_by_id(dist->pipe.src, next_id);
>> +               switch (btf_kind(t)) {
>> +               case BTF_KIND_CONST:
>> +               case BTF_KIND_RESTRICT:
>> +               case BTF_KIND_VOLATILE:
>> +               case BTF_KIND_TYPEDEF:
>> +               case BTF_KIND_TYPE_TAG:
>> +                       next_id = t->type;
>> +                       break;
>> +               case BTF_KIND_ARRAY: {
>> +                       struct btf_array *a = btf_array(t);
>> +
>> +                       next_id = a->type;
>> +                       break;
>> +               }
>> +               case BTF_KIND_STRUCT:
>> +               case BTF_KIND_UNION:
>> +                       dist->ids[next_id] |= BTF_NEEDS_SIZE;
>> +                       return 0;
>> +               default:
>> +                       return 0;
>> +               }
>> +
>> +       } while (1);
> 
> nit: while (true)
> 
>> +
>> +       return 0;
>> +}
>> +
>> +/* Check if composite type has a duplicate-named type; if it does, retain
> 
> see above about check vs mark, here at least the function name uses "mark" :)
> 
>> + * size information to help guide later relocation towards the correct type.
>> + * For example there are duplicate 'dma_chan' structs in vmlinux BTF;
>> + * one is size 112, the other 16.  Having size information allows relocation
>> + * to choose the right one.
> 
> re: this dma_chan and similar cases. Is it ever a problem where a
> module actually needs two dma_chan in distilled base BTF? Name
> conflicts do happen, but intuitively I'd expect this to happen between
> some vmlinux-internal (so to speak, i.e., not the type used in
> exported functions/types) and kernel module-specific types. It would
> be awkward for the same module to use two different types that are
> named the same.
> 
> Have you seen this as a problem in practice? What if for now we just
> error out if there are two conflicting types required in distilled
> BTF?

Funnily enough I ran into it with "dma_chan" itself when trying to load
an in-tree module which I'd forced (along with the rest of the tree) to
be built with distilled base BTF.  And it was also an embedded struct
too, so we got 2 for 1 there ;-)

But it does seem like it's a legitimate problem, so if we can address it
I think it'd be worth trying. Even the size checks (applied at
relocation time) would be better than nothing I think.

The only other way I could think that we could disambiguate things would
be to add the duplicate-named type to the split BTF (as we do with the
anonymous structs).  That would remove the ambiguity, but expose us to
the risk of having to pull in a lot more types. I can't imagine a
duplicate-named type would ever figure in a kfunc signature, so it
should be safe to do. But I think either way we probably have to have
some sort of answer for this problem.

> 
>> + */
>> +static int btf_mark_composite_dups(struct btf_distill *dist, __u32 id)
>> +{
>> +       __u8 *cnt = calloc(dist->split_start_str, sizeof(__u8));
> 
> nit: we generally follow that initialization of variable shouldn't be
> doing non-trivial operations. So let's do calloc() as a separate
> statement outside of variable declaration.
> 

Sure, will do.

>> +       struct btf_type *t;
>> +       int i;
>> +
>> +       if (!cnt)
>> +               return -ENOMEM;
>> +
>> +       /* First pass; collect name counts for composite types. */
>> +       for (i = 1; i < dist->split_start_id; i++) {
>> +               t = btf_type_by_id(dist->pipe.src, i);
>> +               if (!btf_is_composite(t) || !t->name_off)
>> +                       continue;
>> +               if (cnt[t->name_off] < 255)
>> +                       cnt[t->name_off]++;
>> +       }
>> +       /* Second pass; mark composite types with multiple instances of the
>> +        * same name as needing size information.
>> +        */
>> +       for (i = 1; i < dist->split_start_id; i++) {
>> +               /* id not needed or is already preserving size information */
>> +               if (!dist->ids[i] || (dist->ids[i] & BTF_NEEDS_SIZE))
>> +                       continue;
>> +               t = btf_type_by_id(dist->pipe.src, i);
>> +               if (!btf_is_composite(t) || !t->name_off)
>> +                       continue;
>> +               if (cnt[t->name_off] > 1)
>> +                       dist->ids[i] |= BTF_NEEDS_SIZE;
>> +       }
>> +       free(cnt);
>> +
>> +       return 0;
>> +}
>> +
>> +static bool btf_is_eligible_named_fwd(const struct btf_type *t)
>> +{
>> +       return (btf_is_composite(t) || btf_is_any_enum(t)) && t->name_off != 0;
>> +}
>> +
>> +static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
>> +{
>> +       struct btf_distill *dist = ctx;
>> +       struct btf_type *t = btf_type_by_id(dist->pipe.src, *id);
>> +       int err;
>> +
>> +       if (!*id)
>> +               return 0;
>> +       /* split BTF id, not needed */
>> +       if (*id >= dist->split_start_id)
>> +               return 0;
>> +       /* already added ? */
>> +       if (BTF_ID(dist->ids[*id]) > 0)
>> +               return 0;
>> +
>> +       /* only a subset of base BTF types should be referenced from split
>> +        * BTF; ensure nothing unexpected is referenced.
>> +        */
>> +       switch (btf_kind(t)) {
>> +       case BTF_KIND_INT:
>> +       case BTF_KIND_FLOAT:
>> +       case BTF_KIND_FWD:
>> +       case BTF_KIND_ARRAY:
>> +       case BTF_KIND_STRUCT:
>> +       case BTF_KIND_UNION:
>> +       case BTF_KIND_TYPEDEF:
>> +       case BTF_KIND_ENUM:
>> +       case BTF_KIND_ENUM64:
>> +       case BTF_KIND_PTR:
>> +       case BTF_KIND_CONST:
>> +       case BTF_KIND_RESTRICT:
>> +       case BTF_KIND_VOLATILE:
>> +       case BTF_KIND_FUNC_PROTO:
>> +       case BTF_KIND_TYPE_TAG:
>> +               dist->ids[*id] |= *id;
>> +               break;
>> +       default:
>> +               pr_warn("unexpected reference to base type[%u] of kind [%u] when creating distilled base BTF.\n",
>> +                       *id, btf_kind(t));
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* struct/union members not needed, except for anonymous structs
>> +        * and unions, which we need since name won't help us determine
>> +        * matches; so if a named struct/union, no need to recurse
>> +        * into members.
>> +        */
> 
> is this an outdated comment? we shouldn't have anonymous types in the
> distilled base, right?

Yep, they go into split BTF. However, we might need to add their members
to our distilled base; for example if we hadn't yet added an int and had

	struct {
		int field;
	};

...we'd want to make sure we added an INT to our distilled base. I'll
try and clarify the comment a bit more.

> 
>> +       if (btf_is_eligible_named_fwd(t))
>> +               return 0;
>> +
>> +       /* ensure references in type are added also. */
>> +       err = btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ctx);
>> +       if (err < 0)
>> +               return err;
>> +       return 0;
> 
> nit: could be just `return btf_type_visit_type_ids(...);`?
> 

good idea.

>> +}
>> +
>> +static int btf_add_distilled_types(struct btf_distill *dist)
>> +{
>> +       bool adding_to_base = dist->pipe.dst->start_id == 1;
>> +       int id = btf__type_cnt(dist->pipe.dst);
>> +       struct btf_type *t;
>> +       int i, err = 0;
>> +
>> +       /* Add types for each of the required references to either distilled
>> +        * base or split BTF, depending on type characteristics.
>> +        */
>> +       for (i = 1; i < dist->split_start_id; i++) {
>> +               const char *name;
>> +               int kind;
>> +
>> +               if (!BTF_ID(dist->ids[i]))
>> +                       continue;
>> +               t = btf_type_by_id(dist->pipe.src, i);
>> +               kind = btf_kind(t);
>> +               name = btf__name_by_offset(dist->pipe.src, t->name_off);
>> +
>> +               /* Named int, float, fwd struct, union, enum[64] are added to
>> +                * base; everything else is added to split BTF.
>> +                */
>> +               switch (kind) {
>> +               case BTF_KIND_INT:
>> +               case BTF_KIND_FLOAT:
>> +               case BTF_KIND_FWD:
>> +               case BTF_KIND_STRUCT:
>> +               case BTF_KIND_UNION:
>> +               case BTF_KIND_ENUM:
>> +               case BTF_KIND_ENUM64:
>> +                       if ((adding_to_base && !t->name_off) || (!adding_to_base && t->name_off))
>> +                               continue;
>> +                       break;
>> +               default:
>> +                       if (adding_to_base)
>> +                               continue;
>> +                       break;
>> +               }
>> +               if (dist->ids[i] & BTF_NEEDS_SIZE) {
>> +                       /* If a named struct/union in base BTF is referenced as a type
>> +                        * in split BTF without use of a pointer - i.e. as an embedded
>> +                        * struct/union - add an empty struct/union preserving size
>> +                        * since size must be consistent when relocating split and
>> +                        * possibly changed base BTF.  Similarly, when a struct/union
>> +                        * has multiple instances of the same name in the original
>> +                        * base BTF, retain size to help relocation later pick the
>> +                        * right struct/union.
>> +                        */
>> +                       err = btf_add_composite(dist->pipe.dst, kind, name, t->size);
>> +               } else if (btf_is_eligible_named_fwd(t)) {
>> +                       /* If not embedded, use a fwd for named struct/unions since we
>> +                        * can match via name without any other details.
>> +                        */
>> +                       switch (kind) {
>> +                       case BTF_KIND_STRUCT:
>> +                               err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_STRUCT);
>> +                               break;
>> +                       case BTF_KIND_UNION:
>> +                               err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_UNION);
>> +                               break;
>> +                       case BTF_KIND_ENUM:
>> +                               err = btf__add_enum(dist->pipe.dst, name, t->size);
>> +                               break;
>> +                       case BTF_KIND_ENUM64:
> 
> nit: combine ENUM/ENUM64 cases?
>

yep, good catch.

>> +                               err = btf__add_enum(dist->pipe.dst, name, t->size);
>> +                               break;
>> +                       default:
>> +                               pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
>> +                                       btf_kind(t));
>> +                               return -EINVAL;
>> +                       }
>> +               } else {
>> +                       err = btf_add_type(&dist->pipe, t);
> 
> So this should never happen if adding_to_base == true, is that right?
> Can we check this? Or am I missing something as usual?
> 

We're currently adding INTs and FLOATs to the base also, so they are two
cases where we end up here I think.

>> +               }
>> +               if (err < 0)
>> +                       break;
>> +               dist->ids[i] = id++;
>> +       }
>> +       return err;
>> +}
>> +
> 
> [...]
> 
>> +       n = btf__type_cnt(new_split);
>> +       /* Now update base/split BTF ids. */
>> +       for (i = 1; i < n; i++) {
>> +               t = btf_type_by_id(new_split, i);
>> +
>> +               err = btf_type_visit_type_ids(t, btf_update_distilled_type_ids, &dist);
>> +               if (err < 0)
>> +                       goto err_out;
>> +       }
>> +       free(dist.ids);
>> +       hashmap__free(dist.pipe.str_off_map);
>> +       *new_base_btf = new_base;
>> +       *new_split_btf = new_split;
>> +       return 0;
>> +err_out:
>> +       free(dist.ids);
>> +       if (!IS_ERR(dist.pipe.str_off_map))
> 
> you don't need to check this, hashmap__free() works for IS_ERR()
> pointers as well
>

ah, good to know, thanks!


>> +               hashmap__free(dist.pipe.str_off_map);
>> +       btf__free(new_split);
>> +       btf__free(new_base);
>> +       return libbpf_err(err);
>> +}
> 
> [...]

