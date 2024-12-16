Return-Path: <bpf+bounces-47040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A919F3448
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0969C1681E3
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25F145323;
	Mon, 16 Dec 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nfgYhJ7J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PV9zG6iv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AF5647F;
	Mon, 16 Dec 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362362; cv=fail; b=JksgU1n9tSfKNA8LSZFJucql+tgA5yb1Kf8I5vaS9RCdsJOT683IhmVNT533mAzGWLuewdfCmT916J6DvXNg4MTSHVxfZqrRJfWqeVnsfl753L5FVdPhyNlK8fBQaSWnzqNOM805Mk97ovpP5mMSTL/RqLibLnqszrm6N9f7i/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362362; c=relaxed/simple;
	bh=3IHKhY2vDsqTOjYV26X8gMDiS7mOqvIVkNbrMPRgP6k=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmlFeOOzoIdMx844WBcOMxoZyva2jNll7yxoJiZJs+ojDeO6lvrSKEParFuYYhWFe7RrfAB6OFK5kVZty3YlPom+bZWJ+t6EWZLqRLL4JFfm2OZDVb1Y/8C++MZHhWMbaCPYdGMs3TsHQuhTkTvY15t+6a/Tg8665vRiMNTZCbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nfgYhJ7J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PV9zG6iv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtuHK021101;
	Mon, 16 Dec 2024 15:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QO6/6NfdHpxaSSxAwPa0SfjDu/RIKd+aPIM45G+LaFQ=; b=
	nfgYhJ7J3x70yor3mp3BGFk9MwhcuGJ2nlihw9G59+5TNF1BgTxaHsGJlmJo8ezE
	ElxbnMfutn77oG0CLg8GMAUO4OFDBtQbXNRsilqwTTa8azTab30443P1zYa7pd+4
	OBXLxXyV5lZhfQcI3SVUjWK+5ZWJZVIrQJTUHVLWDUEzP/biZxFvqBTrXqF+fVYn
	9Zsb9XUMQhH+um92L+Z0MMjF6rE+pGUR/lDyMMB3bObm7pah/NPmUlP5atPLw8cp
	K7B2KLuAPLfa30Eh1wNevQLU4gL7TyfA/9W0eTtVwOoMkDW7dBd4wDMEAjRVYQEF
	2D1LzaHttVKjvD84VznjHg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9bd4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 15:19:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEosnH032652;
	Mon, 16 Dec 2024 15:19:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fddwdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 15:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBgP156DD7xoYZRTOcguo1ZCwsAzn4/vEAGbSU/egvD0nZgIiNwUmRzG+UBy0Mn8DZm/vhlVDLs5Uls61iCB/5Y8afRlQfmioyA1VadWK+iQ559r6AemQElw/3pTDo3bp8lVcn+hhyTqauTiWi8fXiMWptHWc66XtIJeEc+YW7B9MLKHF69R9ay1YCTl1XdIlRGl5ftwE/NxOCgPWU43bV8DrTYcYCS4X1skGhRdU1Kkm4kbSFIR7OvRwXDpDtDH1PUn3ugGSHgz5M6OSBqXHJkV90M4kHcZ4hXNw2vy9zk94/6ambvya7C6U5wS6fBlRlbxGzHCKxzUY2LAd/KWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO6/6NfdHpxaSSxAwPa0SfjDu/RIKd+aPIM45G+LaFQ=;
 b=mkB6Izd+HwyUDPQbuN9dgUmBqUkrXz0Brv+l5M0xAYHSq4dNV5Xefrr1Awg05mhDMcFQ/9Klzhg6+eqwanPOhAlinOGudffnM46gmoavOmyIYTJd0Low3I842EpHX7sBp5tCNAf6fBwIm9Lq2+UnihVaa1pzU3r+IrwqhwFxj817W2uJu5i9lUNIlgLZNzQsTIrgOWcx7XEKGjMrjgalaUXudjhksTi5ihFy5H0IcQZyS3/bUyrt0gPFXrCTMirxehE8RvsCp5bOq9t81Qkb1JkFWiPknCT+GfhBjr9iuWCwzoB7hMni1lvVcSqMikcPpf60o2e8LCRzK6B9YHmopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO6/6NfdHpxaSSxAwPa0SfjDu/RIKd+aPIM45G+LaFQ=;
 b=PV9zG6ivPykcQBNiUiEHEbat0X6c0DXQ8krWxiO+VmFgCIW8T+bTs4hTLLk0Sr9XbfqigO3hp796vNJJUm2y6Jg3EYpdh5Ir22T/Xrm5uwOOpd/BVkx9RN61fcWclVIRthWUQJU5H5mlEWp0m53UPrxYymn2kCqUyMgcbthsyMo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 15:19:13 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:19:13 +0000
