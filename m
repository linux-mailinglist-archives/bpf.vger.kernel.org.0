Return-Path: <bpf+bounces-57727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A97AAF17F
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F151C4E408D
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A91EE017;
	Thu,  8 May 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="MhrAewlP";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qGKbXLXo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CDEACE;
	Thu,  8 May 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674346; cv=fail; b=YUdy+bUPWyhQFU63oGcWdPCSm/9ymA5VqhgSb34ugNtvOEGWTI45Sxnl4fPYNFta1g1TuoLBkLReVUFZY4FqoBgDHpCdCiUKV+G8E7tzM7iqaZc2o3h3ci5ZawSD5kEII1oGU3Dh39+sn0THkiYXt/aAwlVTmF3Nz8YTjvB7Hjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674346; c=relaxed/simple;
	bh=XUbmXJQMAH8WccsSnUdbX9+D8BEl4BsCfiHAN/V/M6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPmwOcFn+JDR8xSOnwYZr08LXUBU/+lzITbPHIx666Y461GaIzwEPyYnpqmYxd/6hOmP6+U32L7YYIocLurGXln0Q2wKXX+2qWwdzr1GYCrU4ir4/Xsy0NKxy6XeK29/PcSl1VOvJcaLKGXyTtujRZId5CDSgKW1Y1OuhlR3z/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=MhrAewlP; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=qGKbXLXo; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LLP8P010479;
	Wed, 7 May 2025 20:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=XUbmXJQMAH8WccsSnUdbX9+D8BEl4BsCfiHAN/V/M
	6k=; b=MhrAewlPFO2tOHY8LbzJWQETC0VCrwC0q6qxg4Cu+OPt0MYvckSy0ubIp
	UrhozOJYgIfKuxmC+sh9vVBgsqSL8rf5Ff5ChElJL6rtHD3+uXXr4TJtPhPJQ+xm
	UYYDd6atWLf3O3tdhRlo2kS0o2cNRZeQeQkPDCKQr9uXnFJbUAjxG3dNKYXhrJWi
	i1u1ranzoNTurzThhM08kKmn2aQeZpMjmYZbQL9BOnV9wI758EQ5i7TYlRbeyqDn
	Uwg0tLmNnyHBwhkSFZFdD91sJcPI0ieescAjmJmO/OlTV51J4J4ILPczd0eCKKky
	+juV7g4lcxvSd8z4Ux1in5IYhNjtw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011030.outbound.protection.outlook.com [40.93.14.30])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dj7m28j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 20:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2rGoO+4sXckLSJuinOw08CuuB1QxyczOygYC/OZeo8Ql3iYh/F/SyhMI4xzgNW/cH+fvhXPJ/qRE90kFBkWQ+nzMeEtMmn0q7Um8CYtM9KWMrO9YD1lyY37Jje7aTvm5wvkquJrxDLBBL4zyu6ZqqepUZs90UCArLzGj/SOdJ3cjbT8YwZ4bgCseaXY9Ycf2rRhaz2jxh7UzTOhaReZjYV3ifWcitkPy2zMXS7P31XZ4DDOcXwFJS2AocLxIvOnkeLzHh6nvEs7MKgUNhVlQ9NavdKLXyTBZqwAquwcrtBN5evkIhcZ/QduxkRk4S8ebqPkR1afSESgyTOnLCf5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUbmXJQMAH8WccsSnUdbX9+D8BEl4BsCfiHAN/V/M6k=;
 b=KvC2dmbIA2jLjH9X8lQ9ZyPc+mt3kbdKadVPleEuyycWCjdtK3Ts8YYBVrTjcQaDIPPbsFfHZ7viUyu0vq4m+iCJ3/5rt7PnOoIhgq2dtW8L837pOj56fkVRWa+P9WFa8SJfvgxouFha5EboGcPGmZoq5in6qvHh3e74E7L73ky9Q07IvFI7a1Euu0WqkquhfJ3kiEC8dg4tnAZrgmcMWI26Ks8U2i3rQLvUXrhhxgAmqtwZiM1AjAqwS89VQRumbeNp48BPlb2ZUTzzfWqbbkbDe0keGwOu1ZnvSoZEALh0o6hrG3rVG0hetEPIMcAfNt2n4Yz0ea7SQR3i3Xkx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUbmXJQMAH8WccsSnUdbX9+D8BEl4BsCfiHAN/V/M6k=;
 b=qGKbXLXoQf8kN+6W7F+3HMJadLyv6aaMWHGOjTDRzQlusg6t0TSxsL0wd6C5bSwEfpw3+H1WhJZCsPWeqw6zmpFgdbqrA91FbZiKqB9hIIsqtwxQkNuahsfhC2j7wgUqp2FhLP63ZczKrq8MfL7BNZNfOM0FypA4C5uhg3nFryDAZh6KOoeaQpHHhlqZonzwwmzBA/p/HYfpHKy5TKk0KTkp+8KuEhAeGFVeog1O0EAbfvHhbijkpnI63d3lrygIP/bVcK2CLAXAdisZH9H2v0F9wU8jYb9zPWVVGS0TIzThC/xGTBaQpdZgElWtFbMKelSx+o5HLjtVX2zU+ZbvfQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SN4PR0201MB8710.namprd02.prod.outlook.com
 (2603:10b6:806:1e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Thu, 8 May
 2025 03:18:30 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 03:18:29 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Zvi Effron
	<zeffron@riotgames.com>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Jason
 Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jacob Keller
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Topic: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Index:
 AQHbvoGOtDW/U9ulski7jan4/mWqq7PF36QAgAFLeACAADQMgIAAB1MAgAAB2wCAAAOsgIAABy6AgAAVnoCAAA6GAIAAET6AgABqG4A=
Date: Thu, 8 May 2025 03:18:29 +0000
Message-ID: <B864BCB8-AEAE-4802-AB46-176D2CEEE862@nutanix.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
 <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
 <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
 <B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
 <e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
 <6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
 <b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
In-Reply-To: <b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SN4PR0201MB8710:EE_
x-ms-office365-filtering-correlation-id: 2f6c52bd-2b24-438d-c567-08dd8ddf0181
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHpwY1pqckZsdDIxSlZNS0RTUVZPYXM5K21IVjdNdkdxZGdEd21hYkpUZ3RO?=
 =?utf-8?B?NkhnR2ZlRjBBT3lMdVBlem1xUmhXUjJQYzhtWk91dlA3ZzljcnpEVVpYOUd4?=
 =?utf-8?B?NERxbFFwS1FuUEdzVUxsRlhVQ0ttbXR4L0tacmRCRkxTSkhpdlF2OGxDTTNM?=
 =?utf-8?B?S3lYM3FTTmZwV3ZXbVdsTnRNOUpjRHlwcXFISjM2UVNtMEdHSXFibjlDY2ZW?=
 =?utf-8?B?dWpPVUtPek04Mndncy9IT1UxVWUzNXdHK1lUbE9kRmZ3azVrR1B6UC9LcDha?=
 =?utf-8?B?WUMyQW9xdXZoY0hxVlZRUXZFNVRhaE53Qm1VSEw2Vk5aZ2hhYlRjdG56TGt0?=
 =?utf-8?B?MytWc3NveVlSRGpySVZPajh2bjA5ZlJpL1dnSENnOUZadlFuTTJ0UXIvaUg5?=
 =?utf-8?B?QnQ2L0pyVW53QTNITnJ0Y0J5ZXlydnpBME5TZTg0YkFGU3lFMktScTZtMWR5?=
 =?utf-8?B?b1ZjZFVIZ1NyUzNXYmNsdWVxMC9vc2lJeU1jQ1ZFMnJlVGZILytqWDVVQnI5?=
 =?utf-8?B?enlDdENteCtmUEUwMG96L3M3ekZ3MlpnY2YvdW16emNNUHJFMjVtL3FBQnhp?=
 =?utf-8?B?R1pSelpUVnJ4RlVKRTZrRGdmVWNndFBEVlZnbVBrWG13V1VpU252ZkdSRk5q?=
 =?utf-8?B?OCtkeks3WmtubUhqejRjMDRaU0tNeFluUHRkTVdvWW1yTjdCUHd6THg1NFlI?=
 =?utf-8?B?V0txa3lwUjdxSmFvL2p6aURxSUJQVkcyUXh4ZGdKbm5wWW1GYlNhQ2oyQ0dR?=
 =?utf-8?B?UFdMUmNuWnhoYjdoTkFTa3hJaHFFVlk5dmpKSXBiZEs3WllLaVgzTXk2dUk0?=
 =?utf-8?B?YWYreUtZQ3lzVmJxT1kwWStxTnNBQ3NvejVHWkpBeFl1NXRlazNuUTcrRWZs?=
 =?utf-8?B?RXB6ZXdRVVBuek9ZOEs1WDlaZkN0Wk1HdFpBSlBpdFMxbHR5RUNFeHBRenhh?=
 =?utf-8?B?MVE2YkFuOVRxUEs3L1QxRzl0S3NaSVFERWU2Tm1VcnhjTjRYSjFzMDd6U3lh?=
 =?utf-8?B?VzN5ZW5nTWt0UXdZc0dOVVJnV2lPd0lyWnVrSk1yM0EwTWtTUnJhQTVCaGli?=
 =?utf-8?B?MERLdGc4Z1I5dVo5WnBxQkpDSnhscDJ6R0trdXhxbVZqYkZqQzIzcVZNYVpt?=
 =?utf-8?B?NjBEaWZyNTU1R3pwSGZrcU41MDNYRmEwNEM4TGFkQmR1YnZodHlzbjEwWVNo?=
 =?utf-8?B?K1JHM0w2U1BIZXBUSzJxNElva2hXdGNqcmlsQzh3bTZhczIrMTZ6SXZTM25S?=
 =?utf-8?B?a2tuZW1ya2dhaUVJTE9nTm9wUjhRcUtuODNZZGJKVUpQb05adFUrRHdjTFpI?=
 =?utf-8?B?TEpzTU9heDBTOGFTUUlseDhaOFErdTVTaHpZKzA2NHFDWnJyOUV2d3NHZnNp?=
 =?utf-8?B?TU5pY3pULy9tbTFQVndUd2VaRmRkekdtUFFGVmZLZFlhRzFwdnFJODZMUXp2?=
 =?utf-8?B?dDhlVnFuZzl5ODM1SDRzRTA2TWFIMmswUWF6anZFdkhvcUFpd3pzUkErVkdL?=
 =?utf-8?B?cDR3L3g0SW1rTytNdFRMOXI3V1cvdEtIaHVWcjB3Vmh6T2F3QTFWTXJLc1hY?=
 =?utf-8?B?TU5BeEpaTzhRdlk3QkpNR1BjQ3VpdUNXNjZITm9lNm1aODlKeDhZNS9EZ1VM?=
 =?utf-8?B?RHcxUTFobEVTdTZwOEtzeS8yS21uanpXd2JWSlBOd3dwZ2pTd203TzN0eGIv?=
 =?utf-8?B?MHpLWUZENWNGeXN1U00xS0hxSEo2SlFYMTI3VmpDWlVqSlprOGpmY0xsa1Ro?=
 =?utf-8?B?UlV4SlhkL0NYZzM1bFdQNjJTckEybWlLU0V1MFJ0RWZVOWZPalJJMFVPOHlZ?=
 =?utf-8?B?WWI1SU9mMmN4S1Z3dUo4OXhkY2tUS3VoM0l3WmU3M2h2d3ZiSTBFR1VZWkYy?=
 =?utf-8?B?RUxzcm92MU41aFFnUkVPaTM4UG4wUTdhSHpyUjFWU0xmby9iSGovRytOZjhX?=
 =?utf-8?B?NFFPb2pBczA5WWJ4dUhwNktRaHI2NjRLMlNJNExxNkllbUVWamtJekNHWURM?=
 =?utf-8?Q?miPy+w3g50UrY+IEEAyzuCfEVAHe40=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGZVUjRJRDFyNTJLRU1jVEowc1pPSktoWHJ0QmNDQTlacHk1VzdLVnpRdmQ2?=
 =?utf-8?B?SysvaDNEZGdaVXMyRHF1NE1zOTlUZ0lkaTVWVHNpUGhMeGVocnh2dTVSR3Zl?=
 =?utf-8?B?TVh1NlJmZHlVQWRTRHhvdFBLeHVtOWRtb1phSE5SSTZDU2FIMjRqNEM1Y2pP?=
 =?utf-8?B?WFQ1R28vcHVIdnIxdW55d0NsNVd5RU00UzBQa3JEaGd3ZVMwNzAzNTBRQXBK?=
 =?utf-8?B?cDI1N0NKY1paMjRFUkh4ZlE0UjhKeDduV0U2cHJtMXRjSXdDSlF6cTAxNjcy?=
 =?utf-8?B?RGZzUC9YMWE5NTU4a25jdnI3TjBuYTNPbTEydnBwdGNMU0RlZTN0eTRZSUJG?=
 =?utf-8?B?RzBjREV1WlpZaHVGTzU5TFRBVi9EdjE5b2dFOGVXN3ZQZDRXd1pwR3dISFR0?=
 =?utf-8?B?NHpITWFYSTdlMi91cm1uL0YvM0Njb0EzZ243b1dHUHhITmkzMUkxWDhzZG42?=
 =?utf-8?B?cVNlNFl2NU5wTVl2eXlQZkUybTNvZmh5YzQ3WDlwWElMQVYwYUNqR05nYWE3?=
 =?utf-8?B?UkdFVHgxMUY5TFJwYTNyTEk4YkZCaGN4ZWZYM09lUlNETmw1S0dTK2UxQ2U4?=
 =?utf-8?B?eSs2bU5WSXMxeEhJZVl5MGFlZUVINGE1YUFqN2QvZ2RZRVpCT1h0aStJT3BV?=
 =?utf-8?B?aEhidWZoRFdWTG1adXNQcjNDRFBQdzA3UTJReVA2bExtQ1RpQUFEYXJxRlFI?=
 =?utf-8?B?cUZGeG9OS2tqSXdLaTNucEhySFp6RWVESjdQL2FxZklzZXJKSUEwSDF4OUVS?=
 =?utf-8?B?Yy9QSEh2OWVGTEpYbG1aR3RESnRRaDJyb1A0Zm42MVVGS0pJWEdmN0ZhSVBk?=
 =?utf-8?B?a3krYXd0QnBOdnRrMXpaUVZ2b3hHSTc5bXdGNjVaRng4Z0RwUG9zUXZVYzdG?=
 =?utf-8?B?VUppQzY5bjIvOHdlOTZPQ3JMaXU4RVZ0N0dWN1NyOHNES2lvdjkvMkd6dURk?=
 =?utf-8?B?enp4T1AxaGRZUFdrc0EwcTFGN3gvQlFFOWtRUmxHOHNzWTZFamF6MXI0UTdJ?=
 =?utf-8?B?NWFySEl5VzhqMHk1MXdQY3I2dGFOSjgvaml5dzZlM2l0RDFBNm9YMTI1OUpk?=
 =?utf-8?B?N0l4NVR5bHFOZTA1bkNUM2xCVzlTNTY4WHYrY0UydGY0bml4cGlrK2h0c1V4?=
 =?utf-8?B?K21EY2FMRUl5b2Q1cDRYaUplNWorTVV6eTNXRVZYb3F3d0cvTE4rRlVKaHR6?=
 =?utf-8?B?ajZDNFNtZ1NKY0lEM0hJZ2pRMzd6bW41cDNEbWthWTJ0bHY5SzVYamVoSUt5?=
 =?utf-8?B?NTJyZzh2dHY4Y2VWUmVkc1Yzamk5TGdYOTMyMEdFQlFtN0FaOVMvemxNb3FY?=
 =?utf-8?B?QTZUQ1dnb01YYVlEVzFUTkdSM2ExcytYUm5kS1RGaXo5QUl2ZVJTbTBxWTl3?=
 =?utf-8?B?MVNvTVJNbHZtNzU3ZDhLcFBTUGY2TzF6cEkreEdDVHhiVE1hZzkvTEZaem1G?=
 =?utf-8?B?MzBaaUh3NDJ1M09VcS9JSzdKYUpCSWVIU0VSaG5nRnlOQ3EwaitjcElUMFRU?=
 =?utf-8?B?SEcyRmswS3FnT05qeXVJUVJ0enE5dE1QUitOR093K0Njdm1rbDVFTmFhU0dm?=
 =?utf-8?B?TGI1aGhMbGxqenhlK1JQaDhqWUpIV2tHL1RFcGNQQ21hVkJMYkg4MG1haVhH?=
 =?utf-8?B?WStIMkRtbnNnN09XQlkwMXB5WUdNU0xiMW5xS2RrVStGSm9EWVZSVEhKMjdh?=
 =?utf-8?B?RkJuVzc2OVNoMnZSRWprWXNhdTVVM1pRVFdRRFFRT08rcmxkNisvYXVDdUJW?=
 =?utf-8?B?dG1saXJWS1J6QldUOTZYRmQ5L0E1V3pvVXIydWxJeDJJVllvVVNzeHptaDlN?=
 =?utf-8?B?cjBRck5RT3pES2ZiQnAwZGhwc3FteGhFbzJPck1obm9rYUJ0RWY2YU5XSlk2?=
 =?utf-8?B?bFd4S0ZsWTBOZmR5K3lxUEs5SGFQTGgwUmlrajRiTzFjSFVnTldHbEl5RU5r?=
 =?utf-8?B?UGRlK1BlVFA5d2tET045UlNkZnVrU1BLemJwMnRGdWtZbTFaejRiRGtZbWZz?=
 =?utf-8?B?K29IYi9SeU1aMjV6MmdldHB6ZTZDeUJDckl4OXM4SmpTaUdXbHdRT04yb2tR?=
 =?utf-8?B?Y1Bzbk5lWVdjRXNqaitER0JIaFhEVGFzZWYzS3VHN2hWMVJ5Y0hVVUJmeE1J?=
 =?utf-8?B?eU94a1VPMjN5cEJaL2JFajdQZUFKTTlqV0p6UVJNMXhSVElJazh2TzRBc1FY?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E6A058842EECE49AB3C837F85460415@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6c52bd-2b24-438d-c567-08dd8ddf0181
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:18:29.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBKJDjQjtMVPfGm2971fqWqBTo4eAEBwUG3KM4WRRwMqrp+qm7xMbDVJxZq1L+aVeEyuD66Y9UXzDNR7so6Rr3RPDi57FdIYRT57OUEK4mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8710
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyOSBTYWx0ZWRfX8m5sXh2rzIg1 PNMg+cg8GGYQ+zfd2Wu0KWed+gdDsrxSbxe+1qp5mQMA4aHl3DQa+cRra6ejOkJJEZxDgpighwr 4XlDwnj+jKIAFc9HHRJDKjNhoRrIZ8IIty4dQiq7BU4/P+3RbGg454m3dzXezEyjHXiZDvrj9W5
 Y8uzZsfnm2iGyNIifdZSVP21482uh92yRstYAmLkFHZPcTaEU9hTM/J+OxmtPqU1zin0dklLOGB +F6s6ifMN9ef97MM3e7WYNd6Oi6TYjQW5rPDmOFw5h/O0MqqfSsUvj5x7lqMGxu7yTTQ9m77zZe 9AuJFCxO8XBbmTRNEeUjkePvFaVFgMeWWoIMm15LSImzu4/ZtdsaF28SyH2Eosj/tv00moBwRlH
 wScX1viNMFitaq6L8+onIQPuh9uKKfdzbMgse7hWR0VUD+WBJVsCIc0a7ll812fOIGROdcq1
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=681c228d cx=c_pps a=uiDhKFZJcG2N7b6OoV3sKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tISUIl8Q_uJPw91FU8EA:9 a=QEXdDO2ut3YA:10 a=67sPrzudLhkA:10
X-Proofpoint-ORIG-GUID: LppmQAbou5thKEA5cNZtbi8709LpTPMn
X-Proofpoint-GUID: LppmQAbou5thKEA5cNZtbi8709LpTPMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDQ6NTjigK9QTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gMDcvMDUvMjAyNSAy
MS41NywgSm9uIEtvaGxlciB3cm90ZToNCj4+PiBPbiBNYXkgNywgMjAyNSwgYXQgMzowNOKAr1BN
LCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0K
Pj4+IA0KPj4+IA0KPj4+IE9uIDA3LzA1LzIwMjUgMTkuNDcsIEpvbiBLb2hsZXIgd3JvdGU6DQo+
Pj4+PiBPbiBNYXkgNywgMjAyNSwgYXQgMToyMeKAr1BNLCBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxs
ZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+
PiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+
IE9uIDA3LzA1LzIwMjUgMTkuMDIsIFp2aSBFZmZyb24gd3JvdGU6DQo+Pj4+Pj4+IE9uIFdlZCwg
TWF5IDcsIDIwMjUgYXQgOTozN+KAr0FNIEplc3BlciBEYW5nYWFyZCBCcm91ZXIgPGhhd2tAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBPbiAwNy8wNS8yMDI1IDE1LjI5LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPj4+Pj4+Pj4+
IFN0YW5pc2xhdiBGb21pY2hldiB3cm90ZToNCj4+Pj4+Pj4+Pj4gT24gMDUvMDYsIEpvbiBLb2hs
ZXIgd3JvdGU6DQo+Pj4+Pj4+Pj4+PiBJbnRyb2R1Y2UgbmV3IFhEUCBoZWxwZXJzOg0KPj4+Pj4+
Pj4+Pj4gLSB4ZHBfaGVhZGxlbjogU2ltaWxhciB0byBza2JfaGVhZGxlbg0KPj4+Pj4+Pj4gDQo+
Pj4+Pj4+PiBJIHJlYWxseSBkaXNsaWtlIHhkcF9oZWFkbGVuKCkuIFRoaXMgImhlYWRsZW4iIG9y
aWdpbmF0ZXMgZnJvbSBhbiBTS0INCj4+Pj4+Pj4+IGltcGxlbWVudGF0aW9uIGRldGFpbCwgdGhh
dCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBjYXJyeSBvdmVyIGludG8gWERQDQo+Pj4+Pj4+PiBs
YW5kLg0KPj4+Pj4+Pj4gV2UgbmVlZCB0byBjb21lIHVwIHdpdGggc29tZXRoaW5nIHRoYXQgaXNu
J3QgZWFzaWx5IG1pcy1yZWFkIGFzIHRoZQ0KPj4+Pj4+Pj4gaGVhZGVyLWxlbmd0aC4NCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IC4uLiBzbmlwIC4uLg0KPj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gKyAqIHhkcF9o
ZWFkbGVuIC0gQ2FsY3VsYXRlIHRoZSBsZW5ndGggb2YgdGhlIGRhdGEgaW4gYW4gWERQIGJ1ZmZl
cg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93IGFib3V0IHhkcF9kYXRhbGVuKCk/DQo+Pj4+Pj4gDQo+
Pj4+Pj4gWWVzLCBJIGxpa2UgeGRwX2RhdGFsZW4oKSA6LSkNCj4+Pj4+IA0KPj4+Pj4gVGhpcyBp
cyBjb25mdXNpbmcgaW4gdGhhdCBpdCBpcyB0aGUgaW52ZXJzZSBvZiBza2ItPmRhdGFfbGVuOg0K
Pj4+Pj4gd2hpY2ggaXMgZXhhY3RseSB0aGUgcGFydCBvZiB0aGUgZGF0YSBub3QgaW4gdGhlIHNr
YiBoZWFkLg0KPj4+Pj4gDQo+Pj4+PiBUaGVyZSBpcyB2YWx1ZSBpbiBjb25zaXN0ZW50IG5hbWlu
Zy4gSSd2ZSBuZXZlciBjb25mdXNlZCBoZWFkbGVuDQo+Pj4+PiB3aXRoIGhlYWRlciBsZW4uDQo+
Pj4+PiANCj4+Pj4+IEJ1dCBpZiBkaXZlcmdpbmcsIGF0IGxlYXN0IGxldCdzIGNob29zZSBzb21l
dGhpbmcgbm90DQo+Pj4+PiBhc3NvY2lhdGVkIHdpdGggc2ticyB3aXRoIGEgZGlmZmVyZW50IG1l
YW5pbmcuDQo+Pj4+IEJyYWluc3Rvcm1pbmcgYSBmZXcgb3B0aW9uczoNCj4+Pj4gLSB4ZHBfaGVh
ZF9kYXRhbGVuKCkgPw0KPj4+PiAtIHhkcF9iYXNlX2RhdGFsZW4oKSA/DQo+Pj4+IC0geGRwX2Jh
c2VfaGVhZGxlbigpID8NCj4+Pj4gLSB4ZHBfYnVmZl9kYXRhbGVuKCkgPw0KPj4+PiAtIHhkcF9i
dWZmX2hlYWRsZW4oKSA/DQo+Pj4+IC0geGRwX2RhdGFsZW4oKSA/IChaaXZFLCBKZXNwZXJCKQ0K
Pj4+PiAtIHhkcF9oZWFkbGVuKCkgPyAoV2lsbGVtQiwgSm9uSywgU3RhbmlzbGF2RiwgSmFjb2JL
LCBEYW5pZWxCKQ0KPj4+IA0KPj4+IFdoYXQgYWJvdXQga2VlcGluZyBpdCByZWFsbHkgc2ltcGxl
OiB4ZHBfYnVmZl9sZW4oKSA/DQo+PiBUaGlzIGlzIHN1c3BpY2lvdXNseSBjbG9zZSB0byB4ZHBf
Z2V0X2J1ZmZfbGVuKCksIHNvIHRoZXJlIGNvdWxkIGJlIHNvbWUNCj4+IGNvbmZ1c2lvbiB0aGVy
ZSwgc2luY2UgdGhhdCB0YWtlcyBwYWdlZC9mcmFncyBpbnRvIGFjY291bnQgdHJhbnNwYXJlbnRs
eS4NCj4gDQo+IEdvb2QgcG9pbnQuDQo+IA0KPj4+IA0KPj4+IE9yIGV2ZW4gc2ltcGxlcjogeGRw
X2xlbigpIGFzIHRoZSBmdW5jdGlvbiBkb2N1bWVudGF0aW9uIGFscmVhZHkNCj4+PiBkZXNjcmli
ZSB0aGlzIGRvZXNuJ3QgaW5jbHVkZSBmcmFncy4NCj4+IFRoZXJlIGlzIGEgbmVhdCBoaW50IGZy
b20gTG9yZW56b+KAmXMgY2hhbmdlIGluIGJwZi5oIGZvciBicGZfeGRwX2dldF9idWZmX2xlbigp
DQo+PiB0aGF0IHRhbGtzIGFib3V0IGJvdGggbGluZWFyIGFuZCBwYWdlZCBsZW5ndGguIEFsc28s
IHhkcF9idWZmX2ZsYWdz4oCZcw0KPj4gWERQX0ZMQUdTX0hBU19GUkFHUyBzYXlzIG5vbi1saW5l
YXIgeGRwIGJ1ZmYuDQo+PiBUYWtpbmcgdGhvc2UgaGludHMsIHdoYXQgYWJvdXQ6DQo+PiB4ZHBf
bGluZWFyX2xlbigpID09IHhkcC0+ZGF0YV9lbmQgLSB4ZHAtPmRhdGENCj4+IHhkcF9wYWdlZF9s
ZW4oKSA9PSBzaW5mby0+eGRwX2ZyYWdzX3NpemUNCj4+IHhkcF9nZXRfYnVmZl9sZW4oKSA9PSB4
ZHBfbGluZWFyX2xlbigpICsgeGRwX3BhZ2VkX2xlbigpDQo+IA0KPiBJIGxpa2UgeGRwX2xpbmVh
cl9sZW4oKSBhcyBpdCBpcyBkZXNjcmlwdGl2ZS9jbGVhci4NCg0KT2sgdGhhbmtzLCBJ4oCZbGwg
c2VuZCBvdXQgYSB2NCB0byBjb2RpZnkgdGhhdC4NCg0KPiANCj4gDQo+PiBKdXN0IGEgdGhvdWdo
dC4gSWYgbm90LCB0aGF04oCZcyBvay4gSeKAmW0gaGFwcHkgdG8gZG8geGRwX2xlbiwgYnV0IGRv
IHlvdSB0aGVuIGhhdmUgYQ0KPj4gc3VnZ2VzdGlvbiBhYm91dCBnZXR0aW5nIHRoZSBub24tbGlu
ZWFyIHNpemUgb25seT8NCj4+IA0KPiANCj4gSSd2ZSBub3QgY2hlY2tlZCBpZiB3ZSBoYXZlIEFQ
SSB1c2VycyB0aGF0IG5lZWQgdG8gZ2V0IHRoZSBub24tbGluZWFyIHNpemUgb25seS4uLg0KPiAN
Cj4gQSBoaXN0b3J5IHJhbnQ6DQo+IFhEUCBzdGFydGVkIG91dCBhcyBiZWluZyBsaW1pdGVkIHRv
IG9uZS1wYWdlICgicGFja2V0LXBhZ2VzIiB3YXMgbXkNCj4gb3JpZ2luYWwgYmFkIG5hbWUpLiAg
V2l0aCBhIGZpeGVkIFhEUF9IRUFEUk9PTSBvZiAyNTYgYnl0ZXMgYW5kIHJlc2VydmVkDQo+IHRh
aWxyb29tIG9mIDMyMCBieXRlcyBzaXplb2Yoc2tiX3NoYXJlZF9pbmZvKSB0byBiZSBjb21wYXRp
YmxlIHdpdGgNCj4gY3JlYXRpbmcgYW4gU0tCICh0aGF0IGNhbiB1c2UgdGhpcyBhcyBhICJoZWFk
IiBwYWdlKS4gIExpbWl0aW5nIG1heCBNVFUNCj4gdG8gYmUgMzUwMiAoYXNzdW1pbmcgRXRoKDE0
KSsyIFZMQU4gaGVhZGVycz0xOCkuDQo+IFRoZXNlIGNvbnN0cmFpbnRzIHdlcmUgd2h5IFhEUCB3
YXMgc28gZmFzdC4gIEFzIHRpbWUgZ29lcyBvbiB3ZSBjb250aW51ZQ0KPiB0byBhZGQgZmVhdHVy
ZXMgYW5kIHBlcmZvcm1hbmNlIHBhcGVyLWN1dHMuIFRvZGF5LCBYRFBfSEVBRFJPT00gaGF2ZQ0K
PiBiZWNvbWUgdmFyaWFibGUsIGxlYWRpbmcgdG8gY2hlY2tzIGFsbCBvdmVyLiAgV2l0aCBYRFAg
bXVsdGktYnVmZmVyDQo+IHN1cHBvcnQgZ2V0dGluZyBtb3JlIGZlYXR1cmVzLCB3ZSBhbHNvIGhh
dmUgdG8gYWRkIGNoZWNrIGFsbCBvdmVyIGZvciB0aGF0Lg0KPiBXQVJOSU5HIHRvIGVuZC11c2Vy
czogWERQIHByb2dyYW1zIHRoYXQgdXNlIHhkcC5mcmFncyBhbmQgdGhlIGFzc29jaWF0ZWQNCj4g
aGVscGVycyBhcmUgcmVhbGx5IFNMT1cgKGFzIHRoZXNlIGhlbHBlciBuZWVkIHRvIGNvcHkgb3V0
IGRhdGEgdG8gc3RhY2sNCj4gb3IgZWxzZXdoZXJlKS4gIFhEUCBpcyBvbmx5IGZhc3QgaWYgeW91
ciBYRFAgcHJvZyByZWFkIHRoZSBsaW5lYXIgcGF0aA0KPiB3aXRoIHRoZSBvbGRlciBoZWxwZXJz
IChkaXJlY3QgYWNjZXNzKSBhbmQgaWdub3JlIGlmIHBhY2tldCBoYXZlIGZyYWdzLg0KPiBXZSBh
cmUgc2xvd2x5IGJ1dCBzdXJlbHkgbWFraW5nIFhEUCBzbG93ZXIgYW5kIHNsb3dlciBieSBwYXBl
ci1jdXRzLg0KPiBHdWVzcywgd2Ugc2hvdWxkIGNsZWFybHkgZG9jdW1lbnQgdGhhdCwgc3VjaCB0
aGF0IHBlb3BsZSBkb24ndCB0aGluayBYRFANCj4gbXVsdGktYnVmZmVyIGFjY2VzcyBpcyBmYXN0
LiAgU29ycnkgZm9yIHRoZSByYW50Lg0KDQpObyB3b3JyaWVzIG9uIHRoZSByYW50LCBhbmQgSSBh
cHByZWNpYXRlIHRoZSBjb250ZXh0LiBNeSBtdWx0aSBidWZmZXIgam91cm5leQ0KaXMgZXhwbG9y
aW5nIHRoZSBwb3NzaWJpbGl0eSBvZiB1c2luZyB0aGF0IGFzIHRoZSBtZWNoYW5pc20gdG8gYmF0
Y2ggdXAgbGFyZ2UNCnBheWxvYWRzIGZyb20gdmhvc3QvbmV0LCBhcyBzbWFsbCBwYXlsb2FkcyBo
YXZlIHRoaXMgc2xpY2sgWERQLWJhc2VkIGJhdGNoaW5nDQptZWNoYW5pc20gdGhhdCB0aGVuIGRl
cXVldWVzIHRoZSBiYXRjaCB0aHJ1IHR1bl94ZHBfb25lLCBidXQgbGFyZ2UgR1NPDQpwYXlsb2Fk
cyBnbyBkb3duIGEgc2xvd2VyLCBub3QgYmF0Y2hlZCBwYXRoLCBhbmQgYWxzbyBmb3JjZSBhbGwg
b2YgdGhlIHNtYWxsDQpwYXlsb2FkcyB0byBmbHVzaCBmaXJzdC4NCg0KSSBoYXZlIGl0IGhhbGYt
aXNoIHdvcmtpbmcsIHNvIEnigJlsbCBnZXQgbW9yZSBleGNpdGVkIChvciBub3Q/KSBhYm91dCB0
aGF0IGxhdGVyLg0KDQo+IA0KPiANCj4+PiANCj4+PiBUbyBKb24sIHlvdSBzZWVtcyB0byBiZSBv
biBhIGNsZWFudXAgc3ByZWU6DQo+Pj4gRm9yIFNLQnMgbmV0c3RhY2sgaGF2ZSB0aGlzIGRpYWdy
YW0gZG9jdW1lbnRlZCBbMV0uICBXaGljaCBhbHNvIGV4cGxhaW5zDQo+Pj4gdGhlIGNvbmNlcHQg
b2YgYSAiaGVhZCIgYnVmZmVyLCB3aGljaCBpc24ndCBhIGNvbmNlcHQgZm9yIFhEUC4gIEkgd291
bGQNCj4+PiByZWFsbHkgbGlrZSB0byBzZWUgYSBkaWFncmFtIGRvY3VtZW50aW5nIGJvdGggeGRw
X2J1ZmYgYW5kIHhkcF9mcmFtZQ0KPj4+IGRhdGEgc3RydWN0dXJlcyB2aWEgYXNjaWkgYXJ0LCBs
aWtlIHRoZSBvbmUgZm9yIFNLQnMuIChIaW50LCB0aGlzIGlzDQo+Pj4gYWN0dWFsbHkgZGVmaW5l
ZCBpbiB0aGUgaGVhZGVyIGZpbGUgaW5jbHVkZS9saW51eC9za2J1ZmYuaCwgYnV0DQo+Pj4gY29u
dmVydGVkIHRvIFJTVC9IVE1MIGZvcm1hdC4pDQo+Pj4gDQo+Pj4gWzFdIGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZG9jcy5rZXJuZWwub3JnX25l
dHdvcmtpbmdfc2tidWZmLmh0bWwmZD1Ed0lEYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9
TkdQUkdHbzM3bVFpU1hnSEttNXJDUSZtPS1nRmpJbzZsTUpWbXhvR1RyTzk5RllUbENpMEtkdGh4
RnVTUnYxbmFzakJJLXFKcnFkQnVRRFROMVRyWEFyckQmcz1YMTZ6c1BKX2xKd0xnSmpLSkh2S1Z6
TUZrdUFqRWd5WllmRHNvQ1Z1Z3lZJmU9DQo+PiBJIGNlcnRhaW5seSBhbSBpbiBhIGNsZWFudXAg
c29ydCBvZiBtb29kLCBoYXBweSB0byBoZWxwIGhlcmUuIEkgc2VlIHdoYXQNCj4+IHlvdSdyZSB0
YWxraW5nIGFib3V0LCBJ4oCZbGwgdGFrZSBhIHN0YWIgYXQgdGhpcyBpbiBhIHNlcGFyYXRlIHBh
dGNoLiBUaGFua3MNCj4+IGZvciB0aGUgcHVzaCBhbmQgdGlwIQ0KPiANCj4gVGhhbmtzIGZvciB0
aGUgY2xlYW51cHMuDQo+IC0tSmVzcGVyDQoNCg==

