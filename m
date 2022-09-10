Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9C5B4812
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 21:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIJTl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJTlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 15:41:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0796422C0
        for <bpf@vger.kernel.org>; Sat, 10 Sep 2022 12:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu+Hm4NHoPrmYIdfLSBMgOOd0PiPZPTYpBXJeGvOLErtFFkhlzJf2iYw6pl+akmWLg2zZIMgAD3+ePCEU1ZEKpiXfd2gFxxBAzWaGIOFi95iTqlLOWiEhUbd3uYI/Ps5uijGZfv2/yPCNJbaG6tWzBt3lFR1DXAj2RSmkK+l3gE8mNhIupKWW4MRdUfFjncSD1vfiSRTEt2nM1QElICnlsggPQtNH+b/XUcRN192N5MqaqPBcd4hRhZV/xKI92HxkuSDEvAMwGZAaQM0xkAeDRxS2rr8tXC35EjCzS0zlZIw5pxd4//U+d4koS/o3/ojNmUNwrddjLW+BMonjYWkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVRByZLN6Qao4LnEyrfyQb9y2nwnQYlcgKFUmygV2z4=;
 b=AaSQJUCauJmanrDYbRgL0bw+WuF8X+vT5J5AV7UqKYVoc9UrWwOYrScC108Ji8zgV88YSGW/R9i4hzRmGetRXs9e34ekiPg2ZbaR2aKH2qbS5nMOkbjvl6f1d81cC8t50+O5nQrwqX9A1Vv+D+/Qto5Y9OpKHTYmnCYgJPKPo6UgMNJpmxHXWW7Wwi2L+bAH04E6IwliLASmVv6C53luR2TASwW+01oV0Tp974TBXZl7PDQBGPbWL/VcXITdtdNATB4O9b2BBkUHICnIO/EnRtG9/5GjzCxrn42MBrMDqaL0RaMiy736WE8AvGroekn5SbkOJYQj8U5sY6i6yxscmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVRByZLN6Qao4LnEyrfyQb9y2nwnQYlcgKFUmygV2z4=;
 b=cdQQQXnCl9oq4TocqoatzOZfOlQoC8o5uiXGyrjUHUePJRqDzo3SffVKeULudmKxRmCq/42R43aOsP8c2iAegArd0wAsoe3yH1Rf61XwyTHYBdUmWKSI/YbEd6YpiCu0S/A7TJQGhS8UHUp9fMg9mSb+KfWkM0XdMY9FpNmXyWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MN2PR13MB3973.namprd13.prod.outlook.com (2603:10b6:208:267::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.7; Sat, 10 Sep
 2022 19:41:21 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Sat, 10 Sep 2022
 19:41:20 +0000
Date:   Sat, 10 Sep 2022 21:41:14 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next 0/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Message-ID: <YxzoWn/mbIUD2cTj@oden.dyn.berto.se>
References: <20220906133613.54928-1-quentin@isovalent.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|MN2PR13MB3973:EE_
X-MS-Office365-Filtering-Correlation-Id: f97aff60-0e26-4a19-debf-08da93646f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPSwveK9j75W9ZTLc2EVdbdhRAdmNTnsKgdmztF3HFFS+fOo/uGCMzNGkG3wgeOQYhoUyG5eUodZDkV0Oa4+kJSYYrxY1dAjaHhikQGEnqVmERoTlNIkviz9r1dUjKjaOxiCemdenIlZvODd53CzouMod6xpjuKWZVJkMiPwex/3lIhBPuHILfN//qFhc6tD/f9/sEPYaqef3Ed/ZZwNDSGfx7jDQuleu4r5eKECEbgI3sQwONiqx4jUKbLzrZJphwsljT86mRHEc/Puo/SDMnvC8bl8ltl8ME1CpHxs6DwSLl8NqQSWxxl+LE3VwfUSVvQYiltIyn4iPFfFw3shMzdoO+eJ7CMEak/6ACde2vT0Kumvd+Rxwj84fmdHiJbDJmjZu+Wc16P19e+AG9hWRZQuQ1wizWZs4WmJq+nn6uF5EHmAGVUNiUBb2qSkDacWxQ41e4r0cEKVNEIR1xQh8QIuQoe5MYJziFbvbre27g4gh6sQjDWzooUt1omcDyKdlIn4JJ57hEWtY27o+ekFZjq35dGYK/eOKXa03yvHAK4Jkf5t4+GkdqPWD4002WnqPko+Mvwk+0nrWoNXotdAu9Cxi6NcFg50DLZPXdHEDjQqR8b4ZyDF0WiaWaRKkfzEIbdB38BIQbBVH6dbTLWVgOb69C6RMS6L5ljtu1QmCycE0FKp1iZ7uRyO8OJmWOBSWBhGUBY/ZBIDkdlhX7gl765XG0WswMCzNiYjIz9VgCc5vS5uA7JGSiH7w60s/EUlfCx4DCOAZnJJmRzyvFnTawJs7CVmHLD2BnSf4gG8BHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39840400004)(396003)(136003)(366004)(346002)(316002)(6916009)(54906003)(8676002)(7416002)(8936002)(5660300002)(38350700002)(4326008)(38100700002)(66476007)(66946007)(83380400001)(66556008)(66574015)(41300700001)(478600001)(9686003)(52116002)(6486002)(26005)(6512007)(6506007)(53546011)(107886003)(186003)(6666004)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?etKq8a3gRGH/aqGj+6TFk5lW0OfwOaLjinvDJzurV9I4q1I4lomOQrH1Uo?=
 =?iso-8859-1?Q?zvwUPvtKGZWFXcDHwATx0M4LZ5LhuM1Lnd3snn9ho/UeTtmO2MuzdqwRHA?=
 =?iso-8859-1?Q?9u9EDPM0bw2bd7nzSIUQfbXOxxhj1wreCr0P7EYr0o03gsVcpK5CfMkvWn?=
 =?iso-8859-1?Q?VeeSKlsi1PL87PgvYjzVH+ysEjSksPNdBl8w1hN4VWIS9LmWEy6qgOTiOn?=
 =?iso-8859-1?Q?KDfVM5TZ02x7bq8BUR5pcADKEYD8cpODsnUPtt18/ZR0MJYE52kp7g0qdj?=
 =?iso-8859-1?Q?8vwLo12Pdf359r91cayfBYFrR+4lWKLuQIHV4ezk1Es0mnkWYFDb25/PaH?=
 =?iso-8859-1?Q?sdzbMICqbwHbCqhDRGDIKrwHKmXesFTJMhMmMAkXx5D5CHLl48Nt3orour?=
 =?iso-8859-1?Q?4pYKyHDSaqv04jFx3vpqIpEiPX5D3+z8x2B/s8w6vhTX9ybshY63OQCFtJ?=
 =?iso-8859-1?Q?cPVJE+UUC0OplgvGzf/qCc9hgqV61tTI3EASJhTfrAg3FFYDDqDA6IdPA5?=
 =?iso-8859-1?Q?TsWfzsjzfruo4oFD2zOwsSox0JEBaLuFmAr/TrZFykWImFH8pr3OdbH6r3?=
 =?iso-8859-1?Q?g+t7qvkTULZYo9G95Jq5EFm04vHUuGryzAQUsicLf1tHY+M9WoajjmnhhI?=
 =?iso-8859-1?Q?Hw3A5pcHhZe9Jw9v5vcv+fEReWkhE53tvd4LaID5R0oAj0p773XBAKqWBz?=
 =?iso-8859-1?Q?1iwB+mRdgeUHPMkvnSBwD3ZedllPp7au+zelB5xmbB6qoVA8nwp3suBfIZ?=
 =?iso-8859-1?Q?oDPPDFriuwLHek7t6thdIWqRwVGzS+rTSTLadthN3Wt50IoyhNMsqItHZz?=
 =?iso-8859-1?Q?IGgjOQO05QiHmH6jsHofQvdDJgvJCQ80W8pUqfUPr6lrDy29ruD/POv2f9?=
 =?iso-8859-1?Q?X94LpOPi6/3PkKmizk2rPAjhUMqDq7OtASHEPYgdhXuo9ZVT4AexNDL3m7?=
 =?iso-8859-1?Q?iJykkI7SKXM9bNzzEivAM6dQ3vQMDD9bIgQCorS4PS3+20EOfmVGPff0oX?=
 =?iso-8859-1?Q?5/RLmbRIK9DCxKbP3QhEcEyOKjAB5D3Wumxy3Wg72aOf6vBVF0amRlpTaU?=
 =?iso-8859-1?Q?e3CGwJ2ykLyswAfW29nP/hs501OIjbHA/TGcQAIJ9cE/iGe/JEyxW1gCxO?=
 =?iso-8859-1?Q?9f51t1Z3JDJrh3ClR4ETsA4Scm5N/C2ZuGiWKDJhb7l4zjYxNrKFt7R4P0?=
 =?iso-8859-1?Q?Wd7qJqUJ9rDh9W3fYZhsI1KbHrD830RUer6puOKRlhXG9tRFiu/62lwFTM?=
 =?iso-8859-1?Q?pyVCCnf7NQhJtQyLe8hZorRe6JtfCV6SZ6PN+kyOK8Y79Zaypp9n1HHZWW?=
 =?iso-8859-1?Q?Je/g/n/PjhgVdqGymhEwO/btwyhIemgKcyuKIfXLUJ97TbvHWGenvATMfL?=
 =?iso-8859-1?Q?AqRArdxHm8TFexy3M+H5aPTsCQGb//wnTrZcei63CPsdP8UXu4jw/o/zJH?=
 =?iso-8859-1?Q?p0U9ni7brgpf+2/rB7WFIMMiq0rlsLP0Vp2ZgaSabDXF50f6XGR5oD4Ix3?=
 =?iso-8859-1?Q?ao5858eP1XTRXX1TmGEAUOCxnncB6sCjnjj7yup5UCT1PolA+fmZJqTXZU?=
 =?iso-8859-1?Q?l9ajv9pfZvS45VQON66WJJHmYAUs0NBQmiQqSwHYSJJfoQppyUAHJkmAne?=
 =?iso-8859-1?Q?uFKJa0xVg3W5/962KnsZ8M2Sn6fWwglR5vBQtldsJYV65Oe7zGAmTlbg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3973
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

Thanks for your work.

On 2022-09-06 14:36:06 +0100, Quentin Monnet wrote:
> To disassemble instructions for JIT-ed programs, bpftool has relied on the
> libbfd library. This has been problematic in the past: libbfd's interface
> is not meant to be stable and has changed several times, hence the
> detection of the two related features from the Makefile
> (disassembler-four-args and disassembler-init-styled). When it comes to
> shipping bpftool, this has also caused issues with several distribution
> maintainers unwilling to support the feature (for example, Debian's page
> for binutils-dev, libbfd's package, says: "Note that building Debian
> packages which depend on the shared libbfd is Not Allowed.").
> 
> This patchset adds support for LLVM as the primary library for
> disassembling instructions for JIT-ed programs.
> 
> We keep libbfd as a fallback. One reason for this is that currently it
> works well, we have all we need in terms of features detection in the
> Makefile, so it provides a fallback for disassembling JIT-ed programs if
> libbfd is installed but LLVM is not. The other reason is that libbfd
> supports nfp instruction for Netronome's SmartNICs and can be used to
> disassemble offloaded programs, something that LLVM cannot do (Niklas
> confirmed that the feature is still in use). However, if libbfd's interface
> breaks again in the future, we might reconsider keeping support for it.

I have tested the fallback method for NFP and it works as expected and 
one can dump the offloaded program. I know there is discussion about the 
output format of the LLVM path, but for the whole series from a NFP 
point of view,

Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>

> 
> Quentin Monnet (7):
>   bpftool: Define _GNU_SOURCE only once
>   bpftool: Remove asserts from JIT disassembler
>   bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
>   bpftool: Group libbfd defs in Makefile, only pass them if we use
>     libbfd
>   bpftool: Refactor disassembler for JIT-ed programs
>   bpftool: Add LLVM as default library for disassembling JIT-ed programs
>   bpftool: Add llvm feature to "bpftool version"
> 
>  .../bpftool/Documentation/common_options.rst  |   8 +-
>  tools/bpf/bpftool/Makefile                    |  65 +++--
>  tools/bpf/bpftool/common.c                    |   2 +
>  tools/bpf/bpftool/iter.c                      |   2 +
>  tools/bpf/bpftool/jit_disasm.c                | 244 ++++++++++++++----
>  tools/bpf/bpftool/main.c                      |  10 +
>  tools/bpf/bpftool/main.h                      |  29 ++-
>  tools/bpf/bpftool/map.c                       |   1 -
>  tools/bpf/bpftool/net.c                       |   2 +
>  tools/bpf/bpftool/perf.c                      |   2 +
>  tools/bpf/bpftool/prog.c                      |  17 +-
>  tools/bpf/bpftool/xlated_dumper.c             |   2 +
>  12 files changed, 291 insertions(+), 93 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
