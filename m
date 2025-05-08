Return-Path: <bpf+bounces-57725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C71AAF172
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302751C237A5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19D20CCD0;
	Thu,  8 May 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UzWaXex+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="nOfycqfJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A61F17E8;
	Thu,  8 May 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673774; cv=fail; b=mWydeDbsyVieY9YsGVvoQXQzF6hUo9GABBlU0ibidsv6b6b+7m2XhLWZa+YLj3XvP4D5QYJoIN7No1vlgm7ZED5Zm/Ve1XGzs99ro4scDY5+0UZ+AlVbJg9c/B9pFbD+BJ8Cyaw3gf9DG6RCEYU3hktaiWKqrk9I3WQFKa8bYXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673774; c=relaxed/simple;
	bh=0sWOy14NEPvIrd2v93+aLa9GVTxKQed7gCP6mheB9m4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCSyymujk787wCd7o6BIvGIVrBxbaE4ZUQMDPLdhKfxNwAtaHdvEyjm8QcvTMp39+YA5fZpLmIl/ynHF6IUmDMPz/jlMEyedcv3GoJtdOU12T+AAvownNIBUwsWXlhHZ+6xgwbWd6sAao7DA21t55XMCXATil1IQoOlOCn+BcDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UzWaXex+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=nOfycqfJ; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547MqmBw016570;
	Wed, 7 May 2025 20:09:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=0sWOy14NEPvIrd2v93+aLa9GVTxKQed7gCP6mheB9
	m4=; b=UzWaXex+Z0zUFuG6l7wNFg32GvkFGexIF7GsWB8xeTBkgcGYInOIoOIud
	r6ch+fEgQIoEa93e3BrF5MeWFVDFAqLvvdXT77yTkCuzarN61xM9ll2sIp0yX+eg
	rltUVG2rweJnyYV22tn4RvnKkutx8ajV7W2Fm5ibda1+pHQQ9BNtnqPl6KuPbLVb
	3tcAUpDdybDobEwRWDOvfWzN2yi9DedP4Ywb1V3aiU/nt1AhpQ1Z0DbyAJsl6Ch5
	eYggxHv6gWfBzM7oEQevAjwRQ8b1dZfoA/uRCl8Pdi7LjsAsuJGL2M/hrs/ZIRYt
	Sgxglm+GaLxYGWBdIoCD54LqIdToQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djp12j6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 20:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0/fIjPaY8nlyVWFdF4vefP/H2zKDrlCcrry1uIMGtV254dOHvjBzYjIodRTervCztui7JC/1nn5yMhF0m67hOvj3jBsMFQ67xRyP/F1XsUXIDf2kDjY8i73IX0hYCUanLYDqXz95NpA1rIEhg79tlr5i2SIlHcuycKzdooQ82eB8g+B5023r01xqZR/9g689Z+AR/ovZ/YhuZKcpfVV6xGqI/2nkXzzvZDyU0eLrgD1rfTHWZw9QnplXybH9S+LGBsplIpuooQj4vJzDeiC2aBRvwiIP8yQAeTgUk2ZZXVqMrar14NfoheihZiz4k970YW8VD+jC/5JS6DSkQd6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sWOy14NEPvIrd2v93+aLa9GVTxKQed7gCP6mheB9m4=;
 b=WeTBY5fOHgJY0Ox3bUis/tjIfjOxzkuJKUHt40Shd/eLcoQ0pJMjSbc7fIWsTCsTLzv1oCZptUu+66qNrDsVoJes1TVfWf0ngnmoWvl0dJ/57PRM48U5zSwzvPdHr0oU7D9jENiS/h0ljHClCkGDBlfO66DxZx9mPSmO4F8ftfUx8J7zh86l74Zc+O8sxR6TyvCppPtJoyVF6KQcvAKiT/2XAdcHFYawHsAuo25Ws2koenETse8pvb+HTLYmTa5bxKGAag+vYDdbIr87MjRKnVNOLjtT0Bf6q05Kxij9sL9M7Lu3th5bovWk3Ayp5QTMTzCyzdv50O5pYP4QZlTj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sWOy14NEPvIrd2v93+aLa9GVTxKQed7gCP6mheB9m4=;
 b=nOfycqfJM4y4mwFRXzs31cP020H3X/jPu4xfaRCLfLMj2FizdEqonyYWWWEy0MWgRG/MfIZuRi5gB8Q2BH+QjIgx80RPlvv42sI21KcRBAT1rC58h/SWnqHrlQBIIicYYZJJmOdnnnuyc6GYF5yQdYqlRX4qMZiBDPUbzJef292yZRpw14xCDfXnV4/kDfGqThJspJlwz/r+29s8VVwCze9m6Ponu/UOa2ZaSHgxQaElSefH472y1Db8QzOwlGDd+BbVDP+F1CGlqgu+YIW3011Id7/LpSUKoQbD01FugW3Iwv+un2AsgRcBTn76Ccu1VvkexBzV7JTMVIMpiR8WKg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by LV8PR02MB10334.namprd02.prod.outlook.com
 (2603:10b6:408:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 03:08:57 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 03:08:57 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] tun: use napi_build_skb in __tun_build_skb
