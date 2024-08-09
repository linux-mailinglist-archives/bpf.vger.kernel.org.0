Return-Path: <bpf+bounces-36785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB094D59D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD891C20A77
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46684D11;
	Fri,  9 Aug 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lNYb2VsU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZuuhVNQU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF217557;
	Fri,  9 Aug 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225770; cv=fail; b=sx1HxHm8EVTnTxV3vpJT7O8JFXQk+m50alDOBbsxiAW35ITsDcboyBqkUXnTsW16l38zdP7Qi4q8AXUyCXI34RNVcK1HDbJ5I2pzxlsIQ9Pi4eeZh2OuaS58XTFInkNb5VI9y1vfJ7Gu9GP2zu5vgJLyVdTiz3oXWMo2UPThlNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225770; c=relaxed/simple;
	bh=7qkXOMflB3zMYEZ0mAgJqTKc2d9NGUAOZ8j2fL8lW+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GyXn+iKwUQ10looQRFz4BBhxUlfRrVlGNDTv6qq6W0PRINnvLUgwonymssgmjFFwoncuu1ucKTVA2D26EFkwPbYyjhbBYepQEFzuKKtEALnVo+Z45UoLdruT70Rp784eBtfeSE+y/oEjnVia58U2RnBzs+dv4IMxawvYx1zoqXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lNYb2VsU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZuuhVNQU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMXsu018815;
	Fri, 9 Aug 2024 17:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3TA8zLJPXdsy0nr9O32N08SKX8czJkPfu4tTJ+VXfkU=; b=
	lNYb2VsU/pLXMji5dU0CA67RWnWG7ZufyVgahzS8c3nCQ/XVemgS3Z6L7lBVFCsb
	tivktUMsJpdDqk+HtiXH7yQ09oEvbe/7pOtV/ItVWXhrqJDZ8+GfZxqm4atppkLH
	1u1eH/n6qo/AWvQJz86l4OmtWajBHcv8ImjTDXrZ8KvzGHjee3TDEGKWzFDsYORo
	K5E/3o36Y/wYFxVKtddKwDSjsYUuVDA5vRNNMpPvuOe2Lwacb47rzxgw2ky5esy6
	fZ44kpbeo8yZL1iZTnGRTfNjcDUiFaxLjeQPBp3ZgV0YVi4WyFmCx4eIFPrq+pUJ
	rMF4GNubyqS+6x3864hCYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce9cdd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 17:48:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479GSgJJ023876;
	Fri, 9 Aug 2024 17:48:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jxffu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 17:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1+qaug7XqvYd9A+T0WQrSpfZjVgTHX9VTkj2LRZwDlpja2ulyuhTqs1y8oHueEhlo0NscmEmeWV6UgD79qTKon5g2QmVNYLqrRWniIrqpfwCTLhaVofyrMVnrp7w0m9q9ktA3W0KPrZ3VQB1DSeAbv9HHFELnmPfdrYczIbX46t3OBxRWRdNZ19GzIy7323OfV8d+bOeD3VPcZ1PK+ffkkroJ3JgsoSus/rzPwziEuQMBe94+FUzHpBjmAmzq86AS1nt417H5mlKomLyO5jbztOV7NNlPw9FhgVTNr9a/y3eSYqm72Jlu9VBr2kOdP+cokZFB9wqaQTot2THxGE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TA8zLJPXdsy0nr9O32N08SKX8czJkPfu4tTJ+VXfkU=;
 b=SgOM09GU8pYC9QzbZ1tEWUSH9IbyYHQqnpcnQ4yTQakuA3/BD2DYK5V38D1ieKjOj5utCYSS9Qq9jy3oZiXW5FN30KCAH9jaMWFg4EHTcaKIVXJhIJKYhRUm6SGtzayvM20IoqbF6Y9lzZzBeOTjxoz9+hxhCwubynfWTVSLG78lAn1Dfke0oeEZw8Ls+8RvkdyciPglewaC7j1jdZ0BFjEdKHQoMCaU3T3xZPw6dWIYKIq68vYy3LLIarkNluOlJ2c9fWLePPilVBicht1Lmg97SVqpzfboW0AgV7gPrXJPZvEsRO4Tb3QlHdcI8H/YRidAyrNeJEzpHjt4rteHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TA8zLJPXdsy0nr9O32N08SKX8czJkPfu4tTJ+VXfkU=;
 b=ZuuhVNQUgBSjK+Sxow9H7FydRoKPuiT1hNS3rleXK+gvZxyuGiJKCkHhO3jOOEk5wCXdKC1Y2So5tF9Qpyd7sUsVCgKklXZUppTm2QmVdaV9OOY9+5MP6fqv9VlhUDb8OgAFtl1ap4mEAKEsMQ2Z/76W/FECkjplXvqHnUK0alc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 17:48:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 17:48:37 +0000
