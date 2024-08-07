Return-Path: <bpf+bounces-36603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A294AF49
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DFB2821D2
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67B13E021;
	Wed,  7 Aug 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZG46A1L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aG9b3Ktp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5308126F2A
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053544; cv=fail; b=us/bPB2TUEE61UCklrenaCdwm1/a5+vtTwCG0WHflFlIRyJVNnnRY656DrJu69qqYDdhZXbURu9g1m02r7lCkiIEdLD7GzvMkIQB/q6ZeDQO6OpOrIbjWtMQ2RqdEgtOKK8Goty+40Mx6iG+dY3A8evg0qtgEyCDkS3NE1lCL6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053544; c=relaxed/simple;
	bh=oT98SeH3p/TbDQbIjK+TyYi0/Aww0Vk5nhfzujAvPSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=my58MOCkpTUUrccuCyUSziWdaXuVsfsWujkrtx8e2LYtpPQL6s2wH2EwDP9RjKRAjebwdKZ2WUM2De8Wf7fWAhBWfLuYpCBnV/PKqH3doXUvgKTD5P11urGV9GeYcoO8IFkYAXh5ndul3pRVuY0LPB39SEb59n7LwT/loetelDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KZG46A1L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aG9b3Ktp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HMXDm026252;
	Wed, 7 Aug 2024 17:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=fKVdwiB2B7EV0HpfRbVK2b3eSKklgc/sUAsE4+7i1LQ=; b=
	KZG46A1LhgxDfLhI1gl+M3DyEuNbw4l9AWdpBhcz9E354wLUSnY8OR4Utdh6Y2sK
	is4SFF6M0l0Tcde869jNN//a6AQvs61S++kiS5fgATmT4MVOgC4ujn+2xgeaYCJE
	IhJjd6xHmwguJEfmJuZNO6iiqHibF+UdeTehq0MJnPo3gbAasGK9uUjCuCdPXXNb
	R85czTwY9eOui00HdnDzt/qp3e3EhSQoa5NYLd6QauTc6JVvX1dwyNysSqcIEILX
	Tb+hJLatHFeMp77kpLZ/HZN1eG+ZiAfz28fYQ2kpt7FLTXFV2+rDja7oOyh/N6ha
	5norIdNh71rgA9cmGzpu0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51g7qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:58:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477Gs9Lk019793;
	Wed, 7 Aug 2024 17:58:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0a9ywm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2NKuw5BYDfb+K/3CusJBkkxcz+JWSBOo5B0WilcTCu5Pc0WMY4LE+MSOvvjTfuU4OdxJNE9oyNiEjd+5V9+H06jRXgGvXWpQyEJEx/FxmaYsLIPXcrPeXGvSC11GLFTdXBROxiv3Ej7sThFpZOpu7ZK5KnDYoFaa9uOESqUFziWyui6AHBXfNQJUZjtXfb2P5IGKWXyMXT8+UwIX34kkpG78Dbyhk1/oJcvq+q0N5dRXE08VRmEa8inrAhe0sBVU/gicgGU2O2TSodBR+vTPCCEHozLdjAjbA74+7KWUjPSYr5oUiDN4UDL3sixDuEC5NYAOxpA6mSq9yexGxpHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKVdwiB2B7EV0HpfRbVK2b3eSKklgc/sUAsE4+7i1LQ=;
 b=KihHypOZChFvYtS/lw2q5O3H/qV8+QAMgTH6mWuNUS7D0IH/kNGaWKLbuxcYR45h6DVVvEWBmQoyb8tsxEpgmlm/f8iFii9eE05GRTRAvluluR2713MCEQh0kgQ6tGGiPoAVkHQSp9nLqPpNXWAVysdjU65Vs5ZqoxZJuuZvKwUw3pP77RXOx8MZEYjOIZqo1oQG+n3hGgDKO7+Szu4jCYhvIOdzkyVZ72ZWDIjCIJ99dorU5dowS1dWHYMhIKKPHf3tat+gvgBSyFE/CdYa+h+4FIfnqT4ilcO9bCFyaPw/L2hEKxP6mxdUB7I3S2+Pax78Z0sRzABhk92AFyr7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKVdwiB2B7EV0HpfRbVK2b3eSKklgc/sUAsE4+7i1LQ=;
 b=aG9b3KtpdqAFxQZz7Ez+WtlIcWdb2x5LTS0h3lqGfwivYr+W7txuOAowzaGPfU0/hGWqRQcqf3m0jjJDqJtcNyoqhEF6JmbHcZeu23Tw7O8lLg4jNUpZB0a/quudqtocjrArLurXW6E0VrZDzvza/E+lW1TkBEQfnjzIcubOGeU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 17:58:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Wed, 7 Aug 2024
 17:58:39 +0000
