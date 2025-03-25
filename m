Return-Path: <bpf+bounces-54701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8DA707B6
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A7B7A62FB
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66F26138C;
	Tue, 25 Mar 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WvnMeZ8n"
X-Original-To: bpf@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023143.outbound.protection.outlook.com [40.107.201.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DFF25EFAC;
	Tue, 25 Mar 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922394; cv=fail; b=hKZFVli2TXGO9gF0P5TSY5W9vgYr78A7b9W8r47ncnmKwNFExPmnxoIfcktA+mjB6DU1PH9uP5abyhfNHXPvMX9VX5taorWPbL17fEnNQ5SuXjfv/ZB8FSvnt+qC+UipELHHTg4zWOBFCX52NLZVmpVZMjyyemCgmyC4RoEM1SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922394; c=relaxed/simple;
	bh=CRmt3v9OTd0JjOde23UG4Xoo6Q3cERyGacEHMgshe1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AdL5DvDSejrqOD+bQUkuimskbYGzo3tyYYFwLZLDadkVruS9mVSrKuzJYnflVVSeEoyaXcIW9NDUBIus/Bj6mi7AqFBDzAutu8mI4GQlZpJVA+afntKVHp77CIwSy5uliVCtKjwxwlkMRWWL79MRTd84UpFyZYzhjKW/lzIBhLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WvnMeZ8n; arc=fail smtp.client-ip=40.107.201.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8xmnC6kzkRox+jb/W7Yn8tJ0ULbV+Oo9iKGNuTZLG2PD2VcRuLJfo2YvENu6LTl27lDcuV87piwAMDr5EZsWXkBDSbZmbnxhzZ2axntC3tInrED+uQC469xrxre67j1JbcXzX0UzaCms0Tj1YAYrMqkusGQdrPJ/kBHBJW5beb9BOmKMz4dupGD/TUEfM5bTUryZNg7+mWH1WpvOiznyCt69TKbe/N+khv18+Hbdb393YQadVeY5R/zDsh3fZbzni7tMvOi7dDtCH7swhewZAAdmBdXunzL8Su0fbUpsgYFmftF2xBGvznDkY09Kp6Bw6uLS1kimjpd3mU2Sn/h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AzkDOiZynJNXrE6AzxvT7Ytv513bOvxkTizBKwZt1I=;
 b=Iv00Xqjd7qU12Kx2aY8hARzJ4pzVVHZAIk7DWcTSKjyyt6vEGYRldrdwHqZePnGj4UN6AqwqfV3sMYB6XMkrAF8fmZyYXhKQAZDO0DGXZwyCgwIoZi/CgtzJsTRi8lIp0MMZi937yc53kWt/SwKArvPeBnGu8zSbVVi48DOiOJ/sQmjesUjySpWvCUzlwZFdj0WLpHmTXsDSy0p8L6b1cXwxRpl3kJ4Q+FaYNaGkSmM4ru8wBUUxZEwP2yOwPomOYycg+wWZZvbqqjkURw0qmx+r6Nkp0FLtHxBu+SClALNf2NedpI1n0bppzPkvVPBR6GtrsCORtktE6drNf39cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AzkDOiZynJNXrE6AzxvT7Ytv513bOvxkTizBKwZt1I=;
 b=WvnMeZ8n3HjtXv2GlSSnPS6SRjDO62TRbH3toyDeVMbxpeXon4sBvP9QLOp7VgUCDB1cuSgCBizyfDPHk5rvFPgiAg9DL5rEq62tPKjCzSqQc24yWLvorRlEM4WiSk233NMesauBSTX0vDHOlvGNs77aL3m3sad7ughqSRjTC8Q=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by DS7PR21MB3364.namprd21.prod.outlook.com (2603:10b6:8:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.25; Tue, 25 Mar
 2025 17:06:28 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a%6]) with mapi id 15.20.8558.037; Tue, 25 Mar 2025
 17:06:28 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Topic: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Index: AQHbnaOLMtMGcFkmHUqnlbDfcH1CsLOEFM+Q
