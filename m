Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5407E64D596
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 04:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLODbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 22:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLODbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 22:31:31 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A723BD6;
        Wed, 14 Dec 2022 19:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS405RR3okvmNNkCjEaZb6DvqR99w4T/lMQPWnGnYzyhWyC+VTukgqIiNLYyAgl2wPnWrZ6RJB2ITCsR7P5dOeNNUQD+qG5Iv9c2yUYHshqwT5yutPNEMdfmnAFY35HjV22edo/M4EqQkrENa0CyAcUtch0nv4VRdj2kTLN9pzOTOEYCVRr4WVItvauXBsuNmOGGFxsNdG4BHXf5nh7lC8PGok85jhwpx+jOpYGgl4AmtTc2eJT3+jiqwXtGiU/6crGQZ5zDPT/H5lIrwcwPKTXLDgVu2NJempgGjII6d5uuMr/FEARsVmkSf23N2JnPxfp/TcQhCDMNdVbATWLpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHO3zu9MPyua5ROyUArtBGyDpEivKaV7T8167BCKlHw=;
 b=Au5TC0L0C1Jz6G/Dh+mUIklMANcSyZQb9P6UBcKPK6bTI6WckzKTDdfHQgIe9v6j5Rg2BJy5rq+pJ8yoyy+EXiHqh3xZoqHo233l2pcnt0pGUbcj11B1IIWeBXCEhV7VQwcE+kIV1uuSD/31HB6aXa9/wPIMKdVe8TbleWQ+TIVgW2tCyv7IHw7cFQ5Up1oUbOtB8++CwSuHz6gbWsKxbLCkTG2L7FvEhq3DvF2eujJ+G3EchSkied2YDVO9e5O9xMW3z1pJ4Huv/OIocyzDsmNzcCEVPnzzHY4tgdqOJmSXzt8Qq18O3ZJLZG1uchey8hy17w7ZcQy/EqFLtw2f+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHO3zu9MPyua5ROyUArtBGyDpEivKaV7T8167BCKlHw=;
 b=mkdCr2Gb0yqKvsBQvuHbqFX0krifSt9Z7ni2ZFcxvvXmmo7ij50sBGc+WbQz+6fe8sgzszz3X/zItI0rAHnSK6V/foZDVq0x045ZY3RFN8WtLwqsOMV42PN3gXBUPf6gPRT0YHcyClTahYzM6m7ggLzLPLHwa/Zr41Yl5cNZz0Y=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6069.namprd05.prod.outlook.com (2603:10b6:a03:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 03:31:25 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::ef68:2492:c1ee:7d04]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::ef68:2492:c1ee:7d04%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 03:31:25 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/kprobes: Fix optprobe optimization check with
 CONFIG_RETHUNK
Thread-Topic: [PATCH v3 2/2] x86/kprobes: Fix optprobe optimization check with
 CONFIG_RETHUNK
Thread-Index: AQHZEDW18AwsQ28s7U+Yq+RD5eoSpw==
Date:   Thu, 15 Dec 2022 03:31:25 +0000
Message-ID: <5BCC1248-FC01-4EB2-BFB2-4BBDD9092045@vmware.com>
References: <166264927154.775585.16570756675363838701.stgit@devnote2>
 <166264929259.775585.14768855667710290362.stgit@devnote2>
