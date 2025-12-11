Return-Path: <bpf+bounces-76460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44ECB5240
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 09:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AF4030194F2
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07F2EC08D;
	Thu, 11 Dec 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkgR8/uv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qjlyPqE1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423228B3E7;
	Thu, 11 Dec 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442075; cv=fail; b=ZBU6kwnldp6nFrIWyX2qqHqMII7Z2Bl37UAPZuXcFXMNL/0A8OpVl48/qPVQmp3wwap8yZeUFEibah6Pwx5ZXqU5DpHHy6ePuKJWJQEhfUVHxMjtDTbLykExIW8vS7vAZlPUljR7b08/POpgxGMWNpl80DWvypxBVoKyG4o+R+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442075; c=relaxed/simple;
	bh=uCeHXn13nnAGKQJpv1bd42sb1dSybCz1pMX3mwtW3qI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FaaztHHUdZgE/Id0WK/lNP0pxDPq1pFbuCd9n5Ps4V8uwfJ504t1/xnhJfMOo7zxi4lR0GtNg0UjZ8rNitQxoSqDpds3GvsvCiLgAe2OKn+q/EzzMXFPnrVQVDMemPM2Wnoy2bacmfoMPD5FZ7CkVbBxQykFdelgYJV7LjzlcFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mkgR8/uv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qjlyPqE1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB1h2TN484217;
	Thu, 11 Dec 2025 08:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HwKZQW0WLF4v1tOMOtMcHUKPjM2780SGxc0uyfgiUM4=; b=
	mkgR8/uvGQIyH+b8/55SQUlp5RCAtnzWqB5Q3SlsYtyPEjX+1oY6pLrPPPwuabNR
	VtSKngpzn/5ax8zgOAQHPim9ztfE8yM2Pvbu7aZ82Olh6Tz0X+2ln/d3LtGY4L3d
	DmNQzBdTDVnbFlfybVlPgdvEfttDBoetS8tv4njmLE4HviXaAgtkLPBl9lLYJ6tp
	PFeCi2Oms8d8saDyljc/LScantn2uGUs+/8vQRK5sAXCU7vfJDh/PK2nYsF9BtAv
	29NemqR+CHK2v1dGuINIGYYBWYoEFS2BUUcPl18aVsBw7RMIIMSLVtdx7OjRM5yD
	xt+xixxlv6v39QFIT9vP4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay9y31d66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB87nSC017484;
	Thu, 11 Dec 2025 08:34:00 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxbbekv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF0Cm/ryLFqT85ED/WetAum5oMcBtGhW25DST4Kev1YsuUSgJaEE2MEy/M1NHQu4atoh+bVk/qQGzkqlAVUow5Af++ZMsocIpnCWnAPdncz1Q/ttnWjMVmToXcZESPvrFSDzAjFs3fqxMtCfUdjTm+o71oAOOY6NmhT0inqA9MbX80qXXMIhD7XY0bCBYiloCA6aUW4q+iREAs32aYlFqJCfsY1PvlRuiYWtc5PusgqfgrWtfz8lYXZ7nHYpdGpGGfPlNQFJIw5C2d/JPm7kDOoB15NEN9Y+cupNh5yt0ZUfWfNhej6n5nphCCCZSqNU8aaXZvxuvYoiquxED4g+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwKZQW0WLF4v1tOMOtMcHUKPjM2780SGxc0uyfgiUM4=;
 b=crwaoaU5OgTgv0i0iA7BoXaVPO5F/PCGT3QIAU/iyljYN1qI/UWOWt0aHFqc0LdGy4bKkj9B4ASZoMw6WvWC4mCEB1+au/eiTnRBoNbAV1PEieVb30zt7iHnxbcA9VR9Ewri8mJYg/0pLO7ZS0ryqmwFcpPh2nowYIuheEPQtldPzbLo+Xrx/Fnr7qINlImV/aX5R3Ml1S9vkn5Q0aMgCPKunHKk7nyxYuF4oacIZbRLwLvgqBrJszNgQKqCbhQHd8V9TnS35BbcQBw2v55XfcpiDDjyRjmOZL/gqiByXQpVW06uP1rPIqQpHLLXxmG/UfthqOeMs1WAB2ZmtR+59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwKZQW0WLF4v1tOMOtMcHUKPjM2780SGxc0uyfgiUM4=;
 b=qjlyPqE1uDiuF0JzKqbj4Rf2taFIxa1/FkdwQFMwwwPK4RZkACU9dHoB42AI9K6MsmLUZBjKmHgRyydrWENgNrObqmcslgu4G+sBiUpT0348t6FIL/ehyEoTkCA8vOI4LptrIAB+jZFMvGlUmL25whSXU4+QENDJXGgnJlg6H2Y=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 08:33:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:33:57 +0000
