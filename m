Return-Path: <bpf+bounces-79229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B7D2ECD7
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2045F3015149
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E889352FB8;
	Fri, 16 Jan 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFH+XaiL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QisyFJ4g"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41D352FAF
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555995; cv=fail; b=lnu+Nm1B02paIITFGWidzNvRqDLeIbfjYliBdY0hKUsisQ8heL1dp9V4JJ1fDZUxcMavBVcMlmv3dWNbPqF89FVfVtUe10g2oOIageCTcCowb/VS4zMvR/IRBUrBRvou7fu6CT29lRe1ga3r/NYWpuCMEI52lMDss8AwmKKSJIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555995; c=relaxed/simple;
	bh=DtLPj+pf6VH4OxT8kT715f69x/4FxmsPz9ZfToeuHQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBhSzVajXuPA+5NKeuV3AUxPbjqZ38pt5i5l7dUPAJpWInhef3fxtjk9rKINk/QL46iMWVLUEpmMQatrSmmXpIFkPeIqdyAfGiodkngFviNPUDcHdTLmyLYatl4p1ybPxu+SLO3PMAyqC20jjiulZHTHd8eEH04JVkZDicqzZv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFH+XaiL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QisyFJ4g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNK0p1796053;
	Fri, 16 Jan 2026 09:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nhrxZfNA2dUA2v9wreiSXOxOrxPlzpkeHByBehTLDrw=; b=
	hFH+XaiL5rrrNqVtdNNteQU2aZTUL3WUVVDQnLew1B/hJvAAEXkTxn0ONsJKLzOu
	hxM9uLmcAuxQpfrLbd7KTJ8dFuWPpFnkrFdBraIFaSVgltIL3rR2sTvHASbfL9K3
	1RP6GjDri2leQoOVSB0D9Xjo9SHyQIhpdfdD9xbBFlhsmXH2Mm7ckr/WJ8Fb+m1M
	V8DEcNLymUXl1yoss3QZP1keXDjalwRvcdapEC4HaRxF3IzVJEPu0ZT+Ohs+MLCM
	fUsfIw3Z9QMnXcvBB5dCMeHuZXr6SkXKggKU4qggioEWIiXJ6CoS9ijSF5CbbUyH
	BPIunE9eYHuqikhYpYqDHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgsnyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 09:32:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G86g0C033952;
	Fri, 16 Jan 2026 09:32:46 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7cpv2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 09:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOtUcC74NSMfyfuKxfLDwS/opHp15AUJNYxrMWEkNQx3PRpW1/tVnTM/yeIgg787juStGSoGN5D/rC0i5+UfNulNqA18ajL1j1kgUIenDtyslOosE9lgb+fI7GBpSePLaxv5+bbarwLGkAOVmTBJfXQqSg9gRrjCtNW2JoTqnTl6+zCKq5/bnEQmWaaqEMLlB1sJejH3HEgdrRTAw3d23VU9SE+w2O//1lo7wEsaqhWQxPj7Od3cUKPLIFWDTPGlvZkfx9NqVufmF3MdiCSlUAE8DFaEgSYYWYXieKg0AwTUNYB5fPlDx24LJ+8e6JWE9yqi5Q9wb5hGvAJDV/hnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhrxZfNA2dUA2v9wreiSXOxOrxPlzpkeHByBehTLDrw=;
 b=Jr1TIcjPocArkdLHnfNuiX181Oj+LfZUMRrkabmLMDXvt8CnzagFEzsyDnHohIQ3rRJVHMDfNYd3b2mUVTZK3R5UutYmnV2/xvfDfJTLKRzlnc0Y9O1LC6nKCrEK+3wgLYGcaWQxJxAZ6Qp+Frt8guTr0PTJOM6nixMdY0yMUMZaAnzSeeZc6qlwwkkMKcHocvvzAbSVuPoviMLFsX8yEry8y93uZCaDzLvEuD/fgxaDrc78qZP2f9FeY3HEcwgkyfCBgGH+5MCdn3b9lJ4MHBozrwe5GzeZHNjGi8Gqlov57RydfQuygzwrN05cfR7rPCV+X3nZQzWZxuKgjtm7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhrxZfNA2dUA2v9wreiSXOxOrxPlzpkeHByBehTLDrw=;
 b=QisyFJ4gn043qMavAjmh4xtzgiLtkB33xtUfBxCD1K2iw0pPPupeRheQ0gVjsA06Ij63qJA/65TpK/xv7yUjEuZ3AO+CEDqsci7KAJx/BECnjvkPqyjDIRouaIzPdg6Tyd634C8n5lr2y847zIqNhqRKfEfXCbRG0W6zhggdCcE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 09:32:43 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 09:32:43 +0000
