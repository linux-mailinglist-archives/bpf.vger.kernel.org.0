Return-Path: <bpf+bounces-27212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B418AABAF
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477C41C21143
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73CD7BAF9;
	Fri, 19 Apr 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MafNJsYx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dEc2EUcM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C776402;
	Fri, 19 Apr 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519881; cv=fail; b=MT9qtdT/CGST/pp9O29l/lL28IRdMURezd5N+mccV+eLEOGclePZ0pF0Vo4P744gOTArGxoKGtvk4Mjqbwy3PUfLK7g3qjzd+dS1ItJxZE/nFiwQ98+YfDIsE0eQAvblg0jdwpGzWuusAyi2w0R8ee2gqhdiSwr2qkkcoQCjSok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519881; c=relaxed/simple;
	bh=tiAlOVyS6QT9eBCwjiQav5P5i7U9tjkZrQzhEPkTJM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tq5MDCSWlANO351U5qPlha5TKwtmAOARzB0JCX9RfYLTgci9IUv9F7FsFPIoCAU1291iRkxafm/7Qr2J1Yr3EUr3O0Zo8c9U6Q+zU4ghR3rDXv8UVViOI7+JEO4ckMyiyHaY7jQ8VJOHNyrUNlZxHSkt5GcFp9Ao18o19aPYFQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MafNJsYx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dEc2EUcM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8xIbQ012560;
	Fri, 19 Apr 2024 09:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H5vudH7vcUemUL5UOPtrkVicY3+aVwUYOpmF44nlvqc=;
 b=MafNJsYx4m+UvM6sedNbvzqBSxr76/bI0npsxd2kElgn6+K4Ae7GRqVD5aS73VXbVIS8
 YzsQnORV1k8c9xWydRauHqwq47RhEgL19HEfqgcW5RpueWhAkcy2WveJ2lHaS26430z4
 Jo31s2X41EBhFyR2P5bUonH0SFqqcCPKpXVIpLG0+8bU/sQ0Ql/E7Hzqt9UG93oQMUEJ
 /FODe9/GrJAi3ERPaj/73JpfoZy/+JES7wLCC0SOm1JCo16r3jXOGQeaSaNQmh3TQiaQ
 ut3SJt7m3/MtQwIPMAnojYetOxBWofWNZMuiYrPNcbe2ns6AOFnhl/BG73xcVpmGdw0K 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbvbr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8miKO038189;
	Fri, 19 Apr 2024 09:44:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc7ckndb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcCyqblcIHlAfa9yxsOBjhI7eZotgfeoDAia1tt8ibvRWAheSMKNqSolwyQVId0Hlw05KyPOIr+Pr441IWYrN9ztbCIEIFrEc1h3qqMccIJJox4ngS7MgZH9P8XlKvKbnP+LWHdmogyhdo9OmzIORJaMgmzYQZ1jCBxzDC5SBdhHfpATeosELFlyUO/4xx0VC7vaAsXJ7fT9pWxcA81PM3rLdC5gSA/pDHcbCdQ0//8yf7kmpp+bTnJKJwWCrLdS9dLkVIHIWNrKetkuq798wHPrI3ljhlgOUHEAY/Qu8nWAJKgyNJfVAOXUhSIRsOx8iwMAoYnxh+UgJpuY3VyUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5vudH7vcUemUL5UOPtrkVicY3+aVwUYOpmF44nlvqc=;
 b=EvpRnrZRwwOVPd8W8KA1sABpNRhfF/3YjneiYo8gyaGyPe/X7B6bSmdWj47Q1BHWUBWt42+oRxODUgLAoTR13bVux5I2Tvvoe4ofQqknksZBFxfHCq8K7bhXCQ4rfVXiVCiZ8dqDoAwrVX3B+F/lDsh4Hlbdyp6CePo6H2yOht70vh44DeG+67LrVWlJA6KEw2w+8YHORrTPb+SF7D/3WrCZA22rWUEhEHFKccl7Mnhu4ZEzFicoDS9XHuFBIkVbMEFt44emt0KnHY5JB+7ifiVLNQ2t+veXVGOph7OTtVbwirQneWSXaz3uhfYP4jYpFy7a5KwkdDzL+utufc4fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5vudH7vcUemUL5UOPtrkVicY3+aVwUYOpmF44nlvqc=;
 b=dEc2EUcMzsbnCBCaqzbojIL4DtuQrDJjxUAxmhWOqg+0xpcVkP7+yfHg70x1doF3ZwXMLinyuhTmwMuP65Ee9kncLQ3r1Ty2i53EJiLkqk25GbusY2e2/wZyILc/OQt2arPKnL8Vq2Ej/FhVCaT9e8KfvIo1dMmNJZtgfD2X5AQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Fri, 19 Apr
 2024 09:44:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 09:44:22 +0000
