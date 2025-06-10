Return-Path: <bpf+bounces-60181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D1AAD3931
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1911A1BA3D26
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5F246BCB;
	Tue, 10 Jun 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dS3pDt4U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kk4EZjhm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E337246BB9;
	Tue, 10 Jun 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561673; cv=fail; b=I7+JYiaubeexzgxCP3554VSeEF1SdEAv8HnNwns0CmOPziJCIYeNMjhC/cDnmVGkSoEVlclYx6/XwJnyvMEnrzyk/OwEMQqY4BVRhuXkyjg6qWUCQD3gtHOytotu3U0GZgzafAGcpD/pVm1KdMaIaVKKTR1RbATpnqF4FHDwKFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561673; c=relaxed/simple;
	bh=xMpF2ybiqRvwspFE2pjUxV6KeKAP4VxJeZmpM8QiJgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CvtkJvXcSogo6iS+4OsG9RZ+F+nv+rEClKz37PUm0R/9KrEj9+G1kmwkqN4i4qiFDoJ175jLDnhBSsNiQWkZpcZGLjtiZwhOop+fxOGBKu3oluMrEctbKPixp9VAYas1+mB+4kKmnSiLnPpCG0LSqvrvgOnkbyYeKRX5HWqIY2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dS3pDt4U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kk4EZjhm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADC80Q005261;
	Tue, 10 Jun 2025 13:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ddDEabj2cO6LbZ/MpV/EERT01fY2da+PpLNpUInNwoY=; b=
	dS3pDt4UP9tkHfF4wDZhZC/nIWkFidSquh0bFtx+zk+0HqoGLpnJYRNDcv3LPqKB
	ORoccIpU+3GXEmLYJKyYR/TdwdHARaiJgF/bxMGveFkzzxli7JQxaZupPiOSFKIp
	XU/LbSrRXxU2cqeI4BsNhzx6+gPHPABdCfGKqFAZ0AA7n5EiTMFj82+QqjKQoC41
	faVlyRIc5zo5lb3q3haBe7FMADGw0TDqJikjv5O3wX9zJHotyqvLdvtOlh9O/8DY
	/H5UgVdUVQIGn85ghmUu2U3D8hkooKxLyco6BqE4H9AuGTBzPdY6wQdolQq7ZC2m
	mys1ecRAwrkD4MSE43MXIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywv6r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:21:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACnBVD020981;
	Tue, 10 Jun 2025 13:21:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bveyp19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHp3gdGx7Eh6jOb2McZWqlluuXduTlMNTlirHtYkdOKfjAdtGYF2XcCOxiRhE4VKvVZeSJ5CBO4I3jH6fkW/63VoNbRN/QU23Vh+T2QPiQ2j29ed12qQ/xddHIQ9jHrrta7cuwO9YPYZgpvrZ5uh6NJCgqtcYodTVSebzx4TpKDGqRNcAcrzSMumayNS/24VndmhHeLnqLdMKHTP2wJzgjh+vVO5PuZ/N8/0kNiifKaDbHRTAINmUz5ot3ec4yacXIZJ68gDosnG5165Muga2civmvtCSYeNMy7d4KaBDF8ueRZ9Bq+hH+1FCfsOmPDM9XMiTBQLGpEu3M4VnS4+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddDEabj2cO6LbZ/MpV/EERT01fY2da+PpLNpUInNwoY=;
 b=Vxvx/udqi8XTsIZaUh5clt6s2cRumK6OagzY1iiiwwfeyjKJ31RFfeCRVNCbvXEKPJZns8mK8YXQOM4XKfUOxH9HXLqwp+8mvINxZqLUPa2avWFQHB9sFgQ2S4tmd5nYpL7YYIcENvaVHfjuCiOWRfrUa9VdQxvyESVKrPNT4Rtk2vB3niHwy3aj/G5ZmXeatt5P9z49V/Fd3148YffZcDx59R6bn5truLJOYCl87mN0uZR0YpPwVxQ12IKmnB//e258ttauMcP9DD2SVz0zIZ13aw+AQYoc+nND5wMKiG3qU2hY1XYqf6iKDqKq5gjVISFXPxOAjFmcGMTvCxPQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddDEabj2cO6LbZ/MpV/EERT01fY2da+PpLNpUInNwoY=;
 b=Kk4EZjhmbbNZR90dqwdBG19ZUbqk0yvgdlAY6CQfs3KfUqhrzukXs1LptcvUqVKAtmuUZFQpziB8VKETuB5wjq5uBeRxVP2rYcS5IFTUkiqXBA19DugnWHB1peyY4kMl5AvQf6leh20+8E3/l0qxyZaEuP5t/LPl2Vjp6k8SMFY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4883.namprd10.prod.outlook.com (2603:10b6:208:334::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 13:20:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:20:54 +0000
Message-ID: <1f74cf95-9547-4915-923e-8c05d9c5672c@oracle.com>
Date: Tue, 10 Jun 2025 09:20:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/7] netlink: specs: fix all the yamllint
 errors
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, mptcp@lists.linux.dev,
        kernel-tls-handshake@lists.linux.dev, bpf@vger.kernel.org
