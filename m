Return-Path: <bpf+bounces-17175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0780A1BF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3461C20CC5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F919BBF;
	Fri,  8 Dec 2023 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gegKLNIo";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ML7DyH0i"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED03F1;
	Fri,  8 Dec 2023 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702033425; x=1733569425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oywCcxpvcq774ikp9Zv+0+tlrr44eyqIRY/PiJvY1H4=;
  b=gegKLNIofu4/7uGz94bYqwFAXp47QXBkqyVR3+FYv1M981hMuOIVDYIh
   ezSMPAI7vBy3hAffzwkBrJtzZyf66jyV8lyi5EydndgQ6Clr6q3Y454cT
   VV/AKdDLQg5wu6J2sNtbQXnGF9UcUVf6Tuhe0yRYiiwk0xDcSL00OxmMF
   z5d3yBxzH2dIHAvn6k132/FdPVx9DiVGBGIgKwhS/z03jAIygx4ULYpre
   GI/eKYehGi4zPmoMR7nN8yZR6vXP3K0ybQRxTljJ6m4dNwM4g7Fdd8sNo
   YcWLs9yb3rKCvXklkNfA1lgSwkndojmf+Wu2v+ykgJX9VxWrsdzNdZXOp
   Q==;
X-CSE-ConnectionGUID: fPFZte+/TH+GVMr8YTp5jQ==
X-CSE-MsgGUID: In9ovAXCTY+sELLKRsvDew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="12989660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 04:03:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 04:03:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 04:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6gsgXGCHUVqSUYGis3Ub2Q3eC14LxkbKMRfPt42XFLGjhvXwR6mDojXIyFibppCD915CuAZF2KVAN6XqlTmwbKfxomqaO5gk9vb2r3m/RjfbTn2waZHNeTA6OToZ2KaVXqkV7WE41WoxbtVbAjaBV6voiKX0GLa+s3MoW1OyRUt65OlvM8gd2xlULAk5fnJbU5Pdq1NNDy7MTuFf1xjUXRvvq17bGZ8JQ4ph3Rd5UtZWqQPyJcrwCYIYdi0F5yJodcOqYv/7BxAx9yzIUbohO553ynKEYkwz1VxJm1UoPgp+nzZ3iQgdwwfiBOg8L+zlNXbm/qxZl/NuSlJqr1dCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oywCcxpvcq774ikp9Zv+0+tlrr44eyqIRY/PiJvY1H4=;
 b=MULQUuWicyhwO8tH2hSYh/B8CqznGdh0S3loNQgv81xDI2UYEhL3Void+cRAovWRHrPkKGtirx0KqEeEAKjJdE04pPp2G2poqMI4NihJvn55G3aN6rdMmBL5Wq5BHPW4aEaEzdBDA4BQECPBAgdTLL4F7R0amQBPWrgBtcMLBEx7MEPIKgwQodi0kH8jDE1Cvx8bYdGck8l/4K0r4LwN6PGfGUskPqfClZByGOBge+e7/nvBdwMi70B6+EF2RQM9ESe+RK+erptlOM5/kzdNlVFJpBSBaBfd0aURAHiu3jv0ZFyrIrwS45mgAJZTzH6bY69LZAnhFHr0lEz8dxMs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oywCcxpvcq774ikp9Zv+0+tlrr44eyqIRY/PiJvY1H4=;
 b=ML7DyH0iq7yAVdiWko824DhgTLQo4TYysRuR7UDDrvgZojmwgZ/KhK73eDpx0Xs3v32/3j/u+m6Jfs2SDDauvJTjJ3isLg33J3fCg5ItkWsyRUKa4l38HZIo+RTxRVgUOsW2FWPlQHROahbzNj7rbTXgOxxsYKo81iPBb7cgtLWwRUXy0Qm0OhEEpGnqAGo4STbCAiVDlmmHXbfxuSjhu0yHRoPQDgRxltbt9XsTHERtvDoIo2Br1cgEwrPAjTY2tRtcdAeaGYCbCnVF75fCqolF/ARxL+06wXupaW8VLYPWg4vHHeRZoQnaK4aQnM/EuceKM9EMtcV13BGrbzJWnQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 11:03:16 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::be2d:30b4:c304:3c2e]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::be2d:30b4:c304:3c2e%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:03:16 +0000