Message-ID: <2ce09b72-1b83-4a0d-a665-50ec8fa7b520@oracle.com>
Date: Fri, 19 Apr 2024 10:44:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/3] pahole: allow --btf_features to not
 participate in "all"
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, jolsa@kernel.org,
        williams@redhat.com, kcarcia@redhat.com, bpf@vger.kernel.org,
        kuifeng@fb.com, linux@weissschuh.net
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
 <20240416143718.2857981-2-alan.maguire@oracle.com>
 <CAEf4BzaS9_x+0DPuHU4NAFEP1+Mb-RPdmMfVCw9oW-d=Lj-cmg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaS9_x+0DPuHU4NAFEP1+Mb-RPdmMfVCw9oW-d=Lj-cmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: f939e152-46a0-4594-b561-08dc60554ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dLk6uq1PE2MX/Ie1kja1tYi4+Ob3UgRUXIb6yaFB6zr6/aAGDgYMGKqHP8HPXFPGouHR7/29ardf6UWkGXg0PafBd3r2Ykc6SzBKqwiLLgr16sx5XfDbyOSCPo5U5bdT2uTqXkZHGH4N4rz1lC+yESwzpAGeoEQ6HBblTAm/HPys0KuSKjK3D9U/BI8Jx05JKL8MOUd+TUZMfj8O5NJFwYVa/5BW+1byi/l0vRzLdQ2kUV8hK/z7J7ixfkcG4s7uyCTxug9BiAa6mty7LKpmQpv1ei80519r5ezoPukcpDCcNd9h78sGmbQjgcE8M2bg68ycHpub6+l/dEw2/olqw64XLPu6pNKvib4BSQTH9Or43DghVFPzBav/E3q2r1XCia3EzI5kFAE9VknJ4d8+gcwKXb0r1cVV9UVnEECUGvOWnib5RguZ9lF9g02yo0lfJS6AFPhoIiK7n56ksr6Sz7RViXeNBASwHtpeb5FLBEPKpSczqDza4ROC6f02Fq5Gkl+f9XeaNoZ0NJUy1e8PaFV17k3o3Bv5IQeW2GdMimRH148Tcy8PNf814FJIii+yb3QC+5LtuUvM2jpnDgrmMHe0QJhRt1ZPjHvZxXKddYNxCQam7kheChJfVy2Dk91zoYwbhJ7aY7Uk3cfSA6sEfxFRJqjOL0tjgpSaxOgdBBQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1BsaHE0d0dVTkVHTkZzdjN5SENkU3UyeGhvWGxWSHNITms0Z283c3pjTFVF?=
 =?utf-8?B?OE04U2IwSXg2eVgwdDhVK28wWXVOd0EvaWZxeFJOYm90ZFlXcFFlZTNRUmc1?=
 =?utf-8?B?VG1PZUpaMldSemtCbStEL3I3ZWtXcG9ycDN3cWNtN1dROEdQZmZLZVMyR3Fj?=
 =?utf-8?B?bGFsZ09IbU5WQytVd3BpSVVtVEpvbEhzd21iOWc5REJRbHFVWTNSZDNqdTlG?=
 =?utf-8?B?Zi9IckhCaVNUc3pWNWxLNUlLTjY4N2twZHZ5UlZ1dWtWbE0yU3ZoWEtETGR2?=
 =?utf-8?B?TGdIOEVVUFhvSDZjRHVRYmJEd3V0ZGcrNEFFdlI0ZkFZNnZxZE95OW10c1ov?=
 =?utf-8?B?a3NjYTFSLzVOYThPMDdhR2RqNU1mcWZBUjVNbVRIbWt5TGttY0kvenh2bkV2?=
 =?utf-8?B?TTYvTGdNRVczb012YW9aT01SSnJ6L3dsL2FOV3lMTzdEcE9RR1FXS29tSEJw?=
 =?utf-8?B?RW9KeW9YVW9vK1ltTmFuM0IrZnl5WVIyS1hmQzFCaWJycTVqVG1ITXdpeHht?=
 =?utf-8?B?bHliQTFEYjFZbk5XTmdQdFFXQXI2MHpYb0hubEEyNTdBRlVZK3hZcEEvNzhG?=
 =?utf-8?B?WEltVGNWL0xGemVxWldnMmVJZUVWUExHcW1UYkxzK2tkaHc3MlZKNVp2L01r?=
 =?utf-8?B?M3JKQkFkSUIxZ2dGYnJUM0J6cmZwL2ZmaGIzTEJYcThSSWxGL2g1ZVc5RDlV?=
 =?utf-8?B?TjFldjN0VUozZGI3OW9pNS8vb1gwSWRzV0hNaGdCM2tYV1g1cFcwNWJ2d21h?=
 =?utf-8?B?UWFMQzJ5ZDVNR0hFd2NOMUU5dGd3S1dKMmtqdEREUGF1U0RQaEVxT2t5bndM?=
 =?utf-8?B?R1JEbVdpVkxacHB0QUg2RU9zUHJsU2prR2hGbmcxelVWOCtEbzRsSEM2c0dh?=
 =?utf-8?B?MERPdlN3WUhXNUtXYU9DRE1zM2g5aVZ1RTg2YWRFU21OMGFtV1lwcCtiV2pZ?=
 =?utf-8?B?RFg3aHF4QTFyQXhpTFNoTmRhL3lLQmR5aytkUWoxcTE3dis4dHlGZm5yQis1?=
 =?utf-8?B?NkdRYTJwL2E3WTNCUUp3WTluM0JqVkY1K01hMDVScTZzcFhlN1VUSFdzYTB4?=
 =?utf-8?B?OFlnbG01SjF4NmdsU2FQcktvaFVEb1dIUWNQWjRnNDdlcDBIYW5ZSnB0M1Iw?=
 =?utf-8?B?VnUvMjdYNklWK25leklXd0wybjc0UUJod3ZuTWJ6MWlmKzRGVTljQmRtWWFD?=
 =?utf-8?B?QUw4NUgzblpoK1JSNHoxeWJITnNSQXhRS29keTkxK0hLWklmRzhya0NuclRm?=
 =?utf-8?B?VzZ4SEp3K3M4c01aeEhyNExOam1mdG9RVllVOWhwQ2M1VWZVZmwrZXNlZ0NB?=
 =?utf-8?B?cTJockNSYVMyYlF3MGQ1dGNkeHR3UUhPZGtldHlSQzJjTmRaY3FCK3hYNzMv?=
 =?utf-8?B?cUdjTEt5VWZFTGxHN3c5cHpzY2owM0EvbWJZc3F2U0RkbHFmOTkvSVFtWHcv?=
 =?utf-8?B?UCs4bU1MT0o4bE9iOWxoN3FuaGVmWm5EdUFvTm9pWVNFTzhzYWxuSERFQ0JM?=
 =?utf-8?B?QzRzTXNZY3drUTJ6V2dhbG55NENVSVlyVnRNV1E1OHBLdEJMWDF6VVBlLzlM?=
 =?utf-8?B?dDdGNUFMeWU0bXhiNlFSZG9WcVA0RTZET24zYzFSKzNmcXo2SC96d2FjK2Vy?=
 =?utf-8?B?TWJBa1JmaEhPNjZac2tZekJwaFh4ZFBvS2V2TEZGK3kwa0NNaFpUc3d2YXQ3?=
 =?utf-8?B?bHRsRGl5SktoSHhzT0d3YTU5aGl2UHFQZDk1eGEwWTNQTG1hUkZCN2YyeFFv?=
 =?utf-8?B?bzVSVGRhb1REdUd4NEtCZHdLNXVENzJzdTl2eDg5UXhrZ0o3MGNSWnVaUkUz?=
 =?utf-8?B?Qm5JcE1Bd2xQVi82MzJnSVp2bDE0THVPUXEyT3BjL0JQTVBJVTAwUzZkMmJC?=
 =?utf-8?B?dUF0UjJicXA5UjNtQkhwRi9aS2ppbVN3RVAwTFA1Ny9pUXRyVnNxUUpQaVZ4?=
 =?utf-8?B?dzF2M1pRWU8ycS9iWmRYeGpiL25HeDBxc1N4VlhRNXVKWHNaei95RnRINnpo?=
 =?utf-8?B?YmFvdWlrY2pJMU9yKzJYRllZcWhaUk9ZQjE0K3NHQ3E5NHJQNS96UnJFaElh?=
 =?utf-8?B?WWM1YmhoY0RIcTlDeUZVdUNwNlZySkFCRFRiZlVpQVNqUVp6TExwUzdVSm1z?=
 =?utf-8?B?RDJ5dzVuU0ZmeFh1dmZORThRajk5VHJsSG1RRW5QaHd5dVNkckw4UVorS3JW?=
 =?utf-8?Q?NSPUTRhWLnUmDf4Hah3En8g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jL5EXPMwlS9cN4+JjzcDDxw3GLhtYJ3Q06/PRDwC+BmVMPQB7go75y3MkxKHLtoXPmYJFqNekh+3fxeCzc/gfZl3x/pbjS8cDIJEngpRz0lmHjNsInexFYyig6BTc8q89/s8b9q3gLDcGtVGcnjD9maDa7C0MMKASNdkRsBRPa5m8RglPNrHOCxjMwqWq7ufrvmDrVwOc5yjqlZMrAyOPMqMUlbFscXIolyqAwjZGukF4jcDzKCy81K0rODRWheY9F0aozfmUX4ZcFgNbNGUKQ69dwJNIA5FupzsWYJ/6DO4DwiTf7DiMhATPj+MXtM6t7x87qgOuTs1CW0NJfSraAfdFs4JUJ5pQFmbuWCJzi71+o/KGP7nh6m+BPbvc/BeDtbdy0XbQzXkPYiQaVpFUj+LU0/ndBrm6P/rjV7haANyMd2VXthDs3ya0MntFTH/zDRksUOf01QWMewuVkzyyQKFLQHi19tW97yWc5vqrXf9HKmK5qT01ndZfhvCgmBWAg6hm+7rStp0YyhdEo2/pdgo2evypxKhy4DFDkgi92JjEAsgb3zX+CHYnVDsrwiscnuEXiPlUDrVsQJ4rh3MusY1Cr/PbVD0AX2nywSCBdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f939e152-46a0-4594-b561-08dc60554ace
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:44:22.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBOzF+bqIgPN/exjQS87CHOvWda1O9QxU3b9rrYYrUIpGVyTL/OM+b1ATL2x1akNhmkhN8Rou3RF54uwSrJScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_07,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190071
X-Proofpoint-ORIG-GUID: -BhO_tOuBEWCPAwKa6nq0yTZ-EciCuMK
X-Proofpoint-GUID: -BhO_tOuBEWCPAwKa6nq0yTZ-EciCuMK

