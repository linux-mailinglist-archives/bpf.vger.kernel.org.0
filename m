Return-Path: <bpf+bounces-48545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BFA08E35
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FFF3A7C97
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5020B1EC;
	Fri, 10 Jan 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnB8ddoD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TtPxXgkd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC120A5CC;
	Fri, 10 Jan 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505617; cv=fail; b=dA7WV/98aft+C5YItLAtD1XyCQXzlXzg+5H/dSwGjfYv5t+2PjToM0FV4b8UkGk9RogZPB7/+AfTV4vj1XmbLuQjQrq2rAwcoK1IXLdnwSmo2uQWykmJGVsJD7KmTmWVDB0R7lCy9lR5DNA/e1AEx2GRzWkSYLTJ1Y/u060A6Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505617; c=relaxed/simple;
	bh=iOiWFceoVa7W3fZUXKXhGyFaT6v27o5JWHp0VBZYw6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j08HYR6LLkOwbvezN+tv1yOpFQNRWBYfPnw0dgOhibJSBQe7UXJFB6wA4US9deQsJ+FnMpV7M+3SSs00lDEPOdN8HIiGi5S06cWqlgeXGGRWXM2rq97ozBEfep3Mz8LhMaj5QNr8kNV6gNkGe5B2wKYocl08u5kc+hM8U//4ZAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nnB8ddoD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TtPxXgkd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9CdwJ018267;
	Fri, 10 Jan 2025 10:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DYdaDgsKAeX9YGwggVOrXWxFqGgHCHOBlo4o54bm5yo=; b=
	nnB8ddoDzkaAjURkAEa+Y6oGl2y/muD04tfdj37Zja+MfxQiXmaDtNCRVFLsIMmy
	H7mwfKJBjvHUIfM/syqwhssXJlGLJrAFURH/n/Ef3JTsq5t1IikuX949IJOzLVcM
	R+TVDHtxtxWra3sHuGgkIMvFA4sjuqW3kQ8CT395AS2kxQKi5NOJLt9BO7i9CDWj
	ZbTZBEz/2TmfdMhKkRoMhNaSuJPkRtBq6HphDmjmAYndDyBk8LL5B7S2UbC4qlRU
	XIeKhsJX9Pqeeo80j38MnndTHE8BfmC+rLGzxrphykPDr2ciWMBC2qEuMxrb+HlS
	n0CqOObVMvTECg/rL31O+A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8uj91a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 10:39:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8YMeV011166;
	Fri, 10 Jan 2025 10:39:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuec51ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 10:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR2WPxLTo+KsTeQApxBodafi9CkLkVisVyiNlPxsLVcZSW7ukq/RgzXYtQY1qhzTnLF0KE7qqNWMkIqMDWX6v7uG0xgeYRew0aYkFa5k/9zLe3oQWUF8vDEy8kjos5zoCMnyL8jMQUVOtw+cYcBdzqYjreLipj84Iksukf7mhad4KwJOvI4PfsvWySvIAEyqCJyWXqEdV3f/ecHb6EcrbX4lxwtOCbQ9dAPoqOu5ZbcYbxsTiG17bQjBZgInWt5mfedZGRIhCGTrzA2d66Ol1kEarutyB+GFNLnpWq74pEvOls/rOJqFCNov+5X8bNpBmQNSFrMnFMR7CgsCPro+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYdaDgsKAeX9YGwggVOrXWxFqGgHCHOBlo4o54bm5yo=;
 b=NY+qV1MIqA/EID0ffJAR/0WCFsXnBqVnfqtD+q2aNmB8g/TtTUVZW7k6khNN9qEA9i3+pUB2Ya1Kwwp9IQGjAG+r2zWj7U3zc35t1NQLzpXp9Pr5dWmRLy9TzTVcoscELRNTI/vAtoAztLJytlV+Fwxo/R2K2Nnp/Wq27BmnmNxZBY3F2p6WFYJT3imS20G8XfzypIyrpDQcsjoDJPikCtcXOVKgaCgOHdjL8SRSOaF6u8CEefQOruhW1gy9ECXvu6tJVXbBCkqWCeHstpQwuOkzUixsHXaMXF5btx95vfR19ggU4XynoKcfr8tCJ0j9PGrzxJJ3vofc/tvW0sCCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYdaDgsKAeX9YGwggVOrXWxFqGgHCHOBlo4o54bm5yo=;
 b=TtPxXgkd2Hp7Bd/U3gyyGnxPsd54OeOZ7bNQCclAIJk/p5wr20MPZKVDe08eoO/R7ywduYanIkuDXx6VgXu5JLD4UMrHPrF4PsL0Y2fK2RFcogNskxNlt4zBqSbaOm8zPrYM5Id4H5sqKjlks75Vp9rFZqZzjf04YiUUs/0RZ6U=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.20; Fri, 10 Jan
 2025 10:39:55 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 10:39:55 +0000
