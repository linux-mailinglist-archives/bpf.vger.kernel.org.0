Return-Path: <bpf+bounces-70976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B827BDDB96
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A819504593
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82A313523;
	Wed, 15 Oct 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVcsh2ng";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cy2l5lC1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405D1A23B9;
	Wed, 15 Oct 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519721; cv=fail; b=TaUdfxRxA1TH6QAszOFeYY/wbtcD8w7grw8JUINeBBcY9SCqYBb37n6Coix7bEDp/4eP86+znDkWU39sPFjt2hZEctMGoi4uxFFJMXgMucy5InsM5z1m7HzOu5W8OAY/Eq8B5paIjnB3TfaHaIYbk+G1+B3a4uXRkL/g1uf43+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519721; c=relaxed/simple;
	bh=0vC4flYeRUsxAkGjxG/qXAIfBifKrGmuM9kRoCfnQfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5tP4OucHs5fOY/YG83DMYiEyl2boNjttzR/5GfXxLKTXnKHRxIVMh03elzgx1mzMdNXMkDNkjvhN/hH3CvVmiRHC5FCV0rr0G5/VmQ0YzZNFKTAX+SfYuyBOJ28I+i1cF62VP2gBkqu1odUCTd4fAeNZ1E5PDPYsRgHQpMBYxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NVcsh2ng; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cy2l5lC1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uLb7030854;
	Wed, 15 Oct 2025 09:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T0PXHOApZEZxfRH0b2zC6T6UeDEkdsqLLtlaLBWS+V0=; b=
	NVcsh2ngpzy/Zbqpu1yDm7DjvAawRJPICzV45G3mdGS2qaZHciTTJL8Tdvm6I8N1
	Lp2jObUFxDa83p5JzJ70JRJpm3376OS9wxVZZILDNzhrQgtH5pKnYAR2JI2kGqP9
	xijqbr7HDEc/jYoaK3emUSzWowFM+O2U8Bs0pJg4w86EehXSDqRT/GPDsCPLIVzq
	WHJk3RJLm0qez20giArT4xtfOqumsD4tCJsGkEhntGvITKvkehz/4P9r97xPwQ0G
	oTAbX9LVq355GH8KT2xJZf9bS0HGtZhy+7UCwMiVijgm97eBKMXWR6AuQY9Wckn2
	sKrmbG+EyPwxOTvO2L89RA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bx9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:15:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F7ALv4017150;
	Wed, 15 Oct 2025 09:15:14 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpa2u9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbocdfvi/rBbLv2AgFmFpn2vA2jAxaXcMneqCpHc8x7KQuBOg8+7zfBfUnKfg5K/0K3YufeWAjs3UbSoH7+JK0KTvoDw+XQo9guNsi+QIySLpQ4SLZnhMGa1s/DVRext79bwBRPjNGT69RpgxgHXCJvfh/CmcifRsE0zdRG3na/Hpv4Aq1jKtWrPD8807Z/yudyiQ+DQoBKCVdi4wdcL8AZf0YEhPqrJkwiWMzJCqAFVxyrWZq3HORH06uuPOIZZlfOjW7PPla4FXV6PZ3BKHwL5B4C/ulNJMyRSOrzf8V8GUufNiW2hmAbkPMY4Gq0bQ9y8oSTJZXVP4lSbAlk7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0PXHOApZEZxfRH0b2zC6T6UeDEkdsqLLtlaLBWS+V0=;
 b=wFthQkca1pznXY8DaIbf2z2qFjDaQdwxslFlEu/DMZprHo/KBo1TTOnCprxwIsfuLQSYYme8Z+ZfKd/kwDbyejYzvmv7TkdD+Ty0RkXzCDzRcFPFwn77UUYycEdQAe4pHkbWgSbBWivuf1h4Dl7Xclfe+X47IgikqCHsZ+OfjSi56/SX8Suoi6rPy4L4/ozpV8G+KytFTxlIPfCj/Jgrq5hIenERGw0nnRp2QeDhkSjiPJaSyXfLD8jXj+E0EQj5Vzsl3ZzrF3BOBmUgSQKDzX0Jbh9yDzO0OK5UEFVA3BgEzIq1pMhxT0E0S4sBt1j6vMYP3JZCawD2rjoVoAiJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0PXHOApZEZxfRH0b2zC6T6UeDEkdsqLLtlaLBWS+V0=;
 b=cy2l5lC1HVegw+JYnttpBiUcbiOMUlIwAVdrihkLbYtUcOnPWrzu6YN/8x9t3kUH9AYU0cp8KYHnT4nRGSlkdJ5peKVjk1o3ivrOPjp/7uVYMmBV4HOxypQTwMpJlsfVC7K/e5RYSSOW3eHHLMYluFkMgjmsuJbX75wtjJynCkk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 09:15:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 09:15:10 +0000
