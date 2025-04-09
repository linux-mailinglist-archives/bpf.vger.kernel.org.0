Return-Path: <bpf+bounces-55510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A76A820A1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F6F42460A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372C25C6FA;
	Wed,  9 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hxx48aJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JAr07IHH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1B1DED5C;
	Wed,  9 Apr 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189241; cv=fail; b=eCskSk3VihPsft1sGa+m4IeN6OTeUBmOD/DXi/6jZbhNVwO4oRe3wDgDD+gGwrkQEkSOKz0LZjb+b/N3rkgKG5YPB3h9lf8R4Uf7j0PjWqsMtPTQ9135GkK1vaJ4AP3ypIt+lnztwGEWJjlOBy+DBD0qa6xwFEj7NaC9niieexs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189241; c=relaxed/simple;
	bh=uD5mNE/p2K0Q+8Wh5YT93oqXXYGNbZl+6yymSj9C6jE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCmykvkpG1yaPCPLXAYg0Foda4WpjwuaGvGvQR/5kk4sVsTOPrqLKFo5CFv1rGzKBv8OxqL4et63+EFEsyswgg7ZLZf/SyZlcfGLEkmYrdu0rM6ygYqTjTEFiDLNW3Hq5lwExOy0BCDExJmBiyoRKk2IT941ACwjeEFns1wa9cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hxx48aJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JAr07IHH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5397u01U010909;
	Wed, 9 Apr 2025 09:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sV9ak91oclQTW5f29gmqzLcw0vuEXHVHewZ/OLYOaxA=; b=
	hxx48aJi7nyt52g66gQQcn+HbrpPxijakmQXqXGEOC7ipHBRVzFbbbghI6DSzJdb
	1gdp6K0vadsuVTaVEdxMrEY5GgdjiZgm7kWjC5WK5IQSkYbEp4ADakSnhph4yc/R
	E9HLTyHPAFNBWBTFrNFqfAiF4+Cgnhqn4EG4N2op+2eISRuUgDLVulyuhHaeYl9e
	tWT1lYWSzE0OxOmbsapxAHf8SUt6UYMTFa7j67PH40e7Uzf1Y335MNFBkxNFPxzq
	WOwubzvz2cTHJSBnrOFxHeuySvq6gC6hYn9yNPTd2ck471123YseIyRIp6x+ckE7
	lSQmW0dKqvhOha9iQRn15g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41epxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 09:00:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5397Y2OZ021126;
	Wed, 9 Apr 2025 09:00:00 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttygur5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 09:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSh8BtvQUHtBok3yc/iWVFaRHahsMSl/FehUENqPtSmUN+SvgY7+G2sjRvIQc3ZxLzvBLI4LmLr2hoMme21wMo6fHDPmiKl+9Ynr7tWExQPKRVSzT/qp0SCxNwOTz9RUc6ZSAM0vTw0P7oGj3ADbenz9SmdUDCeAkEotZKijJIsfuCqKw3Cq+5XJbzVHcV9KhPoJXZiPD2qXSy1aJvO1GA7C4gYa4C5Rc9Yd4o5RgDa4UwRvGwz/QHoCFq5zGwz+Cd/rvrqAQfs9s6WYMZEDHsGX2D3t3yHMQ+ge9XuhYgXOdr4vFs64tY3DNV/QoVP4f+oQYMfF/zDHslUdjIUjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV9ak91oclQTW5f29gmqzLcw0vuEXHVHewZ/OLYOaxA=;
 b=WDw4WsPfaZJHbO+riP7qHsqCVvUGvTwX76UcBqtWEBtEoaG5JlA3nfm0zNNhPYm+PMsaix5pocmtGIsKsS8XGLsL+n8Ei/t9McyF4MlFg4V+maXz6iR4jtnGQtN9sHKYdPKafdwHRzL36oMhtjEtah874yhtgfD6L+JryuS5r51+K/SFoY3mx/N+xHJpr60ZPFhPHp0U/57TrMxnesC06FXlMt55bAp10Xy+EyLsUZ5214Df0B06O+YENWzTawDrJQ1++ys8Ij1q4j/xSrSgQcI6WqyLCApB+0yEiOFgu25FBHSMzaEtNHNA04teRRp0DWFnaNgpQxSND73b6zCuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV9ak91oclQTW5f29gmqzLcw0vuEXHVHewZ/OLYOaxA=;
 b=JAr07IHH4lltYLPSZak/4FytXrI0Woso+2HoW3UZHT90QzCj/a6YEkEv/Acvt5pHVEYS/QAwk4olN34HJpQKQnNbdz2802CfK+5IQUQ6aJh9wj+45O48vNEst0FVcuDPAcj+5aRYuqsghOkQLvSqHIEX3+FUedng8P/3yVq/xnE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 08:59:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 08:59:58 +0000
