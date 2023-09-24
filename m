Return-Path: <bpf+bounces-10725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AD7ACBD1
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D70511C20829
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1B2DF58;
	Sun, 24 Sep 2023 20:20:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC497DF41;
	Sun, 24 Sep 2023 20:20:19 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020018.outbound.protection.outlook.com [52.101.61.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D14AB;
	Sun, 24 Sep 2023 13:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN/ZxFBQ7TsCFBEZ3Eonm+nJ7OOSrMqii4+B9mPDd5bgqJw2zBitvhKubzwY+2DXJX4OTUiiT4sK1RqtqfhB5LNF16xBf9bDsZ53qTH5MD5PMW3oGU9PWHx8JM++hQE5yLLvxDDuMQaa9rQL1RQIdT4K+JWUhpvRW0HZP71N3jqgB4VY6xtvlFusiGN0JaskHMD4C5/ICKsXErnmv2zWq05KzqIMzdEGfBbXAMLCH7XXGdbMwEE3AG9wKjk84Gkzo9dt4xMMkR5ON28Ab8RDE0psQ7GjzEN9GVx7Lsr9SRXSFWTDG2lRu03tgNaf23cXMXuSjTsEzWGblz/KAGiD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67znoKIcB0/ylfmLqDqeyDlZfKteoqXa1NzIdr3PhdY=;
 b=fk7QiDXmocuVOugtO09g8soFp19ZpwLyvRivPdXAnRp+JUcwFhbSWVscQJ8towbR13rFqStlIsnRWWeA85DFLRkEHAH8WsL7yMfvywELrkb5GyQzdRH9LB1YyEsphmPkRntadhxxZVS2msOodnVFgomV3aemLtulyPHva8oj1GlFISI4GXJZW0rWxSzHDg3UUnsimzr4dX1Z4WeyyhJk9kumbezRQmq3XcZCa847Lf8wjAFcFc9IXIDabxJ5hgVljy8woHoz6aFpzCx1D8lwv45HpqjggvMVNQkOw/Y0WjmlMpHOTARdpDylfSHgq70fq3U26DqqjYdY8VQOSwQ3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67znoKIcB0/ylfmLqDqeyDlZfKteoqXa1NzIdr3PhdY=;
 b=Se3Rf2fbRgjwitbv8GNpDuTwdR1DzgUiwnIovdeYV2Vg1VoP1ygUbGBIItoOSorx4kne5e2gm2NjhdnErBzv+9AY8eY5R5KokbTBYC3XI9oSTY10Z/7J/cHrW5hI9Bomofnca7dXBm/cUs27EEkJcb71Rp2+KwYH4FmxnTUIAAY=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SJ0PR21MB4024.namprd21.prod.outlook.com (2603:10b6:a03:51a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sun, 24 Sep
 2023 20:20:12 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9%6]) with mapi id 15.20.6838.010; Sun, 24 Sep 2023
 20:20:11 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Thread-Topic: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Thread-Index: AQHZ7ocno89Zc74TMUuQIX+kEl2AKbApcUeAgAD6YYA=
Date: Sun, 24 Sep 2023 20:20:11 +0000
Message-ID:
 <PH7PR21MB311605A203905F20FFA841BBCAFDA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>
 <2023092439-crescent-sloppy-c212@gregkh>
