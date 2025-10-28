Return-Path: <bpf+bounces-72513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EAC1411A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791D4198102D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF53064AB;
	Tue, 28 Oct 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfuY7sr7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Va7Gwx+q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2D302177;
	Tue, 28 Oct 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646836; cv=fail; b=qdmTeiPjJiteU1NlLak5m8pdOCu93WaZne1GfH2x+Ixm32C5fNjwCOywG23gsY4IH9RV1GpVEBelHbk1fMb2NvQhf0or98Et0Nzz4KV9UkfK77yCOkqEtYxXFRZc/SbB9rsmNfcf2eM07i1f52LeMA9bYclKXIHhxijLYl7QmUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646836; c=relaxed/simple;
	bh=n9i5xgO/BtuGzPB5HiptfL0zYdZaN8BOpbnFXhQWWw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOq9oRO/EHFyDiB/RYg9BUFBKLTNMKvhOfjV6cNZHWuZeOolYB05YCpVzztnbAAn2gXwlBMKTW5cg2BAIBFbYLgwTSDVmlz45IIz2k7OM2XYoEjAh3DLHLHZmJy/9kGPNHQ9xNuUi+Gwp1LiP9IR2B3EYM1Pi7ReGa1HtXDXne8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfuY7sr7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Va7Gwx+q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NQiP010387;
	Tue, 28 Oct 2025 10:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8l9SelW6qO/FkNGrBO3mZSikQRTQ8bMfkKoza5kBFNk=; b=
	FfuY7sr7cwgigNzAYmAOZAwDgzLoEneYFDhBmLDUcB0t7bNMxEyqLKft+NO3ZNaW
	KxQI5Pls35hkJclA4OhfO7J2U6Wt1MIgEdWd2sAY1Wb4taw5raC3L6s4tvoRLskh
	RKgrh263QFGqTi/HZVLfJiTM5a4vZJb46W1B0pRzBAt7c9BpE2/5CxjU+4p/yAis
	gfd/MBKiKvg3E2knjzMznLkUoZv8X8qgGUYgXKYCVQB+/Lc932ZlfLHk8KBxXNcl
	slUYJF8VfKuSQsKRX8CeZrqWo46Fp2D+bG70U8432/5XUt/9gyfpUt3vNq5emixj
	qgaD3PQ1rozRwck6kean0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uub5py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:20:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S92kj7037551;
	Tue, 28 Oct 2025 10:20:30 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n080mna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agJ+nxhsPTzIl4UILt/lqiZdvzDKkqK303NFwQ/RZy2bqqHABX6VQsVLvAk1A5WLbxwSCTXUWPEkC6nb3tD7iW5QlfyvVWH1GWh7tFQCF/sIOQ/KKLopThunA729zao3WluLugEFlnWtHG8Psgz9nv35cZKib3iCSCymFEUEbY6V9KqBbQyy7NIjN274VFHGo6490qKDk89sLVsSHnq0GnamDGG0nCajDuV2uAevp4doSphpEq8MhfumdiEm+wyibA5EBXyG29ADTvSSqjHF7cAfi2ODbquQKbfxsmPj3UJRTaOziaZzjUjT0oBc7WuKj5uum6YiTtyQ03RxOOZXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l9SelW6qO/FkNGrBO3mZSikQRTQ8bMfkKoza5kBFNk=;
 b=cxT+0PBhF70P9xpRQPjZG/pxYbTaXv6kq2+Aif2iIa6OEHIzFGnWjDJhvUal08A60t/sGndPJzjOQ4Y8NZd1wZGOCm7cr1A9w0/SXbHBtdNEdQa15XF6gR9u2ILMUbq8axMjeOgH4Doe1yyKQOzzNJ8u55TzV91GsT8buwR02TTTtQgejQs9UGTyYEBJ6b14NQ57uqUBEEeUD6EzJr4NzHwMVrjTfIzGwiXIxcmb63512WrbMYcWEKxsnSAf3SZxKRN1UDJco4JPw4KAjcb54CpBe5vmiSw3KnWr4Eh+LgM2FV5Ll80rK+hJv59f+WML7N4npOwKCLEUbpR08ITTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l9SelW6qO/FkNGrBO3mZSikQRTQ8bMfkKoza5kBFNk=;
 b=Va7Gwx+qEndd8i0hTXxGwh8rEg/WDSghl7QKuWzKgJ+ORxNgOPBxC0zTDsY3y9I7HgnoM1wmfpqXcAW/RLFk2FgyOXgWSAkRD8uKoV96wfjuUpRAdjEJbOF2k22NOjxnv7kkAURBNDpRYG4Uwx39cc0uUct8VPE3sd91R8iMLzc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 10:20:27 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:20:27 +0000
