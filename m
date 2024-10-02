Return-Path: <bpf+bounces-40761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC4D98DE82
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C41C22F23
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69461D04A8;
	Wed,  2 Oct 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AzZIyKN2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Asj6j0IE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B301D0170;
	Wed,  2 Oct 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881906; cv=fail; b=pW+zUSzrKEOYtutx9ajHcufbIZL44FlH6OHZlWO9PLnWWKeVjkPhPezORzfF5yFiaI/W+imSbDCnd6mjcYJ9+K+KNUYOZDWal5DXXMUrKYpqwcMxUwsaOqQwbm068RH/Gabxmj726lgjP3AkM7Or4O2Bg+m8yMIeCJ8U/4WHwPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881906; c=relaxed/simple;
	bh=W6czb6e+cP/tUG798Oe7DPa7L6bsx8/OeoefJelr0yE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qejSI7pULIuHPWYE4OyCzn9W3vlISEtASCBdOUrIGXKK4qGCeDIx+uNBnqHL+HbyL+P0lsj/J/O9eFXOhBtC+Gi7ecn6C0/lc+oo5nDzbuPsIqUaWU+Ue1bSgmzi8ZCu3NUOY2vLEqUvRLBHrTVpp8pRh0Ku/1izQgA9ss3EK7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AzZIyKN2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Asj6j0IE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492CdCQ2029509;
	Wed, 2 Oct 2024 15:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kVCxAyGm9QQxePkz17/tkKWDEqnAWau/7L0tWH01f2U=; b=
	AzZIyKN2tD0S00aKqF8NlJ1OhJ/yWOpfWOlk8g3lTv+6jZ0oZp1nwA/do6itAg9t
	IVhWyUBteeh+4RYDP8sbJhO+1OBFo16khJ7NFotoddGqLI81O+uNIuj0ZhqPIyMm
	e1hoa2VTRyVwP17AL0K5DVlnBXlXapyrgtubXXxYl7R7dSfPDe/6y97KPWlJAO/f
	SssvB7x9I8x+0HB1RlnE+B3RSUtHglJ2Xpo+Q2aRWmmAsdznzFWZxgwcF3DyLQXm
	1IgRfu7wVdAycp6tF3mMUu5y3jDTDK2cFduFaF1TRmPOlir/cKG1AZ/5xu4+K7Wc
	akL0N3RCncJcoSuVXTVjyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1hgwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:11:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492F01KB039348;
	Wed, 2 Oct 2024 15:11:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88919vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFiDKjeKwexeGiu/D9Zf8Zyx4CqG6Kf+bR6BAT6YB1ksu7tyVQP7Jn2gk8BEB78DAT6xGPNxhtGg6Yq34LdofrWeNW/SxGSnuTf+ZLGuD2bqKj2NLGaDf9n/N6buSB7pbrmvzpkp0bAgJD9+51qeCg+uNQg4PujEBjo79wuagHlARgZOtQHs4tIf3F18+rhFp9v0aO+Qsyh+u81KKyo/YaQ5d/it+cvN+M4JSQF9CmabXCzgmQoor0bhBr6FjzT1xiewNTrIMZfaYQ3JEGAQKuBZyOuiUCW8apkv1vQrdriqYyy5qOlPdwX8EDpyk7hqscQsB0z66O4k1nZbDP71Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVCxAyGm9QQxePkz17/tkKWDEqnAWau/7L0tWH01f2U=;
 b=cdVN7N8tHtU0YX0t6nQb6QoBc8OwLliiB2HAoTyW4d6ulTGU5fawX6EtHpTi0CqEzV7QgFH4hHgoxqAUvpH+MvD+oWLJmoNf3rYfQk5IkQGtqs2Iuz+2doUHIZk/tR4Dqr9eb8GYKut4zVDTZiB9Og9dYmlkmhCatgzjh3AZ5YooL8FxowtHkbEGCDgknYWr6KYzoATlTgQoJNBwgG7VNcBn/h2USw8VvAgyrVSfuA4J9sDqPpA/8hGJvkE0wqlfnGB3yquwws6evGzlbwSe8bla7p5dh9HiOJf+x1qPXg7Av45D+82L+FyOJA8Fu1oIdqhsTPSH+8CVQRyalKg85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVCxAyGm9QQxePkz17/tkKWDEqnAWau/7L0tWH01f2U=;
 b=Asj6j0IEAMXn0jWftT+ybTlapyiIu0b38epROHjyKEQrqYxDludGS9GxMWoiYQZob8fuRrPA1pyEhJ3Vm4/iJDsIx7Dx97ZKF7UF1VF5qxvSB7EY2uuQb4cgRpfBmVqFNw47y1Tu0i9K2xUw2timRXCkx0hevU7jTo5WClmy7RM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 15:11:31 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 15:11:28 +0000
