Return-Path: <bpf+bounces-64025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82925B0D6F5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFD23BA3A9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198552DFA28;
	Tue, 22 Jul 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYoMg1FQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z0Vy6NZv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F142DC33B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179009; cv=fail; b=FenrXyYLIzLPDfZOze9bvVOEw+nVeuWv3K6zjN/fO9F9/cDDadsL1NgHW+3whol5RbasX70Y30bRJubQ2P1ikff+g+lxCY417xxidvvttuqoMemkClx533lDcYEByxQ9lAcvKksKLWBVhBC9sLxPZBVddsiWoyApQapjYIfxYtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179009; c=relaxed/simple;
	bh=qvG8WTugyFUWTpGEH/6X61QSwDLPvK3alEOQWY96noM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVf4fKe6vVW54BH5NvU0AyfwLesh2V5t0QEZnuEUF/e4SMdzsP250hqp+B0rzXSdAagHWS4O8/bEwsns1D2O8f9ellJy5G56i2qD/otKRACTEWaxQ+XRVc5Jc7vWt+drnWS3O089DMJaFDvH/NtpFLc6gqQ2fTwXXHEH7smVsas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OYoMg1FQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z0Vy6NZv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCxT029312;
	Tue, 22 Jul 2025 10:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UWG86VXDYh6TvsqbIlIljdp4YUvxISIu9o0budyw8I8=; b=
	OYoMg1FQL8VG2xJvnl5heAxf49h57iBVoFthNWTHsjO7hNxmMXLYrKdWt3ZdY6dk
	dxY9ZGdyp7XWUyBsT82M2hWs+bstrNiKP3d9hBbuo1pb4eieoXDUgBP6ZurVK4G1
	/9pKh6Q8KFlApUYt+KINAPH9btJG4aYoSQErb0osAgz7XgTQV23f760s1H3wzqwx
	3t+StNC+LJokJl/nZIPdGTWPyQjd/nnbK6ocd3Hi/x27s33WtTveAGtjbYBKYrIh
	YQHEtunz+H+/HtbgQtJERikPLOyTyyBUHg8DWtC6Mdo44+h0aB50B1uBWFzPYK3y
	g3vR+NFu179j9l/pNTSJng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpn0gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:09:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8YRQ2005975;
	Tue, 22 Jul 2025 10:09:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t94rum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5Np5jN8jooMrfOh6fN03p4LypzrziUT0gUBY+y+afTt0jfrLCacUuIqpwkLxsY2qKir2BABOnx298kXJBF2/R/aVGl3azuBL3ZgoEfZwseVABOWmdXL6g5Oz7IAQTdpvLnCVxIO2J0IgewD5XgA/xIYnOM6qKhfUPgl714gjRxWh2wxjvCtuIWnCqhDU1UvMqih4CfGizqWiUuwQaEaflxpJ6tl1xArsMPvmOAYunN/3Rkhtof+S+IqUxiPkps/NrLrTEm58ZQwj7wrKZrKAw6QyT8kt/gH+wAXNPU9yO79wXcers4By4VuSH4SIyoyuRFNpj8zt2nc6vfi6+l6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWG86VXDYh6TvsqbIlIljdp4YUvxISIu9o0budyw8I8=;
 b=fjLbyp4H9WoVOPKUb/x1JMtuktd2WlC2B6Vi7iR+PZyGi+9x+8vrD+dBwGdqPrzykMZ1czeyJfJXQ5EyTPtqF4S0pgmFAlxui0WzhzP83eWE/X4u2jlAynH1KsqR87EhM9uZPHOD5TAXzx46e8sFurPizckkL6NxlNy5oswRqrzHWfb8jGwHuTBvRGCiQB4PHSKrduK9fkyke2Olfnp7OB6ef82ZnG2y3YyhqZ3PbnNyp4WInuROygJrXleJNyfU3kC7oUCVYgQcPBXWbra7izzbSLaMnIspMRhUPNLzSILZfPFXEmabjkpjiSvEct8/sLJu2af/rlJcTPW400K0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWG86VXDYh6TvsqbIlIljdp4YUvxISIu9o0budyw8I8=;
 b=Z0Vy6NZvtdF8pfp0doqmXFQTHWJb17DVyQ7D2LA18VPNRpF+UChGy1Gs9Z65KnkuBrwrSbQL4Ehrno6ZK2d+aEcXmbNCV8of3ezknS9pgbc3vXLqK6PHT1GYrWX4wsz9qKrepFI2JkXq/1DF3Y/a+2MobtCBZFr4amXh1HBWo3A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:09:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:09:10 +0000