Message-ID: <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
Date: Mon, 16 Dec 2024 15:19:01 +0000
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Cong Wang <xiyou.wangcong@gmail.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, bpf@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@collabora.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
 <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
Content-Language: en-GB
In-Reply-To: <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc03c51-bf27-4404-e5cb-08dd1de4ff6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTR3Ym9pemNsaTZ1VkxKQmxla1pKQ0RXRDBCejg4blE4cWowckQxMXZlWDVz?=
 =?utf-8?B?RHQra1JNRjMzN3lucEN2WjhsY3BKYnI5ZFpBeVRETUdxcnJIK21RRzhnanJB?=
 =?utf-8?B?L3JydTJlU3JjNk96QmErdlZodVRsRnBFbG8zendreHhISjEwMG5KUm40enFI?=
 =?utf-8?B?WXVWaFJ2YjRWRTFtVWs3QzVlYXZ2MFl2cnl4WFE5ektRTHFELzAxMU11OE9a?=
 =?utf-8?B?Tlgwam5JL1dqYitFZVR6UHFFRmViZ05IanhsZVErR05DejFNdENkNE1FeGM0?=
 =?utf-8?B?STN3T1V4Q28yQTlvZlNnb2xIZnZ3eG1KSUJTa3B3Z1V0UFlSZTJLcGgzTTVI?=
 =?utf-8?B?Z3RvQkdYR2dHNkFmbG9EUE1vVElIY09RK0syY1NnNDRrRXJUMHdrM0NvRzEr?=
 =?utf-8?B?QkJPZGtQZHlnMDZMSWVyUmtQYSsrY1lsR0ZzN3hKc0pEYUw4WU1UTXhsZU5D?=
 =?utf-8?B?M3FMMWlJSms4cko4b2E1NUZRaHMwRHJKRk54dURMSkdwVUNCcUJ0QytXamNm?=
 =?utf-8?B?T1VIUGwrR2dKK2h4NGxEcUlhL2FrTmM0cnl0MCtIRDNkZ2hEY1NRc2hmZXZr?=
 =?utf-8?B?WGNDcTRSdlIvUlE0QzU3V3MwSW52Rk5aTUZBLzY3QnFLSVBTZWs1eXQzRmw1?=
 =?utf-8?B?S2FISVJhR1l3aHV1emJpTUFubzJtUFRXYndzSk83NkpPajZWTmNkZURXd1hm?=
 =?utf-8?B?cVd5eWNRczcwdEhpaVJmVzdEaUR1dkt2WEhqSm9XaWFwWHNyMFZOWndPVTRQ?=
 =?utf-8?B?T2czMVdtcHFhVFBBS0hLditOUnFxSlRKb2pYYzV0ZUpLNGliQlFibHRXbkxC?=
 =?utf-8?B?K05DbW1wS04zMURFdDd0MlM4Q1VkNmpJQytzSG5qVWNqZ3h4akdGUG1sKy9K?=
 =?utf-8?B?ZTYrWC9RZU5VelN5S0xoNml3VlM1NnhoVStOYVJadTJGdzhYRzNkV01GRy9w?=
 =?utf-8?B?Szc1VWthM2w1SkRZQk9aQVo1bjhKN1I0NENYL2JQclFheXJ3bExvaDdtU05h?=
 =?utf-8?B?aHlZd3QwQVBqdU0rVmdCTUovZFZFb2xaRnozSnptYUdvcklvQ0l3YURFc1lW?=
 =?utf-8?B?WThFWk5rSWZjN1cxa1N6YUp6T0VxcWdiUmFKZndmL1F0WWRSR3ZoZ0RjVEZp?=
 =?utf-8?B?Y3BPanJOaVVLT2l4K3BIQkxBKzBNOHVyUFlvajhDMWFtTHVxUTRTckpVckJl?=
 =?utf-8?B?cExJTkRaK2VwOEhFR3RMbmRpOGVjV3ZqRnNKNm1yNmRsaTJvYkN5dEhrNWEx?=
 =?utf-8?B?V3JJakFtMTd2WFBWMzBSbkJVbTZ6dVNWd2Q5cDhBZzRMa3U3QUR1U1YxRzg2?=
 =?utf-8?B?MGJtaVYrVlUvT1MzekRLUjNyMVlIcWYxaTN1Sk5rcVJnOVNVNXZLM1RmbThW?=
 =?utf-8?B?dy9VRldPMC9wL3lPWWswMmdoNUpZWll1SDR5Q2RSVGlUQll0NHZBY1hzb1Z0?=
 =?utf-8?B?L2NoaXBTWWFobDlWcGhaNW52ekNhcktwcmVtY2NpTXRFSTdKbUlaVDZUYTJS?=
 =?utf-8?B?QVNCcVNUVVp3OWY5VzNxYUl1c3grM2hNclNiMGdhbVRRNEU3WElsMGZFWWlj?=
 =?utf-8?B?QUduMHhmaHRzZGJVOFRDNmdVSGl4UXJaNC9JMzQrMDJuVTV0amMrTlZOTllU?=
 =?utf-8?B?d0pFcTVqYndjTDFhdjRzeW16Tm5iSGpYeW9pQnZ6NTk2dzZtRXJPSnc5c0NV?=
 =?utf-8?B?bDJsR3Q2SUREaFlmYnFpYm1vYUE1Z0JRNWRpRC8yTnRFZU5ObytCS3ZzOUdH?=
 =?utf-8?B?dEd4cDFNUW9zQW01UDIwaEpnQ1NSSFRPdjlTQkZ5VlJpZWJwUjVUbkowbUt0?=
 =?utf-8?B?U3ZKQ09jM0ZyTjVjalNKcWNFUmRJY3N0K21yQ2loL2d6WGh4bEt3TjJNTW5B?=
 =?utf-8?Q?zoukBojePs3D2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVBqcXZsOVdHdU5sL1JVTmZHVy9kNUF1ak5qSGNjSkNLTnJ2cEFYdTEvZUtN?=
 =?utf-8?B?MkM1Mm5LQ0tnU0EydmZOUUZTR1hOUS90R01ON2RIaFZCLy95RytlVHJ6QUE2?=
 =?utf-8?B?dVFlNTB0TjI5SDAvZFdrNlBDZFRQemhWU3AwWGU0WFBCdnJCVTRTNW1tc0I5?=
 =?utf-8?B?YnhGbHUzSnIveGJmNk02cSt3b0JheUoyaGV1TmpZY1ZiVWFIVDJqa3FrYkhZ?=
 =?utf-8?B?QkhvUmlTQnFtekZrRmJNWjNyck82dkVYcDhPMDFDV1dudjBBL1FQbUdSajlE?=
 =?utf-8?B?SGE0MDlrZnVVM1dkNysxSnN2aWdjRVFUZjdJUUloRHNBcVlKdHJBNU1UTFA1?=
 =?utf-8?B?TFNUL0RLR3djSTJCM1VtOFZqbUwwR08ybjVoVEZOcFhMYzdFQkd1K0w1UTNU?=
 =?utf-8?B?YU9MQkhRUVh1SE5OckxqemJMSnN1WktzVW13b1pzNVdhSi92NWtSaWZBRnNW?=
 =?utf-8?B?ZWZocGgxMnQ3OXp0RGJUM1RNSUMyZU9Ncm4xVDg2RlljeWpsVDJWOHV0Y2Rr?=
 =?utf-8?B?VzZveXI2eXFnRGFQRUNtdlN6RENIYUdNVytIQ2RYWWowL2xndHUydW12WGVE?=
 =?utf-8?B?YXY3NlVtZ2VUMGNHZDFETmhmK1E4SmdEUGxYaENFSFIzcnRIcmRWdjFzN2Va?=
 =?utf-8?B?bkxuU1RweGF5cXdsVHg5MUFSUE05ODI3WWhXUWJ3S2pGd21NSHdjZ20zUFhK?=
 =?utf-8?B?SzV5cWFvZm54QURZMkQ0OWxmZzlZdlgyUlk0SGkwWTcwREtiMVhDdUNTOGYw?=
 =?utf-8?B?Rk5jcjdhTm9JSktEcFNvQkxldHZGZGRpT29UVXNSRlk4dHpEM0FRaG1HQXow?=
 =?utf-8?B?NWFwdUlBc01Pb29zcDE0VEp4NGdkbXVvT1BJNzJ1c2tvejJ5b3BJV1JIUWxI?=
 =?utf-8?B?SnY3UERnUUlFMVBsTkZEclMrRndHSU5zaWJCcmVEaTkyWStubUVUTTNOK2Vi?=
 =?utf-8?B?eWdtMW1Ma2s3VlpvN0lFakNseTllUXpQcm1GVlFiL1pxYUlWYW0zUTF2aS96?=
 =?utf-8?B?S0MxVUFOOCtUZWpia25yY3dTNytlZ2d1RUVpeHJTVURUd1dyVHhPYmJ6c3dD?=
 =?utf-8?B?eWRVbUYvQ2kvWmpHaEUzbFBSeXdZaDAyY1JrMnRibXdqUTRyOUo3Y3Jadlpk?=
 =?utf-8?B?amV2YUNQT0ZyaXd1N010bWxPRHpwNXkwbWNNWGlJR0NsUU50TEtBdDUrWjFT?=
 =?utf-8?B?b2UvUGJrZUxyK3BhNUtBRDFvcHJ3MW15U1FtbFpVd25hbUU4UEwza0RNeld2?=
 =?utf-8?B?VTBUQmtPVWhaeUZaL3FLWlpoYkdOSTVMcUJENmV4VkVNU0RpczJGM2hVeGlq?=
 =?utf-8?B?MG4weXhpTHVJSDRjQmFreWFVZzAvOTk3a0RYay9UcThVaVRoVTFtckFWbmcw?=
 =?utf-8?B?UEFnOHdNMVhnbmRiRmtjcWJSN1dnMUZXektmUTJ4SXEwUW8zQi94bFJFMkJH?=
 =?utf-8?B?UGdIWWZ0dmRCbm16djdkSHp3aHBPcGZyYmZXc1VaMHZqRXRCQ2dXMzNjVUpC?=
 =?utf-8?B?b1JOdzBVUDBSZDRjL1oveUcxYlRRanpERXNKcHE5ZFl1MitNb0Q0U3hNS2VX?=
 =?utf-8?B?MFVNaWxRdHZnTm5jMGFMSWFDcWRDRXlQNXBoR2dqZDNBOHl6S1NKVVo4M0Uz?=
 =?utf-8?B?UHZYTWJLSHZaRkhwcXZpbnZYWWJVL3VUdFltVmtGcnZjS1hXMkJyRW5lbk1T?=
 =?utf-8?B?VDB5VjJrSVpHMDFxSXFxSnFmV0JsTyttMGVnZUE5ZndmUjdRR2wvSkJoanNu?=
 =?utf-8?B?bVBSdDc4Y2c1U0VWU0tUTHhxNVZlM3JkUXFpM0ZDR09SRGo4Zlp5MUttODNh?=
 =?utf-8?B?YjBPT2VxaUIwTHlOQjB2OVN5RGhFTFNXV3FETnUyL2hyZS80R3kyQUQzcmtN?=
 =?utf-8?B?OFEwMnFabzBPdFphN012dUZhZWN2MTdmRW43OEVYNVRYcS8yTlUwT29oaEg4?=
 =?utf-8?B?anYrVlhtYStPZGc3SzVXeG5aNE1Rc3IvQmRsOUtUcWV1OGtNU1kvL1RZV2RI?=
 =?utf-8?B?emJGTWVCRUZFaTZwQWhTRGlPbXhXbjU3ZFJZMS9JMjFoRXBHYmFrS3RoeUJW?=
 =?utf-8?B?ZHo2MnNnd21NRkZHcExLclN6Y3oyMFFDQVk3eTVoUm4vVCtyc05vUHNPaEpB?=
 =?utf-8?B?VmZmTHo0Nk1JWUNpcU1yVXlpcysybHFIVlpIT3c0cUNOSzhyOHR0YVcwR0hr?=
 =?utf-8?Q?5AFPKLtQ5y84P6McZbixzpM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KztnkDtxSWQ9uQHfJSQ6cEmuxmfDqxlnr+V9GTs0cNvuTrUSzsNcNst4dQzU0FT0aobSSAjzqlbGcYKnWlfgtq74WrrnJOxriPNwvyhNPmk2Vpxs1tmAsXIoauAE+BBuxEKopQtCoWzWKLQLU6WWr3nH2urc70gqc0fOGqmVpPIZBL6ZwHBBqdT408Ec/lbY2U0wZrJJbaxYw4Fef3GkAQwM/mPlLRk8jFE8Y+ICJZ78CuSpsTiedkXenRWF7TE9USp9kIqyeEGbxJmBLNXxCs/IFmUSx7f/uds7mJqxy9ezUF9dysEJfHc+dg/MA7reVr53p7LiSgtcP5sYecH7J04fHLQ50GY2t3bELIycQNdBsxMfSLegWrGRcFiGyZncdnqQS+kKeEGolcb1rkpHpdLPWBx3ni4T1VTDuWupDCheEz7qEMG54j67ay39zYn8Uw7XKjsSeX/lhAwGoQLs0Xhug2/Ti8FjU67jtXjAIigaeOJUsDqlLSeRocVnIafqnfAQTq7eHollSmWStqJ5eLZeEawzhf2j7PGYbwwU3jE+XLK+ijXg4Za1ujdDYzTongdwj+WHvXFiyhKefzwn2DUKcibjqz/no1z7yjGQAKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc03c51-bf27-4404-e5cb-08dd1de4ff6a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:19:13.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tSME1w8Wdqeb3SWqJfNSVcsVxdgHb+Gx7NfaleEXav7YDqeNLpWY28oswd+qEHQBYhC3719m0NZFDcdwli7nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_06,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160128
