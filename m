Return-Path: <bpf+bounces-57102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0ACAA5936
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9191C06EDA
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BE1EB1AF;
	Thu,  1 May 2025 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vjNrB+M1";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UPnR7sit"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C43211C;
	Thu,  1 May 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746061284; cv=fail; b=D6WP6/p1k93FIfSG5UgoUO89X4+52XDX+SHV5hVQHxzra/R+DwWPfeIwWHom8Zg0lD03oVEcxX/OS1Gwo+XHSRQf+3303LgxW74o6pijSdV8fMNYs1GCHl9C1EaMx//qmyqr65hHfjjhA/F10EPt6t6E3oRNVRpKVSonKNfCYqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746061284; c=relaxed/simple;
	bh=AO93dyfjtUzCtHVF78ml841QgcMnv3MvCK/u8ykw0/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YD4tOd5O0r/6B+ptM80YKzQEa/whlNcE+xD3Q69yL6pK9eZhp7AFwDEOV7IPZDmeR2Ewa5mqGiBooovRwE9u5uGs106xrSTzcOpGdhpS4O9BckUQUcl2A/9gMYLeOVNc9toN9PyMUtmkXALQWWVaqw4S2e/CWH0CU9bCPVQOnFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vjNrB+M1; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UPnR7sit; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFfRq1009541;
	Wed, 30 Apr 2025 18:00:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=AO93dyfjtUzCtHVF78ml841QgcMnv3MvCK/u8ykw0
	/0=; b=vjNrB+M1nZGzJPHoe/Nd6EkEleBgA00pxPYGNaGlJ7ckPR+uSnUwQ/CTI
	Pw7Cd6XZCX+kFn+DSfvdxNGCl4/CQn9S+zxE9YD37IFG27zL5Z+PhWChUWc2Fzc7
	h/eNjO/D7frf8LOUmKyqLr6MAQfNvdCZREsOuoLrDlMGHuBS53QGqoiJOXbjC1Dd
	wmSP5NuO+iTD10sje8SML5ZixslJiYvVS+yDlbgTf+s+frcTR8Y0UrxssgSBOpwh
	NDbuy+3PmkQ93mkp13SjRKUxPnUHYYYfR85xtrHLooaCcWCrtPS9Yw1HmljIXfn6
	zR2+lUqYyPZ/AE3KAaK3/9UU/qeHQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468w182q9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 18:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+OoVmcc/InFSIM85UFDELiPTBWOsPGRcTSJY4AWCIJ4d4ilFfBik5PV8GXWfHE3FRinNJObJPi0lFS7O148Bq1BrUhTXwEijtx5PStRBikZ9usC4Eua3XS8CKS0qMFHwY+rmtJVY0KDv8FYJTDrI0NpFpS5Ac8Kfmn6Zx1PwMLy50rrgHARsJnTQy4Ks7keDKilnWh4AdRWggKMdBvWebo4eUDrLv9LJo09O6ImlAmaL1EqT7g7VvVsSXo2VqXklBTfvDUgv2nFuwJuAeqGkVZFByR+9d5O3NJYn4mjQ8VvSbuJo4TYYRMxaau0GTkGkR3fWwO/9LSgg17GuHGSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO93dyfjtUzCtHVF78ml841QgcMnv3MvCK/u8ykw0/0=;
 b=cJvW5NURyNlpK+DVYF5oKLJ0cXX9noci2sIbBDNr4f+Vo7FHgiE9GMuUeT9/ndjWmfM6JrbO1VBtWMfj14DHpk7iQpc4kj4dXnWedEFZ25l95noWqw4Nv0+owgl5+YHoBeqP38L4KnwGRwe3InLDpdzYsgcr82cwYrWk5ISqw+s5hnYCWMxnsonNpX6JM3yQ4iKySGp7n2ctIDANMoO7pG/UUk+hZaQGMpAYOHafJ1aER+InMb/uZ9BH7bf3YnNcgZtbPlbpPUG8Z9/FoA8R5zLmQVtc+OX1oWXiAH7RNnzAe0zTN1JEXfUiPPOm3zApWH4zgSean8+t/l2t/Dc/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO93dyfjtUzCtHVF78ml841QgcMnv3MvCK/u8ykw0/0=;
 b=UPnR7sitqIzmHRSoC4iZs8QGb0Tta+kfiRhHxrTnoyfzcPzJlqKtmDh0+6WAc0BrBlPPBK1n9oe6oaiJ8ZXwBc59bTCwhacbx8iSCtq/C2F2wWDatG0yf8V4Ns0YL+WtaMFw4fTrqr3pEuexRNlyx1CQaH1JUj3zC4a3AaSj1S5kRSs7ZMwUoA6KK6Vwpk1qxm4QFVcdxR4yqOQouvu0O/50TobxaWxASTJm+8gwTHMHBYRYCuoSIvElV7A26pF3XfstMoJCmuxpouM1EiYVYUlLqEYC8JX8B09ASnxk/S71UdKpdP8cl+zcMLx0pb3MBpVv4HZHiJZZM6vWmsh8zw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SA1PR02MB8526.namprd02.prod.outlook.com
 (2603:10b6:806:1f9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 01:00:51 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 01:00:50 +0000
From: Jon Kohler <jon@nutanix.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
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
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon
 Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Topic: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Index: AQHbugfXMi2+AuBiuUeGEjm0tDyzm7O8tC4AgABArAA=
Date: Thu, 1 May 2025 01:00:50 +0000
Message-ID: <32FB9CF5-E5BB-4912-B76D-53971C6B6F98@nutanix.com>
References: <20250430201120.1794658-1-jon@nutanix.com>
 <aBKReJUy2Z-JQwr4@mini-arch>
In-Reply-To: <aBKReJUy2Z-JQwr4@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SA1PR02MB8526:EE_
x-ms-office365-filtering-correlation-id: e1db3b57-835b-4f6d-eefd-08dd884b9dce
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3V6ZTNMOVFKSkZTSEhtbkhLdlJvTXFVcWMwaEw4dnlmQkNxYXJ0VFJnUkMw?=
 =?utf-8?B?cEVMd0FNOU1MQzlkQkh4SnV4MWZvWS9rdGd5cE1abWpSZHg3eXNFZVl6cG04?=
 =?utf-8?B?RDdrY0IraGVCdGJaMnNONGZlVmRmNWpFK01jcEFiWlhucTBRaUxKejNhZlRh?=
 =?utf-8?B?dExwbUhjSmZ1YlVad29wRDVlbFVFTStwN29GRmIzR1lXTzYvckdOcjYwbmMv?=
 =?utf-8?B?WDFTR0tiL04vZXF5VmEvTHgrMVZvT1lxb1dDd1VqN1JIN2Zlbmp6NWVXdUVj?=
 =?utf-8?B?amR5cnA3U2lJbGRLTEw0Y3hCcjBCdlNiandEckxJaWdpOFBrRXF3Q2hRakQ1?=
 =?utf-8?B?ZTY1aExkTG5RRDlnTThNYVhnZjBpNllsZ2F0LzVrWUdVQ1NEdlVRUi82VHZI?=
 =?utf-8?B?UVluRThkMENlL1ZuckkySkx2TEU1Ky9oRjFIcDIycEZZTDhlSzNOTGZiRnds?=
 =?utf-8?B?bHB4aExjenpTUk9LanVoL05PSkZsL1VRQklzZGcrU1BUWVhNUkhyYU5LSVpM?=
 =?utf-8?B?YmRWUitvVlBySFU1UDJnNHh1OWg1STFZRUZNSzI2aG5PR1JzNDBPeDFvemd3?=
 =?utf-8?B?ZGpuZmx6bHJFK2s5TWJsY3Y0Z0lUQzR5NnQ3SGNtZzlEV2RLU2JHMkRHWjhN?=
 =?utf-8?B?bjlMZ3VyQ1VTdG9XcTJqRjNFVzVrRFpDZ0hIMUs3cjRnWXBkWmdFYm96MFd3?=
 =?utf-8?B?YlRwQno4QzJlaDdKWmsvU2xTSHBCZ2JhbkcxVmJwQ095TzRrNytBSnRjNWFJ?=
 =?utf-8?B?bFhzYjE4WG9xRkRFYmNjaGNKOFg3VXRqdys2eDF4bnpDeDNPVnMzNUNQMDd3?=
 =?utf-8?B?dUs3UFdrd2gwVVQzTlVmc3JPaE1DU1NEWURCdnBLTjZZdEZDZk1Xa2NpVHNw?=
 =?utf-8?B?S1hMRUd3THhCcDNHRnVWcHFnOEkyY0xlVkdITXBQRDBPRzZ3KzZlSkF6c294?=
 =?utf-8?B?dXV6Yk9UaUh4WUNkeU56WnVFNUVOQzBycmZQeEg5aTNjU05YbVVheG42SlVQ?=
 =?utf-8?B?Nm5aWWQ2dnRyU3VhWkNSSlVoTEpBb2lnTURreEdDYUt2ZlpEZit0T0lNWHQ1?=
 =?utf-8?B?TFN4OUpvTUZSamNZT05RSENKc2pYTEFkZStiT0V3TkJ2eEFlRHRacnJCc29M?=
 =?utf-8?B?U1hsTHJUaWVaTnk2RnhJc0lkN3lVenBVVlQwUVF2N3RTY2liVDlxUkZleWJF?=
 =?utf-8?B?STZHSXVabi9YdG0xRSt1UjZrWjJwOUsvejJkT3d4eXFJMkd3NEUzTkhDQzhD?=
 =?utf-8?B?dFMwakFRejRoendmZWNkNjcxK3BVaVpoMG43SmF5V1JsZ3lod2M4RkVSZlBa?=
 =?utf-8?B?QWRnWWRxeU1EWjMxNXV6all0QmVHbjNoTndrTHhXdW9nMFNDMHJpUjlSK3d3?=
 =?utf-8?B?SlVGbkFoMFcwTmJaYk5XSy9xeCtuNkdEOC9Qc25ZU2JKTmU5cURNUzdmNTl4?=
 =?utf-8?B?ZnNoeUZlV3NWSzk0VVBBcjk3dENjK1FnOU0xQ29JZUt0cDRNVW5JVHRMSXhX?=
 =?utf-8?B?akNsU2lxMXB0SHgyVWlsbTVkdXgvTTFBMlpUcEpaWVZwSWpCeU1XTXVOSmMv?=
 =?utf-8?B?L05MWi9uY1hzOExXSUhFYVFTRzRrWG0rTk9QZ1ZsMW1vYkFtRGhzZ0VlMHZh?=
 =?utf-8?B?aGVGZm4wdFk0bXJqNG9Cc01RQm1Wem5OZUlLZkhUOHhqcVhpRGpCb1V5d0wv?=
 =?utf-8?B?cGVzUmw0U0NxRDgvcld3T2U4ZkNkT0s3Mjdpb1h4Zm5XRjNGTmpCMHNBYWhi?=
 =?utf-8?B?Tm40SC9yNHJBaTBGZm1TY2NTM3VvVEpGRUozRVFtcVAxeEtlTUtQWVFCT0w4?=
 =?utf-8?B?YjFaR3lxalFzRGVhY2tKN3c1ZUVqNWFpVmVYdmROQkNabWRNejZpRzY1K2hL?=
 =?utf-8?B?VU4vdEhxMGxvZ0pGM0hKV3ErZHBmQmJwRU5sTVR2YlFqdXR0dHlKNzlVblE4?=
 =?utf-8?B?STNhN3ZmZFMzNHFXT2dzZ0Y1SXZRcXNPd1JXYmpsZ2RzYWp4ZUl4dU11NGZV?=
 =?utf-8?Q?0e5ykMN7wkhLOkY5dVXKLw88mZrG44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmJEb1ZYRmppTVNaVkxoZDgwekk3ald1bVNjOTRpQUMrWGl2U2RUU1pteVpW?=
 =?utf-8?B?RU5ndmdoa1k3ZUxROWFXbmtGS3BlVDhJWVQ0OE1laWI5SVVhUjBzVGttaUlp?=
 =?utf-8?B?RmNXelpGb0lLVXRJall1VVdneXBWNkFEeGJGVjcxM2xTNjRETTM3a3pXYjky?=
 =?utf-8?B?dE9GeElDZW9hUFltMktDS3BTd2JkSk1XdlI0bTlFYjBtOUFCZkx5aVJJdm93?=
 =?utf-8?B?VHpRMit0YjE0R2xzZEhzdCtOVThZTDdUbHRTQStNaUMrOWM0VWlIeSswalM3?=
 =?utf-8?B?clRPNGxnQzVyaW5rcUUvdXVpV0taTkI1T05OMlV3ZEEvUU16bmRuOWZoODJW?=
 =?utf-8?B?SHdvTVBBY0pEczBLYmJOY0JCSmc2NlFEQUVBNkZOamdLcGY3SStock1YNFlG?=
 =?utf-8?B?WCs0RElXMHNGR1B3Y2M3VWE5R1pjWlpBZWNCaW51ZXM3M0xxdkJiYVVCT0Zj?=
 =?utf-8?B?eFFoU09kQzRJUW5zcmd0MHdmTFRjYlBTSWVYdjRVR0o1amxCclpkNG9Bc1JJ?=
 =?utf-8?B?aFQ1SFhpQWV5V09rUTRJSFpabDVmd0k0VFVXbk96OFd2c01xYkdYeHVjUkNQ?=
 =?utf-8?B?bXd4U0NNNmgyWkQ3Uklrb2diNmJDOUYyS2lQVUdhdWpIUHRzWlJOcWMydDBi?=
 =?utf-8?B?N1N5dVZnTWRVMU15aUFLTndmbzR5WllZQ3gwRWsvTFlKMXV5bE9EbzdzNmt6?=
 =?utf-8?B?cUhCYXdiRDI0ekZFWElpS0NPTUtpRWJGdkdMdTNzUXlTL0xPalB5N0NIOHZs?=
 =?utf-8?B?UmdSRktZdWsyYTZHbTNiWjdabkIwdXNrR2lTS042Q0ZSYVlMV2xOMlFYSUFM?=
 =?utf-8?B?Y3gyRGdlc2NGMk4zMDdKUHJOeWc0amdLS3dQczd3Z0w5NTJ6d1IxNkJZZGlm?=
 =?utf-8?B?eFZlb3ZhOGwrWkt1N3ZSaHVHUWdaVmxST2c1S2pHNEhnQTRINEwxMFBRendV?=
 =?utf-8?B?WHVtWDI2dmxKd3UwdWE3MEdQcHA2NlFWVmZ2N2lEMEJ0aUhkQWpXMXZqcEdt?=
 =?utf-8?B?bTBjNlp2dXYvOWNENWJtMUFzc0ZDSkNBRG1ZckJSbEhLTGJlWVFKMlVyd08v?=
 =?utf-8?B?T3ZpdFdRRXEzdTg0N3pDTnFFTXJwTlp2VGs0N1ZmZkdoVm5yc3hoNDdCOVl4?=
 =?utf-8?B?N1NwZk5ZSG9nYXpwYUxoNUtOVHBsTnpMdVBVTDkyMm5xenBWUE94N3dWNWNR?=
 =?utf-8?B?NDh0aGwycjIrM25DZ0h0MWEyYXQ3OVd4K1JXbitLdkRQa0IyYmVqbnQvY2Jh?=
 =?utf-8?B?ckhkUGRzZFdGWkY5NlRVZjdnRnlkaXprU3FpYTBsT08xTkt4WFcvQm1CVU4z?=
 =?utf-8?B?ZTZ4UWttMDhiQWlhUndKaTQ5ZjhMcDlsTXBhNGtEak1zTkRhUGJRLzEydnFh?=
 =?utf-8?B?OXpIYWlZdEZrT0lVUVV4QWFlUmdjS1lQYzFiaUk2RUZ1MGZqbmVDZHJHaldS?=
 =?utf-8?B?NStDSzI1cktMREgzZnFYeFlJSGNPUWRkTlZBbHdqTFVVemllYTFqYUg1aURl?=
 =?utf-8?B?aG5ZalZwcVNrU2U2bTJnckZKNUFCOFRPZytaMnZISk93OG9RMjRWUlZpVUtU?=
 =?utf-8?B?R01GcFRGSkt2bGRqNDE1VjhwY2VRWGxaYlNSdElFZjFvc0E3RmFDNlFOdnZW?=
 =?utf-8?B?N1RsYWtXY29zR0dlT2NvSXZEL0NQcG15cUJhTURYUFc5b0pYMllxdk9tcGF5?=
 =?utf-8?B?c0xaVnBlaHhjNkFpMndFZGdXNnpBMmswSlQ4b0dtcVlPMUFDRk4ycXpCVXpF?=
 =?utf-8?B?dHRFcmxMb0RHOTY4Y1IrR2w5V3VobGVLcWFQVS81RVlxTyt5MzBmVTY5ekpz?=
 =?utf-8?B?NDBQVWQ3VVVRK3ZHKytYQjJKVytMY1hNTkZHWjJqRFFpODNyeHJrZ2wwWHlP?=
 =?utf-8?B?WWpTSnk4bGtZYkZ3ZWJ1dllDQnFJMlZjY2FxUkZmaUJkWVJndC9NMmpXQ0RO?=
 =?utf-8?B?U05LWENnaG1WYUY0ME5SQ0NkcVlQYTJEUlFjQXRuSzZvRk53NXFudUE4Tk01?=
 =?utf-8?B?WUlsLzdtNW1UUzR3TFFsSldCUmVybnZVbmI4L0FKQmZ3TXFvOXNmQWpIY0xD?=
 =?utf-8?B?NlBZUkQzTC9yR05Oa0dMQ3E2SERUdkZTNTQ1WW5KM3pXUVg2L0s4M2tMVEF0?=
 =?utf-8?B?am9KUUpuUHJrbGljTnNZUVpTVFgvQlBlS0pKMnE5NnhNWXByZXd2MS8yWHVx?=
 =?utf-8?B?aVo0c2VxOUlQRTVkNTBoakVoM2dLZ3NWbzNsUGcranF2bE9sbHNOS0tML29K?=
 =?utf-8?B?WHRTbWtPN3dQSVB2a3F3WlRPek93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <493B7C4759AE054BAF2AD923E857AB40@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db3b57-835b-4f6d-eefd-08dd884b9dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:00:50.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRGmfyZ/pfsPLwCT7cOwmK/KnjNBNFJypluSUAVPS1VBBmDiEwxZ8dZ0uOMUhyPukfopiVvsd14irQbYfbyzrH4XWOQS5HMIYLTV2DipzMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8526
X-Proofpoint-ORIG-GUID: dg291qvaulK1yEENqEB5Yk3I9XM4eTT6
X-Proofpoint-GUID: dg291qvaulK1yEENqEB5Yk3I9XM4eTT6
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=6812c7c6 cx=c_pps a=nstxx7sbfik0j6lNDJSLGQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=pGLkceISAAAA:8 a=fNeB7TUBp4HW7pnj_RYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAwNiBTYWx0ZWRfX8djP3GoipO6T UrC14FTZNbUG5wi0cgbYZM5COEi/zaZqTYLQCulLckksiXaF8A1fI+MVvKhIK2py4efopeMV3+w g2QAW3XHVzXdleku0NWQnFG/NHwASg87QF/CTNQgYr5RXh+Dz4IHivGRcv7qjoPliJxutTshYSV
 KyN+ye9zk4f81bqFLHLQAf1xTHIMW4rX50MphG74kK1VjK3twX40mq8Q4Xlq/KARZhgG86FoVOX 1osbXzNXJEhdrN3hQCHRUylHwrc58Sc8hK9LevATT8Y6JjmOW62n4rXt66Fly3r529TFv37RQUk V2Q/vEgrQYpbaO9Im/vC+LjjA1CkyT+jZ5W1+lecNwfzQpt2LKHGIAIj91eZTvMuksx8WQ//VwU
 HDiiaubNRIiTbcE/nG3EawoozUQNluJ/Mx8q+15P3ZQioMfh6XKCIDZGZtj2X56temIeUE14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDMwLCAyMDI1LCBhdCA1OjA54oCvUE0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBDQVVU
SU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiAwNC8zMCwg
Sm9uIEtvaGxlciB3cm90ZToNCj4+IEludHJvZHVjZSBuZXcgWERQIGhlbHBlcnM6DQo+PiAtIHhk
cF9oZWFkbGVuOiBTaW1pbGFyIHRvIHNrYl9oZWFkbGVuDQo+PiAtIHhkcF9oZWFkcm9vbTogU2lt
aWxhciB0byBza2JfaGVhZHJvb20NCj4+IC0geGRwX21ldGFkYXRhX2xlbjogU2ltaWxhciB0byBz
a2JfbWV0YWRhdGFfbGVuDQo+PiANCj4+IEludGVncmF0ZSB0aGVzZSBoZWxwZXJzIGludG8gdGFw
LCB0dW4sIGFuZCBYRFAgaW1wbGVtZW50YXRpb24gdG8gc3RhcnQuDQo+PiANCj4+IE5vIGZ1bmN0
aW9uYWwgY2hhbmdlcyBpbnRyb2R1Y2VkLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29o
bGVyIDxqb25AbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IHYxLT52MjogSW50ZWdyYXRlIGZlZWRi
YWNrIGZyb20gV2lsbGVtDQo+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIv
dXJsP3U9aHR0cHMtM0FfX3BhdGNod29yay5rZXJuZWwub3JnX3Byb2plY3RfbmV0ZGV2YnBmX3Bh
dGNoXzIwMjUwNDMwMTgyOTIxLjE3MDQwMjEtMkQxLTJEam9uLTQwbnV0YW5peC5jb21fJmQ9RHdJ
QmFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPU5HUFJHR28zN21RaVNYZ0hLbTVyQ1EmbT05
cGR4elFzelhfTTBLM2dFUGVZT3lNWlpZU2tSUjhJTXZ4c2xTODMyMEVvY3RrNTh5LUVMQ2RaNWlh
cnlGMkdIJnM9Si1JTEI3RTlWUV9wbG8waHlqRXR6R3pqeTZHMF9vNE1NTW1tRV96OHZ2YyZlPSAN
Cj4+IA0KPj4gZHJpdmVycy9uZXQvdGFwLmMgfCAgNiArKystLS0NCj4+IGRyaXZlcnMvbmV0L3R1
bi5jIHwgMTIgKysrKystLS0tLS0NCj4+IGluY2x1ZGUvbmV0L3hkcC5oIHwgNTQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+IG5ldC9jb3JlL3hkcC5j
ICAgIHwgMTIgKysrKystLS0tLS0NCj4+IDQgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90YXAu
YyBiL2RyaXZlcnMvbmV0L3RhcC5jDQo+PiBpbmRleCBkNGVjZTUzOGYxYjIuLmE2MmZiY2E0YjA4
ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3RhcC5jDQo+PiArKysgYi9kcml2ZXJzL25l
dC90YXAuYw0KPj4gQEAgLTEwNDgsNyArMTA0OCw3IEBAIHN0YXRpYyBpbnQgdGFwX2dldF91c2Vy
X3hkcChzdHJ1Y3QgdGFwX3F1ZXVlICpxLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4+IHN0cnVj
dCBza19idWZmICpza2I7DQo+PiBpbnQgZXJyLCBkZXB0aDsNCj4+IA0KPj4gLSBpZiAodW5saWtl
bHkoeGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YSA8IEVUSF9ITEVOKSkgew0KPj4gKyBpZiAodW5s
aWtlbHkoeGRwX2hlYWRsZW4oeGRwKSA8IEVUSF9ITEVOKSkgew0KPj4gZXJyID0gLUVJTlZBTDsN
Cj4+IGdvdG8gZXJyOw0KPj4gfQ0KPj4gQEAgLTEwNjIsOCArMTA2Miw4IEBAIHN0YXRpYyBpbnQg
dGFwX2dldF91c2VyX3hkcChzdHJ1Y3QgdGFwX3F1ZXVlICpxLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhk
cCkNCj4+IGdvdG8gZXJyOw0KPj4gfQ0KPj4gDQo+PiAtIHNrYl9yZXNlcnZlKHNrYiwgeGRwLT5k
YXRhIC0geGRwLT5kYXRhX2hhcmRfc3RhcnQpOw0KPj4gLSBza2JfcHV0KHNrYiwgeGRwLT5kYXRh
X2VuZCAtIHhkcC0+ZGF0YSk7DQo+PiArIHNrYl9yZXNlcnZlKHNrYiwgeGRwX2hlYWRyb29tKHhk
cCkpOw0KPj4gKyBza2JfcHV0KHNrYiwgeGRwX2hlYWRsZW4oeGRwKSk7DQo+PiANCj4+IHNrYl9z
ZXRfbmV0d29ya19oZWFkZXIoc2tiLCBFVEhfSExFTik7DQo+PiBza2JfcmVzZXRfbWFjX2hlYWRl
cihza2IpOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJpdmVycy9uZXQv
dHVuLmMNCj4+IGluZGV4IDdiYWJkMWU5YTM3OC4uNGM0N2VlZDcxOTg2IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9uZXQvdHVuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiBAQCAt
MTU2Nyw3ICsxNTY3LDcgQEAgc3RhdGljIGludCB0dW5feGRwX2FjdChzdHJ1Y3QgdHVuX3N0cnVj
dCAqdHVuLCBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLA0KPj4gZGV2X2NvcmVfc3RhdHNfcnhf
ZHJvcHBlZF9pbmModHVuLT5kZXYpOw0KPj4gcmV0dXJuIGVycjsNCj4+IH0NCj4+IC0gZGV2X3N3
X25ldHN0YXRzX3J4X2FkZCh0dW4tPmRldiwgeGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YSk7DQo+
PiArIGRldl9zd19uZXRzdGF0c19yeF9hZGQodHVuLT5kZXYsIHhkcF9oZWFkbGVuKHhkcCkpOw0K
Pj4gYnJlYWs7DQo+PiBjYXNlIFhEUF9UWDoNCj4+IGVyciA9IHR1bl94ZHBfdHgodHVuLT5kZXYs
IHhkcCk7DQo+PiBAQCAtMTU3NSw3ICsxNTc1LDcgQEAgc3RhdGljIGludCB0dW5feGRwX2FjdChz
dHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLCBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLA0KPj4gZGV2
X2NvcmVfc3RhdHNfcnhfZHJvcHBlZF9pbmModHVuLT5kZXYpOw0KPj4gcmV0dXJuIGVycjsNCj4+
IH0NCj4+IC0gZGV2X3N3X25ldHN0YXRzX3J4X2FkZCh0dW4tPmRldiwgeGRwLT5kYXRhX2VuZCAt
IHhkcC0+ZGF0YSk7DQo+PiArIGRldl9zd19uZXRzdGF0c19yeF9hZGQodHVuLT5kZXYsIHhkcF9o
ZWFkbGVuKHhkcCkpOw0KPj4gYnJlYWs7DQo+PiBjYXNlIFhEUF9QQVNTOg0KPj4gYnJlYWs7DQo+
PiBAQCAtMjM1NSw3ICsyMzU1LDcgQEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3QgdHVu
X3N0cnVjdCAqdHVuLA0KPj4gICAgICAgc3RydWN0IHhkcF9idWZmICp4ZHAsIGludCAqZmx1c2gs
DQo+PiAgICAgICBzdHJ1Y3QgdHVuX3BhZ2UgKnRwYWdlKQ0KPj4gew0KPj4gLSB1bnNpZ25lZCBp
bnQgZGF0YXNpemUgPSB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhOw0KPj4gKyB1bnNpZ25lZCBp
bnQgZGF0YXNpemUgPSB4ZHBfaGVhZGxlbih4ZHApOw0KPj4gc3RydWN0IHR1bl94ZHBfaGRyICpo
ZHIgPSB4ZHAtPmRhdGFfaGFyZF9zdGFydDsNCj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2hkciAqZ3Nv
ID0gJmhkci0+Z3NvOw0KPj4gc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsNCj4+IEBAIC0yNDE1
LDE0ICsyNDE1LDE0IEBAIHN0YXRpYyBpbnQgdHVuX3hkcF9vbmUoc3RydWN0IHR1bl9zdHJ1Y3Qg
KnR1biwNCj4+IGdvdG8gb3V0Ow0KPj4gfQ0KPj4gDQo+PiAtIHNrYl9yZXNlcnZlKHNrYiwgeGRw
LT5kYXRhIC0geGRwLT5kYXRhX2hhcmRfc3RhcnQpOw0KPj4gLSBza2JfcHV0KHNrYiwgeGRwLT5k
YXRhX2VuZCAtIHhkcC0+ZGF0YSk7DQo+PiArIHNrYl9yZXNlcnZlKHNrYiwgeGRwX2hlYWRyb29t
KHhkcCkpOw0KPj4gKyBza2JfcHV0KHNrYiwgeGRwX2hlYWRsZW4oeGRwKSk7DQo+PiANCj4+IC8q
IFRoZSBleHRlcm5hbGx5IHByb3ZpZGVkIHhkcF9idWZmIG1heSBoYXZlIG5vIG1ldGFkYXRhIHN1
cHBvcnQsIHdoaWNoDQo+PiAqIGlzIG1hcmtlZCBieSB4ZHAtPmRhdGFfbWV0YSBiZWluZyB4ZHAt
PmRhdGEgKyAxLiBUaGlzIHdpbGwgbGVhZCB0byBhDQo+PiAqIG1ldGFzaXplIG9mIC0xIGFuZCBp
cyB0aGUgcmVhc29uIHdoeSB0aGUgY29uZGl0aW9uIGNoZWNrcyBmb3IgPiAwLg0KPj4gKi8NCj4+
IC0gbWV0YXNpemUgPSB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfbWV0YTsNCj4+ICsgbWV0YXNpemUg
PSB4ZHBfbWV0YWRhdGFfbGVuKHhkcCk7DQo+PiBpZiAobWV0YXNpemUgPiAwKQ0KPj4gc2tiX21l
dGFkYXRhX3NldChza2IsIG1ldGFzaXplKTsNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bmV0L3hkcC5oIGIvaW5jbHVkZS9uZXQveGRwLmgNCj4+IGluZGV4IDQ4ZWZhY2JhYTM1ZC4uMDQ0
MzQ1YjE4MzA1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9uZXQveGRwLmgNCj4+ICsrKyBiL2lu
Y2x1ZGUvbmV0L3hkcC5oDQo+PiBAQCAtMTUxLDEwICsxNTEsNTYgQEAgeGRwX2dldF9zaGFyZWRf
aW5mb19mcm9tX2J1ZmYoY29uc3Qgc3RydWN0IHhkcF9idWZmICp4ZHApDQo+PiByZXR1cm4gKHN0
cnVjdCBza2Jfc2hhcmVkX2luZm8gKil4ZHBfZGF0YV9oYXJkX2VuZCh4ZHApOw0KPj4gfQ0KPj4g
DQo+PiArLyoqDQo+PiArICogeGRwX2hlYWRsZW4gLSBDYWxjdWxhdGUgdGhlIGxlbmd0aCBvZiB0
aGUgZGF0YSBpbiBhbiBYRFAgYnVmZmVyDQo+PiArICogQHhkcDogUG9pbnRlciB0byB0aGUgWERQ
IGJ1ZmZlciBzdHJ1Y3R1cmUNCj4+ICsgKg0KPj4gKyAqIENvbXB1dGUgdGhlIGxlbmd0aCBvZiB0
aGUgZGF0YSBjb250YWluZWQgaW4gdGhlIFhEUCBidWZmZXIuIERvZXMgbm90DQo+PiArICogaW5j
bHVkZSBmcmFncywgdXNlIHhkcF9nZXRfYnVmZl9sZW4oKSBmb3IgdGhhdCBpbnN0ZWFkLg0KPj4g
KyAqDQo+PiArICogQW5hbG9nb3VzIHRvIHNrYl9oZWFkbGVuKCkuDQo+PiArICoNCj4+ICsgKiBS
ZXR1cm46IFRoZSBsZW5ndGggb2YgdGhlIGRhdGEgaW4gdGhlIFhEUCBidWZmZXIgaW4gYnl0ZXMu
DQo+PiArICovDQo+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgeGRwX2hlYWRsZW4oY29u
c3Qgc3RydWN0IHhkcF9idWZmICp4ZHApDQo+PiArew0KPj4gKyByZXR1cm4geGRwLT5kYXRhX2Vu
ZCAtIHhkcC0+ZGF0YTsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+PiArICogeGRwX2hlYWRyb29t
IC0gQ2FsY3VsYXRlIHRoZSBoZWFkcm9vbSBhdmFpbGFibGUgaW4gYW4gWERQIGJ1ZmZlcg0KPj4g
KyAqIEB4ZHA6IFBvaW50ZXIgdG8gdGhlIFhEUCBidWZmZXIgc3RydWN0dXJlDQo+PiArICoNCj4+
ICsgKiBDb21wdXRlIHRoZSBoZWFkcm9vbSBpbiBhbiBYRFAgYnVmZmVyLg0KPj4gKyAqDQo+PiAr
ICogQW5hbG9nb3VzIHRvIHRoZSBza2JfaGVhZHJvb20oKS4NCj4+ICsgKg0KPj4gKyAqIFJldHVy
bjogVGhlIHNpemUgb2YgdGhlIGhlYWRyb29tIGluIGJ5dGVzLg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IHhkcF9oZWFkcm9vbShjb25zdCBzdHJ1Y3QgeGRwX2J1ZmYg
KnhkcCkNCj4+ICt7DQo+PiArIHJldHVybiB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfaGFyZF9zdGFy
dDsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+PiArICogeGRwX21ldGFkYXRhX2xlbiAtIENhbGN1
bGF0ZSB0aGUgbGVuZ3RoIG9mIG1ldGFkYXRhIGluIGFuIFhEUCBidWZmZXINCj4+ICsgKiBAeGRw
OiBQb2ludGVyIHRvIHRoZSBYRFAgYnVmZmVyIHN0cnVjdHVyZQ0KPj4gKyAqDQo+PiArICogQ29t
cHV0ZSB0aGUgbGVuZ3RoIG9mIHRoZSBtZXRhZGF0YSByZWdpb24gaW4gYW4gWERQIGJ1ZmZlci4N
Cj4+ICsgKg0KPj4gKyAqIEFuYWxvZ291cyB0byBza2JfbWV0YWRhdGFfbGVuKCkuDQo+PiArICoN
Cj4+ICsgKiBSZXR1cm46IFRoZSBsZW5ndGggb2YgdGhlIG1ldGFkYXRhIGluIGJ5dGVzLg0KPj4g
KyAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHhkcF9tZXRhZGF0YV9sZW4oY29u
c3Qgc3RydWN0IHhkcF9idWZmICp4ZHApDQo+IA0KPiBJIGJlbGlldmUgdGhpcyBoYXMgdG8gcmV0
dXJuIGludCwgbm90IHVuc2lnbmVkIGludC4gVGhlcmUgYXJlIHBsYWNlcw0KPiB3aGVyZSB3ZSBk
byBkYXRhX21ldGEgPSBkYXRhICsgMSwgYW5kIHRoZSBjYWxsZXJzIGNoZWNrIHdoZXRoZXINCj4g
dGhlIHJlc3VsdCBpcyBzaWduZWQgb3Igc3Vuc2lnbmVkLg0KDQpUaGUgZXhpc3RpbmcgU0tCIEFQ
SXMgYXJlIHRoZSBleGFjdCBzYW1lIHJldHVybiB0eXBlIChJIGNvcGllZCB0aGVtIDE6MSksDQpi
dXQgSSBoYXZlIGEgZmVlbGluZyB0aGF0IHdl4oCZcmUgbmV2ZXIgaW50ZW5kaW5nIHRoZXNlIHZh
bHVlcyB0byBlaXRoZXIgQSkgYmUNCm5lZ2F0aXZlIGFuZC9vciBCKSB3cmFwIGluIHN0cmFuZ2Ug
d2F5cz8NCg0KPiANCj4+ICt7DQo+PiArIHJldHVybiB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfbWV0
YTsNCj4+ICt9DQo+PiArDQo+PiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGludA0K
Pj4geGRwX2dldF9idWZmX2xlbihjb25zdCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4+IHsNCj4+
IC0gdW5zaWduZWQgaW50IGxlbiA9IHhkcC0+ZGF0YV9lbmQgLSB4ZHAtPmRhdGE7DQo+PiArIHVu
c2lnbmVkIGludCBsZW4gPSB4ZHBfaGVhZGxlbih4ZHApOw0KPj4gY29uc3Qgc3RydWN0IHNrYl9z
aGFyZWRfaW5mbyAqc2luZm87DQo+PiANCj4+IGlmIChsaWtlbHkoIXhkcF9idWZmX2hhc19mcmFn
cyh4ZHApKSkNCj4+IEBAIC0zNjQsOCArNDEwLDggQEAgaW50IHhkcF91cGRhdGVfZnJhbWVfZnJv
bV9idWZmKGNvbnN0IHN0cnVjdCB4ZHBfYnVmZiAqeGRwLA0KPj4gaW50IG1ldGFzaXplLCBoZWFk
cm9vbTsNCg0KU2FpZCBhbm90aGVyIHdheSwgcGVyaGFwcyB0aGlzIHNob3VsZCBiZSB1bnNpZ25l
ZD8NCg0KPj4gDQo+PiAvKiBBc3N1cmUgaGVhZHJvb20gaXMgYXZhaWxhYmxlIGZvciBzdG9yaW5n
IGluZm8gKi8NCj4+IC0gaGVhZHJvb20gPSB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfaGFyZF9zdGFy
dDsNCj4+IC0gbWV0YXNpemUgPSB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfbWV0YTsNCj4+ICsgaGVh
ZHJvb20gPSB4ZHBfaGVhZHJvb20oeGRwKTsNCj4+ICsgbWV0YXNpemUgPSB4ZHBfbWV0YWRhdGFf
bGVuKHhkcCk7DQo+PiBtZXRhc2l6ZSA9IG1ldGFzaXplID4gMCA/IG1ldGFzaXplIDogMDsNCj4g
DQo+IF5eIGxpa2UgaGVyZQ0KDQpMb29rIGFjcm9zcyB0aGUgdHJlZSwgc2VlbXMgbGlrZSBtb3Jl
IGFyZSB1bnNpZ25lZCB0aGFuIHNpZ25lZA0KDQpUaGVzZSBvbmVzIHVzZSB1bnNpZ25lZDoNCnhk
cF9jb252ZXJ0X3pjX3RvX3hkcF9mcmFtZQ0KdmV0aF94ZHBfcmN2X3NrYg0KeHNrX2NvbnN0cnVj
dF9za2INCmJueHRfY29weV94ZHANCmk0MGVfYnVpbGRfc2tiDQppNDBlX2NvbnN0cnVjdF9za2Jf
emMNCmljZV9idWlsZF9za2IgKHRoaXMgaXMgdTgpDQppY2VfY29uc3RydWN0X3NrYl96Yw0KaWdi
X2J1aWxkX3NrYg0KaWdiX2NvbnN0cnVjdF9za2JfemMNCmlnY19idWlsZF9za2INCmlnY19jb25z
dHJ1Y3Rfc2tiDQppZ2NfY29uc3RydWN0X3NrYl96Yw0KaXhnYmVfYnVpbGRfc2tiDQppeGdiZV9j
b25zdHJ1Y3Rfc2tiX3pjDQppeGdiZXZmX2J1aWxkX3NrYg0KbXZuZXRhX3N3Ym1fYnVpbGRfc2ti
DQptbHg1ZV94c2tfY29uc3RydWN0X3NrYg0KbWFuYV9idWlsZF9za2INCnN0bW1hY19jb25zdHJ1
Y3Rfc2tiX3pjDQpicGZfcHJvZ19ydW5fZ2VuZXJpY194ZHANCnhkcF9nZXRfbWV0YWxlbg0KDQpU
aGVzZSBvbmVzIGFyZSByZWd1bGFyIGludDoNCnhkcF9idWlsZF9za2JfZnJvbV9idWZmDQp4ZHBf
YnVpbGRfc2tiX2Zyb21femMNCnhkcF91cGRhdGVfZnJhbWVfZnJvbV9idWZmDQp0dW5feGRwX29u
ZQ0KYnVpbGRfc2tiX2Zyb21feGRwX2J1ZmYNCg0KUGVyaGFwcyBhIHNlcGFyYXRlIHBhdGNoIHRv
IGNvbnZlcnQgdGhlIHJlZ3VsYXJzIHRvIHVuc2lnbmVkLA0KdGhvdWdodHM/DQoNCg0K

