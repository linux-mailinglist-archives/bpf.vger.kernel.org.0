Return-Path: <bpf+bounces-22863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C186AEB2
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD311C24740
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8193BBCB;
	Wed, 28 Feb 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JYGcguE5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEp/ogbw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189A73522;
	Wed, 28 Feb 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121863; cv=fail; b=IR8T1q7oUs+u13lQGlNIR2GJH0doJgmEAgCOaQyAZZe/yMFJ+pVppPeW/5+9pdtB9B7gvp4tw5psQRZs26QRKSWRSEfYydWNrfGrHsQHBpNpvNklr+Qoqshx4EGNYPTiXajXKVxSOsDetZSUDkFz1Wg/qLI4KqaW3VZlZFdVdII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121863; c=relaxed/simple;
	bh=GGVP5Vr5gyTC24s6Dg+elwz40Jo1ZJ7QaTqTqKCvV+g=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=NjOS5F++wGlmftBr7UZ0YGZO+A5ri1PbwIvUfNzJNtAplxtgtMfaoakPKfHaW/0/RKB0A+dddhmtocHSmAGP70MEChmSPPPakd2+Zwvfn0gWZtAk6nwXd0rN2ysqj/XtmzxZ0vX+XkdWqSe8t871UBTk61LJq1Wa2K6SS3IiR+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JYGcguE5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kEp/ogbw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S6kDuO017477;
	Wed, 28 Feb 2024 12:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dBUOScpHBNHKMDQo8JIEGCQyhRpUiTDuLX85AocxRb4=;
 b=JYGcguE5oBCzOY0lJ/7JxKWZzqQyJpbjcDkkgIyVOm6TX3xiLhXXaxANQB4I+/2aoR9J
 mf8oPXRWq/M776sSaGsa8qo/6ev9SBbl1XQjxZuRW3Y87ujtkJWuuKRKAm/aZqTYBTFx
 aFlQn9z5TTch/s9+VfgmcRekE5AWgf2m0rgNVE7sAWX8uUfXtJxrXyoiD5FBOCYpNAtQ
 0uG8+70kqj2cDuM4iglrg55VL/7O7Y1vr5D2ZW7bzYxZrb138ZaVV3THpv8LnSwYyoQm
 0/l2oX0m9gt8AlNMh9ianA0+lMJQCvtKUO8QAXakFJFPdPlsjQ24U1zy1i/NAg1cEDrl lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccj48t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 12:04:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SAbP9V022519;
	Wed, 28 Feb 2024 12:04:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w932fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 12:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC68e2ZMuzXdGgaLThB3Bf2svTNldJNI848MTDLeXRV4a83gM7Uzj13SMMvN/hjiUYMmuPU1coWgJzgqHHjyvWHG+sVwbrKYlePkdFURx6UFd4C45L8EX6H1d2v24zrBDIL0tyQNm5MF42B2UWskTQb1k7I0AYF+tnsbgG6AUcOnFXcJQS2a1+ssqsppRZmqWMf3ilwlGJDrte20qL3fesD4yfqhjJM5LdBtnB8Jm85aTmfDO2+RCzaL4C+/F43rEoSsoLAptZxv2gM3WJv24FIIiFwRnqCX5h0vCUTT28wEECWPdqGf6scAsa1ODSLcDIZzkNQipuK1pN0u54I5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBUOScpHBNHKMDQo8JIEGCQyhRpUiTDuLX85AocxRb4=;
 b=RrCDCfBSDRkf7/wG/ZZ9qslo1Ydq5yi6mh/2lnHfVNhLMPEE0166en4m6t7DyPwniYn0tyBtllyKPvg6mWT/k9MJn6V4jMcQNhxzCie5vIEDULJActk6UEMAG9fpsaMYwXTtr8vu7+o9ab6CIGEsSNi9liHywn9dmTjVgR4y4JgKUVTP0xUYzNDPvEkBxnLmc71f7WFO/HsHPoxKDTMrBwbBFTQ4drAS1MGdNn125Bywc0jeTnLwZmmkC8XEsgLe75ODiHB8fu9RgWUIlDIFdlYMSn/RMKiOnteZ8X7FNehGgaWFrYnmE9+CwJc3HurL8zYROT0GTnVk9OxtxwNb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBUOScpHBNHKMDQo8JIEGCQyhRpUiTDuLX85AocxRb4=;
 b=kEp/ogbwJdGhCPl8gQDQlWtFvmRLyZta1w2z9ARO+aejhmKOxtJymxAKuRMlwYwXmN0d+OVlWPG5SIR0VeYLZtpXjo+ZQoCZx8/rM3fk/UpIP7eAjJ8MFNf60uRG71LC7DegJWSjA+UbRcV+6IVm4ZxPuD8E/1lzisZ5MgNIJ00=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 12:04:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 12:04:06 +0000