From: <Divya.Koppera@microchip.com>
To: <justinstitt@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shayagr@amazon.com>,
	<akiyano@amazon.com>, <darinzon@amazon.com>, <ndagan@amazon.com>,
	<saeedb@amazon.com>, <rmody@marvell.com>, <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, <dmichail@fungible.com>,
	<yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<louis.peens@corigine.com>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <drivers@pensando.io>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<doshir@vmware.com>, <pv-drivers@vmware.com>, <apw@canonical.com>,
	<joe@perches.com>, <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
	<hauke@hauke-m.de>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <arinc.unal@arinc9.com>, <daniel@makrotopia.org>,
	<Landen.Chao@mediatek.com>, <dqfext@gmail.com>, <sean.wang@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>, <wei.fang@nxp.com>,
	<shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>, <linux-imx@nxp.com>,
	<Lars.Povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<Daniel.Machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<ndesaulniers@google.com>, <nathan@kernel.org>, <keescook@chromium.org>,
	<intel-wired-lan@lists.osuosl.org>, <oss-drivers@corigine.com>,
	<linux-hyperv@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next v5 3/3] net: Convert some ethtool_sprintf() to
 ethtool_puts()
Thread-Topic: [PATCH net-next v5 3/3] net: Convert some ethtool_sprintf() to
 ethtool_puts()
Thread-Index: AQHaKJpxqmNUvj9Mfk+NlKo4i1f/T7CfOGdQ
Date: Fri, 8 Dec 2023 11:03:16 +0000
Message-ID: <CO1PR11MB4771F4677509E46589039C75E28AA@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
 <20231206-ethtool_puts_impl-v5-3-5a2528e17bf8@google.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-3-5a2528e17bf8@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SA1PR11MB8543:EE_
