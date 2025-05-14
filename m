Return-Path: <bpf+bounces-58234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5AAB7603
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F6D3A16A5
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD72920A9;
	Wed, 14 May 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YzRN79cc"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021079.outbound.protection.outlook.com [52.101.62.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E2156C6F;
	Wed, 14 May 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251368; cv=fail; b=sceInJireSk3mvOr8tWbBmZAn1QqNhmNGLqPy2bhgynWQ/gsJdLck4/bHbiPPS2qxOboHlPzkmp3KJQUX9aqKPBg6e5vYC0bc8biYenRWGGzz2mct0kM4J3ruW6QfbM2HSTUQoc3EXI36Vqtnz9Iw4ntvnbVGKOdF3mLYEdY6BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251368; c=relaxed/simple;
	bh=9Rk/VMRilcu8KzWFLBBi/d+8G9l0Nk7F+xcOpXmX7rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfkaXCAPZ5es7AUmqEwUE64yspI5EOmeoYwl2jwhFtx+qx626k7ilR/xMg5GiVYKqoKKx3ykuucH1TxZl8dfQi0pm8K92M79Dxfn780wMD0iyZ1Q8NOjDlumx6Rrnhju+z6paOxgAhLMf8xcjJdZunve9CNNeHApZIrpIVxklJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YzRN79cc; arc=fail smtp.client-ip=52.101.62.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4X5b7wFSPooaz/+Qcju1v+H7EUlWyylTBqw8/yq1fC5g+eRM/jKtKuN7JueUW8DaN8Ty93/vQ7fjmywKIV8CD/1ql2Zw8lhsD52CQ++agj7eVJNzrOc7j+qrtFuRrzYgO9WCJCcTUQZkEX/qy6X2uAhYBthu2vewvn9t3OWRKY1o+jd4aqbIsvumPzmU2aUf5HfxUtlpHUIOFACFpMQJwz8t6NZbuIcoQo6btwYjEbAj9U9cm/LGRWNnSwEXYIdZ/xub4D0ZJFcRPiYkqwgPAuVDV7Aaj1/PN9vXE8Qbbjd0ZQ66ZZM1BKWr3rNt0JiiLaoXKkVamRNCbiuZTUnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rk/VMRilcu8KzWFLBBi/d+8G9l0Nk7F+xcOpXmX7rU=;
 b=NtpZBPUXmxszd91V6lkwm/vqKFjpN9K/wWNOfuMNeSGuC0iBSUETFPb9JY3spjM3gUVENeZKOEbaYPRHQy5yIDtUe8rbjp3TIaSNaJppk3iasym9M/3r2gDX7g0kvvmV9czJ/dncoKOHPfeCl+ztZFsYg/n9+PcSGqiUEhJ7MG1d21uC22/ugQUPl3PdG5hZ9OdkUZ2CEVPu8/xcLr6bAMFMW+oupuUGVaJitwP03SVpoflFgYZ2j3IGlW8i98YysDk4B1TiiAbyY606ri8ClaSMA1Sc3Ghm2jKlgL6amdbINUZMckF5p61pznhe3oxHozpLHmy+nQ5GgVftTfBwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rk/VMRilcu8KzWFLBBi/d+8G9l0Nk7F+xcOpXmX7rU=;
 b=YzRN79ccZsx/YDF1mI6St1AaVdNqy5HIf73lc6bkBS3kZs7x8xGtW81BkTbbHHnWpijIDjGr2lv6WLlxaC4zGU+aFDaTb8e9mNR17n+BFWdMXUbiV2aM4PnDiR9bINXc2eiY4Mmuw9VrjC+CIyLKd0Ka1VUca5yAF1X2leU6+Qo=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3040.namprd21.prod.outlook.com (2603:10b6:208:394::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.3; Wed, 14 May
 2025 19:36:03 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.001; Wed, 14 May 2025
 19:36:02 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,v3] net: mana: Add handler for hardware servicing
 events
Thread-Topic: [PATCH net-next,v3] net: mana: Add handler for hardware
 servicing events
Thread-Index: AQHbw3g4KpxrP38PRECRV38WXy1PPbPSh19w
Date: Wed, 14 May 2025 19:36:02 +0000
Message-ID:
 <MN0PR21MB3437621E95E27BD2EBA4923BCA91A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49caaab5-9f29-4fd6-adc1-27da3cfc8dd2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-14T19:34:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3040:EE_
