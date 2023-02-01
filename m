Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2B686980
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjBAPDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjBAPD0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 10:03:26 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFC721F8;
        Wed,  1 Feb 2023 07:01:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrO4qQZ2w7X6w/SdYSlCW0ilUjtg4akayKq3fPqcbKGkl62LJAb9xl6yUarZ/3KaDAChyJR+hzt6e+y79jjEVADD5WjljBkmDoV8GDHcODzkf8adEVDLU0jYwC/dWxpC46+enykxXuhSy2Ef6Zvt3VnPZDoe1UcNlZlBDciMJVvu/CZdjbpGIgVZnd7FJCTiNIgOpXohmF95dScYVxoOquttt1kxgKRsi7h6DnxmnoDlNi9xTc07IlU56re69ddkOkKysxzJSKorUWIgb+nI/xBhNjnKqXDPAQl5C4Qn1IfPcn30REsfI+7tTZeF8W7C7fAoVcK9ghAy7zLms+x0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIrmxenUitYAtC7Z+5fCF6GxECQVFvyCVI7diy8v4A0=;
 b=cbbQYTUQ5haLeoYOz+BT0I8TY/LEZ2imyYOHULWtAF9t69SJdQu1CXZPEODLGw7Hm6tukEcOMzckytlLYJQCPnmJpFoq9lsfbmOre34NDr9tgogDkSakSnNe0lhZLY01MEFwCzTyMzV3n33AJFAL4ieEDHouVB3RuAFdBuL4neg/tXhwwOswYRpQ3Q9hxGFRtWVmodIasqKvLNah81NFUygOo1j/TrVsoUYp9iAPIf0KR3g0DEA4mH9Hpgriqa29dSsdSRbXdQH2zNosIM0LkKgfTwC4CBd52XFgynOZPekQ9DUIQjKdjXBqUDyt1zAYap9D7sf69iCwaNKv9zeAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrmxenUitYAtC7Z+5fCF6GxECQVFvyCVI7diy8v4A0=;
 b=S3wk1o6K3d4TORmHKnvgC8qlw8+6o78g5e0vAFBVIuPoZXfLXjY6fi3QwyrX4jCBt2ZCyIitXDLNLMDattwKHl7QgoPqs8ZbgsVVpbUOJzNPOKGVZCJr+RKnqWI/GHJtQVsAm99Dkex2NZ1kvZm/M+PPVzsxZ02OIQGKn1lX3v8=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CY8PR21MB3802.namprd21.prod.outlook.com (2603:10b6:930:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.6; Wed, 1 Feb
 2023 14:59:52 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::7d5f:74de:b40e:903c]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::7d5f:74de:b40e:903c%6]) with mapi id 15.20.6086.005; Wed, 1 Feb 2023
 14:59:52 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH bpf-next 1/4] bpf: Add new macro BPF_ALU32 and BPF_JMP64
Thread-Topic: [PATCH bpf-next 1/4] bpf: Add new macro BPF_ALU32 and BPF_JMP64
Thread-Index: AQHZNjnh+WCGLzafvka+VYSixdj+fa66LtGg
Date:   Wed, 1 Feb 2023 14:59:52 +0000
Message-ID: <PH7PR21MB3878AF6D5523240CA579D0E4A3D19@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
 <1675254998-4951-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1675254998-4951-2-git-send-email-yangtiezhu@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=945e3cce-7cce-439b-aa09-98cfb3b5336c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-01T14:58:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CY8PR21MB3802:EE_
