Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9C5FBEF7
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 03:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJLBur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLBuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 21:50:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD780A3445
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 18:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC/33qSX0KH/ROgu8uDDRrqQYKTLp6eI40hv7mDRDkfSIxhTjBg2rPqMSouBLwPKcsA/2/Kqn83dBBq7b4HXFIwrr3+e1MVn/pvk0V69xvzLnpjFbrcA5KRxu+vi75yBDv6tcaDNOuTO7E0RKx2U/wRglzD5C7yJ02lpNSwf6D3/jjhkgLJunhCQtrOUxhC7c9cQlEoeD2FEvBBMfY2Dt6baFiH3aI8QBM5vucFprugx8vM0us8LF/p1xaVhj+VhvnuvUXlYL+YQiGDDJ7MXij1mviGV1pc6oF7Ig98kUN6DvAfCYbT6acoroEHZ3gvCmFYDoW581clnlqWU2VTCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsajeCp5nS0FOm2UKT5vXcOInGyU+yDnCIcJaOYcEuw=;
 b=bQquada+AtW3o/zHIuefAUdoxfm/GZm2AhABneCQtF3J1cgLPw+gAz7kyzh7n9ymjoVkquv8PzeT3HzWUhOyosW2XWapCEzk6+v/yeBsPSq9/RSe53/JGerXB60ZERuTLvHrfxYZyT/uklgqinGRAyS0cdgHRBvQ/wZiSzyMcaao6jymMjz82kblBj+GG4S1sw0GJ1dIdTSj98X8POw5m3KbX/FVB8PS4kvwxpjA7zpbL/lzUYjpzNqIvdW8+S4Wao87f28w/0bLZzoD9RPWRyCipTzknB7MBytYPmPu23VbwsHJUHwrhtrExNTkKPm6u4dHZQfAimOPYH2BG27yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsajeCp5nS0FOm2UKT5vXcOInGyU+yDnCIcJaOYcEuw=;
 b=dQODXAmQJch3kuh5xtzHf0t2+JZLfxpNLDlloTr7ATqtcluZQ7cgecV91FbC6l308w4S60RRmzwJrbXaRNTTHApA0lUChJ7P6DHDmVj4yqzNXQ6AGYxy1yryKjp5bXkgleJdzXMsbinCNEbNKdS1vHitE8w99VnQABZXwp/kQvED3joy0xKNzdoH2VGHDgxfV/ncdTPicL993tzTAPni4748hfZSTWCVCWmIU9AhKg7RhkL7umNSrZC+EvkGa26O9HXbUXB1Cw2Pi66z0rckN/1hvIjAXKLa5iSbU0j+pya+x0J04VJJI/zvcvv/253MYjLCOmbbiH2tfyxbh+d/7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM9PR04MB7556.eurprd04.prod.outlook.com (2603:10a6:20b:2df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 01:50:42 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 01:50:41 +0000
Date:   Wed, 12 Oct 2022 09:50:33 +0800
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
Message-ID: <Y0YdaXapMzC90ftj@syu-laptop>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
 <20221007174816.17536-2-shung-hsi.yu@suse.com>
 <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
 <Y0TpKaIGL18UltHF@syu-laptop>
 <Y0WDcdQyxkYuQVXq@syu-laptop>
 <CAEf4BzZe_U96h31RzOcQbos4nD3kFsBLjNn9O8NvgnV9J3v2JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZe_U96h31RzOcQbos4nD3kFsBLjNn9O8NvgnV9J3v2JA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AM9PR04MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: cd215a6f-359b-415b-fab0-08daabf42b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiswa7xnCxeMxcNk5v+tn5C7tlW6bJKNNN88HBVYlT4hxlmGGyBgRxHkFOqUlv5bdMBhXDYs+bwrR/zvVOBOBxbeJ+HUGsvbX5TYrSZMs95sQowpK/ucumJrQNHrZnIbpqw58hSZy3uCDd7GtUoatANczDIBW7nJU0yG13TgEaGAaHTA9XLEzrvXb7KeY4DpDeoJeHwSxKehNgV0Gf9SGHCtbfXLOXAGT3GpzB/AGlgRmPxOMqln6bCwwQtBwedSWpJ4XdLJGHhA/Kskn2kQJDxKkycR7w8oQUTpKk3+L7z5DK+aD14lWQOMkBFhTR8I1F4/OR4RPn2qOJubs64rYNn7/QXzVS1Xe3B+Xhj7y229j6NbAIthJDanRiJ2cSRh+8GAQqEUNXjjMeQ909qfCjrJ3uacwisHF11DebKLVlJGK3fhd2lcjUM28QJy4k5IMDqyPwjTSBulpI3TrKq78NcuAK+sTyO/jYywGe8/HjcZXkyn/ezO5rT8xpCyV1DhMncsoEFaNzqI2LJUMCLjW8cR8YUqVvon4KB31CGSSWXxo4polCh62APJ1qKF0Lvzq/zNcCS53MoNK0yAkdlj3GPLxbEPAo5s1/ixBKCTpS0QkQnNMvxykFq1PoOcYNo6gyTagmCr7U/6mWz1jzTq8d1CDHJ1KcI3jEmCJw0aQ62kdHku5zb9qsDZmKun2cJT5urp6vhiJZrriXVq0f8XzXeYUB/y0jItQTnBUDU/hopiJ6f/d8XavqnSUaMwvDZd9KTbB8CacqGMIV9Aeoh3Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(66556008)(2906002)(4326008)(6512007)(86362001)(41300700001)(66476007)(8676002)(66946007)(186003)(7416002)(8936002)(83380400001)(5660300002)(6506007)(53546011)(6486002)(966005)(478600001)(38100700002)(9686003)(316002)(54906003)(33716001)(26005)(6666004)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9hZVZlOW9CVnpONmR5UDY2Yk1UV2tFMm95c1dZV3AxYXRyMklPRFJJeENY?=
 =?utf-8?B?Q0owQ1RIbFpHWktGaVF1ODNYYXZkc3hOL2tYYVZQZnd2S2tveTA2Q2IvUjN4?=
 =?utf-8?B?RU1UMmhDV0xJeUZVMm5rT1B0SnlCQTBIS29KYk1pb2FoMUllMVArUjhmajlD?=
 =?utf-8?B?LzdkQXQvOUJzSVM3ZWR6SytJSXJBZG5TR0VFNm5aTERYTk1YMHFveFRsQUtF?=
 =?utf-8?B?MlJZQzYwR21LandzMlVZNmp0b0lNZGdsWldTVlVxdU1vWlZaR0ZiRU9XR3Fs?=
 =?utf-8?B?YVRKM1haMXR0UmxwOTREYzVGMlVVSXozcUpGbHBETzVSWS80cGU2SS9DUkp4?=
 =?utf-8?B?dXh3NHY1VE1PajZadkU0S2VTL3liRjNURkppM01jTTJIN3UxK0NhNkpweHFH?=
 =?utf-8?B?NktwSXZYQWdpeCt2SDZmZysxQVR3ZmVOSytjY2xrRWJyNUdzV0FlcVpnWmJT?=
 =?utf-8?B?a1BrMS96QjBGVjVNQk82Vk9Sb3F5RUZCUGw1S3dEOTNTRXhVajhEb3VVVmt1?=
 =?utf-8?B?ZTNST05rcTZub3dPM3FaeWhIMENRSzJYSk9NTXZiVGpjMG5KTHNZdzRSRUR5?=
 =?utf-8?B?Rk5OYzNlMGsxb2NRek5QNmJDaWtqQ2NsOWUrU2ZaeGdRWldtV2d2SFNsM05z?=
 =?utf-8?B?R1V2YWRCTkRPODgyb2xYWkVmZ3hGNXAyb2VPM1hZaGd5L0kwRjhtNFFXbmFn?=
 =?utf-8?B?Y2NrYzVBaDFuNHBLQnZRWFlBSE50bGhtQWhQVm9Nay9LYXpRRml3MHJhc1FB?=
 =?utf-8?B?Zmp4dmQyeGxWUHRML3JrYTNDT0tnM2M2WG8zYVB4RHZQbVhISnJmYWNxci9D?=
 =?utf-8?B?RzBSUnNkMVpiZkkySkRKeXNINHZnaFNuRWxsM1pYa2orbHZ2ZlZCRG5HZ3lj?=
 =?utf-8?B?VUt4d3pucThCbVEyeDgvMEQvdmtqVVVsT2FpUk5KTFNaUkxtVkVKQmQxRmcr?=
 =?utf-8?B?WGZVc0FWck5jazZXdDFjL0dlOGJIKy9OVmlRMDV2RGhtdlppTE94WVVDakJE?=
 =?utf-8?B?cm1lK2hRaHIyOHRWZ05wQUIxMDgvenlCZE9HdTlnd25DUldCbnBOK08wRW16?=
 =?utf-8?B?VXA1UkI2WVBjWG03NVlKYkFUZDlGMmQrZlZwNU9jQnYrdm9DTE4zTnF4ZSty?=
 =?utf-8?B?M0tLLzRwYitqdHpGeEVnT1VrblNDL1BONUtJaWNPdnhTdkR2RUJvbkJyVjVG?=
 =?utf-8?B?STNRWFcyOGpnNFkzbmFydmZEc3h2MDVuSk56NHpQaVZodDJRR1dzODBPSzdU?=
 =?utf-8?B?WE9BR3ZTUzZPWEdsc0l5TUxzcElObzlGWHozOWlkUTBpQk5oREJlWXErSk5D?=
 =?utf-8?B?V255L0F2SzNmbENUR0ZiaXZYMkpoMXhWd2s3bXQrbG91WWpTWTc2U1VmL05l?=
 =?utf-8?B?cC9IZTlMR1M3RjMvYXVHY2VBc0ROc0tTd0FYclBNKzB4M1lDNDc2WW8zdGpV?=
 =?utf-8?B?RmkvVG5jai92VDE2VmpSbDFLUWhiMnprbzBJdmlMdXJ6YkYwNnNJSnkwL3Br?=
 =?utf-8?B?NlhIbTFVWkQ0b0gyckVhTzMrOHl3RjNuWG5ZMFUzOThmc0ZLTGxWTnJJdWQx?=
 =?utf-8?B?dkNCb3IxdnFHZVlPTWlBT05FVXFYZXo4K2R4Wk5PQkpYSXJkYkFHZ1ZveXdT?=
 =?utf-8?B?LzdxMytTcTFIci9Yb2hWRGNxdldqMWVkUnh4SVY4WXU4dE5tRXhTZ0YzVHhP?=
 =?utf-8?B?UUNXZUloWlFwaXpjTFdLUVdMbjR6TjU5eHltNGNIUHJuSzdTTVpPWXBDOWZy?=
 =?utf-8?B?Slo2N1JXa21ndk1VYndkNnBLMy9qcHRKRTQ2em9JRE0vdEZFaFZ2OXg0QnNE?=
 =?utf-8?B?OGxNTDBSMktvNjROUUZxMHFFREJVU3M0VjUvRS9LS1djcDhjOWlid2NBOVJC?=
 =?utf-8?B?WFlGdjdsRHpzTGdXY0wvM3JsWXplV01VVnovc2tOTW9TQTVUOUJROGJLL3Nh?=
 =?utf-8?B?YU0vMWZhS0ErdkZWOXdnaHJkVmZheFA4akV2R1IrSXZQZCtseVFpMDBMWjkz?=
 =?utf-8?B?aWRVN3FvYXNCS3o5RVd2OENaZ21uQUEzY3VhRFU0S21PYkFSZjVjZi9zWXly?=
 =?utf-8?B?Nm1Wc3VhaE40L1c1V0R4a1hibEE3Q2VXTFIyV3ZEYkRKNnNhQTNYd0pIQ0xq?=
 =?utf-8?Q?SuAY6iDYeY8neso7V7xar89r3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd215a6f-359b-415b-fab0-08daabf42b3b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 01:50:41.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xqkzIFr+ZvgFNJbgt+kL1ReekHXgvjewY5UAKkUcILZixdZnMXqn7Ih2w5mkJDeqNakgQruVDGHEUGgTRDfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 09:06:03AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 11, 2022 at 7:53 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Tue, Oct 11, 2022 at 11:55:21AM +0800, Shung-Hsi Yu wrote:
> > > On Mon, Oct 10, 2022 at 05:44:20PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > >
> > > > > This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> > > > > oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> > > > > reports are incorrectly marked as fixed and while still being
> > > > > reproducible in the latest libbpf.
> > > > >
> > > > >   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
> > > > >   libbpf: loading object 'fuzz-object' from buffer
> > > > >   libbpf: sec_cnt is 0
> > > > >   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
> > > > >   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
> > > > >   =================================================================
> > > > >   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
> > > > >   WRITE of size 4 at 0x6020000000c0 thread T0
> > > > >   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
> > > > >       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
> > > > >       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
> > > > >       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
> > > > >       ...
> > > > >
> > > > > The issue lie in libbpf's direct use of e_shnum field in ELF header as
> > > > > the section header count. Where as libelf, on the other hand,
> > > > > implemented an extra logic that, when e_shnum is zero and e_shoff is not
> > > > > zero, will use sh_size member of the initial section header as the real
> > > > > section header count (part of ELF spec to accommodate situation where
> > > > > section header counter is larger than SHN_LORESERVE).
> > > > >
> > > > > The above inconsistency lead to libbpf writing into a zero-entry calloc
> > > > > area. So intead of using e_shnum directly, use the elf_getshdrnum()
> > > > > helper provided by libelf to retrieve the section header counter into
> > > > > sec_cnt.
> > > > >
> > > > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
> > > > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
> > > > > Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
> > > > > Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> > > > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > > > ---
> > > > >
> > > > > To be honest I'm not sure if any of the BPF toolchain will produce such
> > > > > ELF binary. Tools like readelf simply refuse to dump section header
> > > > > table when e_shnum==0 && e_shoff !=0 case is encountered.
> > > > >
> > > > > While we can use same approach as readelf, opting for a coherent view
> > > > > with libelf for now since that should be less confusing.
> > > > >
> > > > > ---
> > > > >  tools/lib/bpf/libbpf.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > index 184ce1684dcd..a64e13c654f3 100644
> > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > @@ -597,7 +597,7 @@ struct elf_state {
> > > > >         size_t shstrndx; /* section index for section name strings */
> > > > >         size_t strtabidx;
> > > > >         struct elf_sec_desc *secs;
> > > > > -       int sec_cnt;
> > > > > +       size_t sec_cnt;
> > > > >         int btf_maps_shndx;
> > > > >         __u32 btf_maps_sec_btf_id;
> > > > >         int text_shndx;
> > > > > @@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
> > > > >                 goto errout;
> > > > >         }
> > > > >
> > > > > +       if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
> > > >
> > > > It bothers me that sec_cnt is initialized in bpf_object__elf_init, but
> > > > secs are allocated a bit later in bpf_object__elf_collect(). What if
> > > > we move elf_getshdrnum() call and sec_cnt initialization into
> > > > bpf_object__elf_collect()?
> > >
> > > Ack.
> > >
> > > My rational for placing it there was that it's closer to other elf_*()
> > > helper calls, but having it close to the allocation where it's used seems
> > > like a better option.
> > >
> > > Will change accordingly and send a v2 based on top of bpf-next.
> > >
> > > > > +               pr_warn("elf: failed to get the number of sections for %s: %s\n",
> > > > > +                       obj->path, elf_errmsg(-1));
> > > > > +               err = -LIBBPF_ERRNO__FORMAT;
> > > > > +               goto errout;
> > > > > +       }
> > > > > +
> > > > >         /* Elf is corrupted/truncated, avoid calling elf_strptr. */
> > > > >         if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
> > > > >                 pr_warn("elf: failed to get section names strings from %s: %s\n",
> > > > > @@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> > > > >          * section. e_shnum does include sec #0, so e_shnum is the necessary
> > > > >          * size of an array to keep all the sections.
> > > > >          */
> > > > > -       obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
> > > > >         obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
> >
> > Looking again I realized we're still allocation one more section than
> > necessary, even after 0d6988e16a12 ("libbpf: Fix section counting logic").
> 
> Yes, that's by design so to preserve ELF's 1-based indexing and not
> have to constantly adjust section index by -1 to do a lookup. Please
> keep it as is.

Understood, I'll leave it as is. Thanks!

> > elf_nextscn() skips sec #0, so (sec_cnt - 1) * sizeof(secs) should suffice.
> >
> >   /* In elfutils/libelf/elf_nextscn.c */
> >   Elf_Scn *elf_nextscn (Elf *elf, Elf_Scn *scn)
> >   {
> >     ...
> >
> >     if (scn == NULL)
> >       {
> >         /* If no section handle is given return the first (not 0th) section.
> >          Set scn to the 0th section and perform nextscn.  */
> >         if (elf->class == ELFCLASS32
> >            || (offsetof (Elf, state.elf32.scns)
> >                == offsetof (Elf, state.elf64.scns)))
> >         list = &elf->state.elf32.scns;
> >         else
> >         list = &elf->state.elf64.scns;
> >
> >         scn = &list->data[0];
> >       }
> >     ...
> >   }
> >
> > What do you think? If it make sense then I'll place the sec_cnt - 1 change
> > before the current patch unless otherwise suggested.
> >
> > > > >         if (!obj->efile.secs)
> > > > >                 return -ENOMEM;
> > > > > --
> > > > > 2.37.3
> > > > >
