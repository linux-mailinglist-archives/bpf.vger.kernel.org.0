Return-Path: <bpf+bounces-75986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F883CA15A3
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7943079285
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0D31A07F;
	Wed,  3 Dec 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVSIqhyb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MJ/iabM1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1F398FAF;
	Wed,  3 Dec 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787810; cv=fail; b=GGhmlZZLiRkVXQEE1L8LdO1pPR+iUs65e8ISX+zZpjCKBKLBZs1MMieLrAihJbcJKLH+8sYH4zbpcwDPRLsZGLzjZj2jN7i5GXIqvNLmkTOVs+hF8Db+T0EAlc59QmYTlJ7IEJqUKQW7XFc2Ee8tudVQ6N26FZIDGCefWXApA0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787810; c=relaxed/simple;
	bh=9jMARxOWU37HsL4vOpxKqQ4zF0d3fkqkLoYew0XDWAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TmbSmAyTBaHxrBWDhgNcn3NnY+ik8A0yI35l33SSrEurnZgMF7mzzhpboTJgBkukT2TJ0z9uAD1L7P0DCwl/w4Vg2hMClPbXxJAui6uarht0KiREg1JhWkCKQQan/OkaodLvDOP56nuMMa9KeZ4IlkHdnxlQ3e6wsTLFUZamu5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVSIqhyb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MJ/iabM1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3IQthn3365417;
	Wed, 3 Dec 2025 18:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hHsUKqNaTcrboTnrhMbfYpSSrbaoCFRYAfmXtfNY6Ms=; b=
	eVSIqhybq9PxljJuFG3IOxGNZl23aw8gYTPHwPooI+Q3fmv7EKVn7vGenqayFo1A
	Mk1cR/60epM41KIj3eJwXXr3BWV4LmtmlzEL/ddQ8ARejUKHMEuFm0fen1XnQMoi
	Bfd/UrFwzvoLYZYVhHNhASaPXCqSC/gJH77p9tyERcQR9fnOJ/Z9wgULtbKyJeZb
	Aqo5h9mNCUbGU5xHpB+3Z9/NWrQB0qCUwbaVTj0N7YaTfbMi9+drXWVm255SbobF
	cDRAdBDFZYASgtCVxlWSGp8Mtbz/23WGxV5nSOyh4XVqxFXsfMPmD82+6qvomiXL
	s8UcNgEBOeHg2ha2IBEY1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as6v3e1uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 18:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3HPDfk015016;
	Wed, 3 Dec 2025 18:48:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9b2k62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 18:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oR9ZSkFgYQ6w5K20I2Tz9DmIg57e05feRpaY2jxNb/wHkC7/R/9tKxcr20hBc7VOWxoLmCw8qCz9jHVnMGup7E+VWxpWYhgOCLgXFsU62maNXAQix3d2WOpk9dR+fF8QFJXIl48LkMfUyBDX01xdq507/JRQElatQgJCMY9p/eqUU52prUorVyQwr5bTBIaxoLOIttyyrd366W2jm7HLyAtSZowh0gIbqnVneeMnAME2wc+o30sdYrJ5dkaM6+dVZbdaGOFzgliS0sq4JbE0HlM0P6Fn1a2YNqR6isVzUmqGNNj4JKjbLdrpM1y5aj8z/mhEzxkzs5zVZQEQsSwe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHsUKqNaTcrboTnrhMbfYpSSrbaoCFRYAfmXtfNY6Ms=;
 b=hbxpGmh5V+Ud/ayXs0DHWAc7dy4rsG4zSvqVFuvoyZ+5FcEu16ka2pFvlk28Hk9cqsZQM0C1T2DN3c7fE1e/jknMSfc4ctulVh/rNxGctuoBqh707kwWkFU9OmlhqpXg4kBBlMc2Czlfm8Q8PZUklEdqDsc14kZ6keQ28x2fpOqG5Gs/FwAecGfHtChMpK93ircWzSUDLcA3J/34wQtIyrgQ33q3GytmLhEqMhNpxzsh6kCyz4zpwbQz+KJdHyl9plD540XYjEdZgupynAW22ZPhWKlHqIzLbLHawXlfYYQaO3ZFKolVPoI00+TmJ6/1Sg/bDpaBUh2Q241qTLuFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHsUKqNaTcrboTnrhMbfYpSSrbaoCFRYAfmXtfNY6Ms=;
 b=MJ/iabM1FXVelCBI6dU/s6+nnYWbJ8EqQQ7GyDcxPUSSN5pEU3yv2ryrUUkOernYLJLpif1H/qcaHBvgnoupj0Pn4/T1Dv3uwhwDLf3cP31zJ8fH5b9i6EOiVQAILb11MBT+Q+fGne+rrSmyKIdgyrkoQTqgdi82HIZV1LQfBF8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB6049.namprd10.prod.outlook.com (2603:10b6:208:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 18:48:25 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 18:48:25 +0000
Message-ID: <cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com>
Date: Wed, 3 Dec 2025 18:48:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <CAEf4BzbuHChnpoAGm1EJt6tVbW7yruV14BCD0iMeJmNt1OyEiA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbuHChnpoAGm1EJt6tVbW7yruV14BCD0iMeJmNt1OyEiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0641.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 244b7ef8-7f0d-4b1a-3a2b-08de329c8a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGJrQjZ6Rk9PYXNYZm1RdVVDVmxLeVRTa3l0S2tHSno4MFg5T1BFL1VhS2g4?=
 =?utf-8?B?b0o4Y1BzUWpQQXFaeGpGWmdVbGxGbktTd2M1VjNGb01VaUNXMzBZdEd4RHRp?=
 =?utf-8?B?SWl2SndvdWlyVWdnd284alMxTjcvYllkVjdvR0ZlOTVTR3JqQkduSkJaTWQv?=
 =?utf-8?B?dXpaeEM0UGNiaFB5dm9GTnRWK2QvV05vL3NRYjlaeWZ4S0NjUjBaMDU2YlhL?=
 =?utf-8?B?VllHQWFWRVQ1c2F2YjBoSU03MThqelVEbWRjYjAvUXN1dTlBZEQ1SGp3UUR0?=
 =?utf-8?B?QXpENlR6OXhYTmRZTGdKekhtRzNMUFVaVGdFR1JzeWRoMTlMS1lZVmJZNTBq?=
 =?utf-8?B?SDJNTkpQK01NWkkvRHdGTWo0cHhtbVo3Y3VHMW5Gcm1NLzB3RFFOOFJDZXNt?=
 =?utf-8?B?dlVmK3FVQmp4UGswRnltV3hSOE5wSWQ4SFFTazlZUFVDWFBNNm5UaXdXb21W?=
 =?utf-8?B?bTl3NzZEekdsWjVDd1hrYVExNHJKMVl5SWd3L0pqYTJjVGFRalJRQ1ZRMFFa?=
 =?utf-8?B?K1RNd0ZNTlJxeHBNUWdBdWZzQ3JWc3U2WDVDYkJOd2FDSTlwREdqQzIxY3hB?=
 =?utf-8?B?aUxtdC8yUFlHYy9zaFpVQUcxM1lwWDhrYmtBM2R4SUFCSU9ETFR3MHlRRTdL?=
 =?utf-8?B?VFhGMDhReHdnM3ljNGdZd1VZNlRvb3ZiMHE1eVJhS3BaY2psU2o3K3Fha0x6?=
 =?utf-8?B?bUlwUnBlaDhETXFGUWZzQm4zZThYL0VZYzBFcW5BM1piNU1tbmZENnJRK01l?=
 =?utf-8?B?L0NWMVl1Zll4V0FiU1ZvN1Y0VFMyS2RCdXlpZmFMQW1ZRUo3WEpPcnI3NGZ2?=
 =?utf-8?B?VWh5eVVTRWw0RkhNSHZqS0kyUktpTFJhazJ3U1dpWE1DUm9NZzFTSkFCMXoz?=
 =?utf-8?B?MHBmRXFDQ0ZOODJTY1NNT0FWRDd6R080OTBuQm5VNXRWaFpmaEtyd3BnaG1w?=
 =?utf-8?B?azg5Qk5veHhnMXBXVFNDTXRqWnlSenc1eG5oekxYR0M1TVJhU05HY1dhN201?=
 =?utf-8?B?Q0pZMkpYaG1IQVFMOTBsdUl4WktOaGxXOXNlSnRBMEZhMS8zV0ZySFpSTEFH?=
 =?utf-8?B?dTZURWFGdHR5QWJvOWFPOHorbEtYc2t6SFRjUFpkSHp5S0pZS21Tc0lPN2Fn?=
 =?utf-8?B?S2tBZ2pCelZGelpaRis3aGt4YW91dUl0UTVickdTTDVSZzlZckg4dUsvajRw?=
 =?utf-8?B?UWpyNWZlNUFEUEI0NnFnNEUwNTVPdGM1UVlNTzNVbmFlUS9kWExjU2R6K2pa?=
 =?utf-8?B?V3FHQSsxbVJBaFllRExTMTY5cW1SdTFjQS9ZZDNQWlBVeDc2SmdjeTJBcTdG?=
 =?utf-8?B?YzkzaFE1T0w0ZWQrVjRjWkthR1RpRlpZdGh1SVFLUWl6SENhclhsZ2ZudVVi?=
 =?utf-8?B?V0o5YnZRK0VUbnh5NmZEWkZvNTBiZ20wNVgvQlNTL0FVQmxxeS9lNDhwUkNZ?=
 =?utf-8?B?L0V4SkVTRG82ZXBpVXhhdVFLSks0TEZ6d25vc3N1eHhRNXUvNnN0N1BBY3JS?=
 =?utf-8?B?WCtCTndqVXlIMkhINS9hQytuc21iZUdSLzFBaDVwcGVRenBpSlBLVDY3ZUdj?=
 =?utf-8?B?Z0dIdmVweWoyVUZsM2czTW1OcVhId0xlZ0RENm1IUkNsd3MwbUJJQUtQV2to?=
 =?utf-8?B?V0hjcGh5TnFsYVloZnlJQkRSeW8vTWpMeXd5dC9BbklFRllSNmRuaEUxeEpK?=
 =?utf-8?B?WjJXVUJEUjFvMEQ0NUZmbzMxMnZINk1jNkFZcVFUem92UkR4QmZPMWl0eWly?=
 =?utf-8?B?cmxHZ0pPdXBPMDhpQ0drUkdJMVlDS2RtWVNIa1EydlVlcWxsS25kZDhzTXhJ?=
 =?utf-8?B?bGptczRUR3V1VnFKNFYxakpyMGY2bThhYU82dmJCQkYxcFNqWm9sSldlN1dE?=
 =?utf-8?B?c0xHT0RaUjdBaW9ySFF4TEpNU1JBV0kveHdIeFF5d0NtMXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC92aWtKY1Z4OXBReFdVblFUN0RBc095dmJkMkVvNEhWRy9vNmNQZG10eENP?=
 =?utf-8?B?YWsxK08rd0paTTZqQkZySVFPcHRUMzZsQWM1c1l6TjYxcUNTWklxc2FvaTl5?=
 =?utf-8?B?UHBYK3lEbkg5SmNtSFVXKy9jMmZpYXlUZUVFRmxOK2MvRngvYWhKN01VTjFh?=
 =?utf-8?B?TjFwdHlSdytzR3VJTmVWL0NaVHBPd2s1TmEvbVlNOVkrdkFnL3VJTC9nNFl0?=
 =?utf-8?B?YUZFcUwwME9SUjJDekpjbHdwaTR6SEYzSEJuMVJ4VmJjZ3ltUUxTMEJta3Nq?=
 =?utf-8?B?Z2lWZjlFUzRldSs5blZNR2NaSnYzWXhyR1VtelVkQ2hKaEFGdmFvNC9aalNJ?=
 =?utf-8?B?bVlUSDVuVjVKQTkwNVNNWkJDcHRHanFnZVhxcUtrWXg2SG5NaktkNjZnVjBj?=
 =?utf-8?B?TTdnVHBEd05lQ3BoWVNhNGs3NWNrS2JzRmhoTkZRcGdoZmJOdHdXdFBieFJq?=
 =?utf-8?B?STNIYUlVanl0RVRIczBTS2dCejVVSFdEcm54dzZ1YnFieUFwdXFkbGo2NlFJ?=
 =?utf-8?B?SVFsNk9zZldiVTZDQXdUVXZ6ZUpWaVZiemRNQ085eEpObzVOVCtPdWoxNlg5?=
 =?utf-8?B?L3Zvdk5lc0hwNFF0UFFpU3BQaHZ4V09BMHZxQmJybWRDTlpJZlhyL0twVGlH?=
 =?utf-8?B?R0VzYStJWUpUemRWS0luRW9jMGk4RVNBOWUyYjh3SzlPVkdiVVE1TFRhTkND?=
 =?utf-8?B?akRCa3NDc3g4bC92TkFtMkwzbjB1SW4vRHdFOWxXdFhheXVKS3NkMUNkc0h1?=
 =?utf-8?B?YnY5aUpzQndJa2o0UWRZaHFwOWZXS1Y1NlZPbXo4TWdMdmFoWDAyb1BtMWpQ?=
 =?utf-8?B?ejV2ampjOURNbTczZldyd29paDJ0MHZYd0liS1M4UU9hcW5oUUhBRHlrL1hP?=
 =?utf-8?B?REJCTXpPRzVUbzVjSTFIazl3bUpQQk1NUEdzRDQ2WmNiVjlrSFhYTWg1bVgv?=
 =?utf-8?B?NEVQWldSVHhZRXY3bTB1TWQrcjZ6QTRsd1lKM3lxaDNGMXJNWDdBTnI3cEty?=
 =?utf-8?B?SkJDZUFXa3g4R3V3aWJ2Vk0yWmZmd0E5MkhnL2ZmcndQWUV4WnVuWTJBSmVQ?=
 =?utf-8?B?eHNMcUs1dzVyR2ZVNm41cnIxSFN3NXpCRGUwWnhLT2UrWWZwSi81K0R4akNJ?=
 =?utf-8?B?c1pmOGVMVEdXOU9UNzlIRml0aExXS1dLem5KOGFtNUdXTHZpbnpoSTRQcVVX?=
 =?utf-8?B?VmluM0FCWnNPWnY3ZTg2ZUc5NlBJaGhrVXczUVAwMmgreU93L25teVUybHpR?=
 =?utf-8?B?RHZ0MFBpMzRqcFQ3RXBrTEgxMXZrYm44RzhVQkJwNHJ1b09MeUozUVRzNW0v?=
 =?utf-8?B?bFBhNEZsRTBndlN2QWFYd3BpOHB1VDZ1bjUxa0t3SHdzTndWcDVrd0VtOStD?=
 =?utf-8?B?TzNBVXhvUlVmQStMVjBkcTQraEFObEFJRXZFdGVIWnZLR1lvTDdLVVBZZUd6?=
 =?utf-8?B?a0o0cDlzVk9Ja0JKT3Q5M1ZGQWpKSElZM2c1aWdmTzVabXpIOFVJV1drcG1j?=
 =?utf-8?B?R2dkRC92ZXhlc2k2UnhHQ3l3NVhEUG5CWUpBNXlxZStpZjZrZHZlbWNRbVZY?=
 =?utf-8?B?WU5XSXQ3WDEvb0pZc2tZdTkyNE94YzFJUXFPMjZlZWQvbS9oZnU3WVE1Yy9z?=
 =?utf-8?B?TG1uUTlnNWxHMG9WZDRJdlFKdk5RbnEyejBONFYzZlVOK3V3ZW80QnNJT1BY?=
 =?utf-8?B?SUI1elJzRVM2SE83c3JzM2ZxMVFxN09DUUlkVERZcnN0M3VBbW8zU0pZVmRk?=
 =?utf-8?B?MDlsSHY3UGdhdDgvZFFqdVJtWGpHc3huNjFEdjFFS0ZXNloyanZ3b2s5L3Z2?=
 =?utf-8?B?VzBUeXVDb0RXNERYNUFmbWY3TkEyUGpWZXlWYXBqRFVpTXBiaFppS3lrcjJ6?=
 =?utf-8?B?c2NKc0ZnVTJ3cExad3Z6UGp1Qmxxc0UySEZTTnlCZU9IY1AvbitkU2Q1TEd2?=
 =?utf-8?B?V3ZCUXJ5VjRHeUtRMzVvM21aYWdvSzNEREF0QlVyNzd4aURTd0hKOE1TYWk1?=
 =?utf-8?B?VkcxbEgzYU1yY2hYbkE3THBGYWpYbkJJbnFScXhDaXcyd0dHN3FXUnJlZXpN?=
 =?utf-8?B?eFpiWVhMVndMM010YmVGTXpML2NLTiswWXJhM0tQZXNZemtGeTErd0Q1bmZv?=
 =?utf-8?B?US9ENkd1ZWtqaWJRWXVYYThyTFkrUStURHgrRFBjR29SelFKNUVlL0xTcDhl?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBqnwQGRC85Fg8ojmveyh1nEwznAFLybZGXaszVvPMACbYYCwmrLE5Ewqaq2i8hb9QPGfPtus349U0J+qiQHIHhzh+OiBD5TmSuTVoYF5YwZGrSMcJEBfxLwGjSGoeGJOS8w+XnB0DCYGT5t6C4bXsoE0S809jJeWIfXtblPyJk5OD4pSrFszf1Znpv/367wcpZ3zWahaGKiKYmG6mnAkJQ0MWiiPMCcua5BjKLja+eglmtQ/FcAm0X4mneLuiOVSnxVRCeSGca0QUu09hRR1XPqzD/98QeWzKHw9XPkNZxYmII7L0baF87Tk0d3Yb/4k7mwaE5yCiTGwQDJFFwZnya0ihNhfXhoFBzHr7cjeseKHcu2xzTELUTnDarEBKWAi4JEptahA0oPxe/nQc+mg6rywchr1Ntw26CKLCVU2zKS7OhU+u8iQWuXXfZk1bLtxxDQn8exFDJH1+fRZFTnHvRoP9tkSgHYVCBnVSaxuROct5Kwsrx6ba5QhGDKoHUsVVWGpo++bX63VyggBxMAMdcC1nacjjmnM6iAnVreOEkDB6qoZ7B/DU9WZuG1zbV0iYMxcyT9v3WcuR9/dH/AWX44/MqNNWtKkarEZULm5UE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244b7ef8-7f0d-4b1a-3a2b-08de329c8a32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 18:48:25.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiNru909Lq9b/ZlqlBT2zTnJhQ/rLcx5Wk4Gydl+UzEnJtl4x09efj6O6/M+xORH9fmyoSQMQUKCjbZqvChF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0OCBTYWx0ZWRfXwq2I6frMkGoe
 JzOAYhjZXgjcXgH7ikr0jr0i1TlQVyv2ZMGKahXotS5EAuq4WHQ6/jdQd3wFk238CDX4GeLFHJQ
 Yd5jyxq9FDqOYUde1jIxl94FlcPr9VXr+bGhM3dY8iiy5XTFhHHJF3nUtRT23Is3dmGQO1n8K7Y
 Mqn2x4YObdXFRvbXbKhYiKPIgJJmw1x0rNzpe3xJHalzSvcJ0BIslClv353Dfh9bCg85bE8DNWV
 3jm86iNEhT1uY9vdR6fcuZ6B/2bY9rKMkpx6Oo3rtFgsXON+E73lnYwYLzwobd4OThHaRAtwPEy
 dT5NlLIPZRm7y00Z7raQAcw0nP7nxwzbyjl/GsNMSl5fYQ8mzfJsjlR0Y56W+Dx0nlrw0Fq87jV
 JgPmMHiUZi3kBj2+e4UhZ5KnfRk+BA==
X-Authority-Analysis: v=2.4 cv=fqjRpV4f c=1 sm=1 tr=0 ts=693085fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=Xpcf719GfyqPs5eFV3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bF-b7yd8Jd5ceFk2ruCRGHfe72_JNtjs
X-Proofpoint-ORIG-GUID: bF-b7yd8Jd5ceFk2ruCRGHfe72_JNtjs

On 01/12/2025 22:16, Andrii Nakryiko wrote:
> On Thu, Nov 27, 2025 at 10:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Currently resolve_btfids updates .BTF_ids section of an ELF file
>> in-place, based on the contents of provided BTF, usually within the
>> same input file, and optionally a BTF base.
>>
>> This patch changes resolve_btfids behavior to enable BTF
>> transformations as part of its main operation. To achieve this
>> in-place ELF write in resolve_btfids is replaced with generation of
>> the following binaries:
>>   * ${1}.btf with .BTF section data
>>   * ${1}.distilled_base.btf with .BTF.base section data (for
>>     out-of-tree modules)
>>   * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}
>>
>> The execution of resolve_btfids and consumption of its output is
>> orchestrated by scripts/gen-btf.sh introduced in this patch.
>>
>> The rationale for this approach is that updating ELF in-place with
>> libelf API is complicated and bug-prone, especially in the context of
>> the kernel build. On the other hand applying objcopy to manipulate ELF
>> sections is simpler and more reliable.
>>
>> There are two distinct paths for BTF generation and resolve_btfids
>> application in the kernel build: for vmlinux and for kernel modules.
>>
>> For the vmlinux binary a .BTF section is added in a roundabout way to
>> ensure correct linking (details below). The patch doesn't change this
>> approach, only the implementation is a little different.
>>
>> Before this patch it worked like follows:
>>
>>   * pahole consumed .tmp_vmlinux1 [1] and added .BTF section with
>>     llvm-objcopy [2] to it
>>   * then everything except the .BTF section was stripped from .tmp_vmlinux1
>>     into a .tmp_vmlinux1.bpf.o object [1], later linked into vmlinux
>>   * resolve_btfids was executed later on vmlinux.unstripped [3],
>>     updating it in-place
>>
>> After this patch gen-btf.sh implements the following:
>>
>>   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
>>     raw BTF data
>>   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
>>     (potentially modified) .BTF, and .BTF_ids sections data
>>   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
>>     BTF output of resolve_btfids
>>   * .BTF_ids data gets embedded into vmlinux.unstripped in
>>     link-vmlinux.sh by objcopy --update-section
>>
>> For the kernel modules creating special .bpf.o file is not necessary,
>> and so embedding of sections data produced by resolve_btfids is
>> straightforward with the objcopy.
>>
>> With this patch an ELF file becomes effectively read-only within
>> resolve_btfids, which allows to delete elf_update() call and satelite
>> code (like compressed_section_fix [4]).
>>
>> Endianness handling of .BTF_ids data is also changed. Previously the
>> "flags" part of the section was bswapped in sets_patch() [5], and then
>> Elf_Type was modified before elf_update() to signal to libelf that
>> bswap may be necessary. With this patch we explicitly bswap entire
>> data buffer on load and on dump.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/link-vmlinux.sh#n115
>> [2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c#n1835
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/link-vmlinux.sh#n285
>> [4] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
>> [5] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  MAINTAINERS                          |   1 +
>>  scripts/Makefile.modfinal            |   5 +-
>>  scripts/gen-btf.sh                   | 167 ++++++++++++++++++++
>>  scripts/link-vmlinux.sh              |  42 +-----
>>  tools/bpf/resolve_btfids/main.c      | 218 +++++++++++++++++----------
>>  tools/testing/selftests/bpf/Makefile |   5 +
>>  6 files changed, 317 insertions(+), 121 deletions(-)
>>  create mode 100755 scripts/gen-btf.sh
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 48aabeeed029..5cd34419d952 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4672,6 +4672,7 @@ F:        net/sched/act_bpf.c
>>  F:     net/sched/cls_bpf.c
>>  F:     samples/bpf/
>>  F:     scripts/bpf_doc.py
>> +F:     scripts/gen-btf.sh
>>  F:     scripts/Makefile.btf
>>  F:     scripts/pahole-version.sh
>>  F:     tools/bpf/
>> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
>> index 542ba462ed3e..3862fdfa1267 100644
>> --- a/scripts/Makefile.modfinal
>> +++ b/scripts/Makefile.modfinal
>> @@ -38,9 +38,8 @@ quiet_cmd_btf_ko = BTF [M] $@
>>        cmd_btf_ko =                                                     \
>>         if [ ! -f $(objtree)/vmlinux ]; then                            \
>>                 printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>> -       else                                                            \
>> -               LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
>> -               $(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;             \
>> +       else    \
>> +               $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
>>         fi;
>>
> 
> [...]
> 
>> +if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
>> +       exit 0
>> +fi
>> +
>> +gen_btf_data()
>> +{
>> +       info BTF "${ELF_FILE}"
>> +       btf1="${ELF_FILE}.btf.1"
>> +       ${PAHOLE} -J ${PAHOLE_FLAGS}                    \
>> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
>> +               --btf_encode_detached=${btf1}           \
> 
> please double-check what pahole version has --btf_encode_detached, we
> might need to change minimal supported pahole version because of this
>

yeah, this landed in v1.22 [1]

One thing worth thinking about; are there aspects of the gen_btf.sh
script that could be moved to Makefile.btf to avoid having to compute them
repeatedly for each module? For example computing resolve_btfids 
flags based on CONFIG_WERROR could be done there I think. You could
also determine whether the script is needed at all in Makefile.btf; i.e.

gen-btf-y				=
gen-btf-$(CONFIG_DEBUG_INFO_BTF)	= scripts/gen-btf.sh

export GEN_BTF := $(gen-btf-y)

That would allow you to get rid of the is_enabled() I think.

I'm building this now, but I was wondering if the linking/objcopy changes pose
any risk to kernel address computations in kallsyms or anything like that? IIRC
Stephen ran into some issues with global variable addresses as a consequence of
linking BTF sections [2], but not sure if there are additional concerns here.

[1] https://github.com/acmel/dwarves/releases/tag/v1.22
[2] https://lore.kernel.org/bpf/20250207012045.2129841-2-stephen.s.brennan@oracle.com/

