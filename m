Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13E6E5D65
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDRJaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjDRJaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 05:30:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E7170E;
        Tue, 18 Apr 2023 02:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7L0MtNYN/fgYbZaD/Vqb/BLVC1F+/ByAfTDW68VAY9x+tKRIHnI/MJouC6vT9uySKy6CYPh/yk00I/blsrMEqGox2U86slplmcNUQ0/aKnVNZFNgW5wTkD+LK4njRJXQlHQrUIGDQGuh5uLU8bOWgz6tFGprjLk53Q+0yor2ANKAcC3TmbTjtBEr9lzzV0QlfH/gBW/oNJ0s6C7y2y2TJ8RvS/A2Z/mdwA0kAm6WV/Xct1JVmU9tTBe5RHEYWtSkyqaJgw86t12PE7WL5Zjof9obTVLm8wVVfUFxGskksYiX1q1/MiODZFGRfAQL+pzByULWk3m7wmY3+Jat1Ls0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ser4P2Q5CR4sqGV8SPtulGvB0KPdgYcpqMK6tnMyMVc=;
 b=hFTJBFtIDvRutMA4hwiCLJSxmXZuCUVk18ydzNgmdko4ObHB3etG63pOrEMl6XZdpx3YLHcmLA9cl4r42JXKmSGpg1pgBYQNmjzmq5flQ+gcBPPgPDTH5M6QbchHzvGsOPEKXf+6puwGp3IN24xNhNNwqFgAFYwEg/8v5WL6qoijdMRF9mEMba8QWaLnxMt9VAwJpfLj/S/GUNaoKRqRJkSQXveohyVM7L/6X/AQkBrDy4G0K0xafYKYHBBCoU0VBAHZG7fN3A97CDIqhlqQuwIpa3ok+X9+FyeUPkN6vs3yQBXeGY2vOSQTJ6DbkNTF1+5VtG0ZsJQ0N/x+SCNIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ser4P2Q5CR4sqGV8SPtulGvB0KPdgYcpqMK6tnMyMVc=;
 b=IP2QM+oi+e4DDlqG3JqU3+BnZFJ5yVrp/9pHPR1E0Z9pfmo1TsO+n59p+dC5dPeGvdQSOqKtyL/S5iacLZ+zudA63OmczLZ2MTqTMpSShNN/y/bj+B7UC+sYVvWt9EzEetZPOW99P2aeZqdD3NR88Pc+6iZsuSSYoKu91JLXqniBHSB60Fy+2jGLVZtoxCZQEOx6P5t/7yvtYBWd5L4NgNIS7ASgi+iGvJ1zwXlOZOHG+aBI9/tX2n6dSGQLs3zKW/yRVpEpeBxaTb6GRD+Sq6JmAlvGm4FLWglvrfevxXdX0EsXSuKz9GD0jIzicGYxiVpPmXIln/b/2NACmfkpiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 09:29:55 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 09:29:55 +0000