Message-ID: <548ca3f2-30cf-4f19-9964-7ceaa3c6b5db@oracle.com>
Date: Wed, 7 Aug 2024 18:58:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: add tests for
 TCP_BPF_SOCK_OPS_CB_FLAGS
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
 <20240802152929.2695863-3-alan.maguire@oracle.com>
 <ce11fbd3-1e72-4fc8-94c9-c1e7566339bb@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ce11fbd3-1e72-4fc8-94c9-c1e7566339bb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9c48bc-3862-4e65-fcfa-08dcb70a90fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkJxRThlVFFFVzgxRHdWODU2MnJrNWJYVWFVU3h4Nmp2NVI1U0xXM3JJRFV2?=
 =?utf-8?B?c3FiQWZQU1NCbmNEVkNUcFkxU2tlR3NUOFFia1VzM0tiWHFQMnFMcHQ0ZEtJ?=
 =?utf-8?B?dlBRdXJjczZXUVpzc1Zxdm4wd1RDZHIxZlorYzdmRTdYMEJJclFXRU5yNEVC?=
 =?utf-8?B?WEtSMHZjRUdFbVBmQVNqdWw5WTdSUUpUTklCUGF3YVJIWG9yUWtsN2h4NTVz?=
 =?utf-8?B?bGxaSWZyUzY2c09mWjVFK0VWQTk2SG1PK1R0K0Q2eURYQ3pyNE5kTTFVazJR?=
 =?utf-8?B?b3lNaGYyYUFOa3NYWXRhcEVhTVgraWxKd3JvdXNjMzY5T0dxc3ZHM2FYUGlY?=
 =?utf-8?B?cWd6UFFhL2J6RVMySDdBdStsTDdyS2JHeUI1ZDRMTjNTYzNqSEZMbjNsVGRs?=
 =?utf-8?B?SkF6QzFaUVA4Y0FXa3AwcHhVN2NlZzhhNzdzenpxcjcyY3lVVGFMQ2lucDJE?=
 =?utf-8?B?N1BoUVZkSjJZeG1jSGJieGtwaS9uQWFMWHpoR0pmdGRRVUkvUm14aHQzN3J3?=
 =?utf-8?B?L2ZkL0ptdk5Tckt1ZmVXdXRBNFUvR1gzeGhkM3pRbFVSSStWbVJuSFBrZnhN?=
 =?utf-8?B?dFhnTHFqNng1Zjg5QmZmcWZ2NFJrTTFtZjNqWnV5bG5Qa1luZDBNdVIzU2Yw?=
 =?utf-8?B?U3pJYXBvL1ZNNHFWZ0VYOTV5ZmsweW1sS2c5aDdqejM1SllDUEtzQUhWaGVC?=
 =?utf-8?B?bHNpaElLejFoMmIvWlk1MlZseXc4S3ZHT2szK2dLQmpRbTFUM2tIYitVSi8x?=
 =?utf-8?B?WEpqUEdVYi9kTjdnRHdFTkFXbjk5cWZtZHdhRjB3bzBUbXVtSEFzcE81ZDVh?=
 =?utf-8?B?RGYzNjZ4VVBOWlJMRTB1TWFWSDl4aGFYQVpybTJiS0lqeHhQVGhaNWhJR3c5?=
 =?utf-8?B?SDh3TXpOcWozc1Q0ZFNOK1BZRm9CVXJSbHM0cFBrcjJYMUZBUkEyQm53Y2U5?=
 =?utf-8?B?Mm42c096TE92NGR4NzUreXBraUFZY20xSjVwTXBMT0UrckVLenZwYWs0U1VL?=
 =?utf-8?B?MVUxdm9aVlFNYWs2TVlWclhJYTcrRVZtcWlDY1l6Wk4vdVN6NjlIYndXWFlC?=
 =?utf-8?B?em9IZnZUODcwNzVlRWRxVkFaZHBXUVNrcFIxeklwQkw3RnE2SVBOd3FnU0NJ?=
 =?utf-8?B?NTdwSEZjdlVBZ1FyWTdGU1RZUmxJSlFjaFlZU3c0WnM2VWh2YkkrcTcvWFBH?=
 =?utf-8?B?OXJpQTFCcFVQUDFWZ3VJNVcwa2RFVjdBMGRPb0F1eVlYTDRGNFpOMDZTeWxP?=
 =?utf-8?B?YWFUOCtna2tXdVhuejRKY3BYbGgvUDNQRGFVd3JwYTZlZjgrNzZNNSt3czVl?=
 =?utf-8?B?UnA2N1IwVmNIdE1UbW5jU0FLSHQrZkRIVTdoalFaTldYZVJhMVhhY3oycjJB?=
 =?utf-8?B?MVA1d0VtK0t4VFVSV0UwRDByZzhIRHg0bTRCR1gxOEwyckVQYTNraTR3WUp2?=
 =?utf-8?B?RjgwTDBqVmFkRDFmSHh6dlZNRUdsUzNJWHRXeFM5MDJDaklMOFRrZ0Ewckdi?=
 =?utf-8?B?R1BlMkNOVWVMNmNMdHZML3RZSVQ0MndrQUtPWUNFWlZXdVM2eldDQkFJT3lr?=
 =?utf-8?B?VUxyUlVta2J4WUdIWm9YazluSzhENkx1dXFLNnBIaUd0UFlmSnVQbnRoK3ZS?=
 =?utf-8?B?TmVNVEJGUzhPaDZ6eDVJTHlETU45RXVXQnRyUHowOTNlVEhMVDBSQng4OGVW?=
 =?utf-8?B?STRTYm0zc1dIQ3UvNVhvWlp2dUZOSmtGYkoyV1FhSlFFV0R5YUpEV3lFZ0po?=
 =?utf-8?B?ajFNS1ZmYzhpd2pMYk9EQ0RPUjdIS1R4OUZLdzVuekNhRkZDZDljU2pxTk4v?=
 =?utf-8?B?d0t4UGlRYWZ3TTNDd2h1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmlwM2JlZXA1TEttdVNJbG9QZGw0US9ENkhMZ3drT3YrTGVCT1IxTFgxNzR5?=
 =?utf-8?B?ZFRGVlJzYk9wK3RzVmRTODFoZjQ3QlVZWTd1MXRWbUt5WG1LakxDUDlwZWdo?=
 =?utf-8?B?MGE0OTlka21qMGtEL2c2Vmd2NWptbGc2RHlmR3FTcENGN1doKzlDTU1VZENt?=
 =?utf-8?B?VHF3a205c2RaTTY4anhVQzIrdEs3Z3llZlYrNW9NYnJpdzF3Sjc2NFhiVnl6?=
 =?utf-8?B?ZWVjQUh1TkM1U0FMNWt0cGVTTW5pVDZnTmx5U0cwR0VrUWlNMEdzR2hudkph?=
 =?utf-8?B?Qk5EVnRYcXZJUEU0R1NVc0FLYkJWbk1FcG1BMlhVOXBlREJqS0dLb1dHZmR6?=
 =?utf-8?B?dHB6aHMyUkNiajFOa1pud1djbVdQM2c0aU5sSmhZWHQ4VURGaUpOQnhDK0VB?=
 =?utf-8?B?WFlHOUpxREw0YWZjMFBHWUpyVFM0SEdqOWdMMitjNFhKTUdEMDNKNUFhUnQx?=
 =?utf-8?B?dzlxWG5PMisrMENGS0V4V1E2aCsxZjFpYVhRb2hUdVBTcjRKZklQUi92Q3FF?=
 =?utf-8?B?L0NvMlU2Wm9JRG42dW82WGdha050NE5Oak5ISmRsQTJyT0ZIRWNmb3ByWVBj?=
 =?utf-8?B?WmVKVVNIYW94RmFMdW5XMDhCaStNZThRdldxMm9OREp6UUNZUDRCVHBmNDJo?=
 =?utf-8?B?RmN3L3U2ajA1Zk9EN1JxWFVzTVdYeUNsV3QrR01PUnd3R08zc00waVJ4b3cz?=
 =?utf-8?B?aTFLVnB5SXhrU3QxdThzdGlmbGtrcHdLSGh6WUFhRnNwVzVObDBtaGYyeW5j?=
 =?utf-8?B?ajdFRk9FSExjR3B6MFEyenJWUWo1TnpyaTA5bURmWkFNNnFIUStvTThobXJX?=
 =?utf-8?B?bWVpbXpjRG0wbXd2aS85amMrbjNVSitCSlBxT29ibnU4S1hlSXBrbVphVExO?=
 =?utf-8?B?REpQdG1rTUJRYkJWWkVYL3NWVDBIa2dycmRCT0xkUTAwZUdNRFhwOHFMaUdn?=
 =?utf-8?B?RVBJUS9jTVFaQ0k1WU50dGFlc3NBVmhBS2lOT2M1aTlUd3U5Tm1OWkI1djZC?=
 =?utf-8?B?T0dKZ0dmOFJrODAyRnE5NXk4YzZkdzZKQWNMSHp1RWdIbkdqQm05Z3h1K1pQ?=
 =?utf-8?B?VXp2UFI5SEdJY3k2SE14UHFUUldxdXU1Z2ptUjh2WHlaTmhHV2FrNStrSTVs?=
 =?utf-8?B?UDdxbEFjRWlNcll4Z2VOOFhCYlNsSEp1ZGxrZUFWTXJ0bDNZbS94endqY01v?=
 =?utf-8?B?Q2o2ZnZnQkJCaEtkbUZKYVRSQ3dUY0JyNmd0SXFYYWIxRFA0VUFkZy9EUCtx?=
 =?utf-8?B?aVlScDRjRFJ1Sk5aMi82QURBVm5lRnFLMW9KaE92Z1BmanhFUFAyY2RFbWtj?=
 =?utf-8?B?TDZLQ0xRYjVYTHNQMWpnRk81Zno1UEs1UEJURzh2S3NOZkJGK2hjWEpzTWlC?=
 =?utf-8?B?Q0xiMnR3aHFrcWZFNjA4RG5JYkVOazRwZnB2azIrSElDNkN4aC9HSXBVTW5Q?=
 =?utf-8?B?ejZ5ZHF3bjljK2pLbEV2bmhCcHpSazdBSG9ReDNTTjFPdWYyQ2p2N2hybkJ0?=
 =?utf-8?B?M1dJU1d4RVdVLzU0M3pnZkd4VVhWVTUwSnFZQUhLbEFPU0I4SzNHR2xRSkZ5?=
 =?utf-8?B?Y25QVjdTaWxlZE5XSGhxNmkwYVN6M3VMWG04YnN4ZDZRMFhNRWNORU1iUGNU?=
 =?utf-8?B?MlBFckMyd1hrTldka3Z6UlU2WUdNQ1R2ckQ1MklXMmlGa2JqMnhxNnhURXN2?=
 =?utf-8?B?L3lWY0Q1QlhWSWsyeEwzVEpSQ2hLS0VVSFdkTG9NaUlzVjF5anNJS0pqRmhl?=
 =?utf-8?B?bTZ3QjVTS2JEVDdFYW1xVmM0Myt1SW0reHRocEcxTlhwS0Y2WUx3WjFheGVR?=
 =?utf-8?B?TWZENlo4WEpTN1lpKzhtQVlBZ1ArN0ZWS0dBcFFBd3hjV2s5VmdaOVBkT1hh?=
 =?utf-8?B?UThqMkd1S2NOdmJZTFdBQ3VFb3JYSTN2Uml2VEJUOFdsNzl4Sml6ZlNBbVlp?=
 =?utf-8?B?RUVRTE02T3JzU2xqeFpzdHpWdEJHZjB0ZmdVaEU3c1F3cW5vdEh5a0dyTlFQ?=
 =?utf-8?B?K0pYRnNQbE81eEpVNU9zZTFvM0RXa0oyTXFaNmN2VTZHRVpjMEJnclRkRWJi?=
 =?utf-8?B?Q3dPMUtyUVJPZ1NhQWlnSjhEdldXUjBNd2lGL2FURFBldHJpeEsxbk5PMVlW?=
 =?utf-8?B?TXJOaHZyOVA1dHcyL0NrVDZma3FBRGVuS3kxcUVtekl4ZEVTZEVtSkI3QVZM?=
 =?utf-8?Q?ISOYScS76Pep/KA1a/g49Ho=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4nwBHKQIrbOLpwY/Xcy97gP8qgGTrnoSlzKOth5cSLprLpIPZIJtTTXo5B/JZfbXiAFp+GdCIDIDTOxAZWF4K+ZQZvoUD2/LQUAN1xyp3oc+odFIWbqCS80Gm5Hp0iHlXrm3homhrzyIhKNMx+zYuwJjrpPZhlC0o1gleSAnic1+7hHTgNOcj3VNp9wfTQyrN/54Ntmb8UTux6okvxfZzr1Qe8X7IJahT/SDEoqxXP/l4k2gVncH3m8ZPUeF7AG4nQIvZFJg7XmX+zcSe5Db8Jxo8rPswiqReytpAAy8/cfPF1bf0u09wGFsyyFbyPCLhCgKbC+meInj7AiAmN77FAbrtF2AnPQbuaQC3OV2UmMHgBGzLFafvzJAD9yOg0t5kFPbwXHg8r3+PRZrd8+eckECKU/IbeBO87BIU2w/YbCIkAy87UgJVGdF7+irTCGxUPyctF0m3WxD10naGdK8Z76hQRU2mgI4Jp3M1QgUh7Hx/T1pwXeaSKqvNvg8AC7VPXLWXE2FYXg/zhuwCg4NYqBv9eRaytI8kIVaTn6t26BvcL+wEc6iNmPpB1prezmjjDFfJ+CIyZWJPpqEUH2zw9IUTesdwlDtGtwCXbvLufw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9c48bc-3862-4e65-fcfa-08dcb70a90fb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 17:58:39.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULDbT0H+I3rz+rztFKZ8DPC1D9zqFdHqUUqeZAnpdyGuIR/8Xx1fTjgPBM6BEHqqbDTmZit4q7Vq3fLUPErgPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408070125