x-ms-office365-filtering-correlation-id: 30bca623-1435-4a6f-20c2-08dbf7dd47da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCgF64TdUI6Arpa+VKjJwa9bfr27PxvBUl9A+Pq/4QRVb5o0fGn7xiHfe1qKOA5w0RRgXMmWWq2fLeYo06gw5PtXW9VPMLsBGqVkTD0bdquch6FZcewhocdYiCJoYxTyEL0fkDUSQgshF1gUBB+fSXwMlOLLf2LRRNmhG0dMlg6x0JN5pC1woPo+Wp0pZazE+rjqicGaoXiqMm1qy5kXqjqB5VlXoBk7eeBTPSsHaeA8VD5o0XGsqAfcmVC0dCZy9XI61VfxJ2OsactDx7cogQ5edIeaUVBWWNtvlTdBuDxLb8FPf2s6XVLouEkC6QPy9Pil9zu30LkR1OdNVzM8ycIkykOdYGNTCNanxxkJeys/a0OXZzkYRcu6IJfkpI2wcIoJGpJjJTLYP43NM0EtHZFIEVX9fPi4HwL13ymee3p0y62j8HrXIL53wB6hYc2XNk9lBdLvOjcaybhHAD19OMaX6ZrmOSDerXcSpTwwonnY6+YMi3+nXF+zlXi+O0ZlqrAe4eMb1vAhBrupy/6LxLol98HJVkqBrO4MLxzM3LiBkfMq7svbmr3lKk6JuFk0HGgEJOaMsZdTABEGw3ClT61ZwKWXhOT0N+qa8pHuLNVJiGnz3jRk+TfchuqGH76p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(9686003)(6506007)(71200400001)(7696005)(54906003)(5660300002)(122000001)(4326008)(41300700001)(7406005)(8936002)(64756008)(4744005)(8676002)(52536014)(7416002)(110136005)(66556008)(478600001)(2906002)(7366002)(1191002)(66476007)(76116006)(316002)(66946007)(38100700002)(86362001)(33656002)(38070700009)(66446008)(921008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnV4ZXpLL0d3TU0xRjdwS1RxNkc0aE53NXRtTzRLV3NSUEsyU2lVSFBLNith?=
 =?utf-8?B?T0xqWHpDQ3d6STFGUUlwTm9IRm96SXkrcDYvYVorTmU3WmNwUURyWUxkVVIx?=
 =?utf-8?B?NmVmOHZLUzNucm5iM2NqQmRIN3ErN25IS0JoNkowODNMNzF4c0V4QzlnZU02?=
 =?utf-8?B?VXVVZ3RNcEE3bnZZZHJnbTl4bTZaMDBXOTFFSUloQUVQNUN2Vi85b2lvMnVu?=
 =?utf-8?B?dVBKWWNINDNKc0ZJNWJXNFdiN2dvZUhQQjhDQkJRWUVoaHNLVVlXN05RaUtk?=
 =?utf-8?B?WGY2N1BsRmNQcEU0clB6ekhqd1kxbGZpcGVGdVpidHFVNzZyaFhRbDlhZWt1?=
 =?utf-8?B?RUVWM1Y1UGVwZmNSVC9hSkRzQ0NpMEZJUm1XZ0Z2MzJFamJkN1o1eEdzZC9v?=
 =?utf-8?B?TUhvNFVWcjdpUlZWLzRzZnhEeG1xOWo2R1EvNDJQeTNjdHVjVy9wMW1iaGhB?=
 =?utf-8?B?VWo0MlRaU3FwYm15YitnSTZITXFtUnNva3RXbERCV3pEY3NkSCttWFFlNW00?=
 =?utf-8?B?MFoyMW5pL05OaGo1NGRDZnkrYjUzeDJqMTJvS2dncm41VDlmTjBkeEMwSWFW?=
 =?utf-8?B?eUdjMkE4UURjNldacE1sZ0Fia3F2NWFmL0tRNnN3WGhkazljZDJSbW5BKzNi?=
 =?utf-8?B?N3ZtYkpRRDFGN0c3a3lqUFg1OVZPaEJ5YU03RlkwNFcrWjNPRFZoL1RXT3Yy?=
 =?utf-8?B?RmlvVS9IY2lXbEtQTkxHd2VnTE0yQnZCWVJDMHFMQWF6SjZsanhJZHRoQlVJ?=
 =?utf-8?B?STk2ZHNxTzZ3K3ZFdkZnT0pKWUlBQ0c3aFpTNkpGUzZSa1I4eXBZTWJzajlZ?=
 =?utf-8?B?YkVYU0dsZk5mOWZzZG4yRlVFbUZ6b3JCbEdTcXZnVmVYUW9FTVFwcTJiV0Nj?=
 =?utf-8?B?LzNPbGJkWFcxVDhERHlmbitodjU2cm4zc09zY0VIU0FhRExUcUVBc1NBRDU2?=
 =?utf-8?B?eXpGalNvc05IL1BrUzBkVkZWZGpJM1BHczhidVM3eTU3bFhaaUEzb2hiRUNM?=
 =?utf-8?B?cGIvRnAxbWhLRFhFalhVbXQzRnhLT1VrWHR1Zk1IWGUwU2w1c3pYSTVkVlcv?=
 =?utf-8?B?OGFqVkV2YXkwdU1vcDBRWUw3bi9pL0VYRW0zMzlneDlPRktFWjRhdGw3Q3JO?=
 =?utf-8?B?WlRBK1dwRWtVK1ZxUFh1UjUvZUZvRGJSMERpTkg3L2pMd3d3ek5CMHJjN2ZC?=
 =?utf-8?B?bDVkaGVnRng4TC9FUVQ5YUNaSG1kRFZCVE85ODZFdG5TNjN1eTFDVmNDK1ZE?=
 =?utf-8?B?OTBHUjUxTkt1MXd1d2Uwck9laGk5VmNVd3lPbnJBaDRFeENSVTRYZVU2RWJv?=
 =?utf-8?B?V0V5Z1M0REJ2aU5CcHlzMnhpT25LWnBUYXMvc0s1NE8zbE9VYWhnSjh5K3g5?=
 =?utf-8?B?SXROSGJJSkJUaUQ0NkV6VFdZZkJqMlU3aDc2NStOMDNlUjlhWU54bmd2OWFY?=
 =?utf-8?B?RkRJZUNuZDhockV6Q1JSMXlFNDRLQ2N6dmlJQXFRc2ZmSjhJbnlqMVkvbW1r?=
 =?utf-8?B?R1JISC9XazZJM1NCRUdDMGhQdXFrbUVReHZLMFZGQzR3WDhjNy9KQURMdHUy?=
 =?utf-8?B?K3ZNNXA0L3NaaG56YTZRdldQTzZhV2J0TU1rb0RWRWNQVEtjS1RLWlhITEUx?=
 =?utf-8?B?K005QTNnM3JmSGttNXFHZ3g0R1Y5U0NuRHdPMDU1dWc3TFdxcTA5UU05VitI?=
 =?utf-8?B?WjVtVTdMNGhiSHhlVnJYZC9mWnFmRjNkS3dpYVlqMGtlY3VmUE5UN1EvVzN4?=
 =?utf-8?B?QldKMlhrV1dTZHlBSUNQZTF0MnlrZ1BITFloU0tOV01QdEUyV0FPRElibFFT?=
 =?utf-8?B?TkYwcmFSaVVrZC9nalkxNEJvTS9aWWZJb0hYcGxxL2RQZXBNWTZJUWlQWGdx?=
 =?utf-8?B?NUlyR2ZKRTMxMHhWMWZGT2QwWXBGQ1VNcTFQZUUwdTlsTFhLelJJMUFaWVFS?=
 =?utf-8?B?U08xMTNQQ2x1QUJ0emxVY29Za1JTRlA0NXBpWUh1WVB6a3ExdGZWYVBUMjRt?=
 =?utf-8?B?cUhGSmpmSkpHRUlzWmhYcXc4YWNhaWEwZ3pHNTZncllOVFUvN1h1NmhIYW13?=
 =?utf-8?B?RGQvdWVUVWh5RG1Md2c3V215dktBVGVRL0NHOCtPZENmbThMcnZ0ZFZaRmRt?=
 =?utf-8?B?QkxJb0tsaEpSd0tqRUhzeGJIa0xCVnJRYnJkZ3B3YlQxdmpFZGh3WmJpMEIx?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bca623-1435-4a6f-20c2-08dbf7dd47da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 11:03:16.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pcL4sM3lbdx+R7o1dmt2OOoXmUyzVL9O1ZVhN3mIg++n6W0JJGwuwfuCqdc8uVB1AwNzHifgnFUfr0HJzigrgybn5n08gIiV5PCzZLvBYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543

PiBUaGlzIHBhdGNoIGNvbnZlcnRzIHNvbWUgYmFzaWMgY2FzZXMgb2YgZXRodG9vbF9zcHJpbnRm
KCkgdG8gZXRodG9vbF9wdXRzKCkuDQo+IA0KPiBUaGUgY29udmVyc2lvbnMgYXJlIHVzZWQgaW4g
Y2FzZXMgd2hlcmUgZXRodG9vbF9zcHJpbnRmKCkgd2FzIGJlaW5nIHVzZWQgd2l0aA0KPiBqdXN0
IHR3byBhcmd1bWVudHM6DQo+IHwgICAgICAgZXRodG9vbF9zcHJpbnRmKCZkYXRhLCBidWZmZXJb
aV0ubmFtZSk7DQo+IG9yIHdoZW4gaXQncyB1c2VkIHdpdGggZm9ybWF0IHN0cmluZzogIiVzIg0K
PiB8ICAgICAgIGV0aHRvb2xfc3ByaW50ZigmZGF0YSwgIiVzIiwgYnVmZmVyW2ldLm5hbWUpOw0K
PiB3aGljaCBib3RoIG5vdyBiZWNvbWU6DQo+IHwgICAgICAgZXRodG9vbF9wdXRzKCZkYXRhLCBi
dWZmZXJbaV0ubmFtZSk7DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3Rp
bnN0aXR0QGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBEaXZ5YSBLb3BwZXJhIDxkaXZ5YS5r
b3BwZXJhQG1pY3JvY2hpcC5jb20+DQo=

