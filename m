Return-Path: <bpf+bounces-40827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0798F0AA
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92698281E12
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10C519C56A;
	Thu,  3 Oct 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f+vv3Oz3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CsrKewt/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960824C70;
	Thu,  3 Oct 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962901; cv=fail; b=ID1v5+Xe7hN9BglSi+LYX8fqtOHxW5ucVFTU8knISjTPQXlA+yfXPQBoIiX71FrUx3XQ7HmH1xjDXSTfIzuxZi2iq1Xi/hr3CkufJfViZzTjsWDiJMFxg56v3U5krfsKldObmgit0JmWoFHcSRUf8KiJB+izpTcE6mlDY1W/bQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962901; c=relaxed/simple;
	bh=ulvjlNG+qzdk4lHXGrrAR1Cig7hkpmjWa22VP5aT360=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q16E46D6QmCa5DcT2JehSTCeJvFgfoUZ6Cuys9ImUWvQ8W22JkP2qIruGWMZcdPXjjDdWWc4m1EcgrVGNxhhzmkOzY0YZhinFLqqsP0rFK4NW5w4iMsv0GHeOVnwB43qnMRh2gHaEwV8nfwl7ZEy19zxRXqaQ897ZgPZR+OZwDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f+vv3Oz3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CsrKewt/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493DfZWN031701;
	Thu, 3 Oct 2024 13:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WoGa82M8r4qTHVTTItbbIZCL2U67YQUh6bhukyTZAWE=; b=
	f+vv3Oz3SJS/WwupvlIrMjpnUK06/miTyIZWnvfUU9F52yHA2GoeG94s1ug0WzyG
	YiUV2lKqvsXRon8LM1pN3+jctz4kwGHPEEBx0pgFjst36QM0hqLrRyxK267lXNbU
	RZ8Yf64cLQi+eqVonHbqeRPL93CMS33ISo50KaKJlJGh6AN+b741urF64cSDTW2i
	AwwExrY9UEtuCUwXQ/ubhBaZVHD5YFSrACi6i4nUpCcg+xHlfGw80NpnLBbhTvYh
	vH6y1jOTDJk+iwcQ8gzl7oA/JpfjO31wZtI0chU7aEzCOOoZtkbrke3V27aa8qIs
	kc3Rp2y2ih+vD1g0HJTlow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3c9xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:41:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493C6ssv026216;
	Thu, 3 Oct 2024 13:41:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a9psb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbHesdScO3AuHdG/DAttlgl8+ObmkT7TbbQXSbPVGLXNvvdCoSZF8+gi6B5qzxG9KbYKnJOKTShLlGkgwzZx6+XGkgvXcoldrqcxtysIQJ0P1LnsCFIwjWa2YxF3WTtXvcxeHwBGoTY4m9voDlDr1V8dN4cde74CC6tHbVU4doHPsa7tvBHedH0f7NF5ayD/Ph3A5eUAwo89oK3UYc7XwRfAmmkrH6Kt6pK++OLAl2BAPB79aHHOEXOYnL4727vbh2A+65xYvFwFxMTOjJ4vhKpbAoPO6w7iGCxM+MSraBxKBdbxVQMwLAzc8um5iUOvRqH9USa2prdeVS2qO52+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoGa82M8r4qTHVTTItbbIZCL2U67YQUh6bhukyTZAWE=;
 b=FGrfmq2sgSxwnvxoPsJDp4tjzFEkmcwuIw+0tX7nogwJzql5aCr19Vmx7b3i0zd/DT4ekQwD+I2MC57xuInCVRS5S+7p7GYr9D6cqxs1/Ie+10YxKfANoYRjaJ3rMTjVNrV8iGVhKoEDK9ru+1ws2rqvOCzfx9L4dOecr2p/ygpyIVhCf1XSPFsu5VUpwxuy+oFhMsZlgIYXCAYKiPMGgf7lAt0XcJx6bcdz4U+SHzLROverQAeyRyOBN9tG7TnhOFYKXpnFP5VBizVeXPivpE295U2SEeC+Nq/OgA+a7IN1xso/xfSo0CXI9HoHBADLN8HZR16WBa0hthl0fLz2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoGa82M8r4qTHVTTItbbIZCL2U67YQUh6bhukyTZAWE=;
 b=CsrKewt/+X9dOxpDmxiiTznM+wB52k1Vobh74H0j7yW3I8L7fWQW5RN8ygYinxkHRRNcSeVukyjyAMkpezxBWMib5AbOHt1gY8maiJSO8p412PaicvLc15xtsLwf0MsKFFUy1CmSpVt2Gp2s/fKyHMjxolsaGdAuNH/ZMqLdtv0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 13:41:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 13:41:21 +0000
