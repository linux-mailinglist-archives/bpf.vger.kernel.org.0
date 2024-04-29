Return-Path: <bpf+bounces-28131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4EA8B602D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7687D1C224A8
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6E1272D3;
	Mon, 29 Apr 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X3jSLcwI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G4O4SxTi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4681272C6
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411921; cv=fail; b=FX/npbm25xgyLAUFGG3Q+xtBWKlrrGQDH56ju+SCF+EnkNq1L0fFx1pKd3B0R5Cs7C1BkpJRacAs0mcQ8zWIjawlAaDkZpEQ7hAO5Jn2a/Mmc20TU8KagFYRtITgVw+s41p+rI8e3TuEPSzQqWUnNwwa7MtRQc6hYy2YKzQtVzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411921; c=relaxed/simple;
	bh=32j0i78LA4ZWyau3Sj7/L8ssoikgg1AMX7tg4zydThU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ii6YWtKdqlWqTnGUeM6jS8Of/iWKdB3l+DQMjXuFFOFA2vjFl7OMcp5YlNGQA3xs807J91WGdZvNSx3dr38WaSZ714GSWzhrbr7bZfzbwnjvlAdNJCLR8kIzYzT4pjDxqbOOwPg8/W0seU1yEQCtbiIwkIjmF6ZFnZ8JUAKj7Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X3jSLcwI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G4O4SxTi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxR5v020042;
	Mon, 29 Apr 2024 17:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zLAiDhyQR08YxgUeTvdmJOofExgGPQcojS1AyXCLHCg=;
 b=X3jSLcwIeILhe0ApCQl2j8TRQDG6PvEg4cdmASnXIGnUZsEIrLs+xrgwV7detXnkzaKi
 XiZaecyI+/jjR6yOC26T2r57W6gimoa3xfn8AZrCRYXah4m1G79MJksTgOI2MhIqGzRK
 S0vd3bBI2u7I4Ks1EtShhKdxxSrYR+94fvU2ttyrADZiIHmCdUE2hOaPd7zrg1p1C7Ou
 NMMsJtlr/HwXOJ1jRtinLy6vuDCKVkTecKt1zYZsq9JT5jZ1jqtvTTzsfTo6Hlac19Mv
 7kgd8erYQYcsh+knkhng7YJswyhQO90LxnrJ3FHbhmkWg83l5Hs/JKD6dbzrC+n4uKOY Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8ck58g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:31:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THCSdu033224;
	Mon, 29 Apr 2024 17:31:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6e9m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivDFnj264nDlHMqxZjJVh25LPggV86t6aHL4bmYCNipp0h0JidvYAnyJw5Lk/v/BqAPeZtxCTOUKazAkx+a9DCeyoZoypYpk7gmns2paxzHjNQ+E8K6ovkimX6WBvM6+9yIXXcBcUwAOiB4YCIwXTA+ck76L6NMbUBSc96De5XE0JIjnUFI6eCwX0mZH2Fy++MhJ/Yr6ap+qq4ZV2zN7Ty7cODdouxEI8UrCHxM9HkmJvPVqMLaQ6t/UqmBXewDe0FF6vasvW2Z2zEyQHNMnAyf5/Q1PaTvZqImqKs9/FyNq/9H22XpbAf3wq2gANG0TQlbRiYUybNbg/dnFXlPdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLAiDhyQR08YxgUeTvdmJOofExgGPQcojS1AyXCLHCg=;
 b=QPKI1LdQh+JutBNlGcW84VkMhNIooMBYe2vPlXQ7GxkND7/JcuaINoLJ7LbETfLOB8r/j9mebsBJ3C6qFAxUdseF5xvQhCVXdTrXCMqWH7lzzjBsAHInnBBsmFfruJ39+a9lBbTam9CQLRZRs9BF5STwpes4f8tqBfoc3OAsCskwJddLBtpsgOE3qylUS0ot1dbZV54JkoTbyA8GQkhBffNCkCDBQPV+CTmQd25JVHoE9z34UU26Asa+cIawa9wMDCAZKSF2YI7EqjF22LYjNEbMXIwuixh9tyJH8VLF2H4YiqBdjrmPGylUIlQk7/3viF5ckCe+ZOA7JTKaW5J/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLAiDhyQR08YxgUeTvdmJOofExgGPQcojS1AyXCLHCg=;
 b=G4O4SxTirZ11AJZrpMzeiAcWVSTGjdYWJP/qVCFYqAM/nQnYZo6c09lJGDc7QoZ/wB0KZ8YvCgPjcVaw2cZzMdR9eqoWunVV37TaPhsGNkUjkzT8/DnXPU7+xb7sHR6z2SNtxXTitnbljBHHZZsDvmvEx5Ufo5DjuQQA+FxSN9Y=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:31:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:31:23 +0000
