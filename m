Return-Path: <bpf+bounces-64489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12CB13700
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A421895E85
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDB22D9F7;
	Mon, 28 Jul 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NSMmDuy2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D589478;
	Mon, 28 Jul 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692780; cv=fail; b=t+kNxwc/zBqsSv28FABbIOh8GBYH7TgD9yAfMxO+wuF7PQiVGjx9jAycMPVz8/m/vPYqXIEwRsfNIpsJ7xGAEr8U48GMM/yeiY8UxHP7qIEpAZ73r9OYMj7ODbjI3hio9FT177nxLjMJGld2YjmXGVCqhl9osU3V5V6cUDHd9/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692780; c=relaxed/simple;
	bh=/EYcP4BicpdeCPY9WVqMqQhXpWtKn4e/EPzxoBaiG5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuF4odop7Tx8fH/rHpDRumBNlQzWW18Fv0ndr+TRIjxeSRrl4Y40iw6VLVyWYhawdlVGXbvBU6X7QzAfIIj4h1Tfs5f2ApZZpas4Peo+jjYVMZxuI4KT7hO2c8SsUHmGUFnGnZaBdtV+imfraim/cS5Iy1OQpZ7BH0DHWPgFLqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NSMmDuy2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S3kdqT000482;
	Mon, 28 Jul 2025 01:38:20 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2130.outbound.protection.outlook.com [40.107.212.130])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4861kjrh2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 01:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH92/JaqE2gAnuXpAqv+k9qtzoif8ItnxGka3v1pRuXwTfMhrBaq85UckWxaHCtzIx+rzJbn/ycMVPKf8w8XGVC+0cP41XsbhBFD1qXOpl4TVdQUSOV/7c6FdDCWPFna5zpIo06Gh+QqRt5THPce4UVmGhLY/WcDWxyrc4wh1WBicWdFc4cBJcKFmrdir1GZ8UB23I14fAywPUQygRpY7DNzhaOSCfWN8qfdBga6J5Cs5bUSOQ5CbFZppYpVFsSOyFGa48EEZ7zoKQk543Ffp84fsxGAxIYBmgY00Xxj/17jRRwUgIhOvFrR6t0BSyj39wJDPROZxmbSzDAaz+r/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EYcP4BicpdeCPY9WVqMqQhXpWtKn4e/EPzxoBaiG5k=;
 b=Uun9cpnkt1nBMLv1FoDkar2D+u0jRQv3+8ZHXQtThJMqTLO+PLJZmi1JfM6cUwOx+xivi/Pln3PyobAAmOgtYOuvOQMTrdJITVXtwpuHOxhwbtDdBshdHrYfr7Q442SEVVRS19PG0cmfeYAOAXRPxjzxuE0T9GHgvf35bMxCG6KNMmaP+Omd/qBU1eIOGXR9nwyGyL3xtgsNL/OqKJ6e8oG7ZueGAN23Uf6wzvmL7TMMqyWcKa7mDL2p1vRF2H6kqk9DV/sQHBfMTY+9yptGB1+rDz1oros2fjqKtijFHU9VGcLlWS6D5ZIujakkp8GJNvUPTEqjk9Xk8YvPF5IEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EYcP4BicpdeCPY9WVqMqQhXpWtKn4e/EPzxoBaiG5k=;
 b=NSMmDuy23hSKTm/R73i472dMNm5K386kWqrMbsGBZXDzzrqrq67aGPdOg3u7ZRA/fSX/xcAuD2PZAvslsSuWO7VcY8gnatq+u9cvEGU0XH0fq/Hk/99BmIMvFuOrtunO9N8xa/SWuNuSJBqtErrwxeNsoD09jE+LkEw2AUj5kV4=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH3PPF738CABEAF.namprd18.prod.outlook.com (2603:10b6:518:1::ca5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 28 Jul
 2025 08:38:17 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%3]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 08:38:16 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>, Paolo Abeni <pabeni@redhat.com>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        "sdf@fomichev.me" <sdf@fomichev.me>, Suman Ghosh
	<sumang@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "zzjas98@gmail.com"
	<zzjas98@gmail.com>
Subject: RE: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
 xdp_convert_buff_to_frame()
Thread-Topic: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
 xdp_convert_buff_to_frame()
Thread-Index: AQHb+2lU4wFzGbPA1UmAQDcm5IfxlrQ/BrOQgAAHPVCAAgHdgIADzvoAgAJOLfA=
Date: Mon, 28 Jul 2025 08:38:16 +0000
Message-ID:
 <CH0PR18MB43390F3BFF4500653CB3F14FCD5AA@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250723003243.1245357-1-chenyuan0y@gmail.com>
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
 <CH0PR18MB4339EE7E08DBD7A4F6E3EA72CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
 <77ce8301-38e5-4d13-9b76-0d731f8b6a7e@redhat.com>
 <CALGdzuq5D9=HFBwVDxpJm2MULo-Q4qkQuUfZmEHBrpnNJpefXw@mail.gmail.com>
