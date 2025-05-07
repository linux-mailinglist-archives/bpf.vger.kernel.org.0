Return-Path: <bpf+bounces-57701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E1AAEC8E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CF57B959B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA128E5F5;
	Wed,  7 May 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="V8cSupMp";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Iith8/rf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1619CD07;
	Wed,  7 May 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647867; cv=fail; b=mRcpkUzrxDh/IuDeOOcWJuuLom7VSbaQSCZQlcNf9PV3eotXa7u3bULCmyMtRgQnfIF02DANfWtEeyNKsHvy09UFWi/Cm8nZSokz23UFMNXKc/Dho+6cQN3xMZ/06Z4JesRme/nj9nw9ul1Cibag8QapSlrElqzZZM7nOwCk/fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647867; c=relaxed/simple;
	bh=bPxmfl24c8GkJTpXXzk27ultx8wBzcsprwSwhMFdL9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lvc3fqosVUAkDKtj6sAjHQYBlHzEvB7iE13lw6C8mMvInAdXErueBp+L5gFg+WhbpCHDnF8LU2OyGfJg3HKkp/b0uPPybOYrSAo/Lb61KzbWeOjvU5U0HMNBivniPy0tx0csbFhw5Bxq9d/Hb5vnx2yytf9u4JpGBTe0JBbO5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=V8cSupMp; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Iith8/rf; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547E8m6j020767;
	Wed, 7 May 2025 12:57:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=bPxmfl24c8GkJTpXXzk27ultx8wBzcsprwSwhMFdL
	9c=; b=V8cSupMp4yw/pHDylSDO483gH7DKK7KWxbCTqwyFZcZXdo6U3Ag+zABg3
	Cms3/pgJL+hBF7JvB95TxkpyXK4Etu9DU7Xi/BQhdnwafZRbhItbUCoomuj/63oi
	vX9ww6yH5YnWTdxkRfmL436OQsqxw3RGcUYfhjtwYWLryqUJ5KekiDVjijMsHV5Q
	/LmUKvg9wrJutSc5dmgrjuxt/5WLBg8MXotKn3uRGoROxSCocPiN1phQOZxFTGPX
	MRCothlxbInnTPRffjHB2BYrANaLguzAqfGTAwxiq6KiXTdqC5STi509v7IscEZs
	yrJmru+KyN2suJyQ/BlKpHRoimzEA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djp11uk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZrajYwBQqJ+CYnUmPwEYwvA7cbLl16r4zl/dgAgiXxw4n9edT8Jc8N7+Mn6y4aR9cXDOZoXf2qWloVX+PaEGOt/rMWp6Pexz7d6A1HLAq+qlb/4TouODTxq8HjYv3TF9PF2hvClKVBy9970VmSd1NEZHiUIxuB65UaQafdC40wtsLd1jCqwxn71ZJhB09SmF5gTtn8Wkurc5LH3RA8GJgcNzjmqY5xqqd8Etb6oD695lqBe1L8eActqDAFNZVQ2Vo+lNmswN0n2xkf+6eigVgsI6kehq2n49+p3ZdkHYuDNKIqWnrvlVoZjuNwuACUOsQiKa6HhwZm+P+K8u5wNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPxmfl24c8GkJTpXXzk27ultx8wBzcsprwSwhMFdL9c=;
 b=vZ69iRzQDeDJEq6OZ5IceflO973VBKP/NrhX/ZyW1nU1Tju+t9Fh2mYKmalXIb1tyEh9BgY2oRIB4TOGN2+7GrAY7r95muWgxiZRr1cdImVvva+Wn9hJ5VtxRh4rzjT4w6bzDOhpWQNNjGMXDGD2L1xy6mAyg9GOonc5iPsPGqzHplMXP+IVbyQR3/WKdqfRLppBb5R33gyoLzyACM4fnvqnGruy0zV0zK6a+YSqO7fub+AcKixZKv0mE2MV4F2bV2pJdx06QxEDHBkp4w4L588FPhobGxl8Oy9YZ3zfnqZpQQbolfwLLws9Y7pA4x1M5XZjkqKsRRCuJAEZq8Ls2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPxmfl24c8GkJTpXXzk27ultx8wBzcsprwSwhMFdL9c=;
 b=Iith8/rfb0q4tpS5PHFi99RgVwUtBetwTVTbM9+KwvD8wcm0onxXspZhVXYMk/b2JkW+ezrT0bWFuSVFr8yOrf/WyNgnwRRS10v6VSeKa/A9Yb2jGgUKFO0CEQ7hxiTUf10K8BMGhuzw3rfKy+bC9nAWANjEe6OCvfXt04NV7PvckWYbt8yJ7An5XJ0sE1NvUHXWrUhiVa86GMziY6XDgrMyvCzyxkUULU/k7l1Iy5ExT7QKosjz/3A6nQ3qsjjHHJd2W+wz6d2AQdCcXxZLB3Fz1Yrp8QfysIw5YjN9PlCsd3nuNIdTDQWuKMiFfrXtUExbNq/PtwFyQU9lHRpliQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by DS1PR02MB10514.namprd02.prod.outlook.com
 (2603:10b6:8:211::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 19:57:00 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 19:57:00 +0000
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
 AQHbvoGOtDW/U9ulski7jan4/mWqq7PF36QAgAFLeACAADQMgIAAB1MAgAAB2wCAAAOsgIAABy6AgAAVnoCAAA6GAA==
Date: Wed, 7 May 2025 19:57:00 +0000
Message-ID: <6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
 <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
 <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
 <B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
 <e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
In-Reply-To: <e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|DS1PR02MB10514:EE_
x-ms-office365-filtering-correlation-id: f3686d47-887f-4248-d0f8-08dd8da154b4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1NXU1BFSzdTZHlTVmxEczZaMzhXWWhEakIvZEtwZlAyUUR6OUw1V0RINitp?=
 =?utf-8?B?d1owZ1Ewb2NFSXpJT1Z2ZWpMNENoU2NJN0l5eVAwenZNZml1dFg1ZUJWeHk5?=
 =?utf-8?B?VWd0SmJ6cFZnUUZIRlBnM2xoNVFPcjc5YS9MU1BNQlhJZ2dTTXRhZjBneDN6?=
 =?utf-8?B?WlM3QzUyVXp1NHFYbkNWRlJpRHByendRYXpwU3ZuSEdQckwzZ3lxSVJyK2Fp?=
 =?utf-8?B?M0VlVk9aWktadWZnNVdUbTdRcE1mM3ZrYndyUUhkY1FobytOeFErRzhocklI?=
 =?utf-8?B?dHpuOTFEUTdXeGRRWFhTRGZkb2J3cWF2TG9ES0VoazJkdktjbXo5VC9mZHV2?=
 =?utf-8?B?c0FOS1FCays2Z0FGR2gvL28zRHE1UksyQnRscG1mZmpSbkdtUlgxZ25BQnlm?=
 =?utf-8?B?b09BZHZQOGJBWXhPUnpLYmNHd3RYbnZPN0gwOVU4RjJSSldjS2hoRCtSYWV4?=
 =?utf-8?B?WHFzRTlxTFBRdGF3YXV0alZnMnVialBIRDFkZzEwMkdyZ3ZOcnhDZ3B0T0JZ?=
 =?utf-8?B?ZS9jL0VFWWpvY2M4M0REL2dQRERxbksxVkQ4NExFRXFiRkxVTkZ3NWFNVCtm?=
 =?utf-8?B?VnBZS2Z3U3M4YjFIQUFpR1NTbE9SaWtKa09Gb3dpcW9icVJSckpZZk0zd0tm?=
 =?utf-8?B?MDB4VzZLejdoVXdUb3pBa1ZuaHFrTHdzNitJYzhYd0lUVTFQN05jeFllV1U2?=
 =?utf-8?B?L2ZOSnUyTGI2ZmpYR05LVldxaGJGTkh0K3YxamROa2ZVT29jTjVKa0NwYlZN?=
 =?utf-8?B?NDlZTnBNRCttMjlVNzk1VHh4Q0tlL09KUWpEemNZV1poTlk0Uzg5VHV6Z0Uz?=
 =?utf-8?B?dndGRXpITWs0ZjAzdGxhRFpKK1JnMVFCZElkYUJCTGt4WHBuODJqUlBab1Rv?=
 =?utf-8?B?UWY5QXJwSFYvbFNwMnV6ZVFJcTJKQW9NOUNvQTN5Szh3YXVUYVNpQUNJeUll?=
 =?utf-8?B?b1p0b3ExSllVRUw4U0xkNlIyT2dndTA1MVp4WEZ3U2lyTFVyMS9WNlBCQW9t?=
 =?utf-8?B?TzZMZGxsYnpJT0NJZ1RHVlF1eGpxcWJ6YU12ZHZiOU95dXQ5dmJOMW5Kdmlh?=
 =?utf-8?B?bS9ieVc2NDlDNE01VFVpQUFrSGZaSUxQOE9sRGhXSjNSRktCS3oydE1jcTdF?=
 =?utf-8?B?djEyV2lxK25VSUtzYnFSQzcwRFA4a2lSc29XQnVtb1dsMnQ2a2Q2ZC9jaFp6?=
 =?utf-8?B?MEQ3SlVzWVI0UW5SVFdOQjNvWGhDMmJjRDh4cFY0QTJhb3ZQREIwTEtDaHBH?=
 =?utf-8?B?NW5sVzlDNkNHT3kvR3F6bU5MZ0RBMWdTY1pnWlRYSEdFS3Z5Yko5VDFmYkR0?=
 =?utf-8?B?Sm91SHFOQ05Rc0QxbjYwaXBwM1p3aDcrakxUUTZpY0x4Z1hUQ21mTGE5R3My?=
 =?utf-8?B?NEN3YUVnOHlTUm9meURSOXNGRWNYVVk0RUJkaE9vN0lqVFd6VmxMNFN4UXlo?=
 =?utf-8?B?M2hmVjF6ZlRKTVd2Yk94V0JvbjJ6S1RINlk0YmZ0OWZBV0UzZzR0bndGUnVU?=
 =?utf-8?B?cHR4TEFGWVp0Mm4yR2FaL08zdVV0RVFVQVBjdEFqczUweU5XNG1uWHNjSG5r?=
 =?utf-8?B?RjlVZzVwVlJHUi9XWnJaSlEyRUEzWW01alFDcXpOa0VMOFljbDhYZmVwR3lX?=
 =?utf-8?B?UHZhVmIvNVVTY3N0MXFjWjN1VC9jNWNDQURtRjlWZEN0a3FMbE1VMXZZNGhZ?=
 =?utf-8?B?ckUvSXdQbGdQRlA4aHdWWW1pTU9tNzk1KzErMG1kdG01NkptOUZzQUhIem5O?=
 =?utf-8?B?R2FOYXlVZmY0RVllQU1aaCtUa3hwWDJ1V05tN3Vvd0YxKytaNjcxVk93akFV?=
 =?utf-8?B?aG5EcUI0M0QwQWpCNW9RdlVMamsxbXpCYmxESTdpaWNTM0NXSFNVRnNXalE0?=
 =?utf-8?B?T3ovSVN3THhTaHpoVFl0eStybzNMUHFzUHpuZTgwYWYvK3Z6K0oyRkpPSS9E?=
 =?utf-8?B?VUxsU2hrc1k4OXVvUjNCV1FIcW41QUhrMHlpYUtBcldqNy94Vmd4OWxFVHBG?=
 =?utf-8?Q?nrau3KtUHQqVl3MY3jva9/oVWzV7c4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGI0RGtkODJRQ0RKRU5pdjZKTEs4YmRUY2s1N2RmQ0REa2NpZkNIM0ZzQ0pM?=
 =?utf-8?B?SlRNd2J2aUE0U0lpOEVzSnRGM2JEK25Fd0lZODV4UktIbHU3dDIxSHNpaGpU?=
 =?utf-8?B?NjBIbld3MUhxR2UxdjZmWVlwcjk5VGpoOEI1ZGt5ZkFIYWRYZDdUOTdubXpJ?=
 =?utf-8?B?a0VzUEsxMC8xd1VMNDduajZOZkZqMGJpYkYzWCthTjR2U3dITGJHcktlQ0pS?=
 =?utf-8?B?eWdrS1JyREtzSzBKWGpsUUFNVkJKT2VtNFFjNW5tM25HajFobXNwQzVIdjBt?=
 =?utf-8?B?MFp3Q3hUakJWOGxvY3VNOVA3ZFE3MDJEak5NZFVnSEtnUW8rdlVnSSt4OGdz?=
 =?utf-8?B?Z3g1UHVlS1dZdHBCM0kzNjhFQ1VGcWdBcTFwTGN4dVE3TW5acUpGbE0wYjly?=
 =?utf-8?B?Z29YMjNGUmZTdjYwZXNyUkxpa253UzYyc25CRVI5QnBjNS82eGtDVFlBb2pJ?=
 =?utf-8?B?TDF5eDgxZmtvblphaVFKaitwc0piaTFpZ2JSaEpxQ2tsQU5EVDJlYTRTTDhV?=
 =?utf-8?B?eEplYS9QSk9pYjZ3OGlPNnRMeUJidHAzdmRGUTArRndiRGhGYU1tTS9kZVhz?=
 =?utf-8?B?em55VCt5NkdISDNFYXBMU25ZczRWdC9DVU5GSnFtQ3pvdlJtVlV2dkxuRndB?=
 =?utf-8?B?cU1FakpMQUJGbWJrWjlxRkhMWDR0Q3V5MUcvTFJuREU4ZGlGTTN6L1lYU3pS?=
 =?utf-8?B?UDdWbkNwT1EzZ2hzZ2wvYzVaa05LYm1zNE9VREkxYnptQmJ4NzVPSE01cmVW?=
 =?utf-8?B?NlJDakNwa1pKWFVpM3drUlpDU1lFb3EyTmFyUG1wV2dEczJHS3pDcDIyMUUx?=
 =?utf-8?B?YTRsWHJRbXFIZkJYbFhWOUtSc3pUa0QwL2RTWFo2Wkl5bHJpdGd0aWYzWGFo?=
 =?utf-8?B?R0VwbG12OTFydkxObko5SE84L2NKWWo0TThJQk1XeU8rOVBkeUN6a3VRUjlN?=
 =?utf-8?B?bFRGRVVZM2t6Rklob0hCVThORnM4RWllL2VSajRLR1ErSno2bUZjNElZdndK?=
 =?utf-8?B?eDE0ZTF1NFA3V1Q2L0t2eHpkUWlFWmhuWXkxTW92azJ0dVlzZi9tc29VWWox?=
 =?utf-8?B?NTBWU3N4cFBiNW9HYmpNYlNISm5aZ1lWTmd0WU02SDlaM2pPMUNRZ29nNWx5?=
 =?utf-8?B?WEM3WUU4cFBmcFk1NFZKNkFVMkgyZTR2ZTQzTkdVMVdWYVNMQXNmcThuRWFw?=
 =?utf-8?B?M3pkNDBVWkZram1RcUFhZzdaWW12M0t3b1FXK1Z3bUhlRXV4bTc2ZjRQUEIy?=
 =?utf-8?B?UTBubnJ3d3NLWjRsYWVqMzdtQis5R1B5anZtclBqMFVvMG44Q3g3OEJIUEwr?=
 =?utf-8?B?TFhEZzN1bTdWQzR4SFU1OUdYR0lUM0ZOdldISVV0S2YxeXpjM3lXREZRT2RY?=
 =?utf-8?B?Z2dGTlgvT0E5L0xyamM5NHhkdFVjMmhjcnpaeE5tY1FQcXJtN3lldkhUd3d3?=
 =?utf-8?B?bFJEWXFEaXFpcGR2cjVHT09tVTQ5N3RxRm4yeGgzUFZHTEw3S284eWw1a0I5?=
 =?utf-8?B?S1pCS0VqYlgxM0xham1oWDhFVys0N1FwK01nWTYxeUs1c1BXbm1yWFAyQ0ov?=
 =?utf-8?B?NE1INXBXVWJDZWg4Rzladk9HNjkwQ29IN0JIdEZKaEpuY0RaNkNaaktJbFor?=
 =?utf-8?B?VFZHYVBzOHFrcDQ2YmI5aU9RY1hHam1ZK1BZLzJCcHNraFU2U0lKT2tRTkJK?=
 =?utf-8?B?MHlLNnp5djNzQS95UG9nMXVNU0c5TzA0MzdZb3N6cWUyVENVUFZwRGZWTmxj?=
 =?utf-8?B?ZzlDZTgyOFEveHV4UE1IdjA0ZDhVc2VGY0FIOE5NNFNSNGh6YUgwdmhBRk9p?=
 =?utf-8?B?RnZJTjMwVDV2MTE0aUNwTERPV3ZtQVg5M0M0WVlFVUxuK1hCZnphaCs1OXdl?=
 =?utf-8?B?WnlhTzZyRUw1Zi8zYlB0amo4bFdHRENqNUs5aUZ6alB2NWVNcW9waWkvVHZ3?=
 =?utf-8?B?Zlg2bVl4azdpaW9mT2pvdnhTVEUxWHBTR3J3MndaZ1BEOWlqeU1YcnlNNnZz?=
 =?utf-8?B?OEpqMllndm9iMGJldWhodXM5R3dteVc4aDFuWlpEZHF3cDQxT1RFeVpERXhv?=
 =?utf-8?B?dU43cFVxK2cvUFR1MkZhZnBUaGIwWjdFSWRhZlhVQ2g0VmhNZ3ViYVNIc2ta?=
 =?utf-8?B?T3ZxZEoxRWFKU2R4WUtqWDV1d1hMZTREZFFmNFN4cHpnVUNnME1GZEV6ZHlO?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E2BFF4B6A07F64A947A58EED2F6064D@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3686d47-887f-4248-d0f8-08dd8da154b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 19:57:00.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4r6K0lUkyTUeIK4vd8RNg38hfeTVRqwntiFOmwvVmU4rvoxpCvu8g/VdAUqTdkSjUGppdgJ6vOMZzyWTR/MSyd05XwOQSURAQy0NjZNDD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10514
X-Proofpoint-ORIG-GUID: GizQ8s8IoAGDUk16Gcl9_rAh2JMimEb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE4MiBTYWx0ZWRfX6ffv6KqY4AHs szBup7F/9niOSpwogV5Yj6fwdQ41i+cfIfR7+plzZU3dDHY9rvCNl4zLOULh0wPl6nb+CMLslPy N3OH1Usv/pfDzEFD/n3auej3FyXWSyEQQtGT2BFUr8228z4iO9b+9EayazL4DCtDRPw2ibPpTuV
 knj+qThuB9DCBjJRzE37rgfo5ZJazkxoWXqhbVWz3cFfrTkxxbpozS/l1OIgAt2UH40UcEJZWH2 a76xR81zHZI5k7rxg6Vfu79d6aQZel5DviM6E8OdP3F6ulL2a3ajGgPJjeMSixTwtqiiZXP5ajg +IuO00aHiXNOrVizUG0NHTyGqrhlQXIIrVIh413QkKayu/B3faMzFWHdEbR5/3j+BSIhTf01ppH
 g1+RxyvvaTOU67K9UEDFRVSZxZnbRkWnlAxp+RANLoNcOnZWNYnhZIze8QN63beq6k8HqPp4
X-Proofpoint-GUID: GizQ8s8IoAGDUk16Gcl9_rAh2JMimEb1
X-Authority-Analysis: v=2.4 cv=J5yq7BnS c=1 sm=1 tr=0 ts=681bbb1b cx=c_pps a=UiiUhvOI59TtQsb/yF5oqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FZo0KCpr_RZCF8KL8sAA:9 a=QEXdDO2ut3YA:10 a=67sPrzudLhkA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDM6MDTigK9QTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gMDcvMDUvMjAyNSAx
OS40NywgSm9uIEtvaGxlciB3cm90ZToNCj4+PiBPbiBNYXkgNywgMjAyNSwgYXQgMToyMeKAr1BN
LCBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90
ZToNCj4+PiANCj4+PiANCj4+PiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gDQo+Pj4+IE9uIDA3LzA1LzIwMjUgMTkuMDIsIFp2aSBFZmZyb24gd3JvdGU6DQo+Pj4+
PiBPbiBXZWQsIE1heSA3LCAyMDI1IGF0IDk6MzfigK9BTSBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVy
IDxoYXdrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+
Pj4+IE9uIDA3LzA1LzIwMjUgMTUuMjksIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQo+Pj4+Pj4+
IFN0YW5pc2xhdiBGb21pY2hldiB3cm90ZToNCj4+Pj4+Pj4+IE9uIDA1LzA2LCBKb24gS29obGVy
IHdyb3RlOg0KPj4+Pj4+Pj4+IEludHJvZHVjZSBuZXcgWERQIGhlbHBlcnM6DQo+Pj4+Pj4+Pj4g
LSB4ZHBfaGVhZGxlbjogU2ltaWxhciB0byBza2JfaGVhZGxlbg0KPj4+Pj4+IA0KPj4+Pj4+IEkg
cmVhbGx5IGRpc2xpa2UgeGRwX2hlYWRsZW4oKS4gVGhpcyAiaGVhZGxlbiIgb3JpZ2luYXRlcyBm
cm9tIGFuIFNLQg0KPj4+Pj4+IGltcGxlbWVudGF0aW9uIGRldGFpbCwgdGhhdCBJIGRvbid0IHRo
aW5rIHdlIHNob3VsZCBjYXJyeSBvdmVyIGludG8gWERQDQo+Pj4+Pj4gbGFuZC4NCj4+Pj4+PiBX
ZSBuZWVkIHRvIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgdGhhdCBpc24ndCBlYXNpbHkgbWlzLXJl
YWQgYXMgdGhlDQo+Pj4+Pj4gaGVhZGVyLWxlbmd0aC4NCj4+Pj4+IA0KPj4+Pj4gLi4uIHNuaXAg
Li4uDQo+Pj4+PiANCj4+Pj4+Pj4+ICsgKiB4ZHBfaGVhZGxlbiAtIENhbGN1bGF0ZSB0aGUgbGVu
Z3RoIG9mIHRoZSBkYXRhIGluIGFuIFhEUCBidWZmZXINCj4+Pj4+IA0KPj4+Pj4gSG93IGFib3V0
IHhkcF9kYXRhbGVuKCk/DQo+Pj4+IA0KPj4+PiBZZXMsIEkgbGlrZSB4ZHBfZGF0YWxlbigpIDot
KQ0KPj4+IA0KPj4+IFRoaXMgaXMgY29uZnVzaW5nIGluIHRoYXQgaXQgaXMgdGhlIGludmVyc2Ug
b2Ygc2tiLT5kYXRhX2xlbjoNCj4+PiB3aGljaCBpcyBleGFjdGx5IHRoZSBwYXJ0IG9mIHRoZSBk
YXRhIG5vdCBpbiB0aGUgc2tiIGhlYWQuDQo+Pj4gDQo+Pj4gVGhlcmUgaXMgdmFsdWUgaW4gY29u
c2lzdGVudCBuYW1pbmcuIEkndmUgbmV2ZXIgY29uZnVzZWQgaGVhZGxlbg0KPj4+IHdpdGggaGVh
ZGVyIGxlbi4NCj4+PiANCj4+PiBCdXQgaWYgZGl2ZXJnaW5nLCBhdCBsZWFzdCBsZXQncyBjaG9v
c2Ugc29tZXRoaW5nIG5vdA0KPj4+IGFzc29jaWF0ZWQgd2l0aCBza2JzIHdpdGggYSBkaWZmZXJl
bnQgbWVhbmluZy4NCj4+IEJyYWluc3Rvcm1pbmcgYSBmZXcgb3B0aW9uczoNCj4+IC0geGRwX2hl
YWRfZGF0YWxlbigpID8NCj4+IC0geGRwX2Jhc2VfZGF0YWxlbigpID8NCj4+IC0geGRwX2Jhc2Vf
aGVhZGxlbigpID8NCj4+IC0geGRwX2J1ZmZfZGF0YWxlbigpID8NCj4+IC0geGRwX2J1ZmZfaGVh
ZGxlbigpID8NCj4+IC0geGRwX2RhdGFsZW4oKSA/IChaaXZFLCBKZXNwZXJCKQ0KPj4gLSB4ZHBf
aGVhZGxlbigpID8gKFdpbGxlbUIsIEpvbkssIFN0YW5pc2xhdkYsIEphY29iSywgRGFuaWVsQikN
Cj4gDQo+IFdoYXQgYWJvdXQga2VlcGluZyBpdCByZWFsbHkgc2ltcGxlOiB4ZHBfYnVmZl9sZW4o
KSA/DQoNClRoaXMgaXMgc3VzcGljaW91c2x5IGNsb3NlIHRvIHhkcF9nZXRfYnVmZl9sZW4oKSwg
c28gdGhlcmUgY291bGQgYmUgc29tZQ0KY29uZnVzaW9uIHRoZXJlLCBzaW5jZSB0aGF0IHRha2Vz
IHBhZ2VkL2ZyYWdzIGludG8gYWNjb3VudCB0cmFuc3BhcmVudGx5Lg0KDQo+IA0KPiBPciBldmVu
IHNpbXBsZXI6IHhkcF9sZW4oKSBhcyB0aGUgZnVuY3Rpb24gZG9jdW1lbnRhdGlvbiBhbHJlYWR5
DQo+IGRlc2NyaWJlIHRoaXMgZG9lc24ndCBpbmNsdWRlIGZyYWdzLg0KDQpUaGVyZSBpcyBhIG5l
YXQgaGludCBmcm9tIExvcmVuem/igJlzIGNoYW5nZSBpbiBicGYuaCBmb3IgYnBmX3hkcF9nZXRf
YnVmZl9sZW4oKQ0KdGhhdCB0YWxrcyBhYm91dCBib3RoIGxpbmVhciBhbmQgcGFnZWQgbGVuZ3Ro
LiBBbHNvLCB4ZHBfYnVmZl9mbGFnc+KAmXMgDQpYRFBfRkxBR1NfSEFTX0ZSQUdTIHNheXMgbm9u
LWxpbmVhciB4ZHAgYnVmZi4NCg0KVGFraW5nIHRob3NlIGhpbnRzLCB3aGF0IGFib3V0Og0KeGRw
X2xpbmVhcl9sZW4oKSA9PSB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhDQp4ZHBfcGFnZWRfbGVu
KCkgPT0gc2luZm8tPnhkcF9mcmFnc19zaXplDQp4ZHBfZ2V0X2J1ZmZfbGVuKCkgPT0geGRwX2xp
bmVhcl9sZW4oKSArIHhkcF9wYWdlZF9sZW4oKQ0KDQpKdXN0IGEgdGhvdWdodC4gSWYgbm90LCB0
aGF04oCZcyBvay4gSeKAmW0gaGFwcHkgdG8gZG8geGRwX2xlbiwgYnV0IGRvIHlvdSB0aGVuIGhh
dmUgYQ0Kc3VnZ2VzdGlvbiBhYm91dCBnZXR0aW5nIHRoZSBub24tbGluZWFyIHNpemUgb25seT8N
Cg0KPiANCj4gVG8gSm9uLCB5b3Ugc2VlbXMgdG8gYmUgb24gYSBjbGVhbnVwIHNwcmVlOg0KPiBG
b3IgU0tCcyBuZXRzdGFjayBoYXZlIHRoaXMgZGlhZ3JhbSBkb2N1bWVudGVkIFsxXS4gIFdoaWNo
IGFsc28gZXhwbGFpbnMNCj4gdGhlIGNvbmNlcHQgb2YgYSAiaGVhZCIgYnVmZmVyLCB3aGljaCBp
c24ndCBhIGNvbmNlcHQgZm9yIFhEUC4gIEkgd291bGQNCj4gcmVhbGx5IGxpa2UgdG8gc2VlIGEg
ZGlhZ3JhbSBkb2N1bWVudGluZyBib3RoIHhkcF9idWZmIGFuZCB4ZHBfZnJhbWUNCj4gZGF0YSBz
dHJ1Y3R1cmVzIHZpYSBhc2NpaSBhcnQsIGxpa2UgdGhlIG9uZSBmb3IgU0tCcy4gKEhpbnQsIHRo
aXMgaXMNCj4gYWN0dWFsbHkgZGVmaW5lZCBpbiB0aGUgaGVhZGVyIGZpbGUgaW5jbHVkZS9saW51
eC9za2J1ZmYuaCwgYnV0DQo+IGNvbnZlcnRlZCB0byBSU1QvSFRNTCBmb3JtYXQuKQ0KPiANCj4g
WzFdIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL25ldHdvcmtpbmcvc2tidWZmLmh0bWwNCg0KSSBj
ZXJ0YWlubHkgYW0gaW4gYSBjbGVhbnVwIHNvcnQgb2YgbW9vZCwgaGFwcHkgdG8gaGVscCBoZXJl
LiBJIHNlZSB3aGF0DQp5b3UncmUgdGFsa2luZyBhYm91dCwgSeKAmWxsIHRha2UgYSBzdGFiIGF0
IHRoaXMgaW4gYSBzZXBhcmF0ZSBwYXRjaC4gVGhhbmtzDQpmb3IgdGhlIHB1c2ggYW5kIHRpcCEN
Cg0K

