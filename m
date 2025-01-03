Return-Path: <bpf+bounces-47846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00041A009DF
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9BF3A400B
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FFD1C6F59;
	Fri,  3 Jan 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdBoW32e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ak+z5Qtx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12BA47
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910642; cv=fail; b=J3i8uIwp15yjC8uUBEKIl1sP+4EWwR5PHulEAtzG5PNSAK2wIQSrCOahIxjHbZuLidcy2rqTGpFY/thzLk16yTAyCtD1XyLSdf2hTJkoGwzFML6ahy930FWdmVd3BfGzOQpxjwQkBLe/qWJfOrYlbgINDjgdl24B8U/3BhNNZeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910642; c=relaxed/simple;
	bh=HJPtCUGCPBMOaMnuPPgqdTmlXAiISavgUtZesfUjmiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=tysD81V5YOCq2xP1Q6LxldZFuwI0kJsi9Psuz/q9aJKUMJZs0UQn49Y1jxGSqdcXFyRZB/mMa7R7bwH4j9ywSHA9KhzLBD0UHKh7X+KKnjtRXOt0Ixkf4wuJFHhk8cQ8oW0N4XQO3KTxR3wRDwFlBh6Z4hJJ2s7ajj4zQJU52YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdBoW32e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ak+z5Qtx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Bfrcd023675;
	Fri, 3 Jan 2025 13:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EoR/fJRjlML7FlfKPaDpiNuawz2NMYB3G8hrdQkEdZQ=; b=
	DdBoW32eRm5oZF5QBmCwnJDjVpgd8CXgrg8OKM82pkK5xViCOAZZ4oy3Fkx69E9D
	jf+LV2MqfPHfKduXBEKwf076B/LkAXwSne+ySZYj7Dw3TK1fwjR0qYtFuz/RgoSN
	4DpUWszes6h5P9QKAJWYYO1zrw1fj+GxUq2Qrvk0T+Hue5GPAxeRAo1w1nAncefn
	MPL1v2NfbHjOT1iMj4mbTmRHGSa/7u+vHyQUDc/cIgDC9eJ4caZ2FEAJDpg7Ub3s
	WNvRy2R0OqjVq97uL1pIn+o99o4SOGgsipFIDcJZfJ1Jy2ULE/Eqo+1gS2ZLhlE0
	0Lz8xMVYVcCd3Z5XbBNeKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t84203wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 13:23:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503B4CVF011789;
	Fri, 3 Jan 2025 13:23:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9raab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 13:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkgGSio79NTWDtyIOZBNUFBsD/u15qfasaca9iis0MyyySmf7NNt8PW4GcXHDvyDuJLTH2WBS9dUG/D4AEVi54Lg+lml8xg/Uz+UbGcE5xTjtkNXarZTl2SROc3cG8xFM9qPhZ+Y6AhRIgtyAkTSdRINkKMHWItxkP0Pv3Z3MQXxUbjHgd5ZjY0J55hSsCPcsRKNBLeTliaZUOR9bU+vFWcoJ++VxXci2sDT7of79v7nqI3ldPFJu0N30LF02tBhnD1+LUIkz1PLOgkq3crUgRFtdoq5C0zmp60nj7NSfsdmfZLB/NwVMu7V8IGRfZs4KjuyVfcr15xqhwrCgEnisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoR/fJRjlML7FlfKPaDpiNuawz2NMYB3G8hrdQkEdZQ=;
 b=YdEnLqVLiO2fbmFKJxYJsg2Pjim1A+TY5SbFLTQQA1mHDBtDJ02zpyo4DOlxvLMnWKTZg69wpO9YaiDYNVLMoLFIFBb1a5ZK5qqbDUdrQxIGtpa8C5PlbR0HuKRXKBrxHcivzgUk6IxZ5L+TprhUPTv8+HJfAbEsmKLQ5kg2HVKij7+9f0LLVRuDZMYVVw22kPIPAOBkbKNI+yBE3joir2Iu8T06ys/9DDYLEayJ1hCbJ1TgLNPCi7kxrr7Zo0ORpLUUHpc9IHodg1lH4nIlnec3DKzq12J511TorpC/ZeEabNbyk/rDbwhj5QK1KCfZFBdjlzmsc4mklEauKAh+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoR/fJRjlML7FlfKPaDpiNuawz2NMYB3G8hrdQkEdZQ=;
 b=ak+z5QtxxY9aTiqAi1e26FJ5ZvyM0Y+7Qv58cA4E3ZPPmnR0JkTYVSg87a4ioGRMpSJN9otTHlnxAJYvCeqDCGiembVBSJ0WurBht5Q5NrEaDjO3XqPDbuAVJsQ1XbJGq0U2FiVTVWbNj2hn+uEhDHuFBF918ZcgSNXg+xYnK8Y=