Thread-Topic: [PATCH net-next 3/4] tun: use napi_build_skb in __tun_build_skb
Thread-Index: AQHbvpKxzSVpsluvS02O73CvrYJiybPHphEAgABp0IA=
Date: Thu, 8 May 2025 03:08:57 +0000
Message-ID: <5AE43BD6-FC65-4A75-BD59-9CD858D1F6B2@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-4-jon@nutanix.com>
 <681bc77c96437_20dc642942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <681bc77c96437_20dc642942a@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|LV8PR02MB10334:EE_
x-ms-office365-filtering-correlation-id: f308eb8d-78a2-4d6b-7c92-08dd8dddac40
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVloc2NySzdxZEFWLzdBL0pKRmVId3R5MExVZWwrTWE3eUV2ZjhseUk5R2JV?=
 =?utf-8?B?MjFyZXJxY0x6V1RLYStvbTlBYnk1LzY3aVFLOTE5c1BtM0ZhdzFZWW5YdnZ1?=
 =?utf-8?B?V2J2L2s0NWduaWhIeHpZVkQ1dHhXdFU2cFVXMnBJejVFclV4NS9TbHhxV29X?=
 =?utf-8?B?WWVsb3NRcExFZzBKd0psYjEyOEdsUmc5RjVuTlNaNjdkVXNiRTBkRy9XVUth?=
 =?utf-8?B?SGFBZHJsNmpST2x0SVJ3MnVkdVpPVHNoNTFQTzlhaFFpdjVZVUhSYkxvT3Mw?=
 =?utf-8?B?eXIxSWZ3VUVTUmlyWE1zaktESTZYTXpLKzlhTFFiQlp2aWFHWFVtUTN0eXRR?=
 =?utf-8?B?VVZnOE1tNjZ4QnBTSXJUOVBaMmthaWVsL2pCYkU2L3RLcUk4d2pIV3BubllF?=
 =?utf-8?B?alhHWXRVV25zczRXU2lrbXhibnR2NEdNSFR4dWphU0J6S3VYZExsL3JnYXZS?=
 =?utf-8?B?T0l2SGxMaTJsN2tsQktJTjRvNzVTY1FiUEJuS1IrbjBKRWN0c3o1allVYitW?=
 =?utf-8?B?TGlQUytJNkVHUGw1Rit2Yzg3U0FEV3RETm5MRFhKNUFNSUJtUlhDU085K0hG?=
 =?utf-8?B?cXU0SVMwdC9KVk1VQWJWUWtzS1liYlN1aHZ1VHBuT3JWZ0dKdzdQdGlhSmcz?=
 =?utf-8?B?YnhqMTJaWXFWVDhqbUJRSU1Penc3NnJpUmR5UWgwNVMzd0NaeE9FWW8rV240?=
 =?utf-8?B?SVJXYnNBbnJ1SjZkMEpaMkFOVFFKSXpTUU5EZC9PV2JmNHVTVmRpaHlTaGFO?=
 =?utf-8?B?NzVTN21pckVmRVlTSkpqRnRDQ2NMeHhrUXV4ZXBadEZoWGhQYjR2Si9aZFdE?=
 =?utf-8?B?U2VJUUFESmJBNWsyUi9iZzNQNzMxK1psZk1FOTg4dHIvWmx2c3YvR1JEWno2?=
 =?utf-8?B?K2xoVVowakdzWHdBMzk2cGpNZ1NSNmZ1MlBrdmVnY05VNVAxbmVZOUdxRWVC?=
 =?utf-8?B?SE9FM2tIdUJCK0dPTzQ1SnZIZUt2VUFpSGcxVEIrcWlVWWZUd1BzN2IxeTMw?=
 =?utf-8?B?cXhuMTBBQW90WlMyR0NETmRrcHBqU3oyeVVwQXVuMWNyUzg2Tlh6K0NRTU5z?=
 =?utf-8?B?OTFjLzFwaDBoSzdLYzNqWDZncTRjZ3dtU2ZnSHJUYm9GeGZYLy9TTlhlNklz?=
 =?utf-8?B?QkV1VHExZDVVVS92Y04xWGR3NVlmNFpXVHp1WUc0SmdHTHNKU3BROU0waG02?=
 =?utf-8?B?WkJyMzd1MlVHa0o1RlRHUWhpY2ljWHg1L2FvSmYwejhEdS9PWG8rL1N2cVpJ?=
 =?utf-8?B?bWd3Uld3Q2pBQWpCWnRoblBicVJwei8xbU1kbmVncU8zSW9JclY4dXVaZEt0?=
 =?utf-8?B?YUtIMGRDOFhCbDBWMkFXU0ptOFdacVNPV3ViMTY2QlFMR1RtdHBwWVgyZXRZ?=
 =?utf-8?B?dTNvZytDbGxubk5DakI5Z21uN1R5VGp1UTltR3FTNFhKaG15dnA4ZGwyQVcy?=
 =?utf-8?B?U0xxaDNPRDgxUEFPY2NBTSs2MTd1cjBjU0xGRFk4ZFVKZUg1VThhZUFMRmNr?=
 =?utf-8?B?V2QxdDNzSm5lajM0RVhnc2Q4Sm1qYkFGUlZJTjBneVkxMUp1bVdNMHo0U2lT?=
 =?utf-8?B?T2FlRWpjNGx3UFF2eWtON1lnZFdTVG11MU02alRGUnRVZCthY2prMTV6MmI2?=
 =?utf-8?B?UjMrc3pFeDZXUzNaRkNCTDIvVE90RkpKbFl2ZGs2VnNWcnN1SGFsL0xzeVlE?=
 =?utf-8?B?OW5hYWhNNVpsaWV3WnRrVEtzVHh1N09ZdmRVdXpGTWIrMG5La045eWwwRUF4?=
 =?utf-8?B?T240QWc3Myt2ZzN3SXJUdzdzaEhiMWxDb0pOaGFwVkpoU0ZFaGkwL2RDZWZW?=
 =?utf-8?B?dFdKQ0p0MDdlOFdZdW5IUDQrNUJhUjdXR2ZMV1l6RnpTZTZFWDg3NkE4TlZx?=
 =?utf-8?B?eFdqaVNJUWw0ZWFVM3Z6alMrYzlBWEJqcDVvM0RxY21ZYWpZdW82QlAxd05K?=
 =?utf-8?B?UGdSZnV2OTJVV2llajRpWmlJOEh1bFZtajFFRS9uWE9yQ1VLeFlCUXM0Z3Ax?=
 =?utf-8?B?aEZyeXNOTTVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnNHK0FJUm9QRUdMZ0VHOE9pVUFkSXhCVFQ0eDgvUnhHS2Nodmt6clhYekFN?=
 =?utf-8?B?cGZhbUFHdDIxenFqUkhjSzl6bjFXK3ByTHlqT01IZ1doSjBEU05aSVM0SUhJ?=
 =?utf-8?B?dllkOW54bklhTzd0SXdIUmcxTkVQSTRDMmZKeWlyeHU4dkpWajFCVUtLYUd5?=
 =?utf-8?B?bU5USThMUFMvRGtNQnd0UnhrTmYvelRFVzFLdHpmUm1ySTdqNnhmS3NEL0xG?=
 =?utf-8?B?R2pQd0Y5WUtmSFZ2N0FoYVluWm9aWnkvU0dLM3lCVUhhQ3J0V3ZUMzRaSFAr?=
 =?utf-8?B?Nnl6OTlmci9SY0dqcWpJdm4wazFpcm9nYnZYZ2s3emJnU3RwRU5KNVEvWUJY?=
 =?utf-8?B?TGVZaFZvMnlsWHVIbTJrZSt6QWRZYWcwbDFad0lGSjg5STZwcFJJUjMzSlo1?=
 =?utf-8?B?Z2pqc2pXV0VRK05zOGFjbFlLTWZyczJjK0RlejdnYWR1TkpjUVpHMk5VWjFM?=
 =?utf-8?B?dnFIRnFzWUJPd05XcmpjRUpKQ1FYdUlDL2dxSXRwVXJMWnYzZEE2TmxpZnRL?=
 =?utf-8?B?SFI4MHFUeHBLRUxjSEdUUVFDMXZ3Skp6WDNwa0d6dXFzTVE2cGZ4R2MraE81?=
 =?utf-8?B?Z0diRzBHN3dRTVFhS2JCL3B1UHFSRlptRlg2Y2h5N2tiSlJSYWM3ZmlLUDdo?=
 =?utf-8?B?NXk2QWRhZ2ZPWTlkSjZPVE9mS1NDSjlHR3JHT2ZIQ1B3NjdjSS9paW03OU81?=
 =?utf-8?B?aklFWEhHcWpIQmZLaVFqVllNVlZPNTRMTExiVG0wTUhSZjg1c2VHR3laS0tB?=
 =?utf-8?B?RkdHR0NMVHk1VlgwZ1BsL2dySW9BMk5yRk1DaG13VjNmT0l4aU9FczltcEVJ?=
 =?utf-8?B?VDRvSXJTSSs2SG1QVmdkbS8yWXgxR05KQUpGaDdGNzlhenNCV29pbjdDb2dD?=
 =?utf-8?B?di9SV09OczZlUW43N21SY2E2TitRdnZLR2dUa3RaVkY5K2xYRUtydGlldVVj?=
 =?utf-8?B?K2xHMGlJUGpCdmZCN2VHZ01UV2JsdlpySzRBUDdkSjdZWWJFRG9ySWIwdU9a?=
 =?utf-8?B?NlQrampXZ1FnRXhFcmFDcUlWdnhSMjcyQ0VzK09xNXdVSW1jY3BLTnFINm96?=
 =?utf-8?B?YkV1aWRONXMxOXlBNThFdThJajFLcWk1a3d0M3pmdS9pMHZYcTVtNHhacW96?=
 =?utf-8?B?UVZLSkxicUlMR1hveTJienJSVGFPWS9KMm1nTFVrYnFEVENqWXZyR3J2TFJR?=
 =?utf-8?B?aHYxb0Z5MUtRMG1UWGNrQ3pBRHFscSsrdnRSZ1h1MlFIa01BdmNHbHhNWTRz?=
 =?utf-8?B?aWFqMGFMTVRDN0g0M2xSbUNFdHQ5SDB6bmh1bVpXc0cxdDF5V3FDZG9DMHFj?=
 =?utf-8?B?alpiK1QrcERGR3A2ZllBdEJSb2FQak9MTldjRmNORmdKQUFsbTA4eHNYRTc1?=
 =?utf-8?B?MnhsVEJkc1FtbTcvSVE0Y1A0MXlEaFlMS28xZnRGT3ViY1hLa25LdHM4R1VE?=
 =?utf-8?B?bXAwVEU3VWNkSUJ0cGZaR2lBTTNiMTJhSlpvU3h2Y3dWdEpDdC81aTNtNEFT?=
 =?utf-8?B?dUNNd3Q0QThBdkgvMG12bTVTTkFFdVZVamNuZ0dXc3RwY3hsc3V4NUswOUpI?=
 =?utf-8?B?ZUkrOXVyTG1qWDZhMFU4WGtFd0ZBT2ZWb0RtUmtuN1MzWXVwWGNQSkxDTUdK?=
 =?utf-8?B?R0pxcUJpejQ0Z0RheVZibHYvYzd5VWRQZXoyVDdieU02V29HKzlJeEcxYlZT?=
 =?utf-8?B?ajNmemNBRWlweENvWmkxcWVFcDJjREN5bStRTE1rU2pzM2VRS0VaY0ZScURu?=
 =?utf-8?B?ckJ1WStCczQzWFVsZEx4b0lJRWY4R3lsV0ZSZFd4MlVPSnR5QUEybUZSeStr?=
 =?utf-8?B?V1ZpVGtWaDVZdVZzTkN3cFZxYU1JY2NTMG5TRzBxRG1jTU9CSEpUTCsvcnU5?=
 =?utf-8?B?K1pTOVJLVStnQzlIZGlieVJFV2V5ZnQybjlxNHJoYVA2Yk1MT3hiQ1dqSHZv?=
 =?utf-8?B?VEFZUWRNU2ttSHpPYm4rMDMyUkxPV1NhVkVEN0VvM3hsdTc5YzNjRmx2Z0hi?=
 =?utf-8?B?UjloWS9oZnlMTVhLRTl2WmVPbnhGSXRwc1hkeDNuT0tra3kyWklhc040eGFn?=
 =?utf-8?B?VCttNk51d3JKVHVGTmJIZUdOVTZ6OWQ4a3dRTHRSeXFsczJ6aUhVQ2xlVlpE?=
 =?utf-8?B?Nm01cWlTcWs2YXlJUlZnMmphcWI4K3dmb2l2TkM2REZQaXh6QUpQcGg1WEFF?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <278C6CFC5E816740967FB33D7ED632B5@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f308eb8d-78a2-4d6b-7c92-08dd8dddac40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:08:57.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+a9PYCdIflzfaB+WKSluKhr+/IxFx1eu4xzQO6VmzAXWqqocNO08P8wHGeCbxjLiVmrg0rEKBndbG6Zb0l2KBLbPcSIV3G2uG1VSiZ1TUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10334
