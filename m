Return-Path: <bpf+bounces-32291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403B90AE6C
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C63288E41
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C09198A2E;
	Mon, 17 Jun 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i2q5Vbrp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68826198A0D;
	Mon, 17 Jun 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629007; cv=fail; b=X54OAG7iKnyaGbXRHPPzRh/HCVJTqTJCsM5S9ZRqTCxMx4N25qZEhLAiihpPAyo72urf+y2otmeasc9PwA5tvWvaM3wy/+uQc/UiVCkxXwu8Hj9zquT9ltSM7aMgsOfuCHVXRXEgq7Ao72Ai2InVmv1eZ7QnjTyvB2RYxU6fCYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629007; c=relaxed/simple;
	bh=UgS896ySatBAzpcpWS1SGB3ybrYF+QuJMJTCLCIpAXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoE2Ss0HzcTNeCvlHt+lNRvagBwETmwbiZCeqkhJQB13czfxt8gUKtGNQhZtPn6Flbn5R5Hn7j/qR73uKDwXGnW8zhc8ZOGDLmGjb5johvWMLkf+mljkhQUArQyer6VTtJ8WJ901cYbfKou7zpC6UN9mtROP3DY5WW3r8RfBmtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=i2q5Vbrp; arc=fail smtp.client-ip=40.107.220.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8d343718tjUM55r155+LqWYl8nlMBJebG7hlLt6UwtcGbjbhFy8oDlo7YMhsrJJU3Yk2uakPo8DnaimYwPcyW5DL4ZX2UsWLqB/Rrpp1O90+QfJKbkJouo6qEdGjaimhnMdOQeI+i6dqLS34teQ5vvP5BT4FsKv4afc3uCaLHjzLHiKhoq0sWM2G3xMGYnoxXK3OGX2Un6X3WdYatpHm85eXcgUvBFvN3Dteu5F9HsfnPVa6cVEVYSMZ7eW3FiI/2j1koBhv3SrhGl4NvORQzRxAlvV728ENM/qtcoGHBrh7Oct5erpj6lDTlgMJiM9eiOlChFLPswQjLeRCxgglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym5C/aYStxnynJC98r6GJgf/L84t8+rtZf6M5IxfhiU=;
 b=og2IKzDe60pAbdMfIjIBSut6hXhVw7lTYGZV1c7/fw3z9DHgb7ebYNhtsk7j3RRuBfn3OqcKhmGo6CfPgQ168sPPQWZbPg9Bte4w2blZN84eHV1ke7tgiKfYQ/eKg8w58Irs+cKGLZa8T8LmZSyMcRVdlEtxn2iMDP77QHlPixThxcHlP1YOMUe8e6pBqo+fKUOqDfd5ZtPXgTPB/8pCTcldPn9bOh6/Vz0ueoXBkWQvEoszf0CbzTaAP0hmGzZ4y8wJhwidxehDcWzYKCM9xCZP/Er05Was0hwrOMaT2UdElIm8O1nmYb583SuIcgby6myyELxIqcM+N+k1H5bCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym5C/aYStxnynJC98r6GJgf/L84t8+rtZf6M5IxfhiU=;
 b=i2q5VbrpFtad2mtI6O74NO0Hn+8dUSclXt/40CPpR8gbGLY7wmjFT3eIICciBtnkxxdyoSwOv1pGFfOuhphbT6KO4FjjHpVKcac0W2BXzqGnXdD9hwHkb9Q6WOlc+W4Ww5t3IvwOr9dtdifnjqTmxUWYyH4n/i63vhDuzMDfTD8=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 LV8PR21MB4213.namprd21.prod.outlook.com (2603:10b6:408:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.15; Mon, 17 Jun
 2024 12:56:37 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7719.002; Mon, 17 Jun 2024
 12:56:37 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2, net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Topic: [PATCH v2, net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Index: AQHavonLxXa5vIwHmUKnVOADTWBfN7HJx2iAgAImggA=
Date: Mon, 17 Jun 2024 12:56:35 +0000
Message-ID:
 <DM6PR21MB1481F3E311D498B7855D7652CACD2@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1718390136-25954-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41573C486E03FA07162F7CA7D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41573C486E03FA07162F7CA7D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0841edc7-92ec-43c3-a76e-0fec0843ef61;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-17T12:54:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|LV8PR21MB4213:EE_
x-ms-office365-filtering-correlation-id: 78fed927-d20a-4186-f507-08dc8ecceb75
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eIqeZkFGVJCcZNPfZcMfCrkgl7d3deWXfFJ2d2jD3/08xF3/N3NLJni8wOiJ?=
 =?us-ascii?Q?izwwLjhw1mhBDSASL7M5TDMbaVkIjpFjpOYVKuQZkU1aXuDkeg+KDcYaNTlt?=
 =?us-ascii?Q?Z3tvK4DYQVJOe/zIk7xafHrIk2aUgZPPZRKx0V1BvkvFEFbiAmwpFUPkPfP0?=
 =?us-ascii?Q?5kkdd84fXA025A/L7S/58okH+fmZKd0JQHcwqWeDS6Eb9OCmPAYgXjfULCp1?=
 =?us-ascii?Q?zG7LRopmA7t6vXfq8YbNqsCvf7hBpIuaI5OE0AQG1MwKpUtRYiY0MgNENdLW?=
 =?us-ascii?Q?2NIf6Z6vstz79Wf6Z4jtsbAoWY2D5HlodTMYYirDC5ZN3S3tNDzb1q2py6Tt?=
 =?us-ascii?Q?E5+JLomDjJ7s9cn/c8tiqFAg0ahsBBGBUrFuXynXbCr3dbEO5ifJHsF//KCq?=
 =?us-ascii?Q?sAMTJ2+I+FtU0Gy4gHcaioAR6mQHUc8p666sJzEdjl7I4A2ZSN841FEj3Tjs?=
 =?us-ascii?Q?YkUmpZDjHRuA0/bkAoNirJloq8+xg+jCi7Pogg57YJKdPMo+ZjVI0lwD7Ttk?=
 =?us-ascii?Q?yilXspWohg5NK9An2WDLbMz2QojHR18FBbx4hFFZmEtnGruMUuNf0lFoPpAR?=
 =?us-ascii?Q?aPBUuN/5xrlVAo47lfsmvkQZOoEXUqE6+C/zy1otr3z3YMLr41xxtCZchOd/?=
 =?us-ascii?Q?qho67V5QJmNKLhvS669sfEhV/R9IhGTDBEfnuCU5QC6uHlkhnE9D8F7ikEZK?=
 =?us-ascii?Q?FIcKhJptWuv56eJl/D4PtvT0vSqisPYAycSLzXO6J9L/BRgwKtjNbftdm/qO?=
 =?us-ascii?Q?U4E8caubcagkEs2cjV4RcWemHzjUqJA3SqKw9EuX9TmU9HtEXXeF0xYg1uTI?=
 =?us-ascii?Q?Rldy+KPCOUVp5uMLSVxDYtjQG5Fzrk/4uwcSjoo548n8LF5TP6aUHeJWf3B2?=
 =?us-ascii?Q?h1VDm8xcUvw3djnsRQKw2lVLGtv4bka4WmaqtTAYhdoCB5INjGD0gI3I40K+?=
 =?us-ascii?Q?OV2xb3UwTiBuXNWli6bOT6CdWQKF0otOQl0HhRUVE8X8UDsYWKX10UiMFZfc?=
 =?us-ascii?Q?dbeT8MLHMyR3VMh9hhuNSIFQsmViLRAR0zpDJpBFDwhQyAJrQiQK/oRGNFdT?=
 =?us-ascii?Q?X5Da9+KJ0C6RgwnDEbXGvBSf1TRGdzm2Xhz8ZLYry84NvXIWmHfcnmBotVXZ?=
 =?us-ascii?Q?j+aaZ1YljLYpeIsXWAfcoirTLltKfFzO5oyzfX4c9CcZ2DuWaFwKF6rRMcSs?=
 =?us-ascii?Q?HYfnj+bQOeHu0lTZscWrjgIgy8AubhIVmKIXJ+Ewpf6l01pWbffNISEve6ER?=
 =?us-ascii?Q?KPp0qkHe1fynAnfZK0RQvyb7O2futBycD32c3PBI7b3UqQqzdHNXxJXUComa?=
 =?us-ascii?Q?/I7FBUcO33R8MWL1SHUkE7S4Mh1sctKMkEij/jYCMHRtMhBKe+H65miA09o6?=
 =?us-ascii?Q?WoPxkTo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VgooLtD2m2IMZe6jVbCHF32U1a2mvuwqiXhkHOx16PPo2siTum+W9yN1h4Tg?=
 =?us-ascii?Q?4mOTIMUadgAk7ff6Ndcwj+c8M6tqeLci7aXicdD+gr1r91QYz6U6tYC87XDd?=
 =?us-ascii?Q?WpeXcpLgQH/G++oqv9jOM9oF959+qD05ZZ4o5D1Z4MbkLH0F7ydE22DLvtAc?=
 =?us-ascii?Q?pNQgb8kWVZjDpyz8/3uMJtUhn6oI4M8OslzeBQNNAeck0cgr32aAUjm5Ua64?=
 =?us-ascii?Q?xkzJQNIykfOhIyhd6oM6D++gOLvW45qFK0PBWRLwJDX+D/dBQzw1i6grQZuS?=
 =?us-ascii?Q?5J7pgtkXBMH/t9aHUXBl/Hooyq3Gqny6zD3+EKsvA+XzyPrygaKvgNUI4cre?=
 =?us-ascii?Q?IAkj1/L+ozeqG0qvthpI858XahZ+ZFWX8cf+rBN9OSSklHNM5tYc5pCS0nbV?=
 =?us-ascii?Q?vaTnLIio13yijErd9UtmP6IWwP+MjJVYmtpT/LpJ7jhN0S5Dq8rQ++SRCXYx?=
 =?us-ascii?Q?iSoBJEQdqDsYaoJOaQVY7XdMzrGvDlVDCSepsXGVRhd/3vrUbtIG+5Je5qT2?=
 =?us-ascii?Q?MqDqXbH7WjemVdt7Im8HhlIMkqU6XmrSlofa6qih0jiuTmA87+p3bzzBUX0C?=
 =?us-ascii?Q?3PFTysMqM+bEHpP5l4hF8fI3CHQRBD2Q3vcrKaTC9HlR4cvQqUlalWQMy3cd?=
 =?us-ascii?Q?He+5JLyNpKa145S33PexS73NCIdmQBLxyWyoUH22gw9+lvHB2fJ9sc7A6kbZ?=
 =?us-ascii?Q?tzRTVSC1l6onVAB5UwIeOr9trbP6z0r+icr4kEhBNQLHjHG3v3sOLFOxrJ8h?=
 =?us-ascii?Q?AK/3GIy2Mmg9AG28aCSOrXKm0dfxhr1ObuWwtckufS9LeiAKlQ07PAE4tsza?=
 =?us-ascii?Q?DnPG6qGv0fCF28M0aWybTZnuiYoHyH7k+RtSuDZASWpR5jUpE5EpjgteGBwF?=
 =?us-ascii?Q?xfyhiAticCyLd0VMUxYTijZbuJaHBtQt84dRt9pMz4y+NfeN6KdTZq15MurO?=
 =?us-ascii?Q?mPGXqrkQ69+1RTXYfjLABp4Z5q/vFIBa74LwyCTTP+hjcQkNsjPfiM9wysbU?=
 =?us-ascii?Q?WUwtBXSkH7R8knK1+oaV0Sf24PBqfQPYL1evdSghVTEi/qMJCK2UjUUHT/E0?=
 =?us-ascii?Q?tfztt4i1AgzZSIcdNzr3KGXJqzS8JV6Xa1GEBOLFOKWxdaxrf9lycVK5l1nV?=
 =?us-ascii?Q?WJsLdM1Grf9sUUU04vEDY6tyLp+BroZuV7BOSrZ7kh8t+od4KbDOlH4us9en?=
 =?us-ascii?Q?lEt8HclsnP5BR6OM4ylFx6StVpyCAN34j/bDaF7aQcchC19SfhG+jILAiP+n?=
 =?us-ascii?Q?MXioaJm3cxwLX3so6JjWIN+VcsXwzt9ViqULsXkUVtwulpkmLEMsJd6x9rQz?=
 =?us-ascii?Q?FPQzcS3kGfG0aJW8lyWwYw1n41TeWoTcTUi/pIQ8Xaal0pmpXWtkhlxFlhb0?=
 =?us-ascii?Q?+zBZR8xAsJwX2rDDIltCwKTLv3UQaJlOe/4AkT6rpNKn96Eg7YMMT9GjJuTI?=
 =?us-ascii?Q?SfhapkNu/hS1mcrVCjagmZ3QBtn8saw2g6Ca2INxjWE0XGo5qBC1YIH9Q2d+?=
 =?us-ascii?Q?xkBfjH/1M/oC0rjZaL4teSrX5g/Q9UiybXAENvMgYMy0kWeZlZi1TqYezI12?=
 =?us-ascii?Q?NsgubtBgM2CrVF/AVRTQb3LPed0y4EP+vO5ORzsn?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fed927-d20a-4186-f507-08dc8ecceb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 12:56:35.4096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUwNPs5NO6XU6xYNClcvV4b1qsHkjKaoMZHhKzqfVD/yi8Z6sl2N2Sj1A0b78Evb8NfH2e/Mqer2dz21gCZJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4213



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, June 16, 2024 12:04 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: Dexuan Cui <decui@microsoft.com>; stephen@networkplumber.org; KY
> Srinivasan <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2, net-next] net: mana: Add support for page sizes
> other than 4KB on ARM64
=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 1332db9a08eb..aa215e2e9606 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc,
> unsigned int length,
> >  	dma_addr_t dma_handle;
> >  	void *buf;
> >
> > -	if (length < PAGE_SIZE || !is_power_of_2(length))
> > +	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> >  		return -EINVAL;
>=20
> Since mana_gd_alloc_memory() is a somewhat generic function that wraps
> dma_alloc_coherent(), checking the length against MANA_MIN_QSIZE is
> unexpected.  In looking at the call graph, I see that
> mana_gd_alloc_memory()
> is used in creating queues, but all the callers already ensure that the
> minimum
> size requirement is met.  For robustness, having a check here seems OK,
> but
> I would have expected checking against MANA_PAGE_SIZE, since that's the
> DMA-related concept.
=20
I will update this and the other checking in mana_gd_create_dma_region()
to MANA_PAGE_SIZE.

Thanks,
- Haiyang

