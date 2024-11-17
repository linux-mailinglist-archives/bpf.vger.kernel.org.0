Return-Path: <bpf+bounces-45048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639B9D03DD
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 13:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A9C282B7C
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613F153812;
	Sun, 17 Nov 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jlo0hZP8"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21D1803A;
	Sun, 17 Nov 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847337; cv=fail; b=VhsPz6vl4HuPoX4bh6ex51g+ZBwzJPYWN3zArLGVBzZIPU72TV8Rxoo7hfPysaBGSlPn4ynhhL2Iz5DzCOY/YcTgCFIalXUrnAPcyGwpM5YX42CzYntBi84cBOpHERKox06uuFVBr9yN7ZyFHnNhgQmWFC6tZ6A7fH8YD9DPmRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847337; c=relaxed/simple;
	bh=7A6yqEDK0IttIVeN9NGuyywK/4WixQRvBALNDITSucM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffeu4bn3fV+FNAY7HrQCDHNEYvClBG6WK2gCQCxhOfPRiYzhsB0vS4Kt9xEdWunvC9xsmxkU1fgbA2GojPAVw2BphGLKUvycWWHP3Yason2puXOAad0JjB7L5LwlEs2wpQ0tuMIzos42ofwz3WNOGZQ+0SQtZUimmdTqmndAkH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jlo0hZP8; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg/r5HLBjjiRgroUic0fRAc4DWMzXAOYnfCqN67Rb8TSxAahj5sJW6vPefwkaXX9QfOila+N+/z+Q0XCOMShM8sL8ab6XjjLxXNdjcTQVZa/R3vYRYd1VSh0R0kA3oS2swF+BOcMdeFPvHq9sv6KZn4XKbvjiYrJTS5iXM2p2z20zj6rNmjz69jlRP+ueOT4guvF+GIZg1WvhU5NQPJRb1hGpPt2qI90u3FRilm3bNZy4pvIMWpKIiUwn/QVFkB7CMTFv79RrpNOsMRklQFLHaJJfSxLHB6O+0ApcUcsFI3GJQWtjxezbqPWqRThhRdHVJPZtjhlG8HvnljVufFjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A6yqEDK0IttIVeN9NGuyywK/4WixQRvBALNDITSucM=;
 b=MMlr9vOhX+QiKymRNltb2o/hWDibEKS+9mMA2hGbhUc3Fc+7Ma56bMeFN5S1K8z56KIT2hQYnojS0moEObrLJToEMAt8nY5sno29nnyYw2+WqHl0UK9GhgS9TuomVUFXl9dFEczDEZ72xveo9utOv3LmGmWLfrXF2PKb8TXDXRg126o1PtPjHbePCwF54t55nYVHHXOT1fQJYsvpsGFNS7t3BqSGJoDgVMGdXH61N0hmjQO7wSg+DtU4zsGrCV4FJLDY8p6EFTEJiRCGY03VvN3hpTGEHTxa9LBjjxk7iTnDPIVoRq7JObnwLscy6srluC2CDdPqv4q6UU7KCwOwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A6yqEDK0IttIVeN9NGuyywK/4WixQRvBALNDITSucM=;
 b=Jlo0hZP8lQgvvgCpQSIzlQrPsAXj8kSp8w3GqweHYY8nCFLWQuylEr3Ax5Ifzld8iEbelU3mJ3T4ga8d6DE1821bmsCKdM9mP8A3AAGVCU5NwZV4N84ThV1u6cl4DBNEkGe6tBux/m74a9HYKh5AZLDK6wEJhPSn9fhE5S0GadgzYZwWywdNZEnkZzZwwUrhGk1LsofRa3NEkAlBrfC1JJj5AOsTNOABaJNJG0dV3T9zsuMPC1psr7BpGWFxm8V5AuxBJlDAa0WbjE5Ud4C4zmJQJqoKpbP/MRZRJTJbvIGSDa8zDpYGiaOcXBbfKTUKeOJKIUy1ckI4qrC9yAOxOg==
Received: from LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Sun, 17 Nov
 2024 12:42:12 +0000
Received: from LV2PR12MB5943.namprd12.prod.outlook.com
 ([fe80::ad78:5a97:a4c5:3681]) by LV2PR12MB5943.namprd12.prod.outlook.com
 ([fe80::ad78:5a97:a4c5:3681%3]) with mapi id 15.20.8158.017; Sun, 17 Nov 2024
 12:42:11 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Ido Schimmel
	<idosch@idosch.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Magnus
 Karlsson <magnus.karlsson@intel.com>,
	"nex.sw.ncis.osdt.itp.upstreaming@intel.com"
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
Thread-Topic: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
Thread-Index: AQHbNeFJ2N5pOAwogEy5CzzA4z0oh7K24ayAgAAC/wCAAYagAIADAkKg
Date: Sun, 17 Nov 2024 12:42:11 +0000
Message-ID:
 <LV2PR12MB59435D8F548C8DA2E317DC6FCB262@LV2PR12MB5943.namprd12.prod.outlook.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-13-aleksander.lobakin@intel.com>
 <ZzYR2ZJ1mGRq12VL@shredder> <ZzYUXPq_KtjpNffW@shredder>
 <59d1cb78-8323-426a-b1b5-e5163b29569c@intel.com>