Message-ID: <fa45f7dd-1df9-4928-bca0-0398b0a07eea@oracle.com>
Date: Wed, 15 Oct 2025 10:15:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        pengdonglin <pengdonglin@xiaomi.com>
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
 <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
 <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
 <CAErzpmvdvDFWyKXiqAxZHQTEArCKCPZ1FFqKx99Nwu6CG1sfqQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAErzpmvdvDFWyKXiqAxZHQTEArCKCPZ1FFqKx99Nwu6CG1sfqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2dbd75-e294-47ea-1cdf-08de0bcb56e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk10aitwU3NGdlpraXlDQmo5VTFXUzJmRDl0OVJ2bVZZa01zRmEwOHJNcWdS?=
 =?utf-8?B?aS9IcWdjbzh6ci9PUk10R0R2VTBta0ptczlNWEtzNVF6UUF5MkxIR3A1WHVm?=
 =?utf-8?B?elZsckdCbXBtVzFobFM4NUFKYTB3NS9HckZ1Y3htaFg3Ny9kVjZjVnFtZFJm?=
 =?utf-8?B?NldZcktITGJVck53RWJnOHJWbTZMTEdrY1U5aDkzSzlOWjRGYTZHZjJYd3B3?=
 =?utf-8?B?b2ZrTThyZzFXdnZGTEJHYWVLMXVqcm9iL3ZLQmR6MUxrTndRbmMvdDRCM2RI?=
 =?utf-8?B?OTJjQjd1WmNYWjNlNmRQL3M4UWx6VUNyc0I2aW1GbUdRbGRKN0gxYWJ4SVZH?=
 =?utf-8?B?MUQ0blFza2NwOU5rUWtsQm96YVFrT0JEaWlUTzVMenMvd3YwMTJGNEtBQ29y?=
 =?utf-8?B?aVZ6MUNKb1VpdXhmN1pQR2FEL3l6OWxmTHk0R0Y1b1ZZbDM5V3dYR0llZ1Jw?=
 =?utf-8?B?a1AwQ2RGbUdkdys0RHgrcWlHR1VFYVBtckdaeHpMTDkxNEw1YVpnT2ErNVZZ?=
 =?utf-8?B?Wi9ZaGI1cGJGRGVuVjFtRmoyTGJEenBOcXJwU0Yzb2xDRWU2eU9RVDNIVEU2?=
 =?utf-8?B?UktsTGNaVDV2S3hJRFVZQjZhenVmMDNOL21LWVNBT0xRQVZJRE5wQ3RvdGsv?=
 =?utf-8?B?TnF5SFlXcDlxOTlPcFNwWGxVRzNwMFQ1SmdkYzU1cGtJaUVCZHJiZGc0T1Zu?=
 =?utf-8?B?VlJQRkVrMUZxb29tZkF5WlM5MFlOZnMzMVB5cmNjRkk1cWRDeEZ4dG9PbXA5?=
 =?utf-8?B?LzJITlVDc3ZDYkhoQTNxbWdoSXVGT1JBM2xEeVJCbG5QRW42QVFwRmdYYmhL?=
 =?utf-8?B?SkdLYVJCOXlUbkVlU3l1OVBvMFlrdmtxVEs1RFZwenFvaC9kKzVkYnFUTktT?=
 =?utf-8?B?VzFxNE1Xb3B0R1hjdTRVbkVOSWtZYmRnNjY2VVNvR2ZhZ25JUlFkeGVIbXQy?=
 =?utf-8?B?bmc3Y29HaEtlUWNKdFNNb2E5ZmFtVm9YSStwL1hFNVI5MldiSHphcDRNMldQ?=
 =?utf-8?B?NTN4Q2J5cFdkbk1rMURZaEZhUVZQRjVRUHZTV044cnh6TEhiSExzcEgxZTcz?=
 =?utf-8?B?YitNdHo5YlhNZXd2c2ZkWE9ONGZSRy9wcjVhMGcxN2JRcTlEeDVheEovUnEr?=
 =?utf-8?B?TVFNMVhjY2lXOWtqVXpKOEtFQ2JqMWU2ZVRRUGwwYlZrd3ZWZmNQYUdUMWtX?=
 =?utf-8?B?VzEvWkUvem5rQkRpNTYwUE1Pa05EdkdWZUNjaFlMb0xTRVJjOStEZWxqVDA3?=
 =?utf-8?B?U1orNVVWNkNNTDR2Ukw0bkxtUXRmMU9ydDN2blpkQmczSWxNdG15SVdrVWVY?=
 =?utf-8?B?Mi9xRXBoeXNNK21TYkJCWE9zN0pvR0E0bzFRbmgyM3F0eFIvOXhob2E1ZHRB?=
 =?utf-8?B?aWVWTk5LeXRsQWhxMmxnYVk1UkV2bXRuMWtGNjA4QWM3a1k3UWdxYlZXbHJE?=
 =?utf-8?B?OS9vSWNXbStqOG1LWjBCVFlOcW5VaW5KSW8zYytpZFo5Z0pyeDNoS2psMHY3?=
 =?utf-8?B?QzZtTXdpQUFVcGRUOGxDT3FGckZpTnE1ODZpeGM0T3J0Rnlzbks2R1FDTElG?=
 =?utf-8?B?N28yMnpHdjd1ek1NVU5ua2Z3Mk1BcWVEanJ5WDBjMlI3Qm9xRzI4UUJrUlA2?=
 =?utf-8?B?U2U5aVBhZk1CcVpLU3RxSkJ5MlZJeENhUGo3d0FHQ0hSM0xjWGVyNmFqczBk?=
 =?utf-8?B?NXIrck5qTENqNzdkMnZkZGwzTW5YQ2FkbHRzQitWcTRzbE9sMkVkRHY3SXNK?=
 =?utf-8?B?cC9ZU0YyWnI4UnZPTVpsS3JRREZOSjk3VzRaTVduN2d1aSt1dnUvQ3ROWlY3?=
 =?utf-8?B?eWVCMVBIUDYzL0NCMlJhMDdFMHAvL29KQzUwalZZczRsdHkyanlrR0pjWHZR?=
 =?utf-8?B?OFhzU0lQWTFHRThxM0xyZlZoNmdmY2xHcmZaM254TER2bTJPU1dZZVY3SkZr?=
 =?utf-8?B?NjBIVTBtK1hlRXZwdEFmbi9uR2hrbCtDcVJ6eVRkeFdpbmhZTytma3ZSbnNi?=
 =?utf-8?B?S3lEUlJEd0h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTVLK3NjZVpFLzN1ZStKNVBzSEE0T2toVWtsSmZOMkYzVEFYUEFJYU1PYUFa?=
 =?utf-8?B?dVFsK1RyUE9SU0lwTWs2SlpIZG55OFo1THZqRkZVVGxUaHlMemlsQURDVFVB?=
 =?utf-8?B?T3d2eFR0Rm95R0YxNmxFc3Y5M1ljRXZCTkV3STZnUFlndGUyODUrUGd5a1NY?=
 =?utf-8?B?Zkk5a1ZLTG9SR3VlUjlCWEVkMjBUT25sS1VEQUFwSUdqUjNMQ0FZWlloWDJs?=
 =?utf-8?B?a3hUVmtId0hCSis0ZGliT1JMQUxId0xDVHlLN1kyaTNsamo3MVFxV053RjNO?=
 =?utf-8?B?RGtvVVpQV0JrT0FZOGV3VEZ3VzV1emN3MSsvRTBpNHVZc3pOZ2RHOWl4NUF1?=
 =?utf-8?B?bjVYMGdoRExnbkdvVHoxVUd5ZzJkN29SWlhpVUVWYkhhbEw3ZHMvUXY5M01w?=
 =?utf-8?B?U0REU0Zhalladk84czlSalBRT1FBYTdhSnpBNjBpVVZ1K2wyNkJCc2tldVZS?=
 =?utf-8?B?OCtlUXZwWGJqY2dhc0p4MjFIVWo5cytVUHRHNDdVbGM2UmlJeUt6YzRiRm16?=
 =?utf-8?B?dmFCVTdETG5oOXVJVFltYnozellVdi8xRzFDbU9yTFdqYmVLMzQ5ZUhtWFJC?=
 =?utf-8?B?U1hzTi8zVUFkL0VhWUl3cHlkUUI0S3JuS1ZRNFNWODZNR1BQLzExTlZzREs3?=
 =?utf-8?B?UUVRazBwR2czK1gwT1Y0ZjlsT2hlSSsrRllBNjFIU3NodDdpNTI3NU1BNFZq?=
 =?utf-8?B?dGp1cmh3UzZyL2ZLTmtNd0tEUHVHVlBveXRWWnB6L0NqaXVDdlhkdU1CQ29k?=
 =?utf-8?B?V3IrNXhpcUhkU2ljOU1aRS9Nd2tuYTNzTVcrT1lwUUhLbWZBb0R6RnBueU1n?=
 =?utf-8?B?YmtlSGdqUWNBd3EvNnpJL2d2aHZ4ZTJjSXJ4UjNBaDh3VWZ2alRQZjNtRU1l?=
 =?utf-8?B?QUNIQ01LUlQ2cWNTZHlHaTlIeEowYjZFVVl0SVp4L2Z2RG9Sc1kyTlptS3ht?=
 =?utf-8?B?bC8yVWVqS00vRUVvSnI3UE1UVEZnYWtkeGhFV2hWMm40RUNpbkxPRFk1cUZt?=
 =?utf-8?B?MU9Oc1FIK29BMUZQYmM3dkVPR2Z4OEVnTlhXMy9mSDFjTDdLRmN1azNoU0FH?=
 =?utf-8?B?Ym5RbWxxeDhsL1poNVdqdkVIbU1SL3VXUzMvU28yNS9hcFZmeXF4SDFnUFlh?=
 =?utf-8?B?Rml4dDMwOUxmRGtKUytVQnpuWGtVb2ZnL0RqK2x4SThKYVFlYi91UGRnazZa?=
 =?utf-8?B?WHZnVXhnRmVOOVUydE50V0N5U3hJYzNmRmhaQi9lSnFpUDdsYTVPbVFJS2lj?=
 =?utf-8?B?cTkyM3A5TmQ0VDd5K1ZSMmdjM242alJtdWsyUGh2TXlyeXZkQ1o5WFI4ZHdm?=
 =?utf-8?B?cnlWWnFEemEvUkh0NUt4MWMzbzNYcmtKV29VbFJPVnVaVitrYXh5My9Ta2xV?=
 =?utf-8?B?bUZ4NG1sbTZ2RFRwNlhEcmswRXFLdzRiWHZ3R3Qra2MyeHBzSFRxTG1XMVhG?=
 =?utf-8?B?TzBrQnJZWVk1Qk5UaktwMTNFcmV6ejEzR3NzQ3Vwalg0N01rN3ovYkV3c0FW?=
 =?utf-8?B?Ukp0aTdWSG0zaSt1N21idzdzMVYxdFZ5QS9RZU9Ud1ZmV0ZFV215ZHd2YVNa?=
 =?utf-8?B?eDdKRitWdmowektVaEE4R0NIUmRUUEVnRFZZcUUrbmZuSFZGc0lSeGNDZFhT?=
 =?utf-8?B?TUNBQ3dCZ2x2dmVLZktzRG9yQktvUmVTamJId00xK0xDZW9yV1dPcE94d2wz?=
 =?utf-8?B?dnZSV1BOSjNFNE1BNDBjYzBxWmFHR0d0MUhmNXBKK2JLWFU4RHNISGxjOURk?=
 =?utf-8?B?NXNVU2JUQkxFa1ZxNm9KQkJFVnVNa1FEQTFKR045T0dKUkVFTXhpU2pXQ2lp?=
 =?utf-8?B?NS9XdXlWNWtuVUF0SnUzT05RVGI4cWlJUnBPVmtkejNIdU1wWE9JTE5hdnBQ?=
 =?utf-8?B?SGsrMGwrK2JTR2VvVk4yRjBsUFlmS2h2eUg2N1pyMllkaFllcmM5M1JMVThj?=
 =?utf-8?B?QkdSdHc2VVV6MTFDclVUQ1JMT256azZqeFBMOTBUekVCZHYvZER6Yno0akZY?=
 =?utf-8?B?NFJ3b2Uva3BTbWJ6eDNqbWNTeEY5R0VJeTNSU2dEbDNmb0ZzOXpsMEc0ZGt4?=
 =?utf-8?B?SHViZ0R1UGhNMlpJbjlCc205U0hQN1AzYXNHaWpZMFgzcmRrSTR2VStBeEpt?=
 =?utf-8?B?N3BhSWh4SzF3QTJRb3hYem1LVGFRYWpKUVF4OU1oeTkrZ25XSjBuQTB4d2Mz?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HY66ag364TrN6UyfYA/+7at/xJ0+Ik+P/d90QYs2Sw0ZVpbk1P2o1xw6iSmOBS6TV4spoRPpVMlX2fE9iAOuVUQpYQwjsgxlzPk1WUO1tP3ymE3ty5mL5M88k/15jb5fPlVHYbXtsPXN2jEnUr+yItpqyqbFDDIn6MGh34r1rSvP/PaZOrOry0WTKewy+TREu+BWk+x95z3fJ6C2NgA/M87FdwrNXWuL8TbcMxG0PcSFiFEWN9YIhC3NafOYx2AJHSHC7lNmmG8pxI9IcZ9l9OA6pG4MQA4rzDcA2Ljh+VJRVUzehEa+Yd3/oGJB68b4T/bRXQgU985vmib5RvoOQ4J9CVLq8VqvxqMBlPpnip/O9lyYBKOEMcA8EIzfzRS0l98YsiXpvP5Tjp1Th1DbmWAAVkaQtuGXUdj/JAWOSzMaWFAQD+0RkhUE78rY59Nmdo/cra/nukOwPHA9IwG+ANBpticQDyyYgqRWO/bFUbJOb+kSJ1EIaQa34QkkvGu76feK+OYmyz1jrOUJtX6UESO0939BRiwQoep+qwUgm+heg4iT1DBtZZntUyKijFuasZbqdPU+v8WPxEzfWiwmglMIApqNexAznr92rr7JtII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2dbd75-e294-47ea-1cdf-08de0bcb56e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:15:09.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13nUtKfNw84WYjmYX1/u2dizGf6lfkc/QQjSYjq+li1hIeVtXK+nZuotV56Ds74g96k/n2rF9fTIlrvckCo/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=965 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150070