X-Proofpoint-ORIG-GUID: w7LpGCm4CXtPMWBPNTBaFsiGjD91ZTKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNyBTYWx0ZWRfX4kxaSBUhO1zB rNb0iGAyWVA9jgZd0jc20iVM9W+R9vecvJx9U3DjC9t4GRx4BqnZiPbS3u1vYuWsVVKig8yZ1GQ r9kG3K84J3ELWVeC0J3N0HTOAuSUEcUO7lr823pPirJ35ocsOxN5A16ybY/2pOHMNuxtqXs1+Ap
 526xF60eiTGDJYqlLn3Ruhpzqpt9GaWfW1BQETjv+KhSylLc5oZyVVrk5Skh+KYgsjLZYOGWlO9 etkZ+FuBaBdXP7qv+4GKdGllFaK1Gve5hyDbTfgDUJ/MRZtg0VYtVccebF4zMoykvebVsi0bnel GuIXQxeat1GIeMlHGRSh5UPac0b0IIggUq/sgJTIu9oxcj/cGqToisZwcqFKn1WKQ+CLy5uP4Tr
 OqZoMnGc2dwHl68JAwQ2tqIup7Qw5BGlOZfo1ocI4bcRXFkKxEXK+W5AsZP3UU2/yn/Dc0e9
