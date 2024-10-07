Return-Path: <bpf+bounces-41098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AE9927E0
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80EE2833E4
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423618D655;
	Mon,  7 Oct 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AGIiXMoF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i6rLrvap"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C718CC0A;
	Mon,  7 Oct 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292478; cv=fail; b=iEWGPtd5A01V85NqoQcQi54M2W4sBx1h2pkV27iQvDg+li3wOd9WdTH7G19k2Kv34SSPN1ygttOONLYr5O6RNZsVm+EZBJQWWjnylaxXbNeE3LWkre++k5NtoC4/RkC/7H9ixbF2EOOyL8FVJhTirdQSsAMGfhlkrlp6Z7FQ1aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292478; c=relaxed/simple;
	bh=fDmOm1ZFk1TssCDLZEV+Z4C9iiH5PK5LHt9jUF7uurQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SpcbX1ddIkDHGE6HKplx5OOz4rucdRTJCoKomCM5s/tDDYkCgw96zagZg0LBAO3QbKRhUnDs+KzC+1Iij6+8/FneOHTySx63Np2zZGsADKYAg0Ce609GsWIrSm7gbMRnnMtkK2CrkXFQjoTMIi4B/UbanK9sIWAxbocB7Bg1Mwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AGIiXMoF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i6rLrvap; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4976ff4q013389;
	Mon, 7 Oct 2024 09:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2vYhUoEOmnAfqqU+ibco2c7Y+VdVViO5MSBMyqsMhos=; b=
	AGIiXMoFLRwCvcJGH+EefY7/a/bXUsMk5Px9l0vqwzZODWTPjYReb3PsZBcQIr9e
	DCHLuPUmQbRoYrHULi3zubFGSGH14Kv9pRVw8KsJzF2IiVX3pTfYich6mQpPDyYL
	rLOQRnkrWVsAw5o5wbMBAUpvrr2MMP4HtrR5ETyxLZ0dfHxT6TTh+JcLVT8TFsPS
	IYRLp+TD/ncJU31Ho6Adh6T1xsT45MDxDP6gPAEWaaWU4XAjBs+6GTKXhm5p2x5p
	yrAC4qssopJ/BJDfWNZFLMPC6WjyveZI5+D9biGQSRjhitopNrs4UPk9o6zXs6wW
	CRPOqDPfSY0aRqRRxFebgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pa7qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 09:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4978bxaM003251;
	Mon, 7 Oct 2024 09:14:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbrw6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 09:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9JuWJsSZV84VyheSedpfGt2GsmE4lholISp1s9/YXHTILlJRloVOpfGQHmiKveShEc33Gxp24cOqBgCVPRi/vQbbEP76DVkGQncWuGp6BkdVE7OQXa3GEbDKb98SBCh1/yOVhkPKvIvDVjZKwM567/coeWQmqWktVKN0EkCHRbAv/YdR5y4wR/2qJMx20iSamvELcjCCaA/nnANLKvJTDmsuW81zQgMWGOi84aFQyQMKoxIx9DoPmhHGTCsTLKfd/aJErnEsY4i7a7BK4V8KiHXEXTxKqDCsIwqHUJ1sz7mj1jY5/3rAxqITBp2o8DaS/+p/N2ta3zOi1PWNzkdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vYhUoEOmnAfqqU+ibco2c7Y+VdVViO5MSBMyqsMhos=;
 b=btTzukX9XHXpV/TvJKOAEcssItkP6aw0RuJu/KmX0uHKp75/DZkfm+nDLiASIztHYn4TKBdFmBeZkmmce8lR+/F0dxU4GCUq0Th/Lj6U2fxWehQsNMhFHTp7T3VrMV7VkOKQ5OPCJHK6ycT4LXpAsjOeWPLRzYNAzY8/cdVjaUpoVJsTBPjNwGXtnYLv7V9F0xw6s5vJ0J0ZsTGZIElXYdFG9zbrsEbusYCmUOVVm1iMVTS560cptHUGgbXRtgDlES2RtoxR3UD2n2pk7sDL2tkSKgK8rht5CdAjoWPGEdMCU2qDf+OHM0SdbMou6L+5hbGbSiKiBdIM/xDXqDWklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vYhUoEOmnAfqqU+ibco2c7Y+VdVViO5MSBMyqsMhos=;
 b=i6rLrvapm/kAjviK/51Mr5FFEjXwlxUV1iH6alhAizgv9AdhCwparc/c/Q+K2IUGIYaPUW/756VhJcvqzkeaoEaMY/asT27nnkruXCUsy1E+ej/Ttb+bJiI/8DGWQAnFfHfLgR+zd3EfeuERPBgft5n2sWJd2tBFhTusUj1x3K4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 09:14:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 09:14:29 +0000