In-Reply-To: <166264929259.775585.14768855667710290362.stgit@devnote2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BYAPR05MB6069:EE_
x-ms-office365-filtering-correlation-id: 2a45c6ea-e4ba-4a83-08b7-08dade4cd85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zq84Rs6bZ08hXJO0X1rz1ubBo9JK95kjR4PmMwygM7DZtteBEIBGniAz2a2ERaXrVqD1HScazL0vcgnkEoN1vc+X2R2fjklfsDprrfxsfiALidAQhQgpfQDfxnhvY6Tc7YajQgebYvs+Ww30OARBNIdXNhSsjHLl+WXjEnYzHzDem2FgvKkriZzHNGSmBU9mvH51IT1qmA+frmyWga9LlPNIj+PRzv2iW2NCqpBjvqjSRvbtDhggNWdydNp7JT9LdP8o4/Qo1xKSE3UXgLUDDCAD7TxazvetY+BzsuZgYpUh1Cn5RAmiaMshOhoKgN6hA+OGanlQZ+23J3CXSeOJGTa+OgJKNKbz9+sVZivtxcbyZvWlD6o8fwXUI4hf841maosWAbrfLUTJn3mI6qMjzgEKCP+fO2jJFimZGhfkmW2ijTzr/xjrmXaFhvhhFoGt/vjTcyCKYj521JUMBiZDgoage3IN7H3LexS8qBqh6n5W77Hn4zSHEuFKVz9DwRP1yXUDArWGTDhAms4VS8cInKJETJzPYQqjVV7cLn4v7GMe8KpDNUxP7Agb0dGSwPQIHXdWbLpibK74QMF/95/nkv2AeXHll3upB9eWka/anJjp/jSslpZvVSxkpHYFMY7TtsRgQyuu7xvDDjqSTSaCB0vLAt15ILMESSdK/J1I23hXuGiUS4lzv035kfVGHvWdq3g9v81JCBGJo23WWSsuFqr2UBFs8X2t3W6WhD0wZU3fWaQcGN5ZpDBez0vitFzdlS+i1wVZEZBl9QQ46t80GzOH/2KGNlnPRM1GwJynEpg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(86362001)(122000001)(38100700002)(7416002)(5660300002)(38070700005)(2906002)(71200400001)(6486002)(41300700001)(66556008)(54906003)(66946007)(8676002)(64756008)(66446008)(66476007)(6916009)(316002)(83380400001)(26005)(186003)(4326008)(6512007)(6506007)(76116006)(2616005)(8936002)(478600001)(53546011)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q4Es3vzfxUkL0DLrjvmrkSGkB8EN7AO4GXJ9a1OcZWSy/ZUGFLv7oFQMikut?=
 =?us-ascii?Q?Civq6Wt5tqda0RYVYl8t2lJCp81PUSXfVjWOCYujV7Gsa19A71fKQdcHzQrs?=
 =?us-ascii?Q?X1QN5dNQxPxI//mIBGKgB07kuJsXMCbTp3t019DkTbhZtMqfOMNKvJfCwXke?=
 =?us-ascii?Q?PaVKF5vz7BBk+UmC8JGmnaszMQexbgf++IUuWfOAB4qLDFT48YQ+LW3z0Sv5?=
 =?us-ascii?Q?iOmKrcfunEAmIWNUYWKipaGHt40gn9IO97EbiMuYVPkJ6DxlvqXBiHSBFFBR?=
 =?us-ascii?Q?soVOXD8Kn8esOm6RZFo9un2/yvJdbXXJLkBTj6KVqkL45agwIN+UHFEBzNKu?=
 =?us-ascii?Q?M/oXdxHTgAWxmp6jUWvMEU/wlBLPuMY164COdW3OvGcWf3pSbPWBnppGt67q?=
 =?us-ascii?Q?mp37xDINRs11REbTlisqB/GM5ommk1igY5r9BBFXGHKW3cMnILetPVS4ut0q?=
 =?us-ascii?Q?8CRvjvYCttflsJX/qvDL4GnHYilkGLDXyN4eCNsg6u3YA4rT35rZ5pVw/TCj?=
 =?us-ascii?Q?eXBuBTLdKfA+wWIMjptp7UaB+JkhOZfHFvluxWZORSlByXO4nVXorZyut6l6?=
 =?us-ascii?Q?vDJ8srdYIMwywGZoaLynHfQo5K4y/kgnI2walRRDBxbqZ72Et4kBLsibQieI?=
 =?us-ascii?Q?F0dnzu54Zivhb+Vl6n8wuOCl9Be9K32VnHTQRzLpdUIka7DqCaH/WdilXBQo?=
 =?us-ascii?Q?qENGbPR3UQekiXNv7Wh1bRWLkH09nKo6q2GEQqS/DXt2hsFlBcmf3ZQ3kmsj?=
 =?us-ascii?Q?Nra5ZB3sNGJ9GQCIxkZB8LicHg6MivmHbNgLDzP/w+Ho0GECAbYUksLPFwnC?=
 =?us-ascii?Q?QpslFODtihtGwW+9YfJySk22TbqME1jcJId3lenkNNQueVkVW8femWcxrzzU?=
 =?us-ascii?Q?Ek3osfvzlqx4glaNC9ydt0NlrXYRtZ3si/yEovU7SfuJnevL0oKVOFlIzGbg?=
 =?us-ascii?Q?7EfS+brbfxoAtgcKftc+ox57p2rY6BujjucAgr9QQpVj4yaW0QDai7RmY1Lh?=
 =?us-ascii?Q?CeMjuQqbdl6xv8YdL19eqkRwMMR/Y3gbtrdVihl5Y3sJcE9cl4lN5ayV9k0p?=
 =?us-ascii?Q?zCq9POwLrkGV/kM/QvGqdlNTBY2yjRdLTxCXvGi6QQ8/wYY31JDoCa6QdNse?=
 =?us-ascii?Q?atnApOHkjKMifikpA3QgP4Xg8G4V/h6cynD+D58l1Y/L/woVSKX8KVvbFOd8?=
 =?us-ascii?Q?mZhhsIOhGGB1Q/wcjYeVUjsH4eAOlF2Ah0PE+RxjxSQ71m+Okm7d13pcWwq+?=
 =?us-ascii?Q?qPiBpA2/mDmuIpNtCmzddXyO8IhwF9xmnRO1gcbKK8lreq4c/1GWZj+ZYz7s?=
 =?us-ascii?Q?Z8wVSoD61p7JaRxajSvms8Z3sfkZchw81XeKLBeVmX9FiClKw48UiNRY9Vo4?=
 =?us-ascii?Q?D7i05MYqhuES7VhScZYTwz64Q6WRBJmGnHWqjXWJQ0EqJSIvNLFOuApdR80S?=
 =?us-ascii?Q?PI7tg/LkcLfVTsPP8MqzcasGmLj21DiS+Q9dZispC88S9JXJ3RNqlCOTyO8h?=
 =?us-ascii?Q?XeTqzv/PxWkEuqnWBE+TV2x/Er4w8KN6ruXHh7FlCPdYPFEN+91hjQowCZkr?=
 =?us-ascii?Q?mNDTGRC3iU2zcE1C39/K1ZkFNPyu7xDNN/5SCF7g?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B85B81A94E0BEB4EAC19177E6CC73BDC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a45c6ea-e4ba-4a83-08b7-08dade4cd85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 03:31:25.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Lt3KUPtpBp0IQBTBU3KToZ2mM0Gmw3kGpVxGpufPDQwfN7Tn5uve4Z5jUDaGT0P8TUW/Qqv+J+GgK1H1W+nAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sep 8, 2022, at 8:01 AM, Masami Hiramatsu (Google) <mhiramat@kernel.or=
