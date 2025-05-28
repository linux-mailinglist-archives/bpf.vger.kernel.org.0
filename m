Return-Path: <bpf+bounces-59186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C303CAC6EB6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497F54A2CFD
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6F28DF1B;
	Wed, 28 May 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIsz4evc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2oQUCg5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30728B7E4;
	Wed, 28 May 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451902; cv=fail; b=c7wSJIyOChuvgAueHfWVNG74cL8wKu+LLKFvLXVc7X/abC8ILOINGfmWS0YZYt7QLLARpn7Qy2hCFp9BLZiLEhwFN5hfekyh729xx2AuDxcX9181sNaazsIwuFPYY0RNKDtWGiI/hvRzWJCR87/0C93R8UxOhvVhcAkH0CHXsKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451902; c=relaxed/simple;
	bh=WAW5AmaRDKT36Oj1UvUHMUHn9AChs9vMp/sZbb2wseM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uop9flZIKVBB3MYS78CKIU0NMDHcbHAICAMNKIWzjySmW8LzCVs0H+tv5rUyFuLsG8COa0VQWtkbW9mswDfQPcoVan35rN5Elkj+W3zcyj1Y4hlPh9r/o0fbhrZuRbaIFUFnNoBhu9IbTrizBvn2gvWpOfCigTYr2O90lPIM9IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIsz4evc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g2oQUCg5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq4Cv006747;
	Wed, 28 May 2025 17:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0ntwRTqb9wotVC5eATEFG+Te+t0Y1OZIRUY+rCHEcYo=; b=
	mIsz4evcXrN8SUg4F4wNzvVGYZ6MkhAx+nZ7mr7VPWxwnePEqGC4P3IoVGwdEjeD
	7lr1+lgEEhkLNPHUaDSaUb3dI6P8ZURjHA6EBvOsJOAd3gAArDmtTWyubaEJ1jap
	z1n54vJyNTxwbVJErXE8iWEezPgs862JGOyGvt1tpZM192XmNRQ4zVqsQz8UqbGo
	J+jPPBbx9BJJBjxpoWo3EtJedbDR3zwNBrHMCpfvg/ni9QLUmvDhfDsd3FELjavr
	+wgkhOjMe6tbmHngyqAWKgeqTbtc9beUoc2IDqHV/agMwGWD7P3UBnKSYqdwRfAS
	Iz7mititeZBqIg2klW4fyg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcjg83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 17:04:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFVmCi024391;
	Wed, 28 May 2025 17:04:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaxefb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 17:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWEuNDmkSq+isbxyqNP68KtBvJ7Eqr8MtBiOKfKZPTO+qaIwnYfYX5WJBE4cXmd6bDMp/+7YRuohA9zhEXMQ3GwoK7978gQOQrlYFh2zdu0zQ+5AfcKAk7MQa84b90fIVxoxIPhwrb6emxJTaMp71qVxwz0yIqrIjELhyfuI/CbjAjH9JWLhrc7C6Ulw6GVDNBO7368Y0eIHHRSrFz090n4TdT1NHDfnZZf5fIRm+7KKZEReXRzFqISar+yHwXt8aqG5rpp8RwjJsttCw5/lCVQjnBzDr53u8XQ+99AkzgEjujPfxCGFRgju0Ss8CGUmWARphvrYWw0b0me+T22Mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ntwRTqb9wotVC5eATEFG+Te+t0Y1OZIRUY+rCHEcYo=;
 b=Yz6VhK/ekuPzoDMrsCJ3Rwd4DDqjZ/cer5m0eZScbKNkXMRRLJQDpg9oV/6u3aJqeOeVbJ1vttN0+1Sg0eYrMDSRDtK1Esz0FjRkU3+bOxdKTGCBhwlRpm4ApKgZsNKclYne7sd695fd+tdTOraJUzT0TB9wgUdLUYdXFWlZsBn4Dp5gyCtKXO1GESfDQw0YTEhQvFFQ70r/7MAzpc2RvDB050YHAi6IIPYXtPoEdXYu9ou7ggIl8nYsgXd8mAxu1DUdeu+L/eNZF/Gz31qjixH7PRCKr/LnhNXeyOfH7ZiONNqvFzKRCc5TcbP75Z0XhvJWhvr5Qij6Obd7zQT7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ntwRTqb9wotVC5eATEFG+Te+t0Y1OZIRUY+rCHEcYo=;
 b=g2oQUCg50omhTWDwDPorkLZl53c7EkrvZ/8fLDqtYrstbEveXQNJBtwkyW2BbyVPdCfB8p4EykbfsALEfh2RrrDqDiIHGmg9FXoSX2U+P8dNyuHVMAzf2/P8j1dtssNV2C1OJ0F/e18ooP46pb+MjTaEVjyuCtYlOE6aYa14T7Y=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 17:04:29 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Wed, 28 May 2025
 17:04:28 +0000
