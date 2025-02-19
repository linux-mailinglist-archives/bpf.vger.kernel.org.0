Return-Path: <bpf+bounces-51919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA5A3BAE7
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F6E3B46E8
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC011D432D;
	Wed, 19 Feb 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="T4tFGXzM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AF1C2DC8;
	Wed, 19 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958405; cv=fail; b=hcsVnjx61Lja+JCUX3FHJNl9PrrpEFdLmvC1vTgniA3HGncfL6mOrprcqAIHi/AQtZQUSRXgUPTvoqQMn3qaNNLmsbX+2jKlLnGaPZPEGJO/fFD9iJ6o+kffRBsNInlfffG+/PnE79nwe3nOzkYjaGjSHxAtcUa+Q86hJqVQMsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958405; c=relaxed/simple;
	bh=/gogklUrAelTK7SDv6nhzFWrLy0GEC8pHfGY0LTbgY8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6omlXj6u5GG9XNmQEXhzz0ZwnvvFjh38oKBCZrKgiKHRb/wAaKKVT7P8WERr1jXueu2G+wlGyb44OVrh4x8bCFgph1f+K66qoMct+4B5SYOA+UW8c3KM9737tsbvRoe8PQpGPFinQbHJmf6ktvnVEyiMWjCZTEax9JuIgXK+Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=T4tFGXzM; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IMMEgc014742;
	Wed, 19 Feb 2025 01:46:08 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44w2x317ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 01:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joE2BOVZNLJkoinx3NQ2dSrfboegeOTKUmKACW3XxNx0DU0vv9uT+Fb5/rNG4w5k6/2h2gA5Bol9ONfEbvixLBTe5xPg9Jc3gcqAxFfZueUz79vmr9OXKGMMv8mfBu6ue6dieFlMUw3PuPOtgOi0ht/tCURPCJnAQwzpMtsEczGeOsX56fxgaNEdfKF67F22IGJKu3I7EAg4aQFZVsPawGpTYmu2mxqPFCibp2TtwG941Y08L6JZabgTkgw70EwSpSIn6zrDgr9z7DS5oeuMEx65O8i8VGC0lfHXvpmRsp+ZR5CGaZFwkZtR0krkTPpZJgFe/wY0+aLfuO31yV0IUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gogklUrAelTK7SDv6nhzFWrLy0GEC8pHfGY0LTbgY8=;
 b=PxPj+Q6AKLsyX/E9ynoEClipUXqnpVW8Djqg5jnC+1voXEigDIcutgn2IIU1sUIKgFT1gP/abv1bh1Fq4Sm9/QdrNkvoMVj/vvKio2e3I6HS2151coVQT+JxZOk1xobgRb9KwfqESQfz03Mcl47HZxFbdJepE/3hLYgTzJEw+SD3nrNmZ/qoZKCBgK0JjbuSjoJUR7F6TGfaaC2mA0Fh6GJ1vPW+BAWTpwzf9LR74jp0L52XwGkP3yncIRtGyr/beq6x3njinN/0oVjS2wVSt+BSaFMXc+KoeJOq8mnwlccqNulRdrTLloyQAYDo2BtKTmWe34lTXjTa09IERwDW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gogklUrAelTK7SDv6nhzFWrLy0GEC8pHfGY0LTbgY8=;
 b=T4tFGXzMCMlfk67NUkeUT1UZCsDmcxAEiIiMSMKc+UyQ0LP0oVDLZvJvlhEZT47f0jN+fuqGFAS/Ve3yKi5JxoJaH8jzurxX+RLHzlu+S0wadFGvHSliQK9ASQOKjDz494+MEM3UBkLzYqEgzGvVjhLsVscOmtUX/OuRL9Ubark=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BL1PPF85182F59C.namprd18.prod.outlook.com (2603:10b6:20f:fc04::da5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Wed, 19 Feb
 2025 09:46:05 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 09:46:05 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero
 copy transmit support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero
 copy transmit support
Thread-Index: AQHbfdiziL3JtPoDeU2zWkEZIG1hHrNM42mAgAGG7fA=
Date: Wed, 19 Feb 2025 09:46:05 +0000
Message-ID:
 <SJ0PR18MB5216E1ADBDAD93D50FF24300DBC52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com>
 <1ff73b64-2745-473d-a12d-87e1501262d5@redhat.com>
In-Reply-To: <1ff73b64-2745-473d-a12d-87e1501262d5@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BL1PPF85182F59C:EE_
x-ms-office365-filtering-correlation-id: 23368bda-d626-4fce-90b7-08dd50ca3a8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGlPdms5c2lubjlZSFBxSUtZdmUydVA3Mi9wSjdEeEJCZjVVNVgveGFTdnF3?=
 =?utf-8?B?eW5Uck14K2ZoeWhYM0U3elRENEtHR1l4VlFMY0xDSnBKNzJTaGNnREJMYjNI?=
 =?utf-8?B?d0IrZm1jSDJtdFRLdEQrSDA4c0FIWERydDl6aXBiMnNqRFduYkJsYlE3Z1ZD?=
 =?utf-8?B?NFgrdGRaampLUU96WElHaUNsUkVMQk1pMEpTY09ibTJHMUphY0VaRWhJcGh1?=
 =?utf-8?B?VkU4WmdsbUViZ25qT1pLM3pqRlR6N0h4MEU1YVlHdC9mZnFTdGtVMFZXaS93?=
 =?utf-8?B?VUpmeCtUNU5NNkYxQ1B2SlJodzJCcXRGNWNYZHZtcm1YbVBGSjg3emUrT2dy?=
 =?utf-8?B?dTh5OUdCREZOczY3RWU1WGtFdVJXZnVQc3BBbm1GbGYyRHZya2UvdklITGpa?=
 =?utf-8?B?aE9jdXdlVHNQYVQ4R2cyMmYySGlvem5yYWVUL3BBVmJzeDV4NEhCU2ZQSWJ5?=
 =?utf-8?B?clN6cTRPWkx0cUpYSjJDZWtISVo4OUF1bkNuY2pCeFJnbmdwK0ViODRCSjdP?=
 =?utf-8?B?NWRTV09hUEwvOFlLRDFVVXZDQXNiVDc3RHZaS3l3ZVpSSXVQQkFNUDJKRkZ2?=
 =?utf-8?B?S1pZeHMyR3VuSUFUN0xmcS81ZW95RnFsc2RxTGVwT3NxSGQ2aTkxS1FURWVx?=
 =?utf-8?B?OWVoUmtXUWw0dmpvdGxPN3VGZS9VZDdmTi9TdXFnSmFsL1gyNWFkVXhlMHMx?=
 =?utf-8?B?ZTFuVXFRV09kNWMxYURyNkY3d09aS2R1NjEzdDZWWXIxYUwrcDFkUCtwTyto?=
 =?utf-8?B?Vk1pcS8zMUZOT0o1eG5tNUZPRWFXc2oxbEVXTFRzalBiSytxUWsrK3haTDRI?=
 =?utf-8?B?bHhMTFBRRzM0ZmpNNUJxaTZHZlU4dmcrZGhRRFlsMEcyeWkwRnkzTFQzS2F6?=
 =?utf-8?B?T0Q3QXZiODR5VytqRW5TdCthR1F0Ly9BeFZYSks2VTdlVWQ4TnZjMTlCV2pW?=
 =?utf-8?B?K2w2a2ZrOTQ1TVN3bUd5WXFIbWtPd2d5NnVtVFM5UXd1d1Z3MDZjQ2N5bE1K?=
 =?utf-8?B?alpBYVZnUWpOZnhhSEt2dlpxMEFLdmhEeDE4M3BJYzRYUUFEVERSYnQyZHJC?=
 =?utf-8?B?Tm5UeXJGMUUrRDJQU1Z0TC8wNEM3OWk1OVAxbjhRSHgwcThhd25VYkNVZVBj?=
 =?utf-8?B?b1B0L2h4QzE5azE2Z3ZvYUFKck91TmhrZnc0THNOS3pwVWw2UTFkNU4rbGNs?=
 =?utf-8?B?empFL21QeFlodEdobUZzZkZGUWhzcENKQzBkbjN6MFZoSVJidFRWNHRGNnJp?=
 =?utf-8?B?dDg4em1XU1NkU3R0U3BTMzJ1djhKT25TRGdyUmJ4LzdLRjJYaER6QmRwanJp?=
 =?utf-8?B?d21CNHBSeW93SDJualhmdVdYTFNSdVcwb1U4OHljQUtyb3BPN1daNWVPRGo4?=
 =?utf-8?B?YmJnZUw1a3FJQTRwUWxEcTgrT1dkeG9sRURrMTJybmJ6OVBySVBnZC9HSmlM?=
 =?utf-8?B?cEh3Sk9GNnRWbHF3Qng0UmRMTzRqcDRuTTMxZmE2OVlVMno1T080RjF4STNZ?=
 =?utf-8?B?ZUk0cVM2b0xiTFJiakNRVVpoVWg5T2R3aEpzZSt3UW9WRXRSdy95RU1neU9h?=
 =?utf-8?B?UDhQTDlrc1VmWVJqZ01XT24zaFRQQ1lHdmdFaTZ5emtSMkszK3JuRWh0UXdv?=
 =?utf-8?B?YVk2blB3S0d3V2Njdk5rcmRlWW45K2pKYXN4S3VWMVFGclFrUEdwdVB3Szg1?=
 =?utf-8?B?UjFLVjRZcm9QSUVTNWVmdVpaTzBtZXR6R1pXYXVEaGRBMWlSTlB3ckQ0UWQ4?=
 =?utf-8?B?N0NHd3JxdktWK1k5aGN1b25vdkcyYlRtMEFNVktVR3dHU1gyUHY1S2w5UFds?=
 =?utf-8?B?QTRTYXdra2JUd1ppeWxQQUI3YkVlRFVIZGFaVmY3TDVCM2pEeG9tbjhoSDBU?=
 =?utf-8?B?WjdGeDNFMVFlVnNBQkJXYkdUN3VWRE9lNHFucnJzZC81VUlFY2FoRkE0b0cz?=
 =?utf-8?B?VytZRDhPU2ZiVjZhdWlDb2paM04rM1NMYndCaHROdG5oc2MxRlBHUXJvdi82?=
 =?utf-8?B?ekRKT3orQm93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sit1cUZnMWd6Z09EelVpT2hHWDRDR0hZbmpTWFFhSVRNUGxDaGp3MytXUDhO?=
 =?utf-8?B?dlA0NjhaVVdFU0t2aGl0U3FLN2VUejJaMElUem9ZRDBlT1dKSms3eWxnWjFT?=
 =?utf-8?B?TXpLWWFDd1lNOEsvaGdrU2RvcDgwczZJT3FKbWlPaWRmYjNEYU01U0pzS1J0?=
 =?utf-8?B?dFUveWlBcGZPUkpzanBEOE4ydHhOdGpabVM5NW1zc2k3dE1sb0tXaGRpczZT?=
 =?utf-8?B?anRwOEFCM3VRdmxJKzFsSnJzYXhKeEVoUncyL21mRUJZQVBOSE5VcmtUMVpy?=
 =?utf-8?B?TzNXWDYwd0lJQ2RIWXJOY1dhdlV0UEN6emo5TUlrbHpYNHo0amJtalZuUEpI?=
 =?utf-8?B?MCtOaXJxLzdveFR5RUxSUGJxR0h0VGZJNUpIc1NxQjJ5QktLaDFnbEZOaFNt?=
 =?utf-8?B?b2RkTk9SaVkvbGhQQXJyWlRLK3ZCWHM5WXNHK0FRY0tSd2huZnJ3QU04T0tC?=
 =?utf-8?B?eWQwNVlhWUZWTDlUZjdjSlBMc09zbGp4R0o3Q0ZXZVlJbGVWZENYdldmWDR3?=
 =?utf-8?B?bVNPLzNqMXFiODFJNmhRMWFlMnp4TFg2ZHhKSW1qVnRVTkZoc1VDTW5tOXRS?=
 =?utf-8?B?MmFzNjg2ZklGaysvYS9jWjJUc3lnc2FCd2pJQmZJQm1hc3RnNDQ0WlNqb0Jr?=
 =?utf-8?B?OVQ1VVhjcFZDVjA2VGViSGlGM1F2d2g0UXpWY0c0Z1MwclNBVzM3WGd0V04x?=
 =?utf-8?B?aUpaOW51eXVoYTRJbEVVSCtGUzBrTXlzL2w2a1Y5MGNhalJYcjVoRzI0bDNV?=
 =?utf-8?B?Y3VnYVAzUURJclZRY3RabitwYWV6cWRsM3VYdElqQmNxVmR0TmRtZVI5c1hs?=
 =?utf-8?B?bkkyaitVNEFxYmJyWnllR09kaUhyazRQMDJDSy9GKy9yZ21ZYi95cU5QekdQ?=
 =?utf-8?B?ZmhIUmcraWNqZVl5cE9rdmtXUmoveFZyeXNYSnAzNUhnRFNGdU5pTkZHRktR?=
 =?utf-8?B?ZGpKUlUwT01LNDRZdXZybXhzT1F6NnJaSC9YV3h5RXBzejBjaTBCQXRtOTFw?=
 =?utf-8?B?YnVOdnFrYnU3TjdHdGl0bmFhc1lBSnQ3YUxwcnRFZmk1Vkk2RTlPRWdLTTVH?=
 =?utf-8?B?SnFNN2ZTaDhsZDFkQ3JTalpqdjlWSjNiVG1xbzdZNWxtazl0eWlCK29xcnRU?=
 =?utf-8?B?cVBsZnpOSlJqdTh2WHp0NERqTG1JbEs2Rm04b1p3WjNjK1NDL3JJb2huUTBE?=
 =?utf-8?B?VElFMlk1M0tOVlZvaG51d0w5YWFtblljd2VsZTdWNTVFZXhGcFIwSDltRWly?=
 =?utf-8?B?VVBYa29zdUxKOWRzSUhiMEo4eEtkZHdJL01IMGRIOEFMT3Y2RDF2OGVlOFRv?=
 =?utf-8?B?bVBoUzZEYXRPanJwcUkxaVhKRlFtQXo1VGsxbHVQcXFnOXkyUUpuVW43WmtT?=
 =?utf-8?B?a056bmVFRjI0WTBzbW9rYVA3N2xSdkZiN09ORzBKR3FaUEUzd0g1M3AzVW8r?=
 =?utf-8?B?eFFMcDJRclNIQ0hjRGJWUFhsalV2a2VQaEg5Ly85WHdkOE1STEdaOVlyS0FT?=
 =?utf-8?B?NFFocFVkRTJsTTJiV2IxR1BGZHRVZ1krR1NUS3pUSHhweVUxb0VzdnpIQkdR?=
 =?utf-8?B?Q25jVWpRUUpyZCs0TnRwNXo3eHRGU29GWlJpcWxDMHpWbk5NaGhXZ1RZN3lN?=
 =?utf-8?B?WFRqUEZERUg3bzRQVmxGcnpnU3M5YWhvZGY0NjJPMlZSeGo2MEZaTmk3TjJF?=
 =?utf-8?B?TnBtMThOeHRCS21XTkFOTjVpMU8vbyswWVJCTTBxUmUyQUhGVzB6eGRNMWJT?=
 =?utf-8?B?OUtXRjV6TUJ3UDNKZXBWL2FvT1E4azB5eUx4SjFlQmpCZWNUU0xCR1lQakh6?=
 =?utf-8?B?cXRyWlhZcy9CU0hhcHVNT09oUnB5ZC95Rm9HRkk0Vi9jMWhRRVkrWFJEUEJR?=
 =?utf-8?B?cjdwbHpJWW5PWldQSzFvOGgxdEpHN3R5YlVxVkxtbmJvekprU1F5OXJjRnNM?=
 =?utf-8?B?d0dNL3lscU1uc3RiQW50TzRzalN2dkxJemppaHhiOG1PY2RzeDlYQ0lYc0dn?=
 =?utf-8?B?Z0dlcVRuekszUHZTWGYzbGFPTjR6TVd4V0x6T0FCTHB2NDVYVWo0bVAwZnJ1?=
 =?utf-8?B?SUpTaHh6U0xqN0huQzlOSHgyV203ZnZaazFQUTZTNzNwNkNHSGVGWjBZcUN2?=
 =?utf-8?Q?g4pU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23368bda-d626-4fce-90b7-08dd50ca3a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:46:05.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1roprhkCs7x8Rc/rx2tt3QKiqUUVtx5a5TPOMc2vt6OhLQkviggJTDEaNrJH11aOqqIFq5RJuF7xj5oEAqK+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF85182F59C
X-Proofpoint-GUID: XhGwDUwPPOFeY9Qhi7ZOBNQbWF8Ht49c
X-Proofpoint-ORIG-GUID: XhGwDUwPPOFeY9Qhi7ZOBNQbWF8Ht49c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01

Pj4gK3ZvaWQgb3R4Ml96Y19uYXBpX2hhbmRsZXIoc3RydWN0IG90eDJfbmljICpwZnZmLCBzdHJ1
Y3QgeHNrX2J1ZmZfcG9vbA0KPipwb29sLA0KPj4gKwkJCSAgaW50IHF1ZXVlLCBpbnQgYnVkZ2V0
KQ0KPj4gK3sNCj4+ICsJc3RydWN0IHhkcF9kZXNjICp4ZHBfZGVzYyA9IHBvb2wtPnR4X2Rlc2Nz
Ow0KPj4gKwlpbnQgZXJyLCBpLCB3b3JrX2RvbmUgPSAwLCBiYXRjaDsNCj4+ICsNCj4+ICsJYnVk
Z2V0ID0gbWluKGJ1ZGdldCwgb3R4Ml9yZWFkX2ZyZWVfc3FlKHBmdmYsIHF1ZXVlKSk7DQo+PiAr
CWJhdGNoID0geHNrX3R4X3BlZWtfcmVsZWFzZV9kZXNjX2JhdGNoKHBvb2wsIGJ1ZGdldCk7DQo+
PiArCWlmICghYmF0Y2gpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCWZvciAoaSA9IDA7IGkg
PCBiYXRjaDsgaSsrKSB7DQo+PiArCQlkbWFfYWRkcl90IGRtYV9hZGRyOw0KPj4gKw0KPj4gKwkJ
ZG1hX2FkZHIgPSB4c2tfYnVmZl9yYXdfZ2V0X2RtYShwb29sLCB4ZHBfZGVzY1tpXS5hZGRyKTsN
Cj4+ICsJCWVyciA9IG90eDJfeGRwX3NxX2FwcGVuZF9wa3QocGZ2ZiwgTlVMTCwgZG1hX2FkZHIs
DQo+eGRwX2Rlc2NbaV0ubGVuLA0KPj4gKwkJCQkJICAgICBxdWV1ZSwgT1RYMl9BRl9YRFBfRlJB
TUUpOw0KPj4gKwkJaWYgKCFlcnIpIHsNCj4+ICsJCQluZXRkZXZfZXJyKHBmdmYtPm5ldGRldiwg
IkFGX1hEUDogVW5hYmxlIHRvIHRyYW5zZmVyDQo+cGFja2V0DQo+PiArZXJyJWRcbiIsIGVycik7
DQo+DQo+SGVyZSBgZXJyYCBpcyBhbHdheXMgMCwgZHVtcGluZyBpdCdzIHZhbHVlIGlzIHF1aXRl
IGNvbmZ1c2luZy4NCj4NCj5UaGUgcm9vdCBjYXVzZSBpcyB0aGF0IG90eDJfeGRwX3NxX2FwcGVu
ZF9wa3QoKSByZXR1cm5zIGEgc3VjY2Vzcw0KPmJvb2xlYW4gdmFsdWUsIHRoZSB2YXJpYWJsZSBo
b2xkaW5nIGl0IHNob3VsZCBwb3NzaWJseSBiZSByZW5hbWVkDQo+YWNjb3JkaW5nbHkuDQo+DQo+
U2luY2UgdGhpcyBpcyB0aGUgb25seSBuaXQgSSBjb3VsZCBmaW5kLCBJIHRoaW5rIHdlIGFyZSBi
ZXR0ZXIgd2l0aG91dCBhDQo+cmVwb3N0LCBidXQgcGxlYXNlIGZvbGxvdy11cCBvbiB0aGlzIGNo
dW5rIHNvb24uDQo+DQo+VGhhbmtzLA0KPg0KPlBhb2xvDQpbU3VtYW5dIFN1cmUsIEkgd2lsbCBw
dXNoIGEgZm9sbG93LXVwIHBhdGNoDQoNCg==

