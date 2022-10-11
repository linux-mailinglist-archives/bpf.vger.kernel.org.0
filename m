Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4355FAB75
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 05:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKDzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKDzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 23:55:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD5733F1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 20:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL+wqNS2kzORZZb4Ekfjmmwqj+NXppb+y4jMHpETC/R32AkAiLGfmjoTz3wEKO+/0sagFCnlagyZTuBB+Zh7HB/j6O55QvwXQXdb5gCcCIZt41ENQMc/kvwWkPJ0rrunJ2tRxEpd0Kdj+CpwLSIGsZ2d9DsdVxnnDzEvvSSKknMxUZ+6YkDGdmbyQ0Vv6K/MA2X6jzlBU7t9vKqOWQ8UtHzwrO7bdw9AsjFfjz1ta8hAaJyajnUyEPoyuM0w/C5qS8zsRwCqNtlPRHLjywaZxD+81sWjVVlBxs195MGcWs93Vmvqj9OvMod3okRgV2X8jpCWNzPGqTWAvZo+Kbalsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIuwtLHtBAJI+1JGcmuFz7X/J/TnMZRUHyvlnGLfDIo=;
 b=PkjHtL21ZrY+vbJxH6FlM8y2DKOWsu3Z+PebEr1RCFfXFGl8wYBkcI3rXBC9U2jxlC/iYa4v7gZ2Av9OKZ2qs0lgjJPb18luNlLoQpA1lMbzFhxzMjWan/Etpr8tODNuvnKIUgFzcZwr/sCl99teNo4/eciZT47Ws0Gs+siaBQEA6uMf7yWvagwVmga8ZiGak2lCUjvEgZXcBN88jbGJGZ5YfydfFOu/xpdcktsgsVIhwgPcpIYkduzH4Sy0NtaCyCgSZEHOroH5+t3dJX24uX2hAvR/Q0dnwfToAJGojDg08Z6xcL1HjfcN9M0ubRra5iC5mDEL+t8yjRgAH6Vq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIuwtLHtBAJI+1JGcmuFz7X/J/TnMZRUHyvlnGLfDIo=;
 b=JsxaEc5egxR8JrIZ99EtAf3ECpihFSvbssXzvZ1Za1XG6mQd5WuoLZ8smNa8BiSxWUcfI9t5NfjUfCxjtb6a0qO/izzjMLMqR2Vnn6PziMeUKdDhnTZ7Xypym+f4ldiNGN/t87tndZru7ATMp80rvw9eogF6QcdsAFNVnhFcK0VnK/jQFVvFNMI/9mXe0fbMgU+09M1WLIW0MJPYRv4O3HzXa60z/pB4hUGlYP5gC6EjQyluwOwo42dUuHhrpB0TdEzUE5n03P851RRpjGcMDtP+/9XR7uUvTYCEyn89pzFdtZ+ais4M+ymr7RNnOE4CHu9npZpcCNwRZwWN8MWtLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 03:55:34 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 03:55:34 +0000
Date:   Tue, 11 Oct 2022 11:55:21 +0800
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
Message-ID: <Y0TpKaIGL18UltHF@syu-laptop>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
 <20221007174816.17536-2-shung-hsi.yu@suse.com>
 <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
