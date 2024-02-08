Return-Path: <bpf+bounces-21500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FD84DFCB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D7F1F28893
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438E71B3D;
	Thu,  8 Feb 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7njbOhQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e/WdmiSi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D276401
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391958; cv=fail; b=SecQpFwvkgsCXpL+A5KgkCIFWm+0fHrM/dUNrEe9pZqbC4YWb8I2UyQJ5KTRIJKNyQnsClk6RiZ0tA50L5IrWz+J29hzZdsHNZWbEovyk30IVqWuLpE9Nrz/R1X70/1gVeXdbXKNoC9ADQfp0NMdfTDdQEtCqeJCY0L/VbxjYh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391958; c=relaxed/simple;
	bh=EyCsTXMa1eYgzgbisbe0rjroYD8sOFxzqi53taU46M4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=RFYqxEoVoewDA915IljyZxfU/tRQNDTyKPmhySbk1AvNwNzP7aHS6oYoyfjTdEsQq/0eCDNgZgnQlFVMR0V+2pPBH+nySJypjlCGzXu0QCk/3vXt+6aCWwTeFfKJ3h4kv1mJmlwu9VLphkyNlBjkZhghl0O2PgvxA1WFXvUNygw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7njbOhQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e/WdmiSi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188xFEC025976;
	Thu, 8 Feb 2024 11:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=d583iADP2xaGKBvF18yHz5HWDNRHwrMmIcfEqj54Hq8=;
 b=I7njbOhQmIkV+Q9Z4Brmc0hedTv6giITAgf4EhxHZVGNnpOZZGcvYzw8mHea2vlrvZcr
 FMvYCHMHwN93sExwZQYScnFQxNsOYtys2f0F6QNCiR24vUULeFeYs94kOAP2cN2B8NNv
 ES0fUbp7C4VMPlxazp1nUDG/JZBuG9C1cUiHBgviyMhcMtVFYUrLSjdPZ2Lm4bilhyFk
 VdFdJwmC5wzaMemeHjBm9YecuN/fh/dWDy2xbwQIrMyv6YI80EwrZCkKxY/UOBgmPZMt
 DfxP6VYeNXBAZEcAbwUoEm59iQu4vRujhIvSHP2Ec192h0y/mkICifGp5UHdo+0+bprn Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ume6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 11:32:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418Adfe5007036;
	Thu, 8 Feb 2024 11:32:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxavhs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 11:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVwC8FAGmLZCPpe1EtgOjQ9i0t/+r2gGNKZKlz7AuI9gAvkSip4RnlgyfCitd63FeXtL05fdq8FO4AJPnjAvXrGT/lgTdHp5o17JXGGVhxW6/jE3cSVGhiIbxyIFWV19WUinLx54ev2UDP431lQLp3FnAYhmQ/L7U2NhxsOKeB0KOIA8Ly8YyKBNd0bRBwB5tXR7B+fEwQivR/Dv/TLG9ZJlMAWCBNUhSl2k7/W260/YEXOozt3/k3XYmf8pdmsdxEXW2Cg7vfPyepOnvXucS4/0B6IKz3k/qFK7s/wnKMw+Cl5J9jC2PwZ6AQbATgS46BsUvOz110/fhoqghBnpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d583iADP2xaGKBvF18yHz5HWDNRHwrMmIcfEqj54Hq8=;
 b=NnfNSgMbXgkkKwkXI6Ofr/8W29dHAEb2IwLg2SvarxYWFhaNv75rbFzj6wPR7wFlGNqLrElujfHuwFaDj0BQl2SWSe9K0LSSxn3qXPoTzpQ9I2qnk7mTMLWrcuY18bbbjsqKavNdhbNUwW0t6UPe25nQZW3CL/cb7a0ktFQrVj3OAWtohpFdhDzmOPBF5eDF501jq8P+OVmEUptzYR1Qz/23MjN6Z8XQpkREUmSn/ER3zV8G7k0gzppVWvAI92eT2WvDODib6zCD08Es/OAhr0WYticYeXADVAWf1/SkpHicQbAf6dH1j9giSGSeWJr9v/CpWZp+FymhMPI1wKb1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d583iADP2xaGKBvF18yHz5HWDNRHwrMmIcfEqj54Hq8=;
 b=e/WdmiSiYXZ6bneGuNLPby6pyXGYSZXubTG5f6Nvo+GZxil3EcXeDlAlMNLA/P/Fmml+2okDLj1AKjJmqyM8M2VMTSkhF+geVIW+qQ3b33Y+4Lvxr0+LuyLYNLddOE5cdIuryEl8cR02sUml6ynec6t0q1qjH8RER2/vgJvYgHo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 11:32:24 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 11:32:24 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev> (Yonghong Song's
	message of "Wed, 7 Feb 2024 13:45:00 -0800")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
