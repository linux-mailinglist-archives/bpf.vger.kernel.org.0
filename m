Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BC5FB668
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJKPES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJKPDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 11:03:17 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26F9836F
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M38T5KZbSed3aTmeRc4J5f1IDc2bCGKKHjZtVlp8mSv1i+wVLd9yMsVaH9hdGBXcymFgT56OAUDboh78VD8tcHjngiCRWHUXM5ifDfG591z0PFjHqXhNKCLAVDSFz4h9BTMV4FOgoJIaQvCtHNgaAL4HFnaOIGek/MTSXNyWf6V85Ph8OE+AgGqwDi62zj0v/+0icpo4271/6OVWAwAUOtfhYTYQfzF9kJbCxquSLlZYsPtxAv1G8EDtEoVQuYLw2DaJj3o7Je0iWuwJxcZbuh5OffbWbpJe9n9eR4ce3bc9IPSGn5PzQGmDouH1/0VOwyKA/hR3x19RZkHsjYvhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+gCgN1yx2hZKq0rkkTeAJXJlJjX32STZ1H6A41DBa0=;
 b=ZXct5OhHwZ1ejs1lP1QVayV5TVIMeiwqiyoe/gxQeUMKFETXuYnXfW3uc/EG/HwlPJPG2rdDv6PAVLNcMGmRrGnCOHAqlzgbzJse6Z8X84pfoOgq+75SNzmM9ELnF4QPxM63aWug5dmid7QW60zckuScjWzbf+oB2SCQMNZhjk+XHwHZwZtjoLy3PiittKz3oPZnyBW/YomwFDLqY4ARyYxr1BHa9/XYqZ3li+9Ytk0LcOJ9QEFlqO6Sm97jCowIdKJxzxNvXiDnaPbQJYmEOQEu3r0CRdIjogVEXtxuQsSfbbQnO1aGevR2OM61gseVAlVTq6UPI2cFBhYyv0X+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gCgN1yx2hZKq0rkkTeAJXJlJjX32STZ1H6A41DBa0=;
 b=brtDrDeAXlGwzJwYR764KWdL6VqiicLsa/VzOwUbrWEudhF3Oia03J+swST7UMI+171PSGcNRsTHVncLpaVaiWTHkS2MWNQyM7sGInJU0inQbUdQAjnlGsA+ypY2CJyW1Gy5oGZdmG5v1asME/Yl427eAhvBCFDxrxrrrj1gth997OcKwrAL0T1XahFj9wNi3AgiCs+2l5cFMS5EoOgMb32iOFgAYF8z3hT/CgXyS4a7RABFj3YCFOFahemJLMk1W3XyTr2aJnzX142m4PUQ4n3YKpLoDqwsBPSWTlNGFqOMwYDkwru8jdzv1e0f6viz8QJzAPa+AQmoiuMGzi4CEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:53:45 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:53:45 +0000
Date:   Tue, 11 Oct 2022 22:53:37 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf 1/3] libbpf: use elf_getshdrnum() instead of e_shnum
Message-ID: <Y0WDcdQyxkYuQVXq@syu-laptop>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
 <20221007174816.17536-2-shung-hsi.yu@suse.com>
 <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
 <Y0TpKaIGL18UltHF@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TpKaIGL18UltHF@syu-laptop>
