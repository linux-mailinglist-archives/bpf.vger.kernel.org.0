Return-Path: <bpf+bounces-42891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8CF9ACAAC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E10B21133
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575351ADFEA;
	Wed, 23 Oct 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u.nus.edu header.i=@u.nus.edu header.b="EQvUNy/L"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D31AAE1E;
	Wed, 23 Oct 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688660; cv=fail; b=dY2fQz3Ons4cTWmQQm7rHAQuarcPbJFNmZ5/NumI/7YX9wP0bUqxxRAxMR4y07jlWD9MnLoTc05AMXzZ3z8WuPuT9gMdFjpXe7zAiG3IlIx7butLXTh5y32gP2rhCGO8UzNM7T/1jPU6tGcKHPVC0hWfjTrO4MV1VZNQxituxjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688660; c=relaxed/simple;
	bh=0ARJvvzTnU1njEY88FTazpuaQZ9GtN2e1rXesu5JEQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mxyI29dcIuBbjoaVx52tFoZpf2WC30JRlDYVhx43hLWIiSifQXNi/u+946iQPqJYFfrNswss0P3KnjdJk7cu6mG51wjbe6j3s3KUeNasuf7jPO9FzKy/c/VWYIaUKXyIwFvGk+RPaspBK/Cbtce9yhFIANAXpqnCocNBJoFQC40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.nus.edu; spf=pass smtp.mailfrom=u.nus.edu; dkim=pass (2048-bit key) header.d=u.nus.edu header.i=@u.nus.edu header.b=EQvUNy/L; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.nus.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.nus.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP/qVn+lay/I/byMp/77RZMgcrA+hDdt/zNp52nS3ujMZjTywlftUoVxYNr9Q7MsBNSjMjEeBbh14Ln4T2unqPDoAQKthmXjeBzP6moY7BhvEb8c/7wMFMdK0H0QYSzYjgfN0W5r5R9oDA6+jnJvqq128munWlWesHtwqBVWaHL5ZZcja3WyHaq2Zu7h3VJmXTEsaPD90iRChksQ1FfnBCwg9YJ6QsFaiTWKshZ0G7/ZRijoySpeR3gGDs4YeDNW2GIH9M+n7yrSDQbZGEDtB/zDmjyjpliU9IP/etPqnddtsW+5D1KbDmANGX9UOsjtI6cyeewGeyQjhEZr7N5+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ARJvvzTnU1njEY88FTazpuaQZ9GtN2e1rXesu5JEQ8=;
 b=JYOG2Cmduj/v2tvjS7ZzJBwDSMdYS2g9DgcxAKjIEmDNXpIlu1MfcvkGzgb5JMZmCYLY4qGm7kS4Xx0GXCgR+P18EkOO7VuYk2Rqgoj/sk8FkDqJ7dusWrlJUpCZw9+ALpBUA5G8JM2RfMoPhRzRw06n7X6jWEj58N5k4SjuTPQfrl4rzvByyI2t5xIXvdzeGRivfa+l6BmTJ9ITAtpHraJkFygdSiTcnw85CWHT3KxbyR/Vb4rlmJp5cVhVF8ZvFO9eJ21Nx9lGzmeZfpLlVBmO5aWAJfdjLtlQuPa948q9S1WrAeV0KESP2KweWsOTnPb5viXUpTVDX3CYHsCdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u.nus.edu; dmarc=pass action=none header.from=u.nus.edu;
 dkim=pass header.d=u.nus.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u.nus.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ARJvvzTnU1njEY88FTazpuaQZ9GtN2e1rXesu5JEQ8=;
 b=EQvUNy/LxdRYYi3Z68BcL+ICWj4sj8L/3E+s2FmIMaT1mrxUOEZ8SwbsToa2nbaLv2qfYt2w5ZYoG4wpZ0zh5/EMnK6z4clVHx3A/Kq/g6M/dXZEu8zdOT/BaRvYvgX+K7KrKmT+escCunOP2hb1RagnOMLAtGgsPSV0zjSKcSNFS9mz7KfdoE3qb4cGW5Sc2NTtu62oApt+7f/2vLY/OsfL5o9wjaoPjMzoy1cB4915XAV0Z97fEx3q9af28ysJJpf/tBRz5pq8uqOn0q2dmplEeH+paDelfX/KA+0fw0gX6IKKApvg3ygO+f0oa6nZKKfNPAT8FG/stBWjxaQjEw==