Cc: donald.hunter@redhat.com
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:610:38::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 407928e7-eec6-41be-2735-08dda821a0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCtmdEhtMHQ5RUdEbHRNcGIrOHVaYnJRRFU2RHFuUXZQNm9NZVdzSXJUYncx?=
 =?utf-8?B?bHh1QzhiRE55WUw0Z08yZC9OZ0N1TFpsMWpQNlhNUmFUNGhGdHdabXJMWmd3?=
 =?utf-8?B?UzJrQWtiQUliSTlLSzU0eVBxNCttdVVsWm5tWnV5MVh6Z2FMdDRoTVVTeG1x?=
 =?utf-8?B?SjhUMDNiT1poWWRxbmEzdGNHQzdOQnBoQWo4YWhwQVdxN1E1K01Mb2ZGdE5j?=
 =?utf-8?B?RjRrNU8zWFNFWitnY01Kcm9sdXlkTk5qYTZXaWoyZk12MGxJZU9mYUNBR2Fh?=
 =?utf-8?B?K2NwdnhWQVdGVmxLSWZMNGhORmMrbHVJWUxTNUZZd3RhK0lhcDFIU3NaakRy?=
 =?utf-8?B?STN5dzNpVXdoYzJKempTRXpGL0kvS3l4Y0h1WTgwNXZTWTJ0aHY5TXl0NEcw?=
 =?utf-8?B?MnRSYi9MRWNLdWVSZXFWbDk5eEpiMTcxMUlmTHpDK05rQUcybU1BWnp3Tlls?=
 =?utf-8?B?OVcvL2t2TjJSK05JWDlPdU5EbnlLNjE3dFArUm5SNWNLQ00xSEoyRWkwejgy?=
 =?utf-8?B?OERLM2EyM1NVZUtYVVVURlNlb2F4QUpIQnlPdHA0SDgwQnd4bDNBem5jT3B0?=
 =?utf-8?B?ZndSUDdlQ2FKbkpvS1JIUGw3WjN5b3h1MThKdjBsU0t0ZFJYcWJ1RFVYTmNB?=
 =?utf-8?B?RW9DUlVueGNOeEJRUUsvcUR5VXk0enJiQ0ZlNVpmbFpMeW1MU3FiSjdJRU5u?=
 =?utf-8?B?T3FvS2FOdTgvUjIrcVRaTEcwRHFnUnJXK3MwdVFpc3QveHFLc25zZFRTSjhn?=
 =?utf-8?B?c1pIN09rTGoxNTY3a3prRUpUZzZMTGpQN20yemUxQ1JLUENpWWJhdjMxVTlQ?=
 =?utf-8?B?K3EwcG1Qa2QvaGlOWTVZYzJveWdvMitVUG9PYjNBQ1FpYzNZMmNkNVVvMTAw?=
 =?utf-8?B?K1dPT2NDcXlHNlFUbXFDNDRhL1IvaVQwY2NiRDFBQklqWml6amlaWVVEbXFZ?=
 =?utf-8?B?VkxEYTBlc0E0SWZYUXd2RXlrVjYzVEM5WHE5eHJaU0R2b1NHY1BPUTRLVXRI?=
 =?utf-8?B?TG83QVVQYXROb1gxRE0yWE4wM3M5U011YXk1bUpMMWpPYWtiSStUVzVEYnB3?=
 =?utf-8?B?NFJ6N0xlUk1KQnlySG5OamhwNTMydmNSVFgxemgzaGNLMnJtc0hKTTRJZ3pr?=
 =?utf-8?B?bUZPRDJ2NHdaRlZpd0dSZmZxS1NBV0szblZrTDJlN0x1cUNxU3E2MGF5V3NB?=
 =?utf-8?B?S0M2TVJ0Y1hrQkhTSHU4dGh4NWdTMTc3cEpyZ1FmbEZHeFVlL2dPU3dPUWhP?=
 =?utf-8?B?azZHWWFtWnVSc3JMNU5qRkVWcHJoZDFVYXE3RnM0MEJDSm1lbHNNUk1LaVpB?=
 =?utf-8?B?M0VnbHZUbTdUdmE3dm1kblJKUE1BSmdtdWx5V0N6NWxxUlBmeGdTaG1vczcz?=
 =?utf-8?B?cEN6dndxVGNpZHdWMkwyQTZzSktzYmwvVGQwVDBGQW5RenBzWGozWmV3UTYv?=
 =?utf-8?B?SHJjNXVWQ3V2YTdNQy9YRFZ5bkxBYUJ3ZGN1ejdVc2N3S3dENFpuczNhYlpz?=
 =?utf-8?B?RUh1VkEyeVU4akJmRGltRTNkekJmLzNTamIzM21XbHE5M1BGRGlRM3Z5T25N?=
 =?utf-8?B?Z3JBU1NWZGNnL3JVT1ZSSlB5S3Q0QUh0Y0wrdzdwaWNwcUxyNEhMWFM0VlVW?=
 =?utf-8?B?OXIvSklsbDROTUUrVjRQQXpuSlJIMHlNcmVGd3N3N2p1UGNnQUU2VldzYWdK?=
 =?utf-8?B?cjIzb2RpeVFXcUcxSDg3bERHRGFOd0M2MTh3VDJVSmllRlQ1N3RTUHBFK01J?=
 =?utf-8?B?SXBSaGhqc2p2SnhCSkxQMlFzb0szZ0owNnFGZENDR3VpZHkrWWVnMXNnZUNC?=
 =?utf-8?B?dzZqUXhIQWQ3bU5YcXJNVGI3R0oyRVdZbWx4d282KzFHbjF3cnE4ZU5tc3o3?=
 =?utf-8?B?MUJ6dWMyblpoVkIyWW1ORTlwSC9xTGhxQUpzSllPN2d2Y1RnZlRTTS9Cd29j?=
 =?utf-8?B?TUtpL2ZlM2NwQ1UzVU9YalBtU1JLUHJFNEVsdEtPbTVTTDZWMjB0UUZNN0Zm?=
 =?utf-8?B?aVVGamgrd0pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk1peFpSdTVTeFNFbEVpd21mUkl2MnR4QmxzSnJON05TWDJtYkFyQkZDY3hp?=
 =?utf-8?B?by9EdC9URHN4VGJqUUlLTGFiam9lbjZaMmIvSVhoN29PTEhxenlpam4zcGVB?=
 =?utf-8?B?V0hETUNiSWkrdFBzWEpJTlloQlpDT2dlelBobE9wNVc1eDlWRDR1MkRNS3Iv?=
 =?utf-8?B?QUt6UnRQby9WVGg0R1BZaVkxbEpjc1VXRUtmYVN6ZTRmUFNpYkF2c2Nxc250?=
 =?utf-8?B?YktGT2hqQXdpclQwTGJ2WTJMdUFQL1BKRnNxcURFb0c2SjZpUjhnZDhCa2FU?=
 =?utf-8?B?ZysyRXNERTFseUR4RnJJeUVQVzlQQnJzZ0paYU44TVdLOGlCTzBIRlFiMzNL?=
 =?utf-8?B?WW90YmNmMWdKTEQ1Tk9Sc3lOOXNHZ3BVMzdKZVk5OE9rVFdIdm5kbjBDT09t?=
 =?utf-8?B?REloZStKcjRLMkRJUE9yVjNyNktBbXFsVWtKU01UZHNyMmg0TE9CSUU4aS9y?=
 =?utf-8?B?czNlUnlpSE5EYjRiRy94SHBFYThqMWhVRmVwWlh1dzg3cUlPeU9jRC83OCtM?=
 =?utf-8?B?M1F5aWM4M29kekVKRTJ4R2dtS1VyR2V0L2h4OUhadnRpdGlHR1JPNkFMQjFw?=
 =?utf-8?B?UnhOR09hUmJleFJzNnhrMEtPYmUyREYzeFBCMGN2bGRwYWxzMk5ZSkR6S2xv?=
 =?utf-8?B?bnFmbXZSSE1uZGJSRnlReGU0VGhSZVE3aUVtUTd3VU5jVTFXbUdnblhYYnh3?=
 =?utf-8?B?UHhJQlBzRXJDanVnQmpKZkFFOUNEZDB2eXVkZTVWekg3S0w0VzdBQnVOS2wy?=
 =?utf-8?B?bkdaUmZ6WnNoR2dUZUJwaisvOU9aa0VqL2RVOHZZZ2NtMGhWYm96MnFxS2ZN?=
 =?utf-8?B?Q1VRTktLNGxJZ2JxWGxySWF2dlRiN3NDeStrS1d6RFI2aTJMcjFNaUhyQmFS?=
 =?utf-8?B?K1ZqemViMXUxdC9LQy8rRTlZUGlUVE14OTZwY1FwOEEzWkVVc1B2VXJ2REJZ?=
 =?utf-8?B?dnVSeWo0TjVGRDJ1SnFxTDNwM0krWjRmZG5Cb2QxUityck1DbUptSkdzVzRj?=
 =?utf-8?B?QW9idEk0L3N6Q3BScW5GYmgwZjM2aEZ6Z2p0UHRmWExmRWNyY2RHdVNtTHJD?=
 =?utf-8?B?VU5LQTErcTgydGI3ckQ2UzdicVA3empmWS9qVjR3RTFzanpac2hnb3VQeFp1?=
 =?utf-8?B?VXFrb0FxVzZ3Wi9KYUxUSDVDWU82d2JObW85SjFYU1JucFVPRitTcWRFOHcr?=
 =?utf-8?B?UVVHVXRxR0RWbkdRY3pHNVpaNVdDalpLL0VmNCt2Z1BseDh2ck1ic0g3S1NL?=
 =?utf-8?B?RDVaREROYlk0Z2tiYS9wREc1MWRBYmg1TTBJZmZHTTRUcTUxbWFNSGdBeEZr?=
 =?utf-8?B?Vm5CR3B2WU9xY3p2cHF6cTRnQWpnb0RjT0JCdkFkRTBuZlo1bHhOSVJrSmV5?=
 =?utf-8?B?OWRTdHJKejhuNkFzMTdEcjM3ei9FbU52L3B2Ynd4cmN2U1lZNFR0OHR6S2Zp?=
 =?utf-8?B?YUdPVkErQUxiZWlvK0FZUVYyN0grcVRXYml4d3dRd2MvZFhjTXVZSk03UXov?=
 =?utf-8?B?U0UrSzF0RFIwWHkxazVOUDZmMnBkSTlvWmk0dkZRd09tNElGNHJwWnViNkdG?=
 =?utf-8?B?M3pmTDdZZHlMeGhJUUlSY0wrRUdjYkpqUXV2WGIxQXRUVTl1ekNwZ3FkVGtV?=
 =?utf-8?B?WE5MSko1TUI3b1o2S2NkcDhpMmRlSlp1NnlrM0R0VmNCaFJwUnNLRHRiTElo?=
 =?utf-8?B?dWY2L2NCUWM5dlJ3Ym5oR0txTUFOOEtwMzZrWFJxYzRBcDJLTzB0TGt3bmhM?=
 =?utf-8?B?NmtHalNLUE05NnFBQUdQaU44TXVlbGRhWnB4MElLMElpOS9ySjhZV29VUDl0?=
 =?utf-8?B?MFo5NWc3MDIvR3FVSHNGVzBicUluSTFRVUN1V0xnbitXb3lUNmxwbjgyQnM4?=
 =?utf-8?B?RDlDckFUYzR6TmJEOXRxTDRhbUQyTC9WN0FxS1JzU2lnY2ZkaDhnRndUNmhw?=
 =?utf-8?B?aVZKaVBacnlGV01DV3hwQ1NUZTNmei9vb0JNeUJRa2EyekZPTXFUcEdMNllF?=
 =?utf-8?B?M1RjclFjMnJQVmdBYnJDSmpxRFBVeS9HZDhwNWJreklFQTNWOXpWb2tYdmJj?=
 =?utf-8?B?TUhOTTczOUYrZFlVRjRrak5ra0ZJTTJ2cFFUb3FzUzVhdmFuOUtPY290Qm9B?=
 =?utf-8?B?MEhBS05CTUo4T3BFQW8rcVFVWkNxdkxtSmk5dVBnbk9UcGMzL1BZQllxcWhh?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6x4XnIvHBuhVRoqYbtx9HKA2D528mf2k+6v2AsFQz+LGID4bv/7MhvHHP3w14FW7GZaJl9tq1rEr29AzdYksCHONFuTBJN/B76JY7sIWtSR3pN3NuyOo6JaX41ftm9ce+tQdbYQs50Q38csN34tkVZvbDYqR4E/AYNDieGpAhtEj283k7l/rQpog4bdeA9T2T5rbf6B4jOe4weBFne389m5+Rd78Vo8kJUqpiUrbBpFs9S9sAousZGIa88eQnJ1ELLED72VSPB1EhZY6kjcngrmSnxCiCS//3xF0dFio4siYA2l/lx2Dd8dj8GPxsNE91jROOH4UPy2cyCByGw9NUjaEwwsIrPyP22Ay0qQwOAb9TU43mBXoAdrqbS4in7+vku9oMKd9mB6WDX9HNd4czXI3cAUtJIuVa1szM6MAXw9pKZ/urO/1jFkQlSBHpecP2iiP1KA/wVs73nDEF5MIequ8bbG/Mt8yKAZuO3FTkx9nre/a0kpQ7s0X2BI04QrGziQ9zJpanENOtxMyZe3WaRpt8zBBJfOzf4lrB0js59dV8fMsssGb/9ydEP/hJZwok/SX0Vz3zky2Pbgp8qj6arzICjg2RjYnwEShhFNapSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407928e7-eec6-41be-2735-08dda821a0e5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:20:54.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghiljy4I+OJq0axC+K1kUSRi/N1GCD97/t5eYStQ+uL1e2KFQWjY8sE5CzmTqkOX5v+yugFegqfpC1KyOUGRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100104
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6848313f b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=wdO_r5vxAQ5BLrPc5UMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: RljorqbQgrUOTNoOHha_AEGSVd91mx2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwNCBTYWx0ZWRfXxOa1aEYRtDzV 7WE/yD3uactQskwT0XIxzes3XJM0T6D7RrQEOcXy54Bfzh6/zlqQ+DuxNqZWJbF1Tf65Aet1A6F fMsQ3YPEPX7Ptd24Es8NpzfMwahEOR3n8YhqpeGsakF1obkUS8n4DXHS+gT8hHsgT17Fu3zsJ4r
 Cq1sJ7xoCmOQdj+6ittbfqgyV1ed2aMAiw+Zf5TruatECNd4ZORp7E/O9X4UKPThw77Y8dGIWx/ u9LQ2ut8UyUpi8b1NmIFH6efP/Z8POsKmZWvT+7rzAaBxQdVd8UzvQOauPpRgXJCF4KMdQ/vOy/ JH1ZegtZ7wgAa+0fAeK/TUXyHFbwhHxhA/6XmXAXatFNjfUHRdg88Uuk58pteHUM9FrsjLWoV1j
 s3lzNLX99WyyWHMKdZrSWZhdfynkbS/hUE8qWTvODGNEG6JkfersFxmPILn/IWG5xbsDg3kW