Content-Type: multipart/mixed; boundary="------------mBUH0t5AeeUFZ3pYCPFebgig"
Message-ID: <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
Date: Wed, 28 Feb 2024 12:04:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
To: Jiri Olsa <olsajiri@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org
References: <20240228032142.396719-1-jhubbard@nvidia.com>
 <Zd76zrhA4LAwA_WF@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zd76zrhA4LAwA_WF@krava>
X-ClientProxiedBy: LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b36eb2c-22c9-416f-9d8b-08dc38555cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VlRjzSRVQ6+bVvph8TpB3/jJiC0ARdi6aJK2X+Jzog5pky0hoAeTQ+Q7BKzZgPagG17ygHlNyzBF0JCmylxkGplMM7bfqnfVpOnSouiCPYRxPzVWoMpX5BmPG6u78dZ8g81BnDvK1Ny7HI1WiVjoYBYIaNTzDnP2sz4OOc+bJ4XiCkB/+D4VylpHLYr9qV11sBszfSuDW5NACfZc+hZALa5QvXl5LYCFBmhlAhbZ9LggeYJGEOP+WtfjZxiWw1aVR6DrVdIphPlpe4qCqrDGDcICOY0WAmockv2cLqglWiL9YDrRYXsgCTvo//2sSHoyBN7G9hrLoSgGAl5uJE8Eh28jgHVfoPLyE6jMWDZ8Jbn1Vs0qtSL5hImqu1jSHN7a26n0Cyrpb2AQlpm7xXa2brmSIZpaCgPLMbhuGAqJFC3Ga/EVHrJpXaPjX8jF0VcuG01AKQmcMeDRMCM0o9cvmf+tnmMzbK4M4WuJmw+vEA1xDj+eILPcVTAHa4MYUBhV28y1Q5LEHaotRwmbhcbCujsm/CdVh5de6pYUmUSL+EOWoO+0sJoqgUdgy0aWyVuEF4QcywN8NbGrKe01S55jPfYJFPLCCDccefVJeLW9B8OyKALr1ebZmOWS9ErbadqyMlEGgjxtIBrLhdFsjFHXmg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHc5a2JKUElpL3NPYnlvRjlCanJtWHVRUkw5cnZwNHRxTUVSSzhDRnF3L0lx?=
 =?utf-8?B?Sk9DT3RWS211OFMzL1lWRHJ3OVlXV1pJVHh3OVg3SE9PR1h0T0VHUW9qU2Zk?=
 =?utf-8?B?Zm8zdGdqZlE4ZWZWNUdtTDFMSXF3UDhLK3dKMVRlN05sb2s4Vm1aWE8vQy9Z?=
 =?utf-8?B?NzF4RzRLVThFTmZqNExjU0NGTFEwamk4bm1jV3pFdTUwL3RtMlA0MDNlU1Y0?=
 =?utf-8?B?bkNRQ1RwdkRXb0t0LzRWWUF6SElSQlNJWm1ldkpHTzNDZ0hDYStLQklPMnBT?=
 =?utf-8?B?MnVHR2prTmdKSGFUNTFQL2dpZXJ5bzBzRmFGenNWOHlGUS8wMGFWcVJvY2Jq?=
 =?utf-8?B?RE9jSENWV1liMWdvaUtzc1dnQ2dlcnhabllqeVY4Q1VHSmtLS1pwQXJmbVRI?=
 =?utf-8?B?VDJqSGVaR3dsaVB4alN4UEdMY0w0SVIyM2k1OHI2aW1xUWNESG9LYjhSVnNo?=
 =?utf-8?B?SnEvcnRQR0RpWlF4ZnJkNGxqQWRmREpHVXFjS0ZnRWJ4YTNTSyt5TGlKZktk?=
 =?utf-8?B?QWFTYWpSa2FLZVZqSU9JVkMwTUFXVmRKWTVteUgxdENaT3ptTlVwNmdkbXVj?=
 =?utf-8?B?RlpkT3c4VHU3VTNVbjU5SXZITUo1V1NMWGJDdWxjV21TMTZHcnJQQ2E5Rnc1?=
 =?utf-8?B?SFp1ODV2VVhkTUswcXREMXVTa3RiYWlsekFldEtqMXlrYnNwN0MrUEpyU0xL?=
 =?utf-8?B?a09MQTlSRTAyOHlsL3ZQWGZjcXF0OUZrNDl0a2pVSlFqSTVIOXJDeXFhYldR?=
 =?utf-8?B?MUgzY3Y1cng4MGFHbjQ0OXFnV1M2U2lHekoxb0ZOdkY1b2xwMmgvUHEvRjly?=
 =?utf-8?B?YzQ4ZmY5ZEJ0Vkd6YmxpL2UraGNkVGMycFRFRUc4KzJEVDRpOWpXaG5qZ1BW?=
 =?utf-8?B?V2VrVE9xQ2E2M1prUnB0Z2NsRE02K2JSWGdqU3hsakZqZmd6NFZCWTFwaDFh?=
 =?utf-8?B?aVdkVThYWjRucXdhSTYyMWgwQUFRYTZwTDNSRDN2WEs0dklBbHZMV0Vqem4x?=
 =?utf-8?B?S3FyMmdsZy9MMWJWb2NiT05Qck93NkxhYVg2dDZqeXcwck95bWZCajVENFFJ?=
 =?utf-8?B?dFB5MXJVSDRVZkZuMEFNS0l6NkdmZVE2SVYweWV5QVNDeTJLbnhkVlZmQVpL?=
 =?utf-8?B?aFhaTXNrYUJ2ZzRUQmJENUp0QkdkZnFBcnFMYWp3dkNkc1FjNnZBV0NQMG1m?=
 =?utf-8?B?OWl6YlNwSm1tbzR1dHVKVjdWRkRHdkRYUEdraGsxZndISWdrTjdYNGRoaHMv?=
 =?utf-8?B?WGEwcmV4T3k3YmZVbThzWHFwUU43ZFFJYjFSa05xbmVSc0ZlMW90alpGVzNB?=
 =?utf-8?B?TkF2VnpPY1pzdURnaTczM1p2SFE4SFlLK2F5M0QwdVN6eVlDb0RZZzZHVHBP?=
 =?utf-8?B?Umh5ZUpoQmc3dFlVOFhpMldoMWR6UzN2T0h6Y2NOVGp2ZnFIVmNTQTJmZnor?=
 =?utf-8?B?RHIwRk92WEtURzhrWmtPQ2JVUXRDNFlUR29pYzYxZ1dBdHFjN0pUVUhmU3I4?=
 =?utf-8?B?SjltcitxRnNQdTlGTGN5UmNOTnNBb0dvS216SUZpSmx5ZEFrM2hkREFJSWJZ?=
 =?utf-8?B?MDhBR1NISUdDRVVtYThaNWFWR2JHVmlRQjRPeFJpK1JjMWUyZE1SRDV0eDVZ?=
 =?utf-8?B?dThaMlpnbGNxeHNxVkhNdFlieXo5UUJRTnlsZGMveHBlaEtRQ25iVVBoWFMx?=
 =?utf-8?B?cGZIZU5RRGlDdUo5NFJkdGRYakZEamZQZU92YzdJUUpneGpVYzNwM2RKTEdI?=
 =?utf-8?B?SHBhYzFVd3RiSmVXdVBuNUpMSzMvaEFOU0RuellqQ2lyNHBZSW9mWDV5d2hX?=
 =?utf-8?B?K1FCejBrWFFjSzhaQVlRaG1BVmR4c1J3MzRCWDUzS2xyZUMxaEhBcUhWOUVp?=
 =?utf-8?B?M0NhY2YwMUZVVkV0a0pOTW1lQ3RSc2lGMk5qUTBiVVZlL3RETTVFbUhIQ0xT?=
 =?utf-8?B?bldNYTY5OTJzRGduVnpGbWpVTUl3OUthSHZYMnp6S3RIRjZKWmtZWFhVVVkr?=
 =?utf-8?B?cHRRak5FN3grWWZmdmIwUi8rS3RuQVJKMzVCdEppbVF3MU1URTY3cjA4a2VX?=
 =?utf-8?B?YkV6SWtNdDJQdVUxOFVkNTJzSnRrWU1uamRUYWhHRVdsSHd4ZXh6UjBkL3ZF?=
 =?utf-8?B?elNpaVNpc0x4TCtJWnVIeGVQOTgwbTV6NnFSYU9yczFvWk1hR25hemRyT2xS?=
 =?utf-8?Q?LnR0aonFLn+A25vKq+04ESk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LtAgqxqya8GsuI+vYHOsOekQN/Ei8A4CnzSGF56CfRXYZCvQjWLPLRf83GEx2ZwwQUYzwAbNNckuscqRccIYYlSymUblXAcn+R+1GloOOU1WO1n6DZHB2Wgn4IBq8+Sa44v8FtK7STMngsYnp+yms4chFjIWtarG5fFgaj8QWqEBzp14piGVvoWWQov5xsC/LRwdbFoxsd0Qp2vl8aL/RCwLwCmLhmGqW9f+05ajyZ8XUdxLRYOLGIWIv4fOzaBM7/PNK4dYJ4F73ZaNpywJOcOq9Lb/2JJB50atuHcjFF1weU7Ul/a0ATeMVSCp3FOYMcXfwhkwbFmeTgNPGP6ZW7vllScLP1Cjufz9Wqty5UCIJyQfjORQ/Famj3A+mUdQRuln65CdZlAswB+5gF+RD01h0wYWOKnPKqre9YWKeUUR0DKjQhigPtKKXX0ganWu/YEAzzpiYoZ5Wv1zo6gz/2PyGOfMeVwmCzVvAJQ0ItuyMLbYC47AN2DE7Oa4F9Ghc+Fn2nvhkLsg49TRGFNGInN11QQxYf8KAjGEd+yF/Onc3ijj9wzzaa/FLm2wqwarx3GRG9TbB5sEqeyrGR/qYdGKGbUUr4XVRbdWPnAH1/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36eb2c-22c9-416f-9d8b-08dc38555cac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:04:05.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEkqZ9fvite/ozM7wFNjrKKHcJgpejBZaH5EW0u1Fsi9ZDJhKd7+EKfCahh/dy+66wxQLcfdMlP3ewic1/F11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280096
