Return-Path: <bpf+bounces-47866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75195A01334
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F801884E5A
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64A152514;
	Sat,  4 Jan 2025 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQYOT7N9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GgO6TI6t"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DC2594A0
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735977991; cv=fail; b=u1DbEW6sBUM8hdLy7hd0g7fVf09AdcxDMrocxqz6cHuVKY7zEHCH70axAC32EBO70dnsugNQP9bqdBLefJZa2MmQPdqTalkw4MG1QXK9shS2iYq902K0PKVWj1Zt3lvOmLZ4R55jZG5u2E7UjM2mnRAtOOIg0V0+CYzWWXqY8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735977991; c=relaxed/simple;
	bh=qO+RVuc6UJbq0nFH4NB/g5Xxg7jfA6FY2eRWEKAzAXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QkeDms/bxscFXXsFoDSbPmdiq+8BRzLfZ65A/gLpxk/OKToaUpw+Z89cYP/q/u2yxKbP+hWTHIchs614+o4ei7gJTIK4wK3g8/2/sRwYc93g1y2n4q32DTNm4WS+10L3byySXdegBDX7UYJal7dhQFyxP07m1lMaBE9lBB+oIrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QQYOT7N9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GgO6TI6t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5047xF82001740;
	Sat, 4 Jan 2025 08:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y+4nUF6h1wmLON+DODdkdQW4mtyqExjJerLAyj5HFSQ=; b=
	QQYOT7N9NnDnI2xjLHzni6/gQdGZsh5c7VzFDq2sWLWNS/BJRUWb9Y2oAcWwBo+Q
	GHw0UyNfhq2djfMwvQfe8yS6ENG19hFfXKmad6TbgiTNHuFANJZQHb3A/X25xl81
	jHf9+gTUxJM/Zr0v2ItHBxV4mwN7zsIZdwxLAjPBlk5j+tSLDgwpt4t4a/vNdjbX
	Op+Tj70aTAnohyFnSHdPuaHSLFqjfHmXMBuevVLPk6n1kM0DqbBvZrXqKfgRDhVm
	FIe8EIc4vPdZq5TWlzp8VLdp9AotLv3qRcyYEwi8yHF+HT3zS9NRd4uOtT2X9YCD
	pxa/gNoQkffEMgvYANKj4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc0j0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 08:05:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5046bCBO025491;
	Sat, 4 Jan 2025 08:05:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue5xcg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 08:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtPwgf5oJCiRl5RIPmlSdKINVonDOZBPBfvG4rzF7XBbpKVwSq7XWRXh8B/QwAv66mvGw1fmROKnEPugIgQlurctw6UkusGVoO5hyOW1g9xQQSbH37ZmnR40pUefsut3+BGej+8NhJOBGR21LxXvZXkCgUgjRKZz7keWIBK502b6BVpG5lm9p7zDa2blbM1oaxFtvt1A5FD+hyfrl4ShFg8dc6v65DcLiMnLtXCWtdShOpqBjdZ77LZHgAgNY+F3ojeHtd5/pznoc5uxpdbbG3r1V17Vf3RJ95SXXMyctf2bcVXuniWzMw9tGi7k9nO2cB+6WcL4s3uLiMfIYsOkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+4nUF6h1wmLON+DODdkdQW4mtyqExjJerLAyj5HFSQ=;
 b=K6OcesvXonShSywLeWFW8IYa6UsZHKnjURG/eNFEViCrt0F2hk6DVJHlyggX5xdlaUqFXxfBV6eg0eDgcDtuFG0uRzn3b1WJ1A4IxEYGofinpGQBmcZ4oHAfj0Efkd4vYqD+XAHZGr1p3n1nLJsX/GpLqJwYM0+WfkDLTeOGPAot1Fn4DRVfbVv44QxtItrcEEZBIdZTp7mwt5H6xzCthytqsOwU9+2qTE0A2kHckwky5tnOK7EVmO9tmdPsCZGoxJ5gUh83W1ZOtM2EZ0E7DfHV459vtvBJ4rNl9Qvq6d4KZb5K1ImFlWv1DTWxz55GMtUCt1VQ8YtftBgl3b3bPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+4nUF6h1wmLON+DODdkdQW4mtyqExjJerLAyj5HFSQ=;
 b=GgO6TI6tRONIMfs3llE3SXsZ2yDBDAi46KHsX5a/oSHc3Rd6ERJZa4tGuP5UCx993K4X7a6/QQ8LtBtyWe7FGszgWACcnb3RCZ4Qma0VphZYCUE2oOW3bShac1LjIdATaBD0OHF7RamZBwPCowPuuNgDdrOTnQ5+oHo8ZKgAk7E=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Sat, 4 Jan
 2025 08:05:46 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8314.013; Sat, 4 Jan 2025
 08:05:46 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust
 <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Manu Bretelle
 <chantra@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko
 <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrew
 Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>,
        Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me>
	(Ihor Solodrai's message of "Fri, 03 Jan 2025 23:48:52 +0000")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me>
Date: Sat, 04 Jan 2025 09:05:42 +0100
Message-ID: <87pll3c8bt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: c3de5110-f0f7-40f6-c1a0-08dd2c969808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnlpcXJRekF6Ympya091T1Vka1ZQWU4zdlVPdy8weXE5TEVZRUlSbnhXcHRX?=
 =?utf-8?B?VGtxR3BHSkhmSGFsVnpZNDRQelBlbWtWbHRvU2phN1VGM09zbDdQaktxTnlM?=
 =?utf-8?B?bC92V2Z1QmwwblpZa1VMbHpnWTU5YTFPWUZSMEMvZks1cjM0Njl5aWtvNFI5?=
 =?utf-8?B?eXg2QThlMG1FSk0yYXR1L1BES3JWQkJjTkhQUVFLRnE5czg0K3NtNExQeExZ?=
 =?utf-8?B?a3Z1d3hwakxaMjV6bU51eTY2TEs1U2dkT291dkNhWlYydVgrTCtkWmtlLzk5?=
 =?utf-8?B?S01LM2c2Vkk1OXE5MWJlakkycmc4dVcxOEgzMFY3UGlkdVI0VjRmZHZEdEty?=
 =?utf-8?B?K2tQRXNxSHJhZWUwTy9PUGVneFVMc01CandSU3BZZjZUd0hNbFJTbzl3VFJQ?=
 =?utf-8?B?YWI5NkJ4ZThFZUhSditIRzlka2dOU0hFQVZCTlNUMThkdHg2T1ZNamM4Nmdw?=
 =?utf-8?B?ZTRNZjZOdnZrRUJyWXFtdWdrLzc2YUVZUGxFcEJ1dkJrN1ZacEI0QTFQQ0la?=
 =?utf-8?B?ajV3VHJTc05PL1lZY3BiaG9Fd1ZlQ2NmY1h3cGFpa0FRcXk1N1dLUHZWRFhZ?=
 =?utf-8?B?N3NaYUNYem5pSkoxa0ZiWSt3VjJWQU4ySStTZHRGTkZIMmszb0FSMTNYcWdh?=
 =?utf-8?B?R0RrOFI1MGtNQjNSekdVQ0VjYVEva0xVOFpCVXdXZXBsbUp3WDRDZ2U5S0xT?=
 =?utf-8?B?c3U2ZFRya2owbXFKNThGTWtWMEZJME5nQytZenJLRnRuU2wxUUZyMDk5OHho?=
 =?utf-8?B?eDRXSXY0TmNRbk44OGtMZG9odWtaZE9wSFd1NHhlbldVamlKU1JVUzZhYm9F?=
 =?utf-8?B?bDlhSXAzWXppMVZFYjdnL0JZZFFIWTVvUm1pOThYdTQ0Tjl4ZWVObDI0ajBs?=
 =?utf-8?B?RG92MngyRnJoTHhyRFV2VWsydmZEcXlNSlFncmRTSzZ6ZGtYdHJ4NDdNbzM5?=
 =?utf-8?B?TUVLYUg5RmxMZTRiK3h1RmRha1BNTnZUZHdoYUYzSm9ubk1vam1yNm5oRzJG?=
 =?utf-8?B?RFB1YmhsRWNoQnRvSk90YnBGZmJCaUxGYytmOGVyekNTWEp5eU1sVCtDYkha?=
 =?utf-8?B?NjEwam84bVF5K3RGNURWdlZERmJPcWtTUVBpVDlxSUMwY0N6UHBySi9qam5v?=
 =?utf-8?B?YzdPcnJIN3FIeHdOWG4vMUlGcVNjZXdEZ1hZVVRLOXMwM3NzeCt4ZU95S0tC?=
 =?utf-8?B?dDZUMFNQVlVpNFFRdk9NWUJvTkJOVnJlNGVwZm41YmFpS1BYUzdDQ3oxTzhi?=
 =?utf-8?B?VEhKQWVGaUcwZG8wVThVMnNQUzFqaXNKYmdKQkZhK2RINnpwSVhrNExHUkh6?=
 =?utf-8?B?RDR4SDFQNlQzSTNSMTdlblFXci9DNTBGVmRlYlU5ZnR3Q0hTUEJVRlN0Nmov?=
 =?utf-8?B?VUJmNzY2b1lYRWxTdHUzMTBJY280ZTBsOFgzQWp4cWIzSVl2Vjl3NmJZcm4v?=
 =?utf-8?B?aXNHa0l2N3pyUTNKWm5Ia2p6YlRIMk92MnBtYllZTm81YWp5K2xGMmlQVjJy?=
 =?utf-8?B?WHUxSzhvUkYxWnhibmszemVNcDFVcXVTQ05Mak1uM3RjM3EvYVhEblNSQUlE?=
 =?utf-8?B?RUtoZFBPaXNNZmJlS1FVcnh0aUdIa3dIWDd6ZWRGeTRlSENLdHJoSnVOMmxI?=
 =?utf-8?B?cVlRZkJENDJCUkxKc2pQTEhZTThIMFFqT2plOHdkdkFsT1lMa1RZU3oyTDBu?=
 =?utf-8?B?SDFZVThzajgzVkRyNUZXSjVPVHVPTkRWNGxTc0N4SFNVK09DanIrRmpFdzJF?=
 =?utf-8?B?S0w2VUJWWFdrMzZLWEd2U2JVeTRQY09reUovVkdDQnNLYi8zTC9pc2d3aGZE?=
 =?utf-8?B?WEt3OWtPbEFub2JmenJtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXpXZktiL1ZYZHJib0IwVUpwRmZjYzE0QzlMcFZwS3FnNmI5d2NjYWhUcm9I?=
 =?utf-8?B?WkhPd2V4WnNaREFYRjJyWWhqcmpLVzRCRW41ZWlWMjdveE1iQ2pqaG1xQnRZ?=
 =?utf-8?B?ZW1zSkNINFd1L1ZqR0pPVXZyTk55Z1UrbURRcUVOVWlRQjJvT1FSVjNWTVBy?=
 =?utf-8?B?amxRZnBVVVpOdk41WEQzcU96R1lOclBYTU5pQjFNYzRtVU43VWRDNURyelBY?=
 =?utf-8?B?aDZHZlk0L0hhc29kVnU0bURZLzdQWVBVOEdQK29EbHZ1cVZWdjhtSitmUlBG?=
 =?utf-8?B?UUFDYmxmRTljcEsvR3puVXBOVUcxK0lBdkxyYkh0ZHlTTklhTDB5SXhSMG1H?=
 =?utf-8?B?ZmVtN3g0VXc4YldnWWpreVhpNHVQYU83VTFkSFZOR1BtRjd4a1JUL1ZIc1ow?=
 =?utf-8?B?RDFraDlQK3dRL0trQW1NejBPNzdhUTZGZzZvY0o3WWlzM1VFUElWRlpzRWM3?=
 =?utf-8?B?dkFYNXhHdExOYnFwSkFsMnRKU2hPdTZhZ3Q3THIzcFFKN2FaeGRzNFppTzVa?=
 =?utf-8?B?b3IrbXM4QW1OZWU1SHhEUVR6em40YWU0WjIxemcyaTdEWmVMYzBEa2lhd3Vn?=
 =?utf-8?B?aEtlb2hpM3NYRlpWRkZtTmVGeFJiV3B0eHJPQlRKVXRCYzZpcEo5OXh4Vko5?=
 =?utf-8?B?VXdFNVBNN29BN2tDeWFKczBHR3U2dXhiL1NNTU5CMmpnRU1BRWRTVUlzOGtM?=
 =?utf-8?B?dFJpUEVkOWNIUDBKOWpwTnNoR0x6M00zVzNDdkdCMTJXellUOFdpd1ZZQytC?=
 =?utf-8?B?UVFHN2Jwc2F4U21aM1dkOVlwbTQ4SDNLZU93K2NCaFQ4NnloMGpQV00wZmtK?=
 =?utf-8?B?RkJwQlorYjl6OExObG5TSFBHZ0FlL3Rwam9CRXcyb2lVMFdSYzM3TDg0djdZ?=
 =?utf-8?B?OWZJUW1wUnhSTnJNU0tSRmpvMGN2c1E0bzUweCszaitsNFhDTjNrNGtJaXd1?=
 =?utf-8?B?L1Flckp4aHZrcGhLUGRpaCtmWVdyZ0p4MzF1Rjl1WllQdms5VXNqNkNXZjFM?=
 =?utf-8?B?cmtmbGpETzY3UzcwemJaV0h5YzZadHpYRnNXbVg2bnZKNFdST1UyblVMSno0?=
 =?utf-8?B?L2NwWklGdDYxSVVKbGJYY25KRTBxUEN5dUh3eXhrY3RSZFRxOWc1ZU1hWmZF?=
 =?utf-8?B?UlZ6OXNFbzYvb2RLcVVoYlZ1c04weUZnZzZZTFl0QjNuZzdkOWJhNnZ5UUZT?=
 =?utf-8?B?REI2STlra0RNdUNwY1BVaXdrRFpURTY1b21Fdm9ZVjljYTVwVlFTSCtRdnhJ?=
 =?utf-8?B?UHNzT0xGK1JTMkJPc1hKUFJKbFMxM3VtcDVxZFpwOWNQaTRmT0ZtSWI1QlpU?=
 =?utf-8?B?VklsUjhiSnRrTkNDNGJOdmVPY1poUTNQd0hPVWJYWUtqQXdUeUxleU9jeE4v?=
 =?utf-8?B?L1JPVGNOTzJaLzRnM1dDU2JncTVlV2ptdW1jZU5RYW5mSkFiWnh2OTU4Sy9W?=
 =?utf-8?B?UlFmZUplenVGRUVmQW5GR2xjR2c5NFdQUzJaY052L2Y0VnlIRWdWeGpEY2hM?=
 =?utf-8?B?OUlLVEFnRGxHc3c2Zm5hLzJySFdGdUxjWTV4ZG1CeFBnNFRSVi9ZeU1mU0lW?=
 =?utf-8?B?ZjRmejlVTGlDdUlDME9QQzlYL01UZ2tHaHc0T0E5WnFNQlY2ZkI3SDUxT3Bn?=
 =?utf-8?B?a3Fwbkg1blNMMnBoWFZwM0RwalpNQ2RZSUJ1TkpRaFplWHdzVU9pRU1vK1d0?=
 =?utf-8?B?SFphdkE3djhnTlp4a3ZMM2UvQ2JoYitnaFJGNWR1b0hRMnorVVNLREg2dXVD?=
 =?utf-8?B?YWFEWmtUNEtWcW1LT3pWcXM3VlBtdVNiMVB4WHpFTVJtSFdCc1Y3MVB6ZnZt?=
 =?utf-8?B?RlFaRnYzbUM3TWJudlp2MGp0NzdGeGtlajEzdERaVU1JSVZJZ3RPS1FiamxL?=
 =?utf-8?B?ejJ5OUZ1TlVlR2RhZEVPNitURUorNnJxYWF0eXFyRHZBMnpHSmlOaW1icUY4?=
 =?utf-8?B?UjVVdENHWjJ6cmlqMTY5bkFOYkVacGR3c244T2ZHbFNWNC9VS2lsR29Ca0Rz?=
 =?utf-8?B?dDdBNXJaZG5GYzl1b0RPOVM1R2ZnSElpdlBIVWdTcXUyNzBjSlU4YUdtMFQv?=
 =?utf-8?B?cnlaNG1PZUpPL0RZTGljdm1Hb0xNYkdpMXBPSzFvUGh0WGozYlcyWDZhR2Vn?=
 =?utf-8?B?bFlVNjFXRFBFeTJGNXE5Zmp5dUJsSTMvbWowZFRNWnVOT29WdC9iUVVzZFBq?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uoIWtdkLY7/bch4ZDzy8W0Mf5Agax/TGUlyIo4sTtBqM+/3m0FaQaXzGm/HjExsxoyP9d0YvLW0UxmYQ4wCpmdfXnIHwj7QlcKribeuwqCsgdRdgJo0Q1vbM1J+aaxrvo3nAUA5XnwJZZnoBbAUuV7nUwL1uJ9+pozNXCv8Y1/1D3I8wlSoGlHLXi9sVluQcBAIHt+vdknh33fShqUEE4olEz0e8IzS9wL5dTlS6qRLE2P6sWfebrB3khE4nfvAG6aYJBufm+iuC3igy0+oJqOphjuBJClERbrYUK3Bgz95RYiih3M1YGHwnM1RBC+iWmoI32cUUxxwy2F+8+WS3LRt810Nc5Ani8oAW6+swaUD3fCUYPgKczh0FoDYJJ2qjnUbTtYwnad3Kk0XfXmHfIdXQFy+04i3Lx7byoHdCAT56wAq0sj4Tik1pY1hIqREvDNFmfCSzGc8HZPK9RAfAa8q5ZPN8Vt+HLJvIH58i5jaSKAklE9ndr3AZK++w21xuFR7RrMTohHyBWKHHGs+rE52/mYTdtQZSCjMwNBxNJLiYJkoW9cpG8LW4xE+YNb1YLDHUpM20RA+6gS6z7pWOkG6je8ngoT/uufITtmm9tsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3de5110-f0f7-40f6-c1a0-08dd2c969808
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 08:05:46.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ1FtxLiElCivh6T3+25bfYuD4+D9Cnke+atARaui0FBil5DXs4sGOKdUh+3CwOqcn7BnwX7nyG/u0IVOw7EVI5QICf0tJV70oHmZcvyvQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501040067
X-Proofpoint-ORIG-GUID: w4DZMp3iu0w0G_1JqqJbma9xEpn1BJ4M
X-Proofpoint-GUID: w4DZMp3iu0w0G_1JqqJbma9xEpn1BJ4M


> Hi everyone.
>
> I built and ran selftests/bpf with GCC 15-20241229, and would like to
> share my findings.
>
> Building required small adjustments in the Makefile, besides -std=3Dgnu17
>
> With the following change we can mitigate int64_t issue:
>
> +progs/test_cls_redirect.c-CFLAGS :=3D -nostdinc
> +progs/test_cls_redirect_dynptr.c-CFLAGS :=3D -nostdinc
> +progs/test_cls_redirect_subprogs.c-CFLAGS :=3D -nostdinc

These shouldn' be necessary anymore after the change in
https://gcc.gnu.org/pipermail/gcc-patches/2025-January/672508.html

> Then, the compiler complains about an uninitialized variable in
> progs/verifier_bpf_fastcall.c and progs/verifier_search_pruning.c
> (full log at [1]):
>
>     In file included from progs/verifier_bpf_fastcall.c:7:
>     progs/verifier_bpf_fastcall.c: In function =E2=80=98may_goto_interact=
ion=E2=80=99:
>     progs/bpf_misc.h:153:42: error: =E2=80=98<Uc098>=E2=80=99 is used uni=
nitialized [-Werror=3Duninitialized]
>       153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>           |                                          ^~~~~~~~~~~~~~~~
>     progs/verifier_bpf_fastcall.c:652:11: note: in expansion of macro =E2=
=80=98__imm_insn=E2=80=99
>       652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCO=
ND, 0, 0, +1 /* offset */, 0))
>           |           ^~~~~~~~~~
>     /ci/workspace/tools/testing/selftests/bpf/../../../include/linux/filt=
er.h:299:28:
> note: =E2=80=98({anonymous})=E2=80=99 declared here
>       299 |         ((struct bpf_insn) {                                 =
   \
>           |                            ^
>     progs/bpf_misc.h:153:53: note: in definition of macro =E2=80=98__imm_=
insn=E2=80=99
>       153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>           |                                                     ^~~~
>     progs/verifier_bpf_fastcall.c:652:32: note: in expansion of macro =E2=
=80=98BPF_RAW_INSN=E2=80=99
>       652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCO=
ND, 0, 0, +1 /* offset */, 0))
>
> BPF_RAW_INSN expands into struct init expr (include/linux/filter.h):
>
>     #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)			\
>     	((struct bpf_insn) {					\
>     		.code  =3D CODE,					\
>     		.dst_reg =3D DST,					\
>     		.src_reg =3D SRC,					\
>     		.off   =3D OFF,					\
>     		.imm   =3D IMM })
>
> This can be silenced with:
>
> +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -Wno-error
> +progs/verifier_search_pruning.c-CFLAGS :=3D -Wno-error