X-ClientProxiedBy: AM6P193CA0081.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::22) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b1a164-616b-4acc-990c-08daab3c724d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJQeDTNeDeb54R0FX4ti7MzV11Om4TQw6Ddxw/2LxE8Z0TlziK9pxTW8bGSx4KMjjHjadEE0a48CYx5FK9P33E3oZIyAiZ8i7Dhr1FfDGpPD9+eUp+S3ZD6t81DQvH2oy496rnFbKcCot79LfGzdhvh2EbypjoeETHCJgiQ4mGiA9PX4/PJiXZdiU2PyxRigztbTJfI7sYVgpyrC8zg3RbRLRMBjeaykMoR8RC9LQS2GuzJVqLFc9X9+siECfnMGsf4kjYR+SOSKfBzWBzISB9UAWF6Y9o+RRWzwjYPMjwIVys2aYWxwUDJvCBn+HPqMaDmxLersiZayYi3Kf/DW87WUVLnu18iMiD6JPrg4JYd7CNTYIchDjQWO095b2V44WEh/U4V+SxQ+uUeiH5QK9cDoJM+akioA6r7iwp3Zuse4YMnTBZSFW9+MZoQVJAenArKlj+MRPZPG4DHRkom/JIUk1HD6qSiTtfS3maQILEGVQo9pogMqhH5sanI+g1z7HQTfvA9RNDnEWIXs+NtVR8m+KkeA/mlKoi9T/G13eZiaSYcvLmwy0dPC683v51ecwDjbOUuKjkAsy4OuJ4svrn2rIAzyUF08AP/qZl/J5lnrAtMOkTkPsN7Waz+A8vDk483VoGnoSGCmTmP+gfNamD3ypYIVOE7gBLeNHRIpVxISeoppytIV4GNaXW/IKYKO9te2M2nNLD+ftp8c758thClfampAylNchWcwmKBpVOJLsiT4N7pM9XD8meLXEFdcEBeZMGCd1y89mJOKU1bv5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(186003)(38100700002)(86362001)(54906003)(316002)(6486002)(478600001)(966005)(5660300002)(8936002)(66556008)(7416002)(8676002)(4326008)(66946007)(41300700001)(2906002)(83380400001)(6506007)(6666004)(53546011)(33716001)(66476007)(26005)(6916009)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitJWGJuNVlKTHltK2hlcWo0b0JWNEtzNXdHQVVTRlpTaDJhUHdHSnpGUFp2?=
 =?utf-8?B?YnBiOVRFdWtlUjJ1Z25wSnBDZkVPSGM5UmxCUFpNaWs0bkdoNTdWcXVvQWpp?=
 =?utf-8?B?bFBWRDB0V1JGRklhdjFFYlk3Ni94eERMcllSZmNaQ3Y3V04xSFArWXlGVHkz?=
 =?utf-8?B?cG0xbjE3eGZWRXZVSkRXUTVtYkg5b2svME85ZTBWcG9kSHY1REYraFo0dlM2?=
 =?utf-8?B?ZDBLRWk3bXk4VWdwTEp5d3ZLWFB6VXRMNUNJYmVlQXB4OWNqajJUOC8wNFBq?=
 =?utf-8?B?eW9iQjFMRTVFaUQzVUVROFRMaHEwUjRnU0hzblljNVZNNHg3VUJ4SHQxaHNk?=
 =?utf-8?B?L1IyejVMQUc4eWxnS1F1VnNoWWVvUFN3S2NLNVdRaHdMQ1pheDNQb1p6dGY2?=
 =?utf-8?B?N1ArakRpTTlZcTlCYTRVaUYzdU5KM003N3o2Y2s0OURJVEV2YmJQY0h1SGQz?=
 =?utf-8?B?TEtaQ0JwKzhveEplZHRucmpSMDZETDJ3UFIxUWpCUDRoS0VsQ0UzQnpqSVpP?=
 =?utf-8?B?MmpKZ1I1ZGNOYWdIY005WmdmWnJyREdOTmp0Q3haTkE3TExyNmRLdUJ2VDM3?=
 =?utf-8?B?ek1mZzlFQWNrU3NHMEpiU0hGVFI4bFhTME9leWZQN3ppK2RRb2xaQ3pZaCti?=
 =?utf-8?B?Y0puRFJNNjZiTXo5YmVZZHQrMndLWndDcTZWYkh6U1doZUtCQm9OcGoyNm5T?=
 =?utf-8?B?OWpZd3c5amRrb1M3NTVZbDlEcEJEeXE5SzhJcUhuZm5BMVhxQmVvMkZybDJR?=
 =?utf-8?B?b2kwV3E2WTh2RUY4VEpMQXB0ekJpK0V0c1JiMWMxT1MvNkhkWjNnYmo5K1FV?=
 =?utf-8?B?bWo2bWpEZnFNUy82K1dWdmxoUGN0U0prM1V2RlYycXBUdzF5a09EbytUZ2x4?=
 =?utf-8?B?MmRjSDBmMFNOR2ExTjk1TFVFSmVtbzU1SEpFZ2g0MmNkWDFjNzBHK0FYeWlN?=
 =?utf-8?B?OUZ2QmE0bG5BMjdjQktIcVlSbzZ1dCtpQUU2eHZGMWdFUHc4M09YT0RQREJX?=
 =?utf-8?B?YWpwL2g0Q2VneUNBODVoa3pEVkowWDdOUUxNZkJqNlJyRVM1anBGazhmZXhI?=
 =?utf-8?B?NW04UXUzQUJlbCtQRlNYWFZzL24ycmdJamdPMlM1enozYklFcmtjT0UvelI0?=
 =?utf-8?B?RWYrMnZkNllTem5JWFB6TTExSkVBZGRCK1l0RjNnTHQwSjc5WkZLaVlsQ3lo?=
 =?utf-8?B?cFl0UlFnRWRNMlBZUFFEbUQ0d2FGMXE5UjdBUjhCYVJLZTBFNXIwN25TYkpG?=
 =?utf-8?B?SFEzVDlqQ0RVU2JTRDdmTmpHYzFZMTU0UTFtVEUweEdEeGs5MTFwcmxOdXE0?=
 =?utf-8?B?ZUsySXNUMDlIa1RKS1g5RU5rM2piSEphL3dDNytnS2pNUlJnWlhnUWYvM3pk?=
 =?utf-8?B?enc4NDZ3L2NLZGlxMmhwMFJhT1FRTE9Lc2VQSFFUbFpueURtaFZnUXgvbURr?=
 =?utf-8?B?c3RwREI0Z1lFRHIzS00wTmZiTHpFeWtCRDVTOGpFVjlkb25FSVRka1BUZnFj?=
 =?utf-8?B?L0QyNXErdSs3OFNUQTRvTnJTSGlMelVJbW9oQnU2dnlsSXRKVFZDZGRGYUVo?=
 =?utf-8?B?QW9zZ2VVMzhRTS9TRjJDdHo1RHlIVHdaV0U3UmQ5bS83ckJ4VUovS1pGZUV2?=
 =?utf-8?B?K2VjVkRVR0w3Zzd1WWJDVVVkdmNVMndVSEx2T1ZHaHRDekZpVzJyZlRVSTZj?=
 =?utf-8?B?aWk4SzhaOUhpTEMwQUNpVDdTVXVWZHd0VFdXY0lJa1JlNW5DMUhhKzFaK1VS?=
 =?utf-8?B?cE1aZ05RVEZyYXk1RWtBYkNlempBNjd2Rm1SQUVTZmdPbmVXU3B3SzVhOE11?=
 =?utf-8?B?YlZ4MmtOc3dIZ2VTc0M4d3l6NXh3cTBJTjJ2OFFENWdST1JLSFZGTDRQNTh6?=
 =?utf-8?B?M3RnNGVnZndtNTNNd2w1TGM3V1pBL1g4NTRDNVZobzJGWjlWMk45VlpDelEy?=
 =?utf-8?B?MVk4eXhTcE5xRXFPUzVYTHhMcmNJKzF4dkRHU0RvamNraDlOMEZPNER3SFpm?=
 =?utf-8?B?eUw1Z2ZmT2JsYTBzbU5KWTF1eE0rd3hXL2p6dDc4azI1VzlVMkVHMUY4eEJF?=
 =?utf-8?B?N1FocTFnemlvU3VQUGd1eEhiS3RNQ2lEMXdvVGdRYlcxKzc5OFVaWFF1NDZi?=
 =?utf-8?Q?59EnAm5ssp8TkJJlNiPXgqDUj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b1a164-616b-4acc-990c-08daab3c724d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 03:55:34.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ42kgqDe+Q4iXTV6cvmhdUxkFksW8rCUg6vg7qiuG/8aUN9q+yl6Kg1HO3zu8NbNi0UIJGmSBKRpr5R29yAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 10, 2022 at 05:44:20PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> > oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> > reports are incorrectly marked as fixed and while still being
