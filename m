Return-Path: <bpf+bounces-35656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241E93C85A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629771C214A4
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB153EA86;
	Thu, 25 Jul 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dRpGxbB0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C31B94F;
	Thu, 25 Jul 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932229; cv=fail; b=imlLWtcBnkoVWFMPIoCKxFUErbGPTeHxNoET9yiDwnQ0ppJgOji00dpFrWq6D6bJcTWdVkiUaLcavMDr+65sk0T9ow9X4+JTnaf1RdSB3/lTaMDeZItBdgnJKm48dRDaachSJhx5j5UV5B1QwrhtMJJ/vgDwNosPSZM+9ArVAHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932229; c=relaxed/simple;
	bh=4uJmmeRQN1/evvaYgRbniE5Wp1khKAFa1m3s2IGLLNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JCDZJIaKX8cieiZz1fI4mQG+LTsZfOxB5ZwlWiOq2GZAfuhmHVil7aSd4NtT2iwSuMF+Qc7EyVwWH3Yjf+THUqReYYEWJ92yF/OuWFypLkakw1350tn7tRsD7UxXwJHSLGdG+jN8UkEss5aTRRl75YL+oHplmw0nsqaGazsu4jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dRpGxbB0; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PAmfbS015219;
	Thu, 25 Jul 2024 11:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=aFJ/Rj7wSCZR3MOaUiS6uAUT72MGT57zrfltyTCF7XM
	=; b=dRpGxbB0csgzX12JPyPgHHdZzIoA6MWl3qXw0K1qpZUPDxervrUJnRwKZiJ
	r4kR6bvEdwpM7slYFW1is/wjJblufH07RExgV1JsMtm5HhPIuXF001twIXcOJV3B
	KK+L+IvAPCpfGgyqQE4tPd1RTokuLq8jm94WTZTt+vIcdJiwqktaEND71IKCPdV+
	2BmKXvLEYb44lEGOIRP6iNVHCBeosoIMd2RJWviizxzu35EUX3cYSExJdmbpGY7i
	XIV143fduEBM9ge0epDVc31Gtxs2grlLGaPZsnskJX6ZNR8INJNMiS8SZ2cUDj/d
	nX2NA606g7k8gqDpVulJoaVFfcw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40ka8p6qp9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 11:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7/p77Q8LPeglEoYVuK612pLettmK22g6eo942q7aUCJROftJbkxUfYsOrNElHg65OZQWTMI6uJslWEMEqRX0zdnhAVqtosVEHLgaqNP8ug95FsYjlPlKuo28TQL0icjwZskb25EmF/rXhnMK6c1C/oPaXb/CYxyBi9B118Cj7Z+FfjRfZtTGQJclmi9dQElD7PgOCUVFER76dvo/vQ4JDerFLCjaI/EjFdTNGTsvrHIMV7cKi34ZTUg49+zk7Spo55un/rpZcXayIioXeqUM/I5FQ70c1UWAaoNRt8Z0e/BrCklKhUaULbEHjSOIS0VvrMWkPypFzORp4QSPJlIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVzvU/RLFKEYn1AvSV6DvGvkNMSOwP0h/7sT36RpWLE=;
 b=gztwgVP+5EK5oazMt/odOhWgA5HQP+7h1Zhm/YZcyKsLUg19idFE0rQSqp/x2s774OdwrHsxwtKQB5xGRBNFtvuh/KNcPwXBBwCHJL3mftgFVxsZce/HMm8JDFnj25cYADtWQMBNEtSnzSy8RbXQEMD91Om716/2tW0CyMl0o2SmIiRv4jYIaQhZ+NM19fMjQ2cjgYlQqrJ1J9PKghMJY3rlZeP/CSQs78hi+g5LxYmiDcRu7G3/3dtChZ+8WAoHtHk82Zd+ZinCpVRU8DgJQASEU10eDVAx+zwJhGaBYQGyLgOmSwIhvbA382GTxY50qNXkLHski3w6/KJbhpPSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by DM4PR15MB6254.namprd15.prod.outlook.com (2603:10b6:8:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 18:30:22 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 18:30:22 +0000
From: Manu Bretelle <chantra@meta.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: pull-request: bpf 2024-07-25
Thread-Topic: pull-request: bpf 2024-07-25
Thread-Index: AQHa3offaQgMHizIvEanecrbrzKztrIHcK8AgAALwwCAAADXAIAARwWA
Date: Thu, 25 Jul 2024 18:30:22 +0000
Message-ID: <76460C8C-42B3-454F-BD5D-2815E6FB598A@meta.com>
References: <20240725114312.32197-1-daniel@iogearbox.net>
 <20240725063054.0f82cff5@kernel.org>
 <ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
 <20240725071600.2b9c0f62@kernel.org>
In-Reply-To: <20240725071600.2b9c0f62@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|DM4PR15MB6254:EE_
x-ms-office365-filtering-correlation-id: 51db52bc-eca0-43a0-5be4-08dcacd7d803
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3U2N3BKNU5qdjRWNGl1YXRpenpCNHRnUTVQSjVGclNXNFlqL3dSLzhHUFI0?=
 =?utf-8?B?bDhadWVDbFNPSXVVOUVuT0RWWCtoTDFhSHlIbDNqUWYzY1BFR0M4WjROdWw2?=
 =?utf-8?B?RGZqVWpjVnU0cUsrcFNTU29oeUpNcjhlcTJ3VTF0aXhCUlM0elpBamFZR3BS?=
 =?utf-8?B?V2RHU3BQZ1hnaWkwRkQ3Z3RQS0UwaUJpT3VkRHdMZTdPdm5zQ3VMMytzNHZO?=
 =?utf-8?B?bGtsUGJmZ3JzS1FXUkVFNUFzY0dQK291MmpxTTJPRjFBR2FoejNtN3JjV3R2?=
 =?utf-8?B?VkwrYlFkRHZxd3l6VkF1aHFPa05XZFlDOW42TVVlbjJHcVdueS9DZlFVWDRo?=
 =?utf-8?B?YmVmeGI5QTJBVlBab0RWdW9iRFV4YVA4RnFnOVBWbjBRNWdiOGxTVmIzMExy?=
 =?utf-8?B?OUNPSDdETHF6d016anZHNTFuSks2M203RmF6K3FPZVRwOStLOG5saG9FTmpQ?=
 =?utf-8?B?em5vYldGcDlhLy8rTklob2U5aXZFcjVMS1BFQlhPRFJTVlI5bDhzNHRMYU9j?=
 =?utf-8?B?am5xUWJROGhCRGVqMUpzTzRtNEdGa2o3UnA5TXNNbkdVN2c2UUJOR3FkRlVq?=
 =?utf-8?B?YkN1M2JyTlVZNmhKL3dyNEkyejNxNjh4M0Y4ckpXcHRNVU9XMlNsU1A4cHA4?=
 =?utf-8?B?YU9XSmZUbG4wdWFVd0locktlRVhzMnJMOTBCemhzN2dwYmtpenJHWStHSXZX?=
 =?utf-8?B?QXNUaTFscGV6cWRqdU9sRU9DQk1tT084SS9qUXdrdG0xZ3pFTlZpd0JSMitO?=
 =?utf-8?B?aHRxTmE3aVJQV0NXNXNrYTk1K29udlNOekNEVldlNjlhQUJqbXhremxiR3Vp?=
 =?utf-8?B?SHVKWEVJTHJmOVlxbzdrM3N4Sng2Y1o0OEhqVHBrbFF5ZVpVSTF3M1VCaXcy?=
 =?utf-8?B?Sk0ydzhUNGhRVXRlZFVQZHg2c2lvNkRVUmtjVXAvSEJ6VC9NUkF4eStWUEVh?=
 =?utf-8?B?c0pUNG5LbmNYSCt1SlFPWUhzUXZ0QUhxY3RvdEVTZENTQ1A3K1FZdnhtc1V2?=
 =?utf-8?B?Q1FvUjQwTWJVUXpkU2dGMUs4ZkU4TFJPYnFnLzh5blczR3UwUmV0bUxrY2Ry?=
 =?utf-8?B?RnZYWXJXV2VvYzV5blM2Ylo1R1VNUmtxN20yTE94OW1xNlZvVVllNjc5ZDQv?=
 =?utf-8?B?dVZMYmhuVDFUYjN3V2JUNEk4Y2VQcTJwSCtuQjhWaFp3dSsyYU1XaWQwdk5G?=
 =?utf-8?B?U3dTRXd4RHFscmZlMWtBeXYzY2RYY1MxcTFLbXlZN0tlcDYzNTN4YlBmbTlC?=
 =?utf-8?B?T2MwWmVYbFZSK3ZoSkpPRU8yR0JpRUVqY0p5YmdHdnZoZ2Y1M2Z4V0liZXZ1?=
 =?utf-8?B?ZkJNUTdXcS8veWM1di9PYnBVYUhJWWZLQkFoVHlzKzF1UStJbTQ2MHVUU1Z6?=
 =?utf-8?B?Vnp1cmZOVDR1R1JrUExmenl1SXg3ZEFPSkFsYVFWS1kreWZ2cGRHTUUrTDRu?=
 =?utf-8?B?S054Z0w0M05mQzhNakVGczhuZkdxajVYSXJkZ0pLQjVsbGI1S2N4aWcrZkVV?=
 =?utf-8?B?aXNoUXdZeklDM1dwU2RkMWJQcUg0OFdrUlpCakVrTnJoQnpPK3o5bzRXN1Zh?=
 =?utf-8?B?Sjc1ODdzQ1Nldkg0blBDRzNhQW5FQ2dhMkdTbWhtNjhWNFlKWmZ1VGpmWFV6?=
 =?utf-8?B?NHh4T3NkLzNVYTc2T2tocGpER3ZPZ1kvdExKYnFtekxOVm90L1BGdE1EWkIy?=
 =?utf-8?B?dW03eFVJcTdTK0VyU0ZFc0FyZVFqQzRlbitKakUrRWkzRXhBNFlEZWJGdVM3?=
 =?utf-8?B?c0ZUZjhkMG9KVXRhb2FUaVpESjYzajNVVHdSMnUxTzJheUFBbUIzZmFRdUxw?=
 =?utf-8?Q?AJbAIaTR1Jsms8taabJuUjfrEofHlpMf5zXJ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFA2WWNsT1JrcXpTQ0pTUWxDTVVYbGdlMmtmQ1c0V3VGbDY1b2ErQnpHaitq?=
 =?utf-8?B?WGVtdmVzSHptN3ppanJiMGMxY3krRnVWOXpmS2lGdUE3andvQzk2aWtRVG9Z?=
 =?utf-8?B?dEE3VWxjVGJiRmd0LzRJTFNLZER5WDR2bWk5MmhhemJJblIxVXpjSnpldG8v?=
 =?utf-8?B?czAvOW5iWlYvTHFSWmJiVjZ3bEFrUEE0QmpzRmxTN1RzSjhpa2NlMnZ3SUxO?=
 =?utf-8?B?bTNXWTBibVczZjkwbDgzZmxRVEdnamVVNXZHdEl2OTdLV0licExFekk5NVFv?=
 =?utf-8?B?ZlFWTUdyUjdnajQrZ1krN3MrZjFLYzVzRWIxOUpJa0RPZHRsbUtEVjNWQncw?=
 =?utf-8?B?SW9JOXRjRGNIdGRxUklpWGpzUnhKL01KT2NlQUNQbVFTWnR6cTBGOEM0R3Q0?=
 =?utf-8?B?R3FUYnJIakJYNXhnUGo1eUtoNmVLR2poTHUyK0p2R2FaU3lrb1RtU0Z4elpY?=
 =?utf-8?B?RmM1cEdxaUNQQi9tTVAwb3l2dXNpMVdFMFJNM2hpSjNFRFZ0MElQQ0JSbklR?=
 =?utf-8?B?MEpOaDFnQ2E3UUxKL2lMZWhnQTBUZ2RCbGF5enA3SFE2UmJnOFp6Rm52Ylhp?=
 =?utf-8?B?bWtPeHZ6MVVFMXYydDFySjBmRjArbGJGTkZCMkplUlJXWEU0ckVHa1FIbURT?=
 =?utf-8?B?TW5hSkY2ZW80aHdiQ29sUkdzTGcxcFR6ZG01cUV6c2ZnNDJya0VXS2xCL2ZB?=
 =?utf-8?B?R2R2WG5jNVlwYVljOXQrWW80QTBqaUJBcFBUWElwWnl5WVJZNEJQdlpVU3py?=
 =?utf-8?B?czQrS1pibUY3KzVXaDdDOTk5RktsSGd5TGN1YVpBQ0t0NllGV0dDWFJMT2Q4?=
 =?utf-8?B?WGZyeVYxeEdYVGhzWjBMZVlUdWZPaVdvNGQ0cHpKZmRxWVh6TjRCTFNjc2l2?=
 =?utf-8?B?VXpMd3dESWV3SjU5NmZnZ0tjWXpDOEY0c1F6NEVMU1ZBcXJQZ1RiSHNIRnBE?=
 =?utf-8?B?eHF2YXZsQ1VCMXZOWmN6UG1YVWMzYmdlblJ3TEVxWnBVeU93eDZ2VXBLcnhS?=
 =?utf-8?B?MmhWMXliNnpvMEJoNzJxZmFlQ05sbzlpV21zeU51ZGdHRUtDY2lhTGM1cnZm?=
 =?utf-8?B?YzZzRFBJZk1tQmZpaFJxeld1QzZHamVVZ1o4RFBlNCtSL1FOK2pLUDAyNisx?=
 =?utf-8?B?eTM0ZTVCRlVqYTB3UUxyWVV5SWJaVUplajhVM0hiTzlIZ1hTWmJpTDdGVEow?=
 =?utf-8?B?NWNRWkJyQ0VVOVdSaEpxV1FmL1lwM1JOcXlXTjd5cDc3L1FoMXAydnNlTUow?=
 =?utf-8?B?M3BxYkdnRmpJTWJXNk4wenZBSlRxMXBOcmhqM2d6NzJRZDFRamlTT0ZLRnVK?=
 =?utf-8?B?bEdSMFdMZ2lFUWFrRmF4NXlwMWFVUUVqWDFlRXFNbDJwdXArd1RSWE80NDVP?=
 =?utf-8?B?alUxb3BJaXBud21mWWNuZTh0RUt3VlBDaU1FWEl5ZlhZMFZuTTdxWDd3VmZp?=
 =?utf-8?B?cXBxS20vS0p6VlN2MnFXZENGOFhrVnpicmJGRVdmUERZMTRORnFPZnJsK0do?=
 =?utf-8?B?anVTSkpySGJLRE5MUGdqRmw1eVErUWV2NjJsZ0F4TG9ZUEYxNUVOeXhpaEZW?=
 =?utf-8?B?RUtXMFRXem96bFJZcXZBSmFXYzF5RzF0VlFtbWtJN2gyV0NGVFFpZ3N4ejFt?=
 =?utf-8?B?VlFhcEpuMTBpV09OWkdDVC9PU1JOMUdZTTFsQUxKL0xWeStLOUV0RzV0Slpo?=
 =?utf-8?B?TUVDakpESXNFQVgybTVWUWh3b2lwdFlMVzl4OWhsbFdqdUlpcXlDQVZPbGNO?=
 =?utf-8?B?bWMwYWJXRklKWUxCOXlvTUVld1NEb0ZJU1M3QkdPZWpnVkI5R2QyNC9xbzR2?=
 =?utf-8?B?L3dNd3JMdGQ5VTJuN01SSG5hMGFWekNDbGdOWG01dlE2Mm9EbmhrbVFtTFFy?=
 =?utf-8?B?MVFFdFFRZlFTdlJyQTNHOHg3dXVxMW5EdEhaOVpVQ0E0aFVyM2gwMmQwZ0ky?=
 =?utf-8?B?LzVtd3RTKzQvNmhuVnBiSnR6UitaOXlhUjkzNVpJRWhPM0IvSkV2NnJiWkV4?=
 =?utf-8?B?MUtDcTY0UVFVTy9IU0UvemVScUxJTVR6UzFIWDFjTHFhaE5KZm5lUFF1YW9t?=
 =?utf-8?B?dmNPODd0YWtWdVZzc3BKVThVSUtrRHB1ZzhaN0xoRHg5RmdUVjA1Q2x1YWhH?=
 =?utf-8?B?U01LN1UydERwNnBXZ2I0aW50Wk9HWFJZUW1Vb1ZBMHpDVG10Y0REd0JmV1pQ?=
 =?utf-8?B?NHc9PQ==?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51db52bc-eca0-43a0-5be4-08dcacd7d803
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 18:30:22.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBpulJjxKkFl1IdqpIIrSKzsCne47q3YIvNo5FhWdNe17awldmgjpEdTB1u707RY8py9IQNaPEwfy9llRZrqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6254
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1FB3AEFCDAC60D4BA77B40F8ED8AAB93@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: OxHQ5f_fd8UEnZ5a45Tn1AZMHduFG6Ow
X-Proofpoint-GUID: OxHQ5f_fd8UEnZ5a45Tn1AZMHduFG6Ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_18,2024-07-25_03,2024-05-17_01



> On Jul 25, 2024, at 7:16=E2=80=AFAM, Jakub Kicinski <kuba@kernel.org> wro=
te:
>=20
> >=20
> On Thu, 25 Jul 2024 16:13:00 +0200 Daniel Borkmann wrote:
>> On 7/25/24 3:30 PM, Jakub Kicinski wrote:
>>> On Thu, 25 Jul 2024 13:43:12 +0200 Daniel Borkmann wrote: =20
>>>> Hi David, hi Jakub, hi Paolo, hi Eric, =20
>>>=20
>>> While I have you, is this a known in BPF CI problem?
>>>=20
>>>  ar: libLLVM.so.19.0: cannot open shared object file: No such file or d=
irectory
>>>=20
>>> Looks like our BPF CI builds are failing since 8pm PST yesterday. =20
>>=20
>> Looks like you may be one step ahead.. BPF CI runs tests with LLVM17 + L=
LVM18
>> at this point, so we haven't seen that issue yet. Maybe Manu has?

I did not play with llvm19 yet.

Checking the BPF CI netdev builds that went red yesterday 8pm PST leads to=
=20
https://github.com/kernel-patches/bpf/actions/runs/10087416772

BPF selftests build is failing with:

    CC bench_local_storage_create.o=20
3298 CC bench_htab_mem.o=20
3299 CC bench_bpf_crypto.o=20
3300 BINARY xskxceiver=20
3301 <command-line>: error: "_GNU_SOURCE" redefined [-Werror]=20
3302 <command-line>: note: this is the location of the previous definition=
=20
3303 BINARY xdp_hw_metadata=20
3304 BINARY xdp_features=20
3305 TEST-OBJ [test_maps] htab_map_batch_ops.test.o=20
3306 TEST-OBJ [test_maps] lpm_trie_map_batch_ops.test.o=20
3307 TEST-OBJ [test_maps] sk_storage_map.test.o=20
3308 TEST-OBJ [test_maps] map_percpu_stats.test.o

across all combos or architectures/compilers. I did not see anything relate=
d to LLVM19 though.

last failing build was today 5:17 am PST https://github.com/kernel-patches/=
bpf/actions/runs/10093925751
with the same symptoms.

First successful at 8:02am: https://github.com/kernel-patches/bpf/actions/r=
uns/10096557745

Manu

>=20
> FWIW we got a PR on the list last night which was based on fairly
> recent version of Linus's tree. I dropped it from the test queue,
> but I suspect once we FF this will come back.