Message-ID: <290e2542-fc51-402f-b84b-00e1f2ca2bfa@oracle.com>
Date: Wed, 9 Apr 2025 09:59:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 1/2] dwarves: Add github actions to build, test
To: Ihor Solodrai <ihor.solodrai@linux.dev>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
 <20250401092435.1619617-2-alan.maguire@oracle.com>
 <880e470b221b93882250e759e4a7334b48ec88b6@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <880e470b221b93882250e759e4a7334b48ec88b6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN0PR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b64cd5-ea9f-4b4b-5164-08dd7744e76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnptYnU3WVVHNFJlTmJrUnpNNnM0dDhFRFVpaDZaZWl0dXZraktLcXF0YkRh?=
 =?utf-8?B?UGVmeExxL0E2bEYvZXhMMWpGd2FFOTFPMXJuYXFQcktFU2tScHNQU2d4Nzhm?=
 =?utf-8?B?VUlId1hGcFRLSE9WR0ZnV2V4cytOSkswQzRmdCtCaGRHOC8yL2FUQ3BxNTNo?=
 =?utf-8?B?a0RpeWVnQmh0eWhYV2V1ZGFvemU4Mytwdk1uSWZ4NGMreTVMQTZqcDJjSTZ5?=
 =?utf-8?B?S2J3VExZNDl4bmFKN2J1MWZiOVhnMElNYTluYWJSQ25weEwxTVRUZW8vYjBa?=
 =?utf-8?B?TmlIY0w5aGdia3I2Rk1TcUU3ek9qYlU3WStWWklRNDNMMCsrdFdPbXhRTjlw?=
 =?utf-8?B?Vk9FakErb3k0cW5CcXFnODV2MlIrZUwzcXA2NnBmczEwV1NMRDNoODNmNTM1?=
 =?utf-8?B?MkJzZlZEL0pKYVN5VzZnd2gxUzBjeTYvUmJaVjdYMVVIR3JNaDczajF4WGM0?=
 =?utf-8?B?RFJGWU9jM2JyUy9kT1A1Nk5vekl1dUJPZytnNHhIMW9YeFFjdnArYXNtM3N0?=
 =?utf-8?B?bkFLdGNhOWlpVDYxZElvbjhSWGE5dC9oZDBIbG5mRk15T1hOYkpIelg2MTBu?=
 =?utf-8?B?blduZnNya1gydlFyYkZMNjhQdno3VzBHMTVqUkM2RFZscklLT2tFb1kzdXJD?=
 =?utf-8?B?STYyZVRETTIxMXVEd2xlemRSRzR5Z2R1RFdtM3RFaWVyTG9LRUNFa2VyMjVr?=
 =?utf-8?B?Umpnb0lRVTFpUEdvOGsyZUNtY2hwNTVkZGU5a2ZoMDgwWGh5czlvdmhBN0VL?=
 =?utf-8?B?VWUvN0Q2Q01vOUlkQktVQVJSdnVyTi9jenQ0VGhIWTdGVll6RlVnZ2hyd1ha?=
 =?utf-8?B?SS9Sb0p6dVVlQUVUb2c5ekUwR2lGSUYrZUxnK3NjdkxuMnZTZDhPb0R2VzlY?=
 =?utf-8?B?dnB1TVBENGZCcGk5UFBCbkE1VUx6TFAvc2NNSFh4SjZnQU1QMkJVcE13cmtE?=
 =?utf-8?B?U01SVVZwY2k2bjBCdU5FcktLdUZtT3orWnB0eGF5Zjd5V2ZwZi9oaU5GY09P?=
 =?utf-8?B?Y2VJbExBNGxSVmw2eTM4MUpFRnRYcGx6ZnJkNndtMlZVVGg5WjJmQ1gyQS9z?=
 =?utf-8?B?Q09MZ1A3TnhOSCsxS1hNRE5hakpkSmh5Um1FZmszQ20yWDVvL3hVa2hZU29t?=
 =?utf-8?B?QWFhdFhBck5lS1ViaHF3bFVFK3JuNklHZVRLUlVVWWRQUUl5L0xERTF1MytV?=
 =?utf-8?B?NWR1aDN2UjREUVV4ckZITSttVFlmaFFKMHNLUm5sbWN4VVFzckdaMUNWaWpu?=
 =?utf-8?B?YSs3VkhZUXRERjV3N21hai9qbWQxT3czRURoaTFSTWFqZ2lHS2psTUhIcGs0?=
 =?utf-8?B?Y3BlMFNudFV2cXpCZkVubTRwakQyMXVFcC96RGJmNWdiMlAwV0xkdlpTV0pO?=
 =?utf-8?B?Q3hkWDBFTWF1cFZKRXM2eXF0aGx3Y1lSRHNjVjQ3WjlEa0p1d3ExQkFXeUJm?=
 =?utf-8?B?TWh5OCsvcGxoamhNYnlvalZkWmdyaTBCcnJkanEwYm9tMjZja0E2MDdXSHZ1?=
 =?utf-8?B?TXRCdkI2V3FaVkJtWUNrMVJjd1QvR2dzNUFGS0hCNjlDNFZiaHhQRjUrMmtl?=
 =?utf-8?B?bjZsSlYvWU5Od2RFZkIyNGhmUmdCcGEwWmZvN3crUjk3Zko1d2MvaEMyQVM5?=
 =?utf-8?B?YUh5Y09yS0o1UnFlRFZUUHphbHJBdUhUNHF3bGxoQmgvSldjMk15UnJDYmpp?=
 =?utf-8?B?Q25zV0FHK0ZzQWIzMEM1TzlZdy9LREJBRXd1cGp0aHNxdXBvblBMUXpBVmtn?=
 =?utf-8?B?NVJGUXRkU1Rnby9udGIrZkoyMTlFSWtOaWJGL1BNTG9yNkp6TTdHakRacklJ?=
 =?utf-8?B?VUVnOGVybDcvQlo2RzZyQnBZMXlrZ2FYeVU5WjlVUWM5eDU3LzZGOUFKcHR4?=
 =?utf-8?B?ZGcxWWNsUjVleUhrMmhXbng0K0t4NjYxK1BnbGFXUGVnR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUtLbnV5Wkt4UUdSbjhFb0M3bWFTa0lIQ28rblYwczRQRndhREhSVmJmdzdr?=
 =?utf-8?B?ZmI2ZWR3eFl4UEJmZ29EUXZrMUJLdFIyMDBzSlRVWFk2Ly9NSDJMZXdKa2Ur?=
 =?utf-8?B?aVBNcVpuVFNiaVFYc3liaG1pTHhOdVAzK0pMWXh1WkJZcU5vdjlxaGFEQkgv?=
 =?utf-8?B?KzNPeWdpZE5iZEVZZll2S2x0VWh4ZWptVy9Gb3crOXJRRGVlcld3aVNPaTRr?=
 =?utf-8?B?N0JobVhDMFJwNUtNbE9PWEc5c1JRaFM3L1ZKU2xkOXpaTXk4S3Y4aEJSM0lh?=
 =?utf-8?B?M2Z0anN1L0ZZY3JicEM3V1E3a0NvQmMxWlRUR3BiYU5PVjUvN0duMjVpVytT?=
 =?utf-8?B?TnQzTno3eVBFNmh2d0JWUndHOGpmTnVuNHJpRm9rdU1JcXp0WnM2OWtaaERs?=
 =?utf-8?B?OVdKcjRWWUlzYjkwSlJwYXkwamNUTVI1L1VxSi9yclV3UmZqMHhaRUs1ck5n?=
 =?utf-8?B?SWZYWmVZbDNDTjNIUHVPVk1rM3p0ekVnemdHQzhoczMvRGtmc2QrU3BZT2ZT?=
 =?utf-8?B?a0pQOXkxblpzYUxoTk1MMFhjcTJ3eDZrYXFYUDdqQ0RCZ1VYMUlya2JTalZE?=
 =?utf-8?B?OFpuK0hIQ3JzWjNmSGJEbytKTzRZb29ONzJWUWlSa01LNi9xaVhqZnA3SE8z?=
 =?utf-8?B?V2lDaWdLT1FHOHBwazAyam9DTmREbFhPZHRQbzJwZGdGK3E5ZE9TQVdRRkVY?=
 =?utf-8?B?M1JLdkthcHBDeFFJUzBhQjkxQXRVWDRnSlh1SVQyMnIra1ZlajhBY3E0Z3lt?=
 =?utf-8?B?MHhQNW5jaWtscHpRYmdWSWcwVjdOUENPbDkvQ1pITFJsbzNsUEEvQ1RZRWhI?=
 =?utf-8?B?V1ZuRGJaK3M5aUc2VWxwOERCRHowNzZ3a3p3VXdQN2pEZW9Cdk1FUkY2aG8w?=
 =?utf-8?B?bm53QnAwQnYyamNjaUF0UGlYSmpSWWNQN0xVUlpNditncWNHQ3BRQkpkUUFK?=
 =?utf-8?B?dnlWdTNXWnJ2QlppdXdWakxHMXdNUG5FbDlkaGhKc2dBTFYxaXFzZWErQVk0?=
 =?utf-8?B?RUhVdWtmZTlvbjZqd0U3am5wS0d0YWdyN0pJTVdFSHJzQUdmaEptL0NibmEr?=
 =?utf-8?B?Z3RKS0oxUEpUMVBLS1o2RlBxQ2hUMmMzSVJTTWxzZGNrQklkeE1UN2lWMVI0?=
 =?utf-8?B?MU1UUm1SYlA1UHU2a3k1MkgxU3FENWFieEQrSGs1RWt2L1RGMHFHcDNPZzl0?=
 =?utf-8?B?YzQrYmJwTGY1UFBpYWJ1RUoyZUp6K3FrVy9ROUpkY0xlemJkKzM2T3l0QjlY?=
 =?utf-8?B?dEVwYXdMZnJ6L01aaFRqaHhia0hRVGRRQ3Y2SVBaSHFFRU92Z0srZjBnbzA5?=
 =?utf-8?B?L1pqK2RGWXdEN2NPYkhZWThIZitaWU9PVUdybWc2Tyt3UXAydmFYWHBMMjlw?=
 =?utf-8?B?NVZHV0F0Y0pvdnlJanVyOXc3TkpRbVlscTN3QzFDUnpOdWFsM3VWc2FWeFVT?=
 =?utf-8?B?OGVoQmphR0JxSGxGZGJVa2d2QURkalpDYjJDVnhaMWRPTEJRb1E4cS9temJH?=
 =?utf-8?B?aGhHOEtaaG5oOC90N2RwRlNhSVAzRHdUdVhGY1FNMDJQTnJIVytZR2Rma3lL?=
 =?utf-8?B?VHJDM0UrU1RWSGhUZENNZlROWG80czhuN0lWTXRQWjdWcnI1K1duS1k2UEN6?=
 =?utf-8?B?NENjQVFBUDJUQTJxVk9TZ1RyVmI0VUJnUktWTUFLdGE2TGw5cFNiVzhIMy9P?=
 =?utf-8?B?Tm11Vld6ekNFVzdzdThxM0RNNnlXMjJjODFlSHcyUDM2U2pXK2grajRNNnpT?=
 =?utf-8?B?UFh4RUg1ZEw2ejlrTlBCVVJwU0FPWlZ3c3NkbHY3aVFDa1JVNi9tVW10Q2Mv?=
 =?utf-8?B?Wm1rU0FuaXB3bFNaMk9IeU96TEx6eWREQ05kTlFWZnBxTkhTRGFaMUZDdjVz?=
 =?utf-8?B?RGh5RlAzOWlXb3pTZ0FCNFNhdDl1Y1VGK0JRR3RXR0RiUGdLam1SOFJSbUlG?=
 =?utf-8?B?cWVxSCtnUUxQdzN3MDI3TWhvNU8xT1FuWVZ6dXB1ZnhMQTdNY3dzYlZmWGVW?=
 =?utf-8?B?NWZoWWNOdGwyakxRZjZOelpvRTNVNkwyaXo3bHFhcDI5R0xMcEtTUGdrMVQ3?=
 =?utf-8?B?OHRhOEF0OHhJdURGQk1DSnBLbnBIT0dFcHk2NzMrN3RMcVBKcEdtbXh0Mlcx?=
 =?utf-8?B?aW9pYk1QZzhoK1hyWlloOFNlOTIyYU15Sm03eE5SNXRCQmhjaUR2VFFFTlFU?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FIZBWVQ1trITz9g3hCcPGVJ6FHoz2d9/a8L4UeTIPrW6vL32LxkmP0E2zsTnKT4v0c9bejKlwQyLaF7SIGLgkNtH/n0JQZpvy6+ojWSD5wEQnha2usmKhCvqztCu8SPtz4EmGHtDmFoHRykKH1T7uABiVqcjkHAvA5GvS/IEpM/0ahzVn5S3gnrmh9lDRymYTMXNb0cBJnjzAlitMC4zBLrJ3BMSW+tCK5+sNy2XqJduZ79Y6ZQMgpxEbpHhvqzDg03OuAah0Z0CFddqQ09+fIJfJAIGmST6VdCzFM6omjn5t1WmQ5z+HNMq4uCvlZX07463uC7lBsfkxpHLjXHQ0oWmvQdfBwIIQRmjG+pbdprfCz0QcsaHpvMk8vC2hdn+cAmbtE6jzBOEyapNkdJvjDE59BxdJAOTI7OpJdDFb3ngj6oh0syXdIv9g+li5Asl+tIAI9I04Yl0Mp8b2Zd7iNT/xqeqF1YiMA7JxO1GjLVaqfQjg9nME8/V3f8dPaZ7x+/LEFZwa4cP/OtXHPHOtndQN4AGy5jTincRyTDpmxXHMalC8q4RnxPKHVq6oKoBOuoHkXj/w3x73nVveK5s5lryMk8KrxFV4MF8/3ClEls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b64cd5-ea9f-4b4b-5164-08dd7744e76e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:59:58.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMVtYyjvtm6wzkX1O74giYZpsA/wZ4kyMzPjBIgVJif057Vh+H5KAzjHvlNDeB/beSzLam4f81U9fAmrVWf22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090046