Message-ID: <f05afb12-5ec8-47d7-bcd6-a0d6b913b38c@oracle.com>
Date: Mon, 29 Apr 2024 18:31:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: support resilient split BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
 <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com>
 <e08937ac-c329-4a72-9a6e-8fbc36a740b5@oracle.com>
 <CAEf4BzZ=uMh4gW8O20-hZV1njJTAN4afQBKzFHro5A6ym-3FBg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZ=uMh4gW8O20-hZV1njJTAN4afQBKzFHro5A6ym-3FBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::27) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c6263d-66f6-4247-824e-08dc6872308e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VXo3d0s0UG0zRFlQeXN6NTlJM3lOT0JhdGI5ei9lc0ZUVmxyNnhuT2RMdEY0?=
 =?utf-8?B?NjdKR21vb3hjOWlKZ21mY3owRStDTE9pYVQxQTZ2dHJncFlhTmVTdVk0cjBO?=
 =?utf-8?B?ODU3WjY2UnBWMDJhVTE2ZENGb0thaHRzcEppL0ZSY0dGZkpRUXVNZ1lIVVNZ?=
 =?utf-8?B?MUxGclU3ZW4xc3c0Y2x3eWRudE1NT0tOVzcxaHZtQVhTWVpLeUJIczRkUGg1?=
 =?utf-8?B?YzVlbDVEU1pkOGthUE1UaGNaSUpOdm1JQ3pFT0xteEJYQkUwaXpSUGo0VVBi?=
 =?utf-8?B?MUpwSElSVUFTeXZQK1VqbmNaMUxTZ2tkRE81ZzR2Nnc4VXJBRW1qM3Y5WHF2?=
 =?utf-8?B?NFhwQ0xSL25KUnpiU1ZONmJ2ejExalM1U21WeXJKR0dFZEZweU1EemRCUE44?=
 =?utf-8?B?OGRiMEppaDJ4ZGd3a09rRytFdHNxVmhHNzkvN21za3RsVHFUWWF5bXdtRlpm?=
 =?utf-8?B?N1M0eGt2TGN4a0U1TEJ5aEtHUE1adjJGcXRaUG5INS9EK1RjVG41NVg3UTF3?=
 =?utf-8?B?d2M3WE5hdkVvNmc2WUhwUlBqUEdqazhDSGZJaHQ2cWdEZFh5bnAzWERDZDBq?=
 =?utf-8?B?VXF5bklKNUpyVEhDaDZOTUJSNFJKTldEU1hmV0FRZTF4T0JyY3dKeEZFbk92?=
 =?utf-8?B?TTQzS3FwUjdoMS9LZDd1Y2pOZWtqNkMwczAwcERJemFRaW5BN3poVTVlRHpj?=
 =?utf-8?B?QUZ5S2crN0hvc3JITzJGc0t6TVhaSGhGQW1BRmpZUEhKNCtJQm9Tdkx4V0E2?=
 =?utf-8?B?NU9IbFJlZVBtTHU0aXhaRTN6N0NDNG8vSjBkbm80SUZCVmFuWlpBOFFyc0Nj?=
 =?utf-8?B?M1R6Y3pIMkFOSC8xZFMxbG1QQWVsb2VVQ0taZ09MaDN4V0VMaVU4WnRaczQ3?=
 =?utf-8?B?Ukl6cTI1MFc3MGtmY2FxMjFRWFE0OE5XSnJFZFc1cmwrRWhqY2l2Qy9YN1hN?=
 =?utf-8?B?S043Z3FGc2V3NkxwZSt2NmpwS3cyRlJkbDRWTnhzcGJSMGdFRCtLa3pXbThx?=
 =?utf-8?B?TDhKMUwrZkpOTjZtV1pzN0ZpbmF0UmNLb1V4L2dONnhRVlo1UERuSWR5NEtM?=
 =?utf-8?B?MjNZd2d1cFdRVDBkWER1eUNhcUZwaVVLdDNjbjEwcC95aWh2VFJ3UWFjMnEv?=
 =?utf-8?B?UWwwZnkvaTBBV2l0OTRoVmtndGxhbjUxcHkwekZFNzI0N2lMT2d6eGJGZ0p4?=
 =?utf-8?B?TERKbElxWFdsd1p3TWJNSk41MG9oaDFvSExZK0sveElDU0puWkhRQ05aZm1j?=
 =?utf-8?B?c1V0QXZ1RG1FMDg5OCtCaUFkcCtrcXZneWdZQnNFWUFVaFBIcU1iU04zZmNB?=
 =?utf-8?B?QVEzSU9IdXBUZldML1Z3NXo4TjJSUlU2SExCOFJYZUtuVnVyMnR1SzhMMkVu?=
 =?utf-8?B?NG43aHBwT05ubkpqK05WUi9XSWhYekI3M2FEZ0g1NmJCb09pN3pydUJwZnVi?=
 =?utf-8?B?TnYycDFLclQvUGd2Um0zbk9FaTd4dThKUzYxTVVkR0lobTZtS3ZvK0hnMkJz?=
 =?utf-8?B?eWluNGlJSjlRT1ZaejVheU5VUXErNDV6dUQ3V2tNTEdVczBUV3dKRkh1L3o2?=
 =?utf-8?B?Q1NRdzQxbldGZklRbE5RMDh3RkFGcERKVHUxQjV1Z01kT2VCVkhmaFVZQjd3?=
 =?utf-8?Q?mTeTzO8XogwNCeT3cDiPA02nOTS0FOcQjiLrnxKnuJbI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVZYZnpCWlJXSmJLL1BYZHlSUGtLVEp0MjNFNmxJQTA2OUZ2alJ4SUJLQVdR?=
 =?utf-8?B?YmMveklhR3VtRk14Nmd1VVZDWmtNQVJSNFdyVmZwb1NwbzRSL0oxZ2pFUXRJ?=
 =?utf-8?B?N2ZqQ0xycitRWDZqUW1yTkZhWjJXUWtkRWtaZXlEWFJ2MndsQWFqS1VsUU9V?=
 =?utf-8?B?VGNzN2ZBR1JhWnVWOFQ3U1gxdFNRc2hPbG8wY3dKMWpZVU54OUlzcUY0Z01l?=
 =?utf-8?B?Z0xtUWV1ZUNMN3NCd0hHUm9LRVh6c0xsNG5pd1p4a0RlL1ZPSW9zck0raVFH?=
 =?utf-8?B?Vm83WEszOWl5Uzlhc3k5OTNsRFRlaHZ3S0M4TXpJTXUwVHhiekJBRFpGMUVF?=
 =?utf-8?B?bE1uaEEzd1Z4aEsrUk02UTR2TEp4eE9qWERhWmMyMVEyakxSaG1xbkIxclRF?=
 =?utf-8?B?TmQ1WHpsV2pQNTQrb3JHdi9QS0h1b2FTMzJNejYxckVWMzBkMGhwUThMT0hN?=
 =?utf-8?B?TUEwTXY4cC9TMVhmTHFTSlFCL2p3MVVrcDQ3MDlkekVOYURZMW5iTExiZHhM?=
 =?utf-8?B?RmgxWCtnMkF1cURIQlNlSDNRUmRnNDFpaVcyK1FqSXdwYVovVzE1TXNlRVZp?=
 =?utf-8?B?YkxjenlNaVpMaXJsNmRsZ3VUZHBuQVJHaENSaHVGWG1IaU9IYVowcUlKZHIw?=
 =?utf-8?B?Yi91TzhxbEpJaTJuaDA1V2dTSjEzRlp0Z0tCdHVzczYrSTIwUHc3WmtBRkE4?=
 =?utf-8?B?SzBhMHZodm8yRjVzTUI4MlFkU1AwVWY5NXZOS2NTeTcyNGNFUjJWZUZ1NEUx?=
 =?utf-8?B?Rk1jUy9yM3VrUFNwVEx6Rk14UitlR2U4MXU0ajVjeUd6YWd3RzM2WXhVODFa?=
 =?utf-8?B?c2w1ck9DL2tpek8yejVnV1dvVHMvY1BGVDhiVXpwU2p3a2djd0FxT3R0cjBz?=
 =?utf-8?B?LzdRTDVkK25ydnZsL3FicFA0NytJSzdRVXZmRjdBbmlHcGkwSEF2blUxdjE1?=
 =?utf-8?B?WkJKSHZkczJNcnpwMXZtVk8wcGxzcWl5YzlYV2ZBWEtxTTVLblhBcHNvQzN4?=
 =?utf-8?B?aWQxalF0RzVFbGVjTEFEbGZsZFVjMVRXenZ3NHh4RE9LZ1NUVFludmxGM3pG?=
 =?utf-8?B?cUpEdkJaZTYzUEJUTFVyNkpzOG5MU1hEb2xwc2xkQVJzNDcxRXB0OE1RUFd0?=
 =?utf-8?B?bStLQ0c1WkVaUjhNQmFkemErbGRjYVUzR1c0bmN3Z0V2N0kxVmhoQWI1aHVF?=
 =?utf-8?B?cWVIOGI4QXpFWnYzaVl2NHBMOUJENzREWUlqUzdRanNjTGZ6R2xBSmV4YVF5?=
 =?utf-8?B?dVpGUEpzVThCeWliNXhFQlgvWjVGQzByQlJKQXcraEc5YkJoOHNVUDAvUE9H?=
 =?utf-8?B?ZnNhQnlQMXlwV2h2V2RGdUkySHVCeFIvK20yd2dMS2RiL1hzUFZiQzR1SSsw?=
 =?utf-8?B?S2VBNDMxMU9qdC9nZkY0Zy85d0g5bnNkbyt6eFVGVW9GTkd3bncvS1NUbFRP?=
 =?utf-8?B?QWdCTWVqRzlGanNwTGFHbHJOMWZScTJlcHQ5WmRHcDVQZlRwQWNrQVVYK1c0?=
 =?utf-8?B?bmZrNERxQkQ2QjM0V2g1YmtHNUZQcUk2dFhLRnUya1NDN01UdFhzTTVuZlFV?=
 =?utf-8?B?N1ZqN29QRTYxV0VSUVU0TldIcGZIOEliOU5veUFVbWJabkczcUo5aW5Oc0pW?=
 =?utf-8?B?aGZKMk44Z0w5bEtWbXphbWVDSGQrV2xQd0lhUFg5VkY4Q3IvYVJFakEyN3o1?=
 =?utf-8?B?TG8xcWVFeDlnUHVRSGU2R3FVSWdybUFEZm13WHIzSXpBT1gwMUVjVFRUZzlx?=
 =?utf-8?B?WHNxWW9NZE80MVE5TEFmUUF6bTh2blcrMFhER2ZROUJ4bWFBYnpWakRRRUpR?=
 =?utf-8?B?b0tqQU9OVlRsRElGRzRNMERNTnJlWm1SLzhpSUFWMzFDdEdZaThjekN1TS94?=
 =?utf-8?B?YXJUMm5vNEVjWGR6MlNiRjRFQjhZZzAzVGkzTlJJTHpCKzMzanBjL2tqWURx?=
 =?utf-8?B?dmdWNFpOczRhSlIwd3A5RjNUeWd4cDZQMmprWDY5RnBycUI4UUowNUkzMHhS?=
 =?utf-8?B?UzZlRVFsbThTdzg1bVQ3T3p3eE1hbHdwYUNuTENkdkZkZk1ySlVzUGtiNlpD?=
 =?utf-8?B?RmFtbHRFeDFOM1hMQll1STZmRU5qb05KYm5tOFlQMDBkNC9KeDRuT1hPYUpZ?=
 =?utf-8?B?a2dkSzBHcktWSURPc2VtNUROVHlQeWN6Q2VleGVobU53ZVF6RjJQR2p3VVBN?=
 =?utf-8?Q?ftnybiZhzsTctBoj6TcLObI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rAtyyHr5Up1FgznIPx9mxHui3Fyz63MSfalPcIF4WijIpQv2dnE03WjJRTAkbSrPJkFeldc3Krf3bEFUB96Vf4UFPDYUf5omJ26FvpG8pXIpa3spj5soGYxlYXCevWzcVFonft4P2ZfDecJZaqjv2EySdj5NzKDrB6dHDrHEkkrekEEhyVC5baCH1nbxApHAEpJt/SCI2I3pd2DIEjLpDxRtQyoxLSt+ctda01DN84swn4KnAPwna2hhpbAK2vNTltgrVxocEBcJ68n8WU23NcDq78AyBS1hNJMmuH7pNOBqbMA0ZlrJ9/7V0JeK07F0WnTJnmxCuz3XA6IQNlb0mJQXhOW4kBo0uOqX48bdZoYBPP7S5+gRaPZMK09zkXrtd8PjOVflJqU3dQrfT1OXqjmOgZ6V+pQtv6wjtj+FzSxK5rvkYztJU31O0Rr7fa5UdNHXubdWQG9Xg0n1tdrqDUunjhBg9bvfXx8HuSTBwQK0RYy1D3a764eo4txnr6jg0FS73uMgIB9tr6pK3I0VLoTFOJHq7s6nxkBTMpA6JzmW9C9CeOi4Fxzo9pVDAaUYvJhLKqKc1zQ6/LVHAe9JiELwvoeUXTu0xXzWElwYv34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c6263d-66f6-4247-824e-08dc6872308e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:31:23.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuhP8l9FNk2CmN1w6h5ZHKIbzVmRjbne9/ymM5GSctxrOyvH5zJTQzuOiSHo5W6fg6GF846rAdIbb4lyJ0o6Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290113