Message-ID: <df3c21d4-9f42-4681-b7bb-78134f430f1c@oracle.com>
Date: Wed, 2 Oct 2024 16:11:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
To: Jiri Olsa <olsajiri@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com>
 <Zv1VQ0G_GpwCjjie@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zv1VQ0G_GpwCjjie@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e825eb-46da-487a-40bb-08dce2f47d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2xVVDVCSm1Db0R1QXJmSmFuYkpja1o0c1ZuVmE1QWVuMC8wVlhkQVpQT25F?=
 =?utf-8?B?OXA1dkhLd2xUVUZZMEowaklPN3Zzdyt2RkxMeGczdzREUkVTM2xGUGx2aVZa?=
 =?utf-8?B?SUpXMG9qUGpsaTFGcm1PRUQrQk4zVkU2NWpYNHl1M3ltVGNkaTJWWm1lYVpY?=
 =?utf-8?B?dHRwdENGQ0ZJbmFlQ2pLNXVHRVVBdUhhNWRadEF3bllNdW42bDZNaGFQbGRS?=
 =?utf-8?B?aHBLdDNhSjVuMys4UW5VdngvcWhuZ0NNK1JpRzJtcFF6UHFqMkhCWFFTaFFh?=
 =?utf-8?B?OFZaaitJMER3eVIrdnpwc3NyTGFrV3VGK01TQ20vZThFMW81VTRQa0MzYXFv?=
 =?utf-8?B?R2dENUhYS1pZUCtxU1Q3VEcvNWFJZVdzdnhRaW9YNFlRa0xEaUNYTHNFMDkx?=
 =?utf-8?B?WHBWa1g4azdzRkVmOVArbERSQVBVOGxadU9MU2kwMXJtK2hSNjFJZnluN0xi?=
 =?utf-8?B?WkVpRy9PNitVNXYvU09semk4c1JkeDdWQXFZZ1piVFU5ZnYyWUx6Ymd0TE9X?=
 =?utf-8?B?ZEtHSnF4aU1qOVhpbFozSG1TZFY1a2xxZTF4U3NpVHdIaEcySkd0NklmUmMr?=
 =?utf-8?B?b0F4VDA2YlI2a0ZpOENZa0R0ZFdlZ0RPMzg1Z2ZLbWE3c2FQK1FEYzJpRm9u?=
 =?utf-8?B?ZjlQYjROaFpJcmRWeFIxTDV4MVUzVzBnMWo4cnBLMkN1aXBzR1lCVFpncExr?=
 =?utf-8?B?VGRqSFlCS2hxajRLWU1KeG5EWThPV294dENxMEVHeWdxa2tINUhubytFTUhl?=
 =?utf-8?B?SXRxTkdWYUdsSEpjOWYzc0MxVzkzejdBRThQbHdDQWRjYXBNc0FDN2dxZC9R?=
 =?utf-8?B?aGtvVDVVVnptbzFmM1l3MEh0YTlOS0Q0b3JKYTNxckdURGNnYlV0Z1dNTzU0?=
 =?utf-8?B?ZFlDdHYrcHh4aURYNGZDT0ZDbnFLbDI3bkJGcGdGd1RTRUNkUkhpbkxuK2NJ?=
 =?utf-8?B?REtiVmp5L3dibVc4dHNwYXY3N1c4QWN0WGhQMFBGNjBPQ1Z3YVFROGhwUXZL?=
 =?utf-8?B?Q3J3VVdrNTM2TTIxUExyUnlDL3lKM2lDY1JoM3hjK202L0plMlhnRDdwN3Qr?=
 =?utf-8?B?OVMzaTZlS003S3BRVXpJdkxpaVp5Q1hvbHZuY1JwU1VuMjZIV3V6VE1DS1Bi?=
 =?utf-8?B?NUxKUVJMMHdtMng0TWFEbnZGWTlwS0R3SThaZlQyVmgvM1BrOThkUnpheUFE?=
 =?utf-8?B?azNoRXRpd24rOUhtSnZlc3NXM0IvN2xBNDVrb1c4ZXJ0bDVIckFld3BTOTN3?=
 =?utf-8?B?ZlEwMXVWekIyQzB0SWk2elJnSElkYnc3bkk1ODM0RjA0cFFodnlRMVRkaTB1?=
 =?utf-8?B?NUsvYkMvVUxpQjU3Z3hieVZReDRRd25XZDdKc2hWSnpURUdpQit6Vmh5U2tm?=
 =?utf-8?B?aHViSUhqTmVMb0JRdUpqTzJXUUxBem5ucFh5bkV5dmpJcnpwalFmWENOcGhZ?=
 =?utf-8?B?ZC8xNjV6S0NUTWtVV044TThmUDN0NzRoOGRnUW5ockdja2pEbFI0NlBTclBG?=
 =?utf-8?B?djNlOVFvcGgrZE5ySmNwaEg5bUxvbDdPQVhSTzFnb1V4YXd1NkNSYU1iYmtv?=
 =?utf-8?B?RUpXWm1TTnU4aW9xNzZ2cHBzVVA1dHZKZ1lHcnI5WTBBTWhrS0k4andQRDV1?=
 =?utf-8?B?Q3drcStHc2hXbEZGclljV1MxM042TFh2V2JYbHpxekQrTm4xZ3orcWJSUW5L?=
 =?utf-8?B?RFA1Skh3OGd6RTJKS1F1ZGdUYkFJOTB6bUJzL1Y1VTR2MDE3clhnVDF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjRuTDJQSUVURFVpZHVXUmNMclVpTlZDL2YzdW9jdENWT2FNS2lVRjBrVHhN?=
 =?utf-8?B?Qlk1N0dSQ2x1WEluOEJWS3NKRGNzNzJpaUJjdnA2SWFkYTdTY3N0b21LWDJ0?=
 =?utf-8?B?WXJzeFNqQTBnNkxFMHJDMWRPZVpUT0haWld1OFp5Wms0QkZYRHhaSHFMMjRU?=
 =?utf-8?B?YW5SZmZESytLcWJiZXZBaEZYcXU2NnhjWFhNWnNPdnlrVUszQjRiSmpMZkx2?=
 =?utf-8?B?aTFISEZxQktLcVRkK3JMdnM1bVdLb3B0TXZQTkt4TkJPK3dlT05CeFZNdzNN?=
 =?utf-8?B?VlpKMTB3T0FpM0NQNlgva3JOOGJVTXJFL2UrUkIzMkpncFJhZXduSVFnVjVL?=
 =?utf-8?B?VmdvcnF4UzdDRzFIS1YxcEd2QlQrSCtqK2ZMNzYyMU5ZbkRML3lpOHplMzJr?=
 =?utf-8?B?ZlppN2pkRkFOL2NYUzVMRVhtdnVQSzlHK1RXWWhMMTUvcnZwKzEvcFNTMHVM?=
 =?utf-8?B?RlVZUkZzUzhYZjlIOURjOExQMFY0Q3d3L3VIZjY0dnhPa3hJY25iYTE4TkRP?=
 =?utf-8?B?UU5QSk9iYmowMVA3UHhnNDBrdVBlUlE2OW5OR0doMW1tYXlsbmRvWW5GOE92?=
 =?utf-8?B?MEZ4R3U1UUUzVjBLYm41eHN3SmE2UjZtcEpZZ3dJM2Yya3dlS3ZqNmF6MHZL?=
 =?utf-8?B?eGNTd1JVNFpJOXY1QVZjQ083a1B4Tm5HaUdvcitlOER5OUJ0MlZEbk1WVXZJ?=
 =?utf-8?B?eUdZMURiVnBjcXc0MUxuN0RZTTU5N05ETkd4TnpFeW4vZTVyQ1laWjF4aWFK?=
 =?utf-8?B?YVFmelErTDl0L1dIeDVVYTFmNjdWRUhrYm0zenpIeWlDWUhFWW5qQUFBY05E?=
 =?utf-8?B?cnFhdm5pUlZuK2t3QXJBaUhqcldPL0lzYm5RT0pPZlNoamNvU2ZjSWdxcnhJ?=
 =?utf-8?B?Z3RCbjN0aFlPaWcxZ2dWbHNXRi8vZ0RoYWlrQXJ0QzlnMnRLMnhEOFhwV3hD?=
 =?utf-8?B?UHNvaVBoWjRqNlMrZnBzemdLcmt3ZHVoMHVKV3RrNWVDRWN5Rm81STZVWTJ0?=
 =?utf-8?B?WDg0V2VmcGNzSlkrTlR6S0UyaUxGQklxdTRLOGxlM1N3VHVQamxGNEgrQ01P?=
 =?utf-8?B?cXlHRlR2ellDM0ZDeEd4THhlTFUxb2V0OWN0UlpwQUl3a1lBUkp5NjF5VHo4?=
 =?utf-8?B?U2cxTHVQR21sNTZ0ZFRNbys2VEJuN2U2Qzdub2Z0UmtVT0RNYmJielRXU2Uw?=
 =?utf-8?B?cTlMaDE0dnVnOUMxV3dmR0greVpSZzhJU3Rzb3FJT2VCWlgyRXZDOFNDVnpi?=
 =?utf-8?B?SXc1TDRXQWxJbG5BcDJuN1dJUzY2T25taGRCUVZaY1JJWlIzVDBhQmJOQmt5?=
 =?utf-8?B?Tll3aW9jakNxT0dqWC92ZXlkRzhUa2V6V1hQVzQwMzV5YzM1UXFWRjE1L1Ez?=
 =?utf-8?B?VjQ2Yk5DaTl3TWFlYjBRVThPdWRGb21JR29Cb3ZQaURJVkpIbGZmK3JtTmZk?=
 =?utf-8?B?QW1UNFJ1MTZtMEkrWHZrdWNxLzAwSjZ5TVNzbDlOQ0lBanE4akQxdnNPRFhB?=
 =?utf-8?B?ZnZvakJ1bmk0Y1BJa216bXZPakptMmxJZ2Y0RmNzS0Q5S2puZUFzaTdnZTNu?=
 =?utf-8?B?KzhXY1pPTHV5RGdDdSsxcWtHZU4wZVdiZUpqd2RnajhOVXQrazBTQXRIMjRl?=
 =?utf-8?B?NFVRejl2SURrK0c5YTdUT3ZtbjZvUG96aHdOei9Hb2ZvZHpsYlRkbG1qcno5?=
 =?utf-8?B?REduZmRJYzJxQ0t6dFJKNWhRS3ZWTlVWQmNQRFpzNmtkWVBSZDNaNGU5blhI?=
 =?utf-8?B?c0hwK3BzT053RmRPMUI3dnhmbXVTZnBMQWl4YzhuM0psanEwYklTUEN4dVhP?=
 =?utf-8?B?aWMrQ0NNL3RuWjVFWGY1M3VmZEpPdkhrdkg1YW5ZWk9sRHN3b3lTcDVpTlh2?=
 =?utf-8?B?NEU3c2gwQk54SlRlYkxqY2lsK3RDVUh6VnNKUTJVTjZpY3h6aG00YUJJOHJp?=
 =?utf-8?B?ME1kby9naWRJRWhSWEg1czFnS0xCUVpOUmlQeE1QUU54NnRMY2laNjRnUlhW?=
 =?utf-8?B?MWNmVTgxYmlhTmxCa1RJVC84TEl5SlhXejFaRzdpMEM5VGNQdkN6OW9uUUY5?=
 =?utf-8?B?eFdaWXVzWUFHV1BVRFVaYXAzdzVyV1JBUFozdnVRa0FUNUROMFQzL0pWTDkw?=
 =?utf-8?B?a2VGQjFJRzErRlBmNjNJUzdvT0Y4NjdFcVZhQWhjL0VoT2ZGbE5ML0wydXZB?=
 =?utf-8?Q?NbQ6xlyJd/5QM/1xlg+z21w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWyb+t/LYKz+0Ox/0Sw7cymilpvlRnUeoXB94sCgKptCxZfhoh+2Rwf14Elf1qIxe49duJbLEZ82OQ8VrGXVdcbaL8lH+/hJgPdf639hqQGlAHSJkvTstgXgJ+p0Tz80vQwzBFB0HVdDMEjbIWSbMZSB9yojuFAobQxIg/0EqH3Pd5i+m4b8l0Sob2vH3IbNeibASqf/PasWONhQmheDHysSBWwxUEMwGQkwlHxxky0s6TDPtQRCEMEFDN/tQoptHdjHTCGHTMCkOrHShPf2VCANPKnNJ3eW4KGnD2MI5pG/bdN6cmJ8MvVFEiND8mPvjXHMp2Z5q5s3hCWZfhmSP5rg3cWbUxnxjizpzanDqlDmXpp4h7XiQ9aELOsJH/ogQyHcFCnHQbrhCBgFayqksYWeMnUdFSUIs5ZpDmd0gz19bwmqNS1E6xrP/n+i8IWDBZqqUNSzmCJSkidAB9df9v5m4AgxeMO8Yd0lQfPD0aJLJ9uDwzFI4Jcw0ty3sXvCX1gMxHDFxzFCSEPEtfVPHY+snWHEfPQH5pfjid28kfkV3gNbj9fZqUcxJxQUUh1pFsqGQa3Kw7KteYUB/8gjYAKzvYGkSdBXE3PADk+L6i0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e825eb-46da-487a-40bb-08dce2f47d3a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 15:11:28.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJxBh7fQaTnRxt+6uOET1uRjVHTsCd1yz96MS5u3nWvdK4pKXDH1WVKnWB5MzrnD6XNW8WGzFeJtwQg33wcw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020110