Message-ID: <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>
Date: Tue, 28 Oct 2025 10:20:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
To: Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9843887d-1570-4ca9-d54c-08de160b9d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MytQTFU1S2svamc4bFVOVzl0dENWMUExWkdmeExORUkrNnpkSGpPd0oxUzIx?=
 =?utf-8?B?b3d3SzFVaUpURG93NWpsK3FmZ2EvNFUzeVhRNFVkbDNhd0VUYVZGSUQxdHVY?=
 =?utf-8?B?Q3RHUWx2eDRDVzY4d3ZNSjQ1TC9sa0lFTFRMeHIwYmlYNzFxSURsc1Q5UGxm?=
 =?utf-8?B?SFpkU0d5V1lzNk14S2ttUzNxTXhLZElCSE14OFlDRkJGQURFdk9lSnRVQnB1?=
 =?utf-8?B?Q1hOVm43TEZQN0JkRWJoeWkwZUhaZEFGRzB6RVI5Y0NuMGVoWXU5Q25BNmdy?=
 =?utf-8?B?aWxSanh4S2JoV0ZKcldTbFNWL3g0czJ1Qk1Xd01ZQ1p6RTkrR0o4K0JZYXZo?=
 =?utf-8?B?ZVFFaXFUd1lJZGl1c1dRb2Y3ODZQMjBuUnpTVkFVNVY3dTRmWjNDSFcvb0Mr?=
 =?utf-8?B?VDl6YVd0T3pCSG0xclAwZFBvRFdiOGtnVXhyYjhzWnJVQVIzTFd1bzBCQitR?=
 =?utf-8?B?cTFEQTViMGI1am02TTkwYlRhVE4rZFRlYkYremQyclRRMVkxNkNYSEJFVita?=
 =?utf-8?B?dTVOT3F2VG9iNzExV2ltRkZIOXFVVjNCTnhOeUVJRURDSnJpY0R0Q2x5OFE1?=
 =?utf-8?B?ZnppUUZuRVNqdkdpU1ZPTzBybjJSVXAzQ3lURDlXM0tpR2IyVFppN3ljVUwx?=
 =?utf-8?B?Z3BSMVJmcTZtMUxQeXlSRHdTREtHK1B0dnRQdW1yV3R1N1NzMnJSYlVYd1c3?=
 =?utf-8?B?ajNBVUJsM2JaT0E5UWE3Rk5Ta1l1ejdZL1lJSVN5emhlMUlvTC9OYm41SEkz?=
 =?utf-8?B?VWV2cnlNc1diWVUvbHEyNU9rNVE3V1NXUlgwV3k2TU95a0g4UjZSNGVtaWFK?=
 =?utf-8?B?Um9vZDl5eS9nVmhndWtQT2RHemJvRURUNGZ2Tm9YLzcwTUtHbmx2eVlBMVFw?=
 =?utf-8?B?S2d5TmcyaTdXNnZJOUxCMnpuVUdINjVFK2I1KzhwUWE4Ukl4Nkt5dkFaOU9P?=
 =?utf-8?B?ZmVqNCtaczZDa2c5ejVURk5KUlN0RWw5cGJwcS8xVW5JcTZRSW53anVEeHly?=
 =?utf-8?B?dEhzSDhuK01KalMrMWZPS0tOaGE1aTBBb2I3VGRoQnBSVTlwUHFJZlFqTksx?=
 =?utf-8?B?bWIzZm82SkpaYk9FVW9zWGdhN0podXhJMHNsOVRDZmt0ZlVtUkdFay95UWo4?=
 =?utf-8?B?clUxQ1RKVW9oTy9DMFg2L2ZYY3UrMnNGQUpBZXc1b24yVml6eVlEMW5tY0xQ?=
 =?utf-8?B?eW1rTlZyd2ZKTkVwQWs5NmdYRlg0NEZQRnpHd0UvaC9UTE1qVUk5WS9SS0p5?=
 =?utf-8?B?bktHSEJlUFhGcy9xdW5XMUxwdTVPVUZrQW5mcHVycVdXSHpRbmZ3NERQd2pO?=
 =?utf-8?B?VDBmR2FKLy9KNlpUdDF0N0pNN21jOSsvbVhrcUt2RVREL05hWTkwQ3hLMlBD?=
 =?utf-8?B?OG5PZ0I5TG1XZW4yWUFXc1hjVyt1aHp2Y3ZlZUprMnBkMGlCSXlFYW5xeGho?=
 =?utf-8?B?V0xvTmhBTndmV0tGYXo5OGFmTVp3Tk9OWW1TWWk5MVZBZitvNGk3RnhUVXM5?=
 =?utf-8?B?eTRFaUMxQ0Nlc3FYdG0xNFd4N1EwTzIraDl3YU5BSStwTjVuT29PUHZGUmRG?=
 =?utf-8?B?UmlGSmJ6K3dSQXFxWm94MlZIVFpVSnBhM0I0aHgyT0dBdmdjZ0RRL3JmeSti?=
 =?utf-8?B?VTMwOXlYTGRVVU12MzFDZ3JyTEZ6WjlmOURnNFU0L0tqbzVMcy9OemlMREVz?=
 =?utf-8?B?N254bWpPU2VId3FLM2xqeEZNTzBEUlIvNTRwd3lnOVN1S0NiTnVwMTErQUZZ?=
 =?utf-8?B?bXFxeVlOaGNrQ1Z0bk5XeERoU3UyMktEYThFd0tOWTdJMVYveDBZK0liNk9O?=
 =?utf-8?B?ZDhiRzhEYVg4RGNUQzYraSt2ODdIdkx1V09lL0txZHhicUNLTVRKSkUxNVIv?=
 =?utf-8?B?eDZ0Vi9wZ0pJMkUwK2lpbWUzOTc0S09DdXRZSUtzb1JBWG8vaHJTQUJ1QWxV?=
 =?utf-8?Q?DHApVUL2Sguf1jV4kbrLCeEeEMDAXvap?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGorOUxKMGoxOVRESmNpK3A4dDNDNWgwY0hVKzFlSndtTFkyV2psS2RwRGJG?=
 =?utf-8?B?TnpYOWF5NE95SjVxNDFDQVVQRHRVTzkzakxnbk1LWlUxOHZqZm44ejJJd09N?=
 =?utf-8?B?ZEVkZ2JiQ1l1UVphc3FxR01JblhheC9DT3RyMHF4YURMSXp2ZWlCQjFLMGll?=
 =?utf-8?B?Y0VtR2pJWTYwajhwZ0p1WHdYdGU3N2NKc2MwcnZxUmZ4aDc1ZzM5NGQwT0NI?=
 =?utf-8?B?UGJXb1pHbDAvVW9BeGgzS2V2RXU4Mm5UbXRWMUVuWlIyZnlRc0s2YnVwYlVx?=
 =?utf-8?B?T1YwRjRVWlQwRlpSRm5kYTNqd0xiMmc2K3dRMVZWSncyRHpGSUFuYUVVazcr?=
 =?utf-8?B?bG9JOGlPTURqNHpIT2NmeEtFZVQ3bjViY09GbzdZL0ozd1poWEtmRDE3Uldp?=
 =?utf-8?B?SGVYQmhPTVZLVEc3S0tXUm5DMUQwb01NcHI4WW12VlQzZ3JObkVONUlzUDBv?=
 =?utf-8?B?TzBSRGJCS0VxenZNWjhMZVNtUHRxM1lVbFQzckVMY1ArblY3cmwzcldhaGE4?=
 =?utf-8?B?MklvU1NpYnR4NXM3ZS9IbS9rR3hpRkJieWFkYWZsckFCbWZySmc5RFgwbU1P?=
 =?utf-8?B?VWJkWjBEb2pQRW5aNktzR1ByYTZUT2R4RDc1QVN2VkNzMENmUnpPcHVRaUV4?=
 =?utf-8?B?UEZMQzhDMWRaRXBFMVB2T2xBZEc0ZVpQc2lkeklqeVpkSXc2cjVnK2p5VTNj?=
 =?utf-8?B?RFhnalNnZnhNTm1SVVVBUVRTVTJCNHdqRldEK3NkajJESjRrZzdKWlJkSGZQ?=
 =?utf-8?B?RTVwRzJ3RzlnZzh2QW5iNXl2UUM2YXJ5eml1OHkxREtYYUVTL29YM1Fsckph?=
 =?utf-8?B?YU1tSFFkR0dER2tWTGRHc3ZUOEVJV25WRVQ5SWt1UHpoaDcya1N5SFp0ZVMy?=
 =?utf-8?B?N3BuUFk0bS9xaG14VHJWdXhNWlZKd2RwajkvN3hlS0hUZi90ZmdKUkU0bnJ6?=
 =?utf-8?B?dUVDd0FVRE4weXFKSERmUnExYVpGRmJUVEQwQnd6R09TcU5YWXFYWWNIVUhH?=
 =?utf-8?B?NWxVN1ZSekp5VXBKVWc0ei8wQVlrbU0xb2t6RXRYZUJjdTlGNW53dThTOVZx?=
 =?utf-8?B?ZWhoNlMzQjdaWlZUVjREbktXVnFjNFE3MGg3MG9KTGtHQm9vc2hUQnZQWHFN?=
 =?utf-8?B?K1A5WDl2N3REd3RiUTg3ZE0xSkZKUzh6MkFKd1A1WktiTEYyUk1QZzVZOUV2?=
 =?utf-8?B?L3MrZHlIV29GYkcyemhLWndaSUJrS05mWXhwdXB1TzFROGkxYzh4STdrbnYx?=
 =?utf-8?B?Sms0QnVEeWxWdTM4SGl5a0h3OTJ3QkZ2ZG4wUWxqWEVNd2VjWE5qdnlkclph?=
 =?utf-8?B?bmUrU2hta3RzTW5SQTFYdjkrc1FFbzBhcFh3ZG1pbk5haUg4Y0pVTmZCSnVp?=
 =?utf-8?B?UytNaTkzZFY2RnVRRDduR1FEWS8zYXVqT2tSdU1INzFpVFM2VE9wTGdhQm8y?=
 =?utf-8?B?eFFoRUxqeTFjMnQvVWdaWmJQZzlyUHJzR0tGZWpmSU1FVW1lUG1oR05HaC93?=
 =?utf-8?B?U2dVSVBidk5oc0Q1RmhxQ3ozU0hFTDhzUURsc09pYVFvakt3VFJxTFdrRE5Q?=
 =?utf-8?B?MTJ3dzlZcVNkYzhBbUJlYUpBZEpYT2JOay9PWnYzdGFvN1U5MEpMNXpNMXdV?=
 =?utf-8?B?WFM1WE5xU21pelpzb1RLa1FMaXBpeE1OYi9NRXZNa1czQVJmRGFwMW1DQ1NB?=
 =?utf-8?B?Qm1mRUFHUG9GR1QyN1h3SU9tZ0RQdjc3WExsRHlIMjA2K1VFRHRqMllZTHlD?=
 =?utf-8?B?ZnhoQ3E5RUpHWnlFNkwzOU1PWUxVYWJSZTVsM1JBcEJPcEo2bUhITVNuRWRG?=
 =?utf-8?B?TG41aUZoQTJLTVQ1dTRCcFNuL242dXliNzdmSktuUDk1Zm04eDZON2RpZ3hk?=
 =?utf-8?B?TWg4RkR3RmQ4QVZ3bk9NUnpRVHdxQngzZEcyUmV5MGRsckN6Z2hyQXZmR2Ft?=
 =?utf-8?B?K1ZvZFVoOFk0UWVPNFZYSjdiTTdkSWNoZjRtTElLUkM5UCt0Y1lJYy9HeEFK?=
 =?utf-8?B?Y2ExL0xMbmF2aVpGcEZNNjhPVFZvU0ZLU1E5cFlqOWh4RVRBdnMxVjBPa0pm?=
 =?utf-8?B?QTFadDN2TWZOYW1UNE1UZHdKSlFCYUZQL2RnZVhXQU1BNlBzSWxxbWVtWVdu?=
 =?utf-8?B?M3RPbFpOQ3JFaWhxd1FBRVh5L2tNaVdmRHhRWk1zT1dTOVk4WERtYnBIRjB1?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWoZNHPnrTL2GAX3oHNbT7WwDF4ymoVfWG7XdLx6xc3awXn9lK/BI/cNAHUePTJlqjyxPsSjcGwlgIpavGvcVCFKL6ASmwVY2porIQIXdtFtecTfID8cfDGSFvefFPSwnycOhNjy/SlPetfJE7reg2uyKFEyBLueLNXBkz7L1FgWfidZSrSyvgff2Lej7Wkri5ZuhnPyxUdaNtsLmdvAyWtTJ+/Xvest4QgVxeQJIWhTP5ixqCyOK0pK+0DqnLtvqm3p2ThsHtAkUf5NP1Jkg8KZg+z8zp5CI8n3uKm+YExuW3roFxy+WDwPmVLuqwK6oFM/smDeKCEOqOXatv0RYXYHGM6SHvVS1jYCbLUTOhQBYpKBELft7pM2s4Cp1n5Gf70lHZejx4kAw0opdoW7SP0GXl4AFYDpbpzPbZ6TmmQbbv9MiywdVznZbCooIctPuljXdnNxS+7UUKKPzpZtYZC8bp//bREpHI6dEI9ZtbvE3+mwQqzIM+FSsZ+hPnKqZojLBJ8HJWpSlu7Aqil7tW6V0oCp0+rwASktzIIm2sYOBfYFSOB3tsGs5zJ+94PkWezpeGFJmXdHszYjtJzJ89fjhT8u97JPhwmfCfVTS10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9843887d-1570-4ca9-d54c-08de160b9d1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:20:27.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQYGvZBF5CtbZKEL8qRONDft7te9c8fKhClpJctTvF0EJgRVmc5vrrLTpdxLEOVmffI1Dwl4WrUAXbe+sVdhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280087
