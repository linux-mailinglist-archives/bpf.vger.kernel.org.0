Return-Path: <bpf+bounces-28447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919278B9CE8
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4928A28BBBC
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04082153BD1;
	Thu,  2 May 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZGKc9JA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XgcakjTB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D647F481
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661683; cv=fail; b=Xe0jn3Kmbrltyj1A7sXKdSpZzjW6FGq0lAwTOzBn+h7B+0pEIoZx/ugsmbS7Duos5LZVAWmWxjEhGpIFXhhkcrg5H4XjfEAOfzdbylVHi0ZtAe7MYpQo6cvGeXzIt/wkS/z7rvxm3h6eyVdw7z61HnqauOW2zjDe7GYcA6Asc6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661683; c=relaxed/simple;
	bh=4sZrKORWlcK5zd8f9uV6vZm3WSNGlCXO5PTsYPa8n/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ATUpytm7DEsax8dl5uETy4k9e2RhjafnwifrO0iFsLdhiksb70KRiMBA/1U5ODE1ZWuSbrAY7si8OIqGCMK25e0KiCeCAizG7C7AfzyVoCIngPfZt6ZwJC+6+ejY9bBh4uWiOjBgFarroZv1dHvIOHgAZSY2WJA3DtVFUOhGm1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iZGKc9JA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XgcakjTB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442EDuqS014717;
	Thu, 2 May 2024 14:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BG5y+KTpEYv0U92yfbPvSZSzp8RcSfiKvts1Xwbanos=;
 b=iZGKc9JAUeOn6fx8SV7t+30qb+DsQD954qfBSLQkZCNx4zCnp3miuMuJO2KB/2hpfgWj
 gixHjebe++oL9ouq2tn02wZ1EArm+hh0Ys/UBGtxX6JQGwThrYWTRJSXIWKccRudXFCM
 64vusBW9inQcN8u1f+ZS+iXQXKUxYw7kh1jEgiDkhE8NVHD+ZBfpiiMNMge0x+y2OMO8
 2aKQdyguxXJBSk3E1HMdoOdGrj1s4V1q8veyTZ25wGzY5yXjhaHl+7ch4ogKbYxCjTEY
 zyUsj+3Mg2oERWBnKM2wtHgGWIu2RwICuIjMSfemhfEloCpqXFNKaeaj7MTi3IuRENx1 +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdeyqjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 14:54:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442EFE3D008934;
	Thu, 2 May 2024 14:54:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c2b61e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 14:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7bBMbAYo8tpleMnciPTR8z2HPQG9A5a3Fl4WmBZcjBMp4WbgZ/rThkTepldU3TW2Mp/yM7EIhALHEBqd82URIGISd0UHbrb1m0V/02bblPwE/TRb40AhJ4dy/SACfYIoyDyhqUSO/YGCueZji9nxKAagnZvO2bfQb4piBALriI9MgrHAqgH7DFb/2fcsa4nhHGmq69mbRqq3x3ewfvjRNwrTpZ8DRgwFa1nxq2ho187QkAiFqgmuPqASYYXxVq9KHfzIje2VVD65zm2Wn3b1bq4r511dgBD207R+YGKZ2XCZwzUBhaH7AMzfKL8D7Lm4SbybKYM/hxT7ToJ4B6D7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG5y+KTpEYv0U92yfbPvSZSzp8RcSfiKvts1Xwbanos=;
 b=gYmJWaq627o3XL/mg89vpjJ4Ex/JkvKX76ImTuKbd0m4chz0bYEiu0+gqWzIuO36v+qmveinv1he0N4vtjx1OK4vZOayoKCmdlbtEfF5+SeVQp+geJmI84uvGMzFeyYJwE3gv7KqGLe1HuRp3nSgemMVvZFVWwy+ABK6PEfiMmEpOR5+W43/gPkI/9gTBRVjzvJ9HKDICgR+w/nfCBeRRma3yoX1WNkWIy9ghQejYhXMXm12wznQehiujvZh3nOkpth0qGueFWp0761PGB8YMylF/qVbQxgJb0QdBhxBvHiyyshMNmGRLlJLXyCe7uw9SHQA8nkyXmav6aV/qAbpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG5y+KTpEYv0U92yfbPvSZSzp8RcSfiKvts1Xwbanos=;
 b=XgcakjTBAswERuSQ10E8EQZWSatp3KMTKzR014TAbQnDNd1HK8MaqVb8nc2/bU8j2mA1se6CbDWtgkIorX5KRadyal58zaJ6RqtwvtXlY1rEkQJiI7Dlur/1G5qCjIvic2mltR4iB6CiUsGSMXuL3lTKZbgQJN1aEUd1y29Spqs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4870.namprd10.prod.outlook.com (2603:10b6:408:12a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 14:53:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 14:53:58 +0000
Message-ID: <6a1a4fd5-39b7-4bdf-9241-1f3aa8a86b28@oracle.com>
Date: Thu, 2 May 2024 15:53:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 07/13] resolve_btfids: use .BTF.base ELF
 section as base BTF if -B option is used
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-8-alan.maguire@oracle.com>
 <e79129b07130c6b76f02a6f98e5c68e861bfaef1.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e79129b07130c6b76f02a6f98e5c68e861bfaef1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fd0bd7-8bdb-40e0-fc7e-08dc6ab7b232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHU5MlpKRWNROEJWS0dFUm5qUkZ1V3RxV0g4ZWFWaVVpN3h1MGYxWksrb09l?=
 =?utf-8?B?aCtqOVJiTnltWWd2bWd4aCsrZ2h2RGNOWENOL2RHQ3NTU3o1ZWNKRkN5ZXpT?=
 =?utf-8?B?akc5d0N3UkNISEo0ZTJVQ3JET0tTbWtncm52d21idGlOMGszUEpzQjJ0emJ1?=
 =?utf-8?B?aUExd1BWelhXS2tFWGhVdVd4M1dMY29tMXIxY1lBUUdvcDVmbWFrTmtFYlFs?=
 =?utf-8?B?bC91NmtyTTZhMUdwNHVmVFljbWhxbW9EamF0OUR1b2drYlArMTdMaFl4S29m?=
 =?utf-8?B?VWpvb1lvMnIzbUwxUm0vZmxuTm5RbEYwOW5ET2tkaTRJU0oxL0JRREhSRG53?=
 =?utf-8?B?cHUrYkpoVTN1ZGFPSHR6RCtCL0owaCttd2FZM1ptcS9hY2dCNDV2cmhTYlNk?=
 =?utf-8?B?WVZ5OWtmYUxDWFFFeUZ3TmwrRXRPbmh6eld1OWVZZmhVM0hONWtLaGZ4RFhL?=
 =?utf-8?B?RzFyV0d0djZseVdlbW1xd3U0TzdPTTAyckVOeGIyZ0JiT09pY2pUTVgrQjVZ?=
 =?utf-8?B?bFcxTm1CR3VEWjNmVTRiUldsWWtxeWFqbzdRaUoxZWJ0WU9SOGQ5TTFJbzdY?=
 =?utf-8?B?U3ZXU2oxREkwaTdYaHA1ZEJ2V0hxZWVIakxWK3NGOWZ6WC9QZjJSVHZYeGtV?=
 =?utf-8?B?SHljd1BTZ0wrMEgwQ0xIUzEydVplRHdXWWVySTBiVlFFeDFHWm5lUWhMRVYr?=
 =?utf-8?B?VXVOQ0YxR0RZbXpsdEJKaU83ZitMa3ZRWlY2dm1VY3dPZlVUWkd6d2l6ZUVE?=
 =?utf-8?B?RVo4Y2VWcVc3WjNFN243WVk2YUE2aXF6SW5iRWM2OFoyM3E1RWp2bFk2b3Zx?=
 =?utf-8?B?UEZiQmlYMzR2anhzQ1RzUkNXdisvK3YxQzBoM2xCd0ZQd09mSHhYQXVjalJ5?=
 =?utf-8?B?N1hiTmtISXN4WWFEdzJadjFRQzQ1Q050KzVqMGRzenpBSzRFangvaUEzbUp0?=
 =?utf-8?B?L3JBSXVwb0tlelhiT0htSHc2T0RpSThkdG1VY2ZVT3htVWl4djNmMmFkbHZx?=
 =?utf-8?B?WXhOaWJHcGd1UENXMzRDWkJKcm5rQ0VjN3N4SndvMlh3N2MvYlJ0WDFiZ1Vu?=
 =?utf-8?B?SGc4Y1RRSjhtVExDT3pFYjhqYkNyQU1va1ZGZDQ3am9Fa1BQY2xPcGVBNzR5?=
 =?utf-8?B?NkhLVEJMOHhja2VwQ1FUb1hwQXYwNmtIMUxuMFlIWmVxY3BqWFAvUTJuZS9a?=
 =?utf-8?B?aFZHMnRwbEpIRnRiSXoraFJpQ3RFWHB5ZTlqcEhmbktkNEdYNitubDRqMXhE?=
 =?utf-8?B?WUJScTRMRFZFWXA3L0FJeG9lUDcwdHZ2VDFhWVpVNlhQRXQwYU45TDd0TWJR?=
 =?utf-8?B?TGdaZ2tibnpjaXVHR25pQnNxMjFROGEyb0VxZk1Jek56eEQwSVhrVnM3cDd0?=
 =?utf-8?B?ck9saTZZeEpHb2QxMXJCWW83ZVNZckF2R1NOUWdZaHM3ekNDTTRyMVRTelVR?=
 =?utf-8?B?cUYvMHF5MXJSWkwyS0s0M0xaWlZ1Z3VVelF0cU1PQ2VSTjJWbUovWjNodU1D?=
 =?utf-8?B?Qk84NWltNkVzdGpaZ3MvNVVwVXIrcnZodE1yTjNBTGZvTWZ5cmhRcFFDc0FG?=
 =?utf-8?B?a1pWRlorbklSQjBXS2d0VG93ekpTVFFmYVFuUjdINU1kVWpSdTZQV0pDd0Jo?=
 =?utf-8?B?OG1Qd3ROcE85TEpMTzlMQVdTamI0VG5BSkxUMUtJK05LUFd0RXFyOFpmZjNj?=
 =?utf-8?B?QTlSMHpITUhIMVZNMkc5Q3FQRE9SdVFxaWpMMGJFMEdwd3MraHkyN2F3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2hHY1U2WGZWcTQrZEQraEdySWdFNVRIVk95MVpjQTEzbFh3UWY0bXQ0MCs3?=
 =?utf-8?B?dm9wVTU5Wms1amZKY09UR0o2Y1R6R1ZWYlZQMFlBUysvYWpVdG5Ic3A3Vm1x?=
 =?utf-8?B?bEc5VkJ3eVhiTlVOQlhod3ZNZDhGcDBUTlI0cjZtbEpFenREa1AzN3ViTFk1?=
 =?utf-8?B?Q0plVXZvb1p4ODEyUU9pWlc0a004aThEZ3Y0WnY3TmIzSXZteHdjVEJmdW52?=
 =?utf-8?B?NTB4TEFXbERHU0FWT3NlK0gwNVVaMWNncFVMVTVtanJIVTZYbkFOZW5lRkVq?=
 =?utf-8?B?aHREaVdQZDBvTnU3akJkU01lYmdxVlVqZGUyalI2RGJLUndRT28wYkVkZE54?=
 =?utf-8?B?SUZVMWpTMWdqa0hNajZRTUdxVTFHTjl0Q0I0VXluMmtJNmUzMkFQREpUT0Yy?=
 =?utf-8?B?NWdwNkJDWkZUSmpYSGo4TkduNUZLSDE1VVd4TVFIb04xWm55YllINFBkU0JC?=
 =?utf-8?B?Z3YvcUw4eHZDcmNPb1l4ZVhjeHN5V1k3RldNSzZYTWVoejdRKzVtSmU2ZC9q?=
 =?utf-8?B?OTdGOFFBU3BKemgyZEg0aWZ6citINmYwVThucTFLVzlnL3Q2MnRmSkJMdG9x?=
 =?utf-8?B?SDlaQ2FtcjhyU0FhWlVmdUxiNjVTQTVyYXRBTzVqTjE2eTdlYlJ3SzVtZmFK?=
 =?utf-8?B?QVIzcG5ZVGpLZ2VhQlBYekF2YUN5UHBCMTRXZ1BuNlR0K0FESVAvdTJFNmF2?=
 =?utf-8?B?ckszRlBZTlUwaVZmQ3B3T3cvbzFHeFA1YTNyaE9CdDJ2Z041ZHlhQmZVemdz?=
 =?utf-8?B?UHArZ0ZQd3hUN3pWMU5UT2tjNXVFVEdNWFlsMU9UczhyTHhDSHQ0YWpNOUxk?=
 =?utf-8?B?dHN6dWtRZ285bzlHaldBTmZVUTdaTkFMcmZ5V2g2S0FwS0lodFUvVmM3anYy?=
 =?utf-8?B?Wi91aVRxcUZXbXdQcGJsb1hMeFJlc2pqYWU4Z1RqWWtwMCsvaU5yZyt5VmYv?=
 =?utf-8?B?R2k2UmhzbU4xTFo0VFM0TGUzd2YreFpKME1DN3RKYW9qTFpXWW5pWlRnaHNv?=
 =?utf-8?B?WVc1QithaU1OQmkySEJ5aDlPdU9JVTZnTVJSRmlpOEE1QUhRemZEWFpNMHJo?=
 =?utf-8?B?bW1oSG5Nc3ArWEVBUmtlWE9JdGxKM1JlcWFBblpMdzA4N3hVWVloR0kyVC9U?=
 =?utf-8?B?dUQ3TllubXkxZEVjUFFsaXVVRXVsY3U0K0NyOG0zb1ZqNHowT1Rxczh4VCtF?=
 =?utf-8?B?Qll0OHgrbFp2VlBETE96VkhFUThCSHh3cGl6U0ZsK08ySXlMV1d0dmxDOTdn?=
 =?utf-8?B?TVJGaDBUQzgrQUdNWXN3Nm5yUFVuVzNZMnVJY1RZYXhia2o0Ti92WEk4ZVNR?=
 =?utf-8?B?bGZqdTlOZjFOMGd3WXNuK0k0VjdxdnJTZHUzczgzcHV0czQxTHV6UHlwNFdt?=
 =?utf-8?B?ckxlVXkwM25VKzYxS3JMOVBNdy90MGxDb0VNYzhRTnpoT1dHWVhkbEw3N1lM?=
 =?utf-8?B?R2NWVnA2cC9IdGZEM2lZOTd2alBiMWFheVgvS2xJU0lUd3ZpSmYxZEZzNEpI?=
 =?utf-8?B?WEh4YUtkdU5mWHoxSllWNXlrMHRENEt5M0FPeDRYRXM1NHI1UkJoOVJnN2lX?=
 =?utf-8?B?RXh5NjNjK0Y2L0crTjZzM285NTJFeUtaYUorV1FkWEpwZ2FjelFuMjh5ZGY4?=
 =?utf-8?B?Rk85MnoxSHkrU2RReDJJeFVQbTFSYlFnQytvRVhrSk1GSk5rR29reTVZWmlh?=
 =?utf-8?B?dGYwaGhNWG9mbys4SDE1VTJOSnlsWW9sZ3ZjcHdHNFhWcDZzUWliN0IyQUNu?=
 =?utf-8?B?RmZPUWFNa3VDRXoybkRaRWZ5RWF0VUlGTzN2alZzNnBYSkkrdnVXb01ML0k5?=
 =?utf-8?B?MExTSnZSWnR6bFFjSlZ3OEdLUEpzSnpaZWVwTGlCTGtTSjV1MlhJTHcyTDBL?=
 =?utf-8?B?d2VLMnE0bW81NHlBdmppYk5DKzA4V2prN1JjVCtpUEZBdW5QenY0WmF6UmxO?=
 =?utf-8?B?M2cxd3cvajdVWTEzRW9malBRVmFoVTVEZXI4N2VhNjVqM0V6S0Q3Sm40cGFS?=
 =?utf-8?B?SCswZmNmY2lPMmg0VWFGYmQ1NUhxakU1bngwMWR1YXdMWFYzc0VPS0ZxRnRF?=
 =?utf-8?B?YmpYMG1JTlF3SGI5UkQxcnlpd3BWWXhZV0hqc1E1cVgwYndpMVhJcklXaUt5?=
 =?utf-8?B?eEtWWFFpWGRPS2t0MFR4VG9Fc2FsdjVBZWJqcWhFM1BtU3hmbnZxU0RQZlJM?=
 =?utf-8?Q?PyGDdEWE48BEJhhJbJhYta4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ilpt8fEd+uewI6/+lLxDZFrLKuOV3tI9Elq8fEjjAvsxaJ12ux83L8cwRWUAScwAJ4OvuzfcIPPmzjnSeYJKdUdRozCkF1YamW3ur4TkgJBVVsKvKoigLArRhEibHXtDzRqYfBWK8LNRKjAA+pJ3Q9DKcUTdy1syjiHy+Tz1MDJMairfYEGDmI6ecb0B7+i1TqgTdcSOXv4Wfhj3ko7Nq7diDayoKggnkOnTVDTuF75DsnmlnZ8cUgOEYZoFtbbYPvuRNK4/AOx+t/k20jfolJcl/5iNjZxKTpJgKK/YBv8R0Cwa/Yk8GMtjIL/4iBQUlX6eyLuGJCPmxnrLQa4dHF44wFAdrESlsU9UmnTS28Eqfsp29+zbp4U4MEFZlEDfo7EsBcVRHUq8iOb8uSGj6Wtk36LZbwUyEp49qn34bFRA6RmIKIMMJYE+A+IGda2i5b/qW9U8XIOjrmpCOQN0jnUx7QaPRpAOywEW1cYawnad4EOIEmWbNjazi3yJWJ7dzpQBHFnbWY5If098KUMIQTM56i4Rc5LewLVmq8T7VHh2gWDFxD7957tb1iwhbvT8nlnvUatBcGKoO5sgbrpS9rSu6tfa/BuFXNzHC5Bhvbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd0bd7-8bdb-40e0-fc7e-08dc6ab7b232
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:53:58.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+gYoVZS2ptLPZyAPYfQF72KqpbfgU0H6HuKRcEj97g/d3DIk4mYOBeqlTDs1o2CWIarq7o4H9vZBxToyWv5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020097
X-Proofpoint-GUID: ycgm3XXndv9Y797GVNx0o35BjUfOiwcn
X-Proofpoint-ORIG-GUID: ycgm3XXndv9Y797GVNx0o35BjUfOiwcn

