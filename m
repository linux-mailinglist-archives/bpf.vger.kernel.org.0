Return-Path: <bpf+bounces-75897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85286C9C4A0
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B7524E38A2
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34029D260;
	Tue,  2 Dec 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ufoHfj9r";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="we5nwcg+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6783279DC0;
	Tue,  2 Dec 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694242; cv=fail; b=sFIR6szm0wdellr4UZNlZj0v88HUpd3+6Fr4t4Wi0wvQcvs9XGL58jODPTXlne4cY2SH+E5nIZ9poTSohRi4cWvt5TKeYrv1G4U2X3xTHtE3Np8K7mEnobJWhJRqPUa02Cif+mPTNXlcFsqGrxwReke+VVk/NJuh5m1bXykwt7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694242; c=relaxed/simple;
	bh=XVo+xXpEFXKdoMT/bLCpRua+CZmkKEBM7n5HkQrN0x8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=af30VsWVNpJjGEeC+p/qF7BcNnSt7+VLQDT64q4SxtVadqZ9E7v2hrjIO92S3PryNnir7veZVyUAmxWaQuXN/XvYpXZmeFYx4pEQ8umReqIKqemOCMSd2eUudcg3602PciVsoFePJUFBH8etfW23bzcuRp/7NZrOPFPwgOaeVaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ufoHfj9r; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=we5nwcg+; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2BDRnh4012197;
	Tue, 2 Dec 2025 08:49:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=XVo+xXpEFXKdoMT/bLCpRua+CZmkKEBM7n5HkQrN0
	x8=; b=ufoHfj9rvRnrIeUlwJiJHf0cX1iQX3FAP/XqdYZ0ZA0wvxFubmLCbxSxn
	kmrWZOuBkS99Av+ZTP0ZKOZjLiJuFN6Aj/SCiZWIK9U4nXkyM/R61HCaZCT5Rjhm
	p4NEfKENEWtlxAgWhAWOl2Z6g7Pbg4uIsARd3ZCrZsvp1WpBm0KR0yW18cmhvy43
	jqc1rcg+qqEsNrTSZm1RDDqs5hVLwh7Z3fYs74nc5gpllf34xNRW68IdvwF2EOS6
	bQCjofValL0HzHgdYbLCA75he83z/GFIxQZyG9mA42j/Dyvi0SNoP06gqjmAeJT1
	yupg/kLzWXqPjCj76i/3Iyv+wQJrQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023105.outbound.protection.outlook.com [40.93.201.105])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ase1gjxtp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 08:49:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL5Jw6gHy/4uz2GyDIGOKvcq27qzng9/oTncoHQ4TPa9KUIjHE00tzt1hBKnha7wihpZv28ZdsFjl1XuZt91QUIDBZRjFiAVfNiPtPmoslU2CqHBM2OlIYUXTmWlEotUr685N51Y12jkzdPZYgk7zZi/ArI2WvKM2ZIdxlZ+7TLNObCdVykqvvOIwqJ43/f4DYp6ajIrzNJIXXZdvTZ58mqdhhvXjdYMJVQWjeFgCpAQC4KopjWztnM4iq6gMFQjf98elf2POh31mrZyBzdjUDuM10wz2cdqlwMiPGpQk9gwt1MFam6h+1REfdhGX4IyFq5tquYQHaj/eFtQeaVd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVo+xXpEFXKdoMT/bLCpRua+CZmkKEBM7n5HkQrN0x8=;
 b=cFOyIejz/6BPryS26yMt776tuJ1Ag0lKtK66qoeYRi2mVlahZkftqVccqufNuCwY5tM/t+OTOQ2Nt/+ZgouuTdVkxI8BVyICxk6uWGy/Gzut8zZL/YKgZS3ggvplx/CyYLy8EfD+C9DabRbbJsR3pUbSJooJwJ5vs8em/PQrqLuaqMTT7whjsjIWZfNn64fw9h9qGP0Prc0Qv6ma6A6eECm+dwPsDd/3ljBMaVA8YZw83iQILkYE4l1cTOL1cImzhmzCpCpmBDC4fXWI0y8Oj9WoKmPcOthksVT8mL9qHnN2POU/p9AOcvg1Z5MzX7+CW27pnlQ3SipN0vTbDuKPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVo+xXpEFXKdoMT/bLCpRua+CZmkKEBM7n5HkQrN0x8=;
 b=we5nwcg+yUdzO78In3IBlhAssAX99Bil1y0n21C/NVn8ML8HCJTuDNnYyTGf7HilHnPlzDrxRAExGntTGGT3KEviY7s3sAu9wrK/uIdhG4yJmOMTw6OXjPugYBTtCyepLz3HosO0qtfztlGQSqt377yvijsAyVVbCJ/ln3ds67cEu562RFTz+qzbNNhvT53eSULLR0O8WKWSMeQRwn5IX3Pf86petYsIHwobC/EAF/Fty9plR2CKfaru9yFVJrcuKfpjBGY2g7dU/RWBY/aTDnOvvhNowrKvSm2AoDhO8LWAnE4qH+/xJCziC0rD6NuheiUUDtuBlI7xS8t63sZQ3w==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SJ0PR02MB8402.namprd02.prod.outlook.com
 (2603:10b6:a03:3f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 16:49:55 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:49:54 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jason Wang <jasowang@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper
 Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Topic: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Index: AQHcXkBJGnA/Z0TBbE2dy0yPlIYpvLUHaj+AgAcwkgA=
Date: Tue, 2 Dec 2025 16:49:54 +0000
Message-ID: <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SJ0PR02MB8402:EE_
x-ms-office365-filtering-correlation-id: 1affce39-c263-488e-80dc-08de31c2d1c8
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGJYek1zaUFIWWNzK0gyeHNTbkI5SU01b3VzRVI5N29SaUlmeTd1VVQ3QVNS?=
 =?utf-8?B?akhsajFQaGZZRWVONWlTdWpIc2toSWEwd0tWNnoxdFNVd0J2QmRqeTYvWXAv?=
 =?utf-8?B?OHB1cERvclo0dkF4ZlVwd2dMSGtwRXdBdkRqWUU1YkpmYXVaU1V1ZzZXT2RW?=
 =?utf-8?B?RE1VWjFoc0lRTFBMY0FPeUx3a3BtVHRmY3RVQnlRMGJBcVRWaTNBV1lFRTBF?=
 =?utf-8?B?VG92WEgzRVNucHNpb1dZNzV0Sng5OXByQmJ5L0h5TWdxVkNvOW45WGkrYTRV?=
 =?utf-8?B?bWZJNVVCeUkyRU5xZm8rOVdSaHRpTld1bjMxVk1qOGpRRG0zTjJyK0xkVHJr?=
 =?utf-8?B?eWZQbFdpTE4zSnhTMCt2NmNIY1l2Vk5uQkwyWUUyQ3FXSktoUHU5MDVTRTMw?=
 =?utf-8?B?RWFldUdocjJ4RTVyM1RhOUczbzEwSVJ4a2MzMGo2Tm9UWTQyQ1ZOa1lnSkNp?=
 =?utf-8?B?MDVYTlNvRTNuajZyOVZaRTRYUUVNSVVQRHRCbzFTb21mRFd2R3Y5ekU5TEl5?=
 =?utf-8?B?QXA3eVgvWW5tMDVoWFVZSU9IRFBHLzVzS0FZSDJ2RzdHM1g1bnliM3pMMEtQ?=
 =?utf-8?B?RDc4Ynp4a1dWcVNHNTVoVFpZWWRaRC9VeFF5OHNzekozZ3o1WmN0bWNRdFU2?=
 =?utf-8?B?ZTNSRVJOOVFnL2x3VUQvb2RzUCszcExBS1l1M1lWdTFWeDlSdDVURElBTC9E?=
 =?utf-8?B?VWNzVjZFZmFWdVNCbTVERGtSc2pvcFFRZ2R3T2xiVDJEam9WWFdIOTJacWtM?=
 =?utf-8?B?a1M4YWpkSUFTM1JaajkwS0FQY2RSczNOYTA4cUw5bE9sZDVXem1oMXBSMFls?=
 =?utf-8?B?TmJQaHF1ZUFHNmVBRnRQb2NZd3BBYmN5dHp4U2tqWHN5eHBpT09Gb0svczZK?=
 =?utf-8?B?VVYvWm9sNG1DRmp3QmgzUmVsc3JJR3dQQ241RUNDdlFpRy9ISXZLWVlCVVBW?=
 =?utf-8?B?Wk81c3VCL1dwVlZBOGRWM0loSHM1L2hNekxSMEhrcHY0TWZYMUpBOVNtLzJs?=
 =?utf-8?B?REpscUZBZmRTQ3FuZ24vTjdlU2RZMWxHUzN1NTBoVnFFdUlNVUhJbE5IU2Rh?=
 =?utf-8?B?cTQ3dUE4US9yVmFXWEtTZVB5NGVzTnBPVFZHUlNwRXZ5TGVOUkxMYVErc1B6?=
 =?utf-8?B?VkJPUnExRDRsY0U5ZHZxZEtpZElvbkl5ajh6ZUU5NkdCYTNkd2Z2VG1oUzVy?=
 =?utf-8?B?VVJOT1VYUUpGS3RDVmY3V29VdFd5dDIvajhUaHh5ZzI2MmhZQk82YVZmNE4r?=
 =?utf-8?B?TXZGZ2RaZDFMWmYrZjdqZDVDSVh3d2lPNitENzNvM0tJbFlzcDNabjRMcWV1?=
 =?utf-8?B?NzNBTE9QUm5zN1AvaWtXMEpqR0VLcW41NDNqNnYrVlVNVmUyWi9mTk9sY3dD?=
 =?utf-8?B?Z2dCd05LdmsvTi9rWVJPVCt5NnpqSTdSS0MvU2QrK3F0ek1aSTRpcGVLNkl0?=
 =?utf-8?B?RFBFY1lsTjl0ZFJDSWMyY3V3aWg4MjBJOUJkTTVEbEE0Tkl4cnIxeGVXRlFV?=
 =?utf-8?B?ODBTRGo2WGI2MWVmNU5kd1U5bVBDaDlxM29UYXA5TXRFMHBoTy9zWWFVUmFM?=
 =?utf-8?B?TGIzRy9pVkFZdmdHcnpWa3J3b1A5eGh0ZHdYRG82VitRRG1FK0lOMUdRLzNv?=
 =?utf-8?B?REZUTk83RW4vVjZZcWRpYmRjNjdlVVFuOTJFRUthMDNyUDVGMEg3YmllUXRC?=
 =?utf-8?B?M3NYTTNXbXl0dklDYnFCY1lOSXdtTlR0WnN4MzNwVGl6dDVqY3Z5TGpNSHcz?=
 =?utf-8?B?bUtDamNHeWo3WThRQmVvZHNDemgzQlNJSkZIY0hpVmNMWmJnY0JBSGtpUG1t?=
 =?utf-8?B?VUQrWE9tZnBIQ2YzV3pYNEZOUmF3UE1Rd0hXMVNzcE5NSFN3Q1N6NXQ5ZzlJ?=
 =?utf-8?B?S3VGdDZsLzdMUnJlOXorK2xBRTVaSysvRnRGWlR2MnZrMVlLSjF1YU9lb093?=
 =?utf-8?B?RmxTZEFXRE5WeGVCVlNNN3NYNytsY1VGZHRTNjNOWG5BOGVXM2w0M2NmS093?=
 =?utf-8?B?ZDluUmd5T2JjZ2FieVVYZGFEOHdmL2Rwb1BMbGFPSm1tdFF3SER5Z3RBM0ZG?=
 =?utf-8?Q?GU7X3t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1MvK25DZ0VKQ1FrVlRVQlhnSDQxdGhYTWQxRDlkWFdINkJJaGxNdXE0MUgy?=
 =?utf-8?B?a3NsZFpwdGZRYzFpaHdqdkEzVmxBM0h2M09TV3VVRFhvdGIyVzBWaFhlQnll?=
 =?utf-8?B?OEREeVNCT2o0Wm1lSStsVEFndzFZWmFTVjhFczM1bUMrMml5Q0FQWjdIemZX?=
 =?utf-8?B?WmxYc0paSGNkRVYvUnpBZ3FSQkpqMnNGdXF2LzNHN2RDNmMwczVLdlNYQkww?=
 =?utf-8?B?NGlEeEo0NnJQaTRkdjh6MzJtRW44ZC9jVmEwZmVPQTFiOGZHdWxjaWpRU2xu?=
 =?utf-8?B?cXN6UGhjczhsNlAyRlQ0cksrcnZCK3hwMElmMGM5K2x2NVNlb09pUGRkVmtS?=
 =?utf-8?B?R3IzMnBrVHJUUno3d2l6RHJmVGZzTVBUT01RNTBnUUpBNlYrRW1GRFYwN29a?=
 =?utf-8?B?L2pCYUFIdXlheU9ZOEc3Vkl3Vzh5NzAxajhlL05vSXorWmFSWkJzeTErQ2VR?=
 =?utf-8?B?M3NVdzlGcFM3OC9aM3E5cmFqdFNTZTg2djlzdTJmaXAzZmtIalI1NUQ5eDcx?=
 =?utf-8?B?YzBKY0IyZzhqeVVzK3lGSFNiSnZ4NGlMTUdwUGNCYzJyaXZLTHhiRWoxeWph?=
 =?utf-8?B?TkdXd0RraEVtYUxoTTE4VjkraldKVzhybXVuVUU4YWN5MkswRzlrYlc0NWJO?=
 =?utf-8?B?UVc1QXhDQlRIWnZUcy82bE9iSUltZFJkc2Rkd0c5VE9lSG1kL1hEeXpuN2VR?=
 =?utf-8?B?SHp1SDc5SG12OXFqaG9GQ2o2ZjI2L3ZIT3RsVENsV3N4VGdqbS8rK0pnbHFj?=
 =?utf-8?B?eGszR2MraGt3SU82RGpDQ1lPUHhjN05hOCt4NkRFZ3RkL3NPcklRenVFOTVm?=
 =?utf-8?B?Y0I2OUQ3M2R2dWhNQVlZRWpvU0F2a0kzbm9pQUVrU252aWVBclkxZk5VL25C?=
 =?utf-8?B?dVMvcDJkUHRuSTZYV0ptL1NCZ2pidmlBKzRDWm1jSVRjdHFoYlJadEdUTk1T?=
 =?utf-8?B?SWlLc3lRSHphdU5mNVpyOG9IZjJQK1RQZWdkSFJNTUxkbXpNeGM3d1dBZzBu?=
 =?utf-8?B?aGU4TThHRFAzRmZ6cFd0QmpKWkdldWtYek12NjRVbE9vQmpLcklPZVA3WHFI?=
 =?utf-8?B?MGJlWTNUS3BXOU82REgySFVuTmlqU21zdm5Eb2ZTb3E2bmkwZGd4VzFqdjM2?=
 =?utf-8?B?cUtNMktjZFlENnZIWXY3b0JDYTdYOVpOVFNoY2tOUGpLMlFTTmZCNXl3UkFV?=
 =?utf-8?B?YytBYlNDbFlld3haTStDVVloSFBiY1RiMC9PdFF6NGpFelM4VVZ0eGloVzhE?=
 =?utf-8?B?amZQSVRVMitzSnZ6c0lncWg0RGxpUjJsUkFXUVEwVE5uQWZkbWhTS1E1d1BW?=
 =?utf-8?B?OVMzbkROTlc2WDhHMTBoMWlOWmtzUTRydDMzdTREWnk1OXd5TkhZYjJSYWU5?=
 =?utf-8?B?VzNCQ0JUR1JINGxuQ0ZnLzZHT0NOajhtdW5na1NKc2puenF4RHR0L0prOHJz?=
 =?utf-8?B?NmRBbml1aWhYMjU1QnllYko5bytWRy95bHV2ZXZqdVBzVDlwQ3FZSmI3cVp5?=
 =?utf-8?B?UElOUjNDNnRwcS9Wa3N2N05BT2s5Tk85dmNBYmZsN2V1RnpjdFhZOGk3clB3?=
 =?utf-8?B?ZXd3cmhyeld6Vi9nZGV4QXU0MktjWGlOaHVHUFFpVVZLbWM3Z0tqMXhSY2Vq?=
 =?utf-8?B?NnJrQzV5Z2JzbzMyS1B1MjJna2k2eHVDMGFyUXRGTURmYnVrUWhrSUtoZ0JD?=
 =?utf-8?B?b2hMV2ZnTXhRWnBtR2tBSllsWkl1ZFkwQ20yekl2eklobWNwV1YxMndsNkdt?=
 =?utf-8?B?TkU0VTFUR21rY3BsMkgzeHdDbXp3NDJRZnBpbzBhSTdJNFlFMjFPNmI5MUJk?=
 =?utf-8?B?czN0NERhRU11SEN4ZEV1WTVhUkw3MXFzeDlkT2pOVUU4L282K0U5TGE4dHVa?=
 =?utf-8?B?UDllK2JVQm5VZ1ZjQmpmR3BxUCtWTWFOdW8yOVk1RVdaQWZqbVYxUDc1V2tH?=
 =?utf-8?B?UDlQVXZVQ2lhVzlrWGM4MHdHdHJZSTM1TnU3YUkvbmc4MGJ0THdkUkJTTUlu?=
 =?utf-8?B?OVp4UjRvOTF2VHhGbE9MOVdpc2lvYm1BUC9CQklWanV3TjFPd1FZUVNUL1JI?=
 =?utf-8?B?UmFXWGltK1NkbnJuVENveWMxYVpxVzdMbG5LN0s2ZXROUVo3MHFrR3dtYi9Y?=
 =?utf-8?B?cFRUME5qdjJSSjBqM0pMYXFBTEZrVlQxamhUZG1oczd2ZGJ3YWlvT2Nhc0o0?=
 =?utf-8?B?L3l1VTNwVkpETkNpbXNJejVhSllQalorbWFQQzk4TzhjTUNuMjFPSlZhTEVI?=
 =?utf-8?B?M2VWNk1VNjVqakE3S1hiYkJwOE93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8523569BCB7C94CB6919E9B209B677C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1affce39-c263-488e-80dc-08de31c2d1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 16:49:54.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WS2F006N1nfgBOLegy9uTYK2YTS9SfaEuvyClaCelrmWzmiBsLrQ/zsPuOSJOBvQMO0ruQzIo8R/0UZ0ack2z3SvJ0pIiM9+rIUUbvYxPS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8402
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEzMyBTYWx0ZWRfX1IqE1lbSsU/R
 ExUxoVZVE37aOLT32UFKdGNVv9IQCtAK1x5C5uPxiE7ewfefsqHRhwVjtG9zIRdw1syvIHGWmgz
 T2wqVzzVNBFC+WCYpSBrlgmxoXvPW8Ha3hk16Fx5cEBVe5OzJlgH7cIEBOkZiTGDDKVDEgdMU3I
 l9jitX0owEQvfRffTQsa9AnodvQoNOB3bZt2inC8FrkW8Z4pq8PGqDZSuZwohzwur09nqxmXhbF
 BzKmSnnRrZHFLVpc9zAraOVisOPVe+5RLtyDAMIMl5xTX9YCzCStkLk1BnFae+7tf4rVy03y05l
 hePiHJRDDfN6cUq2pqDnz8+9yu11Psn7KXfeiqToXb4OOs0ZWc8ZX1sx/yh98d9cno9bf2kmi5i
 +WasOvQqLTYNfup1LCLituQHrDjBPw==
X-Proofpoint-GUID: VKZpe3niHvk0dmyHmbPeg3KydJTa6Pfz
X-Proofpoint-ORIG-GUID: VKZpe3niHvk0dmyHmbPeg3KydJTa6Pfz
X-Authority-Analysis: v=2.4 cv=ZP7aWH7b c=1 sm=1 tr=0 ts=692f18b6 cx=c_pps
 a=hloNlEDlI3+XEZKeHTbqpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=JvmmYtEPXo1WP6rDxlkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI3LCAyMDI1LCBhdCAxMDowMuKAr1BNLCBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTm92IDI2LCAyMDI1IGF0IDM6MTni
gK9BTSBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBPcHRpbWl6
ZSBUVU5fTVNHX1BUUiBiYXRjaCBwcm9jZXNzaW5nIGJ5IGFsbG9jYXRpbmcgc2tfYnVmZiBzdHJ1
Y3R1cmVzDQo+PiBpbiBidWxrIGZyb20gdGhlIHBlci1DUFUgTkFQSSBjYWNoZSB1c2luZyBuYXBp
X3NrYl9jYWNoZV9nZXRfYnVsay4NCj4+IFRoaXMgcmVkdWNlcyBhbGxvY2F0aW9uIG92ZXJoZWFk
IGFuZCBpbXByb3ZlcyBlZmZpY2llbmN5LCBlc3BlY2lhbGx5DQo+PiB3aGVuIElGRl9OQVBJIGlz
IGVuYWJsZWQgYW5kIEdSTyBpcyBmZWVkaW5nIGVudHJpZXMgYmFjayB0byB0aGUgY2FjaGUuDQo+
IA0KPiBEb2VzIHRoaXMgbWVhbiB3ZSBzaG91bGQgb25seSBlbmFibGUgdGhpcyB3aGVuIE5BUEkg
aXMgdXNlZD8NCg0KTm8sIGl0IGRvZXMgbm90IG1lYW4gdGhhdCBhdCBhbGwsIGJ1dCBJIHNlZSB3
aGF0IHRoYXQgd291bGQgYmUgY29uZnVzaW5nLg0KSSBjYW4gY2xlYW4gdXAgdGhlIGNvbW1pdCBt
c2cgb24gdGhlIG5leHQgZ28gYXJvdW5kDQoNCj4+IA0KPj4gSWYgYnVsayBhbGxvY2F0aW9uIGNh
bm5vdCBmdWxseSBzYXRpc2Z5IHRoZSBiYXRjaCwgZ3JhY2VmdWxseSBkcm9wIG9ubHkNCj4+IHRo
ZSB1bmNvdmVyZWQgcG9ydGlvbiwgYWxsb3dpbmcgdGhlIHJlc3Qgb2YgdGhlIGJhdGNoIHRvIHBy
b2NlZWQsIHdoaWNoDQo+PiBpcyB3aGF0IGFscmVhZHkgaGFwcGVucyBpbiB0aGUgcHJldmlvdXMg
Y2FzZSB3aGVyZSBidWlsZF9za2IoKSB3b3VsZA0KPj4gZmFpbCBhbmQgcmV0dXJuIC1FTk9NRU0u
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4g
DQo+IERvIHdlIGhhdmUgYW55IGJlbmNobWFyayByZXN1bHQgZm9yIHRoaXM/DQoNClllcywgaXQg
aXMgaW4gdGhlIGNvdmVyIGxldHRlcjoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9uZXRkZXZicGYvY292ZXIvMjAyNTExMjUyMDAwNDEuMTU2NTY2My0xLWpvbkBudXRhbml4
LmNvbS8NCg0KPj4gLS0tDQo+PiBkcml2ZXJzL25ldC90dW4uYyB8IDMwICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBiL2Ry
aXZlcnMvbmV0L3R1bi5jDQo+PiBpbmRleCA5N2YxMzBiYzVmZWQuLjY0Zjk0NGNjZTUxNyAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC90dW4u
Yw0KPj4gQEAgLTI0MjAsMTMgKzI0MjAsMTMgQEAgc3RhdGljIHZvaWQgdHVuX3B1dF9wYWdlKHN0
cnVjdCB0dW5fcGFnZSAqdHBhZ2UpDQo+PiBzdGF0aWMgaW50IHR1bl94ZHBfb25lKHN0cnVjdCB0
dW5fc3RydWN0ICp0dW4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHR1bl9maWxl
ICp0ZmlsZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwg
aW50ICpmbHVzaCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHR1bl9wYWdlICp0
cGFnZSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHR1bl9wYWdlICp0cGFnZSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4+IHsNCj4+
ICAgICAgICB1bnNpZ25lZCBpbnQgZGF0YXNpemUgPSB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRh
Ow0KPj4gICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkciAqZ3NvID0geGRwLT5kYXRhX2hhcmRf
c3RhcnQ7DQo+PiAgICAgICAgc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2hfdHVubmVsICp0
bmxfaGRyOw0KPj4gICAgICAgIHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2c7DQo+PiAtICAgICAg
IHN0cnVjdCBza19idWZmICpza2IgPSBOVUxMOw0KPj4gICAgICAgIHN0cnVjdCBza19idWZmX2hl
YWQgKnF1ZXVlOw0KPj4gICAgICAgIG5ldGRldl9mZWF0dXJlc190IGZlYXR1cmVzOw0KPj4gICAg
ICAgIHUzMiByeGhhc2ggPSAwLCBhY3Q7DQo+PiBAQCAtMjQzNyw2ICsyNDM3LDcgQEAgc3RhdGlj
IGludCB0dW5feGRwX29uZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4gICAgICAgIHN0cnVj
dCBwYWdlICpwYWdlOw0KPj4gDQo+PiAgICAgICAgaWYgKHVubGlrZWx5KGRhdGFzaXplIDwgRVRI
X0hMRU4pKSB7DQo+PiArICAgICAgICAgICAgICAga2ZyZWVfc2tiX3JlYXNvbihza2IsIFNLQl9E
Uk9QX1JFQVNPTl9QS1RfVE9PX1NNQUxMKTsNCj4+ICAgICAgICAgICAgICAgIGRldl9jb3JlX3N0
YXRzX3J4X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4+ICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPj4gICAgICAgIH0NCj4+IEBAIC0yNDU0LDYgKzI0NTUsNyBAQCBzdGF0aWMgaW50
IHR1bl94ZHBfb25lKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+PiAgICAgICAgICAgICAgICBy
ZXQgPSB0dW5feGRwX2FjdCh0dW4sIHhkcF9wcm9nLCB4ZHAsIGFjdCk7DQo+PiAgICAgICAgICAg
ICAgICBpZiAocmV0IDwgMCkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAvKiB0dW5feGRw
X2FjdCBhbHJlYWR5IGhhbmRsZXMgZHJvcCBzdGF0aXN0aWNzICovDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICBrZnJlZV9za2JfcmVhc29uKHNrYiwgU0tCX0RST1BfUkVBU09OX1hEUCk7DQo+
IA0KPiBUaGlzIHNob3VsZCBiZWxvbmcgdG8gcHJldmlvdXMgcGF0Y2hlcz8NCg0KV2VsbCwgbm90
IHJlYWxseSwgYXMgd2UgZGlkIG5vdCBldmVuIGhhdmUgYW4gU0tCIHRvIGZyZWUgYXQgdGhpcyBw
b2ludA0KaW4gdGhlIHByZXZpb3VzIGNvZGUNCj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
IHB1dF9wYWdlKHZpcnRfdG9faGVhZF9wYWdlKHhkcC0+ZGF0YSkpOw0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgICAgICAgICAgfQ0KPj4gQEAgLTI0NjMs
NiArMjQ2NSw3IEBAIHN0YXRpYyBpbnQgdHVuX3hkcF9vbmUoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1
biwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgKmZsdXNoID0gdHJ1ZTsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+PiAgICAgICAgICAgICAgICBjYXNlIFhEUF9U
WDoNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG5hcGlfY29uc3VtZV9za2Ioc2tiLCAxKTsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICAgICAgICAgICAgICBj
YXNlIFhEUF9QQVNTOg0KPj4gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+IEBAIC0y
NDc1LDEzICsyNDc4LDE1IEBAIHN0YXRpYyBpbnQgdHVuX3hkcF9vbmUoc3RydWN0IHR1bl9zdHJ1
Y3QgKnR1biwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cGFnZS0+cGFnZSA9
IHBhZ2U7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHBhZ2UtPmNvdW50ID0g
MTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbmFwaV9jb25zdW1lX3NrYihza2IsIDEpOw0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyB3b3Vs
ZCBoYXZlIGFueSBzaWRlIGVmZmVjdHMgc2luY2UgdHVuX3hkcF9vbmUoKSBpcw0KPiBub3QgY2Fs
bGVkIGJ5IGEgTkFQSS4NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoaXMgbmFwaV9jb25zdW1l
X3NrYiBpcyByZWFsbHkganVzdCBhbiBhcnRpZmFjdCBvZg0KaG93IGl0IHdhcyBuYW1lZCBhbmQg
aG93IGl0IHdhcyB0cmFkaXRpb25hbGx5IHVzZWQuIA0KDQpOb3cgdGhpcyBpcyByZWFsbHkganVz
dCBhIG5hcGlfY29uc3VtZV9za2Igd2l0aGluIGEgYmggZGlzYWJsZS9lbmFibGUNCnNlY3Rpb24s
IHdoaWNoIHNob3VsZCBtZWV0IHRoZSByZXF1aXJlbWVudHMgb2YgaG93IHRoYXQgaW50ZXJmYWNl
DQpzaG91bGQgYmUgdXNlZCAoYWdhaW4sIEFGQUlDVCkNCg0KPiANCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgfQ0KPj4g
DQo+PiBidWlsZDoNCj4+IC0gICAgICAgc2tiID0gYnVpbGRfc2tiKHhkcC0+ZGF0YV9oYXJkX3N0
YXJ0LCBidWZsZW4pOw0KPj4gKyAgICAgICBza2IgPSBidWlsZF9za2JfYXJvdW5kKHNrYiwgeGRw
LT5kYXRhX2hhcmRfc3RhcnQsIGJ1Zmxlbik7DQo+PiAgICAgICAgaWYgKCFza2IpIHsNCj4+ICsg
ICAgICAgICAgICAgICBrZnJlZV9za2JfcmVhc29uKHNrYiwgU0tCX0RST1BfUkVBU09OX05PTUVN
KTsNCg0KVGhvdWdoIHRvIHlvdXIgcG9pbnQsIEkgZG9udCB0aGluayB0aGlzIGFjdHVhbGx5IGRv
ZXMgYW55dGhpbmcgZ2l2ZW4NCnRoYXQgaWYgdGhlIHNrYiB3YXMgc29tZWhvdyBudWtlZCBhcyBw
YXJ0IG9mIGJ1aWxkX3NrYl9hcm91bmQsIHRoZXJlDQp3b3VsZCBub3QgYmUgYW4gc2tiIHRvIGZy
ZWUuIERvZXNu4oCZdCBodXJ0IHRob3VnaCwgZnJvbSBhIHNlbGYgZG9jdW1lbnRpbmcNCmNvZGUg
cGVyc3BlY3RpdmUgdGhvPw0KDQo+PiAgICAgICAgICAgICAgICBkZXZfY29yZV9zdGF0c19yeF9k
cm9wcGVkX2luYyh0dW4tPmRldik7DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4+ICAgICAgICB9DQo+PiBAQCAtMjU2Niw5ICsyNTcxLDExIEBAIHN0YXRpYyBpbnQgdHVuX3Nl
bmRtc2coc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IG1zZ2hkciAqbSwgc2l6ZV90IHRvdGFs
X2xlbikNCj4+ICAgICAgICBpZiAobS0+bXNnX2NvbnRyb2xsZW4gPT0gc2l6ZW9mKHN0cnVjdCB0
dW5fbXNnX2N0bCkgJiYNCj4+ICAgICAgICAgICAgY3RsICYmIGN0bC0+dHlwZSA9PSBUVU5fTVNH
X1BUUikgew0KPj4gICAgICAgICAgICAgICAgc3RydWN0IGJwZl9uZXRfY29udGV4dCBfX2JwZl9u
ZXRfY3R4LCAqYnBmX25ldF9jdHg7DQo+PiArICAgICAgICAgICAgICAgaW50IGZsdXNoID0gMCwg
cXVldWVkID0gMCwgbnVtX3NrYnMgPSAwOw0KPj4gICAgICAgICAgICAgICAgc3RydWN0IHR1bl9w
YWdlIHRwYWdlOw0KPj4gICAgICAgICAgICAgICAgaW50IG4gPSBjdGwtPm51bTsNCj4+IC0gICAg
ICAgICAgICAgICBpbnQgZmx1c2ggPSAwLCBxdWV1ZWQgPSAwOw0KPj4gKyAgICAgICAgICAgICAg
IC8qIE1heCBzaXplIG9mIFZIT1NUX05FVF9CQVRDSCAqLw0KPj4gKyAgICAgICAgICAgICAgIHZv
aWQgKnNrYnNbNjRdOw0KPiANCj4gSSB0aGluayB3ZSBuZWVkIHNvbWUgdHdlYWtzDQo+IA0KPiAx
KSBUVU4gaXMgZGVjb3VwbGVkIGZyb20gdmhvc3QsIHNvIGl0IHNob3VsZCBoYXZlIGl0cyBvd24g
dmFsdWUgKGENCj4gbWFjcm8gaXMgYmV0dGVyKQ0KDQpTdXJlLCBJIGNhbiBtYWtlIGFub3RoZXIg
Y29uc3RhbnQgdGhhdCBkb2VzIGEgc2ltaWxhciB0aGluZw0KDQo+IDIpIFByb3ZpZGUgYSB3YXkg
dG8gZmFpbCBvciBoYW5kbGUgdGhlIGNhc2Ugd2hlbiBtb3JlIHRoYW4gNjQNCg0KV2hhdCBpZiB3
ZSBzaW1wbHkgYXNzZXJ0IHRoYXQgdGhlIG1heGltdW0gaGVyZSBpcyA2NCwgd2hpY2ggSSB0aGlu
aw0KaXMgd2hhdCBpdCBhY3R1YWxseSBpcyBpbiBwcmFjdGljZT8NCg0KPiANCj4+IA0KPj4gICAg
ICAgICAgICAgICAgbWVtc2V0KCZ0cGFnZSwgMCwgc2l6ZW9mKHRwYWdlKSk7DQo+PiANCj4+IEBA
IC0yNTc2LDEzICsyNTgzLDI0IEBAIHN0YXRpYyBpbnQgdHVuX3NlbmRtc2coc3RydWN0IHNvY2tl
dCAqc29jaywgc3RydWN0IG1zZ2hkciAqbSwgc2l6ZV90IHRvdGFsX2xlbikNCj4+ICAgICAgICAg
ICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4+ICAgICAgICAgICAgICAgIGJwZl9uZXRfY3R4ID0g
YnBmX25ldF9jdHhfc2V0KCZfX2JwZl9uZXRfY3R4KTsNCj4+IA0KPj4gLSAgICAgICAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBuOyBpKyspIHsNCj4+ICsgICAgICAgICAgICAgICBudW1fc2ticyA9
IG5hcGlfc2tiX2NhY2hlX2dldF9idWxrKHNrYnMsIG4pOw0KPiANCj4gSXRzIGRvY3VtZW50IHNh
aWQ6DQo+IA0KPiAiIiINCj4gKiBNdXN0IGJlIGNhbGxlZCAqb25seSogZnJvbSB0aGUgQkggY29u
dGV4dC4NCj4g4oCcIuKAnQ0KV2XigJlyZSBpbiBhIGJoX2Rpc2FibGUgc2VjdGlvbiBoZXJlLCBp
cyB0aGF0IG5vdCBnb29kIGVub3VnaD8NCj4gDQo+PiArDQo+PiArICAgICAgICAgICAgICAgZm9y
IChpID0gMDsgaSA8IG51bV9za2JzOyBpKyspIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBza19idWZmICpza2IgPSBza2JzW2ldOw0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICB4ZHAgPSAmKChzdHJ1Y3QgeGRwX2J1ZmYgKiljdGwtPnB0cilbaV07DQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSB0dW5feGRwX29uZSh0dW4sIHRmaWxlLCB4ZHAsICZmbHVzaCwg
JnRwYWdlKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHR1bl94ZHBfb25lKHR1
biwgdGZpbGUsIHhkcCwgJmZsdXNoLCAmdHBhZ2UsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBza2IpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmV0ID4gMCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZWQgKz0gcmV0
Ow0KPj4gICAgICAgICAgICAgICAgfQ0KPj4gDQo+PiArICAgICAgICAgICAgICAgLyogSGFuZGxl
IHJlbWFpbmluZyB4ZHBfYnVmZiBlbnRyaWVzIGlmIG51bV9za2JzIDwgY3RsLT5udW0gKi8NCj4+
ICsgICAgICAgICAgICAgICBmb3IgKGkgPSBudW1fc2ticzsgaSA8IGN0bC0+bnVtOyBpKyspIHsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHhkcCA9ICYoKHN0cnVjdCB4ZHBfYnVmZiAqKWN0
bC0+cHRyKVtpXTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9jb3JlX3N0YXRzX3J4
X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4gDQo+IENvdWxkIHdlIGRvIHRoaXMgaW4gYSBiYXRj
aD8NCg0KSSBzdXNwZWN0IHRoaXMgd2lsbCBiZSBhIHZlcnksIHZlcnkgcmFyZSBjYXNlLCBzbyBJ
IGRvbnQgdGhpbmsgb3B0aW1pemluZyBpdA0KKG9yIGNvbXBsaWNhdGluZyBpdCBhbnkgbW9yZSkg
ZG9lcyBtdWNoIGdvb2QsIG5vPw0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHV0
X3BhZ2UodmlydF90b19oZWFkX3BhZ2UoeGRwLT5kYXRhKSk7DQo+PiArICAgICAgICAgICAgICAg
fQ0KPj4gKw0KPj4gICAgICAgICAgICAgICAgaWYgKGZsdXNoKQ0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICB4ZHBfZG9fZmx1c2goKTsNCj4+IA0KPj4gLS0NCj4+IDIuNDMuMA0KPj4gDQo+IA0K
PiBUaGFua3MNCg0KDQo=

