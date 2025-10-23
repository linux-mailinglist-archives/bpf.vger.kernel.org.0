Return-Path: <bpf+bounces-71932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A197DC01D9F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DA404E62C6
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA932D44D;
	Thu, 23 Oct 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtFAEU3F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jF6PdLVk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D574322C7F
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230284; cv=fail; b=eMp2tv7v4TI+xSPYFtuV3zxXIstRVV4A6nXonwNJNyQ+i17HUBZABEG1WE6fiQ3+iPU0PjfbhygcuXL//6vQO24RLSsB1KgoTrjocvlszj50qqj8jgDZ9Yy1miXLw2VDRoYsmw1S1F0XonUF0a066p5+3OFm2TT1ER9IkiRoyPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230284; c=relaxed/simple;
	bh=rXcF/VF0EfEM5S9l9Ina7YMlujPQoevsyFZ4qcKPAs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCheCAdnqpSHv7Vuhqkd/itJrPpjhjhwLJdl5CpdSXuJgBpo0G4nyFEGnrP65LUBU80rB7DD/SPnuJVfu96poj84lChiPBlBvNYcXRzAGhEyUT6yNHvXmONo/5FMGzhgXoWddhRKVeYy6MnnyM5L+g/YOe7GEFfs+H2P0P8+UJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtFAEU3F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jF6PdLVk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9k3on011396;
	Thu, 23 Oct 2025 14:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HmFU57QUdrge03jlNAmpS08FSPDd7k1gp01WkkVDrUc=; b=
	WtFAEU3FohYwX/Ec/AZYmhL5yY6GZOuH+sRvDYTbtlLEGhzm8tfgoWNu2SGErpaM
	Ywbj/M7WA45ONwEhjG9Ijic97ooQR3lk4/frZxJTR9SBhkF80uP7oLARdMgBtIrU
	oCESQKS/pDM2LBG3mnn+IzXbxGvF7WrDg9DOnj9xtbZmUAMEC4w3V/X2uzhiAPlx
	KI0sSQM4IIOwdXLq9/Mb8fnDTiAMOfx62bMIE76DgbTHhx3KCYs8wZnQhDSK4Ewa
	Pu6yW6EqpbhW0wuyBecTHVyl3kaIzWWJbyq6ymdlv7df6nl6e+1K5L2kFYJniMlr
	OWyjEB664hj/YCpFs+VIFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcyantp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:37:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NETN1D012467;
	Thu, 23 Oct 2025 14:37:32 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1benkpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5HKDkrY3X3+OB44FyJmm5PiGompX03FK9A7ffd89OwsGZ33yCLJD7dOwZa0semXJrvbECfu684FjVfD1Yv6ZsBEzim57RrZsXMKsGlFNP408MG2JwZ6yifbv0XCh9W8l/bUh6ld7ZmwVFjzpDItSjClA75kv0DFDrjVwLoUhCSa8xkFq7lDIfBx+eMHfMIK9hPbybsXw3Q0UXxQIhxXSM6s9IlJz0DJ2wkei4/CD6lJdy4zAUGiUJmjGoU9JaxJaZsa21jh7tC9iHsK1tbf8m253+V1pnHrz/bq57z5FZWULnvgb9WSpQcWYVkZNTPqv7sqFWjog8qRaVWRCsk6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmFU57QUdrge03jlNAmpS08FSPDd7k1gp01WkkVDrUc=;
 b=Y7ZRKGKtlnQ8h2vv5VuGfRHDkVSSNnEaQwYR0rvp4RqLrWlq24BRHG0NfL8n+sXA5GKw3BHQ/u62QtUeGVt0f80hHSZzpemmEYFanNkDVUhF+pjZQISyfCO11T1aQ3uaTApY8QYi+Mp7RMgkcP2F4oYv8NftDEOgdKCVUEaISptcp+G6pT9/qU5jyMviojE4V5kPsRSOcWcvjNeI8ufNzsavyt4Jusp5iby8YRfPH6jgLfKUjE2F03c1dziABSG/rp4aT8lwDnDaVnTOCHmS0Lo2ogLxJTNpve/+UabxCQ9/N78cj9MVeR2ssG5Vh12gOZorX71S+R7Q72Xczd7i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmFU57QUdrge03jlNAmpS08FSPDd7k1gp01WkkVDrUc=;
 b=jF6PdLVkrVztqpu4G8tPF5Ew6N64im8R8eFYyu4Qvv1mzj+Mg2Ajby7YrGsV2B6WuwExSXNVHamhbIyX/JISUJ3eAF1N7DKDVGcjoaFJz1nic4pWOw1ZwX4UA7iCfKMnL9lX+a+gGVf/zQqPDnN93lfTkMdutNHk9ZGEWR3CmHg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV0PR10MB997567.namprd10.prod.outlook.com (2603:10b6:408:33b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:37:30 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:37:30 +0000
Message-ID: <1b7bd33c-1b50-421c-98be-4b6c41d89e1e@oracle.com>
Date: Thu, 23 Oct 2025 15:37:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thierry Treyer
 <ttreyer@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com>
 <CAEf4Bza27n44nNcPUtQHMS9OR1BH_NafY1xcRqhKORJMNamP_w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bza27n44nNcPUtQHMS9OR1BH_NafY1xcRqhKORJMNamP_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0110.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV0PR10MB997567:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e528292-5c5a-4eaa-7bb6-08de1241b188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGZnVDdyZUNKWDZmb2JMYW1OaFl4N0U1VjcrUVVxZHhJTHc2bko1VVZHUEs4?=
 =?utf-8?B?VjVQTUFzZjVmTG9uWm1GRnMwdFlNTU5vbWREOEhSd1R3QUQ3WWhScnpvVDA0?=
 =?utf-8?B?cVRJVy8xOEtYRUlNVnVYWC9mR1VpZEhFakxjL3pvRmNnekZnTTdVakhQcDlt?=
 =?utf-8?B?VXU3QlVwVC9jaXVZREdnTEFvUUZGT3BNU3pxS2RVR2U5UnVDV09vbE9IZTJa?=
 =?utf-8?B?SDd3ZjZqWW5ubUoza0NGZTJhUlhpbEsyUlpvdENlTDE3TnRyWEtiMURsSElC?=
 =?utf-8?B?aEM0ZFRPT3prN3grdVVDZTVrZUxxRG05Nkorai9iMjUyQ0h2bDVZM1p2MEMr?=
 =?utf-8?B?ZjJXOStWZ09PVDJDVVZhOVE5eTRhbmRpU1pHSEgzMmJyditBc1ZJdzE2NW41?=
 =?utf-8?B?RWZvY0VsaGV4OU90N2lwOGZTQnNNTVJQamRxWTNLV2JOSHBhcXpHM2pRWWxH?=
 =?utf-8?B?RVV6QlNjTThJMU1EKzd5WmJHSkFTd0cvNG9PNGNPM3FzTS94aHhnT2ZDRWwz?=
 =?utf-8?B?MXdQbzBIUHY5UlRRSmFScTRSbjFuc1JSdHdJak9WcU03dGlRSzZsQU1FZ3Uz?=
 =?utf-8?B?elJsZTk3Rm9ERGFtM3lLak9FQ2MxTjRIWFZ5cmNXS3llK1NWQXpNenpnV0Ju?=
 =?utf-8?B?ZFJlMTJWZ2l5TzlUUU84YjNhRlM2S2lkL3o2TFJIZ1JJMml1N2RrQ2tpeGEz?=
 =?utf-8?B?UUo2NlJaSnpJTjdNaHB1RVpZVHRuZVRnTXROejlJT1FsdlFFTVpwVzZRems1?=
 =?utf-8?B?djVsTWVnSGw1NXRaQXpOS3NsdXpXYjBjNXBoa1dJZmdpZ3NicUkycXQ3eUky?=
 =?utf-8?B?SkZBdXFEYU9WeGR2ZnFKbHJWc3lhT1J4MkZNRXdyejgyZ1hQaEZ0em5QeWg0?=
 =?utf-8?B?TUZVUGticFQ5MzlodzR2b3doYkJqNEw3aERQRE1XaWlYakNBK0Nid3UrMEc5?=
 =?utf-8?B?Tk5OZzI2Q3FPOWF1S3JyUmxjL2RUb09PV0JtUllPL25FcXU0dnBoUWpodnpL?=
 =?utf-8?B?L2k4SUZlNldzQ1BRSkVLVW1OaEhTRk9wSlhNd0tOZHkwck9zdHdYbUJBNTRj?=
 =?utf-8?B?V2JqVldWclZReDhUSU9YekxwZnQ3R3VYdjgydGNzS0tJYmdwd1FDS21seFAv?=
 =?utf-8?B?dlB1aHgwSHBoa3B3eStvMVVmcXFnYjB0dFJJV1lqcDhaQzFMdC9JUmpBOXFH?=
 =?utf-8?B?SUhpOXFyRVVHUjJrY2UwaTMyS0JqR0tNVFJWNVlrN2lMTDlVbk9pcVl1TlEr?=
 =?utf-8?B?T1hhN2lMK1o0ODBFZlNVenJEQnMxTGhsWC8rY1BMdktqRlpCaXludGo5OHNz?=
 =?utf-8?B?OXZSaW5IVTZOUjdVc3pkQ1daZ1R4WXZUNUIzelgrTDFDUjJKeWQwUDUwNEdM?=
 =?utf-8?B?eVAxSU5PcHJXTlh5U040eXdqdUphVHdLOWNGZUpyRUx1ZHdTbDJEZzdkbDg4?=
 =?utf-8?B?WXJCdEJTdERSRlFxaGFzS2s5UktPWTJSdDQ0Qkk2cFYwLzVqRzRWcGh5bmlk?=
 =?utf-8?B?bDcvR2h2OXl1aXh4dnZjMVBYVGZIMGVVKzYwZUE0MXRLZXNGQmtuQnAzMlY3?=
 =?utf-8?B?SVJQbjhRNlN0c09wQnhlVk5EaG9tbUpwWkRCMjJkemdSdGRmVXJkR1dXQUFL?=
 =?utf-8?B?UGJUMXcrcDNXOS9ndUhOdG13eDZSUmI4QWx3MFV3dDlDajRVSVl2bENRT1A4?=
 =?utf-8?B?UUYyOGtUVk5XbnRwZTE3eWovZXVhVzZVVytEMHIrWVNXbkRDci9YSjNrUDFm?=
 =?utf-8?B?OW84Z0xZMFVldEhmb01JT2ppdmJlemZPUmUzL3BPSUpiRjdlY3VOUjBYd2NN?=
 =?utf-8?B?K250YXY0ajg0bFBBRG1qT3cxUm5pM0ZKZ0hhS3hxSGJSUnpmSXVaa0laKzlF?=
 =?utf-8?B?ZTBKRW90eGIrSWtrZ1ZaMkVmVWVNMWN4SU1HWUo3aTlTRi9QTWpFZHNDZmhh?=
 =?utf-8?Q?YzK0O5JqmjhlAxzmJTx2JC9VJUb3LSEj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUo4R0VZUENFTlFDcVR4aEFhWXpGRVNINFh6cTlBQWdqZEg4azluMWpxM0ha?=
 =?utf-8?B?Rlg3MnVZR0p1TEZiR3dvQ1VWVWZEd3R4QzQxVUhBaXdmdytUZmovUVZnbkRm?=
 =?utf-8?B?aisyblZaNzJJa2hUSzFGN09jSnk5MGMwZ3hTZEwrUjcyRVB1L3FMZGl1YWU3?=
 =?utf-8?B?U0l0R2QxYXE5VFQ0SkU3WEpRZWhaVFhaeUIyZXY2ZmlLV252S0dOSEZsOEZm?=
 =?utf-8?B?NjNLTml3S1pMSlpMWmsvNnVnYXJRd0RpY3RlL1BReVgrbzhJZlJGaWU1MTkw?=
 =?utf-8?B?N3cvcWlRVDVHa3F0bWtueDZwb1B0QzdvREtIYWdjTUF5N1Bzb0RFV3BJNHZT?=
 =?utf-8?B?aytjWnM4OGY2MEpGSzN2SURoYUJ3RVFhMC9LZENDemNtQ2VKVEdCTm5vTEsv?=
 =?utf-8?B?bHBwaEJoOG80WC9YRWNkaVh4QWdlN1Ayc1J6alZLdWhmSC8rR0laUnNKT2gr?=
 =?utf-8?B?ZDhRRVYxaXRXT2tyRm1XaVBRNzhjczl4VnlkTEJtTHIwZS9pSGM0eks4algz?=
 =?utf-8?B?SDNXa0E4dHh6VnNFaWljKyt3RXJ0Rk8zbWNvV3BRV0tRbm11aGt3QWpLVFBo?=
 =?utf-8?B?R2RDZnpkc3VVazcwRE5sOXEyZlJJbmpBSkJOU1cydkVLdmNXdW5HWURhcUND?=
 =?utf-8?B?YXlGL0pOZG9sKzBGWENKaWwyUGx2NE5RWlJGWFp6ODFsYTVZeUlOakJmYkFz?=
 =?utf-8?B?ZlZaRzAyWGRiamZIWjVXSnE1emlsOW9CbzkxMXd4MEg4RUZBRkcxcWNjWXZC?=
 =?utf-8?B?c29nOTRsSFd4TE8vMGV1Q0Y5MlliaDdiY1J0dDY5Q2kybS9RcVdXVS9xUGV3?=
 =?utf-8?B?R2VFUDNVN1BlRG9ISXExRWNQcXVmZ0dzYXQvVDF2bk9UWVNTdVpQZURDQmNx?=
 =?utf-8?B?Q0FET1E4SW1xYXlwMFp5VmQwRjBBUDNEQnZtQ05GaEdaWHc4SitYMmJVSlFD?=
 =?utf-8?B?L1dETUxYVVY5cGFzQ2YwWFdCcmRWOEhDdm4vQjFqZFF0QmN4V0ovZ0Z3N0JE?=
 =?utf-8?B?a09kZjFlbVFXMWYxTkNnMi9OK3FleVgvNXlFMkZRdkIzTWlCTTVZemY2dmJI?=
 =?utf-8?B?ZEZVaUVESzR6M2JLdmQzTE5VOWZFOGJKTU1WcGtvdUJpblBZNUFQSVJvU3p2?=
 =?utf-8?B?aytUYzRya3JTU0tNK1lsYkI3bUNaM3hIaWI5TVZNengzanVoSEZIUmlYNzQ0?=
 =?utf-8?B?emNUR0xOd05xNUdYRVZ2TTM2SCtqQ0s1dGx2WVVsVFZUdmwxK0RhMFpFckI5?=
 =?utf-8?B?T01ZTk1WdDlhZzRhSmU1TG5ZWXFIaUdYbFF0bUdxMWFVTERsenZ1QS9JOEw4?=
 =?utf-8?B?MjlXQS8wemV2d2Y5cXVTTmZIeXJxYWordWlrWXB3ZjhySVd3UzFncU03ZDA0?=
 =?utf-8?B?TU0wWUZwbWsxeTV0VVdYRHpjU3FXaUR0eWxqUEJnTnZwTlJ5ZFAyaXhYZkNN?=
 =?utf-8?B?WFE5SkRROXlSMFlybFhqUm9aK25tSDgvdXlUalpSZzlkeVc3dmoveGVZQzVk?=
 =?utf-8?B?ZCtiYks5OU5PR0swb1h0SnZsYnhDSDUvdC90d3dOaVJCNXlneFgyWVNnTTdX?=
 =?utf-8?B?NVd6N2FSNU5ORDZKbVRsWDUyZEJnN3JRa3Jid0tFNW5CRU1xTlo5YmpQdzFo?=
 =?utf-8?B?MHd0eXMzaytLOEFLMFQreTJnZGtxMDh6UXRDZkZyTk1hSFUxWnI1UWxWRlBX?=
 =?utf-8?B?dXNJU1NuOUJLdGhPOFozSnljNDJLaFk1RFRnVHFKbTNFZEhVNlh3VmxaMzU2?=
 =?utf-8?B?aGJwUk9EYjJJeHJMRERXQjBvcXpSUzltOW9EUXRGNitDVUQySFFIaXNHeVdq?=
 =?utf-8?B?Q0RaS1dybW5RNlozdm1pQ0RCSHpOSTlBcmRDMGoyZUI1Mk9jVkxEU2dqN0VG?=
 =?utf-8?B?N3U4WnptMWNLWWpBU2xjb2p5OEZ6OFJ3OTJwWTVFaU5MdWtGUHo5eGJMWTI1?=
 =?utf-8?B?d2FVUll1RFNEZUhBSUNCcDRWWXVLVTYxay9panI3eGw1WjNMRUNUSTFQQnVl?=
 =?utf-8?B?WE9UZ2VaY2R6WXJZQzVYbDB0TDZIVjQ3NDgrdGk4Njlhdk9qWlhMUHJpeGM0?=
 =?utf-8?B?SDJmOTZCRUdDdFBiSG8rRVJhYVZYK1h3b0tFekpHRERCc3dicFBwSEZ0dU9D?=
 =?utf-8?B?N2ppM2RMNkl1SldQdllpZTNtOGVGeVEvK3dKY0FMQ0FpQnJCdkp1bVFIcWtK?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KfVJN/dniqkR1ly5MPS7ey9k8MpkKCFPPOJ1eICFwMGEp0mvyar6TeSEWNYGvFNWtlokLVzwlUeJej/WMhnlOtBjkSGs9PLqbazkzNHL/YsRlzvpZbAq/FPbvtBd7TjlV+iW9p9wKYEHJQoTSxWgY9AT4NdtplIJTSJ95PiTRL4FKvkzbHVUVxs8OsxVAJSk+VxuHeDaocJn2JYHfABGxGGLr9IvZZ537UW/lPHex49hst8mX4hlpX7pndVjex7h7BXcJoTqi1+o5XH+kLr5/iLGp7DHhzk7Zaza6MLMhWkeJ+jyFwa9IBxk9uVYbFoMgK/VRLeBO4eT+kbp1hJxYz4Vj3sfDr4xs4wEAja5C5wR89GOVD2cqXbitjljfZBX4XcshmX13h99i5jFvapwVEc1NDepT6BAw7bxiCBx0cg4E0BMHHifU09h9SrTc0P1zic3RG4sz13DEKXrd67fWYoxrKnEHYlkhQq8eXdt5bZ3hGzK2mKLp/5Pp72y/ghIPkkDCqHeGa0z/BfUDTz05RlyXFkVBzsb+UBu5lO4jiCS9lwnkm6gSG4kRSQbvESWJzb/YV7cQj0Q140f0JetnW19F+/6OwyvOeFa9OK4rjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e528292-5c5a-4eaa-7bb6-08de1241b188
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:37:30.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WkXVr9UOUoLdTU/obZxjuWL1wNTnsgKMcvz/CoRsK8/J9n5m+l/jcparhwRcVDVazQBzAOStSvC7L9iZKCXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230133
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fa3dad cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=gSftqqt59qM7jXegiO4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX6hpXD1qg49hV
 svXEMe4P9XgQJU32Q5Xldi6V/fKaK7Jdhb1oIHpwsg6Ny7O3NCKvDwYz1/xr87aKPrmFdC4WNHa
 rFJ1PRMeMYOuRPzeluBxEFdfa4fC29aGojdG5OadDxehGndmo/nJqb8fItqWinOaxpEgIKn1XTZ
 tKH61B2vTixDGgPeCNZAOpWFcmyddaHnOJEE/5XDTsbGK/zQwgZkQWphx0culF+RyiOzASvm7GJ
 ljyYPwMHYmmlUVxpkrrAXcwWT4A3B0TqFd4DUWaNMXK9wvOzoflSOZvO6LXAa8RBDUg5O0oRJdP
 N9mVWR82jQp3+87EFeGpI35YGG4L8USR+ezN4mmzKpi+PHffC6RurvyM5Jp35UwuzXQU1WmX09Z
 K6YTau/59srb0pdNNkAmGKipFcyldw==
X-Proofpoint-GUID: wErxqsTr6UwEH5FEL3O-ZinfvFn_LibE
X-Proofpoint-ORIG-GUID: wErxqsTr6UwEH5FEL3O-ZinfvFn_LibE

On 16/10/2025 19:36, Andrii Nakryiko wrote:
> On Tue, Oct 14, 2025 at 2:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 14/10/2025 01:12, Alexei Starovoitov wrote:
>>> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>>
>>>> I was trying to avoid being specific about inlines since the same
>>>> approach works for function sites with optimized-out parameters and they
>>>> could be easily added to the representation (and probably should be in a
>>>> future version of this series). Another "extra" source of info
>>>> potentially is the (non per-cpu) global variables that Stephen sent
>>>> patches for a while back and the feeling was it was too big to add to
>>>> vmlinux BTF proper.
>>>>
>>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
>>>
>>> aux is too abstract and doesn't convey any meaning.
>>> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
>>>
>>
>> Sure, works for me.
>>
>>> Thinking more about reuse of struct btf_type for these...
>>> After sleeping on it it feels a bit awkward today, since if they're
>>> types they suppose to be in one table with other types,
>>> searchable and so on, but we actually don't want them there.
>>> btf_find_*() isn't fast and people are trying to optimize it.
>>> Also if we teach the kernel to use these loc-s they probably
>>> should be in a separate table.
>>>
>>
>> The BTF with location info is a separate split BTF, so it won't regress
>> search times of vmlinux/module BTF. Searching by name isn't really a
>> need for the non-LOCSEC cases; None of the FUNC_PROTO, LOC_PROTO and
>> LOC_PARAM have names, so the searching that will be done to deal with
>> inlines will all be within the LOCSEC representations for the inlines,
>> and from there it'll just be id-based lookup.
>>
>> Currently the LOCSECs are sorted internally by address, but we could
>> change that to be by name given that name-based lookup is the much more
>> likely search mode.
>>
>> One limitation we hit is that the max BTF vlen number is not sufficient
>> to represent all the inlines in one LOCSEC; we max out at specifying a
>> vlen of 65535, and need over 400000 LOCSEC entries. So we add multiple
> 
> We have this, currently:
> 
> 
> /* Max # of struct/union/enum members or func args */
> #define BTF_MAX_VLEN    0xffff
> 
> struct btf_type {
>         __u32 name_off;
>         /* "info" bits arrangement
>          * bits  0-15: vlen (e.g. # of struct's members)
>          * bits 16-23: unused
>          * bits 24-28: kind (e.g. int, ptr, array...etc)
>          * bits 29-30: unused
>          * bit     31: kind_flag, currently used by
>          *             struct, union, enum, fwd, enum64,
>          *             decl_tag and type_tag
>          */
> 
> 
> Note those unused 16-23 bits. We can use them to extend vlen up to 8
> million, which should hopefully be good enough? This split by name
> prefix sounds unnecessarily convoluted, tbh.
>

That would be great! Do you have a preference for how libbpf might
handle this? Currently we have


static inline __u16 btf_vlen(const struct btf_type *t)
{
        return BTF_INFO_VLEN(t->info);
}

As a result many consumers (in libbpf and elsewhere) use a __u16 for the
vlen value.  Would it make sense to add

static inline __u32 btf_extended_vlen(const struct btf_type *t)
{
        return BTF_INFO_VLEN(t->info);
}

perhaps?


> 
> 
>> LOCSECs. That was just a workaround before, but for faster name-based
>> lookup we could perhaps make use of the multiple LOCSECs by grouping
>> them by sorted function names. So if the first LOCSEC was called
>> inline.a and the next LOCSEC inline.c or whatever we'd know locations
>> named a*, b* are in that first LOCSEC and then do a binary search within
>> it. We could limit the number of LOCSECs to some reasonable upper bound
>> like 1024 and this would mean we'd binary search between ~400 LOCSECs
>> first and then - once we'd found the right one - within it to optimize
>> lookup time.
>>
>>> global non per-cpu vars fit into current BTF's datasec concept,
>>> so they can be another kernel module with a different name.
>>>
>>> I guess one can argue that LOCSEC is similar to DATASEC.
>>> Both need their own search tables separate from the main type table.
>>>
>>
>> Right though we could use a hybrid approach of using the LOCSEC name +
>> multiple LOCSECs (which we need anyway) to speed things up.
>>>>
>>>>> The partially inlined functions were the biggest footgun so far.
>>>>> Missing fully inlined is painful, but it's not a footgun.
>>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
>>>>> user space is not enough. It's great and, probably, can be supported,
>>>>> but the kernel should use this "BTF.inline_info" as well to
>>>>> preserve "backward compatibility" for functions that were
>>>>> not-inlined in an older kernel and got partially inlined in a new kernel.
>>>>>
>>>>
>>>> That would be great; we'd need to teach the kernel to handle multi-split
>>>> BTF but I would hope that wouldn't be too tricky.
>>>>
>>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
>>>>> make a lot of sense, but since libbpf has to attach a bunch
>>>>> of regular kprobes it seems to me the kernel support is more appropriate
>>>>> for the whole thing.
>>>>
>>>> I'm happy with either a userspace or kernel-based approach; the main aim
>>>> is to provide this functionality in as straightforward a form as
>>>> possible to tracers/libbpf. I have to confess I didn't follow the whole
>>>> kprobe multi progress, but at one stage that was more kprobe-based
>>>> right? Would there be any value in exploring a flavour of kprobe-multi
>>>> that didn't use fprobe and might work for this sort of use case? As you
>>>> say if we had that keeping a user-space based approach might be more
>>>> attractive as an option.
>>>
>>> Agree.
>>>
>>> Jiri,
>>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
>>>
>>>>
>>>>> I mean when the kernel processes SEC("fentry/foo") into partially
>>>>> inlined function "foo" it should use fentry for "foo" and
>>>>> automatically add kprobe into inlined callsites and automatically
>>>>> generated code that collects arguments from appropriate registers
>>>>> and make "fentry/foo" behave like "foo" was not inlined at all.
>>>>> Arguably, we can use a new attach type.
>>>>> If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
>>>>> of regular kprobes from libbpf is unnecessary.
>>>>> The kernel can do the same transparently and prepare the args
>>>>> depending on location.
>>>>> If some of the callsites are missing args it can fail the whole operation.
>>>>
>>>> There's a few options here but I think having attach modes which are
>>>> selectable - either best effort or all-or-none would both be needed I
>>>> think.
>>>
>>> Exactly. For partially inlined we would need all-or-none,
>>> but I see a case where somebody would want to say:
>>> "pls attach to all places where foo() is called and since
>>> it's inlined the actual entry point may not be accurate and it's ok".
>>>
>>> The latter would probably need a flag in tracing tools like bpftrace.
>>> I think all-or-none is a better default.
>>>
>>
>> Yep, agree.
>>
>>>>> Of course, doing the whole thing from libbpf feels good,
>>>>> since we're burdening the kernel with extra complexity,
>>>>> but lack of kprobe-multi changes the way to think about this trade off.
>>>>>
>>>>> Whether we decide that the kernel should do it or stay with bpf_loc_arg()
>>>>> the first few patches and pahole support can/should be landed first.
>>>>>
>>>>
>>>> Sounds great! Having patches 1-10 would be useful as that would allow us
>>>> in turn to update pahole's libbpf submodule commit to generate location
>>>> data, which would then allow us to update kbuild and start using it for
>>>> attach. So we can focus on generating the inline info first, and then
>>>> think about how we want to present that info to consumers.
>>>
>>> Yep. Please post pahole patches for review. I doubt folks
>>> will look into your git tree ;)
>>>
>>
> 
> BTW, what happened to the self-described BTF patches? With these
> additions we are going to break all the BTF-based tooling one more
> time. Let's add minimal amount of changes to BTF to allow tools to
> skip unknown BTF types and dump the rest? I don't remember all the
> details by now, was there any major blocker last time? I feel like
> that minimal approach of fixed size + vlen * vlen_size would still
> work even for all these newly added types (even with the alternative
> for LOC_PARAM I mention in the corresponding patch).
> 
>

Yep that scheme would still work. The reason I didn't prioritize it here
is that the BTF with new LOC kinds is separate from the BTF that legacy
tools would be looking at, but I'd be happy to revive it if it'd help.

Thanks!

Alan