x-ms-office365-filtering-correlation-id: f3ab6beb-82ee-41ee-f50c-08db0464f8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVtdz0bF99vDWWkuxq2mv0gSTp6YpHFriUoCInZHC+Flyigl1HpTgPtzDRYQbcWutp9Ge66Y5iUXm+oQdzhBxGXSQhKDYwZhxvXw2KciVGbERLaE9iBtItmrz8TP2ktv2NGe4gmYzaqlVFQHDajrQb+IlzL6sCY2Zdgq8lPVzviyATVcBfEFvFqna37oRubQq+4PdNP9qU2UCdqWDZa8TMH25FHYpg1YxrO9J4EID2+SVAHXKjvPj/W4nWYJAFVBiLQtfilQOC+FzKt2p1gPUcBIutJxIRU1Xc/gMor6zckOh58PjvxckO3lYgLi5ragX4bIuKBW4L1JaXNaDiDvqV04n7e7B5YQyRruUDcSA7sYDWjv9NarTVWj6m2qhBe0XyYWpluj6y+HrklSDO5hBym2GBHUEtSYNib9827T35C+ujg2JKTuq+U7jH3LtdIlxqJfx0/YrOJGMXnxV3lympneowFWva7LxohT1RzuA0e7W7UW3hkiH6kC0W9ifyzcXuhQBY6kjS4RNCGzywWbhiNJR5ZmxFZPqw1tql4ek5d9wiksg2CCtagOhnjKLTam5ADWSeBvtN9PKUbfgIDv1yGiyI6CIKpJ/seaTJG6azfbObdLfeL1P2sHXiIa+XTENoy11UymAUF11b6p7KKm/gaW1Ae7KmJ6h2OjAbNQjZcarJ4/jponnhfzIYvxxet17mgVa0ZgcnqFWkhkhEiKTvZu2E7aDUWF3B0fRURsrbYjq+xerY4h75NH1q/Edr1p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(66574015)(9686003)(83380400001)(8990500004)(2906002)(186003)(26005)(6506007)(53546011)(82950400001)(38070700005)(10290500003)(8936002)(7696005)(478600001)(71200400001)(66556008)(76116006)(66946007)(122000001)(4326008)(8676002)(66476007)(66446008)(64756008)(82960400001)(38100700002)(41300700001)(52536014)(33656002)(5660300002)(86362001)(55016003)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?22U9PiA0rlbh37EujCZllGTLM9WqdUV2F1yxZiDSPh80rfZi5fZjBnC7mb0U?=
 =?us-ascii?Q?qUhWM6byZVDVVeW9RX0it7lIqUj0YLm8oHMDK8ax7Ti/f0s2UxBWTVYbZ/OO?=
 =?us-ascii?Q?k1QMYv5m1e4oacfRLJORuVreCSqA44+7UlvbzrlWE9Kh0iyptfnwShIT4e86?=
 =?us-ascii?Q?3HUkpLWzZPg8HFDtfiiT0lfrvvzzX8RqeShuGJx5dpdhWebrKdbBrc2Yzz3I?=
 =?us-ascii?Q?tD1jfDKv3ZuPuIadtkDiit/xMPY7muIRFzWUb1XVUZpKWC8/TscNgHCJsp4Z?=
 =?us-ascii?Q?q5WeXP4D4H2IDlOUERpjDzIS/Q6RauLZD4zP12k58L2ku16V4IUXPaFH1oAZ?=
 =?us-ascii?Q?R7/kvYSnOmJ9Q+ql8Yycp7PmL6xS4VmoXDRDAz/lSXPn15gTRDrkyHpwhadg?=
 =?us-ascii?Q?bM/XuVAnYyZr+1Tqq30VbgmfkxNGO03Uaw36oRPh4p3ycqcjqfDjyZoAYgmt?=
 =?us-ascii?Q?EgG97/EYLc8X09Vfs5Woqwj4+dbcIOpSVHXNS4HGZmkWUJjfufcA5bog6+th?=
 =?us-ascii?Q?Lc7UevBvw0wqXSJPdFLT8m9FnFpsQ1KeCPpWE3PMh/Yg1uelExN33eZcPy8/?=
 =?us-ascii?Q?tZe6fLgWXfwL+LXKGIO/bbmL6rZZ0M+GIxafS3GWyH/dTjWtDyoGt0O+DYjJ?=
 =?us-ascii?Q?u8XwBFo/PObzHLXZ2k9TyuOkNnC4laXJ3j1RHQ/B6R0C38Qc99UI/KicN418?=
 =?us-ascii?Q?cAX9JzQOhXQ6QycKcExBzUHNW+TPMRKrkJQ5aMF8ZxMs6XQt2Y6HSY8ELS4A?=
 =?us-ascii?Q?OtL7BXXK5mcJxyEWihUM82iDEUUMAIFg2UFlbphKPz1hYb2DJITKEgRkq1rn?=
 =?us-ascii?Q?zJm3DKpBcEd1vUpOAFGJqjn20biMOIzWQTxOxhmeoefmZdkT/lbGycO6nt+m?=
 =?us-ascii?Q?lB9ZAlNpVPMTMiHuGy1/6b6RA3uwT9AUg6smF/hY9+qFYNVZa991n1gHmH+C?=
 =?us-ascii?Q?R6fMKmNzZM1bJghmc4qbJxfFiY318saOje82mz2NomuLSG8yZ6+XPNau1RSR?=
 =?us-ascii?Q?y16SopIPRcFadTpN1r87W4MHRHXzonyQ6f07QCdLrNR0hGc+Hq/u82SxJ2Rh?=
 =?us-ascii?Q?YWT7y9ONlm+WijWMsUMnB4lcl1LTWRg2UM6+MOXy5nQpA/b0MZ6jj1bbvQbl?=
 =?us-ascii?Q?ZR7OvRNCV+qaqsFXtYBY/gfbmLNAllGNvI7adlXYEGWJWTQeedj9uhZL1LQr?=
 =?us-ascii?Q?x1Te6y3L+pQYQv2ksd9N64Qif3YPdTyemptDRwB2piT8uy0/C4VkGsz3gyGb?=
 =?us-ascii?Q?MtZG7Jt30mJlkuYumG59H9we0EVh3dCISjzO54xBZ3Hu0cO9M2MzUBUapuyC?=
 =?us-ascii?Q?bDyiLUaXIgSae+3cpSsKJJQiUxUn1IPe2q5HalQ4YN9hJKuf9nnYNNOWSHX5?=
 =?us-ascii?Q?l3DrmH/84uCjb9FWTr1xWpdZlxh1/kCbk865CV/NA3Dp+5+DgmtdDvv8Qm+W?=
 =?us-ascii?Q?l57wuzUJZRLITG7m5DlaoV/MiPQd0M4u+RRGSk1asM9CAnzWiFMpoPpBNj8D?=
 =?us-ascii?Q?uyDFgsjUBd/hIHZAkkxUWNG3hXOqj4VRQi4mwjxhf9jDABdnTs3aXzdzV9if?=
 =?us-ascii?Q?5C2VlgfhTp6ry2H3Ds1p3cCJ6JGfhovZDs2C34EAdKvJ02czr7vumRFHyZB6?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ab6beb-82ee-41ee-f50c-08db0464f8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 14:59:52.1230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8U/4+xi2POGPAL7WFk1YG1eVvsj1wmuWjk3Hj6awYghYfck+De0X3zw9VzpMFxfEDdd55IhzXiPo/vj82PBQXHPN+xAlBivELLkwA5oYqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Forwarding this to the bpf@ietf.org list for visibility, since the instruct=
