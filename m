Return-Path: <bpf+bounces-75896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FDC9C3D4
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 17:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B7F4E3226
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6328B415;
	Tue,  2 Dec 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="sXCidvMU";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pzvy8ycS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D1279DC3;
	Tue,  2 Dec 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693511; cv=fail; b=hVdL6KLPH/EzGis9BqtODuir7QPL2dCgCW5t/odjiUUP12td8KJZdndayzUACeJSk19Uy/5FRYtST90Kha1w3s08TIfWjr0urfwfhV6Fet9bowIvPNbieE/uwoRoSJ3SlZu1o4naHawPapk2MJk5AcStm4lfuRpkROKDAjAk3/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693511; c=relaxed/simple;
	bh=8P3kNiqq7UouePH9P65HvMAQM2Hjtpen5meSNwDQA5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JkIvSXhVEcqq/bg+szHN92RaVyJ4mRMVgjsolXJ6MnPlhh08kSuT1/76xYwrNGFCEMNCikF0ZVUJtb7H8bA6uMyND35Rj35izUwmGyg3uXdXJu2ph/2Chrwk1oQii4H+hjIzSbcKOFWviUyOEntK3CQfQv08wL4/LqEzpofooKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=sXCidvMU; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=pzvy8ycS; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2EQBFP1715416;
	Tue, 2 Dec 2025 08:38:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=8P3kNiqq7UouePH9P65HvMAQM2Hjtpen5meSNwDQA
	5A=; b=sXCidvMU6SU6xL7ZKKqGQKrgO0Q4ueW1Si421Yw61fyIK+SBBJM7pZniQ
	xRy3C0IvHtP9IiDH06o4DcJwnGnxVjNdqcN0CI5d7J7GgECdN4YMMH6vhYI2My+D
	E8G3G4U2uPT8oY2bLqj7clE44bjT+mTmEcPI+tIdOyY9Rm5jlEeTL7FrZMOYIDSx
	wE9Sqe2PqGpjWSc+rB/cyupWqydLmkBDo7kReRU7CtvkDsePZMmCdU8Qqy5UlQGf
	SSqnv9z6Pk3oR94mxtLPkUGowHl3LILf+wdnjUQaw1GRAbX5J9ecMGhYjz9bpY6Y
	iK1Mo2rz0yjkwHGx0lInlsxUq+U8g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023084.outbound.protection.outlook.com [40.93.196.84])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxshpg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 08:38:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hennDzMK39rJykQ/vQPTudOnL1Rum5D1q81DwtlQ1oTstJb0dfpWvjBGtNNQ/ZI1bH8Q+FFIuxwqdgzCPeX23yckWmHhqos0E0n2W8MItH/6MbpqfX1tM40nXI60rav4NWb2o005I2Oo6SlUSzaWOrKlRVpUtgxd/4gX9VfsyhHH5nhZV9+TXmUyXMSy+Aks5+8qRX3Em1qhqxXaWn3gBCHanfckn1YkvMAQ9KreoIINLVQuqyHnr4mtmpmMQSkQGyOb4YdVGa0r6q+mQ2DFT+EMgmf6RLywSnaYKkGYjqidQGhZ35ziY113y9UbVFfaDCH4roL35mSJHOAV9WnaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P3kNiqq7UouePH9P65HvMAQM2Hjtpen5meSNwDQA5A=;
 b=mGw8Zeq4DrPnjmzNUOeZISPbyRkztcTYW4qhy3l8wTHClmh6f72QEJElMKfx1hyMLgRD3vkZ6Q04w3jrj4FyvfOjwdVLMOG9z9Mk4kt1Mh/sY6YCTv5FUFoahD9GXKXjQB9wDdP9ikVYnljMF8HyRF0rR9gtlaJwLKtxHNoSEsjYMZF6lz34kpvan/FEOL2UBmtXTmjAyvRnzbNmA0lbHnpY3LD38J4mGBlxlqGHFNhN11egS+XW3hTtYwEI69KU7MW0MMq4igmvt0XGsO4OmYB24mocsZEqNTGM1te5oDdWyJkJJETXsj2POopIFlNEMe5oGy88bR5uQthesaAMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P3kNiqq7UouePH9P65HvMAQM2Hjtpen5meSNwDQA5A=;
 b=pzvy8ycSfqLPkaMexO3F5uQv9yfatVOz1Td+uYG7VqYMrx0YMCrvrDBESSJCXeoaSlqjnnneNcu78Tr69QYLKUHHa8LKwMCccW/hzQxroFTO2XQ8QKDpPD4pYs9yZfoeCZui91uXxTsx+qJIFswdPs3julO4hwdw/SiGmj9f+2VJOFjL/nTMiX9F+c7q9zqf16Apc82bY3O4nzYZh+DB+CndL6pC4cz9SmsfMgNyGRZWI9K2eYUMQf92qZLwJklQdIVO75SyH5/Dzf9wgK8AIJ2Ce++uYkDIXQRp8xqXRFyOATU59uGISjv5CYI3WEzgZMtt4/C4Do4V/eQtxHsZuA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA3PR02MB9971.namprd02.prod.outlook.com
 (2603:10b6:806:394::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:38:00 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:38:00 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        "(open list:XDP \\(eXpress Data
 Path\\):Keyword:\\(?:\\b|_\\)xdp\\(?:\\b|_\\))" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/9] tun: optimize SKB allocation with NAPI
 cache