Message-ID: <87900b12-c836-4692-ad7d-b1997df806d8@oracle.com>
Date: Fri, 16 Jan 2026 09:32:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20260115163457.146267-1-alan.maguire@oracle.com>
 <DFPVFON6H9AQ.3BE95ZHQ3ATOL@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DFPVFON6H9AQ.3BE95ZHQ3ATOL@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CYXPR10MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c01a6b-0a88-4dfc-a0ea-08de54e2331e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk91NFRyQlJqNldTcytxdGE4eng4WmZZUXgrVE81TURmY010YW5vcUdiZThr?=
 =?utf-8?B?bU9raWxOMTd4enpxRWJCbXV4OGNvWmpJZEhubHBuNjM4UnF4a3FFUlYrVkwy?=
 =?utf-8?B?ZWliYTI0b3NRYllBY2RsTWFwcmsweHdIelM1My9FVGp2SjJOajAzcGZqZm41?=
 =?utf-8?B?TU5GTkt6SFJpcld0SC9BTUp0VE9SZG9UR0dFUFFHeG9Ja0dPU09hU01ORTJJ?=
 =?utf-8?B?WTZEVDd6dXpFTWR1YkVDbjNIV2ZWdVF2cnh2Mkh5NjdqYWU1R3RhQ2ZXK25S?=
 =?utf-8?B?RStTL3h5bUJ0dm5wUWtsdjR0RkpNV28vZzQ4Tm9iM2FCdmlKN1RYNmVScWZE?=
 =?utf-8?B?ak16dDJkSFVQUXQ5N25qYi9Wb0ZmUkRPZjU3YzV1Znova2tYOGtIK3ZWWUtX?=
 =?utf-8?B?Y21zeEZrTUVOMWtOalU0ZFdWQmZkdjkzSWtpNTVPQXFHeDQzSDdLUDdoY1Rt?=
 =?utf-8?B?QWdRR1lTSnRzYXhXNWg4R3lPdUlscHNuOEFocU9wS2ljd1hHY1dMODM4RXUw?=
 =?utf-8?B?aU5GMkRUWUM0ZjQrVU1FR3hNQldvalVLQjFKN2xwc2FhRkkzSDRMK0RTdHpX?=
 =?utf-8?B?Y21JVm9yQi9UTW03bnFBQ1FSSUoybWFoS1hYbVk2MnJNUGU1cmk5OFNTUXg0?=
 =?utf-8?B?NmlRMFFPZTBJYzdrcDJVdzE1SDU1TXNtZGhrRnlHRzhMclVWNDZzV1NUNXlV?=
 =?utf-8?B?Y0RQY0hrSE1VQ0Z1d3dWVW9lUnhyYXRkN0JIUnlKT2x5RUxhelYvaFF1WnpR?=
 =?utf-8?B?WnRMQ2tDUi94UHJ1bDJVWFlyM0huZjc2cDhVRDZQUlZNYzhqK2JGdUEvZHFN?=
 =?utf-8?B?eUFCRER3YjNJNlRWampoREF0aE5FMUZrZVVTV3c5ZFA3YXpxRHZWMVBsd2dB?=
 =?utf-8?B?Y2ZDRWdmanZpL0UrOEp0MERGNWhVVm1wZ1pueFdpM1R6YzVONWxVbTNZVjBS?=
 =?utf-8?B?T1BWbFRONVNtSk0xZEFLbXk1VkxzRWdlWWx0R0VzQjVWTFhEZ2ZKWlF3THdV?=
 =?utf-8?B?WncxaEhCMjFoWVRwRVo1cVdNSm0vZGxIaWdjL0xKcWltME9sVUtCMFpsWlI2?=
 =?utf-8?B?MTVKRHdvcmRaYk5YR3dkUDY0Y1dQdGpWcnY3bzZSYVRRV1NuVlpqeGpHYkli?=
 =?utf-8?B?RWtnNDdRY0p6QW9VUld4Z2FIcjVETzA1U3F5VFNZWEtpaUxML3JaNEdZRHJj?=
 =?utf-8?B?UXg2RC8xc3kyNk82QlorRi9rNVROaFFRcXBmaDJmUXZpbXRZY1I4bjJnRmd3?=
 =?utf-8?B?VHZGUGZNRTJHYU0xMm5pQnR4SWc1VmJwYWI4NHBsT0hmNVdlelZyZmZlWDVN?=
 =?utf-8?B?aWNoSzF3Y2JKUE1YNFVwV25uZ0Jibzh0c0krWmN6NUcrdSsvZGV6REtiQXFh?=
 =?utf-8?B?QkkzSjMvQkVmd2NXcFQ1dkJReWlLSHlMeFF3c2VGY2lGWllmOG04R0tkMEsw?=
 =?utf-8?B?MzJHSzZXanlWdVp1cXhwVE1qSTBwSmtMcWtwa3c3dmpLMWVIdjFuWE1XSWRU?=
 =?utf-8?B?S0UwVlNhR0xjWDNiODRmdXpNMk41TzVBQWdaeDRxN3BDM2lVMWhjWlR2OEZG?=
 =?utf-8?B?bkI5VGhpTEY2WDdOSk1oL2t1R3JrSVdhdm9INGVBeWU1aFZRRnJKbklIaG50?=
 =?utf-8?B?aGRjWVhDcTlvVFFxM2JnTDlZdThoUHNWZVRuVmdKUXN0SE50R05sSmtsdHh1?=
 =?utf-8?B?K3ZwVXhtR0ludnhoWjVSdzV1OU5PdW1GTHNqQnFlWWZpdzMrZCthcDlldy9F?=
 =?utf-8?B?eDAxR2Z4dHczWjQ5V0RLaldqSndvUUlVVTlza1hNTUdHM3BVRm1hUE9YdWY2?=
 =?utf-8?B?SkZ5QUJkOHF5ME1EQWNZL2RiRG1yQzJDUlU4aEM4TFFYTVc1c0UrN0JsM2FI?=
 =?utf-8?B?RGU4bDNDY29jNVNhZXdoM21wbjNRSEFrUGxJU1htajlYUWo2eWtQK2FHRzNr?=
 =?utf-8?B?OS9DeGFrUjdPL3JLb2FrUm9INVVicWJSTXhjd0hKeHJ0dlorZzJXcTV1bG5F?=
 =?utf-8?B?Z2ZpZWNVQTFuTmRoYVFSOW0zSUhjTE03bFo4V2RROWpXdEU4OHY0RXRSaHlD?=
 =?utf-8?B?VzJqQlp5ckFReVVMTk9RTDV6aldrMS9YZ3QralRka1lyZkt4OG9VMStTK1dk?=
 =?utf-8?Q?CFyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0VzTnBGNVM3NmhwMEZtWC9BWWR0aFJTODBYNU0zTUEyRXhDNVR2Y0t6L0hY?=
 =?utf-8?B?SXVVSHBhTEVGSlBmT0xRNGRzd0MxSzBYcWpnNzAwMzZhQlRiWDFNTTlOMDZJ?=
 =?utf-8?B?djhJR0htMEppNXFTN3QyajJDWjhIRGZOOFY2YUozWERCM0F4cSsrK01GMFZS?=
 =?utf-8?B?VVFBbGd3dVlFcGs0YS9TZG5hOWlJUGVON3FTaUp3NS9uNVNlbWlFT2NTd0dF?=
 =?utf-8?B?WlpoekdnT1JiU1FuN3huL0tRWUlrNlRlS0ZPZFhaVE4rUGZVZHZyWitrWlJr?=
 =?utf-8?B?T0JsMVVqeTVhWHNyQzIyQXNDRXNxeWZjTVh0d0x0K25vNWExZndwc0JIMmsz?=
 =?utf-8?B?RzVLTDVweXZoQ2EvV3lHc09QaW43SndkOXJObU9sczFESnFzVnZwUXU3cG9n?=
 =?utf-8?B?NklnaVdXdW83SkJVZW1IM3RBSXZsa3gzS05rQUVmejZBQTlIMGxNS0I1M1hu?=
 =?utf-8?B?RDRmYnVMMFRTRkdPOFFLZUh1SnBEVitZV1ZnQ3NTOEZ0cUY4dENDWTN0cG54?=
 =?utf-8?B?TmJURnM3SHFqMVpGcWVrQThiWjZIS09mR1hsUVpOT1JLcmRlRS9NaWVmaVpV?=
 =?utf-8?B?bVBoUUZURFYvbVFGbC9kRWw4Nlp4dlNEbHhteG11RDFCMEdlZldSK3RET1Z3?=
 =?utf-8?B?SzNHT3hVRGtPK1RnWlhCWTdhS05yNlNhYjZwaTduNmdsRFdhbTJ0cTg3alAv?=
 =?utf-8?B?OXR1aTc4c3RScnlkNTFPZnJpMDdYbDVrTWh1V1ZWanRBWGYvOC9nWFRDUFNX?=
 =?utf-8?B?L2lrcjQvazVKUjZXSnhJUVkrRU1uOVJZSTNlLytHcElXMFZvNlI2THhnTjJS?=
 =?utf-8?B?WjRQeVl5aDk2Zzl1YW1HUS85dlhYSW9nc0c1S0JwTWhybE4zRzIvcXpGYXZa?=
 =?utf-8?B?TzFDS1RjOGt3QWF6OE5zeTJkZ09mYkRFRzRQam5ZV05oUUc5Z2RLKzkxeEtO?=
 =?utf-8?B?anBsN0RxVE14VFU1dUl1aTYrYkRsOUxUVzZSeG9mWW1nVEs1M0NOd1FZdThn?=
 =?utf-8?B?QmZ5bXZzUlk5Y3J0ODZUcmV5c01lZXhFd0VFOEoyRmNuQTlPNXpFRVlXV0N1?=
 =?utf-8?B?dXlGZjlmUUNGNnBDcWxRRlc1TjRMVGV4SVNIVXhvU2E5TXA2dmI0QmhGUVJV?=
 =?utf-8?B?dHBLMU05STQrcXIzVXBsYnBMcGNNdzVtcldtTUg2U1E3cXdteXhlMVpEZUMw?=
 =?utf-8?B?REYvYllQdHZKdzFuM3VrcTZFRGJWQXA1aWlpQXBacFFlZUpUejZBMDZDelBI?=
 =?utf-8?B?cUVRT2dWMDRPNjdaR0xiZlVBMzFuTHdiMGJxb1QxQlpCeUVOUnp3dzZKZDVS?=
 =?utf-8?B?M3pxWlA0ZUdCOFY5ZVNQaUlZYXRiWjZsRGEyY3N2L2VTQ0l1ZGNWSkVPTUpl?=
 =?utf-8?B?cTJsT1VZRmpBYlI5bUs5bmhXaklmZmpHSks2dmJTTlYyVHA1S0NDOU5LY1Fu?=
 =?utf-8?B?ekJvZDJMYVhjblduSUw4Nk84TFNsMVpFSHNyQWJYQndYazI2WW42enNmdHNn?=
 =?utf-8?B?VjZ1aXFaZW5aanlHazVyamVEMGFQNmVvNGpnUVR5RGNKdkpmUU9PMTJKa3gz?=
 =?utf-8?B?R1JqT0RSaGQzSnJTSUVRdFpqRnV2RXNsK1djNzU0eFQ2L20yUkkvM2xLeUFh?=
 =?utf-8?B?eCtSQ0h4K1pDNEh3enRKZHRKd01tL29pL2ozOXZERjAvbVpDZVN2L25SdG1l?=
 =?utf-8?B?anFLZ3MzT0VnWGFodlgrVUNYTGplcGdIZDlTVExSOWdveUdCSXJnVGJIL1JR?=
 =?utf-8?B?QUZBNWNsVlpkSGVNWFk1N1I2eGZLR3FKV2pnTmhJSUNSWHFhRGZ1ZFZpYzcz?=
 =?utf-8?B?UW10UWhSQWtudzhHYXA0STRJbkUzeXFpREozNEp3VVVNNG04dGNJMklncnJI?=
 =?utf-8?B?SzNLU0hRMjBhL1BvODFhVDQ2WE5weWNUUXVLWWd5THVQa2JlRVpBYlRVOUZT?=
 =?utf-8?B?ZEVmUlZ3R3RuT2x1RC9hWjNic3NwTkRIVTh0c2szWE1pQUh6QzZZcndVZ3JW?=
 =?utf-8?B?VXNpWHFXQ1U0UG9nV0FsdUh5YVA3ZXBVVDFUbXl2NmtGUjZKZ1VMdGxGK0FK?=
 =?utf-8?B?RU0zWkNaa0k3czh2dldCUEozSVJkM0ZsUjlVVmJOcm5HUTBkTmRSV05kTHIx?=
 =?utf-8?B?NTI4anlwUzYwVDBlalhlVDNFT2VHTDFoNWswSkt3cWpibTlzVUhVaGN4SGhI?=
 =?utf-8?B?QitCSlV6YzhIbm54UGRmTHFTN09SNnZ5RlEva2xYZGpsQnVyM0M0VVJaNnpl?=
 =?utf-8?B?aXJvQ1Q4Y2xZRDhTS1krZmZCcURZSTdRR3NKS0xQak9zWDI1Q2lETkRmR0Vo?=
 =?utf-8?B?UWZUaVdpdVZDM2J6SExQYnZVUVltWDNYbXFueGhwbXpkNDZUdTVFUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gDYdpnBePDnqdJeXcOEB7RwXdjfkHm5Po8CmJMBEBrQrZxFBkjJ4HIBNCW9GvqouGwOmty55OgRuIOlNBXUUJ3OR6lvtGEcz1k5rQg32c7e+sMjXRkG8KVPKujOhUgInEZr4rqCeDPGPm6+MazP34tzpxpZFPmSxVcNRG+vJqcyUwqObwZ0GUi/SRlL3y9cCzR3ttwx53QBrzJUtUWuttpLHtWKYbKGRf5YGIuWx8it5pKzgpbMPcZJuPKC504Le4OMq7Cz/JdQgMKCc30XnUvp762CtFDT+qI2tpjSGiUFBJPrR2fRCRtZmRVPOnbSu2oT6NMWXdXL553VOFppHGksKKtIOeMVBJlfsW9iTwy3LVMqltMvRg7dxrM2KFLLYmc94teESoAkyq0NDSgNSsXtBFi4UTFqgvIaCiCw4daeBy87H+Cmi0oph8PCMaU0iWWWdV9GvIedOpvNcPy5ktiiF/zloQyr1KI1ZL6B7LxqcCuKWjcgHwHFO0O4SF4yeTb1kPeK1Gyk74/oBDUE0F6yqyiPMErlg8fqsBGj6RqFdloTL9I1x+hrOHqe3eR0HLZepkturephTI4HmA98FB+2lkd8W1VG3cKc8Q0DkxpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c01a6b-0a88-4dfc-a0ea-08de54e2331e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:32:43.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82ncK4omppPHPYJhn9AOd4psrs/vgJRwQwneTJeh59pFfXz9COh9Rvy/juh33x8hYpI9/ZYXUnB3EDFDxz4d9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160069