X-Proofpoint-GUID: RljorqbQgrUOTNoOHha_AEGSVd91mx2K

On 6/10/25 8:59 AM, Donald Hunter wrote:
> yamllint reported ~500 errors and warnings in the netlink specs. Fix all
> the reported issues.
> 
> Link: https://lore.kernel.org/netdev/m2tt4tt3wv.fsf@gmail.com/
> 
> Donald Hunter (7):
>   netlink: specs: add doc start markers to yaml
>   netlink: specs: clean up spaces in brackets
>   netlink: specs: fix up spaces before comments
>   netlink: specs: fix up truthy values
>   netlink: specs: fix up indentation errors
>   netlink: specs: wrap long doc lines (>80 chars)
>   netlink: specs: fix a couple of yamllint warnings
> 
>  Documentation/netlink/specs/conntrack.yaml    |  38 ++--
>  Documentation/netlink/specs/devlink.yaml      | 208 +++++++++---------
>  Documentation/netlink/specs/dpll.yaml         |  14 +-
>  Documentation/netlink/specs/ethtool.yaml      |  70 +++---
>  Documentation/netlink/specs/fou.yaml          |  14 +-
>  Documentation/netlink/specs/handshake.yaml    |  10 +-
>  Documentation/netlink/specs/lockd.yaml        |   4 +-
>  Documentation/netlink/specs/mptcp_pm.yaml     | 192 ++++++++--------
>  Documentation/netlink/specs/net_shaper.yaml   |   7 +-
>  Documentation/netlink/specs/netdev.yaml       |  43 ++--
>  Documentation/netlink/specs/nfsd.yaml         |  10 +-
>  Documentation/netlink/specs/nftables.yaml     |  16 +-
>  Documentation/netlink/specs/nl80211.yaml      | 109 ++++-----
>  Documentation/netlink/specs/nlctrl.yaml       |   6 +-
>  Documentation/netlink/specs/ovpn.yaml         |  26 +--
>  Documentation/netlink/specs/ovs_datapath.yaml |   2 +-
>  Documentation/netlink/specs/ovs_flow.yaml     |  16 +-
>  Documentation/netlink/specs/ovs_vport.yaml    |   4 +-
>  Documentation/netlink/specs/rt-addr.yaml      |   2 +-
>  Documentation/netlink/specs/rt-link.yaml      |   2 +-
>  Documentation/netlink/specs/rt-neigh.yaml     |   2 +-
>  Documentation/netlink/specs/rt-route.yaml     |  10 +-
>  Documentation/netlink/specs/rt-rule.yaml      |   2 +-
>  Documentation/netlink/specs/tc.yaml           |  27 ++-
>  Documentation/netlink/specs/tcp_metrics.yaml  |   8 +-
>  Documentation/netlink/specs/team.yaml         |  16 +-
>  26 files changed, 440 insertions(+), 418 deletions(-)
> 

For the changes to Documentation/netlink/specs/handshake.yml:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