Date:   Tue, 18 Apr 2023 17:28:42 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZD5iyv20HWlhH5MT@syu-laptop.lan>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <ZDfQYHJyJOrR5pcB@syu-laptop>
 <CACdoK4JemtGV9m=kuddE4eZQgfTNj1OqhwfhLpDcsspTvfZx7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACdoK4JemtGV9m=kuddE4eZQgfTNj1OqhwfhLpDcsspTvfZx7A@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: ab11df5e-0b94-4f33-2409-08db3fef7838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeLKJqVFuFewNhmEchNP48ISPaRADpHydLG4Wzxhw5oa8ZRkDtr+dJSU7sfLSdDSliEWNamII+g+CfKqaCuP4IY2Hd1ZTLQ8RWIPHXn22UWVgM+HoOgtLVXm9baXEaT6i0orLPs5dGBBhbaM6VWIyfuKehRTJ+gNz/UxNf3Zr1Xo9BXyOYOKQ03qG7nv69+96EUBQTmyMquySPUH2WaCyMh0+ip9heJnKS2gVzsiJViYnJC8FJpw35NpmNXzaVeftLR+JuWqlnOmWGXZU4nyY1L4vrZl7RDx8dIURVHB/7q3n9sBsaq2GPmgWdjDDMWwVjRwwAMjM8GEtzWUfL5dibjAZKahkjaFO+bEOfGlhgc3hGQIFPLPiGnkG2PYt24zlCklUMHrZAfdv5Ls9TQYnjzKXbsk5cUN2mTv/KMKnldeWxZ7xJn63QmXTlYvZ5tlg9+UeUJVTwR/sxWgy72AtGYAhFRwk5c3r1UspfpqNKYzm0fNxlQZowl1gZ3KGGcX+qF1X4fhnP/AuZmAfEtOEr4l/c9GtLtkkDXI2Pl1KgqGDnX+ogBOlXw4r7G9srOcTHPvVNn0c9WaZUJc95KD6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(966005)(6666004)(6486002)(478600001)(86362001)(45080400002)(36756003)(26005)(83380400001)(6512007)(9686003)(6506007)(186003)(38100700002)(66556008)(66946007)(66476007)(316002)(2906002)(4326008)(6916009)(8936002)(5660300002)(8676002)(7416002)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBrak9tNGhBR0JQWTJvVXUzaEFlaFFpRnVEOVJyaFFJVUg0MStJemJOZlZQ?=
 =?utf-8?B?ZkRrZlpPVjZpUERocnNmbGRORmtNRHM2amN5TURnYmM2Y1BCbEpmVkxzTGl6?=
 =?utf-8?B?T3o3UTYxUTYzWXZKY3FqNHV4bmhJN1BhTG4razltbjMxUlc1ZXdKb1JOaS8v?=
 =?utf-8?B?T1l4b3B5SHZ6ZkVROGVSSmo4MjNhUGh0cmdScWYxVThndktvaFMzd2FJQURK?=
 =?utf-8?B?Ym0zcVRtRllPYmp2Q1ZGUUdVTnpHdHM0aUNFWVh1eGVFUElsWlljMXE4L3Q2?=
 =?utf-8?B?T3Z2YVpvMHJtVEhmaUFPS3lEVkFVTjV3TkFpQ3QyN1kvV2QxUHUzUUxRN3RM?=
 =?utf-8?B?YnMreW1iVTVtVjk1TW9yT1M4SndHbklSZ3hoM2QzNmFPNXMzeDFqUTJUbTVP?=
 =?utf-8?B?dG56K25HbjFuYmR5cFlINlVuRXl4bS9rbUhxdEJuSEhLcnBjeW5nY2wrZHFm?=
 =?utf-8?B?RVI1Tm8yczFhNDdQQmNXSVRtRyt6SWZ2ZUI1UGpuZjZiYXFTbGlUT0tsd2Vy?=
 =?utf-8?B?elpWSHNycnM3WFBqMzViRDNIekhOMEZUaDUrL3JXYlhoeEE1Z3RKeHZNNXVQ?=
 =?utf-8?B?dWl6NFk5dHRHdWVqdGcrNjI4RG9tTHRRUllBNGw1SmNWTXhjWjdhVktjbFpp?=
 =?utf-8?B?K0dhZHR0Zjl2ei9BektsVk10UnY0SUpHd0hGOFNzYXlLdjRVeFpycVRLVmRw?=
 =?utf-8?B?Y1EwQlBtSk42NkxoRDY5UFgxaG9BNFVCM1dNV3g5Q2ZQa1llVWxCQWg0bnNo?=
 =?utf-8?B?QjNJYS9KKzJCSmVtdElsdCt5N1JNeFRzeVU5Z1BOU3JtWFNQd2tRK0pjNnZv?=
 =?utf-8?B?R2dLTzV4Y3FJS1BVaDkrTUs5WmtCVUVBVEw4dnJyV3pPa0Y5YzF2REJLcjdj?=
 =?utf-8?B?VDRhM3ptMXFTQ3dJVzZUbUhhNS81TGh3dDBubXdsY2FaNnFyUXd3VDlrZEI3?=
 =?utf-8?B?d2o2dGg3UGt0Zlg2Y1pYN0IvVmV3UlpLS3RYSDViRlMvb2ViS1ljR29HTWlE?=
 =?utf-8?B?eHpWR3FGNFhxTFZTMWhvNVUxbmhMbTVodFZIUXFINzNvNWFQejNsWUErd0dU?=
 =?utf-8?B?L0QrZXRwVWxEeXJ3azhndE40RzlCdWw4eDZHM3c5OW9mdFQrRkkyN0JFSnJH?=
 =?utf-8?B?bzVBSTBPNjA3MEZBbGVMYXUxamN0eW5QZG1NUVpvbDJBR09Pbm9tcmo2YXhj?=
 =?utf-8?B?TTlqN01Wd05FZ2U0RnZZZk94dmk1bU90cWhSM00vVEhGSXhKNDhqSGVrRWlD?=
 =?utf-8?B?QWt1c051WDR4Z01lZVM1bHNVd29vT1hpS3Q5ODNHdjU3MTdkeDlHZnd1a1Qv?=
 =?utf-8?B?Z01uNSt4MU1OTkZxMmphQTNuMENId1FTR1FUc3Z2STZlVHZEdEM0KzA4SjJD?=
 =?utf-8?B?ay8rVGYzNWZOS1RrTDZBYU41Tjg2cDA5a1Q1VklGY2dkRDFPZFk5cXF6aHdO?=
 =?utf-8?B?NlpNamsrRU1UbVliaCtkRmZyK2daNUVXSkNOS3RWWWV1bzBlWkJoTm1LNGxU?=
 =?utf-8?B?ck1KNjVRZjVZMDJ6VUVlUkt5ay9SZlN0QzFvM2w3VEcyRFo2L3pWYlZJM1Vi?=
 =?utf-8?B?RzMzYllvdHIxQm5mMzNBQ1EzbnVqam9yT2pKb3Bpa2kycUR4ZW9xdm5WTUhr?=
 =?utf-8?B?ampJWW5wOTBZcmpKUS94SmpiZllSMVl1M2pEbThPNW1GOE91OVd3V21hVGdI?=
 =?utf-8?B?UVdVVnpPT28za0JyRHYrRkJVc0dmOUpXaFpNeXVtVHBGbE5uZGRpSUQ5cHFI?=
 =?utf-8?B?S0ZONzNMeGp1Ym5PaDdCbGlhbVhQRGZBd3NGeVhlRWwvbS9BSHVXWmt4RmNL?=
 =?utf-8?B?eFNtL0J5dWZ6YU5nanByV2cxcjV0RTRqc2FPQjNtdjMyOHJjcXBWWnpreXBi?=
 =?utf-8?B?ZFN5OXlOTXhBc1hUbnBOVkxuUVJwVCtUQVVyaU4ybXRlZHBKTWtodlpLbXRN?=
 =?utf-8?B?SFphR0hpZDRxZGpFVXJBYTYvNWVMb20zVEJPWEZRS3FYZ0NVYncwd3pIbGcw?=
 =?utf-8?B?Rzg0ay96MXZNZ1YzUWo3Q0dqSVNRM1R0N29xdVhlelg0OUM5RVcvZlN1VkFL?=
 =?utf-8?B?THEyZmIzRklvcUNSTG9OKzBzZUg0dkpwbUlsaHNIaC9STUN6cHpDSDRCaUNP?=
 =?utf-8?Q?vdiTOhUNwd6Pmr0U/iIKlsZW3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab11df5e-0b94-4f33-2409-08db3fef7838
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 09:29:55.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmVR73gcxBUeM51PLIqMEig14VaAdN+Quf8E6VYyJhfE11Qj6t6VZ1QdP2RGSc6k62yOI0KS+YGwm0fW3+3mWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 02:12:40AM +0100, Quentin Monnet wrote:
> On Thu, 13 Apr 2023 at 10:50, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Thu, Apr 13, 2023 at 05:23:16PM +0800, Shung-Hsi Yu wrote:
> > > Hi,
> > >
> > > I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > > of using the source found in kernel), but realize that it should goes
> > > hand-in-hand with how libbpf is packaged, which eventually leads these
> > > questions:
> > >
> > >   What is the suggested approach for packaging bpftool and libbpf?
> > >   Which source is preferred, GitHub or kernel?
> >
> > An off-topic, yet somewhat related question that I also tried to figure out
> > is "why the GitHub mirror for libbpf and bpftool exist at the first place?".
> > It is a non-trivial amount of work for the maintainers after all.
> >
> > For libbpf, the main uses case for GitHub seem to be for it to be used as
> > submodule for other projects (e.g. pahole[1]), and that alone seem to suffice.
> 
> Then it should be enough for bpftool, too :) The bcc repository uses
> it as a submodule, for example.

