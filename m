Return-Path: <bpf+bounces-57728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6CAAF183
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3E99C68B2
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BEB1F4736;
	Thu,  8 May 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NopgMoml";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="t0mDWFdP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA136F4FA;
	Thu,  8 May 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674418; cv=fail; b=M9xOY0aadx/IdVLS4yoC4litkkx4kUrPM2wgmIMmCHA3xdi+XMSwFly4/CoxGzIE32wic1awt5LdPNbqgkADPtb0MeipuApzKR311/XIFO42rVgRIHW5XQAs4Wp+iS++G8grmCrfKxqZwh1MahoUF9IPBACwU3svTq2eRyqyt20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674418; c=relaxed/simple;
	bh=eneAIfVYRxqwUDJmi5uqIPtNAaQx3AClj5thJvTVtg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQDjCNAXgeGSGzsDSst4oLMrGJPfmTRsXrY8s6vuj8WCN+yyBnAH9IX87Hr3Er7RpV7LlyHBHYJ0z4QGfFu3jpV8zVxZl73Fy3YVw4fIEQg6N+ECorMVdBGRkaq/G0YSAsJZ0i8TW4IaeEa5oExh1f46Rk74+v4s6OJwXf73rZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=NopgMoml; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=t0mDWFdP; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LLYNf025617;
	Wed, 7 May 2025 20:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=eneAIfVYRxqwUDJmi5uqIPtNAaQx3AClj5thJvTVt
	g0=; b=NopgMomlgzOlawTqLumNWPtp93JTEETkSA7091QIRG14B1gwogHf62L2R
	WPlVLPHQ2jXgbYh0v/uLbPaEJm17EoI0FmkDLvvFAnMYFEnTdHph/xIwOLI0/U/h
	355XsAFIy1BP6Hw7J5IokQ1m1LJ+op2+O57JhrxCw0SiKWYX+ABrYytMykTnwaKf
	Oa7G0cgf8KPVNw1NIr2zjjg5X8RblZzDRjgqwOcL3V2NhvcfS5EhhJ1ZgVUKba+M
	mZ3xAN8lfr63vaBWiYI3nxr5UmsYjxX4lH88eUFKUGwLFQGYUeXjbBgqouVGINdK
	zgnG/4NAF/3uHYnG3a9uScfumWWig==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djp12jmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 20:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bekF0aOc9ijoF+3Wl4uX6QahO4EdWh0nbD8BetdfaY1mhjVdMKER1tZmmmLPht/gAjFkv7R0Lb1kih6NDv6l+NupLxk5lznHZNWL1dPmPVeQFShj7tV8RBtHEzgpL4ty8tZyDGcc+/fhLIFRcOD0C6M3JoMGCdY2yTi5V2zl0W1FuoDtXj3BRtOTM8iFe6ZaKFIqcOMIy/6GygOdlT1rFk4m/Q1kNp2McyyOYgGEEP7YXmJavIw/D898uKjKfTVSsx9y5rJuNMjrtxTSMKxWzXnpKF64hARvXunyZCbeNHhivJDF7OICeywcNhPVkZTaZU/xNSjhEzj+X1R7SB02Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eneAIfVYRxqwUDJmi5uqIPtNAaQx3AClj5thJvTVtg0=;
 b=klbm3hK2bimb5kSP9q+dUPmlXoyF4PbsmBWdZlLGRPJ1rqYprKKiOYlj3PRJvMs6lxTWfmZejjKzNCk+Sn5EHmmpIpaBTxVj3CJ2Mn9QC1/PfoxuMVyat6d9iEinD4v8hWk2QzmHheABGpp7IVvj896zjjiHhNyum80/aEmQfq004aXcQdPKTIGOzktR9f4YikzmtNZlZBHly++xqog7ae78PzeaeWx4LB14P7SInxc9Fmo+JgZQ83OLP456aNLCWtQxBokD0RAa8RpGQmTH73wFf7yIQ9JH1J4SbRYObAmhLaeeUVUsE3gouAW4lQAxDkv3BNn/yInUOmerce5Gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eneAIfVYRxqwUDJmi5uqIPtNAaQx3AClj5thJvTVtg0=;
 b=t0mDWFdP38LTivbs5HUoJ+7UAKbm9lBIonzBqAGNu+LUQin04kAj+yzrjcPFhELRYK1OcthXVXVq2FfaIh9cb8Al8ftsauIHM6pdEvf/Fmc8NDlpwsNU+Yt9l1oWpkp5mMcJsxM94q2v6SNhnZuERbUUxkR4LrcBL6euIc+v5MN4IvVcTTvD3c9+JQ5p3dN5ZIKu83m1UYZ3joK1krXrRAFDy5q9P96R7kKjSCvJhrbbJDvPLwac3ViGY68OGEY0CISBploYJz5gK3CJLn9pzQnnIRllcxGI4wiZmZTpUx44xRwxLfL/CRV6BjwnIeZBZN4ACeg9PjGXlVSEiQNCsQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SN4PR0201MB8710.namprd02.prod.outlook.com
 (2603:10b6:806:1e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Thu, 8 May
 2025 03:19:43 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 03:19:43 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Alexei
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
 AQHbvoGOtDW/U9ulski7jan4/mWqq7PF36QAgAFLeACAADQMgIAAB1MAgAAB2wCAAAOsgIAABy6AgAAVnoCAAA6GAIAAET6AgAA33YCAADKWAA==
Date: Thu, 8 May 2025 03:19:42 +0000
Message-ID: <2121D2EF-E554-4DCB-BB6A-93FB3975B064@nutanix.com>
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
 <20250507171829.3e8f8a76@kernel.org>
In-Reply-To: <20250507171829.3e8f8a76@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SN4PR0201MB8710:EE_
x-ms-office365-filtering-correlation-id: ebe5877f-a267-4fbe-4acd-08dd8ddf2d18
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUVWa1djWGt1YjBmRjJtNDkyL1ZTR0w4VzR2K25MUVhjVzh4dkJwQWZkbUJi?=
 =?utf-8?B?Q3FUREp0Q1d0a0RYcnhBb1pxMS85eFd2NVNnQ2RaL0Npa21xK2pSOXpqTkxQ?=
 =?utf-8?B?RzB3WW91UlZwUVdEbDR5NTNHM0wwRXlkditjektpMUV0MlJaRDBNUUVKOEFw?=
 =?utf-8?B?U05pN0dId2JVdXFBWDR5Q1UyanQ2UHBueDJ5LzlKaWN3QnpUMWlCd1oyMlpD?=
 =?utf-8?B?WUJsblB3RzFKcmVObHp4cVl4SUxjdHhxYlZKSHpuZ2lUQjVCbWNqTDh4Qjdq?=
 =?utf-8?B?L01BTnU0M1pzR1k4Ykp2TzgydUlXYWVHZS9tN2wxRTF0N1N3c0xIWGpoWUJL?=
 =?utf-8?B?MVdLQklZNURUZGJDdmdQajFTTEEzeGt6K1JZcWJqVGRzT2xWMHNXVytnZHVy?=
 =?utf-8?B?R3dmSWxmaFhOWGh1cmY0ZDNLRWZWekcwTWwxcjFUeXVrNG55S3BzTWxGRmFP?=
 =?utf-8?B?RisxUmtkRGdjVWpkcXNnMWpVc0Zad3F5N0tydUEvU1Zsc1pwaVRhMWFwVmov?=
 =?utf-8?B?RjZQRlgra2dFTG93ZmM4eUlDdGh3dVJKclIyNE1mUmlWL3lQa3h4LzZwdzIy?=
 =?utf-8?B?SVhDTW0yNUNISURHQjNqSHNZemNqYTN5dDJiWHZGSkMyWDBWVGlKWU1oK1pq?=
 =?utf-8?B?dThEQ21lbVFZcHQyWXJVeDc5cVUyOTVzOXNSelpydUxEdU1hMUdQR1RUMk11?=
 =?utf-8?B?S3d2YUdQSXpIbUtZVnI4dXhmbTBmVEFDUlRUeUVNTlVVWHErUjdFcWFWZXRZ?=
 =?utf-8?B?TnREdjJETFNseTUweS81aEkvSDIrajJ0aUFJREozRC9LZmRMZnVZc2FjeW5s?=
 =?utf-8?B?Q21SV1pYZTJIeThralREZnhMMG53NWlSMUhGYzBtTjA0aUQ1QzkwOXFMR3VH?=
 =?utf-8?B?WnhUODkvSDlOc1Q4dmhwbm9RYWx0UUhCSlBoS29xVmQzSDM4Q2VEcHRPR25v?=
 =?utf-8?B?czdEb1VORkdyVk5HWDFhZDVvWHJXU2FaLzZxa2UyMXp5ZFM0OFlrMnVPMWZZ?=
 =?utf-8?B?ckptZWxibjMwcjNQakxYdHlCTWJSZFpQT1V4Nmo4WC9XTTJWQ011eXIrY0tj?=
 =?utf-8?B?T1diK1Z2OGNQRjFCbmtudlRHVUVYdTJyNDFsaFVOUDFycWYwNC9sN2Z6Y1Mv?=
 =?utf-8?B?OEV5dk5yalU2bS9DcGVRa0NjZlRvL3IrczZaakFjSUx4cGhDek9ySkpVUFZ6?=
 =?utf-8?B?YjlYWnlUdFNVNFJhbmlGbk5ITWZNeWk4UUdPSEZXNUZCZ25ReHBxMVlubVNn?=
 =?utf-8?B?ZjB5cEFNVm1BNTlOY2htNkxEK0l1V0FOSHV6MmpUay9vdVdCSUU3dStrRlNF?=
 =?utf-8?B?bThndUZpSXJBbDI5N3VpWG5pQjVXL0Z1OHMxakJxL2U1Z1RqMFRGU3B0V2Fn?=
 =?utf-8?B?dW9TRGxxeGtyUVp3cmwvajdwbjhpRlYrbFhnVjB2UE5ZaWFFR0pCRDEvOEE2?=
 =?utf-8?B?L2IvWTRxNHFSalZidU5YYndDYWpPRUFnZGNYK3QrZFc4ZE81WHJGa2RSQklG?=
 =?utf-8?B?NmVXeE81MUhPU2hXYUpndVo2c3Y1cUZKQit6aWRIU2tYQUhrZk0vOXFqNGI1?=
 =?utf-8?B?ZC8rTTFhQ2NVTlAxYUJLbFBPV0pIODdTR2JEaUpMWGFGSGxOUTlLODRGbXNQ?=
 =?utf-8?B?aTgxczdqZnRsME82MjdvV2FabWVxSnBhNmlaTEw2dUwvd1g5SThTU0hLM0xZ?=
 =?utf-8?B?b2kwWjJNaVl6clkvdXZtcWYzbzBrbW9XdFFBV0duYlNNTlVlcUFUSnNxaFFW?=
 =?utf-8?B?QWxCNTMxcDNSazFEZURrNS9HenZ0WjN4Zk9neUV1bzZEdSs3a0R4SHJoTFdB?=
 =?utf-8?B?cDc3Qk5FZFFZNTFvSjNkcTd4bVRDQ28zL3hnQ0RzVzdEN3ZqMm5OdXJYMzJE?=
 =?utf-8?B?Qk1Ya3RBM3FLb25HYTlQclVZcVM5R0pzeEYreGFkNXdLOVk0aTBrU2NBZTVw?=
 =?utf-8?B?ZThFU2JYMlhKNzFWQVY0T1RhN3ByNXVUdk02TDFmblMrQU16S2dCZEZtOGhw?=
 =?utf-8?B?cHNsNFlTZHJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnJFZVVRVmU4QXVhNDVoUE5INDJqUWZNZUgrS2NRQm5vUVJnUXB4VEE5dDNU?=
 =?utf-8?B?Tko2OHN1NEpQZ2dMVys4UDRxL0t6anNENythK3ZMdnJMNlM2WWYrSVpteTE2?=
 =?utf-8?B?SzMzaGVXS3lzaE8wY2E5S1BHVVVBWFc0WUdHQ1Z3ZnlFNTVCNVFBMDVEd25W?=
 =?utf-8?B?a3hCbnNHZUdpTGlWVU45Z0hacURUZG1rMklvRWhyRUpzRUJpMFdiRExCM00y?=
 =?utf-8?B?ckd1Tk8xd05ZR0VVVEVXaGRVd3FuV295VzU4VmpYWkJqZFR2blc2K25uK0lv?=
 =?utf-8?B?TlRDOEhCY243WmMrUWF6bVFSK3Q1eE1XbkVYb0Z0SU4weXNVTWhwcGlueTl6?=
 =?utf-8?B?VkkrQmRja1hsMm5xVlJYVVpjRkEzTm1VZXZHZXN1djhqUldLUndQY3JpK05O?=
 =?utf-8?B?TlRWQ0piQURXS3pTU1E3UUxvQkpQNWNySlFiTHZCRFR5NkxoWmcwY0lueWNz?=
 =?utf-8?B?T1R3di9UQ2QwcWJuK3d4UGpHZVBVVVVnRkt4eTA2ejhFbjZDMEFZbUJURVNS?=
 =?utf-8?B?ZHZud2FpaEFmOExjelZvTzM3dDVZeTVtbytWYjVpRm95cW9BeFptNVEwcmQ3?=
 =?utf-8?B?Z0FuSlRIMEM0N1lXS0RmaG5zdHhMZy9hV2UwSU9ERVVqMnVRUVVoWnBscWQr?=
 =?utf-8?B?L0FZTXFxSmJUbTlFQ05KbnRzVkNxb1E2aW9vM1RPU0VyZWk2OTJpRDA5THRy?=
 =?utf-8?B?U3RUYnJ1TW9BK3A5U1dRbkNvYzN0ZFZOWk5mN3l2K0trTDhHMzFYWTZBNzVE?=
 =?utf-8?B?amFNb3B6YTNRSXhmVjlOYVNYYjhuQVhjaTR3ZDF5ZzdlRTdTM1hTaTQxRXFW?=
 =?utf-8?B?ZnZwa1dnZ0xRcjdidFUvL1lxVEMxRWRVdHNvR01kSHQyNlcwdElPam1CTkNU?=
 =?utf-8?B?ZXNmcGo5WVJZNHRpUGZheWlzODJQTTY3N0lsZ0dBdXd3aWpDQk44ZGlXYWVC?=
 =?utf-8?B?QjhiYVNKOERxclBGbSs4THJCd2hQMitadFg4WVhsZURBQkhTUkxPS1prMHBm?=
 =?utf-8?B?QmkxelR3a3l3Nmp0dVNsZEUrS1BUZUlEZjJxU2pyVWpJMTQ4WDRjc2NPMm9h?=
 =?utf-8?B?UVZuQ2NtQlgwNEs3Tk5pZ1djdDM0UHViUFh5YTd6YVlSV055SGF1eUQ4WjFK?=
 =?utf-8?B?SVJKZUFJUkNhOFhSY1greUNRdjRBVWtlKzFYY21CamROZFNFYkVRUHppR3A1?=
 =?utf-8?B?ckI2L1VvWHd5Y2VaVmdWeklGOUNRUFVNdW1CRnZFSTcyTmhGNFhYaVZwV3VE?=
 =?utf-8?B?Y2o0NjlLM0hic1NwRXpYUGdlY3ZNUGdRZkFaUElQeHYzQTlmRSt1M2VYSVdk?=
 =?utf-8?B?V2dxSk5kNFZod0RQeFh0K20yZTJLbGhUcWR0M1k3SHo5OFMxRnM1SThpNUhl?=
 =?utf-8?B?N3pZOFJWRkR1eXRvKzBwcEtqa2NsZFJXcnB1QmtMSFN5M0prZEhOdjBzSVZV?=
 =?utf-8?B?eTVHYVRIc2hZYXYraktabmxMcm11R2drRzdoWFJza3BzVnlTcmwxbFg3ZlZP?=
 =?utf-8?B?bzBPY0xoaWZ3dE1zNXREUlBUNGYyMEdjcmovQkZ6Q1gvelJkOGU4WmZtTlhY?=
 =?utf-8?B?SUU4alZZZU12cWtIQ2xvRTdrY0pQbDhRVVVTL2lpaUo5Y05UZjh6L2pNaGlD?=
 =?utf-8?B?QjM2K0dGc0hhMHcya2s4dG4rTDBaN0I3QVVkazJXNExPTFZFaUdCMnFQbVhw?=
 =?utf-8?B?OWRJWE9QVnNBMGFSZEF3S2RPZ1d4R0l4aFRreWo2cHJVempxcHFNbVRwT2NY?=
 =?utf-8?B?TzdQNFphcU9Xc3M0eDFNS2hNZWhaUDRFb1pTYUcvUVVsVUc0VGJBd2NkUUR1?=
 =?utf-8?B?bERrK3FPam83Y2s1aDVrNFdGWGVyQmFSdmQ1ZFdldzhjRnBnbXBmazZDbE5j?=
 =?utf-8?B?TG5TbStYM0x2aXBHbXltYm8rTVBpZXFudUMrYlVoTDN2ekVtU2hjMFhQZ3gv?=
 =?utf-8?B?K1dYd0tKMjREbkszYWJPV3NhT3Q3VVhEaWhleHJuTmRKYnBIUmluWGVzQ2ZI?=
 =?utf-8?B?eldKQzdGUDlBQk91cG55WG41Q3NtTmZiVVd1VU1kUHBTODR0SlpaTHc5NFJF?=
 =?utf-8?B?L1F0VFZFOXZtY0g0Z0ovTFU0d2dITytMMWV3dHRPQWlCTEZIcncvalJLMjhV?=
 =?utf-8?B?bDZGa2h2N3huaE1YS2UzT2d2OWx3Y1d4QUpEekFid1JIV2ZHOER4YkJzKzZo?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D6CE7347723144580909E1B37428788@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe5877f-a267-4fbe-4acd-08dd8ddf2d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:19:43.0125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CIgjAWWonEtG0atkC2vEh2IVkhQKw63QdV7ItyJZHQihE1Z7BQ398zwFc8SvkzdSSpdKfOkjmUkBuprQo/wGKbSUSilvv6+ccWRDIsz3Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8710
X-Proofpoint-ORIG-GUID: DwOb33Fr4uzOWV1DvvSfR9mR4UttK98Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyOSBTYWx0ZWRfX7UIO4awav7EE EXI1xzEg8ctoHpEFwrNezBYRxZ5TiRI4gdQFbgpZQS0AlMPksjoK/DETAUsRR5k34SEp29xPeN2 u88hccxtS7vCCNJfHqrWMOgw5fijn+BHDXWgxsp4zZUAcEn9fisa9Ck5LnNgc8eamEKkUqwVZV/
 VkqKHPgxIkIGh+TwbLw0jYsud6qW0nL8Xb29Vb9v0KAhkoBl4vo2FwFT93xCJEOCSy06QqpE6AP 7Gencp6+7ZSHaoC06lH993Cz2vP529d2+pnrf1kzwJbyrYaOVTmCFBIYqrAOJRMhdRGzbc7G6bX mGa6ZAu9QLSIpUI1Oopu1omMizM+kJs9TYlSIFkZ8uuGqMBe7PziJ+DfPJ1G3Nf+mKnQBgpjqdG
 CKGydvZLEo99WMolENxbrTW6Hm5X2YvBRWvietiW8Xm5lYM9ZgKmP+sMukj08RyKLsk8KscM
X-Proofpoint-GUID: DwOb33Fr4uzOWV1DvvSfR9mR4UttK98Q
X-Authority-Analysis: v=2.4 cv=J5yq7BnS c=1 sm=1 tr=0 ts=681c22d1 cx=c_pps a=GHJUnOcs406mhZkDzxAeiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=F8AXsVzP4kXpIRP8dGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDg6MTjigK9QTSwgSmFrdWIgS2ljaW5za2kgPGt1YmFA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDcgTWF5IDIwMjUgMjI6NTg6MzMgKzAy
MDAgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4+PiBUaGVyZSBpcyBhIG5lYXQgaGlu
dCBmcm9tIExvcmVuem/igJlzIGNoYW5nZSBpbiBicGYuaCBmb3IgYnBmX3hkcF9nZXRfYnVmZl9s
ZW4oKQ0KPj4+IHRoYXQgdGFsa3MgYWJvdXQgYm90aCBsaW5lYXIgYW5kIHBhZ2VkIGxlbmd0aC4g
QWxzbywgeGRwX2J1ZmZfZmxhZ3PigJlzDQo+Pj4gWERQX0ZMQUdTX0hBU19GUkFHUyBzYXlzIG5v
bi1saW5lYXIgeGRwIGJ1ZmYuDQo+Pj4gDQo+Pj4gVGFraW5nIHRob3NlIGhpbnRzLCB3aGF0IGFi
b3V0Og0KPj4+IHhkcF9saW5lYXJfbGVuKCkgPT0geGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YQ0K
Pj4+IHhkcF9wYWdlZF9sZW4oKSA9PSBzaW5mby0+eGRwX2ZyYWdzX3NpemUNCj4+PiB4ZHBfZ2V0
X2J1ZmZfbGVuKCkgPT0geGRwX2xpbmVhcl9sZW4oKSArIHhkcF9wYWdlZF9sZW4oKQ0KPj4gDQo+
PiBJIGxpa2UgeGRwX2xpbmVhcl9sZW4oKSBhcyBpdCBpcyBkZXNjcmlwdGl2ZS9jbGVhci4NCj4g
DQo+IEZXSVcgSSBkb24ndCBmZWVsIHN0cm9uZ2x5IGJ1dCBteSB2ZXJ5IHdlYWsgcHJlZmVyZW5j
ZSB3b3VsZCBiZSANCj4gbm90IHRvIG1lcmdlIHRoaXMuIEkgYWxyZWFkeSBrbm93IEknbGwgYmUg
bG9va2luZyBhdCB0aGUgZGVmaW5pdGlvbnMNCj4gZXZlcnkgdGltZS4gSXMgaXQgb2J2aW91cyB0
byBldmVyeW9uZSBpbiB0aGlzIHRocmVhZCB3aGV0aGVyICJoZWFkcm9vbSINCj4gaW5jbHVkZXMg
dGhlIG1ldGFkYXRhIGxlbmd0aD8gSXQncyBub3Qgb2J2aW91cyB0byBtZS4gQnV0IHRoZSBwYXRj
aA0KPiBzZWVtcyBxdWl0ZSBwb3B1bGFyIHNvIPCfpLfvuI8NCg0KSmVzcGVycyBzdWdnZXN0aW9u
IHRvIGhhdmUgYSBET0M6IG9uIHRoaXMgaG9wZWZ1bGx5IHdpbGwgYmUgaGVscGZ1bC4NCg0KSeKA
mWxsIHRyeSBteSBoYW5kIHRoYXQgdGhhdCBhbmQgc2VlIHdoYXQgc29ydCBvZiB0cm91YmxlIEkg
Y2FuIGdldCBpbnRv