Date: Thu, 08 Feb 2024 12:32:20 +0100
Message-ID: <87h6ijfayj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0079.eurprd02.prod.outlook.com
 (2603:10a6:208:154::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee4db7f-6528-401a-e401-08dc28999f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YDbmFpi5ft4VVwrp8hYJnDqbEoALIhEUp8AiGPFwr2wUu265HoYE9DdzyqrFU7EQ7ci5ATxByUuPKlwvxOQ9JXQjjXWf+9PSWoty/6iKInWBzQES6uYpdmRk2Nhmp+b0dlg1s3SMhi83LP9KM8FCDkpNmWkK7k2wDJVckLTBy5TGB3OnrGsVlmIuPEZsqqyjhIVmPlRyHMeQK5CV2Ie2fm4Hfel4lk18OIv4n1iK++tUYyZcWg5cpP0BhT4D+xv+JoX0piVlnhRYQhETMbi0cRoNj44EFb8Jh0aDAXkvYEO/S/sSMp3uiV9+KrDSkKyxdrA+kYzlJhWUHCgmeuX2IM2e/Cxlwlw5q6P+FeAGWk5dXz1DNPXv7KMGy7MZrocSrQHk0eZdoQDkjQHxvcVqtlwz6PRDvPDoX9gHX/TsqwVP2d3mt4ZHACyyCbMXoaVyl2aSvLtNcvYd8yy5FkkROHGyN7y+4kYZgcLxr94dqtwbr/beL97F9bDfB9r+L+dkAKthoggRXb2Git5WmcNiW+LS58aDBtB2h6/uod170YY6zTaCz/Fyb7NCRPj17dTl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6506007)(53546011)(6666004)(83380400001)(86362001)(26005)(41300700001)(6512007)(107886003)(2616005)(66946007)(6486002)(4326008)(36756003)(8676002)(8936002)(2906002)(478600001)(5660300002)(54906003)(316002)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CdrzgpctU823ZRAlRCJbRFfe+BTMhxonR5hfD1x5bUx5s/5FEXt9MyXm1Ztu?=
 =?us-ascii?Q?X7VZCEQjIpZj5YGIw1huxFd2qJZR8F8zx68aMnOhjxy+kaqnPGH6CumUHkKN?=
 =?us-ascii?Q?lNOQY/gkYahm+G6F6ZTMRRbxhMfE7IK820nW5bNdUFoDqOFcySxbiHa1vq6z?=
 =?us-ascii?Q?bbEvJriAmW6Uoi/DS6SVvctYM8Ha3UJ98LBmobd3vu33V4+HncNjPSoQT896?=
 =?us-ascii?Q?j2hl5iOKIQPDggZd3xzWO+je6Ithjf4Rc4qCOsOovwtuiZR133HmRAEDg6Ri?=
 =?us-ascii?Q?OZ/m2ocvYGPZDIixaxq7usZXd3qCfsLaWEt4jtWWwxyPrCq60dDreYSjX2H2?=
 =?us-ascii?Q?+ADxaA/BbtsQfhbe4c/LSK1IsfXmcoV2XyaNE8b8xiNNsV3/akYzCjlZ32ku?=
 =?us-ascii?Q?HpcBzjbwUbYINW9ShHu9PSCNDfkz48O6tDyXnPQaEjuB8srgwPdf1eIY82nb?=
 =?us-ascii?Q?+byQdd2dxWyvIoGPBRmrQQT1D2XOSrlGgZkInisPXULWXf7KtJuQ1vVJR00B?=
 =?us-ascii?Q?z/9NJab5L52ODG1WoWJNQkXLvpg5F8BSXGASSX9sCHZr++UhCvIPa4L9NyTV?=
 =?us-ascii?Q?Oo40aOdFg2tjI8+KoQABUYIWqN/yQ3IeAbUwYfN0Iuy6jlQ+5XDsYzQH3o+A?=
 =?us-ascii?Q?X3tovAAecQInpw0mGb0t6yUsP3OTAyl/3IHVaNQ5yxuEairSJ4PwQI+nsVd4?=
 =?us-ascii?Q?UAwClVWvP407xQmG1ORR9ykYEsDIgEd63dAOwZKSUHw8xANCCKrf83zBhnPY?=
 =?us-ascii?Q?tHFG+whAHHf9QCgi7Q8ZGZb1V34ZfB852Js5mLTYovMG73Oq+DwYshF8pM/r?=
 =?us-ascii?Q?Ic2/VUEBiuv92NtGa+joxECyL7spezazs4pJjn42/TWbrh6Gnp9aO2XNKzpb?=
 =?us-ascii?Q?VHCqVTlW1H1puRGxiCTF3YxzLB3y9Snis9I9ji1FhngMU/p04jSHVmmNRXjd?=
 =?us-ascii?Q?VMMdqA0gSDfxTW57QGnB6hNuAMUr3KMT76mJWCU+jFn07A/xRq0Rl6AvOlat?=
 =?us-ascii?Q?f13v4YzQwSmzWu+VOtoTnTv8NM+MX8yb2xpWQo5CEow/1vUmCfBJuuoOgNpV?=
 =?us-ascii?Q?qYllY7S4oC/dghtM8k25LJiL6ITK6dcK/2blKszvuRmTRtkZf4AGV3TMcljL?=
 =?us-ascii?Q?Ey1EvNOiLqonmmDKlGAqVBRr1ircMdFU1Rh54NdSNnviY8TBL1/fTdWPoJck?=
 =?us-ascii?Q?D9fwDm+x6J9ePg9aehRELmg0lLumRJB0HPJaOXpLUfbYpattBHTEmdqAAsas?=
 =?us-ascii?Q?BfSvGzZDyzliBiqjp5Ka5kgUAoJL9IB6rCxoHpG3p150AkM8PtAbmjfNmtKq?=
 =?us-ascii?Q?zuruGK6d5FAZQkjAy7yoW0gmUK9Yw0mAO3E20S5lsMKCFUwK1xd81OTcizP6?=
 =?us-ascii?Q?T+fNZIrUM/BknMsJeVup026Qvq02VJhWqpYHEl4uPJWyreP/mbNV5zVZJkP4?=
 =?us-ascii?Q?PU+Og1+0jNjFaW5Xo7m9WcmQR4bvPgR41x57Y33ElUYnxxT+md0Qk8FFbwhN?=
 =?us-ascii?Q?0Vvjq8+Z20dHnigydN9NAxt6RT/yd7ULogSVNaCI+QBVRLWCoAYJucL6Qpvu?=
 =?us-ascii?Q?8uCcbCC/BaJxcn206MVcdtVSQY0Jo0vQqE0mXUhxeol6wPUv7tPTyJQKSMHC?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9I0de54/RuhyDeTh7nONZEl4uzsk1puJ7ZlL8MV8qgRthlpRVsLP+lvSysA4LHz4a+a4L7js+FYdE3xwipSAlJ7erEykJb24uVQp/SUi9Si5VxtreG/h01DY4brM6fY2NlbaWpABXcIHJqIhOyxBk0lZEOumhAju4uxzVpONqkACqdxIrNbsOJuNeiOrxGtfHUCd14eZdwQFFjDkgMcKzi1LGc6eUp1W+19+XUSOrPjlo/I4wk4twwiTKNKViqiKWj4VGAmyuBtsW0E2TSy9po5PtqzXpUhqIc/zoay23Lu7cDSvFdKdJfBO1xTXxTTL/S9jhrjclP7JJHI6VZC1YEqLM52NYaaxuLQOhNS+lo88kMaFbr/xQqCFPfOVqgIY8JECf6DXzr+QznON+jd4fes5EnAvYasIZuY8jNHLotKob39aBHvEQD6xugjlL00ENdqDn8WpDMenRk1BxSsJjHu2qFIsTGVawczIECwf7tX7AIhwF+5qBNnQRB2EdN95spPtB2VEUZfCqk3jqeoEt7nt538qTKtCPwllgLYaqaFIBfqqaFSPf8ByG+BL8b3vwg6pOYZq5ooobIHPrqgdoimmQmfWjoG4xSonBbY/zS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee4db7f-6528-401a-e401-08dc28999f0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 11:32:24.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6Pn9oYJVHOb4aQrfjnNc8QetEYPWoCMCLdh6hEmxSOaS2D0gCWagM2QuYiBa1FPSVkr46b4l9QfBi4Tz+8W/j3o0G9RMhxitIRkv9GXqls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_03,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080060
