Return-Path: <bpf+bounces-51110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B0A3042E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAD87A35F3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CD1EA7D7;
	Tue, 11 Feb 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VnYteHGD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA726BDB6;
	Tue, 11 Feb 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257665; cv=fail; b=pGdN2M1F318BYak0z63PAK/yOPBdF0hSXno13cr0x7N/GiMocVLqtf634S19eKr4XpTooiQh2LFlETN/b8u5n3vEKCAPQg79okfuN7q0oWu1jfUsbw7cE7J6+TMVp2ZnRSO/jsdiPQ51qYqN7m+Xniu6c7htum8fpphgc2SI9v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257665; c=relaxed/simple;
	bh=wM/G48nzK+uHTM1DbKHIJ4tu56O2Mj+ssNJj97ckHwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WV+KJ/OiM4bDr3mKDGPZGZD8L+OvEzuHLSk1MXNVNIJ4c6XExp/q2zGpMzGkcs/BfU2uCObZ2iZJdMw0IjdIVnbC7+V6RpTPswE7yLBA/vq1g8phlrukbDyx16lPwD7u3UwD9GCV9dizedxOYmKBZ8QBbf/VPVk+wxCTKWeeAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VnYteHGD; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ANSX4j032511;
	Mon, 10 Feb 2025 23:07:08 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qu5ngrag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 23:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ1G2tB/KB6Yz6wx3Q8v2cQ2Ze1UI38Gvd2KdlIXGWg5ftmTGEggQeRbvbhX72k/7+Xay32TOUqc85R1GQmoE7YQnaoW1icZNRsdmej/PBxnmmDAqg8DjttoBkpZy73OYlkfuav4ZXRdEsSV2znFep7h6et3adVim1SIeunNWLBpqx/HfW7F0mq3w+Rj1rxgmqLDk/ndBopdyG4kr1K/DCitKiBvsI12vdgsKliL8dF1A3eAbGPLA1/VopYIzh+87+f9MJkdCDX2ADVXQPzRvFJilKTm4CpW0ipr5BenIGe9H/KMeWzeCOK4Mg6i4v8gN5onP0RX4J4Z3ioiPCGbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM/G48nzK+uHTM1DbKHIJ4tu56O2Mj+ssNJj97ckHwo=;
 b=fgBzjRSCcXWK13BqmWZiRZjkCR7tP/kFa7FxLIROxqNqfn6WLnfnFvtzliIrZCElFpblrTp98Imc7SpLC7K+496fc5Efa2JG7G5CdMAZthwoeShLDPR2mQ+tPquc6Nl4fNBRva67VrBkJmlGVGuTl7JCMq2vvpSOnwt9EuxzxpuDIrllqmZHNdvZeQqQjHbLsCiMLHQKFMXJFJldbVcbhs+yzovI10ivdL0FVpuLadPE5q7F/qNyarZHEe7sVcqEW0NfFupUnMZcImuKevwIwiqutYckj/23C2/nonmaQ1PVHu9Q5leJQKP4MgaJvgAlPxQrTCBEQikwnu7qDXR5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM/G48nzK+uHTM1DbKHIJ4tu56O2Mj+ssNJj97ckHwo=;
 b=VnYteHGDMH9dQNNaSF+e3ctjZsngPoV8aZmeNOQeU7rD44t5eNnRyLP5p+4ejLknsBHBI7HAlJ9XKiW4FcjeY4SyfkzdwBlEHrc68rAOPhX4q8aj8e7SfkM0nBbIsAdZAiz5s+CB5pr1zANZgRGcSOsKv3iCGEWtGBomw78HKKA=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DS7PR18MB6385.namprd18.prod.outlook.com (2603:10b6:8:256::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 07:07:03 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 07:07:02 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com"
	<larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 2/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 2/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Index: AQHbeHROjiAW+GCWI0CYNqqMIYkWFLNAxFoAgADnCsA=
Date: Tue, 11 Feb 2025 07:07:02 +0000
Message-ID:
 <SJ0PR18MB521635EA615322287FB56A37DBFD2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-3-sumang@marvell.com>
 <20250210164128.GG554665@kernel.org>
In-Reply-To: <20250210164128.GG554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DS7PR18MB6385:EE_
x-ms-office365-filtering-correlation-id: 33e8bbb6-cf25-4cee-8a67-08dd4a6aaf76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnJJRHV2Umh5dUJtMWdPYWhYYnhmVTFsYWJQUzdFZkFtek5kempjU0FvVm11?=
 =?utf-8?B?TFpBU3A4RU1wUExseWNtYk5xMXNCS1VaaGFKQ0dlbUxEV3VRZ0tXZlpLalJM?=
 =?utf-8?B?YWdjbVNxemlPS2FDMVgxRHVHTFhnN1p3d1hhZTN5OUh2azk0b0E1bkUvM0c0?=
 =?utf-8?B?YnFFY2M2Und6V0VBc0dZa0dvNTZkVUExc2s2d0hITEJlak9LdzUrSUJFL3lZ?=
 =?utf-8?B?V1pRSnpKTmgwdFFiOTJncFk1QUxBaEVxMEtVUk5MZExCYmJsdzQ5cEV2NmRS?=
 =?utf-8?B?aVhKUVNjM00vc1pYaXVES1Z5bzRwTFdYOU12YjlDanUvOEZxRnp1MkpodU1w?=
 =?utf-8?B?NkNBWlhtNGg3K3F0YXFFajhlZDBQbDIzTmhxUVFucThVcjdUWGtxcUpRU0Rj?=
 =?utf-8?B?dGZUdlZPNVBKMzd5YlhQbVIxZFhNYnc5Qy9UdEprZ0FWNmVodERRQjB5ZlVy?=
 =?utf-8?B?aGorMmNrM0xTNGh6MFYvQUV1TVl2M1ozZWc5Q0pGMTdRWFd3Tm5GeE5qaWpZ?=
 =?utf-8?B?bnNDeUJYNmN6aE11NlcvczJrQUo3TFRETTZxNFBMNWUza0R2RU9QWEpJM1l6?=
 =?utf-8?B?aDZEaEF0amgyaUpBRGJWM1VLMDU0SnpKVDNXTmhoOXNwbVRjY0hadXl6cVlX?=
 =?utf-8?B?U3pDSWEzN3BHaHVmMEd5RTFXZmpBRkh3MmM0K2JCN3QwcWVvQVVCVlBmMHF3?=
 =?utf-8?B?WXlEWjlOeFh5SHR0ZGtJTUgyTEdJOElneUJpTWVSWk9rTW9XR1BrL3Q1NlRN?=
 =?utf-8?B?SkNyL1pRWS9pZ2p6ZFFLRVFReDQwNDdUYU9nMnFuVWxmSG1DYUIwNFBHUnI5?=
 =?utf-8?B?dU5xSnNUSGM3T0VNalp3Q29SRTIxUmsvTVN4ZVVaWG11eHkydGR6d1crZG56?=
 =?utf-8?B?V3pnYVg1ZmlRL3R3Q2RpQVo5empQbU1zOHErRTlTbHZmd2ZCUmxNcmpETkdy?=
 =?utf-8?B?enRQSE5QY1pPN3JwVHo3OUp4NzJvRW1wUC8yUnpFTmUrVzd2TUFEbWl2bDhG?=
 =?utf-8?B?RlhLQjd4dDRUV1gxSWFrTzNRWk1tTDZpdnhKclZtZ1A5QmtRU0V4cHhFbWdu?=
 =?utf-8?B?dEdkdFVLV2J6dGFXZ0Q5bHhva2UzNFdXNGhhaFlpU1pZVGRkWUNSTkp1UjBM?=
 =?utf-8?B?Wm9FQ2lEcjhXNE1VWXgwcnVGWXN6TzVwdng1M0Y1aGwxTCtkQ1dTWit0S281?=
 =?utf-8?B?UEU5SDd0OGpHQUkxU3FMa0d4NWM5UXdUUUNHVHFCbjBQMU1zN2JELzNwbGlJ?=
 =?utf-8?B?bkJFWUlsUG0wOGpsQ04yK2Y5UnhlQ21EaEZnY2NSZDMydTNVR09aajRHbmhJ?=
 =?utf-8?B?UURVSktxNHZXZ1lPNGorWGVRYXhXZDZyV3RpenhNK1dtOUxETDFEdEtWbThI?=
 =?utf-8?B?OTBuYUlCVisvOWVxZko1cWppM1hSWnhMN3JlclZ5bDR5b3ErVnBYMVhROXRT?=
 =?utf-8?B?V08wQUdWOWpVdGFwY2creDhCeWR0cVI4dVVnZWlwTlpvY1NpOEVSSVF0N0Ir?=
 =?utf-8?B?ODZaOGlTcVMrZFRteWdOVDdIT2R4b2hpdWM3Y2NSS3lwSW00OFVvNDZPMVQw?=
 =?utf-8?B?VVRvcFB0eDZ3WlNrelhNanJjUWw4WFVtbzNNek1TTGlkRjJsOVdtMnZjWEor?=
 =?utf-8?B?RU8rSzBicG1ZZWE5MjMxQnRuWkZXWGMvT0NZTXJlL3VUdVkrYTBJck1PbVRR?=
 =?utf-8?B?T3FlMWRxcTZNbDVKaHJiWjJxMFhNUnFucGlLTDlpL1p0czY5UmttZ2hJelR3?=
 =?utf-8?B?NndERzFyVUd6SUhPUk1HUXd3WkdKRFlweXlIbHlhTUdWRHJDdVYybzBXVWpu?=
 =?utf-8?B?Z3hpYTlZa3lIMnFRb01jRXpoVFAzUTFsMGJiWUoyODRNWWNLWUJkdkd6RGM5?=
 =?utf-8?B?SUswbW4yaFAzamVaaSt0Q0VQa0xwUFJMdWpCMWE4M0F3WmpWNWdhdW5aY1FP?=
 =?utf-8?Q?xd0Qy0yxZGOtcph1AftWe1CPYTPfnz/e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVJHY1JrL3lFcEdpT0FLVDRUcjhTSENsTEpNWlZpcW9pRis1UGpySlRQTmxR?=
 =?utf-8?B?NmcydnZmcjd1WW1sdjNNbjdxejhGTlpTa1hCdjV0blF0QnpkOW5IcVNnckVG?=
 =?utf-8?B?TjEwL3c4RG51aDAweGthbjJTWEFHaExsWG9SSzRVMzR1T2RHQXJ3Y29XWXlr?=
 =?utf-8?B?c1pYVTRvaGV0L0lTTVpSRFFFRnpxQ3VPYWtBazJlTWRWOUM2ZUJBZ003a2FJ?=
 =?utf-8?B?c3lXU0xyVmh4M2hzMzA0d3hBcnZaNnNTbndzTWNmdVI1NlNaMmNXaDJ3Mys1?=
 =?utf-8?B?N2Ird0IwZk0reWduK2c0NXdYRzk3ZFdIRUhBOEQzYnVkT0tveE5zVGEwMzRQ?=
 =?utf-8?B?VWU2VmtGcXNIbWE2K0FKbVR5MGRYMk1TV3U1T3h1QU9Od05HZ3J5RHh0L0tT?=
 =?utf-8?B?b05hR2MzMllYcVptQU1BdFNFaWlkNGozaXp1TXgxOUwzS29XV1JweTJXa3hi?=
 =?utf-8?B?Tm0xUWtKZk1URE9TY3JHaGlieGtxY0NZREpidXVTck9KWS9ZZGpTYkRVeHlQ?=
 =?utf-8?B?RGU3QjZ1cHYzUXlaaHR4UUIxU3JOQ2M5UkNuUjgreDFvVWozRlBzOHpEYVhn?=
 =?utf-8?B?d2x0Wm1xZk1lU3V6Qm41NlhyUjRRME1QWXQxYW5UQkN6SU9oRGdPakh6aXdY?=
 =?utf-8?B?aklYRVQyQ2VQN0RpR3pydFh2MHZuWTdhVnFqS3hYTExRQkoyUHRwY3lFM1NS?=
 =?utf-8?B?aTdXa0FLalRhMVN3SWxZaVE2RUJBNG1ybTc3VldYUktoNjVMUW9zbW5aZWg4?=
 =?utf-8?B?QVZtaVdEaXZtUFdyT1JNT3JiRHFseTVQbDFyaHRyazRYRUtxb09ZaHhCQ2Zk?=
 =?utf-8?B?bkdpQi9uR1REUjA3bXMvUUpCWmxheHBtSDFMZGdyNWh6YUx5VzlXY2QwaitQ?=
 =?utf-8?B?Ky9aOU1MNTVhbXJJOGxpQmZJOWhmTVlHSnNpc3F3VzkvbmFhdVY4cGlDUnBS?=
 =?utf-8?B?MUFQT0liZXorbDdnREpMd24wcHVmYWliNzRIVzEvc1VCaVJyVWhyNlc5M2g2?=
 =?utf-8?B?Ny9BbUN3UHljUHhsQ1p2UUE0ZGxuaWpjVXl0QU5BNnNUZSsvUTNxMnlIQTN4?=
 =?utf-8?B?cUFPL0J6ZXd6U2J3QkkrdFhDTDFCbW01c1dtSnQxZDNQbW93NlkzNVNNbjhh?=
 =?utf-8?B?UjlYT3lwSW9RWTArWjl3MGV1N010ZWcwNnlYQU0wY1phMUY3TUtuak16bWpY?=
 =?utf-8?B?aW4zY2Z4WkhGME1telFJMk5BdFBHZFpEQkNWVER6V08reFpJeEZPVmUwQnBI?=
 =?utf-8?B?eVVEUTVPT2w2bzJrT2F4Y1Z5OTB2dzdsL3RSbmQ3YkFlL3dzdEZYdEdweVVu?=
 =?utf-8?B?azEzcTNSS2lTN2V6WFRobTJ6eGx5dVplS3M3SUZjbnoxaE9EL25rWm44RUtL?=
 =?utf-8?B?azFCeWExbWsrTnYzRUpSdmdvVWhjTzQycXkvanRIQ3pnaDNQcWsxM3IxWkh5?=
 =?utf-8?B?akVrbTdmRXFDRHJST01uSjZDdU9PRVVXZFpZcnVYUWpaZkFCQzVsVmkvTnBq?=
 =?utf-8?B?ZjkzR09YcDFXTmF5KzRqekRSMEwvenIwRmhpakM1RUx5R09kaHBhSGJtS1Zu?=
 =?utf-8?B?TityZklFY1pmWENCVnVwdFROTzM5U2Y2bVcvb2FQdEduZzdmaE80WkZoSm5X?=
 =?utf-8?B?NDlNSTR1TlpKd0ZRcmNJc2R5ME9pU1ZnbmRqNGRLbk12ckZKM2lKUHNHMDhp?=
 =?utf-8?B?NWtwYStSWGo2eS94dE9abnlRV3V1UjNlanVoRUpCSVRlazFHMVkvT0ZjTnZH?=
 =?utf-8?B?RDdzd0ZNVFdLM2x3ZW5QSWZRaFJpa3l0UWtVemJ3MXloeVRMc3M4SmhGQzZJ?=
 =?utf-8?B?MEJPMVNSajJCNzE1cjdGdWl6YzI0VE9yTGp5WWQ5S0pSeERWcnpIbzNNcmhx?=
 =?utf-8?B?NU5CeFFzMjNkUVdxN2sxZ0VtdFRMeUxrTU00cWdJSmZzK05LVmlVTkFPUDlF?=
 =?utf-8?B?ZVFaMmlTdkhIVkVIN3ZPUVZIamwwS3hLMjk2ZmtYTHJmUm1XVGE2M2pCbTJH?=
 =?utf-8?B?eGFEa3ErVHp4VTRHSXNMV3pTbm1CWjB4VDNNRTAzR2pKVXdoSE05TmZVYjJv?=
 =?utf-8?B?SjFBUlJMdGlCb2JXY0tVRndKUkZSQWYzbFpHYUxvSnVGbDl0dldudVNHQWVW?=
 =?utf-8?Q?wTclAzHPNGLjE4GMUpCV+nF/w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e8bbb6-cf25-4cee-8a67-08dd4a6aaf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 07:07:02.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0WHB1ITz0jdz6+cBonTCQ5ADDbAlCx+hjgCPxTVRKWOSvpdyYgmLHI02vOXAtaq/8lfL+2VS/txq38iIbbrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR18MB6385
X-Proofpoint-GUID: hStCzEVse__xR6EGxdmaPA5c6VBez4Ed
X-Proofpoint-ORIG-GUID: hStCzEVse__xR6EGxdmaPA5c6VBez4Ed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01

PkhpIFN1bWFuLA0KPg0KPklmIHRoaXMgaXMgYSBidWcgZml4IHRoZW4gaXQgc2hvdWxkIGJlIHRh
cmdldGVkIGF0IG5ldCwgd2hpY2ggaW1wbGllcw0KPnNwbGl0dGluZyBpdCBvdXQgb2YgdGhpcyBw
YXRjaC1zZXQuDQo+DQo+SWYsIG9uIHRoZSBvdGhlciBoYW5kLCBpdCBpcyBub3QgYSBmaXggdGhl
biBpdCBzaG91bGQgbm90IGhhdmUgYSBGaXhlcw0KPnRhZy4NCj5JbiB0aGF0IGNhc2UgeW91IGNh
biBjaXRlIGEgY29tbWl0IHVzaW5nIHRoaXMgc3ludGF4Og0KPg0KPmNvbW1pdCAwNjA1OWExYTlh
NGEgKCJvY3Rlb250eDItcGY6IEFkZCBYRFAgc3VwcG9ydCB0byBuZXRkZXYgUEYiKQ0KPg0KPlVu
bGlrZSBhIEZpeGVzIHRhZyBpdDoNCj4qIFNob3VsZCBiZSBpbiB0aGUgYm9keSBvZiB0aGUgcGF0
Y2ggZGVzY3JpcHRpb24sDQo+ICByYXRoZXIgdGhhbiBwYXJ0IG9mIHRoZSB0YWdzIGF0IHRoZSBi
b3R0b20gb2YgdGhlIHBhdGNoIGRlc2NyaXB0aW9uDQo+KiBNYXkgYmUgbGluZSB3cmFwcGVkDQo+
KiBDYW4gbWUgaW5jbHVkZWQgaW4gYSBzZW50ZW5jZQ0KW1N1bWFuXSBIaSBTaW1vbiwNClRoaXMg
d2FzIHN1Z2dlc3RlZCB0aGUgUGFvbG8gaW4gdjMuIEhlIHN1Z2dlc3RlZCB0aGlzIHRvIHNpbXBs
aWZ5IHRoZSBtZXJnaW5nIHByb2Nlc3MgYnV0IHRvIGFkZCB0aGUgZml4IHRhZy4NCg==

