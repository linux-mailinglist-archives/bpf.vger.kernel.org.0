Return-Path: <bpf+bounces-76732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3867CC4A3A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B140D3012761
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908030AACC;
	Tue, 16 Dec 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bq6oJCnn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N1drV3tZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBB32C95D
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905833; cv=fail; b=VAGgB+cfilvhf+3CCX7WZemuoiBvtlTL2Hj4dL6b08+H66aTGyniew1D+OdFaXr+MhwUmeVsjzMAlgLicUo5TePok/AQxVw83V1a04ehCT45OcK5jgXGHAMu5sOe00Ic8oW0kvQEjoPaHO8ceTABqBiurNSXj1qSckn9WDskfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905833; c=relaxed/simple;
	bh=00OiR0lnXdT80bnCFmljx8yw4nSEcN2SSupqcRbd46g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YGviAbDXhEocrWkz84wK3Pd8SG/MAQZ7ibDfWpe54J6CzQNUEju7z/BX3OfWGqVq+qeB8Qoyuf00TrbZ2rlvFHyQEyg16CF4sPHjDW5V7zEpoZ45CbrYHM7wFu2NP22zkbiDPgHH+mrVk8paZZngQjBZ7QB0pvE/eotCPARvDFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bq6oJCnn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N1drV3tZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDvPMi476928;
	Tue, 16 Dec 2025 17:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2cvpFBjEgMa8gnKWSvh1OziA6YJqM28j9aAUqVkUl44=; b=
	Bq6oJCnnJEqPPIN9ObqR5UstrRVMQ6CaXNFNEDLZv7Gou1dcfmUKzPfBAOV9QY/Z
	b9m5uMxBg6wQd8whpDFOdKMZI8E9h6R1Cv3On5SwVweg7MtVUiTEhdTzZ+vfQk1n
	cHDsgxOorMuCVvCUoGmmdQo/Z6RWR0WxWi8W52preeMDVabxXlDCG0vygDg5lhEO
	+ZsmqYv4PobdiljHsMhi94hCrh8crppfp04Xg1/baLvudEtQuZJD5bQLtBB0wR15
	S5pn2DiLgyvdS592QKfIrzpnJt0NxEaDruum/g3k0O95Owoqa7qYxgiGuPMKIPTg
	OYSLktKtqz4bRzfHVu5brQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx2cavc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:23:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGHAEnk022507;
	Tue, 16 Dec 2025 17:23:35 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkkha7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbrtaXmnp1IjM/y24n8W7RN7PSDDEX8XFqjqs4j5sTrUuAYKsrpQ651/khdjj26vB4mJJoHbhVfkxjSrAWHPm4xCzPQIzNP/hXGg5PYJltdVLVqLaE7F//tIb21qemkQpl8TQynfTf10YuOOMUJiU1Ehe7Xrhu/dXnMeVxWxcW5dtLDFN6BgPqdoVQOjfaKbLYKGT3lCPztFdjUQcD+IrUOHPTidqGNAN8NmkbXTjNDZUysGlwtZrX4MT4UkncCuUR+73E7Fh7SC8Elr7J5zuA+ID6dC52e9wEk+9aAJznpEPe7MCt3F1j/K+2uCgd7aOmTyLIqrE6+r6ixPYPxAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cvpFBjEgMa8gnKWSvh1OziA6YJqM28j9aAUqVkUl44=;
 b=rTSFKm3dwOSk0XfZ9+1Ob8OVZv60I6BrXet5k7VBSz2H2nhq+svmr72qCxphcdmRgLixyi2Jem1pbvhEa5MaoLSs/jC+Hu1YPKXli15zjrDw4MLKzKN8za7o8KoN8D2wiJ+jz0p+Zgs8b+jvyElrKiPIvapAXmXUzbLRtJEFCnsAoX/GGtCAXqdp1JWyzIW4AXQFr+S7AvBol3HkodOzgweE15U6f6kbcPfUOQ+W6ke8bWieoDKYKxbz+YvrO5yYmUdHb1ye64QPQkb6pFJ+uOldZYmMk4ZKIijWqvMV3YnO8r2Jz5ZQ2zxRkywvbdOD4i5FWkzWB/m933xyQ9OfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cvpFBjEgMa8gnKWSvh1OziA6YJqM28j9aAUqVkUl44=;
 b=N1drV3tZHibKSbDh5VxlMpECZ0mW11f3szKsMvOE1WMrQyFTA7ksvVgoOE11IzMAZ7LSbyb3wHOPl3GUNNcE2+olP5OUz7epmlunxhZBSgcCNAXeYwyN42sWgUqApLwqMmECPYTL34jaA+cpjf2hFQ3FV6gjvTtutq6ZqdtlTZ4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 17:23:33 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 17:23:32 +0000