X-Proofpoint-ORIG-GUID: gjPnCPU92SLuiPUsbFR0FGaHAU6dGV51
X-Proofpoint-GUID: gjPnCPU92SLuiPUsbFR0FGaHAU6dGV51


> On 2/7/24 2:12 AM, Jose E. Marchesi wrote:
>> Some BPF tests use loop unrolling compiler pragmas that are clang
>> specific and not supported by GCC.  These pragmas, along with their
>> GCC equivalences are:
>>
>>    #pragma clang loop unroll_count(N)
>>    #pragma GCC unroll N
>>
>>    #pragma clang loop unroll(full)
>>    #pragma GCC unroll 65534
>>
>>    #pragma clang loop unroll(disable)
>>    #pragma GCC unroll 1
>>
>>    #pragma unroll [aka #pragma clang loop unroll(enable)]
>>    There is no GCC equivalence, and it seems to me that this clang
>>    pragma may be only useful when building without -funroll-loops to
>>    enable the optimization in particular loops.  In GCC -funroll-loops
>>    is enabled with -O2 and higher.  If this is also true in clang,
>>    perhaps these pragmas in selftests are redundant?
>
> You are right, at -O2 level, loop unrolling is enabled by default.
> So I think '#pragma unroll' can be removed since gcc also has
> loop unrolling enabled by default at -O2.
>
> Your patch has a conflict with latest bpf-next. Please rebase it
> on top of bpf-next, remove '#pragma unroll' support and resubmit.
> Thanks!