Message-ID: <3f5369ba-7bbb-4816-b7d9-ab08c48870ae@oracle.com>
Date: Fri, 10 Jan 2025 10:39:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org,
        mykolal@fb.com, olsajiri@gmail.com
References: <20250110023138.659519-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250110023138.659519-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0697.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 16dd959c-7e6b-4cad-27d0-08dd31631ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTF2bzViTlFJVTFQa1ZwRTh6MTMwanVPbVpJanZSYlJSbXJ3Wk0zV0FVL0JS?=
 =?utf-8?B?aDNHMXVRSUw1K0dFeTdDeklBdHhwOVF2TUVTdld6UW1OdnRtUCsvVkExSFRO?=
 =?utf-8?B?aC9nU1lrY0dudGl3b1R0YmhHOXY5WG0wV0lBUjM5QlNURmRSYm9PWW5OVEUy?=
 =?utf-8?B?VjlIZFcySGpGZ0IySnhKKytaVUJ5UXRiZEVwMkdqQWdUYzc1STZsMHlxemRa?=
 =?utf-8?B?NXBjbVZnWngrd1k5ZGI1NXVWcmFKMWk4ZmdtZWZybnNLcFhvOXRIbGprUWhW?=
 =?utf-8?B?VUZmWHNza0VhMlBsWFk0djFlTzliZzA2K21PejN0cHBKTExrQWljSnJHUFNz?=
 =?utf-8?B?dlJUNTRHYm5qQ1pwUmQ5Q2dCUGR3R0MxQzlvSmZHZEVMNDFlRHZseVBLMDdW?=
 =?utf-8?B?RFJBZjBiK2lMU3ZQc3Vvd0FsYWJLSVlkM055S1dnRnZYMjBnQVczWlZ0Nm5R?=
 =?utf-8?B?OGRzTmJsNm50WVZXTkkrejc5NVJyeTdhRHRpbDN4VHhLbWhyUENZM0lxU2Nx?=
 =?utf-8?B?RXIwSHcrdDJkKzM5TVdYUVRYa01SQnhXRHRkOVAyN0lUd3FiT0dDYTBldXRB?=
 =?utf-8?B?M2Y5SUsxTWVpS0hLMUVVM1NrTUVTTFhqY1VTM0tQeWVqdXdpRnFoeWJLTFRz?=
 =?utf-8?B?Qmxld05OY0c1bm1RUm9LSTB4S01yWGFxaS9panVzSXpzWWo2amtTZThZcFJZ?=
 =?utf-8?B?ZnBZc1dGVG5CSUpyQjdCOC9xcTBWeFJOS2oyVTlkTGI3N3BTanFkRzdEM2tP?=
 =?utf-8?B?NUFSL3B5ZFVLRElzN3hEekQvbjFnVElyT2JDM2hFRUFMWEUyYjRxRzc4Rm1C?=
 =?utf-8?B?UWpFZXV6OWtWZWFudUYwWkhIMjArdWFXckhXd2daWFg4VzkzTVllVi92MEhF?=
 =?utf-8?B?NlhyQk5LZjVSZTFYamZQb2FRclZaN3RlOS92QnNkWmRnUzc0b0ExZkozTk9s?=
 =?utf-8?B?T0dWMUoxL0docmMyS0piekdITGZTRE9GMW9FazI3djF4d3lxWkxiTG41Rzcx?=
 =?utf-8?B?SFVuc0UyYktLYXh3RmU5dzJCbzNlQWpOS0lXNDJmaGRUamZScVpwczVSNkw3?=
 =?utf-8?B?MTIyaExLblBZQURNRHRxWU9QeGpZcElxUTNVaUI5SHZWZFMwYVB5UXo0azJp?=
 =?utf-8?B?R3JPVmF2dXEwQ1V5NXZEVEttR3I0TjFCTllKeEdXQmxUbVhsY2t3WU82ZjRj?=
 =?utf-8?B?V2dPcEtFQ1lqSVlsc2RsL1RjZWlscVBhQ21QMnNNY0FTMXp0ZmZXSlJ6Y2dj?=
 =?utf-8?B?LzAvRExvZWl1QVA2TCsvak9QaGN2UFhVRzRrMGVyUlMySkRET2x6WUJZWmxw?=
 =?utf-8?B?d0xaQkZSN3RTRjBKTHZEWUVmTG05UTIwZE4vc2Fyb3dYSG9KSzFWZ0NEUlU4?=
 =?utf-8?B?Rkpqd0c4bkxoUW1ndXlmd3dwWXVad2k5N05BNWpxUTNhVEpZanZodjd3YkVt?=
 =?utf-8?B?aWNsM0IxTnQ5a01MS0hjWkFId3VyOSsyTmxUWXg0YnlWUXNTNWJaM08yOVha?=
 =?utf-8?B?S2kycS9jR1ZlbHZ3TVk2THhBSWpBeFRIS0NYUEZycVRFa2JHNzRvaS9rbVYv?=
 =?utf-8?B?bTRFN0FJMkpDSDAxbVllL2ljVldtRUNnZVFhMWFqK1BnbU1haDViRXZLdlM1?=
 =?utf-8?B?U1pNSCtqU3lPaFVlVVR1L1Q1VEhhditxRnlWU0hSMmN3a0d5OG81RmhPUkNt?=
 =?utf-8?B?QlZBRGwxU2lEeG11aHRWbC9Wa3o0MCtLeCtBYklNQ2lIYUptaE5Wb21RUGN4?=
 =?utf-8?B?ZENvMlZzYngxcWU0aS9HbzZzTWJXMDJLanpvTmh4MUVTUllEUWcwTHM2NVkv?=
 =?utf-8?B?bWNwOXpEbTZRSG11eGM5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVWcEtwSmNzLzdRdE4vZldyZVRjUE9paStYTk0rQzlCNE5QcEI4L3p5TVMx?=
 =?utf-8?B?WHh4MDF0MmlGWVpya2pEa3ZGZkJHSGZ6aVZLSGhsL0d1Qy9zaXNkY3NtcWx4?=
 =?utf-8?B?cmZ4K29WZGJzSGx1MHhVbFFYRjRudW85T3d3T1hNcmZjTS9xWnRQU09qZzZF?=
 =?utf-8?B?NldTdlZTQTE3QTdoL1RhN2xaczdEY1RiVGhIcVE1SDA5L1J6NmkyTXV0UXY5?=
 =?utf-8?B?aEI0bWFzYXBDbSttbXpoSEdlbnhQK0NmVzZQNTJWdndoTitlN0xvbStNMGNG?=
 =?utf-8?B?a0R6bTQ1c2pyVk1uM2tTV2UxUEg2cHNkcFl2dU9WV0dlWWp4V01iV1gzbExV?=
 =?utf-8?B?VURUcGxweVlHWWtrS0o1SkRid0R2bEEzUVp5RVdSVVBIc05CckRTdXZMa2RE?=
 =?utf-8?B?TlpCNUZDcTBLeWF2MDFsTEt5STVhUVhnR3Uxb2xNM2FLb0sxaXlDVHVsQldQ?=
 =?utf-8?B?QlEvZE9yUmNkdklTazlHNmFUcHFySE1sRk04R1hObUpyTzd6dHZ0dzV6RUdD?=
 =?utf-8?B?eTVvVkNiT3VkWkZNdEZMY2dhcHBsRUdJN3k0d0hselgvTFFYbmpla3ZrQUo4?=
 =?utf-8?B?RnlxN1hsVSt1N29SVVc4L3BTOXl0VGpITVlSZVJZYW56UlVTck5NUUJ1d1BG?=
 =?utf-8?B?NTZidmd5WngxM0svNjJqYnhLSnppTlh2Q0dpSHdxSTVSUTQzSG1XL2dYdVVm?=
 =?utf-8?B?L3NPYmNuNUE5d1NEcmJYNVY0NUZTMnJDZ2xqa3ovNGJmK1lRYnJRNVZ5T2Vw?=
 =?utf-8?B?aTRIcmpENnozcnFyaEUrSkE2aENMQ3lXNlU4bkZGTzBvLyt4by9XYVBDODVV?=
 =?utf-8?B?a2pWNjRqenQ3M1ZrT1orblVKRE5BaXNSZkYzWGNMdjBmYnlWbFRpbW5teUJH?=
 =?utf-8?B?Wk1IWENzNUx0MFN6dS9vNTBXckRTNktWYkpnODdUQUdBVGxuWkdTNURYZFRw?=
 =?utf-8?B?LzdRUVhlNVloSFlLeEVCV0ZGU2RxRzRUS1BhRE41SHBobU5Qb0w2VmZYelhR?=
 =?utf-8?B?TU9mZFJ4enR2SEoxbCtJYzQyNGhtYnZEaXdvbzhMTllvMTlDSklVb2RSZUEx?=
 =?utf-8?B?eHVUbDhpaGx0VTNMZ0lmZE1ZNkRpZFVSVExqcDFFK053cDV3S0k0ZmJBZ2l2?=
 =?utf-8?B?R25CMTN6S1pVS1FURTdpdGZvWHBRVVpRb0g2emJhdVNiSU5XMnVYcVZVdXBJ?=
 =?utf-8?B?cFhGcnpQWkJYT1ZUT25Ic2tPY1B1Mk56NUxwYVZ3U2pkWFJSK1NYSlU3VXZJ?=
 =?utf-8?B?U3VWb3hLTVVZQ2g5ZUJrSk1GUGcxMDJmdFpMSms3eGNoNHkzUXo0aFNTbHZx?=
 =?utf-8?B?TVBLNnk3V0E0Rjd5OVJLQklOell4dzdFWEhjKy8yUmRGNnF6QUIwN2pmUEw4?=
 =?utf-8?B?WXlON2pHWTlsTmYxTnRCQlhTaWx6OGVxY1lSRzJiWE9Fclp4Z1crbS8yb1FH?=
 =?utf-8?B?VVJxOUcvK1BBQXI2R0NLdk9YQUV3cHdyd3c4cXJmeU0vMXNEZ0htQ3A0U1Bx?=
 =?utf-8?B?d2dydUF1b1d0MXRRbWdWSHZUczI1UzhBbFpIV3RxRlFPVmZYK3hlbE1TNzZP?=
 =?utf-8?B?b0V6SW8wREpydTVrTDVWYmdYNVlGWXhoTmdrU2ZwaGxrb0hWUDhmbDVjMWxh?=
 =?utf-8?B?d2ZURkZDWUxReXJ1YTRZb3FPRExRVFFESWFSaXVycDBsT1M4aUYyRVB1dzBQ?=
 =?utf-8?B?ajRFSEJaNnQ4YlBkU0lHNllOT3BuMEZ4T0hhZUM5c3ZObS9LR1JBa2pTOG9n?=
 =?utf-8?B?UzRPR1RDYk93WUY0V29EV0h4clB6akhrOER2c0JIME1BdXIxSTdqSFFGSFpF?=
 =?utf-8?B?dHBydFQzYWYvN3Z4STAzbVRVeUxMYURGNmhMY2JSYXFRTEU1VDZSWEN2czU0?=
 =?utf-8?B?Tk9sdUJjU3hPbDJhd3pJUUgydm9YU1FWL1RrNitWeW9xMVpBeE5QaEF6VC9n?=
 =?utf-8?B?aDlvczFSOHFEd3hlSlFMZEJkbE5USkIxUE83OGpPdkZZb1JiZkxUWitKOHFY?=
 =?utf-8?B?MHNnUkJoa09DWW1BcWVxK3RwNzhXTCtxcGk3bEtmalVWWGptSjdHNXQxQlZE?=
 =?utf-8?B?QmJUV2NmVXhnK2VXdjQ4VjFMK1lkeU11WWs4RDhsdzlBbTBFcW1vbUZUL2dt?=
 =?utf-8?B?VWtrZjlZTEY3QWF0K3dsTGtZdDhlbU1ZN1ZRU2l1b3Q2NFp0ZUtTci8xUks5?=
 =?utf-8?Q?i08ppIDpp3MO9HAnrq6TlrI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoIAJsoWo7lLZC0oRV1dcnSHNLtD7t0+Hybi+9F1Fch1il4++rw+TxJpYUCmnpn2/b90PTmv9DjYmR9DIPALsnidF6z9a4E+1TYNLYqMU0BInrLHUp0WvcmKdlthPurl8Oa+JdiydQ5FA4wNpRqgrqHae0WPWPsI9CBmQAjN+Yblc7YRiOmwB7h9Q1m07PtoimmXmtToKSK3xYVf51w65xOd6uSsjcKODZo1E+nxNlxQVlv8+SfyiJVtvdJoy4PgO8RbMRpkysBECMqObjmjxGo6PbDiKqSwycFnAeIs5lanf+kgSMVB0SRxJEMXLGY8T3s66Rdh5fvqQp9pSK0egvLwxXYv/9X/upBaa7UPnqF1WLwEGT+1O8gEKO/2PDGrp8OdA135tN4p6RwtlBuEynKCbRc8LsYzeWruc3KgEY3R0KMXBLrE80D5J8L3J/mGYa3Sh2QSKeZEHCzlPhctiPFy6xH3VjzI9MvpsFd5zLV0FlqzcG0ATtpxQ5feD1a5jFed/wpW5UIOqCkLojimprAZ5Zk2DZ8pqkDYISuLG0idUW6g02fREGO3+xJtXkajKKXIhqUO2dUuwaSkUzlXt744WQn1iDa5vWLdEDY0tbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dd959c-7e6b-4cad-27d0-08dd31631ed1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 10:39:55.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwVgHbVUjR1CkKvET0L1SI2IAolY3lk006zZEp0A0DcaKs5oL66p3vXDAxKe2ZMJn07CDdwN1DsD8zVhhEhcTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_04,2025-01-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100085
