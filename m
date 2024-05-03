Return-Path: <bpf+bounces-28497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6D8BA815
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26A01C21839
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D91487E9;
	Fri,  3 May 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BdjnSJPV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CbyBW3Gl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F21474CF
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722668; cv=fail; b=C3I2IsSW/GsEq9/EDy+ru+RqfRn7Fy8cuvB9TXswJsp6imJ5lQU76qtqE5nFDzAvX1tDcKqH12NMcZhjF9aAP4iqNGPZNDIq13QF4U9XwFCEgH1b1CNp9jjxJjnT12B7IGz0w4sThI67VW6bEnmtHhpo+DzPWlYPWRAZBYF9r3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722668; c=relaxed/simple;
	bh=7tzZb2z10tSYHiUpafrX1Y2rPqeOoAuy0uAacIwqUOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dMA0RkUIsF34OGT10oTsLkleUNQIydK9sr4XRbzTq3vhc6eP+9sdxPj8faLq46+DRmwQqkgPrLt2BlqWili1AVkoPcm7Lf+uFw8CM2eJmSHIRsGViKZ+T5igeO0A30fjHc6oMNIG/53xlZOzfB1LeYzehPVaqwnZfhQfhHieMJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BdjnSJPV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CbyBW3Gl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436i08Q004354;
	Fri, 3 May 2024 07:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3C2kIVxu2wpMa0zR89e602rhKq/Z86DPblA8sb1F/Fc=;
 b=BdjnSJPVxXtJI9iMFxIMqPOhiW+ZuSE2jdrxfNUcaDQv07Le55MMQyX78EKoBVSL0BDD
 xiFI2Kp5gJG8V8yvGowdV7OCcETlZyqIRe4HDuICtLMmo8kTL4mySMLiyZDhx0LOtqXO
 /v+cgc3W1jjUp7r8+rVain/q0IRnr8n80Ta5cmwmT5A+2i3r2c6BV4CxO9HNZf/NLI7u
 JQtK4gzaTjCZkbPnUlZI/4z8bmFWFfgt6bs7a/Vtec6kx3pK1LX3GaRAgBEhd3wzVPLs
 u6pYnLrA70fKsqVP/UPF2xW6TS6HOP3wKjzKsSpneTqMMSS7dGUuKjYrkoBto68hsruw Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf79b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 07:51:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4436MJp1006276;
	Fri, 3 May 2024 07:51:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc00a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 07:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSPv+kcOzE1qaZbsgDfC/IEejDGudOdXuEOH9XVhKNaUfZ4mw7CK9HNoaZuep1RRdNttKmLvWZK0pnh9dFrJRoVO3EN9wyygMIQxp0LJIra4elOJ/4sEr5DIFzhxcnXsnqLX0mlT8bS87+ATmiXZDIOBS5MvSAcyNIlVKDixGme31aw5K3X4Y7m7fZDwIAzrrDBHCf6LICJm6neUc2PO3udG5Hoh0us53hnNAOAxTkSRkQpjAdsJM5enxkaMAvJXjsi3k3iFEPDlFYtv1lhF3KixW2T5mGRZKPA0WUKWenYmv30oN/++D+GY39sIx0z+U2YRAaJ4V+jALsxu3lRHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C2kIVxu2wpMa0zR89e602rhKq/Z86DPblA8sb1F/Fc=;
 b=TsOEUz/u+SgJ73rj/CXgaQoyRxrMbzoi+8acESYQsSbIPJAVw6tihJTzldp5IZbWNYem5TLnsKHPeguHp7fMnNwIEJfWdze7pZ4Ky2j2JsVXXdujyO5S4589Ae4w9rOzGV6Wl9xfadzKi9c0FAS2h2EBDHMlffzWdXVORCgxiJjs9HwAL2iIcpfWbFMeUfWEOIic8NACSSGF+mDUDEq14abn+B75h6NHVu96idV4YQgpw1MhMbU8jejVjHva75Td4wTPFdEaXltjiJwuJM/yuYzmaluxflWRZbQuf5wuraZpQZW/Ab3gp7gjOdClmk8F2KLDI6N459Apg6Z32rc4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C2kIVxu2wpMa0zR89e602rhKq/Z86DPblA8sb1F/Fc=;
 b=CbyBW3GlaAMTA9BC5b1Z7KxDh15LbgD8oPVKyNcSYqs/5SuDB5sFsjFWePYvH+GhaDGzXdRFV0Z1TPTmCsJfynMHqnEFPCjRyw7VdClUKevPyRnnFnr3I2XXdlhj0ceGJCgp1Vd1WyqX8Kq42NpTXpYfFwKkMRpgkJ5DwP/Ffbg=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 07:50:58 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 07:50:58 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