In-Reply-To:
 <CALGdzuq5D9=HFBwVDxpJm2MULo-Q4qkQuUfZmEHBrpnNJpefXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH3PPF738CABEAF:EE_
x-ms-office365-filtering-correlation-id: 907ac23c-0b5b-4582-9e6b-08ddcdb21944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzFZclpLOHpLV1pmb216UEswL2JHWmhyR0lPZTNHRlp5cUNNOWh1VFhzN1NT?=
 =?utf-8?B?cUVnYkFrWEtMR0Fqb1RpZWpiYSsxUEY5NW9ZUXpnUEUxR0c0eEVBQUVPbjQv?=
 =?utf-8?B?dGk4VlFralRSOEhaQjB2YzdwMmRNSHloVkorMGduK0RGc2JvTU01czdjb3Y2?=
 =?utf-8?B?Z2VzUzdkc0phSUZPZDRXNVhtUXh3TWV1dDZqeldJMkpudUE2bm14bGNOMUty?=
 =?utf-8?B?NG9yT0x1d0NCSWs1QnlXQmNjcUYyV0pmUDdMZzY2YlBGVlNLVWVCK3dHTlBW?=
 =?utf-8?B?Zk8yZjg2a1Q5V0lrNmJJNWRoTW5wMitpMDd5SWdpUjVHNXpjak5nVU1BREhL?=
 =?utf-8?B?VUgzWjFSVEVkRDlxbENKNWszT3RkQUxvemtCSncrQ1lsNUhaZUFGbzJNZEJS?=
 =?utf-8?B?dDA3Nkl2d1dNak40bmhnMU1iZjhjZFlzR1BiMEROMis3VGd2V1ZRaW5xRTFq?=
 =?utf-8?B?TTNMQXI2bkk4dDlNSC8rQVdpK2R4WFRhMC9qcEE3dGVBVkNsTXV4VWpNdEtL?=
 =?utf-8?B?dXVaa3h2MXFWaXFRN2Q3L1l1OVY0RHhvSGdvb1l0ZHBnWTNVNG5lVXlHSHBH?=
 =?utf-8?B?YW9lYzZLVUdLK3Z3cENTd0Ixdi9DZkZHRXI2dk5HSmFOTWEzYUdrYXlvT0pp?=
 =?utf-8?B?eVdTczRqRG9TdWJxYmgyMDlOZkJSajBMN2loOWVsalZJcmVybzl3RlFsV0Jy?=
 =?utf-8?B?NkxnVFd6SGoxS2tZYkY0djhpUmdmN09iVHZoRGNIU1FWVld6bVg4aVZhcmls?=
 =?utf-8?B?ZlZLdGV5Q2dGVUg3ZDZodFdkQkJMRHlyWWJYRDZQcjZQSG1qNG5oTnNNM3dz?=
 =?utf-8?B?UExHbHc2blh3aWNaYS9HUUNidll0ZlpVYnptdnlIK2p0Rmh0VXZ2UWlDQkI4?=
 =?utf-8?B?SVZ4OGdDOTJ0eWc3bVhiOTNMVEtTeGZpTzVzMG9JK1JlMm5TcisySkZkZ0xP?=
 =?utf-8?B?cEZrNDJUbGNZM3NwemRzMHp1YjZVSXpWOHhPUStEUm1UOUR2YmZUWHl4WVNH?=
 =?utf-8?B?RVdqYWxJQ1psQVFiT1A2dHkzZmh1QjJtSUYzdmtPYi9IK1VTM21oSjNIbFEw?=
 =?utf-8?B?a0J0ZVhSYzZydWN2V1R5MHM5amFaZzBLV3NEOHRKWkw1V2JXbWVreVhKQW5u?=
 =?utf-8?B?VzVMQXlwcVB4UHcweG9YdSs2ZFZTbUVtY0MySkdGS29FVDl1b3NJVGJ4bW5Y?=
 =?utf-8?B?NzFUeEx3S0Nrckp1QTdPMm91WWxsVndHY0lObWxFelJHTHFrVjlpOThDSGFE?=
 =?utf-8?B?VzVRSEd3d1FrU2xxcU9JcnZRMVNyN1QyUVdwVUo5OWRjVzRaSjJ1NUZUZFEw?=
 =?utf-8?B?aUIvcyswbC9NM1pCRUhRRlp3VGtvbjRQSjRNZzZibE1wWkZjUkpWWm0vU0Jj?=
 =?utf-8?B?ME9Mb3JQRmlrNHpFSkU3bDZ3SEJIZVRDTkFyYUVzUG9vMXB2RWZQaUVXZU45?=
 =?utf-8?B?MnlwbXNUNUZFOWdsajdGcUY3bHYrRmNiWDFyK2tJL2VzQVg2NlBseFMxNlJX?=
 =?utf-8?B?ZktDVFpjMGFLNDB2S2xGQi9mU1ZXTDVUQ0FlVmhwVXpDNnZzQkNvQjdIMlBP?=
 =?utf-8?B?YXk0TStoQ3dhbUtrUnp2Q3o1SmwvbmVnYjBYSVFvQTFaNmxkZGRrQmx1dFJV?=
 =?utf-8?B?VkEvd0VTeW94U1RrTTFLT2pldWFmNWgwNnAzeGN5ZDJXb0U0UkFDeWtYRjRt?=
 =?utf-8?B?WjZXdksydFhRN2xrSXNBU0FtYkk3L2lsbDJzWWhNUzJEWDA4NGw3bGNJamtH?=
 =?utf-8?B?NFdyN3NkVjlKT3dlSGh3aXg4NUdBTldHTmRWWFFNQmd6ajIzaHJNSUFWWmV1?=
 =?utf-8?B?Tk1CUkRyd1VPaEU2ZHlUakJVMExLTzQvdGFweGVjbDhtV281MVFNRmI3LzdE?=
 =?utf-8?B?Tk1PYXBKMlYzdWNCWldKdWtiaGFlWFFrNGxxNis1b0VkTys4SkZnNHNVdCsx?=
 =?utf-8?B?QUpXcGZSRytaSGJ3VjdaejJtNGxGVnlBQUxHakJGVkNaM3diV2pVRUxwTE5Z?=
 =?utf-8?B?bVk2Q3pOR3pBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0NoQ2RHSmZ2MHFZOFExSkdCcVR3Z0dxT2JCSFJtcGNGNnZKeUFwelNOYjB3?=
 =?utf-8?B?RStPTFVHVXVZK1puZzZZUG04K0hYOUlVNkJvRmdycUdMTzBBd0gxdXNGZ2NT?=
 =?utf-8?B?NldEa01GSUFyL3ZrQjF3aFAwNzdJTHdsUGtlWngvRm9tUWFqMnhIZFRlOUdN?=
 =?utf-8?B?cnVRaDNBb1NqcXhheUl0ZHBZZS94aHM4YWhPaXJUblBldlZSWGxWUDUvQ3ht?=
 =?utf-8?B?T3BMY2ZUZjQ2RTJPYXRyZzlxUVVnOXV4ZDZXc0JGREhnMkJXa0FCS2YrK3hp?=
 =?utf-8?B?ditBM0h5ZUltR056RWN0d0R5WlI1VWlqdDA2OWlYRk1mdm5hdjFZMTdmam15?=
 =?utf-8?B?NEpiaVE1bjVNMFpWbUdXT3dNS1N4V3d6ZHpyazM2ajdBY3pIdFc1K3JpSHB3?=
 =?utf-8?B?dVZ3c3Zxb0VGMjRaLzZCOE1QejFPRnZLTDZ6aFpyQ2M3dzZLVnRGcEY1M3VJ?=
 =?utf-8?B?RW5KWHhrczJmM0xxYmQrL0xMOFJZV3cxSVhuM0xMWXQ0QW5sbWpLSnNtVE1N?=
 =?utf-8?B?N1dxMWNsN0JvaFhmV0VUL24vUmZGcEFxZ0F4N09IT3lFUUJxRm9jeDZUSkJN?=
 =?utf-8?B?S2paSlBQUHlpcE0ybHJJM2ZrOG9JbkozSHFkK1h0VEFzK1d6SHdJWHIweEFs?=
 =?utf-8?B?TWt1dlROVnVBTzMwYll0ZXdoK29JUDNVclIvY0l1UGY1MjRWUjhXOG1iVnMv?=
 =?utf-8?B?cjE4L3hCaVpNaE5Dbit0YURQelZab3ZhWU5jZ0dvNENsRjBybFRBZ0ErVTVn?=
 =?utf-8?B?RjR1WUZ2WW5HWVBUdzVzNU0xcHRZUnFHR0lPblpOQWYxK04vS2pVaUpGcVJ0?=
 =?utf-8?B?WFNOWi9IZndjSlBOdlVoNVVDeWhmNmJjRkVDMmd1eVNMRU96ODV3TTByY1Iv?=
 =?utf-8?B?SWM5T0VaSEZZSGRsL3UyVWNIN0N2bm9mL2s2eXl5MldobTlBTXQyUkpmUGpr?=
 =?utf-8?B?aDdibHlBeHY3TUdtZVRxbzNSRVZEQnhnditQOU1FamtPVUlXN1F5NllEOUg2?=
 =?utf-8?B?TUhpQWVocEUvZjY5Z2ZCd0E1dnFTeWRNbU5HeVVXMmdVMnZzakU1aEhIcHdl?=
 =?utf-8?B?NEZNSXI0NG5vVVZ2cWhPZ0hoaFVsWmdEUCs4bkY0eXFKWG5hMlJBWFduSmNN?=
 =?utf-8?B?MkYxZmp1N29WQTVYYWJGdlRZcFowMU9na04yNmxlN0JEV2NMUGtQTnFvTEx0?=
 =?utf-8?B?ajF6YnBpZHprS2lndU5mcTdiVk9Rc1ExbkR6cmtseS9CamdzcE56TFVPYWxp?=
 =?utf-8?B?NkhydFFuTXYyamtpMGVrZCtkSEZTMGJMM0Y0Wm5oRm1XVjNwTXV1eWQ1T08z?=
 =?utf-8?B?a0QycExkNW5RMy9IWkM1aEVhOHQ3THg3RVIxU3EvTDZIdHRUS09IY3UvSFJ2?=
 =?utf-8?B?T0pYNXBTbzJZQzd0aUc5UTA2cG1MQ0R4dUx2NUNRTlg2b3A2UXB1QTR1akpN?=
 =?utf-8?B?Rlp0OStNRlBVc2trSnN6SzVyWjhqSlp1V2ptejFSLzhOWG1RWjRNYkZjVnor?=
 =?utf-8?B?aHArTlFmYmJPYjE1R1pDbUhoNnZsclJhUnNKWHhWR1RzV0RleWJpbFI0elBL?=
 =?utf-8?B?WFhRMVR1OWk5WVpQKzExQUNieHd6TGEzRjQxK3Z2a1BlMGdFNHE5TDJ1d3RY?=
 =?utf-8?B?NW01cDhRY3NZM2h3MUJScWpGZmVQcmtieUtSQXdmRWREVVRUWWl5RFk3TEFx?=
 =?utf-8?B?QVI2R0VDeWZoUGVTN2ZFZ2JjMkdJdUxqUHZOaURTUDVNcXhXRWhKRjR5T1Nk?=
 =?utf-8?B?YzZrZlJ0NVJPRUlVelBmZ0VXMXRnb04zUmNpYnpmc3NjNFVXbXVyckxtaC9I?=
 =?utf-8?B?RUFYdSsxWUJteUcvRUFIUldZL0lMMGZzOGJqcUorRHEzUVk3VzNLbTZmdG1u?=
 =?utf-8?B?MytRMDNMRk5Qem9JZ3YyWkJaNVpGUVFoeFBTL21LWk5XZk9xQjZjRkJMaytW?=
 =?utf-8?B?NkhidnM3ckdVNjlKcm9QWlJ5NjlCMng1YTNETlRjNnFDdnB2OHB5MjdISVFq?=
 =?utf-8?B?QXJwL0haZ1FMZkgyenZXdVhXY1VYazJKUWI0N2JSQ3hhalhqa2FsQ2ZYa2tC?=
 =?utf-8?B?bzJUckxiSDZ4MHRCaWJ1RVB0ODZsZEFKdlUrNGsyd0EzM1FRbmR3RVdxYkZv?=
 =?utf-8?Q?Dr3I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907ac23c-0b5b-4582-9e6b-08ddcdb21944
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:38:16.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8bG+h8UztjluEw88HCVmwpXql7+MwOS+oZHbpt2bHZRO8LI7orTB1T+5VxKgt+pNylpt3mw3qnYBKtcaXd/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF738CABEAF
X-Authority-Analysis: v=2.4 cv=UYFRSLSN c=1 sm=1 tr=0 ts=688736fb cx=c_pps a=Y0dnjB51ZcnszryFCY8P2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=3aD-yOJHfiOzvsFgfuYA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-ORIG-GUID: EV9aTWzobn5cliMUBuECrPkh6Gq-0P1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2MyBTYWx0ZWRfX1ZC5S0KQzSh+ d71rtGnxg1f3XVDJxfcfmaORcuHNNrrQgWHmXX0nYMfIam32KpAiATF3WXpNzkYALYWoMMSjibN 0xRFpeI79T7aqpYDHz2/Nl/l+4q+MxSZ7cPDjCcMfVtEG4hPIX5gmSHO7wayWk/bUQF894qm9VL
 Dk8Y7l+mcctc4bXj94W5IISf97w3nO4/xEu3m9Sd4Xi+HXs8yCv+SYpsecuoRztwGbuPsH5x13u TFsawODNJ/F90+T6K+sqBsKCcf51FkUvrk8gfM7ynX8nesEbJCQtoKgwSch8m4j9nllB5oYNjX+ 5qg2aGRTHR8Z+mgn0+2lngDFC3H4fsQVTK/E2EoV53tA9rLyF9T794OLZv7J+0ZMHqlz1iNrfi/
 7iZZAuikjkQlQnYjcPHUzwnxr2HXwXvQdSQFGsWfbOMQEzhpTRDYw+jndMTPmFM21O32/LWc
