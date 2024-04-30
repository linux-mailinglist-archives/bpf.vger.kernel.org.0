Return-Path: <bpf+bounces-28232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538058B6CA7
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECF51F21626
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28725479F;
	Tue, 30 Apr 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4aBLSu1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdTq0Umh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FAF46551
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465218; cv=fail; b=Nnr8wlgB6VKPGsSTDo/f+YSad5JioTun3BdLYgAcX5GV6wQ/GU6VWByMcAWJrCI3rp0Xt4bZ+z2RxumHGsab2i30UD/ljHpiFZadPGjaPQD2U10l4kdYYhKhgKl/KQM9Ab27VywO/nbbQ67427Td4IiDBXEiBsE/tUXBdccXltI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465218; c=relaxed/simple;
	bh=AKxniPWBNTUmmHBgdelKnA9pSrg4Ig6/NrwjYytjt1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mqd0bqSUcLhHSOodVimjhSspawxmRM4KVlXpGbvDX6YnOT1i1XRNzigqQTrkHYSCj5gJxrCZa/2c+Tz9Cdu6PaKy2uG0u9NarMn5v8vjP5m+Ly4xHSUY/FijUKEL9lMZ4yBRUR6jl3xO+HGKPzMQ3x4/V/r5r4DtchRemJVz3yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4aBLSu1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdTq0Umh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1iLsx018295;
	Tue, 30 Apr 2024 08:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uuqwD/OerBNZ2lLCACb+7WNFgpV/fOOMhtN0iRsTINs=;
 b=T4aBLSu1cH/7pvKK12TeLumRKQZQ5rd3ItpTgwHuvdKofU6qMX9ELbn+UuL5BS3tPbZk
 3Hpftbv+DG/uGNdzXdeYNJHDkrVWMPtDb6u2S0oYI3B5yqBXykHXVvGU9WOLFITAUPl5
 8MXWBxCJAKuRIvX+1o7todArpA1LJQsk1bRvIPb+0RzxdI3pgTNYkKJ29JgNcHxqUHP3
 6PCzit8owYQPPNMkSyW/31nJmS/P+ZJVZb8FI5RUK8Dbgaup7h8B/oIA0RH2JdTtNx6r
 aWvP29e9W3LNHP6jdxeFJ18PtxwdNChqzBFWAIEsDGy3T5NyBsMhnLxnmXUwwF/LehEp zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cmfra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:20:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43U6NlcC008582;
	Tue, 30 Apr 2024 08:20:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7gneb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYCzstMCFYJ4gXLFCk5eooIip4L4ZlilFlWXamwyw4FYp0mX/3TbOMA+X7BHfQBqWKj5kIO/UH08Ipz9zfL78RzqcR/82PBJrHT4Znc4R5kbiOW0Y8B18hQK4Hml1y3oWB3B/b4ROLBXC5wq7eJKlAsvPqTV3nXNAf+zkcGHM2FN5CnNO6KK6hj++ifmHaZ8tLFPSS2wmlnNxlv5BIj/xWbGgt1rXe60NVXpDFI6LRiCrB0+TMkpKtWFtpFik5vDieSc8V8N7oDO1FcNjjqHZmWFotR2YcFS4q/5oo/OM7+bVzQmFHXISrJs8IleS+ZbVAxAVu2ThrBLBc/eoYZQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuqwD/OerBNZ2lLCACb+7WNFgpV/fOOMhtN0iRsTINs=;
 b=mKWGNNcyF7qnl2lPeqoIfoSdae7xXGH8ttuWstIm8qBWtrCiQE1l0/cLka9nD8TQsnB7bWA+CmaosV9ad1qweQgq/BuITWMOsjDsIMh7PRVOndP92T1YKst8dc54z+ki4paI1NSPsCk3KCfj6jvY5f/XHhiHtK9oFCB/5xo54cCj71lS4zv1EtG+tZqbuLZuuR4vl/Gfm5Z0p2sqrJe0okD5dkOJfBOqsUCfCBdJUzHejHhdVrPh9KA6U8Bhgaj7exSHL6IwTNarLX55pcT4tCjLn+B9Ih1tGZHknZH53jSZZSgOI3SJ9X0f+gdP/9Q2S6s+E0DcxAFSQODroOq8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuqwD/OerBNZ2lLCACb+7WNFgpV/fOOMhtN0iRsTINs=;
 b=fdTq0UmhZj43KAj6Z6xNak/J4bn41rNf60xa9c7PDHW5KuSK67/DdwW4XCM12Vt/kY4oHaqKxXNO3ZvUOWNfgGe0aB62tnZh991Qf3CDEtFmuyjjJbevRpQSnD1GG0QDQwszlW4Ic/1xqTgnPDcF/CMOKzlCnwkobppEytWqA6U=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:20:11 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:20:11 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in
 bpf_tracing.h