X-Proofpoint-ORIG-GUID: G1UgWTdomX2QrSOSj2yZM-7naFhlgQIS
X-Proofpoint-GUID: G1UgWTdomX2QrSOSj2yZM-7naFhlgQIS

--------------mBUH0t5AeeUFZ3pYCPFebgig
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 09:20, Jiri Olsa wrote:
> On Tue, Feb 27, 2024 at 07:21:42PM -0800, John Hubbard wrote:
>> When building the Linux kernel with a distro .config, most or even all
>> possible kernel modules are built. This adds up to 4500+ modules, and
>> based on my testing, this causes the pahole utility to run out of space,
>> which shows up like this (CONFIG_DEBUG_INFO_BTF=y is required in order
>> to reproduce this):
>>
>>   LD      .tmp_vmlinux.btf
>>   BTF     .btf.vmlinux.bin.o
>> Reached the limit of per-CPU variables: 4096
>> ...repeated many times...
>> Reached the limit of per-CPU variables: 4096
>>   LD      .tmp_vmlinux.kallsyms1
>>   NM      .tmp_vmlinux.kallsyms1.syms
>>   KSYMS   .tmp_vmlinux.kallsyms1.S
>>   AS      .tmp_vmlinux.kallsyms1.S
>>   LD      .tmp_vmlinux.kallsyms2
>>   NM      .tmp_vmlinux.kallsyms2.syms
>>   KSYMS   .tmp_vmlinux.kallsyms2.S
>>   AS      .tmp_vmlinux.kallsyms2.S
>>   LD      vmlinux
>>   BTFIDS  vmlinux
>> libbpf: failed to find '.BTF' ELF section in vmlinux
>> FAILED: load BTF from vmlinux: No data available
>> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 255
>> make[2]: *** Deleting file 'vmlinux'
>> make[1]: *** [/kernel_work/linux-people/Makefile:1162: vmlinux] Error 2
>> make: *** [Makefile:240: __sub-make] Error 2
>>
>> Increasing MAX_PERCPU_VAR_CNT by 10x avoids running out of space, and
>> allows the build to succeed.
> 
> do you have an actual count of percpu variables for your config?
> 10x seems a lot to me
> 
> this might be a workaround, but we should make encoder->percpu.vars
> dynamically allocated like we do for functions
> 
> jirka
>