Message-ID: <82ef6815-b628-467d-8bc9-f55784fda02d@oracle.com>
Date: Mon, 7 Oct 2024 10:14:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: fix reversed condition for matching
 ELF section
To: Jiri Olsa <olsajiri@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20241005000147.723515-1-stephen.s.brennan@oracle.com>
 <ZwOYV5HuGlezOFJR@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZwOYV5HuGlezOFJR@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c428b8-c7f2-45f5-f175-08dce6b0725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDVraVNSSndrR2xXWEc2RzR6Q2xLT0tWYzdxZVh2ODVSYVN1SXFvNzBkMHVF?=
 =?utf-8?B?MTZqQnpCeXpZYkxzd2JlTnhUVEJKUzAyTTdyVE9MdXFmT01ROUVYSkljYm1l?=
 =?utf-8?B?ME1KamYvQmFjV3FsZ01GN0hmZ3htQVl6TmluT1Z3U0Y4ZlM0S3d1eTVlMCs1?=
 =?utf-8?B?LzVTUEpMMUorWkkvMFFhQWl0SFNpN013OCtkRlAwc1Nod2loMWtGak53MnN5?=
 =?utf-8?B?Q0V0SWZ5K1RhUCtGTW9pTVR6OE1Nc0Z1ZmdQSy9ZNE15SzlNSm5GRTlUWEtB?=
 =?utf-8?B?MGhlcUY2Rld2VFFUbllLNUltbFlLOE1zd0RkczVwNGJxNXhLQloyc3VLR3hw?=
 =?utf-8?B?NXFxbkFSVjJwTlNIOTVuS2NpWGdjTEtQQWJZVEhHdTZSWjFDZUkvanFCSDJB?=
 =?utf-8?B?UHlPOHdOSjlMdFUvMkVxL1creGJQSTMxK0Z3VlVzRE96Q0pvWnBOTEZpWWVS?=
 =?utf-8?B?UEpjRDBHSkhhNy9INjN1ODltWmxZRDNaY1BOdXl1UHlUUVZhem5ocEcvYWdk?=
 =?utf-8?B?eS9pUTdCdDhQVk5HLzZndDRyRk11dlM2NVEvSHV5RE1RMHQxZlVjaWQwbjd2?=
 =?utf-8?B?YWVxTzEvWVZaemNLdXd5VWYvdXNTOUx4QVhxbXFiUXNjbGVGdDdzMVpvVDJF?=
 =?utf-8?B?aWVpZHEveVNFKy9VNUJRZGNKQ0pZQWJ5NkhLSmoxdVBRd2FKYnFzZE9zcXhS?=
 =?utf-8?B?RTJQRlp5Wm9SMC9OaXhIQlpnUUNxRzBjNzlvUjd5b2l6MHRRMXB6STREaElR?=
 =?utf-8?B?SEk5OVZkQTJZVUhheENvaGNGaXhhdXVvV3dmL2tRZllKeE5QZXU3ekIxS09p?=
 =?utf-8?B?cm10WmRGUGI0MUFQRmxIakM4Z0s2ZGdNOEk1ZWFsRWxmTi9NUzMyMHJmWmNa?=
 =?utf-8?B?WHkvUGFUdzhQZGVTN0lLQitqZTVhaHFqZXJqSEQxOU5xNnJOZ3paeXpINXht?=
 =?utf-8?B?UytwU2FFQnRpNm0ra3B0OUVScG9nQlJMTXlCd1JGQzdDL0xkTzUrMWVETHZq?=
 =?utf-8?B?R3lKZEQwbFNyYzNZSUROTU8xc0d5Y0YwcWZ0SjcrQklwVlhTNW1pUVFXTUpP?=
 =?utf-8?B?QzdWbExQajBxOHQ5bDE3c1VwM0wyT3lhOS9zNGJta0pyMzFNemZlTmFtcTRa?=
 =?utf-8?B?YVRFUDBMOFkyV3VDZjl4ZjdSbWJHeUh1NklwRGpOSnl2RDNCa2YzQXVMbFZk?=
 =?utf-8?B?QjNTM2NuQ1pkUTZ2aGNQcnhnTVVDUXBRZ0l4ZUV4TU0zRkt2TG1mUGJMbEht?=
 =?utf-8?B?RUVrQkVabEJCdG1MU1JkL0xNcmFkRXZTSUNWUFpvUmdsZktQZ3Z1RTBUeUZw?=
 =?utf-8?B?Ukp6Z3laY2RwK2ZOWm1rVmFkVXlJQ05icXFRdXg2MVNlQlNjZjZDVDhJalQr?=
 =?utf-8?B?Tnl4amN0M2h0SndzZjRvWmZnRVFKREhmQnFGSjJSVTR3dWg3RS9PL3RoK2JO?=
 =?utf-8?B?REJRT0NvaHpOSUlmNDlEdGNqbGlJeGVJV2YzdTFsZEVkcmZEeHh0K0FHQzg3?=
 =?utf-8?B?VlExSUlGdU54UEszR245RnBTdGgvVHl5bm5WcEF4QU1Jemc0WHpPejFTWjJZ?=
 =?utf-8?B?TmpWY0pIVlNzR0hZOC9LdEFnaG1BVFdIdlJaQ0ZBWUl5Q3dwUjRBY1QvTmh1?=
 =?utf-8?B?bkVmYjRtUXdIT1JLb3pYamF5Y1E5eGhFYlBnc0wrenZoYktCZHBmRHJTOE9Q?=
 =?utf-8?B?RXJTYlZHWWY3dGlBb1dtcmpJVG02Z0RkWWR4MTFhTFVTN2xEL2xocy9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTdnY2l1L01FeVg2U1dZZng3UmVhZnlYWUNVMTI4cjJSMlE5U3FiZEJsV0s5?=
 =?utf-8?B?dk5vSldGdFlpajQrdXZjUVIrc2RyU2M0bGs4aHFUMytNbERRRE1NWjhNdm84?=
 =?utf-8?B?K0Y0QnY2RW5HVGdWK1pNcXNORloyQ0IyWVNDdlFkTGNvTzNNdnRsM1E2Qkl6?=
 =?utf-8?B?Wk8xeFVadzl2cDVQVTlUNis4YkM4aVZidXg0WlRGayt2cHA1cWxyQ3U2dmla?=
 =?utf-8?B?c3lIMFpnbDdEQkNDTktMblVjWDVaVzZyM1h3V3hiY0ZZRW1oMWNadFNVaXhk?=
 =?utf-8?B?a2ZVZ0pqcVplZXJVeEtqUmo3aStBazZhdlhJN01yQzFkSU9pM2RwYk9EbjlR?=
 =?utf-8?B?RmJLMzdyOW9VYVpjQTE3REJvL0RwNUl2Qk9IWGpiQllOOXdVdlh3MDQwNnF0?=
 =?utf-8?B?SWkrTlNValN1ZXdHMWh1bUYwcjhrMUxzSXQ3cGRXbXo4YzFEWjR6Q2FwRW9w?=
 =?utf-8?B?ZjFqN1ZzbE1HbXl1enRmbG1PcFljU0N2Z2hOMk5ZMWJJNE9ub3o4L0NKeENn?=
 =?utf-8?B?SXcxaHl4NDNHenRhZEZ4MjU1ZUxXVUFTdnJHT0dMSHZGN3l1WEgxRUUrZnJD?=
 =?utf-8?B?cTVIM3RqVDByMmxoeHdRdEhaNXlmZ0NzMmlWQ0tGNmJZNjVBQ3lsZnk0SzRn?=
 =?utf-8?B?OVk3S0RRQjhuakphUkhiWDNDdHZIYmRMN0NiY0xYMHYrMWlVbFFXUmdzL3NR?=
 =?utf-8?B?eHluZlBHYmJudUgrbGlkQmpFeTkyQ1o2T3NTcDlUM2FSeFA3K1JPcUYySmxx?=
 =?utf-8?B?ejNrK2FIVUpFaTRVWkxUMGhMZytzNmZVS1FHL0MyUTRZL2lwOWRZci9MQzVR?=
 =?utf-8?B?aEY5WDFqNVRtWmk1S3J0cnNmbG1lYkdSazBVNE54bUVZV3Y4NVh5d25UMDEx?=
 =?utf-8?B?ZzlPb2gvbW9MYnd0USsvdmdsNktHaG40WUlNRFVJRjdMQ01heVd1RmRXZ3Y5?=
 =?utf-8?B?d1QrcUlUa2pxY2YrTHBEenc2NE9nTkYyc1hLaEJpTW9XcmYyTnVkeUJ4Q0Zv?=
 =?utf-8?B?U01KY0ZXcDlvSnFycjJUSlBHZGdmNFRtcUlFeTViUzZQWHNHZHpsdEVVUUxW?=
 =?utf-8?B?MzJONkVHYzU5Rk4wWWo2TkdmK29ObDhIWnRTaXgxSXRVaGtmbEtsVlM5SFVS?=
 =?utf-8?B?WC9lNFlsb1c3VW5BY2llZWg2MWg5My9VQ3pNSWhyUDdXbHpTT1IrZ3NsZzlL?=
 =?utf-8?B?RnZldWc3eExiMGNDZ2JwTjFnMldHYkg5TjRxZnR2K2dWNkhNZTB3cnFjTnRS?=
 =?utf-8?B?VWVYS3JSYVNxL0JMZTl1RDliMC9BczgwVk11a1IveUZKWDAwN2lxOEFFdC9J?=
 =?utf-8?B?dEpUL2RwaExEdFRhVmdscFh2d3h6N0lha3FBSlRhcmlodlo5THNKNW92NE5S?=
 =?utf-8?B?bDZFaDUzaGMwS2xQKzF2Wjhza1AyOWt0RWhjMXNVNmErM0tLNVpWMnlveVYw?=
 =?utf-8?B?Z0dLOVAzK2phZVVORUZGZ0JlQ0ZoeU9EYkFrSHhMQnNOenN2eE16ZkRDdmUz?=
 =?utf-8?B?cHpvSGIyMnh0N1JHOUVjcjR1TnFtdkJNdmZTUUQ4aWxqYUZoNDh1VFl3Q1gw?=
 =?utf-8?B?OU5QN1QrZ1lzU2h0Q2hFQ255cHJWeHlFSDZydEYzTEtYNzIrZi92NEZRc1Jy?=
 =?utf-8?B?S0cvUXJtU1R4Q09NbndEdS8vTFhkeGRzSXl3b2tDMjkxUmpRRkQvbnVyWkpS?=
 =?utf-8?B?TlNJYmZVN2tiSzVmdHdtTTRVWXg4Z0J4NjBKL0RORFJIVXhmWUprWGVhT05G?=
 =?utf-8?B?bm5kckx4MmR2MFp3TmhZT3k0UTA2ZXNFdFdnc2NUUm9weXVMV2s4dzVHY2s0?=
 =?utf-8?B?NzQ3MzM0ajV3RlF5cWxHb21oOElMTDBWZ3UwbFNBbExwZGZUUjJBTDBkUHVT?=
 =?utf-8?B?NFk0QlArVWtwK1lZUlRkMzR1R2p6bE9icTFKSEYvTTFrVjU4NFlsNzlSUnI4?=
 =?utf-8?B?NnhndERENHNaMmsyS3VsMEdtNXplUzFZTzFydlFycjZnUGlzZHlOZnQ1eU56?=
 =?utf-8?B?OVZXTlh1RTBlSGtZSUE3aE5yTmpqZ2xpWGF0T0M3ekJETG9yNGhYSnE3NHBP?=
 =?utf-8?B?M2JVTkNVMXdTNnM5MmxmNzhTSzMxWjZsWCtuUFhWWWMzYUNaNnhwUGcyOTBI?=
 =?utf-8?B?REx4WlpQVXhwQWswWkNFUDZHdFRxT0g4Um83UmNlWmxoZS9EMnQ0Nm42eE9M?=
 =?utf-8?B?RHd5Uk1CWnBndmFGNzdZeDRWTXZxbmxockJrV2NsMFlGdjRFSlZjRTVaRkpB?=
 =?utf-8?B?MEFma25SdlBIcTdTV2ZFSFVLZHNRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0CR8wYTj15mJk4e4cJKpGfDoLVISH2/d2zGivy9/GwOxNppRspDo/FsQxJO8urZW70jHNOs6ZGfHJYgZFoZbiI5+Ikawofqpx+gQN7OrPScOCHnobmZEOhGSfrbFc7+iKnrr34YRuzGdYIz6xu+DYCCFr7uo6ocUO0VSQ834HHmCeKiBsoN0H8bpI8qBAPysJ8nw1KxN7M3M899p35Ac9WbL2LhAatjEJuHo2t8Wv4UYjjNlUfrBd+m01jE11q9vTR0nhyN3cCGJUPs4jLbgpOo46b8F+BcIeJ754y28rzjo9dMbFVhAbIR1lRaHnsfaRUG4xjU+A5Z4AYNSBzcX4UiRptsIGn7ddWqm63ZMkxUIcGlGsw76WGiuNn5ufaCzcauwXcgsgvZHwXo+aRcPY7k1xZtt9Y1jlQmFNTpwdij4CWvrQcWfLHuAqD5atAS+nOhI1FEI7J7P9gEa4PVhleG5iCCG9xCWg+HbMX4H2bZl+2Pxe3IiQgfsP1gekSrrM8jUd0qzatZK7x+CprgiUUVxaGWmG5IqDL7eq2f6zyXyWzyLMEnR3QL2yJlLA3IzE8xHuninXPy/68hHr0K/jrbSkvnL8nvraQxraImdjLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c428b8-c7f2-45f5-f175-08dce6b0725d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 09:14:28.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNEd0s7y5PYQUWQN1jrA/NE7J0hpLEZj9arumRZYaaKNydIbUBzFLfkNq63vPoI34Vz1YQSXom3S7xMOci+GJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_21,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070065
