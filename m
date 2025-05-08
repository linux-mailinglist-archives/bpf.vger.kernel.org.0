Return-Path: <bpf+bounces-57768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9569AAFCD7
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E33F4A40F6
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ADE26F455;
	Thu,  8 May 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2humrHB+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Zj7PMwWC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991B18DB02;
	Thu,  8 May 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714290; cv=fail; b=eh6O5BgnptT9b7usaLupyb1/wgpk5zc3IHUREevKQsijfrD+n0iaBXbVVrIrZSOOPFaPJA6ESi65nzxZ0f7KTca5HPx1VRkn6CyvaaDMOLchK9LYIiZdFY8m/CuXTN2+P6qXgnmzAr72XYyh/0FAz24W8D2yJlbkqJVvFPh+KcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714290; c=relaxed/simple;
	bh=n9Fpem+8hlsbthGdsLDg7X1X3Ypnj/32f+I61YGL6ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bb7R2Evw8XV3GkSV58ZDa+WsoD/6x9lTTeUsh6IkdrCHcNeIzL8NpIMOcDTqUdmEqaBZZdjY4wo2HZjszqll3W9i32oktn7pEtUvUh1DbMqi1Gln/0C+1T67E3vDJvNaxSyd+mZ8cg5Tzv/MJIMvZsEP2LIf6HKNJ+zvGjophhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=2humrHB+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Zj7PMwWC; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Aewvv012542;
	Thu, 8 May 2025 07:24:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=n9Fpem+8hlsbthGdsLDg7X1X3Ypnj/32f+I61YGL6
	ig=; b=2humrHB+pT1L+uhTtBrDqqUtGxdpyyTCZHPzR6EHqwoXPzCD1fgg78o3H
	XT54qPLCHmGYeEqmEGiwn2iYSOaHLd3K06mSN7gMP5x3vZ1sEITMjXBC84NGJk4d
	Gd99ppSz7PYwddL5wiJdHe2hNBcxObrPAj4x4zwVWAynUJe6tS4IoqaS1db0asSk
	/ReUlFqaknNOcOuexHaKKfdSEpcAFVZwaojrUBygeEcgEeJgMW801vxsOfWzY337
	qtpH2/lgiqPubm/alU0f6I21QgB4r1WRActXcw3oiq9uhvVOAElXwGs7eMG7gJ4p
	igbUCZdoVONbLLS/K6swkTTZow+HQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46djpykh0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 07:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAmY0XbSEbDR4NUfyGJtI6Cw8+NZCOm40fnv/WvXRmofCDruKJ9taGreAYlER3LyXUC0vuWW7pT/voHWsADiDi9xpKfopzsb/ZaAHjv36loeXmiwbFtLwCh+JrrUOeGnr5+nkR7WtxOTUiBbYvaidlL6R3WBe76301iRnAIfB8VkdNY3kawjj4AMQ9VhiQABNmQzlAFKTreqK4w5XasLAptu566gRo+LEDU3lUT/y23yxBBlmVUvtCCIYe1BJFiIJhXaZvhQ9kYBiR7K5ehcSe3TkCCbu/ZL8SKN4G6+fKNYQJP/dUQSWCdO34IPYWcmDJipzKBRf1ZEvfbROJlhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Fpem+8hlsbthGdsLDg7X1X3Ypnj/32f+I61YGL6ig=;
 b=KESaWkO8RcayKPKtyOVDwQmB1aVk7QUbyyFMVq9kutlfPR03+IEGE700HrLP4/9LqO+y5PCOpD2/cZzT011JiuTy/sb7J2QFOj3D3aWElD+Bvw7dNaVaWP54NN0fGLyneer+nnQ5xoYdGRMCfMmVOnPEilgFXK61Vjr9E+zbXIhMDGaTt2oprkfFqngiQlUXTFPz74cP/XnMVRg8jer5L4ALNpaeZdBjWvYm8F6zdC/IRgMEZAwa3AMYdnrKCQ5yQEuikNXTLOIBvMUKOQHWidyIT7TpKZENEbo5nsJZMzbmpe4q/B8X17SnWD+nuQXVPZYFdOjeraJiNvCQU7xapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9Fpem+8hlsbthGdsLDg7X1X3Ypnj/32f+I61YGL6ig=;
 b=Zj7PMwWCBsdEgyN+DnFZeGYbuteMtS2K0vIZynp2mOy21x/aqidw9fA2WGTzk0txxqHYoOefCTOONRUNpaxxwPGn4KpY1Lm+IyXtYhiEYgBPdWsLmokhlY4H8qE9UTS/jMxeqrcHgL5YIJ+4jH2Mk2ZxRkAq2x210vtp/dEw0PGxRa589B2sIsohTvIjHVQ7AQ9HjSY+Tf5Kk4wt+e7Sqc8SvDCf7I3RfQ9NPhAtomR7FBo48pMcVe1cEyhTd+xqrkDPaGACIyVjSbHIshV7Xnwhezh5Qj1A1MmcK59vWENWwgB+6XIJ2WUl7ez3a1GI17SH8hCG3C95edwrXidctA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH0PR02MB8779.namprd02.prod.outlook.com
 (2603:10b6:510:f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:24:10 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 14:24:10 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend
	<john.fastabend@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Topic: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Index: AQHbv2eEW0uswKQU00yY881fwUmSW7PHpieAgABkjwCAALEOAIAADRCAgAACCwA=
Date: Thu, 8 May 2025 14:24:10 +0000
Message-ID: <7C311781-F3BA-4AEB-BD17-892A88192016@nutanix.com>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
 <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
 <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
 <962b227f-9673-4050-90b2-334850087487@kernel.org>
In-Reply-To: <962b227f-9673-4050-90b2-334850087487@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|PH0PR02MB8779:EE_
x-ms-office365-filtering-correlation-id: f284e62f-58ac-41c7-016a-08dd8e3c000a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVRyNVRRUkk0aVJtVGhnY1BxSUxSdVppTTdzZVk2TmNzVlBRMWZvQXpid2NP?=
 =?utf-8?B?d2tMbTZHNk5JeE4xOEZLSGxjUkhaRnhmM2l5U3E0ZVVlS2lqUUE4dmpZdWRV?=
 =?utf-8?B?eXZhNVVXSUhnb1BsbWF0WWpmQml2N3pSKzhoWmFpVi9yMS9qaG1GRHdRQlpU?=
 =?utf-8?B?VXEvdFV1b0ZhbW5IYmRFVElwbmgrVDlpdU9wOWdYNlpGRmd1YkJOOWdjcUpZ?=
 =?utf-8?B?a1JyY2xLWldJTWZYVmsyZHFEdGJTZFdLZ3VaNlhmZFY3S2k3WEtmV0NPWEFW?=
 =?utf-8?B?bkJvbnZGelFIaW1WSkloVy91V0lxQU1BNVk2U3E4VHZzSWtqRlVESDdpWnlp?=
 =?utf-8?B?ZEhqQ25QNnNVZ3dIbk8ySTg2YVVRRzdoaGVnUy9obUFPbnpmelpkdW5GWWRM?=
 =?utf-8?B?TFQvY0p5UkEreTVHUDI5TUFLdGZ6VU9CK241UUE5Vy9hWmUyNUtQRW5PK3I3?=
 =?utf-8?B?NExmUDNxM29GSDZlMDdTMUlyb3Y4VFBKeWhGeWRmMVM2N2xoVnE2dFR0RUJD?=
 =?utf-8?B?V28rRnVFYjRuZVp2RnNOS0JlY2kzdGFOdERkRUhTa1dZNUY1MFNvR3pSVkxR?=
 =?utf-8?B?UjFwKzhKa0dpOENzQW55azJodnRic2JlM1RDNFl5c3BBVkZJVlJ1YmhDYWxY?=
 =?utf-8?B?RDRzU0NvbXd4enR2V2t2S1N5c3lmS09LSmdHcWdneVhVSUt2MTZlQ3dkMzlU?=
 =?utf-8?B?VU10djJIRjcwOHdUUTVyMXlPZzIxaW5vd2VMTndSSmhhMmhwQVlwdGVNMjRD?=
 =?utf-8?B?V3VHSjQxR0NWdWJZaXBFTTIxaWhIWGZsdTBBQmJJQTNJZEM0TnpJWE1ESlp4?=
 =?utf-8?B?UDdhcHBlSUxGZ1plclp5TmhoTFU0WnJ0Q2VKV0FaSHVydWUxa0dWc0xCSEZL?=
 =?utf-8?B?QlNBSTVHeG81eHlocjBvT0o5NHBUcytmUkFyNWFOTklGOTdMUUlLclFYOU9O?=
 =?utf-8?B?S3dhaTNjb245L05JZUxWUVFlUUlMT2RuZ0xId1pXTWJVZDJ6VWcvREViQjZI?=
 =?utf-8?B?WDdEMkNiTzlLQ0VxK05NZVU1SEw3b0V4RnU3NEtVMVRWYWlML09zME9UVlRT?=
 =?utf-8?B?SVZjdnM0VGVualZmZ2NjTzFDenFoZVpUb1d0YkYyLzNBTnV0QUlwRzVhTUhq?=
 =?utf-8?B?eG9IclhkQ2RmZnVYQTFEZlY2eGU4Zk91UVFGYzludlVQbjE3UklTWjc1VkEx?=
 =?utf-8?B?d21kQjlBTlpiZFZUUGtidWFHRkM3Y201WHNtdDZwdzVDRnZvdnVsWmh0bFFn?=
 =?utf-8?B?Q0Jpa1ZCeVRXZHpsOTdqRk45cE1FS3RFcEUweVM0MXBTTEFZbVlHT1AvZFlW?=
 =?utf-8?B?TW9YbWtXQlRyUnhkUkFKK3pSK1FnZU1mb3BHOFdTRFZXMWdJejdJb1VvTllN?=
 =?utf-8?B?TU5FVEcrcEJCUDRGdzNXaEFPS09HTFZ3RHZWUWI5OWIzaWkzOUlHYTcwck1u?=
 =?utf-8?B?YW5ZandQaENYWjJYQnRPbjZGZGtESys2bi9XU3J3d2oyZ0JmVmlHLzY3dWQv?=
 =?utf-8?B?eGZMcHlWS2xBU2doMndVWE9nOEhpUitDT3FqNEZJT24xalRIUzJ4RnMrcmNS?=
 =?utf-8?B?R3dYZnhleFZHaDUzeVRPbmhSZS8yeExQRTZ5S2lNYncyc0xkZElxdlJESUxW?=
 =?utf-8?B?VzI0QTlkdWdJWG9xWndHUUhRSm5iQVlzNHJZY2ZIQ05vYnVvdHVyZldGL3FD?=
 =?utf-8?B?ZXhHblVvOVU0NjBzM0lxajRzb1k5WDFRUkJacHNORFhaUlNFb2tYbU5jWlJp?=
 =?utf-8?B?Z1g4Sm1rSHFaTkNaVXM2SzFxVW5jZENjeUVQdU9HbzBhQU5wakowWnd0R2pK?=
 =?utf-8?B?TGh2cVorVGFFeUpkanRFTy9zc2hpalJuNGdxM1F2Y294YUd6QjFHNG9nK1JG?=
 =?utf-8?B?RTkzRTVHaVc2c3hqOVJxQnVXR0lmZmtFOUpNTHViSmoxWDkrYW9xRlRxN2V1?=
 =?utf-8?B?cXI4djFSb1JKTDhwRjlzcHBRdjdSc2Ezak1zeUpBREJPa3ZZcTZ6VjBrSXhF?=
 =?utf-8?B?d3hvQ1B1L1V3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGt0VkR1S1gvamNLb0ZYNmJqeDJPZGhmKzN4VHhHa2xuekJlRm01a3g5Y29O?=
 =?utf-8?B?VmUrTGtYZ21ZV1dpLzI3VnlvTElnMFk2Wk0yNXJ0SzdhK1dGdC9NQUtOYXhP?=
 =?utf-8?B?RHZSWWhWTDUwbEExeG9BRUd6SnVJZEFIeWtmNmxOUmVEbUJuR2c0eDhLTXov?=
 =?utf-8?B?b0hQMU9pbTVLSkwwWFFma3Y2ajlJTlFlZHhaNDZKWUliOVQ0bVNtdHphZGNw?=
 =?utf-8?B?QkJUZWFZcnlXeXNnaWhjR3UzR0VDcEF4Y1NZYjU0SmxwR2QwNDNZRHFJV2dm?=
 =?utf-8?B?Z0lPcnl5aWJCb1lWL0R6T0REdnFEaXBYZ3hOVUI2WUdCYTNhKy9Sd3paSDh2?=
 =?utf-8?B?MHlGU0pKVXlFNVhWSHBlNVl1WWQ0cEk3ZHRtYmEyTUJwRFMrWHlCdk81Q1BW?=
 =?utf-8?B?WHZSbzBYbVZ2YWd6UUVNTUJXbTI1UzNieVg0MVh3K1UyV2FXWDZYYzBJMSs1?=
 =?utf-8?B?Q2ZGWGF6NW1ZYndUV29zcGs3bGJCcytSSWlsTDNEdlI3NmhWdlZ5ZkZZdjVV?=
 =?utf-8?B?Q0xGa3laTkRSUnZlM1F2c1lLbmdzUkxPRFNyUHo3WXh0aTZHSjkwaVd1NEZT?=
 =?utf-8?B?b25QTTk4NVF1TEtIMGFTaFA0aDBVMzBVOTJZalo0Z1ZQUXV6aUw4a2tLNmx2?=
 =?utf-8?B?R052T1V3dTVOM1NiYXoyNCtOb3hSdkNnRFZ3Y2NwaURwcEVUbWU2WDlhaGQ2?=
 =?utf-8?B?TklSM1VyQkd6Mkh1VkVkRXQ2Y0JHRDlWOWZWY2F1bC9PRFpUeitOYys3Snc2?=
 =?utf-8?B?dXpaVHJ5QWVwbVFrcmJDTGk1VVhzanlpUThhZnFKdmJXRU9sQnJaNGdLdnNn?=
 =?utf-8?B?VnlXZE1vNmNJQXA1dWF1dlJnM2FuUkZNcUtwYXdEd2ozQnUzRUg3WnROVGxu?=
 =?utf-8?B?bkJhaGM0UXJrcytRdFo2Y3pWRk5OdUV2L3FjRzFqK21KVkJrUDI0TXRTMGhZ?=
 =?utf-8?B?Z3VmbmRHQkdSOUJGWk5NSUgvR2J1UDJuVENVTzVNc0dCL2xyL1VDNk1Oc05s?=
 =?utf-8?B?bVppUU5wNUhpakZpRUhPSTFEbkhsaW9SOGNJN0dzMElYQTBNcDd4cG5JNUZN?=
 =?utf-8?B?LzlFTkZJN3NMZmFyZ2NUUFJMMHA4WVpZRnlhM2MweitZbm00dVFTMlMzcklN?=
 =?utf-8?B?Z3FSOHVhRm1WZ29jbmU1S3ZPNVVzcG14ek5iaXA5dGwxUTM0NDdMbEY0T1Qz?=
 =?utf-8?B?YmVIV3Vlb2cxTDIxRUVPZWtIcllGYWxHaytvbmQrWWo1VmRpalpIbkY0MjF6?=
 =?utf-8?B?eTZtU0tZbjRRSjFwMlA3VlBjSCtydWpJNGRzeVNQRFp2MDlSQyt4RkpqVmxJ?=
 =?utf-8?B?elFsTE8rOFo1NS9Sbi8xaElIaWRIbUJ5SE0ydXNmNUxGajBmbFBOWjRuK2FX?=
 =?utf-8?B?TGVxTGtqMnMxUmRRTklGOVJJNXpvSDJjSWJ6c1QxcTdSK296RUFrcGo5dTdB?=
 =?utf-8?B?REZHSDdpUStNcDN0K2g2ajJIeURscnQvc0hRTnNxbU1oa3k3UEZpNURZVmxN?=
 =?utf-8?B?K0IvMjMrdkdUU1dtMVU3cTI4bjNJc2FXWnp0d1JBRWZOMXkvYXd2RmlnZUhL?=
 =?utf-8?B?NDR5TFFldWJNNFVPdHdpTHdPV25MZGFhVVFNa3dJVVdveHZ3OVlteGpWQ1l4?=
 =?utf-8?B?ZDQydTdEc1pYWHNzbUV5azBNbU9hTG5MSTFmNFYyOXU2dGJ4MTlvYU9xSUdB?=
 =?utf-8?B?N1FWMW1MekxCRkswQUxueGpvOHB1NDJNdVpQMCtDTE00R290UVlvZXBxM0Fj?=
 =?utf-8?B?TUhJNWEvOHQ3R3oxVml4TE81QmJVOWVxdWdwOUVscFRFelFjMDY3NlpEYkQ4?=
 =?utf-8?B?eGZDbFgyUXV5SWVWeUFWdmZ4QmZwVkhZbTk4U0lXaUFVS2hhTFpMaW01TlJj?=
 =?utf-8?B?WkJJd3BLeDY1dUx4em1tQlI5T0trKzFodkZiaXdLSUVnMmRSTUdURE9EV3RV?=
 =?utf-8?B?d0RlbXNCSktIRmdhQVBEelBVbFpoT1IyZjZWUFp2RGpSSkdWTkNTcHlvdzFn?=
 =?utf-8?B?OHFVNGJoVHVJSEFNalZEaVg4K2FrY1Y2UXljbTlSU3FoYTM4NS8yaFlmcDZa?=
 =?utf-8?B?bDI3MzdBbU11QktwNTlCQ25HWDRUc3phOGpGM0hreTlXS0VrSUxJQWhCb3Bo?=
 =?utf-8?B?SGh1NFRNTzJkTlcyVnlNWTNscFRmdTEzSnpORmkvOHhJWS9LeTZFT0hZb2J2?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72B71549B2537E4A84F9823E5D56FD9A@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f284e62f-58ac-41c7-016a-08dd8e3c000a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:24:10.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OyCvPXVGdsPZAslzQ93ndfOJzLOAhXVuQQFTSzqq29fYyK0ElvfSPcWjirNXda00v2662AEvhYJ/aUjouQp5Z/kfL+InLzaU2d1HBrRYCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8779
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMyBTYWx0ZWRfX9NnRY+FTYx4D cWn9SEVjUy9tERVa8gmZrbqcq0Xq71nB9+yHt5EXbJFSCIAAMdJ/7Q0SEkXrD6qf0S/lPrqCQH/ ipRR/r0vFw05y1xJWUhC3GVNoqJqLarBFpXSSc8+cTBH138U+x5QZXVl6Z8uoF72AUS+BDg9DRH
 G3Pn+8M7bkkYldQjMj5vC7P20WFU22CNH5xcPCRyo92bFZCZO3O8WmZU4lBPyQOIGcktuZvpLT9 lWVWe4g7ZMYdspUOJPKmBvfMI/B2ooxVL9E7hLqN0QVm/9hDH/aRJHEfleIFr9smLrNR11o7ket bQxRh946Gt9QDXacfNlO+iKnGwn+Ys52p9K3WFzraL/RtuynQXaow7SbTdU5nGAJJc0hzXNmO11
 dqk1rc7ZJkOpV9qzgutXxuvrtAlM2of5xsXeNOLbPVwl1AFpO1+p3Z7I1Upr5E/KxMGCJ0UG
X-Proofpoint-GUID: AUlLU89p2DloCulJzy3TYIY4iq1v2v5h
X-Authority-Analysis: v=2.4 cv=NMHV+16g c=1 sm=1 tr=0 ts=681cbe93 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gLXnmbLFrqdvYg8mfwgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AUlLU89p2DloCulJzy3TYIY4iq1v2v5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDgsIDIwMjUsIGF0IDEwOjE24oCvQU0sIEplc3BlciBEYW5nYWFyZCBCcm91
ZXIgPGhhd2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDA4LzA1LzIwMjUg
MTUuMjksIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQo+PiBKb24gS29obGVyIHdyb3RlOg0KPj4+
IA0KPj4+IA0KPj4+PiBPbiBNYXkgNywgMjAyNSwgYXQgNDo1NuKAr1BNLCBXaWxsZW0gZGUgQnJ1
aWpuIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+
IA0KPj4+PiBKb24gS29obGVyIHdyb3RlOg0KPj4+Pj4gVXNlIHhkcF9nZXRfZnJhbWVfbGVuIGhl
bHBlciB0byBlbnN1cmUgeGRwIGZyYW1lIHNpemUgaXMgY2FsY3VsYXRlZA0KPj4+Pj4gY29ycmVj
dGx5IGluIGJvdGggc2luZ2xlIGJ1ZmZlciBhbmQgbXVsdGkgYnVmZmVyIGNvbmZpZ3VyYXRpb25z
Lg0KPj4+PiANCj4+Pj4gTm90IG5lY2Vzc2FyaWx5IG9wcG9zZWQsIGJ1dCBtdWx0aSBidWZmZXIg
aXMgbm90IGFjdHVhbGx5IHBvc3NpYmxlDQo+Pj4+IGluIHRoaXMgY29kZSBwYXRoLCByaWdodD8N
Cj4+Pj4gDQo+Pj4+IHR1bl9wdXRfdXNlcl94ZHAgb25seSBjb3BpZXMgeGRwX2ZyYW1lLT5kYXRh
LCBmb3Igb25lLg0KPj4+PiANCj4+Pj4gRWxzZSB0aGlzIHdvdWxkIGFsc28gYmUgZml4LCBub3Qg
bmV0LW5leHQgbWF0ZXJpYWwuDQo+Pj4gDQo+Pj4gQ29ycmVjdCwgdGhpcyBpcyBhIHByZXAgcGF0
Y2ggZm9yIGZ1dHVyZSBtdWx0aSBidWZmZXIgc3VwcG9ydCwNCj4+PiBJ4oCZbSBub3QgYXdhcmUg
b2YgYW55IHBhdGggdGhhdCBjYW4gY3VycmVudGx5IGRvIHRoYXQgdGhydQ0KPj4+IHRoaXMgY29k
ZS4NCj4+PiANCj4gDQo+IFRoaXMgaXMgYSBnb29kIGV4YW1wbGUgb2YgYSBwZXJmb3JtYW5jZSBw
YXBlci1jdXQsIGZyb20gbXkgcmFudC4NCj4gQWRkaW5nIHhkcF9nZXRfZnJhbWVfbGVuKCkgd2hl
cmUgaXQgaXMgbm90IG5lZWRlZCwgYWRkcyBleHRyYSBjb2RlLA0KPiBpbi1mb3JtIG9mIGFuIGlm
LXN0YXRlbWVudCBhbmQgYSBwb3RlbnRpYWwgdG91Y2hpbmcgb2YgYSBjb2xkZXINCj4gY2FjaGUt
bGluZSBpbiBza2Jfc2hhcmVkX2luZm8gYXJlYS4NCj4gDQo+IA0KPj4+IFRoZSByZWFzb24gZm9y
IHB1cnN1aW5nIG11bHRpLWJ1ZmZlciBpcyB0byBhbGxvdyB2aG9zdC9uZXQNCj4+PiBiYXRjaGlu
ZyB0byB3b3JrIGFnYWluIGZvciBsYXJnZSBwYXlsb2Fkcy4NCj4+IEkgd2FzIG5vdCBhd2FyZSBv
ZiB0aGF0IGNvbnRleHQuIEknZCBhZGQgYSBjb21tZW50IHRvIHRoYXQgaW4gdGhlDQo+PiBjb21t
aXQgbWVzc2FnZSwgYW5kIHNlbmQgaXQgYXMgcGFydCBvZiB0aGF0IHNlcmllcy4NCj4gDQo+IEl0
IG5lZWQgdG8gcGFydCBvZiB0aGF0IHNlcmllcywgYXMgdGhhdCBiYXRjaGluZyBjaGFuZ2Ugc2hv
dWxkIGJyaW5nIGENCj4gbGFyZ2VyIHBlcmZvcm1hbmNlIGJlbmVmaXQgdGhhdCBvdXR3ZWlnaHMg
dGhlIHBhcGVyLWN1dC4NCg0KR290Y2hhLCBtaXNzaW9uIHVuZGVyc3Rvb2QuIFNvcnJ5IGZvciB0
aGUgY29uZnVzaW9uLCBhbmQgdGhhbmsgeW91IGZvcg0KdGFraW5nIHRoZSB0aW1lIHRvIHdhbGsg
bWUgdGhyb3VnaCB0aGF0LCBJIGFwcHJlY2lhdGUgaXQuIEnigJlsbCBjb21lIGJhY2sgdG8NCmxp
c3Qgd2hlbiB0aGUgbGFyZ2VyIHNlcmllcyBpcyByZWFkeSBmb3IgZXllcy4gDQoNCj4gDQo+IEFG
QUlDUiB0aGVyZSBpcyBhbHNvIHNvbWUgZHVhbCBwYWNrZXQgaGFuZGxpbmcgY29kZSBwYXRoIGZv
ciBYRFAgaW4NCj4gdmhvc3RfbmV0L3R1bi4gIEknbSBhbHNvIHdpbGxpbmcgdG8gdGFrZSB0aGUg
cGFwZXItY3V0LCBmb3IgY2xlYW5pbmcNCj4gdGhhdCB1cC4NCj4gDQo+IC0tSmVzcGVyDQoNCldo
ZW4geW91IHNheSBkdWFsIHBhY2tldCBoYW5kbGluZywgd2hhdCBhcmUgeW91IHJlZmVycmluZyB0
byBzcGVjaWZpY2FsbHk/DQoNCg==