X-Proofpoint-ORIG-GUID: lpnh6_5SuMSlcHNiy-pOfCSaVvayuzzq
X-Proofpoint-GUID: lpnh6_5SuMSlcHNiy-pOfCSaVvayuzzq

On 08/04/2025 20:09, Ihor Solodrai wrote:
> On 4/1/25 2:24 AM, Alan Maguire wrote:
>> Borrowing heavily from libbpf github actions, add workflows to
>>
>> - build dwarves for gcc, LLVM
>>
>> - build dwarves for x86_64/aarch64 and use it to build a Linux
>>   kernel including BTF generation; then run dwarves selftests
>>   using generated vmlinux
>>
>> These workflows trigger on all pushes.  This will allow both
>> developers working on dwarves to push a branch to their github
>> repo and test, and also for maintainer pushes from git.kernel.org
>> pahole repo to trigger tests.
>>
>> The build/test workflows can also be run as bash scripts locally,
>> as is described in the toplevel README.
>>
>> Similar to libbpf, additional workflows for coverity etc
>> are triggered for pushes to master/next.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Hi Alan. Thanks for addressing my comments.
> 
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> Some nits and questions below.
>

thanks for the feedback! replies below..


>> ---
>>  .github/scripts/build-debian.sh  | 92 ++++++++++++++++++++++++++++++++
>>  .github/scripts/build-kernel.sh  | 35 ++++++++++++
>>  .github/scripts/build-pahole.sh  | 17 ++++++
>>  .github/scripts/run-selftests.sh | 15 ++++++
>>  .github/scripts/travis_wait.bash | 61 +++++++++++++++++++++
>>  .github/workflows/build.yml      | 34 ++++++++++++
>>  .github/workflows/codeql.yml     | 53 ++++++++++++++++++
>>  .github/workflows/coverity.yml   | 33 ++++++++++++
>>  .github/workflows/lint.yml       | 20 +++++++
>>  .github/workflows/ondemand.yml   | 31 +++++++++++
>>  .github/workflows/test.yml       | 36 +++++++++++++
>>  .github/workflows/vmtest.yml     | 62 +++++++++++++++++++++
>>  README                           | 18 +++++++
>>  13 files changed, 507 insertions(+)
>>  create mode 100755 .github/scripts/build-debian.sh
>>  create mode 100755 .github/scripts/build-kernel.sh
>>  create mode 100755 .github/scripts/build-pahole.sh
>>  create mode 100755 .github/scripts/run-selftests.sh
>>  create mode 100755 .github/scripts/travis_wait.bash
>>  create mode 100644 .github/workflows/build.yml
>>  create mode 100644 .github/workflows/codeql.yml
>>  create mode 100644 .github/workflows/coverity.yml
>>  create mode 100644 .github/workflows/lint.yml
>>  create mode 100644 .github/workflows/ondemand.yml
>>  create mode 100644 .github/workflows/test.yml
>>  create mode 100644 .github/workflows/vmtest.yml
>>
>> diff --git a/.github/scripts/build-debian.sh b/.github/scripts/build-debian.sh
>> new file mode 100755
>> index 0000000..5a0789a
>> --- /dev/null
>> +++ b/.github/scripts/build-debian.sh
>> @@ -0,0 +1,92 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2025, Oracle and/or its affiliates.
>> +#
>> +
>> +PHASES=(${@:-SETUP RUN CLEANUP})
>> +DEBIAN_RELEASE="${DEBIAN_RELEASE:-testing}"
>> +CONT_NAME="${CONT_NAME:-dwarves-debian-$DEBIAN_RELEASE}"
>> +ENV_VARS="${ENV_VARS:-}"
>> +DOCKER_RUN="${DOCKER_RUN:-docker run}"
>> +REPO_ROOT="${REPO_ROOT:-$PWD}"
>> +ADDITIONAL_DEPS=(pkgconf)
>> +EXTRA_CFLAGS=""
>> +EXTRA_LDFLAGS=""
>> +
>> +function info() {
>> +    echo -e "\033[33;1m$1\033[0m"
>> +}
>> +
>> +function error() {
>> +    echo -e "\033[31;1m$1\033[0m"
>> +}
>> +
>> +function docker_exec() {
>> +    docker exec $ENV_VARS $CONT_NAME "$@"
>> +}
>> +
>> +set -eu
>> +
>> +source "$(dirname $0)/travis_wait.bash"
>> +
>> +for phase in "${PHASES[@]}"; do
>> +    case $phase in
>> +        SETUP)
>> +            info "Setup phase"
>> +            info "Using Debian $DEBIAN_RELEASE"
>> +
>> +            docker --version
>> +
>> +            docker pull debian:$DEBIAN_RELEASE
>> +            info "Starting container $CONT_NAME"
>> +            $DOCKER_RUN -v $REPO_ROOT:/build:rw \
>> +                        -w /build --privileged=true --name $CONT_NAME \
>> +                        -dit --net=host debian:$DEBIAN_RELEASE /bin/bash
>> +            echo -e "::group::Build Env Setup"
>> +
>> +            docker_exec apt-get -y update
>> +            docker_exec apt-get -y install aptitude
>> +            docker_exec aptitude -y install make cmake libz-dev libelf-dev libdw-dev git
>> +            docker_exec aptitude -y install "${ADDITIONAL_DEPS[@]}"
>> +            echo -e "::endgroup::"
>> +            ;;
>> +        RUN|RUN_CLANG|RUN_CLANG16|RUN_GCC12)
>> +            CC="cc"
>> +            if [[ "$phase" =~ "RUN_CLANG(\d+)(_ASAN)?" ]]; then
>> +                ENV_VARS="-e CC=clang-${BASH_REMATCH[1]} -e CXX=clang++-${BASH_REMATCH[1]}"
>> +                CC="clang-${BASH_REMATCH[1]}"
>> +            elif [[ "$phase" = *"CLANG"* ]]; then
>> +                ENV_VARS="-e CC=clang -e CXX=clang++"
>> +                CC="clang"
>> +            elif [[ "$phase" =~ "RUN_GCC(\d+)(_ASAN)?" ]]; then
>> +                ENV_VARS="-e CC=gcc-${BASH_REMATCH[1]} -e CXX=g++-${BASH_REMATCH[1]}"
>> +                CC="gcc-${BASH_REMATCH[1]}"
>> +            fi
>> +            if [[ "$CC" != "cc" ]]; then
>> +                docker_exec aptitude -y install "$CC"
>> +            else
>> +                docker_exec aptitude -y install gcc
>> +            fi
>> +	    git config --global --add safe.directory $REPO_ROOT
>> +	    pushd $REPO_ROOT
>> +	    git submodule update --init
>> +	    popd
>> +            docker_exec mkdir build install
>> +            docker_exec ${CC} --version
>> +            info "build"
>> +            docker_exec cmake -DGIT_SUBMODULE=OFF .
>> +	    docker_exec make -j$((4*$(nproc)))
>> +            info "install"
>> +            docker_exec make DESTDIR=../install install
>> +            ;;
>> +        CLEANUP)
>> +            info "Cleanup phase"
>> +            docker stop $CONT_NAME
>> +            docker rm -f $CONT_NAME
>> +            ;;
>> +        *)
>> +            echo >&2 "Unknown phase '$phase'"
>> +            exit 1
>> +    esac
>> +done
>> diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
>> new file mode 100755
>> index 0000000..41a3cf8
>> --- /dev/null
>> +++ b/.github/scripts/build-kernel.sh
>> @@ -0,0 +1,35 @@
>> +#!/usr/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2025, Oracle and/or its affiliates.
>> +#
>> +
>> +GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
>> +INPUTS_ARCH=${INPUTS_ARCH:-$(uname -m)}
>> +REPO=${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git}
>> +REPO_BRANCH=${REPO_BRANCH:-master}
>> +REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
>> +
>> +export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
>> +export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
>> +
>> +which pahole
>> +$PAHOLE --version
>> +
>> +if [[ ! -d $REPO_TARGET ]]; then
>> +	git clone $REPO $REPO_TARGET
>> +fi
>> +cd $REPO_TARGET
>> +git checkout $REPO_BRANCH
>> +
>> +cat tools/testing/selftests/bpf/config \
>> +    tools/testing/selftests/bpf/config.${INPUTS_ARCH} > .config
>> +# this file might or might not exist depending on kernel version
>> +if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
>> +	cat tools/testing/selftests/bpf/config.vm >> .config
>> +fi
>> +make olddefconfig && make prepare
>> +grep PAHOLE .config
>> +grep _BTF .config
> 
> This looks like debugging code, but instead of removing it I think it
> is useful to dump entire config to the output (hence job log) in case
> something goes wrong. How about `cat .config` before make
> olddefconfig?
>

