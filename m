Return-Path: <bpf+bounces-49851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF86A1D532
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF4F16633B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4531FDE3D;
	Mon, 27 Jan 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KasXBWf/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LF76/lGe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AD25A62A;
	Mon, 27 Jan 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976698; cv=fail; b=V7oDwGzin2mIow0efv/wbsJi4tr4Faiyq3ycyqfwDRLf/36XxHLT4sQ+RciV763NvKAcXlu7C9cgR3q4nU9mO4+e1AynbXAX6YLTmFab8BTPW+8JSgGiHECBviAC0K8xLEyXlQS8XX2zAao+sHjmmfS2Bc02+BoGtSx7TFjxmqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976698; c=relaxed/simple;
	bh=qyJn2CN7DSRLxAmwqZwIe1golUgysfxqUfAk8NFCiGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BlX4ADNUxS59q1adOai1dRvHMI5UwNcgrTkxZ9cyMoCeA6bgQ1ba20zC2Y0wNZCiWGprs66bkjTp29VSCL0LVymrdFWSPAjOf3bnLyoawGvLT9PnfJl5UYOp8WgWw+Y/yGca3tDTBNlMZnA/X8pPuHILYsiiLhauuv1wx3w5x00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KasXBWf/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LF76/lGe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RA2Oq1030939;
	Mon, 27 Jan 2025 11:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zgq4NVwGBXCvjqwboWhdCYPU3y81/hgQ+A7walvUTyQ=; b=
	KasXBWf/+2mBZznq6Y3fWY3hdA0MzmZewHRnd+bAfGRdGdgViKnrXVR7if80BpKA
	fiSCihjhgYtow8vIxyT+H9buWlqfQxVhUkPWz++he8EIzPMcOeutWkRcyHbZsFGQ
	AjNWXDDlhX4cI7Jc2q4DntF2OKnDs87c61AnhK67k4kpaG0oB5gAPZHylkk324re
	Td5RBs+pQClGBamLQOrcEDOoXrIrJbbeyB4Xa9enVyJ0tCdCQbmS4spaRjE9tRNq
	dTjpSuIyXgAKjpa0DdoQ/KKA2w3/HekOSAbA7Kv4u8VhZNlskI7Et3oMB9w/EJ4h
	I5ayiwy+9F3RTKRUMS7nuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cpj0jnrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 11:17:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50R97s2W022882;
	Mon, 27 Jan 2025 11:17:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6u93k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 11:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdbjIVv0eLCQb7Bxs4QGHfPHaPYvEXztGSCoYTxvFAORC6hSqkewEUKh8RQFfzPgHZZnp7aaBl/HqbRsLG6aDmsk7y2kiWp7KV/h8XvLj7qdAlOzphDOnWvkcQqTb96iYF1HRoTgedyAHCIXKAtwSbCEX/ez8Bg01OUPP7hs49xLPaML09J/+Yk/NdecVKbYOelMxIggYpr4/9lMN4T0R/W4o7Omdy/rE0NB2P95yBWSRjrPgrxy2nChAhVtWiJhkWOByw2Vqx8CYPGF93boFuLd6EBG09x1yrK2cNkep5j/bHocDFOT3CKp1o0Wago6rmT2bh6FfHfzfmvuGwiwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgq4NVwGBXCvjqwboWhdCYPU3y81/hgQ+A7walvUTyQ=;
 b=GKsHGFIS+gIuN63jSjctYfd6DIIpfpywkxvN4euAoYQSw7kvNQwG156uh1eJOuwBrxFfeszhWXjbaH/0s2gdvSMpG607FvpJye68frrMwZ2LyoO5dsCpj8Bb0jo9yW3jnhKTsuHo6MXg41hUyYwRTVdT4G+1+qISCKmb1RaxfbXrMi++zTpCKiDGLot5zF7vZLQP4XJUtSezpPQNaHmo3sgmZ9PPVQwfTRIwtQ8Ds7DKKjzZwnnzTfFw/g3/4oWF43e7sr5VQdrEllNblHcJqjLS6cN2+vIL5gDU6i+dw0mPCEoWWLpvk4lwtY3VyZdSMDWWzYQ910pKLI1ZM2Zu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgq4NVwGBXCvjqwboWhdCYPU3y81/hgQ+A7walvUTyQ=;
 b=LF76/lGehf6wRpkn6haXjZ5B5PMtOQ46+pC7+QxDnCEKrA9rYgzw8o07X0pMvaI1a4vm8e151b/Gcw4SDiRNwqVlz0tFhHmZ0qyFWfK7jTWXayWbsHWACreIBA6cfYKZjgAURUPGLb5HncYGwq0FPZnkeo++BAdG/lnRRlvTwPw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7268.namprd10.prod.outlook.com (2603:10b6:930:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 11:17:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 11:17:45 +0000
Message-ID: <54ff082d-5409-4fe6-b711-b80fdedd751e@oracle.com>
Date: Mon, 27 Jan 2025 11:17:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are
 really in ELF section
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, stephen.s.brennan@oracle.com,
        laura.nao@collabora.com, ubizjak@gmail.com
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
 <CAM_iQpXGzy5ESZ3ZE0Wo_p_pkXYbgMe3L8stbBcBCo+oJuWimw@mail.gmail.com>
 <CAM_iQpU8jQ9yEs_rAf2gdyt5yie7BwkiU4vpa-efF6ccVo5ADg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAM_iQpU8jQ9yEs_rAf2gdyt5yie7BwkiU4vpa-efF6ccVo5ADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a8e939-7036-44ff-779e-08dd3ec4395c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmcvUGhIUDFvSG1lcVhlQWk2K0NzYVY0R1pZZ1VlaUt0enVhbjBSQWJsYVIx?=
 =?utf-8?B?KzN5bit5U3crNVk3cm9XUnBTVlBPbHo4SlhGRTZKMzI1RytCOVZLL1dMSGdT?=
 =?utf-8?B?MkhRVjlPd0VMMURVdEkvTnpKRlJIeExSdkVna2Z1M1pEZ013RmlBVi9UMFpS?=
 =?utf-8?B?SXhHU2liVW1yVktDdVloOUExL3UwZ2ltOG8xbTV4Y1dlNHI1a2NXNHA1OEpl?=
 =?utf-8?B?UmVabzZpZjZUQmVIRDZiZ2JocFFrWkY4VXJwR0VxaHRqTDFYcVE4R0hiR1RN?=
 =?utf-8?B?YTEwdUdla0lJeGpHb0I5NTU5Uk5icGpIbUNNenh6UWovalNJbFFZQllUZjlm?=
 =?utf-8?B?WmZPMzg5RjhpWFBXUU1HcGFhZ1gwOXhjb29xVWUvL2VQL2szMm05Tk9CdWo3?=
 =?utf-8?B?V2kvMEVMUlI3WWtJam85cWQzb2tId1lUeGUwTHUxZjFOczBtMThrRU1kS3Vj?=
 =?utf-8?B?dCs0bDBybENQT2tqQWRDVzVtci9aVEh4ZWM5R3BuZCtqSDlPY0tlRGN0bG5Q?=
 =?utf-8?B?UmZ1WGl0a05hOE84U3ovNXYrayt3R2hab1ZYNnVQUVFGc0JGRkNPYS9rV2Vi?=
 =?utf-8?B?SmdJMSttaHpTUm8zd2tFd2Jad21wNllocnRaUnNCS0RyaEZRT2gwMGNyS3V3?=
 =?utf-8?B?WW93QjBWZFRqeGZVd01EekEyOW1NdS9rdnR4OHhtNDIrYWxQaGtwVWh1Nlpq?=
 =?utf-8?B?V1hkY1FpREJmY0RkRC9WVWpRU3AzbVFoZ3cxMjJ0RVNYZ2tLTEQ4N3J2Vkw2?=
 =?utf-8?B?MWhNalpSTnpTb3RuQmJ5QnM0aWxaYk5RRW9wVTQ5QVZPUkRuNzJvMkRUWmpR?=
 =?utf-8?B?TmIrdWlyazBNOGl2dlQybVEyWXhVWEhHZGM0K3ByNDNFeEQvQ1U3ZEIrbk5s?=
 =?utf-8?B?TGV3V1ZrSFVNLy9JbkhMYXdBR2JYMlVMZFgremFXRFFXdjJTK3lsNDZJY054?=
 =?utf-8?B?bSt2QWxYTkpZTzJlVmlUazJodWgySE5laVVEcWFvWWpZeG0ySnVQU2FPa1Zt?=
 =?utf-8?B?WCtNZnUraUduaUFQMTIrNzdyaUxKNHJ5Qk9PWG1hVCt5VWRSZU5mbmh3bHBZ?=
 =?utf-8?B?Tk54em5qb3JQL1Z0LzUzeUJocm9HRVJibW9LZ2lRTGRZVXRwemt5UUJ5MUlt?=
 =?utf-8?B?SGl0cjZUeDh5RmVGT09jOXczYzdlU0hRL0hDYldQajg3Tzl5dU5na2pYc2FH?=
 =?utf-8?B?TWpNZ0Z1MWtVRGk0eU5kS3VzMHJXdzhGTDRRNUszUlVVbzlNSnMzMVQ3N25N?=
 =?utf-8?B?Y25Cem1hRlJVK09NS3hndUVybjcwcW9PSUk4UmZoOFhXbE40WjJ6aW95R3lt?=
 =?utf-8?B?eHJlY2FIYmpCaHk2VXp5MEdaRm9ZbTh4NlhmU2g2T2N4anhDbGdyTmtqSnpE?=
 =?utf-8?B?R1c3NU9HRjA1MllQMWRxd3dXalNaaFM5Q1ZONDl3cnk4WDRBNHdqNlpTOU52?=
 =?utf-8?B?K3VoeDNuVk9iVk1VRm42UTY1TlQ3a1QvOTJGUUtwOHoyaGJFOENraWNpQmU3?=
 =?utf-8?B?bGUvcXUxdzRodFpOL3FFQ0ZYR2lpUE55MjVuQVVKTTBmQjBMUXBwSEpKTXBl?=
 =?utf-8?B?QlliemJkenRKeHRUcCtJV0lVWU0ybWt3d0wrQWJLQ1I1ZjRzRFlMQmdoVi9R?=
 =?utf-8?B?WVZnWktnZU5mZFVDSVkxSk1rcG11OEozR09McTltYk5SOCs3WnR6WFM3ZktB?=
 =?utf-8?B?SWp6NVpWa0ZES3RySVVOVWFCWG9wRjBmcEQwVXVCRDhrVUFwN3RZZzRTOXg2?=
 =?utf-8?B?WUVYbERURWtHK0s4REhVckxQZ1VEY21CMmxUYjlFMTBSQ1gySW1HeC9lZHlS?=
 =?utf-8?B?ekJ1SGloN2hPRmpiMi8vOTdlaHpUNlNSaENrdy9zWnliM2t4SThkd1pqNGtn?=
 =?utf-8?Q?eSD4LQODsvPSW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGQ3RktubmhiZzZSM1Jxdmt3Z3VhaXErcnE1NlBabUI1Ri9iOGg5UXpKdjdB?=
 =?utf-8?B?QkVLZVB6a2l5a2I4bkpKaDgvTFJJZ3d6dTc3eDJNditqRTZMdDZjc2hBa3ZI?=
 =?utf-8?B?RjMvNklIQ0JDVjBJVnZ3cEEzRkRyN01LZWJYWTB1b3lDZzJvNFlrbFFCdjln?=
 =?utf-8?B?Z240aFBpVW5Rcll6MU5sclJ5djRNOVNjWUNYQ29YUlE3MjhLS092RHV3Yndj?=
 =?utf-8?B?VDhwUHliSnY3ZURCREtQNGpWY0xkeDlBNTJqUE95QWEvNG1tQi9RME9mNmRS?=
 =?utf-8?B?anIrbjBseDd1SUtBUm5ZTnVmSWpJNnJhSDNSOHBFN05SUzIzRXF1ZkRIV0I4?=
 =?utf-8?B?NG1jZ0ViZ045V0xYZXJSb1FHVWFoaml0UytoMmVDcUYxeGZzcndwV3VTZkZK?=
 =?utf-8?B?eis3NVFsVnQrVkxDVUtyWUhVdmhLaGd1RFE3M2RaeG81K2tMaERNNHVNbWZC?=
 =?utf-8?B?ODBFclJEUUloTUh2WUI2Y0pZaVk5SWlOWkpnekR2TEdOaDQ3aGtsRUJQTUJR?=
 =?utf-8?B?SUtQa08xL3RtYXVIcytTWkhMaTh3Zy9PdFoxL2p3VjZKbW44QjV1dHMwVFhs?=
 =?utf-8?B?VjVuWGxJN2dUc1JJSjlzMU1oQzYwMVVEUmpjWW0rNTRlNUV0QTFqTlhBMENT?=
 =?utf-8?B?WkFwNWhPa3YybWRpcG5XZThDUnRHNHI1dVdrSzE4T1JkeCtXSXladmZBZmtJ?=
 =?utf-8?B?QWxrMlI3akQ3V0xkcXBXWktlb09qcGJ2QlVJeWhHT09YRUtoWm5qQ0tjWkRw?=
 =?utf-8?B?OVk5bUdvUmhCLzBTbUxjeUh3aHZZOUhsN2N4WWRwR0JKZ2YwTjczY0FvcW9I?=
 =?utf-8?B?NTltUHRieFgvSUViTUZucTNuN3ZEZTlVelVUTllZUWRXbnJnUmM3aGVIN1I4?=
 =?utf-8?B?akE0K1FUWlFhVndNdjlQTmRYT0NyTnNqRjRPVFZBOUVGLzkzdlU1SmdaVk1T?=
 =?utf-8?B?Sk9YTkdTYXZmMG5oYVJEQzFQVGZCVE5GMStpVlZWbHFrMkNCYUlNcGRUSzBa?=
 =?utf-8?B?V3oxSXNSdit6dnhPTzlTN2ZOOGEwSllVT2xwLzhDWmFMeGZGM2NtRE1TWDJS?=
 =?utf-8?B?SWNWcm5aaHAraVBFUE03Z0hRSmFZRmtZVS9RWHhwNU9xQUg1VVpZTTViTHgw?=
 =?utf-8?B?ZTJoekVBa3Z2T3k2eHkvbnpHY2R1cEM4T0UvaWcyWXpZTDdRQjFxOWlJSmxm?=
 =?utf-8?B?bzNCUnZBSEtvN2lXSytjOHNYWHZVTUE5RldJYWR6RU91L3lGd2dkV1FjdHhR?=
 =?utf-8?B?cVpYdjh6VU1sTExPaVhDTlozbWI2WVcvUGVWelIvWTJQV1VFN2NuNG50Z3ZG?=
 =?utf-8?B?Z25IcXBubFNVNmNiZ2QzNkFZUzBrOVdlamc2Y3ZQR1VJUTdtdjhXK1RJeW1Z?=
 =?utf-8?B?WGJDNXRGbWUydlJOUmNSYVFaL0YxTFpKb3JxcS9RQjRXQ3BRMzRtdC9OMFBH?=
 =?utf-8?B?RGV1RW4zMXIvNktod1RpcVhlbTlLeDBsa1Z3YlVhUmpVSWxUc1puY0VvSUJ2?=
 =?utf-8?B?UENBOHVZNjlYK3ovdGhHODJpVDlBNTZQVXl2b2w0SVljMHZQcVgxbEszV3hC?=
 =?utf-8?B?bnQ0NFA2b1FxZlV3aG1KQ2xBY0hrTlA1VnZTaU1DRWdOZzgvcFBRNVlLcTZ3?=
 =?utf-8?B?eWlPcVRRaldWRG1qUDBJaFlHNmdSV0tBSkhLbVNQd2RaaDBpcWlHalJJZ0wy?=
 =?utf-8?B?OWVVQkZrVmRuaURaSFl4QjN0c2VmUUQ3WEpzNXFrYmROU0Q2VlZMcHFzdU1U?=
 =?utf-8?B?U3pZRWNpa2t4TEc4R1pVN1Q3MFFpbGg1ajBXazZrLyt5dEQybDN4NkFWNHV3?=
 =?utf-8?B?QmQ4MTVFZVBDdUJkTWg2bDBrUXRTaDNRTGo5UjgyVGw4VmpoQ1BKUjE4ZUYz?=
 =?utf-8?B?WGgydGZ2djJyVVhabVFZMEZ5dmJlNlI1U3RWVzFwUWRDZEI0c1FPTmNLaVds?=
 =?utf-8?B?Wm81S0VtSHM4NGRUenR0UzBGZ2hzR090MXU4M0hIQW1OSUdWNE5XbnZFcHhw?=
 =?utf-8?B?TDFaa1BKa0JZMVB4OENHOFlQN3EvM0tkL2ZvdTJQSXlZVHV4azVzRlM0ZnZj?=
 =?utf-8?B?eFc5WFRsRVVaaGZrMzhFNHRNS1lobG5vcFhyY2pFOWlVSytRRG0vZ2xuSHp3?=
 =?utf-8?B?YnZweGMxVDR0NzZqTXB1MnF1VEF5TmtEMnJIM01HdzIraTJrbGdycll2clUy?=
 =?utf-8?Q?ALTKBbCZ4+WfTLdpPqPtRvc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BaI92mdY1z9eOj3pJOGXTXXEV+wVTmfj3zjNT56mu3x85rW6WGi5yC7zELT0ni6wZeN68G+dTdEZd2TfN3Z5jcLEEU2YToyLes/VnYN0HEA1Qnhu2qxfj0c5kJlm9GARIClvPQMpKg0QQCKed7ogNam9QLnPHiSMYPejZLsYvsdC/5txZzypTnOOhLwEEZAgcJht7ozUbrg74Z3TJLoAS6jyGG8ZVi0hCMAJaWFnnrS4/Fo78IZxb8ZEu4YURVt8Zeiug64lPBxth1ECsn9SmL81RNw0dstIzfyVqXw4kmPTUkJoJH8KOokLO3THWKZQ8r5cSwb6WOLbRNLfZM8c5Z0UKcsliLROUhO0fIBjUSnuO1n3CYexkbJ9+jRBRqpzFqC+FzapaumepSZBQO+4NP0pJLp5+VNJk0XaAwA+C1JfJ2vDkYPkPCrWLUa0bIPiP6AQNRXk4kTWez2roFZTpooS95bC06sbscnnWZuDv/A9XpOhLpX5L5ihmanHCZzqrK3teoIeCSQHSERT7/Enwj5tHD1oLWNXSlyllOijE/k1DMC2CxYM3/RtKNZJ2v+8/j24z/6b2aAi0wg6myzLgZ6aWj2uFmhxafKI3DN7ewI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a8e939-7036-44ff-779e-08dd3ec4395c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 11:17:45.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1Px7FFUVj2HEg+UgtMe5xE8EC8MnHxFe/HrLObBx5uqIOv/tYojXZNvHrxFmdfO+2f9HYty5wxnLuuBjpmw/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501270090
X-Proofpoint-ORIG-GUID: V9aAHXwGOht4m6LrWLCLWjNu2AVx8Ls-
X-Proofpoint-GUID: V9aAHXwGOht4m6LrWLCLWjNu2AVx8Ls-

On 26/01/2025 20:04, Cong Wang wrote:
> On Sat, Jan 25, 2025 at 8:55 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> Hi Alan,
>>
>> On Tue, Dec 17, 2024 at 2:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> We use the DWARF location information to match a variable with its
>>> associated ELF section.  In the case of per-CPU variables their
>>> ELF section address range starts at 0, so any 0 address variables will
>>> appear to belong in that ELF section.  However, for "discard" sections
>>> DWARF encodes the associated variables with address location 0 so
>>> we need to double-check that address 0 variables really are in the
>>> associated section by checking the ELF symbol table.
>>>
>>> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
>>> kernel builds where __pcpu_* dummary variables in a .discard section
>>> get misclassified as belonging in the per-CPU variable section since
>>> they specify location address 0.
>>
>> It is _not_ your patch's fault, but I got this segfault which prevents me from
>> testing this patch. (It also happens after reverting your patch.)
> 
> Never mind, I managed to workaround this issue by a clean build.
> 
> And I tested your patch, it works for me with CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y.
> 
> Tested-by: Cong Wang <cong.wang@bytedance.com>
> 
> Thanks a lot!

Thanks for verifying the fix! You didn't happen to get a coredump or
backtrace for the earlier segmentation fault by any chance? Just want to
make sure there aren't other issues lurking here. Thanks again!

Alan