X-Proofpoint-ORIG-GUID: ApaS8ZmULEu0S4SL2tpLjGKTinUl9Go0
X-Proofpoint-GUID: ApaS8ZmULEu0S4SL2tpLjGKTinUl9Go0

On 10/01/2025 02:31, Ihor Solodrai wrote:
> BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> into the master branch.
> 
> The segfault happened at free(func_state->annots) in
> btf_encoder__delete_saved_funcs().
> 
> func_state->annots arrived there uninitialized because after patch [2]
> in some cases func_state may be allocated with a realloc, but was not
> zeroed out.
> 
> Fix this bug by always memset-ing a func_state to zero in
> btf_encoder__alloc_func_state().
> 
> [1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
> [2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.solodrai@pm.me/


Thanks for the quick fix! Reproduced this on an aarch64 system:

 BTF [M] kernel/resource_kunit.ko
/bin/sh: line 1: 630875 Segmentation fault      (core dumped)
LLVM_OBJCOPY="objcopy" pahole -J -j
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
--lang_exclude=rust --btf_base ./vmlinux kernel/kcsan/kcsan_test.ko
make[2]: *** [scripts/Makefile.modfinal:57: kernel/kcsan/kcsan_test.ko]
Error 139
make[2]: *** Deleting file 'kernel/kcsan/kcsan_test.ko'
make[2]: *** Waiting for unfinished jobs....
/bin/sh: line 1: 630907 Segmentation fault      (core dumped)
LLVM_OBJCOPY="objcopy" pahole -J -j
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
--lang_exclude=rust --btf_base ./vmlinux kernel/torture.ko
make[2]: *** [scripts/Makefile.modfinal:56: kernel/torture.ko] Error 139
make[2]: *** Deleting file 'kernel/torture.ko'

...and verified that with the fix all works well.

Nit: missing Signed-off-by

Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 78efd70..511c1ea 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
>  
>  static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_encoder *encoder)
>  {
> -	struct btf_encoder_func_state *tmp;
> +	struct btf_encoder_func_state *state, *tmp;
>  
>  	if (encoder->func_states.cnt >= encoder->func_states.cap) {
>  
> @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>  		encoder->func_states.array = tmp;
>  	}
>  
> -	return &encoder->func_states.array[encoder->func_states.cnt++];
> +	state = &encoder->func_states.array[encoder->func_states.cnt++];
> +	memset(state, 0, sizeof(*state));
> +
> +	return state;
>  }
>  
>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)


