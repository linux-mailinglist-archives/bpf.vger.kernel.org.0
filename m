Return-Path: <bpf+bounces-36835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7007794DD24
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2616D2824EA
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBCA15D5A1;
	Sat, 10 Aug 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lf2UJCTU"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020135.outbound.protection.outlook.com [52.101.85.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152A2B9A4;
	Sat, 10 Aug 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298006; cv=fail; b=WbipAgN5OfPOa0emj3JFqU1Wc7AOdes9csXRv01mPxC2Z3JARxyhV8GOi7QRaJkbmTw9V06E582w4ZK8zqi3VHx45xp6oq9KGYjdaX2ZBLy0ukONZXgJve8+y/8uFvZnCzYqzi+DXDqHGRuM/NJJ2gjq6lR4m/MhJYLyjf9MPP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298006; c=relaxed/simple;
	bh=+EciQmZa/xUp1YVyJw9NoGAK5AuUh7RB8HDN1ZCCrBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPfandFL/go6Yu2OUJu9fmhwcat5Iy7muYeJbrswTzHPdsUt1ODWvabAdr25rLW+06RS8D6osW0w/Vsnltr7U2n2Zp3EKLshQ3nX2AgOY/8cPJkZ/aam5LmuX+R85DULPP3hS721Cc+fxrAD9KZ1qlTESPQHhrg55m/TrV2AyfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Lf2UJCTU; arc=fail smtp.client-ip=52.101.85.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcJTwZiu14r5+fbpBFKYUtLRegOZNe+MSt3CWLCBQlcrabo9sC2DNLuBW/e3Xmlk9z1HWTE1AJNi1pJOGBUmDVhaenTTluR2+cFDhRn35AozIyc5kYFAFheQ23EkK4xzjJokUk306PUgNPbaoVSdQa0TCSeQXdf/j93TZgMRGKvd6kx9U5vTSERgypE1THgx+CS5nIt/q76bsZxJLgNN9skoodr5Uv4F+aLCBaHJje3IE/TnIrkeufKsWti2uk2HRwgzaFjkismG0S6NM06+WwWRSDzGjrffNaOOwJUxcYkCXRm8VtjBvRynlFrvYv18I+0ZgOqE/yjjf4TV2hGdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBD9r7g92DaVyOKCraCB2NDxW4JZPM2houiB7TnS56I=;
 b=cFCsYc5i2uWJe96zMrNC3m7yLE9fIO60Zg05B2618e1DpaF5K8zgsq/AQ57qx+jP4u96N/lOZlBxy0h9m3Kp3B/g53wXOfEeKEbdbad3G93mNtjJe7GFnzd+N4NlE7ZHDf0mIeCOzQJXXi3/nCB0K2bKJMW9ExZC14HnYWmOlzlWXfHp2qlABMXKFgjaLU7jcGUkM014InaRsDGE2aXnzLzsVPO7weeVVyfxmP0zxTvcQ4dayrjS7UG8T79VJGVuPPaefEhX8Yfc/6iZ9CiAlVf/tJvluzN4fZzmt6r0qaHw/HmpzjK83hVHMxUoLy/bP7WoB9CcaDB/XVKKlbzZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBD9r7g92DaVyOKCraCB2NDxW4JZPM2houiB7TnS56I=;
 b=Lf2UJCTUTE/u5vAzbIX0NmvoS3v3cp08KzKQNuzDy2t3pdDmLbt6bXpheZ1yFMFhYk5N/x9HDWixsqUa4f5/U8K+1+fafIzAYYrNFw3jrqUZLBxhq2SZvrAfRZ7GgpJ9XmU7IMjDjWaSS/EfKlvk+Qkl5r6Ph8RzhD/zzmyywEc=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 MN0PR21MB3438.namprd21.prod.outlook.com (2603:10b6:208:3d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.10; Sat, 10 Aug
 2024 13:53:21 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.009; Sat, 10 Aug 2024
 13:53:21 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix RX buf alloc_size alignment and atomic
 op panic
Thread-Topic: [PATCH net] net: mana: Fix RX buf alloc_size alignment and
 atomic op panic
Thread-Index: AQHa6p90m0uDljYx4UKuse8SC+NXXrIgg+3Q
Date: Sat, 10 Aug 2024 13:53:20 +0000
Message-ID:
 <DM4PR21MB353644BF43244D3509267741CEBB2@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1723237284-7262-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1723237284-7262-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef35f7b3-8342-4306-9f86-2912de2d42f1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-10T13:52:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|MN0PR21MB3438:EE_
x-ms-office365-filtering-correlation-id: 1aa3d3c0-f7e9-4a72-18db-08dcb943cb7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/4FSDKQ9el62tkFiUIa9Bdbx8+M8BrqpaiqmrDcGE9tt6z2TjrKGoGtGNjB/?=
 =?us-ascii?Q?QHkkbbP9qw6oR8Wagetn6AK8nFYgBrwpp/LuzM1El5w0gJaYjD/6cvbXTJE7?=
 =?us-ascii?Q?CjlKcsK0YXS9QYugElIVSjjBFKImzJOcW2kWhIfuQ1LULTcU/m0U1FV9WynT?=
 =?us-ascii?Q?wPb8QdPhgwTv7izdoj7i6Q0OC1liu2PYPs64Nt+lus7Q8dDYIWSRoJ43+kdI?=
 =?us-ascii?Q?Jr7LLmoqHwNZU0ip3vJz2FmdhglsDSq90fjhx6v5Ufko4DPCNbjwlGZSx1z9?=
 =?us-ascii?Q?hqg2ZtCV7bdTKZBMr7gJpp9pmxeOiGrtsRUXBDNoZvldlUEpN6/WVAtL0ykB?=
 =?us-ascii?Q?5AEXSXHOW+GBhCv3PQALaZrEMDCTLWrg36kITxJIInf88kMCbthFqzcLxw//?=
 =?us-ascii?Q?yYrVMBWA9mA2NIrtdRIbOvF8sERd0UDAXjMYzCdmjl/ErD3TLYm+mGy24KyZ?=
 =?us-ascii?Q?ejKuH0ULJSA+CUEAieGfAp8UKHU3q1mCdP5++j6vy61QckKMa3WKb5Cqvw0A?=
 =?us-ascii?Q?ecyiMSvQulma1MNi/C2UnOGm2PZVddYuCIOCVchXn+XRtEpRDVNuxRA2OLah?=
 =?us-ascii?Q?0/cCr5nJG3lwNftV9j4t+KjfsxOiduQvEHVZ16qcwQeqMy6kfg9No366Wmak?=
 =?us-ascii?Q?FjEyJeo86OzBoc1XXC6onQYWY6UgejU7tTmYgBtxTUWiViU6ekpF7hvftIbs?=
 =?us-ascii?Q?HSHfifdDOXKoFE3djZyr3DHcs2z+eWXWvgqshjI0eYT2KegdW0qqYa7D4Vze?=
 =?us-ascii?Q?wHwDXQWRC0CyHWvqgyO/Q1o59AGtu+Yg1MBJgqN0gSkY7HteBBdIt5Gz4Snl?=
 =?us-ascii?Q?IKHtcXv2jE/rLGoledXgMiN17IG6Xm4T/8HCaB/YMdBcqPHikC363h1hZXIG?=
 =?us-ascii?Q?DB8UG8TbTrvl/Whk6GtZVMGEL4utbkVUx/Kd/76Yb4q7sBXE9kc1Xtd6FH7p?=
 =?us-ascii?Q?5RfE6W0f+c0YJpyzmpnuGj6Iq8mZtMxEi1ct5P/bX8s41xNx1KkbZieJ8CPr?=
 =?us-ascii?Q?wg8bsMA9U585ZrM+OAgry+s3+jd2c4QvbiDLuu92VDZhq0TOCcSJm6Jeb9Wz?=
 =?us-ascii?Q?hbAN/N4Iol7J+z67KlSvpUIozZaV6iWl2LfALdPxp/RVBJZD2sbxQWmO5G+5?=
 =?us-ascii?Q?cSmYM0a9GE4BnZ3zRu/m85EcCXIIEDN4fxB4HQnmMdiAkp4weh9kMij/KOS5?=
 =?us-ascii?Q?S3mDxDaKpeDnSd9qjNqUGreecOj6Kq8hYDjVppKM/kLgH8wbl7sDvCuls4BP?=
 =?us-ascii?Q?WxnFH2+skmFCP1LJb9GlT7O1uithlCdHdT1iJA7X/BdFJGZ1ZTKzaHo8S4jv?=
 =?us-ascii?Q?xkvV5iNsq9EVQOoPDHFc8iH5kTwWKBWqkVmt7Tcd/hDb4TtfsjazI7jukdIl?=
 =?us-ascii?Q?1mjldc9owMmo5DBxc0Jk7zLZotUZ4XOBLRLAesnp9/mg2MZSWA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A91zhJPCan9jo72afNTyh1j/Spve91U6PoeD2Bz50bjPV27YUKfsvFdpl2Fm?=
 =?us-ascii?Q?bjMWIfdTX7A9qmW2UUtfg8kr1gW9lnK4h81JsaKxDQHe60t4AZOUtwluCZdT?=
 =?us-ascii?Q?X4wSV0iGRJY4pVojOstJclCfU8Qt6lTOOCawoX4G9TBuIrL4J/uJ6UNoF7aN?=
 =?us-ascii?Q?Nw6gPkRk5Hp3r3fbAl7vHWKyl4uvta7hzEgKe/JTnkSzXAdiaBi91xSAjXLu?=
 =?us-ascii?Q?qrdmDfMhVZ3m8B6IyPacMZM/W89Vk+/iWmPeTHbjlFgFI2mwu9TF5qaLa3jp?=
 =?us-ascii?Q?zl53STO/T1X2dy05KQ+ImKIB/6msIufjzyFLsbPB6KyT0djc/uUkrFT5+VnF?=
 =?us-ascii?Q?ir2kIZpb7FhUHZmAqRuHIqOyKw95Hjr5fOydrze2fzLbC35N/SOwJmzpByn6?=
 =?us-ascii?Q?IFd+T+8d9mZPXlBzKKAknTMVDp+dwQ+lBvzd8N/pISJdGAPa6SB8N8bqQ42S?=
 =?us-ascii?Q?n4jM1sLY7BMGSYua8tYEKZwPHS+kC93+sGK7nEoYpoBih1EgNUro0Sd4Nnts?=
 =?us-ascii?Q?YrIfQl26vKLR4qkQwEaUQZMrzd67q0SR5SggqTxlclZ0fU78CTBpzlec/iV8?=
 =?us-ascii?Q?z+pzFmeqhyBLnrT/xvSYkzyGvJ8MZm6YCoCm+kTXVNPEfNnnP/nDrGQ0pI7c?=
 =?us-ascii?Q?1F3vBncOfAVruTntHNy1QhYY1y5kr2F5jVujJRYIS3XUFQACWdfTHPvM6Six?=
 =?us-ascii?Q?hcoZOPzdG8NKHkka7PceFSgTjXE3HQz9/d89vBcpbLdewLHnzCeyENVa24/S?=
 =?us-ascii?Q?r/ZmcO0dUv1x0QEHIHGOV/y7X6FTCGgWfiaBTXqrYBFlYho12D88Bd8Biisk?=
 =?us-ascii?Q?WkyRSNCzCB+z72C4Bferw171/KCgwiKoVfJuZej+V3+1B35zf9hVVROGQglY?=
 =?us-ascii?Q?anMj+erIaAHlul9oA7j42CFjQPl8e1E2+uWuhUt1F29/LkPWN4YSqMMdVOi1?=
 =?us-ascii?Q?sHRPIxy8RFX8511VR3n9gKMCIzwflviYLu6LYvArc6FSiz5+zm5ehYNmbPHu?=
 =?us-ascii?Q?9sVg/oSDHR+w2WjuxYAPKs8ywJoKknZycSp/6pjRRJmcgNX92nz3IVG9hl61?=
 =?us-ascii?Q?2St5qoDgxh3MgCMdyARK8OKcbgy9S1U/Wea3MoC87Hz7mYSY9yscsXpEmTc/?=
 =?us-ascii?Q?b3lqdnuNyk0pqBmbrFf6dsU4cF//sIGGueofFjfLCEZPM9oH+S15jrGTZRpN?=
 =?us-ascii?Q?RIND1NkJO6plU0GKBWogukuYAeaY5LVCLZoVZmhd8yMllyBDOh5f4p5xua6Z?=
 =?us-ascii?Q?MKXpjGcKSO/pqRMhmra2zxtVFVemL+Zcc1jZHLWoMvxUec2xhE1XD1nbWpMo?=
 =?us-ascii?Q?wYE4brlD3E70xrjd1Aix/4O5po657zDYWrFac+wJE0vDLYS4lwwVOpNYqWeU?=
 =?us-ascii?Q?2cR8QKhEHm6RplEqv9l8kdQ7gAMcsLsA5Y6lE7wFMm1t27b/oxjb3iT9G+Zw?=
 =?us-ascii?Q?RDTTyWUD9RtsO4/bCROq43aRFVy5kgsMiECDHcgDYaxH5/2ihjqTivwjUUgG?=
 =?us-ascii?Q?HNVBUO/ON0hPfm9pU/cc6vRhuKPg/JS3PMx/ifMgB2k5+E/2XC5H1LIUCO+q?=
 =?us-ascii?Q?OBDVfed+xCmzjLhJxZN0PLEsxpVxLtbJDizDUeqk?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa3d3c0-f7e9-4a72-18db-08dcb943cb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 13:53:20.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dv2EXjEqkUh/K0MC7vFME61oLhIAqPsl9CTpB8aCSAuDzXyh3RBcGqYLXEuZn7/0zDCXvgklzGX7qsEG+nOFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3438

> Subject: [PATCH net] net: mana: Fix RX buf alloc_size alignment and atomi=
c op
> panic
>=20
> The MANA driver's RX buffer alloc_size is passed into napi_build_skb() to=
 create
> SKB. skb_shinfo(skb) is located at the end of skb, and its alignment is a=
ffected by
> the alloc_size passed into napi_build_skb(). The size needs to be aligned=
 properly
> for better performance and atomic operations.
> Otherwise, on ARM64 CPU, for certain MTU settings like 4000, atomic opera=
tions
> may panic on the skb_shinfo(skb)->dataref due to alignment fault.
>=20
> To fix this bug, add proper alignment to the alloc_size calculation.
>=20
> Sample panic info:
> [  253.298819] Unable to handle kernel paging request at virtual address
> ffff000129ba5cce [  253.300900] Mem abort info:
> [  253.301760]   ESR =3D 0x0000000096000021
> [  253.302825]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  253.304268]   SET =3D 0, FnV =3D 0
> [  253.305172]   EA =3D 0, S1PTW =3D 0
> [  253.306103]   FSC =3D 0x21: alignment fault
> Call trace:
>  __skb_clone+0xfc/0x198
>  skb_clone+0x78/0xe0
>  raw6_local_deliver+0xfc/0x228
>  ip6_protocol_deliver_rcu+0x80/0x500
>  ip6_input_finish+0x48/0x80
>  ip6_input+0x48/0xc0
>  ip6_sublist_rcv_finish+0x50/0x78
>  ip6_sublist_rcv+0x1cc/0x2b8
>  ipv6_list_rcv+0x100/0x150
>  __netif_receive_skb_list_core+0x180/0x220
>  netif_receive_skb_list_internal+0x198/0x2a8
>  __napi_poll+0x138/0x250
>  net_rx_action+0x148/0x330
>  handle_softirqs+0x12c/0x3a0
>=20
> Cc: stable@vger.kernel.org
> Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d2f07e179e86..ae717d06e66f 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -599,7 +599,11 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasiz=
e,
> u32 *alloc_size,
>  	else
>  		*headroom =3D XDP_PACKET_HEADROOM;
>=20
> -	*alloc_size =3D mtu + MANA_RXBUF_PAD + *headroom;
> +	*alloc_size =3D SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
> +
> +	/* Using page pool in this case, so alloc_size is PAGE_SIZE */
> +	if (*alloc_size < PAGE_SIZE)
> +		*alloc_size =3D PAGE_SIZE;
>=20
>  	*datasize =3D mtu + ETH_HLEN;
>  }
> --
> 2.34.1


