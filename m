Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5456E062C
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 06:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDMEz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 00:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMEz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 00:55:28 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2158.outbound.protection.outlook.com [40.92.62.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9C59D2;
        Wed, 12 Apr 2023 21:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay1izjfpDKYaOz8OAWT40WM+2dypwGQlJouGw2Erbr5/0pAME5I8vOIG1V7WCrSS+NLV+Xfy2L971hDB4Jl3qb/eK1QgmMoT3pSbyC1zwL70KzoyJrXdv85ILTfRkMiVTOPQY6jTPaw6K9iEe2FAgADHS2ygI6vdWD54xTllGLd2ODxe+etoM66xFr4DH+ZU5RgZF0+BJouQWFGQFAm/u9K9tomWJbo0fRp0GFmbGFwbXY9X112yJtQBemH0SM+eVbHO6V7yqjAkrMbvRVLIksEWY1DRJnaeVvhMAzmkHSr3C9X8lthOsfjIdUmRnNhhp6NGLM/9B59aNA7+K+F6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIDRo+Vhr+BP5JkVc2jK4hvcpvu9l9Mk1pLNmHYI9aQ=;
 b=icLdoE8OEK1XSfrojZDKrD+8tMrmaBCv9HkgXKXHgFDlEEyJwQ36H6ARA0C6YnIgeoZHwhA7aEoc9ysMZbqB1WIWdjGzMRGpFEATg/070qQmmsOcS4aF80BjEK/mDmqFKyRXEBfhfcmF6DN/bcJ0fq3EvirPrjdJFi8OKBdKhjj3aSfLjVEv6y7DnkAgiUuNS+61lN0h0iFeGbOHZrhvmshx6CASP7AyZjtbraiE3e2NqINxya1LyCzduW7Pbj+znlBrskYfQ/pNRV8BRk6OhMfvZ8QTaRyP9IsjmS3e0oJubnxsw7TU6weWTo3+7ERFQIxdF1s8Ko/bZ0PPD3+R8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIDRo+Vhr+BP5JkVc2jK4hvcpvu9l9Mk1pLNmHYI9aQ=;
 b=gveQnOCyp6Q/A9mwC/gFZpJGohvG9AsugwhemOnhSA8UekhyPW7bQpxv6ByA1ddc+gC/f4Ngy8fna+u7j4YLFG0TQnkLOARjkvrbvpIMIzpzdoJ5JORyQ4kksLccu8AfWFTqsGEZVCUkBtqp2QQeNBzOBvHTiVhVZw5/pifRxoEIyWhSVqwa/O61UnE6gItbn55EccHFdW6Yajeib+CCOHIZZBGPeyoNGOYOGzxW7qXxeVPtPts1Dg+FT4mtihkbULtT1dLsys6pKrua+qjboRTafUlyLmH5ON5F9BGUOrBBmXUl9aFr5McwrjDfxdhjqYUoDO0jIWeDTJBBQEWThA==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SYBP282MB2634.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:117::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.4; Thu, 13 Apr 2023 04:55:19 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645%4]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 04:55:19 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     jpoimboe@kernel.org
