Return-Path: <bpf+bounces-40403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF5988269
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0C21C227E4
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5A1BC08A;
	Fri, 27 Sep 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZjaG1a0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RlnQfO+X"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278819FA66
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432813; cv=fail; b=K8nxw1CbYc3Z7sUIrMJxacixUUf7c4dVtPSPmtCVruaeNX7Ipo6VwKG02x+t++ouBPYQ37tgM337aX4qbdeiIKSdhET8sR7afzcLzAtrpMgdmxMcLwGP7qDBcNBUTiXcN2SrpRkovky3+DMBIJ5KxxvkM79k6081SC8kdQ/xsZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432813; c=relaxed/simple;
	bh=nDZPrnLtT/l7h8Xe8Gy6WH92DpXSM8sV9FPDhWcHlbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CwO9Wytglc3681xSwTOXLWu3BWOAS6Dkk9EFX0H+55sdX6ku4zyuXcY2HUIqrGLC1QZEU070bkdoY/XwqvcvU+UKb1TW0FUb7qGp3/KAvaSsJgpDoDPVQjjcG5aR0fBbmkv6WYVK3v+lGyMO0FnZ/UL+aYFww5IrkyZe1crxZ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZjaG1a0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RlnQfO+X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gwGC027355;
	Fri, 27 Sep 2024 10:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HROAh+Une/dbY04j1KE2/UqRRZr4orV5l+5SY/vmQ/c=; b=
	YZjaG1a0aYNcf8lz1pTM4+mkkElibu3QSQxVK7z+jYU2XL0K6bYtWongTpwX7tpR
	wxgfagF5ejSy7ZHwJjTF8dMsPHU3re13d14K6wg32kQoRM/VjzlS4DPMq7QWpZkN
	NkGihOgPGAbhzVYFFp4QCORYw8nXaHACwIPd+m+sGj8DZpCxbTnlfkCKYcrhoTVJ
	8Hv/IYtfP/SSrv3tP+Tcok+mZLqdAqyowy+/IXlI6RWrrsndbT4Y4U4/qgWl32Pi
	e/ZECIxQUN9QfH9YjmoFZAai4mkuyOBoMpAOmfZ+lfacoVMhpcHwHOs5A9AKtldu
	mK/ZDHey9WGqgRL+rPq9cw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cmy5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 10:26:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RA8982031127;
	Fri, 27 Sep 2024 10:26:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc9w9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 10:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykBLU6Jutrf97KY/u/ce45U9q9J5tWQ4E6WA5Vj2aylo1hCHoagjND5IFw9mkU6UstJDA67V7LShlqXWaIBaNebD5JAsktVzwwam/jRYIKxMhpLmUospKNmUr1GHv1iTqlAHRNolclFgws2jTPoknX85AhMcvxdhj01DtTCg1ve8Z4EOcUg2E+ShE+p7U06hgpGqrOsglWrQ1Pyw5YL1qb+IuJxpFZhy9F8gwtQlA8n3xV1YLiyMMCWUHxd+DyqIlUqul+GN8zG6d7FirpjHHYv6SixZOdV8W2RxsQaR0cfdVp0NiysSYJwuy3Riv2AdrAuqAK39fYXaf877R5g4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HROAh+Une/dbY04j1KE2/UqRRZr4orV5l+5SY/vmQ/c=;
 b=tBG5QkmllQz8a+OKfwCVSi+DrKf6t4FYOOSuwiHFPSpIlCIxeMYG1L0pGsS+nN6aSd0MV4aNjFFWW3L8pyMKxta5woeJ/lLWdbvmF4OqWu8pZmYLwGgsE+BUX9yHzE7f2TBLbeDsjXh9Nhyux0eoxrM7SYU/5aa4zfh48C39lv5BzJcp06TAsRlDE1K7KXBs/lWrkEz0TzRcLqE0ast9xzwphBsFshftU2zrhdmYhnM46rb8DwpyYcSmbYH5j5aIaTMncd0v1rw0HO5fpZ8Iul7VEp7JZnCIi4dfAfbq8Y3QEF6MYka1qTJ4m/nHdJrzpth5R2YFpTYAFnCZmPQNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HROAh+Une/dbY04j1KE2/UqRRZr4orV5l+5SY/vmQ/c=;
 b=RlnQfO+XJBE23jLuon0PdZCQU3MH0n58GTuwz0kCuzSig4Ya5XqCROsihkPoU/fZNFz+Oj03iGnr8MB6wXAWBTpBMyNScCW25461xquH+EEqJNs5TYnFBFs22r7UvoDtTjLzf0gfuUSFvkcGzu5YlL5Gxs37vgX2+dqeLzTvstc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6546.namprd10.prod.outlook.com (2603:10b6:806:2a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 10:26:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 10:26:12 +0000
Message-ID: <d9846ceb-b758-4c17-82d1-e5504122a50a@oracle.com>
Date: Fri, 27 Sep 2024 11:26:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: fix uprobe_multi compilation
 error
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20240926144948.172090-1-alan.maguire@oracle.com>
 <084902540a09a7036b713bd2336955e9b63fb30b.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <084902540a09a7036b713bd2336955e9b63fb30b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dfd0e8-1126-4733-28cd-08dcdedecf54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTdqMWhHR25taXhENUJoYjdWbzBMbUFGV3g0R252THBxOG5LdUQwajBUZjQv?=
 =?utf-8?B?L09sbHBuaVBIT01LOGNsRWxLYk4zc0VPM3ZyWkMrQlZUZjJqQ1N3N1p2djc0?=
 =?utf-8?B?RjdXVGF3ZWdGcFREOGEvcVhGaHRCMVB6bE5xRTBMcmZNVEdBeWwvYTQrM0R0?=
 =?utf-8?B?cEVaMEZBM2FXTjJ2dnk2b3QyMVFHTXcveS9QUU1ITFArN01wY0E5ZWVvc293?=
 =?utf-8?B?WXZQc0k2ZHlvQWp2ZjVkdERPVFhrUkZNTkNvTkZ5emNKaXh4SklYUlorWkNo?=
 =?utf-8?B?VGdKV015OWUwVTU1ZC94Rkg2ekpuVWY0anBGL0J6L3dCTzBmeXJid3RrT1lQ?=
 =?utf-8?B?aEUrSGRsSkFTbkZKbDVzOXdBMWM4VWIzRUtxYTZkajlLZ1ZHbGM0c1lVNXI4?=
 =?utf-8?B?WUJBUGV5bkNPeFRLWlFTR0QrVy94WFlpVk1aeDlGekpEdmxqT2RjMGN6Zi9h?=
 =?utf-8?B?YkVyNGlQVGZZd0pZMjlyNGt2VjhKSVFWeU5yTkV5N2paRUlrcDZlT0diQTlo?=
 =?utf-8?B?aEVKYzI2bGRUbUFlTGVWYnRNc3BDcU0xU0JoVFh2Z3Y1SjV2YmhaWFR6eUY2?=
 =?utf-8?B?eUttNXE1MVgwb2R4M1M1M0YrOFhNZmtxb1lwSDZlcUJsTjVYM1J0b3NkZ0hv?=
 =?utf-8?B?cWRTekwzcUxheVo0SFZBY29veUcrVm94aFlvckVMWEhwTTBwNmtaY3NXamIx?=
 =?utf-8?B?OTZvYTJWUWl2SFZhRGZoZk9zUnhyNENHbDNwNGNXeGN5aTZNMnVIUGhaODBM?=
 =?utf-8?B?TzJSaWpZeitKb0h5NE1HQVc2OUVudHludzZIZVJ6ZUhZVkhkSVhibGZkYUtX?=
 =?utf-8?B?V1BFYW4rb3NIcldVVXBQb2RmNTdSOGlYMGxvRFdlV3lUVDBEcmhldVdZU09I?=
 =?utf-8?B?dGo4YmFJMTNhYnlDc2JOQzkybXdGY2hLWWpwZUZCZWVUck1Rckx1SDArQURk?=
 =?utf-8?B?TWYwN3JtZ2lNbEFtMHhOSlhLM0ExMG82NlVNY0VoZnpoTStqRlU2VGhFU1Rv?=
 =?utf-8?B?U01lL2paMFlWODdTQXVZUjF0OS9WZDVMUThzTkoyNDZvMFZzUTcvR1hDL1Yw?=
 =?utf-8?B?cUFqakVxSUQ0eGF5V0kyZjN1K1NjeGt1N0VyV3R2dm1ML2pCTnJiRWkzQ1c4?=
 =?utf-8?B?THQxSUU2MTR0RjlYQ2ZZVXErMmtTMHFRQWlXTGx3bnZCcGtFbHBOMzZISzFG?=
 =?utf-8?B?dmFkYUQxUjRWV3ZzWmJKMUdsZENPYVNkd1pSQ2k1TldXQUJqSTJhb0hLMEdP?=
 =?utf-8?B?c0NFSGNHK0tJSTE2YUIwWERvNDM2ekVnSExzSklGL2E0cEhSWm4vdDlSWElv?=
 =?utf-8?B?eitXY2NaV0JaN1BjK3VGdXFicWJRbzk4L2ZIWVp3anpFUk04R1ZRQUc4d3VN?=
 =?utf-8?B?dkx4bjdJNWFUU0xiMEJGZ1hOSjl6clNnUVdKTnNGSWJjbTQ4NkIvQUNza1Zz?=
 =?utf-8?B?SW1CeFQ5d1RqOHNoQyt4dlc4UFFwUyt0d0E3Wms0RlRNdWVpZ2R2Z1JFMGdj?=
 =?utf-8?B?NVpTV1NveU5vYVE4MVVyOWZtNzgyMExhd1A0MWpUMVZ6d3pHdVJqOS9vQkFx?=
 =?utf-8?B?dzFsT2Y0NnBucXVvN3NwL0pNVHQ5S2E1ZHhZalpNN1BGNGtxZUJpTUw4NEFC?=
 =?utf-8?B?MjZpZXI5d3ZLNkRPaUxmYlVnOGdkQVEyN0VNcEg3dFppQjkzOU52eU5CcHFh?=
 =?utf-8?B?UnVyVlpaYXZTQWVXeDN6dGF3aUwyNmNXTTJleU92YnZPSFZOTkdpSlZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZPWlhRd3Nob0ltWHd5RFNXOHR0N3JLK3Z1SVNWSStJQW9GRkR6N0hYRGRk?=
 =?utf-8?B?RGpEaFA5emRrNHpKQUkyRXFDUUhhY1NXbU93RVFsU1F5L3VoSGdmZGNtaU93?=
 =?utf-8?B?NTZKM253S3UzN1ZuRW9nTlZNbFVMMUQ1VjE4RUVMRy9Xak1NSytHSW1YZ29v?=
 =?utf-8?B?emRUKzNqYVludE5TWHRuNU5pTUFEU0k3bWl5b2hzUjhDMFNhOExucmMvdHJr?=
 =?utf-8?B?czVaSWdRaFE2Q3B5V0hCTnZidUcxOHZ5T3hYL3FTT1VrUmZKTHByQlV2MnBP?=
 =?utf-8?B?bTNSNktBMk5EVzdGSThwTi9wcW1WZ1FQaCtEQ3lCN3ZJR0ZnY2UvcGtBbjRh?=
 =?utf-8?B?TkVhU3d3Q2g0aTEraDI3NElZaWNuUWRodjh5dzJJaGJmTjhJR1Eya3Z4dnRk?=
 =?utf-8?B?WFA3YzJJOGxkT2puYzZoOFdGRnZBVzdzNnUxWjVWRkhVTjZiY1liZjNnTW5z?=
 =?utf-8?B?NmhWZDN4MGJmY2tNclV4UnowdUZpajlzeFFadUtmM1I0N2IrNXNaMzhzUm5F?=
 =?utf-8?B?ZTMyVDFhdytLRkNIeUNHaHBMYjlIQVJHanRyalFycGxxenB5MEV5QjViNDJH?=
 =?utf-8?B?RVpZUEVoZitLV1B6bGpCWFBPY3JvL204cTVCNVpaSDc0V1hNK0lhR3YrOStR?=
 =?utf-8?B?QlRrTXZqWlJWZUNRS3Npd3lyc0taTjlHN0VwZnJnZHpmbjV4TjcxTGh2MEdK?=
 =?utf-8?B?bi9HdzQ2Ritpc2J2TWpRNTJndWVCdy9ZWjlDTTIwS1lJZkVHZU9LMnFMcExZ?=
 =?utf-8?B?RXRZVlVlZXlrVVNBWUFwS1JianpqWUFjRGxwSWFrMEJKUkRaVHp3c0h2WDVW?=
 =?utf-8?B?Qzc2TzR2Nnpxd3M1T3ovbVpnWjQvMStPejBLeTRsZWtqRUJtWFZuWjF2ZVFC?=
 =?utf-8?B?cFVKdXBnQUJKblc1YTdDVnlaMXNlZllYdndvSllxYlV0SXlpWW1sSWdIMnV2?=
 =?utf-8?B?SVJWaEZnRldZNGxneWg2SDBRTEJaSlN1RWppbnN5NXVEWDZvYm1ISktVTlZV?=
 =?utf-8?B?N2pScnlkSFpVQjBiOEJRTUxiVUNJRjRMc3lnUHRZdmo4cVdCZk9GRnRTdUdB?=
 =?utf-8?B?TkdVL3FGOU1FamZ5dlJlcEpDU0RWOCt5NlQ4STNDcEIrQ2phTnowRVJWRjl3?=
 =?utf-8?B?ZnFHbkZpMzNHeEtQZkxCdE95VEVXMUUreUowT1BOdHdXUmxraDl2WnBMb2kz?=
 =?utf-8?B?NjlwazFlb3FEM204K3Bia0wyYnBhWEZsWUNUeWN5eUFJeDJTeTRza2tlRUJu?=
 =?utf-8?B?Ym5UV3hkd1p4aEJBQW5zc3VUcnJjM2h2aEVNZWVLRnUxeS9GZE5hUUc3YlUw?=
 =?utf-8?B?YjZrajNiWlJadGszMWU0bWFWMHBPdmlQclBuV2xZSzhISVl1K3dZWU5SVk1s?=
 =?utf-8?B?WkNpWUNMbFNZaElJZFUrUllia0w0bEY0SDRnZjR3ZUpZa3JHREJSamtQc2h0?=
 =?utf-8?B?TlFkOEdTK0gvbWNxMDZZRDJ5ayt3bWp3L0ZHSE5FcVg4U3JRVktPRm53R3FY?=
 =?utf-8?B?NUV5aFJMdHhZdW85NEEyVDMxbmRyeDE2MlVWUjJQbkRyUHVRcEt2RDdjNHpE?=
 =?utf-8?B?d1BlUlFwTnlDUEZyRXF2a1NDeW5KM0d4ay9tdUdJZVM1QzFCRUtadExuS1Ux?=
 =?utf-8?B?MWFnMWJYdHd4V3ZzTkxKRGlCWFpWb1F0TFhtUzJZRkZXaVdQZUFpMzZVdnhs?=
 =?utf-8?B?cmkvQ3doOXZZRHRsRXE1THZsT2VoUVZxOHdqSVBzQ1dzZys3Mkx4dzZUUDkr?=
 =?utf-8?B?UXYxbTVWdkVNOG9EbERHTzFMS0Y0NFgwcHllQUVmY2JyMjNpZTZUM01NWG4r?=
 =?utf-8?B?SWZkTHF0UHN1NW5Xc2ZzNUYzTDJ6T3ZrNXdtcnRYWFpKN2l3YWRsRldvL293?=
 =?utf-8?B?cEI2dlNEclhXM0xPN25hazY2ekRrc2lITWd2L1IyeGJHcnNyd0hGSklOMzBp?=
 =?utf-8?B?YzJkKzRsNkgxRTdIMmtzbDZCQ3FoYks1VU8rb3NxMW1adTNPUzVrZHIzenJh?=
 =?utf-8?B?aTM3blpTcC9OMUhqdVp2cjhEdVNlSUdtWGFGVVZRRmJRbW5McXliT1dJYnYx?=
 =?utf-8?B?QTJXcSticFVMZVZGMHVpdlgxNTBGakhhK0VBZE42ZWZTUUg4cnhlY0tvbHov?=
 =?utf-8?B?R0Z5Q0syYnFYNDZrVk13a3FzOVg2NElMUHFiSXdqUjRaSmRyVkNsRW5QZU5m?=
 =?utf-8?Q?THV/l9IEgrLYcgf74QEpD0A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TgH48umzh4dWUebCrZH4aI1xV/BYKNusCGh+JAK7t+SCSAASD/AFkXLZsGQYzlUeRGZD3AEjMzt+VDAeX35g1ZWTCZm6LGGy11dH+msrFTrKkNHkG5iDSnbBFyZqQdjfGR0HMehm4HL93tI/4mB0Ao0LYmKBadRVpi3YIXylN4qI+RF/W9e0omV5uXDeGZTl4s4zIa4glLRqyyojzffKJh/DlGIJkS6L4L+UzCv0J4GmtLOQCQPWugpRnjrLyIvm5MyurvczslBSj/0Rl7TSZEfrHzNkuAPmpXMs1g/aslsiANCJJ77rBZDFkxeqvYkqko3QPpyY+monvLdJjJ9W3jb0dJ1Gzb7zSxwqh+DkqEhVHaDFN0aJUIO3yMLxLUNYhH5ILGHiX08Fo0JOnLbANvd3GFZl5PhJHt+rx4utqbKJgF7G5JmUUykBq8E8bz+5u/4VB996B47DXZIGoXplSyvuvP5/aKHXfGnYMdJsA/tRjeIhSmFpoC1FL46p9A3qO+3r5nY41aCdrUwChXpEWAuFRA/IA5+XZ+zYVfLZPISuD5yakjMwd8ueYQsvZ9kGAJp/XiyQgDr8uO0TqAjan6RZUlJ/dgmF2EQP4KwW/ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dfd0e8-1126-4733-28cd-08dcdedecf54
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 10:26:12.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+FFfzNRmpVcvyYITpa46TAm1tO40xEN49WdAAoFKCJpXLEExheh690lfr7k1zO6WRiWj62oKGJNy4Uv+Iapig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270073
X-Proofpoint-GUID: Pl4544TY2zhz29mjOT511aYbOV7TSlVJ
X-Proofpoint-ORIG-GUID: Pl4544TY2zhz29mjOT511aYbOV7TSlVJ

On 27/09/2024 00:44, Eduard Zingerman wrote:
> On Thu, 2024-09-26 at 15:49 +0100, Alan Maguire wrote:
>> When building selftests, the following was seen:
>>
>> uprobe_multi.c: In function ‘trigger_uprobe’:
>> uprobe_multi.c:108:40: error: ‘MADV_PAGEOUT’ undeclared (first use in this function)
>>   108 |                 madvise(addr, page_sz, MADV_PAGEOUT);
>>       |                                        ^~~~~~~~~~~~
>> uprobe_multi.c:108:40: note: each undeclared identifier is reported only once for each function it appears in
>> make: *** [Makefile:850: bpf-next/tools/testing/selftests/bpf/uprobe_multi] Error 1
>>
>> ...even with updated UAPI headers. It seems the above value is
>> defined in UAPI <linux/mman.h> but including that file triggers
>> other redefinition errors.  Simplest solution is to add a
>> guarded definition, as was done for MADV_POPULATE_READ.
>>
>> Fixes: 3c217a182018 ("selftests/bpf: add build ID tests")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> I was curious why this error is not triggered on my local machine or CI.
> MADV_PAGEOUT is indeed defined in UAPI.
> Selftests build picks it from host system header, which is
> /usr/include/bits/mman-linux.h for my Fedora 40 setup.
> The MADV_PAGEOUT was added by commit [1] back in 2019
> (and should be available from Linux 5.4, I guess Alan uses a very old kernel).
> 
> I think that at some point in time we should adjust selftests to use
> UAPI headers that come from the kernel being tested, not from the host.
> Until that happens, I think this fix is fine.
> 

From what I can see at my end, /usr/include/bits/mman.h is provided by
glibc-headers. On distros the glibc-headers can get quite out of date. I
do a "make headers_install" prior to running bpf selftests to get latest
UAPI headers from the kernel in /usr/include/linux, but that wasn't
enough in this case since /usr/include/sys/mman.h and
/usr/include/bits/mman.h were provided via glibc-headers.

When I tried using <linux/mman.h> in the program, I ended up getting
complaints about madvise() being undefined, and when I used both
<sys/mman.h> and <linux/mman.h> there were complaints about mutiple
definitions so the approach taken in the patch seemed like the most
straightforward.

Thanks for taking a look!

Alan

> [1] 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> (I want back to 2019...)
> 
> [...]
> 


