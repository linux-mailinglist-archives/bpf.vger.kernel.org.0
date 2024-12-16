Return-Path: <bpf+bounces-47069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FF9F3CC5
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91464166EB7
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA301D47A2;
	Mon, 16 Dec 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IOV7ajq0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mzxfhLk+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B41B9831;
	Mon, 16 Dec 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384536; cv=fail; b=red8N2CcRx8L9bOAPW3XDgZM4UwSoiOWfzytt0Bzu/yjZAssrctgdN+nJPvQHj6XfpJd3TZKAgMvef9rE3M7X95ZTidHHfYL5Rq3lTLk7kYa79zji4wmFAIYGBXZUpxanE+0Rk/FYIxV80UoLynGHJuHsdbYIK6Xh33NB491TJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384536; c=relaxed/simple;
	bh=c2FfZQbaXwonitHYQnteEHwVZPDRSdlDX2VqMYvYYYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=FztCawPWUNOdHtQ3XtcwOeAK5iykLSehhEhokMmiBONhViZVBj0JkWReJso/9hs/Z39gaNxrsxUUfYL9pdxsxx++b8em5VDW0l/PHVi0vfqpFU5dULGzFHRbLbFzP88JBg5MCP0hajgmVC9sKjRCQJhkZ3RqWCrnSOd6Ki0H9+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IOV7ajq0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mzxfhLk+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGLS8HO022011;
	Mon, 16 Dec 2024 21:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d2/OYSPPgRaMwqoge7cSfb0h5PNE9/nX416bxVSg9wk=; b=
	IOV7ajq0YO7P6r32djJeNpsZG4+1acUvDwoHUhB1fPNS2PSEuWDvuBPVoUdTKVkk
	BqsmWlD2o1JQge3DxeCLXDQRKlaJPXklCQMRFzLv89aFbhDXppeupfTADL7ff85P
	iEt8kYlK/XMqaCb2c6I+GjZOhQASp8+OKdMuxTyYvluNKKZR+gAbxqT5mhMS8i3d
	ZqrV6BY2E1tN9gTw50ZHcDkfX8oxTd+oYeAFV9pLEaTrP3dpYgzPyEk3yd28T+xZ
	am9FKpl2ZGOnyj5vROVdOkVWwcH+PACKRrLnr9QIPcrlUJrBvAC7U8+z1ctGTsTe
	Szpqkd8hZKHDY2fhn0WSBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m04hjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 21:28:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGKUqfm032637;
	Mon, 16 Dec 2024 21:28:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdv320-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 21:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah0M2zXNXMN5oelVh68vtxnBmV5yJaWwbwjfmKsxurzzNEp5cKLMQPgt8UcKNorn2xlIvgALokohzO6d0AORO2xg3270dt+kl8zR2PC1IWNTmFQUCfKI9LbSkFPy8ZU50fKFf8jFdajR5UGgbScTTq5+OE4o62vYZHErass/FrjHuJC0E+IC88Q00VXOpjyNGc6upkNEFZlzYj5lG7lypCn76HbnjLH0V43Qkj3BaY05hL0xaL8KdWg5RhR9yDKwQS8ghhUN7KpjECcoJDXvtGPGFupvXQTsp1LXXPG+dR39qEojFIDJtdxzoOYJQvsWbH5vJzchYMm1KQbm2fC7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2/OYSPPgRaMwqoge7cSfb0h5PNE9/nX416bxVSg9wk=;
 b=Heq+zQLqPrp5aqiGP/YYIP7cFex/nwe26BzmAgfxL20s3EUUCr7QkcJ+1G8gNpW+1nApmPFWwAx3SnxaHPas2oX7r1xHgYFB1dbjfWJ6V8pV+Tm05f8Gu5EWnU1OX/PY6Jkf2S14jddw8jB9yGPwRORCFiSgXLgf0jieCHqF8Zd8cZ9LMxPt1CJRK43U3hjSgyyb5y+NC+/doXXNU4dlpSHiGtAUcl/2Gq3mrmWzTKnLVOAIX6uI379VqpjJZo4xKePm5F/rWbwUxZeB2FoNnIOokjGAsBcKNepe3aeGFDR/24/gVquDGaoXHRWjHf9yaucCp/zbFtOnof6S2l1bTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2/OYSPPgRaMwqoge7cSfb0h5PNE9/nX416bxVSg9wk=;
 b=mzxfhLk+1fpp++I+s+GXOMah0mj7zg9z8k+l6c9NfUxNY340gulIytZQ7eDRw5q8UlTBEWkgwZyKGSOvK35UXk1btBdxTMUoNqgwqD9vsWBBKoe4oHxIsyVNhPxvZgj9pAUJ2G58aCboCfV04SpCprvX8kBF3shDKvFiqYZEEX8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 21:28:48 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 21:28:47 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Cong Wang
 <xiyou.wangcong@gmail.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, bpf@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@collabora.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