Received: from TYZPR06MB6807.apcprd06.prod.outlook.com (2603:1096:405:1c::14)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Wed, 23 Oct
 2024 13:04:13 +0000
Received: from TYZPR06MB6807.apcprd06.prod.outlook.com
 ([fe80::5bd7:7352:17f9:fb65]) by TYZPR06MB6807.apcprd06.prod.outlook.com
 ([fe80::5bd7:7352:17f9:fb65%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:04:13 +0000
From: Ruan Bonan <bonan.ruan@u.nus.edu>
To: Jakub Sitnicki <jakub@cloudflare.com>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
Thread-Topic: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
Thread-Index: AQHbJCX0HcR/EMM0jUCKHbBO7jzETLKUTExBgACJoYA=
Date: Wed, 23 Oct 2024 13:04:13 +0000
Message-ID: <05A2E6E1-143B-4BAA-B346-320514E4477D@u.nus.edu>
References:
 <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
 <877c9z9e3x.fsf@cloudflare.com>
In-Reply-To: <877c9z9e3x.fsf@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u.nus.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6807:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: 1883d498-07b4-4d4f-e9ad-08dcf3633166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blZ3Q0ppZ2F6MnpqWlNMb0t5QXBVZk00cGdDNTdGb0o2cTNuSG16Z1lmeDZx?=
 =?utf-8?B?RVROS3dwTzRlb0lnS0d4M3RlVkdqWTNYRThQMzJrTlRWejJGZ3NybEpzTllQ?=
 =?utf-8?B?Q3RBT212N0Q5dU45Vlh5cnJQYlh1My81V3VydGJlNTkzNW1INlJnM09XNUp0?=
 =?utf-8?B?KzZyb1MwbFltcGlSM1FKVEUxUVJFZVd5dCtxZENUdE02c29yRnhKc2xwZDBj?=
 =?utf-8?B?UGQ0UlVML0p1ODJLN0UvVFN1djVBVnhSa3FnZlZ3TWdaUTZEOEhTcDJ3aVo2?=
 =?utf-8?B?TFJ2dmlPZER1b2lxeGxXcFZWNFhMRk16SlFjKzNVUXVhcWFMQmlFRkxvOTVq?=
 =?utf-8?B?OGlhejVsODlXa1kzUlZLeUcrR0VxVmZXRzJYSW4vc3hrb2ppWFVEU0FzSjNI?=
 =?utf-8?B?UnRUWlMyejFuT29XRzRLNEhoekYwbm5pZm5lS0hKN0pLRjBzbWRvS1FrK1A3?=
 =?utf-8?B?S1hHUlJxWXloT3dXUXd5eFBJRTBoNlU3Y3Z5TnFZMVNhN0dzMUFGbE9aWldj?=
 =?utf-8?B?enFldkhUazk2blNqaTViWlM4VWs1a3dHcUlvc0FyaDhCUWZsbnMreFR3R3d1?=
 =?utf-8?B?eGFKaldFd3pySE1kV0VWRnJZK2h1VkpubmRhUUd1TEZjN1RIS3ZLVjl2NklQ?=
 =?utf-8?B?TlFYTUFuWUFmc1I1Sm42c3crcDl6ZHdKZXQ5Rlo2MTF2MDZmR2RjTWl4dHdM?=
 =?utf-8?B?VkJ5TjVwOWNYM3FoSDd3Y1ZWTm83Z2E1NmpLYkVDY3VZUVMzcElFTCszUWly?=
 =?utf-8?B?Zm9Hc0hOYUZUTmxSVVhvNXlrckJxUXpSV09sajNRbVhaSmdXcVJqd2lkWUFw?=
 =?utf-8?B?NnRVcStKZlArVk55cVhPRGRvVG5vTnpXT0t5NVRSRUFzZXlib2RIdEQzMGRB?=
 =?utf-8?B?ZGRRbDE4cmxWTWZILzhkc25JVE1rQk1iOThkdUFrUE0wVysvTnNOSlhOY0du?=
 =?utf-8?B?ZWhIZ0VBR2kvUE1YZDVwTHlQT0NmU2pyZjRVZGdsc2U1SktvM0ZqWndjM1Az?=
 =?utf-8?B?TzFaQ2xtQ016MHRKaWhxWk1wbzU4VWV6VjRndkt3dnNkZS95TFlNbTB2eHZ2?=
 =?utf-8?B?UURFR2hmSlQwdm5uSXBVa2tjUzNWU1VoaXRWVy8rcmtjK3BNcjdlWkJmQU4r?=
 =?utf-8?B?ZWJwTlRtS0tuVUJmWkE3Q3FqdU5yd3o1RzF2eFk2ZTlhejM1KzUrUVplQkN1?=
 =?utf-8?B?TTUrMDN5Z0pyT1A3MkQxQWVycWVWVGRoODQwVVlSVFQ0TUFCVVc0eVIwTlQ0?=
 =?utf-8?B?dDVIODFmZlNZZHFzYlNwMTlONlk3M1BwcGgvdVNlWjNQOGNCZmVzSVBzQk92?=
 =?utf-8?B?Y1N0WkFKT0J0NndrSGxmeUZuNTkyM0w2bjBaZFhJSUNFdVk2S1lxa0phb3BO?=
 =?utf-8?B?K2dydVFRTWhhMXJURmVqNzlGdTFhQkQ5aFN2dG5yMkRsZXVjUGdIVFNBVDBa?=
 =?utf-8?B?WkRZMi9YNW5GOURrWisxN0JLeURFcHM2Unh3dU1VVERXMTQ5QXZsWmVzaFdV?=
 =?utf-8?B?dlZoR29QVmxJVnA0N2hCRWFtMkNON0taeENnZ1V0NHNEVWVPaDd0V2lTK1k0?=
 =?utf-8?B?cFd0S201ZHJEUmNKRHhULytFTnZ1Uml6ZUZHbWE2RG56Zlo0SDcrUm8xSy81?=
 =?utf-8?B?d2Z2M3BtWXZtcDZtcXloUHgzc044Rk5iNjdIdHhad25nMndBeFF0bVJ6U3p0?=
 =?utf-8?B?bkZVRjlDTXdvVThGdXhTNklERU4rYTZQUDFzTjVFQlpIKzBYc3dmTVBHeFFw?=
 =?utf-8?Q?ZXbkoGL0h9cDjnRQbV0TODadJt6K2CAsqClOYhc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6807.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2hpcjcreC9laXdmZFNGVEREakNBUzM2cXNMSFVCOHRVY0RSTytLYXduWmFB?=
 =?utf-8?B?R3NwZi9jQnZUelh1UTVGQ3VFd25MQ3E0NGh5YmltUFlCMzRzcGRtYlNmQi9I?=
 =?utf-8?B?dXUrN0RvNElkd2xlUVdJRmpnUHBFRkZJaTcxOFBhYStnclVkbk1Ya05yTTQv?=
 =?utf-8?B?SjZnNkpWVExEWVozQ2ZyTVIrYnFpN3RLSmJIZW92cmdyK2dnY1I2VzlxNjE1?=
 =?utf-8?B?T2xTY2RwelpTc1pGbG1mQTdGQkJUUDBCR08wVThBYUI5T3NISmorUFViNHBx?=
 =?utf-8?B?NHg4YU44Ukk2NVhIaEtKU2VHd3VJejF3ckpveWJqVEdkRjBuTHdQVys5RTVn?=
 =?utf-8?B?a3hEdFd1Q1ZtdWw1T0tvaS9hbkRtRkdoL1pSYnZkVGx3alNhK0JWK2M5bTVO?=
 =?utf-8?B?V0NTVDZLbHhMVC8vQ3krekhrL0t2M2E4dlAyTndncGZZb296ZytOS1dsMzdw?=
 =?utf-8?B?d0lBR1pOTjRiaDR1V0puSmU3NDhtTWZVNEpKUy9XS21CMTFnVEsrRnpmN013?=
 =?utf-8?B?TUxWMTBNQ2ZRS1RuRHFsVG0xamF4L2dEMVpVbzlvcVlzRHRMeWNwb3JvOVhx?=
 =?utf-8?B?dXMwNHd2eXZYa2VNQ29DQ1JxWEFzVTdPdW9kb0E2eG0ycWVzb3NVdTdRUFpX?=
 =?utf-8?B?MnJTSDIzci9EVHE4YThpaWU5NnBCL3g5OGp2MC9UR0RJcjVYVjhjcVVnR2JF?=
 =?utf-8?B?SDZBQWg0YW45aWtza1NjQnV0TXdKZmx6SUR2MXZhSHViRkxpNm0yY3pLRzlM?=
 =?utf-8?B?TE1IQlhtTlZCUlZDQ05sZmtSZk56UXVHYkQ0Kyt3TGNqVVpUQU9BOGdPSGVZ?=
 =?utf-8?B?OU9kZFhUL3R6bmU4cWwwTFprbkhHYkQyUFN1TDhRRlIzcm1GWUw1bXE1RlVP?=
 =?utf-8?B?RVBRQXF2VTJBVHg3N1A5Y2JkZGw4eE1VWHRHRG9uMjhhMlZLa05RSHplWEJX?=
 =?utf-8?B?ODJ6bmtqWFBlWHhJYWxmellPT1R5YmROMlc0dVpqNXU1YXVjNW13aC9naGhy?=
 =?utf-8?B?blloMk1iOHhjajIzZ1lCelZHMmxlZFV6b3BRbDFCTnhJd2NYVkN5SjdFcyta?=
 =?utf-8?B?YUJid2xMTEc0T2NIQzV6b3FDT0FCZHdYVE5lK2tvQ0JHdHZHU3BoV0xVRWZF?=
 =?utf-8?B?U0NkS1lOMi94TWJJS0NPMlgzWmVoN3VwSDhTZjRncTNVNnBndFNpMGtGY24w?=
 =?utf-8?B?Y1dXbUJNUEdFYWZCV25wOEVOQXNPSmpsYlpOcU5PU25pMWVuZmNLT0ZVdk5h?=
 =?utf-8?B?K2JQc3Z2M1Q1eWMwREVvcVNXbGdIWFRpYUU4WDJ4YWRUYXBvamtmUEpRYVFR?=
 =?utf-8?B?OTZFNC8weU9wenBIOGJPV0g1NmpqYlp1d0Vvb2lLeEVFN1lIRHhGa0J3SjR4?=
 =?utf-8?B?OFQ3V3ZoVVhOUHdxQkxZMTNKR1VSS250Z0xYTTBZUHZKeXhaV1cwZnZqVm1H?=
 =?utf-8?B?UUh0MCtYNVROK2g2cVlHUmZsUitVYm1lR2U3czQzRXJDQlF5TnE5Rjc3K1Zs?=
 =?utf-8?B?OXU0M1NlaWdDZk9sQy9jcFFTYXp6amNkL2NlMWxnQjBKS0R1L1Q4QjdOSGkv?=
 =?utf-8?B?ajhaYTlzeDE2VGhFOUlhMUZmMkhnU2NvUVcwektWUFdrRXFNSXhlejUxZzZB?=
 =?utf-8?B?aHNyQVJjM1Q4a3FiY0w5aHZBK1BZdFRoZEkrQnV0NUtJcWdOd3lneFhCbEZD?=
 =?utf-8?B?NmtxRS9uVElPbkY2Q0VqM1dVYkFra1pPSUhMSGJjSXc5N2RQalV0QWVSU0E3?=
 =?utf-8?B?WXF2TmZ5eDExaFFPMWh0SFUyemZMSGoyN0VxaXkyclg0ZFJ5UG12UDNxK2d4?=
 =?utf-8?B?RitLTkpNYnZFK3dMUFRtM00yS2FQdVdDOVVzdzdVdWpvZktudWpXbmtxQUd3?=
 =?utf-8?B?YW1HRW8zdmdBOXozSGc1RC9HR3FBZzQxZVJGYnZTVDJnTFUzbThIdVRpVjh5?=
 =?utf-8?B?U3JFNFdFWUcyL1FtTE9rdGY1ME41S2diTTREOFNyNjJsdVkyZE5sZXJ6L3Ri?=
 =?utf-8?B?d2YrSngrcVpKRUh4TmxhZkdlOXV1V3dVVWlQQ2VmV05HU1JjbjhieGtaWW05?=
 =?utf-8?B?TlRPb0hjaTNCcG8xTVZBeDg5aHM3QlVVM1RvMmNSTnYzVitmWXhTTUwxbWJ6?=
 =?utf-8?B?dVI0bEhuQlZhelRReEM1YUh4UHdlVngyeUptRlNTTFk5VmtsQ0RncTF3emhj?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <238A9E7B912E044DA48A1F06875403E4@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: u.nus.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6807.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1883d498-07b4-4d4f-e9ad-08dcf3633166
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 13:04:13.5791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDanYZPbGtyfv2Gz8HxhbVrp9deuf0vhQQ9S/MPj3Qpccpo3X1b2jItZsxfLMTMB8aO7Pm0tE7M4tnw6t6Fjbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467

VGhhbmtzIGZvciB5b3VyIHJlcGx5IGFuZCBtYWlsaW5nIHN1Z2dlc3Rpb24uIFNvcnJ5IGZvciB0
aGUgSFRNTCBmb3JtYXQgYW5kIEkgaGF2ZSBjaGFuZ2VkIG15IGVtYWlsIGNsaWVudCBzZXR0aW5n
cy4NCg0KQm9uYW4NCg0K77u/T24gMjAyNC8xMC8yMywgMjA6NTEsICJKYWt1YiBTaXRuaWNraSIg
PGpha3ViQGNsb3VkZmxhcmUuY29tIDxtYWlsdG86amFrdWJAY2xvdWRmbGFyZS5jb20+PiB3cm90
ZToNCg0KDQotIEV4dGVybmFsIEVtYWlsIC0NCg0KDQoNCg0KDQoNCk9uIFR1ZSwgT2N0IDIyLCAy
MDI0IGF0IDAyOjM2IEFNIEdNVCwgUnVhbiBCb25hbiB3cm90ZToNCj4gSSB1c2VkIFN5emthbGxl
ciBhbmQgZm91bmQgdGhhdCB0aGVyZSBpcyBLQVNBTjogbnVsbC1wdHItZGVyZWYgKGdlbmVyYWwg
cHJvdGVjdGlvbiBmYXVsdCBpbg0KPiBzb2NrX21hcF9saW5rX3VwZGF0ZV9wcm9nKSBpbiBuZXQv
Y29yZS9zb2NrX21hcC5jIGluIHY2LjEyLjAtcmMyLCB3aGljaCBhbHNvIGNhdXNlcyBhIEtBU0FO
Og0KPiBzbGFiLXVzZS1hZnRlci1mcmVlIGF0IHRoZSBzYW1lIHRpbWUuIEl0IGxvb2tzIGxpa2Ug
YSBjb25jdXJyZW5jeSBidWcgaW4gdGhlIEJQRiByZWxhdGVkIHN1YnN5c3RlbXMuIFRoZQ0KPiBy
ZXByb2R1Y2VyIGlzIGF2YWlsYWJsZSwgYW5kIEkgaGF2ZSByZXByb2R1Y2VkIHRoaXMgYnVnIHdp
dGggaXQgbWFudWFsbHkuIEN1cnJlbnRseSBJIGNhbiBvbmx5IHJlcHJvZHVjZSB0aGlzDQo+IGJ1
ZyB3aXRoIHJvb3QgcHJpdmlsZWdlLg0KPg0KPiBUaGUgZGV0YWlsZWQgcmVwb3J0cywgY29uZmln
IGZpbGUsIGFuZCByZXByb2R1Y2VyIHByb2dyYW0gYXJlIGF0dGFjaGVkIGluIHRoaXMgZS1tYWls
LiBJZiB5b3UgbmVlZCBmdXJ0aGVyDQo+IGRldGFpbHMsIHBsZWFzZSBsZXQgbWUga25vdy4NCg0K
DQpUaGFua3MgZm9yIHRoZSByZXBvcnQuIEkgd2FzIGFsc28gYWJsZSB0byByZXByb2R1Y2UgdGhl
IEtBU0FOIHNwbGF0IHdpdGgNCnRoZSBhdHRhY2hlZCByZXBybyBsb2NhbGx5IGFuZCB3aWxsIGlu
dmVzdGlnYXRlIGZ1dGhlci4NCg0KDQpJIGhhdmUgYSBzbWFsbCBhc2sgLSBwbGVhc2UgdXNlIHBs
YWluIHRleHQgZm9yIG1haWxpbmcgdGhlIGxpc3QgaW4gdGhlDQpmdXR1cmUgLSBodHRwczovL3Vz
ZXBsYWludGV4dC5lbWFpbC8gPGh0dHBzOi8vdXNlcGxhaW50ZXh0LmVtYWlsLz4NCg0KDQotamti
cw0KDQoNCg0K

