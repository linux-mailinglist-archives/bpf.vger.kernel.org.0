Return-Path: <bpf+bounces-7625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768DA779BC0
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 02:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226112816EA
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28776EA0;
	Sat, 12 Aug 2023 00:06:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957B7E;
	Sat, 12 Aug 2023 00:06:54 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77021BF9;
	Fri, 11 Aug 2023 17:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HebKUgMCiHJu2CQ+Ep+ft1Pbn7VVa17e63zMZR/mEZwkMn6aJcH3T7mgF/vcOfuoWXuY/NC6X0UQQrU2aXCrI6/Mxa2KREnc5D8aljv0jcS8kQ3sUIHFp+3aOeix6PNGqcpe6lc2TJadfrpm39kgpxJy43LuBsVaqTSK9hGeJ7JWw1wLDZ03JvEkrfNpqgf26vpoBhEhVRwUxJlUe2WatW6oYn4FYZptgSRBXomsJp0O9b+2RVIHpLka6UikQB+l3pPkRjENwAe+pteHcD4lvo4IZ66ZVAMUABirCKtE/CH8atmZ5cHupx+KSO58QkVZPbkb2OKfD/tFs5ZpeYVPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgLtqYX6gva5rHcwjASe5CKCyR0LRHMQa6kd5jTLKWc=;
 b=n21zSP02jnV509jraAJ+r3MYiRlvsOHkPIQY+M2nUu7dJEOv7TjU4v2jtzupZyINPz05jLFHcIxCJmZHtM/Oz0lBEvZElAE6hoJU8z5/Wf4QPpmn+FvSXXlaUkLIyVOwKw3LAFQJ7auq+Z/IXsBzAtWLj18fSVsyx2dzOHssFvELSitPJcOP5Weyb2fJYuNBUtorhUahnOCti0oKOEc6Ex1fKwEWWlkwONI4mODDl6mhNgi/ZJsip+RTV5gkxgvEJCamCPprfPDabrBS+YRzcmHhkdXT2e+aZLxfNd9p/lz619wScZbfyluTH972+KjriDah8tAlTl2cWTfaEk/noQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgLtqYX6gva5rHcwjASe5CKCyR0LRHMQa6kd5jTLKWc=;
 b=GImLi3O42bRk+uVOh5DQVD4WB/j4rtNcAXn/UjGfQwhN3CSrqpYkemhzxI/wnZqoCx1LmGIY4rL2CfhtNEmnBjcRmiXK37LmVKybn6cxni/ydlt+PxRH+b6cD4ylM+OYhsJmETgdVhn8kW+byNGFe0Uqdn8WKPmoO1PFetl7Z18=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 00:06:46 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.023; Sat, 12 Aug 2023
 00:06:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"larysa.zaremba@intel.com" <larysa.zaremba@intel.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"jbrouer@redhat.com" <jbrouer@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Thread-Index: AQHZy1dCnxQwOLKBq0eoj4kIh1yvrq/k/3cAgADLJ1A=
Date: Sat, 12 Aug 2023 00:06:45 +0000
Message-ID:
 <AM5PR04MB313962DCC05E4D588C37A6BF8811A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com> <ZNYiSEG5/0cJIZ3f@vergenet.net>