X-Proofpoint-GUID: C-DFewMGIJLnpUJaS8oZAB_ROh_Nar_1
X-Proofpoint-ORIG-GUID: C-DFewMGIJLnpUJaS8oZAB_ROh_Nar_1
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=696a05be b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q9gpgRxikmRTx2F44jcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA3MCBTYWx0ZWRfX7ly8OO9oUNdC
 SZSiGjmr7/5S7HtzX/IDn7FQ7hecxBCQ59/WV7q0FuzCkhqg1dAMwMjibtVVSRKHqZSlNlpTsGh
 2815eDZS76j9lu7VBlx3EOJkTetISOBpClzZfAezhU22oVSvWq30Dy/daf8/maurIXSlsm0ZTMN
 1j30QYrieML7eXDRYHfBmUmWGo3QjwnXd3fvHQ9api/I8yAX85RAJiZff5NPw5skpNMAiMR21WR
 kKyVLbZ4t1hPwwBrDRYcyqE5ocbJooyqQZ93myNcvFm53HuQ8ud0vDErVKqVoj+gYpKvubfUiHd
 uwpNbeOgNYzmQpiplfi8ZnC66MYsY60wGDlto5QoIuvJPx9Z72l6QKncu+cm+DEuDTckBxyXxgm
 6t10mnXAGjyI6w+BkIStiqufwYNQR6uU9izYCQfmHQAJYCIUC8sPVdfAr0y9D09r8LbdGkVeDG0
 I1Ip5C/zlr7sfysghtQ==

On 16/01/2026 08:30, Alexis Lothoré wrote:
> Hello,
> 
> On Thu Jan 15, 2026 at 5:34 PM CET, Alan Maguire wrote:
>> If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
>> Add a ___local variant to support cases where vxlan is a module.
> 
> Just a naive question: for ebpf selftests, aren't we assuming a
> dependency on a "fixed" kernel configuration (ie
> tools/testing/selftests/bpf/{config,config.vm,config.<arch}), which
> enables most of the features as built-in ? 
> 

It's a good question - my take here is that we also need to remember 
that most folks interactions with BPF happen via distro kernels. Most distros 
tend to modularize their configs more extensively, and they also want to use 
the BPF selftests to qualify the particular config combination they have
so that they can be sure that users have a good BPF experience.
Often issues arise from this, and distro folks either report or post
fixes. This is all good, so if the only cost is a bit more flexibility
in the test environment, I'd say it's well worth supporting that. In
particular blockers to selftests compilation cause problems for this
process.

There are of course cases where having a very old toolchain or a highly
incompatible configuration that aren't supportable, but in general where there
is low-hanging fruit in making tests a bit more flexible, it's worth doing I 
think.

Alan

> Alexis
> 