X-Proofpoint-GUID: YRETzzH8QuiDeh4YEqlhYdbXiPoXJGjB
X-Proofpoint-ORIG-GUID: YRETzzH8QuiDeh4YEqlhYdbXiPoXJGjB

On 29/04/2024 18:05, Andrii Nakryiko wrote:
> On Mon, Apr 29, 2024 at 8:25 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 27/04/2024 01:24, Andrii Nakryiko wrote:
>>> On Fri, Apr 26, 2024 at 3:56 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Wed, Apr 24, 2024 at 8:48 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> Split BPF Type Format (BTF) provides huge advantages in that kernel
>>>>> modules only have to provide type information for types that they do not
>>>>> share with the core kernel; for core kernel types, split BTF refers to
>>>>> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
>>>>> uses that structure (or a pointer to it) simply needs to refer to the
>>>>> core kernel type id, saving the need to define the structure and its many
>>>>> dependents.  This cuts down on duplication and makes BTF as compact
>>>>> as possible.
>>>>>
>>>>> However, there is a downside.  This scheme requires the references from
>>>>> split BTF to base BTF to be valid not just at encoding time, but at use
>>>>> time (when the module is loaded).  Even a small change in kernel types
>>>>> can perturb the type ids in core kernel BTF, and due to pahole's
>>>>> parallel processing of compilation units, even an unchanged kernel can
>>>>> have different type ids if BTF is re-generated.  So we have a robustness
>>>>> problem for split BTF for cases where a module is not always compiled at
>>>>> the same time as the kernel.  This problem is particularly acute for
>>>>> distros which generally want module builders to be able to compile a
>>>>> module for the lifetime of a Linux stable-based release, and have it
>>>>> continue to be valid over the lifetime of that release, even as changes
>>>>> in data structures (and hence BTF types) accrue.  Today it's not
>>>>> possible to generate BTF for modules that works beyond the initial
>>>>> kernel it is compiled against - kernel bugfixes etc invalidate the split
>>>>> BTF references to vmlinux BTF, and BTF is no longer usable for the
>>>>> module.
>>>>>
>>>>> The goal of this series is to provide options to provide additional
>>>>> context for cases like this.  That context comes in the form of
>>>>> distilled base BTF; it stands in for the base BTF, and contains
>>>>> information about the types referenced from split BTF, but not their
>>>>> full descriptions.  The modified split BTF will refer to type ids in
>>>>> this .BTF.base section, and when the kernel loads such modules it
>>>>> will use that base BTF to map references from split BTF to the
>>>>> current vmlinux BTF - a process of relocating split BTF with the
>>>>> currently-running kernel's vmlinux base BTF.
>>>>>
>>>>> A module builder - using this series along with the pahole changes -
>>>>> can then build a module with distilled base BTF via an out-of-tree
>>>>> module build, i.e.
>>>>>
>>>>> make -C . M=path/2/module
>>>>>
>>>>> The module will have a .BTF section (the split BTF) and a
>>>>> .BTF.base section.  The latter is small in size - distilled base
>>>>> BTF does not need full struct/union/enum information for named
>>>>> types for example.  For 2667 modules built with distilled base BTF,
>>>>> the average size observed was 1556 bytes (stddev 1563).
>>>>>
>>>>> Note that for the in-tree modules, this approach is not needed as
>>>>> split and base BTF in the case of in-tree modules are always built
>>>>> and re-built together.
>>>>>
>>>>> The series first focuses on generating split BTF with distilled base
>>>>> BTF, and provides btf__parse_opts() which allows specification
>>>>> of the section name from which to read BTF data, since we now have
>>>>> both .BTF and .BTF.base sections that can contain such data.
>>>>>
>>>>> Then we add support to resolve_btfids for generating the .BTF.ids
>>>>> section with reference to the .BTF.base section - this ensures the
>>>>> .BTF.ids match those used in the split/base BTF.
>>>>>
>>>>> Finally the series provides the mechanism for relocating split BTF with
>>>>> a new base; the distilled base BTF is used to map the references to base
>>>>> BTF in the split BTF to the new base.  For the kernel, this relocation
>>>>> process happens at module load time, and we relocate split BTF
>>>>> references to point at types in the current vmlinux BTF.  As part of
>>>>> this, .BTF.ids references need to be mapped also.
>>>>>
>>>>> So concretely, what happens is
>>>>>
>>>>> - we generate split BTF in the .BTF section of a module that refers to
>>>>>   types in the .BTF.base section as base types; these are not full
>>>>>   type descriptions but provide information about the base type.  So
>>>>>   a STRUCT sk_buff would be represented as a FWD struct sk_buff in
>>>>>   distilled base BTF for example.
>>>>> - when the module is loaded, the split BTF is relocated with vmlinux
>>>>>   BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buff
>>>>>   in vmlinux BTF and map all split BTF references to the distilled base
>>>>>   FWD sk_buff, replacing them with references to the vmlinux BTF
>>>>>   STRUCT sk_buff.
>>>>>
>>>>> Support is also added to bpftool to be able to display split BTF
>>>>> relative to its .BTF.base section, and also to display the relocated
>>>>> form via the "-R path_to_base_btf".
>>>>>
>>>>> A previous approach to this problem [1] utilized standalone BTF for such
>>>>> cases - where the BTF is not defined relative to base BTF so there is no
>>>>> relocation required.  The problem with that approach is that from
>>>>> the verifier perspective, some types are special, and having a custom
>>>>> representation of a core kernel type that did not necessarily match the
>>>>> current representation is not tenable.  So the approach taken here was
>>>>> to preserve the split BTF model while minimizing the representation of
>>>>> the context needed to relocate split and current vmlinux BTF.
>>>>>
>>>>> To generate distilled .BTF.base sections the associated dwarves
>>>>> patch (to be applied on the "next" branch there) is needed.
>>>>> Without it, things will still work but bpf_testmod will not be built
>>>>> with a .BTF.base section.
>>>>>
>>>>> Changes since RFC [2]:
>>>>>
>>>>> - updated terminology; we replace clunky "base reference" BTF with
>>>>>   distilling base BTF into a .BTF.base section. Similarly BTF
>>>>>   reconcilation becomes BTF relocation (Andrii, most patches)
>>>>> - add distilled base BTF by default for out-of-tree modules
>>>>>   (Alexei, patch 8)
>>>>> - distill algorithm updated to record size of embedded struct/union
>>>>>   by recording it as a 0-vlen STRUCT/UNION with size preserved
>>>>>   (Andrii, patch 2)
>>>>> - verify size match on relocation for such STRUCT/UNIONs (Andrii,
>>>>>   patch 9)
>>>>> - with embedded STRUCT/UNION recording size, we can have bpftool
>>>>>   dump a header representation using .BTF.base + .BTF sections
>>>>>   rather than special-casing and refusing to use "format c" for
>>>>>   that case (patch 5)
>>>>> - match enum with enum64 and vice versa (Andrii, patch 9)
>>>>> - ensure that resolve_btfids works with BTF without .BTF.base
>>>>>   section (patch 7)
>>>>> - update tests to cover embedded types, arrays and function
>>>>>   prototypes (patches 3, 12)
>>>>>
>>>>> One change not made yet is adding anonymous struct/unions that the split
>>>>> BTF references in base BTF to the module instead of adding them to the
>>>>> .BTF.base section.  That would involve having to maintain two pipes for
>>>>> writing BTF, one for the .BTF.base and one for the split BTF.  It would
>>>>> be possible, but there are I think some edge cases that might make it
>>>>> tricky.  For example consider a split BTF reference to a base BTF
>>>>> ARRAY which in turn referenced an anonymous STRUCT as type.  In such a
>>>>> case, it wouldn't make sense to have the array in the .BTF.base section
>>>>> while having the STRUCT in the module.  The general concern is that once
>>>>
>>>> Hm.. not really? ARRAY is a reference type (and anonymous at that), so
>>>> it would have to stay in module's BTF, no? I'll go read the patch
>>>> series again, but let me know if I'm missing something.
>>>>
>>
>> The way things currently work, we preserve all relationships prior to
>> distilling base BTF. That is, if a type was in split BTF prior to
>> calling btf__distill_base(), it will stay in split BTF afterwards. Ditto
>> for base types. This is true for reference types as well as named types.
>> So in the case of the above array for example, prior to distilling types
>> it is in base BTF. If it in turn then referred to a base anonymous
>> struct, both would be in the base and thus the distilled base BTF. In
>> the above case, I was suggesting the array itself was referred to from
>> split BTF, but not in split BTF, sorry if that wasn't clearer.
>>
>> So the problem comes if we moved the anon struct to the module; then we
>> also need to move types that depend on it there. This means we'd need to
>> make the move recursive. That seems doable; the only question is around
> 
> Yep, it should be very doable. We just mark everything used from
> "to-be-moved-to-new-split-BTF" types recursively, unless it's
> "qualified named type", where we stop. You have a pass to mark
> embedded types, here it might be another pass to mark
> "used-by-split-BTF-types-but-not-distillable" types.
> 
>> the logistics and the effects of doing so. At one extreme we might end
>> up with something that resembles standalone BTF (many/most types in the
> 
> My hypothesis is that it is very unlikely that there will be a lot of
> types that have to be copied into split BTF.
> 
>> split BTF). That seems unlikely in most cases. I examined one module's
>> BTF base for example, and the only anon structs arose from typedef
>> references possible_net_t, sockptr_t, rwlock_t and atomic_t. These in
>> turn were only referenced once elsewhere in distilled base BTF; a
>> sockptr was in a FUNC_PROTO, but aside from that the typedefs were not
>> otherwise referenced in distilled base BTF, they were referenced in
>> split BTF as embeeded struct field types.
>>
>> So moving all of this to the split BTF seems possible; what I think we
>> probably need to think on a bit is how to handle relocation.  Is there a
>> need to relocate these module types too, or can we live with having
>> duplicate atomic_t/sockptr_t typedefs in the module? Currently
>> relocation is simplified by the fact that we only need to relocate the
>> types prior to the module's start id. All we need to do is rewrite type
>> references in split BTF to base ids. If we were relocating split types
>> too we'd need to remove them from split BTF.
> 
> I think anything that is not in distilled base should not be
> relocated, so current simplicity is remapping distilled BTF IDs will
> remain. It's ok to have clones/copies of some simple typedefs,
> probably.
> 
> We have a few somewhat competing goals here and we need to make a
> tradeoff between them:
> 
>   a) minimizing split BTF size (or rather not making it too large)
>   b) making sure PTR_TO_BTF_ID types work (so module kfuncs can accept
> task_struct and others)
>   c) keeping relocation simple, fast, and reliable/unambiguous
> 
> By copying anonymous types we potentially hurt a) (but presumably not
> a lot to worry about), and we significantly improve c) by making
> relocation simple/fast/reliably (to the extent possible with "by name"
> lookups). And we (presumably) don't change b), it still works for all
> existing and future cases.
>