Message-ID: <0a827263-7257-4ac6-89cf-d694c9d3ab65@oracle.com>
Date: Wed, 28 May 2025 22:34:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250527161904.75259-3-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0088.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: d94c3790-989e-4dea-0881-08dd9e09b4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alo3YWg3czlUZUk3anVnT1NjQ2J0Q3d6Z2crREdxT1FrekVuQ29OalRoaHVT?=
 =?utf-8?B?bVNpM2YvcjYwYWovVHdySUNFejVjV3JZY3JZYWRjSTNnTW92SEpTRTRhazlK?=
 =?utf-8?B?L29CaTFqQ2h5UE9ab3FyYzBDNlorcnVTOTV6Y2xSbzlCcHFYUC9oZUl4LytN?=
 =?utf-8?B?NkpIT2xOcXZJdDRLUzhnV2dyVnlQSVB3OU5lMlVrQ3FXS1lvT3VMKzVkKzVi?=
 =?utf-8?B?WHExYnp2eGVHYWFzcWlQZnBqb3BnbktKTktWSGVTeWRoMjY0UElPMUg1QTVP?=
 =?utf-8?B?dFpReXF3cm82bUd3UHFVMmc0b0ZnNlhpSElyNS9tQytqRFZKdi9BUWxJV2ti?=
 =?utf-8?B?Q0Jqb0FGWUNmdEFnazErTWZ6NFNRdXUvVTBYNkg0dHoxU25SQk9jaGV4N085?=
 =?utf-8?B?M0R5M3h4dC9PTW1IWGlVejJlM2NicTdDOWZ5VlhVS3BhcUJkek1nT2d4clJl?=
 =?utf-8?B?MEVWUVBDVDFQYUptNGtiOGprNlpaSjk1d3VKbnpqOStzbG0vSEdlRExDdlp1?=
 =?utf-8?B?K01ZYjhNNnNCK1Iwa3pTd2VrTUxuNjdwZElnRmtlcnNhSkJ1OVVRVXkvMWoz?=
 =?utf-8?B?ZFg2RWQwUUhEcjBybHJGWlFHcDBraW1INUVNcStWZ0I3NmRFUWVIUm9tU2lR?=
 =?utf-8?B?b1hmdU4zSXlZYURTMXh2a2tSdXliS2hDa0NuQmlUZHNlVW5HclA4aG55OVRG?=
 =?utf-8?B?Z3lRa1prU1lsRDN3WDgzMDdRbWR0S2ZoM2VvNjRMaHZWQkgrK1JVVkljZlB3?=
 =?utf-8?B?SnNaaHVzaC9LOWV0bkJweUxoa1JvQm80bnNSckpNRytEcFpFUW5OUnU0ZGR6?=
 =?utf-8?B?ejJRejljTS8xM1Q2b3Vxc2F1akpEdU1mRW1EdTVKTFF3Zi9YbjZtUEVrTEt5?=
 =?utf-8?B?QjJqUXRIT3FlT2N4ak9YVG8wL0ExUFpBOU1qUDNTRlcrQ1J4NC9Xb0pwYmtw?=
 =?utf-8?B?MFF6VVFORXVqb2FERExCUEVuM294TytJSm5QUFBPR2ZlcUEyZGZVZnlwaHls?=
 =?utf-8?B?djhsWjRrVFAzM01WOVJEcjdqbk0ybnl4VkpnWHpNTW85U0NER0xWcWE3S1pj?=
 =?utf-8?B?NlUycW55dGpjUk8xemF0OXVQY3VIam5oUmNyNVZlcTAvcFBTZy90Wmh5aWxN?=
 =?utf-8?B?NFM4a1lLNVlVMlpTdFc2Tis2cHNyTHAzVmFzdEVIVGEreFI4SmhsRUtIUklG?=
 =?utf-8?B?T3VNenEwR1BueW9qNXI3L1BRcFFwbW94QWJFUXg0eFB6WXlqOCtvdmdmNHhR?=
 =?utf-8?B?OU5LUzFVK1lrdEpQdm5hMEtINjlZaGhwM2hqTy9zRXhLVnBpZVIrMHE1QVNl?=
 =?utf-8?B?UUpEZE5BOVNTVUJGcGZSaXJxNldFZnFYQ2VjcmYxNnNnY3RLZy9Id0tTLytX?=
 =?utf-8?B?ckVvbWd3SU9MdnduWktWdkdDNHJqclUxUHpkM2ZZUTczS2ZoK2lYR3lHOUVp?=
 =?utf-8?B?TlhQYjZ5bS9HTkU3aE9yTlJhTk1OWDdGRlRsbm9WdHkxZURLQVNLOE9ZS0RO?=
 =?utf-8?B?Rm0yNDRBTmwzc0FOT3B5SHdOK2xjSFloT3I1eTAzT0o2NGlCTEJ0SmxSV3pp?=
 =?utf-8?B?aWRVbUNDTE5Kd2FyNXVIS0xsK1VkMDVwSzVMQnZQeUFKTXltYmNuZE9JK1B6?=
 =?utf-8?B?S3A5NENDVU42R09zVnhMckVJa1hKYUplYi9CYTI3SHNabmxzUTgrODFWSzZI?=
 =?utf-8?B?NkNoL1VTMkxvZGMraUhqWVlWaGlYQldUYUdtNUVaM3FOM29mR2o2dk91L3dk?=
 =?utf-8?B?OUtZZW0xS0dBeXNlYmhUSnFMc1VRcEhHaU80SnBZY1k5NnNzR2J5SVAxRmJC?=
 =?utf-8?B?VHFPV1h2akNyS1hHYmJDZVVDYWM2bndkZ3JQaFBtYlBpTFVRMExkNTBRVm52?=
 =?utf-8?B?MHZCR3JvV0ROVmR6dElUa201eDR5SHNqekJlK0w0U1dxMGpmWjVmVW5BUHRU?=
 =?utf-8?Q?oM3nFwMkhF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTBPU3JPOTQ5c3NQeUF1QmROSXczVjdJZUpvZHdSNWppSDNhYkFidTgrekhU?=
 =?utf-8?B?WGNGYjFuUlNBUWwxSlVhYXorekdUL0lUNmVkR29TWFpSK0tVZCtQWG1VeWNw?=
 =?utf-8?B?Y0VTdHRnek1ZQ2xmczlCZHcyQ0lmUm5HaGVURlhuODBpclQxdmtTWCt0N05M?=
 =?utf-8?B?b2R0WnVxUG1QdDZKV1BpM2wxS3dqY24yQWdCOU9GNnZGZEkxWFFFSkVnOHdF?=
 =?utf-8?B?K0ZFWmp6VitCbXVFRUt4STRuSC9jV2dDSG9sYzF5UVFSRDRkYlpxMmllc2lB?=
 =?utf-8?B?c1ZtNGswc0U0NXZYelp1cjZPa1ZZbDVBVEljRXA3allIcjZFMDJoN2RQcVZQ?=
 =?utf-8?B?RUgrVHkrUUdzQVFLVmk3d01TSnFzd3ViWVAyWXZtL3U1d2RVQkFoWnJyZUs3?=
 =?utf-8?B?eUlSVlhpaUFLVCtSSWkrZkZZSmYvdlBlVkxOTjU0TUZJeW5sZjZLNlNCTmZS?=
 =?utf-8?B?VitFZ25JRllacVdRUFFJUWpmQTdmUUM3MVkwN0tudUNGaUF5U2N5SzMwSUlL?=
 =?utf-8?B?amkwcEhVOFcyYTBadXAxMWoya3NaNVVKZzZKV1ZsMDMvQmhFeTRrK1h5N05B?=
 =?utf-8?B?dEtxUm9vcHZuMkFxcFZoc1pYZ2dHb0hTbGpMbHB0QWZSWityV0trYTdVcW1S?=
 =?utf-8?B?RWE2RXI2V0ZBWTVXVjNhS1JydDJQRnFvUzFBL0pySFBRUFRHVlQ3Y2VTcGF2?=
 =?utf-8?B?VDZDOEtwZ21NeCs1NG9xSWdhUWhCQjVMd1NFNUFucmRXUTFzenN0eVRnVnJD?=
 =?utf-8?B?TkpnSVd6NGtGWjdzR0M2Sy92OWJWS3NLTWJWT0RVWnVHeUVzVlVUZS9uUkph?=
 =?utf-8?B?VUtXbi9zek5BNGRiWForVW11V2ZEVVNuQngxU2ZpNlc4Y1RNZ2I0VThHdjZZ?=
 =?utf-8?B?dUI1NWVNL3BhU09EZmdDUkJ0aGxIQmFIT3NtV1hNM1I2d0lPb0tMVUptZG5Q?=
 =?utf-8?B?VngyRXpCRFVaMnJLcGN4Sll0UndEaldJNk9mUnB2WnFidVBJbDFmaWZDdlA3?=
 =?utf-8?B?aGRmMW5IWXVDdXdZeXJXdnFLMmw3UWpqWGpjSjdPbnRnbHJ4TlBqRXhoaTNy?=
 =?utf-8?B?ZWIwb0gyZnFlQ285THMvLzRWZkpUVEpCMDhXWGtycVR5OTlWUm4xNTR0YjlY?=
 =?utf-8?B?L242K094dlI1WEx5VVd5aUpSbytPeEg5MmEvNXZhQjBrVUQrOFNGSnBvNGRr?=
 =?utf-8?B?N1dTUHkyRThqQUIxd1ppYUFpMXVTZWluK1hhcTd5aFQwWThkMlNod2VQRjVj?=
 =?utf-8?B?d2IzU3hzQTNBWWZOV0hMSCs1TVJrL3VOWW4yNTZZVjAzbXUwZFVSVngvZmRS?=
 =?utf-8?B?cjF0ejVYS3pnb1luVEY5d0MyMUJBempFd0lYQWh4a2piZDBqeWIrWlpsVGor?=
 =?utf-8?B?MTg5OWJuejk5aGdaRlhCWlg3Y090Z0pEVWczaHlrSFpubWZtb2tIY29vMWc3?=
 =?utf-8?B?Z25ibVlqYTlRVHI5b2g2ZGRHdFc0T3BObHNPV09ROEdJRzkrRGNUdU56V0Vt?=
 =?utf-8?B?TkJZVUtmVXBGQnlLYVR2L3FXRDNyenFDaG90ZzB5Zm8xaHBqei8wSzNmYmRt?=
 =?utf-8?B?cEptUjZ4eTB3S2tvK012K2psTENsYlNiNDU3eUVtZzdhbDFjWDR1SUV0d04v?=
 =?utf-8?B?SE4zWFhIcW5rTmduVk0wWW1XMFNtNlorN1ZvdDhvQ2V1aENXblZCY2FZaGlS?=
 =?utf-8?B?WXRGTW9PTzVEN0R4VG5GNG5JUTFmWEpFSGJqTXBoN1l3M2FzWC8rZU00RXJx?=
 =?utf-8?B?Z3YyMElrWVliNW9UaDNpaGFvQnJ3MHduN2pQbXNBTXlTZkxJa3Vjbk1WTkNT?=
 =?utf-8?B?aTh4R29yczkvU2JjZGhpNmx3Z01qY2VROGVEMXptWVIyaTVVNG43Y255SnE5?=
 =?utf-8?B?T0NkSlVjVk9TSUV0NkUzT1RpYWE2M05mQm45QlV1bUpNbTYyWXNqZ3FNaWFx?=
 =?utf-8?B?Y0F3K3hkaUs0ek9OcjkvblphSzREU0FMdElCT09UdE9Ta0ZIR2tRM1NIOXFu?=
 =?utf-8?B?eURMYWQyVUJtaDVxV0t0STdBUzFuRjNWN1JIQ1poTDZnNnFoM2lUU05WTCtw?=
 =?utf-8?B?L2laa2FFOUJaVE1LSWhWeXAxTDNRNmJiOFdYeGt2SXFBaE1FR2RsVEYxa25P?=
 =?utf-8?Q?qBC3Kbs9UHveIAyYEP1wAM1+f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vS+5nnheCn25ap1ib0N8wrDyK0yKPr4anWMZ2h+DxIu5Pmycqh8sPVzLxZEntW5Q953Go1niAFiWX3stCAerWTBlMa/rSztlE/eK2/iit5MZdZOtKgx98VAwss4vphm6/9isvn0n7wox43kqh0ro9s0t3JBimYBNyy2fN8djcNsFV5kSOK6zJ3G5gtQJkEUhL/1kcym8XlpB6rr+c42cdlDpzCwSlO4ZRKw8iI85MQMKipvQa3IYpudQlO1vzjXxD0Q1zqlS/czGnP8ypMj5OVDlgt2qAQMD3TBRg5l3XdsyVabgyjis0412Qjqk6+S1jfAiy5H1RIvnquGWAvHCxP3EPDvev0DLgpSBXMBC4Jc4Ay1qz8/brlMsSD2Oj/aVMG51sZaCZw8nVQalGakv6nALCUqL49JCTIeP7kUjtD+Ok7Qbzg756F2C3VBhOolp2GaoRZMnTAvFtf9wrs7xecZz0BKVnxHiBIzLAcFFvom+LfU/PNs6pGuTGMDMwHpxiFznOKh2wvBq0NbNbRum8oUEn8QNwqhTYBC+u4wKOCJXBbOp9QJw+9KNHj3pL5fwFCxV06eFqIOUsmrdpvP6ohS+QDUQighkwZjxqkp9mB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94c3790-989e-4dea-0881-08dd9e09b4da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:04:28.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+qRacWNVi8i5FJHkgRtEBV+jp4qm0yuz6+0euSgzIDrfAvJICr4C1ssYPyFG1HhnSH6usuCAVZF/iGpVqY1oOjPLlnxN2MMwHsSWGH3rIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=964 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280148
