Return-Path: <bpf+bounces-40021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6697ACCF
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383421C21564
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95C158A2E;
	Tue, 17 Sep 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MceK1XeF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fLxlNPXN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C34594A;
	Tue, 17 Sep 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561361; cv=fail; b=J4IawlywprwHdnOcqXoiBavn+3XPFviOnOmKEBWGPUDqVcwY3YC+UwTXAWPHn744H2a+nJuDGTYsytLQxo7irR81+LAIKGilJGsdhu9SNDkl8H9zYQuugiknIiIPcpko8wFKH/o69DL/8/YioCpKeDK/JNE6s6CGV1cGUo+Jj2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561361; c=relaxed/simple;
	bh=/AApIabFIwOcrysSRBqe50c59VTPpumJ2vlVnxs4/Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHda9mMznF9wtQB3g3SO6BiFsiJnfZSX/1JWBCM/LFPXYOA1yx/w9QlI73vZkP/SrARAjqVpWH7gCopi2S7Fl+FmVi5x2at7PC9lgVVl4boLLX7hOQgqAP9XvFQ+h41/iKG+39xGMIWfKveZjRb+9yJi5hveqEQ2dZoTMjXrYvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MceK1XeF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fLxlNPXN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H1MaE3007484;
	Tue, 17 Sep 2024 08:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cjNmnxFaf49UNQMSGQyq+0EnE7mqWNOGYTaZHvaZNvE=; b=
	MceK1XeF1mSJtxXqoyQilGZG9gtWmUsfeFTAts/UN4ARD6aX+1fVASri8Uy5z110
	IwWycx4InkmZCwz/5Nn2iL+P1OPAjSvTPjN6bf+vDz7Kq2dt/yihh+RPAh0dbQm7
	PvnYW6MdpfaqcJQkwjns7n+G7Lu0/g/7hgAhKOFKp/2iXtgKzeQWA7zY62KVWwsR
	pw9WtHPXW1YIXzyH8aSa68b4Nz+1cGIKav5LiTEDlMYD0UgkzScSJz6qtw05Vn0V
	Q9e6lu2FQ76AdYipiJjkI0UOT2z45D3ETQW89AimPCwxAElQLeK+I63u0ynlUcT4
	zUb15u1GhJWxS0I9LQp4Bg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3scwg8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 08:22:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8KOe6000430;
	Tue, 17 Sep 2024 08:22:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyduvwkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 08:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj8oe36VXTrtj8lApf8D4+wb13q76qY9XFwMxiQkfTVJeLRhzr4yMPa9Zh5ph7D8Kxg/dcOTCl/R9fw6LidTenK0y13M9kfAkgss4m72YqWnccBv0n3gPccW5x9Yr0JimOqT0FJHD0AdKVnnTFJ83OFQgxvKR9hWdr3eL3Go7P1rbkn4O/7pjrU0yIif0vPJNuNnYWtQ+h3Cz4c2sHwenTY4/KKX53q+AzD0mWYfGytwJ1RvQbYWc3hKqoiwve4RLdrHnYqxHCLaq6EuuppqDZJh3btPxbnxhvN4HfAZU7JL0uEI4fNkO0QU66qw60nkDJw9KECO+wx++eKMubVSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjNmnxFaf49UNQMSGQyq+0EnE7mqWNOGYTaZHvaZNvE=;
 b=cZMJPmwf+vAi52e0FrdV2R39I6O4M3PcOhq3jqSj3SrY2T+2FWKRfE8nNHmQfUAq1hRB7TpvoeJnoldYDXTCJADQlWIhOY99LfyZBMrDq/PiSLqj5AnOcv4XjdKDf0G1LBxYSZXepb6Wrvzqkp8neoq+4FLTsj6VFHAeOedn6IGl814cmq4Tt4ELYI5FAWD4toqC4SJgbzcTzT60Y4fB8S+MGbJBdf3fdnyNV8tyS/UNh0XDzLwLMy7hpoEhxbSBy+k7ruvvMp9rfLcIRgPy/Dcc6AOmoy7VKtqOJxKOeF20K9C6P5yTjtV3ep4/Uw4flTo0Ji/6lOtV/prAob1YpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjNmnxFaf49UNQMSGQyq+0EnE7mqWNOGYTaZHvaZNvE=;
 b=fLxlNPXNUIp/fyo3mlxUd7uXvs1/z64avhAMKnG6ZTscC/kfkTeE67pwaXVcgznloaUr4VNIZ1qE8/EuDDdwV/ATM1USZwzbT/hsSHpZCWLto/zEbnRhQX6jXdOFa6FR+79z/Km+I0OHVhlivVBBGO8hReJJZ4vPaeptK9Et5Eo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6859.namprd10.prod.outlook.com (2603:10b6:610:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Tue, 17 Sep
 2024 08:21:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 08:21:58 +0000
Message-ID: <96a902c8-df75-46ef-8416-952b46d38afc@oracle.com>
Date: Tue, 17 Sep 2024 09:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for
 eligible kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
        martin.lau@linux.dev
References: <20240916091921.2929615-1-eddyz87@gmail.com>
 <dcaf46c8-68d2-455f-955b-311785cf2827@oracle.com>
 <fc3059de61eeeff33af1b22cb68edcad6759b25f.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <fc3059de61eeeff33af1b22cb68edcad6759b25f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0408.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 599424fd-312e-4ee9-9ebe-08dcd6f1cc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWwzZmR3UHpGRmRjVC9Ramp5ZzJmQjJOWG9WckNFRjgrMVlVbWQ1WHFrTnRJ?=
 =?utf-8?B?V0JiWFVvV3JxM3BNM0U0VGxRSUtDMW02c1hTdStxdVA2b0s4ZEpCcWxWM0hD?=
 =?utf-8?B?bWYwUUJMWndFOG91TlRtd1d1dnRWdml3QmFjVFcwdEpBbG1sdWlxeXc3N2tZ?=
 =?utf-8?B?WXhlUmhpK1ovaFZRc3p2NzdDVGlhUzM0dkVLSDkwWU9uazhWaURDV2ZXRFRP?=
 =?utf-8?B?eXJOR2U5L3ZGS3ZMRUFPdW93Y01wK3puLzVyTnpNby9qQkY4NWUreHlSck5G?=
 =?utf-8?B?azc3VDRUSjF6eHQvRVNLdHNzMFU5eTRqcEZNclhUeEswcUd0bjczaGdBb3Z6?=
 =?utf-8?B?RFBxTXY5Y1BkQ2svdGZKRmp0MCtZRngvYmZEWHhWKzZyTlF4SkNyVWdGSGly?=
 =?utf-8?B?Z0RKbXMrdzNhWjl6UVlOYmlKVDhvcnBrU1VwSEJPM3RRdFkvU2FsQnJzMjFX?=
 =?utf-8?B?TnZGNE9yZi9uT1N4aFNCdTZMcUdxbmo3TnRjV3lGV24yMGl6ak11OHNtS01y?=
 =?utf-8?B?QW5TN3RPMStRZzA0UjlHakNocjV2emErNVZmcEtuN3EvMGh3d2VGdzU2d3Vs?=
 =?utf-8?B?Ny9ONG5VTUZ6RlFnQkphaVd1Rk5JOW94L3BpL2xoR01DM0M3ZHMrTlBTYlAv?=
 =?utf-8?B?QW45Rmk3b3d6OG5FeXNLZVF5SU1yeTB3ZXB5SVV6S0tpOWZhaTd1TUptMTlS?=
 =?utf-8?B?MWJRYUdKZnpYUm50S0JoRkNtaTVxUjBrY0dmSUh4Q2dBTno5RllXKytaTTVF?=
 =?utf-8?B?NjBpOWg0cUtLVzMxOWhkT0ZoVjZrek9xTU9GK08vcTdxbDRWaTVzUWlBc1pm?=
 =?utf-8?B?M0xsOXlURWNuUjNWR0xKWjRtcjZ2MjBmNkxoZmxpSEpSMXg4VDBSQk9lL3J4?=
 =?utf-8?B?SmFkc0hJenlTRjJtMlhrTDZ3RGpmU1I4cmFkeUlWdFdtZzAyK3NRUEhPUjRx?=
 =?utf-8?B?TjBLZHh6WEI5Q0NOcTJjdWJTY0o2ZHZncEtXOUYwUkVPMUQ4ekFydzJScW8w?=
 =?utf-8?B?WVdWUWVUUkxGY2JudmpMdlhnVkk5WWdKVEUwM2QvTGUraDRzZFgxaGFYVzZr?=
 =?utf-8?B?bzJEOGdmTVMwcGwzd1lYd25RNmN1SnFza245cU5rR0FpeUd0eDdZRGNaMEVB?=
 =?utf-8?B?V1hoU3RzaTZ1TitKMEhHUzNBZGNQeFA4YmV0ekhzaCs5eVNGUWNWWnY2eVZC?=
 =?utf-8?B?VUh6Yi9oSEwxelVPZjZzeGdFdTNFYWo5V2tkRnY2Nkg5OUFxendaSmlBRGxR?=
 =?utf-8?B?bmlVSVpONitTWmVDMzR4aVAvdnJLeE9BbEJLTEJQa25GbU9KMlNXaGJyUkZr?=
 =?utf-8?B?UVlkZmVybmwvVW5obGNGcURqaTBkZjdMM2F0V1J6NzNvcXZvQmJhbHFlWDgx?=
 =?utf-8?B?VmczcXdJTVpPYVpSd2ROQVpzYjduN09aQnZOSlF5dm5oRjVxWmFzaHhCeFAw?=
 =?utf-8?B?ZklLQ1dibUkvSG1QaTEzTEpJY0tRQlJ3clVGZksyTWxJV1JuRlVqTXZnSlNi?=
 =?utf-8?B?OFZxSHVlZXlYdmQrK3dpc2VvZU1sdUhDRjNjUXAwVGtiMFZFOTlSMHEyajZD?=
 =?utf-8?B?SmxLOUJ0dmJTdDlxelI3TTFHSE51ckZGbGxSY00xMVgrRTRGeExydFZCMkdq?=
 =?utf-8?B?eDhYd3czSnNIK3lHM2FXN09iWDB2cGMyTXIzajJudVlSZXlianFsSmVHTzQw?=
 =?utf-8?B?NWJDN1E0eUNmdjNEWUNueTgrVkdkei9Cb3JialYxeVR4enZ1blFERi9XclFL?=
 =?utf-8?B?anFPbGEvOUE2NWpGeWdKUjVMSXhOb056b2FPbCt4Q1lrVkJKcmhhZ2NnSFZT?=
 =?utf-8?B?MG9jZ3F1djZmNGFKSkNqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW1YTVpFVGppK3BJU0JzV21lamNzMTJsY29jQStCQXlFM0hJNEd1SmFOUlE1?=
 =?utf-8?B?THlsMTl6WUEvZWs2bWtlRGRKK1o3Q3lHQ3JrVVl2RUM0ZDNOZzNpL3JkQ3Ez?=
 =?utf-8?B?cndYOWo5RFhWK0tBOTRsOG5PK29SMlV6L1k4d1VpQXdaalBJZitFSlp5U3lU?=
 =?utf-8?B?NXJrZnRRTmdWb0RpcXdXZ2RGRklDR1pYSGhOUk1zTWdST0RyRkVYMmFBcml4?=
 =?utf-8?B?aHZ6cTRBNzloUC9JcWtXVUt1d1BDaUlwK2tkTkQ5b0JWdCtDTWZxUkpTYmlm?=
 =?utf-8?B?T2pBU21oMDJKcE5lY2xEcFVvL2NVc2Y3WWZXSHJDZjFIcTVHckJOdXhqelR6?=
 =?utf-8?B?cnQzU1RxUmNLUitpYVpHZzRXbWFmZzlMNGovTCtoS0lCMGJ4YzNLYlFIWWw2?=
 =?utf-8?B?ZmEvWU1OZzdJTFNnMlUzNXpTejJBTWhIa0ZjTXdaVCtha3RNNEJOTGd0Nmxu?=
 =?utf-8?B?ZlFJcHRKb3RwN05iZkpuUDF2eHVYN3JlVllWUDVIWGhhUnhlNXNpemY5L2FL?=
 =?utf-8?B?NndZQk1QODJFL3l6d21pM3l3TUNZZnc2eUcyNmRrZG5YMXpxV2podGdZSkVt?=
 =?utf-8?B?MzhocU1hY2FxOCtMMkFxQ0VjSWZUaHNxcTJDRHVXRTdzbWUwYytoN2xZM1VW?=
 =?utf-8?B?QllaNHdnZDlVbi90RmNOenN3bW1GbkRzR29teCtiRENsdzJKcnpiN3hpb1l0?=
 =?utf-8?B?Rm45UHNyYmh3cjBycGdiR3pxaVZHVlhxaVpxVHBoRDZCMW81bVRBcURzWW5X?=
 =?utf-8?B?am5uVlVnVkF4d3R6RS9QYmFJRzloU25HbjBxTUwzdFpIZC9XbnhJNUVuTzVD?=
 =?utf-8?B?T2JaK3k5bTNxMVBweXJuYTlhdTNrdEFtRmtuNUZ0eFVPSTc0enVzZDdzZlpL?=
 =?utf-8?B?bjNwakpENVJWRTFrZlh1SVU5ZHRQMjZ4aGVYa1dOcG9uRkFiSU5RZzFUTFA0?=
 =?utf-8?B?QlIvaTZLWXgrRlJZSm5CMEFjOEQ5ZFZvcm40RUdjVW1ncWQ3MjhIVk1yeWJh?=
 =?utf-8?B?dHhYTHR5cHVIL1VHbG5wQXBwWThpSTkrdUhQWGVCVVl0amVyTGx1amM0T0RC?=
 =?utf-8?B?R3BtaHdkNFVKUGV1VDhvSjF2eW9FT3dXWGptSHNWOGx1YVRremw2REdESG5G?=
 =?utf-8?B?WGY2Y08zbjVpUVBCSnltdml4MnZVYXNsdWVnK2JsMHE3Q2xVSDQ5UjdIZUFz?=
 =?utf-8?B?b282QUZIUkhyWEs2dk5qcW5jL0xaTkFMeXkybUUrSEU1UkFBSklNc2pxa2ZM?=
 =?utf-8?B?WTB1NnZHN3ZPdWg0dTF6ODU4VnNjODJVeXA0TDdIZCtwMllCWlZJM0loS1dQ?=
 =?utf-8?B?UnNlMEhJYnh6M3ZRTlBQc2lNZzNVeHN6dHlCMW9IeUhDV0xibks0cThSdlFr?=
 =?utf-8?B?WFVqMlNhdDMvKzN0YzR2MDlUWWJFY2JWU3cyN1hjcmxEczhPbnAvZnNlK3Bw?=
 =?utf-8?B?MVdSSTN3TkZkSE9oUFlscEVaNDlSTkhEQXpORnBDcXdLRTFlZXZIdTJ4NlRY?=
 =?utf-8?B?ZHpNVTFTeE83dk9HSjlXWFd6WWdsWEk3a0xDTzlWU1QrUXVqU1UrenVRblUw?=
 =?utf-8?B?ZUU1NW9WK1Y1T3cxNWwxNE5DM0djSGJwNE1HaHg3SzFCSE5TOTIwZGdZMUNz?=
 =?utf-8?B?RysrOEFpbFphL25nd1hwWS9uMDR4Ylo5ZGVwNndwZC9OTWpFYVF6Zk1wZFhh?=
 =?utf-8?B?MTB6UWgxQytZWi9rYzRJNmR3blBmNDVqZktSVW1lUmJpVGxPNlpiYUxYSGI4?=
 =?utf-8?B?SS9PZU8zSGtjVXJPYmRzSTMxbzRwM2pWY0xHY2pGbDRFOTl5eWYzaGRqVDJq?=
 =?utf-8?B?Tk43NDdZN2JBV0hUelI1QnJmSytxbytsb1ZyZzNyQTZiK3NGc29OK3pkTHU0?=
 =?utf-8?B?NE9OVm41dnU2RHlNUkJzYmF2SG9tOUlzZUhLL3dSVDJKMlJTMWlMTXlFbnFa?=
 =?utf-8?B?M2p4MTRkUUhzRzdxQVJqOUF3M1FjVjFlLzQxVXh6UlQ1NURFUVRLMmkzbUpa?=
 =?utf-8?B?emVjQS9mUk5scDhEaU9KZklnR09yRkxNR0l1WGhLUm9SSDA1a0FCZjhFR2l4?=
 =?utf-8?B?c1MxUzFxaitrMVBzM2YwdkoxUmM1SWo3Sk9QdmdxUlBhdjRkOHpPUnZTTEdX?=
 =?utf-8?B?V1l4ZjUvajZyajlSdTVUZ2Jxd3ZnTjhPWlBvTmdSUzVESmtIU00yMnNrMnB2?=
 =?utf-8?Q?ExB+Idy2uMGf4IYuCvkDvZ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NXtgAl1R+uxGeV8AD+zPHkuoQUwMfBHtyDjLRAEGBciDF7G9yde9w0GrkdaJlmmB5rvCxRVhbwDHok+GXw0THEs5j193qQdjR/wjz4y+JtPU/LRD9hCT7x07vzyDDh7fgmjvbcYpWLgRKcbQeV5b8PIKjVLlcTANJnHlz4xwNclin3mTL7hYAT0mb2Be1XDTz5NR7HbdeYpaE+houPvy509UIWzk496imqwhWj6kHnwLi/nmoeEnhZKw3OFm7hOlcrPgXtvlQjms/6pl85at3xO754lB/B8F3EEItE7DyEfBSP/uN85UrdL6jBF91161IRYj9W5ng1RGmjVya31MhsECP2YPmoqZ4qOi/X/EBE/QJ59rkL7L5H0S32tH7XtEZWs+RwvLK8Bl3z+EX8ETeSRFjGiBSQAMG9IZhTHIe+/8AXouYCzpGGo6O02xbVda6ha1Wo0E5OZg15ba6qK9VkyG7+YpHUQa7Vh4S078S2vdX7j9aSHB8LWyz2JYhbcz+xEAfiYm2RT1mDIRRcmhlGytN1IAH38AQ/Hbezt9Ac57z+14bEPaZu5Ey/fbsH0ZPU6HtKhkL5X1bxj698OIjQf+oouvtCy6zYMnwP06jcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599424fd-312e-4ee9-9ebe-08dcd6f1cc77
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 08:21:58.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I1Jb4s5zPDdgNZKFJENyBKOiKmgakDrjiINpO12MuHbAPljP3aUNvky3XYbUTdl271FgXLuiatxJiBgliKdIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409170062
X-Proofpoint-ORIG-GUID: OPAAK6brwkOKhO15ZQHmzmi-g9dJHNGq
X-Proofpoint-GUID: OPAAK6brwkOKhO15ZQHmzmi-g9dJHNGq

On 17/09/2024 05:40, Eduard Zingerman wrote:
> On Mon, 2024-09-16 at 11:16 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> hi Eduard,
>>
>> you've added support for multiple declaration tags as part of this, but
>> I wonder if we could go slightly further to simplify any additional
>> future KF_* flags -> decl tag needs?
>>
>> Specifically if we had an array of <set8 flags, tag name> mappings such
>> that we can add support for new declaration tags by simply adding a new
>> flag and declaration tag string. When checking flags value in
>> btf_encoder__tag_kfunc(), we'd just walk the array entries, and for each
>> matching flag add the associated decl tag. Would that work?
> 
> Hi Alan,
> 
> That would be something like below.
> It works, but looks a bit over-complicated for my taste, wdyt?

yeah, I guess I was thinking the kfunc flag would be checked along with
KF_FASTCALL, but the code already knows it's a kfunc, so no need.  We
can add something like this if/when other flags are added.

Sorry for the noise!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> --- 8< ----------------------------------------
> iff --git a/btf_encoder.c b/btf_encoder.c
> index ae059e0..b6178c3 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -39,7 +39,6 @@
>  #define BTF_ID_SET8_PFX                "__BTF_ID__set8__"
>  #define BTF_SET8_KFUNCS                (1 << 0)
>  #define BTF_KFUNC_TYPE_TAG     "bpf_kfunc"
> -#define BTF_FASTCALL_TAG       "bpf_fastcall"
>  #define KF_FASTCALL            (1 << 12)
>  
>  struct btf_id_and_flag {
> @@ -1534,6 +1533,15 @@ static int add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, const
>         return 0;
>  }
>  
> +enum kf_bit_nums {
> +       KF_BIT_NUM_FASTCALL = 12,
> +       KF_BIT_NUM_FASTCALL_NR
> +};
> +
> +static const char *kfunc_tags[KF_BIT_NUM_FASTCALL_NR] = {
> +       [KF_BIT_NUM_FASTCALL] = "bpf_fastcall"
> +};
> +
>  static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc, __u32 flags)
>  {
>         struct btf_func key = { .name = kfunc };
> @@ -1559,8 +1567,11 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
>         err = add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc);
>         if (err < 0)
>                 return err;
> -       if (flags & KF_FASTCALL) {
> -               err = add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc);
> +
> +       for (uint32_t i = 0; i < KF_BIT_NUM_FASTCALL_NR; i++) {
> +                if (!(flags & (1u << i)) || !kfunc_tags[i])
> +                       continue;
> +               err = add_kfunc_decl_tag(btf, kfunc_tags[i], target->type_id, kfunc);
>                 if (err < 0)
>                         return err;
>         }
> ---------------------------------------- >8 ---
> 
>>
>>> ---
>>>  btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 43 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 8a2d92e..ae059e0 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -39,15 +39,19 @@
>>>  #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
>>>  #define BTF_SET8_KFUNCS		(1 << 0)
>>>  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>>> +#define BTF_FASTCALL_TAG	"bpf_fastcall"
>>> +#define KF_FASTCALL		(1 << 12)
>>> +
>>
>> probably need an #ifndef KF_FASTCALL/#endif here once this makes it into
>> uapi.
> 
> kfunc flags are defined in include/linux/btf.h so these should not be
> visible in the uapi/linux/btf.h, unless I'm confused.
>

ah, ok sorry I thought it was UAPI, never mind.

>>
>>
>>> +struct btf_id_and_flag {
>>> +        uint32_t id;
>>> +        uint32_t flags;
>>> +};
> 
> [...]
> 