On 19/04/2024 01:06, Andrii Nakryiko wrote:
> On Tue, Apr 16, 2024 at 7:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Specifying --btf_features=all enables all supported BTF features.
>> However there are some features that are non-standard, so we should
>> support a way to use them in --btf_features but not participate in
>> the set of features enabled by "--btf_features=all".  As part of this,
>> also support all used in a list of --btf_features, i.e.
>>
>> --btf_features=all,nonstandard_feature
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 |  2 +-
>>  pahole.c           | 36 +++++++++++++++++++++++-------------
>>  2 files changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 2be165d..2c08e97 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
>>
>>  .TP
>>  .B \-\-btf_features=FEATURE_LIST
>> -Encode BTF using the specified feature list, or specify 'all' for all features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported features are
>> +Encode BTF using the specified feature list, or specify 'all' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
>>
>>  .nf
>>         encode_force       Ignore invalid symbols when encoding BTF; for example
>> diff --git a/pahole.c b/pahole.c
>> index 77772bb..890ef81 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1266,23 +1266,26 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>   * BTF encoding apply; we encode type/decl tags, do not encode
>>   * floats, etc.  This ensures backwards compatibility.
>>   */
>> -#define BTF_FEATURE(name, alias, default_value)                        \
>> -       { #name, #alias, &conf_load.alias, default_value }
>> +#define BTF_FEATURE(name, alias, default_value, enable_for_all)                \
>> +       { #name, #alias, &conf_load.alias, default_value, enable_for_all }
>>
>>  struct btf_feature {
>>         const char      *name;
>>         const char      *option_alias;
>>         bool            *conf_value;
>>         bool            default_value;
>> +       bool            enable_for_all; /* some nonstandard features may not
>> +                                        * be enabled for --btf_features=all
>> +                                        */
>>  } btf_features[] = {
>> -       BTF_FEATURE(encode_force, btf_encode_force, false),
>> -       BTF_FEATURE(var, skip_encoding_btf_vars, true),
>> -       BTF_FEATURE(float, btf_gen_floats, false),
>> -       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>> -       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> -       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>> -       BTF_FEATURE(optimized_func, btf_gen_optimized, false),
>> -       BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
>> +       BTF_FEATURE(encode_force, btf_encode_force, false, true),
>> +       BTF_FEATURE(var, skip_encoding_btf_vars, true, true),
>> +       BTF_FEATURE(float, btf_gen_floats, false, true),
>> +       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true, true),
>> +       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true, true),
>> +       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
>> +       BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
>> +       BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
>>  };
> 
> maybe keep those special features in a separate array instead?
> 