Thread-Topic: [PATCH net-next v2 0/9] tun: optimize SKB allocation with NAPI
 cache
Thread-Index: AQHcXkBFRXfvrjOf9U+bl8xdktzzv7UI/n+AgAWY/oA=
Date: Tue, 2 Dec 2025 16:38:00 +0000
Message-ID: <25B14229-DF73-455D-9FF6-2B9F43238C1A@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <willemdebruijn.kernel.199f9af074377@gmail.com>
In-Reply-To: <willemdebruijn.kernel.199f9af074377@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA3PR02MB9971:EE_
x-ms-office365-filtering-correlation-id: 3f6f7ce5-dd1f-4be0-58f9-08de31c1280f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDZpeGYvME9SQzZjcXBBbzJYdTFsemtzUFBrbzRwU1F6YW5DcnkxeDFvaVpQ?=
 =?utf-8?B?cjNTU2xiaEIxWThmd0E0MnBManhjcDB3cGdOcW11WmN1VmhkM2JUbkpZSDJT?=
 =?utf-8?B?Y0FjdiswV0x3clI5MHYrdDlCWjVpdnZrL1VzQzI4aERJRGxteGNCbVVRejh3?=
 =?utf-8?B?L0xCU2pUdEFWN3FsMm0zS2w0Ukh3R2FTMk16SlIxN0R6eWF6MVEzd016QmYy?=
 =?utf-8?B?RXp3Z3k0a3JXb3lOaFA1VTBhajlNSVYrcUJIc0hiR20zZHgxWnY2WVZlVzhr?=
 =?utf-8?B?THloTG9WY2JEMStiNUI0RTkyWXhqU2xOSlRBamxRUWNSdkRKMjNPMDN2RzA0?=
 =?utf-8?B?MSs2S21mK2IydktoNyszZi9WN3dubzhNYUc2MytEazFYOTVHbnloZkFnRnZ5?=
 =?utf-8?B?K2hJTXpWMUduSEdlSCtjM3JCZnVjQ04vS0RqNEptL2Q0eWN0MmFrSFB1VXRw?=
 =?utf-8?B?NGZqNC9VdEt2SlNBM0JGdUE1cFJUT29KeUxvSkpQK3hGYzJZZnl1MUx3UXpn?=
 =?utf-8?B?N3dDRTlBcHBwbmROOEkrSUowOUx0U080eUhCamdlWDU5SU9VczNIS3haWWNw?=
 =?utf-8?B?cHJSUGpTTHlPaFhIUWdjOGtlay95YnlmZHlrcU1Pd0FNSnRGWnFDSVp0NmlL?=
 =?utf-8?B?eDR4SFFEMFJpL1dUeTFIVlFiT1FNdG9pSkoxSWtPNVY5N0ROV2J3RjN0ZG9C?=
 =?utf-8?B?M0loZXhhOU9YbzNCbFo0TnVRcFk4ZHh4VVVTdGNmYjJ1NklicU5rSEJSdTMy?=
 =?utf-8?B?UHIwbkNka1FlakJyaUxveFdpV3V1SFQrTlMyd1RFRnBQRVdPTEZ5OFBpb28r?=
 =?utf-8?B?QnpBcGhGaElzQUx6cVJRcWEvWVJIdHNKTkJXY2xvU2F3SDI4ZWVBbmZqeENJ?=
 =?utf-8?B?YnBTM3JxMHV2RjVvOFhSbHU3eHhNcm11WlBOWTRjbmo4MVJrNEFuSk9yWmVD?=
 =?utf-8?B?aWgrSzJIcUxKcGgvZzJadmdnWDFxak1XaVZrQ0tuNHZwamVpVk1hd3hNOHNs?=
 =?utf-8?B?blQyVE5iR0dIcGh5eG9vcHAxZWdQYTFJNDhCVTREQmU3c0tJc01TVnYyMmwz?=
 =?utf-8?B?SkhDYU9XTTl0OHlBSS80Zmg4VDdMbHVMUzR0TkF0Zmt0aWhCcUtXbWgrUkhP?=
 =?utf-8?B?U0I4bndhM0hjdG80bmpMNjNZTWVoT2tZUWNlUkhZUDdtSTZVZk41V3FNczlj?=
 =?utf-8?B?NnBMZVo3eDZ6akR1K25JNXpvM1FPcXdHZm1nM1RvRmk1NFN2RTAwcWdOL2xF?=
 =?utf-8?B?VGNvdHdiY2JoYkVDQzZ4dlBITjJ4RVJINWorc2hWR1VaNm1FWDNvLzVEMVVk?=
 =?utf-8?B?Q2F1OU1TcWdaUkNyU2trblJjUC95R055TFNZWktiRHdxWVF5b25SSkdCM2w5?=
 =?utf-8?B?a0MrT2tHYURWeXQvK09JRXlRaGlvb0RnbnhpaUpEQmlqVTAvNmlXeWRyam9N?=
 =?utf-8?B?dDhBdFhRUWt6UHhiZ3lHalNjWTV3QTRRaVFTMlhMR3BmczFwak00SDkvQkJW?=
 =?utf-8?B?cFk1cW1XOFNPeHZSaHZiQUg0cTJ1NkRrdXdjR29OTTN6bjFTS1lFR0Q2MkZI?=
 =?utf-8?B?b2Y0M2c1aWdkOG1HdncvaUptb08vUGN3K1BmNE96QkNYWXdxd2ZzVUtudXRn?=
 =?utf-8?B?ZXBIYWpQcTlPOWV1dHZWS2UrRGlOck9Ec1ZwSmdFcmxQL1hPZ3RzaEthakla?=
 =?utf-8?B?bmVxSXNUSHNEaDlMcWVuelJGWkExTEx6c2NDL0J0YVJGSGYyMWd4elZ0dW9y?=
 =?utf-8?B?ZHFqbTgxTkplMHZKM1Z0RUFZdHFhRGp5ZTM3QkgrQWQ3SXpLQWZra2V3RDg5?=
 =?utf-8?B?b3hSSmJSTUpUN2lvVFNGS1dnUEV2dWxhcXM4ZHRJK1lpbWdDQ0svWS9OTmY1?=
 =?utf-8?B?SVZYYTFOZTZMbFZHWmJ4V1ZYRGVrYkFDQmVNdy96dU9uMWIzNGFTZllyRVZ2?=
 =?utf-8?B?dEIvWWZGTWhqMHJkQzFIUlBxVGpTZHBSdnZKSzZSRDhwT2JBbWRFOXpyekJo?=
 =?utf-8?B?ekZhdGFYNnAxOXB2S2MydEhBN0x2Y0hiMFlvWU9VZG9VeUlVU3QwVU92bG9S?=
 =?utf-8?Q?LA0gu2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFJrSlQyb0ZrRklhS0M1Y3psQUF4R25UZWNxdTh1Mk9WTkdJT2xlY2RrOW01?=
 =?utf-8?B?Vnd2VS8zRWc2Q3dnSEF6dmhaaFhiYTBhNGRmWmcwNnNUajhHZ21MSWNFdHAw?=
 =?utf-8?B?SXpjSFJuOTdDTHhORTc0b0lYRGJsOCtFNmRPR25tTllpc0dDSHBSeHZTbVBN?=
 =?utf-8?B?TENTaWp0cXNDVGZldEhyTlBuNm1La0VMOW1QM0I4dFdwR1d1NmxSc3pJN3Nq?=
 =?utf-8?B?M1hyVStCQmxFZnlVeDdZNGtqRUkwL3l1dnA5eWtZTDQrRHZQR0U3TEJRRGRu?=
 =?utf-8?B?WEpCL3FrOEpRT3pjMkVIL1kzb1R6L1ltNHpqUzNWY1loZUVtamZWOFk5RVNt?=
 =?utf-8?B?UFVZS3JXOXZhang4M0xScTFHWlBUWE9wVzF6bGpoSURKQTdMMVd3MkpvcVd2?=
 =?utf-8?B?cFE0RGcydWNuOEU0Ri90aGcvSTFibkRjWm1GSlhUcUE4NHI0QWVzKytwVEEv?=
 =?utf-8?B?MHBLTDBGNUhySVRUYXNJLyt0cVRMcUQyRDhVYzBxeWp3Ynp4dU4rU3JRbDF3?=
 =?utf-8?B?ZFdLWXo3cE81WUNCUFZxeFFWN3d3UUx5SHBaaENOSTNzb3ByVi9ZR202a1My?=
 =?utf-8?B?ZDhESEVKak5aNU9HMDVDTTRxVFRSS1RLdUErSEMwSE1VU0tiNlB3TmorUkRv?=
 =?utf-8?B?S3JjN0JQME12aEZhT0xkWG4vMER1S2tnVlM5bGR4b0R0bEFoVTdUSTdoeWtz?=
 =?utf-8?B?eGxVL0xsVEtUUCtmN1RxTVViNFJJOGQ4eFNXdjhZWDVlaWxQNHZNSlFPQk5J?=
 =?utf-8?B?MFpLdEpjMzRScGloTDIrU25FcEp0OGduczRaVlZkSkN6YzRRd3NLQWZuWFcx?=
 =?utf-8?B?Z2ZJak51QnQxNjAzRUwxZDgxQWpTL09ycG5nd09vTU1yQkVqZXEvcHM5TXh1?=
 =?utf-8?B?d0M2T0x3MkYyODcrbTRZdWU0TDZLcWQ3WnF2SzJ0Q2FIRFlUYzh2a0p4dVN0?=
 =?utf-8?B?alNzK0RyQ0tuL0lod2kxVVlFZHJ1bHpxc2Y1eUUwakNyQzRIbTVXV1IwRGhR?=
 =?utf-8?B?OTBtejlENHF3Qk9jcDJ5anBTZjZ4MWx3ME1zOS82eW4xVysvR3ByUE85L3Fh?=
 =?utf-8?B?UFVxYzNJU0JxbW9sZy9GYXlUZzVYN1Rqa1QvbEw1NzYrMEUyT0ZYaWlMTWQz?=
 =?utf-8?B?Ym5JV1ZKYlQ4MlFETFJqWVZVNHBYNVpIYmdQU1BXWkhxQXEzYnZoeCtmRDRX?=
 =?utf-8?B?WjhUcEY1cnM3S2IzSHpFSzcxVXpCQ1VzSEkrbDRVR04wVHFua3Judm5aT3E3?=
 =?utf-8?B?N3QzSUpNbkZaSmJMVzdSNUpNNDE1M1JMaFE2eWZtRlM0NTZaaUZEUXhsZThW?=
 =?utf-8?B?dy9EWGU1djE1NVpMOTk5anlqaEs2UDVaK29nMGRQYUZzb3I2dUpaSCtqcUR3?=
 =?utf-8?B?ckppR1F3VEViMHJHWTRxSE9Ud2NaaEtWQ1lhb0RuTTdYZnNCZTgzYWhvVVhY?=
 =?utf-8?B?TUJzTlV4M2x3OHRPWWMvUEdoWTBVS0dWWDJ4YkxJTlBjejd3MlJvTVkvL2tp?=
 =?utf-8?B?d3R6ckNUMmRjVEF5dUdLaVJPZ2dwWHMyV3liUDd3ZVRWNU0zQ1FoR2s5cktl?=
 =?utf-8?B?M1VkQWlndmJTVHRTOEltVXBmRnVCd01xd3BGSDBXQSs2WHpzK0tGMUc2VnJF?=
 =?utf-8?B?Qk9VTFBlTFA5dS9CNEErZnVRTFBwU040UU5uWVMrSzl3NmtNYyt3MCtUT2hs?=
 =?utf-8?B?RnhNTDlhelYrUGU1ZURqcGU5d3lkUzA3MTI3QkdXR1VYbzkzc3krSzA5aTRa?=
 =?utf-8?B?L3RpcThhZW5mdGVPMkwzYm9UbDFMWkp5ZG8xYnJHaTh3OU9PeElBV0NHOS9V?=
 =?utf-8?B?L21GdzFNUWV5MGJtaEh1SUdmcVFBcktaVEtDQnRqaGF6aldSSnV0TktjdkIw?=
 =?utf-8?B?VExQN3dsQ0o1WnpNbWovSGMrcmdzbFFSek85Q3oxM0hVT0FBekUxdDVvQTBE?=
 =?utf-8?B?cHZNRzgzWmgzVFdvRlRva3V3SEVJL3drelJTVHVRTmpsZ1hGY3F1WEVDMjNJ?=
 =?utf-8?B?emVNMmZZTmYyK0ZnWDBRL2srSW10OGRvaFRMQ1pVSlpZMVN1UUdySXhoOGNn?=
 =?utf-8?B?Mjd3VlVxRUhZUWQ1TmlRbXJXdXp4UzJqQUYzRm5vRjMyMnVjUnFIREQxYTRh?=
 =?utf-8?B?aE8yTmlTNU15V0o5MHVPYUMvYlZnWjR3eDdVZHUxYTZiazRFQm1Rd0NsYThI?=
 =?utf-8?B?c1hjV2dhNUx0QjN0blhnRC9pV1VMQk5oem5rTzE0a3RteXJNNFN0WVdEdzhK?=
 =?utf-8?B?Nzc2Slg4eVYzeFNmRE9BVWJIUmFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD888DD9E3F6BE438012933A37121291@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6f7ce5-dd1f-4be0-58f9-08de31c1280f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 16:38:00.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoyJLCj8u+C9h/zwBh4S8q1JF7wCcuxhgKyRUgd3A+9MzjGplUXgnYsd3jQ7uZj1R8JyTpekruQeWiKnb57qnfzveMJEoKMIwrLo89TKq8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9971