Ignoring the warning doesn't cure the resulting undefined behavior.
These selftests seems to be violating strict aliasing rules, so it is
better to either change the testcase to work well with anti-aliasing
rules or to disable strict aliasing, like it is done for many other
tests already:

progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing

> Then the selftests/bpf build completes successfully, although libbpf
> prints a lot of warnings like these on GEN-SKEL:
>
>     [...]
>     libbpf: elf: skipping section(3) .data (size 0)
>     libbpf: elf: skipping section(4) .data (size 0)
>     libbpf: elf: skipping unrecognized data section(13) .comment
>     libbpf: elf: skipping unrecognized data section(9) .comment
>     libbpf: elf: skipping unrecognized data section(12) .comment
>     libbpf: elf: skipping unrecognized data section(7) .comment
>     [...]
>
> Test .bpf.o files are compiled regardless. Full log at [2].
>
> Running all tests at once, as is usually done on CI, produces a too
> cluttered log. I wrote a script to run each test individually in a
> separate qemu instance and collect the logs.
>
> 187/581 of toplevel tests fail on current bpf-next [3]. Many tests
> have subtests: toplevel test passes if all of its subtests pass.

Thanks for the report.

>
> You can find the archive with per-test logs at [4].
>
> [1] https://gist.github.com/theihor/10b2425e6780fcfebb80aeceafba7678
> [2] https://gist.github.com/theihor/9e96643ca730365cf79cea8445e40aeb
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?id=3D96ea081ed52bf077cad6d00153b6fba68e510767
> [4] https://github.com/kernel-patches/bpf/blob/8f2e62702ee17675464ab00d97=
d89d599922de20/tools/testing/selftests/bpf/gcc-bpf-selftests-logs.tgz