yeah, maybe that or have BTF_STANDARD_FEATURE() and BTF_EXTRA_FEATURE()
macros to clarify the difference.

> it is kind of weird to see --btf_features=all,and_then_some, maybe it
> makes sense to have --btf_extras or something for those?
>

yeah, the "all" is a problem. Arnaldo and I talked a bit about using
"default" or "standard" instead of "all"; the problem with default is
that there's already a notion of default BTF values - these are the ones
we get without specifying any --btf_features or other BTF-related flags.

Having an "extras" feature option (drawing from a separate option array)
as you suggest might be a cleaner way to make this distinction. What do
others think?

>>
>>  #define BTF_MAX_FEATURE_STR    1024
>> @@ -1350,8 +1353,10 @@ static void parse_btf_features(const char *features, bool strict)
>>         if (strcmp(features, "all") == 0) {
>>                 int i;
>>
>> -               for (i = 0; i < ARRAY_SIZE(btf_features); i++)
>> -                       enable_btf_feature(&btf_features[i]);
>> +               for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>> +                       if (btf_features[i].enable_for_all)
>> +                               enable_btf_feature(&btf_features[i]);
>> +               }
>>                 return;
>>         }
>>
>> @@ -1361,7 +1366,12 @@ static void parse_btf_features(const char *features, bool strict)
>>                 struct btf_feature *feature = find_btf_feature(feature_name);
>>
>>                 if (!feature) {
>> -                       if (strict) {
>> +                       /* --btf_features=all,nonstandard_feature should be
>> +                        * allowed.
>> +                        */
>> +                       if (strcmp(feature_name, "all") == 0) {
>> +                               parse_btf_features(feature_name, strict);
>> +                       } else if (strict) {
>>                                 fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
>>                                         feature_name, features);
>>                                 show_supported_btf_features(stderr);
>> --
>> 2.39.3
>>
>>