In-Reply-To: <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
 <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
 <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
Date: Mon, 16 Dec 2024 13:28:45 -0800
Message-ID: <87wmfzmi5u.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:408:ed::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA0PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 803f45b4-ed96-47fc-7d2c-08dd1e18a042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFubzhMakNrcjRDSWxqeEgySDAvbHRuN1U2WUxKQUpRbHZyaGFWWWJZaVRa?=
 =?utf-8?B?WElpamVpOXkvNC8wSVJIVzY1elZNcEhTRUoyLytKWjlVZHRrMW5ZQ3d3dy9x?=
 =?utf-8?B?cWNNeFdKZTRpb3J2aHc5WkxDYlFkaTZBUGtNNVA5NjJPc2V5T2srVDYvMVdL?=
 =?utf-8?B?UlM3azdRVEpMamdTT25DL0piYmNDc1hNYmQzYTNwRkRPOS91RHRmMUZ0bFJH?=
 =?utf-8?B?eko0UWIyWGdFbnlLaDhUZ2Evenp5OWlnSkVHNWlJQjVHVElRUUI4cVUvcWhV?=
 =?utf-8?B?NVRLdkJQNEorakpVbCs5NFkxbEFEMVpUb0RySjZVNGY2OGY1cVYyWWN5VGRJ?=
 =?utf-8?B?TS8zNENocVhhYXRLc04rT1preGpDck9iOUVobWo1RUFOZUlPQ2lUM2oweDlk?=
 =?utf-8?B?RHZrVHhGeVVubjQwZjdmVTJhc3VkZnQyaDk2VzdXK0ZkSndrQ2tybC9zZUUw?=
 =?utf-8?B?T1lmSnFLMFBJSHBBajFYQjErSGJKSzFwWm42Q1N2RmxjRXNScXk5T1h2ckpm?=
 =?utf-8?B?TCt1MFZMcGlUelZkb2VuU000aUtZb29IQ0FEZmpjTkd6QzJCY1ZoaitOc2Jr?=
 =?utf-8?B?ZjFMSFFOTUF0R1ZrcGFyUSs4dTRVamJvUUt1dWFNTHFvMTQwTTNQdHpIOFU2?=
 =?utf-8?B?QTVzcms0UHhLWmU3VzlGRFREcEFiTDZqQVpaZ0VzV3h5OVUvOHhEZng1MVky?=
 =?utf-8?B?c0JQZ0cwdCtXMWlOM1JYcWh1VXJreVJWMmtVeE9xdGhNRndjeUZFZE5hdHFZ?=
 =?utf-8?B?UDZwU2c4d25NT3BMUFpSdmxTbUJobzUxRm1oMkFVamwycVI0VmxtUzNCNVR2?=
 =?utf-8?B?L21mZVBtY2hDbVJ3cnlhREErNGV5cFAwWUFUV1ZOMk1KdVAyazc5OHNFcXI5?=
 =?utf-8?B?RGxoSzR6akxaTVdCWWpPQ1c1WTljY25nRTh6R0dYZHVocHVGZEhGLzYvV0o3?=
 =?utf-8?B?TzZ1WTgwR0VOd0RSMjdWeEIwcWFhYmdiZWxIKytvYUZqdnFZdFlrSG9RTG9I?=
 =?utf-8?B?ck52V0RPdmdjOCtZcmtjcG54VmhvWnl3REtqUWpISTN5VGsydlVoc1doVDB0?=
 =?utf-8?B?VVYrL09ucnBZSHF2OTZIODliQmRFY3B1bWZyS3lZc1pibk5UOW41NEVIUFFZ?=
 =?utf-8?B?UEZYYjA3U1dHbXZiaUJHdksrVzVYT1dNTU9KWWlGMmpoVXNZcVdpRERsbGF4?=
 =?utf-8?B?T1NCemVLbzc2QjRFMENjeGpGMXpMNHVJYjVrN0o2WGZZS25IcU13ZDJiNDZL?=
 =?utf-8?B?MGJQbktER0F6OVcyU2xxd3o0TVZJQnYzaFdOWlVTeVo2ZnBwTDdLL0k0cS9S?=
 =?utf-8?B?WkJBenhZZVZhS1czRTZjVU5ON1VYSFV1VDBkMitLdWVSTXVwTU9zdktqL0sr?=
 =?utf-8?B?MG0xTkdFTkRsV1dNQnkydEY2MkNZbnJmUDJtWXJvb0VLTjEya1MxWkZHNEFM?=
 =?utf-8?B?RHlVcEExUHNBQ1A4S1lOMFFCeSsrU2M3VlJaRCt1V1I1cy8reG50QzJPSHl6?=
 =?utf-8?B?QWZEcDBUZysvWlJTcmpLWnJyeG5LYUdRLzFyZVhJTVcvVlBTV2RRVVV3cVFL?=
 =?utf-8?B?SS9kS0NNY3BZcWxST0RSdmFUNG5JZ3JCbVZJU1BuZTg4WDJYYjNubVdWTzd3?=
 =?utf-8?B?bkFEZ1FJZzJ6WmwxT21YM2dkdlYrNmJpMm9VajBUZzdSdFAyc2wyeS84d2wx?=
 =?utf-8?B?MjBJNTFVbXpHZG9Ld2M5WTRiT0Z0bG5xTHYxNFFmT2Y4R3N6WTk3cGtqSXdK?=
 =?utf-8?B?Vnk1bmt4andEQXFDbE44VFdCNm16eGtNc3djK2FGcFl2RHRIWWFCWnBhNUhY?=
 =?utf-8?B?Ukx6VVJoWDRZa1FjNTF6TDFhSVRVWHAwSDJMWXJYcGxpR2FlOXRlMUY0b1cx?=
 =?utf-8?Q?j9MQqYZfbO8gx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3o2WVJMa0xYdzg0VlJNOHZ4WCswNUhybUt3VHpDM004TFQzMDVldDJUUnBS?=
 =?utf-8?B?UTY0NnlmY0tVTDdIaXR3dHNNOC9MTXcwUzQyNEVpaHZYQWlsc0tQNVRYTDNy?=
 =?utf-8?B?Tm9ZaDBQVThwN2RuOFBaeVFEZTBoN21pREtIbWJ1NEJ5SVRZNkVaN3F1WDBa?=
 =?utf-8?B?ZDY4Sk1wby9sQzZFaWRIMWN1Z3J2ZXhsZjFiMktlamV3Ty9TVHZaOXUxQ1Uz?=
 =?utf-8?B?VlVxLzlNc01BT1o1cnFHZVNQb2c5eGZMck5kQkRObXNGVHo0STdvT3U2WHpx?=
 =?utf-8?B?WEQ3S2w3VGwyVjgrNURCWGhJdHgrSkVWWmdtTE83VGcrOWpwVGhFOVVyRmRm?=
 =?utf-8?B?aTNwSDNhY0hPeHozcXNKbElkOWpzZ3J6ZHk3Skl5TFJVeWdIaGRObG5FRWlI?=
 =?utf-8?B?bVhrMU5EcE5sa2hXbDVaZk5Xb1FPR2hFbUgwVUN5b0hKdnlCT0VNNUh3OVV2?=
 =?utf-8?B?YjFpbHRsNjVEY2VlSnpKN3RLSnBpUW5IbG9MQ1p0dUplOHYxblYwZStmZE9J?=
 =?utf-8?B?ZkpFYnpoK0VKRThUL3dqcmVxNERWZTNiTEtUcFpBOU5XRDVTMVJFVVdPUFBU?=
 =?utf-8?B?K1ZvOUlHbTNxRVkxQ0Q2ekVHcjdQM0krVzA2cU1QSlRxTHBtNDdpZzdTWmVi?=
 =?utf-8?B?SVN5aUV1MHlGZ3haV2VmVlNZOFFEMnArUEpZeStkK2pKTlhwcC82em5WT0J4?=
 =?utf-8?B?OUY0KzhPcVNMYVE0NnBmek9pVmlTTE51QWRTUGtZQzU3ZjNvZW15L2hMRXY5?=
 =?utf-8?B?aHc1SXlSakNNSG1oWUNDMlZ0UnlXKzdTTkVubnF0TzdQYTY2WjJzd0pZem9o?=
 =?utf-8?B?aGtjOURUSXNVZkZoNEJaNFVzYWIzYlhPdzV1bGNKRHRYaDBOU3NtbzVZSTkz?=
 =?utf-8?B?YUdXTkM4amlxdXRLSzA2ODA5djNRNUg5OGdrZXJKMnhpcmNBK3pqNmt2TFk0?=
 =?utf-8?B?UmppY0xvYmZ5L3JWL3NuclUxNXg1SDRSRXFjYk1PS1dJbEp1bW9JRERrTVFs?=
 =?utf-8?B?R0pPSnJubTVPWjhQa1Frb3VLM0hJbjcwaS9LS0ZsQ0V1b1dqZTdFK0NwdWMw?=
 =?utf-8?B?MWJ1VEcyK2R3UDdSazhtMnJnQTFMbmxPQTJZV3JoeDlCMGdjajJOZlJzYlhW?=
 =?utf-8?B?UDdBWXpRRmFVcHBUWUg1U3poU2p2ZGhqNlNlWHJrWTNXZnV4Q3Z1SCtmTmFR?=
 =?utf-8?B?M0xlTUhDWjcweS9MQkhWRm80QlRNajVHTkdpSHBsM1YzQ3h3YnBNQ29LelFp?=
 =?utf-8?B?L3hZWjJ0NGFFQTRTN3RWd1hYZ2ZZRy9aRG9hSzZab0g5cUdvUEFDdjZyVlNp?=
 =?utf-8?B?djNFWUpzZmx5RXVKaTd2Mmw2dXZxWkhMREFqU1VIRkJrM25RU2ZRRXdIZ0Jh?=
 =?utf-8?B?dmtmbXRGNlJ3T2RoMXV3Z2R0MGZDMHpnVkdpTlB4MndQTmplL3NGelh0eTRy?=
 =?utf-8?B?WUdZVlkvSzU1VmhmSXNHTldDQTlRMnFHKzQ5SUFZZWJQTlY0R0lvTjZINksx?=
 =?utf-8?B?TlVMQUJjZWtaWlhsc283ZENabFlMaU01SDlCRThnQUtHT0paeWs1MXp5blFt?=
 =?utf-8?B?c1ZRZTdxaXl5M0g3bFFVV09taC82NXAwTU5CU1VoSVkvbkQxamxuQ1JnbFlG?=
 =?utf-8?B?cnFNTWVrSEtnRExvMVRiREFjTDk2V25CZFh4NElBODlpMVRnU25JR2tSR0hx?=
 =?utf-8?B?MEJCcGlDMjJVMVFKNVhwakJGQ3lnL2I4amo0Ykw5UWRDaVgwSnljUXowZFc5?=
 =?utf-8?B?NDRSVUY0c0dMYUdFR0FpN1E5R05JbEpoZFI4Y0tyMW1YS3Z6VHFWQzhVNFVX?=
 =?utf-8?B?THpDcUZxdEJpcExGVm9nMjJGS2d6bFljeWxIV3c3NnlYQjZjTDF6SkVMVDVy?=
 =?utf-8?B?cHFWb1ZwQS92NlhucFhPekp5dngxcnRxdkM3eStGTWFMWVFEanpxNVdLYm5t?=
 =?utf-8?B?d3g3OEtBM1V4N29JRTZxSjk0a2JBWVNmU2lpNDRMQVhoSEF5MkcyMjkwSVZ0?=
 =?utf-8?B?VVF6S1c5bDhRVldoZjdvMEZNN0lKaFFmMCt1UVdrai9sei9HaCt3WEtSYWdx?=
 =?utf-8?B?OFdtMVB0QjlQeTIrNnhHcllhT28rS3dMMVJ6bEY3a2NrOXNUb2pPYzJjSXFx?=
 =?utf-8?B?T3dLYnJSV1ZoUkpDUnVvWWQ2SjBiL1BoNFNudmttQXFtaEM1eEdhNHlKSDJK?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ctdXWId/WpVngWxXS3gYd7v75VfGhcltaxJHmcsFztaOqSk96At07xKd3GwVkc9X2jhGDLW4T6aYesteUobSHA1VhnTb+Ydl2G24yF5bE0lnKJwLfD1zoqKZ6cuHdC+nHZoXDe4+UKyhDBm8ccHw5AV/Yu9moEjMH6SYN8tqkqzrq5KMGIOZMO4YpeAbtDDZ1HYPOmEZw3/NzlOuds8dbbXsbYv7sSBfw12ZFqqQr1O31/oSMImcAT+5c+E2+jQQFZYAFKRU84QlY34/Fuptdl+CiTgPpnArL+mKw2Jr/sqVwMO5dTjpuLbz/5Ub7hTFcHMTM0IHgvAgWq80zr/Ox2UR/Xpx+6f5bDpQqznxw5wS7uj/w1KydDJY51SyeCvCZy5XR0qXxw6F2LDwdvemhQB5Hw6aO+L1K6bhAdnK07IQPcImKfrfoMxZY6NkD1TKZFpztmfxnFt4cP401E4CoVlseCAxMzOK4dvjP0l+QojQmeNivYjn2ZnkrrCehXf5+ywrVfNul/81JpY8T18dkUPffbLIlMLCrABbBMk+HLwvSdIcmEox/REuKd29JTGzrWhVQkBweI2T5tgH5cbeBoD7frAXXmy9hGyKue/8DRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803f45b4-ed96-47fc-7d2c-08dd1e18a042
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:28:47.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3xoiRzEeACpPfp03MVs7F3BWOezd4fEp1N+trGdlWQLcMz8JQHKv0B/pT952ORMRI9ZEaoCpIR8tJ9n+D0y+AU3/iWz31wlcMvDoUNOzKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_09,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160176
X-Proofpoint-GUID: dlBJZVpuELzKV61ep797x_E5AdcDNNIb
X-Proofpoint-ORIG-GUID: dlBJZVpuELzKV61ep797x_E5AdcDNNIb

