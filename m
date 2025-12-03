Return-Path: <bpf+bounces-75970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83AC9F8E4
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B188230292F0
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5431328E;
	Wed,  3 Dec 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kY1NUVrb";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bw34+9so"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBF312820;
	Wed,  3 Dec 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776167; cv=fail; b=BRoCS70LQx1BdGnzd0pI9sbOFphWuy6hRRvhjAGr6uZFPSxriPRBGB5PI6cts4yf/nimBNXZPYzSRzVWRINqSr07yMbCqH/sTNmMzKrA7Qr5fhqijqoKbH7yT4zO0e6ufK7tyIcBRsPOl2onfeIFNmBk6Qtnx2YebEAWZoOI3II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776167; c=relaxed/simple;
	bh=yKON/Yw4Q6PqrK9CPaLboGn4Uo9kydduixvBJ0reXi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orP2M9+3lAbzO0u4Elq6fyGZU/kd5KTuTrkx8iHshVCMIOPgiPf6Jktzz97ovgl4p9hfXpn1j7DCxcVjXoSCvCFr0QmuitFBXVerh+EK+AN42nmkHXxLfGeTjAe8z7Ow11b1J0AcnJGxMvhmdlCPpVsCCJfQ3ttFjAEmQvcEvWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kY1NUVrb; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bw34+9so; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B37xU3R1853065;
	Wed, 3 Dec 2025 07:35:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=yKON/Yw4Q6PqrK9CPaLboGn4Uo9kydduixvBJ0reX
	i0=; b=kY1NUVrbKomg/d5UYOYlDPxLSOA8AY5zTEY1EiFdKMaH8OVycToWi6nku
	gxWlvx/Spjc7w7R4qU2XKZgQC8eLc7XvenouuDWU4/TMo5tXyCafL8QLgXEpk/25
	cWG8mPfn+xyncIvbK8uQ4Hzdtpji4Qwq3MKN0FXZ+lkpiwVsNUVM/smfm2gTiQIC
	ITiPuimx2p7TkcmzefJmnzU352QZmgXD4a2CR5wfRmsEbYpyPuyq99Gm8qlvOFK3
	sm4hQ3/YbvdF4IxfHrmzWNRmgbg4Q8m9bjzc7cUQvS8kM+piCP8WMnCcVVHo/SfK
	OsvoOAK2JG9nr1b4d6Mt0YGxyYdUg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023142.outbound.protection.outlook.com [40.93.196.142])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at29pjyef-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 07:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOo0QoScDJnTse0Xph0a4uZ+o2yipmKbVe9coUirRgWew2WrZgSgCPZfqwysmbIj6wfnXQmaL75bOzKpqM3XJPNK65biWxKjGkZSyEGci3CvTsD5qBWF6V5o+dBnvY9sygPh3UtVH7z8UT/H+blMAI1XdMNYWMWzWaLpgi5qL6/VWFfpbpUawrPS/jJ6RHXMdpvXtoe6/3UD5/SSiPIi7WokG8dxnrsuc9ANOMmJpCYPlbNHji0icvhNVhqNBTWHKodES3j4Hny7FkXHJCmpeLjIeJk5XUBzLj7gpT/KXw0m0hiivUGvjc0kFR2jDEwSGiYFYPFR7uDwYnl8sI1Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKON/Yw4Q6PqrK9CPaLboGn4Uo9kydduixvBJ0reXi0=;
 b=t7niMPanTuzrVP6oftEui7zha1j9c+FWOqOZjP+NoDtiRVciFQd7yzBCR95UZSArtZaJlXWFLmtBqRqehu1gwWohL+auIxaPZU/nkCpl6u4eN0QDjHMQE/L8ydHgzopZU9I4geD/6cz+4K0cPCAMm/L0pdIle1hnixRl/EvA6iCZj4KZY7guoN34duNP+pNsMKQSX4u0V/RwPZlsoDtrYk0/ZRFWGSlhmyCbgNI3zWbQnJ6QZz+WAJq6NUfJjjcd1RXAd4WBSwZ3Vhsu/KdlfkO5+XPR8jtFJogMIYJhMQ2iYyRirR9M5zwHi+FnostL+rsbZQ5bn1P4Y3FAU6T1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKON/Yw4Q6PqrK9CPaLboGn4Uo9kydduixvBJ0reXi0=;
 b=bw34+9sodM5KzQgK6moGQu//ca+vZGFNtUFMqtWU37h/GXlPzuPug9T7DTTidmt++zEyxMlpCW3dT8qqx20iz40tduyv3pNzkH5/py1YbE1KcAoKmxlTh6CIgkiup+yMdk1VGUOY+E7/rq3COfgebHKi3JFcsphqbIg43esnzKWUJWYdA+ftwRlhzgA4LL7Gi7lwSq+jqnGuoZWeKgBVQUHYZwOyGFaxCbdsnTRAqA2KRMdWdUEi7IeWDKHpg5PHdoj4zaB+ZICqcB4YAMIThhmYEV2eap899vEaYut+pSabJ2XX3zn4jhDY0NaAsL1FhS4nzGzoLLdUVm2j3KkLQA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CH3PR02MB10485.namprd02.prod.outlook.com
 (2603:10b6:610:203::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 15:35:24 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:35:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Jesper Dangaard Brouer <hawk@kernel.org>,
        Jason Wang
	<jasowang@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav
 Fomichev <sdf@fomichev.me>,
        open list <linux-kernel@vger.kernel.org>,
        "open
 list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
	<bpf@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Topic: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Index: AQHcXkBJGnA/Z0TBbE2dy0yPlIYpvLUHaj+AgAcwkgCAAAvqgIAA/5QAgAByBgA=
Date: Wed, 3 Dec 2025 15:35:24 +0000
Message-ID: <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <20251203084708.FKvfWWxW@linutronix.de>
In-Reply-To: <20251203084708.FKvfWWxW@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CH3PR02MB10485:EE_
x-ms-office365-filtering-correlation-id: 1b66c46b-7d57-428d-82ad-08de328193db
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVNLS2pjN0RFUEM4WDZkY1YrUUx0dWNWU2R5V3JIV1BMYnBYeWpLV1ZEaUxl?=
 =?utf-8?B?MENLY2RtRjhrS3ZDVFk5UGVRRURpeVhaR2tObFR6TjloQ0xJejFoem40ZkQ5?=
 =?utf-8?B?THhXNnYrSlhzZi9xY0FhaGdKTEQrOUJ0ME9vbzhUZ2pCNnhuYnN5SDZPS2RC?=
 =?utf-8?B?SGM1MFNUb2w3SjRCTGlRWnlibVBWVXpWbmtLWktRUXQxakpCQ1dObTVHR3pQ?=
 =?utf-8?B?ckZ1QTBmeW9hQkhDRmdVUElaRTBUcjBURksrVnVhMkh3UGpZQXNQVVg0SFBp?=
 =?utf-8?B?bE9RNUJ2UGN1a08zeFhiZXJja2RzcW5NZC9TVFo5LzIreWtCNUJMOHEvOGF1?=
 =?utf-8?B?dnY4THJ4ajlxQ3NxTEtqVzhzV2xLT3A3KytzeVdLNlBuRU9nVlNkOEYzcTln?=
 =?utf-8?B?eWxTdjQ2Q0o5V2VxTUZrTWh3SWRBWTBDN3J3cTYzSWZ6TjFZZGtNTHdVdUxn?=
 =?utf-8?B?ZWJYc1diVExRa3IvcCttNDdIdHpVbHZOaWg4TTcwMXh1ZkZnTktlUU8wRGhN?=
 =?utf-8?B?RW1IZG4rNjNEMUVqdSs2bnZKK2NWWGs3R1JPUS96dkdYTzlSMGhHaVp1bmV6?=
 =?utf-8?B?NjlmWmdScFZxajJZc2Z3Q3c3N0pSYzJmbGREOS9jT1k5a1I1bU1ZcVU3Rlcx?=
 =?utf-8?B?bkwzbkVuaUVMRC9vWXZGeExDalBVejN0cnJhNkduc3ZPY0JpTGZxRTM1K2Jm?=
 =?utf-8?B?L0trYWdYT1JwSk5KZVFGUzlyRXZpS3RxVVFQQVhqdDlLc0lxdEdkM1Q1c3FX?=
 =?utf-8?B?Y2thWFJuRldZVDg3MmQxKzhrUUx1U0JLcXhTdnB3S3FhNldlOE5Ta2lha3R6?=
 =?utf-8?B?cVZhcVp1cXM5TjllSXREVW9oZ0tDNW9lV0Z2d2JJWW0rS2pzVXFxM0ZleGFt?=
 =?utf-8?B?WU5SSWVpNzZhNmVEYzY2N0EzN1djOE5xQVkrS1F3cjl3R2tqVlk2TEx2YWpT?=
 =?utf-8?B?NnBCNHBVdytWQUt6VElhUGhHeWlkaGRBSzI1aXlNNDY0dEIyZGdTcnZ0eEds?=
 =?utf-8?B?dkg2VElRNnhjQ1g1aHJvc1l4YkJveENuUmlMakxSTG0wVGY3Z09BR0xndXk4?=
 =?utf-8?B?RVhZY3F2SFpXY3RmeGVnOXBEMGhMbk5aemhRQVZPUWZ1NmJHcmYweDJJdlAw?=
 =?utf-8?B?dVZXUGZhSkl5aU8xSzJWZ2QzYS9xKzBzRlJtQmdlSTlwWFMydENOWXJ5VkI1?=
 =?utf-8?B?czFjTmZBZHpFOFAwSlRBZjNkUXMzTFA1bDJRSEVmQ0JCNndKRnE5YmpkVi9x?=
 =?utf-8?B?NWhieWlra2hkVFdUc0F4ZmVOS0xCcU5ZZlh6UFpQek52Wm5EdEhqN2V2bkIr?=
 =?utf-8?B?Ukk4VXdtdkV5RHg4eVNvOXd6d0VYOGFuSXZxa3NueEhlajhxRnI3THYxYUFH?=
 =?utf-8?B?aEJteENsaGdpUE8yd1k4eENFamdYUjEvdWp4KzFpbVZudHFpOGZ3akFEbXlT?=
 =?utf-8?B?R1VYNTArUjVCMzhzbjN4L015VW9KY21uVUd1Q29lbkFqbHJHZE1yYXdlWnFt?=
 =?utf-8?B?RkJ0Z3ZGZlRoMmJqU2NZQThFdm1LSHFvNDM5OTdNQWhkd2JXVFhjemNKQUdR?=
 =?utf-8?B?QWpDWk12T2ZZWHdjWkRsRTFjYVdFRTRIMWY3SjAvdVdaeWt2UktFODFYQyto?=
 =?utf-8?B?SU96d3cyZ0ZCbGN1cTV0SDlGSlFZTDJLeDRsQmxQTkpCbm9jdlEvbGVFYUxt?=
 =?utf-8?B?WVJTaUhTR1RRVEVqRDB0Z1hVd2V0dXJJcmY0TzlVTVJKR1NxdmNjcWR1ejE2?=
 =?utf-8?B?cTZEYVpPa2M4T3M5QVFkUlV4TjBGQ0loZkF1aGdLdzdqRG9qLzJCVjhQS2pp?=
 =?utf-8?B?RklhdUpwbkRrWnNzK3NhRU1DdFE4QVlJcUNVSEtpT0FFMlpIbjBuMFcvWlBX?=
 =?utf-8?B?cWk4VXh0L0lyYmRmNzgzMmRpdDF6L3ZXQjhDVEhYNWJoOWd4SVhicXpsZ1Ey?=
 =?utf-8?B?OEpBMGpEYXNNTFNENzJOS01WVEJUVEsrUzdQVk1OVC9sZXdzclc3Vk5MR045?=
 =?utf-8?B?T1hCV3VYMkxrRlNGaW1EYjY1bmlFNHpudjBKWlBGNi82WXdaRGFLQVAxYTRl?=
 =?utf-8?Q?Z95Y0I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVdobDVWY1J0cFphK0pqRVJXTEJ0SERyZDZXNDlGa1lWV0JoQUo0cHplUjZw?=
 =?utf-8?B?NGNpRHhoY2tmTDVjWGpkZmJ3Q094bXpIN3BZU1M5SnEzWEo5RHRxeUFnT2lB?=
 =?utf-8?B?MGZYRkVnMGhqR0pCcTYwZy9renN6WW1UMktyMUx0MzgrM1lqMGpSckhsQUhR?=
 =?utf-8?B?Q2RDM21FNXh6SmlTZzBVWGJ6dEo5THlkd0NuRzQ2clMvRkc2UnVDdDI1UEFJ?=
 =?utf-8?B?S2VUa1RidFkxd2pHVUlDY2thUiticDhrNVdUQ3NQQ1loYnNOQXN3YWo2TFc5?=
 =?utf-8?B?SlBRVjhnZFdKRlVaQyt4WEdNTDBIc1JmNFM0eEJzTlBVSk1DNCtYRUdTUE51?=
 =?utf-8?B?OUxOejBYTkVGd1ArT200SFRMMTJUaEhmckJETzl0d2pvY3lLSUVSMDBzRXVU?=
 =?utf-8?B?S04yKzJhclpMQUdKSXAvOVo5Qm9OWXdoZnViSm45QXBSMlZqeVZndkNTVmdq?=
 =?utf-8?B?K1EwS05BamhiL0YrSnIyMHUvR3dxTEV5V1QyZEpydmp1clNYbmhmbklUK2RB?=
 =?utf-8?B?azZDbUxnSmREQmc2MDludldTdE83Y2hmMk9lemF2dTVhWnJVcDNPOWdRNGY4?=
 =?utf-8?B?dWhDZE9aUzFmQzhmcDdZWDNjcGNYbnh0Qk1iNnNDNG1wbFYwc0swa1BqRTJL?=
 =?utf-8?B?ZE9jRS9KZS9SOEtaTi9IczRFdFpMRXBuN01Ta2o0ZHlmczg0RDRLd1BSWDdT?=
 =?utf-8?B?WkdWbHE2WXBZdEdnMmFVS2U5bE53TjgxaGxuU1NFRS9TSWlKMlpmVGIxU2VE?=
 =?utf-8?B?T201SE5MYnkvblNzbDVyQUNPdWF6T1VWNURqK0NOMlhLaWU4QnlOYUhwaXVw?=
 =?utf-8?B?WnM0S2lNSlhialRlbTFzV2k0NnIrcjZiZngzQXkrUDFiTVpndU1oaXhjeHFz?=
 =?utf-8?B?THF0eDViVHlsS3NacDJlNnFyUXIwcXp1ZitiUENMUDFqZGlpdFZ6NnRJM3Bt?=
 =?utf-8?B?WHlUQW5ScjNod1JOU2RwWTJIcENLOVYwTXJkUzNzYUdhbEhkdEhZcThtQWkv?=
 =?utf-8?B?RXRtbU40VzVubnNXYzRwclZzWEpQQkgrK3VTcDN4RlVqRlFrQjVEMHowc210?=
 =?utf-8?B?dVdsNGYzY3lZVWlYNnRFYUdiSGxSWVBLc01GeTJJdXliZzgvMGU1bktTbHZt?=
 =?utf-8?B?OG5oUlVTMnhqMkZsTmxnbkc2K3NvNWxTWmM3dU40YjN3aUxldnJNMC9EcXc0?=
 =?utf-8?B?amtjTkJpRkdFMHB6Q09WeU45MDdLblVaWk9qMiszV3o2d3Bsck4wb2FpeTE0?=
 =?utf-8?B?cmg5Sm14VElzc0E3N3NZRno1TkEvdi9mZDArdUZOOHN0TWZKaS9SUXRxNWYy?=
 =?utf-8?B?Q20vSlRDNWVqMmsvMXFHRG5ZYnJLWDVKM3B0QnNUdnBySlZiUk45RkFWZGtZ?=
 =?utf-8?B?c3luWWg2cUZ0WVBibEt3OFBsZndOQWlrenNJZVJOdys3dkJ3dkMwRXUrSUFE?=
 =?utf-8?B?MkdBVnlaVEtTUjRUcWgyWHFIdHREZVBVcll3SFpTYkFWR0RDVktlMSs5MFUr?=
 =?utf-8?B?YSs4YVJHaXloRkgzcnVQRk9LRHlaKzN6bk5Dd0VwRnp5RU12aDRybkI2aURS?=
 =?utf-8?B?UFVWNEc5UExhSGV5NEpJOHVOejhrS0NGcHo1Z01oSld4RTl0Yi84MlEwbnl6?=
 =?utf-8?B?S1JEOUNaU2xRQmlicVJqVW9VOG5oNXpBT1g3ejJPWTY3cHZhV3ovUTRNT1dk?=
 =?utf-8?B?RUlVWDNVSVFmdGk5ZmRBVUZ3Q1JzdjZqNmIwQ3RMRWNZQ3NoSm9yWlJJazRP?=
 =?utf-8?B?djQvSEp6ZTFLeXZjeWNFOEVJNk1MbzZxV1FNZHlwaGNScmJlQ3JVTDZIRUJE?=
 =?utf-8?B?M2xxMllOdElJdE9hWkQ2dS9YY2JKcW5NSy82L0x4VVJCZUl4SmYwaTFiR2FN?=
 =?utf-8?B?MzIyMGsxODFVWnkvK2pTNDl2aUszazhoSW9pUlIvWjFpUVpFcHdPYzJldCtB?=
 =?utf-8?B?K0NkUmQ4N1NTVGxiMXpxb1lQUEhobE5tcVl6ekJvaEprZzhOVHJabzJTZVhk?=
 =?utf-8?B?bTVadlZ6SU0rTkdHbkpPc05ISCtRaVRoMVVJb1gxSFRMSDZMT0hnbC9wekdT?=
 =?utf-8?B?NGdSRWI3QmZwcHZlaTlLejFlNFZYNW5vYjRqUGtVQnhZY2x3QjRqVUlXRy9l?=
 =?utf-8?B?ZXYrMmMyOVFKUTN2RmYvSmV2U1V1ZlVmdDIvV2pTazdUSExrdjU5YmpGZzZ5?=
 =?utf-8?B?TXpDclJKVWZFVG8zbUp6cko1bGdvRmJzY0lwZWdDRGlhWW9oUUozaVlKb3Jh?=
 =?utf-8?B?NlZrNTNCc1cxejBMc2dyU2FQS3B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACBCD2A5A13DBB489B95312790CFC27F@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b66c46b-7d57-428d-82ad-08de328193db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 15:35:24.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgGmz6/qawW3QIDeO2AQkjJI18sI8BsLOKZMh32AKPhXaU/r4Dreyhr7IHo+TcQN5MC0qyiYYcEgkECpehjkhFy71OvcFkk8i0dSgiEWd/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10485
X-Authority-Analysis: v=2.4 cv=O9s0fR9W c=1 sm=1 tr=0 ts=693058be cx=c_pps
 a=Db16Y4lORBbdbxOstMYGNA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z63dM7LJC--zgO-Z1QUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2XYc8BGMnDBgShmVigeq5iJHaroz2QLI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEyNCBTYWx0ZWRfXxZ6gDmDqzAK4
 bIK4WjZviczWD2dNlaqJGcNO9A2KBTi8wsohLg547N93kjWdWdkZCk8hR2TNXMt9HSAwX7lkFpp
 khGCzUd4qzkkIF8eUo33XHPUjEnAlXj4/gCTWG55GoNzkq3oeFLqmwCkaXBHS2z1jb5QpcSgWOW
 /zjr59Osb9Er5Vw2dUQifpA9iJACyOeXeEzZzPTFcmfVhYBEDbMUchTfSb2XpXiPVa7sy3v7QD1
 3gxyVZ6p8lUNRXvtxPrC4LzluFyPKOgHpoML6aN/nqilQO34u+FQZ/WEfLTe1tFh79ClC+cs9VC
 8L3N0RK7HXbU3jjW6Ztkzj8Lmfppig4Nbhu87hLEFFO4iONI3OXnuJuurN0bSDj/0TlkAEko6A9
 bHZKzWC954jJW3kqZCeSwKbcyM/srw==
X-Proofpoint-GUID: 2XYc8BGMnDBgShmVigeq5iJHaroz2QLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDMsIDIwMjUsIGF0IDM6NDfigK9BTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0K
PiAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24g
MjAyNS0xMi0wMiAxODozMjoyMyBbKzAxMDBdLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3Rl
Og0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgbmFwaV9jb25zdW1lX3NrYihza2IsIDEp
Ow0KPj4+PiANCj4+Pj4gSSB3b25kZXIgaWYgdGhpcyB3b3VsZCBoYXZlIGFueSBzaWRlIGVmZmVj
dHMgc2luY2UgdHVuX3hkcF9vbmUoKSBpcw0KPj4+PiBub3QgY2FsbGVkIGJ5IGEgTkFQSS4NCj4+
PiANCj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhpcyBuYXBpX2NvbnN1bWVfc2tiIGlzIHJl
YWxseSBqdXN0IGFuIGFydGlmYWN0IG9mDQo+Pj4gaG93IGl0IHdhcyBuYW1lZCBhbmQgaG93IGl0
IHdhcyB0cmFkaXRpb25hbGx5IHVzZWQuDQo+Pj4gDQo+Pj4gTm93IHRoaXMgaXMgcmVhbGx5IGp1
c3QgYSBuYXBpX2NvbnN1bWVfc2tiIHdpdGhpbiBhIGJoIGRpc2FibGUvZW5hYmxlDQo+Pj4gc2Vj
dGlvbiwgd2hpY2ggc2hvdWxkIG1lZXQgdGhlIHJlcXVpcmVtZW50cyBvZiBob3cgdGhhdCBpbnRl
cmZhY2UNCj4+PiBzaG91bGQgYmUgdXNlZCAoYWdhaW4sIEFGQUlDVCkNCj4+PiANCj4+IA0KPj4g
WWlja3MgLSB0aGlzIHNvdW5kcyBzdXBlciB1Z2x5LiAgSnVzdCB3cmFwcGluZyBuYXBpX2NvbnN1
bWVfc2tiKCkgaW4gYmgNCj4+IGRpc2FibGUvZW5hYmxlIHNlY3Rpb24gYW5kIHRoZW4gYXNzdW1p
bmcgeW91IGdldCB0aGUgc2FtZSBwcm90ZWN0aW9uIGFzDQo+PiBOQVBJIGlzIHJlYWxseSBkdWJp
b3VzLg0KPj4gDQo+PiBDYyBTZWJhc3RpYW4gYXMgaGUgaXMgdHJ5aW5nIHRvIGNsZWFudXAgdGhl
c2Uga2luZCBvZiB1c2UtY2FzZSwgdG8gbWFrZQ0KPj4ga2VybmVsIHByZWVtcHRpb24gd29yay4N
Cj4gDQo+IEkgYW0gYWN0dWFsbHkgZG9uZSB3aXRoIHRoaXMuDQo+IA0KPiBXcmFwcGluZyBuYXBp
X2NvbnN1bWVfc2tiKCwgMSkgaW4gYmgtZGlzYWJsZSBiYXNpY2FsbHkgZG9lcyB0aGUgdHJpY2sg
aWYNCj4gY2FsbGVkIGZyb20gb3V0c2lkZS1iaCBzZWN0aW9uIGFzIGxvbmcgYXMgaXQgaXMgbm90
IGFuIElSUSBzZWN0aW9uLiBUaGUNCj4gcmVhc29uIGlzIHRoYXQgdGhlIHNrYi1oZWFkIGlzIGNh
Y2hlZCBpbiBhIHBlci1DUFUgY2FjaGUgd2hpY2ggYWNjZXNzZWQNCj4gb25seSB3aXRoaW4gc29m
dGlycS8gTkFQSSBjb250ZXh0Lg0KPiBTbyB5b3UgY2FuICJyZXR1cm4iIHNrYnMgaW4gTkVUX1RY
IGFuZCBoYXZlIHNvbWUgYXJvdW5kIGluIE5FVF9SWC4NCj4gT3RoZXJ3aXNlIHNrYiBpcyByZXR1
cm5lZCBkaXJlY3RseSB0byB0aGUgc2xhYiBhbGxvY2F0b3IuDQo+IElmIHRoaXMgYWJvdXQgc2ti
IHJlY3ljbGluZywgeW91IHVzaW5nIHBhZ2VfcG9vbCBtaWdodCBoZWxwLiBUaGlzDQo+IGhvd2V2
ZXIgYWxzbyBleHBlY3RzIE5BUEkvIEJIIGRpc2FibGVkIGNvbnRleHQuDQo+IA0KPj4+Pj4gQEAg
LTI1NzYsMTMgKzI1ODMsMjQgQEAgc3RhdGljIGludCB0dW5fc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0
ICpzb2NrLCBzdHJ1Y3QgbXNnaGRyICptLCBzaXplX3QgdG90YWxfbGVuKQ0KPj4+Pj4gICAgICAg
ICAgICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4+Pj4gICAgICAgICAgICAgICAgYnBmX25ldF9j
dHggPSBicGZfbmV0X2N0eF9zZXQoJl9fYnBmX25ldF9jdHgpOw0KPj4+Pj4gDQo+Pj4+PiAtICAg
ICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG47IGkrKykgew0KPj4+Pj4gKyAgICAgICAgICAg
ICAgIG51bV9za2JzID0gbmFwaV9za2JfY2FjaGVfZ2V0X2J1bGsoc2ticywgbik7DQo+Pj4+IA0K
Pj4+PiBJdHMgZG9jdW1lbnQgc2FpZDoNCj4+Pj4gDQo+Pj4+ICIiIg0KPj4+PiAqIE11c3QgYmUg
Y2FsbGVkICpvbmx5KiBmcm9tIHRoZSBCSCBjb250ZXh0Lg0KPj4+PiDigJwi4oCdDQo+Pj4gV2Xi
gJlyZSBpbiBhIGJoX2Rpc2FibGUgc2VjdGlvbiBoZXJlLCBpcyB0aGF0IG5vdCBnb29kIGVub3Vn
aD8NCj4+IA0KPj4gQWdhaW4gdGhpcyBmZWVscyB2ZXJ5IHVnbHkgYW5kIHByb25lIHRvIHBhaW50
aW5nIG91cnNlbHZlcyBpbnRvIGENCj4+IGNvcm5lciwgYXNzdW1pbmcgQkgtZGlzYWJsZWQgc2Vj
dGlvbnMgaGF2ZSBzYW1lIHByb3RlY3Rpb24gYXMgTkFQSS4NCj4+IA0KPj4gKFRoZSBuYXBpX3Nr
Yl9jYWNoZV9nZXQvcHV0IGZ1bmN0aW9uIGFyZSBvcGVyYXRpbmcgb24gcGVyIENQVSBhcnJheXMN
Cj4+IHdpdGhvdXQgYW55IGxvY2tpbmcuKQ0KPiANCj4gVGhpcyBpcyBva2F5LiBOQVBJIG1lYW5z
IEJIIGlzIGRpc2FibGVkLiBOb3RoaW5nIG1vcmUuIFRoZXJlIGFyZSBhIGZldw0KPiBpbXBsaWNh
dGlvbnMgdG8gaXQuDQo+IFRoZSBkZWZhdWx0IHBhdGggaXMNCj4gcHJvY2Vzcy1jb250ZXh0IChr
ZXJuZWwgb3IgdXNlcmxhbmQpDQo+ICogSVJRICoNCj4gICAtPiBpcnEgaXMgaGFuZGxlZCB2aWEg
aXRzIGhhbmRsZXIgd2l0aCBkaXNhYmxlZCBpbnRlcnJ1cHRzDQo+ICAgLT4gaGFuZGxlciByYWlz
ZXMgTkVUX1JYIGFrYSBOQVBJDQo+ICAgLT4gaXJxIGNvcmUgaXMgZG9uZSB3aXRoIElSUSBoYW5k
bGluZyBhbmQgbm90aWNlcyBzb2Z0aXJxcyBoYXZlIGJlZW4NCj4gICAgICByYWlzZWQuIERpc2Fi
bGVzIEJIIGFuZCBzdGFydHMgaGFuZGxpbmcgc29mdGlycXMgd2l0aCBlbmFibGVkDQo+ICAgICAg
aW50ZXJydXB0cyBiZWZvcmUgcmV0dXJuaW5nIGJhY2sgYmVmb3JlIHRoZSBpbnRlcnJ1cHRpb24u
DQo+ICAgLT4gc29mdGlycXMgYXJlIGhhbmRsZWQgd2l0aCB3aXRoIEJIIGRpc2FibGVkLg0KPiAg
ICogSVJRICogZmlyZXMgYWdhaW4uDQo+ICAgICAtPiBpcnEgaXMgaGFuZGxlZCBhcyBwcmV2aW91
c2x5IGFuZCBORVRfUlggaXMgc2V0IGFnYWluLg0KPiAgICAgLT4gaXJxIGNvcmUgcmV0dXJucyBi
YWNrIHRvIHByZXZpb3VzbHkgaGFuZGxlZCBzb2Z0aXJxcw0KPiAgIC0+IE9uY2UgTkVUX1JYIGlz
IGRvbmUsIHNvZnRpcnEgY29yZSB3b3VsZCBiZSBkb25lIGFuZCByZXR1cm4gYmFjaw0KPiAgICAg
IGJ1dCBzaW5jZSBpdCBub3RpY2VkIHRoYXQgTkVUX1JYIGlzIHBlbmRpbmcgKGFnYWluKSBpdCBk
b2VzDQo+ICAgICAgYW5vdGhlciByb3VuZC4NCj4gDQo+IFRoaXMgaXMgaG93IGl0IG5vcm1hbGx5
IHdvcmtzLiBJZiB5b3UgZGlzYWJsZS1iaCBpbiBwcm9jZXNzIGNvbnRleHQNCj4gKGVpdGhlciBt
YW51YWxseSB2aWEgbG9jYWxfYmhfZGlzYWJsZSgpIG9yIHZpYSBzcGluX2xvY2tfYmgoKSkgdGhl
biB5b3UNCj4gZW50ZXIgQkggY29udGV4dC4gVGhlcmUgaXMgaGFyZGx5IGEgZGlmZmVyZW5jZSAo
aW5fc2VydmluZ19zb2Z0aXJxKCkNCj4gd2lsbCByZXBvcnQgYSBkaWZmZXJlbnQgdmFsdWUgYnV0
IHRoaXMgc2hvdWxkIG5vdCBtYXR0ZXIgdG8gYW55b25lDQo+IG91dHNpZGUgdGhlIGNvcmUgY29k
ZSkuDQo+IEFueSBJUlEgdGhhdCByYWlzZXMgTkVUX1JYIGhlcmUgd2lsbCBub3QgbGVhZCB0byBo
YW5kbGluZyBzb2Z0aXJxcw0KPiBiZWNhdXNlIEJIIGlzIGRpc2FibGVkICh0aGlzIG1hcHMgdGhl
ICJJUlEgZmlyZXMgYWdhaW4iIGNhc2UgZnJvbQ0KPiBhYm92ZSkuIFRoaXMgaXMgZGVsYXllZCB1
bnRpbCBsb2NhbF9iaF9lbmFibGUoKS4NCj4gDQo+IFRoZXJlZm9yZSBwcm90ZWN0aW5nIHRoZSBw
ZXItQ1BVIGFycmF5IHdpdGggbG9jYWxfYmhfZGlzYWJsZSgpIGlzIG9rYXkNCj4gYnV0IGZvciBQ
UkVFTVBUX1JUIHJlYXNvbnMsIHBlci1DUFUgZGF0YSBuZWVkcyB0aGlzDQo+IGxvY2FsX2xvY2tf
bmVzdGVkX2JoKCkgYXJvdW5kIGl0IChhcyBuYXBpX3NrYl9jYWNoZV9nZXQvcHV0IGRvZXMpLg0K
DQpUaGFua3MsIFNlYmFzdGlhbiAtIHNvIGlmIEnigJltIHJlYWRpbmcgdGhpcyBjb3JyZWN0LCBp
dCAqaXMqIGZpbmUgdG8gZG8NCnRoZSB0d28gZm9sbG93aW5nIHBhdHRlcm5zLCBvdXRzaWRlIG9m
IE5BUEk6DQoNCiAgIGxvY2FsX2JoX2Rpc2FibGUoKTsNCiAgIHNrYiA9IG5hcGlfYnVpbGRfc2ti
KGJ1ZiwgbGVuKTsNCiAgIGxvY2FsX2JoX2VuYWJsZSgpOw0KDQogICBsb2NhbF9iaF9kaXNhYmxl
KCk7DQogICBuYXBpX2NvbnN1bWVfc2tiKHNrYiwgMSk7DQogICBsb2NhbF9iaF9lbmFibGUoKTsN
Cg0KSWYgc28sIEkgd29uZGVyIGlmIGl0IHdvdWxkIGJlIGNsZWFuZXIgdG8gaGF2ZSBzb21ldGhp
bmcgbGlrZQ0KICAgYnVpbGRfc2tiX2JoKGJ1ZiwgbGVuKTsNCg0KICAgY29uc3VtZV9za2JfYmgo
c2tiLCAxKTsNCg0KVGhlbiBoYXZlIHRob3NlIG1ldGhvZHMgaGFuZGxlIHRoZSBsb2NhbF9iaCBl
bmFibGUvZGlzYWJsZSwgc28gdGhhdA0KdGhlIHRvZ2dsZSB3YXMgYSBwcm9wZXJ0eSBvZiBhIGNh
bGwsIG5vdCBhIHJlcXVpcmVtZW50IG9mIHRoZSBjYWxsPyANCg0KU2ltaWxhciBpbiBjb25jZXB0
IHRvIGllZWU4MDIxMV9yeF9uaSgpIGRlZmluZWQgaW4gbmV0L21hYzgwMjExLmgNCihhbmQgdGhl
cmUgYXJlIGEgZmV3IG90aGVycyB3aXRoIHRoaXMgc29ydCBvZiBwYXR0ZXJuLCBsaWtlDQpuZXRp
Zl90eF9kaXNhYmxlKCkp

