Return-Path: <bpf+bounces-48265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6DA06345
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3D67A1C94
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229891FFC6C;
	Wed,  8 Jan 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XuTlOPzq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZymhZHP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A11F239D
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357052; cv=fail; b=QNLyG4srXhzV+1cgtHCYjLIxQ6drE5e09MbzE8zefmkGZTWgDLoZUU1wIrQlMG5Vr2WG1u7OWNHzkRMVcFnmwRc4iEIwIC5fZFUpsjGk4d8n9DHPuyadEIpesfLymK0ufLfSvc02uh6j6I61uXPf8dQGg2vmCsdiFleJ88TTtRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357052; c=relaxed/simple;
	bh=X+67QweHQzLpWi6IJHSM9Op5E3QmLrOUuj3Oo2w1+FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=WHMn/+b5v7C6sEEJtDhQvYG/LT5kp9WIFrexdYOE5UfCPaVVxOGan27N/b3QQkEaqbebTvlrdlJtp8aV93dSXdU/bckLJ2KWOFyr4pVXMnuBRhodxhR+5JMxX9GEV34TzNgVawqsz9js07lTQ3fkFSJGlLSanh9elUg3TQimAN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XuTlOPzq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yZymhZHP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508FMjFX026596;
	Wed, 8 Jan 2025 17:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g2thgMy0sOiVASSsHfsTT5CTigPYYgvfJVr52FjQgvM=; b=
	XuTlOPzqPoAuDidicwTUVH9K8Ufu5NxwlfIi5a4ilqYH6h0kyjTW8LwQ3cc9SdtV
	FnbLmZVWnCeXxmBIkK5TCBnd89pkYgl1ghnWHrd3lRtmkAZ8FDku4AY+aktsa9aa
	lpxtfhdkcSlKbR9wneBqd5KGk/Z+NdfbmhBTdiSa1A/929SHiR5cIX0b+/fVWhye
	+qvobo/ykkVbFRb6jvvkgpcJXHUUd4sgrLc3Ea04NZ+OZ611QApXG/1x1lqKFhWX
	2hJdPINe1s0KCHRWqU7Ta2JkOVC5proEEHvXA+NNfCQMktNsJdh9+I9LmSBmkRce
	og1O8JpKPBv0zV3Gtmmgxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb7c8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 17:24:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508GnG5S011203;
	Wed, 8 Jan 2025 17:24:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9urjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 17:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArV0vaQzn412jp3JZ6lxjWr6M8fR03KykFg+EN2h1sVn0YMB0XkwmVgD8XyQy+3sQgl6M9VXN/MXP3IbPS+3B5WHcDG1grC+sL4AaRGHr6i46Mps5Fc2Bm2rHfKXSzo3iS9S6nBJNu9RopVApS+I4GlB5cu5CAgMa8lAa5HLbxLTSfs6RpUuMPsQ1YUFNnIxAXZ/VrG1luhGwYX4E0I8nPlehCT0WGVqmC0ycFqVGXTOtMWXb/Q/X01QA6Ipfz2KrkyBT2SWrl17anJqRCH3k23pIuPaE8LKqqpZoENf9Zlj1Yqa/tg1jXbdmPvJyBSiuNURJ+RW6HIGQ2appykQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2thgMy0sOiVASSsHfsTT5CTigPYYgvfJVr52FjQgvM=;
 b=EipcvWCexPhzu4Rm7pZLUxdlYbs129sZQcZGzWkoKez0Ttsk8jRO+lqSdtvRh8QpysRuq0iFLstOkNcTApa2rktPks9Q4JIRqqDiBub8Kd5LCIwI4e+0ErFP177TC+CkQaGAB45pxkmjDa+Q0rodzUCwJl/9NzUNlAbTkj8/6Xt1+vT/4vutWJEIXf1WiGmcoV3uF6K/BRDXDoLQScUGXzNuIYRVyQQU+7VFf7CGGq2w9HtzYEX6H1S9RAU0PPC9peNByQnrFRFyVg16T5dqSEuV5TrHKV6F75XPG70tYxUJTL3jVhqgjDZFh+GSzrFsxD3BgO9ksUOXr0J0JXtocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2thgMy0sOiVASSsHfsTT5CTigPYYgvfJVr52FjQgvM=;
 b=yZymhZHPQhwPjn1DvySqeh9e+3rvD/WTuvghgJIXdmSRAFhw7rdmL77DUQfX1EnqslOtvfqMNWTRysIjiKNP24Z1tJ1cjRNKDyzsinHmc2AedSDiTbN9QuE+mhvye+tdn1sDbLaKHDsityts70yVtsYWl4yLMMxEsOiVMaYbzlg=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 17:24:00 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 17:24:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: Compiler support for BPF at LSFMMBPF 2025 - Is there interest?