Received: from PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Fri, 3 Jan
 2025 13:23:37 +0000
Received: from PH7PR10MB7804.namprd10.prod.outlook.com
 ([fe80::39a7:9bba:4b86:f389]) by PH7PR10MB7804.namprd10.prod.outlook.com
 ([fe80::39a7:9bba:4b86:f389%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 13:23:37 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "gcc@gcc.gnu.org"
 <gcc@gcc.gnu.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni
 <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <5fc0ff106733d93488e4dba03f23a9ab71444fb1.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 02 Jan 2025 16:42:50 -0800")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<87jzbdim3j.fsf@oracle.com>
	<HfONx8uvT8UvgKSa4GGd2dyrUNHSFTv6VHMDSeCw0849N7REwVvl5MGyyvEmVIIQRcQIEf_-fyr6TcLJodeWdczujiEqrUZKJzX3sfhrPwA=@pm.me>
	<877c7daxbi.fsf@oracle.com>
	<5fc0ff106733d93488e4dba03f23a9ab71444fb1.camel@gmail.com>
Date: Fri, 03 Jan 2025 14:23:33 +0100
Message-ID: <87ldvsuj3e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To PH7PR10MB7804.namprd10.prod.outlook.com
 (2603:10b6:510:2fe::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7804:EE_|BLAPR10MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d80f540-2304-4466-706a-08dd2bf9d470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdLVndBREtBN0tJOEpqZGZZczZrZWhCMENOTlZ3M3hLcDlHNkd2RGZhYW9w?=
 =?utf-8?B?a1MwR2xsMmh3bm5YSE5QWUlHSzZpREx3UlM1eFZ3cytnaWxKemd4TWhtV29y?=
 =?utf-8?B?SDNLM29FSmdlMS9RdzlEbjJpR3YxbUhHaGZEQXA4eU92YndFOWlmOHloaC9S?=
 =?utf-8?B?SjhWc21SVVJEbTlRT01pdS9nSWNiWVNBdDd5V2VMZGRwTmdDaVVRdzdsekdL?=
 =?utf-8?B?Z2l4cVBwRHZReU50bHRHQjIzUElLTnRVcTZ6UHUzbDV3N0tOelVjV1loZzBJ?=
 =?utf-8?B?djZvYTlUUGJOdXJ0ODlQalhhNEZqcUF1bVJ6cURidS8rNUdtdDg4MVl2OGto?=
 =?utf-8?B?Y2Y5VktIMTAvaTRXZCtoTVRCUngrVFB5cjhjbXh1bzl0aUZ4eDBCdzhyakJV?=
 =?utf-8?B?L205NnUzVnJZMGhGODRGYVljK1lJMlNFMjVSclAwK0FkSXpta0pWZ3phcktu?=
 =?utf-8?B?TFhFVW8wcWs4VWpRZE9BMmVkMUdBSC9DQVBHdHB6UER1OW90a2tKODRoTktj?=
 =?utf-8?B?M1RsVGVUNldTVmJDTmI2RVRCRGJpYmV3VmlqdllaM2piOUl0UWt1MlBsMjFT?=
 =?utf-8?B?cS94bXZtS3U0K2ZhVStkSm9YUUkzUGV0VzFRdWc0MEFjL2dqSGo4Z2FSYVpO?=
 =?utf-8?B?TlExWGdMOXgzVFFyQ29DYnpZdG1mZ3llaXh6eUl0bTJWZ2tONzdXSnhZWDAz?=
 =?utf-8?B?TkhEMnBRMEVUVHFGazV1eXcwWStMTE9ybHppVDllR0tQOGhYMThMWHY0QVRv?=
 =?utf-8?B?dUZscWNuQURuWmZNY3NlVEVwb1BXREc3M2RtcWJDbkE4L1BXTmNMQk9JQjRH?=
 =?utf-8?B?eUVHWWxGNGdnSkx5MDJtQkNVcUx0K0hiRXVQNSt3Y1crZnh6TGhTSEtuWkQ2?=
 =?utf-8?B?b2ZhK1pUdnBnUGR0VDVydUVpTHpNMVhoMUJqMGtJeHRpaDg4T3FxMkRnVW5l?=
 =?utf-8?B?dG1RZWJqYWFCZVB1bklGeDJGdjdqWldJZ0VUR25pNS9iOEpaWWIzTVNrYStw?=
 =?utf-8?B?NXRxMkxMV2RCT3RWSXo4cFFBK0xyY1FPamFKK25oclNWemdMbThVU1RhNXZy?=
 =?utf-8?B?bjB0S3pEU3RHWWJlUkloNVVXY2VNWGI2dnlvMk5sdUtVR3pobDk1L1FsR3dk?=
 =?utf-8?B?Wjd0VCtGaWovRlJMNlN6cDBDcEtPdENzekN5VXk0WHdwSzhLUnU5WHRhNWxi?=
 =?utf-8?B?dC9QbHF0b0lLb2VKelVPaXZnNzFpYzBLajBUSWRaYU5SS0Z6ZWVzQ0hVSXZP?=
 =?utf-8?B?SjFUM3ZsckJvSWtSQUpOUW8zUmpqZXBEdktwT3ZrZWwrWVJzSzVOTktaTjlX?=
 =?utf-8?B?Z052dkh3b01aTjdXckthazdpb2t0NHhJaHBBZ2w4TjA0ZmtjL3BMZFFUN2Zm?=
 =?utf-8?B?SWtMQnl5ZUs0bHZzZDl3c2NvbEJjTmZCeFNlMVowa1YrZW9ZZjhSdVlQdFJz?=
 =?utf-8?B?emJGMTJkVThTSU0xRjREaFRKbmFZNndjeldDLzBMVHlzdVNpRUpTTlQ3bStv?=
 =?utf-8?B?ZStzbDBKVmkrVlk0UlhQcnBRZkVGVjZyU2xTcDlLU25CUkl2TWRMMkFkN2tn?=
 =?utf-8?B?dDkySlI4OUhtakY5N2RUTk92RVRjN2NQT3ZzVHYyM0g5YVdmZ1RrMVAwUkxx?=
 =?utf-8?B?cVMwZXhFeEJYWWU5T2hFVlpKSXV4SEYrNWlZN1hSOTdHOFhCejBGNzJRTkR4?=
 =?utf-8?B?SHNZNWZIWjF4ME5HWjBDSHZIUytZWno3YWtsWmh3V2ZYRGtEZlArVDNjS1Zz?=
 =?utf-8?B?K25IOHZLaDAxOHVaSnZtUDYxQ2NwN2xtOEt4akxlZzN4VVh3bmZZSzRFU1Zn?=
 =?utf-8?B?V0tmUURHOTYvRXU1RGtUQnNWbVVpY3VhVTI0RVpEdnhQc2ZvZjNBekc4bmNk?=
 =?utf-8?Q?XBEWFYHBJWm7p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7804.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhHMDJxbjJRTllYNG4rZHdVSUNDYlZzWnUwTWc1VlpNdVI3Mm52am5NQWt3?=
 =?utf-8?B?ZXcwOExOR2xCelFEbjFySURSMENLcklJWTVNTHY5VGpNVERZRFhidjNEc0FJ?=
 =?utf-8?B?Qi9IUi9ieTI1cUhxTjQ1MGVoTmlNY3krMjhWc2Fac3Nyc0hxUFRNdGRkbGxy?=
 =?utf-8?B?bXkyTWxFNStOSFB5NElyN0N2R2V5b1hkY3VIZ3djM1cxL0pHd1huaU0rTmtz?=
 =?utf-8?B?YjNSZVQycllhaVNveXFQOVlDWm1vQzU2NVBPdE1HVDdxbnQzZFZjaDREK0g5?=
 =?utf-8?B?dHNJWUZHWkdXakdnck0xUnBTc1Bwd3hJN2dzMjF4Sm13dW9rSUJmQ2F3YnBC?=
 =?utf-8?B?MEN1NEdybVdpRmtGb2FMR0hndGNnRDcvN3hPV3lNWndxbWxNSzBET21OemFH?=
 =?utf-8?B?MHoxczJCSmo2Y244YXFGTTdBWjJJeSs1Z3psbEZ0SjUxazMyZmx5eFl5QlRG?=
 =?utf-8?B?dWZzRUk4Qy82Mlp5L203N1pyMWFqSFg2aHhWSWp1TnhmcWdVVXc4MmtlaXpC?=
 =?utf-8?B?Ynk4bFNuU3N5VDloR3kvK1Byd0lJTGZaeTEyQ2Jzbk92SkcrMUlDc1JsV3du?=
 =?utf-8?B?cnN6REUwVU5zRGVxcDlDVFpvZG9wcUFRYy80dittVkVPdGhuejZuNXMvbTdw?=
 =?utf-8?B?b0VSOEU4SEhyZ2hyaHFGM0hvUzVJUlJPdTZRRTN4anpTVldMY1BLZUFRak1h?=
 =?utf-8?B?OEdtU3JrU0daM3ZMcDRYTDZkb28xN1BPU2RNWjI3Sm9DWlQrU1JRRlBhWUxx?=
 =?utf-8?B?L0NremNhcHRsaEFDYm9GY2RMcVN4VFQ0UDBmUGozOUk2ME9PNUptcVV5NVdL?=
 =?utf-8?B?QXdqM3l3RVdrZ2tsVmZRRTZoMXNxZ0xKeFJSRFpmbWtEV3VISWtPaSswdHls?=
 =?utf-8?B?eUQ1TEMzbWxnS0FCU1l6dFhEVGZNb0MzQUtOOWtoZzJqMklLb2FsLzArczVl?=
 =?utf-8?B?d0dhMEdJT2Vxd3NTSDdFckhIM21VOGVYa1RMeUc1RHNqSmpwZDBBUEJoOFpa?=
 =?utf-8?B?MzI1bENWZk4vdkNhSTFOK1Z5THVIZnh0c1dNMW5lRkJBZW9zZDA0OUI0NmhC?=
 =?utf-8?B?R0ZkZ2lFOG9ZSit6d1VsS3lTZGpoOWhWZjJuZFNjU0lpcENFUDVwcE92SUN4?=
 =?utf-8?B?anZybWlUSkZrU25aYTZqc2ZVa1djd3VTVHEzN1NzNFhHSnFCNW1YV1dPQTBJ?=
 =?utf-8?B?WTVMZUxwOUNSOFprU25lT1NlYVJlMERFcFN3THdiUXVYM1EzK0N6TEcrdFlC?=
 =?utf-8?B?dkdTVUQvWGVFRG40SitOK3lBUFNORENleS9oSVQzTy96S0hMR2Y3TjdSMlNF?=
 =?utf-8?B?VmZyazNFc21mTWxNNlo3Smg3TFdRVGZyV0V5Z0J1Y1BVbHJIK2hMREFwZjVo?=
 =?utf-8?B?QmZ2TTc3NTRnRk5GRlA1bHVvaUNzZjhZb1RCdk05R1J4L2tFUGpOWk9zQ1dv?=
 =?utf-8?B?Wlp0RTB5U3hOY1N3V0VobGlsNDJjZXhORmhCWmt5bHY4UEFSUFIvNENEc0M5?=
 =?utf-8?B?djBwWHBJSnpBTXR1RndCSGVqU09tbjQwK2Y3TCtxNmFJdlFwTC92OHF4TFZE?=
 =?utf-8?B?b1VXb3dsdVg3Slh6RzlMSjZhZmtzVXhjTzVCMU9vWUpBWVVScmMrWk55dnlt?=
 =?utf-8?B?U2h6NkNTMUNuV2ZaMjRRSVR1dm1sUEpId2FQMkMrMGtNZGtsdWdOK3F3SlJn?=
 =?utf-8?B?Mk5VME8rV01YT3gvVlROd1NqVXlIbVFoVUhKMmNDblErbkRkY3FyK29OMTI1?=
 =?utf-8?B?T2lVYVgzSklQNjdjTXdKeDVKZTJwQnh4bmV0eXNtY1JpRkVjYjJ3MmlIb0I3?=
 =?utf-8?B?a3RHREpmSkc4bmQ5SDJMeUFlUTVqeGJLS0w4TlU1NlVVL2hIbWtjNGFiQmE4?=
 =?utf-8?B?NUZWMEtqTjZQaU9wcnBEaWpTbzFXSlF4b3IyeEgyTm9LVlpKT2dsZE51dUwr?=
 =?utf-8?B?eU95NzhBQ3VIYXBoMER4azMwNWY4WnRoVkZ5bHV3cGRnU2Q5b3htN1B6U0hT?=
 =?utf-8?B?MHREOCtPZThLTm5iRHlnVE9XREkrZGFvZDVXZWNLbEhiSWh0MGpUMFRzenBR?=
 =?utf-8?B?cHBHSmJ0am80RmthWUQvY0lySU5Lb2lVUHY4L2dNMUVGRFpNMzd0SGhVZ1pn?=
 =?utf-8?B?UTMrS2FtYUF3Mm1MNE1QMkExT2VjM1IwNS9YR1JPaHd3YStOQ3c1cDdZYmdS?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gMLC6Lv0ILZM13mz8GBxQ4n+33RO3U7HJ2gxwfLzMnkoNL9nnJmkV3qrC69xuvyJs3aa/OHftSVIWLrj7lWbKahmqJHQon7cPTVrdIpb8YCdRy0Q9L5kZ/IxmXuxyZ4gUXk+QMQLedUNKeNBrQI/gc/14qK2YJ7VYNYrqQsyZX3izfzE1mYFjkJ6X9xtfbvJb/3LFX1KH4TdODqdUZw4bVyCyz+NF0ylCeO0IPPLPRzvUFEcJnvFjxm4bu8oS8CslDCHriT/tdL3PbqJmh5w9nD2hMyo8FZQtPxRmAXcGGCBqLEPh6LQYJzWQbFq5FFdouZdo5C7x7dvUMpNWEiWwt7uOqZcXXe35greqrVJgJgpLbY10mt/JxsL53lhMpPyDAFc42oYJbQOHRhY2VC6rs5Qzfpi/wKFS+Yttfv3fwzAvioWdYzkbO+N9rab1JVZX0FDKgTjZcoHQWKYtICS/tBiykpVvBJmkeXstA927pbiHdYs/hozTOaw6dGz3wgEJzXXNpTIfRiz4EcSc7c3IWLsngptnb3nHCe50pdPBygRY1OF0aNln/nm+TkPauPWWSaaxPCRzCpD93cOwKB6faZL6lQQUPoSNUTmNGWi9OE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80f540-2304-4466-706a-08dd2bf9d470
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7804.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 13:23:36.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0OaB3alDeyP1A5UXtHYM/hkGlaSfBbCGcg8cOMcyDvWmufos60ewrUquZ4m3KwKQpaluWoAkqLYiD7nuQRfyXsr1HeJY07Vok1WAPomDxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030118
X-Proofpoint-ORIG-GUID: u_e51b-5soIXSupJhAmkxPukHdMuUdhy
X-Proofpoint-GUID: u_e51b-5soIXSupJhAmkxPukHdMuUdhy


> On Thu, 2025-01-02 at 19:24 +0100, Jose E. Marchesi wrote:
>
> [...]
>
>> IMO the BPP selftest (and BPF programs in general) must not include host
>> glibc headers at all, regardless of what BPF compiler is used.  The
>> glibc headers installed in the host are tailored to some particular
>> architecture, be it x86_64 or whatever, not necessarily compatible with
>> what the compilers assume for the BPF target.
>>
>> This particular case shows the problem well: all the glibc headers
>> included by that BPF selftest assume that `long' is 32 bits, not 64
>> bits, because x86_64 is not defined.  This conflicts with both clang's
>> and GCC's assumption that in BPF a `long' is 64 bits.  This may or may
>> not be a problem, depending on whether the BPF program uses the stuff
>> defined in the headers and how it uses it.  Had you be using an arm or
>> sparc host instead of x86_64, you may be including macros and stuff that
>> assume chars are unsigned.  But chars are signed in bpf.
>
> This makes sense, but might cause some friction.
> The following glibc headers are included directly from selftests:
> - errno.h
> - features.h
> - inttypes.h
> - limits.h
> - netinet/in.h
> - netinet/udp.h
> - sched.h
> - stdint.h
> - stdlib.h
> - string.h
> - sys/socket.h
> - sys/types.h
> - time.h
> - unistd.h
>
> However, removing includes for these headers does not help the test in
> question, because some linux UAPI headers include libc headers when expor=
ted:
>
>     In file included from /usr/include/netinet/udp.h:51,
>                      from progs/test_cls_redirect_dynptr.c:20:
>     /home/eddy/work/tmp/gccbpf/lib/gcc/bpf-unknown-none/15.0.0/include/st=
dint.h:43:24: error: conflicting types for =E2=80=98int64_t=E2=80=99; have =
=E2=80=98long int=E2=80=99
>        43 | typedef __INT64_TYPE__ int64_t;
>           |                        ^~~~~~~
>     In file included from /usr/include/sys/types.h:155,
>                      from /usr/include/bits/socket.h:29,
>                      from /usr/include/sys/socket.h:33,
>                      from /usr/include/linux/if.h:28,
>                      from /usr/include/linux/icmp.h:23,
>                      from progs/test_cls_redirect_dynptr.c:12:
>     /usr/include/bits/stdint-intn.h:27:19: note: previous declaration of =
=E2=80=98int64_t=E2=80=99 with type =E2=80=98int64_t=E2=80=99 {aka =E2=80=
=98long long int=E2=80=99}
>        27 | typedef __int64_t int64_t;
>           |                   ^~~~~~~
>
> On my system (Fedora 41) the linux/{icmp,if}.h UAPI headers are
> provided by kernel-headers package, sys/socket.h is provided by
> glibc-devel package.
>
> The UAPI headers have two modes depending whether __KERNEL__ is
> defined. When used during kernel build the __KERNEL__ is defined and
> there are no outside references. When exported for packages like
> kernel-headers (via 'make headers' target) the __KERNEL__ is not
> defined and there are some references to libc includes
> (in fact, references to '#ifdef __KERNEL__' blocks are cut out during
>  headers export).
>
> E.g. here is a fragment of linux/if.h, when viewed from kernel source:
>
>     #ifndef _LINUX_IF_H
>     #define _LINUX_IF_H
>
>     #include <linux/libc-compat.h>          /* for compatibility with gli=
bc */
>     #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
>     #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
>     #include <linux/compiler.h>		/* for "__user" et al           */
>
>     #ifndef __KERNEL__
>     #include <sys/socket.h>			/* for struct sockaddr.		*/
>     #endif
>
> And here is the same fragment as part of the kernel-headers package
> (/usr/include/linux/if.h):
>
>     #ifndef _LINUX_IF_H
>     #define _LINUX_IF_H
>
>     #include <linux/libc-compat.h>          /* for compatibility with gli=
bc */
>     #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
>     #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
>     		/* for "__user" et al           */
>
>     #include <sys/socket.h>			/* for struct sockaddr.		*/
>
> As far as I understand, the idea right now is that BPF users can
> install the kernel-headers package (or its equivalent) and start
> hacking. If we declare that this is no longer a blessed way, people
> would need to switch to packages like kernel-devel that provide full
> set of kernel headers for use with dkms etc, e.g. for my system the
> if.h would be located here:
> /usr/src/kernels/6.12.6-200.fc41.x86_64/include/uapi/linux/if.h .
>
> To me this seems logical, however potentially such change might have
> implications for existing BPF code-base.


Aren't the kernel UAPI headers themselves architecture-specific, even if
__KERNEL__ is defined?  I see arch/**/include/uapi/asm/socket.h files in
the kernel tree for example.

I suppose a way to handle this would be to add BPF as an arch in glibc,
but at this point BPF objects are not really linked externally (despite
the linker supporting it) only "internally" at load time by bpftool, so
it would be a "headers only" port, and these headers could probably be
more easily provided by BPF "hosts" like the kernel.  Now I am wondering
whether NaCL, the precursor of WebAssembly, which was used to be
supported in glibc, faced a similar situation and if so how it handled
it.  Will take a look.

