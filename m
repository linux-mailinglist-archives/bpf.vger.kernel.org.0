Return-Path: <bpf+bounces-31927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D6905506
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5950DB21E5F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B2F17E461;
	Wed, 12 Jun 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aZUKDB/e"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286517C221;
	Wed, 12 Jun 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202121; cv=fail; b=rrOu9sn28+4hAbIraktM7Zt+xnu+GbN++nLYdf4/5ZaxCP71T19i5cEippemdSzeEbFzaH3iHnuM8lhnMirYKkJZsveF+tceHqXclKl0yZLfmzCeeR3T8hrOSe+SsLyXlK3kk3w6Q7Q1APMAMXPFYMz5IvGm/H+GqaG4Rm+zB2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202121; c=relaxed/simple;
	bh=S2OT5dHrUoj8zvveGNw1osRiB4r5++dJTJl7H4koJeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdK4WBQe8mtg8S2FT7pjV5VwFX37ezLXHBa0Cg9FByfhEqveq3Mzo344+1n9HFVYEzH5MvjJYswMxoTmObimpQ1XpoAGZrVDahGGQEV/HHC+R2fL3Dg+gUJ/gVXEV4MXST+BAOwD5nc1ATPpc8fwrZ7HgUAcCHa9T9Ue8ju3DTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aZUKDB/e; arc=fail smtp.client-ip=40.107.94.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwNW978b8Hsau1IRsZJuxUH1UwXrjmE47+NtddJt9zsgDsCYIWGi1BaURc7wUDOM/bb+1Jqriq85UKkOcuYMlo0d+8ViWb3uA2PMhxQlXdeIu+G3oUmSA6Z/ivKzJNPqCteaa5LqX2MUQ6h1MwsCEsIUL6Sc6gbt7YcwkhdNc1k/IUGmM4Qx9vaUYvg2TiU86LYocPD+6CbnNvcdccpMtMntzEjcAUiwuVrrEiAnqCTsFBInqjIuj9lQL0pUjlCHG6c1RfVxfEOtT8a4dfnCuDyrdC57CJrLaoDzL0JsFTn0522aUmrNXWJPMjxjI5ce0wSdqFpXo7dT+sFLrj2MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkuQzAXbpuz1Z4FAIpiFlW/6Zvcp6xC/LJpMq63BA6w=;
 b=l/RPxykUWdn8h40yGFP61foQbzLiLuluzuxsb149PfJqU9kC0Pux8NxRjKt54qifYkhkQLyztYvCi3kJRxMVRkc+MwI3XLjgbvUNGII8BtFTnB8Q/HEwROX8rG0iDwm9qwmI/84uQ+nzMpRDMCx7TzMtMaurbGVkeE854FfYr4Y2WGRIDA5shnBR67nvoV0QOqWTlnr+AK7jDye9iYbyOw2obOgnkIYC3ZmrZoPwzpG2GU0vu3KLmxBSuDuR5gebD+gvBMbJaH2mIEPRJ6/NmsJTi0YE2UXSI7b/kTxOw1arCZmfnyOMFXjiBJWWQWDsMIzaAk0wT8zmo9Aq66XVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkuQzAXbpuz1Z4FAIpiFlW/6Zvcp6xC/LJpMq63BA6w=;
 b=aZUKDB/eCOL8KhU2PEghFlQkeChPtNJlA4TXoDOSI/srlj05JQPBiWPB0gwvnQvl/ty6TxRs8SqhwoDdwPUy6TJWF3BpINA89Fs+ZuaiyZAG86ld7dh27UrrEbiCIdVhvzHl3zzQ5GHRly9M68Bqp00kjyvY28sGkbNJLTS4fGE=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 LV2PR21MB3277.namprd21.prod.outlook.com (2603:10b6:408:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.8; Wed, 12 Jun
 2024 14:21:56 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7677.014; Wed, 12 Jun 2024
 14:21:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Topic: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Index: AQHau3yCjVULPkZ+NkeRwzD4A2YQ07HCw4UAgAAC/7CAAA858IAAl4CAgAC8DoA=
Date: Wed, 12 Jun 2024 14:21:55 +0000
Message-ID:
 <DM6PR21MB148141756E3739CD3F13E2C4CAC02@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <SN6PR02MB415781A68B43463F34A884E2D4C02@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415781A68B43463F34A884E2D4C02@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb4882b-67e9-4568-8c78-027b60b1813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T16:45:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|LV2PR21MB3277:EE_
x-ms-office365-filtering-correlation-id: 6c3f676d-5c05-453e-cfd7-08dc8aeb036f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|366008|1800799016|7416006|376006|38070700010;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3xQZxBKBYeAiGEUThj+0oMJpACXX5Y11PTD2bAUPBXyBm/Ey40hh0WSubL?=
 =?iso-8859-1?Q?VQDRTlWtWeUDo+XUvTmPyJmPwu2InszGavNIHOC0s/p4vHpURYWFXWI4B+?=
 =?iso-8859-1?Q?6kDp7QgXq78veT2P3m4Z5htG08yOuOFpsDEZsV41+KzLTRWrCVBh7qi71y?=
 =?iso-8859-1?Q?n+3dtBbcy1mDIrk+kKNCDxVuw84NFkhKLtNWwclWM6fwCqYjwREipSCgd+?=
 =?iso-8859-1?Q?DXwfegGZJt7iERXhU1RGZNCC+6m+AMpSDg2G/74XHwiu4pIwkX6STbNelJ?=
 =?iso-8859-1?Q?1oOzD2rj/UMA9bQd07cdEqAZ3p8KeZRqmIq4/e0RG3RUZydMqQb+QoPtVw?=
 =?iso-8859-1?Q?iWwKJ0+6FLJhA82cXNdEuXvaY0vmdmFLAu7GhUGmAUw1ILCLUdYMiohcuA?=
 =?iso-8859-1?Q?qdNR4oy5kQ66Sm8sxSxRjjyAkkHtJ2v2y87VVRWW5jK2aiMCrqX86vnPMa?=
 =?iso-8859-1?Q?jjHdc5heSJj4MoniB8hTcztDJ+DOYeXMjWxAHVD/LM8TH+kWCGJCtgBmKT?=
 =?iso-8859-1?Q?OAYtDye7Y6Ddnlda4jXIsAywQrX25/d0CfGdXnURwTkPBlqaZjyRWPHlLQ?=
 =?iso-8859-1?Q?vo8uyJvr34OPhOjMzx4HBcoPYgR/iIy/9+esnM3VNLkv4p+DKcWcdM3w/9?=
 =?iso-8859-1?Q?UvdJg60Vytd/afNsYUgjv1NZRP5T1hC8pL1bMnG8FTRLpI/9vs7TEoqq/g?=
 =?iso-8859-1?Q?5UcrEN9SiYAudciZsxkKvavkLI3oAeN+bub6tjMQ1YT/6Do56bqY4DO6z/?=
 =?iso-8859-1?Q?2vF7I+8nIyArmiGX4CcVOPCFDIEyttkUT0ICc9WypGyXJ3s37oPzdKIrcL?=
 =?iso-8859-1?Q?egyG/1M0KDnWsEKdVevqQeNOcKCwB/INvBLHHAtsg22s3QoSv3X1wDsBUV?=
 =?iso-8859-1?Q?b3MoHlWNdAmf8r/TyK51xuEsl7r8NdCp/uDgoSyITQx/j3e7ayx3pisqmt?=
 =?iso-8859-1?Q?HYhf/JpwXxAljrC7IfMLApsw43uq/plpho5R5P4/H1xGnB45FiDr7Ay/QA?=
 =?iso-8859-1?Q?FtjjG07vxYYSEChpknLWrQ2BtS2UvSCJLJzRSc3aOe6yHHuhYPDSkJNd12?=
 =?iso-8859-1?Q?cRjW2JUQ52FfcSTH+spcf3p8kN/elbGk57RN8KyE4l2BOx7hdyXjy039xr?=
 =?iso-8859-1?Q?4NSymBlhPdbWO5WUOlJsxtln08GJZeRBwWh7kuhoQYdQ6apOjanCOwyVo5?=
 =?iso-8859-1?Q?z4uZiTXXP9oXnGKHfgIWvHyU3n/LhJTGiMCHKDV0ivQTHfEyvIb8wi21gY?=
 =?iso-8859-1?Q?EV+6TFj4lT8wIqi08lfFaLdX1iH5mGO6Yp2CpCWllUXVCQLpWsE+5GM73O?=
 =?iso-8859-1?Q?HeK0dXcad3Q2AgFNOhCkDdr1wbxkEgRV18u8ftm49TGCggQOOYXdmRO8Ve?=
 =?iso-8859-1?Q?b98hkgyEZHEAQgMS10b5GqSkCB91gpW2uXPJaKvsUHZoTrPDwSpX4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(1800799016)(7416006)(376006)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kJsfKERJEHrWLQEhuSGr6vxQ03GQmPpntuHnyoSXsJ5cyKu6R6JwdAz1s6?=
 =?iso-8859-1?Q?K/Sc9q2YUc384M3irh5prLs7B0nCw7rgsmxTQdsXb6D1F9QwO+cdRkpfLT?=
 =?iso-8859-1?Q?I7x2SuQoqFnbGIgZf2nCoJlL0kYcm4ojZEHdhextiu0dET0Zx+saTZs2wP?=
 =?iso-8859-1?Q?RgYbNIb+rVKxSF9KXbiVAcFhcVwLkVVTB+kEjytJHjdh1T0Rs3hXp+frrX?=
 =?iso-8859-1?Q?GVu0K31IMl8cshegVSEPr4pikEXSWEdtjaeNcjKvmsFdINtWcEXkufId83?=
 =?iso-8859-1?Q?rg9XHQEv1gP70Kg/ea/mNJr2oe1P+52MrxtfTWT64B+q7okLMSvj+QHfFl?=
 =?iso-8859-1?Q?1Ny34uh9jwOTX6IhEMyXx16+LodnXl6hVxT9PKXE0qibQ50N6igNtF8+B3?=
 =?iso-8859-1?Q?5EuU4t+E5bmPBUlClmZsPQZ86+xAQttPsOdsZ4D9rxA2dOpNYQn6aEjbYZ?=
 =?iso-8859-1?Q?BYnzTyn/Rhl7uDk053MwRfUaujVW8XVaK4dobMAMnFB3HBZEUbPPxkUsb/?=
 =?iso-8859-1?Q?fBzTnqVDwAWsncq3BpIH040WRcBJluyK1UM9++fUo9T0X/3qrVJWUE7yYo?=
 =?iso-8859-1?Q?VsZlYksxi9WKLjhUmfSimAzzIfRvcaQMuwtc5N+J7Kf0fVmZ2T4POlE1QL?=
 =?iso-8859-1?Q?CeJOcBPzyTdEujLtf5uPGQF34VBF8fBNp2n7nBlKSQXDXrIfreP3AYl9S4?=
 =?iso-8859-1?Q?tBMoF6mVvyp5fiKKrC+VjkkqjLF8fUhXdFK4EpGzppvfts/SjOlNmEVJNO?=
 =?iso-8859-1?Q?a845/Lej13PnElGKBYkGHAiKAHoR/xNEKKKFr1+vnoG4rc1p2HmIY8tGDM?=
 =?iso-8859-1?Q?DgeLOKWHxS0/zWBcuA2mC1drSj5ikh2H21IAONBy99BPCtVbFnFIW/NvYy?=
 =?iso-8859-1?Q?5s3tlkCyLRPqmAJ8WAHq7bQmKf0A5HJNEXrEqlqgkMjFYygaTGZl+Ke3yC?=
 =?iso-8859-1?Q?I08rEkJAK4L4/NpFA1A1ZNSPqMsMNj8K4fkyP5DZiG6lw0lyhZYvmxNINQ?=
 =?iso-8859-1?Q?4gFBeY6Sm+0UElji9sgvZo4Yo0gaHLF3hU9AhzwIJ8v7yCZ9nRvu8Yldp1?=
 =?iso-8859-1?Q?Cv5VOoF2CgmWtJVCzi0KQTRHogFfiqKAPs8DZDR4C9SMmA419NOIp2Rgc9?=
 =?iso-8859-1?Q?SyOrf29ks5NFR0k8sTec38beDbnB11dedjLLEYISkb6cqzNB2GsnGmFCqj?=
 =?iso-8859-1?Q?L4VL9jndxh8CLBG+QZBTTU7ERPh5pRmHMh1ErPQYH/f+UOUcbAO477H0MN?=
 =?iso-8859-1?Q?3IwWaLsMSXQBdXTIax/1MmOeamtGdNAL+rw//zDJakvSPcneAmXUwWnkAf?=
 =?iso-8859-1?Q?X+km3Czhpavmk1RnHMkNm7nrQP09ZtaXoDwDGl+e06F1n7ITJItbzol18l?=
 =?iso-8859-1?Q?y3Z2SePv5N5o5nSYLcIpzc3SKBeF/POR37Llpt+dnhELCLw1MeD1NftGqy?=
 =?iso-8859-1?Q?wc2iS0YeuRVGWkFS5UJs6ItWKKL2DbtdT1hpn/si+VGEe5Tv3tHcyu9KLu?=
 =?iso-8859-1?Q?+Pcxrm2+8JfrYZd8zsPYHRI5mWP88tF91W1tEZVxZYbTEvBUb/KYSzwMbc?=
 =?iso-8859-1?Q?QuQQBLEABEYPN35IXc3c4hxWRtSaJTIDp6mBqyTkmYlKIfhy/EjMXpWTvW?=
 =?iso-8859-1?Q?vP7QJlGyuqtuHInxNHTHVWK3gBIqMk7hfP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f676d-5c05-453e-cfd7-08dc8aeb036f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 14:21:55.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WhXhPAqLWZ/8UvwMBrbJAmi/aG9DiCqIb9tYuqf/68/okRWPDPSYHg2I3kmTG0QpdwtPBqaSR4/EUslxFGX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3277



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Tuesday, June 11, 2024 10:42 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>; stephen@networkplumber.org; KY
> Srinivasan <kys@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; leon@kernel.org;
> Long Li <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> rdma@vger.kernel.org; daniel@iogearbox.net; john.fastabend@gmail.com;
> bpf@vger.kernel.org; ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH net-next] net: mana: Add support for variable page
> sizes of ARM64

> > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > index 1332db9a08eb..c9df942d0d02 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context
> *gc,
> > > > unsigned int length,
> > > >=A0 dma_addr_t dma_handle;
> > > >=A0 void *buf;
> > > >
> > > > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > > > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> > > >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> > > >
> > > >=A0 gmi->dev =3D gc->dev;
> > > > @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region,
> NET_MANA);
> > > >=A0 static int mana_gd_create_dma_region(struct gdma_dev *gd,
> > > >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0struct gdma_mem_info *gmi)
> > > >=A0 {
> > > > - unsigned int num_page =3D gmi->length / PAGE_SIZE;
> > > > + unsigned int num_page =3D gmi->length / MANA_MIN_QSIZE;
> > >
> > > This calculation seems a bit weird when using MANA_MIN_QSIZE. The
> > > number of pages, and the construction of the page_addr_list array
> > > a few lines later, seem unrelated to the concept of a minimum queue
> > > size. Is the right concept really a "mapping chunk", and num_page
> > > would conceptually be "num_chunks", or something like that?=A0 Then
> > > a queue must be at least one chunk in size, but that's derived from
> the
> > > chunk size, and is not the core concept.
> >
> > I think calling it "num_chunks" is fine.
> > May I use "num_chunks" in next version?
> >
>=20
> I think first is the decision on what to use for MANA_MIN_QSIZE. I'm
> admittedly not familiar with mana and gdma, but the function
> mana_gd_create_dma_region() seems fairly typical in defining a
> logical region that spans multiple 4K chunks that may or may not
> be physically contiguous.  So you set up an array of physical
> addresses that identify the physical memory location of each chunk.
> It seems very similar to a Hyper-V GPADL. I typically *do* see such
> chunks called "pages", but a "mapping chunk" or "mapping unit"
> is probably OK too.  So mana_gd_create_dma_region() would use
> MANA_CHUNK_SIZE instead of MANA_MIN_QSIZE.  Then you could
> also define MANA_MIN_QSIZE to be MANA_CHUNK_SIZE, for use
> specifically when checking the size of a queue.
>=20
> Then if you are using MANA_CHUNK_SIZE, the local variable
> would be "num_chunks".  The use of "page_count", "page_addr_list",
> and "offset_in_page" field names in struct
> gdma_create_dma_region_req should then be changed as well.

I'm fine with these names. I will check with Paul too.

I'd define just one macro, with a code comment like this. It=20
will be used for chunk calculation and q len checking:
/* Chunk size of MANA DMA, which is also the min queue size */
#define MANA_CHUNK_SIZE 4096

=20
> Looking further at the function mana_gd_create_dma_region(),
> there's also the use of offset_in_page(), which is based on the
> guest PAGE_SIZE.  Wouldn't this be problematic if PAGE_SIZE
> is 64K?

As in my other email - I confirmed with Hostnet team that the=20
alignment requirement is just 4k.

So I will relax the following check to be 4k alignment too:
if (offset_in_page(gmi->virt_addr) !=3D 0)
                return -EINVAL;

Thanks,
- Haiyang


