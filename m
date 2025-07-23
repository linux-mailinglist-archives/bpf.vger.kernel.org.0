Return-Path: <bpf+bounces-64209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFCB0FB31
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DFB9673D0
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D0231836;
	Wed, 23 Jul 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JWRW5M7t"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023101.outbound.protection.outlook.com [52.101.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA9200BAE;
	Wed, 23 Jul 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300554; cv=fail; b=Jj8DC6YFZsfCq6Ci/EdbJs+VDa69P71tTX3pbjj8UB5d9tvSeSDVEAZ+ui1E3eKzUwDzBQ0GYXQoYT75xXrbg9sfPzraKeSASYsc5GlE/FpVBiH1lon7eQ4imwj9M0Pg8K4skFocpqjJ8q4qyOWc8uuxvoTBtVuV7wWzUFxf/Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300554; c=relaxed/simple;
	bh=NbRkuUrANDq5CHoZZRvLOgV6pZsPYSWNURLiv1D8L6E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJKjoOcoS8LaMxUKIleNY+n3otvCObIrRBy8j2tVF7QXC/MFadsVRlDYQT57FSWdvXuVSYzrM6sgel5Oij3qpOFieYVwyTwXSKxeS9EwLsD9U551Phig/CMHG4t8xZ8+Ku6COPdovmtAhIUtnqZqI6KA7LsRT6UtM/TxtZXdZOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JWRW5M7t; arc=fail smtp.client-ip=52.101.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2nMV2kb/wFRobBj4dBWzMFTfL8NPlxb3MRDQfQGldkyuZ7k2U2lO5ufPa5BAW2T3tbQXbcWAx5BV+r4CbWBJqfqO15yzlp3/pNW8akVC6zQbcGyJOQmfrsi/MtwIDYu7fx81unVJzW1b2hau2DTi5MYKtsWYEBzoV9XS3CbGmeX1jf8tKUCo163kDDox9dhFAouqoPIqC78dxcuyrfsVxnc39c11+dKrFaWq2PwOyGsRScvd1xPVR94JSpn0H6SQuSUtxTllNk1zoFk71pmnCSV5rSa95n0P9dqbl8slJ1wrcTQBKYy8FLvqg5sJwDzrNs7BZMwZXixRIgY0Xnpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhUN9bYyya9HcQTKRb2Tr9lYZtPkq3KIWG5QNp1HDcE=;
 b=fgFYYztJkXF20hxFurq0pCqGt0f6xyX/ljKaYIeHfw5Evjxd2wG/rn/pYAw4GOVpx+CR+BkZVDHeICC7CuqekHjo4TkltB3oVn9Gol68Vp8oRTES1ARAD6D+5QvMl4RkDZI4weVDeZ8myQXfK9NVgLZ83JS806nGRzeJVnpSv8oJNrvcKXGhRpqlZgeYhRteXt0RYAW7HPkVR1UEraqqHf2vPp4LI2h/9RHxaQcvSv3K5S5Lg4qBKqrnTvPB/ckSNk4GHI5FqUwUPaRDZhmYW1EdKbD7s3nVa/6nVQhoqFMuN6Q+M2FiuB92N1EKw7tXEband1/T81QokykdFldDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhUN9bYyya9HcQTKRb2Tr9lYZtPkq3KIWG5QNp1HDcE=;
 b=JWRW5M7tNmkZaHm/DnJq8nfHI7nWFTlls34f5K8feDL9dy4RAcjiUcXuf6RN6uEepe6suownZclwqOXzGfEfH7V4O7zTu5da9EiqU3HyrpWQe78nGCwDYoZIFeNaGzJEC/zI9hY6XCPx5OjGPOoeTR8hx8Ie7i/wWyxr4d21Qyk=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ0PR21MB2016.namprd21.prod.outlook.com (2603:10b6:a03:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.5; Wed, 23 Jul
 2025 19:55:49 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Wed, 23 Jul 2025
 19:55:49 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michal.kubiak@intel.com" <michal.kubiak@intel.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Dipayaan Roy <dipayanroy@microsoft.com>
Subject: RE: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Thread-Topic: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Thread-Index: AQHb/AUBeOoDCPVUaUazwNHsW9rYXbRAHwZw
Date: Wed, 23 Jul 2025 19:55:49 +0000
Message-ID:
 <SJ2PR21MB4013DD021CE6EE505366E83DCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References:
 <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=15485fe5-d475-47f0-9408-2df30c684c9e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-23T19:53:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ0PR21MB2016:EE_
x-ms-office365-filtering-correlation-id: cf8ce484-87d7-4757-1bae-08ddca22ebe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5CXy0LpNuwICJ0h0F9L38DpWvO1XtInpWpZUNDxLSzawrnaBIuQVhRuz9T9p?=
 =?us-ascii?Q?Q/lpBnl//La2N0rAFeml93Hz5VYRt1HHF5g2VkEp5Ir34OzpMKfBDTAFXGBo?=
 =?us-ascii?Q?QbszOmyyqgLQRnPpyfYLAJQM7lqJENyEl4j7M3JQi0o7UR6NRQf9jOP/SyzQ?=
 =?us-ascii?Q?3gcHl0Cmek4Z8pxJTkpG8/cFFqsozM8jZiKApvsPrLJBX913SnaQVRvx2swn?=
 =?us-ascii?Q?v+v8nIep8FU3AT+4s/ACRObHUZIoXbaKtFD9N5K48L171XUy4idh4mP+GvCz?=
 =?us-ascii?Q?rHCPrQe9X58cTis8kaIz9125VP7iifyF1I0lZPbSCdtYFgeTuzPDopW9SPUG?=
 =?us-ascii?Q?SLz+Pp+E8rhktNT75zoUFTecY+lU2vNGQCvMejn+qmo5gmm4cvKSwLzjOCdl?=
 =?us-ascii?Q?YOyBI0tj+8YWcJNBWEaL9sRzN09tITlYV6GfUNSWcMssRgUoa1Gx62Bcexyh?=
 =?us-ascii?Q?ivzRUoo2RmQER8PznBt4tw5u2D6lDuCe5aLbHEw1Ox1jDiQVbj3oDST1a6tR?=
 =?us-ascii?Q?YIC2tQ5oX1dImSoK7xQZs+h9QubtoGYA44Uuzc9w9nIm4TSBovdZqjOU9EDz?=
 =?us-ascii?Q?C/Zn06KBH500NeF9MOcj0pDqMPqaTpyZ8RlTds7vrWuAOJ8xOOCiiwDO6SzB?=
 =?us-ascii?Q?0dnFMeuiXux9F3Xg73KOOk9puIpgD19U++y7OQfPOsC9OkR1lQH8h4Yb/laT?=
 =?us-ascii?Q?MmV0dkZpM3dHGOu8gsIzN5q6RHZXfMcpkI61UzngzHelSgeKnh/0+70sEvaF?=
 =?us-ascii?Q?gNpDAFrnHDZWnlXR+Ij/hM9J23C0KjWgv5jxS9y8M7Orr30D4UJAqlxx1RJ1?=
 =?us-ascii?Q?bjC5gfUyWUh50N+uG3Gz3KEV2JLB6oIxdTg58jCde3vHP8XBOXn7lCkVq4eW?=
 =?us-ascii?Q?QnQUjnBN6gd6dqeO5lvY22+Vggydw1+7tRFY3P7pcbhOFVswSyHmyuV74Jtj?=
 =?us-ascii?Q?L+xynXTiMwv1uS8UD4/Buf26IiWMPzJtyNFpFV9kbrmD5GSldAjxgiY+mHty?=
 =?us-ascii?Q?jWi3r3vZ+/u5HNPBnLRhIWks58wM4OnUvOgC01o5NxVU3qwJhMEYYtetJDYe?=
 =?us-ascii?Q?/RcHj2qqn+nyNL9EeJBv0/dSCFuqhKbRcK0juNz6NUndVKR+grDsj4ERgyM+?=
 =?us-ascii?Q?pAk8ADgB39iT5hq2CoWIuZtKexpaZUOame0r6LbF2JMgMdrH73fd8gQHiJyu?=
 =?us-ascii?Q?x8p0bI40nCPtGdYoK5iHxIn47VjbQXLfT0Y4RmyAUtz3xgS+EeANJ+9ObTT3?=
 =?us-ascii?Q?E7pileE7fVXy44/Zo0ooMxFJbyIa02y25Vgg0q2VYxF4cGHWRLMRS1mq5RyD?=
 =?us-ascii?Q?WKvKbFd5TewMojNxwxljjR/ItEOeJfL3/TzNqljq39V89uQb1b5xhXbtt+bW?=
 =?us-ascii?Q?p6x+0zMOhMhkPOyaxONxaSxOF4OKPJwG1SI8Zm7PVyET10UtccFNed4+ZoQN?=
 =?us-ascii?Q?UlPoa+d+SnsZM647FV/uZnjCRF8NL8oZkFvKazMKNWOWU9RAoKAJvN3lvpI7?=
 =?us-ascii?Q?BX7JNBxpjyHS4Kw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NffS8qZjEMhgOOEuE3IDCurlhrfo0tyFPOnyVgCoCUoFVYGaVlhRCFOMil1K?=
 =?us-ascii?Q?K0ywfwUEEIbIdD62SvrzFbwIn+sliUfJCrZZ0E4q7QFn9bJ0E/c+6GJ7UOhF?=
 =?us-ascii?Q?CAAfCO3e79RJLtOw2fOZXemECvGvmU+WaACqdYReowYO9sO4S3I+04bxvsgo?=
 =?us-ascii?Q?GRZ/sQyZ8Z4N/77zSrvXKt4gNtwNHPfpeTQSwYE/3gE1QetxwZyFUHeLGDWb?=
 =?us-ascii?Q?GlX3hgekO22CS7WFFnReYrczAMG7PjCi5hMcb9XxCDNs9t7hcVY+C0LiLXRr?=
 =?us-ascii?Q?V5g8CZG10PqI3ZgTHsYNzY1xX73xiiW6zR+ezaZcAVJj3sMDbF9dyYYNvARX?=
 =?us-ascii?Q?wng7dzYENaxluiKfH/o4ebOZ/ffqVEPc7SuulIWXwIrf7N/MfiYI1/9yGKfg?=
 =?us-ascii?Q?55n56u4dPjqxdBw581r9bFZID9jl5fJ3+XVVzbvzSBNAKQKWuwo9NtFBdraQ?=
 =?us-ascii?Q?3B5w0wVYnPt2xdHjg6KCWVnq7rDgOtZtM46tw0Ro+sH2KL/enrJTSS6shbmJ?=
 =?us-ascii?Q?nBu86DbSg6rW2VLjZmFWwPyEBPvzjPoatsxSr2OcfyvU2ajDGg9VXmcuQpHd?=
 =?us-ascii?Q?yuRF4pC/di8Iup/P+uXq0iECG4buZ4T/NmSEix9D7Cj9hpxxN17SUH9GAJDx?=
 =?us-ascii?Q?wHg0GPyvr8RKYiB1N+j1F+UPljchqBpQkzGq6UxZOHZLBKqyPb9zZU/IW1QH?=
 =?us-ascii?Q?KePL2ChTTgW/y7sk2tcZsIGO82kgRRWSY8UHbkvVoDPnWlFhNN9ti+MrXNMs?=
 =?us-ascii?Q?fKl7oAv7AKVjz1s9L+5O4GSw4lsW35DO5NCty1awJG1RpILLL90LYE7yiTpa?=
 =?us-ascii?Q?x94KKBrXQa06Zo2zxA3afDCnkraafalg0Z/1OwQb9D0vQy43vGBTSm25OV2g?=
 =?us-ascii?Q?tg7YMPfv9m8mw8qh9T6MU3D11taZNO/RfTLJLuTQRQW0GgPjFko4abqT/zMt?=
 =?us-ascii?Q?cUgcQyjrO9WmaGT/XqDOMsroF38KUVqn9W3pCVxYXjbwizpdsiVung/dehHR?=
 =?us-ascii?Q?lAmNAIUrvpbE3iXzzTl/AWeFSr8VVILjxr6te9c1BXdRV/otHyvqFcN8kAzR?=
 =?us-ascii?Q?FVLPK7PEfZ72imWJwfPjZNOQdxMYvnfVSb/2sNRuxHXEjegNCGmpr7lpTy1d?=
 =?us-ascii?Q?4IERP/L+izg022/uUy7ufFF0NVbn2vfn0si94DsAKHy4JyzSkOg6Sj3f3COn?=
 =?us-ascii?Q?5IRAvvSkICVCyq3jB5ufKj4st0IIrq7n+w90mWPhnlNbAZ79whQkN1ANDqm0?=
 =?us-ascii?Q?YJLIdmr/4bMZovo+quEe5xHi9T2SAwfzp0isjud2WzgO03NZlIXtTNuSa4GU?=
 =?us-ascii?Q?w8br/MFTlV5XiOl/4dadrh6KzuJSBPp5CiUow8u5lXHOMjAiw0skXXT2P9+K?=
 =?us-ascii?Q?pu2IXWtuVJA9NNRkatLa7FrdyXLlOhV50gS6aJ3iLtIU/mPbQ0P7S2fC5/oz?=
 =?us-ascii?Q?wEpaNvmsf1Sxyt6aFCALmNZi+Q+WQ2yuy+Bxv5EjA4mdtRcXym3u2H82VtNI?=
 =?us-ascii?Q?vWpt28nK/mBfxOmGiOQuiqUc4I4gKqWGnj+A5B1pp0Bklz+r0U2wODMaTH1M?=
 =?us-ascii?Q?SebpqaRMnjlPDpSrhU1TfTd38mnaw4mIwOmKXiCG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ce484-87d7-4757-1bae-08ddca22ebe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 19:55:49.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCOwcEWpFUrW17k1BTC2koCT0jmzp3hUDTbC7J46FTZP5sAY0K8xk0awQHlCKSPZwuh7kXx+q+qhgZ90abwBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2016



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Wednesday, July 23, 2025 3:07 PM
> To: horms@kernel.org; kuba@kernel.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> Konstantin Taranov <kotaranov@microsoft.com>; ast@kernel.org;
> daniel@iogearbox.net; hawk@kernel.org; john.fastabend@gmail.com;
> sdf@fomichev.me; lorenzo@kernel.org; michal.kubiak@intel.com;
> ernis@linux.microsoft.com; shradhagupta@linux.microsoft.com; Shiraz Salee=
m
> <shirazsaleem@microsoft.com>; rosenp@gmail.com; netdev@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-rdma@vger.kernel.org;
> bpf@vger.kernel.org; linux-kernel@vger.kernel.org;
> ssengar@linux.microsoft.com; Dipayaan Roy <dipayanroy@microsoft.com>
> Subject: [PATCH v2] net: mana: Use page pool fragments for RX buffers
> instead of full pages to improve memory efficiency.
>=20
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with large page sizes like 64KB.
>=20
> Key improvements:
>=20
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>    * The XDP path is active, to avoid complexities with fragment reuse.
> - Removal of redundant pre-allocated RX buffers used in scenarios like MT=
U
>   changes, ensuring consistency in RX buffer allocation.
>=20
> Testing on VMs with 64KB pages shows around 200% throughput improvement.
> Memory efficiency is significantly improved due to reduced wastage in pag=
e
> allocations. Example: We are now able to fit 35 rx buffers in a single
> 64kb
> page for MTU size of 1500, instead of 1 rx buffer per page previously.
>=20
> Tested:
>=20
> - iperf3, iperf2, and nttcp benchmarks.
> - Jumbo frames with MTU 9000.
> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>   testing the XDP path in driver.
> - Page leak detection (kmemleak).
> - Driver load/unload, reboot, and stress scenarios.
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



