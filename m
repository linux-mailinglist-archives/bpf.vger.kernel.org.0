Return-Path: <bpf+bounces-57726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B49AAF17A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2192B4E4217
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97BC1F0E58;
	Thu,  8 May 2025 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="OsFnLIkN";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ex4pP6FW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04694B1E5E;
	Thu,  8 May 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674027; cv=fail; b=cU2dGEQBopm2aLl5qaZx/JMkx2ozZrLNnlr081PvPqQ4BiQXEo9FmH3ge//sHpOecxIGmxpkhx8VPIv2eLrL3tW5SCYVFdoBc1OqzBW2/Cy36YQsmduBYrMH7Dzgy/sgYFTxYC7MZ9g6oHliPXWd2i+tLpV9mdgYpMwIFmvXykE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674027; c=relaxed/simple;
	bh=ALUmDb6eFKVfueE/hXHNe1P0z8TcMWsNBev+sb07p7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTINsw6QMpnPqJjiwQPgoTHyfO+xUpovVcML3gUiJsgn7eKyXlRc0spOHa5yYuE482Rrske+/TRjIILSBEAQ81lwLs/9xZBmMHzswZ4N2cn+FeDTa6gyE298OTKVxyG/bj1Cyn3ClfBUO+unQzkmyhPdQSaSLYhBKyXa0EiTKVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=OsFnLIkN; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Ex4pP6FW; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LMCBL029193;
	Wed, 7 May 2025 20:13:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ALUmDb6eFKVfueE/hXHNe1P0z8TcMWsNBev+sb07p
	7U=; b=OsFnLIkN5KX8eQA9kyCoi4f+eIncF1sGaP5sSNSXMWxAbFQctmRi26+if
	HF8UmkzKc8gcbe/rBkhL4cDhqFXKDWMa4T7vFnqrKqUpdISdYAbRKdbca48NGKmJ
	pqeCvbunnMjYAD9UtUH3xHhZbVVN2FCbvpoJIAl4cDq6mXMmixkuCht+AgZnZ7Yr
	pG75CTthGTcn9j5Sn120d241nDBl+UK4+DwrNvb4WeGA5ikxJr7ZRDPzXAPQZAk4
	+ugebg6jdiAe7x5sfg5/Q9u+fUg7OvRxbHN109pnjVvl0zm2Pg29s3D7ZW5qNysC
	tiRnvH9IWz5yTcp3yPq6u1I20/njw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djp12jcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 20:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdirA3qwvVICrYUazuDE+lMUC+JeXBSN0CkAKPRYH51Z3XYyJSqxUWgynaDRpQ3Oi0m1BjfoqLEwbwGOK0++/ihNdDfRuctnrudmzTtD4xioyYsBnv+1HJWBRxBCBeYqtBhB/Z8Tq79eRywnq5mFu60fqYDYCdXYTxwbhAg08179p/BQ+2Yh4bXlGinN50QQoD2sp5aIBAVd2prqVpcS+ywChU06jUjaCYDoE/0h4fRPYCLVzBrDTWyhGg3p38avt4U2Ca3/iiJQYa6zuW2xP4rybY1WXE4PPnbrTqpu2i4XPNwOGkYUCAtQI6DJB/8J52GAVvNznaa9q5IzgyxWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALUmDb6eFKVfueE/hXHNe1P0z8TcMWsNBev+sb07p7U=;
 b=Hw7wGgXeebE+VFMedNUyduJueedLN/XFU96KGULbgrsiQhkga60lhin5mssvtSG4I0sdpeg5BdPshRNZPh7Pw9c+5tPy1ycSSQJthSDpGSEQrFjhyfRSVYS3gXOUiys/j1XL23ogVafU8r0Xl1Q4li6CvF4s9Vy6cxHNVKyhuRFJ99AbJQ7fovP1BhivVewmvkw9y0xmRUrjHaidJS8m6jpj5N3U+Rywg0O5TqadTPzFZq+UCSuN3BeEtGcfsWPucHiKgsjV/ir9AFCsdbFMEGzySyfulg0coiDecUJghoucZPRhutrgxIiY1Srq1no7fWFYM+F9DGYAaGrHA402Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALUmDb6eFKVfueE/hXHNe1P0z8TcMWsNBev+sb07p7U=;
 b=Ex4pP6FWuLg0u+sCCKMt63ANOK1JpBKdM9l3xQn5App1LeWBavBYjAvHvEZivKQQnC886KkUAkLX8a5D2+zhDq0CceRE3GW+MSNrF/+U7Xum0lksio6onb0zmhnbnt4kUNPXSfO3RupTTSzEr4fxkSQ1RA9oOh84JoLeAeujapuo/cdjMjlO2S0vYSEZO6CCIByUqwbXS1zcOT1bg2ySpQD5M4Pc9H1NewnzG4CnF+OV2zZZInIoShecreYoHd82C99J7tfeVsSKiy4REJSwBCfgsCMa+JkZDCXh6AamQEswhoSr3uQSZZLQpv3eqEwBJxD7O1XFNPgbiFUrCJi9SA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by LV8PR02MB10334.namprd02.prod.outlook.com
 (2603:10b6:408:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 03:13:18 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 03:13:18 +0000
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
Subject: Re: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Thread-Topic: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Thread-Index: AQHbvpKqjlwy8c+fkEmxxfKJcSD8ubPHpD4AgABs2YA=
Date: Thu, 8 May 2025 03:13:18 +0000
Message-ID: <CF84F28E-C3D0-44C0-8540-53E184BA1F79@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-2-jon@nutanix.com>
 <681bc5f4b261e_20dc6429482@willemb.c.googlers.com.notmuch>
In-Reply-To: <681bc5f4b261e_20dc6429482@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|LV8PR02MB10334:EE_
x-ms-office365-filtering-correlation-id: 13def20a-313a-4f97-b222-08dd8dde47b0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VElnV0FjUUorOUtWbU5hT3laYjBGUG1uT29keHZ0VVlGRWlIQ1BBQ3ZST2Y4?=
 =?utf-8?B?ZTdLczBuL3p4eVlYOXBLK1U5YzFEM0pJMWc2aWhqeDA2ck1WQW9CWFQ1Kzg3?=
 =?utf-8?B?TytJSHFrUGx6czk3TDYyZFJESW9Qdm9sMHRHK0JmWkZyQWlrQmFyelNGQThT?=
 =?utf-8?B?UlpZN291WmNzQkVUV1EzeVBjSkZPUUc5ekpXalUyL0pQU2R4K1NnUENxZGhM?=
 =?utf-8?B?dlU3M1hXZ2FMYmk4Q3BjMnNmeERZVEZIQ2tnSnFtcTdnalF0MEY3aFhZT2th?=
 =?utf-8?B?SURuNklEV1R6eGVhS0c5RnJvVkxESTkvV05WQm5FWC85RFFYbVBZeXVMK2wx?=
 =?utf-8?B?Q3dlWWxUYkV4WXBVQkdDYW96dng3TFVBSDRaVkVNSnh3NzVyUlZ3d1FKMVpJ?=
 =?utf-8?B?REREcVRlTlFEZllob1ByeW5WQS9uempFeFlmamFrQ3A0OG1UTXl1MjlkWGUx?=
 =?utf-8?B?Y25OWXkzQmhNazZLN1AvM2kwU0V1Q3dxNWgxb0hNeUtJeTNEN0pVVWRRYTBn?=
 =?utf-8?B?V2Y1Q2RaYXNrZjZnMGxodWRvU2pmUm02RUF0WUVrdTF1dWlvMlRhVGFjQXM1?=
 =?utf-8?B?MjBEZnpBYUF2QzhBL2ZRN0xXc3BCOS8rMXk0a0dhSVZnNm5xclBXUmkzTFFr?=
 =?utf-8?B?MHBicnRoWFZnT2xiY3N4eVVWR2RYaVROVncxa0VoeFdubVdUK1NDK2c1Rjl1?=
 =?utf-8?B?M2NkNUozSzdyMXR5Y0NQRGN1QVlvSGF0M3B1T21ERFJWb1hrNURxQ3g4R0NP?=
 =?utf-8?B?VVNObHM2eVNSendtN1I1d2REWC9NRHVDNlU2VHhtbStKNGtyODhNK2FXajR5?=
 =?utf-8?B?SkZDUUYvVUk0YnQyaHQ1cGNic28rdzFNSzl2SkQ2TDkrVFhTNUpZUWo2MFl3?=
 =?utf-8?B?MC9wb2FQZ0R0VEpyT0xTVFkwZEZ1cFlhQ1lFOVI3Z3NBMVREbmpUY29oa2ps?=
 =?utf-8?B?T2wvWkVGeDRJU1lHTy9ZNERoRXNDOU0yV2VDTmZySmN5L1VVczhmWXp0WXdL?=
 =?utf-8?B?UE5lOVM4MkVRNXdmK0hKeXZSZmQ4ZWh5K0dIaHFybmlsdzZuMm1zTnFDWjlq?=
 =?utf-8?B?NGZpayt5WjVZZks0Vlp5ZUlGWm9aeWh1VmN4RXNFTXRTcHgyR2g2UllMVEJn?=
 =?utf-8?B?eTZ6R0g3UktBemhhMndxWWpLSkZKQjJOcTcxai9LRjFLc3VsTmlwcHo3ZFZH?=
 =?utf-8?B?aUVOZWxVb09iQTJPc3lzc2hKWUF2bDZmMVEzejJsbVFpejY0OEV6WVMvSXVq?=
 =?utf-8?B?dHp0TklYRmJ1Tnp4Ni8ybzIxSXFVZU8wazRUNzV1bTlWNEpvbktTSnRXTTRx?=
 =?utf-8?B?QS8yTUFsVDRxcXJtVExqOWwzV0VQQ2Zld0ZnUlJXVUN4d1BCSW9EK3MrUTU3?=
 =?utf-8?B?ck51VEZUU0taU1pyZDBRQXVreGY2NWlKY3BiUERDckYyWjVLR2Q3VnAxTDlG?=
 =?utf-8?B?djZJK3Yzazl0QjkzdDdXWngwRGkrVlpvU0ErR3IwdkVVTU9NbThXOU94a25y?=
 =?utf-8?B?Z29tTG9TSUk0N0RFY2pLRTQ2ZTEweXNqVkhTcDJnalBuUGhIRmsxdUl2TWt0?=
 =?utf-8?B?YmtTaGNWK0dxc0N1OElVeWNuWTRoVmowcFFqOG9pMjB1NDhyRTFlbGoxeGsx?=
 =?utf-8?B?ZzlCWkxYZkgzNkJoeEpsRmlmZ1d4OFZhaFlmNURwdG9lN1ZkUktXYWNCajZO?=
 =?utf-8?B?K1JNeFdiT2d1YXdlOXk4aEJjazN3amI0S1ludkx0NkM2WDBsUkMwaFBIOEQ1?=
 =?utf-8?B?ejJGbU9hY1pyenBUVG5pd3l1U1lKY0FSWkszbVZiNi9QM2JiWWcwejdha3N6?=
 =?utf-8?B?azNlcVgyb3lYanZpYnRKZUZQZER3R1htZjdxdXZpUm9uemN2VmF4VVY2ZXFG?=
 =?utf-8?B?TG41amh1dnJ1QlpUc3VsdTBsNWpDa0FPUmxEaStvY2QxZXhTMXZ2WEJMVzlH?=
 =?utf-8?B?UG1QVk9pS0dJTCtuek5WSkhTc2JxZ1JGeStQdEY0MmZ0clFvRFZGZEVLaXVn?=
 =?utf-8?B?WGNCeUFiQ2t3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXBqZ0hNMmJBaUZlaGRVL2kvLzdoRWduQWs0MStheE4rbTBBQXBRSDIxRUNQ?=
 =?utf-8?B?RTVBcjhvbmZoOHdEUHFveFBMS3NQK05mNkJ6bG5tUUpCdmIzZ1BucE9rVzdy?=
 =?utf-8?B?S1hMSW9SSVIraXEybGFtUVJjeDlIU21JWGRuellxd3ZkSmI3eXlyaUVhc3R6?=
 =?utf-8?B?ODNoQ0k2UjVDWExOSmtGbG9GYTZ5c1dnd24wcWd3SlB4MnB5bWxrUmp3SCtM?=
 =?utf-8?B?R2hkMW5nOEduMGhWU21Qa1gvNHNpTEZqSW9kS2lWQ2pkeXZ5K2RLRVNxdEpw?=
 =?utf-8?B?ZDdtNGhhOWJpb0F0T20ycnVtTEQyUWtHNi9SMkdjWEZidEhvRGgzeGlFblVo?=
 =?utf-8?B?ZzBOc3hvWEZ3QVo5QTJPRWpicCtxK2psUmVwNWVlMlk0L3l1TTRMUWRtbk5V?=
 =?utf-8?B?cVZBbHJxYkZsS2lWSHNyLzRBZDJwb3QreDVQVUl3MGN0dXpRWVY3MWpSYmk2?=
 =?utf-8?B?N0JCTXdUZFZPdkJiRnc1VWlYNDIrOWhrWUlJYk5YSmR2WlpzZk1EM2JXa1Jw?=
 =?utf-8?B?RjhMdkRnMklqak1sNWxEYTVsWFlzd29FYjJRMTJua09iWGNLZ2pmdlBwTDNa?=
 =?utf-8?B?SWZvSWxUVXlSeVI2c1pqUHJJaDFCREcyYW5iM255bmxVVkVjSUdaUFNVSVBW?=
 =?utf-8?B?Z0NHb3R0UnJDTzhNSEYvd2pEdnRLQTdGY1hWUUh4NUwwTmRIWTNlaEZ5dlFm?=
 =?utf-8?B?cEhpWXVpN0F3VkVLaTlMRkh6U1N5SU92eTZkd2tzcXlhdEtMTU5BY2dHOFMy?=
 =?utf-8?B?cHRyUmE2bXI2NXF5T2hYZThEUE9GVEFZTDkyaHcrNytHR1R1VUtTaEJMWjNV?=
 =?utf-8?B?aTRSUmJSaTA1MFZ1VU5vbW04eU4wUEdWRWNBelM3d3ZRN1VMQytjZVZVZWla?=
 =?utf-8?B?THo5cTNDTU1XL0x3eTM3MXJlTjBSQVh4Y2RMeWVWYVlTcGdMSUFUMXBEOWRp?=
 =?utf-8?B?NDVacG5adWowNCsrdUlyajRodnlqU0lWWFVjY05CQ01seWo2bDhDdVNHL3lx?=
 =?utf-8?B?ZVQxbmlSaXNma3h0QnpaSE5GTlZpKzBVeSsvaDhJdmMyRFFmT2VmTEp4Zmxq?=
 =?utf-8?B?UHVhRTlSQytIbVkxRWhYczNacTlyTHJwek0wS010dzZ3WnhaL3BublBkUmJP?=
 =?utf-8?B?d0h2dHMrdk1YUERRdVBuRktRZGpyS3BvNzdwdjl6WTRsYzI5SWJhYnlMSnor?=
 =?utf-8?B?QUx0bVZWYytzWXpKU2trUHMyUG55a2kzNzNyNjMzNGhMNURIRlF3NE55U1F5?=
 =?utf-8?B?cTVCYmZzOERudFBlS2NHTmJTYmNSMysyNTFyVDArdXhoYmVvTWpML3hWWDcw?=
 =?utf-8?B?dGN2aWR3Y3NxVVczVW9RTVpNK2RYQkYrUjNwWm9meEEwV1E2b3E2VDVieU9s?=
 =?utf-8?B?ZjVON21PU01JL001eTlOUDhjRFk3MFNzNWZIZ2ltdmFZSkpRejU4ME5SeEFM?=
 =?utf-8?B?YnFtQXZWN3l1eFBtUDdEQ0hCWTZ1SUxqY29WaEVhcUlLMUpqZ1dQWFpWMExa?=
 =?utf-8?B?NndXODZkVnFvRGJ5TnpaZ3I4QXJzSDJCSklYTnFwTzRBdWRKZmluQXVaaE13?=
 =?utf-8?B?TytjT25FUWpTTnErL0RCckdpV3l1UklxRllwenBhNFM4cmtrV3V4RGoySmw5?=
 =?utf-8?B?bHpQZFFGY1pYNDhhTmVJMkp2VHB2dk90K0p5OWU3OXZVVlA2bGZHaXBVV3Vo?=
 =?utf-8?B?bUFNSnlHekxKT0owL0xxNFArb1E3YzRFajdqWDhUb3pBWE9weC9NcnFBRkNR?=
 =?utf-8?B?UGppM2pvbWF1MGFvWE9ob0YrVko2OE04Y0xDZG1Mb3FuRnlGL1BBSG5WZ2xB?=
 =?utf-8?B?dFhkZ085YXdEQk9qdWpZVnQ0bUtrQ1NxTEw3NDB3RldBUGZubDZXeTJtQ1Zn?=
 =?utf-8?B?czR4cDVpaldOZW1Mc0dxcm9aeXRpcDVBOWludFp3aFRXQUpqVENRUU54S2JX?=
 =?utf-8?B?RG15ZTdnaDhJNC94UnBTZEx5SFJzekc5cjg0eE8rT0Erd3VaOElONlp1ZDV6?=
 =?utf-8?B?b2VLTENmUjRETSt3SC9rVEFsMUpFL0xjWnZnNEZQYnFzb1h5dmJLMVJ6ZnF5?=
 =?utf-8?B?VXN6K0JXNE4xbS9Eb3IrVXZxNXRBT2hGZVB1MkVuVzhqaVpNdGlGNUdMSjhY?=
 =?utf-8?B?VG0zUkxXRHd2RzY5Uk1SSS8zNG1WcC9kM1BUSzZzWGdYS0o5R3p5Nm9RRWVD?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8820BAA293A3B4A8F3524F3F84F68FE@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13def20a-313a-4f97-b222-08dd8dde47b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:13:18.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M8YpT2wkUah4HkgvdDWeE/Ms2g9/itaBWuKBhFICMjiqtR3QgyKDKdq2LNTOMp36RTS8Ud3DFsQ9NArsslVe1AA5rUHDb3DGE5uW1YmcZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10334
X-Proofpoint-ORIG-GUID: kP3WVKkNINJvYrxGMQDodpBJyXGHbAIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyOCBTYWx0ZWRfX9VSvjQwy/rT8 CIzpiQymCBS88BRHqvqM7pvyNw/7jEYUWpuLdppgjc9MEKwTQf89OOYemGo8Ho3ayk83jymKJAb ML8KWQu+lIUNU87vckBrZwlJy7BLz5Ha+wYgXEmpX24rk1WHcuvGlAKv1YumeNSK0VByppqNZZ1
 tI8OxIcB98UFek5RtLXv7EgJyA3dG0isGXqvQPhzNDk1GlpLlpGoYvTeZdBwwxpKR1Zkz7gD6ap pmklmLrYqwCV7/fMKcnKD9L2og933ihq6Nv9fOxXVfFM73UYV/4nxBfUIF2xmC5WO0P6RGKPVa6 i3WFhkLsn1Q1rH3a7lzGUjqVS0x81GZoIM6CRUGtXoxFz6DmvNn3RH+GlUJLAVJUmdXRGzeMvLp
 IOLAi7QHAlsOopf4mzFYa1fGVJsqpR9ydznqTr008eB//EcTf13WsY6YjGGB64jl59sirSmM
X-Proofpoint-GUID: kP3WVKkNINJvYrxGMQDodpBJyXGHbAIY
X-Authority-Analysis: v=2.4 cv=J5yq7BnS c=1 sm=1 tr=0 ts=681c2150 cx=c_pps a=TWVVkEr8Ytp/jGYVlMgQuQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8 a=YHyfU3prTFVGqkxMnc0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDQ6NDPigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiBIb2lzdCByY3VfZGVyZWZlcmVuY2UodHVuLT54ZHBfcHJvZykg
b3V0IG9mIHR1bl94ZHBfb25lLCBzbyB0aGF0DQo+PiByY3VfZGVmZXJlbmNlIGlzIGNhbGxlZCBv
bmNlIGR1cmluZyBiYXRjaCBwcm9jZXNzaW5nLg0KPiANCj4gSSdtIHNrZXB0aWNhbCB0aGF0IHRo
aXMgZG9lcyBhbnl0aGluZy4NCj4gDQo+IFRoZSBjb21waWxlciBjYW4gaW5saW5lIHR1bl94ZHBf
b25lIGFuZCBpbmRlZWQgc2VlbXMgdG8gZG8gc28uIEFuZA0KPiB0aGVuIGl0IGNhbiBjYWNoZSB0
aGUgcmVhZCBpbiBhIHJlZ2lzdGVyIGlmIHRoYXQgaXMgdGhlIGJlc3QgdXNlIG9mDQo+IGEgcmVn
aXN0ZXIuDQoNClRoZSB0aG91Z2h0IGhlcmUgaXMgdGhhdCBpZiBhIGNvbXBpbGVyIGRlY2lkZWQg
dG8gbm90LWlubGluZSB0dW5feGRwX29uZQ0KKHBlcmhhcHMgaXQgZ3JldyB0byBiaWcsIG9yIHRo
ZSBjb21waWxlciB3YXMgYmVpbmcgc2Fzc3kpLCB0aGF0IHRoZSBpbnRlbnQNCndvdWxkIHNpbXBs
eSBiZSB0aGF0IHRoaXMgd2FudHMgdG8gYmUgY2FsbGVkIG9uY2UtYW5kLW9ubHktb25jZS4gVGhp
cw0KY2hhbmdlIGp1c3QgbWFrZXMgdGhhdCBpbnRlbnQgbW9yZSBjbGVhciwgYW5kIGlzIGEgbmlj
ZSBsaXR0bGUgY2xlYW51cC4NCg0KSeKAmXZlIGdvdCBhIHNlcmllcyB0aGF0IHN0YWNrcyBvbiB0
b3Agb2YgdGhpcyB0aGF0IGVuYWJsZXMgbXVsdGktYnVmZmVyIHN1cHBvcnQNCmFuZCBJIGNhbiBr
ZWVwIGFuIGV5ZSBvbiBpZiB0aGF0IGdldHMgaW5saW5lZCBvciBub3QuDQoNCj4gDQo+PiANCj4+
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBK
b24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQoNCg==