In-Reply-To: <ZNYiSEG5/0cJIZ3f@vergenet.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB8024:EE_
x-ms-office365-filtering-correlation-id: 6f207a9b-86d0-4b28-c06f-08db9ac8042c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gCi9ZZ1nl4LEo9HZawbATLJ07nmC5ZyrHPc58EdTJL+qz/bpDLDhyFQhgkduWUkA7pRt3a+j0yhbwwvcomcV6Yu3+AX+TMJSQPRG6wATPzlOz2wmgsmE1K00Fgf2Cgu/5kwv+lIXo2egRbVjS728UgWN4NRr9AnC8mbrv70M4BsM6D2FfzMnIBWn8wb0zoEWjo3XouarJnzKpPPeIy8clByIY693m8YcSM2rj4wp6WwhmQXwGyocKmveyKo6TsOtK+1weQOuvVYvUPe7ERJ+PkUkBRJGkXMIW2z3w/RKfB+D83a72zS0JDrdiFvQvOgQuQpNbpv6XDU07p6AmQn9R2HHLNYMvwXdQTbuV36Zwn88IE3qZD/uUp+E52pExLfrH+QuCqWCQovi2r6BQpbdk+eo1FKtWOkdlrjsRhAkjzKpsYd/PKGDCeKIua0kc+k0oPPo4hu59ZwG7vsoHNqRpnkP38Yek3elJvTY8n3ZCcW6hj55NmHTiUvMIgXLcjjOC5GCYjfCM/J+NamydAJID2eJAhoYI6pmyadSouQy/VHCSPCSPxO13IBhH0zEC1u+jHUsuq17NsGGa0zQb3rXjSfALfIOr2zVt8tnNwPAWfY38Qf6BPUEAcqJ1O4nd0Mb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(186006)(1800799006)(451199021)(8676002)(9686003)(86362001)(55016003)(33656002)(38070700005)(122000001)(38100700002)(26005)(478600001)(71200400001)(7416002)(54906003)(7696005)(6506007)(6916009)(4326008)(76116006)(8936002)(316002)(44832011)(2906002)(52536014)(66476007)(64756008)(5660300002)(66446008)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?54lZ6+yffRkO/R/j+tiOOhoKJ6lnG16xa6wb5niujyLNbS8Ma6EybX1+O3C3?=
 =?us-ascii?Q?DnEz6SE3U/RZ8CBGMwxiY9gkcAaFkE9vCqg6qTK3bWqdt6HeWT8adVK12wGz?=
 =?us-ascii?Q?dPgBXwbqSfuPUQv/GbQq01kvsV+ncKizJGlBTW/jNn3d7ftmkSWUuIwn9dI/?=
 =?us-ascii?Q?frqgdIKBOo7Frmnf8teRGl/iaJTFttgtl1WjyBpW3fK+4uRRTqKcJzn0S2iU?=
 =?us-ascii?Q?q+Sr+RKlWnoF1FoBrzuBrHmLpPSRP0uiR6La/b+hGeIiww1JH+nCXWTR3VmC?=
 =?us-ascii?Q?qblyTxDChiy0srXs5cxexFxFR3shSEoYh/KuyGU7hgLvZQDIRlJ9GrRrL9lK?=
 =?us-ascii?Q?Rn6cR3SfLtgd04afIhhE1FDV99au1T/V11+IPkU9z5mPn2MuL2BtOGBbmVJk?=
 =?us-ascii?Q?W4Xp83L/LHx0ZoFFEdJq90d+cUbKnqVhTxoEGLMMXvmy0S6LKYmlj5TF3/JR?=
 =?us-ascii?Q?aY7HswGs5Q/P4NQ1U8nypbZUa/Qr2GuVXXEsvd/uSeLK1laAUOOH7IDlpvHT?=
 =?us-ascii?Q?GJ+ZUASr850YB1QyLdXTObCqDKkzI4gi6MI9IfDGRkXmIqJLIbE4T+NuOvj3?=
 =?us-ascii?Q?W4JBojIzv7r3kpNbb6IX1Am4JkpSOC7kaoSs89XmbF0ksu+uV3uHx3q/15MR?=
 =?us-ascii?Q?7huXYhgouiUzcZjQLkv/EuoojU2z31rxvHroQDLX/2h740o1UqbsXui6HkG+?=
 =?us-ascii?Q?/QmT5l4J5p6EflhTQ2w5ah7G4bGv6is1jWNAg7LEJ8CqHejLXI2wtBWJRvjj?=
 =?us-ascii?Q?rQ7DRXJt66jOoT3p2j9ngGDrNUi5c1xGMwvXOoIYKuNLkSz+SvD0BH2KSoM0?=
 =?us-ascii?Q?FonALeZ866hovUyM5jmpe2lWDLuvxz9ibpkbQ1+PH4ElGv8Ip165FCJuAtm7?=
 =?us-ascii?Q?UJKitmwdZP8RorD0CZKMS6gzWogbREWAOGsZpjARsE+eSUANn5LJXr9NexLT?=
 =?us-ascii?Q?5d+71mGkprvn1GKxQAbH6VYQmpOFbJxw/fcljn0Yetf1M94nk+PMVvtW2p09?=
 =?us-ascii?Q?1jtM6vXSwqawwmp/dVtv2Ner0UcdfeuBWDYFb/60xXNUWSonzy3jgX+l/Dzk?=
 =?us-ascii?Q?KxIDP2G51+Ym6wUfFXQ+XnIPatCYcx8FKmD1iYM7GiMQajh/FY1/F+vkHHxR?=
 =?us-ascii?Q?B//RHiEF6xt8f708/qJaD9IWrsuzYMrqy5vRENHe66Th82DZrxTVJfMfBrwH?=
 =?us-ascii?Q?gTzPojNGux7QLgYSkcYB4I9rsmidilqiChc7Ra3fQlrJsLl5vspDqwUqn781?=
 =?us-ascii?Q?h693Cek7Bui3xjKv5XaMKBuaL90ImlnIygBzKoKYhykmE+Kna9JdtbL8pStH?=
 =?us-ascii?Q?LgB9lUXu+EnZE/Jshs13r8QNXnRQ/hZq/wT4iEEvLuF/X/losFpTyxqoFzyR?=
 =?us-ascii?Q?KFJpDdm15HR4APVQcjfNLbCZOyu1G965QcKW8KOg5K0sGlXN7PPLI4SVGVC4?=
 =?us-ascii?Q?fBKJ9vTeyqXRZJTRXEsfCnJpIwLNbrCyH/9AEQziDeqtz1M6bNhov02vD3hx?=
 =?us-ascii?Q?K6QiLrznaGGm1zCjgm6DW7NqsGO1BEKf1/EjLu9a+8lX3DonbyZGwkVnzl1v?=
 =?us-ascii?Q?NO+s5hW7x7z99bOrYoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f207a9b-86d0-4b28-c06f-08db9ac8042c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 00:06:45.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET9b+4KCvj13J6d2AvTZtshvbv7X7DH/VQG/zkrK20lC5sOe5cpstjykyBF4ZppSpxKe7iqxALNZWQwel7fVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Thu, Aug 10, 2023 at 02:45:13PM +0800, Wei Fang wrote:
> > The XDP_TX feature is not supported before, and all the frames which
> > are deemed to do XDP_TX action actually do the XDP_DROP action. So
> > this patch adds the XDP_TX support to FEC driver.
> >
> > I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB mode
> > respectively on i.MX8MP-EVK platform, and as suggested by Jesper, I
> > also tested the performance of XDP_REDIRECT on the same platform. And
> > the test steps and results are as follows.
> >
> > XDP_TX test:
> > Step 1: One board is used as generator and connects to switch,and the
> > FEC port of DUT also connects to the switch. Both boards with flow
> > control off. Then the generator runs the
> > pktgen_sample03_burst_single_flow.sh script to generate and send burst
> > traffic to DUT. Note that the size of packet was set to 64 bytes and
> > the procotol of packet was UDP in my test scenario. In addtion, the
> > SMAC of the packet need to be different from the MAC
>=20
> nit: addtion -> addition
>=20
>      checkpatch.pl --codespell is your friend here.
>=20
Thanks for reminding.