Date: Tue, 22 Jul 2025 11:09:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <694a8b10-6082-44ac-8239-2c28b4ba8640@lucifer.local>
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
 <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
 <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de1bb44-d747-4667-8628-08ddc907cd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFUzYWR1T0dzSnEybnR5TTdQS3BTdE9SMk1FaE1HOVpybFRoNU53ZnFnQVZx?=
 =?utf-8?B?K0JJUWRRNEpDSkt5UHVGV3dmVzFpelJBWnU4UTk1d0gyVmtmOTArZkx6Z0JI?=
 =?utf-8?B?cTlJdTJPUHZPR1hmQkkva2hRWkJkaUtOR0tpVUlFZGNDeWt6Q25LWTBaaGhk?=
 =?utf-8?B?ZitpTktwdU9YT0lFaWcxbnZrNVZGMHRhd2crQVJOaWFhL3Z6NlhIbTZldHVO?=
 =?utf-8?B?MGxHZDgxVXpaby8wWnRtc3czUEg2d0VhVG1oTkt3VG9zbUZZeWxtbDNLbEtq?=
 =?utf-8?B?UDkyZW9GdXM4a3ZHQkMzTkhUdEt2eE1tVkYzeGNJOXdLWEtxT0VsRENVWlBz?=
 =?utf-8?B?QVNyTlFkY2puVnI5dndlN3ZPM1I3c2cxeUJYR2pjT0xKNjFmZGdCMmJqUS8w?=
 =?utf-8?B?Q3pEMzRlU294KzhYN3ZrUUFCaVozN1J0MEUwMXU1Tlp2Y3N5aTY3ZndzQXor?=
 =?utf-8?B?Z0tnOVNBV0JFOFJEY3R3eDhuQ3ZxN3pTSC8rYmw3M09TQ2RWNkVFUXZKRWU1?=
 =?utf-8?B?NmNhUjEwUVpBVEFZWlQzQmxXQlBVbDZVOW9QRmR3cVpaSFZEUHljcnJUSnRM?=
 =?utf-8?B?TlJIR2pIQnVaUTNQbWxFSEZQSlk1YTJFZDUyWWJGL0h3ZHBOODZLQmdETDRu?=
 =?utf-8?B?NHlKQVIyY2FpMlVwVllSSER5RmFtZll2NHVvYlFLbGpxeVhoTmN2Sjd5MEJy?=
 =?utf-8?B?YXA3QjBLKzZOV0hLM2g0c2llemVNb09WRG03ZGJGOGhZcHNaV0wxS3dPREF2?=
 =?utf-8?B?cHQ5V1FpOHo3QTcxRFd5MWxNN0pWdHV2N1dSclJIYnRvUm1LK0FPNHpkYmYx?=
 =?utf-8?B?TDJFS1UxZ05WWGFZK1I0WC9hcG45ZjIvbmZ0eVdZdUJOakJoRUpYdVJZWmM3?=
 =?utf-8?B?ajBQckRTK21QM295UHNMTFhtYklEOTVrZjR0MGMvUW1kSWt6ajRSdlhONU9o?=
 =?utf-8?B?V1lBaEhzRmNPZzhvVFFGRUpzM3V2a3h5S05KVFlRWGphbzRReUdsSzNxVlMw?=
 =?utf-8?B?RFdMSEpwSVQvTi9OdjZGWU5DWURVaDdaNUpSbGFaNTBiMmNKZDBHMmpIaFpp?=
 =?utf-8?B?M1J5V0NsWTRoMDB3VUZCU3Q0NmtGQkRoT25xMzdrbFRhbnV2OHZ2MFpFb3pO?=
 =?utf-8?B?V1podEJnUSttbjlLdkRUZHg3eExoV2dYWDdEay9TMUNNWDZuclUwajk3MzJa?=
 =?utf-8?B?Q1NNU1VvdVFIRnVsZitqazV2MW9iQWZzUFd4bTZhdUpWcndNNkkxRWhwMGJE?=
 =?utf-8?B?cUVsc3RlbUdKbElXNnpDQlFaZXZzSUxGZFp6cWVBUDZia1VKU1lnZGVzeFZn?=
 =?utf-8?B?d3Y0QlU0aU1JcE81bHpYK1c1eDNuQXNpREZUZ0V0bkdWQXZ5TnI1bDBqMi9P?=
 =?utf-8?B?ME1iaWFWVDRRTFV6M0Z2MFNZRUZMUm9waTVHaEZnRzd3SHlJaUcraFlEcG5h?=
 =?utf-8?B?bmxJQ3VQdUcwZDdQTGpjbUJkTmwyNWZ1S0JqekxXUk9oc0dVaFV1dm8wWmNX?=
 =?utf-8?B?aWx4K2FXcC9RSWVoTG1Idk4yYmRXYk0rbFdBOCt0WHdsS2hHM3pPRTZ4RGQ5?=
 =?utf-8?B?eGhjaThQdXZpdk5QMmVTZ256ZjY2Vms0blAzak1HcytoeUIxcnNPaFkvbVpM?=
 =?utf-8?B?R1gzaXZlZGR2L1AwbjBJMVZkc1VWTHM0dzFkQWF0NWY0R3FzbWNwbUpnbEN5?=
 =?utf-8?B?WVRhZjMrQ3BwVHo0TjRlbTFkRElTRHRwcHNheWl5THhmWUdnaE9ueVhMUHlG?=
 =?utf-8?B?U0YybWcxb2pNdGdoSm1DSExudkQxYUwrdVFTWjU0Q1FYYi84TUJjam10aUNh?=
 =?utf-8?Q?cD68xkgtxKJOMM5Vpub7jazYB+2LeRO9iP3gE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEhWajZzS0k3citxdTVrUy81VTRJUmc4QkRWd2pHU1NldFVHOVdKZDV1Z1Z1?=
 =?utf-8?B?bThrUVo0bC8wSWdvdnFtVzBHMzVBSytJQ3pZaXB1dDRCcURnYXFHWFlIeW9n?=
 =?utf-8?B?RHNIV3diZ1IrNi9TcWNoY0VMTHF3V3dLd2ZYUjJYU2kxNEFlMWpENjBuSmlu?=
 =?utf-8?B?Y096NkFVelN2amVBU2t2RmpoMllhTUFuck8wejRUSmVoOHh4eUt3eEtnckk3?=
 =?utf-8?B?clE2MGtaT0FvNjdyNm9yWDl6YmE5Si8wRlFDcUJxS2t5eGUvOU92Y2VkOXFJ?=
 =?utf-8?B?bUUxQU5OZytyTmY0Rm5EQmlDb1hQTklRV3A4bC9WOVlGL0JMZklRaXhhbGtN?=
 =?utf-8?B?VE9wclNlY3BYdytBa2hlN01pWU5kemdHQ29vYVE5b01yYzFqUGEzMXpXK29K?=
 =?utf-8?B?UG10NVVHbHBXeGU1em5jd2JLTXVmajNtS1FFUzZSc2FqMm1BQUJ5VjVJQ24y?=
 =?utf-8?B?aU8yMUcxY0JzYnV4UXZxREh0VWF3OEFhaDh1T0FtQXIrM2xia1FkS1JkL2dl?=
 =?utf-8?B?dTZSZVY5dVJmdm9QZ3NvQ0xqbXFXU2NpSmtQZG9EdERMc3RHTVpNWXV0NEF5?=
 =?utf-8?B?WXBEYm5la1pnb2NHWHZRaG1iS0E2TU9uMnMxblVBRXlrWTRFb0V2WHgvcWFj?=
 =?utf-8?B?NllBbzFmbmpyTDhja0hkUS9RbWc3dCtGUGlBVlpYa2FOSVg4bzZGS1BlZnN2?=
 =?utf-8?B?TWJBMjRuRkxBcnJxYWpvSW9pTjZYMDdxKzZwUmN5VmNacjBuYk5KSThJSkxy?=
 =?utf-8?B?ZHB4NWpQdEpGaVF1bGFMclVrdlg5bG9kS0RSbG9xYlR2T1MrTFlRQ2wwNlN2?=
 =?utf-8?B?bDl6SUl5cGZvZDlZMDVwWkZUY094WDY2U1NJVUswUzdnblFLT0RhUURCc0Jz?=
 =?utf-8?B?QUsxUjhJOFRoWUlPaU9ici9tZWU5NE9YMXZKZSs4bEVBb3V2RnorRzZQOTRh?=
 =?utf-8?B?eTJMa0ZTdkg3bDUzWjIyd2djTnJrL3BYYmJ6R1hSUW42eHZHRFdIOFBvYTFu?=
 =?utf-8?B?ZURUUTNKRlFEczZ5S3N3dkZUYXZIOW83c0dQOXBnK2pHQ3hzMzlyK1JFTDFS?=
 =?utf-8?B?UGRuU2hDZUxLQWkraWhlRE9XRVRIRFM2MmRjVzhXd0ZvWEdISnBkTi9HY1Uz?=
 =?utf-8?B?SjBkZHR1K2V1bkl0ZE0xN3hnRWdGN1BTenB2a2FLSkJhQVJ5cUJrNDdiZTVU?=
 =?utf-8?B?dmVLNXcrNWlEMkhoKysya21Zd3Q4elM3eXdZVnU3eThWTG1vOHdjSXFKL0dr?=
 =?utf-8?B?enRMS0dTUnNJWUdocTJIcTdMK3NmU0ptQXdNMXc4RG5Wbm9HN3B5TDBXRFV5?=
 =?utf-8?B?RHZzOXJMVHNqbC9mN2pWamlqVDA2YTFaWS9BaE9zMTZSV3R6ektlL2cvN2FO?=
 =?utf-8?B?ZjJOalg3QmpzdTd4bURKUHdsYUV2WjhSa2dFSWMrOE1nQWhkcUE0VXYyemcr?=
 =?utf-8?B?ZktNQnVjT3F3RU04MkRIa013ZmRyak9aS2prNHhjdGVHOThjYkhOcE1zSmlp?=
 =?utf-8?B?V2M2RERwOXFaQnVFQjRSUzFJWWhSQUJ6YzlaTmZnS3ZCMS9QOS9oK1Jsb29t?=
 =?utf-8?B?OFh5U1oxekUxUjEyT0FybmlaOGF5ZnBjMkt0S3F4bytmekpiMWdFVXY3cHlE?=
 =?utf-8?B?OERGelA1N28vSHlnR0xmWW1CWldMeDRYY0tORFVRaGNGekFERkorazdlUWZR?=
 =?utf-8?B?ZElmbnJ4NWt0cGtPWFdPNEQxS0ZuRHlFR3ZBUWx4QkxXUVBobFNidFlvVzVy?=
 =?utf-8?B?bjNYbVJ2L1pBSXFpY2lyMUlXQ05WMkZwZWs4VU0zS0hCNmdVUHJaSXA3aTFp?=
 =?utf-8?B?eGE2eHprWkR1STlXVGU0cWdFVlN0alBoL09MMXdCVjdyN2FEcm00emFSVU0y?=
 =?utf-8?B?N3lXeTdzSDh2TWNWWmR5aDY2bmhMcFlnT2tRRHc2aHJaNkVGZi9ueWZLQ05y?=
 =?utf-8?B?TWZEeXJINFliQjRoQjZuYm0yK09KeHVSakpiWnpVV2V4a0tSVEd0VGZSM1R1?=
 =?utf-8?B?MGhsWXhXdWprTzRDVDZmcHorcnhET3RLNE1jWk1aa09jTzJaWkV4eHlIL3lF?=
 =?utf-8?B?NmdndDcxTUsvMUZteW1kc256U2h5TzRpZG9Cd29Halpkay9qL1BDZFcwWE9V?=
 =?utf-8?B?bDlhc3JVdUxRS25NVzdKSVVEeFIrKzkyaUk2Wk1UTlJaTkxsM01BcEpFZXEw?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o/qGnOdFHjeK8q82VS1t+Mhplzf91eXUlUuJQ8MFtTsZ/ic7mwVElnqi2uNIuerH5K0kufYIk13j4wDizDCJYORadP6GLGn0moc9UiOV+dmw6xNDtyIgJ1SRokLYkqNb3h0ZCyxQ+UwkFDojMW7GcM0icBb0i2FU9Bq//b4G74t5vFXJK4E9CgDpXXiMllBkUHtLjPNNqNpX4bSm5XIE/zbLlIfnYJyqst9leXCQCKdnrTsYl1aTntTbQK32+zx27o0KPY3fPahsAI5KUTSDO2k4WF+Od8e6rMQCBPmRkz0muxa2SpChPP3XQKIuUUamSp1iv+MA3fRjZWh12QMQ0G4j4tZBOATliR45iczGiLs5lNLfKd/jWHk2F553LT8K1DNEibclU8HMC9f8UxrL8ZIkkIW+JXMj5tpOF95sEWYtcPDDaqLfiVoJheE4wdO6BQYEt3G+UZYPwVDATnKISsNPsRk70UxzYBHp3d4ABGt5LVwaMWVx0P06P/irk0zg4gOZpMHj8AU1NjoTpbNH1MxFPkgpPWtp6Yvg3fONJqIP1alWZLHxkdrUIGM/DHA9yz+AGYOXINE+9DMI2PK4xdnuJK1XzrvmNkx17j0nnKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de1bb44-d747-4667-8628-08ddc907cd92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:09:10.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXb+N8kk/Y3rbQ+a6feNwPNPDMDGCv4xIoHhKN2Uwo3xX3Huyquczlpw/rOxGMHHdt65mAhCdO2+jgd1SVefeElR/fZRxo8aHow0geSrEPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220084
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=687f6350 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=lTF3TKN5rYYCXv280msA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ur9huVPPI5QA:10
X-Proofpoint-GUID: TZAebDEIsIu3C_SSqp6-WcyKSsDXdwUQ
X-Proofpoint-ORIG-GUID: TZAebDEIsIu3C_SSqp6-WcyKSsDXdwUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4NCBTYWx0ZWRfX0PXaxU/k2yhD
 fagvDHz2M5NcAvTJ9fqySffbcVrq9jHNpyMVo84wNV2zzNcD5bi4FXDlfUotv4uoItJjYPN9SR8
 RVlG2Lz3DOBAeorLrZJOcmnMU8uHpTH6DxNvzWvtPQY+J36aWVJcVdq2f7MKQel7ByAaD1cMFzL
 A434Idq8LhBh0ceKIcY/4UWu2cIdfO9cjyuUV0CAkPpc0bssczEXF32w7ZDKZuqDdrSA1zGhPFn
 L9u9ypSXawmniFVc0Uq55C0qm0ZNkRL00NGxmlnIld3bsrKyQOonab+g18S5laQ1vQQBySXCknd
 FqJN/U5eN3QzwNfPQlAQnGWrgKCY24DCT/6myWUwfmxNlynN1/FkuVSstGQYA9fIHRGSRH1F4he
 VwaYBU7JlTCmYOs/2q7449ZyKwKqBhvac556FokqRTU37eaW0ogun+B5ushkSpEio60yIRYS