Date: Tue, 25 Mar 2025 17:06:28 +0000
Message-ID:
 <SA6PR21MB42317CBFF4D1437A3B39F98ECEA72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2d4f7ce-4753-4bcb-994f-e7b7d6feca24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T17:05:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|DS7PR21MB3364:EE_
x-ms-office365-filtering-correlation-id: 6d415a1d-2423-4891-88e6-08dd6bbf6218
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+9fwZSm4o239a9Y6h9xcMM47IX9NFvKEZY/1Uj0BhZ84JBK4tfGKlIwlowX6?=
 =?us-ascii?Q?3z/NmsxUyE4nDpJ0pFF0NInV7Fvs/ZIMyg9X/Hfg36WJylkWGxZbot1pCEKy?=
 =?us-ascii?Q?vNb+RD5shEuMANgpX9LWYECcAF7c3LADFTbdMH9eSlKs+zVKlhSrW4Q3ojrP?=
 =?us-ascii?Q?asvhxdbOSujNqP5blr5ZCfxKYrSa6kSbl8VW+Vm56MizkmM+ILG35mOJoE8A?=
 =?us-ascii?Q?b3oPWnHgb+UX/384Y3JOe3jUcNPlEJg2AB0BIS4GOziJS5FKdUiBNRyZ5pRf?=
 =?us-ascii?Q?ieTr+I5Q/9S6vlSt9yL7XVvH9j6jnLB/j/2+CCxbhLL/f4AmiCMkgaiLOFYu?=
 =?us-ascii?Q?tcbZL3+X6Yixvg+eYsZ09a+yS+RDTEhvC7iiFPYCrFULsZqePc9dV/aP0hTW?=
 =?us-ascii?Q?5URq39q8FtnZgTsmAfFBTz1YWn8uuH3TvgOmisbqf+jMaz9HnB36wgDHhtr3?=
 =?us-ascii?Q?XhVk9JkOs9w9U/afVKxqB4fCL7XfsCMsMAbKLqisVLFiSIqJ64P6RTzmwvIS?=
 =?us-ascii?Q?ekGLzUPKDldX7g/oUoalIzEorIM1jqtpzGLM0PTY+oMTDfHG3goOavtFxFTn?=
 =?us-ascii?Q?kf7LVwW9QSwXT7dvRornYccAahUJsgKZdUGlkbcnU1fVX8Z3HxZir0Kfnuit?=
 =?us-ascii?Q?2DoNaadHk5E+C1oKlcUg/fxWnPISC8EnTn6Og2/CcpKljioTQXfJXbBfQYtf?=
 =?us-ascii?Q?Ipu196jSmaNRJIZ/FjXdMxTfMb1zTQkxV0i9Jqp/vtf3BKyPlKPGcMyWobny?=
 =?us-ascii?Q?uukG6nfROOMCAny9TgFScIta4nY+LV5z3Y7rN8yQD2yaEtxzYmYzZC3kQfDJ?=
 =?us-ascii?Q?fkFu03y+ZtutD2D6KCCOueSqPHtrPJ+IA1Mg/2U5+4tvjthm41fEJWrEXKO4?=
 =?us-ascii?Q?pKyc0neC+DW77911DnWXZJqY55fqX/+jMsFCqBT2JUmIbgA7TXy0dAyirFpt?=
 =?us-ascii?Q?Gnq3XPvwPUNjep2uINWcG+dHzUQP3br+0z40sre5YLSsP/1ktkMKWOWwlYDB?=
 =?us-ascii?Q?Ypk332aBMW9UnypdhKzId90sUOYoA58XRe4VJ2kZy7blm1jGckC1HKsnfrKt?=
 =?us-ascii?Q?hEkUG5/xNQ2vDLGV7unLDEv8Z//gWRB9afUfm+4Zc6DrgPrPUbNKKvc8Ypmk?=
 =?us-ascii?Q?/T6k/slCA3Z8qrU60Odux/SkWdGoMxzpSoVl736ymmP0Kq81lvx+rgoF7u0Y?=
 =?us-ascii?Q?uEGAST7xCi0EQE6iTbhgFQtTcOd2qqis06mC/verTi6CER98tqUM1KmC5MaJ?=
 =?us-ascii?Q?0+tJyup+AdHL7ww0aFHCuMw/F9QGSsTQoAPXJ7wXXEpfBzsxYnZ8BJ0ATzDj?=
 =?us-ascii?Q?hQCzlV6W41aO+ZMTguDoOOApt2TZkmhA0aLUkT+x4F7+Y+mC3WTSFP4LosUW?=
 =?us-ascii?Q?YseyAzmKiJLk1kgOBuMAZEzgpRAZ5di04T1CCsoPygq7LJSYO7FBgbB6hVkC?=
 =?us-ascii?Q?oGIsoqaN+1+/9NJhkE59x42ji862NzdmXesPq8HW9h9mCRzvY6JzMFo3uHWy?=
 =?us-ascii?Q?/wegOIQcKYUyN4Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?grbgD65K7uuLIetZ/73+bFOLxwQE3kU9oJKjSmhLxH1K9A/9flXL8ZHU/Dpq?=
 =?us-ascii?Q?ZqKWl0sT/GUzSDyTINPW2YqkGMzk8cAYYyfy2UDosA8mbQQDKl00cwjrs1OX?=
 =?us-ascii?Q?Isc0b4CSlUNnq0/RwpgyAml6w26rxC9VkGJrS7koH21C3Ez5/mqcb5at/c5R?=
 =?us-ascii?Q?2KqYHBf7s5sJH+b/YRsBNAifny2P7Hip2H4CzAj5TdpG+eVgLb7HNvdsHoyT?=
 =?us-ascii?Q?4YpJHdjejk+9QhD83b1nmNP9kGEQ/fCHoCra0G8jyF00nyjERWpIMLMPgTrg?=
 =?us-ascii?Q?dTXhNXWH7awMNw9i+lwYybcwQhXYuu+q3e0KT/rzvdR6k10qWbTitVIr1nQA?=
 =?us-ascii?Q?qKkuvCLu4YNwbhyMeiMSj/GcwyvRZugWIl1xZcs6RZQceB0PUD/PGCafPbt6?=
 =?us-ascii?Q?z2wuT9STERlwKfJuvI9/lojbBrghEcFx0kk1pfUWI+Vxp6D5Py7y+w037Vya?=
 =?us-ascii?Q?iA1CneMztKPTf1xojk78585mw/ks3Rif6VKi29tZSaxgeu9rnoDZSdqzoIO4?=
 =?us-ascii?Q?bqhuEyL2IgUVzP24RA53tGHcOFWMttQwUlXxcfdKhxC1n/4Z5H49LvPKzK0S?=
 =?us-ascii?Q?4UCfg8kY9GXGy6eDDL/tsU/aYsPCcL8k6sM21ib/xZrq6riDYA+7SddukGSc?=
 =?us-ascii?Q?sSzsW6zd9m14ijFD42klyVKPamx6FVe8E65bH5vEWjfbDGgB3rqlWi9rGG5I?=
 =?us-ascii?Q?Ixsk6hT7F6RcqpNtrU3JllxhQlc0f9vVipZJ9acVjnsR33s/gwrf0Xjlbu2y?=
 =?us-ascii?Q?XnRMDHGqwqBPyB++vzC2bF17pAHjakT5LdFbGZCdGtls7tMntefqQlqE1Xet?=
 =?us-ascii?Q?saFCvTjBFLKO248xlpOqokzqSr+3PQZpBTe2rUbR3mPaafj92KmB0kSRKFmz?=
 =?us-ascii?Q?Nu+DoLrbD6P8CLYOuqxVrqvrlYeQLA0DJnUANrZbYCXWNuBLqQK3ev/NZnxX?=
 =?us-ascii?Q?wC355X1BvzZRQgIqVvxs0V8ldYkoHHH5mA8mHqknJcQJKTl6HBnC3Pt0VCia?=
 =?us-ascii?Q?fVelTKftexpxAdMuur5JVI+IreJSN9BDOcQKqHNtqT00zyLM3Ls2YO8cPMzA?=
 =?us-ascii?Q?hvCqV2LsZj+FawGjnXetEZBkuI5BV2kKUH2P0Cnc2Rvme6mT8nLcIMNfDZDc?=
 =?us-ascii?Q?ZWusPmUPFSFv8HGOjV7LoLg1ZxATf05Y/CCCpkHzQxlNa+Y686RzGbaL1URy?=
 =?us-ascii?Q?cF6RxJXcB21CQKIRf3GDFhYPlSlrlVvuOiBtyZ1azI+sDVNlWRq2ZSLp20Ix?=
 =?us-ascii?Q?12Sez/DcArl564+7YEXSnJ29GMQX7QJfePdXN4fVmgcmcayIaKndf5yc6Mfn?=
 =?us-ascii?Q?7MpzHltO6JqISiT8wuvSDjeVWBEhnlrMjpDwXvBBC9E4OYmN3hGgyoHlYqF6?=
 =?us-ascii?Q?YpaImtS5wnb+JV6sS/5AjPhvkUMxxO3pSGRnvB8vPIgw3s10kwrLlDA/4lNI?=
 =?us-ascii?Q?XFrFWewDqGpl9wWxykcyNV1NvUH+ATnez5tcdQGWdZS/wGb49PGUzy3CEl3/?=
 =?us-ascii?Q?g3NfyjFhZI090JvzZBcC1HQXXSgU1FSWtJcKGWDbz4qwXi9/dkxtZiDPi7Sn?=
 =?us-ascii?Q?9hEvYg4GIgtc6pV+f397D79KRb9PP2oQVhuUZOCD?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d415a1d-2423-4891-88e6-08dd6bbf6218
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 17:06:28.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mSjVNAHVykJvma4306l69q1paq8jGrDqG2RwZSLjYTFWuVkMJgssBIRXxgzFmzXrptB5uEYjhFcgtSF7tu5tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3364