In-Reply-To: <CAEf4Bzb-bbEZ5Q6vSX+tiMu4iME2uVjN1T3d3vPZXMe5ngAfxQ@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 2 May 2024 22:52:24 -0700")
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
	<CAEf4Bzb-bbEZ5Q6vSX+tiMu4iME2uVjN1T3d3vPZXMe5ngAfxQ@mail.gmail.com>
Date: Fri, 03 May 2024 09:50:53 +0200
Message-ID: <87bk5npc4i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA3P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CO1PR10MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c194d0-0aca-4c77-f55a-08dc6b45c4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YzUyVlhvY0hWZmlia0N5TXZIMDBHNVlwQWVRUGpqQ1FEZGkrODBmZFU2aEN4?=
 =?utf-8?B?eFd2OFdkSDNhRmF1VDlwSG1TOTF0MjJIZXlLVi9La1NwZVVXSkNqa1F1bEFH?=
 =?utf-8?B?Y0lvVGhyWlRmSi9wUE40Rmg5b09sSjIrc25VaDhBamhNaHZHWE9MRHpoMWlS?=
 =?utf-8?B?L1NoRlgrMC9HLy9aRTdYSVlxcHBLSk1BS1N2RHpRdVc2R0QxTW9lM3VHUHdu?=
 =?utf-8?B?enByQTRyeDlORnBic01WUWw5ZGZyaHo4R3hIRjEzU3ZjalovNmtrc2poRHZi?=
 =?utf-8?B?Rko2bWFEeVdjWEdHcjVPMkJoaFBLRE1ORkdWYURCNXJ1MC92d2ovYjZxSE8r?=
 =?utf-8?B?amMzb1k5RWdRTGdEUklKanIxa2Y5bEZsanV5cE5FZFBXZGltYlJoNm9NZEtJ?=
 =?utf-8?B?NGhnKzFwY3BYV0JpM3cyRXY3ZklTYmpQZ2FtUzlvcHZSYnh1WktmK0laTml4?=
 =?utf-8?B?aXlQWEdBbXJUZTB2ZzI5aVdtOVcwcUFUV0ZsRWo5VkFUQTk0NWpkR2p2QjlT?=
 =?utf-8?B?ZXRXZXVVQS84dStDMjhDanR1cDFpVVdiS3hHU2UyTnNqa0ZpaGEyNFQxRXYx?=
 =?utf-8?B?c1JvWUt3Qm5LN3ZTem5lQ0pSbzVUZ0NISjJWN2hlNTl5clZ4TEtIQWtlV1p5?=
 =?utf-8?B?Z2FMYnhxVlZHQjJmOTlUTW9oVWt5WlRiRklsbG0zRGlNcFRQblJZQnJ6Z1pI?=
 =?utf-8?B?cHA1QTZoTmJDUGhRdXVHbDF1c21pMmM4VHVTdVdVY1VNTWxKcGFSZDlNUU96?=
 =?utf-8?B?aE96TVBtdXBNd1MvOXhvTU9NbUNoc2lUcjh2TXRKaVFnS1p0ZFZzV2hBY0d0?=
 =?utf-8?B?MTgvWWJRVDlEL1AveW52OVVzd3Z0RnM1Q3BXMU50YVNMYWUxaVZCSTliVVhP?=
 =?utf-8?B?QnB1b2F1bDFNYnFvcXR2MHhRWENnanErTk5YVWpQVGxPQzl4c1VFN2tQWlo5?=
 =?utf-8?B?NnNRU0g0aUdZd0JraU0xK1F5Y3VCaS94QlNLSWpyZzhFdXlsSGlmcFlkcnlD?=
 =?utf-8?B?K3NUa21rTjZKL2tWVlFsbjNadUpaSFVDaHBKSXhTZTBBSFRjcXovcFdZQUF1?=
 =?utf-8?B?YlNoZ0RiallXODh6Um4zbzk4eXUwcllLWkprbXR2M1dPdzdOWlYwakJMRVBv?=
 =?utf-8?B?Vit0WTZSdHNLekZNYWR4YzdDdjBqOC94N3dYbWdXaEpYUW5xaSsxOHp0M0dK?=
 =?utf-8?B?ZTQ3RnpxV1dTekp0dWw4WU1kMkxyNk9HQTF2S0NBeHlmVzltbTRCVW40MUpv?=
 =?utf-8?B?OFA4V0JLUDBmOG1CNFQ3M0tVempyMFNyNUFkYmR2bkc5bUN3U0xnZzZ4T2tK?=
 =?utf-8?B?MG42bTZEaytnQkdGUVcxbDdOV2hzeC9LQWcxNmxjbllNbTRXcVVYSXhRMmk0?=
 =?utf-8?B?dW1qQ1ppdHRSZTIxaTFBMHJadnp0OU1FK3c3UXdZejJqaVR5SnFvRktTeE9v?=
 =?utf-8?B?eG82REZvMmFxb1NmaCtpZnVWT0VscTBHbi80WUNIZVpUMTdLdnFzRS9VeWxZ?=
 =?utf-8?B?OVJ6b2FzaHU4dlVIaU5QbzRtSXBtbXNTdVl0NXF1bWdPNHptVnRzRTRHK2oz?=
 =?utf-8?B?NWlNT3pDS2YraEIyN1VVQmZwNHZoM0k1ZHZwMFlNYWp5WlVKUzFLY0NLVmVh?=
 =?utf-8?B?N08vbGN1MnMvZ0xhd3VZNjZxRmg5YTUyYUtIaFlWdm9CT0tnWDg3NjdjSkxq?=
 =?utf-8?B?akkwdC9ncWRYbHpLZm51WWZhcmFFbU1acnNoakMxYnVYYmpsM3FRTFBRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFBaRTlwdVVaSDVKUzZSdERmUVB2WGd2UlFCeHd4QkNEWTJSNC9kMTVOVEo4?=
 =?utf-8?B?cXU3dEt3aFcvaTFKKzI0N0VBZkN1dTJSQ0pycnc1dUlhYjJqa1BJMWlaVnZv?=
 =?utf-8?B?MCtwODhNUmZmOHpFclRhTm00bkJIR1BiV1V0U3NsUFdkazU5L1QrOHBPRVI3?=
 =?utf-8?B?NHN3djk1OUFGSHZGd0RyMkNRVldOcEhqeVc3TmtsdE5pU1NSbjZDellMT1lN?=
 =?utf-8?B?ZGhhSHFzNmszQVdKaXkvaXVucUZyT1NSVEpZcWdKQ3loaVdWNXZIaTlpbVhp?=
 =?utf-8?B?ZVpibU0xdm5wUEhQeDZlSU5hN2xhbFhHc2p2bU5xUFFZNWpSUXFCdEkrRDZ3?=
 =?utf-8?B?QTVPMXFyVkpLanY0cmc1V3hYdko3R2k4aThVYndlbldUVzhhb3FrVVlYaWFG?=
 =?utf-8?B?emtNZTFvcG9RVmJ1OFM2RTN0N01vU3dvUHhCaXo0RzJxWGM2eUNuYUxMOGt5?=
 =?utf-8?B?NCtUMUxDTkVaSGJXajRoSlRtQ3Z5dEVISkNRSzRucS9qZzBvU1R3OEY2UWlj?=
 =?utf-8?B?d0tTZVlLU3gwSDFTQjhsUHVMMUxvN0E5eVhTN1pKZmQxV1FCc1hqV3JyZ3Nk?=
 =?utf-8?B?S3I2NXdsT1FrUW9oTW9qdXZkeitQaC9xWGg0SVRTajNQaDM2S2pncWd5NURw?=
 =?utf-8?B?bTBPeld4cW5SU1VuYlNsUDBrb1dNTGpHV0xTMkNjdWFmY3c3Ukk1Njl6NFRX?=
 =?utf-8?B?UjhVZmFscU1hQVV0YVZGUGZVY2o4R2dVd1FrY281Nmd3MUVrcnBncER5UTdj?=
 =?utf-8?B?VFY3bEc5V3dJSzgvNjQyZHUrcnYzUWp1cThHUG5scnBrb0h0aEJKdFBiREti?=
 =?utf-8?B?NWdCbEtrRDcwS1lTK3NzUGR6bHJPSU9SQTJHMXZ4OHhkY2VycUtlbWE5aldz?=
 =?utf-8?B?NVZ3TitxeUQ1Mi9UNTQ3ak9JMUhneGwrUVZtdjdTUSs0ZkJMN1ZGZG9QTHFC?=
 =?utf-8?B?NXB0RFFBbmFDTFk3RU8zdS9qbmFUQ3grVXVwdGRVQ3RPTkI3UVVqNzhaMnJr?=
 =?utf-8?B?dHR3NlQrRmpHYzZ0MUtkTUNCU0wrK3JPTFRMd08xYUZKb1FaZ0JsaTJEckgz?=
 =?utf-8?B?UjFYVFFjNCtZeWZhVHRzTzdZd1drL3NudkV3TEg2MU85NW50VEkrNHFmNXV1?=
 =?utf-8?B?dzNTc3ZOUkMzeHh1N2k4VElWd2NmdFByaGUzS2kxRVNVeHl1MFNWRjJwY1dO?=
 =?utf-8?B?VmZCYVlzZm9aNVlPUk01VU1HRjQxQ1A0bTEvSkRzdnhtMG9Pa2ErVW5Ud0I5?=
 =?utf-8?B?eXcySzdZZjRmcGQ0N2dsdVcxcUdLOVp3bmRyMGdLcDkwK1pZY1VLempjNFo2?=
 =?utf-8?B?V3NySlE3N0V3QXdtNzdheWVFOWJkd1VjOUJiMXp3VDJoTEZrb3BrNVdPNmhK?=
 =?utf-8?B?cXJLT3p1Q0oyZkdycmVqV3VLREFxU3pRQllVa3Nib2JvWWN1T29nbDVvZEh0?=
 =?utf-8?B?SFJBZE1pb1N5djBtV0x3UnVRM01UeG5FOUFUU0VQczVxdlR2TXV6aHdyMFpW?=
 =?utf-8?B?a1IzMnorTkg4Ym1wNnRpN3I3bjBDbUhyWDczSU1Yb3lFQnBhWkN0ck9sTmdQ?=
 =?utf-8?B?QUZCUmtWcWdYY2k4NjlkN283YXFsaGRGQ0RvdkVONTQ1N2tuN3hEV3FiYUdQ?=
 =?utf-8?B?YWFucE9xNFhCNm1ZeWx2Q1NRVWVlT1BqbVdCMXdJbFJGV0NDOGhhangxUVVy?=
 =?utf-8?B?a0RWaHJSbUR3SUVpc1BYb2tuN3hRMzR4Yy9SdFRuOW9SWDZNV0pIeG02OE1k?=
 =?utf-8?B?Rk8zbXhJcGhmYVN5V0hZMTdhVzlBd0U1akF3aVhQdzdYYktiaVJsTnpTL2J2?=
 =?utf-8?B?eVFBOUlKK2lDOGVoaUdrTnRoUlZSTm10akhGa0hUcHc1bWlMUVRDYjQ2OU9J?=
 =?utf-8?B?SmpDcnc0V25VT2pkdjFyb1lvbUxwNmdnREVYdDlmbSszeTdvWndlMlBSRkc5?=
 =?utf-8?B?R3JNb2pITEpLZzJJOHY0RGVMSTQ4ZnM3S0hSdHpMRUVRNjR3eW01MllLbDFj?=
 =?utf-8?B?bldLOG5Bd1FCSFRXUCtFdGF3SEMrSGo4alF1eVhOR2Zmd1hoTjludU81ODRq?=
 =?utf-8?B?ZXJGb2krU3Y3TXVEMGUxWGw4SUpsemxmRnB3K0pNdGcyM3E2UW43TCtFQzMx?=
 =?utf-8?B?azJDWmc5SHNGTmZwZTQ1c3QxVWhIcXV2aFErRTFkSC9JUTRUR2VPZS9BMTVK?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1gX5nJLiyi6p+JMAq1XBTAGABiYvauzEpPSGdq6cV24FQavnlxsYEMsb866X381mXZjiJL8Gzd8b4JRjzQwo/EyESBC8NE0FpZwuXBEkJOX4WEFCxIyZIPFvlQzBjAkQdpk9xnseGH3TImE7BOc3QaJ6+BB5g2qdB/M6I/cn559S8WDku9kRQc+w4ch//V87Wi2c+c3nKBscA90C2bDRSxu4ZiDBGqd0eue8TC5Hjposghx2fR5iN3KcOOwlyevAZqk3YnpVIi5sKBPcqMq2M0B3r6QNuyTJopMaJt/TtS7jMS5s8yWbJCcRjZnqJC2Ocu62RB8RFV8c8mZhXqz6vS6VuzSEjCib+QFNv7AT/3L1AKOSSX6RqyiMqxzamaK1wuVJE8Crv7lkUP3JZmydG3fVv6jS753Gu5vK3vIbXBDvGatcWM90qQnuECbNeXSBfQKOhhpsijxc73u4KqbXn+g/KMT9/yhdyDeHxlDhI0Jh3K0R72ZAGUjHMJGXi4cpEy8QvvQ/kUVwfXFTRrTClh+IwOSxSo9YMSMHS39vpRNyN3TCOZHcXLq8TFsbRHMfkZv7EKCwGuUA4DOTUwpGFV4/cRvn6xrFUE/T52sivJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c194d0-0aca-4c77-f55a-08dc6b45c4c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:50:58.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLNg7o7m2Fjk9KKuyssa/0m4hAUD0CfTaLm61ExfDTJoZIt073QjdVdTmQlx1BqSPGDye7Eh9nyGe48boMxwmrSpmxIo9oJZ4CCba0uBxlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030055
