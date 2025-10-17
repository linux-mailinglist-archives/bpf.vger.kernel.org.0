Return-Path: <bpf+bounces-71180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F4BE7532
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D721AA16C4
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B22D372E;
	Fri, 17 Oct 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2Q2MCe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="scimj1J4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDC2D239A
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691455; cv=fail; b=NESKsJG5i+O/e3DmpJJW45mLO3z1w0CtPpIM+Gg6Cbp3mBfs52VNdh/6jkBiC34NB06vm62QDNFAIGUtLTczdNn/AE2w4+0DgOthZIO71GeFgpZLH9RVnJyzKCyPAhXRCYUpEL7uWX1yFeWQlLm+e7stocH4S2qJ8ghslyOGndQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691455; c=relaxed/simple;
	bh=misLSGK9BNmnmxazw8snCufrUo6gVGqfc2mql8MGZhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuVAzATjFyxTYAWWWMBhaGpRO0ZiEIQzleZk4yn9RZNqyYqt0YXYqiQ8k4QntH+Pzvc1oK66PPU+hfvwb+PYedQOP+TaxE6WOa4IIZjgm09sIey3geau4II9wFEECbkIX6G1yPpmwL7YFomPPhzcb4xrNbvnN4BVmO38w2A5OFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R2Q2MCe8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=scimj1J4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uJoB008834;
	Fri, 17 Oct 2025 08:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pU0i50bsBuiNEV1BcIomTDnjNmV8QbL7Q7sa3xj/mNo=; b=
	R2Q2MCe8kdgfyHqKQC0NKBp1ywx++oIyPb3ktCLdNVLnUDizi3OYKGWG7y08DTdn
	LPpHuqYvf7q1fTiCqYPHvWkqqPyaujYzoq9LzywhCb218IL2zb/oMxxjo43MZnGK
	tlwONidxmrDXdQShnpXiUcCK84geumm2OX3+Bic7FUMG6Z6tTygRn0iXidMPIg0j
	SJioQhE4uq0M/LYuI1PNxXoBoPAkQri5FQbzXUFLp0xDEAgtztQW7bWF9FcyORXw
	LuF6KzDAbBt01AYYbcHiotG7r8V8QjDhsKa3bI8DMNs6YhVfw5ksDb7+iUaUYGNe
	DxPQDNWMXOd/r7QCqJkgOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47tfbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 08:57:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7Hx7K017909;
	Fri, 17 Oct 2025 08:57:11 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcjv2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 08:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJP5G4MGTVnwl0o1aLqIy+jWRQyytbneer84mD5ECPxJU47VnoaI6ouWFP9o5Lgxo+zikCsEXCDmN5Wqi8fMCrWmq9+dzRHwPAhPTpcufgkJMQutAEPAgCtIl6CylN+8HFR1fNyPrVAINFsTt7liw0GAt3VYlpAshed+JfBNlDzYoAGwGEKG77lfALo9I6j5YNoJ5xg75zSMvrMLtvvg/lSwHbtVoRXwyRc9VC7VQdBL9RY1qQ1HqTu2QXdZ0iyABXWZ7okEqnuTOYL3Pdhj2MJZVKZguOwfo34H22xKwbLu+VkRoHIPrmlSu+CBQpSP0rmrxFkV8nmo7lxeogmTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU0i50bsBuiNEV1BcIomTDnjNmV8QbL7Q7sa3xj/mNo=;
 b=auwcUf6vcWj2tDN8nsoQVM3QRaYQc1q9jdHgBfREx14JYCrUhm5YguEKHoTG0h3r1sVy678Tt/8oE32jVHjUFpsDayfpuVNFBFrG/zzWKVw0n2xlz2fEvnHBl0UAKcBeu3+kfb76nIWRbatUAdommRwdfJfgQPy7WYm+XbPbn0w0UvYC9KEHDLi2MRHEsIUjdmPNhr4wEqd2O/fe5Fu/aLRtmiGu+rEs7gEkCzuTRYXz5OxkRMRvEgXRhdLoPNKVPem52FEvHADgWoka5iDPSs1LsI9WdlpaN7xpfox6AiW66bI5NcPdqx1rqqFHvY3t/jA8DvRgO9qcVXJcSCj6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU0i50bsBuiNEV1BcIomTDnjNmV8QbL7Q7sa3xj/mNo=;
 b=scimj1J4e17ie2mr3SzrjI3OdKnSg0JJvVMny00OSsTTDCIKVz3qd9C2iU0ia8MpU22bITPXAym6jOtuEtb4UTwkdVWTcIvE+R+XlGV9amdiuATm4NEggtkdjuwGjWaE39PMLUVpGadg90u+Oq/WBMwQ7KcfbjiPDWlb1VeK8tc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 08:57:08 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 08:57:08 +0000