X-Proofpoint-GUID: whA39b-AEBBXLFOUdIvY0yPF7AYlhaoF
X-Proofpoint-ORIG-GUID: whA39b-AEBBXLFOUdIvY0yPF7AYlhaoF
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ef6623 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=t7SokOkX3h5_LgWNp-IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX19ybe3xbO4P3
 WneHtMp3YttaIiGYKiLLV8AGYkx6OMoxRXsigwaLAk/HXBMlncxEg0imMJuWKbd3Up8EqFxIBt7
 xYGtH5Qw/b5atCaABvrTbrBKr0epMsxeTAcrrjYMK2gXFFlHMejG7lH0baOHLgzWDaPVD6xwLy1
 0UhwKkMHzzt5+i3p34zp/pH1CjnK4RapvqasW7PJLzcoS0RxoRjuxiFII8FvJtHb09o252IsUm0
 JeAAEPkEdd29Hp67cyCfe4ASIu0sssoti4kDeFZtXubSSxdJDcdxJq3sWGPliX4WoYrjmj2t4dk
 cxxiiRXbRXrVEVqDGYymlHDYBUqLtyv/QUTHMlrM93SnUfx3fxkKlyjuiz+L2e6wkv5E/STlGiO
 kG4lVECJt21KolB+sGh5CsNQ851rBw==