X-Proofpoint-GUID: pfdbLeGxFqTGXNnvgBkSxV870KSqq2lD
X-Proofpoint-ORIG-GUID: pfdbLeGxFqTGXNnvgBkSxV870KSqq2lD

On 14/12/2024 12:15, Alan Maguire wrote:
> On 14/12/2024 04:41, Cong Wang wrote:
>> On Thu, Dec 05, 2024 at 08:36:33AM +0100, Uros Bizjak wrote:
>>> On Wed, Dec 4, 2024 at 4:52 PM Laura Nao <laura.nao@collabora.com> wrote:
>>>>
>>>> On 11/15/24 18:17, Laura Nao wrote:
>>>>> I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
>>>>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
>>>>> modules[3] and its btf data[4] extracted with:
>>>>>
>>>>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
>>>>>
>>>>> Looking again at the logs[5], I've noticed the following is reported:
>>>>>
>>>>> [    0.415885] BPF:    type_id=115803 offset=177920 size=1152
>>>>> [    0.416029] BPF:
>>>>> [    0.416083] BPF: Invalid offset
>>>>> [    0.416165] BPF:
>>>>>
>>>>> There are two different definitions of rcu_data in '.data..percpu', one
>>>>> is a struct and the other is an integer:
>>>>>
>>>>> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
>>>>> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
>>>>>
>>>>> [115801] VAR 'rcu_data' type_id=115572, linkage=static
>>>>> [115803] VAR 'rcu_data' type_id=1, linkage=static
>>>>>
>>>>> [115572] STRUCT 'rcu_data' size=1152 vlen=69
>>>>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>>>>>
>>>>> I assume that's not expected, correct?
>>>>>
>>>>> I'll dig a bit deeper and report back if I can find anything else.
>>>>
>>>> I ran a bisection, and it appears the culprit commit is:
>>>> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
>>>>
>>>> Hi Uros, do you have any suggestions or insights on resolving this issue?
>>>
>>> There is a stray ";" at the end of the #define, perhaps this makes a difference:
>>>
>>> +#define PERCPU_PTR(__p) \
>>> + (typeof(*(__p)) __force __kernel *)(__p);
>>> +
>>>
>>> and SHIFT_PERCPU_PTR macro now expands to:
>>>
>>> RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))
>>>
>>> A follow-up patch in the series changes PERCPU_PTR macro to:
>>>
>>> #define PERCPU_PTR(__p) \
>>> ({ \
>>> unsigned long __pcpu_ptr = (__force unsigned long)(__p); \
>>> (typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
>>> })
>>>
>>> so this should again correctly cast the value.
>>
>> Hm, I saw a similar bug but with pahole 1.28. My kernel complains about
>> BTF invalid offset:
>>
>> [    7.785788] BPF: 	 type_id=2394 offset=0 size=1
>> [    7.786411] BPF:
>> [    7.786703] BPF: Invalid offset
>> [    7.787119] BPF:
>>
>> Dumping the vmlinux (there is no module invovled), I saw it is related to
>> percpu pointer too:
>>
>> [2394] VAR '__pcpu_unique_cpu_hw_events' type_id=2, linkage=global
>> ...
>> [163643] DATASEC '.data..percpu' size=2123280 vlen=808
>>         type_id=2393 offset=0 size=1 (VAR '__pcpu_scope_cpu_hw_events')
>>         type_id=2394 offset=0 size=1 (VAR '__pcpu_unique_cpu_hw_events')
>> ...
>>
>> I compiled and installed the latest pahole from its git repo:
>>
>> $ pahole --version
>> v1.28
>>
>> Thanks.
> 
> Thanks for the report! Looking at percpu-defs.h it looks like the
> existence of such variables requires either
> 
> #if defined(ARCH_NEEDS_WEAK_PER_CPU) ||
> defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
> 
> ...
> 
> #define DEFINE_PER_CPU_SECTION(type, name, sec)                         \
>         __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    \
>         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
>         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
>         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
>         __PCPU_ATTRS(sec) __weak __typeof__(type) name
> 
> 
> I'm guessing your .config has CONFIG_DEBUG_FORCE_WEAK_PER_CPU, or are
> you building on s390/alpha?
> 
> I've reproduced this on bpf-next with CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y,
> pahole v1.28 and gcc-12; I see ~900 __pcpu_ variables and get the same
> BTF errors since multipe __pcpu_ vars share the offset 0.
> 
> A simple workaround in dwarves - and I verified this resolved the issue
> for me - would be
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..4a1799a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2174,7 +2174,8 @@ static bool filter_variable_name(const char *name)
>                 X("__UNIQUE_ID"),
>                 X("__tpstrtab_"),
>                 X("__exitcall_"),
> -               X("__func_stack_frame_non_standard_")
> +               X("__func_stack_frame_non_standard_"),
> +               X("__pcpu_")
>                 #undef X
>         };
>         int i;
> 
> ...but I'd like us to understand further why variables which were
> supposed to be in a .discard section end up being encoded as there may
> be other problems lurking here aside from this one. More soon hopefully...
>