Message-ID: <e15e740b-ff93-451b-99b0-9baa025730f2@oracle.com>
Date: Thu, 11 Dec 2025 08:33:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        martin.lau@kernel.org, clm@meta.com
References: <20251210203243.814529-4-alan.maguire@oracle.com>
 <6dcc4caa01eabb37a074ca584c6e9deac0e8ab217269dac8e2317a23c252f5c2@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6dcc4caa01eabb37a074ca584c6e9deac0e8ab217269dac8e2317a23c252f5c2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 490cbd60-75f4-4bd4-b9b0-08de3890066e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?azQ2bkRlTTVMU0RKMHg1amZrZitJeHVyRUxldUs5SjlsR1h3dER6enVkTXJM?=
 =?utf-8?B?ZTdRdUdhRHphejFqVldxaUVGcEFnTFV4V0ZiR0doVTY1eUs1eHpCMW5VL01w?=
 =?utf-8?B?b296aXBBR0RGSWE2MnJTeWZGcnVleHZLQ2c5QnR6M0pxTFQ2UUxXY29EcHVO?=
 =?utf-8?B?aDkvdzRsMEdEQXZzT1RMWjE5UW1Fb1VzNkNkb1RnMzAwa21WYnlvZnVKak0y?=
 =?utf-8?B?TDJiZFlOaS9sMVZTUEdVM0NTZVpyUkpOK2loSDFJUzZMeDZRdXBMVGtaMXdD?=
 =?utf-8?B?ODFlNlpmQzJPSXErVzc4ZGw2bUFXdUtOdlJSREVQcHFYOWwvMmd3Z0VTS0wz?=
 =?utf-8?B?a1Y4MUEvTWluWUs0WkpxbUFZOUFtTEF3UXlsd1FRNVhteXdLQ0YyaDJBc1BJ?=
 =?utf-8?B?SHFidWJvSjJQS3l1NFpOUTMvekN5SGNVTzUwYUxrSkc4a1B3YzJiU2pVR0pU?=
 =?utf-8?B?YmJndkFObXgxa3JTcVdtdTlVVXB6dXlCM21tSXdkVDVHbXdGR2d2NFVvQ1pZ?=
 =?utf-8?B?REhWS0hobHVWOHI3R0QyV242czNDZ3NSamtLa2Z3OWN6cVVSeTdCLzlpUGJu?=
 =?utf-8?B?TGtuZmRHeUNyWmNiT09GLzVsM1hFdEIvQ0RINUdLV2ZhR0NwTlFJd1dGTTd0?=
 =?utf-8?B?N0poQzNTUldGeDZqRzZ5SXdWTEZKbmE2M3VyRytOUE5zOGpvVnVHa2V0K0Rh?=
 =?utf-8?B?NWNxK2dyUWY3OHBvMTdJbTJaOGEvaUt3VTBpa3hTZWNHR0g2d1lMbG92Njkv?=
 =?utf-8?B?RTYreXFsK0Z0d2VCUGZpQWM4TXBlM1ZZZ2ZGY1pvWkFsVTl5TWZqck9qWSts?=
 =?utf-8?B?OFZlUHB1SldlTWYxY1BCWHpVazNjNUVMVVYwWTFYNGNtQzVoWThCL3hTcHBC?=
 =?utf-8?B?QWhTVDRaQ0cxVnBhcitDcXJXa1VnUUhNSnl1bUVzVTdncG9QKzdBWFlNQmVW?=
 =?utf-8?B?dGFpcldmQVBHS0FNcFR5b1VrZGZSZjN0NDRjdjRmTXBWdGNWVUJvZDBFOGhz?=
 =?utf-8?B?K0llTktaWC95RC9Qa0hpSG16TU0vb2pHTXBiYmE0a2RxWjlBZjNoVWVYUCtR?=
 =?utf-8?B?YjVDUDV3SVFqS0xtY2lTNHA0SWlTUVl0WkJQYVhpVEEyK20wd1I4OXdYK0tm?=
 =?utf-8?B?Und5SElRa1RUSnJqY01rZjZocFR1WHRhNUplc0xWSkN4ZXF3V1JWNENlREJ6?=
 =?utf-8?B?Mnl1RFNwUVQvdlQ3Vi9xT0pNTzF0c1RMWHpiQ3l2REloc3RqRWhDODhxS0pT?=
 =?utf-8?B?K1U4VDg3NUtxeDJNZnNYZ0dOcnE3ZFZLZGVKMVpVTzVXQ2lSS0hHUjh1aEtT?=
 =?utf-8?B?Z2ZsdmZWM252MVVLaVdsek9DLzlGN0pmemlKdG9MeklCbW5UTnJ0dUFkWEZF?=
 =?utf-8?B?Ry9HSWlMeE4veFlrams1UGlIazJaRW91dWVGdGc5TTh1SUVJdUZWVklIZmxL?=
 =?utf-8?B?SmhRbFZGR1luS0lrYWhwU2V2NlF2SGN3Q1Y0cnVBSGVFNUluYWs5K2hRY05G?=
 =?utf-8?B?eXlhTjI2WlBqWlhyTWJGa0tpeEhQeXZ0MXJQMTAvRzNvMm00eVJOWmk3NjVq?=
 =?utf-8?B?cDdVbjdjaWVBOUxsa29CM2xVcUZQOVk5T3FLZkpDVDhVd1VSTkcyczB5WmRZ?=
 =?utf-8?B?TUZrb1pkZktDTWpXNDZ5bWhyb3JxWTB3TFVWb2JPVkFkZDVUZldoTTBxbWI4?=
 =?utf-8?B?RkZxUWJCMlJyazMyZVRHY0R6WXJaR0RveEYvMlh3SnhmOTduT1FueTBWTlAy?=
 =?utf-8?B?ekR2YnJUUVhWS3dLeHBlY1hBalU5bHAxU3poSE9RN0h2TkZKUTlIUGlHSVlk?=
 =?utf-8?B?U0V4czMxZG9KZXlJaEtDYjNhMm1wYzVPbFZ3SjV0UlVDY3BNeXNxRFpQT3VV?=
 =?utf-8?B?dC9NUVExYjNhUDE4eTFOTXA0K0hpSCt1VzVKRVpNdXVNN2hkTFkyQzRRSU9W?=
 =?utf-8?B?ekdLMGNWd2xTVjUrdmhCUXJBc1NrOGwvQk1vM3V6R2FObEpyM0FIcWMwNmpp?=
 =?utf-8?B?amRFS0VNaCt3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q3gyZmMvL3JqVWhSdVVFRUhMVDg3MnBQMVNKRzBpWmRnbHpqcWt5cHY5N0NH?=
 =?utf-8?B?MWFNUzRGSkVkcDZFVTBEaGM3eXZNanA3UU0zK1ZnVXp2Si80K016alkvVWxs?=
 =?utf-8?B?YmZNTWZVTlI0UTdSZGZhL1daMUMvb28zZWloYU9YSE9Ma2FLMVJzYTdWWS9O?=
 =?utf-8?B?bGozZUxkWDMvSG1PVzE0b2lRUG9RbkRkWTNHSzNUTy9aLzRqNXFvRVZzMXls?=
 =?utf-8?B?R2J5Qmt2RS9TU285WGNLS1Nia1JUbHhoaG5Jc1lxY3F3Uy9LQ1FWc2JIVm1j?=
 =?utf-8?B?YVh0cXlJMlNwOG5pUTNuc095Sld4OUZ3TzJFTC9YcXlQRkR4cXJQK29ySmRq?=
 =?utf-8?B?djNTU3Q2dThmSnR6S2wxd1BuTUdFZ1MzdWZkcHNoVVhLL1JBNFlTZjZrRU56?=
 =?utf-8?B?T3lXYkcwM3FOYUNTdDJVb3paWk91eWE5SzVnVlRzOWhQaHJBZXpWU3VtRnlI?=
 =?utf-8?B?UVgyempYVFl5aDkybUVwcTY5R3VmWUN3c0dHdzhneWdLMGw2aDlIUHQybHFX?=
 =?utf-8?B?dmRhdUprR0w4T2p6Y2ZVSlRJeXlJZWU0SjVqUjJYZ051bnVRdXIxWnh3T1lF?=
 =?utf-8?B?UGozV1lONll5UnNOcGtaZ0xpa2dDRkl2VmxwV2pIZW1pbmJoY1NHaHlhdUFH?=
 =?utf-8?B?OWpENkluWmtYeFFRU1Q3QjZZVWRZK01hOGlqeXY0S1krWi9mL24yTHI1eEJT?=
 =?utf-8?B?eWJjdW5xSlpST25jQzBBS29SRkwwbHdhZHZsL2VlN2dHdjBZS1E4MG42anJv?=
 =?utf-8?B?Z1NJajBQWXFBUGxkMVZRcitad2pXVjU0ZGhSUmpvM3ZYeS9xYkNOdnc5dVg2?=
 =?utf-8?B?MTFwTlNrVzFMZllIRDdWLy8zL0Zuclk2K3J0VmkwMTFSbFlxOVhJemdBY3dE?=
 =?utf-8?B?Z245YWJRS25JSTJYZUYzR3gzRHRrb1UxUUlzSUphZUUwb05ycmtkUElXT2xO?=
 =?utf-8?B?eVRQWEdMMk9wRUdTbmQrcjNzM04yWGxseURPbHF1ZFYrb1dDai9Wd0wxdVEr?=
 =?utf-8?B?S1dxRGRxUmVhMVhSUHdOMGQ5R1pBYzVnb0J6dGdhNFkwNkdNdm00c0tFY2M0?=
 =?utf-8?B?Si9NK0FZRUY0ZUFQQ2NzSWJpM1FJUnF2OVZCR0ZrSHV5OHRLU25PV1ZMQ3lW?=
 =?utf-8?B?L1o5QVVyWkVWM0hzQlZPL1BseFZINmZTWHQyKy9KS0I3Y3Bkd3oraXUyZ0tu?=
 =?utf-8?B?YldvZzMvYWVrRXhPUFpwTVJIbzdIckNDcDQvTCtsbWJZVkNNdis2cGZ3cUMx?=
 =?utf-8?B?d1NBYmRCNlhjMUF0blFFcTRhSnZVOEpyM0pJZ0NwbHFFNkRUR2ZpdncvaExZ?=
 =?utf-8?B?RlVzQUxRWlB5dk1Uczd1eHMwM1hMeFlqaVp2WVFyVjVuLytVMU1za09WeHdZ?=
 =?utf-8?B?bnoxNnY1Z09HZmxNaWFhd3B6SFdJM2RIZGdkc2xvSm96SFhxcyt6R1VZUG9M?=
 =?utf-8?B?REd5b0dzUE9ycW1Cc3B4Rkp6Q0lQaTZoc1JVNkdmNnlpYUtmTTk2SUhwZSt0?=
 =?utf-8?B?elFNV2pEaUJBeUtJNFplVllyUHF6TjRtdWN1Y1JvZkFSRVlEL3Jqa1BLOSsv?=
 =?utf-8?B?bEQ2c2s2Y0d4UURJNklOVU5pVDNOWDZTL1hNMlhHZm5aL2Z3d0RsZ1RLOTRG?=
 =?utf-8?B?OHRpZ2lwS0FCZWR2YXRNV0NFMFR6OE41L2JZSzByYkpEczY0bG84VFU1NXJS?=
 =?utf-8?B?VndkUEc1L3hMSXYvTW1nd0U1TUFiYXMrREd1NXd4NEFCZXN6enNOVzk5THhF?=
 =?utf-8?B?VjdtQzRUdXhvTGxxQlQwZm8wL3hGTGJEbDhCMkozZWxEYStpNnZtQnRyM0dU?=
 =?utf-8?B?Y2pOK3h1N2RSUmhhNmszWDVlQjZxUmJtRXM4a2RndzNDWHU2L2VMdHZnUE5I?=
 =?utf-8?B?L0pDamtHclpmQXUxa2lYWGFmU3g1a3daYmx0RG85Z2lWSlAyRHpmank0eUZ1?=
 =?utf-8?B?bzVJS1Mxbk9sV2tuMjdkTnNJZFdEYXN1RlQrR20zWHM1NkpjMEpYUWNWOUtj?=
 =?utf-8?B?Z1UvRkxSdHM2S2gxWGpBNE45RXhFNFpkWGNudVptMzdEeTRpd2pUR0d5Qzgy?=
 =?utf-8?B?Z1ZyUW1OcTVxc0ZTalozdGxuT3QzZkhVVkhkelVENzNPeWJZNFVNa1gwbERu?=
 =?utf-8?B?OGxrSGIwSm40emZpaXZFN0JiS3ZTd1BPViszVWlwbW9PRWFkZVlYSFRURTh2?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gd73RTHA1Bh2Z6kTUfyLMKVIUNJa2GXs+NVYVBPq5ilh/WOAVRmO9oOl3VZzrs7+ly3AculD2Z1vRmmjd9/2Jm+H4/MilmGAIXWSSxEdQroW/AM9TefotP7VnZgDv1MgPNi56pzHs4WTgYt0RgTizfLNM4iMZW1VsAyys/XzNFDr34d/qMOnQtv8Aws1QCw6P3tcAnddexwnJbC95BjFGivNpgW9cwK6h9gVWqsi9GY3ZXInGjvMU1MEmOXdcsmNF6gVjpqp43tuOqnwV8NRrzqQ8TTdqphIxqIEiF6c2NB/D3gOgAPYgLpZqhEydGCz/J/tB8ByYyo77savzaSMWZ3gr9G+KVD+KSJgHn/hacBpmnqaGePYfWkTFj7O0k4Q+CE3GkICQqVGrPQ1thkMuCguikE3r3CT9RBYmXaJeXauXlFxfgVxgwd20wch2f7THfzI3BICCmOZhdo+kk1fyffH/nCo+0q5GMs/ttKSiYVInlFQ/VZc94BWzSM2HJOzu6EfFimByHz6dJnbOto05t6uB20zAYAlsLE1ymikfTb3uY0ERGKYyFCe9Y3VKFBHslgyOd/xe8J+wFUKJr1lCX/7ZPAipxFK5PdPYG9XK/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490cbd60-75f4-4bd4-b9b0-08de3890066e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:33:56.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBSYIzdvTV6ovC3cK15qQ29/qbfiuRBJg2nwAk9NtY90MfbybYa4JtL3w43XirQaNrZkItdC2Jhlfc5T1JF6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110063