Message-ID: <129305e3-adb9-450a-b777-5d42f231c1df@oracle.com>
Date: Fri, 17 Oct 2025 09:56:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 03/15] libbpf: Add option to retrieve map from
 old->new ids from btf__dedup()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-4-alan.maguire@oracle.com>
 <CAEf4BzZHS8w8On8W2Ez-r+pmdurw+w=4Yo2bA0fxeYhKhqE7bA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZHS8w8On8W2Ez-r+pmdurw+w=4Yo2bA0fxeYhKhqE7bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8468d25c-10e2-4527-bc48-08de0d5b2736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amhLdDZaM3Q4RHB1UjJSZURqSE4wY2MwQlYzZUVrYlE0L1AzbjFsRHc5ZGd2?=
 =?utf-8?B?RkFJdjB6ZjhVeTRFdHZOZkRwb0ZqcktxWFFaTUVndlQrWFErUlZQdWk5aVF5?=
 =?utf-8?B?Unh6OUVkZUpMbEk1TFhudnBCQ2w1eTFManZHcEY0eE1ZRFljNExEZ1FUUzI4?=
 =?utf-8?B?ZHhzbFRjQVAyQWp2Z0g0WGtnYysxblNZNHlLaGUzRWIwdnJ0VjJoNUJiN3pD?=
 =?utf-8?B?T1d5MFkrYnRNMklDamhld0ZOUElKK2ZLS1FtT2ZtZE1Da0h4eEJ2M3FOSXJt?=
 =?utf-8?B?cTRIY0xCMnlwTEpFOGZwZGpPZnhKT0xLUHJtMVQ4MjBkWHErUHRTQlRScUpn?=
 =?utf-8?B?NFZoeW9pczYxcDNJZHM4RTdyVG5PT2JvWWs2TlIvajdLUUhjekUwTC9zc05z?=
 =?utf-8?B?TzY1ZngzcW1aM2UxZ1pkTTdzL3lVK0Irb2NtQzdYZUhVMXdoZ3NWUXlzSmY4?=
 =?utf-8?B?U0F2b2doaG96OHRrd0pOdkFGRnpNQVJqdGp1dFFQTjRJY2x5OHBnb3NLS0J5?=
 =?utf-8?B?QXgxelcvN1JhVGFUa0FiMEtPVm9Rdy9TWU9nVjdQR0lCUU1mTm1pSHIzV2JW?=
 =?utf-8?B?d2ZiZlA1Sm9LQ1NQV1piWlBXMjVjR0pHVjZZS092eUpoNHhXMWs4TGVEaTlU?=
 =?utf-8?B?WUtOdjZvcnNvRnA4VmNjZU1jUUI5Y05CSnBoWEhNZ2lvazhqanVRaUxrdktG?=
 =?utf-8?B?aEswT2xNME8xWXZEcVh3bkR6VmZPUEVNNU5mZzFTaWp3TXExNFIrRTkyOEpM?=
 =?utf-8?B?UGVlc3lmSU1MWFVLNHQ1clNlblZvQjdvbVlHTEw1V1A0cnhGMXBMS0VCM2F0?=
 =?utf-8?B?dmtDRDFVQjc0NG0wdWhUN0U5WnZvMXFKamZQamZDK3htTGhuTGVhL25meGEz?=
 =?utf-8?B?S2xCWWhJSGcvQjJjK29LUjI3UW5qQzVFSFgxZjVad09NY1FyOVFTRWJmczQ4?=
 =?utf-8?B?S20zUUphNS8zREFEaFNhUmQ4V0JNd1B6SFFUMXE4QkE4TklJcEErWU9LL0wv?=
 =?utf-8?B?bFBKb3JVMHNtRmhwM3h6RXpqaFMrTnFFUWZoWDc2c1UwYzFFSXVHekt6Rkhj?=
 =?utf-8?B?NXZNdHN2N0hMK2d5MzNoYVdiYmVPcDVoTE03S1RWY2YrOGNSTHFqQTVid1l4?=
 =?utf-8?B?cVNlTS94czQ2QWJ4UGY5N3drSENkTmxPMzB6ZzN2OHd2bFlWdlNoRTAwbi8v?=
 =?utf-8?B?SFhUYzdFRnFIS04zWmlRRjkzWlhHNWNBK1F4ci9tUm5McTVEckZZUmNaWUlM?=
 =?utf-8?B?aE0zeFpaLzd4a21ZREVlZUZqRDBzejJJV1JrRFc4TnRTQXp5b0FUOHhUb2RO?=
 =?utf-8?B?TUZRY2RHVGVaeldENnFjVjJsTkVZazhLTVk3TjJjb3pQMldPWnR4bkx2MlJ3?=
 =?utf-8?B?emVpckJjSDZjbTdnS3EvVUtBek9UcHY2eENSK3NXa0RvUmZyejZxZWFjMm9u?=
 =?utf-8?B?Y0N2cklKbHUxdmJVLzQxL2czUmRncEV1b01QSHZFaG9TVkdLQ01GaGI3cXJk?=
 =?utf-8?B?R2tQdXJFa3MzeWo1N2xnbWtLZktSeXV6MHBmaHlaWFVBQmgvQzh1RWZuUTVp?=
 =?utf-8?B?TDB6ZEFPUE5nWXpyVUN4bERuekVPeVNLL2FDR2NvN29sek1kUi82em5JcEps?=
 =?utf-8?B?ZDJpTTg4YnlnVmpiRDMzWWJGaWdjRWFtU01XWUpRRnlMYmN4TVBuMmU1eUtE?=
 =?utf-8?B?VE8yWE5zN01KQkxEN2lZcHFyaHBIYVFrS2oxeWZTTlZwdVE2NEFPWmRvQnZD?=
 =?utf-8?B?Y1Z6UVh6c3ZMQUlyalNQd2hlSXc1T0E0MVNWTkFBT3NtbW5XOWVtdW95aldF?=
 =?utf-8?B?MzROY21zWnIxZSs5V09PK1cvdHlKVEFZdlJ0bnVDT1lXdkhOZncyNit2Z2JE?=
 =?utf-8?B?WG84cHBnQnFzYkJYbHVtdXcrRVZMM2I3QUdNcnB4dVFFcGQ2bTdvcHd3SHNO?=
 =?utf-8?Q?4W/Mmw80OZdzZGrLC4QFjrgrarRO5XfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEg2dUFkay9CQ3NNdXRhYTBZZ1Q5YW5qQ0h4U1VYT1VTaFZDdXJBK1A2Z1dT?=
 =?utf-8?B?NzJ0My9Ld25EZG14Nmh5TnhWS0hiQ0MyOGFldzc4OWwxTXZWQ2VlNXM3NWlN?=
 =?utf-8?B?bTlSaFM3ajl3eXNyU211R29HTEZGWm9veFJqSnBtNno2U3I3YlVoUFVZUXlU?=
 =?utf-8?B?T3NIQTl3Z1d2Mm0xVW1QcWNsaW5VYXVPaTBjQWgreWFGOXJyQytpdkZBQ0Jj?=
 =?utf-8?B?dGFOV2V4aWxTcGpoMWsySVE1RGVSOVlKQTRFNGU2QWtyUUF4bXZ3VjBoRjRp?=
 =?utf-8?B?MzY2Qm9lbkIwSkhkNCtCNExLV2c5Y0w2YUJycEtuSENJOWlnMGx3blZIRFVC?=
 =?utf-8?B?RVdpeGJNRUNSRjBERlZiQ3d3NW1rbzNpUmkzVTNOTWo2UTBqemt1MWdydzZn?=
 =?utf-8?B?RkNKL3pWU3p4OVFETTd4eHo4bUJzSFhPd1c0aGRuOWx5dUVhakxEeVdaVjRj?=
 =?utf-8?B?UEMySTJ6cm1IbXZ6NlRGUzUwZStyTEdQTnNaSzI3TWUxdUtwVmg0QTdvaEd3?=
 =?utf-8?B?RkJwWXJmSUxJODZDdXZnem5RMzRaU2tVbXg1a00rcEdlNHUyOFBOYXV5V1RX?=
 =?utf-8?B?QnJGMDBIM1NpMUJvR2RYamJteWVIbTRjYUd4ZDNMWDBWMXlGd0s4ZDZCY05o?=
 =?utf-8?B?UUNid3NQbEExc0hiRGpSYlEwYWo4bnBWdHJrR3dxYUMrb0ZzNGpJQTlIbDJt?=
 =?utf-8?B?REhJZGxRSXpBbnprU3dXdHBKS1IzUlVpMWVoSGRmTVN3eHNsV2s5dkZKUEFV?=
 =?utf-8?B?d212N29mcitNZlBFUFg1L0FZK0NNSEpEbnZwNWVWa1VlQmtsc1dCcUZPTVAx?=
 =?utf-8?B?RU84cTdRV2NCZll6SVIxNkZpWUtQQk9lQXlTMFNQaGQwWjBUL3NrM1VJWktH?=
 =?utf-8?B?RFBpaFcwanp2ZDlnQjJsRVpxbDhXdndPQ0NOdk8zdHNaSHZCZlpObHBiMTMy?=
 =?utf-8?B?czZhaTQ4WWpab013ZzBBWXlSbHdUamlndEtVbkcrZkcyUXpxcTVub0F0WVdV?=
 =?utf-8?B?WHpWZU5nZTB2WXppUEd0N1g3L1pqQjVIeFVUMGJUaFJ0aVo5WWxka29ZYUhH?=
 =?utf-8?B?SmhUSzN1YlViWWI4S2pvZ1RiMWZCeThuTFBCTVNiMnJ1VFo4dlFRRWxVb3py?=
 =?utf-8?B?cXI2KytadWh6bkZ0Y0xKTlJkNm1DcTNaTjRXcTlzNmpDakhYaXhoZ2R6bVpp?=
 =?utf-8?B?c0FDbzdaZDdFSFFWSU5JTUFkMVFNYlNXN0U2YWVudE41V1Z3dUVTV1V4NGh1?=
 =?utf-8?B?N3ZRbUUrWFZXa1FrVlJqZHNabXovY3NYa1FrSUdZMlRmZU9oUXJqOXVMVk1Y?=
 =?utf-8?B?WHBRbUpVOE5JejVaTjBhTzV2S2VJb3JycU5ESzBScm5UWmcrL1JvSElBR0Ey?=
 =?utf-8?B?M00ycXdqRE4rN0x3TDE1TEdqSFRNcDJtMm9kQjFFOHBJRnlRSTZSUGh6aW94?=
 =?utf-8?B?a2h2VzJUZWEyRVF4UzRyZk4reFo3THdLa3c2WkhNcDJhektPNGZIL3IvT2NO?=
 =?utf-8?B?aFczdXJZTDdCSWRyVy9TWGdzWWVZM2YzbkwraFd5RFh4d0MydlU2K0I3amZR?=
 =?utf-8?B?eWtvdnUwbDZ5UlBTQ2JUSnRHcS9qTUtmVWo4SUZmcWN0MTk4QzBMcU0vdEcv?=
 =?utf-8?B?WmxhRURiZ0xkR2VXRWd4NklOZFBZcTlpcmtkSjFFYko3UTVRMHdTZlBRY1g0?=
 =?utf-8?B?S1k2TEo1L3pGeFNESjViQjFZSXduNXZWMmZWUXpGaUVnQkM5ZTRiS0FRVVR2?=
 =?utf-8?B?ZHAxSXFSaTJWakprUnZSTzdQeTZDMXVUaHExUDlSbTdmVWhWenYxMTR3bCta?=
 =?utf-8?B?K1p4MHg0QlRnZzFiSXpoYy8xUDkyYzQ2L01pa1YvZHFYNytscnQrVUVJcWRO?=
 =?utf-8?B?d2RIN1Yya2U1NzdLRFVWbWtlejIvbUlHOGFSM2tnd1VGc2lBL1JWbjV1Zzdj?=
 =?utf-8?B?d0dqVjdsYmZzTVZDdXhlOGh6a2QvODRlRkFyWG5DbWkvOGw3QlZibFc1amxo?=
 =?utf-8?B?KytLZHpub0hVUVp6azNTZjhDMmNDd0d5QWliU0lrWTlsYmRYc2FvV1NJbVJZ?=
 =?utf-8?B?YXJGT2R1Z01mSGs1Yk5vYUpxSmNVNkVSTGpmTlpmUWErQm91SE9ScXFZWXFz?=
 =?utf-8?B?Q2dDeU9MZGV5cWxiVVZaOSt6SUxxUEd2Mk4vTXp2UTh1NWtEYlFlNHFndjd1?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CUDN34BuXldyW/emiLA2XdHrytOX+x8hiaWb3cBcDFwxuAmaoOawpUZjXUmGh6PTZnivfd8AEF1oLI8gheca7QWLUSiQMrPquJd/utuyOGSo6sB+QO7kWsWD7one/5xS0I0LZGqjvI/ynE6SJ/ajmbPG8JmAIvXg2XcFyXIROGLYh07FVU3tWicGWtveS/GlvgErZh1onPgEzdLtB7ILlovFytxHLZ5K4jcjU0CuTra08vYnuIajmB0GlRc5tqO04YSLBlqgPuWR/NeGlAHfEz55o3XI7fWNLYAv5GU9E6ziq/v4NOLkzLIZ9Ycwb60+YS+D01Sobqc0h7jHlfSe7ocN2Kz59cwKC194+wxq0YbDUDVf/f2IaF5ax5aynZHiYwbmFad7W8bWdPAhuZnk+U3cktSN9cl9CnNvkjE3yP1tqgX/g+YKhuXlPS7tCEiYPrIoSGGHqShn4stg/A34ebXu+RrntWMVKo3cyxtdhjF029aIRXc4bzX+hP05ZL2AdOj8JPYHs5L8zbkbcRzVmXGQIIqxJUtWZAQGIipybVHhuGNU3LI/Z3QI2QwvzsbP8c52jcSeynGav0tqypNeoev+TnfLDYSFerDjAgWkRwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8468d25c-10e2-4527-bc48-08de0d5b2736
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:57:08.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNbTLSOoBpyoNyWFVI8OKhDetndMlDjYAb8u7ZTnW1EYdZSoG3j6NZE60lxHjNVaKy+XI1uf67jO08Kz3Drr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170065
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68f204e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7i_HOK9ytEczOMLSvHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Gb8bLtJ2Lk4a5dw81Lb04dhKVB7X39ke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfXz3/3vlnvxOSI
 zMz1eNOq5ESjU2vmCpW1e2610qkTLIJGjoCNPXt1MFzeb5gFdyLVE2ezXQQ1LyGybCWAuGGJHGd
 aAAYBS4lFv+tbEnlvjlSaYKbhUgDPC0e/3391Ilfj4JuPU4X4JQePVmz0iKHRMqeUiFpmz6/YeM
 2Qnt4cNdE5mXO0B0eWqu3B+dhd2BVO0jIN5u0G2LEFIjxa4lallasV3TVog8Qf4kVRno9KMdCCc
 fDZ84SEPrgTzTf4+9pb6WBJOW02zWmym7bUahOaxBWqkUSFgMF+MXoElRVIbz4uYpUJR6bjb+Cj
 KdLcZVMrcDMvT13STeNvsefv1h7Mu5RQeNN8WWpECfyAYI6ov7YHcKPZaJ5kkbYaxOPspeBqE7c
 cOPlEq9HEKFbDlvAC4CRQl+QmvR5cg==