A bit more context here - variable encoding takes the address of the
variable from DWARF to locate the associated ELF section. Because we
insist on having a variable specification - with a location - this
usually works fine. However the problem is that because these dummy
__pcpu_ variables specify a .discard section, their addresses are 0, so
we get for example:

 <1><1e535>: Abbrev Number: 114 (DW_TAG_variable)
    <1e536>   DW_AT_name        : (indirect string, offset: 0x5e97):
__pcpu_unique_kstack_offset
    <1e53a>   DW_AT_decl_file   : 1
    <1e53b>   DW_AT_decl_line   : 823
    <1e53d>   DW_AT_decl_column : 1
    <1e53e>   DW_AT_type        : <0x57>
    <1e542>   DW_AT_external    : 1
    <1e542>   DW_AT_declaration : 1
 <1><1e542>: Abbrev Number: 156 (DW_TAG_variable)
    <1e544>   DW_AT_specification: <0x1e535>
    <1e548>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
(DW_OP_addr: 0)


You can see the same thing for a simple program like this:

#include <stdio.h>

#define SEC(name) __attribute__((section(name)))

SEC("/DISCARD/") int d1;
extern int d1;
SEC("/DISCARD/") int d2;
extern int d2;

int main(int argc, char *argv[])
{
	return 0;
}