X-Proofpoint-GUID: L5RUnc0njm20liDAA0a_Z4x18D8SfUmU
X-Proofpoint-ORIG-GUID: L5RUnc0njm20liDAA0a_Z4x18D8SfUmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2MyBTYWx0ZWRfX1+SEulOvmQP7
 G5xahdsmyQbLNGpLGdUsvMpxr/VvVucFo6ZY7F8RQT0cmgpYVv7JAUkl/igOvuEgDxaaN1FkaDE
 9EgXhUmiT/6rAhlvFTAIG9H+k8skMr+mZKoMVxnsQ0D6w+iWuvDcMAnc0UoXbGAbxw2+OV1KpO3
 l4SDupUasL8iuOlTf98ZTFEMMw7b6hQnMYcyXB3JHrIxKJaSp4UjDlWVKTuoB7Wwws6dB+yULNd
 eTjabngxshSQJya/r+WVm4ms58mi9v8h+7tIsQn28UNhiBHCLgB7/LQ4RDLeQCyhayQTIPYouwK
 8B93X++4kufhmp94a/WkZPjQERAzJ5eN21ohKHmZbNI/e5acj7vyxGQAOuWqDwmzT2dOgPzeZw/
 jh/kN63kQxLL9+BmuwXLMgWl8Nwz3Q==
