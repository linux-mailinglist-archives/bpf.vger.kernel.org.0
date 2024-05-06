Return-Path: <bpf+bounces-28708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB18BD525
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF191F229F2
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C223158DD3;
	Mon,  6 May 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELhNSUBq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IlbhIeX5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BA158DB9
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022384; cv=fail; b=qS4lw4jgFkTI6rQrSF0w5piKWfCj6kLPdLwfIE/yPJ3YwrBQxYEPI2FlMy8HBWwyWgK++ncDaj+XgaM8kh6SC+nMsRjCypmT7zq+1p+OV3K2jODE8tcO2TeTe5QbRQTJaA0KWFAmwoRvCyV2RjeAsKkH6y3hiRj7S5CRzxwiZHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022384; c=relaxed/simple;
	bh=o7/LjVQ2q35XXhZSR5iterHPohUbe7ROj4QnoGiJvIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5Z8LMEjYnLLNbK1mLebN3Bqd07N4oHtF2Zp0hrYoaon94ERnQhj09E7qljIQDH5XN/hir2UiqiXaSTZSUHcEYMMZZRJ1k+x/kvCJBTT1TXxw4dgvgtt/m2DAhtA/snQYcclPP0gllVtj0B7QZqB5rIAaFe97go/7bopg1U/75w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ELhNSUBq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IlbhIeX5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IePVY027841;
	Mon, 6 May 2024 19:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YbZQJzBiGWDaKGMDbJU/g+AJQ5PgMooOcU1aUy07xa0=;
 b=ELhNSUBq4fRULu0lOe6j9OZ8vm3Bj23UIaivCA8zt3cqA7zgVj80w71IbTQhK99fBs4K
 ilF6lqftUenildMs0Jf4fOecO065CagCdsizdYgsR91rCC4lsn7yBHMjRHDRtUlVBkj7
 ZNVjlvv5SjYFg0euwmxFcFOf9nb+5o5DhDDjf2paoL90SimDqb4z3aUCTfSA7JuMjCP8
 jfnEHE+RDbuDxSXtySzgU1W8bu8gu4sQW3H0ZOSEm05R2pImPpyxXADwiV/br5QnyEYn
 E0Nw8jWJ+kNb2Ie1OVqu5EDMuGgURt4BezioIr536cnTTsxPnK3ThMBYxOMxoH7vzwa6 dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2duaj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:06:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446HjOjT029378;
	Mon, 6 May 2024 19:06:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfc8udf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFkal+xmQHUuvS/KAO2+VvTUhpj/uKqyddnbdkl8CkGOxYYX2IaVT9ggvZ0/J1S3N/nPPpETPJ6BTQTMVNgpv9mgrX+27oPkEdpCGSAgZR/LKdoZ5x6VCQ4umOD9c6KT/qyyoOrtVa92ypy9RSmlhHbfdTPQO0kfOmj+bEZc6XdBzeTb5CKMukqx+iEkWRSYR/0xIDlvjVFX5u8h/dS1Fz+aNArkLQgXRhxPGFXsov/IHuy2roqjaZx6tOiRp0pR7qjB/OsceJKLyu8NjQ3gijItjPrALQijdb5gJIkCC/BgISI7lhQmk513q2AhPrUUCu6talRYwyyKjma3QoG8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbZQJzBiGWDaKGMDbJU/g+AJQ5PgMooOcU1aUy07xa0=;
 b=fh54xQi+pUjJDYNhLaO4/9T0lYN6jnm8lqmx/ThqylevujbT/Jx4qEfbMNye8Xk3F8tmflAx7SySBdqMXgjCrf6w0Z0H72uGW2gp/zpOFhqkg/lKj3qEteuOOdQw+2j4XCu7SIktIEmeiCOSL8PSlTZ11uK5iAkn2e8m5UaupCZqdIhUXOYmJCCs/LVEo49PgAxeFdfxnCJGbhKxp/lPCBKDtXt0vZLx67k9TZAzzxVcrAcgjPFPK6Wv/O7fXT2pzhiMvPYkO7DHCbGEYL9x4imKmSlqFbTWvDXL5ryWG9CtdhJjoCjjmNnENRFk0kbaHdbPcUqMGx/H6EPXYS9Dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbZQJzBiGWDaKGMDbJU/g+AJQ5PgMooOcU1aUy07xa0=;
 b=IlbhIeX5WW+eWBBWvFnsC6WKCzGe20avqaLEhJwjJb2I8mVuO6X6EHFjoiO6P7DxsMmDYM1BY1GgFsE5fSuFQNFKOUQSmg4EdCN4uUlPgr/ZAO1E7XAaCbivShr3ltoXy4HyGxdXcB4rORy8rM9WLncWsyxkz9rdwmbmqCxaKYs=
