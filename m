Return-Path: <bpf+bounces-5953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C1763790
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1501C21293
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA09C2D2;
	Wed, 26 Jul 2023 13:28:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075AC151
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:28:57 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3DAC
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYxY89rFaCqgDZuZxUfwM7/hJuViZoDgyV/eV7T32eGex9EzQXXBS6pHHku9DmqJ71562wiTaqUf6P8WFdrT65AKF6X7qte5M/yG367MXHeye6uzNhU2ls8DNXXM15pleqe5eDhgvEHlqOGOGXLTZC7c9F1RRF4N/Vv0mdd5X6AFic9Eaquf22b8qh0DaWb3gpyIEVX+oy3jKxi6oq9/LHQe2I4ZVfvbCWt6uVwH3Bg6O1r1Ly34iJfqG8C33iXvvYlSbO5anwIlf/8uKKOWSZiY1/u/A3qKmVuRkF4wKhMOF4i2qmzV03fq22cbst9uQlObQO65X2SQWPumRc9Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBi3ooOVGlGYSeNPKpQT0+B7DjSu7mjl1bWiTaa9OgM=;
 b=kBG0M4l0FZu5zVSSBGbd+jREih7tkAgQ8Ldjd0ynQTD5VMe74wdRE7VImsqYdtVMx1KlSYJY9Qwb6cIp/J+pFh6QS4oiltKu0LNNOP7g2JWdPzdzxaXQeg/Qz84occpVWiFWHOI06DLpgQ3U9LN4Zc3uC6xz7DQ+sRH/l7Fb32LbTMYl8wW9qodh+kfrQmV7pqM10xYJmLodSaDvFBEZsw8gZ/stYpnG5D0e10QP5olJf7QXOXW5E2o+z41O/AYevCYc0NvGsNNzuOxnAVrvSeN76RujjNnFkM4PhjhloerdVk9HneNhlS3cMf+pqMdu09AkB6AgHY2O6HUhYrvm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBi3ooOVGlGYSeNPKpQT0+B7DjSu7mjl1bWiTaa9OgM=;
 b=EyKmshsnCFoJGH+8iDN4HDGMk/rXBlviTr8NaO0b3UE2bCBTDgv4tAZpi8qt1fYmdRTxfyIvFjfEtx7dSKCnC7XEWr3us71Bj4Mj/bySdqIggod5o5Qro3vVzTkd6Zh0EO34dAkKQshS/tcnM+7tOlvWyFxtyvjfWDIoCNynjao=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB1951.namprd21.prod.outlook.com (2603:10b6:a03:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 26 Jul
 2023 13:28:54 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 26 Jul 2023
 13:28:53 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
Thread-Topic: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
Thread-Index: AQHZv6MzE6eRJcWIfEigDp5ZlTaSuK/MCpzA
Date: Wed, 26 Jul 2023 13:28:53 +0000
Message-ID:
 <PH7PR21MB3878287822C8A1F5994A8E9FA300A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230726092543.6362-1-jose.marchesi@oracle.com>
In-Reply-To: <20230726092543.6362-1-jose.marchesi@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04b39e72-ec51-4282-9831-827ef74cba26;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T13:27:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB1951:EE_
x-ms-office365-filtering-correlation-id: 097f3d50-8938-4279-b2cc-08db8ddc4166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GMenmjzlOCn+2KkUj/9Ld5TRIiPIZDO0u+JjbStTLXTjE+eOTewzg8GC5/m6RBqfWmpsbYZdkOJG2x2yKHDSR3TeS0t2A+EKQgjRrmmYVyDkXzgqSkrboHP5G7+Nw95mlHlZyG+Cc97nXHZ+kI3gJUmUcDPijtHE60qubBRx61ZIV5gYTQSAsdtWgqR9nRhxlf+QiN8TBW2KCWOgJWZ1uwmRqp6HXNzyMawyTZHrBJLYVqcLPjQnAWsZRaH5eykM2eBDel6Pz1ypeajDbw8AAH/aSSOvbC0HwlaaJPba8Z1ltvo4jpB8a+1cJKr7Y1PaWBFMZNozKIYs/UYslpqbz7tBLfoyQMS7axTCBUD4Ghd2oglQzrwYluvd8Saej2nOGFQyFIchdnDEzbRCxvDg/+n5tdL7rQhXFqzWtliJEztf+ilmqRYEbFeJjklsVzjl2GmYuBiXRmD+D0R7OgxGNJxZZBovnorl6WTptdpgutNeEvMypBDntAi5KXZrLmnBpFlQ4FEC0Ujgw6D8arwnujJmvRwX287ooVJUlVk5xk9j2voaekBSuQ8y7pXgSrbnphBUeV5cECm1BbOrFTn5ycgWpkQ+fcHwG13BPwtzWbndJDszyk2XTuffQhfFABBVweCu5rMd9PWku7+Yx2UZjn+jKgD3o8gWU/VSIW4fiAI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(6506007)(53546011)(52536014)(110136005)(8676002)(41300700001)(8936002)(5660300002)(76116006)(66946007)(4326008)(66446008)(66556008)(66476007)(64756008)(83380400001)(316002)(9686003)(186003)(71200400001)(7696005)(10290500003)(478600001)(55016003)(2906002)(8990500004)(33656002)(86362001)(122000001)(38100700002)(38070700005)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xaSXdBXZw2iEpKfWa+KnQo/5Kdp5JtVMFvjuwUdPJEa7eG+iGFrT+7T5qkb7?=
 =?us-ascii?Q?d6hUZUqkF1QGqF/BVitLt15jnY2X5SRe1rJfBCFqiyoi5243iEpG8KtrZyZ4?=
 =?us-ascii?Q?0r3LfMdzgwcUtwVj3C8hd8oguoZEemTj+hZlMd/dmS0P7NV/SClQ1EzzLJHK?=
 =?us-ascii?Q?bJQYBVB2+diibpTdbrFwmAIDt4sUl+DmvJM21n+k7UJQ3af2abDU+wAA8tpo?=
 =?us-ascii?Q?zXDX6IOXFlIl0nmTEHUo0YWEB6YfOKwv/Lve6+WTirP7bdC9L3ezrkNiBINk?=
 =?us-ascii?Q?7sNZmmyQSv+1yTO6tAyPkCruFwY/Qb7UH7xPU+x+Xk9ntl3tDOlb/849M+d4?=
 =?us-ascii?Q?ga1XcAKuZcSx0aUHCQUUpx5slKzyC0LjBYbjchck3y2W301lCzhqLLeHhGPQ?=
 =?us-ascii?Q?GKI9bfAs0UiNrZnxbkAiBU6I4Qj67jSVjSE77OHJyq+e04rQ58TxvaS4WlxQ?=
 =?us-ascii?Q?FHC+M47/o81nbZnng3pN9ybloFn0RuSXQd3NqEQxdRomdu8u+D0eJyxqoeEM?=
 =?us-ascii?Q?hBzd3xLEpEfQ9LRwshiU5ewHPSFKiNTOgMpUv6KvQoZjXk8PQAzdHCitGthY?=
 =?us-ascii?Q?rLWushIMhBP/Uc5B1Y5d3Zk86PkRRHk0szBH4AeSDhd6xW8qzQelWss10DnM?=
 =?us-ascii?Q?R4k7Z+ZOw2L7Q0+HLxK+SdZfQ+MWNte6ovg3hcgV61Ui7GOJNpZnaEPLo9wm?=
 =?us-ascii?Q?c5fpdTR+kDAMwm9NaQiThPsRklZHwVhvmOL5QH8O3AlnGxstlk+nCyG6gQlk?=
 =?us-ascii?Q?HHx3JPtu7rqgvio9vbRgdJ6/uFPaI/8/F9iAZyd33EYaaCHHpJwXb1bt4iHR?=
 =?us-ascii?Q?JVNRzMMhUnVd43jxqjNljdcIUUtsSvvOVYPPvD/kgHAY172bnmWAs16RGncQ?=
 =?us-ascii?Q?LJhhAm++VNn/vR2fo1GIcJR29AhJKCLtB4YddQ9HA3GpEM1KlQsXlLrbJ7HD?=
 =?us-ascii?Q?FGiFTMmaZk7fJjsLZ+OqSKTqVbmxo5OkBcnxn09cE3U1Gsy2dRxLWOF0T0jK?=
 =?us-ascii?Q?W452SM5Td0rDoOjPt7Eo9DM+61cKdy1y53njXDshr8XLmFNvEf/WLHjQiQlZ?=
 =?us-ascii?Q?L28m5gZsiMtIRRELbRIPh7cHcYcZ5lcBibII2dybAD1+Tp/+4YatfOGC+3lq?=
 =?us-ascii?Q?WOkiAhfRmirtvOGf95vykW9t+eJzmbmMPLsFaxNfVlOrCaaFr0muqa0CqlOr?=
 =?us-ascii?Q?PjG5thjeQccdw1mCcWL91NiKZ2uoTOVMiJ6ZT4u6c7F6liIcNBMchYlNKDcx?=
 =?us-ascii?Q?uKblq+sVqmaqD3pVUS6tzeR8Ynvfhp237kGJ5VRNZHcEpITqMLtH/8POnIdD?=
 =?us-ascii?Q?YOQxAXbgeYNhF5pKFklZrT1pgpJE05LFyg1aOMAeknX6NcDjBV8yMe8qWmOn?=
 =?us-ascii?Q?/DTFqKaov/FUKnJ0unky+6BgREUGd3vmI+Gw6Lua4eeCa41DuQvQsiqk4DHO?=
 =?us-ascii?Q?k+/yau7Bd3vqHQsKrjn0IGdVrJn5Fj8S4/6MVQh4+Ff+JMcdov7e4bZ/tqnU?=
 =?us-ascii?Q?Bb7g7IwuFCSPdW24Ssli7igdh58H48+UR97m76/fC4LfAElt738IKd24WUFd?=
 =?us-ascii?Q?nx0hXeT+9rMdY40SEohpquYnSOG6M4EhAf0osSYqs9t6Q5C5b7bpIzbCOb2m?=
 =?us-ascii?Q?0ilY6pcw96hZgcGRYyx+m/EIFkuOJyojn6fmE4WhcytoC/1UfgKduG1x7UCQ?=
 =?us-ascii?Q?XPEX1Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097f3d50-8938-4279-b2cc-08db8ddc4166
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 13:28:53.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+WRHufNpS4JDFpTwpsjGbw7DNX8rHP1Bx8I+4WA4Hbig93KPglQTGsvh3ODnv3xkzeQNER9sqLjD7lQft/U1HAT53vJNNKrK5bEuEfjByo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Jose E. Marchesi <jose.marchesi@oracle.com>
> Sent: Wednesday, July 26, 2023 2:26 AM
> To: bpf@vger.kernel.org
> Subject: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
>=20
> This patch fixes the documentation of the BPF_NEG instruction to denote
> that it does not use the source register operand.
>=20
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index 751e657973f0..6ef5534b410a 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|=3D src
>  BPF_AND   0x50   dst &=3D src
>  BPF_LSH   0x60   dst <<=3D (src & mask)
>  BPF_RSH   0x70   dst >>=3D (src & mask)
> -BPF_NEG   0x80   dst =3D -src
> +BPF_NEG   0x80   dst =3D -dst
>  BPF_MOD   0x90   dst =3D (src !=3D 0) ? (dst % src) : dst
>  BPF_XOR   0xa0   dst ^=3D src
>  BPF_MOV   0xb0   dst =3D src
> --
> 2.30.2

Acked-by: Dave Thaler <dthaler@microsoft.com>

Also, all changes to files in the standardization directory should also be =
cc'ed
to bpf@ietf.org, which I am doing on this email.

Dave