X-Proofpoint-GUID: 3mq7z2k57JlpA3bF3ak33L5iBYGOG2IE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX+0GuSqKWQRcS
 hh7vZTCWaAPgXAMhh12D/mNav2THb9YtSB6ljsz5P7CdE0/TaAeM6oSNFdiZp8RBPSTHIbQJn/o
 bk6FW0rSFq1LHi8SQLpnph9WvzdflPU2qF/koATV2VqyN3py+KnP3dmS9258652TnQdt+/3Xoo1
 dCoQOMiTMAcEXiS3DtIUnfwKQXQ7oKgkIZXxj1ZmP3trBvtPdy9j7qrcZAnTFG57HMVDtqrq+H8
 2VG2zRaNpu4GRX522EAH9A1upvYrlVkJ7x786oMCD2OaDTh2RHCiOGxuW/Qui2swEZPYX6cUZE3
 G5hYVsn+G4uuKYasnVGDL5kmttlPQ1W7x3aGzm2r71fRUxrjOjdtRetMPzmSZUXA6oYyQSmJeUL
 e3wVkqngDwD+0tsykvR1PRu1uaauLg==
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=690098ef cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=k62QnQtcJzh23fGLUSkA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: 3mq7z2k57JlpA3bF3ak33L5iBYGOG2IE