X-Proofpoint-GUID: w7LpGCm4CXtPMWBPNTBaFsiGjD91ZTKQ
X-Authority-Analysis: v=2.4 cv=J5yq7BnS c=1 sm=1 tr=0 ts=681c2052 cx=c_pps a=YTelpZo7+Gv92UPfPuytLw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8 a=xdSlDxOjc4gCR5GH4CgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDQ6NTDigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiBVc2UgbmFwaV9idWlsZF9za2IgZm9yIHNtYWxsIHBheWxvYWQg
U0tCcyB0aGF0IGVuZCB1cCB1c2luZyB0aGUNCj4+IHR1bl9idWlsZF9za2IgcGF0aC4NCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPg0KPj4gLS0tDQo+
PiBkcml2ZXJzL25ldC90dW4uYyB8IDYgKysrKystDQo+PiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiBpbmRleCBmN2Y3NDkwZTc4ZGMuLjdiMTNk
NGJmNTM3NCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiArKysgYi9kcml2
ZXJzL25ldC90dW4uYw0KPj4gQEAgLTE1MzgsNyArMTUzOCwxMSBAQCBzdGF0aWMgc3RydWN0IHNr
X2J1ZmYgKl9fdHVuX2J1aWxkX3NrYihzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KPj4gICAgICAg
aW50IGJ1ZmxlbiwgaW50IGxlbiwgaW50IHBhZCwNCj4+ICAgICAgIGludCBtZXRhc2l6ZSkNCj4+
IHsNCj4+IC0gc3RydWN0IHNrX2J1ZmYgKnNrYiA9IGJ1aWxkX3NrYihidWYsIGJ1Zmxlbik7DQo+
PiArIHN0cnVjdCBza19idWZmICpza2I7DQo+PiArDQo+PiArIGxvY2FsX2JoX2Rpc2FibGUoKTsN
Cj4+ICsgc2tiID0gbmFwaV9idWlsZF9za2IoYnVmLCBidWZsZW4pOw0KPj4gKyBsb2NhbF9iaF9l
bmFibGUoKTsNCj4gDQo+IFRoZSBnb2FsIG9mIHRoaXMgd2hvbGUgc2VyaWVzIHNlZW1zIHRvIGJl
IHRvIHVzZSB0aGUgcGVyY3B1IHNrYiBjYWNoZQ0KPiBmb3IgYnVsayBhbGxvYy4NCg0KWWVzDQoN
Cj4gDQo+IEFzIGFsbCB0aGVzZSBoZWxwZXJzJyBwcmVmaXggaW5kaWNhdGVzLCB0aGV5IGFyZSBt
ZWFudCB0byBiZSB1c2VkIHdpdGgNCj4gTkFQSS4gTm90IHN1cmUgdXNpbmcgdGhlbSBvbiBhIHR1
biB3cml0ZSgpIGRhdGFwYXRoIGlzIGRlZW1lZA0KPiBhY2NlcHRhYmxlLiBPciBldmVuIGNvcnJl
Y3QuIFBlcmhhcHMgdGhlIGluZnJhc3RydWN0dXJlIGF1dGhvcnMgaGF2ZQ0KPiBhbiBvcGluaW9u
Lg0KDQpAQWxleHNhbmRlcjogdGhvdWdodHMgb24gdGhpcyBvbmU/IEZvbGxvd2luZyBpbiB0aGUg
Zm9vdHN0ZXBzIG9mDQpjcHVfbWFwX2t0aHJlYWRfcnVuLCB0aGF0IGFwcGVhcnMgdG8gYmUgaXRz
IG93biB0aGluZ3MsIG5vbi1OQVBJLA0KYW5kICJicGY6IGNwdW1hcDogc3dpdGNoIHRvIG5hcGlf
c2tiX2NhY2hlX2dldF9idWxrKCnigJ0gc2ltcGx5IHdyYXBwZWQNCnRoYXQgd2hvbGUgYXJlYSB3
aXRoIGxvY2FsX2JoX2Rpc2FibGUNCg0KPiANCj4gRnJvbSBjb21taXQgNzk1YmIxYzAwZGQzICgi
bmV0OiBidWxrIGZyZWUgaW5mcmFzdHJ1Y3R1cmUgZm9yIE5BUEkNCj4gY29udGV4dCwgdXNlIG5h
cGlfY29uc3VtZV9za2IiKSBpdCBkb2VzIGFwcGVhciB0aGF0IHRlY2huaWNhbGx5IGFsbA0KPiB0
aGF0IGlzIG5lZWRlZCBpcyB0byBiZSBjYWxsZWQgaW4gc29mdGlycSBjb250ZXh0Lg0KDQpJIHNh
dyB0aGUgc2FtZSB0aGluZywgaXQgYXBwZWFycyB0aGF0IGl0IGlzbuKAmXQgTkFQSSBjb25zdHJh
aW5lZCAobGlrZSBzYXkNCm5hcGlfYWxsb2Nfc2tiLCB3aGljaCB0YWtlcyBuYXBpIGFyZyksIGJ1
dCByYXRoZXIgc29mdGlycSBhbmQgdGhhdOKAmXMgdGhhdC4NCg0KTXkgaW5pdGlhbCByZWFkIG9u
IGFsbCBvZiB0aGlzIHdhcyB0aGF0IHRoZSBuYXBpXyBwcmVmaXggd2FzIHRoZSBvcmlnaW5hbA0K
aW50ZW50IGFuZCBpdCBtb3JwaGVkIG91dCBvZiB0aGF0IG92ZXIgdGltZSAodG8ganVzdCBiZSBz
b2Z0aXJxIHByb3RlY3RlZCkuDQpBbHdheXMgaGFwcHkgdG8gbGVhcm4gbW9yZSBpZiBJ4oCZdmUg
bWlzcmVhZCB0aGUgc2l0dWF0aW9uDQoNCg0K