Cc:     acme@kernel.org, alan.maguire@oracle.com, alexandref75@gmail.com,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, i.pear@outlook.com,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com, joanbrugueram@gmail.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Thu, 13 Apr 2023 12:54:19 +0800
Message-ID: <SY4P282MB108438B241E26EB9DC76A4469D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412163016.5p7wve3meeahdecp@treble>
References: <20230412163016.5p7wve3meeahdecp@treble>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CJ4/+guMGS7vu/9fQeEsVwx+V2ur13i6s7UQdQV9PTnlSmpuLIE9FA==]
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230413045419.622237-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SYBP282MB2634:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e95e20-e0f5-4f9f-ffd6-08db3bdb47b3
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT8wRrMOmTC7gIiazLgnsCtwTlpY4l0lL4HqkwnbHyg3McNCF99+zIyQeEKeitRAPwgZuWUwceWO5+ukEixyWiuh3fIX5rbX778NTlzIB0cbFgTp1SSpnzGZ24v/bLRcCLlmwPaCMAGJgBYC2cDaJ2/hfLP/nPHS/yc4xX+4r+zzKLGJSdte1DaIaXwhUKyfA1bfj4HpjS897SPR8ktv9cd0lwESb/wVHSxG9BWRpnSGBUDdrTm+wIq5vRthUrjQEO3DfMAvzllSjjuejs/nq9az7PkQlHJ5HSnaj98zYJNrOEMhvq14iI3Lr+jEFfuXuitUoQG7tLh4Dw4OosaVaKS3tIWbUSuCGObAT5JTlE+WXLLXAkPU7Zk/gHstGh7K1oxT31WdX+bG5AEoT+woZK/TorwxmtcgdWivc3WAG5un5KI0D+FAYFXjkWM9NnBeo3Y4fhBjmDTtq3TQUy5p4KbvpyaquoBIJdOHreYuaHMQo+PzqACQbGWRi5p8lwrY3ZT8YDWY5Hx/uBj7/r6zIYYwwKIF/iJvV8RKwxuz3WHd1MgfOIpX6AKVFn3N3qc01CTw/ZK1nZobNmX9C7hAPa5fc3kbB1Zd7lbbgixglGupXLxRmpMmjC4Y0j1ZtiUpOgZULRUkIn6Ec6SPdm0d0eBJpPgscmsUkPnAodfl0oGKRz1hSNuuJ6jswh8gtg4t/ha3UInjxa78HIpjGZtx8nQNpwy1Yp2DpO63OfNDAV1J/M+7tnqJGH2UnlBfUECv98vBfmHIEocXsp/JvNcKp8gK0gvwUydmjiomc/+KhVZwNdhaWkVYQ4zT
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vmrJKrqZxCxvMijtDr+rdRSn/A1DJaPRWwyJx8S6JCOVFMv02VnrPN5DzlgljGdKA/riQWomaTh5QCeuZnTXVjoC0xKATXbw3LasQ2ar8Fr6Cwf1ZXB7DP9y4k4NpFHzJZVd1lY98S28p/YHvM6BRWNvEK703tWinlx8pE8jcG4404kAgDyJa2mQTFiGBEfwRLoYl/jbWyCm6+5V38VBnhMX/XRR/BwgLF6aYDgyNxZZFPOQDtCMUrH9mNFVFIaD3lPSbSOTDvItq5UxOAVUKpXmXlqzbrEzXYHEXYOvT8mjXw4drGYV94S3ha0vlJe88zh80cAgwLu0mAD6/YtEp5x+JhCCCYrZE1G5L3efm637SUEj8oHcZfct44aYFF59CwWr/hJuTEc0D3aokzs7pUfgB1+FAtORlY8D4QZiCvVw4aQZRNyd3VZkSuxxHCigmTEJPDIjPwA7TqsdzqnF203bQHDpqS2e11kYu0exYyofCvYFu/J+yoPvje86aJ4E5f7y9tj9zpjjCDL+qeUr7akP879WdMm8oJfRsgq2wDLdXWEuj1G+LW6P047OAHe25j2hmneup6g2soFgpJQlxKzPRRUXQ47S6bDUf2fLX3xqMcDXje+WimYvjvGfhhW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDMm0R8X20bsWmurQWEVhhQsJBWrrHNAgPXCabOxi/cP616br2l4skJNJnG8?=
 =?us-ascii?Q?XQuUK99g7S4l6jNjPjgR1wpadsmUlpz5jM5A1YGZEl3jQT/fFYtK3ybZMFAN?=
 =?us-ascii?Q?4hf+Nlxnar+h2kW265RxsE/ighkMgOQs4nAEZYw3ReySTXMZjLcyNAOPvx2u?=
 =?us-ascii?Q?bnWj+7LSYK7BpKtVGAe/RLCXso2kj1W9KWej/VNA6mVt4tXY5nVT4qDqDjmW?=
 =?us-ascii?Q?X8zKHRy9F/02cYTjpuE5mACGlgVhhZD4rFtXpoWJTfgbOec/DkRsqI/4UX6J?=
 =?us-ascii?Q?98hAgXUMi0YrebVxKY+5R9UBOCyvnAV2uJN1rcfpMlQ+S6Op+QX/wWCGP7WX?=
 =?us-ascii?Q?t+MN+eFGeQLp9ayKJuKwH0uVwyfY8IiKVLfyeb11SQ3S2tUcCSIYWZuEwO72?=
 =?us-ascii?Q?N3L1ObUy86c99+uF5en4ryqMFNjF3ZZBok0buLVC2n/y5rhJiAHGlI/FouJ9?=
 =?us-ascii?Q?8/2hqElzcIYg+/R+nweb0pFf/nADDX5PhnXpYxf5pI9I7N1wi2RXbDLw77pT?=
 =?us-ascii?Q?Km74P//4cpmJKHyTOkpplYUkxAAPgUbuNwFYCG3iGsDAbCgqPNMZ3rTx0s/l?=
 =?us-ascii?Q?jBmdI4kVFkenhHgFVfM5laDOpK8hg9BQpEZW5Df6p69BqACI2hh0gpiLm6Ht?=
 =?us-ascii?Q?MzW4yzkN84k+3T7n2zyrN1+grlMTU4Y1rb7YlYYw96hJj81awoyCMzi7gihw?=
 =?us-ascii?Q?CXmkQwuzvsSyZ3RhoXUW92l3UR3VU80ion6Fb9JM82o4mAgEWMW9rylzmrUG?=
 =?us-ascii?Q?GdyN0n2nXYoTIxXXUhL8422VXm9v2YZS81zoPscVJTyXvTpZ/XNo8OPHFXNx?=
 =?us-ascii?Q?o7QDPhEANO70jG2Gd5aCnKuIcx9MH3ce9RGR7IzS9eXzEF3hmY0VlPjZrjat?=
 =?us-ascii?Q?Ndntpf+ijtpFHcthuczuOEJIs4b1bob6deC15a6W7mfRbWlos+8WZ6bzTDP6?=
 =?us-ascii?Q?ojM9CYMQCvHSxcGM4B/uUdkVuX+4gRrSvbpSYINwP3Z6SQ6QvzeRMXJYrRGo?=
 =?us-ascii?Q?x/CIAysNn7TLAJjzjd/tJXiEtGJ/UqIBwL8+U2U2v9FTcux1jTr9XmnFIgGJ?=
 =?us-ascii?Q?TSHzOJP7R7P3bDgzDBylKlk420pJ3HQah2entdDRPW/dJ2XTl13jH4CaqI89?=
 =?us-ascii?Q?g5Nwpm2If3oloFD+RwwDWVZT0l6zo8glFtlcLnHmPtmL3PphXgqZzNXkkahP?=
 =?us-ascii?Q?UuLNmm+Z/JY1QpX/aq8ogspnd0NkYVx6NkozN61dphpG5+/NTZ42X+LLBLOr?=
 =?us-ascii?Q?nLImPKANjkvidDf8V21J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e95e20-e0f5-4f9f-ffd6-08db3bdb47b3
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 04:55:19.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 16:30PM UTC, Josh Poimboeuf wrote:
> On Wed, Apr 12, 2023 at 03:10:14PM +0800, Tianyi Liu wrote:
> > On Tue, Apr 11, 2023 at 17:00 , Josh Poimboeuf wrote:
> > > On Tue, Feb 14, 2023 at 02:33:02PM +0800, Tianyi Liu wrote:
> > > > > LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> > > > > .tmp_vmlinux.btf
> > > > > btf_encoder__encode: btf__dedup failed!
> > > > > Failed to encode BTF
> > > > >
> > > > > Thanks,
> > > > >
> > > >
> > > > I encountered the same problem when building a new kernel and I found some
> > > > reasons for the error.
> > > >
> > > > In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
> > > > .notes section. In addition, due to historical problems, the alignment of
> > > > records in the .notes section is not unified, which leads to the inability of
> > > > gelf_getnote() to read the records after the wrong one.
> > >
> > > Alexandre, Tianyi, are you still seeing this issue with the latest
> > > dwarves?  If so can you confirm the below patch fixes it?
> > >
> >
> > Josh, first of all, thank you very much for your help. However, this patch
> > doesn't work in my environment. I am using gcc 12.2.1 20230201.
> > After compiling, when I use readelf -S to view ELF sections,
> > the align of .notes section is still 8:
> >
> > $ readelf -S .tmp_vmlinux.btf
> > [20] .notes            NOTE             ffffffff8250b570  0170b570
> >      0000000000000084  0000000000000000   A       0     0     8
> 
> Hm, weird.

I have consulted some materials and found that using ALIGN() in linker
scripts can only "increase" alignment, not decrease it.

Perhaps could you try modifying your patch to use ALIGN(2) and SUBALIGN(2)
and see if the .notes section in the output file is aligned to 2?
In my tests, this had no effect.

[1] https://sourceware.org/binutils/docs/ld/Forced-Output-Alignment.html

> 
> > > Apparently the latest dwarves release fixes it on Fedora Rawhide [1],
> > > does anybody know if there a specific dwarves and/or libbpf change for
> > > this?
> > >
> >
> > It has been fixed in dwarves[1], but it may just be a coincidence.
> 
> So just to confirm, the btf__dedup error is gone for you with the latest
> dwarves?

Yes, this issue was fixed after a9498899109d3be14f17abbc322a8f55a1067bee
("dwarf_loader: Fix for BTF id drift caused by adding unspecified types"),
which will be included in version 1.25.