If you compile it with -g, the DWARF shows that d1 and d2 both have
address 0:

 <1><72>: Abbrev Number: 5 (DW_TAG_variable)
    <73>   DW_AT_name        : d1
    <76>   DW_AT_decl_file   : 1
    <77>   DW_AT_decl_line   : 5
    <78>   DW_AT_decl_column : 22
    <79>   DW_AT_type        : <0x57>
    <7d>   DW_AT_external    : 1
    <7d>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
(DW_OP_addr: 0)
 <1><87>: Abbrev Number: 5 (DW_TAG_variable)
    <88>   DW_AT_name        : d2
    <8b>   DW_AT_decl_file   : 1
    <8c>   DW_AT_decl_line   : 7
    <8d>   DW_AT_decl_column : 22
    <8e>   DW_AT_type        : <0x57>
    <92>   DW_AT_external    : 1
    <92>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
(DW_OP_addr: 0)


So the reason this happens for dwarves v1.28 in particular is - as I
understand it - we moved away from recording ELF section information for
each variable and matching that with DWARF info, instead relying on the
address to locate the associated ELF section. In cases like the above
the address information unfortunately leads us astray.

Seems like there's a few approaches we can take in fixing this:

1. designate "__pcpu_" prefix as a variable prefix to filter out. This
resolves the immediate problem but is too narrowly focused IMO and we
may end up playing whack-a-mole with other dummy variable prefixes.
2. resurrect ELF section variable information fully; i.e. record a list
of variables per ELF section (or at least per ELF section we care
about). If variable is not on the list for the ELF section, do not
encode it.
3. midway between the two; for the 0 address case specifically, verify
that the variable name really _is_ in the associated ELF section. No
need to create a local ELF table variable representation, we could just
walk the table in the case of the 0 addresses.