X-Proofpoint-ORIG-GUID: ELl5_-nswcxtMPUUZvjR-yfqFHjTUU06
X-Proofpoint-GUID: ELl5_-nswcxtMPUUZvjR-yfqFHjTUU06

On 02/10/2024 15:14, Jiri Olsa wrote:
> On Fri, Sep 20, 2024 at 01:19:01AM -0700, Stephen Brennan wrote:
>> Currently the "var" feature only encodes percpu variables. Add the
>> ability to encode all global variables.
>>
>> This also drops the use of the symbol table to find variable names and
>> compare them against DWARF names. We simply rely on the DWARF
>> information to give us all the variables.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c      | 347 +++++++++++++++++++++------------------------
>>  btf_encoder.h      |   8 ++
>>  dwarves.h          |   1 +
>>  man-pages/pahole.1 |   8 +-
>>  pahole.c           |  11 +-
>>  5 files changed, 183 insertions(+), 192 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 97d35e0..d3a66a0 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -65,16 +65,13 @@ struct elf_function {
>>  	struct btf_encoder_state state;
>>  };
>>  
>> -struct var_info {
>> -	uint64_t    addr;
>> -	const char *name;
>> -	uint32_t    sz;
>> -};
>> -
>>  struct elf_secinfo {
>>  	uint64_t    addr;
>>  	const char *name;
>>  	uint64_t    sz;
>> +	bool        include;
>> +	uint32_t    type;
>> +	struct gobuffer secinfo;
>>  };
>>  
>>  /*
>> @@ -84,31 +81,24 @@ struct btf_encoder {
>>  	struct list_head  node;
>>  	struct btf        *btf;
>>  	struct cu         *cu;
>> -	struct gobuffer   percpu_secinfo;
>>  	const char	  *source_filename;
>>  	const char	  *filename;
>>  	struct elf_symtab *symtab;
>>  	uint32_t	  type_id_off;
>>  	bool		  has_index_type,
>>  			  need_index_type,
>> -			  skip_encoding_vars,
>>  			  raw_output,
>>  			  verbose,
>>  			  force,
>>  			  gen_floats,
>>  			  skip_encoding_decl_tag,
>>  			  tag_kfuncs,
>> -			  is_rel,
>>  			  gen_distilled_base;
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo *secinfo;
>>  	size_t             seccnt;
>> -	struct {
>> -		struct var_info *vars;
>> -		int		var_cnt;
>> -		int		allocated;
>> -		uint32_t	shndx;
>> -	} percpu;
>> +	int                encode_vars;
>> +	uint32_t           percpu_shndx;
>>  	struct {
>>  		struct elf_function *entries;
>>  		int		    allocated;
>> @@ -735,46 +725,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>>  	return id;
>>  }
>>  
>> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
>> -				     uint32_t offset, uint32_t size)
>> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
>> +					    uint32_t type, unsigned long addr, uint32_t size)
>>  {
>>  	struct btf_var_secinfo si = {
>>  		.type = type,
>> -		.offset = offset,
>> +		.offset = addr,
>>  		.size = size,
>>  	};
>> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
>> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>>  }
>>  
>>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
>> -	size_t sz = gobuffer__size(var_secinfo_buf);
>> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> -	uint32_t type_id;
>> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> -	int32_t i, id;
>> -	struct btf_var_secinfo *vsi;
>> -
>> +	int shndx;
>>  	if (encoder == other)
>>  		return 0;
>>  
>>  	btf_encoder__add_saved_funcs(other);
>>  
>> -	for (i = 0; i < nr_var_secinfo; i++) {
>> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
>> -		if (id < 0)
>> -			return id;
>> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
>> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
>> +		size_t sz = gobuffer__size(var_secinfo_buf);
>> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> +		uint32_t type_id;
>> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> +		int32_t i, id;
>> +		struct btf_var_secinfo *vsi;
>> +
>> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
>> +			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
>> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
>> +			return -1;
>> +		}
>> +
>> +		for (i = 0; i < nr_var_secinfo; i++) {
>> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
>> +			if (id < 0)
>> +				return id;
>> +		}
>>  	}
>>  
>>  	return btf__add_btf(encoder->btf, other->btf);
>>  }
>>  
>> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
>> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
>> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
>> +	const char *section_name = encoder->secinfo[shndx].name;
>>  	struct btf *btf = encoder->btf;
>>  	size_t sz = gobuffer__size(var_secinfo_buf);
>>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> @@ -1741,13 +1741,14 @@ out:
>>  int btf_encoder__encode(struct btf_encoder *encoder)
>>  {
>>  	bool should_tag_kfuncs;
>> -	int err;
>> +	int err, shndx;
>>  
>>  	/* for single-threaded case, saved funcs are added here */
>>  	btf_encoder__add_saved_funcs(encoder);
>>  
>> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
>> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
>> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
>> +			btf_encoder__add_datasec(encoder, shndx);
>>  
>>  	/* Empty file, nothing to do, so... done! */
>>  	if (btf__type_cnt(encoder->btf) == 1)
>> @@ -1797,111 +1798,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>>  	return err;
>>  }
>>  
>> -static int percpu_var_cmp(const void *_a, const void *_b)
>> -{
>> -	const struct var_info *a = _a;
>> -	const struct var_info *b = _b;
>> -
>> -	if (a->addr == b->addr)
>> -		return 0;
>> -	return a->addr < b->addr ? -1 : 1;
>> -}
>> -
>> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
>> -{
>> -	struct var_info key = { .addr = addr };
>> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
>> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -	if (!p)
>> -		return false;
>> -
>> -	*sz = p->sz;
>> -	*name = p->name;
>> -	return true;
>> -}
>> -
>> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
>> -{
>> -	const char *sym_name;
>> -	uint64_t addr;
>> -	uint32_t size;
>> -
>> -	/* compare a symbol's shndx to determine if it's a percpu variable */
>> -	if (sym_sec_idx != encoder->percpu.shndx)
>> -		return 0;
>> -	if (elf_sym__type(sym) != STT_OBJECT)
>> -		return 0;
>> -
>> -	addr = elf_sym__value(sym);
>> -
>> -	size = elf_sym__size(sym);
>> -	if (!size)
>> -		return 0; /* ignore zero-sized symbols */
>> -
>> -	sym_name = elf_sym__name(sym, encoder->symtab);
>> -	if (!btf_name_valid(sym_name)) {
>> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
>> -				    sym_name, encoder->verbose, encoder->force);
>> -		if (encoder->force)
>> -			return 0;
>> -		return -1;
>> -	}
>> -
>> -	if (encoder->verbose)
>> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>> -
>> -	/* Make sure addr is section-relative. For kernel modules (which are
>> -	 * ET_REL files) this is already the case. For vmlinux (which is an
>> -	 * ET_EXEC file) we need to subtract the section address.
>> -	 */
>> -	if (!encoder->is_rel)
>> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>> -
>> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>> -		struct var_info *new;
>> -
>> -		new = reallocarray_grow(encoder->percpu.vars,
>> -					&encoder->percpu.allocated,
>> -					sizeof(*encoder->percpu.vars));
>> -		if (!new) {
>> -			fprintf(stderr, "Failed to allocate memory for variables\n");
>> -			return -1;
>> -		}
>> -		encoder->percpu.vars = new;
>> -	}
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
>> -	encoder->percpu.var_cnt++;
>> -
>> -	return 0;
>> -}
>>  
>> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
>> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>>  {
>> -	Elf32_Word sym_sec_idx;
>> +	uint32_t sym_sec_idx;
>>  	uint32_t core_id;
>>  	GElf_Sym sym;
>>  
>> -	/* cache variables' addresses, preparing for searching in symtab. */
>> -	encoder->percpu.var_cnt = 0;
>> -
>> -	/* search within symtab for percpu variables */
>>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
>> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
>> -			return -1;
>>  		if (btf_encoder__collect_function(encoder, &sym))
>>  			return -1;
>>  	}
>>  
>> -	if (collect_percpu_vars) {
>> -		if (encoder->percpu.var_cnt)
>> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -
>> -		if (encoder->verbose)
>> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
>> -	}
>> -
>>  	if (encoder->functions.cnt) {
>>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>>  		      functions_cmp);
>> @@ -1923,75 +1831,128 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>>  	return true;
>>  }
>>  
>> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
>> +{
>> +	/* Start at index 1 to ignore initial SHT_NULL section */
>> +	for (int i = 1; i < encoder->seccnt; i++)
>> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
>> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
>> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
>> +		    encoder->secinfo[i].addr <= addr &&
>> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
>> +			return i;
>> +	return -ENOENT;
>> +}
>> +
>> +/*
>> + * Filter out variables / symbol names with common prefixes and no useful
>> + * values. Prefixes should be added sparingly, and it should be objectively
>> + * obvious that they are not useful.
>> + */
>> +static bool filter_variable_name(const char *name)
>> +{
>> +	static const struct { char *s; size_t len; } skip[] = {
>> +		#define X(str) {str, sizeof(str) - 1}
>> +		X("__UNIQUE_ID"),
>> +		X("__tpstrtab_"),
>> +		X("__exitcall_"),
>> +		X("__func_stack_frame_non_standard_")
>> +		#undef X
>> +	};
>> +	int i;
>> +
>> +	if (*name != '_')
>> +		return false;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  {
>>  	struct cu *cu = encoder->cu;
>>  	uint32_t core_id;
>>  	struct tag *pos;
>>  	int err = -1;
>> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>  
>> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>> +	if (!encoder->symtab)
>>  		return 0;
>>  
>>  	if (encoder->verbose)
>> -		printf("search cu '%s' for percpu global variables.\n", cu->name);
>> +		printf("search cu '%s' for global variables.\n", cu->name);
>>  
>>  	cu__for_each_variable(cu, core_id, pos) {
>>  		struct variable *var = tag__variable(pos);
>> -		uint32_t size, type, linkage;
>> -		const char *name, *dwarf_name;
>> +		uint32_t type, linkage;
>> +		const char *name;
>>  		struct llvm_annotation *annot;
>>  		const struct tag *tag;
>> +		int shndx;
>> +		struct elf_secinfo *sec = NULL;
>>  		uint64_t addr;
>>  		int id;
>> +		unsigned long size;
>>  
>> +		/* Skip incomplete (non-defining) declarations */
>>  		if (var->declaration && !var->spec)
>>  			continue;
>>  
>> -		/* percpu variables are allocated in global space */
>> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
>> +		/*
>> +		 * top_level: indicates that the variable is declared at the top
>> +		 *   level of the CU, and thus it is globally scoped.
>> +		 * artificial: indicates that the variable is a compiler-generated
>> +		 *   "fake" variable that doesn't appear in the source.
>> +		 * scope: set by pahole to indicate the type of storage the
>> +		 *   variable has. GLOBAL indicates it is stored in static
>> +		 *   memory (as opposed to a stack variable or register)
>> +		 *
>> +		 * Some variables are "top_level" but not GLOBAL:
>> +		 *   e.g. current_stack_pointer, which is a register variable,
>> +		 *   despite having global CU-declarations. We don't want that,
>> +		 *   since no code could actually find this variable.
>> +		 * Some variables are GLOBAL but not top_level:
>> +		 *   e.g. function static variables
>> +		 */
>> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>>  			continue;
>>  
>>  		/* addr has to be recorded before we follow spec */
>>  		addr = var->ip.addr;
>> -		dwarf_name = variable__name(var);
>>  
>> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
>> -		 * always contains virtual symbol addresses, so subtract
>> -		 * the section address unconditionally.
>> -		 */
>> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>> +		/* Get the ELF section info for the variable */
>> +		shndx = get_elf_section(encoder, addr);
>> +		if (shndx >= 0 && shndx < encoder->seccnt)
>> +			sec = &encoder->secinfo[shndx];
>> +		if (!sec || !sec->include)
>>  			continue;
>> -		addr -= pcpu_scn->addr;
>>  
>> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>> -			continue; /* not a per-CPU variable */
>> +		/* Convert addr to section relative */
>> +		addr -= sec->addr;
>>  
>> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
>> -		 * have addr == 0, which is the same as, say, valid
>> -		 * fixed_percpu_data per-CPU variable. To distinguish between
>> -		 * them, additionally compare DWARF and ELF symbol names. If
>> -		 * DWARF doesn't provide proper name, pessimistically assume
>> -		 * bad variable.
>> -		 *
>> -		 * Examples of such special variables are:
>> -		 *
>> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
>> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
>> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
>> -		 *
>> -		 *  This is relevant only for vmlinux image, as for kernel
>> -		 *  modules per-CPU data section has non-zero offset so all
>> -		 *  per-CPU symbols have non-zero values.
>> -		 */
>> -		if (var->ip.addr == 0) {
>> -			if (!dwarf_name || strcmp(dwarf_name, name))
>> +		/* DWARF specification reference should be followed, because
>> +		 * information like the name & type may not be present on var */
>> +		if (var->spec)
>> +			var = var->spec;
>> +
>> +		name = variable__name(var);
>> +		if (!name)
>> +			continue;
>> +
>> +		/* Check for invalid BTF names */
>> +		if (!btf_name_valid(name)) {
>> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
>> +					    name, encoder->verbose, encoder->force);
>> +			if (encoder->force)
>>  				continue;
>> +			else
>> +				return -1;
>>  		}
>>  
>> -		if (var->spec)
>> -			var = var->spec;
>> +		if (filter_variable_name(name))
>> +			continue;
>>  
>>  		if (var->ip.tag.type == 0) {
>>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
>> @@ -2003,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		tag = cu__type(cu, var->ip.tag.type);
>> -		if (tag__size(tag, cu) == 0) {
>> +		size = tag__size(tag, cu);
>> +		if (size == 0) {
>>  			if (encoder->verbose)
>> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
>> +				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
>>  			continue;
>>  		}
>>  
>> @@ -2035,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		/*
>> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>> -		 * encoder->types later when we add BTF_VAR_DATASEC.
>> +		 * Add the variable to the secinfo for the section it appears in.
>> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
>> +		 * an encoded variable.
>>  		 */
>> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
>> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
>>  		if (id < 0) {
>>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>> -			        name, addr);
>> +				name, addr);
>>  			goto out;
>>  		}
>>  	}
>> @@ -2068,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  
>>  		encoder->force		 = conf_load->btf_encode_force;
>>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>> @@ -2076,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  		encoder->has_index_type  = false;
>>  		encoder->need_index_type = false;
>>  		encoder->array_index_id  = 0;
>> +		encoder->encode_vars = 0;
>> +		if (!conf_load->skip_encoding_btf_vars)
>> +			encoder->encode_vars |= BTF_VAR_PERCPU;
>> +		if (conf_load->encode_btf_global_vars)
>> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>>  
>>  		GElf_Ehdr ehdr;
>>  
>> @@ -2085,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out_delete;
>>  		}
>>  
>> -		encoder->is_rel = ehdr.e_type == ET_REL;
>> -
>>  		switch (ehdr.e_ident[EI_DATA]) {
>>  		case ELFDATA2LSB:
>>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
>> @@ -2127,15 +2092,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>>  			encoder->secinfo[shndx].name = secname;
>> -
>> -			if (strcmp(secname, PERCPU_SECTION) == 0)
>> -				encoder->percpu.shndx = shndx;
>> +			encoder->secinfo[shndx].type = shdr.sh_type;
>> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
>> +				encoder->secinfo[shndx].include = true;
>> +
>> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
>> +				encoder->percpu_shndx = shndx;
>> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
>> +					encoder->secinfo[shndx].include = true;
>> +			}
>>  		}
>>  
>> -		if (!encoder->percpu.shndx && encoder->verbose)
>> +		if (!encoder->percpu_shndx && encoder->verbose)
>>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>  
>> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>> +		if (btf_encoder__collect_symbols(encoder))
>>  			goto out_delete;
>>  
>>  		if (encoder->verbose)
>> @@ -2156,7 +2127,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  		return;
>>  
>>  	btf_encoders__delete(encoder);
>> -	__gobuffer__delete(&encoder->percpu_secinfo);
>> +	for (int i = 0; i < encoder->seccnt; i++)
>> +		__gobuffer__delete(&encoder->secinfo[i].secinfo);
>>  	zfree(&encoder->filename);
>>  	zfree(&encoder->source_filename);
>>  	btf__free(encoder->btf);
>> @@ -2166,9 +2138,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>>  	free(encoder->functions.entries);
>>  	encoder->functions.entries = NULL;
>> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
>> -	free(encoder->percpu.vars);
>> -	encoder->percpu.vars = NULL;
>>  
>>  	free(encoder);
>>  }
>> @@ -2321,7 +2290,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			goto out;
>>  	}
>>  
>> -	if (!encoder->skip_encoding_vars)
>> +	if (encoder->encode_vars)
>>  		err = btf_encoder__encode_cu_variables(encoder);
>>  
>>  	/* It is only safe to delete this CU if we have not stashed any static
>> diff --git a/btf_encoder.h b/btf_encoder.h
>> index f54c95a..5e4d53a 100644
>> --- a/btf_encoder.h
>> +++ b/btf_encoder.h
>> @@ -16,7 +16,15 @@ struct btf;
>>  struct cu;
>>  struct list_head;
>>  
>> +/* Bit flags specifying which kinds of variables are emitted */
>> +enum btf_var_option {
>> +	BTF_VAR_NONE = 0,
>> +	BTF_VAR_PERCPU = 1,
>> +	BTF_VAR_GLOBAL = 2,
>> +};
>> +
>>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
>> +
>>  void btf_encoder__delete(struct btf_encoder *encoder);
>>  
>>  int btf_encoder__encode(struct btf_encoder *encoder);
>> diff --git a/dwarves.h b/dwarves.h
>> index 0fede91..fef881f 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -92,6 +92,7 @@ struct conf_load {
>>  	bool			btf_gen_optimized;
>>  	bool			skip_encoding_btf_inconsistent_proto;
>>  	bool			skip_encoding_btf_vars;
>> +	bool			encode_btf_global_vars;
>>  	bool			btf_gen_floats;
>>  	bool			btf_encode_force;
>>  	bool			reproducible_build;
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 0a9d8ac..4bc2d03 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -230,7 +230,10 @@ the debugging information.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_vars
>> -Do not encode VARs in BTF.
>> +.TQ
>> +.B \-\-encode_btf_global_vars
>> +By default, VARs are encoded only for percpu variables. These options allow
>> +to skip encoding them, or alternatively to encode all global variables too.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_decl_tag
>> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>>  	                   if a symbol has an invalid name, it will be ignored
>>  	                   and BTF encoding will continue.
>> -	var                Encode variables using BTF_KIND_VAR in BTF.
>> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
>> +	global_var         Encode all global variables in the same way.
> 
> hi,
> I tried to test this but I'm not getting DATASEC sections in the BTF,
> is the change below enough to enable this in kernel build?
>

Yep, that looks right to me and it's what I did to test with kernel
builds. For me that was enough to get datasecs and all global variables,
but if it doesn't work at your end we can take a look. Thanks!

Stephen, maybe for the respun patches we could add a note to the cover
letter on how to test with kernel builds? Thanks!

Alan

> thanks,
> jirka
> 
> 
> ---
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..c88d9e526426 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
>  else
>  
>  # Switch to using --btf_features for v1.26 and later.
> -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,global_var
>  
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base


