Return-Path: <bpf+bounces-75906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA3C9C73F
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F0A3A7D7B
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB432C21FE;
	Tue,  2 Dec 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="PZt50tsY";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oS1Ibap+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0651E1A17;
	Tue,  2 Dec 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697559; cv=fail; b=k7v+b5qAYYvgCjwge0pdWZq8Afo2OJDh3T9SRR4nuyN5J6+Zqk8MAh2uGoC8eTIJVl6DbLpzPEnNXK/As7XzrfdFwXo9mNhBg8fKIbyTWWHUyg7rgR1e+cNMGVIzxRbOJJu+OqwoKSgIaDTP6MQWBt8HOl9C217I1lqnFH8C+FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697559; c=relaxed/simple;
	bh=lhe7ta1++cOesy/z0Nlv+8gHmqwrLFydAbJJZE0hz04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1VPUq3erR0BgMf3sODk/De+LUcXfyWIBfTuIfn+vr1eCJpcLb7vFWKd7fDxeHVrOUAdaMeJWXlCYe9LtEXRFNNQiGDrZbdWCdr1E7cs1BgYGc1YpkhCgqGjANQhaFa/RyQDaeQ/s+JowgiQcE+IuKQohqD8skZ1U/Z7Ofpw3O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=PZt50tsY; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=oS1Ibap+; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2CZCPO404240;
	Tue, 2 Dec 2025 09:45:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=lhe7ta1++cOesy/z0Nlv+8gHmqwrLFydAbJJZE0hz
	04=; b=PZt50tsYOHs7SWsupdl28tK8zQ3dr0czqFtBax0FETGGpOJot3Cz0bD4W
	nWiHiW9fHRPIIFM9Snt76Lo7XrzBDRS4FMCzNpX1jZic27eV+ZuxgN+hk4DZQ9W3
	5rv/I8vIIAzYL5XUmTprVeK6ssk5hJAjgvGN5/x1jF87Z+H9Z3+Hm73fpGY0eJD+
	EI06tos9HaiYTtlA2Rh565+pCPPhl2kguEnZQtsQe9NOR2S/rTIlfpEyWMlYMaUV
	UHYYV0WYxYw/iw89YAhzZobXicX8/vvwRjNCYjt/qdkrqNuTeOSQClJQ5tQ95fGD
	Xm9BtREcqq2Gpq/A1Lz6h5wThZNFw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022138.outbound.protection.outlook.com [40.93.195.138])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asdueb5sb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 09:45:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuFqVmAY1G3EwAhsob54WCab57+OT1s684HDAWlIlShLnj0UCWBqozlHVDcIGHmFtEwNQgKeAndpMIQGVvIyBH34fKJM9EWuX6UfjY0qQ/Mxlf/AZi+bK0n1UD3xWhDW9mPX6LbFZMjbes5rODWHgm7Iz6uJ9OwtAttTMwIEz+uRG4yA03bAdSIkCchtaywHm7BP9j8UPPDhi2LRxFcLjFTK86FD5nUrDcWHUg84vKhL3yVTe3QCjaU12AA8+a0hGtHogV0IeEsjTeDHOWUF/sTR3F85KbESv4PqaffD9ug3XY5zRNXAaNsNZd9E05Ey4RQJ6CMruNghdARu2bT16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhe7ta1++cOesy/z0Nlv+8gHmqwrLFydAbJJZE0hz04=;
 b=F2rVmkqvLmYpILX2A8YQnvHkCAwvwvDBZxDgJEudELOvJ+cEXTOtr6m3Le5z0f/qWDLzju0LsckFmpt1GfyIDNC5qtWGm1uobuBGVSQSus0VXMcw85vbTMrnIA6wIG6u0KCCnXtdDMQT/w/VXe2xYK/sm9CPvLhlqS6hhBdVyznfpBbIE1H0mEZjqqA32LIfNFoawcQDZzNL7UuM8rOemzJvqAC2Alw27WLhI4/UCWLk3DJaONnOqi0VGRPjhK71NJTUucpRury5cMoFN3o81aWr803RoJQ1gtEDX1X/hzIzv3OxyCxQDlHY7X7GKGnHftiiSCtUYu06fkcGXwM9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhe7ta1++cOesy/z0Nlv+8gHmqwrLFydAbJJZE0hz04=;
 b=oS1Ibap+PEMjIqWmf+w+7wPu25CmUqMWXvsjS3mwFMpFMHiS3HtDqipQrJZ7tScQYgbkgFD+qACefF29k5tdvQ0pUDAykS3E94YQNSi53QFC3SeFPMKN5MmwYCMkQEEjyhY3DxKpaNyPQ2HBPH+yKEJSKMK5iyIFkgCiC5QkuPbdf2A4iiSDRUZkOzAi8Y8nXkwpGHSay/+f50xVKyPKmvEDLL7MiDGmjNP1LN2tVE6C2twzAL+Heni4ua5Ex3OvWrc5Z9UyFsfL1bZmwBdiecsKlGHspecTQjAu8xwckZYaLAw9thWdmnY636v9Vd4KrvMOnVdY46GKA99qseo/vg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SJ0PR02MB8815.namprd02.prod.outlook.com
 (2603:10b6:a03:3df::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 17:45:20 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 17:45:20 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Jason Wang <jasowang@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
        Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Topic: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Index: AQHcXkBJGnA/Z0TBbE2dy0yPlIYpvLUHaj+AgAcwkgCAAAvqgIAAA5KA
Date: Tue, 2 Dec 2025 17:45:20 +0000
Message-ID: <E9CF75DC-118F-44A7-9752-C6001A1BADFF@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
In-Reply-To: <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SJ0PR02MB8815:EE_
x-ms-office365-filtering-correlation-id: 82df8de0-af62-493e-f7a3-08de31ca8ffc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVVqUVQ4dXByUjNmOW4vZ2doSThTaUJ6QWFrME03SU12cVFyMXhRbStRTUVv?=
 =?utf-8?B?TlBWanFOS0l1Zmx0MEd6enhndnBKZWhLWDMvdHVjdVk0OWdFOXV6NUxJanNI?=
 =?utf-8?B?d1ZOU2xoeEFMTSs5R0JqZjMwNFNrclJtd3dsdFgvZmh3YWNZZURzRElGVWdi?=
 =?utf-8?B?UmpiMGVmN2FwUVNBc1A4OU8zMzhFY2cvRjVnOXZpUEh6UzlYNnNtYU9JSHlS?=
 =?utf-8?B?VGsxYmNDZU5hK1BBSGVhZ0NCTThFYTh2cXZLR1hVR05ZSlBKaXRKTFdSblFF?=
 =?utf-8?B?OTgwTSs4ZmlXR2FwcFBNQnduRXh6WTZNYUp5aHZFK3VDT1RWRjJwbFo0L1dV?=
 =?utf-8?B?S0x5aElkWEJnaW5SVWk0NkhxN0NrLzRJd01hR1poMC9HTEc0SDYwd0M1aFoy?=
 =?utf-8?B?YlVIbm54NHdXR0lybnYwUFZXamlqTDRDNVF1U3kyMEdoU2ZjMWJSRVhyYVBO?=
 =?utf-8?B?djhmYmN1NzdRN2ZaelhOdllNamFCT0JSdlpSZHpoSS8zT1JVOGxmbW81c0Fp?=
 =?utf-8?B?M2VNZ2tWWUhqcnZEci9BNFFML09KWlY2UFpZbkU3YXcvQWVzZXhPbUUraVdm?=
 =?utf-8?B?OHgrcEpicXozRjN3elBKZzVqckdOamt5TlpCOEFOeHpEN2JRZjFoUWRpcW1H?=
 =?utf-8?B?ZHdaekJ4anJubzJxZGttQ3dRSHBNV2pMK2lsaG45NGVxSTVLb3ROQ1pobW5X?=
 =?utf-8?B?TDhTQ1g2dzJaME9URHVmTlRXU09tV0p6K1J5ZlQxWk55Y05vSHFQK3Z6OHRW?=
 =?utf-8?B?eHNhSXBoT0k3S2ZHaVNGY2hoZFpaejNLOW0rWGkyTGlqWVZCRHJTWEYyUElw?=
 =?utf-8?B?cjJPd0l3bkRvS0EvYXYzWEJITTNRNmU5S2E1MDQwQVdHbzEzZ2V0aTZ3RVRL?=
 =?utf-8?B?cXpScFp6T0lRNG8vbHo4Q0QzWVdSSk9PbmZBZTY1bVBYanRScTFZTE5iTzA2?=
 =?utf-8?B?WS95eWQ0aDVSbE9TS3Z2MGpqd0pDL3cwL0liYk8wL3JTamVXckluYkpQT3FQ?=
 =?utf-8?B?SzdHWkZERmhKNWJuMWZuTjIxNU5LWkZRbGxweGora3NuZGhjT3lKYUhuUkhF?=
 =?utf-8?B?K3Y5VzNIQmZsR3hoOVAyY3VOSTFHZUpaRmowY3RNcGxBTkxoa0JMUmpMNmhK?=
 =?utf-8?B?YUlST2l2UDJWRnU5STEwaFdwVzRsS3AyQi9HeDJIajc2YnJOVG1VdnJFUUpZ?=
 =?utf-8?B?WWRJOVZKVjVlcldSNlNFYnQvcGJTRkxJakFpMUs0NmNGRURKZ2J4d01ETDVu?=
 =?utf-8?B?dVVkUzE1SzNFSFJsOVBDdE1BRjJaYlcydXZLdTRFdms1SGNxSGVDSXFDa2tM?=
 =?utf-8?B?eE9xbGErbk80OTlKWGVKTTVuR29yTzFSeFJ6aFZKMlV4UTVSUFdmcndZV3dH?=
 =?utf-8?B?SmxuZ2d0NGV6aGFUeVpSakVRTnF3LzBPWlRrYzNLeDk0Tk52ZkdqRG1NRkt6?=
 =?utf-8?B?MEpIVllIb2R3MGFLZ0owK0VCbWFtQTRBTzllZVBpTFNPYmZzN0FCbldzT3Zu?=
 =?utf-8?B?SlNodTA3ZWZoaDZEZzVOR05pMndYMHZHOE9TdUlwMnovQS9SNHc0WEEwa0pI?=
 =?utf-8?B?MEZLMVVxVThNZTc1M1ZHV2FUVW9nWXVXL1dMVlpJMnFzZnRUWFpuSmxpUkd5?=
 =?utf-8?B?b1RXWEM1eUlSME9iVFozaHo2MU53aU1oWnFnZUV6T3cvQUNSNFpiR212bFpH?=
 =?utf-8?B?b2JmTy9KUWVPRkFTckdHa3YramtmTTVhNTZMUXFWNjZLUUNaZzVHQ2R2eHVl?=
 =?utf-8?B?WFVsV2k4OTd4R1BudjJSUkpmcFdIMGxSdGR5VS81TkxCR0FUT0plZXMreEFM?=
 =?utf-8?B?bHlSZ1pLM1lwNjJwWEVxdEFXNzVFQ2IzQmVTQm1IUGJlRG55bzNKQVFSNXhz?=
 =?utf-8?B?dFA2UUxaVWZnZHNuUnJsUjJkRjVtazM3TnYzTEo1bEpCYU40ZkRrbnZ6dk51?=
 =?utf-8?B?RTQwbjhleHJIZmppOUJHNTY4UjN1cnRwM2RJRXB5ZmYvcERFbGZoR1JpU3lh?=
 =?utf-8?B?dUpCRGNDaUtIL2dHbUl4anVyWU9ZdWZEOVY0N1N3aDhlOUE0aDRSbEFvVDVI?=
 =?utf-8?Q?L3gDFY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFltNUZFMi9jaW1RWXh1YWZzOXVPSEh0NHJDakdIa1FtN3RydCtjTDgzNHRU?=
 =?utf-8?B?VnZHU01iczJzRjZTVGVhYm5EVDZlWC9WbmszZ2xwWDkrSkR5OWFoZVRJUlJ5?=
 =?utf-8?B?NjU4c1ZJenhPS01kc2x1V0QreEpIcmVjZ25GMS92MXlJaXZTTklWTnVDN0pE?=
 =?utf-8?B?SGF6S1pDMG5RSG1xd2dWS0xQTml0MW1rNUpoNWNkZ1JFUUpVUWZ0MEVIbXdV?=
 =?utf-8?B?a2dQNUZIVmRXNG5TWi95a2RjaXNwUzkyc0hBV2VkczZDWjlQcWt1YVplclMw?=
 =?utf-8?B?V2ZFSWE5bWQ0Z2xpL05yRGZ5Tmo3MWxieWNNU3g0bHZBQ1hwdWE1NWZPclNY?=
 =?utf-8?B?eUxlUnpFVlB3RXlJaE5xZTU4WnNvTEUvdGs2bnVaZGRhMGJkem9pSlRuc2gx?=
 =?utf-8?B?aHQvcmkvVkJlSkIwVkM1bTRCZG51bnd1K2ZYeFl5MkVnUXNGNy8zeE56VEll?=
 =?utf-8?B?bWgxZnplUkpEQUp3UnIzL3hKZUx0aDV6ZDlLQWFnNyt6K0lmZEdlQkxXN2dz?=
 =?utf-8?B?RjloamtrZVN6T096QmpNQjJyQ3BvSHVQQWloeC9YejZaV3pBOU5YN0kxbzZB?=
 =?utf-8?B?amRHQjc2WTBVZ1FjWXpDSnhjYkdsQlZFWlUvblFOdkZrRFZaNE9Zb2ZWS2hZ?=
 =?utf-8?B?alE1ZXk2T1k2UDV6azhQdEJMY1krWjN2SVJ1MEUzR1hFcU5yVWJVdHJZZVRr?=
 =?utf-8?B?SG1DdlZvWFFnY3BSRUhIci9BNnJyMVF6VTNBQkFNZSs0bEJ0MXNscUcrYUk4?=
 =?utf-8?B?VkFEYnhxc3kycFRoZzExY1NaTHU4M2tuQUpBVXo3WEZscHo0TzhvWnluZGJH?=
 =?utf-8?B?NDdIWFFvVXZNWC9oUm9BOGFXY0l5a3FyMTRlelV6bVkvZ1VoRHhsVWVVMDRP?=
 =?utf-8?B?R1htU25mRC9wWFlqdVBRSDFsYVN2N3BRRFBNYTZXdEZwMEpOdnBlUEFuWWw2?=
 =?utf-8?B?V1lqSDc0cjVsQjRPVG40Tis3Tlo1ekdNUXBERmxoRmNyaVcrMkdtL3Q3WFpW?=
 =?utf-8?B?aUY3Z1J4YTVTeUsrRExMeWlnUHdzbG5FSTNqRFRYRGNYYnd2VlN0Q2pwUzNv?=
 =?utf-8?B?ZEFTSis0VU1Jdk9MVmNFVlBDaXBCbkNodzRiV2pqQXBjZU9HdlJ2Tjk2ODJq?=
 =?utf-8?B?NDQvbjVabStjbWU2YjZrdjJ1dHBuallnUnZ5SmN3OWRzYnE1MnRiYTJUWm5U?=
 =?utf-8?B?N3ZWSmRlcFFIL1ovcmZOTWNhdTdMdG1nSXpXRHp5UGJ1VThNcGFrb2N0cXBt?=
 =?utf-8?B?UVRtZzhuZmUyYWdJdURTcWduOFU3VE5CT1E0SkllblArd05rZ2ZmUW1YVnJG?=
 =?utf-8?B?VnFsSG1iaDlLUEcvczErLzZDa1R1V01BNlQ2L1FSbFkwK0pVdUNMUnpPUHRR?=
 =?utf-8?B?K1UzR0o3VFZJS2xSUU0xa0dsWTB0Q2xpT3ppbkxiTUE5NjJGdjY4QXljaTdN?=
 =?utf-8?B?b0hXV1ZCTmNxN3lpa082eUJpVkJJTlYxS1ZMZHNyOFNWdjdNUTRTTk9IMFhZ?=
 =?utf-8?B?dkp1RWRWZTBjbm5nZERCTkIzdXRlbmlsQWlCekhhSHljTnV3WmZuWE9mNTJm?=
 =?utf-8?B?eDhJQVJlWDF6aEVoLzBMUXBDQjFrY0dKSEN6S3A2bmFrTWQrTTNqTllyYVFM?=
 =?utf-8?B?dDV2T0FocFdaOHA4RTlZMit3ZGl5QzEvL0xWV3FHY3o3VGMrK2RhMGJ0TlNu?=
 =?utf-8?B?R1RXRUgwbFdyT21BQ0Q3R2IwL1pyUWlCN2d0c2JHd1BiMmd5K1BlUVpuK0FM?=
 =?utf-8?B?VlNGUjM1Yjk2a2VWV0o3L3VQeDVHUGZTK3RLbjgyeVZwd1lvTXZVcHc0ZmtP?=
 =?utf-8?B?ZUF5RTdVWUxVQnAxc2g0d0E1dStZSWw2VU4wZnYvOUZUZXFlUEFWTmhRVzJw?=
 =?utf-8?B?TFFwQ1NMVGYyakd4MFd3M3M1dGZPd2tXeTI2cW1WVSs0cUxjWUdCcE10dXBv?=
 =?utf-8?B?SWU3YTFwREZ4NllpbDVSZ1o4Y2EwaURhaDhIRHpyc1N4K0FlM2Y5SW94cUZn?=
 =?utf-8?B?ZHhIbGdrd1FzWU9EQnl5TGwxODZoZnIzQVZ5R0t3SVR1NkpnZUoxTGNtTjZ6?=
 =?utf-8?B?RjdGN04wWU1vMlhHSEtEZ2hsUjg1SFRZZzhxaWVGdDJYUE1YYmp3NVdRemJl?=
 =?utf-8?B?Uis2d3o3L3hMTllCdjgxOGVUTy90VUlWdWtpUEVqRkFReEpzRHlMV1VnQ0Js?=
 =?utf-8?B?cmdhajBveUZPQzh0WjVNNER1UTFEekxUeHFUemxMK1VTZnN1alFJYlFEUVhv?=
 =?utf-8?B?SWhpNm04eDUyODN4S1FUNFhHUlV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12672C5DDF12574EBD425B8201489F89@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82df8de0-af62-493e-f7a3-08de31ca8ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 17:45:20.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjyYHorvyQPbrmYXB/HDHzPvHRJ2LpJhvaI5BBK+BautLcSM7iJ2er98zitXMZjNWzklts9xzJIQfFwdScCFp/Iwsu1uco579q32EZZjwDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8815
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE0MSBTYWx0ZWRfXxogHF4xfDyn7
 D+AYcjTqI0U07yAT2rh1FoY/9eIzqCzPAhn/f+AjK9xpIBGmCMvM4EUOozcxWA7R6odnXLAXq62
 pWe7FwMFZqpbaR1kaW3JERstJ1rRmJuROk8IDT3HNnlQflfbbeBys4WbJ68m4qA0ELurW8kjxMR
 YaZ5fdZL8Sv+32/ocTx7eo0JNhkbkplpGVLRmMUizGxdXdKyrS+F3Ag6b+QiLEsEspGhMEldD5y
 CjfmgNexfi1lAVd/ePBDqko9IsM7d/ksmbQNOSTyrk2t3xmdzKu4vHjsdMQ3rJ3ME9qXWZpmH05
 ij2YbXBar+rQEO0Vxy0iWsJhp61tVMZYOGvZr22hGNw8/J0ENsIyA7v7U1n74E8fQds+1ZOuwoA
 0sPOhiR7N0NdMTbfx3/znxSl1qsciw==
X-Proofpoint-ORIG-GUID: 43PJBiCEZIeVNlDFcqHJuY2emr4SC7fy
X-Authority-Analysis: v=2.4 cv=LIVrgZW9 c=1 sm=1 tr=0 ts=692f25b2 cx=c_pps
 a=ZVJWEtTsqHd5Y1/ROadkLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=81RVb_6GwhyLgQW2qp4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 43PJBiCEZIeVNlDFcqHJuY2emr4SC7fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDIsIDIwMjUsIGF0IDEyOjMy4oCvUE0sIEplc3BlciBEYW5nYWFyZCBCcm91
ZXIgPGhhd2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDAyLzEyLzIwMjUg
MTcuNDksIEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4gT24gTm92IDI3LCAyMDI1LCBhdCAxMDowMuKA
r1BNLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBP
biBXZWQsIE5vdiAyNiwgMjAyNSBhdCAzOjE54oCvQU0gSm9uIEtvaGxlciA8am9uQG51dGFuaXgu
Y29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9wdGltaXplIFRVTl9NU0dfUFRSIGJhdGNoIHByb2Nl
c3NpbmcgYnkgYWxsb2NhdGluZyBza19idWZmIHN0cnVjdHVyZXMNCj4+Pj4gaW4gYnVsayBmcm9t
IHRoZSBwZXItQ1BVIE5BUEkgY2FjaGUgdXNpbmcgbmFwaV9za2JfY2FjaGVfZ2V0X2J1bGsuDQo+
Pj4+IFRoaXMgcmVkdWNlcyBhbGxvY2F0aW9uIG92ZXJoZWFkIGFuZCBpbXByb3ZlcyBlZmZpY2ll
bmN5LCBlc3BlY2lhbGx5DQo+Pj4+IHdoZW4gSUZGX05BUEkgaXMgZW5hYmxlZCBhbmQgR1JPIGlz
IGZlZWRpbmcgZW50cmllcyBiYWNrIHRvIHRoZSBjYWNoZS4NCj4+PiANCj4+PiBEb2VzIHRoaXMg
bWVhbiB3ZSBzaG91bGQgb25seSBlbmFibGUgdGhpcyB3aGVuIE5BUEkgaXMgdXNlZD8NCj4+IE5v
LCBpdCBkb2VzIG5vdCBtZWFuIHRoYXQgYXQgYWxsLCBidXQgSSBzZWUgd2hhdCB0aGF0IHdvdWxk
IGJlIGNvbmZ1c2luZy4NCj4+IEkgY2FuIGNsZWFuIHVwIHRoZSBjb21taXQgbXNnIG9uIHRoZSBu
ZXh0IGdvIGFyb3VuZA0KPj4+PiANCj4+Pj4gSWYgYnVsayBhbGxvY2F0aW9uIGNhbm5vdCBmdWxs
eSBzYXRpc2Z5IHRoZSBiYXRjaCwgZ3JhY2VmdWxseSBkcm9wIG9ubHkNCj4+Pj4gdGhlIHVuY292
ZXJlZCBwb3J0aW9uLCBhbGxvd2luZyB0aGUgcmVzdCBvZiB0aGUgYmF0Y2ggdG8gcHJvY2VlZCwg
d2hpY2gNCj4+Pj4gaXMgd2hhdCBhbHJlYWR5IGhhcHBlbnMgaW4gdGhlIHByZXZpb3VzIGNhc2Ug
d2hlcmUgYnVpbGRfc2tiKCkgd291bGQNCj4+Pj4gZmFpbCBhbmQgcmV0dXJuIC1FTk9NRU0uDQo+
Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+
Pj4gDQo+Pj4gRG8gd2UgaGF2ZSBhbnkgYmVuY2htYXJrIHJlc3VsdCBmb3IgdGhpcz8NCj4+IFll
cywgaXQgaXMgaW4gdGhlIGNvdmVyIGxldHRlcjoNCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fcGF0Y2h3b3JrLmtlcm5lbC5vcmdfcHJvamVj
dF9uZXRkZXZicGZfY292ZXJfMjAyNTExMjUyMDAwNDEuMTU2NTY2My0yRDEtMkRqb24tNDBudXRh
bml4LmNvbV8mZD1Ed0lEYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9TkdQUkdHbzM3bVFp
U1hnSEttNXJDUSZtPUQ3cGlKd09PUVNqN0MxcHVCbGJoNWRtQWMtcXNMdzZFNjYweUM1akpYV1pr
OXBwdmpPcVQ5WGM2MWV3WVNtb2Qmcz15VVBoUmRxdDJsVm5XNUZ4aU9wdktFMzRpWEt5R0VXazUw
MkRrbzFpM1BJJmU9DQo+Pj4+IC0tLQ0KPj4+PiBkcml2ZXJzL25ldC90dW4uYyB8IDMwICsrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4+IGluZGV4IDk3ZjEzMGJjNWZlZC4u
NjRmOTQ0Y2NlNTE3IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYw0KPj4+PiAr
KysgYi9kcml2ZXJzL25ldC90dW4uYw0KPiBbLi4uXQ0KPj4+PiBAQCAtMjQ1NCw2ICsyNDU1LDcg
QEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4+PiAg
ICAgICAgICAgICAgICByZXQgPSB0dW5feGRwX2FjdCh0dW4sIHhkcF9wcm9nLCB4ZHAsIGFjdCk7
DQo+Pj4+ICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgLyogdHVuX3hkcF9hY3QgYWxyZWFkeSBoYW5kbGVzIGRyb3Agc3RhdGlzdGljcyAq
Lw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZV9za2JfcmVhc29uKHNrYiwgU0tC
X0RST1BfUkVBU09OX1hEUCk7DQo+Pj4gDQo+Pj4gVGhpcyBzaG91bGQgYmVsb25nIHRvIHByZXZp
b3VzIHBhdGNoZXM/DQo+PiBXZWxsLCBub3QgcmVhbGx5LCBhcyB3ZSBkaWQgbm90IGV2ZW4gaGF2
ZSBhbiBTS0IgdG8gZnJlZSBhdCB0aGlzIHBvaW50DQo+PiBpbiB0aGUgcHJldmlvdXMgY29kZQ0K
Pj4+IA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHZpcnRfdG9faGVhZF9w
YWdlKHhkcC0+ZGF0YSkpOw0KPiANCj4gVGhpcyBjYWxsaW5nIHB1dF9wYWdlKCkgZGlyZWN0bHkg
YWxzbyBsb29rcyBkdWJpb3VzLg0KPiANCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4+PiAgICAgICAgICAgICAgICB9DQo+Pj4+IEBAIC0yNDYzLDYgKzI0NjUsNyBA
QCBzdGF0aWMgaW50IHR1bl94ZHBfb25lKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgKmZsdXNoID0gdHJ1ZTsNCj4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICBmYWxsdGhyb3VnaDsNCj4+Pj4gICAgICAgICAgICAgICAgY2FzZSBYRFBfVFg6DQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG5hcGlfY29uc3VtZV9za2Ioc2tiLCAxKTsNCj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4gICAgICAgICAgICAgICAg
Y2FzZSBYRFBfUEFTUzoNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4g
QEAgLTI0NzUsMTMgKzI0NzgsMTUgQEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3QgdHVu
X3N0cnVjdCAqdHVuLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHBhZ2Ut
PnBhZ2UgPSBwYWdlOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHBhZ2Ut
PmNvdW50ID0gMTsNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG5hcGlfY29uc3VtZV9za2Ioc2tiLCAxKTsNCj4+PiANCj4+PiBJIHdv
bmRlciBpZiB0aGlzIHdvdWxkIGhhdmUgYW55IHNpZGUgZWZmZWN0cyBzaW5jZSB0dW5feGRwX29u
ZSgpIGlzDQo+Pj4gbm90IGNhbGxlZCBieSBhIE5BUEkuDQo+PiBBcyBmYXIgYXMgSSBjYW4gdGVs
bCwgdGhpcyBuYXBpX2NvbnN1bWVfc2tiIGlzIHJlYWxseSBqdXN0IGFuIGFydGlmYWN0IG9mDQo+
PiBob3cgaXQgd2FzIG5hbWVkIGFuZCBob3cgaXQgd2FzIHRyYWRpdGlvbmFsbHkgdXNlZC4NCj4+
IE5vdyB0aGlzIGlzIHJlYWxseSBqdXN0IGEgbmFwaV9jb25zdW1lX3NrYiB3aXRoaW4gYSBiaCBk
aXNhYmxlL2VuYWJsZQ0KPj4gc2VjdGlvbiwgd2hpY2ggc2hvdWxkIG1lZXQgdGhlIHJlcXVpcmVt
ZW50cyBvZiBob3cgdGhhdCBpbnRlcmZhY2UNCj4+IHNob3VsZCBiZSB1c2VkIChhZ2FpbiwgQUZB
SUNUKQ0KPiANCj4gWWlja3MgLSB0aGlzIHNvdW5kcyBzdXBlciB1Z2x5LiAgSnVzdCB3cmFwcGlu
ZyBuYXBpX2NvbnN1bWVfc2tiKCkgaW4gYmgNCj4gZGlzYWJsZS9lbmFibGUgc2VjdGlvbiBhbmQg
dGhlbiBhc3N1bWluZyB5b3UgZ2V0IHRoZSBzYW1lIHByb3RlY3Rpb24gYXMNCj4gTkFQSSBpcyBy
ZWFsbHkgZHViaW91cy4NCj4gDQo+IENjIFNlYmFzdGlhbiBhcyBoZSBpcyB0cnlpbmcgdG8gY2xl
YW51cCB0aGVzZSBraW5kIG9mIHVzZS1jYXNlLCB0byBtYWtlDQo+IGtlcm5lbCBwcmVlbXB0aW9u
IHdvcmsuDQo+IA0KPiANCj4+PiANCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4+Pj4gICAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICAgfQ0KPj4+PiANCj4+Pj4gYnVp
bGQ6DQo+Pj4+IC0gICAgICAgc2tiID0gYnVpbGRfc2tiKHhkcC0+ZGF0YV9oYXJkX3N0YXJ0LCBi
dWZsZW4pOw0KPj4+PiArICAgICAgIHNrYiA9IGJ1aWxkX3NrYl9hcm91bmQoc2tiLCB4ZHAtPmRh
dGFfaGFyZF9zdGFydCwgYnVmbGVuKTsNCj4+Pj4gICAgICAgIGlmICghc2tiKSB7DQo+Pj4+ICsg
ICAgICAgICAgICAgICBrZnJlZV9za2JfcmVhc29uKHNrYiwgU0tCX0RST1BfUkVBU09OX05PTUVN
KTsNCj4+IFRob3VnaCB0byB5b3VyIHBvaW50LCBJIGRvbnQgdGhpbmsgdGhpcyBhY3R1YWxseSBk
b2VzIGFueXRoaW5nIGdpdmVuDQo+PiB0aGF0IGlmIHRoZSBza2Igd2FzIHNvbWVob3cgbnVrZWQg
YXMgcGFydCBvZiBidWlsZF9za2JfYXJvdW5kLCB0aGVyZQ0KPj4gd291bGQgbm90IGJlIGFuIHNr
YiB0byBmcmVlLiBEb2VzbuKAmXQgaHVydCB0aG91Z2gsIGZyb20gYSBzZWxmIGRvY3VtZW50aW5n
DQo+PiBjb2RlIHBlcnNwZWN0aXZlIHRobz8NCj4+Pj4gICAgICAgICAgICAgICAgZGV2X2NvcmVf
c3RhdHNfcnhfZHJvcHBlZF9pbmModHVuLT5kZXYpOw0KPj4+PiAgICAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCj4+Pj4gICAgICAgIH0NCj4+Pj4gQEAgLTI1NjYsOSArMjU3MSwxMSBAQCBz
dGF0aWMgaW50IHR1bl9zZW5kbXNnKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBtc2doZHIg
Km0sIHNpemVfdCB0b3RhbF9sZW4pDQo+Pj4+ICAgICAgICBpZiAobS0+bXNnX2NvbnRyb2xsZW4g
PT0gc2l6ZW9mKHN0cnVjdCB0dW5fbXNnX2N0bCkgJiYNCj4+Pj4gICAgICAgICAgICBjdGwgJiYg
Y3RsLT50eXBlID09IFRVTl9NU0dfUFRSKSB7DQo+Pj4+ICAgICAgICAgICAgICAgIHN0cnVjdCBi
cGZfbmV0X2NvbnRleHQgX19icGZfbmV0X2N0eCwgKmJwZl9uZXRfY3R4Ow0KPj4+PiArICAgICAg
ICAgICAgICAgaW50IGZsdXNoID0gMCwgcXVldWVkID0gMCwgbnVtX3NrYnMgPSAwOw0KPj4+PiAg
ICAgICAgICAgICAgICBzdHJ1Y3QgdHVuX3BhZ2UgdHBhZ2U7DQo+Pj4+ICAgICAgICAgICAgICAg
IGludCBuID0gY3RsLT5udW07DQo+Pj4+IC0gICAgICAgICAgICAgICBpbnQgZmx1c2ggPSAwLCBx
dWV1ZWQgPSAwOw0KPj4+PiArICAgICAgICAgICAgICAgLyogTWF4IHNpemUgb2YgVkhPU1RfTkVU
X0JBVENIICovDQo+Pj4+ICsgICAgICAgICAgICAgICB2b2lkICpza2JzWzY0XTsNCj4+PiANCj4+
PiBJIHRoaW5rIHdlIG5lZWQgc29tZSB0d2Vha3MNCj4+PiANCj4+PiAxKSBUVU4gaXMgZGVjb3Vw
bGVkIGZyb20gdmhvc3QsIHNvIGl0IHNob3VsZCBoYXZlIGl0cyBvd24gdmFsdWUgKGENCj4+PiBt
YWNybyBpcyBiZXR0ZXIpDQo+PiBTdXJlLCBJIGNhbiBtYWtlIGFub3RoZXIgY29uc3RhbnQgdGhh
dCBkb2VzIGEgc2ltaWxhciB0aGluZw0KPj4+IDIpIFByb3ZpZGUgYSB3YXkgdG8gZmFpbCBvciBo
YW5kbGUgdGhlIGNhc2Ugd2hlbiBtb3JlIHRoYW4gNjQNCj4+IFdoYXQgaWYgd2Ugc2ltcGx5IGFz
c2VydCB0aGF0IHRoZSBtYXhpbXVtIGhlcmUgaXMgNjQsIHdoaWNoIEkgdGhpbmsNCj4+IGlzIHdo
YXQgaXQgYWN0dWFsbHkgaXMgaW4gcHJhY3RpY2U/DQo+Pj4gDQo+Pj4+IA0KPj4+PiAgICAgICAg
ICAgICAgICBtZW1zZXQoJnRwYWdlLCAwLCBzaXplb2YodHBhZ2UpKTsNCj4+Pj4gDQo+Pj4+IEBA
IC0yNTc2LDEzICsyNTgzLDI0IEBAIHN0YXRpYyBpbnQgdHVuX3NlbmRtc2coc3RydWN0IHNvY2tl
dCAqc29jaywgc3RydWN0IG1zZ2hkciAqbSwgc2l6ZV90IHRvdGFsX2xlbikNCj4+Pj4gICAgICAg
ICAgICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4+PiAgICAgICAgICAgICAgICBicGZfbmV0X2N0
eCA9IGJwZl9uZXRfY3R4X3NldCgmX19icGZfbmV0X2N0eCk7DQo+Pj4+IA0KPj4+PiAtICAgICAg
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG47IGkrKykgew0KPj4+PiArICAgICAgICAgICAgICAg
bnVtX3NrYnMgPSBuYXBpX3NrYl9jYWNoZV9nZXRfYnVsayhza2JzLCBuKTsNCj4+PiANCj4+PiBJ
dHMgZG9jdW1lbnQgc2FpZDoNCj4+PiANCj4+PiAiIiINCj4+PiAqIE11c3QgYmUgY2FsbGVkICpv
bmx5KiBmcm9tIHRoZSBCSCBjb250ZXh0Lg0KPj4+IOKAnCLigJ0NCj4+IFdl4oCZcmUgaW4gYSBi
aF9kaXNhYmxlIHNlY3Rpb24gaGVyZSwgaXMgdGhhdCBub3QgZ29vZCBlbm91Z2g/DQo+IA0KPiBB
Z2FpbiB0aGlzIGZlZWxzIHZlcnkgdWdseSBhbmQgcHJvbmUgdG8gcGFpbnRpbmcgb3Vyc2VsdmVz
IGludG8gYQ0KPiBjb3JuZXIsIGFzc3VtaW5nIEJILWRpc2FibGVkIHNlY3Rpb25zIGhhdmUgc2Ft
ZSBwcm90ZWN0aW9uIGFzIE5BUEkuDQo+IA0KPiAoVGhlIG5hcGlfc2tiX2NhY2hlX2dldC9wdXQg
ZnVuY3Rpb24gYXJlIG9wZXJhdGluZyBvbiBwZXIgQ1BVIGFycmF5cw0KPiB3aXRob3V0IGFueSBs
b2NraW5nLikNCg0KSGFwcHkgdG8gdGFrZSBzdWdnZXN0aW9ucyBvbiBhbiBhbHRlcm5hdGl2ZSBh
cHByb2FjaC4gDQoNClRob3VnaHRzOg0KMS4gSW5zdGVhZCBvZiBoYXZpbmcgSUZGX05BUEkgYmUg
YW4gb3B0LWluIHRoaW5nLCBjbGVhbiB1cCB0dW4gc28gaXQNCiAgIGlzICphbHdheXMqIE5BUEni
gJlkIDEwMCUgb2YgdGhlIHRpbWU/IE91dHNpZGUgb2YgcGVvcGxlIHdobyBoYXZlDQogICB3aXJl
ZCB0aGlzIHVwIGluIHRoZWlyIGFwcHMgbWFudWFsbHksIG9uIHRoZSB2aXJ0dWFsaXphdGlvbiBz
aWRlDQogICB0aGVyZSBpcyBjdXJyZW50bHkgbm8gc3VwcG9ydCBmcm9tIFFFTVUvTGlidmlydCB0
byBlbmFibGUgSUZGX05BUEkuDQogICBNaWdodCBiZSBhIG5pY2Ugc2ltcGxpZmljYXRpb24vY2xl
YW51cCB0byBqdXN0IOKAnGRvIGl04oCdIGZ1bGwgdGltZT8NCiAgIFRoZW4gd2UgY2FuIHBsYXkg
YWxsIHRoZXNlIHNvcnRzIG9mIGdhbWVzIHVuZGVyIHRoZSBwcm90ZWN0aW9uIG9mDQogICBOQVBJ
Pw0KMi4gKFNvbWUgb3RoZXIgbm9uLWR1YmlvdXMgd2F5IG9mIHByb3RlY3RpbmcgdGhpcywgd2l0
aG91dCByZWZhY3RvcmluZw0KICAgZm9yIGVpdGhlciBjb25kaXRpb25hbCBOQVBJICh5dWNrPykg
b3IgcmVmYWN0b3JpbmcgZm9yIGZ1bGwgdGltZQ0KICAgTkFQST8gVGhpcyB3b3VsZCBiZSBuaWNl
LCBoYXBweSB0byB0YWtlIHRpcHMhDQozLiAuLi4gPw0KDQo=