Message-ID: <d25392a8-fa5c-4188-8e8b-fc822d9862f2@oracle.com>
Date: Thu, 3 Oct 2024 14:41:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 1/5] btf_encoder: use bitfield to control var
 encoding
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-2-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241002235253.487251-2-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0210.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4c3c56-afd0-4f63-4f4d-08dce3b1112d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnd2VzhEbGRZSUdQQ2d6cnBQajZCTWRwN0hLRVQzWXB3WmF2bERaNlZhTGNa?=
 =?utf-8?B?TTZjRTBqalJpOGNXUEhxVkFHbkkvd28zci8yQVZ3elhXU0xPRVpoYlNac0Zs?=
 =?utf-8?B?aUNRb2ZWdlY1QWZtUExqU3c1Ulh2RUJOVkVPT0hvNklHU2JzWmNTMS80UWpO?=
 =?utf-8?B?MWlzVGQxZWFVdDBaVDlsOXFNMWFVcm9SSGd1TEk2RGh6UytqampqcDZOaTVZ?=
 =?utf-8?B?ckRBRDMyeUxoMjl4SmM0VTJ5eDhLUXBUU2VIdFNlbDB3NVI5RC9KVjgwNVI5?=
 =?utf-8?B?NW1YbjhHNW5iV1p3RFlVdmZLZEtkSmxHOVMrTEZMMzYvdDJwcytlY3JOS1BB?=
 =?utf-8?B?QkRIZ0dEdGszdHlXRG1IaWtwaU1zZitoVXNRY2VickRrcFRLQmRhR2dwRHRw?=
 =?utf-8?B?cEZTZ25ZcUJJWDU1R29wSmllQ3JYVkRoaDVOa2dQMzF2R1JzOE1PeWdXQjZ0?=
 =?utf-8?B?dEtnZTczQ1lCVklpUkZuQUh5Z1M2cnVZeTNLNXdrc3o3dmhBWXhDbVYwUmNa?=
 =?utf-8?B?a2x6UkdkaHJ1R3I3cDZ4aWFSUlExSGVhVi9ON0MzYlRZUnJreE1Yc1Jlb0Jv?=
 =?utf-8?B?OElwd0ZUSC9ySHBsbCtuODZRQm0xajdaU3BzV2NpRVBZeHBuVzV6TWo2U0p6?=
 =?utf-8?B?RlM0Q2Z4WkhGdFBXTGFteHdiM2hIb20yUVFacVBCNEExbmpCc3FJK2ZOMHc1?=
 =?utf-8?B?Q0ZzeVRkdi9Tem1QYkVoS3NxWlNndHMrQ3VwMFVSblV5Wkw1SVhNb1ZaR1E2?=
 =?utf-8?B?bGlnejZZOGhZcjg2TmxjRFhOczl6VDIrME80M3g5M1FoYm8rTEdvRmg2Rjdm?=
 =?utf-8?B?dVRybGp5OXIrOTZIYlEvTDFuRmRmZXYvMklNU01wTXNNLzlEdnFyNTh1Z2JL?=
 =?utf-8?B?YzBHNnkxSGZpMSsreGJuS1JDakZ0UEE5SXlhZHJ6MXdnZSsvMno4N2ZzekNn?=
 =?utf-8?B?YkwzVmp3YUU5T21PbU4rOStpOG04VTNjbEZnS1R3bXlDVWlFQTJ1bmlQT1dY?=
 =?utf-8?B?NmE0SmJuZDlnZHM3U1FZQW10VmVDM1RDOU85Q05qTFRKaHlqSTNFSGlxZ042?=
 =?utf-8?B?ajVTdUc1aUxXREVvQS9LSnptaDhZUlQwTjl4T0ZIM1hDSEhrbUNnRm5vSTZm?=
 =?utf-8?B?NkRqTkxRK1R6N3Y3cTdQUi9NV3Y4b0hYaDhwdFFYOHRzRGRwdHBEQk5MTEhX?=
 =?utf-8?B?cDdOVHZwV2RWMUQyMVZVQXg2WEp4VlBzS2IycG82djZuazlsbHZBQW5yRjB2?=
 =?utf-8?B?Z0c4N29kb1RaMmw3WC9sbjdYdE1uNnA5VktLSmNsaTNJTlhMdFBlU2pOK2hz?=
 =?utf-8?B?eVp5VzVQVlR1ejZHUDM2QThPMmc5a0tiUjFnZVZTQUx1SHZMQURaMmhSY2h3?=
 =?utf-8?B?aGF5bjNwQ1BkL0huS1lXaTRabkpaTENtV3p4SWRGK2F2ckdxcU01a1RzNXhh?=
 =?utf-8?B?ZUlqYVlQcTlBMkNPNEk1M3J3aFpCUWoyZ3Nrb0x3TThOT1YrendPaEdTbnpo?=
 =?utf-8?B?WUpsMHJSRWpFbkl6eU1DRUd2UlB4N1lmWkZxVExyNG1sSU1xSVV5ejRRcmxW?=
 =?utf-8?B?ZVFXams5b1gyL1FZazhOUjRIR3hKaUQ1em1Vc3ptTDB5SjNiVmp0Sjk5RUxk?=
 =?utf-8?B?WWNCU2tQK2NveW40SXZiTVFSRzhzdGxCZk9JTDh1RUJpQ3BNOHpCSEFzaHA0?=
 =?utf-8?B?dU9LNlJzTWVza1pYRE9UWVZnZVhwdG9IV1Jld3hidDcyUDZvd1R2UmhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lic3VyTnZheUpMQm5vZGlGeU1zYnVrZXNxOW9NcTFwdWhMZWVvNEQ2S21C?=
 =?utf-8?B?UXpIVmpNUzlKNWhhbXdCSEJmUEMveVBhN3VDcEJGSThtbXYyNXdWbG1wMmVY?=
 =?utf-8?B?dkpoaXRpbmI3TEZSVEVmR0JzWVFwMmJ4Y1JUaXZRSGdJTkkzMVMzdjVqaGlq?=
 =?utf-8?B?dVd2Z09LT08wS2EraHZjeFRsZXNYWnJnYVlvS1VsYUxPMEFodDZwOTZveWZF?=
 =?utf-8?B?TU1FTHNIRkppOTNwSWJlNE1XUjk0cUdSRmZxa216V1pYM1pnWFI2K0ZBR0Ju?=
 =?utf-8?B?bUIzRjNkTjhzQXQ0bGJRY3ZwNFRqUFo3ZjhpUW1mUmZYLzhXaG0xS2hNbWJU?=
 =?utf-8?B?REZWUTBDbk1rempTb01oRk5HWTVtM05pc0wyZ3lTMVdxclprNVJWa3U5SjNR?=
 =?utf-8?B?UDJEUnRELzI3VUxHd25oUDFsN21HOHZCemd3TlFwM3BGVGVEWDdrb2lrNzYv?=
 =?utf-8?B?UU40TWozYTFNMVUraTc1eDljU3ZGNkh2YkN4ZG9Pb2x0VHNWK0tRRlVGd1Bo?=
 =?utf-8?B?WWVZWUk5V1R5STVMZGQwT1REL3RLazBydjVIY1VOVWNPQmYwVEJaaWUrTGdm?=
 =?utf-8?B?RWVMSDFCVHZPcC96dXlKZ1V5bVowaFVwR1hQajlkdEdwWVViUncxblkzR05Q?=
 =?utf-8?B?ZnliN29DWHlmMENxV2JMa2ppcnEzMm1VUzVTVjVrL2JpaUg2TW5tb2pOaU9X?=
 =?utf-8?B?T2Jab0dpdlI3bDZNUXg2SldkNUU5TmVtSFNwQ2wwTGMzaE5NdDRMQWFBa2lW?=
 =?utf-8?B?QWtWNFlVaGVsSGcrTWE0dWtTMnp1YUwvTEJLS3JBdG9kbCt0a1Z2OGoveXBP?=
 =?utf-8?B?c1V4QklDS0VHNHdjV0d6Zm9IUkhKTUlGbVQ3U3VWZFhTeUtlS2VCMDhOY2hW?=
 =?utf-8?B?Smg0WlJ1RGlTeXh0RXNQOHF1L3M5SzZOVFhhOTVXWTkzbDJXcjhLVVZ2Tkc4?=
 =?utf-8?B?V2xhNDJlWDRiQldZanQyUWNTQW9ObjU0UzgrYkE3cjFqNzhuNVBGbmxnUThs?=
 =?utf-8?B?c2hTcnZNZWRtOUtrZHpiWk9tL1FXbEtUSk9wM1JoVkgvMldMMEI0Sjh4MDBp?=
 =?utf-8?B?aGdMQk54Z0pKTnNJK3BmbzlKQXY4Q2RmMlY1bXQ1YWY5SlhBdEFOL0hKYi9X?=
 =?utf-8?B?Ni9SNDJGY1RwbVV0NjFWa1BjVmkwaVNMMXNzQjM1Q2lqV2xidmp2anc4ejl4?=
 =?utf-8?B?cUxteDMxU1ZDbmJtRFE2TEp2d09nZG1yL2dxNGtaYjdVM0ZXMTZxdTVHam1G?=
 =?utf-8?B?L1RyU21qbEFMTW9XNjByQm5TdmJic0tCcklKU2lRWWNGcDdkKzNEYXo5RTAx?=
 =?utf-8?B?cmxPK3VMN3VETU12MjVtbksraWZmMWsrYmwxVkcrcmdST2llWngvbFRPbDBT?=
 =?utf-8?B?dFY1K0VCUEZoS0JrbnFBVzMzVGJJUW5aSGFJNUtvS2J3Zy9MWW9LQlVXYjc3?=
 =?utf-8?B?U3k1Q1dGSDUyZUk4WmdwNDJiZC9pR3RNNVNTUHR0OG0vakhzV1ZwN2lLYzdJ?=
 =?utf-8?B?Z3ZJemJnNWMrZ2RWRnMrM3ZHZEN6NDdVUFdGNWVTWkVuN05nSEt0Y3ZPUzJF?=
 =?utf-8?B?Sk9MTEc5dkI0SkR2RTRZQTR1em4yS2hLTDBlbnZqYjhUdS9lTHc2b0ZPT1Fz?=
 =?utf-8?B?WG1WalQ4ZDJpMTlldE5DZVd2U1lsNWl4ZkhqTFZHWHVNdmFNbFk0K1dhUE5D?=
 =?utf-8?B?UmJCdWhleTZ3QXU5K2ZuRTMvRGtvL1VwdmthdkpLc2VGWURKajN2YWdRY3JD?=
 =?utf-8?B?YW1QUTh4TnlldlBIMG03amVhamRsWjdTNHVvT1hpOWJ2SGVSRVp2eEJFcDl3?=
 =?utf-8?B?bEI4VW1venB2YzNPSWNPL0U1TUZOZFVodU1COU1HZzk4dGZJTkc4d09HU3FM?=
 =?utf-8?B?Z1JjLzN1U0ZaOWVKZkhVcTRDbzZXZ1dnRGhqUHZXQk9LUEVUN2kzTEwvZ2dx?=
 =?utf-8?B?NGlaa3ZDbVp6bUFScFdXVlJKMW5WMkdlcmxaV0c5a2l4aXV1djJ3Zk12aERu?=
 =?utf-8?B?NmVHbjRBUEJqOXVzOWZNS2hFNElQbDF1VENFMC8yUXNJMUU4KzhCenBJUGVt?=
 =?utf-8?B?OEtCTkZjQ2c0aTF4OXp5dXpBK0pBT0RsRGdiUFhSTWlBbHB4WWJ4aURaRUc0?=
 =?utf-8?B?UXlrN0pieFNQaXN1S1NValRucW5TdCtIWnhkbmtGTldLOExrcWtEakRwMmhH?=
 =?utf-8?Q?7tskI6swvNI2Dd4lTCpdCB8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5o984ansM7DDiQx+HFhhTWk07uXV/JnmwXvVmcvaw4aaBsh6wcIN/FTdbaIp5vPAP38NnZA+/ZBnfC79X7IyvrOf5OdPaj3pJqJJWEihLDrFlwBLVRsEhJy4XUfe53VtBrjXFwcvK4PQ+or2BB4zMrl5CdrAH6BCcSb4sSO38zVeta8pc1ZMfxG8a/2IRCx6xSsZD+NC4xJ//JZTWEj9Bkgl+TELygmFHPmCKVnX2XONLU3GWs8wK9qVof9U7eyBrERdXBi956c5rKtfgshyscYz2Ki6ASZl7LLCteDHnzfbYuZr7/UFmF/KrqakdfS6f+srikU3JAjFqMSzdQNoQhj+5G5GJVJYhogDPap1C3Tcj0rkhrfLlmdzb6jO0Qnbhv33yJoZRAgsXqHa7eaVpywWc9LynrydrsQBhbeTWAJbSN83yS1rQssR58ZuAyTXKvJv987Hq96oiY/+IVizS80z2rRbe94/FUgPx2nYgIvbW1SIAlEor4EsOYnP/nYFs1Mk7UWfFCd1UOmyLuKgyKi8TzbB8aPRiJLPlJxYQmiBYQDKqC++i2k6D3MJIAAw5MpjjVxcZ1h0dJ4oA4Kb0oQl+YtTQl+MBlfX8b101NE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4c3c56-afd0-4f63-4f4d-08dce3b1112d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:41:21.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bVsrYs4h7SeIV1ypdInWTtX2NFrHRyWFLEfAQe8U/wMjgRHDCpXJTTORVK127i64VAoIHFzirNucI+leZE2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030099