On 01/05/2024 21:39, Eduard Zingerman wrote:
> On Wed, 2024-04-24 at 16:48 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> @@ -532,11 +533,26 @@ static int symbols_resolve(struct object *obj)
>>  	__u32 nr_types;
>>  
>>  	if (obj->base_btf_path) {
>> -		base_btf = btf__parse(obj->base_btf_path, NULL);
>> +		LIBBPF_OPTS(btf_parse_opts, optp);
>> +		const char *path;
>> +
>> +		if (obj->base) {
>> +			optp.btf_sec = BTF_BASE_ELF_SEC;
>> +			path = obj->path;
>> +			base_btf = btf__parse_opts(path, &optp);
>> +			/* fall back to normal base parsing if no BTF_BASE_ELF_SEC */
>> +			if (libbpf_get_error(base_btf))
>> +				base_btf = NULL;
> 
> Should this be a fatal error?
> Since user requested '-B' explicitly?
>

No, the fallback behaviour is intended. The reason is this; if the user
is using an older pahole that does not support the generation of
distilled base BTF, there will be no .BTF.base section in modules. We
will however have specified the -B option, so we want to fall back to
normal resolve_btfids behaviour for modules. This avoids the need to
check if the BTF feature really works; if it doesn't we drive on with
default resolve_btfids behaviour for modules. Thanks!

Alan

>> +		}
>> +		if (!base_btf) {
>> +			optp.btf_sec = BTF_ELF_SEC;
>> +			path = obj->base_btf_path;
>> +			base_btf = btf__parse_opts(path, &optp);
>> +		}
>>  		err = libbpf_get_error(base_btf);
>>  		if (err) {
>>  			pr_err("FAILED: load base BTF from %s: %s\n",
>> -			       obj->base_btf_path, strerror(-err));
>> +			       path, strerror(-err));
>>  			return -1;
>>  		}
>>  	}
> 
> [...]