On Tue, Jul 22, 2025 at 09:28:02AM +0200, David Hildenbrand wrote:
> On 22.07.25 04:40, Yafang Shao wrote:
> > On Sun, Jul 20, 2025 at 11:56 PM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > > >
> > > > > We discussed this yesterday at a THP upstream meeting, and what we
> > > > > should look into is:
> > > > >
> > > > > (1) Having a callback like
> > > > >
> > > > > unsigned int (*get_suggested_order)(.., bool in_pagefault);
> > > >
> > > > This interface meets our needs precisely, enabling allocation orders
> > > > of either 0 or 9 as required by our workloads.

That's great to hear, and to be clear my views align with David on this - I
feel like having a _carefully chosen_ BPF interface could be valuable here,
especially in the short to medium term where it will allow us to more
rapidly iterate on an automated [m]THP mechanism.

I think one key question here is - do we want to retain a _permanent_ BPF
hook here?

In any cae, for the first experiments with this we absolutely _must_ be
able to express that this is going away, NO, not based on whether it's
widely used, it IS going away.

> > > >
> > > > >
> > > > > Where we can provide some information about the fault (vma
> > > > > size/flags/anon_name), and whether we are in the page fault (or in
> > > > > khugepaged).
> > > > >
> > > > > Maybe we want a bitmap of orders to try (fallback), not sure yet.
> > > > >
> > > > > (2) Having some way to tag these callbacks as "this is absolutely
> > > > > unstable for now and can be changed as we please.".
> > > >
> > > > BPF has already helped us complete this, so we don’t need to implement
> > > > this restriction.
> > > > Note that all BPF kfuncs (including struct_ops) are currently unstable
> > > > and may change in the future.
> > >   > > Alexei, could you confirm this understanding?
> > >
> > > Every MM person I talked to about this was like "as soon as it's
> > > actively used out there (e.g., a distro supports it), there is no way
> > > you can easily change these callbacks ever again - it will just silently
> > > become stable."
> > >
> > > That is actually the biggest concern from the MM side: being stuck with
> > > an interface that was promised to be "unstable" but suddenly it's
> > > not-so-unstable anymore, and we have to support something that is very
> > > likely to be changed in the future.
> > >
> > > Which guarantees do we have in the regard?
> > >
> > > How can we make it clear to anybody using this specific interface that
> > > "if you depend on this being stable, you should learn how to read and
> > > you are to blame, not the MM people" ?
> >
> > As explained in the kernel document [0]:
> >
> > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
> > of the strict stability restrictions associated with kernel <-> user
> > UAPIs. This means they can be thought of as similar to
> > EXPORT_SYMBOL_GPL, and can therefore be modified or removed by a
> > maintainer of the subsystem they’re defined in when it’s deemed
> > necessary.