Hmm... bcc having bpftool as a submodule is a news to me. bcc having libbpf
as a submodule is quite straight forward, but I didn't know bcc depends on
bpftool as well.

> The work is non-trivial, but when compared to libbpf, I managed to
> preserve most of the Makefile from the kernel tree and all of the C
> code, and bpftool also gets patches less often.
> 
> >
> > For bpftool the reason seems to be less clear[2]. From what I can tell right
> > now its mainly use for CI (this applies to libbpf as well), which is
> > definitely useful.
> 
> Yes. At the moment, the CI present on bpftool's mirror is more limited
> than libbpf's. But it allows me to test some compilation variants:
> regular builds, static builds, cross-compiling (to some extent). Some
> additional checks that would make little sense to have in the kernel
> repo, too. It's mostly for checking that none of these build
> configurations break when I sync from the kernel, and helped me find
> and fix several issues in the build system on the mirror.
> 
> This CI on the mirror doesn't cover bpftool's features, but these
> should be tested in the BPF CI itself, so we can catch regressions
> before patches are merged. There are some tests already, not many, I'd
> like to improve that someday. Anyway.
> 
> >
> > But I wonder whether packaging one of the motives to create the mirrors
> > initially? Can't seem to find anything in this regard.
> >
> >
> > 1: https://github.com/acmel/dwarves/tree/master/lib
> > 2: https://lore.kernel.org/bpf/CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com/
> 
> It seems like you haven't come across this one?:
> https://lore.kernel.org/bpf/267a35a6-a045-c025-c2d9-78afbf6fc325@isovalent.com/t/

That has all I wanted to know and more, not sure how I was able to missed
that, my Xapian searching skill really needs more work :)

> Yes, easing packaging was one of the motivations for the mirror. As
> mentioned in my other answer, I've not taken the time to reach out to
> package maintainers yet, so this hasn't really materialised at this
> point.
> 
> CI, indeed, was another motivation.
> 
> Submodules, or simply making it easier to hack with bpftool's code,
> was yet another thing. Microsoft folks intend to make bpftool
> compatible with eBPF for Windows. It's quite simpler to work on that
> from a repo which is mostly uncoupled from the Linux tree.
> 
> Perhaps the most important was to make it easier to just download,
> build and use bpftool, for all users who need to get the latest
> version, or to patch it, or to create static builds, or to
> cross-compile, or whatever reason might cause you to compile it from
> the sources. For all those cases, getting the mirror is faster and
> requires less space than getting the kernel repo. This makes a nice
> difference when periodically rebuilding images in automated workflows,
> for example.

While for distro packaging the net benefit is somewhat unclear (after all
that the point of this thread), I very much agree with the above, this does
give users much greater control over the bpftool they can choose to use.

> Does this answer your questions?

Yes, thanks!

> Quentin