X-Proofpoint-GUID: vrNv5d3rr2XjlOTYBUmN8gQVhW1gaHz5
X-Proofpoint-ORIG-GUID: vrNv5d3rr2XjlOTYBUmN8gQVhW1gaHz5

On 03/10/2024 00:52, Stephen Brennan wrote:
> We will need more granularity in the future, in order to add support for
> encoding global variables as well. So replace the skip_encoding_vars
> boolean with a flag variable named "encode_vars". There is currently
> only one bit specified, and it is set when percpu variables should be
> emitted.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 10 ++++++----
>  btf_encoder.h |  6 ++++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 51cd7bf..652a945 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -119,7 +119,6 @@ struct btf_encoder {
>  	uint32_t	  type_id_off;
>  	bool		  has_index_type,
>  			  need_index_type,
> -			  skip_encoding_vars,
>  			  raw_output,
>  			  verbose,
>  			  force,
> @@ -137,6 +136,7 @@ struct btf_encoder {
>  		int		allocated;
>  		uint32_t	shndx;
>  	} percpu;
> +	int                encode_vars;
>  	struct {
>  		struct elf_function *entries;
>  		int		    allocated;
> @@ -2369,7 +2369,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> @@ -2377,6 +2376,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
>  		encoder->array_index_id  = 0;
> +		encoder->encode_vars = 0;
> +		if (!conf_load->skip_encoding_btf_vars)
> +			encoder->encode_vars |= BTF_VAR_PERCPU;
>  
>  		GElf_Ehdr ehdr;
>  
> @@ -2436,7 +2438,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		if (!encoder->percpu.shndx && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
> +		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2633,7 +2635,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			goto out;
>  	}
>  
> -	if (!encoder->skip_encoding_vars)
> +	if (encoder->encode_vars)
>  		err = btf_encoder__encode_cu_variables(encoder);
>  
>  	if (!err)
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f54c95a..91e7947 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -16,6 +16,12 @@ struct btf;
>  struct cu;
>  struct list_head;
>  
> +/* Bit flags specifying which kinds of variables are emitted */
> +enum btf_var_option {
> +	BTF_VAR_NONE = 0,
> +	BTF_VAR_PERCPU = 1,
> +};
> +
>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
>  void btf_encoder__delete(struct btf_encoder *encoder);
>  


