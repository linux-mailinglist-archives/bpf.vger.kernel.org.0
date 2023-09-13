Return-Path: <bpf+bounces-9910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E679EA61
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8031C20C88
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D91F16B;
	Wed, 13 Sep 2023 14:02:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472B1EA74
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:02:45 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2125.outbound.protection.outlook.com [40.107.113.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768031BD0
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJpIw7pmmmtRKF6++fjdUjqLlEMOCkamtxVpAEWlj5QfgjfajCMoAYehmlshNUFyVTeIlwRkPLoNwdFzOFb3kI9dpRjzaPGFxudHr3aHO7OEWcMkZjVVwBrvfy6o10ZlVKib7kyEYBPwenqBB+Vn7L4C1PWwZ2QKLJCPlAai/TiMvkqRvksRHfmIWEBhYLi/0M/Nd/h9ylavTb8nPMVfbGuDE9qZs2LyxqsapJQXE14ORLNmVxfm+Ik/n1sksV69V2vC+vDredPGs1is96j2W6Yr27IuXc6KHbh5mn2TD501eHDvTt73QPthfrNv/8qeT1DAGflZ/ug1p+zuv3P5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8Zs7OAbsx9FycxezKTMWc1pvQqwVvO/S7MCburciGs=;
 b=f0MQ/SuYH3xAcqYZzLwNvFO/4MEJFoT3DdElul3+fS2XeknrSRKE2mk7HDZo5evYw2CkSIXI1NxrEtgzrhAywUob8tCYSdbDOpU5V7qtfuGMJ67nk3s1mgbU8Ulj8PQ/cirB5jF+f1vUAN8SO3zGifbwNPpNwXyu71esJTdFqtXauM0Um++rOPKOlHSJjNUiI0pF4lhihQESmEHczRujulEXbqtIXiPguAkHV3ybJOnl0j+hxaoc2Sgc88jEHLKbFPKGbXvsnoqA9jdO/ilezrD/oUtGiEEdCfNBFnkTfSqM1/CtVSTY8aeMpfDOLv2PAelavFwOOAv1ROovT+Awlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8Zs7OAbsx9FycxezKTMWc1pvQqwVvO/S7MCburciGs=;
 b=kgVxsuTp2YNRdQLNZS8K7VktxdvU5mmrwtVFBhYF5b0cJizK6RJry3GVIKb1G/79/YCzQg9w3VvVwj1ZyCVZnctcsb2XmkWwwK0LEYR+h+Vou066nZNX2KzweVcbLYFA9QdV5W13GMFgTfkykIEeL+KO8XBE/ar9Aroqu5MJXSw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10615.jpnprd01.prod.outlook.com (2603:1096:400:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 14:02:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.020; Wed, 13 Sep 2023
 14:02:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hou Tao <houtao@huaweicloud.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu
	<song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
	<yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
	<jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stephen
 Rothwell <sfr@canb.auug.org.au>, "houtao1@huawei.com" <houtao1@huawei.com>
Subject: RE: [PATCH bpf] bpf: Skip unit_size checking for global per-cpu
 allocator
Thread-Topic: [PATCH bpf] bpf: Skip unit_size checking for global per-cpu
 allocator
Thread-Index: AQHZ5kqYCj5hk0X6PkWBtZtAosvNj7AYyPlw
Date: Wed, 13 Sep 2023 14:02:40 +0000
Message-ID:
 <OS0PR01MB5922E850CE3A0503A9C3307C86F0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230913135943.3137292-1-houtao@huaweicloud.com>
In-Reply-To: <20230913135943.3137292-1-houtao@huaweicloud.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10615:EE_
x-ms-office365-filtering-correlation-id: 3edc3b91-0257-49e2-b195-08dbb46217c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vP44bjs+qdC6Bt/M4s8PNA1aySg1ZUdN+XhF7FTTGJcNLqq7/qz13/I00rSSSX79jn4kkayTRTMm28NNGpp8bkrLyQwhxnhJCbdkhaY3Dr2+JknbTx/Cxt152vUosEhrKvpIskrSKE1QpLmnhj9xXL4tuR7UEDhSKVc897vOam9qkVaaPpbfQEc5+13KCle3ooPGFajhqM9ikRkp+VYbzx99Um1ORVKu609pH6H5ZZi+a4hnpQicFAa51zsgGB/jSbcE7O5W4ucDSNg4x6f6Y/MBvZU/uJQxQLrGct53L46+K6ShT3kbnmo3PXFTpYdwTCmczzYKqQ0OTFGrGLlCdIOx+Oxcgh+9D6tPgx2iygVln39Qw2xVBss5qt/mUHBDFXwO3hWMadn8bmYwFYiiTAaNXYD2GibNnuoRGy0r+a7HQTlkyIFMj/5t0DQGcEKyDGjKxirV9VLle1krJepNwr9H2vloeovm8uYEErQfEmgrTptty9/HEtvdmVFpx9bsNamh79ToPxOxxlp2MFViuDYDjlaGtGVdM6CO7WgtZd6eZncJUKSL2p+bPNSFZk/o3abqWJA3UueUMAwZ1YaROMMJAziusMgYCsZDqH4lSis2JEWG4rULMPmhuFppSkY5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(83380400001)(9686003)(55016003)(38100700002)(38070700005)(122000001)(7696005)(86362001)(110136005)(76116006)(71200400001)(6506007)(478600001)(52536014)(8936002)(8676002)(4326008)(5660300002)(316002)(66946007)(66556008)(66476007)(64756008)(54906003)(66446008)(33656002)(41300700001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?++a66RGTdCvSXQGNsAtbE7iwhjtLBZtaxul/2V9YshLhHMhN3X/ygTSdk21+?=
 =?us-ascii?Q?TaaBPWxbi/QX227fAXiZgV4o55HUlm4DtqY23fFzxAQzAxFMH/NDyDf+cJcL?=
 =?us-ascii?Q?QCeub1OixtKReSNtjw9rLVh2Lu6mQoHjryBdglY1BatO9UirJgjFbZkOwfdE?=
 =?us-ascii?Q?XHGRPZd8NQEZrZUl1oIO7RDEFbp2j9Yhaj108JoCY3XHYgSxfGVlSynQGYo8?=
 =?us-ascii?Q?nVHRGArOWttpuADbHJOsGioQ7wxtGY7G3LH6iFAJ2ncMs2aq7UvstczkGpRg?=
 =?us-ascii?Q?qKlFpmEvpQgRrtEvRM8MxPLZ4aQfUBPs+zb36e2oPPwh8XFNMdDefXsfMUjz?=
 =?us-ascii?Q?/hwyteXraiYAV2Brbfxe855jikZWlF6q0YGANYiLmbS5Ax8eZqx+a2YqiciN?=
 =?us-ascii?Q?vG6l8ARIr9KVj4SyQSiptJk757Rrgg7oPvWfFblMzy96LBKwMr0il7pz/UaN?=
 =?us-ascii?Q?N/RgshpUJ9Aw99gTU1SnC/QMb1QkKvx05pdIhqYOQH3ggjjW2WqwA3BJXZ96?=
 =?us-ascii?Q?oMzs54341Tr78NkmDsEqOc/4dEUZuvSPficzb59rmd8ieV8fzONn5O12Vvzt?=
 =?us-ascii?Q?CTQEo4Zag3eiux76+Rh1/kaCaI3j7yM1ELXF4kIhbiWZ8dHQ+Fjo8bTkqsUa?=
 =?us-ascii?Q?jw8eYi7e9Z6rWXxziVNYRgBBfTHg9yfYo0laJq1wUFjWWWjFnGw9m4u8Iai/?=
 =?us-ascii?Q?s3x3bLo8iBJBYQ1J2aFmgL4p8FneS/5ELB7UpThc+T0VLBBUbyK6XlB9BbnP?=
 =?us-ascii?Q?DgAEBhwda/bTfwqzMEyO+/ib6sy9c88awzF8utnNgGzfNVHIoiF9HOscP51P?=
 =?us-ascii?Q?Ih4yAvGfrM1WkcpTOHAbkBTdU1Tp6tpOX9p1VtzEh32OhnEfSJRnG0Mma7gM?=
 =?us-ascii?Q?WiEYcJGhArx49Zph/Bj2jzHD15nBGcSZw+Wt0/mPeElI2jvqHKb+fFW/EY/B?=
 =?us-ascii?Q?CsqYFUvm9bGmE6H7X0v7stiTfCRuDIrmKPqnctCT0OB1foQG1AbczeWPb2E9?=
 =?us-ascii?Q?ccObH5jd4m0iOw74rulG+10PLGxVufi/2sofp6mZSzVEmnZ5cL4dMGTU9HyO?=
 =?us-ascii?Q?YlqNnVEuW4mHT9flyGV19B7Ut8AwvgZJHY7ZcjIkdApKQfTiS88Xx/EHVc3w?=
 =?us-ascii?Q?9HAkacMdyAQr6DvRodt+TIGkyQXLimHFv3S1dJ7dFoiyNvd8j2yMQRnCYU/z?=
 =?us-ascii?Q?wpR+vPX5XtFlki3RIOkby9TH25kqZdu2pdAVEQm79nPw82EA0M9ls6czMzOw?=
 =?us-ascii?Q?T+ryZ78RYJmTmnnt8JuiUU9tQ1Knj4zYyq+XhC35WXjO9GhAvFG6qLZmxDfZ?=
 =?us-ascii?Q?RTinv7iTbdPRSTv/rWpXwpmcZNiUTMnkQxfj+4xxZwrOHXzE4KT/WHgk6sIj?=
 =?us-ascii?Q?UJN2GBGV2iK1xv5ov2kGC/nFzQyKbASep3GSwu2BqP2Yp8gh2gM60unrAwFS?=
 =?us-ascii?Q?pCZjKe/DP+0JOhb6UPn+qa0OvMdKRo4QhJD6AAcbEMtwUy5RIVCEZdPwvrfU?=
 =?us-ascii?Q?0G0uw4NKOmQP1e5hjjNp+Ll6LZsSx3cda5v3EQ7eO8GjNbibWOobWZlafwo5?=
 =?us-ascii?Q?goeLyGWPsoAI7Wu9NM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edc3b91-0257-49e2-b195-08dbb46217c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 14:02:40.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilqKmCPifSFVvdibhvasyzCmI4PHaxwygzp9Hw85EIDrokQMk2dTLz7TK7LgznTeVpul4EHiYz2ZHJC4j7nkmN9nEVV9bYCFIPnrXcufMDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10615

Hi Hou Tao,

Thanks for the patch.

> Subject: [PATCH bpf] bpf: Skip unit_size checking for global per-cpu
> allocator
>=20
> From: Hou Tao <houtao1@huawei.com>
>=20
> For global per-cpu allocator, the size of free object in free list doesn'=
t
> match with unit_size and now there is no way to get the size of per-cpu
> pointer saved in free object, so just skip the checking.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes:
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  kernel/bpf/memalloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c index
> aad558cdc70f..0ad175277f89 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -491,6 +491,13 @@ static int check_obj_size(struct bpf_mem_cache *c,
> unsigned int idx)
>  	struct llist_node *first;
>  	unsigned int obj_size;
>=20
> +	/* For per-cpu allocator, the size of free objects in free list
> doesn't
> +	 * match with unit_size and now there is no way to get the size of
> +	 * per-cpu pointer saved in free object, so just skip the checking.
> +	 */
> +	if (c->percpu_size)
> +		return 0;
> +
>  	first =3D c->free_llist.first;
>  	if (!first)
>  		return 0;
> --
> 2.29.2


