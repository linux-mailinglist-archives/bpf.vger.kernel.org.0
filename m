Return-Path: <bpf+bounces-57089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84326AA5488
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7DA9E639B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D412690CF;
	Wed, 30 Apr 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="iVrv4/O+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RV3b4tmg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BB1D5CD7;
	Wed, 30 Apr 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040184; cv=fail; b=pSG3xPWkeCsMc7nKyyQaRRbbpZSz9oebjbhIbDoZA9Blef9z4oVIhYMV+idoutbeCDNv4RPmeHBC3PgNCuGewUls26N4EkHLbs1n7/R+AEZ/RrYFNeJaQn00ZE/jqkJAg1g9n34FpZ/tCLV6lDYBaeqG5QdiN6ipvsfKioO5ol8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040184; c=relaxed/simple;
	bh=ZdBCz5h01v3LWe4kby8VarECQChHwu00TjTCindtxR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZCpfs8dg5aSt1x06j+DDAotu7/+Dbmuahg7HV1rY68R9/tR/hCo8aKjeL3qaeratHzrXaDjakcWU+R3b/C6dJ0hfzQYhGfU05GQMIujonSfAkI1I/olapZ3x4SX0AWaCz1aLKaIKa/FYPrEkOkEscDGe3KKJsyyS6MfnBRxneQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=iVrv4/O+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RV3b4tmg; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UH6u21018501;
	Wed, 30 Apr 2025 12:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ZdBCz5h01v3LWe4kby8VarECQChHwu00TjTCindtx
	R0=; b=iVrv4/O+IqBRVYMtu3JXSCyaApdZd9KwNwinxrd1/wCg0TFRRdiIzM76T
	QNej31Hcs7gOF/QAwlIKeFgGKQI0fTqt6YjNbI2faWdTXrg4nQyR+MhC+NCPf4K+
	teRAgATpNIWnrfhOKqbCGr9t/6UWQoE8L2pWmQFnbiSHstta1qG5JEaVgInNjc9z
	q513DHy/qmgg/Kj9TnMzMnTWGk3dFggPQHzCcHKX8vbE8AeeXAnZlN0l8mwP3jSB
	2qEUfUbcMgcGoPsGvZZ9CF5Vp4s4Da1u0cdczUg8eoByfHx+OkQzt/mZPTPza6bp
	kjXfUy5zs8kn23jh7NQkghMZ1AMUA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011027.outbound.protection.outlook.com [40.93.14.27])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjk1mc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 12:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWV9Vz/NKngXBOeslha3lmoqhxNLhoDyA7JpbzcbWdYGIzfQJT+vnBcKUvflkskNvEAZQx0GOqY/5KYdE/X+jbCBbTfMgmnKSKdOyHHVeGU+GDFNWL4L2r1nLEbouTuDo+oDRg0NL6/wfSMOunyd/wjFM5E3eiFGMEcNmac8qrZ0eragK0IUZzYgqj2lBul+qaJmNvq6jOIG5LsS2E16iXu7gHB9rp0ZD+RRehHAbc5jD+KgUT7BrIOX8QuUw+6cPwVVBqKJ/iZff39z/k2xv3iXdihpCFLg3aJHdQmyAIPs+VfA39OGmaQGx9j62CtYxCUJbFwAciYo7MPpBEW8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdBCz5h01v3LWe4kby8VarECQChHwu00TjTCindtxR0=;
 b=yefyiMIg7Ipdku99C+Uzubw88DsjPT1GpzpuaZF1WlPyiUYYFuBXL9fFpGl7qiaLuVtnjV9ZSjLqPFrPrnx8J5J42gN3+7X+7oJOpUAE7n1uVFvmdsVuc5CiS0wAywcJRpVwoHjagrjEtjLW/BkWF/Ke9F4KDW8SgNor/AqqB9sieVIcGopc/cEjuaSdHkTnFCiTVTDuhnnqL0TOgNP6BZ59PiG/xrYfe66188KQMrsUe4OMReIoWg9IVkUaq6yZh2SGpx9xRuFRT2qo79No+n63/DcSVLMnBWNDef9kDN2MhzG07LEzwYtgdN56YGW0s14r+iIPXQRIuftnP//KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdBCz5h01v3LWe4kby8VarECQChHwu00TjTCindtxR0=;
 b=RV3b4tmgFiteVzF1aHsFKRBFxDMmQMuiTON5nNWoC4PEpWvyI6Vpry3glNElWxSUrMX172cOCAX5c+pgewITVq6fYFb2TQJi2XF1b4qs9FTqmAIFvgD49LKDFnLYG2UKJQknaU1Xet0FObWRKtNxYJc+ja+v9W0jD6xqjlFGJbUN7jldRy2NQSW58+PQfEKLhNaRlLDzgV1dtrOemRzi78kwCNgO2lDvSQZjYRB25t2AMIlHBRw2aU5fxMDCMRCrWu8Yg6p1yKhs5VwL4rr5/6HpR6GnWhkH1bggV39/a/mUiOtgmIdtwkVMSt5hoiu1x1bRLPg+PXmFM4T6d40wpA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CY8PR02MB9543.namprd02.prod.outlook.com
 (2603:10b6:930:72::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 19:09:08 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:09:08 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Jason Wang <jasowang@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Jesper
 Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Thread-Topic: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Thread-Index: AQHbufmTrAKec1Ywc0eV+I87nYhU07O8hnmAgAAEWoCAAAE2gIAABVkAgAABT4A=
Date: Wed, 30 Apr 2025 19:09:08 +0000
Message-ID: <BF410EC2-6DFE-46B2-8AF1-4C48309C5F7B@nutanix.com>
References: <20250430182921.1704021-1-jon@nutanix.com>
 <68126b09c77f7_3080df29453@willemb.c.googlers.com.notmuch>
 <a6a8625c-9d20-48eb-b894-7bd6673a16d3@iogearbox.net>
 <2EB0DFB0-E12D-4FFC-89CF-CF286A9CF8E2@nutanix.com>
 <681274309ee3_30bc5e29490@willemb.c.googlers.com.notmuch>
In-Reply-To: <681274309ee3_30bc5e29490@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CY8PR02MB9543:EE_
x-ms-office365-filtering-correlation-id: b643bcc5-7822-462d-b0e8-08dd881a7b98
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU0rSkRhVVE0d1FYOUdpYnpmMlZ4QmZYQXZ5OUdTMTUxMFcrOEVtYjZYLzA5?=
 =?utf-8?B?RXZtei9wL28rZXEyZFA4aTdkdVoxSDYvdzFWSm9qZW1HRFFyZ0FGVlZMZUg1?=
 =?utf-8?B?bnpvT1c3TEx2dG9weUJPZ0tZZXBaazM4ZkR3SldFd0pMSUhnVlkvVUVTSEdV?=
 =?utf-8?B?aUlBd3dJeTdyMGxWV0Q4K3VGN0JIdzE0NzRoQnVORTR5NWlXR09wY3paejJK?=
 =?utf-8?B?cTZUdDhsSXVldkVrd3JWMEo0QkxXdlJIVXRzQkx5ME5DaUo2aEVLNHZSV1Jh?=
 =?utf-8?B?b3FoeWNWcWc2MG1ac0lpdCtWT0xrZTJXUFpiMHphZndiWDVuaUlhOVBRK2Vy?=
 =?utf-8?B?T3JTMTQ0T3NQUEtJQUF1eHp3a3VxaVh6aGVTclF6cGQxNG5LdUxRbFFCVGNX?=
 =?utf-8?B?MXg5QjZPS3RiU2RrdDRzOWlkR0IzdlJ3UmxpcFdDLzh3N1BmVW5aNWsvZHRY?=
 =?utf-8?B?Q2xqaUlUWkxhZGNHb05tdmdoVU10d0RkY1dkU05DUW5HUmVSM0dWd3BrMnBj?=
 =?utf-8?B?bkVMenFvV2c2SlMxSTk2eVVuVjBNUmZRTWhOcEZZc2lwRm5tVGMzT3NiajVa?=
 =?utf-8?B?NklkVGxjN0w0Yjg4c3MvY1BNc2owRnE3ak9RV2NwSGpzRzZKN2lIakRiN1Yx?=
 =?utf-8?B?SDlWZCswN0ZkaGp4eS83ZUJuUE04cDZtcTYyTWVoSTFodEpINXJpM1IyNWR1?=
 =?utf-8?B?QlF3MkJjS3Rmc3VWeitobUM3VVJObThnamQyZ3luVTVCa1NoZkNYbVhiN0JL?=
 =?utf-8?B?dXRLODNGUDhkcExXUjRQVzdRd3JxT29EcGdWcWVoWW52WXc1VWZraERyRDA1?=
 =?utf-8?B?TlczdnZzVk5yTWhWT2RqL3p6c1kvMng2dm9zVVpDYml5NjlVOWdNOGVxVFNL?=
 =?utf-8?B?a1NTd0pCVE8yaG1PcWdBZjFqNldQZm43SjZxazloWUdrZ1VSTjUyc3JTYXJ1?=
 =?utf-8?B?UGF3YWptNnJoL0ppOTRjOEtyWUlpREJ2NkVhSWtHY2R4a1hCbzE2d2V5Sy9I?=
 =?utf-8?B?cThhdG5DUmQyRktSVWloSXBPL0lPUGpvYllDck1IcXFqNHVkZ3E1cXZSb25X?=
 =?utf-8?B?UXJza1laODlsWU1FUk5aYXlkKzEzVitQVHZXa1lCMmFKNmg2TkRlNkZXazhS?=
 =?utf-8?B?akF6djFRaXRPUUJRaUxFWEsyTW92U1Q4OWd6SlNIZWhOd1VUUFdFT2pyV3RE?=
 =?utf-8?B?NnJuZUxieUNmRjVzeUt5SUtaN080SWgvU0JkM2pxd3dhTTF6cSthVkNhNjlH?=
 =?utf-8?B?VjcrUWhoMkR2cmhUdkZ4VkhmVnBxc0YwUGRycS9WcEpJc2JGcWsvZ2xVSytB?=
 =?utf-8?B?SDFRVTMyYWl4RGlqdzdmYmFCWE1FWE1jUTgzS00xSnoydWxqekZwQnBKdjAy?=
 =?utf-8?B?NDJGclc3Wi9mdW5aUWozTHFITjdCaDRFUXUwQjFmdytOQ2J5UmlkMnVjeEdq?=
 =?utf-8?B?bm14QUw5MENkZDc4d0txSWZjMk81ZnBTdXl6bXdFQTdiM01YYWozZkFBclhh?=
 =?utf-8?B?emNVNmhhelNPeERHdUtkRHpWekdwKzFLdW5mZjBiU241eDhkc1pacjNRd0hZ?=
 =?utf-8?B?MTBySDZ2RmNsVCtMVy9Rbkc1M2JnNU10T2FMZ0lOYzM0VzBLbFIwK2lQbThP?=
 =?utf-8?B?UC9xYWFQTVlKSzYxaVBMNWh0eEQ3cCtrSUhkZ3pGYkk5K1h4YzZSM2t3V1dt?=
 =?utf-8?B?eEE3MjJ0MmF3MDg4WWJxVDh4NE0xZll0NDAwZmI0bE1scEpuK01JVWJSMzJ6?=
 =?utf-8?B?SjArNDJGREFnUm5wcHBLczBIMGt3elo3NjJtSmJ2SHBiK25MZHNvMGpLMm5O?=
 =?utf-8?B?VGt0YU1wSm8yc2t5aGdhaFZEQUw4dldkeHZPdU42K1BYQ2hYdC9iZi84T2xZ?=
 =?utf-8?B?bjhNdlViOE8ybmJlZ0JPZ25Oa21EMmFoN0IyRjdLSkdyemdqNEI1aGdVTFZJ?=
 =?utf-8?B?RHVIMVM1TmdESzhDR2ZnYjFnazFsWFowWCtoRkxhSTJucXJBeG9qbG5kdXQ5?=
 =?utf-8?B?MURJTFR2WUd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlJhOW9FeDB3dmxYZ0VyYSsyQ25yeW9BdXo0aElOY1k0NlN3MU1LQjdNQnJ6?=
 =?utf-8?B?QTNYai9FbXJid2luQStJTUV2RWpYM0w3R2Y1L2Z5U280cHJaT3I1aFZQQXht?=
 =?utf-8?B?VDUrMEZrb25YYVdGdGh6WTF3R3M3aXFZV1NUNzlraEc1a243bzFqMWhsZ2cw?=
 =?utf-8?B?Wm5GVHhCU1pJTkdVRm14Y3ZNaldQaG5heGRiUW5LRCtmbkJZVUNFUjR2eGdW?=
 =?utf-8?B?MFk2eFc3d1NQK3E2bnpZRHBweXhmU0ljVkFIOXZRY1MvZVdQUXlIaE1NOTZC?=
 =?utf-8?B?VFlDNWJta3E0aGpMQXlGcS9weXZSdDZ1VnU4YVRmY0FMcXlqRzBValFaWStM?=
 =?utf-8?B?TDlsOTJCZ3NBWTdOWWVhb0NwY2QreDIwcml2aXFwVWViZnpBcTVFVWY0VEpC?=
 =?utf-8?B?YXlxUXd6Ti9hakFZb0N2OFBEbkJNSk93cVAyaW52WTNzNlVwMVpzM0lkYzNY?=
 =?utf-8?B?OUpGaXJ0MDVURHlDa2xqWnVFT0grdlE2TGNSR2NqRnd2WmxjN1M0RWNzK3VP?=
 =?utf-8?B?NHk3VUg5T3ZHZnJGYXZoUGdZdDFML0FZYWNjdHpReWdHT3pVRU1acm1LODg0?=
 =?utf-8?B?VkNPSzhCQ05VZ2k2R2RxVUpweXAvZzdleWIzZzhIL0lsSlJBYnIzdW5SdnV6?=
 =?utf-8?B?R2I2NU9wRWRxRmJjRlFYcjlIYXlhczMrVmJWeG40cmJ4YXZ2ZXo4MVpsa0F5?=
 =?utf-8?B?aHV5YXRONzJ6MDlTY09iTXRYYldLaXd5azcxdzV3WFFmZlhQb3NadlJIaURu?=
 =?utf-8?B?Kzg4Q05sQmJBRlNqVEtUTDRUNmxYOGlxYi91WnBmUjZUODN0Y1ZCRWExdnNo?=
 =?utf-8?B?N3FFRldBSDlaUXBUNmVDNFU0SGR0ZTF6TTFSbTUvLzNRZlc4MEN5RjNYdk1V?=
 =?utf-8?B?RlNLSld4dkFwbFljcm1XNG92dEh4NzJrNlNiRk94bGZISnlVT2VIdFZxamNp?=
 =?utf-8?B?dzZiOVF3RStTbE9aMUxyT1d3ZFVUZkNIMm5MRzgyUFdlYVNKN1NoYmdkeW1Q?=
 =?utf-8?B?VHBqS2p3TXZZSCt1NGNBazZBL1NGRjd5UFFzWkpDd0lQa1FqaXJtRWk1UVpY?=
 =?utf-8?B?OFYrOEkxdHNPUDRMN05aM1FhSTFEeUN6QzhDa3JIQTdjTTZRSVUrU25FNjM4?=
 =?utf-8?B?a1BJQ0xwTXhOVm9nVHFrdFp3cUFXY0VVQzIrRVkvTjNpSEFsQlZ6dElPOGdK?=
 =?utf-8?B?SXB1d3BKNG1pSjUzVlcrUnk2Q3NIZnRSOCt6bjY1SkRGTWM1N2dBSncveTNl?=
 =?utf-8?B?bStST0htcFU0R3hQdkVrZEZadG5GMldhdTE0Q0VveEhaWHNqSmVkMHBQTGdv?=
 =?utf-8?B?M0J2NVc2V3AzVTZxd2dFTHdBckpsa3ZGUVJCa0hVN0FDSnVqM2VKMGo4a2Fi?=
 =?utf-8?B?WnkyMFBYNHo2djFZR2t0N29XdmgrYzcwSVBSS0JkVlovZGNCWXBPODRmUVB5?=
 =?utf-8?B?c1NqUC9HNzFqREZ0anVkM2N3K0NIb3pocWdFekpWaHJ1TERjVm90aERPSzdj?=
 =?utf-8?B?bXpuU1hPN2FwejcxWjdzaVMxSWV0T0JBVlJDaXo1dmk1WkhKaWp1Z0hXSmdR?=
 =?utf-8?B?akRIL0VLRUZwYzd4Wk1pMmNHM2IyYW5LMVFmcDRFQUJPdGR0Q0xtQ09JbFpx?=
 =?utf-8?B?YUwyWnhrZGk0eEg1OENkdDBTdnVUZlNTc0p0YnRGRzR6eE9yT29Oc1VESlNu?=
 =?utf-8?B?eTJzWXpURDhLTWl2YzR1OWU5SWNFbEc5NkV5TGlzQ0J5MFI5dWI3SEUwcHVy?=
 =?utf-8?B?bHNjVHpQSEJnSE50WHJuNWUrbXBGd09oc1FVVGxVZVZxRExVT3ZQem5ITHlp?=
 =?utf-8?B?SmhodENRU3g3RklWT3pGT2J0bXFrcUhaSWRJVzEyNmVQNkhKUnlYR0EySHBI?=
 =?utf-8?B?dk5HRHNhd0JHYzBXdW5hbTQ4T0lkM1I3M1hyVXRNMnlNYzVhaUhmRVFoTkZO?=
 =?utf-8?B?MEE3YjlLNzVPYkEwTS9GTG1zdUpzT08vYklnYjU5Q09uQ3pQMCt4TzFrVU1I?=
 =?utf-8?B?eE10b0F6eWlKejVhUVl2REovdml2VXV1aVl6eFVobE53OVM0ZUQ4c2ZjTzdQ?=
 =?utf-8?B?aitUZ2RTZmY5ZENxQnVha3RINGxsUjhQdmlrUFExaUJJR1pOOUg2cG5MdGRS?=
 =?utf-8?B?cUs5WXJYZ0tRZkRtUVVEYWhJYy9UYkZJdWNnVi9ENWVZekdhSDVUSURralEz?=
 =?utf-8?Q?upBrg4DI02dhtzR6+BG1CC0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22267D0BBADD7C488B4A964E46477DA7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b643bcc5-7822-462d-b0e8-08dd881a7b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 19:09:08.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGrEgaecp11+l6g0+I5UU/q3jObJaYyu8uVAfztvApX4bmODZzGBaPTD6kZkoKoJzXQex9QAhC7atbGXXkKhGU2uZozTeZ0A0VLUD+j72vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9543
X-Proofpoint-GUID: VVWzPwhB1PLGs6UQXsYCn6CBBj6KPqEF
X-Proofpoint-ORIG-GUID: VVWzPwhB1PLGs6UQXsYCn6CBBj6KPqEF
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=68127557 cx=c_pps a=B/o3nIjBIeux7E2B8s4M4A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=hWMQpYRtAAAA:8 a=64Cc0HZtAAAA:8 a=V97qVVAzIgp6qOQn5cwA:9 a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0MCBTYWx0ZWRfX6NAT3Beb0Qwb SwTz1k4miDWkWDmJAVXZ0/erxChM5b1wr7XAZQts+ZDpYWH7JM/IgUgQT93IEw2sq0Z8zJAy6Hm Xc86aHz7YxZnRRn9uk7CczT/LQ16HOwAMWn9HfxsS7+to+cp0TGO/hfSGgOQIz+A5W27iB5HZ8V
 hdsP1Phf2DBH8/PuJNOvvAVIbSgG5RcBFNY+GAnehVz6F/el4+zncPrCygkpN22u/58bxBSO1z5 kRZ6PzfmXeT5conVBItOJBQxhDXlwBI88AWLseoZY4I/joLXFgJmk1ZZP3B/8Wa9uwC0llZrot8 NOgZkWC+UyH39MIbLn52eruAnoOdUOhq046+W+EKL2hKkbHqFwt5rWdZw2uXbWtAiDE7LGx+dlj
 Aub7eib1P6HWj5rMYPl4v/L3W2XCFeJvHyf2l75VsqXdsrFgN+AW2eHaoCcMinNpxQjAd+FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDMwLCAyMDI1LCBhdCAzOjA04oCvUE0sIFdpbGxlbSBkZSBCcnVpam4gPHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18
DQo+ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBK
b24gS29obGVyIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBBcHIgMzAsIDIwMjUsIGF0IDI6NDDi
gK9QTSwgRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4gd3JvdGU6DQo+Pj4g
DQo+Pj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS18DQo+Pj4gQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4+PiANCj4+
PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSENCj4+PiANCj4+PiBPbiA0LzMwLzI1IDg6MjUgUE0sIFdpbGxlbSBkZSBC
cnVpam4gd3JvdGU6DQo+Pj4+IEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4+PiBBZGQgaGVscGVyIGZv
ciBjYWxsaW5nIHNrYl97cHV0fHJlc2VydmV9IHRvIHJlZHVjZSByZXBldGl0aXZlIHBhdHRlcm4N
Cj4+Pj4+IGFjcm9zcyB2YXJpb3VzIGRyaXZlcnMuDQo+Pj4+PiANCj4+Pj4+IFBsdW1iIGludG8g
dGFwIGFuZCB0dW4gdG8gc3RhcnQuDQo+Pj4+PiANCj4+Pj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdl
IGludGVuZGVkLg0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25A
bnV0YW5peC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IGRyaXZlcnMvbmV0L3RhcC5jIHwgMyArLS0N
Cj4+Pj4+IGRyaXZlcnMvbmV0L3R1bi5jIHwgMyArLS0NCj4+Pj4+IGluY2x1ZGUvbmV0L3hkcC5o
IHwgOCArKysrKysrKw0KPj4+Pj4gbmV0L2NvcmUveGRwLmMgICAgfCAzICstLQ0KPj4+Pj4gNCBm
aWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4+PiBTdWJq
ZWN0aXZlLCBidXQgSSBwcmVmZXIgdGhlIGV4aXN0aW5nIGNvZGUuIEkgdW5kZXJzdGFuZCB3aGF0
DQo+Pj4+IHNrYl9yZXNlcnZlIGFuZCBza2JfcHV0IGRvLiBXaGlsZSB4ZHBfc2tiX3Jlc2VydmVf
cHV0IGFkZHMgYSBsYXllciBvZg0KPj4+PiBpbmRpcmVjdGlvbiB0aGF0IEknZCBoYXZlIHRvIGZv
bGxvdy4NCj4+Pj4gU29tZXRpbWVzIGRlZHVwbGljYXRpb24gbWFrZXMgc2Vuc2UsIHNvbWV0aW1l
cyB0aGUgaW5kaXJlY3Rpb24gYWRkcw0KPj4+PiBtb3JlIG1lbnRhbCBsb2FkIHRoYW4gaXQncyB3
b3J0aC4gSW4gdGhpcyBjYXNlIHRoZSBjb2RlIHNhdmluZ3MgYXJlDQo+Pj4+IHNtYWxsLiBBcyBz
YWlkLCBzdWJqZWN0aXZlLiBIYXBweSB0byBoZWFyIG90aGVyIG9waW5pb25zLg0KPj4+IA0KPj4+
ICsxLCBhZ3JlZSB3aXRoIFdpbGxlbQ0KPj4gDQo+PiBUaGF04oCZcyBhIGZhaXIgcG9pbnQuIEkg
d2FzIGFsc28gdG95aW5nIHdpdGggdGhlIGlkZWEgb2Ygc29tZXRoaW5nIGxpa2UNCj4+IHRoaXMg
aW5zdGVhZDoNCj4+IA0KPj4gZS5nLg0KPj4geGRwX2hlYWRyb29tKHhkcCkgPT0geGRwLT5kYXRh
IC0geGRwLT5kYXRhX2hhcmRfc3RhcnQNCj4+IOKApiBzaW1pbGFyIHRvIHNrYl9oZWFkcm9vbQ0K
Pj4gDQo+PiB4ZHBfbGVuZ3RoX2Jhc2UoeGRwKSA9PSB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRh
DQo+PiDigKYgc2ltaWxhciB0byB4ZHBfZ2V0X2J1ZmZfbGVuLCBidXQgZG9lc27igJl0IGxvb2sg
YXQgZnJhZ3MNCj4+IA0KPj4gdGhlbiB3ZSBjb3VsZCBkbzoNCj4+IHNrYl9yZXNlcnZlKHNrYiwg
eGRwX2hlYWRyb29tKHhkcCkpOw0KPj4gc2tiX3B1dChza2IsIHhkcF9sZW5ndGhfYmFzZSh4ZHAp
KTsNCj4+IA0KPj4gTmFtZXMgVEJEIG9mIGNvdXJzZSwgYnV0IHRob3VnaHRzPw0KPj4gDQo+PiBU
aGF0IHdheSB3ZSBrZWVwIHNrYl9yZXNlcnZlL3B1dCBqdXN0IHRoZSBzYW1lLCBidXQgaGF2ZQ0K
Pj4gYSBuaWNlIGhlbHBlciBsaWtlIHdlIGRvIGZvciBza2JfaGVhZHJvb20oKSBhbHJlYWR5DQo+
IA0KPiBJIGxpa2UgdGhlIGlkZWEgb2YgeGRwX2hlYWRyb29tIGFuZCB4ZGtfaGVhZGxlbiwgc2lt
aWxhciB0bw0KPiBza2JfaGVhZHJvb20gYW5kIHNrYl9oZWFkbGVuLg0KPiANCg0KU29sZCEgSeKA
mWxsIGNvb2sgaXQgdXANCg0K