In-Reply-To: <59d1cb78-8323-426a-b1b5-e5163b29569c@intel.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5943:EE_|CYYPR12MB8732:EE_
x-ms-office365-filtering-correlation-id: dd4c3905-6bfc-4720-0375-08dd070541f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXZTMTJmdE52T3Y5d1ZKT0xicHU5T3owVnNnMDJqMzB5ekQ3eUJJSklFZXJz?=
 =?utf-8?B?OUQ3allrTW1GZnR4ejJrbk1jSldPRGkrQW5Zb2wzekd0N011Y3cxeFJDV05K?=
 =?utf-8?B?ZEN5UVhSU1AxZm50b1Bta3VxRjNJQkJrOUNCa3dKRkxXR0d2RGNxMllLS2VI?=
 =?utf-8?B?TmczTEU0WkNaeEpCNHovN2d0T09QYnUzS1dFdXlKcHgzZmRUc2UrUFVsZjlK?=
 =?utf-8?B?bmlEMVFxaW9qSnQ0YXdLYXpibUl3bXV0S1NNb0RmMHdFUXBNb25CaUgrWjRR?=
 =?utf-8?B?R1lOYnNORHM3dVBaSE9LdDZiRmJlSWpMdlFNc3NrU0VnbG5idHZuNGFON0hQ?=
 =?utf-8?B?MWRhQlZtU3BPZjlDVjAwM3liZm4ybkUyL2w5SG1yWm4xcWFHL0FKeHl1VWxJ?=
 =?utf-8?B?SEhQUHZ3ZjdvbEt6R2tvL1BrYVRPanhjaXozbmcrV3RmTnNKNkVqMG5CVlB1?=
 =?utf-8?B?R1ZSQmRDbWhJUStiTzY4cHlUVVZxMW40alh4eGZsdHE2a3p4NmZBL1RPOU1t?=
 =?utf-8?B?bGN0ZnNGMjhnaDhrbHV6Q3E3NlhsYVRQZFRaeWlOYWZsVHBEM0cvR1paOWU4?=
 =?utf-8?B?Tk0yMXhSU3NUVVVCWnErMkpwWTYwcjFxZE1iU083bEp4dWYwanBCWCtaWG5F?=
 =?utf-8?B?TnJSaXNxMXZrM2dtaEtzbnpvYkxSOE5aUE5WYXMwcG5KQ0p4T21CVlFvbWVU?=
 =?utf-8?B?cXZ6ck03NFJ0b2JzaWpDTWF5K1BIRldJMGFsQ0JaTld4M211dytCQ1EyRzEy?=
 =?utf-8?B?VG53RHhReUtjQmtKdGZ4T0lXNjFuVGMyQW1qL3pXY2NDMjVuaFBaSkMwMWpU?=
 =?utf-8?B?VjBsbkpxMmRLYkhrUXdFdHREbTFnOFR2bE4rM2JoM01naHludjdtOFdCZnFQ?=
 =?utf-8?B?WFJEQk80NmluYlFIdXFSNmY1dk1xT1hjRkhRejNMWlFlc095ZDF3YzRYVGFt?=
 =?utf-8?B?OUxRWnBncU1kQmhtcmNNL3N0clVWYWJSdUgycjkySTF5Q1dvdGdOT3NtM0U2?=
 =?utf-8?B?TGZxT3FLS3JsNEg0WERSVjJzY1hjSFNVd1J4Y1NxM3hTUUlSSGs3bzM3NmN5?=
 =?utf-8?B?UzJ3WWNodFgyYUNRUzcrNmpWd3dNMktBK1RyYnFRanB3bm14SmZQMzZlQWto?=
 =?utf-8?B?dWJkRm9leG9SVWlCcHZ4VXBENFVQdUtXRnpwTWJhQmRMeVlqT1FKU3hJQ2VX?=
 =?utf-8?B?Uk0vTnBKY2xtSkM0cndFNzVPaVZYNENnb240RjNRUHdMblUvN3VRaWQrc2l1?=
 =?utf-8?B?RDIxMUNFc1NBNkwyM1FYcXpyclZYMXhjL1JDNE5lNmx0SmtPVVNKU3A1TUJM?=
 =?utf-8?B?SXRlaWMxZmZKK1V6ODl3bnVQYnIxUVN1YnFqVHloa20xY0VJdkZKcC9DRWo1?=
 =?utf-8?B?djVEVWcyVUhJQU1iaWJnMHM5cXdVMkxKbU4vQ1RVM0JhV1dOcnZlQlcxVEdI?=
 =?utf-8?B?WXJ6WFFRVkEzdDhUM2MwOUlGckRibVc4b3ByaURIenN1eTRkL29QSVNpOU0z?=
 =?utf-8?B?aEpEN1hJM3pYdVNkKy9DcGdwTEp3STRobjU1d2pYTEE3MTgvVFpoMEhLdjFC?=
 =?utf-8?B?NHUyblNzWmQxL0FyZkJGclRFeWV0ZS94ckk1RGVTbnBNV0JDZWthdmZSVWhG?=
 =?utf-8?B?VjVESWxERlpSV3ZwWEJDRDhrN1Myem53SlcyL2NvUTZxTnZNZXdvSG1mdThp?=
 =?utf-8?B?ZzNTS25NL3ZvWW1xMzhEbkhpOXlFUGFsalQvWWx4VEdoYnRmaHkvcHNvcjI0?=
 =?utf-8?B?TTcvdVZ5RFhPN09UK0htdkZNRHJxNkg1aURvRDVEYjg0UktYQ0Z0RitXTmMz?=
 =?utf-8?Q?MeU+Vjr8El54ngUg40MEkLHRsIjP5qDk5bhP0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkhsZkoraXZsekIra0IwT0lpNDFWZWFHQVAxc2dKWnpqTjFkQXd2YXRtYTNZ?=
 =?utf-8?B?Qkw5OWJCNG5Da0FsbGMzQkRZbFpEZklaNWkvNWVFNTVkR002SFJES2NLUUJo?=
 =?utf-8?B?M082b2x2QTZkRFFoN09DWjhqNmh6K2FBWkRDM09oMDl4TjBDMmpqRDlkdkRv?=
 =?utf-8?B?ekc5WGVjV3FxcHJpQ0tvUXpVYlZLRjVNTEdxajV2MTJibzI3dmFuNjBGWHEz?=
 =?utf-8?B?a2dFSUtLZjZ3V3lXa1oyOW9WUi9JTUVBcjJCZHIyZWdvenAwdmNVNXZac1Qw?=
 =?utf-8?B?YXcwczZ2U3paSXoxeEJYZ0NOWDRxOUtVeDdPVkcrZFgzM2ZscGVwSVZaNE05?=
 =?utf-8?B?dk9NbUhQdzJEL0o1d0ZtNjZzOXJTOTdjT0FkVWJWMEdLYTRnYUU3K3lKTFZN?=
 =?utf-8?B?WUNnREc5SUdkcUo1bmdVeG9BSkdGUG9Da0ErYnErY2ZCOG91dklUWEl6a2pO?=
 =?utf-8?B?RDN0NVJIdUlFRjZPMnZPSDRmZU9xaFZDajIyYkY1ZzdhUlBNa2pmRjNyQnNk?=
 =?utf-8?B?RTRMR0RUYXNwU2hPS25lTm03VFVLNDhYWTd4N3NZUGErL3pBbXY5VXZuWWRr?=
 =?utf-8?B?SVJIQlJoUW5tY3dFbXU0ZFJyTWRKUzltSEFFVVl6Q0xwNlhsdTdBQUJyeGNE?=
 =?utf-8?B?eTNDSmtXT3NwdFlybjcyK2wzVnIwL2pIR1hiRHIyMVVYQkJwcGI3VHpwbEhV?=
 =?utf-8?B?U0ZVdWJlekw5ZjN6VGlUcTlOaDVHd21MR2puWXFCMUsrRFM4djQxS0huWjBs?=
 =?utf-8?B?VFJTejAzL0srYnc5bk9FWEhaVDMralpaODBnQ1NwM01sUmJBdXVUM2p4bEdj?=
 =?utf-8?B?VlBKMmNYdHRGOHlqblZZSVFRbkJ4UWVBVnptK05yejJYWTdwQTh4RDRzb2JS?=
 =?utf-8?B?L1JwbVgzcGo3RHhUaWxRWVdIcHJWMWJFZk5rS2lIakQ0VG1YSGYzbGRiYmRn?=
 =?utf-8?B?RlBORjZxcU1HSE5YbFRoeWtnOHozeWIybHhhUzE2THc2d3ZOcVlyY29sUVBq?=
 =?utf-8?B?NWgzc0VNNDBualhXemF0bjRFTmVndFBWSTlFTVJ1V2oraStvOXdrVUNQQ1hl?=
 =?utf-8?B?cHUwclhLY25LNjBQRlVvL3JrdXdkQlVMejAybTlGS3Z4cUt0cHJmWjhBN1M4?=
 =?utf-8?B?V01vTys2dUFTNXVrR3VqYjQydEYwbXlZaXFPOE9lQ2wvWC9qS0VyS214RWZ1?=
 =?utf-8?B?UmpSUVpEcU9oZTRmdGMvNzdiemRwemNNODhId0ZISERFVk81ckh2MXViRlZ2?=
 =?utf-8?B?b0JYZjJLaVhMVlFpVUZDMUY5TWNJS1NUM0c2ZXBDN3FPN0lSWS9UOVpCWHZx?=
 =?utf-8?B?YmVDclpMSUZRbER6MnZEN3I3U0o5Q2Jya1R5TlJmc1A3T3J0Wm1RSWFFQnlh?=
 =?utf-8?B?NkJ6YUVublZxckFKZms1bFpkbllSVnVSdVplZ3JsZlRETFpZZEh2Z2hQWTc1?=
 =?utf-8?B?YWlmQ2d2NHRyTGhSTHhZdTVBaWJJRVBjNWhQSlRSdTR0d1VIblQ4QXdjNFFJ?=
 =?utf-8?B?aWhKSGdnQnJ3U3V4bVFOemdnVFVCK1ByKy9OTDIwTlBSTmZVYU1QSEY1Mnpx?=
 =?utf-8?B?OXM3K2NtV0Z0VWFMQllmSVpOT0t3QUxHNnFmb2hSOTBhdzI1NEJuaHIyUFB3?=
 =?utf-8?B?L01FeFI4VnVaNmE2VVFQNllqeDZuZm9KU3BPTjRUWWR4bng4NjZwMDBjVkZa?=
 =?utf-8?B?cEJpTFdQZ0trQVA5MkhBVFA2ZUVJcXpQRmVKRVNBQXljM00zYzVXalZIa1l1?=
 =?utf-8?B?cFpFenNhL3VQVVB0ejVVVWU4OUpKYUdSdWU5YytRME1oSUJTcE9OWGljWEFG?=
 =?utf-8?B?VFJZMnBZZEpuTXdBaGFDSE1nL3ptTkRDYzRSZmp5Zk1COGRZTTU0OEZIWG1K?=
 =?utf-8?B?MG83UTRXTEtvOXZvUlBqTTVLeTFQOUJ5aWdDNnhaYm5MVThEaEZzKzJVUU9X?=
 =?utf-8?B?NVJIT2c0TTJCd24rTlhxYkd3LzYxUG1NR3dtTmZLR012UEN3K3E4TEZSN3o3?=
 =?utf-8?B?QmJXKzJCLzNOY0lET1BRc3FQN093bTduc0J1ekZ3ak50WDhtWUl0WW0rM25Z?=
 =?utf-8?B?MnZqck1pT1lMWnF2NXdGaU9rYXgxbitFYURDVGE2ZXZSUGo2Vkk0c1BSRDRw?=
 =?utf-8?Q?ONOsgSbgYXoxGbZbBcpxBbpU8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c3905-6bfc-4720-0375-08dd070541f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2024 12:42:11.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1KJ2pA3estvwlbAJeDK7FWJP95VxuQk5QhQq9KqB5BJO9106lqh2DwF/bBtJWASLeJnmsHn3fhuzQo+rx8Hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIExvYmFr
aW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMTUgTm92
ZW1iZXIgMjAyNCAxNjozNQ0KPiBUbzogSWRvIFNjaGltbWVsIDxpZG9zY2hAaWRvc2NoLm9yZz4N
Cj4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBUb2tlIEjDuGlsYW5kLUrDuHJn
ZW5zZW4gPHRva2VAcmVkaGF0LmNvbT47IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5v
cmc+OyBEYW5pZWwgQm9ya21hbm4NCj4gPGRhbmllbEBpb2dlYXJib3gubmV0PjsgSm9obiBGYXN0
YWJlbmQgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT47IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlp
QGtlcm5lbC5vcmc+OyBNYWNpZWogRmlqYWxrb3dza2kNCj4gPG1hY2llai5maWphbGtvd3NraUBp
bnRlbC5jb20+OyBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBmb21pY2hldi5tZT47IE1hZ251cyBL
YXJsc3NvbiA8bWFnbnVzLmthcmxzc29uQGludGVsLmNvbT47DQo+IG5leC5zdy5uY2lzLm9zZHQu
aXRwLnVwc3RyZWFtaW5nQGludGVsLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldC1uZXh0IHY1IDEyLzE5XSB4ZHA6IGFkZCBnZW5lcmljIHhkcF9idWlsZF9z
a2JfZnJvbV9idWZmKCkNCj4gDQo+IEZyb206IElkbyBTY2hpbW1lbCA8aWRvc2NoQGlkb3NjaC5v
cmc+DQo+IERhdGU6IFRodSwgMTQgTm92IDIwMjQgMTc6MTY6NDQgKzAyMDANCj4gDQo+ID4gT24g
VGh1LCBOb3YgMTQsIDIwMjQgYXQgMDU6MDY6MDZQTSArMDIwMCwgSWRvIFNjaGltbWVsIHdyb3Rl
Og0KPiA+PiBMb29rcyBnb29kIChubyBvYmplY3Rpb25zIHRvIHRoZSBwYXRjaCksIGJ1dCBJIGhh
dmUgYSBxdWVzdGlvbi4gU2VlDQo+ID4+IGJlbG93Lg0KPiA+Pg0KPiA+PiBPbiBXZWQsIE5vdiAx
MywgMjAyNCBhdCAwNDoyNDozNVBNICswMTAwLCBBbGV4YW5kZXIgTG9iYWtpbiB3cm90ZToNCj4g
Pj4+IFRoZSBjb2RlIHdoaWNoIGJ1aWxkcyBhbiBza2IgZnJvbSBhbiAmeGRwX2J1ZmYga2VlcHMg
bXVsdGlwbHlpbmcgaXRzZWxmDQo+ID4+PiBhcm91bmQgdGhlIGRyaXZlcnMgd2l0aCBhbG1vc3Qg
bm8gY2hhbmdlcy4gTGV0J3MgdHJ5IHRvIHN0b3AgdGhhdCBieQ0KPiA+Pj4gYWRkaW5nIGEgZ2Vu
ZXJpYyBmdW5jdGlvbi4NCj4gPj4+IFVubGlrZSBfX3hkcF9idWlsZF9za2JfZnJvbV9mcmFtZSgp
LCBhbHdheXMgYWxsb2NhdGUgYW4gc2tidWZmIGhlYWQNCj4gPj4+IHVzaW5nIG5hcGlfYnVpbGRf
c2tiKCkgYW5kIG1ha2UgdXNlIG9mIHRoZSBhdmFpbGFibGUgeGRwX3J4cSBwb2ludGVyIHRvDQo+
ID4+PiBhc3NpZ24gdGhlIFJ4IHF1ZXVlIGluZGV4LiBJbiBjYXNlIG9mIFBQLWJhY2tlZCBidWZm
ZXIsIG1hcmsgdGhlIHNrYiB0bw0KPiA+Pj4gYmUgcmVjeWNsZWQsIGFzIGV2ZXJ5IFBQIHVzZXIn
cyBiZWVuIHN3aXRjaGVkIHRvIHJlY3ljbGUgc2ticy4NCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1i
eTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+DQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNv
bT4NCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5j
b20+DQo+ID4+DQo+ID4+PiAtLS0NCj4gPj4+ICBpbmNsdWRlL25ldC94ZHAuaCB8ICAxICsNCj4g
Pj4+ICBuZXQvY29yZS94ZHAuYyAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25z
KCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3hkcC5oIGIvaW5jbHVk
ZS9uZXQveGRwLmgNCj4gPj4+IGluZGV4IDRjMTkwNDJhZGY4MC4uYjBhMjViNzA2MGZmIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9uZXQveGRwLmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvbmV0
L3hkcC5oDQo+ID4+PiBAQCAtMzMwLDYgKzMzMCw3IEBAIHhkcF91cGRhdGVfc2tiX3NoYXJlZF9p
bmZvKHN0cnVjdCBza19idWZmICpza2IsIHU4IG5yX2ZyYWdzLA0KPiA+Pj4gIHZvaWQgeGRwX3dh
cm4oY29uc3QgY2hhciAqbXNnLCBjb25zdCBjaGFyICpmdW5jLCBjb25zdCBpbnQgbGluZSk7DQo+
ID4+PiAgI2RlZmluZSBYRFBfV0FSTihtc2cpIHhkcF93YXJuKG1zZywgX19mdW5jX18sIF9fTElO
RV9fKQ0KPiA+Pj4NCj4gPj4+ICtzdHJ1Y3Qgc2tfYnVmZiAqeGRwX2J1aWxkX3NrYl9mcm9tX2J1
ZmYoY29uc3Qgc3RydWN0IHhkcF9idWZmICp4ZHApOw0KPiA+Pj4gIHN0cnVjdCB4ZHBfZnJhbWUg
KnhkcF9jb252ZXJ0X3pjX3RvX3hkcF9mcmFtZShzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCk7DQo+ID4+
PiAgc3RydWN0IHNrX2J1ZmYgKl9feGRwX2J1aWxkX3NrYl9mcm9tX2ZyYW1lKHN0cnVjdCB4ZHBf
ZnJhbWUgKnhkcGYsDQo+ID4+PiAgCQkJCQkgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL3hkcC5jIGIvbmV0L2NvcmUveGRwLmMNCj4gPj4+IGluZGV4
IGIxYjQyNmE5YjE0Ni4uM2E5YTNjMTRiMDgwIDEwMDY0NA0KPiA+Pj4gLS0tIGEvbmV0L2NvcmUv
eGRwLmMNCj4gPj4+ICsrKyBiL25ldC9jb3JlL3hkcC5jDQo+ID4+PiBAQCAtNjI0LDYgKzYyNCw2
MSBAQCBpbnQgeGRwX2FsbG9jX3NrYl9idWxrKHZvaWQgKipza2JzLCBpbnQgbl9za2IsIGdmcF90
IGdmcCkNCj4gPj4+ICB9DQo+ID4+PiAgRVhQT1JUX1NZTUJPTF9HUEwoeGRwX2FsbG9jX3NrYl9i
dWxrKTsNCj4gPj4+DQo+ID4+PiArLyoqDQo+ID4+PiArICogeGRwX2J1aWxkX3NrYl9mcm9tX2J1
ZmYgLSBjcmVhdGUgYW4gc2tiIGZyb20gYW4gJnhkcF9idWZmDQo+ID4+PiArICogQHhkcDogJnhk
cF9idWZmIHRvIGNvbnZlcnQgdG8gYW4gc2tiDQo+ID4+PiArICoNCj4gPj4+ICsgKiBQZXJmb3Jt
IGNvbW1vbiBvcGVyYXRpb25zIHRvIGNyZWF0ZSBhIG5ldyBza2IgdG8gcGFzcyB1cCB0aGUgc3Rh
Y2sgZnJvbQ0KPiA+Pj4gKyAqIGFuICZ4ZHBfYnVmZjogYWxsb2NhdGUgYW4gc2tiIGhlYWQgZnJv
bSB0aGUgTkFQSSBwZXJjcHUgY2FjaGUsIGluaXRpYWxpemUNCj4gPj4+ICsgKiBza2IgZGF0YSBw
b2ludGVycyBhbmQgb2Zmc2V0cywgc2V0IHRoZSByZWN5Y2xlIGJpdCBpZiB0aGUgYnVmZiBpcyBQ
UC1iYWNrZWQsDQo+ID4+PiArICogUnggcXVldWUgaW5kZXgsIHByb3RvY29sIGFuZCB1cGRhdGUg
ZnJhZ3MgaW5mby4NCj4gPj4+ICsgKg0KPiA+Pj4gKyAqIFJldHVybjogbmV3ICZza19idWZmIG9u
IHN1Y2Nlc3MsICVOVUxMIG9uIGVycm9yLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gK3N0cnVjdCBza19i
dWZmICp4ZHBfYnVpbGRfc2tiX2Zyb21fYnVmZihjb25zdCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkN
Cj4gPj4+ICt7DQo+ID4+PiArCWNvbnN0IHN0cnVjdCB4ZHBfcnhxX2luZm8gKnJ4cSA9IHhkcC0+
cnhxOw0KPiA+Pj4gKwljb25zdCBzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvICpzaW5mbzsNCj4gPj4+
ICsJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPj4+ICsJdTMyIG5yX2ZyYWdzID0gMDsNCj4gPj4+
ICsJaW50IG1ldGFsZW47DQo+ID4+PiArDQo+ID4+PiArCWlmICh1bmxpa2VseSh4ZHBfYnVmZl9o
YXNfZnJhZ3MoeGRwKSkpIHsNCj4gPj4+ICsJCXNpbmZvID0geGRwX2dldF9zaGFyZWRfaW5mb19m
cm9tX2J1ZmYoeGRwKTsNCj4gPj4+ICsJCW5yX2ZyYWdzID0gc2luZm8tPm5yX2ZyYWdzOw0KPiA+
Pj4gKwl9DQo+ID4+PiArDQo+ID4+PiArCXNrYiA9IG5hcGlfYnVpbGRfc2tiKHhkcC0+ZGF0YV9o
YXJkX3N0YXJ0LCB4ZHAtPmZyYW1lX3N6KTsNCj4gPj4+ICsJaWYgKHVubGlrZWx5KCFza2IpKQ0K
PiA+Pj4gKwkJcmV0dXJuIE5VTEw7DQo+ID4+PiArDQo+ID4+PiArCXNrYl9yZXNlcnZlKHNrYiwg
eGRwLT5kYXRhIC0geGRwLT5kYXRhX2hhcmRfc3RhcnQpOw0KPiA+Pj4gKwlfX3NrYl9wdXQoc2ti
LCB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhKTsNCj4gPj4+ICsNCj4gPj4+ICsJbWV0YWxlbiA9
IHhkcC0+ZGF0YSAtIHhkcC0+ZGF0YV9tZXRhOw0KPiA+Pj4gKwlpZiAobWV0YWxlbiA+IDApDQo+
ID4+PiArCQlza2JfbWV0YWRhdGFfc2V0KHNrYiwgbWV0YWxlbik7DQo+ID4+PiArDQo+ID4+PiAr
CWlmIChpc19wYWdlX3Bvb2xfY29tcGlsZWRfaW4oKSAmJiByeHEtPm1lbS50eXBlID09IE1FTV9U
WVBFX1BBR0VfUE9PTCkNCj4gPj4+ICsJCXNrYl9tYXJrX2Zvcl9yZWN5Y2xlKHNrYik7DQo+ID4+
PiArDQo+ID4+PiArCXNrYl9yZWNvcmRfcnhfcXVldWUoc2tiLCByeHEtPnF1ZXVlX2luZGV4KTsN
Cj4gPj4+ICsNCj4gPj4+ICsJaWYgKHVubGlrZWx5KG5yX2ZyYWdzKSkgew0KPiA+Pj4gKwkJdTMy
IHRzaXplOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJdHNpemUgPSBzaW5mby0+eGRwX2ZyYWdzX3RydWVz
aXplID8gOiBucl9mcmFncyAqIHhkcC0+ZnJhbWVfc3o7DQo+ID4+PiArCQl4ZHBfdXBkYXRlX3Nr
Yl9zaGFyZWRfaW5mbyhza2IsIG5yX2ZyYWdzLA0KPiA+Pj4gKwkJCQkJICAgc2luZm8tPnhkcF9m
cmFnc19zaXplLCB0c2l6ZSwNCj4gPj4+ICsJCQkJCSAgIHhkcF9idWZmX2lzX2ZyYWdfcGZtZW1h
bGxvYyh4ZHApKTsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwlza2ItPnByb3RvY29sID0g
ZXRoX3R5cGVfdHJhbnMoc2tiLCByeHEtPmRldik7DQo+ID4+DQo+ID4+IFRoZSBkZXZpY2Ugd2Ug
YXJlIHdvcmtpbmcgd2l0aCBoYXMgbW9yZSBwb3J0cyAobmV0IGRldmljZXMpIHRoYW4gUngNCj4g
Pj4gcXVldWVzLCBzbyBlYWNoIHF1ZXVlIGNhbiByZWNlaXZlIHBhY2tldHMgZnJvbSBkaWZmZXJl
bnQgbmV0IGRldmljZXMuDQo+ID4+IEN1cnJlbnRseSwgZWFjaCBSeCBxdWV1ZSBoYXMgaXRzIG93
biBOQVBJIGluc3RhbmNlIGFuZCBpdHMgb3duIHBhZ2UNCj4gPj4gcG9vbC4gQWxsIHRoZSBSeCBO
QVBJIGluc3RhbmNlcyBhcmUgaW5pdGlhbGl6ZWQgdXNpbmcgdGhlIHNhbWUgZHVtbXkgbmV0DQo+
ID4+IGRldmljZSB3aGljaCBpcyBhbGxvY2F0ZWQgdXNpbmcgYWxsb2NfbmV0ZGV2X2R1bW15KCku
DQo+ID4+DQo+ID4+IFdoYXQgYXJlIG91ciBvcHRpb25zIHdpdGggcmVnYXJkcyB0byB0aGUgWERQ
IFJ4IHF1ZXVlIGluZm8gc3RydWN0dXJlPyBBcw0KPiA+PiBldmlkZW50IGJ5IHRoaXMgcGF0Y2gs
IGl0IGRvZXMgbm90IHNlZW0gdmFsaWQgdG8gcmVnaXN0ZXIgb25lIHN1Y2gNCj4gPj4gc3RydWN0
dXJlIHBlciBSeCBxdWV1ZSBhbmQgcGFzcyB0aGUgZHVtbXkgbmV0IGRldmljZS4gV291bGQgaXQg
YmUgdmFsaWQNCj4gPj4gdG8gcmVnaXN0ZXIgb25lIHN1Y2ggc3RydWN0dXJlIHBlciBwb3J0IChu
ZXQgZGV2aWNlKSBhbmQgcGFzcyB6ZXJvIGZvcg0KPiA+PiB0aGUgcXVldWUgaW5kZXggYW5kIE5B
UEkgSUQ/DQo+ID4NCj4gPiBBY3R1YWxseSwgdGhpcyBkb2VzIG5vdCBzZWVtIHRvIGJlIHZhbGlk
IGVpdGhlciBhcyB3ZSBuZWVkIHRvIGFzc29jaWF0ZQ0KPiA+IGFuIFhEUCBSeCBxdWV1ZSBpbmZv
IHdpdGggdGhlIGNvcnJlY3QgcGFnZSBwb29sIDovDQo+IA0KPiBSaWdodC4NCj4gQnV0IEknZCBz
YXksIHRoaXMgYXNzb2Mgc2xvd2x5IGJlY29tZXMgcmVkdW5kYW50LiBGb3IgZXhhbXBsZSwgaWRw
ZiBoYXMNCj4gdXAgdG8gNCBwYWdlX3Bvb2xzIHBlciBxdWV1ZSBhbmQgSSBvbmx5IHBhc3MgMSBv
ZiB0aGVtIHRvIHJ4cV9pbmZvIGFzDQo+IHRoZXJlIGFyZSBubyBvdGhlciBvcHRpb25zLiBSZWdh
cmRsZXNzLCBpdHMgZnJhbWVzIGdldCBwcm9jZXNzZWQNCj4gY29ycmVjdGx5IHRoYW5rcyB0byB0
aGF0IHdlIGhhdmUgc3RydWN0IHBhZ2U6OnBwIHBvaW50ZXIgKyBwYXRjaCA5IGZyb20NCj4gdGhp
cyBzZXJpZXMgd2hpY2ggdGVhY2hlcyBwdXRfcGFnZV9idWxrKCkgdG8gaGFuZGxlIG1peGVkIGJ1
bGtzLg0KPiANCj4gUmVnYXJkaW5nIHlvdXIgdXNlY2FzZSAtLSBhZnRlciBjYWxsaW5nIHRoaXMg
ZnVuY3Rpb24sIHlvdSBhcmUgZnJlZSB0bw0KPiBvdmVyd3JpdGUgYW55IHNrYiBmaWVsZHMgYXMg
dGhpcyBoZWxwZXIgZG9lc24ndCBwYXNzIGl0IHVwIHRoZSBzdGFjay4NCj4gRm9yIGV4YW1wbGUs
IGluIGljZSBkcml2ZXIgd2UgaGF2ZSBwb3J0IHJlcHMgYW5kIHNvbWV0aW1lcyB3ZSBuZWVkIHRv
DQo+IHBhc3MgYSBkaWZmZXJlbnQgbmV0X2RldmljZSwgbm90IHRoZSBvbmUgc2F2ZWQgaW4gcnhx
X2luZm8uIFNvIHdoZW4NCj4gc3dpdGNoaW5nIHRvIHRoaXMgZnVuY3Rpb24sIHdlJ2xsIGRvIGV0
aF90eXBlX3RyYW5zKCkgb25jZSBhZ2FpbiAoaXQncw0KPiBlaXRoZXIgd2F5IHVuZGVyIHVubGlr
ZWx5KCkgaW4gb3VyIGNvZGUgYXMgaXQncyBzd2ljaGRldiBzbG93cGF0aCkuDQo+IFNhbWUgZm9y
IHRoZSBxdWV1ZSBudW1iZXIgaW4gcnhxX2luZm8uDQoNCldpdGggdGhpcyBzZXJpZXMsIG1haW50
YWluaW5nICdzdHJ1Y3QgeGRwX21lbV9hbGxvY2F0b3InIGluIGhhc2gtdGFibGUgbG9va3MgdW5u
ZWNlc3NhcnkuDQpJZiBzbywgeGRwX3JlZ19tZW1fbW9kZWwoKSBkb2VzIG5vdCBuZWVkICdhbGxv
Y2F0b3InIHdoZW4gbWVtX3R5cGUgaXMgUGFnZS1Qb29sLg0KDQpJcyB0aGVyZSBhIHJlYXNvbiBm
b3Igbm90IHJlbW92aW5nICdtZW1faWRfaHQnPyBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBub2RlcyBh
cmUgbm8gbG9uZ2VyIHVzZWQuDQoNCj4gDQo+ID4NCj4gPj4NCj4gPj4gVG8gYmUgY2xlYXIsIEkg
dW5kZXJzdGFuZCBpdCBpcyBub3QgYSBjb21tb24gdXNlIGNhc2UuDQo+ID4+DQo+ID4+IFRoYW5r
cw0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQoNCg==