X-Proofpoint-ORIG-GUID: h2EGNxhSKcbZe1CaKOcNr1cRN8ODTYJq
X-Proofpoint-GUID: h2EGNxhSKcbZe1CaKOcNr1cRN8ODTYJq


> On Sun, Apr 28, 2024 at 4:26=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> The macro bpf_ksym_exists is defined in bpf_helpers.h as:
>>
>>   #define bpf_ksym_exists(sym) ({                                       =
                        \
>>         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be ma=
rked as __weak");       \
>>         !!sym;                                                          =
                        \
>>   })
>>
>> The purpose of the macro is to determine whether a given symbol has
>> been defined, given the address of the object associated with the
>> symbol.  It also has a compile-time check to make sure the object
>> whose address is passed to the macro has been declared as weak, which
>> makes the check on `sym' meaningful.
>>
>> As it happens, the check for weak doesn't work in GCC in all cases,
>> because __builtin_constant_p not always folds at parse time when
>> optimizing.  This is because optimizations that happen later in the
>> compilation process, like inlining, may make a previously non-constant
>> expression a constant.  This results in errors like the following when
>> building the selftests with GCC:
>>
>>   bpf_helpers.h:190:24: error: expression in static assertion is not con=
stant
>>   190 |         _Static_assert(!__builtin_constant_p(!!sym), #sym " shou=
ld be marked as __weak");       \
>>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fortunately recent versions of GCC support a __builtin_has_attribute
>> that can be used to directly check for the __weak__ attribute.  This
>> patch changes bpf_helpers.h to use that builtin when building with a
>> recent enough GCC, and to omit the check if GCC is too old to support
>> the builtin.
>>
>> The macro used for GCC becomes:
>>
>>   #define bpf_ksym_exists(sym) ({                                       =
                                \
>>         _Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " =
should be marked as __weak");   \
>>         !!sym;                                                          =
                                \
>>   })
>>
>> Note that since bpf_ksym_exists is designed to get the address of the
>> object associated with symbol SYM, we pass *sym to
>> __builtin_has_attribute instead of sym.  When an expression is passed
>> to __builtin_has_attribute then it is the type of the passed
>> expression that is checked for the specified attribute.  The
>> expression itself is not evaluated.  This accommodates well with the
>> existing usages of the macro:
>>
>> - For function objects:
>>
>>   struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __w=
eak;
>>   [...]
>>   bpf_ksym_exists(bpf_task_acquire)
>>
>> - For variable objects:
>>
>>   extern const struct rq runqueues __ksym __weak; /* typed */
>>   [...]
>>   bpf_ksym_exists(&runqueues)
>>
>> Note also that BPF support was added in GCC 10 and support for
>> __builtin_has_attribute in GCC 9.
>>
>> Locally tested in bpf-next master branch.
>> No regressions.
>>
>> Signed-of-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>  tools/lib/bpf/bpf_helpers.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 62e1c0cc4a59..a720636a87d9 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -186,10 +186,19 @@ enum libbpf_tristate {
>>  #define __kptr __attribute__((btf_type_tag("kptr")))
>>  #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
>>
>> +#if defined (__clang__)
>>  #define bpf_ksym_exists(sym) ({                                        =
                                \
>>         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be ma=
rked as __weak");       \
>>         !!sym;                                                          =
                        \
>>  })
>> +#elif __GNUC__ > 8
>> +#define bpf_ksym_exists(sym) ({                                        =
                                \
>> +       _Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " =
should be marked as __weak");   \
>> +       !!sym;                                                          =
                                \
>> +})
>
> I wrapped _Static_assert() to keep it under 100 characters (and fix
> one unaligned '\' while at it). Also, the patch prefix should be
> "libbpf: " as this is purely a libbpf header. Applied to bpf-next,
> thanks.

Thank you.
Sorry for the wrong prefix and for the style fixes.

>
>> +#else
>> +#define bpf_ksym_exists(sym) !!sym
>> +#endif
>>
>>  #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
>>  #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
>> --
>> 2.30.2
>>
>>