In-Reply-To: <CAEf4BzYOJRH7NMhy_kkMynWyz+mEh7ivkX05bq1bYv9aXLEg=w@mail.gmail.com>
	(Andrii Nakryiko's message of "Mon, 29 Apr 2024 09:12:12 -0700")
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
	<CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
	<87h6fo0zq7.fsf@oracle.com> <87zftdwbrr.fsf@oracle.com>
	<CAEf4BzYOJRH7NMhy_kkMynWyz+mEh7ivkX05bq1bYv9aXLEg=w@mail.gmail.com>
Date: Tue, 30 Apr 2024 10:20:07 +0200
Message-ID: <87jzkfuurs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA4P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::19) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfbf047-8b89-459a-8276-08dc68ee5aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NVZhdU9FNWo2NHkxNUJWaG9icFlGOTRhV3k0NXpiRStZWm5ocExKTW9pQWFq?=
 =?utf-8?B?dUpJclJYajBUdnFQNVZ0VFd0WU5KTlNnMzRrb1VDd1JCb2Z4SVF4N2YrSWFa?=
 =?utf-8?B?VGxRUFdxRUlSZFBiWUZMY0ROMDlhcE9EaSs2OGZhc0tOcHpMbE1iQWp4TExJ?=
 =?utf-8?B?a1dtMjN4MjlueDRTZ01QSlNyL25MQXNXTmxyMitrSmdEVmRJR3Q5djFyOUxx?=
 =?utf-8?B?cjBiZHQ1eUhIdUVHZ1lVQUpGMEc4T0YvbG4vOW5ZV2xyVzZySElPNzF2Syt3?=
 =?utf-8?B?KzcrekdaSjdGMXJZZXpLZ01QL1pHV1VEa2V2TFNHSm5ub0tqY3dqM3RUdlNv?=
 =?utf-8?B?eDhkTXJMT2I0VWU4SXlCaUtsVFdsek9aVEJOS0lrYTZEQk9iVjBxaDhwTDRs?=
 =?utf-8?B?MVFBS01kWG1qMEtQa3A0Q1U0MnZrMFJ4RkNYdkVHNmhLNTI4WEp3R08rY0Ni?=
 =?utf-8?B?Y2c4cU5aZHpUOVprR09YbXBYL1UzT2tFeXpLQ3RXUWFQWmpTTC9IaklhL2FP?=
 =?utf-8?B?MHdNUHdpNVBQd2RsZHlsdUtudnlxUDRScnNPT0tScVpOWkRDenRORDVPc1FB?=
 =?utf-8?B?Z1dNcTJhSGR4ZENsTGFlUlRmazhzNmhHankwa3l1WlhuT1dKK083TDdacm9H?=
 =?utf-8?B?dXgvSjh6Y0QraXkvNmEvbCtyUjgyQ3ZZci9rWE5IRzlucHhXUnVTME16OWV2?=
 =?utf-8?B?VmptMFR5Ryt5TktvYkJlS0NvWDIwSjRsNFBEWHhtZjBmY0JUeThsTkl2ay9y?=
 =?utf-8?B?R0ZTT1BjNU1yM2FiSWNmWS9BNHp2Zy9wc25KUUsrWTUxV3diclhIRlVFVC9a?=
 =?utf-8?B?Wjl4QWt1WVlOdlVUeGxiU3VZZUVGdUhzK2xnZk5iYUx1Y1IyU2FSb01wSWhQ?=
 =?utf-8?B?dEw1bEs2SythcWI0TzRSdmlPeXd1WFhtbUFxVkM5ZUhHWU5vRU1MaHVjdFJU?=
 =?utf-8?B?Rm12TzZoeEtkeTlIQ1J3Uk1scHg2VmVTUzhKVHFhUjVTQXBzTy9EcjhPSjZx?=
 =?utf-8?B?blRaSkNWK0tENEd6cU9EMkdCU2NKaXp5Z1pFVXkyUk4xZVBXY0g3S1ZLUTFh?=
 =?utf-8?B?c2N2dmQwNFRqTjNmMHlUUHFNSVdxTDZKZXRBcHRJalVHRkphdkpNV0xyRjBn?=
 =?utf-8?B?L2VxMXFzWEh1WHJ1QWE0Z21iV1lONExEVXZDWDI4c1ZGNk0wRTl5K0RTVDFE?=
 =?utf-8?B?NFNLWE1IVTRZTFVJdVZJR0ZXbDYvY1ZmV0hSS2JlQTNBV2NTazd1LzZ0aUI5?=
 =?utf-8?B?dDRRMjRlR2dZWktYMnNqcTZVY2VDSlROVGtwVGJQRHdRaVIxZFZva3hDVERK?=
 =?utf-8?B?aTVteTF3Y0Z3TXJzY2UxVEVTdHNQSlRsMTNRdUNkamp5RlJoejIxRkE1dGxQ?=
 =?utf-8?B?Z2lMMTJ2eXRuWnJySk1kZCsvQU5DVzVRQWNQK1VhaDdkSWM3TzZEczBKdTJP?=
 =?utf-8?B?MHBxVHBYMFhmdGRjTW1NTk10QTBiWlJwOG4yUUxLUWlwblZ5cTVkZFdhNUJW?=
 =?utf-8?B?d21BTC9VQ25lQmRvdkdjUi93NXg3dGw1QWNRR1JpMGk1WFhXNzArWk5VTnl5?=
 =?utf-8?B?MzFYOHhRaiswdmdLU0hTK2ZYVHB4c2tPWjF3eHI5ZHJTNDNHRkEvWkltVk1J?=
 =?utf-8?B?bW1Gc1hsVmxia0l1OEh6SnA5RkVHbVA0S3Nkcm5JRjFDWEtNM3hwTEhFdlRX?=
 =?utf-8?B?VHZ2STByejF1bHJrWVhIcEhqeTUrYncwVEJSV0NxQTh3S2Urc3dqWW93PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUtXWkNvREU4WFl5bWRYYmIzOE91cXR5SXlaaWQxSUdUdklNUGdwc25JMENG?=
 =?utf-8?B?Q2pWNzNWMjlsUjJPaFlTN0dJLy9lUVgrbzVUMkdmZTZaa2dJMFlGTHB3dGFT?=
 =?utf-8?B?cVJ0UEdZS1BrTWtQY01FaEUzdjA4NmVuTG9YWnU1cWQwVlc4UGhXVjZXZGRT?=
 =?utf-8?B?eVorR0MwUEhzc0czaFhkaXk3MGQ0S3hrMGc3dVhqazQyOUZGYXpXR1I4R0x5?=
 =?utf-8?B?TWtvRnZLL2VxZXV2c1lDWGVxWFUyc25QL3h6UGo2Tk96ZFh4ajhMWHlPaGgz?=
 =?utf-8?B?cUpVK0EyWEErYTl1VkpJTUowbDVqTmZFeHFUK2dpNUx2SFk4a2ptVC9ORTN1?=
 =?utf-8?B?TjZJUWgxc3V6aE80SmJxVTFTV04ybGpaNHpaSG01WVBnWmlZL0xoVmptWXRM?=
 =?utf-8?B?TXp2VkphRGRUY0lPVnFTRDMyWGJVbHhGdkVBNE10OVc1R3JGN0swM04vWHE2?=
 =?utf-8?B?cHorSDFhdmlVNngxdGE0SVE3U05hcmVwb2NwRTlYdjFuVmRMeVBzaEZZaWxM?=
 =?utf-8?B?eUtlVXRmclY1QkorY3RCaW1aTGdUNnJHWnpOSWNGZlNNYlJLQUVKWnlnR1Yz?=
 =?utf-8?B?QktYMkh6bkxJR2Y4bFlFQWxlQ3ZOa1FyRlJQZDlIdVRkL1psaHNXRk1hMUNx?=
 =?utf-8?B?NDF6cUNmc3MvRGVJVzYvMEZCZldWUSswbDhKdnBLczhtZXhyRG96R0JyQXRy?=
 =?utf-8?B?N1BiZlpHcE1OWUJ5bFdwM2dtdCtGam5DYWtIeE4yUitnSmV0cWZnalpHM1Jh?=
 =?utf-8?B?Q2NSTmNtT1Nvc1N0U3Zia3o4bndsSWxmVFE4OHRRV2ZnVktmc1pVWk8rVmFh?=
 =?utf-8?B?dkdaUjgrTkg2ZnlRRkY0c2s5aHEremg3R09sUU9RQW8yZHVsaWV1THdFRE50?=
 =?utf-8?B?S3I1T0xUMnJZckNzYmV3d2o4eHlHVXZodXR0MWluZXZxWHFuUE1OL3FBRkhs?=
 =?utf-8?B?SzNvK21qQk9qS09QRHlibGhsUkV1WEd3SUZNWGQ1VlpsbHV2N1ZOUmNOc1Vj?=
 =?utf-8?B?R1luZnQxblN4YmN3R0NxMEJHZTZVRmJDZzVmdGNhZVZOMnBEMU1xSC9kUXBT?=
 =?utf-8?B?OEtqODg2MlhNelhDdlFKOHV0MU1leDBJYmtaSzVYQ2VpNjQrQ0F2a2MrNzZu?=
 =?utf-8?B?SG1xVDN5ekE5WXNVN2xkUHNDYWlZQ3h6eWkzaVlZVklNQ29kRWRlZVRTOU9Q?=
 =?utf-8?B?bnYxbzhscFh1VU9yQlhsQTVhb1krUGpSNnJVclU3M2dsRklBSjJ4emFQU0Qy?=
 =?utf-8?B?VHFPTm8rb3BpQjRlai9hQllod3lZdzdUVWFETjEyakZYUlJhamt6RnIxaGE3?=
 =?utf-8?B?QVlsZTJJdHZyRlhaVEFOZnVjSnNuR0pUU0QraTMydFE3c2tFK1gxM1hUQnZs?=
 =?utf-8?B?Mjk3Wk5uQXFxdzhhUVFJNVQ3QmRhM3RXelFHQW80WHY1UllDOUptVGh0UTNs?=
 =?utf-8?B?V1lmaFpFNEx2em9Vb0JlQjhHTWhtV2x2NjNqMzJjSGlHTGdNYmI2SHhmdWYy?=
 =?utf-8?B?UFZLZysrVXhVUCs4cFF3QmY2eGw3UjFJakU1U2JpU2NoR2UvOGlhWDhXb1FN?=
 =?utf-8?B?ekVGUTJETEFXN05XSmV0cVVBRTBSajRSWFlqdVlrWmNxTnA1TG1ndVR0KzND?=
 =?utf-8?B?MnM5UGJnQ0lUZ0dYeXJsWVVuVmRUSTdsYmVEVDhqUE1VcUR0TUp3WG9lM1dV?=
 =?utf-8?B?TXUvNS9FeHgxb2g3VTc3OENQTnZNQzU3NVFFemY0T0JrMEw3MVBIRlY2THdE?=
 =?utf-8?B?aklER05RZVBqWlZIRmVVK1pLNzN2VHRDSDNTNnhNR0ZEenJTeWs3NVZPK2pp?=
 =?utf-8?B?T0t5UzB4NytMV0FoYTlHbzgrMmJSNTc3LzZxdVNRRWh2Vkc0OTJpSDRjeGFR?=
 =?utf-8?B?WVlFcEI0Z2FxYkE2SHBaSmJNTTBsbXZUV2xIeUJ3VlRIUUNkNXMwUXhWVGpx?=
 =?utf-8?B?QTRuNEVxczBkaEt0NWlSYitScFErRGovTFBPakFpQjA1WGJFNGUzS0pjandE?=
 =?utf-8?B?Mm1qU082aU9nWWxzTklqbTZKL1QwYi94Q2JVTm9RaitkTjRNcWNxTnBGdVFP?=
 =?utf-8?B?TVd1NlNuaEltZ1FOcTNXa0dCQWxxZ05SS0tGYjZSbDR3VXp1Zk8zc3FVQUlD?=
 =?utf-8?B?Z1pQb2FVZWVNMVB2WHpLeFZidmRBVUZDZTBhdkMzb3VsQVJYT2crVTJVSHlS?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fy/1uBCIrCHUj3dMtBNjbbNBQTsnZxNqs20TSPm7zuqVK2cDQq7HiY1Gp2fCS4plHyTFaC9IRGWCPPNaGiu9Us5A8VF0jIelDCjrtnD4kL9LF2gwOcVcGAbwqfptqX/pn6fotXdGLWsLm5N2lZBa+0KJoEYMV8pDPTbGtpexWvvS1eONaFFsGuzR8bHT4Gqplnn8RZZ7c9sRF87BH+wGzZyDA+7rS9vBFE6qtG56a3s7lRhoSerR82IZ5fCjy2l0ExCLzT6ik+vi2cg0NxAjQ/vLln55IfBS4uPVI+T2pbKzkZugwwnn766QCZ+ukQONrKjEfh5S9H8ej8Uks2fNNhRRHLYnvJkyt1hgRnyOdoBJiFFrE4ALrrnP7hPL2qpwqGhy855CNubgvWTCkU9Xh29fkDU4x9BfWjAjOVtkjS65owDUWLWdtV8nrBfpttglY2tRtsMqbC/9wRVN4zVw3qGJPiBWo42vnNUXcph5LujHiZ8r1b5wp67jvkVtkNEe9845engIST9H0hmwQidHOsybERKvcg/AyhONh/QXcPlcQstPhZW8bMkinNPajgBokcT5ycnXVHLVyR75jw+Z6ZNpHQXq+LKjA3STKrCufTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfbf047-8b89-459a-8276-08dc68ee5aa6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:20:11.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8V40ptMjRz2vcOPL2oG4r8T+Lm2F2IvnwQ2mHmNj/oBx+PNpVc1iIxaliA4S+KgY1TqwHzck6WcEcnS6X2vRJoJGkbwWo6YW04lmQgiaKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300060