In-Reply-To: <CAADnVQJZTJSeZmCRhpNSpw1WPN4xgG8cuMcOr3_hYZ7=aQWfKQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 8 Jan 2025 09:10:57 -0800")
References: <87ikqpmf81.fsf@oracle.com>
	<CAADnVQJZTJSeZmCRhpNSpw1WPN4xgG8cuMcOr3_hYZ7=aQWfKQ@mail.gmail.com>
Date: Wed, 08 Jan 2025 18:23:57 +0100
Message-ID: <87zfk1i5hu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: e879f8fb-7e5c-4fb9-be04-08dd30093d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vndaa1ZLTVFRMUJJK3hjV3BpR3Z0YkIyTERhZTZFZWRtVEN6RmRDN3o3MWor?=
 =?utf-8?B?OVlWcUc2TGdNamcvU0pBVVUrTkpqYTZLL244QkNEeGdGRDViWUZNTmxyN1E5?=
 =?utf-8?B?bUV6WGhXdU1iM3RDT2Fra0Y5TENEWUxuNmx4UWRzOUNRTHR1MlFLR2paT2ZN?=
 =?utf-8?B?WUh0MXdJM1dIZThueUMySTBOL01qYXA2b3krL3ByeGhpZ0JZMXp0ZEVRUHZZ?=
 =?utf-8?B?UU5UelNtZXJLT0pnQlEzeE41Y1VXd3ltTTh2d3pHV2dVN05LRE5OSXFYNFcy?=
 =?utf-8?B?N2NEc1hodGtYa2VNVmNrMmFrR2daTks2MzJXY21wRWg0TkRLeW9TSlRzTCtt?=
 =?utf-8?B?VXBaZS9xbG9uNWVFOEFwc2Vta2Q3T05RSkdEQTk5b2ZWT1hhdVNteWdOUTFV?=
 =?utf-8?B?YU5RaWpVaDFZYnpoQjE2eHJaWXkxUWpxUTgzTWpDMTAwdUw3bitNR3dXY1Zi?=
 =?utf-8?B?YkttYkJUNXo4MEJLMWM0STlzQTRSa2FYL0ZwQ2tyQ0o2YmVlZ2hCaXNaR2Vo?=
 =?utf-8?B?dlQycG5QbzgyYjNxTnJpakF1ZDhxOW0vUVNhWS9LZHFLSndwQ3UyNWZjODAy?=
 =?utf-8?B?TWY3SzV1RTEvbDlWQ2QwV3R5TmxTSndwTzFseEs3cHorRU03cjBvK0JXVEVn?=
 =?utf-8?B?dGFwdzI1Mjc4T0t2T1RxQXMrUy82aHRhbTBQdVFWcUg2T3hKQW9Cc1Q5cXB3?=
 =?utf-8?B?UjhJNVRaMnMwTFdEZGNXRjYvT2NUWHNYS3ErYUw3L1ZzQW1HK0dKK2hWZ3hH?=
 =?utf-8?B?T3pTTzJKQjZKV25CMFdTZFpOZDJRdUptUGtTcWtacEIzQjlVZWlDN3pQYXVQ?=
 =?utf-8?B?K21OenJ4bHVUb2dEN1BXeFpFR2lFbXo3M1RvbWxYOXFOOVBUM0FvSnN5RG90?=
 =?utf-8?B?UzNoVGs1SVZNUXlRSlI3VFYxLys5eGppTjh2TldrWklYVVZXQnNLOGtoUm5m?=
 =?utf-8?B?a09MMS92OHBCem4xYXp1Snp1SXNWZGlMaEZPRmVhcGQyMkJxVXRBZ1c1YnZw?=
 =?utf-8?B?dWM2S0xnOVhrZCt1dHlGNS9LMzVtRTlEaDhhT3V6RU9BTnZVVGNYQ3ZDTksy?=
 =?utf-8?B?bWx5dVJmKzZZcU5uQktoMUtma1k1b1BCRUZ6TVBpa0Qxajk3N2pNK2xONjdw?=
 =?utf-8?B?TVBMaUxNQlNnR3MwSGpZWTUzTUoySk9UZnNMYW85Mm0wdE9VZ2o2OTYrTHRM?=
 =?utf-8?B?TWFpKzZ5eDFTTTlJTUNtVUY4alh2TnVsUjhXMTN5RWFjV3ArSVpETnh4QjVJ?=
 =?utf-8?B?L3JuWGE4b3JybFlNd1gxMXJaL2lpbTVHbHJZajZwYm9JSUhkd20xYnV6QlND?=
 =?utf-8?B?M2d3ZjVBaloxUmFzampkc3o3bkZpYkdMZUYrYXJIYktEMDNtM0NNRW9Bd3gw?=
 =?utf-8?B?OWxLQWVWa2ovaWRLL0FVU0RmM3piQlJNM1MzRnZVY2s0bGhrOEtBaTZBcWtI?=
 =?utf-8?B?WE83cXMya0ZTdU1yQ1dvNi95dGtDaXkycUhnTXU3QmxyT1h4TDRUS1FQWkxV?=
 =?utf-8?B?YnpaVG1obkRRYXV1RXBHZ1c2OTl6bk84SkdUdUpPdmkwcjFhdjR2Qjdab1ow?=
 =?utf-8?B?SjV6eitWbW5yRWRicVRZdUF6RmgzMkNvalVvbFNLb3YvL1kwVDZwa21ZS215?=
 =?utf-8?B?NXZOZGpOM1M0STIyRWtwSThkV2tHT0VCZ3pKRGtiVU4rbFpQOW82SUhXVm9Q?=
 =?utf-8?B?Yk9OeDRRNXBrR2FWRUZQWjVibGhWcU50TXBVNEt4SnpxeWhKdkJucmVpQUlU?=
 =?utf-8?B?YjE2MUlzcUxZZGZ3ejFSR0cyWWtTWmpLZWtyaS9ON3ZXUzJ5QkN1Mi9VL1do?=
 =?utf-8?B?WFoxTjJiZ25LT2dBS013bFZ2blVvZ1lQbjVvanc1Y1JWemtqOHV6eittaWZt?=
 =?utf-8?Q?RdWpRn9fRUXUR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXdDUjcyRzhRNyttUStaaGo1TFJjRFFKampCbVkyNmI4cXBHVHNpTWxFVXV6?=
 =?utf-8?B?VjBqWm5pK002cWdWTUUrN1JEd3JoeCs5THpLR2xieVJIU2lmQkRoRWNnQ1lo?=
 =?utf-8?B?RXFSRXIxMUt4WFNUcmJtc1AxL3FOWlVRTFVVK1JKdDJ0bnpBSGNNcUp5aUF4?=
 =?utf-8?B?Q1lGbVFlY2VTYWJWSWx4T1Z6aEFaMWc2anFwd0kzRStLc1lxVmlVbC9XcVcy?=
 =?utf-8?B?TVI1bVhEMWR5Y1NaaTlDMFdsYWsxT1dqa1lUcWZwM1kxREZIUmhJMGEraTdM?=
 =?utf-8?B?TXE5TmhTRFBsRHlmTUI4WWZxOUIvK3c2djNua0RRTGlBMytEUENqUDZJTDNa?=
 =?utf-8?B?ejY1c3NnazdaMUladmRyVGR4M3REZHFYRlBCUGZTdnBWd00xY01LQjA3Q2Ri?=
 =?utf-8?B?MTR0Mk4xSE1OZFh5L1ZCYjBYWWJUT1RJdnFLYmhucS9mNjdRbGphS3hQOGtw?=
 =?utf-8?B?TmZZeUNwak1WbWtWRjhqWk5YV3BJb01pZGV2R0N6SWZESjFRd0lKeGZvbGJa?=
 =?utf-8?B?ZlZMVHU1cit3WDlvMi9kY0c1UHM4MUdDcWJ2cTcycmtxeHdOdC9mRHE1R0Q4?=
 =?utf-8?B?dWVrencrRGdQNDlBZG54ZjJSdFFVTElMdmIyUTVhS0tHL29pOTFoVHJRTmxq?=
 =?utf-8?B?LytwZnZRTklBNmJXdXoyWFpkTlpBMFFhTVNmNzA0ekpWSFRqcFlpL2dFdjdJ?=
 =?utf-8?B?WVE1aXd1ZU00Z05UMVI2QWZVK01RZjNHeTJ6aUhIL0NUNm1YL3RnaHh6ell6?=
 =?utf-8?B?UktLSmdDanRDSWxOSzhXczRKVjFFK0czL1E0TC9ZT1lIRlJ1bzlHdkJYVWVs?=
 =?utf-8?B?empVenBBeWxDWjdOMlFrZEE3a3ZnZkk5NXRZT21KSTdKS0RoZUN3MFBwOHdO?=
 =?utf-8?B?TDJWczBzNlBjM3l2ZkM4eGRWd0lLenE2ZEJGdmZpRmhaakwrNGlFUGxHWG82?=
 =?utf-8?B?NGpuODRGbFRGNzRERFBMb3JVYVlOc1hwNGFNTkdSa3FyVU5SZ29FOHozWHpZ?=
 =?utf-8?B?TTVLNFExZEN0U2M2TE5ndjVDWGhEUFp1bkN1Y3VrNmpmQkoxWHpzd2lNRFE1?=
 =?utf-8?B?Q1Y5V1cvQXRWZVl3K3k4RVVneEVWOER3MEU3RWJaSVFDOXNQcDd0L2FPMXNm?=
 =?utf-8?B?OHl0ZUNFRU5yTk1VVGd0dWZiM201dE9JRXdZQjhIb1QxOGJWSDJiZ2l1UHhi?=
 =?utf-8?B?R2E3RXpQQUNtV2toNnI3YXZXVDRUOGt0aE5GeGZ2OW85RGg0dGxuWkdsNzRj?=
 =?utf-8?B?Lyt2L1NXOGxScHhVQUU3NmVPS3lFNXhXZXZTNFNtMk8ydEJwL3E3cW8xbE9i?=
 =?utf-8?B?K0FJV05wRytXRGRhUTM1NTZYRUNjSk1lbVA1YkdQOW0wYWNhK25rYWo0ZFVJ?=
 =?utf-8?B?ckZtRFZYQ01ENEl6cVFMMERTLzFZWm5wZlIrTlp4S3UybW9obDlUYUZkOUN4?=
 =?utf-8?B?bERYOGR1RUlBQnBSYitZdU9BcXZOWGlYM2U1U2x3S2NpWCt3YnYvbHora0hF?=
 =?utf-8?B?NVU4QjZuKy9MWERQVnhGZHdxdG5vUk1STDhvcmdadFpHMmlqZ1VyVjFaMGNG?=
 =?utf-8?B?cFI5ellRSVVMNTRLUlNDZFF5RHNUa2NldnFvajB5ZlhJbEtsbnQ4Yi9tV1Vq?=
 =?utf-8?B?QzYwaHg4U2J5eWZJdHJuMUxTRitmZlB6NDV5SXF0MFdma2wvMTFTWm5TNWxO?=
 =?utf-8?B?eUdzMnBVMFpjNU5JSjhRQkJtVFgxVkt2ZStlV1p1MWpoYUpYV1VMMzByR1hB?=
 =?utf-8?B?aU9ZSy94NTcwSHhCNHRMd0tiNHJqWmxzS3R1UjFWbm1ob3hkeWJaeklzU09O?=
 =?utf-8?B?SC9jcWpYSlFGd21UbEJzcnlBNStKSkZPMU1vTDd2WjFjZkdmaHpsZ3hTSm5i?=
 =?utf-8?B?UzZkTG85bCs4blc3OWRacFU4L0dsYWlSYVFIaGsyYWdlWENrYXp4ZElsRzU2?=
 =?utf-8?B?L2p2M2hPVFlLdlprTmcydHcwR1ZYV09YWE9sWC9uQ29SVXpCT1NlMVA5eEFM?=
 =?utf-8?B?MXI3MWdERnQ5NGc5MHpyenBZRTQwNW9IMmFtemJ6clVrNmtrcFdKMGgramx1?=
 =?utf-8?B?QmpKREd5cVROTzd0allIK0cxUmM2bnNxTVFNaVN1THJydzRPeVpKelpIM3E3?=
 =?utf-8?B?WmZlYnh5MWtxY0ZIYW44cVZQdmVEV1h4NHFITUtYcjhXdXFnaktEb0dNU1RO?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	guZDYmDkiC2cqvzfNC+wpNpgGzUE3ai0XfTvVgNq21iv/vg92i7ytwSF+Wzh5eqDMhTr72zdCJ6MP8RU6W/i+nIsFcxFwYyqvXwGrs1Vy79x1LWaMQC6e4+bYntrNdNCcZjCu14Q3cEg7yLlH/pdmNjDcgBApLdMCmVnu/fsfEulM7VQZJQiHsLiHghgv7yymFqpVORSZ8ad+GIX6gyBV9HnWX+FkveXqiDj9QUpeg6gnsZZR8J7nyyYLSYqlmhDpUfdmLUzjjPx8Eo8r2+0MGVvYOTExDKVwVS1iAicmEjHQAcclv8pJquxgQAQFCVAD4si5wRz4Gi7t3xy5J3gPX2ltUsxJncM8hGrMjMJYwvdiqg8fbOHVUzVxys/W2qCTn3XhogBENyvqCFWxojIaB6SdKhRgsrh/ix5hr6x9Ip5NJuV7pVWiwojX3CqG7hfN3ubpnqf02XDxs1Xgvl1Q3bsoP8cJ4Axi44juGLB2FBH/cofGuZzXfrKGa4IJ/CQSP7oSNTPk+ssMlYfmkeP6zJcr78RvdDaEVxaXCXMJeDth351uAWbWXyzKfZOKqda4zZpotHt7vMRtHj93rIvyvggDtTi/NwVq1DK8a0dwwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e879f8fb-7e5c-4fb9-be04-08dd30093d73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:24:00.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1HIIDo7YZHeOFmvvm2Zw20tPVUEnEuqwriFiHDmqZGPB05jaY3Dx3s8quOaHyJWhkhBO0Cv9Zygh6Pu5mzK3wLDp53J1qeVB3BzCt0/864=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080144
X-Proofpoint-GUID: q8GbGCWaWlqguNbIeYovpzDuG0Dq7FLe
X-Proofpoint-ORIG-GUID: q8GbGCWaWlqguNbIeYovpzDuG0Dq7FLe


> On Wed, Jan 8, 2025 at 8:44=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello people.
>>
>> The deadline is approaching and we were wondering, should we prepare a
>> proposal for a discussion around BPF support in both GCC and clang for
>> LSFMMBPF?  Like in previous years, we could do a recap of the on-going
>> work and where we stand, and discuss and clarify particular issues.
>
> Yeah. Don't delay. See:
> https://lore.kernel.org/bpf/Z1wQcKKw14iei0Va@tiehlicka/
> request attendance in gform and send email with [LSF/MM/BPF TOPIC] subjec=
t.

Will do today.
Thanks.