X-Proofpoint-ORIG-GUID: SS_YO1eo8jJIkiY9fo6hitS0aD3asSOT
X-Proofpoint-GUID: SS_YO1eo8jJIkiY9fo6hitS0aD3asSOT

On 07/10/2024 09:14, Jiri Olsa wrote:
> On Fri, Oct 04, 2024 at 05:01:46PM -0700, Stephen Brennan wrote:
>> We only want to consider PROGBITS and NOBITS. However, when refactoring
>> this function for clarity, I managed to miss flip this condition. The
>> result is fewer variables output, and bad section names used for the
>> ones that are emitted.
>>
>> Fixes: bf2eedb ("btf_encoder: Stop indexing symbols for VARs")
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>> Hi Arnaldo,
>>
>> This clearly slipped by me in my last small edit based on Alan's feedback, and I
>> didn't run a full enough validation test after the last tweak since it was "just
>> some small nits".
>>
>> (His code review suggestion was not buggy... I introduced it as I shoddily
>> redid his suggestion).
>>
>> Sorry for the bug introduced at the last second - feel free to fold this into
>> the commit or keep the commit as a monument to the bug :)
>>
>> Thanks,
>> Stephen
>>
>>  btf_encoder.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> nice ;-) lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Thanks for the quick fix!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> jirka
> 
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 201a48c..5954238 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -2137,8 +2137,8 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
>>  	/* Start at index 1 to ignore initial SHT_NULL section */
>>  	for (size_t i = 1; i < encoder->seccnt; i++) {
>>  		/* Variables are only present in PROGBITS or NOBITS (.bss) */
>> -		if (encoder->secinfo[i].type == SHT_PROGBITS ||
>> -		    encoder->secinfo[i].type == SHT_NOBITS)
>> +		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
>> +		     encoder->secinfo[i].type == SHT_NOBITS))
>>  			continue;
>>  
>>  		if (encoder->secinfo[i].addr <= addr &&
>> -- 
>> 2.43.5
>>
>>