Message-ID: <3c9e6cbe-f768-48b1-9e37-779971fd1146@oracle.com>
Date: Fri, 9 Aug 2024 18:48:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libbpf: workaround -Wmaybe-uninitialized false
 positive
To: Sam James <sam@gentoo.org>, Alexei Starovoitov <ast@kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrew Pinski <quic_apinski@quicinc.com>,
        =?UTF-8?B?S2FjcGVyIFPFgm9tacWEc2tp?= <kacper.slominski72@gmail.com>,
        =?UTF-8?Q?Arsen_Arsenovi=C4=87?= <arsen@gentoo.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <8f5c3b173e4cb216322ae19ade2766940c6fbebb.1723224401.git.sam@gentoo.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <8f5c3b173e4cb216322ae19ade2766940c6fbebb.1723224401.git.sam@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cffb246-7c94-412f-6603-08dcb89b7f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?US9wWGRPNUJRZWlvMWpDMks1azhXZmNjRkVLNVVvNkRBM0IyakRHeWE3ZE1h?=
 =?utf-8?B?aVk0SW5zMHpLcEtVNk1uWHJ6SjkxaVJsamFUMERvZGFySytkZFZXbmRFRkJT?=
 =?utf-8?B?OVlxazAxK05rbE5ITGZqMzNvWGNjcXF3cllGNUI0azVFdW9DNjdZZm5lZSt2?=
 =?utf-8?B?UWt0aDZQR2Y2ZjVFSVlFMk1FckdmYlZ4elZZQmU3RDNacW91WWlUaGVuMkFL?=
 =?utf-8?B?ZXJYVjhxZFRFMzhOOWR0WFQ5RkgzQ0RUbDdWc2E5ZWJyQ3huMVdZeDFrYVlK?=
 =?utf-8?B?ekJSZDJnaGdHenRXdG9ta0hDYmt2QmYyeFUzMUJ4eDdaQ0g0RUNsS1MvYWZU?=
 =?utf-8?B?dmhXU0dFWjVEZXd0NDVUZU4wQngwN1lmaHpBTy9aRWdhOE5tMnNTYWJwN2Vv?=
 =?utf-8?B?UUo1bkNoQWtzRWgrS0hNSm53OEhNRFdXUEpSVjUzUFlDVEhXU2dBdE9zRzVk?=
 =?utf-8?B?Rk5seCs5YTQ0dmNlRHBWMm9vTEZkNjR4QzJzOC9KcnBFVGlHK1JJcWNwS3hy?=
 =?utf-8?B?eVZON0xxalV6T0NWWml1aGRpS2pOaTBpOUpocU1FdTF4bkh1Z0tQYjFvMkJM?=
 =?utf-8?B?RHNiQ1RxRlE5RllmaS9nekR5cEVzek5vODF3R3FTM3A5WmlyK2tQTHVURmx1?=
 =?utf-8?B?ZkVRVTJtNE1PaVBFTGlrWkJ0RXU4ckNnQWtmT3V5ckYrbkVzV2tBWGFoSTVn?=
 =?utf-8?B?VXR0cjN0MFpYR2czSDRIZHJGUWk3NDQ1OGc3VHFod0hpWGxPMUNRelR1dm9r?=
 =?utf-8?B?RHVaZDRoenRDRUxoZENWRENuWk9pYzFEQ0tzYmh6bUIwYXVoRmZCUWF1VWo5?=
 =?utf-8?B?NHdvYXFVZjRBelBianFhczU0WFM0K1UweDBZOTdhdWZNSmtadUQ0aUZQSmZx?=
 =?utf-8?B?ZytQcE1JSlM1TktjWEdUK1pnSlorUTJaWjVHOHg3Qlg4QlEzbXA1ck9MTkFi?=
 =?utf-8?B?TkRVb1VmSXdCQUIzWU1QMkJNbTRjSU96dDc4SVByK1pOejdyWXFFbkhQVlpP?=
 =?utf-8?B?QzlLMVRNUndubDRjL1UxNEJCbWRxSlNGd3VMSzNqRkhNT1UveXcwZjh4UmlK?=
 =?utf-8?B?MlBnUHZWYkkwUFZpb3ZBMkNTRmpmQm9pS0ZzYTZzNzR5eG1hQWxRdHVxTVhQ?=
 =?utf-8?B?d2lKNENsYk13MG4yNHhycndxNUNRZXp4Q2xFNDRQN0gwdkY5YmJSRVFLT0pn?=
 =?utf-8?B?S1VjdVBVRVFFNjZKTUNxL0NsRnB4dWZMRVUvbkFKT2d0NzB4OU1KQjFTZVl3?=
 =?utf-8?B?bTR1bnVRVkRlZmIvRUlld0pIQWhHNTg5RXhZUFljb041dXRPQjBsR1ZUMG8z?=
 =?utf-8?B?elZwc2krdkpQRm9OTDQ0U0YwSzduNlkxODZKVTQ0KytWbkdMcEFaaGVBa3Nj?=
 =?utf-8?B?aXhDNUsyajE0dkdTS21UYStqZ21STVpoYXJjK1ZuWnp3YloyN2VQU240VGdP?=
 =?utf-8?B?NTFRcHlBYzBKeGVaWm5IRWhGa05mWkpaNVdVYy9ETVd5d2loOWI1OHFWMmFj?=
 =?utf-8?B?Mk1hOHc4T0VsU1kyallkOTg2ZCs3aVhHYWQxRU42Tmx5OGhveEpSbGtudW9L?=
 =?utf-8?B?elVaRkxsbVVoMU9rS2ZaZytoMXVUVy9vU0YwTHgrbnZqODdhQ0tsUUt5Vkh4?=
 =?utf-8?B?WXpkeEQyNis3TUxJK2hwOVJrKzJBdXM2amdHMmpLS1ZxSnZ3SFRnQnZycGx0?=
 =?utf-8?B?RGVka2EyVmhHS3ZKSE5INlFocWlsZExBNFJBZEdPWHVVRGlwK3VUY2F4M0xj?=
 =?utf-8?B?QzgvaTNhNUhIRExnekpEN2ZLWHJOK2p3UXlRcWVpalBESzRXcG9WdWNKcnMx?=
 =?utf-8?B?NUNKSkNMU3NBUDN5Y3ZzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aENKWEdGcWRzWW9PdlhpVDAxbTNiRVRlR1d6VEtPcTlMOEgyaWlrdTFxZ2hv?=
 =?utf-8?B?UisyTVBHazB3cHQ2TFhTVnh0VlhPcC9aUWJkcFc5VTk0NHN5TDZMT2ZuSEpj?=
 =?utf-8?B?WkVRSTRla3BSUEhYa1g4eTA0UUwzWkRHRzU3Q2dBZVdldnJ4TjdjaVh0WkhD?=
 =?utf-8?B?Ti9ualQrSXVwYnQwaUZlaFZISEFhNm92aThyQjJWV2I4TnVBdHV1YStYSTZs?=
 =?utf-8?B?ODBkVTBLSTZZWXc2STM5UDIwdVFqVVZSSFBGUDJSaUpwMURIYW5meTFPN3Nh?=
 =?utf-8?B?aENjYWdBNklIWUZPRmlkZFpUQnV3YmtWeEY5TzJoakZWeWFoVEdKbzlLZXhV?=
 =?utf-8?B?SUJiUnhteUhidFJPODFheFg4LzVxQTh0SXo0Qzc3eiszdWt6Z0JDQldYeURy?=
 =?utf-8?B?d1VpN0VpSHBNSGR0c3VtdDZYcUFQTUxTVnF6dnVqWSsrN0tBRHl0Y2pUSElM?=
 =?utf-8?B?SkRvNjhvTkRJV3o4NmcyS3dLRXVMVzA1V0tQZnh1Rk03NlppaUJpQzBhQ3ZL?=
 =?utf-8?B?bS9pcEZHSkRDWDhaZEs2dlFPUjIrUC9Nc2V0emU4eEhHbTBSQzg5TlZNVjN2?=
 =?utf-8?B?VDEyNTQyTUw5TGdvd1NJQVJBZUcreGdjS0d6R25WZ055dVpkcXJSTnl4bk9Q?=
 =?utf-8?B?bXhlL09WdVJKd2pqVWVGclYySkFwZ1poMGIvZm5QOWlpNnhGcjlhVGFUSzVr?=
 =?utf-8?B?UVk3Q1I0Y0Y5NGVYUHVhamViUUFWNUg3aTczM0lsWHM2ZUpKY1kwdEdJS3B1?=
 =?utf-8?B?LzdhWEZsaUpQd09uNjBaYWNhcjFlOWtaYWFsNFJSU1hOc0JlUUdnMmFIMTRM?=
 =?utf-8?B?aG8yUVJuQVd3YWZoMjV4bVFQUWF0QzBJeDRqdmpoN2NpL1pXTkM5OGxvZ1Br?=
 =?utf-8?B?NjhGU016WVlJb2hsQnN1bjQwNHE2ZStiTjZ3K2haZUtoTnJoV1VIU01pelpa?=
 =?utf-8?B?KzBic004R2I3RHFjTTJzSyt3RFIrUGZDcGdwTkg3eVowSnF0d3AvSDhVa0ds?=
 =?utf-8?B?MWhsLytaYjg1SDlranl5V25YYXBXVllDa0lnVlZScWpTSXdQR3NpVE1IRith?=
 =?utf-8?B?Rk42YTRzazUxNXF3bTNmUXIwRU45WGpWb21Ham9sK0dHTkFvQVlRSXFRYThy?=
 =?utf-8?B?T3B2MHQrdllTL3k5Y21XMVBWNnJuN0xRcENUVm5lenFxNEovREV0OGUwdlJB?=
 =?utf-8?B?SStMOWE4UW1JMC9JM0RQSC93ZWdJOWhMZ3NrMjRFNUQ4YzJ0V0hXSWFRZ0NK?=
 =?utf-8?B?ZC8zVGdjSEVhY284bm5mQTZRRUovSklhN3E3OG5vdnpEcVpiV3JXZkVtVzA1?=
 =?utf-8?B?ZFNHSURPLzNveXdqWUlwcmlhbkJsa2svZDg1Y1lDSk1oeUZnZ3ZJLzBpVTB0?=
 =?utf-8?B?dS85b054bTV3Vkg5QUk4am9YbFpiejRKRXdYcUUyRm54YWFYUzhuaG9QNi9i?=
 =?utf-8?B?b2NHSm5CWEJWU3lhNVBzaUJJSDh0dnZOMkNUcEZ3RzRydUZaZmRqazBYS2Zs?=
 =?utf-8?B?S1JjWGVWaEprSWlKTGlTSENFTHM0V2Eyc1BiNU11OW56amFkL2FXcGRLUWkr?=
 =?utf-8?B?b2dwT2hPbDZvczJadmRPK2xPVzh0dGlBc1pKL1NFdXRaUWlyMDRIdlRaeDJn?=
 =?utf-8?B?bzBEZExuY2x0cStZdTEyN1U5ZzRFSUJnZVp3dDJ5OE9XbG5TSDZxd2xteHBx?=
 =?utf-8?B?TkxlQlU1dWx5b2tWMDlFbmkvZ1VzSEwwaXdMQVcvZy9FaDJXaXBGbEJTRVJU?=
 =?utf-8?B?cDV1NWVtWVkwWTZqRW5PTXFqRlJMMFUvL085NEJXdnJPUVZRTUJWa0Y1a09w?=
 =?utf-8?B?QVFFeGxiaHIyY3BSaE5MOE0wQXU3TmM2aVgzUEYyYSs1WFZTd1R6OVNOc1hO?=
 =?utf-8?B?cTJnRVJFR2g0eG9yQTVnZDJLck9MRUZieFVSWG11dWV6QklGQ1gwa3pIOGVq?=
 =?utf-8?B?M0t0aFd1LytNUThUaVJCNStlRDJYK1ExYm96VXBkbmZNckx5ZDJUQXZCTjNi?=
 =?utf-8?B?U0tybVBZVWNvbll6QXYyYWkvL3Z1M0pFS2J0R1Z4UE1WZk14Rk5Lb1BseEwv?=
 =?utf-8?B?aTFiZkVPam52OVJLYkZ6MDdmVXFnTDNET21MMGxicFU1R05kSmtxV0gyMzlj?=
 =?utf-8?B?N0t0QTlEOTJzdjg1YjFKM3BXV21QTUdXNWNNVWVkNktkc0puOGluU0dFems1?=
 =?utf-8?Q?e760q/90oEPM5mxDtK0D0Bc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zv/BALp1nrBZCigjakr8IPq++75coon+fLexm0vW3aAGjd98vz8Zd/zXiZbUrUREUuafp+oBRfMHbiDetAlkOLGN769IBm+sU5WXNQgGmGfVFJI2xDvBMfQ8o5FkM5IY2p4XXgZP3Nzs9qNcN/h1B8qTc2HYXlYfRIYyekC2tV8XwUWZdB1aptgnl4FM5VXB+sCpRmRIiXM4N68aMcDS2DXWffsnlo8A7rlu8sMp3W3Shy/DMw6S/gXHZ0On+EtdwuHfxkYGGdeN9EjmrVNKcM7wKfK0GqFiLMexdXxa9mea42mzJ/QeE/nWSw6Z7cW/ybHt/4pcQ4mmNYay/3jGHbHv7uL2FUytInCpZV3ws8IjA5RJBOkiQE+etxpCpplHPIVbiB8sMRIDHhJ1PWkBl/LO1Sd/sF2prTpKKyTCExtXRfUNMruhxYJ/+01AJjjndNsD2sjC0+2ZMh4b/hHDhaSlJLjVY1K+KHo0BIr3SPr3g33PS+a4ErarY9007uTZTe7BU4H58HC9PMrNrQT5Hdmj38muEp+i50JhVHxJmI/PEecXz3r+z5ibamCO7IqSPer5rIy/ya9kCHlqjXUCvNfadlyhJ7MOhfQnebKS+hY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cffb246-7c94-412f-6603-08dcb89b7f3e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 17:48:37.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLAGs61Ud/nhy+tpFQSIRElsF/4F55QETB77O+UIv62odDqllwFuwe/1Vt9zmi0ZYElASOpO9MBeGQVgjh4wvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_14,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090128