X-Proofpoint-ORIG-GUID: I4u9qUBMeZt-OckiOFIhhB1ELP-JyCF6
X-Proofpoint-GUID: I4u9qUBMeZt-OckiOFIhhB1ELP-JyCF6

On 06/08/2024 22:27, Martin KaFai Lau wrote:
> On 8/2/24 8:29 AM, Alan Maguire wrote:
>> Add tests to set/get TCP sockopt TCP_BPF_SOCK_OPS_CB_FLAGS via
>> bpf_setsockopt() and also add a cgroup/setsockopt program that
>> catches setsockopt() for this option and uses bpf_setsockopt()
>> to set it.  The latter allows us to support modifying sockops
>> cb flags on a per-socket basis via setsockopt() without adding
>> support into core setsockopt() itself.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   .../selftests/bpf/prog_tests/setget_sockopt.c | 11 ++++++
>>   .../selftests/bpf/progs/setget_sockopt.c      | 37 +++++++++++++++++--
>>   2 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
>> b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
>> index 7d4a9b3d3722..b9c54217a489 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
>> @@ -42,6 +42,7 @@ static int create_netns(void)
>>   static void test_tcp(int family)
>>   {
>>       struct setget_sockopt__bss *bss = skel->bss;
>> +    int cb_flags = BPF_SOCK_OPS_STATE_CB_FLAG |
>> BPF_SOCK_OPS_RTO_CB_FLAG;
>>       int sfd, cfd;
>>         memset(bss, 0, sizeof(*bss));
>> @@ -56,6 +57,9 @@ static void test_tcp(int family)
>>           close(sfd);
>>           return;
>>       }
>> +    ASSERT_EQ(setsockopt(sfd, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
>> +                 &cb_flags, sizeof(cb_flags)),
>> +          0, "setsockopt cb_flags");
> 
> The sfd here is the listen fd. The setsockopt here is after the
> connection is established and the connection won't be affected by this
> setsockopt...
> 
> I don't think this test belongs to test_tcp() here, more on this below...
> 
>>       close(sfd);
>>       close(cfd);
>>   @@ -65,6 +69,8 @@ static void test_tcp(int family)
>>       ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
>>       ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
>>       ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
>> +    ASSERT_GE(bss->nr_state, 1, "nr_state");
>> +    ASSERT_EQ(bss->nr_setsockopt, 1, "nr_setsockopt");
>>   }
>>     static void test_udp(int family)
>> @@ -185,6 +191,11 @@ void test_setget_sockopt(void)
>>       if (!ASSERT_OK_PTR(skel->links.socket_post_create,
>> "attach_cgroup"))
>>           goto done;
>>   +    skel->links.tcp_setsockopt =
>> +        bpf_program__attach_cgroup(skel->progs.tcp_setsockopt, cg_fd);
>> +    if (!ASSERT_OK_PTR(skel->links.tcp_setsockopt, "attach_setsockopt"))
>> +        goto done;
>> +
>>       test_tcp(AF_INET6);
>>       test_tcp(AF_INET);
>>       test_udp(AF_INET6);
>> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> b/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> index 60518aed1ffc..920af9e21e84 100644
>> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> @@ -20,6 +20,8 @@ int nr_connect;
>>   int nr_binddev;
>>   int nr_socket_post_create;
>>   int nr_fin_wait1;
>> +int nr_state;
>> +int nr_setsockopt;
>>     struct sockopt_test {
>>       int opt;
>> @@ -59,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
>>       { .opt = TCP_THIN_LINEAR_TIMEOUTS, .flip = 1, },
>>       { .opt = TCP_USER_TIMEOUT, .new = 123400, .expected = 123400, },
>>       { .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
>> +    { .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new =
>> BPF_SOCK_OPS_ALL_CB_FLAGS,
>> +      .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, .restore =
>> BPF_SOCK_OPS_STATE_CB_FLAG, },
>>       { .opt = 0, },
>>   };
>>   @@ -124,6 +128,7 @@ static int bpf_test_sockopt_int(void *ctx,
>> struct sock *sk,
>>         if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
>>           return 1;
>> +
>>       if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
>>           tmp != expected)
>>           return 1;
>> @@ -384,11 +389,14 @@ int skops_sockopt(struct bpf_sock_ops *skops)
>>           nr_passive += !(bpf_test_sockopt(skops, sk) ||
>>                   test_tcp_maxseg(skops, sk) ||
>>                   test_tcp_saved_syn(skops, sk));
>> -        bpf_sock_ops_cb_flags_set(skops,
>> -                      skops->bpf_sock_ops_cb_flags |
>> -                      BPF_SOCK_OPS_STATE_CB_FLAG);
>> +
>> +        /* no need to set sockops cb flags here as sockopt
>> +         * tests and user-space originated setsockopt() will
>> +         * set flags to include BPF_SOCK_OPS_STATE_CB.
>> +         */
> 
> I don't think the "user-space originated..." comment is accruate here.
> The user-space originated setsockopt() from the above test_tcp() won't
> affect the passively established sk here. This took me a while to digest...
> 
> iiuc, the removed bpf_sock_ops_cb_flags_set() for the passive connection
> is now implicitly done (and hidden) in the newly added
> sol_tcp_tests[].restore.
> 
> How about keeping the explicit bpf_sock_ops_cb_flags_set() and removing
> the ".restore".
> 
> The existing bpf_sock_ops_cb_flags_set() can be changed to
> bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS) if it helps to test if it is
> effective.

Sounds good; I'll make that change and avoid changing test_tcp() etc.
> 
>>           break;
>>       case BPF_SOCK_OPS_STATE_CB:
>> +        nr_state++;
> 
> How about removing the nr_state addition and adding a
> SEC("cgroup/getsockopt") bpf prog to test the
> getsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS).
> 

Will do. Given that currently we cannot call bpf_getsockopt() from
cgroup/getsockopt progs it might make sense to use per-socket storage to
store the cb flags value that we set via bpf_setsockopt() in the sock
ops program, and retrieve it in the cgroup/getsockopt prog. Does that
sound ok?

> Create another test_nonstandard_opt() in prog_tests/setget_sockopt.c and
> separate it from the existing test_{tcp, udp...} which is mainly
> exercising set/getsockopt(sol_*_tests[]) on different hooks (right now
> it has lsm_cgroup/socket_post_create and sockops). It doesn't fit
> testing the user syscall set/getsockopt on the nonstandard_opt.

Sounds good. I'll also drop the test in patch 3 as you suggest for v2.
Thanks again!

Alan