Good idea Jiri; John would you mind trying the attached patch? Thanks!

Alan
--------------mBUH0t5AeeUFZ3pYCPFebgig
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btf_encoder-dynamically-allocate-the-vars-array-for-.patch"
Content-Disposition: attachment;
 filename*0="0001-btf_encoder-dynamically-allocate-the-vars-array-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhMjU0ZDE0ZGVlMDMxM2YwMWRlMWYxZWE1MDc4NGVkNTdjMjY1MTFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBXZWQsIDI4IEZlYiAyMDI0IDExOjU2OjM4ICswMDAwClN1YmplY3Q6IFtQQVRDSCBk
d2FydmVzXSBidGZfZW5jb2RlcjogZHluYW1pY2FsbHkgYWxsb2NhdGUgdGhlIHZhcnMgYXJyYXkg
Zm9yCiBwZXJjcHUgdmFyaWFibGVzCgpVc2UgY29uc2lzdGVudCBtZXRob2QgYWNyb3NzIGFsbG9j
YXRpbmcgZnVuY3Rpb24gYW5kIHBlci1jcHUgdmFyaWFibGUKcmVwcmVzZW50YXRpb25zLCBiYXNl
ZCBhcm91bmQgKHJlKWFsbG9jYXRpbmcgdGhlIGFycmF5cyBiYXNlZCBvbiBkZW1hbmQuClRoaXMg
YXZvaWRzIGlzc3VlcyB3aGVyZSB0aGUgbnVtYmVyIG9mIHBlci1DUFUgdmFyaWFibGVzIGV4Y2Vl
ZHMgdGhlCmhhcmRjb2RlZCBsaW1pdC4KClJlcG9ydGVkLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJi
YXJkQG52aWRpYS5jb20+ClN1Z2dlc3RlZC1ieTogSmlyaSBPbHNhIDxvbHNhamlyaUBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEFsYW4gTWFndWlyZSA8YWxhbi5tYWd1aXJlQG9yYWNsZS5jb20+
Ci0tLQogYnRmX2VuY29kZXIuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9idGZfZW5jb2Rlci5jIGIvYnRmX2VuY29kZXIuYwppbmRleCBmZDA0MDA4
Li5hNDNkNzAyIDEwMDY0NAotLS0gYS9idGZfZW5jb2Rlci5jCisrKyBiL2J0Zl9lbmNvZGVyLmMK
QEAgLTUwLDggKzUwLDYgQEAgc3RydWN0IGVsZl9mdW5jdGlvbiB7CiAJc3RydWN0IGJ0Zl9lbmNv
ZGVyX3N0YXRlIHN0YXRlOwogfTsKIAotI2RlZmluZSBNQVhfUEVSQ1BVX1ZBUl9DTlQgNDA5Ngot
CiBzdHJ1Y3QgdmFyX2luZm8gewogCXVpbnQ2NF90ICAgIGFkZHI7CiAJY29uc3QgY2hhciAqbmFt
ZTsKQEAgLTgwLDggKzc4LDkgQEAgc3RydWN0IGJ0Zl9lbmNvZGVyIHsKIAkJCSAgaXNfcmVsOwog
CXVpbnQzMl90CSAgYXJyYXlfaW5kZXhfaWQ7CiAJc3RydWN0IHsKLQkJc3RydWN0IHZhcl9pbmZv
IHZhcnNbTUFYX1BFUkNQVV9WQVJfQ05UXTsKKwkJc3RydWN0IHZhcl9pbmZvICp2YXJzOwogCQlp
bnQJCXZhcl9jbnQ7CisJCWludAkJYWxsb2NhdGVkOwogCQl1aW50MzJfdAlzaG5keDsKIAkJdWlu
dDY0X3QJYmFzZV9hZGRyOwogCQl1aW50NjRfdAlzZWNfc3o7CkBAIC05ODMsNiArOTgyLDE2IEBA
IHN0YXRpYyBpbnQgZnVuY3Rpb25zX2NtcChjb25zdCB2b2lkICpfYSwgY29uc3Qgdm9pZCAqX2Ip
CiAjZGVmaW5lIG1heCh4LCB5KSAoKHgpIDwgKHkpID8gKHkpIDogKHgpKQogI2VuZGlmCiAKK3N0
YXRpYyB2b2lkICpyZWFsbG9jYXJyYXlfZ3Jvdyh2b2lkICpwdHIsIGludCAqbm1lbWIsIHNpemVf
dCBzaXplKQoreworCWludCBuZXdfbm1lbWIgPSBtYXgoMTAwMCwgKm5tZW1iICogMyAvIDIpOwor
CXZvaWQgKm5ldyA9IHJlYWxsb2MocHRyLCBuZXdfbm1lbWIgKiBzaXplKTsKKworCWlmIChuZXcp
CisJCSpubWVtYiA9IG5ld19ubWVtYjsKKwlyZXR1cm4gbmV3OworfQorCiBzdGF0aWMgaW50IGJ0
Zl9lbmNvZGVyX19jb2xsZWN0X2Z1bmN0aW9uKHN0cnVjdCBidGZfZW5jb2RlciAqZW5jb2Rlciwg
R0VsZl9TeW0gKnN5bSkKIHsKIAlzdHJ1Y3QgZWxmX2Z1bmN0aW9uICpuZXc7CkBAIC05OTUsOCAr
MTAwNCw5IEBAIHN0YXRpYyBpbnQgYnRmX2VuY29kZXJfX2NvbGxlY3RfZnVuY3Rpb24oc3RydWN0
IGJ0Zl9lbmNvZGVyICplbmNvZGVyLCBHRWxmX1N5bSAqCiAJCXJldHVybiAwOwogCiAJaWYgKGVu
Y29kZXItPmZ1bmN0aW9ucy5jbnQgPT0gZW5jb2Rlci0+ZnVuY3Rpb25zLmFsbG9jYXRlZCkgewot
CQllbmNvZGVyLT5mdW5jdGlvbnMuYWxsb2NhdGVkID0gbWF4KDEwMDAsIGVuY29kZXItPmZ1bmN0
aW9ucy5hbGxvY2F0ZWQgKiAzIC8gMik7Ci0JCW5ldyA9IHJlYWxsb2MoZW5jb2Rlci0+ZnVuY3Rp
b25zLmVudHJpZXMsIGVuY29kZXItPmZ1bmN0aW9ucy5hbGxvY2F0ZWQgKiBzaXplb2YoKmVuY29k
ZXItPmZ1bmN0aW9ucy5lbnRyaWVzKSk7CisJCW5ldyA9IHJlYWxsb2NhcnJheV9ncm93KGVuY29k
ZXItPmZ1bmN0aW9ucy5lbnRyaWVzLAorCQkJCQkmZW5jb2Rlci0+ZnVuY3Rpb25zLmFsbG9jYXRl
ZCwKKwkJCQkJc2l6ZW9mKCplbmNvZGVyLT5mdW5jdGlvbnMuZW50cmllcykpOwogCQlpZiAoIW5l
dykgewogCQkJLyoKIAkJCSAqIFRoZSBjbGVhbnVwIC0gZGVsZXRlX2Z1bmN0aW9ucyBpcyBjYWxs
ZWQKQEAgLTE0MzksMTAgKzE0NDksMTcgQEAgc3RhdGljIGludCBidGZfZW5jb2Rlcl9fY29sbGVj
dF9wZXJjcHVfdmFyKHN0cnVjdCBidGZfZW5jb2RlciAqZW5jb2RlciwgR0VsZl9TeW0KIAlpZiAo
IWVuY29kZXItPmlzX3JlbCkKIAkJYWRkciAtPSBlbmNvZGVyLT5wZXJjcHUuYmFzZV9hZGRyOwog
Ci0JaWYgKGVuY29kZXItPnBlcmNwdS52YXJfY250ID09IE1BWF9QRVJDUFVfVkFSX0NOVCkgewot
CQlmcHJpbnRmKHN0ZGVyciwgIlJlYWNoZWQgdGhlIGxpbWl0IG9mIHBlci1DUFUgdmFyaWFibGVz
OiAlZFxuIiwKLQkJCU1BWF9QRVJDUFVfVkFSX0NOVCk7Ci0JCXJldHVybiAtMTsKKwlpZiAoZW5j
b2Rlci0+cGVyY3B1LnZhcl9jbnQgPT0gZW5jb2Rlci0+cGVyY3B1LmFsbG9jYXRlZCkgeworCQlz
dHJ1Y3QgdmFyX2luZm8gKm5ldzsKKworCQluZXcgPSByZWFsbG9jYXJyYXlfZ3JvdyhlbmNvZGVy
LT5wZXJjcHUudmFycywKKwkJCQkJJmVuY29kZXItPnBlcmNwdS5hbGxvY2F0ZWQsCisJCQkJCXNp
emVvZigqZW5jb2Rlci0+cGVyY3B1LnZhcnMpKTsKKwkJaWYgKCFuZXcpIHsKKwkJCWZwcmludGYo
c3RkZXJyLCAiRmFpbGVkIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IgdmFyaWFibGVzXG4iKTsKKwkJ
CXJldHVybiAtMTsKKwkJfQkKKwkJZW5jb2Rlci0+cGVyY3B1LnZhcnMgPSBuZXc7CiAJfQogCWVu
Y29kZXItPnBlcmNwdS52YXJzW2VuY29kZXItPnBlcmNwdS52YXJfY250XS5hZGRyID0gYWRkcjsK
IAllbmNvZGVyLT5wZXJjcHUudmFyc1tlbmNvZGVyLT5wZXJjcHUudmFyX2NudF0uc3ogPSBzaXpl
OwpAQCAtMTcyMCw2ICsxNzM3LDkgQEAgdm9pZCBidGZfZW5jb2Rlcl9fZGVsZXRlKHN0cnVjdCBi
dGZfZW5jb2RlciAqZW5jb2RlcikKIAllbmNvZGVyLT5mdW5jdGlvbnMuYWxsb2NhdGVkID0gZW5j
b2Rlci0+ZnVuY3Rpb25zLmNudCA9IDA7CiAJZnJlZShlbmNvZGVyLT5mdW5jdGlvbnMuZW50cmll
cyk7CiAJZW5jb2Rlci0+ZnVuY3Rpb25zLmVudHJpZXMgPSBOVUxMOworCWVuY29kZXItPnBlcmNw
dS5hbGxvY2F0ZWQgPSBlbmNvZGVyLT5wZXJjcHUudmFyX2NudCA9IDA7CisJZnJlZShlbmNvZGVy
LT5wZXJjcHUudmFycyk7CisJZW5jb2Rlci0+cGVyY3B1LnZhcnMgPSBOVUxMOwogCiAJZnJlZShl
bmNvZGVyKTsKIH0KLS0gCjIuMzkuMwoK

--------------mBUH0t5AeeUFZ3pYCPFebgig--