On 15/10/2025 04:43, Donglin Peng wrote:
> On Wed, Oct 15, 2025 at 9:54 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Oct 13, 2025 at 9:53 PM Donglin Peng <dolinux.peng@gmail.com> wrote:
>>>
>>> I’d like to suggest a dual-mechanism approach:
>>> 1. If BTF is generated by a newer pahole (with pre-sorting support), the
>>>     kernel would use the pre-sorted data directly.
>>> 2. For BTF from older pahole versions, the kernel would handle sorting
>>>     at load time or later.
>>
>> The problem with 2 is extra memory consumption for narrow
>> use case. The "time cat trace" example shows that search
>> is in critical path, but I suspect ftrace can do it differently.
>> I don't know why it's doing the search so much.
> 
> Thanks. The reason is that ftrace supports outputting parameters of traced
> functions through funcgraph-args, like this:
> 
>  0)                    |  vfs_write(file=0xffff888102b17380,
> buf=0x7ffd1e9faaf7, count=0x1, pos=0xffffc90006f83ef0) {
>  0)                    |    rw_verify_area(read_write=1,
> file=0xffff888102b17380, ppos=0xffffc90006f83ef0, count=0x1) {
>  0)                    |
> security_file_permission(file=0xffff888102b17380, mask=2) {
>  0)                    |
> selinux_file_permission(file=0xffff888102b17380, mask=2) {
>  0)   0.111 us    |          avc_policy_seqno();
>  0)   0.380 us    |        }
>  0)   0.585 us    |      }
>  0)   0.782 us    |    }
> 
> which requires obtaining function parameter names and types from BTF.
> However, there is currently no direct mapping from function addresses to
> btf_type index information. Therefore, it first obtains the function name from
> the function address, and then searches the BTF file by the function name
> to get the corresponding btf_type.

The problem here is we have a lookup every time we collect function
args, right? Binary search of sorted function names will make that
better but it will still be slow if it has to happen every time we dump
function args. Would it make sense then perhaps to have a more tailored
solution like a cache of BTF type ids for functions that could be mapped
directly from kallsyms symbols? Mentioned this before [1] but maybe we
could figure something out now?

For example, we have to look up kallsym name for the address via
lookup_symbol_name(); it uses get_symbol_pos() internally to find the
index within the kallsyms_offsets array. If we had a similar array for
kallsyms_btf_ids we could use the same index to populate it with
function BTF ids, we could later do O(1) lookup. We would just need a
kallsyms lookup that returned the index, or indeed a new API which
returned the name and the BTF id (if we added such an index to kallsyms
code directly). We could even just populate the entries on first use and
then it would function as a cache. We would need a module+btf_id in the
index, so 64 bits per entry to support both module and kernel BTF. Seems
possible though?

[1]
https://lore.kernel.org/linux-trace-kernel/8455bc79-a684-476d-88bd-9f7ff9ffa637@oracle.com/