X-Proofpoint-ORIG-GUID: Gb8bLtJ2Lk4a5dw81Lb04dhKVB7X39ke

On 16/10/2025 19:39, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> When creating split BTF for the .BTF.extra section to record location
>> information, we need to add function prototypes that refer to base BTF
>> (vmlinux) types.  However since .BTF.extra is split BTF we have a
>> problem; since collecting those type ids for the parameters, the base
>> vmlinux BTF has been deduplicated so the type ids are stale.  As a
>> result it is valuable to be able to access the map from old->new type
>> ids that is constructed as part of deduplication.  This allows us to
>> update the out-of-date type ids in the FUNC_PROTOs.
>>
>> In order to pass the map back, we need to fill out all of the hypot
>> map mappings; as an optimization normal dedup only computes type id
>> mappings needed in existing BTF type id references.
> 
> I probably should look at pahole patches to find out myself, but I'm
> going to be lazy here. ;) Wouldn't you want to generate .BTF.extra
> after base BTF was generated and deduped? Or is it too inconvenient?
> Can you please elaborate a bit with more info?
> 

Yep, the BTF.extra is indeed generated after base BTF+dedup, but the
problem is we need to cache info about inline sites as we process DWARF
CUs and collect inline info. Specifically at that time we need to cache
info about function prototypes associated with inlines, and this is done
- like it is done for real functions - via btf_encoder__save_func(). It
saves a representation of the function prototype using BTF ids of
function parameters, and these are pre-dedup BTF ids.

And it's those BTF ids that are the problem. When we dedup with
FUNC_PROTOs in the same BTF, all the id references get fixed up, but
because we now have stale type id references in FUNC_PROTOs in the split
BTF.extra (that were not fixed up by dedup) since we didn't dedup this
split BTF yet, we are stuck.

There are other alternatives here I suppose, but they seemed equally
bad/worse.

One is to rescan all the CUs for later inline site representation once
vmlinux/module dedup is done. That would make pahole much slower as CU
processing is the most time-consuming aspect of its operation. It seemed
better to collect inline info at the same time we collect everything else.

Another is to put the FUNC_PROTOs (that are only needed for inline
sites) into the vmlinux/module BTF. That would work, but even that would
exhibit the same problem as even those FUNC_PROTO type id references
would also get remapped by vmlinux/module dedup.

So it's not an ideal solution, but I couldn't figure out an easier one
I'm afraid.

Alan