Sounds good, but would doing it after "make olddefconfig" be more
informative maybe since some additional values may be set?

>> +make -j $((4*$(nproc))) all
>> +
>> diff --git a/.github/scripts/build-pahole.sh b/.github/scripts/build-pahole.sh
>> new file mode 100755
>> index 0000000..64f9eea
>> --- /dev/null
>> +++ b/.github/scripts/build-pahole.sh
>> @@ -0,0 +1,17 @@
>> +#!/usr/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2025, Oracle and/or its affiliates.
>> +#
>> +
>> +GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
>> +cd $GITHUB_WORKSPACE
>> +git config --global --add safe.directory $GITHUB_WORKSPACE
>> +git submodule update --init
>> +mkdir -p build
>> +cd build
>> +pwd
>> +cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
> 
> With these cmake options, what version of libbpf is used?
> 
> On CI a build/test of both static and shared variants should be
> tested, ideally. But that doesn't have to be a part of this patchset.
> 

Good idea; I think we'll follow up with that as it is somewhat dependent
on what shared library versions of libbpf we have available.

>> +make -j$((4*$(nproc))) all
>> +make DESTDIR=../install install
>> +
>> diff --git a/.github/scripts/run-selftests.sh b/.github/scripts/run-selftests.sh
>> new file mode 100755
>> index 0000000..f9ba24e
>> --- /dev/null
>> +++ b/.github/scripts/run-selftests.sh
>> @@ -0,0 +1,15 @@
>> +#!/usr/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2025, Oracle and/or its affiliates.
>> +#
>> +
>> +GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
>> +VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
>> +SELFTESTS=${GITHUB_WORKSPACE}/tests
>> +cd $SELFTESTS
>> +export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
>> +which pahole
>> +pahole --version
>> +vmlinux=$VMLINUX ./tests
>> +
>> diff --git a/.github/scripts/travis_wait.bash b/.github/scripts/travis_wait.bash
>> new file mode 100755
>> index 0000000..acf6ad1
>> --- /dev/null
>> +++ b/.github/scripts/travis_wait.bash
>> @@ -0,0 +1,61 @@
>> +# This was borrowed from https://github.com/travis-ci/travis-build/tree/master/lib/travis/build/bash
>> +# to get around https://github.com/travis-ci/travis-ci/issues/9979. It should probably be removed
>> +# as soon as Travis CI has started to provide an easy way to export the functions to bash scripts.
> 
> This comment makes me think travis_wait.bash could be removed.
> Do you know if it's actually necessary (for build-debian.sh)?
>

