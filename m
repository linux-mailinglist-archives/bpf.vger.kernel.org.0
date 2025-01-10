Return-Path: <bpf+bounces-48535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC3A08C38
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74667160E0B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1C209F4A;
	Fri, 10 Jan 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tLN8eRtQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A931F0E40;
	Fri, 10 Jan 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501714; cv=fail; b=qWw1RDlOlW7WyG3KRTIyxh+aGH35qVP1X+bcGuo2CJs3T+lNpyEON7bO1IhkgY38KUNiSu42B9tOaR/kT6H4djs+dQKCZhCC/jfV47irkDbsNldGci3C0I3tEpdJ/2s+rsdD70c9Yq/kcyY3LdXQQLGqcsYXqQpOPrZ+V6TVg0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501714; c=relaxed/simple;
	bh=dRsRk/KmqL6Bib1qCYz/Oc8VuZSZKPNqms+y7o5IdZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQMscJKerRZH9+APG1Su37fm6a2pWMF4mh/DDybcXTo7VeAd3/mk+Atv9etboONfLsyOW6s7caa/+lHHtcxISJD/m1F25DCzOIO++M6Tvm756F081++3p6mtsXLk3z9SijPAxYQXgxiMmhdhh0ozZ8zD2VOvs8hyvsJByjKzCCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tLN8eRtQ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9Y6Mo008187;
	Fri, 10 Jan 2025 01:34:54 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44311d0028-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 01:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmt96muAg8ze6V2Ugn6MVu2FkamjsuzllMNXWtxPuP/V2HREwfhld+yjZG/aH1JOobboOKAoo27SmJmey+7cxw/fwcdUpRzEkxMU2Qk13950z44t1WeDvSRKVnZVXO6tCN6/9JlXu/ymKGaciCXowbt51k0daGoLrv/akYshg/4vn3bzsrWllcgZZe/yj+xNWnw4902ivDVu8i0qsaZON9To7jS9VWa/0sNQrxyJbPrgxmpBdE3pB8ft+35jPx1DrZ+JfgkWcwuG0MAxOi1AnuxMv45ImSYVVcLq7Zb7BXs+5zNOEGqWsw+4/E4iYUC7cqIu2OXHetyr78atzwL9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRsRk/KmqL6Bib1qCYz/Oc8VuZSZKPNqms+y7o5IdZg=;
 b=kZQD/C/ZKPCE/Y8I9yCb8OADFB5eYwAINtyrfKwTnXDHpjQQVe7YXIh6C6w9kbUq93NCVlcR9x/5LDiYjohyzlmpAjspWMyeLKZWluS8ZtSrAyXJMn375G/j+dVQSm3Pg7Hb9kHg5nvbvdo2vabSOhEJXbAkmTPYKSMBpdhnAfRaYZTfEhv7kVz3qStMto+kXQuWr5XGbDaCQlfx87geoaGU0JkLP8n3KB1SbLb+VCyfXXHjBvo9Ln9KBWQle+vtWWBZU45qHTMUZIv6qTAaXQ8YpJG37tiNJPTbwiAOOkgkEwBsT9o1pM8kxFDwjips2Q4PQQrJu3foF1dF+TgmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRsRk/KmqL6Bib1qCYz/Oc8VuZSZKPNqms+y7o5IdZg=;
 b=tLN8eRtQ9zc5YwUTuNKNm7J52Yg+Qsp7dW4kcyWe2PhNtvxEkKZkxJ72liSTVdyFnYXh3KZlASuZEtEzAcOF7jm45eI7lPalKXMH3j00ynTyWf7/HOxWKDSSflmmidW5i+qlXCVTU7VFrROY3WEEHSm/ql9CqDGOxm2m3yZQWxM=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH7PR18MB5356.namprd18.prod.outlook.com (2603:10b6:510:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 09:34:51 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 09:34:51 +0000
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
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 1/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 1/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Index: AQHbYfvbMw/7kkBnd0+FS9IndERlHrMOnZOAgAEkJpA=
Date: Fri, 10 Jan 2025 09:34:51 +0000
Message-ID:
 <SJ0PR18MB5216F3EBB556D691BD665ADCDB1C2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250108183329.2207738-1-sumang@marvell.com>
 <20250108183329.2207738-2-sumang@marvell.com>
 <20250109160851.GJ7706@kernel.org>
In-Reply-To: <20250109160851.GJ7706@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH7PR18MB5356:EE_
x-ms-office365-filtering-correlation-id: 84cd458c-9682-46d4-7c06-08dd315a087c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M01PNTZCT1ErbnZQZ0FkYWxXYmdLTVB3cHBVa1NtTm5xNEx3Z1pXVDRvL3l5?=
 =?utf-8?B?SnloYWR4ZEtzcVB6WHdXei9vcHZRNmQxVytkeVI2KzRsZmJ0M09hQ3RudjQ0?=
 =?utf-8?B?enExVk1rQkMrVFdtWnRjQ2Q2QmtYdjAyZVA1QXR1WXhjbnNNa3hnclE1TG9n?=
 =?utf-8?B?V3Z0akNTQW5vWXFYVXhTbUVIMmFQd0xmdlllVERUNXc0ZG53Mk42SXdOd015?=
 =?utf-8?B?YlRkTE10ZEpidHQreDRxWTRsaXM3eGdFdHZLT1VpcUc3ME52U1ZIaUhjcnkr?=
 =?utf-8?B?cGtPTTBEN2hySmlvTDFyVVJSYlptcEFVU3JkaVNRUnREOEZSYmY0bkpQYlY4?=
 =?utf-8?B?M1VjblQrVWhsSE9hdDRTVlJIU3VINndVdnJEYzkyRUp2U29mMHdydlF0TWJZ?=
 =?utf-8?B?OGZGK1JoK01GcVpKSXMrUE9JS3VQQnZJNlNBNjhSMEpMeWtEc1V2TU04TW5x?=
 =?utf-8?B?TjZTcDl1OWNtWTdjV1dDWVd2YjludTQ0RitMYUVmZmhrY0NTQU5nbkxrNElj?=
 =?utf-8?B?SzM3ekQ4dWc3amxHYmJBZ1BIVkhyTGExUVdyMGhnRjI4YnBTb1BaMGdXODFJ?=
 =?utf-8?B?Ry9IOHNUSHZFS2NJYlNIK3Bic2VIVllFWHN3N01mK0dLWmFldUx0bU1ydkFl?=
 =?utf-8?B?T1lyaFd1am90NUVBazN1V1RqZ1QrZUlLVTlnamxTVUtzL3pnVkorSHMweTNp?=
 =?utf-8?B?aGxZT3o5U1ZIYVVkMmZwOTJtMnNDcVJPa0ZWNmNSNnMwNjFLeDkrRG1tS0tG?=
 =?utf-8?B?eDdkaEFIMTY1T3g5RHdGZElTZFdMZ2MyN1gyeGhRTVo1Yy9Xc0dVdW1nbTdI?=
 =?utf-8?B?eUNLWlBRbmpzYVJ0RExGalBhOURBc3JZTis0SlFHczAzRm9RaWxvNmNHWXJC?=
 =?utf-8?B?K3U2SG5iL1ZGZEJ0QkVsVTVKMzBQTU5tcUFaUm80bTY3QlVqd1ZVS2FBRXNu?=
 =?utf-8?B?R0phNFg5S2I3dVc3NjdpQ0tDb0lpN252Um9nR3EzekxVdStOSk1Zdkh1K3VP?=
 =?utf-8?B?ZGlCZnJXT1N3UlFZVDd4UUJLdVpJM005Yml6TlJwNXpJL2N5Q0E5MGMzTDRP?=
 =?utf-8?B?K1lXcVY3c2w3MGU2cVdiamNETWs3RDdZMHBZRFUrMW9EbFc3VlZmdWdOOTB3?=
 =?utf-8?B?S3doYkUvbGlEMmZ0UnkrUm5GR2NnSVQ5MXBKeE1Gdmh1QTRtMm50NHVOaUNL?=
 =?utf-8?B?TlJsMWt2SzlLYkhKTW1iYmk0ZUdnL2ZXRU43K0ZIMzJla3FvOEVFdzJ4ZmdZ?=
 =?utf-8?B?dXlnYkdNWkdvQktXcWxqd0ducHY4UFE1THpYNkxqRTlON2FTQ09uVEJHZktC?=
 =?utf-8?B?cTlIQU9GbXN6NU0ydFF4K1hyczRWYVpFNEhLMU9OM2YwR3Y5YkIyUmJrdXBm?=
 =?utf-8?B?a0pkTHZkSXNCTHI1RklSZ1h5M2twbzFUM2hpVHRXR1dGbzdqY241YjdPYWs3?=
 =?utf-8?B?UUFVaTFSTnNaMVlPKzF2ME1BcCtwNjRnK2JBZnd1OXBOQi9SN2JFN1dKUUxJ?=
 =?utf-8?B?V1lyeTNZSS92dHVaWW1UQjRod2dTbXI1bUZ2YWtCV3JVS1oyOFVUU3pTNXlX?=
 =?utf-8?B?YUFjQUU4RkM5Wnd2RmhhR2JuVGVKYThMSzdWZTU5Yk1BanN5UExGK1BCRk9y?=
 =?utf-8?B?WUNrSzRlTmxaUXRBbU9CZ01ZWDBmT3ZHTi9zTVR3bHM5UGtDN2RNZUEyMkNx?=
 =?utf-8?B?VU5RV3RDaEVtaVVGV0hqUVprRWFsUDArblBsbTF4Rm92NU1SN1pqV21uQ25p?=
 =?utf-8?B?cnM2MXFZbWtsNzVheXp4eUJFeVRUbXJxV1NWeUROZm9JdU00RWFjZ2swT2tl?=
 =?utf-8?B?YTRmbFMxZ29rUnFSWXAyaEJWL2t2MnBjZ3djVUdGMkp0c2dsN05sQWhHSmlZ?=
 =?utf-8?B?blJDVkRkdi91Q2RxSno3QVFOalVob0piTVVXeUZyNGphOHV0WUFkVG80czFu?=
 =?utf-8?Q?iAatj3I16TkiyecPaSefwPHWL4q4jeNf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTg4Q3AxaGNCMFNsbGNWcUZGYngyWUFYazNNSER4d3M3Zkg0RkFMV3ByWklq?=
 =?utf-8?B?eEZtd01id0lJVjBIMVRwYkw2c0hxcHc2aWQyc0dKYmF3K2UzUU9qaWZTZllk?=
 =?utf-8?B?c2F3cUU4ZVJiSEVVVkRhUnVDWHlCMzlMdWcxcUdCdSsxM2Y2WTJsS3RPYW5F?=
 =?utf-8?B?bkJMcEZod1laSUxiUGwrQUVoQlBUeGo0eVA5bmJqOGdzdi9ML3RhMDNBL21I?=
 =?utf-8?B?WlFRZU9TSWJScEZQQVgzOGNUKzhlYVhYSDdncXB3MWF0b2Z0TXRkQ0FTV29E?=
 =?utf-8?B?SkpBc2gwd0ptMFJtb0l5YXJlclhUUE9ZK3BzbW13dDl1Rkp5aFhCZUo2TVJ4?=
 =?utf-8?B?NDlOL2piU0NhVzZmSnlrTlZaNXN5VytFaTRMRjJhakgxN21nMUdGMHZqZWlW?=
 =?utf-8?B?RDZZRVcvNG9NbkhWVTRxNG4xMFB4L3RmTG1Uc2NTZFZYbWNBK0pESWZtTmQw?=
 =?utf-8?B?MG5VY3lVRlVxVFhESlZLeFFQOE16K0hRZWl2b1hqakVZT0t3Q05VcVhXblNQ?=
 =?utf-8?B?MU4zMlJEd25pcGhIZzk4VjdVendUSVF6SVhUWmU2Z2hCMTlLbjZCNWFERWJm?=
 =?utf-8?B?djZ5S1A3S1UzeFpRRXVXZU5YQmRobWVGalRYMUUrWHBPWVVFa2xCaEVQdHd4?=
 =?utf-8?B?R2ZObVRLTjNGWjN3Zkc0dkRxOXVwRVZKRWNvUWxwQk9PL2FiV0d5dDF3cEUr?=
 =?utf-8?B?cFFMMTgzTjlJT0wxaWFIRGp4VTBVSnQyQXB0UVR5OUduRlUxdnVDVmk5eVR2?=
 =?utf-8?B?elc0QVA5OXc1c0pvTW85Ui9SckJNMFJ2cGZldmNicjV2eWpoNEJKSWZXVHRM?=
 =?utf-8?B?RldMNkZXMTVnRm1rVUpZRml2SGprU0s4b1orcXNPM29lUDYzZDlTTW9tYTFM?=
 =?utf-8?B?N3dqNWJuZ0tCNlBObUM4akhsNklYdStWQmFjaVI1OUU0MVh1azVZV2F6RmdX?=
 =?utf-8?B?S3g5WmRqVEk0Y1U2VVcyQU4wZ2hQUGttbklTczhmOVpqZk5uK0RFS2lKOWpn?=
 =?utf-8?B?dlhVVHZ1RHhJOW92eDVBdXRwcWZIVmdTMkVjOTNBOEJmVzJLQ2JodU43ajRU?=
 =?utf-8?B?NTJydDNJVTZOdTdzWGRlazd4Z0NLQTIwK2MzTEdwSWhOa0xlRTg0VjZTRytL?=
 =?utf-8?B?Nmo2bFhtSFlUQ3dRSjdEZmRlaDZ2ZVltMS81OUQ5aGMrbDd4MTcwZ1RRZUYw?=
 =?utf-8?B?bGRTQWlPN09abDhUd1lEYnZXMUhxNkpaRnBiY3NJY3o0MndCOG9RUUdCRmJr?=
 =?utf-8?B?NzVFL0d5TXdWMkU3S1VNekl3RjFKUzByL3BVbWtOTmJ1bXpiNlc1M2ZXNm1H?=
 =?utf-8?B?MENLUTZCdUNnQ3pyME1KZXd4V1I0a29OMTU5Q2tqZ0dJc2VGMmc1ZUFVaHZq?=
 =?utf-8?B?UGF3aDdLY01MeUFjRHU5UGgzSktETjZYRjIraWIvVE1SU0xmQUw5NkJNL3pX?=
 =?utf-8?B?RVk0VHRmZVk4eG16cUV6bVl0OUNBVUxrdmxPczdxWXp0TlhCQUFlQlRDOTNG?=
 =?utf-8?B?K2FqYVdLbFVIL2FmOSszTEI1eXpKeFo0Z1QwblJJN1plclhncmFIemltNUlz?=
 =?utf-8?B?c25PZmV0UXdPUldwcHhzSVJtSW55UDZZcmR1SVJyN3cyKzl4L2wwRWY4QVQ4?=
 =?utf-8?B?bExJL2RuTUY3dWdtOUV4WU16WCthdnJodTBucnVPQ25uM2x0Sy9jek8yUjF1?=
 =?utf-8?B?dkFRL0pUNFVZeDFMSjR6eWlKa0czelc5elppSER5UTQzTi9UbmtHdVNpK2V2?=
 =?utf-8?B?S2NTeUpEdngxN2pKblFIQXBTenhVWHBiOXAxTmcvRkhIcTRxc0ZldzJsOXpw?=
 =?utf-8?B?UVVRRklEc2lCMGs5TXdwU2R6RE02QXVnQnNENHlhZzhNRm9SVFVTUzlsVytV?=
 =?utf-8?B?WVh0ZUhVS0Q2bTgrV04wa0JjWXZOOTdWZDJQRG0wYUsyWE9qMkZIMmdPTWUr?=
 =?utf-8?B?SVpmYk00SEsrNy9oc1lPTW1QdS9CRVhiV0ZFampObWhOcEVMQ0VMTUhVN0cx?=
 =?utf-8?B?bFVjY1NLNUMxMEk0YTRMV0RYYnloVEE1ZGRXY25yU0U3b2dMTUJwYlJCdHZT?=
 =?utf-8?B?a2phczBSNDFKbGYrU2JlRFVxWFdnZFVrU0R3aGJ2WkgzOHNDWnhOMFB6SzBS?=
 =?utf-8?Q?uqG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cd458c-9682-46d4-7c06-08dd315a087c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 09:34:51.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXRridaLNDEQAxiPlCCGyyQihLPVYnpnSTQNWvAjz64baNrWxru0UEZaLdUgoJmK6jpLW1dGcR9VqdtZm+t7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5356
X-Proofpoint-GUID: Md46qgTk2vhyztSJEQUCIA94_NTRU8cr
X-Proofpoint-ORIG-GUID: Md46qgTk2vhyztSJEQUCIA94_NTRU8cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgU2ltb24sDQoNCj4NCj4+IEBAIC0xMDksNiArMTA5LDExIEBAIHN0YXRpYyB2b2lkIG90eDJf
eGRwX3NuZF9wa3RfaGFuZGxlcihzdHJ1Y3QNCj5vdHgyX25pYyAqcGZ2ZiwNCj4+ICAJb3R4Ml9k
bWFfdW5tYXBfcGFnZShwZnZmLCBzZy0+ZG1hX2FkZHJbMF0sDQo+PiAgCQkJICAgIHNnLT5zaXpl
WzBdLCBETUFfVE9fREVWSUNFKTsNCj4+ICAJcGFnZSA9IHZpcnRfdG9fcGFnZShwaHlzX3RvX3Zp
cnQocGEpKTsNCj4+ICsJaWYgKHBhZ2UtPnBwKSB7DQo+PiArCQlwYWdlX3Bvb2xfcmVjeWNsZV9k
aXJlY3QocGFnZS0+cHAsIHBhZ2UpOw0KPj4gKwkJcmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+PiAg
CXB1dF9wYWdlKHBhZ2UpOw0KPj4gIH0NCj4+DQo+DQo+SGkgU3VtYW4sDQo+DQo+SXQgaXMgaW5j
bHVkZWQgaW5kaXJlY3RseSBpbiB0aGUgZm9sbG93aW5nIHBhdGNoLA0KPlt2MiAyLzZdIG9jdGVv
bnR4Mi1wZjogRG9uJ3QgdW5tYXAgcGFnZSBwb29sIGJ1ZmZlciB1c2VkIGJ5IFhEUCwgYnV0IEkN
Cj5iZWxpZXZlIHlvdSBuZWVkIHRoZSBmb2xsb3dpbmcgaW4gb3JkZXIgZm9yIHRoaXMgdG8gY29t
cGlsZToNCltTdW1hbl0gYWNrDQo+DQo+I2luY2x1ZGUgPG5ldC9wYWdlX3Bvb2wvaGVscGVycy5o
Pg0KPg0KPi4uLg0KPg0KPnB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCg==