x-ms-office365-filtering-correlation-id: 93ffc945-df66-4e92-4de9-08dd931e8fe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AcJp1m/bqOuSSwdTGERF4CMNckNCC3wa2WnMXW/C+avP+aFRgnYtkAaAYkot?=
 =?us-ascii?Q?jVvpw197+8HzX4j/5poq3eQGR++B7Bdh7zU5oCpUOptvbUTjtVd0ZmvpB+Y3?=
 =?us-ascii?Q?/pUdBBgGbgMCDT+UgmYlXm/gzpC4vL46TQVEfq4nbmhheL5Gph+K0+joZEIN?=
 =?us-ascii?Q?w0DeGaj1RvoTWjFvMk08/D/osybOWL3S6P2QZMOLWtDIokRmcIVBNrwB+uRg?=
 =?us-ascii?Q?flt8Ue5+75QBYxlLUGs9zMV7BUpTKXDgq8H9OfMkc9OLJBcBNawOgM79RJt7?=
 =?us-ascii?Q?AMw+EsnTw9maY2ucc5wJpzco5+iJbfeVB2zxlYHVWjmyJgrOOrP7a0+1wRGA?=
 =?us-ascii?Q?E+0h9Lpr9+9YVPdx7pX3AXXSycuAexBoXVk2OFf21x/eb1w5k59hzoKt0hDU?=
 =?us-ascii?Q?+9cDRpfQBaP3nyGm4M1NXdEL0Sk4wAqbPmfLft6rU5XOef+xj6MLHzwps5N3?=
 =?us-ascii?Q?CdIgBKbijPAdP6dRPbivWPYKwYBmMnsvZpG2m0SO0UJt43lZGctGwhWat8XP?=
 =?us-ascii?Q?fiUsYQFZWQDOpbK1WBZ1zAqkKsn8zaRJcqDqQJCkplz1msZTlOUjjf2GT+S9?=
 =?us-ascii?Q?WA8OZmMlOybYrXcT9M/fR6q9VSOcVpgC48rE2x/5bjCHyzlLqWhwL/q9cY/p?=
 =?us-ascii?Q?bU7tlOpOq2BwRycNz3XWC2SGYNkgSirijJFPVifE9luMmr8IC7G+sNvTkk5E?=
 =?us-ascii?Q?sg6/+SefWfq9KHT6BesHsWPgKkwdCvuJ/I5lprrMR6webbpJE16lWzyZ1lOB?=
 =?us-ascii?Q?Z/SuFhJu7lPFym1MwA+fSoUYyW8jkBRGr/CCR+EtUStuSQebaTRCDgHjM8+6?=
 =?us-ascii?Q?2AkDuAa6nk5IcTYLHF1Ge10JCwfuXR4lxvuJjQyDnNa8xIbepWso4e0Xx7gO?=
 =?us-ascii?Q?CZK4rwe7K3Y3MVoQg5CBwtNv8GfbnM5aykBf8wqSiZGpte5a0ixIT/mcpuvt?=
 =?us-ascii?Q?LTZ7q0IcsmbZ4bhXu8Dluun+EqxcIE07g0GhoSOIxKC7LTG2zzmv0xMviw8+?=
 =?us-ascii?Q?7XMAR2xoGy3ssi8bXL6mdML/VVMqyLkS7pn0wS4tkhM5ml3pGJ0hrV7BW16c?=
 =?us-ascii?Q?I5QNoDkVj+XKLZUJK3S0aJy47O4iyDNHH23GwZhK3G54gJIrT63nhR1q1xG0?=
 =?us-ascii?Q?BCzbe4JsrXpUpOpCKUdnlJxc0k0MxvtdMkMWV9QbKGkjcS7p94hb793SHnAl?=
 =?us-ascii?Q?/AEjQ1eZjWouGCQZNAG2f6EaLD2y/fghAJcvDvWGCMWBT7yVa55/h1f3O2tb?=
 =?us-ascii?Q?2kjfZ8yvT8EWDnVnCEEdf93YQZd6aiacr/iOEhE+NDgWAcrXc+h5PrsgIrT2?=
 =?us-ascii?Q?fMmy+6AFxWIl4rxA/u2PgOMwYeyMeewaf7TcNNd+BUsHEP3TFR2oqoS6jrHV?=
 =?us-ascii?Q?rTcM1qO+nk/d9JdhUhPsul/MSc39dp4ELlFgXEP/uJ/8eBgBCwbMvs3hT6cP?=
 =?us-ascii?Q?yctlaeLaXwwy8j4LCYVTJwDh5noiXb5wXdsnlb8BzUaqXCAHbplYHA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rgWxv9bDz1W2X3Nh2PI/nIiCr8WkbjJXBxgVo4vtDE2pnd0NDzntUiD9ptZj?=
 =?us-ascii?Q?K6JfpfiiIKxAXv1mMNux1rx7swpb4ruMo8iiKMGwtzZ/XrZt1vrssYW2Khuh?=
 =?us-ascii?Q?FPpaNJsISe1msumPTSlbNY7KvibGptpmgYuZOris7lD12GJbeQvf1qGEk/i/?=
 =?us-ascii?Q?CqZ2TuGxOFGwyMI9pSShTQunVXpFJi/pPjf7fedMGgvclUsK9wHp7DhMTOce?=
 =?us-ascii?Q?tDDab/4Tb6ZiVJnJH/Dq/0LdjEQfSBelrBlkL/S+jkbAGqlXXmdpSsjiX2Jk?=
 =?us-ascii?Q?I+4iszIyJhQC+OGNRmV3x6I6pty+JjmHWBsTN1CJmrS0suSbEItH0ybbOAsn?=
 =?us-ascii?Q?wT7uYhh/JS1iOE75Lx5EzTDsYmjGZOgiVpBu01Z7V21bduT+vGvHANEPJkIA?=
 =?us-ascii?Q?B5kCT0xoHMQuFqKguZ/DvZYtOfpE+DDhWSdz4HXlhQpVyTuWQ3k2X10Ji22V?=
 =?us-ascii?Q?4b1ccuFV+nRLSceSVSPUElZuQRTn/f1nIGyURmzaLEPdeSVNEr3jL+UvQZsf?=
 =?us-ascii?Q?KjEMZzQX4J9KUpYbJZfqVoZqi+lxwTsn2DFBcOn10nWJ24UcfyYJAyeTAfps?=
 =?us-ascii?Q?nAd35dTFTArPo2LBsSVGmEMdx9xW1vo4ZWXymkzb9QQci34wFijOqM1muRi7?=
 =?us-ascii?Q?ocp3RQ3aLOV+lySrEnWev4BFHaPcdwGs/VckzYzvDPpj04OBGcE/El0awDtq?=
 =?us-ascii?Q?23WERHtGUCB8ZlgKVS8NZnaD3IoB3nt/8gNdUq6l904RYxzPVY6Fbbe0l3H2?=
 =?us-ascii?Q?xnsGYi8mW0c31pFY3IfcAi/b0YeAgRgoMr5NDu9hGz1mSqYZ7nTM29AWqBol?=
 =?us-ascii?Q?5afJDQWSaM8En1S98ER+J2O4OnyQTV5iaXLJKOBB7UBT4o68YoiV8Z9RD4n5?=
 =?us-ascii?Q?LX37dTJuQ3CxlYcxzHrs0vRyO+4cVyWKvpG7toeiMRUtNER1MI53wGTj21+h?=
 =?us-ascii?Q?H4IE9xOH//+QtBdklEv4TXRItat9nag25S6b+egQltHhTikDVWVwIIswHl/9?=
 =?us-ascii?Q?NQbmKTTg70v7BpJLzSTdfkwQ854T4J62OpYNeJP6eDlG6BcIZfvpZVJAVBMs?=
 =?us-ascii?Q?vDwBc5m2uncuRSZv1adXRBtg+eErvQ2qSfzBh/E4KkbkHoLuhYjNtdT5inOz?=
 =?us-ascii?Q?mmQVtBH6K5gWz2Aop43uvJI8ItDi3J0t/BguLn3KWgyHQ0Pf7X+knlhLZI2t?=
 =?us-ascii?Q?EOcByAbR0ScjFYggJwHIEwSjY7p2eACK8qluPMU6jf5Q/L5472pYefa1aRo4?=
 =?us-ascii?Q?wMYbXnQWC/PAu8IpCxKsbrFDUbUt+3Nwl2pFcO/saT+ki9sAa3SRhLoQBdzS?=
 =?us-ascii?Q?2JF2ltpQzKs9lvDrMEOBmRs130JiDCepL+2FQfBnOrwobJQIf/ypL5AgcVL2?=
 =?us-ascii?Q?rT0YLegXl9GfG4zZodsGLSyXRbi1neCByzb3nDNmo1h0+mz1IyR0RYl8dxK+?=
 =?us-ascii?Q?TJmfJ1omSMBwuPFMWvfQhZCictchcjmKbiPPWU5Z2/VscESDAzVo9K6Bji+g?=
 =?us-ascii?Q?KNJT2dqTHqNevTl7raSe3swAxvJLlhpeOH5F3yXa3tgzB6qyMKJv7JxRPjgE?=
 =?us-ascii?Q?3k0+zpQ8NjFd4kteD/QvhAqG4TlmPmmct2wqpRel?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ffc945-df66-4e92-4de9-08dd931e8fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 19:36:02.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgDTkv3J9+ZNCaIHdCOZFNWqAj//iw7+oU0slAD279V0cBkqTD+2W7gpjCeLICXF+eUc6ziSwm2HBZwZEfu3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3040



> -----Original Message-----
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Monday, May 12, 2025 3:58 PM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH net-next,v3] net: mana: Add handler for hardware servicin=
g
> events
>=20
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3:
> Updated for checkpatch warnings as suggested by Simon Horman.
>=20
> v2:
> Added dev_dbg for service type as suggested by Shradha Gupta.
> Added driver cap bit.
>=20
> ---

Thanks for the reviews.=20
I will submit v4 soon with a minor name change.

Thanks,
- Haiyang