X-ClientProxiedBy: AS8PR04CA0150.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::35) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: edc863fa-b995-4420-6376-08daab986531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAv4TNeCmnhQ4yE4Z/wEqP4SszHWPp0U0YV+oB1lveDf2Mhe/L7i6OUB2W4QCoi5F7dcdq+ogXWsEDq41+t3Zu3iHnSkIY1B2sIMx5tT/QXw5+fBOfHuxqhnAD8Edwi8r3V+9YjujSPlhXFycU6Vr+q+cvSjgGhqbjFiODGIc7kYPeWh6SQOOThFOlNqaj48LgMq6torvEff1LOvU3W4qXOE4MMrBLnldCK60WxVdEHFrSaGrWwOhhLH7IXU6cUgCaolon0NVWbsWpNTJtTWFyHKh78OtOEXAazRVfu5D7RRhTMfRWQNgZZg4mD3yktatXds7/ohsRrmDwei7LyVe5BEhI5Cc4/agDNJBLjHPom392540kp/8zCllRz25Toj9ULBj8q91580alMyaTwHfsuRsJiMozabaQF9kyidmkssRpXD2TTHxUChKKskAfGkycZWGrV8UGrN5J8iElcedUIy+dG0g2W7+fIql51aA0205KfKq/Igy5VVKXlBI26LrnBQ2ICpUAMqDEvqVyQ8pJr5+7F4W5HtE+Xw2o0uHULMxjGu3ezi5EEN2SHhQuMaKBLfx270JUKUhScNmSRcT2mg7hmwsMU3mopd+i0AmoEgFuWoxWk3zhqmOIHGwh+xNM5CXcFu/VibWWdU4zWffIN3DzHbHZV+fFCrhdFao/eM9+VxgiHfNASXZMfFnDHTdHIyOBqNHQ2S6gPUJT1BOBwBKMO0i8IzWbZ5p76n0QMf4QThHqmCUACH9xwIEnVWp0gFT5/s7RV2jEYdwCVu4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199015)(33716001)(6666004)(6506007)(186003)(41300700001)(8936002)(5660300002)(86362001)(2906002)(6486002)(966005)(478600001)(38100700002)(7416002)(54906003)(9686003)(6512007)(6916009)(83380400001)(26005)(53546011)(66556008)(66476007)(8676002)(4326008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJyZElCck15M3FmLzVUL3JXNjEwNCtDclMvTDNWRTg2ZHJwamd4LzJmUG9E?=
 =?utf-8?B?YkMrM0NBZFdweDdLaGdKdGdsWVlQS3psV1ZweW1Tb0lkN3pOSmdHQjB5UUNH?=
 =?utf-8?B?MVZpaWtwU0hYTHk5a09FS2tncDF3VzlxUVNnWEZQM0VlYlBUN0FWYk1FMkVT?=
 =?utf-8?B?Z3A0WjNJMGlLTmVISStTWURCTWQwUnFGSGx3MXpJbk1uTHdwbGJpNFVwdTJJ?=
 =?utf-8?B?K0FYRzJSVnB6Z1ZUVlhEczFucW81aHI3c0l6M3dxOG5ydmE2SHgwWDVvd0Fm?=
 =?utf-8?B?RWh5RS91bVV3cVo5WFNOVjNpK1Y5YTIvNmVKSnJBakxDN3dYbGQ0Sk5xdGRi?=
 =?utf-8?B?NjM3eHUvUnhuY3R1NEtsYVZteUYwZm85M3JrYVViU2c3bGl6RDRLdGZWNkNq?=
 =?utf-8?B?VThLVTYyZDdmV3N6TTJuZHlnVS9yT0l2UmJ0OGZZekNVY09PUi9nVVhUdGZo?=
 =?utf-8?B?aUU2c2FrekxKaVhVdDBVTDVJN1dtTDNsZDZwalRzRXdyL01LWllRV2pmY1FR?=
 =?utf-8?B?RHVRM05zUzA5N1hqK0pKTDBvbHlwV0xUSTVzQk13eFRtOUpncC9zZGxuZDdE?=
 =?utf-8?B?cVlpOWR6TXJlWURhL2JOM1hoZXJnbE8rUFd1ZkdJYkpjcjVnRUdWRk1tZ3Zl?=
 =?utf-8?B?K3ZrRnJObzZNbkR2WmttZUM0VnQ1b0hNbElodVVvanRXMStxOG82a1dqaTBx?=
 =?utf-8?B?TGhFSXI3SXBiVVNBQzVuR0pReCtMRHJpdlpodjRPWk9iK1ppdUluTTlRWHpZ?=
 =?utf-8?B?YmZBV1pGNU5FMlNPRWRnVXFaakVQMVZNV3VvRGFmOGZRTG9EYTFiN0swV2VM?=
 =?utf-8?B?UVBwZ3JQc0cwR2lNbEtwZVozZ1BHVTNHODVZc2N0Ynh5MGxTZDB2ajlHWWNG?=
 =?utf-8?B?eE1QS0U4SUdPZEcyM09YTnZEdFJFclpLb2wyOS8vaVduTEJ5UTViR011U21x?=
 =?utf-8?B?NnU2amowcDNvUjZIVUYzMFNMWGZuM25rYmtpVE9QQVJOWXZOM0dvQWpHWkR3?=
 =?utf-8?B?c24vbE15MVdOek90UGREUkR5ZThuQ1hTbjhFcTJWR3pXVm44endMUkRJQXI2?=
 =?utf-8?B?Y3p6ZTZ2WW1mNVc3VDNkMzNQYXVlQ1BJL3RKU21ySDFwdUpjYTBKaVAvVFRw?=
 =?utf-8?B?MGprTnZ4Y3ZnNnpneGdvRkVSWmZTa254UnBIRXZsUkxnYUZweXM5OVE5bzly?=
 =?utf-8?B?U3RXZkFubXB1dHdVNWxzWCtkazIvdldzSFh1MVdsU0VvazFPZHBHT25Jaytv?=
 =?utf-8?B?aHRFcXk3citWbGwyMG9Id2U5MkFRcWpIenh0NmpSVkladEJmcmxWZ24zdlNu?=
 =?utf-8?B?VW9YUFBwZWxPUVM5VEg1aVNVejluVFVpZEtSZEY2U3R3L29scWRIVGl5bzgz?=
 =?utf-8?B?eEJFaGw0alBrZUNzK3pnREh4UFlkTGQrMDZub3djcXNYeFBMV2JEVUJJa1lt?=
 =?utf-8?B?QjJhRGlseXpVNkVWMHdDeCsxc2tGVDZlOUFmZ2Vxc3VMSDEzUlRIWmxQb1Bh?=
 =?utf-8?B?L0x1NHNORFhSbWtmaGRGZmRhbGo0cXhlV3VzYk81RHJqbzdLQWpnY2NXOCt2?=
 =?utf-8?B?Y0ZtNEFPUk5RZE43b3RLNGpxVDJ0S1NSUVZFZGNUWi9NWmJhbEFHdUVFUXo1?=
 =?utf-8?B?U1VVMnJaZXBaOUw2VW1EalpXK09ROWxmbzVGWGtOZEc4K0VmL3hhZWw2TTJm?=
 =?utf-8?B?dlZIRUxPRnFvNWxUWjVvWkdIVkt4S0xwVkYwWFFIVFlIQ3NpSUdxU0J4d2ZP?=
 =?utf-8?B?bzlYTGVjS3UyczVVSDFsNHh1S2JIOHBJdFMxWXFsVHJUMmxXWms5aVpHekRp?=
 =?utf-8?B?dDI5RTRxM1A0NndWK2xiYUVPVllURXo2ZUl6bzFoaEZGdk9xNjFUZUtjeFBF?=
 =?utf-8?B?QmZUMEd5OHhsbXVwOW1BQnQvWXNyeTlHMWxKS2I0VVVMemVXWWZTODhoeE5S?=
 =?utf-8?B?Yy84VkNvZjFnTmtxWjhlMlQ3cjREOVBUbmIwd2hKaUluVEJtUHZPRll4N1pa?=
 =?utf-8?B?YXhRbjJDcUEzQzdSRXRYcXhHalgyNFZUbEs0SWFQMUFmclZYdXdUZU54dkNx?=
 =?utf-8?B?OXZIT0kxazRYN3NqVFpDL3hnQVJWYjNyTFBxZ2F6cHZpbWI0R2hTT05SMmYv?=
 =?utf-8?Q?WKaUzpVehWuC6kgNWkQ6HEnUE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc863fa-b995-4420-6376-08daab986531
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:53:45.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWHzZdI3c/F0j9FeQcpr8iQiYmeeVgdXuFJzVevAaOQebmMw2qNfmxKuLOPCfIcQw7bLYkFefBjj5Z+PFJbv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 11:55:21AM +0800, Shung-Hsi Yu wrote:
> On Mon, Oct 10, 2022 at 05:44:20PM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > >
> > > This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> > > oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> > > reports are incorrectly marked as fixed and while still being
> > > reproducible in the latest libbpf.
> > >
> > >   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
> > >   libbpf: loading object 'fuzz-object' from buffer
> > >   libbpf: sec_cnt is 0
> > >   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
> > >   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
> > >   =================================================================
> > >   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
> > >   WRITE of size 4 at 0x6020000000c0 thread T0
> > >   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
> > >       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
> > >       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
> > >       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
> > >       ...
> > >
> > > The issue lie in libbpf's direct use of e_shnum field in ELF header as
> > > the section header count. Where as libelf, on the other hand,
> > > implemented an extra logic that, when e_shnum is zero and e_shoff is not
> > > zero, will use sh_size member of the initial section header as the real
> > > section header count (part of ELF spec to accommodate situation where
> > > section header counter is larger than SHN_LORESERVE).
> > >
> > > The above inconsistency lead to libbpf writing into a zero-entry calloc
> > > area. So intead of using e_shnum directly, use the elf_getshdrnum()
> > > helper provided by libelf to retrieve the section header counter into
> > > sec_cnt.
> > >
> > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
> > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
> > > Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
> > > Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > ---
> > >
> > > To be honest I'm not sure if any of the BPF toolchain will produce such
> > > ELF binary. Tools like readelf simply refuse to dump section header
> > > table when e_shnum==0 && e_shoff !=0 case is encountered.
> > >
> > > While we can use same approach as readelf, opting for a coherent view
> > > with libelf for now since that should be less confusing.
> > >
> > > ---
> > >  tools/lib/bpf/libbpf.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 184ce1684dcd..a64e13c654f3 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -597,7 +597,7 @@ struct elf_state {
> > >         size_t shstrndx; /* section index for section name strings */
> > >         size_t strtabidx;
> > >         struct elf_sec_desc *secs;
> > > -       int sec_cnt;
> > > +       size_t sec_cnt;
> > >         int btf_maps_shndx;
> > >         __u32 btf_maps_sec_btf_id;
> > >         int text_shndx;
> > > @@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
> > >                 goto errout;
> > >         }
> > >
> > > +       if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
> > 
> > It bothers me that sec_cnt is initialized in bpf_object__elf_init, but
> > secs are allocated a bit later in bpf_object__elf_collect(). What if
> > we move elf_getshdrnum() call and sec_cnt initialization into
> > bpf_object__elf_collect()?
> 
> Ack.
> 
> My rational for placing it there was that it's closer to other elf_*()
> helper calls, but having it close to the allocation where it's used seems
> like a better option.
> 
> Will change accordingly and send a v2 based on top of bpf-next.
> 
> > > +               pr_warn("elf: failed to get the number of sections for %s: %s\n",
> > > +                       obj->path, elf_errmsg(-1));
> > > +               err = -LIBBPF_ERRNO__FORMAT;
> > > +               goto errout;
> > > +       }
> > > +
> > >         /* Elf is corrupted/truncated, avoid calling elf_strptr. */
> > >         if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
> > >                 pr_warn("elf: failed to get section names strings from %s: %s\n",
> > > @@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> > >          * section. e_shnum does include sec #0, so e_shnum is the necessary
> > >          * size of an array to keep all the sections.
> > >          */
> > > -       obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
> > >         obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));

Looking again I realized we're still allocation one more section than
necessary, even after 0d6988e16a12 ("libbpf: Fix section counting logic").

elf_nextscn() skips sec #0, so (sec_cnt - 1) * sizeof(secs) should suffice.

  /* In elfutils/libelf/elf_nextscn.c */
  Elf_Scn *elf_nextscn (Elf *elf, Elf_Scn *scn)
  {
    ...
  
    if (scn == NULL)
      {
        /* If no section handle is given return the first (not 0th) section.
  	 Set scn to the 0th section and perform nextscn.  */
        if (elf->class == ELFCLASS32
  	   || (offsetof (Elf, state.elf32.scns)
  	       == offsetof (Elf, state.elf64.scns)))
  	list = &elf->state.elf32.scns;
        else
  	list = &elf->state.elf64.scns;
  
        scn = &list->data[0];
      }
    ...
  }

What do you think? If it make sense then I'll place the sec_cnt - 1 change
before the current patch unless otherwise suggested.

> > >         if (!obj->efile.secs)
> > >                 return -ENOMEM;
> > > --
> > > 2.37.3
> > >