X-Proofpoint-GUID: fVpTx3eETCMpsEiDosyrh0bD7dCYVHz7
X-Proofpoint-ORIG-GUID: fVpTx3eETCMpsEiDosyrh0bD7dCYVHz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OCBTYWx0ZWRfX+mufFbY++gmi MkXTi/SsSJndxcLiHYp0JTRuzg6Jetr90fftHetnAXFPScvFXYniQRAiniHd276la/9qXZzMi5x Itdd1k0tyn/k8oqGLAk3FVckAKqQ2FLEYKOGjxQHiyzoyzm3Ic/+lLIDZ001jENr70k+NJXPSmK
 bz6ovr31/4wnraSQsvsGVDsSVxmPCsyOk+5oa4t/n/KRIuO9qxv6U/5WkajgBk2+igKDxuhtzZL 1zfFsmfoDs2pAOTkfyVmf8/owhUG/DrJHjOKcqaBxKqhHoir+Hzy7s4TsrWtEi5b7DHqROXKKrf GosuKwvXDs6b0G7xDMGRQnm+zAOGJEp20ZdpEQsWQ0jsWGheGqJv+VPuGcMsAI5SEJDrw1/pm4o
 9kU7Fbxpqvo6LtF/5zWBPHFHfTaBEIB7PzA6utB5GqFlU1IIf2yc56HidSqdinBehkPuJeHs
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68374220 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=EFfmVMT69xHJvWft7PkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206



On 27-05-2025 21:49, Bui Quang Minh wrote:
> +def main():
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.bin_local = path.abspath(path.dirname(__file__)
> +                            + "/../../../drivers/net/hw/xsk_receive")
> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> +
> +        server_cmd = f"{cfg.bin_remote} -s -i {cfg.remote_ifname} "
> +        server_cmd += f"-r {cfg.remote_addr_v["4"]} -l {cfg.addr_v["4"]}"
> +        client_cmd = f"{cfg.bin_local} -c -r {cfg.remote_addr_v["4"]} "
> +        client_cmd += f"-l {cfg.addr_v["4"]}"
> +
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, server_cmd, client_cmd))
> +    ksft_exit()

SyntaxError ?
inner ["4"] uses double quotes, which clash with the outer double quotes 
of the f-string

Thanks,
Alok

