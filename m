Return-Path: <bpf+bounces-17173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26AF80A169
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44CE1C2089A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC99E13FFB;
	Fri,  8 Dec 2023 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZwoxdiAg";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RyxHwG6V"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4CAD;
	Fri,  8 Dec 2023 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702032394; x=1733568394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TFzEVkrtdkDnecnm4Wpk02bP9YsYLIVSeyZ6cPyg7OU=;
  b=ZwoxdiAg/7inxwK0P7zgIBrfYOTYQYk7BTYVwTlhRjBpHSKRnOEr3Z/g
   MKhggB2oW6nLEs03etxVS0xDF/kp+r+IA8TsuPbIj5wYWf8GzXuxc/dR2
   qX93Aeg2JS5b8ZIEfL7YrtE2dEihXj2K9xhNsKksx+uxv/6uzDSpkZFcS
   R5PrMsD2aqWtHCyOLEb4C+Iz++PtYpKIyAccpCZoD6WD/jpRwE0F0Vzw2
   DA4qpxebSImkERzRRe2hIQhNo/+Lp8uNEtaWIsIjID805WpVBZBhW6SKU
   hNW+M/L/ArJDrlRiLfCorimZ3dI0uh4xUhPbjRww3M5y5bllPWgw4DaZD
   Q==;
X-CSE-ConnectionGUID: 3e0NrtFURd+b5G5ahGbLkA==
X-CSE-MsgGUID: ByjXocyMTD2zBApuqawf4w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="180148518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 03:46:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 03:45:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 03:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAgIk/6QprF53h2o12pUFOBi49+RtBzI6MDv3h1HrxN+UHO94bdr2jApmg4YhxUb2ftmor9BzHtr5L+91LtgNPz/I2OOkYSKOqw//H9CTGCvPr/M1xld4rXFEsJNPYp48DLlcezIvnwLczrfa6b5e74YzD1Rv2v3BZ6kDQwhfwdymQ/+5/FypJT022n6+KDpzE7OE8yychhqDyWmQ+weZjpNv8+m5KqcJ8qnXQAHvICzfS1uTt9i0XRa2BFkTbCPmnKYlSTEV+32cKQRR6HHnOUxoqgMzZI8oiTBrNqSHA/jRV56tjRkTPMKPuFA8UbLrZCyDXb3TDI7rPl9NlllWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFzEVkrtdkDnecnm4Wpk02bP9YsYLIVSeyZ6cPyg7OU=;
 b=iGowH8kB77pa6VxsozIleBNNKSftdyZgMy9crRuivqPsXzg4g1IHQnQ1Hfuxuoslr4gEzZxSQmKe8OhIoM6qPjxWmEaswtENXPRmeo9HLz3P6GAGZWdqzGz7blaZZs8l2QDFfUmqnURuFiUDuvhJdqbh5Uza3LpsM18ne1C/0lIMeVXuEYcX29niC4SgYSFAGi/+sP/5TwLc9CAOascWpyAy831gfTAsH/CcdM6CwZbf2VGrttxogRJysF65Wo0Hk12YWo/2NAOEhfur0the43+ozuUKME5Ww9iTRg2IoDd2x6+DZEhIYCzU/Kw3TLy8QCHqVKUnp59CvxIZazJBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFzEVkrtdkDnecnm4Wpk02bP9YsYLIVSeyZ6cPyg7OU=;
 b=RyxHwG6VRm5i+ZgFUEU+j3FjkWSCQw3uuWn7H3SM1el3XyNr3yhjTQj71KhPgwMTTNST7VMFm3+fqtVyp8KzDN24gZo0isG1ANS5jnnFYaIeKLNdLKJaZxJAU0F+QdhMgxs/tr+xsQlsKd7Na9vrmyKGrJRJMb0GBHknXXc1NEEvFr72BrDE7iLMerShol2d2eWFkjI1SK6S30G+/7UAdPDRjkeYVSWacP6UxYQu6xAPT5lsy9jnuDM/wI8ckx5WHDsAzg2JEshIsgGEmfpoTh1dAc+BO6yF/tByl5iHmnMeeeRfKovwu4+L34NBxQq7fB8Hkni7QprNW1R37HvwJQ==
Received: from DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) by
 MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 10:45:56 +0000