Message-ID: <b56348b0-3c62-445c-9ef9-f5e1ef6d35cc@oracle.com>
Date: Tue, 16 Dec 2025 17:23:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: fms-extensions and bpf
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
        bpf <bpf@vger.kernel.org>
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
 <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
 <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
 <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com>
 <af630740-eada-4a2b-8846-3d1a17f198f4@oracle.com>
 <CAPhsuW5P7Ska9e+vWt3emuW8m5PXbbzmNsFT3Gj_VhrUSkrozQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAPhsuW5P7Ska9e+vWt3emuW8m5PXbbzmNsFT3Gj_VhrUSkrozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2823f1f2-120b-41f4-86d7-08de3cc7d600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG1BWmNMNEZ4NFV0V0cxOHdoVGVid05JNElwL0NkV2VtTStxczhXc0djRXZx?=
 =?utf-8?B?MFhZdEMwcmVWRVRxUkJWVHdwdTRvU0cwOUFqQzRhMDN6MjZJWlA2OTUwSXBG?=
 =?utf-8?B?NXhFY2laVmwybmJNUTYveE9xbEN4TkgybVl4Q3RjSlFwZU5RRFVpZUFCbDBw?=
 =?utf-8?B?MUgvWWEvdjJmbWdTU0c4MkVpckNvemxySTVWc1RHd3gybmwrdXhTUEx5VFBT?=
 =?utf-8?B?V1c1NW1EeG1URGlsWXVkZ2JESHRqbzl6SVB5TkJjT0ZVRkZTMW9aZy9scWpS?=
 =?utf-8?B?U2lONmVpeTRZY0hqbHJJSTJsdVNOZjVRdTZQSk9IMHFwS1ZSdjhTdlN2R0hi?=
 =?utf-8?B?MmszVm5rcUFiNDZ4cmdxZTd2dkdxMkRPWkdqQlJiekpsbTlNd29RVEZrRGxY?=
 =?utf-8?B?NmYyc1JEc2ovZStIOW9URnR0d2hXRXJMYmxXUXpHL3VLTXI4enl0RTczTUpk?=
 =?utf-8?B?eHRmUWZCN3dpVE4wTDZoanlKbUlDSGd0eWVWZUZhV1prN3F6Q3hoaENuWVlS?=
 =?utf-8?B?MmkxTDBSVUxycUZMa1dNTG55eVRFZTFTWVgzK3lwU3ZzSzNPUnJBaWdTOHpW?=
 =?utf-8?B?SE9LOThBSTh6M0x0L3VSclM1U2k1bE1sdDVWT3N6UEJ4RDRGWjR3cWdpWU5p?=
 =?utf-8?B?QVlUVDJvZG5iS3NXQjNiNlcvdnhZMmw5eWF2RTViV1YvSXNTRlozZ3hpa1hK?=
 =?utf-8?B?R0VTMkIzeWc3cVNTaGsraHRZeGhLb1JjRDZXenNKQUoybkxJU2pPc1lkLzVP?=
 =?utf-8?B?cHhzU0R0UWRtbnVYS1JucWgyYUxrR1IwODlMTXZ0N2IxOEhUcDVObzB1Y3RI?=
 =?utf-8?B?OW03V2kyVTdackZkTVhMSEQ2bGt0clpIWW05eDdkT1l4Vmt4NEtYMER4bUFx?=
 =?utf-8?B?bVpJeXhWcndlWFJEa3BXNTJkV2wrNVF6VEhBcWVLaEppZ2QrSkw2QS8wQ1dk?=
 =?utf-8?B?eXNzSjhaUER5U3ZPNkR6ZStPV1hBbTNWN3UrUkJXYzJzREoxWmhKZm1icXk1?=
 =?utf-8?B?RUpaZ1dGMkh5VHR0RmFNWkJ2YnRsNG5OaG8rRXcvQ3k3bS85WEJvRXk1YzAy?=
 =?utf-8?B?OXNybExmeEdoOVlUaWVuazc5NFhwMDB6dWxYa0lTdTE2NmxzQ1FhZnc3REpw?=
 =?utf-8?B?WUVXTkh4R0JwSVJXd0RncGdHQk44SDRTZkMzekdKSlJ3eUpKclR2SEh1djJ4?=
 =?utf-8?B?aFI5R3BTNUE1TXlaeTRsUGZXN0M5bUwzWlBTblkyZXlGTFQwSXhxL1AxSkFq?=
 =?utf-8?B?a0k1OXU0TDUwdTB5SUY4RXZtSXF3YTRSTGdSTm4zZlhHbVY4N1lSTnB0YlRo?=
 =?utf-8?B?dDI5QkR3bGY0eGNRRjlIeVI4VjBXWTZaUmw1YzFueW5rcEZGZytMOEhqQmZq?=
 =?utf-8?B?M2ZieXRvUzNkV213UkNJcXVsUUU5V1BqMlgwd0NhQ2RHOW9MSGFabWlwNkZi?=
 =?utf-8?B?S2I5aXQ4OHIzWmIwOU9LRzJXSHJ1UURTY1orR081VmxxVmovczNRQ3Blb2ox?=
 =?utf-8?B?UXBqb0daNXcvWmtsRmVzQWk0LzIydzFYWW1GUUhGOUU4clZ1N3FmUTc5OFNG?=
 =?utf-8?B?dCtkV0F6cUZtZUtDY0gyUVZCRHBhd3F4ZjUxbWNyVmpQUW9IdnBNNVdOMDZP?=
 =?utf-8?B?b0xzaS84eDNHWDQ0cEN2UThOVkFDNTRPR1hyWVdhNGlpUDFvekwvZGROeEM5?=
 =?utf-8?B?MUkwdnFHSy9CVW1xV254MmgzaHJFVUdUUFNKZ0Y2N1pFSUhWTmF2SjFtYkZy?=
 =?utf-8?B?K2dJZUpPdTdRZGliQ2Ivb2x6SmpXSEtyZ2hBUEJkalRlbVBpd1ltNmlsMDVR?=
 =?utf-8?B?VXFxWUJIU2RRK3JPK3B4RGx6dmh1SXlEOHRBQXE4cmI3dUFNby96NGRDTWxE?=
 =?utf-8?B?TGJ3MXI0RlVnaXAzakdhQUFDalZ2L28rYnYvMFByZ3lEQ0w4MXlQaUw4Tllh?=
 =?utf-8?B?MHdJMXo2ZXRIdEZCOE5DNE9JMXZaRnFpZjRIWHVLcWNzYXlOR25lcW13cmJE?=
 =?utf-8?B?V3lBNlBhQXJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdGUkdKUnRxdjhGUmI3TVp1dU5nUzJtWElHMnhGeGsvRHNvMEVTVmpiNHRa?=
 =?utf-8?B?eldROEFJaEtOblFyOGNOa0szZmNERGQyT2prTUFaZzBwWUw3bk5jdWxDc0ZL?=
 =?utf-8?B?RjBoSStjRjlFODN2U2k5MGhxYkZETDFsQkYzS2xVakhzZGI1K01JTS8vYkhC?=
 =?utf-8?B?ektrQXNPZ1FHTmN1STZtR1RzSVNOT2F2ckxYcENmYkRuWXYrVHMzMlhIc3l0?=
 =?utf-8?B?NDBHbHRLOHJiZTE5eWd3Zng4K3FnaFRtNldJWUR5d1JRRjkzVm5UOXdodDJT?=
 =?utf-8?B?emRrN2tJNEhRVVU1bjcwNEM3a0N0MXpmbExvcEVpeFRRQWJwakNWREFwbk1x?=
 =?utf-8?B?TW4ySVFYTEszdWhsSEN6b0lxcHJmWlhvancwL2JUMU12Y0RrY3A4MUhXY2F6?=
 =?utf-8?B?QkprbFM5NmVzajRaWHlPdGxlR21jak9oUkdzNzlKc1hLYnpqSEZMVDV1VkFE?=
 =?utf-8?B?MlR1NDZHdWJmSmZPUnVENVllZUYyNDJhSnZXTjk2bzF6U1lwVzB5eUN4WUox?=
 =?utf-8?B?QTVKdzJQRFcrWlI1MHNuWFV3azhHd2s0NDlTcHUrUWNxcHpLNUF6VTVyUXgr?=
 =?utf-8?B?Ky9GbVFkeURpRVRESEpHK3prMVBNUEprbjJ2WCtQREJXSHZwUnBIcjdENVcw?=
 =?utf-8?B?TnFxRDlkQ0VFWjJ3anQyRXVtWCtQZkdEK3lNbnc1UW54Sm5UMXorQ3BtUk55?=
 =?utf-8?B?azlYb1gyaVM0VkpldFM2NGtUQVJkVmN3QWQzbUo2WW9YeDkvamhBamNHaEUx?=
 =?utf-8?B?cTM1akFxenpZL0xYRzQ1d0FsblRrbHVFcEQ1bmwzbFFPejNnUG5iaXEvQ2k3?=
 =?utf-8?B?d21Fc2U3YmJGbjFPMm9vQnh5TUdNZWlMSlh3cXBkMytrYkg0S2lEU25pSXFj?=
 =?utf-8?B?UHdMcXEyWm5nVG13cXhHdkg2Z0g3aUpQMFVaZEpXanJZaWxIWXluT0RsYklv?=
 =?utf-8?B?L1pESkljVmREN24vZUFZdDh3VUFVL3Q3L2VKbkhkSEVSZS8vT2psNEc5OG1M?=
 =?utf-8?B?MEhaTk4yeWk1cFR6ZjJSVGhkZlUwSmN3d0Z4cE01SG9iQzJ4UFMvLzBGKzJD?=
 =?utf-8?B?M1VyOXp3MkZsemJoc2dXSCtiVFloYXAyTENqYVU1WlE3d3Q5Uy9odEdseGJF?=
 =?utf-8?B?d3JXZHVDV2ZFcTYrRFZieFFJNXE0Z1FodFR1M1ZDcExYUCtnTjVxSUxsT2Jt?=
 =?utf-8?B?L2cvcUNLQUd1UndLei8reGFLZi9BdFRpVE1FMTYrVUpvNXRqYmY0QkNoang1?=
 =?utf-8?B?d3dscEdBTWxkSzA5Z0E2MUxPRi9nbnhCdFIycG14SzFjbSs0dGFVT09ZUDJT?=
 =?utf-8?B?eXR4Z2N0OVp3elQ3UEFSWE1VbklwTlI0NWt6YUt3VmJQOW9xYkQrZi9aeUFw?=
 =?utf-8?B?N1U1UFBUNmhuZUV2elhBc0kvN1d0ZTVKTzJsV1lTUm5hZEVnZEdIQUNod2x1?=
 =?utf-8?B?eGtiYURqRkdsaWZ1elNUdnNsazdXMTF5MmlHQ0tlanBJVHh0Z1VGUURkcE1B?=
 =?utf-8?B?ek5SS1ZOTTYwQTEyZzg1RXJaR1Bia0wzcmViOStYeHQyM1YvbmQwa3hIMDVm?=
 =?utf-8?B?d3R6ZHBTZEhQOHpVcWdPNGZOS0pTaTNKZWJ4VW1aYXo0OFBBVE9HL1h4NmRC?=
 =?utf-8?B?d25QN2FqMFpVZnd0MmN1ZDJBTjBYZGk4ZFFUVmsrRUl3M2cwWXNMb3pwUWo1?=
 =?utf-8?B?eVI2NWhqZmw4UEwwZnJEZnZsdUh6VFlxQk83V3drcjYwVXBtWkNVUEQ1a0ll?=
 =?utf-8?B?K1N1Q0JsUWp0WEFjRnFQKzVOK3VPUHZ5WkNiQnRwdkNFOTdWMFRFdVQ4VmM5?=
 =?utf-8?B?VXZKd0hqVSs5YUZGMXdCMnVXUnBQYXovbE9UWnBZQ3NXc1lVaUZvektOd1Br?=
 =?utf-8?B?SVVJUFc1b0FpV2lPclg0QWlTM2YzOGU0VFVQMVdHU2tQaFZyU0F2bGl6ZzJa?=
 =?utf-8?B?QVRSQzRpQ0sydG5TelMzbnU1ZmFYRjJZbTd2QVJQTC81UHB4L2JMelBFdlpC?=
 =?utf-8?B?NDRxUENiaUJ1YzdwUVZsUEd5VExrMjRZYmdpSHA0VVQ0NGpCODVxTXIxc1Rx?=
 =?utf-8?B?akhtemt0ZDVWT2owUlVjamRVaGl4MlJDdmVHR25zUzBQQjZQc3pVS0FxQXVF?=
 =?utf-8?B?cmp3TkMzak1kcjFRWDVzNTQ5NHRqampscW5LcEVpa0lpZFd1aUcvSFgvY2NR?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SSuGNJGdeQw6koNxZbi/NTZwi7rcUhbKjUssKcfBvMIZG5/NEnP9r1ryIt79bAZ4Z+cQ8TsJPr7U0Y6opQ37rzz109MLHBoyiiS/XYtwiGPhRD9FR2wncWcnMWaVlN29uI2btqkwBsGQu5Cel7mNqqSQrBjHdKWrPRTMqUdRnTJ2006BsGa6FQNlayfVQDGo49BbWQy6H0/VNOr+dnx+mzrK2yy+pvVR7T4VdJXa8y5Blv+YxBOCu5bade8LZNM3m7rLTe3C5hB4kUbZuzMWRQW+jAuu3p1Yhk8gUQM1F0tuAcpVUcaOgPv5TZou0yoisBPMK+WjRRufjq5sE5P5hFcn1sfM31oRS5uxQuaRCWZ1hE/FWstf5hw5b2q/amBeFs38ukiV5rKDJFc7HxRiph3iBVjgtNL4yYzDBpatnmCsDQhjDsFWad9IPmmEbYp4u8OQ9TXX5q0vBleJ4hsJ83X90O+nWyu4OQTO2q4ySSbaD32PC2cmKii7hhmxBAzXqSzC2z2J8YctS1VfjdAZEs0TFi6aFz5LDFxqhzHH7GSa9a00U89lHhfH/ss5o6Zd0jmYJSEL46rZoUiU4vw4H0WuwJwp1a5KBSBPUN1ZWJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2823f1f2-120b-41f4-86d7-08de3cc7d600
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:23:32.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBD8ttpcRVIlxeGNMdnILjLKqGfPJRQQuHPlwAyFTwDX18z/NWVCS/13dPEzWtZvzoM02ctTxW3JEP4J/+DnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160149
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=69419598 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=F1-fGAgkbj3pA5WiLiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: lRyUOPDpAkZ-bn7uKDNYwYHBzF246zBx
X-Proofpoint-GUID: lRyUOPDpAkZ-bn7uKDNYwYHBzF246zBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0OSBTYWx0ZWRfX+2DuJUWq22W8
 /MkMaKmma5whrqOlAfjYllJeXBBR0CH7TBsExzCDzAOmBmY4YTTK5/a7Qvtr1/58wIvYw+MVPT8
 lvNdG+zIMIaUHLBY9ptExDyvXa0xS8RdTfZJMDrIOuDpPZl675PCVaaCyLYaaWKca0NI+/ScZiO
 2sCBZ9WCD1liOWH20fe88P4i3US/M34O2UuFeifLd+VMXaL0fmE5G4jz8RNjw7Ag04xYAlwdsFh
 3CYWewLLo6N6JjjPyLMr9hLM9qJDmTKXjCdpVAPrq7OKHhzP80VpaizfIqQTvQVB9Y9JDQGsz2s
 21PeIi+VldXVdxRmwemsaS5uvI+z+CPYpPF3x2o+2Voql4PlMLxGzyXZMoV1y0Y4sgcjLBJ/prk
 TYB8Ky6fyybg3CNQI2G/ZxO8fMN6jwRho1eJgasMGTihjZhyqQg=

On 16/12/2025 16:52, Song Liu wrote:
> On Tue, Dec 16, 2025 at 5:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> [...]
>> i.e. the embedded struct ns_tree is anonymized.
>>
>> So we end up preserving type access, size etc; the only thing missing is
>> the name for the nested "struct ns_tree". We could add an option to bpftool
>> to relax this restriction if needed for users specifying -fms-extension.
>>
>> Not sure though if this might create any issues for CO-RE accesses to the
>> fields? i.e. does the fact that the vmlinux.h representation diverges from
>> the actual BTF have any subtle implications? I don't think so but just in case..
>>
>> I have a working patch for the above which I can send out if it sounds like the
>> right approach. Thanks!
> 
> This feels like the best option to keep backward compatibility. Please send
> the patch so we can test and discuss more.
> 

Sure; sent [1]. Thanks!

Alan

[1] https://lore.kernel.org/bpf/20251216171854.2291424-1-alan.maguire@oracle.com/