X-Authority-Analysis: v=2.4 cv=YJeSCBGx c=1 sm=1 tr=0 ts=693a81f9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=eWIy-B4KrGggPVQfYp4A:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22

On 10/12/2025 20:55, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 737adc560818..4eb0704a0309 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> +/* for unknown kinds, consult kind layout. */
>> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>> +{
>> +	int size = sizeof(struct btf_type);
>> +	struct btf_kind_layout *k = NULL;
>> +	__u16 vlen = btf_vlen(t);
>> +	__u8 kind = btf_kind(t);
>> +
>> +	if (btf->kind_layout)
>> +		k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
>> +
>> +	if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Can the bounds check be moved before the array access?  Currently the code
> indexes into kind_layout[kind] before validating whether 'kind' is within
> bounds.  While computing an out-of-bounds pointer may not cause immediate
> issues, the bounds check itself appears incorrect.
> 
> The check uses '>' which allows access when k points exactly to the end of
> the array. For example, if kind_layout_len is 40 bytes (20 kinds * 2 bytes
> each) and kind is 20, then k would point to offset 40, and the check
> '(ptr at 40) > (ptr at 40)' evaluates to false, allowing the subsequent
> read of k->info_sz at an out-of-bounds location.
> 
> Should this be: 'if (!btf->kind_layout || kind >= (btf->hdr->kind_layout_len
> / sizeof(*k)))'?  This would validate the index before the array access and
> ensure the full structure can be read safely.
> 

Yep, good suggestion. Will fix.

>> +		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
>> +		return -EINVAL;
>> +	}
>> +
>> +	size += k->info_sz;
>> +	size += vlen * k->elem_sz;
>> +
>> +	return size;
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486