Diff for approach 3 is as follows

diff --git a/btf_encoder.c b/btf_encoder.c
index 3754884..21a0ab6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
        return false;
 }

+bool variable_in_sec(struct btf_encoder *encoder, const char *name,
size_t shndx)
+{
+       uint32_t sym_sec_idx;
+       uint32_t core_id;
+       GElf_Sym sym;
+
+       elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym,
sym_sec_idx) {
+               const char *sym_name;
+
+               if (sym_sec_idx != shndx || elf_sym__type(&sym) !=
STT_OBJECT)
+                       continue;
+               sym_name = elf_sym__name(&sym, encoder->symtab);
+               if (!sym_name)
+                       continue;
+               if (strcmp(name, sym_name) == 0)
+                       return true;
+       }
+       return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
        struct cu *cu = encoder->cu;
@@ -2258,6 +2278,11 @@ static int
btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
                if (filter_variable_name(name))
                        continue;

+               /* A 0 address may be in a .discard section; ensure the
+                * variable really is in this section by checking ELF
symtab.
+                */
+               if (addr == 0 && !variable_in_sec(encoder, name, shndx))
+                       continue;
                /* Check for invalid BTF names */
                if (!btf_name_valid(name)) {
                        dump_invalid_symbol("Found invalid variable name
when encoding btf",


...so slightly more complex than option 1, but a bit more general in its
applicability to .discard section variables.

For the pahole folks, what do we think? Which option (or indeed other
ones I haven't thought of) makes sense for a fix for this? Thanks!

Alan