I tried removing it, and if I recall the github action fell over without
a pause between setup and build, so I think it's still needed.

>> +
>> +travis_jigger() {
>> +  local cmd_pid="${1}"
>> +  shift
>> +  local timeout="${1}"
>> +  shift
>> +  local count=0
>> +
>> +  echo -e "\\n"
>> +
>> +  while [[ "${count}" -lt "${timeout}" ]]; do
>> +    count="$((count + 1))"
>> +    echo -ne "Still running (${count} of ${timeout}): ${*}\\r"
>> +    sleep 60
>> +  done
>> +
>> +  echo -e "\\n${ANSI_RED}Timeout (${timeout} minutes) reached. Terminating \"${*}\"${ANSI_RESET}\\n"
>> +  kill -9 "${cmd_pid}"
>> +}
>> +
>> +travis_wait() {
>> +  local timeout="${1}"
>> +
>> +  if [[ "${timeout}" =~ ^[0-9]+$ ]]; then
>> +    shift
>> +  else
>> +    timeout=20
>> +  fi
>> +
>> +  local cmd=("${@}")
>> +  local log_file="travis_wait_${$}.log"
>> +
>> +  "${cmd[@]}" &>"${log_file}" &
>> +  local cmd_pid="${!}"
>> +
>> +  travis_jigger "${!}" "${timeout}" "${cmd[@]}" &
>> +  local jigger_pid="${!}"
>> +  local result
>> +
>> +  {
>> +    set +e
>> +    wait "${cmd_pid}" 2>/dev/null
>> +    result="${?}"
>> +    ps -p"${jigger_pid}" &>/dev/null && kill "${jigger_pid}"
>> +    set -e
>> +  }
>> +
>> +  if [[ "${result}" -eq 0 ]]; then
>> +    echo -e "\\n${ANSI_GREEN}The command ${cmd[*]} exited with ${result}.${ANSI_RESET}"
>> +  else
>> +    echo -e "\\n${ANSI_RED}The command ${cmd[*]} exited with ${result}.${ANSI_RESET}"
>> +  fi
>> +
>> +  echo -e "\\n${ANSI_GREEN}Log:${ANSI_RESET}\\n"
>> +  cat "${log_file}"
>> +
>> +  return "${result}"
>> +}
>> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
>> new file mode 100644
>> index 0000000..25a395f
>> --- /dev/null
>> +++ b/.github/workflows/build.yml
>> @@ -0,0 +1,34 @@
>> +name: dwarves-build
>> +
>> +on:
>> +  pull_request:
>> +  push:
>> +  schedule:
>> +    - cron:  '0 18 * * *'
>> +
>> +concurrency:
>> +  group: ci-build-${{ github.head_ref }}
>> +  cancel-in-progress: true
>> +
>> +jobs:
>> +
>> +  debian:
>> +    runs-on: ubuntu-latest
>> +    name: Debian Build (${{ matrix.name }})
>> +    strategy:
>> +      fail-fast: false
>> +      matrix:
>> +        include:
>> +          - name: default
>> +            target: RUN
>> +          - name: gcc-12
>> +            target: RUN_GCC12
>> +          - name: clang
>> +            target: RUN_CLANG
>> +    steps:
>> +      - uses: actions/checkout@v4
>> +        name: Checkout
>> +      - name: setup
>> +        shell: bash
>> +        run: ./.github/scripts/build-debian.sh SETUP ${{ matrix.target }}
>> +
>> diff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.yml
>> new file mode 100644
>> index 0000000..a140be1
>> --- /dev/null
>> +++ b/.github/workflows/codeql.yml
>> @@ -0,0 +1,53 @@
>> +---
>> +# vi: ts=2 sw=2 et:
>> +
>> +name: "CodeQL"
>> +
>> +on:
>> +  push:
>> +    branches:
>> +      - master
>> +  pull_request:
>> +    branches:
>> +      - master
>> +      - next
>> +
>> +permissions:
>> +  contents: read
>> +
>> +jobs:
>> +  analyze:
>> +    name: Analyze
>> +    runs-on: ubuntu-latest
>> +    concurrency:
>> +      group: ${{ github.workflow }}-${{ matrix.language }}-${{ github.ref }}
>> +      cancel-in-progress: true
>> +    permissions:
>> +      actions: read
>> +      security-events: write
>> +
>> +    strategy:
>> +      fail-fast: false
>> +      matrix:
>> +        language: ['cpp', 'python']
>> +
>> +    steps:
>> +      - name: Checkout repository
>> +        uses: actions/checkout@v4
>> +
>> +      - name: Initialize CodeQL
>> +        uses: github/codeql-action/init@v2
>> +        with:
>> +          languages: ${{ matrix.language }}
>> +          queries: +security-extended,security-and-quality
>> +
>> +      - name: Setup
>> +        uses: ./.github/actions/setup
>> +
>> +      - name: Build
>> +        run: |
>> +          source /tmp/ci_setup
>> +          make -C ./src
>> +
>> +      - name: Perform CodeQL Analysis
>> +        uses: github/codeql-action/analyze@v2
>> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
>> new file mode 100644
>> index 0000000..97a04d4
>> --- /dev/null
>> +++ b/.github/workflows/coverity.yml
>> @@ -0,0 +1,33 @@
>> +name: dwarves-ci-coverity
>> +
>> +on:
>> +  push:
>> +    branches:
>> +      - master
>> +      - next
>> +  schedule:
>> +    - cron:  '0 18 * * *'
>> +
>> +jobs:
>> +  coverity:
>> +    runs-on: ubuntu-latest
>> +    name: Coverity
>> +    env:
>> +      COVERITY_SCAN_TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
>> +    steps:
>> +      - uses: actions/checkout@v4
>> +      - uses: ./.github/actions/setup
>> +      - name: Run coverity
>> +        if: ${{ env.COVERITY_SCAN_TOKEN }}
>> +        run: |
>> +          source /tmp/ci_setup
>> +          export COVERITY_SCAN_NOTIFICATION_EMAIL="${AUTHOR_EMAIL}"
>> +          export COVERITY_SCAN_BRANCH_PATTERN=${GITHUB_REF##refs/*/}
>> +          export TRAVIS_BRANCH=${COVERITY_SCAN_BRANCH_PATTERN}
>> +          scripts/coverity.sh
>> +        env:
>> +          COVERITY_SCAN_PROJECT_NAME: dwarves
>> +          COVERITY_SCAN_BUILD_COMMAND_PREPEND: 'cmake .'
>> +          COVERITY_SCAN_BUILD_COMMAND: 'make'
>> +      - name: SCM log
>> +        run: cat /home/runner/work/dwarves/cov-int/scm_log.txt
>> diff --git a/.github/workflows/lint.yml b/.github/workflows/lint.yml
>> new file mode 100644
>> index 0000000..ca13052
>> --- /dev/null
>> +++ b/.github/workflows/lint.yml
>> @@ -0,0 +1,20 @@
>> +name: "lint"
>> +
>> +on:
>> +  pull_request:
>> +  push:
>> +    branches:
>> +      - master
>> +      - next
>> +
>> +jobs:
>> +  shellcheck:
>> +    name: ShellCheck
>> +    runs-on: ubuntu-latest
>> +    steps:
>> +      - name: Checkout repository
>> +        uses: actions/checkout@v4
>> +      - name: Run ShellCheck
>> +        uses: ludeeus/action-shellcheck@master
>> +        env:
>> +          SHELLCHECK_OPTS: --severity=error
>> diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
>> new file mode 100644
>> index 0000000..5f3034f
>> --- /dev/null
>> +++ b/.github/workflows/ondemand.yml
>> @@ -0,0 +1,31 @@
>> +name: ondemand
>> +
>> +on:
>> +  workflow_dispatch:
>> +    inputs:
>> +      arch:
>> +        default: 'x86_64'
>> +        required: true
>> +      llvm-version:
>> +        default: '18'
>> +        required: true
>> +      kernel:
>> +        default: 'LATEST'
>> +        required: true
>> +      pahole:
>> +        default: "master"
>> +        required: true
>> +      runs-on:
>> +        default: 'ubuntu-24.04'
>> +        required: true
>> +
>> +jobs:
>> +  vmtest:
>> +    name: ${{ inputs.kernel }} kernel llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
>> +    uses: ./.github/workflows/vmtest.yml
>> +    with:
>> +      runs_on: ${{ inputs.runs-on }}
>> +      kernel: ${{ inputs.kernel }}
>> +      arch: ${{ inputs.arch }}
>> +      llvm-version: ${{ inputs.llvm-version }}
>> +      pahole: ${{ inputs.pahole }}
>> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
>> new file mode 100644
>> index 0000000..f11ebfe
>> --- /dev/null
>> +++ b/.github/workflows/test.yml
>> @@ -0,0 +1,36 @@
>> +name: dwarves-ci
>> +
>> +on:
>> +  pull_request:
>> +  push:
>> +  schedule:
>> +    - cron:  '0 18 * * *'
>> +
>> +concurrency:
>> +  group: ci-test-${{ github.head_ref }}
>> +  cancel-in-progress: true
>> +
>> +jobs:
>> +  vmtest:
>> +    strategy:
>> +      fail-fast: false
>> +      matrix:
>> +        include:
>> +          - kernel: 'LATEST'
>> +            runs_on: 'ubuntu-24.04'
>> +            arch: 'x86_64'
>> +            llvm-version: '18'
>> +            pahole: 'master'
>> +          - kernel: 'LATEST'
>> +            runs_on: 'ubuntu-24.04-arm'
>> +            arch: 'aarch64'
>> +            llvm-version: '18'
>> +            pahole: 'tmp.master'
>> +    name: Linux ${{ matrix.kernel }}
>> +    uses: ./.github/workflows/vmtest.yml
>> +    with:
>> +      runs_on: ${{ matrix.runs_on }}
>> +      kernel: ${{ matrix.kernel }}
>> +      arch: ${{ matrix.arch }}
>> +      llvm-version: ${{ matrix.llvm-version }}
>> +      pahole: ${{ matrix.pahole }}
>> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
>> new file mode 100644
>> index 0000000..0f66eed
>> --- /dev/null
>> +++ b/.github/workflows/vmtest.yml
>> @@ -0,0 +1,62 @@
>> +name: 'Build kernel run selftests via vmtest'
>> +
>> +on:
>> +  workflow_call:
>> +    inputs:
>> +      runs_on:
>> +        required: true
>> +        default: 'ubuntu-24.04'
>> +        type: string
>> +      arch:
>> +        description: 'what arch to test'
>> +        required: true
>> +        default: 'x86_64'
>> +        type: string
>> +      kernel:
>> +        description: 'kernel version or LATEST'
>> +        required: true
>> +        default: 'LATEST'
>> +        type: string
>> +      pahole:
>> +        description: 'pahole rev or branch'
>> +        required: false
>> +        default: 'master'
>> +        type: string
>> +      llvm-version:
>> +        description: 'llvm version'
>> +        required: false
>> +        default: '18'
>> +        type: string
>> +jobs:
>> +  vmtest:
>> +    name: pahole@${{ inputs.arch }}
>> +    runs-on: ${{ inputs.runs_on }}
>> +    steps:
>> +
>> +      - uses: actions/checkout@v4
>> +
>> +      - name: Setup environment
>> +        uses: libbpf/ci/setup-build-env@v3
>> +        with:
>> +          pahole: ${{ inputs.pahole }}
>> +          arch: ${{ inputs.arch }}
>> +          llvm-version: ${{ inputs.llvm-version }}
> 
> I think I mentioned it before, but libbpf/ci/setup-build-env checks
> out and installs pahole too, which is unnecessary here. Have you tried
> removing this step from the job?
> 
> You should be able to reuse a piece of SETUP logic from
> build-debian.sh to install pahole's dependencies. Although you kernel
> build deps are needed too.
> 

Yeah it's the latter that are needed I think.

> I could make a change in libbpf/ci/setup-build-env to accept a special
> `pahole` input value or check for env variable to NOT build pahole.
> What do you think?

That would be great! Something like "pahole: none"?

I'll probably try and land this more or less as-is as we're hoping to
get 1.30 out the door this week, but definitely will follow up with
builds with shared library libbpf etc. Thanks for taking a look!

Alan

