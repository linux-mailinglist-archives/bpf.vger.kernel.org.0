Return-Path: <bpf+bounces-9885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702679E522
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 12:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D01281FE0
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFDE182B5;
	Wed, 13 Sep 2023 10:42:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56D17755;
	Wed, 13 Sep 2023 10:42:51 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DF619A0;
	Wed, 13 Sep 2023 03:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YujeuFzfi+k/RXeNlbQtdk4KByVBtfzx0ZlwaC2CPDIXjJEoYTH1w2VOKps08a+/HYUIUxYszuQMtunCxaBwYHOnde3/kw9KU1ows2dUc+E9N3xkeUkl8j1fvLTrDY7ycJBY10gTHnsPtT6W0ptnnCDHDpIGEz5vdcvlF3wlZp0AXjl1L1grsV3JtSaMNsnspm7cuG96NHRBkNhcyFWHwfdAHBeTpBzZH5S07YOYerdFhchq3Ex6MJxdqE7CHtwTg+WLswWKpGOh1vzALUlyITwkreL/1I1HmIt1EVvsWg00xnuytLkl0Blrb4/ny0x6E4h/UuIJCS9XAvxRt5tb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn4Ng4nuMNGJdZG08xijsgE9mkd7Swz6Qs5+clxhopU=;
 b=L5uZ3UU8Ig18Syadd+xh1bXdEE9T7mFlCU9cuUnskAfiRwTExgKtAYfWrxd4HH1M3qaMaM+wfsZI5K1wCKUw1QjvM3YU3M8AmoSxKEZmZlEpTTBEMAHFwy06x03ESO5F0lRiM44NE/Qfm+0Zi6iyaXJ3LGdzHh65BZIyNI2GcJNcQKP/Ft2n6C8XaKyzKr8y38IvAoqEns0y8p7O8mPenuQIHyW0dtS7w3v1adXOsWSVKmdtbz6DoAMDwXgRnDBmywfEbqoxWAnaGjY2cY8Am51r+MWHhru53+uEV4pCWZqxg0HvrV+KBYxi7nhRbbHsQ1Sv9nAoSiqA9RsaSYj/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn4Ng4nuMNGJdZG08xijsgE9mkd7Swz6Qs5+clxhopU=;
 b=OodISMFwx30mnK/QvvhUMJNuuPZ3HbL/JcWlqVT8BBEOkpg3uQX+Bv1nlkVjunXi1f5uFcRHMuiIkhCLvVRS87b07F+B21mytfFRx2hZDae92Maloz9MDd56KrgPLqj8D/Fncx+bo9QX+mTtL9gjxe5/Nqz+pMtZc/QunYsxv6Y=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11104.jpnprd01.prod.outlook.com (2603:1096:400:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 10:42:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.020; Wed, 13 Sep 2023
 10:42:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "houtao@huaweicloud.com" <houtao@huaweicloud.com>
CC: "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.or"
	<linux-next@vger.kernel.or>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: linux-next: boot warning from the bpf-next tree
Thread-Topic: Re: linux-next: boot warning from the bpf-next tree
Thread-Index: AdnmLposdFi5qwwpSbaxAsvKHWRIJw==
Date: Wed, 13 Sep 2023 10:42:43 +0000
Message-ID:
 <OS0PR01MB59220BF943CDC98CDAA9392786F0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11104:EE_
x-ms-office365-filtering-correlation-id: 28dda333-582a-4da8-013e-08dbb446291e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nq1RvUyfIdy6ybu223a9zRP23pVo7LHyYyXWz6UBoqBNNBlUC2PDUT5TeyGgUw36BWeHdTkahm1l9bx7EZajUDV4xJQ63WgjwAhqVgZi7NUQqDHniG14s7b2hUH6rZ0lCbASmolhYqOw2/uIzy36gcbbxAWRmdyahqv6iO3pMoYTA+9FE2ClBgB4dAR9oOdjargGsUqYjXwllxryh8jgQAOdn/veNerSU590tGk/Zqqs5z+D88Jqnwnv8mvk8t74RGaG+YxsnPnEFGwR5QBibp/L4tuOinkNSCi+/l5EvTUnvyYbvvNXm73AVStdPjeist63RobufAawBf/mc1NLUNkHD99V4yaNphAuOjPZldlpMYMY8Fb1J3oJ+z+AVHVQa2EbE+Q/ob+0uBFMv4X8mpCsAUvC/zcZxFp47m+jWbUsmFOowBG3WqnoD2Fn3h+zWEzpRNosZo2yFvmC6/NpqIJl7X45NtxOqwxxV03Unc5Cwvw6/xkEYGuR9kdUrqDpZCSXkq3cggJJenbT3GgK6+O4fz/0nlSOmSnMu5uVRrLKtv9YxilNcSSlFt3v4+uP9skActKH7frbaQwT9luc5+2aSPP5EGrUhJbcq2vLGYuSBLem2Zdu7gprA/KYTUGX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(1800799009)(451199024)(186009)(8936002)(4326008)(8676002)(7696005)(6506007)(71200400001)(41300700001)(5660300002)(52536014)(45080400002)(6916009)(316002)(54906003)(64756008)(66476007)(66556008)(66946007)(66446008)(478600001)(53546011)(9686003)(76116006)(2906002)(7416002)(83380400001)(38100700002)(55016003)(122000001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nok6giIF7/ibrp6C1i6U5D2KHIaq8vkFi6RUHmx2FtcAWAG7hRbS4bGPlX4X?=
 =?us-ascii?Q?Fyp1n79u7jyFVe7F4ZMLVSvoXE7xz1VoxPRNs7CzLyGY3Pe3FbhPct5Oa63e?=
 =?us-ascii?Q?167/3UcxcQRTk10L9yGuQfKf6WmcMCqoO4pjDoXiU1gWcHsFpfk8McloZTXL?=
 =?us-ascii?Q?3+qifOS2+hcCn3MN5/zEXx84tYu7NY/0rySIUFhOJol67ApOSvj7UiRNGcFd?=
 =?us-ascii?Q?vOQWsgeoQvQZYgl2wnQF1KO1fWfKi9I1ZvklY4rphBi7tUE/Iw0FddRsQx7m?=
 =?us-ascii?Q?g2vZZQU+re0j9THwJ8Y8s0/gf3RwtsO7RlFwY4U3/T8prTUEiHX1IPd1NOul?=
 =?us-ascii?Q?DOW1D5TaH5J2bjv7xTz4Bvd3wEI8XLZgwIlv+/yNCavpNt6s9m3VoO/1iNrK?=
 =?us-ascii?Q?+TrI2Sh3guokQXki8N9R++Anmd6s8ftTE/2tA5exXuQnRjjClbGKYipch+s4?=
 =?us-ascii?Q?ImrsxiT8QWaLGkt/tmZgzvgSeT0FdH3l5KcNyn47+8nrEK6ccFtIVoiYJtsf?=
 =?us-ascii?Q?/OBm0tpyPt3m1iy+2t2Q4LQLAiwErHFLuwgNuOzQYaesFyVMYoGTqRiAzsaG?=
 =?us-ascii?Q?wT+DZWMlNP78XWEeAaZSmQkq5vr8lB+jD1fnMjlUsBwpouHtBmJfZG1ceqDe?=
 =?us-ascii?Q?KFMa8bN++flG+leTZPNhdiMTMYkKlTXTRbBcyaX+Q24wsAX72XoDlp0ERj3G?=
 =?us-ascii?Q?RoFnGGyVQwcCLwclwXYxh8R8jG0CUSI5SVjMwxblWzzp4D8xABmuUpi+S2Ry?=
 =?us-ascii?Q?IXOBaYNfHnQE8qTQNDOvAmbwGZXgtgGWmplzgMrEilYXr2G5PrT1AnGRnHcO?=
 =?us-ascii?Q?MCNl9Dl1jyu4M9+Q5YNfCDNaME1Bfdpmgcbp0bZsLutpfUgWoUcnzt8QOXBc?=
 =?us-ascii?Q?NTtbhc0D5zMaEMIS0miACzIRXoFgCW6BRks6sBLp76mSvmdzJpE9zvB66laD?=
 =?us-ascii?Q?tbBuHFYlnLVMwwZA89nezQ4dpoYOA5/Sqz8r50SkuXnz3SYeZHSF54E63rVb?=
 =?us-ascii?Q?QOCUZZVY7Pxp9grmYgO3o+Zdk3N3ImngBJ/DBdiH3o+qRa9b4hRyU/qvGtyB?=
 =?us-ascii?Q?unKcbz9rSwHfEZQKrM+dD4t8P7G88onsxl56CNb8MWsLQzH+ylkTARYGVtsR?=
 =?us-ascii?Q?RRWlqJWTyqvp7AdDbEikaxkC+qg0SvP6HGRmhBZ8bnorDa6w2EnZSMDlPMTY?=
 =?us-ascii?Q?Kc+Isyp5HYKYwzah8uSN3476Ez1TBe4XjWa+vIOcwD7DL/P9Q2QL75KQLDMg?=
 =?us-ascii?Q?NBNusti7gAaZv0hqBWraE9Cub0ALPWnzPaIz09kE621G2AOTN5toslcL7k7Q?=
 =?us-ascii?Q?qoBOPhcfKMuc15vNDgNK9ODS5RUYaXq13NQtFGzoFIG/5/Png2v+zkoPhLrO?=
 =?us-ascii?Q?e9u5lEoLCmO+N+NZ8XYpX7SkbLPj7EFh5D+4E/DIwKuzMU2dj7OSYmX8BQKX?=
 =?us-ascii?Q?tazYE+U33+nh6WkG9w44PB/LxWHxDMDAzWqZzqLx0VWTaAzvwN26dwdcBdtC?=
 =?us-ascii?Q?Xczv+rn4EnTBv8erDYjTQ88+WqEPbGlOL5HnA0cU296F5yP5fglqIMM+0Y6i?=
 =?us-ascii?Q?J3rL11w916qhIqVun4o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dda333-582a-4da8-013e-08dbb446291e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 10:42:43.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNvZGNCgG1UiCgNL8jNpnbaQKZf8IuFp+c2VTnxC/Chb08HSFZkAk/McDCjgB0jXb7393A95AdjVT2dgCM5DsO489wOp283Flswg3fed5oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11104

Hi,

On 9/13/2023 12:59 PM, Stephen Rothwell wrote:
> Hi all,
>
> On Wed, 13 Sep 2023 13:34:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>> Today's linux-next boot tests (powerpc pseries_le_defconfig) produced
>> this warning:
>>
>>  ------------[ cut here ]------------
>>  bpf_mem_cache[0]: unexpected object size 16, expect 96
>>  WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+=
0x410/0x440
>>  Modules linked in:
>>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-04964-g2e08ed1d459f=
 #1
>>  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>>  NIP:  c0000000003c0890 LR: c0000000003c088c CTR: 0000000000000000
>>  REGS: c000000004783890 TRAP: 0700   Not tainted  (6.6.0-rc1-04964-g2e08=
ed1d459f)
>>  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000280  XER: 0=
0000000
>>  CFAR: c00000000014cfa0 IRQMASK: 0=20
>>  GPR00: c0000000003c088c c000000004783b30 c000000001578c00 0000000000000=
036=20
>>  GPR04: 0000000000000000 c000000002667e18 0000000000000001 0000000000000=
000=20
>>  GPR08: c000000002667ce0 0000000000000001 0000000000000000 0000000044000=
280=20
>>  GPR12: 0000000000000000 c000000002b00000 c000000000011188 0000000000000=
060=20
>>  GPR16: c0000000011f9a30 c000000002920f68 c0000000021fac40 c0000000021fa=
c40=20
>>  GPR20: c000000002a3ed88 c000000002921560 c0000000014867f0 c00000000291c=
cd8=20
>>  GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
010=20
>>  GPR28: c0000000011f9a30 0000000000000000 000000000000000b c00000007fc9a=
c40=20
>>  NIP [c0000000003c0890] bpf_mem_alloc_init+0x410/0x440
>>  LR [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440
>>  Call Trace:
>>  [c000000004783b30] [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440 (u=
nreliable)
>>  [c000000004783c20] [c00000000203d0c0] bpf_global_ma_init+0x5c/0x9c
>>  [c000000004783c50] [c000000000010bc0] do_one_initcall+0x80/0x300
>>  [c000000004783d20] [c000000002004978] kernel_init_freeable+0x30c/0x3b4
>>  [c000000004783df0] [c0000000000111b0] kernel_init+0x30/0x1a0
>>  [c000000004783e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>>  --- interrupt: 0 at 0x0
>>  NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
>>  REGS: c000000004783e80 TRAP: 0000   Not tainted  (6.6.0-rc1-04964-g2e08=
ed1d459f)
>>  MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
>>  CFAR: 0000000000000000 IRQMASK: 0=20
>>  GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
>>  NIP [0000000000000000] 0x0
>>  LR [0000000000000000] 0x0
>>  --- interrupt: 0
>>  Code: 3b000000 4bfffcbc 78650020 3c62ffe7 39200001 3d420130 7cc607b4 7b=
a40020 386382f0 992a1e24 4bd8c631 60000000 <0fe00000> 4bffff40 ea410080 386=
0fff4=20
>>  ---[ end trace 0000000000000000 ]---
>>
>> Presumably related to commit
>>
>>   41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation=
")
>>
>> (or other commist in that series) from the bpf-next tree.
> Actually it looks like it is some interaction between that commit a
> commits in the bpf tree.

Yes. The warning is due to the checking added in commit c93047255202
("bpf: Ensure unit_size is matched with slab cache object size").
Considering that bpf-next has not merged the patch-set yet, should I
post a patch to bpf tree to fix it ? A fix patch is attached which can
fix the warning in my local setup.

>
>

This issue is seen on Renesas RZ/G2L SMARC EVK platform[1] as well. Can you=
 please post proper patch to fix this issue instead of attachment?

[1]
[    0.283075] ------------[ cut here ]------------
[    0.283090] bpf_mem_cache[0]: unexpected object size 16, expect 96
[    0.283126] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_=
alloc_init+0x324/0x338
[    0.283163] Modules linked in:
[    0.283180] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-next-202=
30913-00003-g5734f56be91e-dirty #1044
[    0.283201] Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
[    0.283214] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    0.283230] pc : bpf_mem_alloc_init+0x324/0x338
[    0.283245] lr : bpf_mem_alloc_init+0x324/0x338
[    0.283259] sp : ffff80008286bd00
[    0.283268] x29: ffff80008286bd00 x28: 0000000000000000 x27: ffff8000823=
99a60
[    0.283290] x26: ffff00007bde74b0 x25: 0000000000000000 x24: ffff8000823=
9d8b8
[    0.283311] x23: ffff800082399ca0 x22: 0000000000000000 x21: 00000000000=
00000
[    0.283332] x20: 0000000000000000 x19: 0000000000000010 x18: 00000000000=
00030
[    0.283352] x17: 0005000800000000 x16: 0004000800000001 x15: 07200765077=
a0769
[    0.283373] x14: ffff8000823b0de0 x13: 000000000000028b x12: 00000000000=
000d9
[    0.283394] x11: 0720072007200720 x10: ffff800082408de0 x9 : 00000000fff=
ff000
[    0.283415] x8 : ffff8000823b0de0 x7 : ffff800082408de0 x6 : 00000000000=
00000
[    0.283435] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 00000000000=
00000
[    0.283455] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000ac=
90000
[    0.283476] Call trace:
[    0.283485]  bpf_mem_alloc_init+0x324/0x338
[    0.283500]  bpf_global_ma_init+0x44/0x6c
[    0.283516]  do_one_initcall+0x6c/0x1b0
[    0.283531]  kernel_init_freeable+0x1c4/0x28c
[    0.283546]  kernel_init+0x24/0x1e0
[    0.283564]  ret_from_fork+0x10/0x20
[    0.283577] ---[ end trace 0000000000000000 ]---

Cheers,
Biju