Yeah, case b) is the only lingering concern I have, but in practice it
seems unlikely to arise. One point of clarification - we've discussed so
far mostly anonymous STRUCTs and UNIONs; do you think there are other
anonymous types we should consider, ARRAYs for example?
> If we ever need to pass anonymous typedef'ed types to kfunc, we'll
> need to think how to represent them in distilled base BTF. But it most
> probably won't be TYPEDEF -> STRUCT chain, but rather empty STRUCT
> with the name of original TYPEDEF + some bit to specify that we are
> looking for a TYPEDEF in real base BTF; I think we have a pass forward
> here, and that's the main thing, but I don't think it's a problem
> worth solving now (or ever).
> 
> WDYT?

Agreed. I think (hope) it's unlikely to arise.

> 
>>
>>>>> we move a type to the module we would need to also ensure any base types
>>>>> that refer to it move there too.  For now it is I think simpler to
>>>>> retain the existing split/base type classifications.
>>>>
>>>> We would have to finalize this part before landing, as it has big
>>>> implications on the relocation process.
>>>
>>> Ran out of time, sorry, will continue on Monday. But please consider,
>>> meanwhile, what I mentioned about only having named
>>> structs/unions/enums in distilled base BTF.
>>>
>>
>> Sure, I'll dig into it further. FWIW I agree with the goal of moving
>> anonymous structs/unions if it's doable. I can't see any blocking issues
>> thus far.
> 
> Yep, please give it a go, and I'll try to finish the review today, thanks.
> 
>>
>>>>
>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/
>>>>> [2] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/
>>>>>
>>>>>
>>>>>
>>>>> Alan Maguire (13):
>>>>>   libbpf: add support to btf__add_fwd() for ENUM64
>>>>>   libbpf: add btf__distill_base() creating split BTF with distilled base
>>>>>     BTF
>>>>>   selftests/bpf: test distilled base, split BTF generation
>>>>>   libbpf: add btf__parse_opts() API for flexible BTF parsing
>>>>>   bpftool: support displaying raw split BTF using base BTF section as
>>>>>     base
>>>>>   kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
>>>>>   resolve_btfids: use .BTF.base ELF section as base BTF if -B option is
>>>>>     used
>>>>>   kbuild, bpf: add module-specific pahole/resolve_btfids flags for
>>>>>     distilled base BTF
>>>>>   libbpf: split BTF relocation
>>>>>   module, bpf: store BTF base pointer in struct module
>>>>>   libbpf,bpf: share BTF relocate-related code with kernel
>>>>>   selftests/bpf: extend distilled BTF tests to cover BTF relocation
>>>>>   bpftool: support displaying relocated-with-base split BTF
>>>>>
>>>>>  include/linux/btf.h                           |  32 +
>>>>>  include/linux/module.h                        |   2 +
>>>>>  kernel/bpf/Makefile                           |   8 +
>>>>>  kernel/bpf/btf.c                              | 227 +++++--
>>>>>  kernel/module/main.c                          |   5 +-
>>>>>  scripts/Makefile.btf                          |  12 +-
>>>>>  scripts/Makefile.modfinal                     |   4 +-
>>>>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
>>>>>  tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
>>>>>  tools/bpf/bpftool/btf.c                       |  20 +-
>>>>>  tools/bpf/bpftool/main.c                      |  14 +-
>>>>>  tools/bpf/bpftool/main.h                      |   2 +
>>>>>  tools/bpf/resolve_btfids/main.c               |  22 +-
>>>>>  tools/lib/bpf/Build                           |   2 +-
>>>>>  tools/lib/bpf/btf.c                           | 561 +++++++++++-----
>>>>>  tools/lib/bpf/btf.h                           |  61 ++
>>>>>  tools/lib/bpf/btf_common.c                    | 146 ++++
>>>>>  tools/lib/bpf/btf_relocate.c                  | 630 ++++++++++++++++++
>>>>>  tools/lib/bpf/libbpf.map                      |   3 +
>>>>>  tools/lib/bpf/libbpf_internal.h               |   2 +
>>>>>  .../selftests/bpf/prog_tests/btf_distill.c    | 298 +++++++++
>>>>>  21 files changed, 1864 insertions(+), 209 deletions(-)
>>>>>  create mode 100644 tools/lib/bpf/btf_common.c
>>>>>  create mode 100644 tools/lib/bpf/btf_relocate.c
>>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c
>>>>>
>>>>> --
>>>>> 2.31.1
>>>>>
>>>