I find this documentation super contradictory. I'm sorry but you can't
have:

"...can therefore be modified or removed by a maintainer of the subsystem
 they’re defined in when it’s deemed necessary."

And:

"kfuncs that are widely used or have been in the kernel for a long time
will be more difficult to justify being changed or removed by a
maintainer."

At the same time. Let alone:

"A kfunc will never have any hard stability guarantees. BPF APIs cannot and
will not ever hard-block a change in the kernel purely for stability
reasons"

Make your mind up!!

I mean the EXPORT_SYMBOL_GPL() example isn't accurate AT ALL - we can
_absolutely_ change or remove those _at will_ as we don't care about
external modules.

Really this seems to be saying, in not so many words, that this is
basically a kAPI and you can't change it.

So this strictly violates what we need here.


> >
> > [0] https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectations
> >
> > That said, users of BPF kfuncs should treat them as inherently
> > unstable and take responsibility for verifying their compatibility
> > when switching kernel versions. However, this does not imply that BPF
> > kfuncs can be modified arbitrarily.
> >
> > For widely adopted kfuncs that deliver substantial value, changes
> > should be made cautiously—preferably through backward-compatible
> > extensions to ensure continued functionality across new kernel
> > versions. Removal should only be considered in exceptional cases, such
> > as:
> > - Severe, unfixable issues within the kernel
> > - Maintenance burdens that block new features or critical improvements.
>
> And that is exactly what we are worried about.
>
> You don't know beforehand whether something will be "widely adopted".
>
> Even if there is the "A kfunc will never have any hard stability
> guarantees." in there.
>
> The concerning bit is:
>
> "kfuncs that are widely used or have been in the kernel for a long time will
> be more difficult to justify being changed or removed by a maintainer. "
>
> Just no. Not going to happen for the kfuncs we know upfront (like here) will
> stand in our way in the future at some point and *will* be changed one way
> or another.

Yes, and the EXPORT*() example is plain wrong in that document.

>
>
> So for these kfuncs I want a clear way of expressing "whatever the kfuncs
> doc says, this here is completely unstable even if widely used"

I wonder if we can use a CONFIG_xxx and put this behind that, which
specifically says 'WE WILL REMOVE THIS'
CONFIG_EXPERIMENTAL_DO_NOT_USE_THP_THINGY :P

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