X-Proofpoint-GUID: ZKXZVV771mxl0zYO8vSPqhAvt9uDi2J1
X-Proofpoint-ORIG-GUID: ZKXZVV771mxl0zYO8vSPqhAvt9uDi2J1


> On Sun, Apr 28, 2024 at 12:03=E2=80=AFPM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> >> Also please check CI failures ([0]).
>> >>
>> >>   [0] https://github.com/kernel-patches/bpf/actions/runs/8846180836/j=
ob/24291582343
>> >
>> > How weird.  This means something is going on in my local testing
>> > environment.
>>
>> Ok, I think I know what is going on: the CI failures had nothing to do
>> with the patch changes per-se, but with the fact the patch changes
>> bpf_tracing.h and a little problem in the build system.
>>
>> If I change tools/lib/bpf/bpf_tracing.h in bpf-next master, then
>> execute:
>>
>>  $ cd bpf-next/
>>  $ git clean -xf
>>  $ cd tools/testing/selftests/bpf/
>>  $ ./vmtest.sh -- ./test_progs
>>
>> in tools/testing/sefltests/bpf, I get this:
>>
>>   make[2]: *** No rule to make target '/home/jemarch/gnu/src/bpf-next/to=
ols/testing/selftests/bpf/tools/build/libbpflibbpfbpf_helper_defs.h', neede=
d by '/home/jemarch/gnu/src/bpf-next/tools/testing/selftests/bpf/tools/buil=
d/libbpf/include/bpf/libbpfbpf_helper_defs.h'.  Stop.
>>
>>
>> Same thing happens if I have a built tree and I do `make' in
>> tools/testing/selftests/bpf.
>>
>> In tools/lib/bpf/Makefile there is:
>>
>>   BPF_HELPER_DEFS       :=3D $(OUTPUT)bpf_helper_defs.h
>>
>> which assumes OUTPUT always has a trailing slash, which seems to be a
>> common expectation for OUTPUT among all the Makefiles.
>>
>> In tools/bpf/runqslower/Makefile we find:
>>
>>   BPFTOOL_OUTPUT :=3D $(OUTPUT)bpftool/
>>   DEFAULT_BPFTOOL :=3D $(BPFTOOL_OUTPUT)bootstrap/bpftool
>>   [...]
>>   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $=
(BPFOBJ_OUTPUT)
>>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=3D$(BPFOBJ=
_OUTPUT) \
>>                     DESTDIR=3D$(BPFOBJ_OUTPUT) prefix=3D $(abspath $@) i=
nstall_headers
>>
>> which is ok because BPFTOOL_OUTPUT is defined with a trailing slash.
>>
>> However in tools/testing/selftests/bpf/Makefile an explicit value for
>> BPFTOOL_OUTPUT is specified, that lacks a trailing slash:
>>
>>   $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTP=
UT)
>>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     =
       \
>>                     OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINU=
X_BTF)     \
>>                     BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/         =
         \
>>                     BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf                 =
         \
>>                     BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)     =
           \
>>                     EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'      =
         \
>>                     EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&                 =
         \
>>                     cp $(RUNQSLOWER_OUTPUT)runqslower $@
>>
>> This results in a malformed
>>
>>   BPF_HELPER_DEFS       :=3D $(OUTPUT)bpf_helper_defs.h
>>
>> in tools/lib/bpf/Makefile.
>>
>> The patch below fixes this, but there are other many possible fixes
>> (like changing tools/bpf/runqslower/Makefile in order to pass
>> OUTPUT=3D$(BPFOBJ_OUTPUT)/, or changing tools/lib/bpf/Makefile to use
>> $(OUTPUT)/bpf_helper_defs.h) and I don't know which one you would
>> prefer.
>>
>> Also, since the involved rules have not been changed recently, I am
>> wondering why this is being noted only now.  Is people using another
>> set-up/workflow that somehow doesn't trigger this?
>
> Let's fix runqslower submake rule, yes, but I think it's irrelevant
> here. Failures that CI caught were in samples/bpf
> (samples/bpf/tracex2.bpf.c), while this is runqslower rule.
>
> The reason you haven't caught it is because selftests/bpf/Makefile
> doesn't build samples/bpf, but our BPF CI does have an extra step to
> build samples/bpf.

Ok good to know.  Then we better start building it too as part of our
local testing.

Will look at what is going on there with this fix, and will also send a
separated patch for the Makefile.

Thanks.

>
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index ca8b73f7c774..665a5c1e9b8e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -274,7 +274,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL)=
 $(RUNQSLOWER_OUTPUT)
>>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     =
       \
>>                     OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINU=
X_BTF)     \
>>                     BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/         =
         \
>> -                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf                 =
         \
>> +                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf/                =
         \
>>                     BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)     =
           \
>>                     EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'      =
         \
>>                     EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&                 =
         \