Received: from DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22)
 by CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:06:16 +0000
Received: from DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::ddec:934d:1117:499d]) by DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::ddec:934d:1117:499d%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:06:16 +0000
Message-ID: <18123833-2d51-432d-9803-20dd76d7cccd@oracle.com>
Date: Mon, 6 May 2024 12:09:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: disable some `attribute ignored' warnings
 in GCC
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
References: <20240503123213.5380-1-jose.marchesi@oracle.com>
 <a95b1917-80aa-4c81-942d-91f369d31bb2@linux.dev>
From: David Faust <david.faust@oracle.com>
In-Reply-To: <a95b1917-80aa-4c81-942d-91f369d31bb2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To DS0PR10MB7953.namprd10.prod.outlook.com
 (2603:10b6:8:1a1::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7953:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: de1d0b9b-22fa-441c-533d-08dc6dff9b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWMwbk5TNTAzU0R1YTVQUldEZTgrQTBZU1ZvQUswYWF5MTJMOVgrZmJNZlRW?=
 =?utf-8?B?Nkw3K1o1MnlGaCtrYzhnbk1pSWZyOHpaeGlMNFZBMkRWbElFUTZ3SzhyOTRJ?=
 =?utf-8?B?Yk85SVV3UDVnSUExL3oydDhLT2lTZjdiVm5KWFBLUEhLKzlUSXVHUVdNa0lN?=
 =?utf-8?B?WnltNXJ1MlZrN1MrSW5kdVhCajE1V09ESnQ5bDFnOVA5OEpoeXV2a2xGRFpT?=
 =?utf-8?B?dFN3blk2ZDIxY2VobEtsZGZQeEFnQlJuTjNzQmNXajNYZjNEVkgvVE9SZ3ZB?=
 =?utf-8?B?RTg4M1pUcGt5cXZ5WXN4S0d1QnhpbjkyblMwTjNyU2ZkVlErRDM2a0lhdnoy?=
 =?utf-8?B?RFRKNjU1M2pxeG53YnZsWjdLcFlMV0xpMlZaaXY5MXgzSzEweDdIbi83WHh6?=
 =?utf-8?B?SWx5V1cxWVFzb0lRTThlWXpJRzBMWDBWbW1xMURLbXVWS1l5MHd3NFU4a3Jv?=
 =?utf-8?B?Y1ZLcWtsVG80OTVNUEtCdlJnUnNkZ05VOHV4enFoREF6U3hOdGptbXh0QVNn?=
 =?utf-8?B?Q2VuSURYakNwMjNjYk5BdTJkblU2bEVuOFFYUGJYRXgwTmpzb25wZVFKKzIz?=
 =?utf-8?B?M05KWUJuN3U2RmN0NnhLdHBzdSt0RjNzSk80TWt2ZFRFajhFNFZxbkJXUTh1?=
 =?utf-8?B?a0VzREVQelpKck9FNGNNcVZrZm8wVEV1SEw4ZjQwL2VKcWpwTmNTNU5ESTBP?=
 =?utf-8?B?VDlTNndNSFZuQU9tckFQamhiZ08zc2I4cndrcDBLckRYYU1NM1MzbzdPdHZz?=
 =?utf-8?B?V0YvSDNBRWkwczJlMk5aU0RPYUY4c2d5OE40SGdIY05YdVhFclFjSFZZQm0w?=
 =?utf-8?B?SVRFbm53alNZUk9iZTRuUjlrdWZHVzNlajJ3cXY2TGtiMmxSRUtteUZNakdr?=
 =?utf-8?B?L3hITHlkN3UwTWJ4VkJrcEd6MGgzb2pzZm1FRU5pVk85aGxzSWI5YTZxeFcv?=
 =?utf-8?B?cmhneE10cURaaWQrd0lyN2hxSUVOZXBtK2Nsb2oyTERXakNVRHRmVEZMRWE3?=
 =?utf-8?B?R0tYR0Y3WERIb1JPbHA0dGdqeWJyNHVUcUdSVDNHenBadVJaZFVhODFmbUxG?=
 =?utf-8?B?b2RuOFJHRjFvSEN2QWpCTThnRlZNcURSTEZVTkxFYTQxWkU2c1dNYWkraVpl?=
 =?utf-8?B?QmRPMzVGazhDZHAvdVNpUTlxenJyMEphMnl6c2d3WVF3K3I3TlB3S1QzODNX?=
 =?utf-8?B?WDFrUGZDOEJQTGlqZFNpSFN2VDVqdmdycDZZVTRmY3pDZWJhZElWR1NYLzB6?=
 =?utf-8?B?YnZVc1F2Myt4ZWRsaDVHcXRFMjd3SUFiZEttVjFuenRUcUo1eGZQMVBtdXlC?=
 =?utf-8?B?MG5Vd1lYYlg1ZHFUZWt6cVZyU2lGSUFSK1FlWHZaUllIT2pwcHRNaC9QeTY3?=
 =?utf-8?B?c3UyREx1UllzMzNHOFJSNjMzTmo3NWxKcXdDRnRwekl3V2VoRUNwUmhnQXgv?=
 =?utf-8?B?VkxJVXNBa1hVTlhOazhBa2RpSUttVDc3WW9lV1RtWXNBOGllaitVMHFPVDFp?=
 =?utf-8?B?aVo1WVJOaXVrSENKNEZZemZsRkREeEZmVXBNNGxkazhkeGYybWlEaVdSRk1p?=
 =?utf-8?B?YXBOaG1LOE5aZlBZU08ya1EyczlLTHRwSWpNY0VFb0d2SngyU0tXbjJON3JO?=
 =?utf-8?Q?qxSZZvgfwrYJWzD1myyX65MrFTB2C3CRuJ8gAcY8r3Jc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7953.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zit1SU9YT1M4NnFYTzFQTHJYdTZkUHJNOGUwZExIZ0VrQ0s2RC9zNHpJYXZy?=
 =?utf-8?B?ZWZjalIyODJlRjRIeDZCWGIxazI2SmVWQUNLRjFBU3RtN1VVbEhIdU51L21P?=
 =?utf-8?B?R3E1bkJDc1NCc3oxeVRvYlVLVmJyL3Vjb3ZzMU1wdHZibDZNYmU5WFBVc0o5?=
 =?utf-8?B?MzMzdVg5eFhJNElrQnE5MFIwdDE2L1FtcXpjeHZ6eEltd0lSVnVWcll6R1JY?=
 =?utf-8?B?K1pMay9Qa2lYMmdHSTRnR1VSbkJKU2FRdEZoQzRiWmhMUzBqMnR0U3ZLcVBr?=
 =?utf-8?B?OWpWWm9tM1hRUld1aU02NDI0cXpaSUYvYjRPUXgzSy8yRE1DZ29PbjlUQThR?=
 =?utf-8?B?d0p2K05uVDA5NnNXUlhmUFFseG1oajN1c21mdVo1TWtEdUxhMUxrYWREUkdm?=
 =?utf-8?B?eWRoNTJzeXZzYkF6aUJ0Nk0yM1FPUDVIa1dCT05VTFhxMHE0VUhWUVR1TEN5?=
 =?utf-8?B?aWd1VkFaRTNJa0lOdWJJRnp1N0JUSElvYmVOR0xFUFY1cnpuWVpwNlZCaEJT?=
 =?utf-8?B?NzNWNG0zbkR6aUZKbjBZK0NXVVZGeVFRWmJ0cmp1azNOOFNIZ09nRG1FQVpT?=
 =?utf-8?B?TlJuNHhpTTR4Wjh0YjV1OEZxTk80YjNwcU1DVHFEdFpDRWFNWlVVbnprN0I0?=
 =?utf-8?B?eENXa1hPZ3Q1SG5XbEJkWnM2MWc4N2FQWFhyQlRWS0ZyNmFWZEk3VnNHdzlt?=
 =?utf-8?B?Qmk1TkRXUVFlRnkrbUZXYUVHQng2TU16WWpuUSsxRGhGdy9RdHZGckhIUHdC?=
 =?utf-8?B?dVpiUjEyUlEyV0lkZ2JlcTcxdVJhM2taQjl0UGFSK2EzVm9zT0locFhsL0Vw?=
 =?utf-8?B?bklHTEozQndqVTQyd0hrV3RXQ3ZRcEJTcjRpb3RzQjFDTE5SRDFGbVMyMlZS?=
 =?utf-8?B?SzhKMW92cGx5VzZmejI5R2pCckExOGZ1bnVYSXM1cFpKSXBIZk5JZjI0RXJY?=
 =?utf-8?B?WnRIOUF4VDdadTUwMEVKeGJoVmQ1RG9wYjBidWVqNnMrTGJSRTRiQWhaMDBz?=
 =?utf-8?B?NmUvN1ZCNHlhTDZscEg5N1ZiUk9FQXlFVFJjYkRjWi94WnlLeFVYb0JycGtD?=
 =?utf-8?B?Z0pUT3NGNTN0cTJLWDV2b3l3SzR5SFJrekprVUpoOXhwS3ZidmFSMUpxS0pV?=
 =?utf-8?B?clJxUEZENjk2YVFGNTZKOG55aDJrYlFLTUVxUHZxZlkzekhsc3N3R0Y4WUlh?=
 =?utf-8?B?VEMwTjdOSzc1Y3UvMkJhd1NzZ2JsR21EOHlzSmQ5T25FRzRWTHl6dlF2ZEYz?=
 =?utf-8?B?OTRncmVFS09hSmQvajduV3pmbkozbnNTUjhRU3dpY2xyY3hLQnV2WENSdXhL?=
 =?utf-8?B?ZW9PWmN5WVRFeElCSVF5MmpVUVAxWFhzMzcvUUhMZ2Y2eGxBcDI2cGU1Nktu?=
 =?utf-8?B?K2NVYTI5T1V4S0dxVUQwL0N3NjE0bjVDNDJmRWNGZTRneXozbDd4c2ZpRVZY?=
 =?utf-8?B?WEw2VENmcGk2TjF5Y1IrU2pCc0V0MmV0WDY5S2xBMDRjd3ZOMlV3dlNiNWRZ?=
 =?utf-8?B?RndlRHBtTEx4MnQ0SUNpZU9JaURHSDBJZ04wanB3K0wzQkhFeFpjK0NCbWk1?=
 =?utf-8?B?ZERPcnBLUllsRFZJdUpVd2puaXovSHcvNDVWTVFKeHd4MitCcEFyMGJFRUVP?=
 =?utf-8?B?YmdIczdvOXpIMDNpMHBaNFQweFdBaGJidXJNVXF0VjRlSldRc29hS2RLaW9Q?=
 =?utf-8?B?MFRERlVrY2NPaFJKejZDdVlldG5Ybm5Bb25UUXk1dGlOTWVnZUdUaEp0NFV3?=
 =?utf-8?B?QUtiMk1GcWVmZlNDODMvcDM5RWdVVlpYUXJOWXdha09FSkd0aWdNM1FCL0Yr?=
 =?utf-8?B?R1RVa3JTOXVYZktZMGdhRmRPNlIxTjhhblBZcE04NWp5V3RrSnNDSkxwOW96?=
 =?utf-8?B?K1A3cDVZYkhaalkwblN6ZUQ0bHhKZTdEdTdjOWI3QmlGcnpxdE9TZXpRbnNT?=
 =?utf-8?B?SG1CdWppRDZ4dytzZXVyRUhRMXRWTHhOWGRlSkhCRFgxM0lxWWpGMTB6WU9x?=
 =?utf-8?B?UDBXYm5sUkVJYmVMQ0FBU0dUcmNBKzMwby9odHNrR2I4OVQ5TUZ0S2hKNVl0?=
 =?utf-8?B?Y2NoZ2hCenJKbmJoc2pSMEx5YXdySlBmUGZvY2M2MXNYcVJKbnJZY2lrdFNV?=
 =?utf-8?B?SCtoSUlHbnc5aHdsTngzSXRkemFoWjMyU1RiZUttQWlEQmdWdkJVRlhpU3Rw?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0C8S8VakRLIfOZ7moiGZ6XWaLaNjB+i/i7MzwfQSRhAEdGi3P6gzd9ldCjMerkkho3aEKaGOeDkz2RmB+7d0uxkp8n24CCSeUFfXIJgH0Hb/Io8UC7qbT9c4ofhjqRXifVuw9aa7mip+bqNttgkdq4hLlRstbUl3ZTjeBRIH7GiDGODUhpkF6oGy6Z4HyuJZa9Gjvd0Lmb8p/ZMxeFkl58IDBkPNw1m9hDgZIz/FgjRvHct+DFAx7UocUHm20HxZWGjBZknIjVNjb7O6INRTGPQh1BLL3WklNVeyxrAN3dusSz7snrkLTRxL+MVgslgryJm0pK/ChzENhcOgrEQyaPLPlqh2emWCdL2DoFNukfI1rUXGjb6beix9dNXxyPYCCeQLy5bXDmJLH6yK9ax5PARLPO1zePuUjCe+ixDXwM3E/y9AdJ0y6bg9HdTy10tru9uVOU29FM8NkRqVCC8jxKFy+qzncKGS/57kUQf7PFGucY4qJvwdPLxW6Erq5j/Y/94iXGkx9Kr64LSnIKNuAf1xGxm2+ksEPjm90T4pt0Z4znPbvKL/ZTTxhQhalBjq5pN2fSftFxDnA423dK2lC/VyBkmX+gEN7JMQy7rP3wo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d0b9b-22fa-441c-533d-08dc6dff9b1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7953.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:06:16.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbGRnOJ5ohEd4pGklrnvBfusxSmtNUm0Cr9KMfTqrjEksscqS0A19C6GeOPiStjnm1Rbh/I+uUtRNIbzsOCPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060137
X-Proofpoint-GUID: th_JdFKj7HU4THYPQ1-8kFE38-FHFwYc
X-Proofpoint-ORIG-GUID: th_JdFKj7HU4THYPQ1-8kFE38-FHFwYc



On 5/6/24 11:32 AM, Yonghong Song wrote:
> 
> On 5/3/24 5:32 AM, Jose E. Marchesi wrote:
>> This patch modifies selftests/bpf/Makefile to pass -Wno-attributes to
>> GCC.  This is because of the following attributes which are ignored:
>>
>> - btf_decl_tag
>> - btf_type_tag
>>
>>    There are many of these.  At the moment none of these are
>>    recognized/handled by gcc-bpf.
>>
>>    We are aware that btf_decl_tag is necessary for some of the
>>    selftest harness to communicate test failure/success.  Support for
>>    it is in progress in GCC upstream:
>>
>>    https://gcc.gnu.org/pipermail/gcc-patches/2024-May/650482.html
>>
>>    However, the GCC master branch is not yet open, so the series
>>    above (currently under review upstream) wont be able to make it
>>    there until 14.1 gets released, probably mid next week.
> 
> Thanks. It would be great if the patch can be merged soon.

A small note here - the above series does not itself contain the patch
to support decl_tag, it is just some prerequisite structural changes and
the option to prune BTF before emission similar to clang to slim the
selftest (and other) program sizes down.

The patch to enable decl_tag for functions in BTF, enough for the
selftest harness, can go up after that. But, it will require some
approvals from the C front-end maintainers, since it is a new attribute,
so it may take longer, and may be contentious.

> 
>>
>>    As for btf_type_tag, more extensive work will be needed in GCC
>>    upstream to support it in both BTF and DWARF.  We have a WIP big
>>    patch for that, but that is not needed to compile/build the
>>    selftests.
> 
> Thanks. Eduard has implemented in llvm with agreed new format. Since
> the old phabricator becomes readonly, he will upstream the original
> patch to llvm-project soon.
> 
>>
>> - used
>>
>>    There are SEC macros defined in the selftests as:
>>
>>    #define SEC(N) __attribute__((section(N),used))
>>
>>    The SEC macro is used for both functions and global variables.
>>    According to the GCC documentation `used' attribute is really only
>>    meaningful for functions, and it warns when the attribute is used
>>    for other global objects, like for example ctl_array in
>>    test_xdp_noinline.c.
>>
>>    Ignoring this is bening.
> 
> Bening -> Benign?
> 
>>
>> - visibility
>>
>>    In progs/cpumask_common.h:13 there is:
>>
>>      #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>>      private(MASK) static struct bpf_cpumask __kptr * global_mask;
>>
>>    The __hidden macro defines to:
>>
>>    tools/lib/bpf/bpf_helpers.h:#define __hidden __attribute__((visibility("hidden")))
>>
>>    GCC emits an "attribute ignored" warning because static implies
>>    hidden visibility.
>>
>>    Ignoring this warning is benign.  An alternative would be to make
>>    global_mask as non-static.
> 
> In the above, let us just remove __hidden from the '#define'.
> As you mentioned, the 'global_mask' is already a static variable,
> adding '__hidden' is not really needed at all.
> 
>>
>> - align_value
>>
>>    In progs/test_cls_redirect.c:127 there is:
>>
>>    typedef uint8_t *net_ptr __attribute__((align_value(8)));
>>
>>    GCC warns that it is ignoring this attribute, because it is not
>>    implemented by GCC.
>>
>>    I think ignoring this attribute in GCC is bening, because according
> 
> Bening -> Benign?
> 
>>    to the clang documentation [1] its purpose seems to be merely
>>    declarative and doesn't seem to translate into extra checks at
>>    run-time, only to pehaps better optimized code ("runtime behavior is
>>    undefined if the pointed memory object is not aligned to the
>>    specified alignment").
> 
> Yes, the attribute does not really enforce at runtime. It merely
> give a declarative requirement.
> 
>>
>>    [1] https://clang.llvm.org/docs/AttributeReference.html#align-value
>>
>> Tested in bpf-next master.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index ba28d42b74db..5d9c906bc3cb 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -431,7 +431,7 @@ endef
>>   # Build BPF object using GCC
>>   define GCC_BPF_BUILD_RULE
>>   	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
>> -	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
>> +	$(Q)$(BPF_GCC) $3 -Wno-attributes -O2 -c $1 -o $2
> 
> LGTM with above a few nits.
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
>>   endef
>>   
>>   SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c