ion-set.rst
change would affect the Internet Draft proposed for cross-platform standard=
ization.

> -----Original Message-----
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Sent: Wednesday, February 1, 2023 4:37 AM
> To: Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH bpf-next 1/4] bpf: Add new macro BPF_ALU32 and
> BPF_JMP64
>=20
> In the current code, BPF_ALU means BPF_ALU32, but BPF_JMP means
> BPF_JMP64, it is a little confusing at the first glance, add new macro
> BPF_ALU32 and BPF_JMP64, then we can replace the ambiguos macro
> BPF_ALU and BPF_JMP with new macro BPF_ALU32 and BPF_JMP64 step by
> step, BPF_ALU and BPF_JMP can be removed from the uapi header file in
> some day.
>=20
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/uapi/linux/bpf.h       | 2 ++
>  tools/include/uapi/linux/bpf.h | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h index
> ba0f0cf..a118c43 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -15,6 +15,8 @@
>=20
>  /* instruction classes */
>  #define BPF_JMP32	0x06	/* jmp mode in word width */
> +#define BPF_JMP64	0x05	/* jmp mode in double word width */
> +#define BPF_ALU32	0x04	/* alu mode in word width */
>  #define BPF_ALU64	0x07	/* alu mode in double word width */
>=20
>  /* ld/ldx fields */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 7f024ac..014b449 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -15,6 +15,8 @@
>=20
>  /* instruction classes */
>  #define BPF_JMP32	0x06	/* jmp mode in word width */
> +#define BPF_JMP64	0x05	/* jmp mode in double word width */
> +#define BPF_ALU32	0x04	/* alu mode in word width */
>  #define BPF_ALU64	0x07	/* alu mode in double word width */
>=20
>  /* ld/ldx fields */
> --
> 2.1.0

