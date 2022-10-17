Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D6601A86
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJQUoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiJQUoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:44:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021016.outbound.protection.outlook.com [52.101.52.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFF101DE
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOpKzxx4k58YuZtg9Ln3i114Yrm16mcotttQ+XOS8xwp/zDd5U+9/kxWokk0BdChBaNZrFF7nt42aV4ngD+nPUbhnvuArylkR63xnDGfx6KYy5euRqg1jhutF0uqxFXj+PHxrf3G+dTyZ17JuN8jtU95DusppG7xlvc19G1K1l0fPtOlQ/qcI2+/ynKWBYKxBplNwZ0SLH2oWaU7su5tdQbbWxd7fw6f27TrdvumrrRpsdJ1+nmsYCiNe1MXCk2DlhWwU5jenynjTQv+Uql7Xo9LufyE66Z/Y7ujXN4JguKNngID6m4fDxdsPKKaH6An8w+1Foy+NM6P4jhe2OkhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdWDY90XuiwMU1uKR8tQPWDsKjKr5OkbKjOSAiuIjNE=;
 b=O3ABSvZQzHe8AMnwYb7BZgHDiaKSzEXDkJIe8dYfdEdhwYd1bht0G1FdGIibiOx2nSvXF5VK6NFpsOFcLGyksgiwIjY9oRhSNAZ22Bkz3O2Iyl9ZS7Uwnl9q3w0n6EBxDrnu5oyz0oNnMgrfHolLBknA05cZvF8W6tT09aHWWC78fFp4JnW6jsmufLSgDN3kJY45yMPCj0jia1voy8Pqzxd3HL1LkXnJcwXly71B46+mlPUWhMY0kabifSILAQ3ww5fKi2NYl/lts3U0gA13EBon+b9FpG3wOVxFnK9q8HiDvXq9NqVJVDpMfaNH0fhtYrvRzFs1eLc8ZQlOEdPJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdWDY90XuiwMU1uKR8tQPWDsKjKr5OkbKjOSAiuIjNE=;
 b=XRCEcUkg5dushi+Re6SoGAa6q8c9qDU0kxya2W59bf1riiplrUJaJqj58F2wutOM3bfdxkUPa8qCJmT3UWuaCUSt4liYX70adQ8/Nfsw6LMuyi3HNe3g90ODTw6aunjPQs3AyU31EjHYgyMGmU/LtBfjHacw1GbZvt/5ApVZuvw=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SA1PR21MB1301.namprd21.prod.outlook.com (2603:10b6:806:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.15; Mon, 17 Oct
 2022 20:42:14 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Mon, 17 Oct 2022
 20:42:14 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Subject: RE: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Topic: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Index: AQHY2ENV7HAf/RJQsUmx4FEyPcI2aK4TIJkQ
Date:   Mon, 17 Oct 2022 20:42:13 +0000
Message-ID: <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fc3f920-e8a2-4157-878e-d966d98690ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-17T20:39:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SA1PR21MB1301:EE_
x-ms-office365-filtering-correlation-id: 537869d7-6262-42c6-b25b-08dab080128e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBK+jtKeNUFxtMovQKq9fYpRpidRnswWX8JxM0AZ0TOPYyy282E+2e5K4E9j/UW5nYFEQ7e7tkim8JmfuCuqX6RTsm9VCE6teC9NhHLf66kyxZluzoYSWOyMPi0celRg55I3bHy3itKtial0VFTu4uNZ2tnmjw+D+884sDcg2QZSSc86WVilKONjgtTIPyN1jmMLzTf46DuatV+qMGTfrFo+PeTpp8JfImZpUmSazEqnCR7L44UWO3r731U/ucG5N1A8P4OAouWx0DlBohnKhyJ0OPyLub7YnOqHY0EQUfdphj1OEcY/S55gBxTcsgl9IAAs9S0xTJk++iTJtefqVoS+3gYJHFi223FQxIP18eN4ZMnk1KIE3TNWjA7vzjLDtRQrjkcMIGExDc+2F8dvmHWWCV6cUt0NUACLvTvtvl6hkp7tii4L5duhs1BDWYvCe5EXgExsIgAaC64IBpRVc6LyjHnvgwwmIN/aVDSYs3Zxthg8vdyLPuPFCnVJtK696J9oiSwYos8x+MpnyBjAq0CGNbKJTVyRo+t3DzshI8iNZRd2CtSM7ezZHAGFqxyxSmC4YhemyDkyqKWdEo36uzTmka0ao55jkbnY9OicPAMBGNPyCgvr88mHzVl3V3BsuxZanNKQjEWW1ljRAfXw8j6sRXgclZIfqH0fIDL4KjSopq4Ek69z7tHvpzMT8CBItDQGWRSNv2WhkL60VwYbLBSX1hNzaf7/hQ3Y3IV3ivR8F99tBKQlGK/xjTM9Li3Ui2ZsIDzI1yygredxF+RGhGViICvc2/io+Lcjx3bgjEr76CsmmY2t111iOFNmtSnH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(8990500004)(6506007)(7696005)(2906002)(8936002)(5660300002)(53546011)(86362001)(52536014)(33656002)(186003)(26005)(41300700001)(9686003)(38070700005)(478600001)(4326008)(66946007)(8676002)(10290500003)(64756008)(66446008)(71200400001)(76116006)(83380400001)(55016003)(66476007)(66556008)(82960400001)(38100700002)(82950400001)(6916009)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uAAq0SRgAOz+XnMudXZc9h5o6GOYO2VEVrjkL41TFf8du34twSeCSMVaj4Oj?=
 =?us-ascii?Q?KMWx7Q0HsyrX2e0dl77i5EIUBvCUMqTYf7V89JizLfuelQpkqcDQw6g0et4E?=
 =?us-ascii?Q?PzZVxxkfmGzy0Vna5PIl4AcaDNqL2FRFBZnW3W0VLUSxdEN02iTZzKQbZZYP?=
 =?us-ascii?Q?ch0s1fWm2XT3Z9jwevzEXXkLyl7+0Q64kf14sMBbztxV5OgE7zxr9jz8dHGB?=
 =?us-ascii?Q?oCbBmdiS92QIY3/djZCqBAn2nkyIafWVHCfxPVMEcuRwxASv9JQ79ZNbdfTL?=
 =?us-ascii?Q?XjzqnXyJcqfrgdoo1iBPtF/liK5gIGVp4n7EjraDNHkp6I+F0CuinB0bFehk?=
 =?us-ascii?Q?aD1Ux61hWwSjAzdVv9JKLBpDu+P8xtDi5Zb111kY9y8XCa/X7lN0HknR4cxt?=
 =?us-ascii?Q?ykJ0OMQi9h9k4e26sZRvh64RODMFKVU+TpRFzZmktD7pGcAwxpHr2XovJ4zh?=
 =?us-ascii?Q?ZuEql2ESj6PNh62+o3ZFuT9Kah7pm9wZ+TnCR+INZFbnq/4JvORxQn9q+Qav?=
 =?us-ascii?Q?Z8QwhqwPhBpfhOves8at3gesZEhbMmG1jkgIZDuDf6GvXgeSLKeNnPzs4scT?=
 =?us-ascii?Q?mN69zjl8daNEhW8K58oYxmy5RGuoajQrBj3TDlemlYudMT7E6a6PYwWqd6tY?=
 =?us-ascii?Q?8buYla6iJkjyU5VDAjBww1wYOUGf3LV8xjTdmWnEYfOfsGjWVHEagu+J6Ybi?=
 =?us-ascii?Q?SktuSsxBNYc/uYLnDNvLFu7zaZwb4G/wu8HnycjJx3+Uc8rZwHc0RGBM5IyN?=
 =?us-ascii?Q?igwwNfyRlEzyNzFUJD1GQ/auFhiIbWRn0NwvtEYZQVPywSE3MxfHI+PNl62a?=
 =?us-ascii?Q?PRyiL1D6vU6+PQsbVChe5B3K21qx666hcWAX7wmragLVU8mreaM8vOItaKIF?=
 =?us-ascii?Q?VzSHLrlz0RDFHuXXmQtXeBwmXVzAg55iNHhRypqmUFrNaDcX7xIJorfiXhoV?=
 =?us-ascii?Q?WIqFaJaWEql3o0kF1cuvTCJk1kSjc1NuWlxxHfuE6NtIrhJxKEq+nFAA9YrQ?=
 =?us-ascii?Q?9kUxLutwWfHoL8LiH257UaQ3GQR7m6503VXZEFUA60F+97zuvtDCVUGF1/WZ?=
 =?us-ascii?Q?uxhO3ZYjWLYvuGTLS5HRT1SR3lVXtViXnR3hxGSa61Ugbg85grL62e35pqN7?=
 =?us-ascii?Q?5FJKqOEW/3lyhfg6oQwaLVK6YmlVd/3ZhFDCHa10HGol4MUT16SXOot8hHsK?=
 =?us-ascii?Q?HASBvFWbP98m9WBAseWSrqJOliLdvx8rl6O6HLbB38Zm3XKXYUT0j1w1k+SI?=
 =?us-ascii?Q?hZmmfKM8Qq/IlqeTQ9pZMpM8GQrNhQSxNWCoFayoLdrQ8aTwfhxJy6VxF0ZJ?=
 =?us-ascii?Q?cE8ucqcYVKEIvgvv+4Da2cMmd3KUZc6gFdMf1E+NxeY4M69KY3mCkcG1oQ9i?=
 =?us-ascii?Q?le4OkiRtLmLBGqNJAxyKml62R35KjrknM/3mwmsz6YvWnnCaT3+Mxi+aI5YK?=
 =?us-ascii?Q?NohfmMlbfwqRHbB3Ydm6RetXcQg5+Fj0El6Hd/kxjotPayEmxpF+ajeeVjdv?=
 =?us-ascii?Q?pYCx4Uxa/T5f5h60K1Nalso0eGHGW6iNUdIkwlbRrtbr/JgchRyX3H/kR/aZ?=
 =?us-ascii?Q?tyEEdcZWtjlykDTQdTLYB3LzTsP51wP79S2M9rInQNTVMztXbrnF0vBfTxLj?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537869d7-6262-42c6-b25b-08dab080128e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 20:42:13.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eokU7xSfxeQORUE7WXwQxnb22CmBJRipgJCaTL7ZTGvkt7UQ0XvXM52dNYzjWdz5gMG23XbkQsyage7kPQwWTkHaaDq74gbBrfRw70ZulE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1301
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just checking if there is any more feedback on this patch set,
as I've seen no comments since this set was posted on October 4th
which addresses comments received on the previous submission.

Let me know if I'm missing some step I should be doing as I'm new
to this submission process.

Thanks!
Dave

> -----Original Message-----
> From: dthaler1968@googlemail.com <dthaler1968@googlemail.com>
> Sent: Tuesday, October 4, 2022 3:48 PM
> To: bpf@vger.kernel.org
> Cc: Dave Thaler <dthaler@microsoft.com>
> Subject: [PATCH 1/9] bpf, docs: Add note about type convention
>=20
> From: Dave Thaler <dthaler@microsoft.com>
>=20
> Add note about type convention
>=20
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/bpf/instruction-set.rst
> b/Documentation/bpf/instruction-set.rst
> index 4997d2088..6847a4cbf 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0
>=20
>  This document specifies version 1.0 of the eBPF instruction set.
>=20
> +Documentation conventions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +For brevity, this document uses the type notion "u64", "u32", etc.
> +to mean an unsigned integer whose width is the specified number of bits.
>=20
>  Registers and calling convention
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -116,6 +121,8 @@ BPF_END   0xd0   byte swap operations (see `Byte swap
> instructions`_ below)
>=20
>    dst_reg =3D (u32) dst_reg + (u32) src_reg;
>=20
> +where '(u32)' indicates truncation to 32 bits.
> +
>  ``BPF_ADD | BPF_X | BPF_ALU64`` means::
>=20
>    dst_reg =3D dst_reg + src_reg
> --
> 2.33.4