X-Proofpoint-ORIG-GUID: FyHZ07CTxVwJwnQaToGjWBdy1YbHrF71
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692f15ed cx=c_pps
 a=V/GvUwJ+4XAyQQCxxnOR+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=l4sPs596PFwKHm7b7Y4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEzMiBTYWx0ZWRfXx3BcUT9cyynN
 7H6E+uUs9xVp6EBeoFIxXGYdpxdqHTCcYWoHB9nBKpRApy6TARQF9Yesp6TJRlXnbRNwmPP2PCo
 arIJHMS+rbaAeB7KIXHl1FSszH5zpCmex6/IjwoMAXdj1zuI+e2di48rsBhMY0sjYTd0XrkJqh6
 5dO6k5dRtTbOcUJ7ffEdh4xWN+Q6eFIGoZAjSlkIB4Qgi54qZ6V8rOJwZ6hMV3PWoQWq4vAhVAC
 OJiSq1Yb6yqzUBS/EShBVWU/jKuc47QRRBCSh9utFkd/6zUl/9w3j2KcAedRzuHlOxLS7e5sHWV
 DiBtvNyMpUy9OX0FP6G/qj0JbjTh/vVOgiKbMMo6yxucYajEaT+54ysjT7+8VUxVyFveA49bytq
 jBnFUrB+53lsbNazTCw1i8F29I/WHg==