> -----Original Message-----
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Tuesday, March 25, 2025 9:33 AM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; jesse.brandeburg@intel.com;
> andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org; stable@vger.kernel.o=
rg
> Subject: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
>=20
> Frag allocators, such as netdev_alloc_frag(), were not designed to work f=
or
> fragsz > PAGE_SIZE.
>=20
> So, switch to page pool for jumbo frames instead of using page frag alloc=
ators.
> This driver is using page pool for smaller MTUs already.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: updated the commit msg as suggested by Jakub Kicinski.
>=20
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 46 ++++---------------
>  1 file changed, 9 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9a8171f099b6..4d41f4cca3d8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -661,30 +661,16 @@ int mana_pre_alloc_rxbufs(struct mana_port_context
> *mpc, int new_mtu, int num_qu
>  	mpc->rxbpre_total =3D 0;
>=20
>  	for (i =3D 0; i < num_rxb; i++) {
> -		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
> -			va =3D netdev_alloc_frag(mpc->rxbpre_alloc_size);
> -			if (!va)
> -				goto error;
> -
> -			page =3D virt_to_head_page(va);
> -			/* Check if the frag falls back to single page */
> -			if (compound_order(page) <
> -			    get_order(mpc->rxbpre_alloc_size)) {
> -				put_page(page);
> -				goto error;
> -			}
> -		} else {
> -			page =3D dev_alloc_page();
> -			if (!page)
> -				goto error;
> +		page =3D dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
> +		if (!page)
> +			goto error;
>=20
> -			va =3D page_to_virt(page);
> -		}
> +		va =3D page_to_virt(page);
>=20
>  		da =3D dma_map_single(dev, va + mpc->rxbpre_headroom,
>  				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dev, da)) {
> -			put_page(virt_to_head_page(va));
> +			put_page(page);

Should we use __free_pages()?