> > reproducible in the latest libbpf.
> >
> >   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
> >   libbpf: loading object 'fuzz-object' from buffer
> >   libbpf: sec_cnt is 0
> >   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
> >   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
> >   =================================================================
> >   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
> >   WRITE of size 4 at 0x6020000000c0 thread T0
> >   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
> >       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
> >       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
> >       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
> >       ...
> >
> > The issue lie in libbpf's direct use of e_shnum field in ELF header as
> > the section header count. Where as libelf, on the other hand,
> > implemented an extra logic that, when e_shnum is zero and e_shoff is not
> > zero, will use sh_size member of the initial section header as the real
> > section header count (part of ELF spec to accommodate situation where
> > section header counter is larger than SHN_LORESERVE).
> >
> > The above inconsistency lead to libbpf writing into a zero-entry calloc
> > area. So intead of using e_shnum directly, use the elf_getshdrnum()
> > helper provided by libelf to retrieve the section header counter into
> > sec_cnt.
> >
> > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
> > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
> > Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
> > Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> >
> > To be honest I'm not sure if any of the BPF toolchain will produce such
> > ELF binary. Tools like readelf simply refuse to dump section header
> > table when e_shnum==0 && e_shoff !=0 case is encountered.
> >
> > While we can use same approach as readelf, opting for a coherent view
> > with libelf for now since that should be less confusing.
> >
> > ---
> >  tools/lib/bpf/libbpf.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 184ce1684dcd..a64e13c654f3 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -597,7 +597,7 @@ struct elf_state {
> >         size_t shstrndx; /* section index for section name strings */
> >         size_t strtabidx;
> >         struct elf_sec_desc *secs;
> > -       int sec_cnt;
> > +       size_t sec_cnt;
> >         int btf_maps_shndx;
> >         __u32 btf_maps_sec_btf_id;
> >         int text_shndx;
> > @@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
> >                 goto errout;
> >         }
> >
> > +       if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
> 
> It bothers me that sec_cnt is initialized in bpf_object__elf_init, but
> secs are allocated a bit later in bpf_object__elf_collect(). What if
> we move elf_getshdrnum() call and sec_cnt initialization into
> bpf_object__elf_collect()?

Ack.

My rational for placing it there was that it's closer to other elf_*()
helper calls, but having it close to the allocation where it's used seems
like a better option.

Will change accordingly and send a v2 based on top of bpf-next.

> > +               pr_warn("elf: failed to get the number of sections for %s: %s\n",
> > +                       obj->path, elf_errmsg(-1));
> > +               err = -LIBBPF_ERRNO__FORMAT;
> > +               goto errout;
> > +       }
> > +
> >         /* Elf is corrupted/truncated, avoid calling elf_strptr. */
> >         if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
> >                 pr_warn("elf: failed to get section names strings from %s: %s\n",
> > @@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> >          * section. e_shnum does include sec #0, so e_shnum is the necessary
> >          * size of an array to keep all the sections.
> >          */
> > -       obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
> >         obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
> >         if (!obj->efile.secs)
> >                 return -ENOMEM;
> > --
> > 2.37.3
> >