X-Proofpoint-GUID: FyHZ07CTxVwJwnQaToGjWBdy1YbHrF71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI4LCAyMDI1LCBhdCAxMDowOOKAr1BNLCBXaWxsZW0gZGUgQnJ1aWpuIDx3
aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
fA0KPiAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4g
Sm9uIEtvaGxlciB3cm90ZToNCj4+IFVzZSB0aGUgcGVyLUNQVSBOQVBJIGNhY2hlIGZvciBTS0Ig
YWxsb2NhdGlvbiBpbiBtb3N0IHBsYWNlcywgYW5kDQo+PiBsZXZlcmFnZSBidWxrIGFsbG9jYXRp
b24gZm9yIHR1bl94ZHBfb25lIHNpbmNlIHRoZSBiYXRjaCBzaXplIGlzIGtub3duDQo+PiBhdCBz
dWJtaXNzaW9uIHRpbWUuIEFkZGl0aW9uYWxseSwgdXRpbGl6ZSBuYXBpX2J1aWxkX3NrYiBhbmQN
Cj4+IG5hcGlfY29uc3VtZV9za2IgdG8gZnVydGhlciBiZW5lZml0IGZyb20gdGhlIE5BUEkgY2Fj
aGUuIFRoaXMgYWxsDQo+PiBpbXByb3ZlcyBlZmZpY2llbmN5IGJ5IHJlZHVjaW5nIGFsbG9jYXRp
b24gb3ZlcmhlYWQuIA0KPj4gDQo+PiBOb3RlOiBUaGlzIHNlcmllcyBkb2VzIG5vdCBhZGRyZXNz
IHRoZSBsYXJnZSBwYXlsb2FkIHBhdGggaW4NCj4+IHR1bl9hbGxvY19za2IsIHdoaWNoIHNwYW5z
IHNvY2suYyBhbmQgc2tidWZmLmMsQSBzZXBhcmF0ZSBzZXJpZXMgd2lsbA0KPj4gaGFuZGxlIHBy
aXZhdGl6aW5nIHRoZSBhbGxvY2F0aW9uIGNvZGUgaW4gdHVuIGFuZCBpbnRlZ3JhdGluZyB0aGUg
TkFQSQ0KPj4gY2FjaGUgZm9yIHRoYXQgcGF0aC4NCj4+IA0KPj4gUmVzdWx0cyB1c2luZyBiYXNp
YyBpcGVyZjMgVURQIHRlc3Q6DQo+PiBUWCBndWVzdDogdGFza3NldCAtYyAyIGlwZXJmMyAtYyBy
eC1pcC1oZXJlIC10IDMwIC1wIDUyMDAgLWIgMCAtdSAtaSAzMA0KPj4gUlggZ3Vlc3Q6IHRhc2tz
ZXQgLWMgMiBpcGVyZjMgLXMgLXAgNTIwMCAtRA0KPj4gDQo+PiAgICAgICAgQml0cmF0ZSAgICAg
ICANCj4+IEJlZm9yZTogNi4wOCBHYml0cy9zZWMNCj4+IEFmdGVyIDogNi4zNiBHYml0cy9zZWMN
Cj4+IA0KPj4gSG93ZXZlciwgdGhlIGJhc2ljIHRlc3QgZG9lc24ndCB0ZWxsIHRoZSB3aG9sZSBz
dG9yeS4gTG9va2luZyBhdCBhDQo+PiBmbGFtZWdyYXBoIGZyb20gYmVmb3JlIGFuZCBhZnRlciwg
bGVzcyBjeWNsZXMgYXJlIHNwZW50IGJvdGggb24gUlgNCj4+IHZob3N0IHRocmVhZCBpbiB0aGUg
Z3Vlc3QtdG8tZ3Vlc3Qgb24gYSBzaW5nbGUgaG9zdCBjYXNlLCBidXQgYWxzbyBsZXNzDQo+PiBj
eWNsZXMgaW4gdGhlIGd1ZXN0LXRvLWd1ZXN0IGNhc2Ugd2hlbiBvbiBzZXBhcmF0ZSBob3N0cywg
YXMgdGhlIGhvc3QNCj4+IE5JQyBoYW5kbGVycyBiZW5lZml0IGZyb20gdGhlc2UgTkFQSS1hbGxv
Y2F0ZWQgU0tCcyAoYW5kIGRlZmVycmVkIGZyZWUpDQo+PiBhcyB3ZWxsLg0KPj4gDQo+PiBTcGVh
a2luZyBvZiBkZWZlcnJlZCBmcmVlLCB2MiBhZGRzIGV4cG9ydGluZyBkZWZlcnJlZCBmcmVlIGZy
b20gbmV0DQo+PiBjb3JlIGFuZCB1c2luZyBpbW1lZGlhdGVseSBwcmlvciBpbiB0dW5fcHV0X3Vz
ZXIuIFRoaXMgbm90IG9ubHkga2VlcHMNCj4+IHRoZSBjYWNoZSBhcyB3YXJtIGFzIHlvdSBjYW4g
Z2V0LCBidXQgYWxzbyBwcmV2ZW50cyBhIFRYIGhlYXZ5IHZob3N0DQo+PiB0aHJlYWQgZnJvbSBn
ZXR0aW5nIElQSSdkIGxpa2UgaXRzIGdvaW5nIG91dCBvZiBzdHlsZS4gVGhpcyBhcHByb2FjaA0K
Pj4gaXMgc2ltaWxhciBpbiBjb25jZXB0IHRvIHdoYXQgaGFwcGVucyBmcm9tIE5BUEkgbG9vcCBp
biBuZXRfcnhfYWN0aW9uLg0KPj4gDQo+PiBJJ3ZlIGFsc28gbWVyZ2VkIHRoaXMgc2VyaWVzIHdp
dGggYSBzbWFsbCBzZXJpZXMgYWJvdXQgY2xlYW5pbmcgdXANCj4+IHBhY2tldCBkcm9wIHN0YXRp
c3RpY3MgYWxvbmcgdGhlIHZhcmlvdXMgZXJyb3IgcGF0aHMgaW4gdHVuLCBhcyBJIHdhbnQNCj4+
IHRvIG1ha2Ugc3VyZSB0aG9zZSBhbGwgZ28gdGhyb3VnaCBrZnJlZV9za2JfcmVhc29uKCksIGFu
ZCB3ZSdkIGhhdmUNCj4+IG1lcmdlIGNvbmZsaWN0cyBzZXBhcmF0aW5nIHRoZSB0d28uIElmIHRo
ZSBtYWludGFpbmVycyB3YW50IHRvIHRha2UNCj4+IHRoZW0gc2VwYXJhdGVseSwgaGFwcHkgdG8g
YnJlYWsgdGhlbSBhcGFydCBpZiBuZWVkZWQuIEl0IGlzIGZhaXJseQ0KPj4gY2xlYW4ga2VlcGlu
ZyB0aGVtIHRvZ2V0aGVyIG90aGVyd2lzZS4NCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgcHJl
ZmVyYWJsZSB0byBzZW5kIHRoZSBjbGVhbnVwIHNlcGFyYXRlbHksIGZpcnN0Lg0KDQpTdXJlLCB3
aWxsIGRvDQoNCj4gV2h5IHdvdWxkIHRoYXQgY2F1c2UgbWVyZ2UgY29uZmxpY3RzPw0KDQpKdXN0
IGZyb20gYSBDSSBwZXJzcGVjdGl2ZSwgaWYgSSBzZW50IHRoZW0gc2VwYXJhdGVseSwgZ3Vlc3Np
bmcgQ0kNCndvdWxkIGJhcmsgYWJvdXQgbWVyZ2UgY29uZmxpY3RzLiANCg0KTm90IGEgcHJvYmxl
bSwgbGV04oCZcyBuYWlsIGRvd24gY2xlYW51cCBwYXJ0cyBhbmQgdGhlbiB3ZSBjYW4gd29ycnkN
CmFib3V0IHBlcmZvcm1hbmNlIHBhcnRzDQoNClRoeCE=