Note profiler.inc.h contains code like:

  #ifdef UNROLL
  	__pragma_loop_unroll
  #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {

And then it is inluded by several test programs, which define (or not)
UNROLL:

profiler1.c:

  #define UNROLL
  #include "profiler.inc.h"

profiler2.c:

  /* undef #define UNROLL */
  #include "profiler.inc.h"

In contrast, in pyperf.h or strobemeta.h we find code like:

  #ifdef NO_UNROLL
  	__pragma_loop_no_unroll
  #endif /* NO_UNROLL */
  	for (int i = 0; i < STROBE_MAX_STRS; ++i) {

And then programs including it define NO_UNROLL to disable unrolling.

If -funroll-oops is enabled with -O2 and BPF programs are always built
with -O2, then not defining UNROLL for profiler.inc.h, seems like
basically a no-op to me, because unrolling will still happen. This is
assuming that #pragma unroll in clang doesn't activates more aggressive
inlining.

>>
>> This patch adds a new header progs/bpf_compiler.h that defines the
>> following macros, which correspond to each pair of compiler-specific
>> pragmas above:
>>
>>    __pragma_loop_unroll_count(N)
>>    __pragma_loop_unroll_full
>>    __pragma_loop_no_unroll
>>    __pragma_loop_unroll
>>
>> The selftests using loop unrolling pragmas are then changed to include
>> the header and use these macros in place of the explicit pragmas.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>   .../selftests/bpf/progs/bpf_compiler.h        | 33 +++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/iters.c     |  5 +--
>>   tools/testing/selftests/bpf/progs/loop4.c     |  4 ++-
>>   .../selftests/bpf/progs/profiler.inc.h        | 17 +++++-----
>>   tools/testing/selftests/bpf/progs/pyperf.h    |  7 ++--
>>   .../testing/selftests/bpf/progs/strobemeta.h  | 18 +++++-----
>>   .../selftests/bpf/progs/test_cls_redirect.c   |  5 +--
>>   .../selftests/bpf/progs/test_lwt_seg6local.c  |  6 ++--
>>   .../selftests/bpf/progs/test_seg6_loop.c      |  4 ++-
>>   .../selftests/bpf/progs/test_skb_ctx.c        |  4 ++-
>>   .../selftests/bpf/progs/test_sysctl_loop1.c   |  6 ++--
>>   .../selftests/bpf/progs/test_sysctl_loop2.c   |  6 ++--
>>   .../selftests/bpf/progs/test_sysctl_prog.c    |  6 ++--
>>   .../selftests/bpf/progs/test_tc_tunnel.c      |  4 ++-
>>   tools/testing/selftests/bpf/progs/test_xdp.c  |  3 +-
>>   .../selftests/bpf/progs/test_xdp_loop.c       |  3 +-
>>   .../selftests/bpf/progs/test_xdp_noinline.c   |  5 +--
>>   .../selftests/bpf/progs/xdp_synproxy_kern.c   |  6 ++--
>>   .../testing/selftests/bpf/progs/xdping_kern.c |  3 +-
>>   19 files changed, 103 insertions(+), 42 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_compiler.h b/tools/testing/selftests/bpf/progs/bpf_compiler.h
>> new file mode 100644
>> index 000000000000..a7c343dc82e6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/bpf_compiler.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __BPF_COMPILER_H__
>> +#define __BPF_COMPILER_H__
>> +
>> +#define DO_PRAGMA_(X) _Pragma(#X)
>> +
>> +#if __clang__
>> +#define __pragma_loop_unroll DO_PRAGMA_(clang loop unroll(enable))
>> +#else
>> +/* In GCC -funroll-loops, which is enabled with -O2, should have the
>> +   same impact than the loop-unroll-enable pragma above.  */
>> +#define __pragma_loop_unroll
>> +#endif
>> +
>> +#if __clang__
>> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(clang loop unroll_count(N))
>> +#else
>> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(GCC unroll N)
>> +#endif
>> +
>> +#if __clang__
>> +#define __pragma_loop_unroll_full DO_PRAGMA_(clang loop unroll(full))
>> +#else
>> +#define __pragma_loop_unroll_full DO_PRAGMA_(GCC unroll 65534)
>> +#endif
>> +
>> +#if __clang__
>> +#define __pragma_loop_no_unroll DO_PRAGMA_(clang loop unroll(disable))
>> +#else
>> +#define __pragma_loop_no_unroll DO_PRAGMA_(GCC unroll 1)
>> +#endif
>> +
>> +#endif
>> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
>> index 225f02dd66d0..3db416606f2f 100644
>> --- a/tools/testing/selftests/bpf/progs/iters.c
>> +++ b/tools/testing/selftests/bpf/progs/iters.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/bpf.h>
>>   #include <bpf/bpf_helpers.h>
>>   #include "bpf_misc.h"
>> +#include "bpf_compiler.h"
>>     #define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
>>   @@ -183,7 +184,7 @@ int iter_pragma_unroll_loop(const void *ctx)
>>   	MY_PID_GUARD();
>>     	bpf_iter_num_new(&it, 0, 2);
>> -#pragma nounroll
>> +	__pragma_loop_no_unroll
>>   	for (i = 0; i < 3; i++) {
>>   		v = bpf_iter_num_next(&it);
>>   		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
>> @@ -238,7 +239,7 @@ int iter_multiple_sequential_loops(const void *ctx)
>>   	bpf_iter_num_destroy(&it);
>>     	bpf_iter_num_new(&it, 0, 2);
>> -#pragma nounroll
>> +	__pragma_loop_no_unroll
>>   	for (i = 0; i < 3; i++) {
>>   		v = bpf_iter_num_next(&it);
>>   		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
>
> [...]