In-Reply-To: <2023092439-crescent-sloppy-c212@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17f70abb-0a3c-4d67-a005-c5c32605f25a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-24T20:19:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SJ0PR21MB4024:EE_
x-ms-office365-filtering-correlation-id: c6c504b9-612c-43da-667e-08dbbd3ba75a
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YbwdxlVCrQjby7d6MnNz1HL170Tw1Wn0sD/on91iqGfsHd6S0SH9FtzzzM3b4zLJu9av4nVpFdpCvCL4AGYSIjB/ZznCzWxLjKYvLPIbD4eAzJVp3Tp7uwUmXxo44GPhKFiTXNLl4yXmWh4eih4JtOfWIwjB0BD+E7Uh9AbQcHyws9a1sT2ykOLBK1Er9c+0nwdQeLTEVQRpXOA6Rlzi3vKYP74T6vffhqjVr1C0zEt85QOC+PbPNcKtHa92Ecek7hn9YvPQWCmpy0tkaUZGeowG7tAnn2Ik87zAFRPeLA4AlftWOhuVv/hGdhbvMQQ4RVmp67MHDwWWNutzDVWEQELCoXKSJKQgcGxaktZ3MxmjRN7GTQUXa7BYUPo7GoO1ww0hTzp4jCu8fzTojHEwWtetDxzoQ/7ZH370hQEziJvFYxhcXPNH3dFP8xDn7mXEZKN9AoPzyVylWsNKSYwE1y3uLOWXnLbdGURn0aFgJJAJ7BcT2IzRBB3N+G6Uhg7XPHKzM+cIM+YjOVzKKcsbA7nwwsVljpwVHD7L2J2BGCiEEb73SM/xXgteMGuktCeyBWiel3EWheTMfuoWuovOdsYuVoHe7/WlE7z8iYziyjwBolosdqpzuwS8aw4o9uAm9ahUxvywIy50DH/Mt7ZjVoyVIOzVEOO13x+mI8VkNLc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(66946007)(76116006)(6916009)(4326008)(5660300002)(64756008)(6506007)(9686003)(7416002)(8990500004)(41300700001)(66446008)(8936002)(4744005)(66556008)(54906003)(66476007)(8676002)(316002)(2906002)(52536014)(478600001)(71200400001)(7696005)(38070700005)(33656002)(82960400001)(55016003)(38100700002)(26005)(10290500003)(82950400001)(86362001)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k9wB61bKZHidZvNHsWH1GQt9c5WpFL4CHQjBVj89PqNHftWMuMwGiS579QGg?=
 =?us-ascii?Q?VPjjq/bw1Yi5o8D/2E8YDiSgDnDI+FsWfQZ7m4jm94FckP8fFPhhBHN9+ru7?=
 =?us-ascii?Q?q5APm6RzaNcCb0Xj6EKUMn47OnAqA01ly9S9GwcUvmn2Gs2Mb7sGsGNe7Hc7?=
 =?us-ascii?Q?nuKSz0ieZJz6QfsD12o1owO6D9l5Wvf84M+CY66QxNp1uYmdnsToT0Le4EPp?=
 =?us-ascii?Q?MdNNsKBa0VAaVxmYX1j+IblLXhBqAW4uBayxpfiT3lHifu1OitTf93TddOmS?=
 =?us-ascii?Q?ZVlVfkfiKWHWAerroVIfAEIyXHs2767XGvRe2pV7Y7eENd2WENr9EJNXYv4z?=
 =?us-ascii?Q?O1kunT0gbm+YAThJ4+ehA76onbS2XkW7gzSrpYugk9nHqq/aNiqdBHSnT0So?=
 =?us-ascii?Q?2sHCj1mWqpaTekPHX56/JE/bQDiXZCN48oN0PEpWsOJzYh0FhKq9oKv1JAd0?=
 =?us-ascii?Q?223V5qeRuKnmlJo/K8krBy8NRafzOwhDiErjikr9XTzayKcXW0kk9/NvZj7s?=
 =?us-ascii?Q?PW6CMZCxztaN/dYIKZiX0k4UgluXw+SQ+vq6Yx7mJV9tUBQ9kMr2Jmx/mRBH?=
 =?us-ascii?Q?TN2pW1A/Uno4i+3Q6lY7epchH3Tx0QavYpPX4zcMJi9++0CPjEhAMQEDuuUv?=
 =?us-ascii?Q?MKL0OBXFgehaoX0mdtF3ImjeTGliTmAs7ta4YPocuJ9hlpAoSVYby5tOJEOE?=
 =?us-ascii?Q?jHBdUggaSTqP74AoGDO4o+V6cF76RilcPLwnmuKeqSzvKssmAojMmi+Bd1qp?=
 =?us-ascii?Q?JOZuS9Y2bRTD04jmrLpPY27MkBAItAXnuWCVNOu6rElx/k8V1miMUwZSs4Hu?=
 =?us-ascii?Q?VzWgcoa48ZlFI93k9hgJIDcQ4yBZMXPFTDUv95j8q3TwXuVgMCTQV19s/xJA?=
 =?us-ascii?Q?l110ESVYEKoaxJBl04aqGGKeXxTdR+fsW6qPTtrYO3vta6Tdc/N/qHE+1gje?=
 =?us-ascii?Q?uvCOmiJ0THya1/ZeM3MLvuhdPcHT/1vKzNSLUV4v5onez6Owkjfu4ry4PBlp?=
 =?us-ascii?Q?cz0+TwEMgl4InRQPat8vao1rAhzD7rmJTeLhoqOeEjWGn2GaYAnaGwZSy58u?=
 =?us-ascii?Q?1soQHMsk/eLm68g2vfTe09vCSlhejDs6N3NuzlNdVMGLF1RU8fIGLKuD2l5R?=
 =?us-ascii?Q?tR0v3kl6/u21jfEGxFUZlephQPUwXsS+OiVZT61FYzaAw9Kr5q5y7FvXr2a4?=
 =?us-ascii?Q?S1fTaaeRXHlxTPJdOEvoJdFOGuAMAzgrZR3IfRJrDr09AWVvKoXX4X1+El+Y?=
 =?us-ascii?Q?ytbhGOXfH3NdHYQsrT2TOYubQxp7NYAZVAJZnCFPrE/0cChVBtSowO1evZy5?=
 =?us-ascii?Q?pOm+1GhKTs7XLTHFE56oB74B4N9vAJ9HNHZmOkHg69EjrbNxFvphPfKm8f3e?=
 =?us-ascii?Q?4pjumANjMhzpe2RBq47pmTiYO98nYLdUTAjb+0mr6tBdl3HQUULNTL8S7xOK?=
 =?us-ascii?Q?u6uhucPcLiL6wW/sanCzUoKMI6qVIpi2eyiTITAgGoB/7wXl8D9Ve/whds0m?=
 =?us-ascii?Q?nUMStV+EKXzfT9obQ41J/a88nB2MFMwXPDIcJHHxxzDlKxmm71ArJm1t+x6P?=
 =?us-ascii?Q?aIz5J/AZgcC0fgj77s6tYSHTT06+XACH0q0+ADve?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c504b9-612c-43da-667e-08dbbd3ba75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 20:20:11.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHEgg5c/S1XUG4S4eDlpOAa82hk/oSJCroFuWBBejswdbUJk83tG1hC3AqKqNkOGiDTQaojA8xZpAKD1JpGXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB4024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, September 24, 2023 1:23 AM
>=20
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>=20
> thanks,
>=20
> greg k-h's patch email bot

Is this patch too long for the stable tree?

Thanks,
- Haiyang