On 28/10/2025 09:05, Quentin Monnet wrote:
> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
>>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>> Hello,
>>>>
>>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
>>>> sure if it's reported already but it failed to build perf tools due to
>>>> errors in the bootstrap bpftool.
>>>>
>>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>>>>      16 | #include <openssl/opensslv.h>
>>>>         |          ^~~~~~~~~~~~~~~~~~~~
>>>>   compilation terminated.
>>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>>>>   make[3]: *** Waiting for unfinished jobs....
>>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>>>>   make: *** [Makefile:76: all] Error 2
>>>>
>>>> I think it's from the recent signing change.  I'm not familiar with
>>>> openssl but I guess there's a proper feature check for it.  Is this a
>>>> known issue?
>>>
>>>
>>> Hi Namhyung,
>>
>> Hello!
>>
>>>
>>> This looks related to the program signing change indeed, commit
>>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>> introduced a dependency on OpenSSL's development headers for bpftool.
>>> It's not gated behind a feature check. On Fedora, I think the headers
>>> come with openssl-devel, do you have this package installed?
>>
>> No I don't, but I guess it should be able to build on such systems.  Or
>> is it required for bpftool?  Anyway I feel like it should have a feature
>> check and appropriate error messages.
>>
> 
> +Cc KP
> 
> We usually have feature checks when optional features bring in new
> dependencies for bpftool, but we haven't discussed it this time. My
> understanding was that program signing is important enough that it
> should always be present in newer versions of bpftool, making OpenSSL
> one of the required dependencies going forward.
> 
> We don't currently have feature checks to tell when required
> dependencies are missing for bpftool (it's just the build failing, in
> that case). I know perf does a great job at it, we could look into it
> for bpftool, too.
>

One issue here is that some distros package openssl v3 such that the
#include files are in /usr/include/openssl3 and libraries in
/usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
figure out a feature test that handles that too?

Alan