X-Proofpoint-GUID: eCQKejf85C55mEe8RAiGeSsoev5sWhtt
X-Proofpoint-ORIG-GUID: eCQKejf85C55mEe8RAiGeSsoev5sWhtt

On 09/08/2024 18:26, Sam James wrote:
> In `elf_close`, we get this with GCC 15 -O3 (at least):
> ```
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
>    57 |         elf_end(elf_fd->elf);
>       |         ^~~~~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.elf’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
>    58 |         close(elf_fd->fd);
>       |         ^~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.fd’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> ```
> 
> In reality, our use is fine, it's just that GCC doesn't model errno
> here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly.
> 
> Link: https://gcc.gnu.org/PR114952
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v2: Fix Clang build.
> 
> Range-diff against v1:
> 1:  3ebbe7a4e93a ! 1:  8f5c3b173e4c libbpf: workaround -Wmaybe-uninitialized false positive
>     @@ tools/lib/bpf/elf.c: long elf_find_func_offset(Elf *elf, const char *binary_path
>       	return ret;
>       }
>       
>     ++#if !defined(__clang__)
>      +#pragma GCC diagnostic push
>      +/* https://gcc.gnu.org/PR114952 */
>      +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
>     ++#endif
>       /* Find offset of function name in ELF object specified by path. "name" matches
>        * symbol name or name@@LIB for library functions.
>        */
>     @@ tools/lib/bpf/elf.c: long elf_find_func_offset_from_file(const char *binary_path
>       	elf_close(&elf_fd);
>       	return ret;
>       }
>     ++#if !defined(__clang__)
>      +#pragma GCC diagnostic pop
>     ++#endif
>       
>       struct symbol {
>       	const char *name;
> 
>  tools/lib/bpf/elf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index c92e02394159..7058425ca85b 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -369,6 +369,11 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  	return ret;
>  }
>  
> +#if !defined(__clang__)
> +#pragma GCC diagnostic push
> +/* https://gcc.gnu.org/PR114952 */
> +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> +#endif
>  /* Find offset of function name in ELF object specified by path. "name" matches
>   * symbol name or name@@LIB for library functions.
>   */
> @@ -384,6 +389,9 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
>  	elf_close(&elf_fd);
>  	return ret;
>  }
> +#if !defined(__clang__)
> +#pragma GCC diagnostic pop
> +#endif
>  
>  struct symbol {
>  	const char *name;


Would just initializing struct elf_fd be enough to silence the error
perhaps, i.e.

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index c92e02394159..3060597a527e 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char
*binary_path, const char *name)
  */
 long elf_find_func_offset_from_file(const char *binary_path, const char
*name)
 {
-       struct elf_fd elf_fd;
+       struct elf_fd elf_fd = { .fd = -1 };
        long ret = -ENOENT;

        ret = elf_open(binary_path, &elf_fd);