Received: from DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64]) by DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 10:45:55 +0000
From: <Madhuri.Sripada@microchip.com>
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
Subject: RE: [PATCH net-next v5 1/3] ethtool: Implement ethtool_puts()
Thread-Topic: [PATCH net-next v5 1/3] ethtool: Implement ethtool_puts()
Thread-Index: AQHaKJpSOq0mHraPM0S77nPVwW1Wl7CfNdhg
Date: Fri, 8 Dec 2023 10:45:55 +0000
Message-ID: <DM6PR11MB4124F675444E8BA0523264F8E18AA@DM6PR11MB4124.namprd11.prod.outlook.com>
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
 <20231206-ethtool_puts_impl-v5-1-5a2528e17bf8@google.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-1-5a2528e17bf8@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4124:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 795540da-659c-4df8-0aa2-08dbf7dadb35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/+/FTei1hfSE5QUMpHFvgmqMd6ersNN1yNf/rcvXbzkM/PaCOWaHWASxhzd64P+RUAXEDasAJfsfkTHSq4H9o9O4pQnmnHIa0eeeiC7d4Y93tWz1faFw5+eMg6BwN8b6e6gwQewNfwDkOLRbpZ4DL7N3MwsyI+SRyNVd9XGCjiUVVhK4G9D3f6CxENCWl4x6/rkcHhRqW0sCMuoJdTOezN3pk8/4KSHopbAWDwnQUc16dckqNWZEE57SILnJH35oA5nzUfTMi1uu3rhEgBKmgIYQQuhulVshcQRSV6N1u4z1wal6F7TRPYh5zbE6yWXrtqg+McXFl9N/+pbzNCFamtoUy4c/UQU0qHbiEtrwuBrfxEvC+2uWjcjYW8nUBiEdkcVNBXtRkR5bnycRwGRPReqL8tKQwG4os64L9k4SVCvhMbOWVvncVaE4SyjWj6qzruLCkeFYKuROJ11EPq4NpqHFeo8qVRfmv0dauTIiu8kc4H2YucdRlROsOEym/Ct72NbsvcKStZ4ZkurI2Kypc1HzRmIbzwOXmWkdgqVXoqwm0jxsBv98j/dFLdmJJXyEVREslvtPceypUIovDCJv0V+3hh/qnXXjgtIgToAOIZkGtkUmcqvAghKbLbNSY/UL4/Lm8g+ZbiU9ffEainEAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4124.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(1191002)(7406005)(7366002)(2906002)(7416002)(52536014)(4326008)(8936002)(8676002)(86362001)(38070700009)(921008)(41300700001)(55016003)(9686003)(558084003)(26005)(66446008)(64756008)(66946007)(76116006)(66476007)(54906003)(66556008)(110136005)(316002)(38100700002)(71200400001)(6506007)(33656002)(7696005)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjMwQ0U5WTJDcXhPT1lud044ekFxVGpycU15UU5YZjdrUnU1UWdUTUZ1RTd1?=
 =?utf-8?B?WU9yMFVMU0k0QVU5MVlVVlE2Q1Z3N0RmdU1HVG8zRnNWQ1ZydG1Xc2ZUQU1u?=
 =?utf-8?B?RXFFWlJPWGhOUUx6Q3Jwa05wN0tGQkVkSWMyNVB2QzhVSExJTDhCZXl0Mjh0?=
 =?utf-8?B?ZkRiVitKaFJTdWs3UDZaOGFCOUtObnN3RkJGVkpqTXFINC9WTWpDdXY3RG14?=
 =?utf-8?B?eU02RjY0Nlo0Tk9kTE8xU0NtQ0x3aktLK0pkUzN0RDB0S095Z1AyN2l2RVZn?=
 =?utf-8?B?QlRDeitrQ2lVeFVkOVJPeWJQZEJWak9JSHpjZU1QdHpQZXlwakd6REd0Zmxk?=
 =?utf-8?B?eFBzVUJMaUFwYlpEbElVWUZaMFRNWmhyOFR5Qk9tK1FEM3A5VHpXMk91M0NX?=
 =?utf-8?B?UDNkcnBveDhtTVhUaGVvcVl5eVBVaUFrK2wxNTQ4b1pVZ3E0VHVPQ1hDZmhy?=
 =?utf-8?B?dHR6VlRybk9VV0RBVjJmRys1aGJNRXNtbHRhZWkyT1UxZ0pMZEs3Nk9WdzBa?=
 =?utf-8?B?SXpkVUdqbzZCVHRVVStlUDFBaUxrRHdqcDhSTFRUV2pkaWo5TnNGQjh2SWJJ?=
 =?utf-8?B?cWNGNTZWVlZIUlRmaDhtNXZ3TWhxbUVKZnJJVkM2RmFmM0VTdjg3b3VIQlMy?=
 =?utf-8?B?UjdkYWs1WkVqMm9NUWRPODJENGhIMUMrZzFXV0RLYmhTWDVXd3hud05jRDlP?=
 =?utf-8?B?Z2FyRjRCNVl6Y1RPNkRRN3IyTGVjNXA5Zk1CMEV1TjFQQ2EzVkoya2lKekpK?=
 =?utf-8?B?RHBNdlVwdW9HbHkwL1B6R3FBR0NnRzBHOGx0eCtQL3JKN1RYbkdudHNDMWw3?=
 =?utf-8?B?MDMyZWtvNFdxS2x6OW5hOFg2VEJ0T21PNktRRFpCdS9oTXd5NmJtR09aaWMy?=
 =?utf-8?B?bFhDeDZ2UUt5WWJidzEzSU1Gd2tSWlJrWG1VanlUb0RMay9MTXIwTXhxRWM4?=
 =?utf-8?B?UzJ1RUc2TFM0Y3dTTkVyYW9sWFpoeWJOa2xqcWFnNjJTb3UzMTh4ZytMdTIy?=
 =?utf-8?B?dS9NQ0p1TWtUVFJWbWk3RUhVZTJVN0FjOFJhdUlwNkVrOGhZNU94MkZtRE0w?=
 =?utf-8?B?SFA4ZmJZSk9FWmhON3ZKN1p1YjVxVWdhWlVxTU05M1BGdlJuZDdFdVMyQkc2?=
 =?utf-8?B?Q2pWeFFCZDd3NlFqT3FHY3p0VDRRUi85Y3NJT0xpU2F4YW9GWTlhYjRGdGo0?=
 =?utf-8?B?aXh3SFJseVZDRHkya1haejlQMVVTb1p4NEw3L1B0eXY5NVZyd3dKZ0NGaGcw?=
 =?utf-8?B?NklFYmxPV1g2cW1tdDJGNmdrVVY0WUVRdklLNVYzeTNTcGZhVnNDY3ZpRnVK?=
 =?utf-8?B?NXBhZVNYSXY1aU5IWVJLYWthL0RXdTNFdWtqMHBrKzMyUXp4RVJ6QTdZZWpy?=
 =?utf-8?B?TXZFblNLRFVYakQ1Z0E2eUhIM25mcDZGNkZTZmNXR0lwNmdINHF4aGpaSXk4?=
 =?utf-8?B?NzREb2tpZHFsVlRseE5KazN5Vis0VzZycUN0SHdNTWhaTmh5elFMWGtudlN4?=
 =?utf-8?B?dTlPUktpdTN6V2s3RVkxOWJjSEV2OGpLWW93cm51cVNrd1QzTHdhYjh2MUZN?=
 =?utf-8?B?ZEZFVHQyVlNkbnVtR3dMRk1sc1BXdGZxY2haeFh6dmhhaFE1cnlqcUlQaXI0?=
 =?utf-8?B?RjhlNkkxUFJTdElrM2Znb3EwTjBNTmRNMytzSWhCVllyeHhOVnRsSTFMeFVE?=
 =?utf-8?B?SGhCd1UweFZaZituQTRkb0hIQkkvVEtialdXNmRVeVNTcStWL2RpakFORDRP?=
 =?utf-8?B?Y3g4WFVTcWhYK0J1eTFqeUJkZ2krKzg2dDRzT3BWSzRZcnNyU2paTGY0RWxm?=
 =?utf-8?B?VnJuTURGL1diWTVERG1MZHgyTlk2Nk0zb25RNS9DZmN4Nzd6dGVXZnE3NHZF?=
 =?utf-8?B?cEtUSmkvOW9SQjBUcVMrUFZpUEZvVVl4M3VGTFJpNTB0cWNzWmFkeCtPbEtu?=
 =?utf-8?B?aVRlNldub1BETU1KMGdWQVF4ZVRkQjNBMVozZzU2VlhJdER6RmRHQmNQU3Vi?=
 =?utf-8?B?alFmSWErSkVPN0NGZHpxQkZzdDZjSjlEY2p6eGZHcC81SnFqSjVuaTNNZjYz?=
 =?utf-8?B?V2xhTmkyMkhtWTE1eDNtRDE0UkU5MXRRV0ZCcVNXa3Z1eDFvQXFmc1duMmhv?=
 =?utf-8?B?Y2dDcjdHMlo3dzVBQjJleW1mT3djTzFKWlBsUnIwUXJQZ0xrUEZyemUyZyt1?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4124.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795540da-659c-4df8-0aa2-08dbf7dadb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 10:45:55.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZwULr+JuDj2/keqFQbk036G7+tYZ/Dgb93suShdlzQYZwEUQp8TE5MsiZSkOYdTORdQQmvTdzTy4RkFvXJN6w7a7lahGm1TuwMiQk++YhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291

PiBVc2Ugc3Ryc2NweSgpIHRvIGltcGxlbWVudCBldGh0b29sX3B1dHMoKS4NCj4gDQo+IEZ1bmN0
aW9uYWxseSB0aGUgc2FtZSBhcyBldGh0b29sX3NwcmludGYoKSB3aGVuIGl0J3MgdXNlZCB3aXRo
IHR3byBhcmd1bWVudHMNCj4gb3Igd2l0aCBqdXN0ICIlcyIgZm9ybWF0IHNwZWNpZmllci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRAZ29vZ2xlLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IE1hZGh1cmkgU3JpcGFkYSA8bWFkaHVyaS5zcmlwYWRhQG1pY3JvY2hp
cC5jb20+DQo=