X-Proofpoint-GUID: EV9aTWzobn5cliMUBuECrPkh6Gq-0P1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW55dWFuIFlhbmcgPGNo
ZW55dWFuMHlAZ21haWwuY29tPg0KPlNlbnQ6IFN1bmRheSwgSnVseSAyNywgMjAyNSAxOjUxIEFN
DQo+VG86IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj5DYzogR2VldGhhc293amFu
eWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPjxz
Z291dGhhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YQ0KPjxzYmhhdHRh
QG1hcnZlbGwuY29tPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsgQmhh
cmF0DQo+Qmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsgYW5kcmV3K25ldGRldkBsdW5u
LmNoOw0KPmRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2Vy
bmVsLm9yZzsNCj5hc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2Vy
bmVsLm9yZzsNCj5qb2huLmZhc3RhYmVuZEBnbWFpbC5jb207IHNkZkBmb21pY2hldi5tZTsgU3Vt
YW4gR2hvc2gNCj48c3VtYW5nQG1hcnZlbGwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
YnBmQHZnZXIua2VybmVsLm9yZzsNCj56emphczk4QGdtYWlsLmNvbQ0KPlN1YmplY3Q6IFJlOiBb
RVhURVJOQUxdIFtQQVRDSF0gbmV0OiBvdHgyOiBoYW5kbGUgTlVMTCByZXR1cm5lZCBieQ0KPnhk
cF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoKQ0KPg0KPk9uIFRodSwgSnVsIDI0LCAyMDI1IGF0IDM6
MTHigK9BTSBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IE9u
IDcvMjMvMjUgNTozNiBBTSwgR2VldGhhc293amFueWEgQWt1bGEgd3JvdGU6DQo+PiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPj4gRnJvbTogR2VldGhhc293amFueWEgQWt1bGEN
Cj4+ID4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyMywgMjAyNSA4OjU5IEFNDQo+PiA+PiBUbzog
Q2hlbnl1YW4gWWFuZyA8Y2hlbnl1YW4weUBnbWFpbC5jb20+OyBTdW5pbCBLb3Z2dXJpIEdvdXRo
YW0NCj4+ID4+IDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0
YQ0KPj4gPj4gPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1A
bWFydmVsbC5jb20+Ow0KPj4gPj4gQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNv
bT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4+ID4+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVk
dW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4+ID4+IHBhYmVuaUByZWRoYXQu
Y29tOyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7DQo+PiA+PiBoYXdrQGtl
cm5lbC5vcmc7IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsgc2RmQGZvbWljaGV2Lm1lOyBTdW1h
bg0KPj4gPj4gR2hvc2ggPHN1bWFuZ0BtYXJ2ZWxsLmNvbT4NCj4+ID4+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyB6emphczk4QGdtYWlsLmNvbQ0KPj4g
Pj4gU3ViamVjdDogUkU6IFtFWFRFUk5BTF0gW1BBVENIXSBuZXQ6IG90eDI6IGhhbmRsZSBOVUxM
IHJldHVybmVkIGJ5DQo+PiA+PiB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKCkNCj4+ID4+DQo+
PiA+Pg0KPj4gPj4NCj4+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPj4+IEZy
b206IENoZW55dWFuIFlhbmcgPGNoZW55dWFuMHlAZ21haWwuY29tPg0KPj4gPj4+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAyMywgMjAyNSA2OjAzIEFNDQo+PiA+Pj4gVG86IFN1bmlsIEtvdnZ1cmkg
R291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YQ0KPj4gPj4gQWt1
bGENCj4+ID4+PiA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRh
DQo+PiA+Pj4gPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1A
bWFydmVsbC5jb20+Ow0KPj4gPj4+IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5j
b20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7DQo+PiA+PiBkYXZlbUBkYXZlbWxvZnQubmV0Ow0K
Pj4gPj4+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhh
dC5jb207DQo+PiA+Pj4gYXN0QGtlcm5lbC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBoYXdr
QGtlcm5lbC5vcmc7DQo+PiA+Pj4gam9obi5mYXN0YWJlbmRAZ21haWwuY29tOyBzZGZAZm9taWNo
ZXYubWU7IFN1bWFuIEdob3NoDQo+PiA+Pj4gPHN1bWFuZ0BtYXJ2ZWxsLmNvbT4NCj4+ID4+PiBD
YzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsNCj4+ID4+PiB6
emphczk4QGdtYWlsLmNvbTsgQ2hlbnl1YW4gWWFuZyA8Y2hlbnl1YW4weUBnbWFpbC5jb20+DQo+
PiA+Pj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIG5ldDogb3R4MjogaGFuZGxlIE5VTEwg
cmV0dXJuZWQgYnkNCj4+ID4+PiB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKCkNCj4+ID4+Pg0K
Pj4gPj4+IFRoZSB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKCkgZnVuY3Rpb24gY2FuIHJldHVy
biBOVUxMIHdoZW4NCj4+ID4+PiB0aGVyZSBpcyBpbnN1ZmZpY2llbnQgaGVhZHJvb20gaW4gdGhl
IGJ1ZmZlciB0byBzdG9yZSB0aGUNCj4+ID4+PiB4ZHBfZnJhbWUgc3RydWN0dXJlIG9yIHdoZW4g
dGhlIGRyaXZlciBkaWRuJ3QgcmVzZXJ2ZSBlbm91Z2ggdGFpbHJvb20NCj5mb3Igc2tiX3NoYXJl
ZF9pbmZvLg0KPj4gPj4+DQo+PiA+Pj4gQ3VycmVudGx5LCB0aGUgb3R4MiBkcml2ZXIgZG9lcyBu
b3QgY2hlY2sgZm9yIHRoaXMgTlVMTCByZXR1cm4NCj4+ID4+PiB2YWx1ZSBpbiB0d28gY3JpdGlj
YWwgcGF0aHMgd2l0aGluIG90eDJfeGRwX3Jjdl9wa3RfaGFuZGxlcigpOg0KPj4gPj4+DQo+PiA+
Pj4gMS4gWERQX1RYIGNhc2U6IFBhc3NlcyBwb3RlbnRpYWxseSBOVUxMIHhkcGYgdG8NCj4+ID4+
PiBvdHgyX3hkcF9zcV9hcHBlbmRfcGt0KCkNCj4+ID4+IDIuDQo+PiA+Pj4gWERQX1JFRElSRUNU
IGVycm9yIHBhdGg6IENhbGxzIHhkcF9yZXR1cm5fZnJhbWUoKSB3aXRoIHBvdGVudGlhbGx5DQo+
PiA+Pj4gTlVMTA0KPj4gPj4+DQo+PiA+Pj4gVGhpcyBjYW4gbGVhZCB0byBrZXJuZWwgY3Jhc2hl
cyBkdWUgdG8gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KPj4gPj4+DQo+PiA+Pj4gRml4IGJ5
IGFkZGluZyBwcm9wZXIgTlVMTCBjaGVja3MgaW4gYm90aCBwYXRocy4gRm9yIFhEUF9UWCwgcmV0
dXJuDQo+PiA+Pj4gZmFsc2UgdG8gaW5kaWNhdGUgcGFja2V0IHNob3VsZCBiZSBkcm9wcGVkLiBG
b3IgWERQX1JFRElSRUNUIGVycm9yDQo+PiA+Pj4gcGF0aCwgb25seSBjYWxsDQo+PiA+Pj4geGRw
X3JldHVybl9mcmFtZSgpIGlmIGNvbnZlcnNpb24gc3VjY2VlZGVkLCBvdGhlcndpc2UgbWFudWFs
bHkNCj4+ID4+PiBmcmVlIHRoZSBwYWdlLg0KPj4gPj4+DQo+PiA+Pj4gUGxlYXNlIGNvcnJlY3Qg
bWUgaWYgYW55IGVycm9yIHBhdGggaXMgaW5jb3JyZWN0Lg0KPj4gPj4+DQo+PiA+Pj4gVGhpcyBp
cyBzaW1pbGFyIHRvIHRoZSBjb21taXQgY2MzNjI4ZGNkODUxDQo+PiA+Pj4gKCJ4ZW4tbmV0ZnJv
bnQ6IGhhbmRsZSBOVUxMIHJldHVybmVkIGJ5IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoKSIp
Lg0KPj4gPj4+DQo+PiA+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbnl1YW4gWWFuZyA8Y2hlbnl1YW4w
eUBnbWFpbC5jb20+DQo+PiA+Pj4gRml4ZXM6IDk0YzgwZjc0ODg3MyAoIm9jdGVvbnR4Mi1wZjog
dXNlIHhkcF9yZXR1cm5fZnJhbWUoKSB0byBmcmVlDQo+PiA+Pj4geGRwDQo+PiA+Pj4gYnVmZmVy
cyIpDQo+PiA+Pj4gLS0tDQo+PiA+Pj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b250eDIvbmljL290eDJfdHhyeC5jIHwgOA0KPj4gPj4+ICsrKysrKystDQo+PiA+Pj4gMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gPj4+DQo+PiA+Pj4g
ZGlmZiAtLWdpdA0KPj4gPj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250
eDIvbmljL290eDJfdHhyeC5jDQo+PiA+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+ID4+PiBpbmRleCA5OWFjZTM4MWNjNzguLjBj
NGMwNTBiMTc0YSAxMDA2NDQNCj4+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+ID4+PiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+ID4+PiBAQCAtMTUz
NCw2ICsxNTM0LDkgQEAgc3RhdGljIGJvb2wgb3R4Ml94ZHBfcmN2X3BrdF9oYW5kbGVyKHN0cnVj
dA0KPj4gPj4+IG90eDJfbmljICpwZnZmLA0KPj4gPj4+ICAgICAgICAgICAgIHFpZHggKz0gcGZ2
Zi0+aHcudHhfcXVldWVzOw0KPj4gPj4+ICAgICAgICAgICAgIGNxLT5wb29sX3B0cnMrKzsNCj4+
ID4+PiAgICAgICAgICAgICB4ZHBmID0geGRwX2NvbnZlcnRfYnVmZl90b19mcmFtZSgmeGRwKTsN
Cj4+ID4+PiArICAgICAgICAgICBpZiAodW5saWtlbHkoIXhkcGYpKQ0KPj4gPj4+ICsgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gPj4+ICsNCj4+ID4+PiAgICAgICAgICAgICBy
ZXR1cm4gb3R4Ml94ZHBfc3FfYXBwZW5kX3BrdChwZnZmLCB4ZHBmLA0KPj4gPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNxZS0+c2cuc2VnX2FkZHIsDQo+PiA+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3FlLT5zZy5zZWdf
c2l6ZSwgQEANCj4+ID4+PiAtMTU1OCw3ICsxNTYxLDEwIEBAIHN0YXRpYyBib29sIG90eDJfeGRw
X3Jjdl9wa3RfaGFuZGxlcihzdHJ1Y3QNCj4+ID4+PiBvdHgyX25pYyAqcGZ2ZiwNCj4+ID4+PiAg
ICAgICAgICAgICBvdHgyX2RtYV91bm1hcF9wYWdlKHBmdmYsIGlvdmEsIHBmdmYtPnJic2l6ZSwN
Cj4+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9GUk9NX0RFVklDRSk7
DQo+PiA+Pj4gICAgICAgICAgICAgeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoJnhk
cCk7DQo+PiA+Pj4gLSAgICAgICAgICAgeGRwX3JldHVybl9mcmFtZSh4ZHBmKTsNCj4+ID4+PiAr
ICAgICAgICAgICBpZiAobGlrZWx5KHhkcGYpKQ0KPj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
eGRwX3JldHVybl9mcmFtZSh4ZHBmKTsNCj4+ID4+PiArICAgICAgICAgICBlbHNlDQo+PiA+Pj4g
KyAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdlKTsNCj4+ID4+IFRoYW5rcyBmb3IgdGhl
IGZpeC4gR2l2ZW4gdGhhdCB0aGUgcGFnZSBpcyBhbHJlYWR5IGZyZWVkLCByZXR1cm5pbmcNCj4+
ID4+IHRydWUgaW4gdGhpcyBjYXNlIG1ha2VzIHNlbnNlLg0KPj4gPiBUaGlzIGNoYW5nZSBtaWdo
dCBub3QgYmUgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGUgY3VycmVudCBwYXRjaCwNCj4+ID4gdGhv
dWdoLiBZb3UgY2FuIGVpdGhlciBpbmNsdWRlIGl0IGhlcmUgb3Igd2UgY2FuIHN1Ym1pdCBhIGZv
bGxvdy11cCBwYXRjaA0KPnRvIGFkZHJlc3MgaXQuDQo+Pg0KPj4gSWYgSSByZWFkIGNvcnJlY3Rs
eSwgcmV0dXJuaW5nIGZhbHNlIGFzIHRoZSBjdXJyZW50IHBhdGNoIGlzIGRvaW5nLA0KPj4gd2ls
bCBtYWtlIHRoZSBsYXRlciBjb2RlIGluIG90eDJfcmN2X3BrdF9oYW5kbGVyKCkgdW5jb25kaXRp
b25hbGx5IHVzZQ0KPj4gdGhlIGp1c3QgZnJlZWQgcGFnZS4NCj4+DQo+PiBJIHRoaW5rIHJldHVy
bmluZyB0cnVlIGFmdGVyIHB1dF9wYWdlKCkgaXMgc3RyaWN0bHkgbmVjZXNzYXJ5Lg0KPg0KPlRo
YW5rcyBmb3IgdGhlIHJldmlldyBhbmQgZm9yIGNhdGNoaW5nIHRoYXQgaXNzdWUuIFlvdSdyZSBy
aWdodCwgcmV0dXJuaW5nIGZhbHNlDQo+d291bGQgY2F1c2UgYSB1c2UtYWZ0ZXItZnJlZSwgYXMg
dGhlIGNhbGxlciB3b3VsZCBwcm9jZWVkIHRvIHVzZSB0aGUgYWxyZWFkeQ0KPmZyZWVkIHBhZ2Uu
DQo+DQo+SSd2ZSB1cGRhdGVkIHRoZSBwYXRjaCB0byByZXR1cm4gdHJ1ZSBpbiB0aGUgWERQX1RY
IGZhaWx1cmUgY2FzZS4gSSBhbHNvIGFkanVzdGVkDQpSZXR1cm5pbmcgdHJ1ZSBvbiBYRFBfVFgg
ZmFpbHVyZSByZXF1aXJlcyB0aGUgcGFnZSB0byBiZSBmcmVlZC4gT3RoZXJ3aXNlLCBpdCBzaG91
bGQgDQpyZXR1cm4gZmFsc2Ugc28gdGhlIHBhY2tldCBjYW4gYmUgaGFuZGxlZCBieSBvdHgyX3Jj
dl9wa3RfaGFuZGxlci4NCg0KPnRoZSBYRFBfUkVESVJFQ1QgZXJyb3IgcGF0aCB0byBkbyB0aGUg
c2FtZSBhZnRlciBjYWxsaW5nIHB1dF9wYWdlKCksDQo+cHJldmVudGluZyBhIGZhbGwtdGhyb3Vn
aC4NCj4NCj5Eb2VzIHRoZSB1cGRhdGVkIHBhdGNoIGJlbG93IGxvb2sgY29ycmVjdD8gSWYgc28s
IEknbGwgc2VuZCBvdXQgYSBmb3JtYWwgdjIuDQo+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyB8IDEwICsrKysrKysrKy0NCj4g
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90
eHJ4LmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgy
X3R4cnguYw0KPmluZGV4IDk5YWNlMzgxY2M3OC4uNGUxYjlhM2Y2ZTUxIDEwMDY0NA0KPi0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0K
PisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4
cnguYw0KPkBAIC0xNTM0LDYgKzE1MzQsOSBAQCBzdGF0aWMgYm9vbCBvdHgyX3hkcF9yY3ZfcGt0
X2hhbmRsZXIoc3RydWN0DQo+b3R4Ml9uaWMgKnBmdmYsDQo+ICBxaWR4ICs9IHBmdmYtPmh3LnR4
X3F1ZXVlczsNCj4gIGNxLT5wb29sX3B0cnMrKzsNCj4gIHhkcGYgPSB4ZHBfY29udmVydF9idWZm
X3RvX2ZyYW1lKCZ4ZHApOw0KPisgaWYgKHVubGlrZWx5KCF4ZHBmKSkNCj4rIHJldHVybiB0cnVl
Ow0KPisNCj4gIHJldHVybiBvdHgyX3hkcF9zcV9hcHBlbmRfcGt0KHBmdmYsIHhkcGYsDQo+ICAg
ICAgICBjcWUtPnNnLnNlZ19hZGRyLA0KPiAgICAgICAgY3FlLT5zZy5zZWdfc2l6ZSwNCj5AQCAt
MTU1OCw3ICsxNTYxLDEyIEBAIHN0YXRpYyBib29sIG90eDJfeGRwX3Jjdl9wa3RfaGFuZGxlcihz
dHJ1Y3QNCj5vdHgyX25pYyAqcGZ2ZiwNCj4gIG90eDJfZG1hX3VubWFwX3BhZ2UocGZ2ZiwgaW92
YSwgcGZ2Zi0+cmJzaXplLA0KPiAgICAgIERNQV9GUk9NX0RFVklDRSk7DQo+ICB4ZHBmID0geGRw
X2NvbnZlcnRfYnVmZl90b19mcmFtZSgmeGRwKTsNCj4tIHhkcF9yZXR1cm5fZnJhbWUoeGRwZik7
DQo+KyBpZiAobGlrZWx5KHhkcGYpKSB7DQo+KyB4ZHBfcmV0dXJuX2ZyYW1lKHhkcGYpOw0KPisg
fSBlbHNlIHsNCj4rIHB1dF9wYWdlKHBhZ2UpOw0KPisgcmV0dXJuIHRydWU7DQo+KyB9DQo+ICBi
cmVhazsNCj4gIGRlZmF1bHQ6DQo+ICBicGZfd2Fybl9pbnZhbGlkX3hkcF9hY3Rpb24ocGZ2Zi0+
bmV0ZGV2LCBwcm9nLCBhY3QpOw0KPi0tLQ0KPg0KPg0KPj4gL1ANCj4+DQo=