Alan Maguire <alan.maguire@oracle.com> writes:
> On 14/12/2024 12:15, Alan Maguire wrote:
>> On 14/12/2024 04:41, Cong Wang wrote:
>>> On Thu, Dec 05, 2024 at 08:36:33AM +0100, Uros Bizjak wrote:
>>>> On Wed, Dec 4, 2024 at 4:52=E2=80=AFPM Laura Nao <laura.nao@collabora.=
com> wrote:
>>>>>
>>>>> On 11/15/24 18:17, Laura Nao wrote:
>>>>>> I managed to reproduce the issue locally and I've uploaded the vmlin=
ux[1]
>>>>>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of=
 the
>>>>>> modules[3] and its btf data[4] extracted with:
>>>>>>
>>>>>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kb=
d_led_backlight.ko.raw
>>>>>>
>>>>>> Looking again at the logs[5], I've noticed the following is reported=
:
>>>>>>
>>>>>> [    0.415885] BPF:    type_id=3D115803 offset=3D177920 size=3D1152
>>>>>> [    0.416029] BPF:
>>>>>> [    0.416083] BPF: Invalid offset
>>>>>> [    0.416165] BPF:
>>>>>>
>>>>>> There are two different definitions of rcu_data in '.data..percpu', =
one
>>>>>> is a struct and the other is an integer:
>>>>>>
>>>>>> type_id=3D115801 offset=3D177920 size=3D1152 (VAR 'rcu_data')
>>>>>> type_id=3D115803 offset=3D177920 size=3D1152 (VAR 'rcu_data')
>>>>>>
>>>>>> [115801] VAR 'rcu_data' type_id=3D115572, linkage=3Dstatic
>>>>>> [115803] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
>>>>>>
>>>>>> [115572] STRUCT 'rcu_data' size=3D1152 vlen=3D69
>>>>>> [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 en=
coding=3D(none)
>>>>>>
>>>>>> I assume that's not expected, correct?
>>>>>>
>>>>>> I'll dig a bit deeper and report back if I can find anything else.
>>>>>
>>>>> I ran a bisection, and it appears the culprit commit is:
>>>>> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
>>>>>
>>>>> Hi Uros, do you have any suggestions or insights on resolving this is=
sue?
>>>>
>>>> There is a stray ";" at the end of the #define, perhaps this makes a d=
ifference:
>>>>
>>>> +#define PERCPU_PTR(__p) \
>>>> + (typeof(*(__p)) __force __kernel *)(__p);
>>>> +
>>>>
>>>> and SHIFT_PERCPU_PTR macro now expands to:
>>>>
>>>> RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))
>>>>
>>>> A follow-up patch in the series changes PERCPU_PTR macro to:
>>>>
>>>> #define PERCPU_PTR(__p) \
>>>> ({ \
>>>> unsigned long __pcpu_ptr =3D (__force unsigned long)(__p); \
>>>> (typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
>>>> })
>>>>
>>>> so this should again correctly cast the value.
>>>
>>> Hm, I saw a similar bug but with pahole 1.28. My kernel complains about
>>> BTF invalid offset:
>>>
>>> [    7.785788] BPF: 	 type_id=3D2394 offset=3D0 size=3D1
>>> [    7.786411] BPF:
>>> [    7.786703] BPF: Invalid offset
>>> [    7.787119] BPF:
>>>
>>> Dumping the vmlinux (there is no module invovled), I saw it is related =
to
>>> percpu pointer too:
>>>
>>> [2394] VAR '__pcpu_unique_cpu_hw_events' type_id=3D2, linkage=3Dglobal
>>> ...
>>> [163643] DATASEC '.data..percpu' size=3D2123280 vlen=3D808
>>>         type_id=3D2393 offset=3D0 size=3D1 (VAR '__pcpu_scope_cpu_hw_ev=
ents')
>>>         type_id=3D2394 offset=3D0 size=3D1 (VAR '__pcpu_unique_cpu_hw_e=
vents')
>>> ...
>>>
>>> I compiled and installed the latest pahole from its git repo:
>>>
>>> $ pahole --version
>>> v1.28
>>>
>>> Thanks.
>>=20
>> Thanks for the report! Looking at percpu-defs.h it looks like the
>> existence of such variables requires either
>>=20
>> #if defined(ARCH_NEEDS_WEAK_PER_CPU) ||
>> defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
>>=20
>> ...
>>=20
>> #define DEFINE_PER_CPU_SECTION(type, name, sec)                         =
\
>>         __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    =
\
>>         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            =
\
>>         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   =
\
>>         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 =
\
>>         __PCPU_ATTRS(sec) __weak __typeof__(type) name
>>=20
>>=20
>> I'm guessing your .config has CONFIG_DEBUG_FORCE_WEAK_PER_CPU, or are
>> you building on s390/alpha?
>>=20
>> I've reproduced this on bpf-next with CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3D=
y,
>> pahole v1.28 and gcc-12; I see ~900 __pcpu_ variables and get the same
>> BTF errors since multipe __pcpu_ vars share the offset 0.
>>=20
>> A simple workaround in dwarves - and I verified this resolved the issue
>> for me - would be
>>=20
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 3754884..4a1799a 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -2174,7 +2174,8 @@ static bool filter_variable_name(const char *name)
>>                 X("__UNIQUE_ID"),
>>                 X("__tpstrtab_"),
>>                 X("__exitcall_"),
>> -               X("__func_stack_frame_non_standard_")
>> +               X("__func_stack_frame_non_standard_"),
>> +               X("__pcpu_")
>>                 #undef X
>>         };
>>         int i;
>>=20
>> ...but I'd like us to understand further why variables which were
>> supposed to be in a .discard section end up being encoded as there may
>> be other problems lurking here aside from this one. More soon hopefully.=
..
>>
>
>
> A bit more context here - variable encoding takes the address of the
> variable from DWARF to locate the associated ELF section. Because we
> insist on having a variable specification - with a location - this
> usually works fine. However the problem is that because these dummy
> __pcpu_ variables specify a .discard section, their addresses are 0, so
> we get for example:
>
>  <1><1e535>: Abbrev Number: 114 (DW_TAG_variable)
>     <1e536>   DW_AT_name        : (indirect string, offset: 0x5e97):
> __pcpu_unique_kstack_offset
>     <1e53a>   DW_AT_decl_file   : 1
>     <1e53b>   DW_AT_decl_line   : 823
>     <1e53d>   DW_AT_decl_column : 1
>     <1e53e>   DW_AT_type        : <0x57>
>     <1e542>   DW_AT_external    : 1
>     <1e542>   DW_AT_declaration : 1
>  <1><1e542>: Abbrev Number: 156 (DW_TAG_variable)
>     <1e544>   DW_AT_specification: <0x1e535>
>     <1e548>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
>
>
> You can see the same thing for a simple program like this:
>
> #include <stdio.h>
>
> #define SEC(name) __attribute__((section(name)))
>
> SEC("/DISCARD/") int d1;
> extern int d1;
> SEC("/DISCARD/") int d2;
> extern int d2;
>
> int main(int argc, char *argv[])
> {
> 	return 0;
> }
>
>
> If you compile it with -g, the DWARF shows that d1 and d2 both have
> address 0:
>
>  <1><72>: Abbrev Number: 5 (DW_TAG_variable)
>     <73>   DW_AT_name        : d1
>     <76>   DW_AT_decl_file   : 1
>     <77>   DW_AT_decl_line   : 5
>     <78>   DW_AT_decl_column : 22
>     <79>   DW_AT_type        : <0x57>
>     <7d>   DW_AT_external    : 1
>     <7d>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
>  <1><87>: Abbrev Number: 5 (DW_TAG_variable)
>     <88>   DW_AT_name        : d2
>     <8b>   DW_AT_decl_file   : 1
>     <8c>   DW_AT_decl_line   : 7
>     <8d>   DW_AT_decl_column : 22
>     <8e>   DW_AT_type        : <0x57>
>     <92>   DW_AT_external    : 1
>     <92>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
>
>
> So the reason this happens for dwarves v1.28 in particular is - as I
> understand it - we moved away from recording ELF section information for
> each variable and matching that with DWARF info, instead relying on the
> address to locate the associated ELF section. In cases like the above
> the address information unfortunately leads us astray.
>
> Seems like there's a few approaches we can take in fixing this:
>
> 1. designate "__pcpu_" prefix as a variable prefix to filter out. This
> resolves the immediate problem but is too narrowly focused IMO and we
> may end up playing whack-a-mole with other dummy variable prefixes.
> 2. resurrect ELF section variable information fully; i.e. record a list
> of variables per ELF section (or at least per ELF section we care
> about). If variable is not on the list for the ELF section, do not
> encode it.
> 3. midway between the two; for the 0 address case specifically, verify
> that the variable name really _is_ in the associated ELF section. No
> need to create a local ELF table variable representation, we could just
> walk the table in the case of the 0 addresses.
>
> Diff for approach 3 is as follows
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..21a0ab6 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
>         return false;
>  }
>
> +bool variable_in_sec(struct btf_encoder *encoder, const char *name,
> size_t shndx)
> +{
> +       uint32_t sym_sec_idx;
> +       uint32_t core_id;
> +       GElf_Sym sym;
> +
> +       elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym,
> sym_sec_idx) {
> +               const char *sym_name;
> +
> +               if (sym_sec_idx !=3D shndx || elf_sym__type(&sym) !=3D
> STT_OBJECT)
> +                       continue;
> +               sym_name =3D elf_sym__name(&sym, encoder->symtab);
> +               if (!sym_name)
> +                       continue;
> +               if (strcmp(name, sym_name) =3D=3D 0)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>         struct cu *cu =3D encoder->cu;
> @@ -2258,6 +2278,11 @@ static int
> btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>                 if (filter_variable_name(name))
>                         continue;
>
> +               /* A 0 address may be in a .discard section; ensure the
> +                * variable really is in this section by checking ELF
> symtab.
> +                */
> +               if (addr =3D=3D 0 && !variable_in_sec(encoder, name, shnd=
x))
> +                       continue;
>                 /* Check for invalid BTF names */
>                 if (!btf_name_valid(name)) {
>                         dump_invalid_symbol("Found invalid variable name
> when encoding btf",
>
>
> ...so slightly more complex than option 1, but a bit more general in its
> applicability to .discard section variables.
>
> For the pahole folks, what do we think? Which option (or indeed other
> ones I haven't thought of) makes sense for a fix for this? Thanks!

Hi Alan,

Thanks so much for the analysis. It strikes me that it would be very
nice if the compiler could somehow annotate DIEs that are discarded. But
maybe the discarding happens far enough along that the DWARF can't be
modified?

In any case, while we wish for better compilers, we need a solution now.
I think Option 3 is a really great compromise. Reading it in context
with the code, it makes intuitive sense and it works when we're
outputting just the percpu globals, or when we're outputting all
globals. And there's little risk of issues, given that up until 1.28,
we've been using the ELF name for all variables anyway, so we know that
there have always been ELF symbols for all the variables we care about.

Stephen