g> wrote:
>=20
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
> speculative execution after function return, kprobe jump optimization
> always fails on the functions with such INT3 inside the function body.
> (It already checks the INT3 padding between functions, but not inside
> the function)
>=20
> To avoid this issue, as same as kprobes, check whether the INT3 comes
> from kgdb or not, and if so, stop decoding and make it fail. The other
> INT3 will come from CONFIG_RETHUNK/CONFIG_SLS and those can be
> treated as a one-byte instruction.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
> Cc: stable@vger.kernel.org
> ---
> arch/x86/kernel/kprobes/opt.c |   28 ++++++++--------------------
> 1 file changed, 8 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.=
c
> index e6b8c5362b94..e57e07b0edb6 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -15,6 +15,7 @@
> #include <linux/extable.h>
> #include <linux/kdebug.h>
> #include <linux/kallsyms.h>
> +#include <linux/kgdb.h>
> #include <linux/ftrace.h>
> #include <linux/objtool.h>
> #include <linux/pgtable.h>
> @@ -279,19 +280,6 @@ static int insn_is_indirect_jump(struct insn *insn)
> return ret;
> }
>=20
> -static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
> -{
> - unsigned char ops;
> -
> - for (; addr < eaddr; addr++) {
> - if (get_kernel_nofault(ops, (void *)addr) < 0 ||
> -    ops !=3D INT3_INSN_OPCODE)
> - return false;
> - }
> -
> - return true;
> -}
> -
> /* Decode whole function to ensure any instructions don't jump into targe=
t */
> static int can_optimize(unsigned long paddr)
> {
> @@ -334,15 +322,15 @@ static int can_optimize(unsigned long paddr)
> ret =3D insn_decode_kernel(&insn, (void *)recovered_insn);
> if (ret < 0)
> return 0;
> -
> +#ifdef CONFIG_KGDB
> /*
> - * In the case of detecting unknown breakpoint, this could be
> - * a padding INT3 between functions. Let's check that all the
> - * rest of the bytes are also INT3.
> + * If there is a dynamically installed kgdb sw breakpoint,
> + * this function should not be probed.
> */
> - if (insn.opcode.bytes[0] =3D=3D INT3_INSN_OPCODE)
> - return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
> -
> + if (insn.opcode.bytes[0] =3D=3D INT3_INSN_OPCODE &&
> +    kgdb_has_hit_break(addr))
> + return 0;
> +#endif
> /* Recover address */
> insn.kaddr =3D (void *)addr;
> insn.next_byte =3D (void *)(addr + insn.length);

Hi Masami,

I encountered a similar issue with can_probe(). I see that your
patches were not upstreamed, at least to 6.1.

So I was wondering whether it they are going to be upstreamed, and
whether you want also to update can_probe().

Thanks,
Nadav=
