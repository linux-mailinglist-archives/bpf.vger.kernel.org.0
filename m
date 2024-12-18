Return-Path: <bpf+bounces-47277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A275E9F6FB5
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AA188E32E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD61FC7C5;
	Wed, 18 Dec 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XZwapeqe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E315530C;
	Wed, 18 Dec 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558462; cv=fail; b=o25RV/uFnzdB7IQgK6rj3COkeUxf1+HLhwcdJtppG9yL0KketZ91C25XYg5xr2/tHoPoeLOI/oYJPxfiBL7bFVvOENyTpnj/FSsXBKLEboLs0Q2Ts0lrtyu/XzX0yUSgXqTARiNm9Cd3Cp/HOsLSLsDJ24AWP9UZHsmXwsKKBjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558462; c=relaxed/simple;
	bh=UQbXAGIbAKXp7qrnOlSAOSaHgM8Teu0ecs+8RliH0fU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bBc+XTLlJPbyys+hk3wXCBY9Wevn4E3vHe58EpeDasVuH0c8TRVPUJiLU9QACWlAICqAxFp5QMelEsfg3x0qMkiENV5Ze/Qg2bkIolzVVolZRCnup9am+DxXpbcYdZHmoUhj8b/g35FfBafCpFYPKUrww9XtSnODYJ/oBaxpZXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XZwapeqe; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BILLruk022670;
	Wed, 18 Dec 2024 13:47:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=UQbXAGIbAKXp7qrnOlSAOSaHgM8Teu0ecs+8RliH0fU=; b=
	XZwapeqeADj8/kJmxkDX5UaoSSQG9pQiLRjGv4dmiU9vyWw7NqA7i55mDQnnWZ6g
	71lLv8x8IEvCIyPfCVgaBlfIv3oN2Z/lj9dWH91vJV1MJlzE03ULZQGv5n0Kyk6v
	2sNUrbxjO50Au5KKUdCbEpE+yklE9O1jP7XIDLjjWP11vW771cDLT1VgK/N/s5Hf
	HnSapUHTYB7CThOpWjkaoQF+8RIAuCw82QN0cJwjOZZL7zkKeTgOSjsSfVQQuNPd
	QCeZLac3weqz1DsxKGN7yUqFS2L+RnpIlEberU3ooLDjEhmirUtQv4zTJRDSoUew
	eXiMhqk7KsfXwq5RhTQxgA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by m0089730.ppops.net (PPS) with ESMTPS id 43m06vu368-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqQFOnJmBHVsJYwd4tm7oydTqUbM4OKdFLetWaE9flE7GE7y/rlMoX0Y3hGSn/6RhdE4H2rInl8PLd6q+hvXzMxoWZ6ne4fJLHb7FyMtK53+dX12T0xI1Lk32WXnoHF7AHgrHHXzd2usGHAwL8ASJOTGzdVkURE0wbq0fW4Syv6n7UnuNFUhgukurm6iYWUSPKMollZhfoUy5bvBRWSM7sfCaefrUXANMfiCWEmEflMgAEWcWQzh72g/JXuCLnBeKRNySi2Aghkq3Aqv6GDoN3sk6NqlI4E5wuww4OmQrGHu9f5JZfZ7oY8EhZ32l8nCDQ3jPKeRfBcU5aH2F2KwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQbXAGIbAKXp7qrnOlSAOSaHgM8Teu0ecs+8RliH0fU=;
 b=Kz0H5KxDbp+oKC2ZYr+7x/h9jHda69Moo0Jr8c1QnVtffZklVC0buZuFHzC0zhXxOQKvsW11vgyY0LWR8Db3pOucoJm5Qt1VxWToQJ8BWR/UbHuWiJx9FX54P/Z7A1qcrqvMU5vyAgTKoDA/0K3iMJksSPQSRLlbb6VhJa8s7HR+Dd31KGWIo1bGSDU8YqOMuh6/nohQtXxArD1icKNrIe+q/E9dJWN2aONeDGWYupXvA0Q9ABJU7+EfnPjlvThACsmyaFKso6FeMmgwr+IC7E5C/iHoK6lWxghdO2ykp8J929DdMMzK5FJuMZW05wxEREznz3hTC73dHnRWKjayMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB6375.namprd15.prod.outlook.com (2603:10b6:806:3aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 21:47:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 21:47:34 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbUQgH26q3Z2MAsEyHPIKkiJbGP7Lsg1AAgAAHd4A=
Date: Wed, 18 Dec 2024 21:47:34 +0000
Message-ID: <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
References: <20241218044711.1723221-1-song@kernel.org>
 <20241218044711.1723221-5-song@kernel.org>
 <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com>
In-Reply-To:
 <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB6375:EE_
x-ms-office365-filtering-correlation-id: 41d55f31-3bbf-4662-b98b-08dd1fad94d2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3lwR2xiSENXWlI0czFYcCtrb0QrRmhSSEtUdCtYM2s3UEtqZmgyVk52cHFy?=
 =?utf-8?B?RE5TdzVWK2k5bGlZbndpOXp1M00xSFBNbXZZcEtqcUhyQmFGVS9tRHVQNVBG?=
 =?utf-8?B?T0toeWc4NmpXbFc1K3A3VVg3ckl5a2RQakswNnJzcFp6V0JKQzlkemtjK045?=
 =?utf-8?B?dnZic3dvMkVySlF3U3YwVWdORTMyb2EzK2FBKzRaY0lORUZRS3pTdURBUnRi?=
 =?utf-8?B?SDF0WXNGSDJkNGN0MzhnUXJydmFndm5UYW9uanNEbmN5LzhIMTVIVjN3c09l?=
 =?utf-8?B?aDExODdIKzR0V3dwa0llcWRPZGJuTFNVcG5MbGdPM3EyOXRvZkVLZXE1S2Zn?=
 =?utf-8?B?QWcraENNMWdBMVhJZHF5LzVEQXlSeGpDZDdxd1FkTlJlSzhDUDBCa0ZidmxX?=
 =?utf-8?B?VXVoVUhxLzBJa3UvYWFhZEpLblJaUjlwb25sYitVaDltVEdabjhzbDY0Q0Fz?=
 =?utf-8?B?c0xOVkVrc1AwOTd5M1g4K1lBV09FZnlWYUtyUFpOVjJnWGVKdVFCRFdvMnR5?=
 =?utf-8?B?aU5KMEdwQ1FPSk15RWlhRFhqeitGNi8yQVNMTHk0dHZYamhLTldRSnpLVS9H?=
 =?utf-8?B?YlkvWUd4TktyYmJMSnV0bkZYb3FmTzY1ajg1d2FoSERISW9vUVpPMExKSzZu?=
 =?utf-8?B?cWsvSWxPOGJZcFg5UTdFNGk5R1orbGl2UFJrMEoyZE5vZnhXSnV2bmNQZ2RD?=
 =?utf-8?B?NjZpSVRNbHpBN05rdW1oV2pRR2I4bkYrNlgxUEtPSmpqN2FiTUs1akZzdVpQ?=
 =?utf-8?B?cTBsVldkTVhZZi8zVHBwMXJ4Ym5oZ2lTL05NSmxxVlNtdncyWVJMbVZvUk00?=
 =?utf-8?B?M1BSVVQ2Y1ZQa1gzcXN1QnI5Mk9kYjFOMHFSQndjOHZDZGdMZ2w2ekc5SEJQ?=
 =?utf-8?B?TjkzY0JTNzVaSEMzQk1JWnFUanJLMnh6eFdMNUhVOURnNXlKNDRjMnI3UXBL?=
 =?utf-8?B?eEJBenBNc2dhNUkzTWdFalhHa2RJWmp0SVQ3bm56STNDZnVnc0NJVTcyT2M3?=
 =?utf-8?B?eCs0VVQvVjlwankwVGJIeG9ZTUROTkwydE9WZnZIQU4zQytnSFdUakt0TGNw?=
 =?utf-8?B?Kzd0VXRLaDAvR1luMXRyWUIwMjFKK1haeFVML0htdThIaUhtQnp6Sjg3cU5u?=
 =?utf-8?B?WlF4VllPL3JuVkYxb3JsQUhUY1VZbmxGd1hxR0R2VVM2OTVZNkU0dU44R2Vz?=
 =?utf-8?B?N24vWU9KUTFWQS9KcGlYR1dUOStPY1lSSlhmMDFibWsvSmhtVUdvcUs2b2w3?=
 =?utf-8?B?ZlhPQlFUME02c0FuYjgwZzlHS0FEUEZFQ2tqbm1VKytHWXVBSXFnY3VvSlBq?=
 =?utf-8?B?S3p6dGtMUFlmbUJDTzVuRnJ4YVNDMVFPc2VsaDBFYlNDZWVPaDM3M1FINzZx?=
 =?utf-8?B?Mmc5SHRadjk5dTRHZ0Q2MVVoYzNtRC9kVGRvTjRYeGE0SXdxN3YxYjRqSVVh?=
 =?utf-8?B?L2E1KzZ0eUVmZmJBVnAxaitpa0poR3BTTFV5dVRaZEppd1kzaFI1MmorUURR?=
 =?utf-8?B?NGxJSXRhV1Nsb1dnRWNpenBPZ2NnamUvNUxwQ3hHanJjbncwakVsaDl4MnYy?=
 =?utf-8?B?S2tZRndRRC83SG9YdjlUd2xTTG1JNGhUQlVvdlVnNVAwZU1MMEJ2L3Q2aVhB?=
 =?utf-8?B?MkxkcFd6OUVJYUI5elNJUllWaFQ3VHRrMmtUaEpoWE4raVZpUlhwYUlJblg4?=
 =?utf-8?B?dEM4Zmc1UXpHS21MYmVtUGdoZG0yNVlKekxZeFNheHVUZU9qRDNCNncyTjhU?=
 =?utf-8?B?WUd5QThITCt2QURDMEUwcTZkQklYVisrbDFzNVFCd1k0cThlZEpjZ29Pd0Fo?=
 =?utf-8?B?NGJHa0I3cy9QZVRpY25haUcvNi9mNHFldVg5WTduRFQ1QW91SkZhQlRCa0o2?=
 =?utf-8?B?L2lsZWoxbXhqM2d6ek5aNVFqU21VbHhlRVJ2VEpjSzRhQU9OWUp0aDdENzlz?=
 =?utf-8?Q?D5FWXjvuAr0qoQkbHpNlHPtnwSqxke6+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0tUNG00R2p1TVk1Zk82Vkd6cW1EYmdLYnRWdS9MeDROUFNtbEF6U0pnM3B4?=
 =?utf-8?B?cVpGUkwwK0w0Y3puTDlYa08zTVJ2dTdpd2pJVmNYb0xhRUJ6RmtrL0VFQWUv?=
 =?utf-8?B?WjVRb3MxNDBDa3BMZXAvNlBnc2NudGJKUzFuOTh5US9vaityV3ZidDhIN3RM?=
 =?utf-8?B?WWliWkw5Ui9Oc1h1MG12RTBBZmNkTkhPalc2WG9GNG0rS1VFV0VtZDc5T3JZ?=
 =?utf-8?B?eit1T2RjOG9hUG42WEJWNTVsRGs2bkRyQzJQNWp1V2N6eDNIU1BkalBUWWpC?=
 =?utf-8?B?L01tb2tlYlZoaVVMbFVvUUUvZUFDOXZXZGdQZDZ3TFozZW54Vm51cmp1dlRC?=
 =?utf-8?B?bHBmSFdKQXMxZS9BNVJDSzVWL3poaDUrNWU3eHoxUTVINVdoZkxFWGhSOXFs?=
 =?utf-8?B?Z0pGTmpyaVlMQ2FOeGFtS3kxMVZpNnBvejVLSlZCMFRTVUxlelFybmRzSEg1?=
 =?utf-8?B?NldueDVQYTVmUEJsYktFdWErRUpSUVgwcTdrRy93MjcyMEtJcFJQemRtZFdp?=
 =?utf-8?B?dGZqd3AzUWhPMUc5YnVrenBvWnFaS0N6R1ZoMUZnbXVvRU1FR0dGdWtKNlNG?=
 =?utf-8?B?d0RGc3M5aGV4TXFTV0lITFhRdlZBdjA2eU1kRytwclBlQkxzaXlpc0hjdDYr?=
 =?utf-8?B?TG9rM0c5ZnM4NFNoTmpPSGJ5Y3lzb1RCZDBOVUV1OWt2R2J0NXYrTVlycHlE?=
 =?utf-8?B?WGZ2b0pYaDBiTyttMzcvRHBsV1BmRkpXUE1CQ29TQlRLN3JCdzJmaDRTOXhM?=
 =?utf-8?B?aHY4TWM3MW9rc3UrNmpjRnlZSkhGUjQ3cFdSa1dBa29QZnpOY1ZaVGZvSER2?=
 =?utf-8?B?Kzk5Z2htclBkYUxBSjdhb3FqMzlFYXBzM1lSRHVWSXJ4eDFYY3BrVlI4UW4v?=
 =?utf-8?B?MlZMNnFQQnRBUlhNM2ZxVUJSWnQ5VndUVW40Q1pyMk1aRkZMaHA4Rkl3YlZp?=
 =?utf-8?B?Qll3YTZhMnF4KzBPM2JSWm40STJSUHpYT3dLWGRZcElvMHhpbUNsQWJUSVRF?=
 =?utf-8?B?bWNjR0hydDhTWHBpTEZNNGVjbEdTYlBESGdrZDhLRU5sRzRzSXpCRFN3d3lV?=
 =?utf-8?B?WlpXQ2ZXbUVyQ21IaU5KUEZHSUVUY29JUEVTRWpoTE44NTh2YkRnMUdLUTJ3?=
 =?utf-8?B?c2RJRkNuUmV4cEFTOFhXZ0d0aGptUWE3ZUZ0R1JqbHlGclVuS1VXWlcvYUxx?=
 =?utf-8?B?aU0xWGJpMUgzYzE2WmFUWVRTZWtEMzdNMGMxd3A2ZENlSUJsRFR3WTJ6VzRr?=
 =?utf-8?B?aHNMWU9kZTFsdjlhd0hEMUp4OWtsa0Q0YTF5djNGRkw0d3JMdm5rcHlaSFht?=
 =?utf-8?B?aUtXR3IwSkxoSXFXb3pnS1VBL1pGek1ZRnNsUktEc1d4RUpRMGxVV3FueWIy?=
 =?utf-8?B?L1ZKRkNZQWxlay8vR1BsYkJUSWhWTkFYM2lzSmJqVFRYWGZBMEhIbndXc3Ar?=
 =?utf-8?B?NkZmWklxQ1VNa3E5V2NxYUxhOGd2emhXeXpFY0sxdHd6azJacnpQZm9tbGRI?=
 =?utf-8?B?cEkrVVpOaG8xeXNteDlHWTJTemxaQ2lLM1ZRTlhkNUZLeG9IbHR3bDRNQ1dj?=
 =?utf-8?B?Mit2VzdKRVNEVkp1T3B2bTBrZG0xSzNYblVkRzlFR1dzWFpGWSs2YlpWdTV5?=
 =?utf-8?B?dGhOTDczSFdsSzlicWhUYWliOVgySW1FSEpteDJVSlorZ3hFQm50QVYyazJs?=
 =?utf-8?B?ZjA2UjZJOFBrNUlMcFk5c0EwMFlnbFFiRDJyZjJCRmRwMU9qRHZqNU5qUFpz?=
 =?utf-8?B?ei9pMjVlbDhOc09EUi9WSjl6dURBemNYbU1vV3hRZjRaL2xsc09WOHFldENv?=
 =?utf-8?B?a1dINldHZGJpSDVoWm5Henk5Z04wNklrMVRkcWplcUh2bmExRFFDQkpBOEt6?=
 =?utf-8?B?SnVlcU93dmpjUktGNDMvK0Nwem85VjJwbTU2dzhVTGFwYWVWOTB4N3Uva0NB?=
 =?utf-8?B?QnZjVm41UkpvUDZLMHV3YWNuYkRpWnZpUG83bGRqaXNJMElraGZtbWliQ1lj?=
 =?utf-8?B?OXdwZUsxWExSSVVJN2hpTWlkVm9HSmJ1d2gxbFJ5ekszRG5Cb3RVNjgwUk9L?=
 =?utf-8?B?Z1N3b3I3eVlISFlUN0ttaDhCSE5yRGcvYmw3Mlp1amUwN2tkbFBTQ0dSUGtS?=
 =?utf-8?B?aDFqZVNxdXlUSXFtUVpqdHVqV21iTEtnUmtFNk5BMzNCOW5JYkR0R2ordm1U?=
 =?utf-8?Q?3fPXpMm2mqPkT+8LsMwG7Eo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C7D493AF553B342B112F6E275AFF030@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d55f31-3bbf-4662-b98b-08dd1fad94d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 21:47:34.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnn4783Xce5SXsDOE6OWz56IBQUNvX5af5QoTttXsRq1fXCVMd/CPXz18r45MIJJI+I2BbkxfvsqLO5ne2t2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6375
X-Proofpoint-GUID: i6n1XQp7zymkruRUh365dDV2tTSWfo-q
X-Proofpoint-ORIG-GUID: i6n1XQp7zymkruRUh365dDV2tTSWfo-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQWxleGVpLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQo+IE9uIERlYyAxOCwgMjAy
NCwgYXQgMToyMOKAr1BNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBEZWMgMTcsIDIwMjQgYXQgODo0OOKAr1BN
IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiANCj4+IEJURl9LRlVO
Q1NfU1RBUlQoYnBmX2ZzX2tmdW5jX3NldF9pZHMpDQo+PiBAQCAtMTcwLDYgKzMzMCwxMCBAQCBC
VEZfSURfRkxBR1MoZnVuYywgYnBmX3B1dF9maWxlLCBLRl9SRUxFQVNFKQ0KPj4gQlRGX0lEX0ZM
QUdTKGZ1bmMsIGJwZl9wYXRoX2RfcGF0aCwgS0ZfVFJVU1RFRF9BUkdTKQ0KPj4gQlRGX0lEX0ZM
QUdTKGZ1bmMsIGJwZl9nZXRfZGVudHJ5X3hhdHRyLCBLRl9TTEVFUEFCTEUgfCBLRl9UUlVTVEVE
X0FSR1MpDQo+PiBCVEZfSURfRkxBR1MoZnVuYywgYnBmX2dldF9maWxlX3hhdHRyLCBLRl9TTEVF
UEFCTEUgfCBLRl9UUlVTVEVEX0FSR1MpDQo+PiArQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9zZXRf
ZGVudHJ5X3hhdHRyLCBLRl9TTEVFUEFCTEUgfCBLRl9UUlVTVEVEX0FSR1MpDQo+PiArQlRGX0lE
X0ZMQUdTKGZ1bmMsIGJwZl9yZW1vdmVfZGVudHJ5X3hhdHRyLCBLRl9TTEVFUEFCTEUgfCBLRl9U
UlVTVEVEX0FSR1MpDQo+PiArQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9zZXRfZGVudHJ5X3hhdHRy
X2xvY2tlZCwgS0ZfU0xFRVBBQkxFIHwgS0ZfVFJVU1RFRF9BUkdTKQ0KPj4gK0JURl9JRF9GTEFH
UyhmdW5jLCBicGZfcmVtb3ZlX2RlbnRyeV94YXR0cl9sb2NrZWQsIEtGX1NMRUVQQUJMRSB8IEtG
X1RSVVNURURfQVJHUykNCj4+IEJURl9LRlVOQ1NfRU5EKGJwZl9mc19rZnVuY19zZXRfaWRzKQ0K
PiANCj4gVGhlIF9sb2NrZWQoKSB2ZXJzaW9ucyBzaG91bGRuJ3QgYmUgZXhwb3NlZCB0byBicGYg
cHJvZy4NCj4gRG9uJ3QgYWRkIHRoZW0gdG8gdGhlIGFib3ZlIHNldC4NCj4gDQo+IEFsc28gd2Ug
bmVlZCB0byBzb21laG93IGV4Y2x1ZGUgdGhlbSBmcm9tIGJlaW5nIGR1bXBlZCBpbnRvIHZtbGlu
dXguaA0KPiANCj4+IHN0YXRpYyBpbnQgYnBmX2ZzX2tmdW5jc19maWx0ZXIoY29uc3Qgc3RydWN0
IGJwZl9wcm9nICpwcm9nLCB1MzIga2Z1bmNfaWQpDQo+PiBAQCAtMTg2LDYgKzM1MCwzNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGJ0Zl9rZnVuY19pZF9zZXQgYnBmX2ZzX2tmdW5jX3NldCA9IHsN
Cj4+ICAgICAgICAuZmlsdGVyID0gYnBmX2ZzX2tmdW5jc19maWx0ZXIsDQo+PiB9Ow0KDQpbLi4u
XQ0KDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQgcmVtYXBfa2Z1bmNfbG9ja2VkX2Z1bmNfaWQo
c3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgc3RydWN0IGJwZl9pbnNuICppbnNuKQ0KPj4g
K3sNCj4+ICsgICAgICAgdTMyIGZ1bmNfaWQgPSBpbnNuLT5pbW07DQo+PiArDQo+PiArICAgICAg
IGlmIChicGZfbHNtX2hhc19kX2lub2RlX2xvY2tlZChlbnYtPnByb2cpKSB7DQo+PiArICAgICAg
ICAgICAgICAgaWYgKGZ1bmNfaWQgPT0gc3BlY2lhbF9rZnVuY19saXN0W0tGX2JwZl9zZXRfZGVu
dHJ5X3hhdHRyXSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGluc24tPmltbSA9ICBzcGVj
aWFsX2tmdW5jX2xpc3RbS0ZfYnBmX3NldF9kZW50cnlfeGF0dHJfbG9ja2VkXTsNCj4+ICsgICAg
ICAgICAgICAgICBlbHNlIGlmIChmdW5jX2lkID09IHNwZWNpYWxfa2Z1bmNfbGlzdFtLRl9icGZf
cmVtb3ZlX2RlbnRyeV94YXR0cl0pDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpbnNuLT5p
bW0gPSBzcGVjaWFsX2tmdW5jX2xpc3RbS0ZfYnBmX3JlbW92ZV9kZW50cnlfeGF0dHJfbG9ja2Vk
XTsNCj4+ICsgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgICBpZiAoZnVuY19pZCA9
PSBzcGVjaWFsX2tmdW5jX2xpc3RbS0ZfYnBmX3NldF9kZW50cnlfeGF0dHJfbG9ja2VkXSkNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGluc24tPmltbSA9ICBzcGVjaWFsX2tmdW5jX2xpc3Rb
S0ZfYnBmX3NldF9kZW50cnlfeGF0dHJdOw0KPiANCj4gVGhpcyBwYXJ0IGlzIG5vdCBuZWNlc3Nh
cnkuDQo+IF9sb2NrZWQoKSBzaG91bGRuJ3QgYmUgZXhwb3NlZCBhbmQgaXQgc2hvdWxkIGJlIGFu
IGVycm9yDQo+IGlmIGJwZiBwcm9nIGF0dGVtcHRzIHRvIHVzZSBpbnZhbGlkIGtmdW5jLg0KDQpJ
IHdhcyBpbXBsZW1lbnRpbmcgdGhpcyBpbiBkaWZmZXJlbnQgd2F5IHRoYW4gdGhlIHNvbHV0aW9u
IHlvdSBhbmQgS3VtYXINCnN1Z2dlc3RlZC4gSW5zdGVhZCBvZiB1cGRhdGluZyB0aGlzIGluIGFk
ZF9rZnVuY19jYWxsLCBjaGVja19rZnVuY19jYWxsLCANCmFuZCBmaXh1cF9rZnVuY19jYWxsLCBy
ZW1hcF9rZnVuY19sb2NrZWRfZnVuY19pZCBoYXBwZW5zIGJlZm9yZSANCmFkZF9rZnVuY19jYWxs
LiBUaGVuLCBmb3IgdGhlIHJlc3Qgb2YgdGhlIHByb2Nlc3MsIHRoZSB2ZXJpZmllciBoYW5kbGVz
DQpfbG9ja2VkIHZlcnNpb24gYW5kIG5vdCBfbG9ja2VkIHZlcnNpb24gYXMgdHdvIGRpZmZlcmVu
dCBrZnVuY3MuIFRoaXMgaXMNCndoeSB3ZSBuZWVkIHRoZSBfbG9ja2VkIHZlcnNpb24gaW4gYnBm
X2ZzX2tmdW5jX3NldF9pZHMuIEkgcGVyc29uYWxseSANCnRoaW5rIHRoaXMgYXBwcm9hY2ggaXMg
YSBsb3QgY2xlYW5lci4gDQoNCkkgdGhpbmsgdGhlIG1pc3NpbmcgcGllY2UgaXMgdG8gZXhjbHVk
ZSB0aGUgX2xvY2tlZCB2ZXJzaW9uIGZyb20gDQp2bWxpbnV4LmguIE1heWJlIHdlIGNhbiBhY2hp
ZXZlIHRoaXMgYnkgYWRkaW5nIGEgZGlmZmVyZW50IERFQ0xfVEFHIA0KdG8gdGhlc2Uga2Z1bmNz
Pw0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8NCg0KVGhhbmtzLA0KU29uZw0KDQoNCg==

