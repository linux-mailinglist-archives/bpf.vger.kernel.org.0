Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9C6E0A17
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMJXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDMJXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 05:23:33 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2146.outbound.protection.outlook.com [40.92.63.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D282708;
        Thu, 13 Apr 2023 02:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAGX+TWDqAUz5zasHCRO4mrN89sNteLBpR3hVWILYwVuOzQpWYjcG4S0POYxSe14gtuXvFBr1G2Ri/n9YSPxkF/EgnCvJpT5H3oTVxLIJihDrg+BG3y5EuL7K0lTI5RxsZglpfSBPZzIQ16QVY9GHFL0F/PLehF2IhwZro2UWbERWnDnQJfbrJ967zgNBmMI1L4jsCqEAiREkTaeW2p1V2t2aRDlqXXn1PGPDxKUsi0Jts50lJCAkfKYBeCRcnvJExbuTt+KGSel/2xDZS73egBOrGEsmp2X9BWgGoErqPlobAo2hysny3eYL84gkwjyXwE49DctHxfCWUk1BUMcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHE1eMl6Kw6EDxKsjauAUGqAs93uRw1DjbHsUaskQXY=;
 b=Y5CaiPrrK3jYfiwjQWYEwboJCq7TOIVunw1gcS8jODu6n4O8nu+LVdgeSsA5JUuHD1IN/vDffc/YZWp5NjvVsU1q6jaOXuh0xo23THTNSJF1g7k/89c7/Rq/hBprxMhTNNGhKtZCAgehdwLD5wgCW+d509OIruBw2C/OtmLY7f7WPuXlk/s6CfRrD9RoxyV/zH+ZI5Ep7zPLtWBDO10sNF3dPyAb7XlSB09K2UhsIo0q6FLBeXGz2UR2JZIy+rkMjIiTJylTe3aoHuA1QR6L4IBZZ8agd78DbsN8WqzzSwH5XEv2sYcOyregXrPVoX0SODsOtzVEcspHMbj2+8+caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHE1eMl6Kw6EDxKsjauAUGqAs93uRw1DjbHsUaskQXY=;
 b=sqhKHe4g4iC5QzGEAKZwqUTMHtgwgZVjGrNjLRKDUoPcOCgSwUOgZGxw9SJsEvWVMVCsz7cMJ9lzCPP/pVg2SZGEgBm4FzzmChz6oupya/UAiBxbt40Sz9vkLzqXClOoNphGQmVpPge5wx1fhctMBsssUhWhz1JLsdvgk9Nzweivf9p9hNXcP4iS6XaaumDSlnj2CUnSE8WfILoSnA52zqMZjx4YetQi835ASzgRcsvDxUX7rt3Qpik0nsBLs+xBaumKU9VMRuTL0TSyh2JeifBUlSTHckitQLOdc1e3HusjrChHxlfBHlQ0FnZ4k5OlSK/qnDJuXl4XvMAvxHEqEg==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 ME2P282MB0066.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:57::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.4; Thu, 13 Apr 2023 09:23:23 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645%4]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 09:23:23 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     joanbrugueram@gmail.com
Cc:     acme@kernel.org, alan.maguire@oracle.com, alexandref75@gmail.com,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, i.pear@outlook.com,
        jforbes@redhat.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, olsajiri@gmail.com,
        peterz@infradead.org, ptalbert@redhat.com, yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Thu, 13 Apr 2023 17:23:08 +0800
Message-ID: <SY4P282MB10847E614FE5952EB4D46F049D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413022149.94781-1-joanbrugueram@gmail.com>
References: <20230413022149.94781-1-joanbrugueram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [gRDh3H7DFuvzulRltlzXStJhrjJHxn0B/dIChI5RNaV40HnwWJhJqg==]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230413092308.45734-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|ME2P282MB0066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7430f4ad-7588-4709-9716-08db3c00bac0
X-MS-Exchange-SLBlob-MailProps: cn60g5V53KNlipco9KbgmIn/wK6zG3iEUNqClu7visljvT/Eiys2axg9Cpp54aBLhB5QQaZEzflVfCjcM6DTn+djNEeHb5nbWcP3v5IsXf3An8EKuDPBpiLyRF2NBV5bMwDnW1xphvl6TCVPtH34zFyBmeELR6S2FkJT5+kr+N9dsCFLXEhyudB48GNQ5SIoZnenKphdKFJHz+bNMWw+Bxn6SCcUuHH/h+CzJMY3PhX6uhxTWfcOJeq2K854rIi4kHEEZ+kqH8eB4os+Qy1cpW7QyvBLwB0rRrPTzEmmVYBy9Gi++zps/kzZIM1mG4WF6E7JGFiksylpt0KgmaSmSyoaGpFQgTlUFWAgqEM62cV0KqPv1dfEy/NqGTrTBRr9uPr0g7UMrjwMbW9/xTPM7hXvytfX3uUgQ8dktEeVVNLuekTs4/y716EO+k4sNwDOTEvvi28KTOWByThGPyowJY0ZVhuf7RtxcplSkQ7s2lZBSkGYh7gQN4n51wrva4p4I0LjjhBcVhucf8xhiNtF4a4xnIQUXOr7XxyMkr9A8Dk5eWnuJv3moSIs1nKyuFJ0I+O7TpG0OPm1MYDEbim8J10GOfNo2iNim632Zyue6cZxDKG6L2auBUmEROITd4Nu0jp+pDt9Ez0TO27/THeoJ0RvGw3sotF8xPMzTc2LfzZwLor2u9yTnhSIZDVHq+0TJbOQ0TQcyfGiod+aVBc5348QPeRxSHuDMoMSnZ6QWMmfCr180A1Sa9SezzHY3qVN5Zn/gw2zsC4CsNtou0bojDUA0XzXZilcLreruTaex4fUBhHat3HuE2CycOv5+5PaHPatd32K7rgiu7V4e1cq+jCLDu33BWB/zRo1yJjrzIW18y0D8ntqPw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue/7TnLhlwsryTXKZrIq3ILU7wv6QIN2GuEy90SijD44IrepFNQNMP020wkB/4+2xzoTQsqDp5mKU7CAfMEg/tgoP13Q/qBENpzYLZ78Bpkd8fpYzbTsOW6t34cpTWMbTL80Pl8AiI0nvsE5q0DNM9M2a+msP4iHRPn4DGQWbjxBhGO4m1eOOflnc+u7c+Rt/gN/dFfKmVxJdsuIk2n2a6CK3Csq7pOiAaXAXR8R4wNKB1QDmJjQMXgsECp43s7zO5Fww1Rbgq8/b4/xY5KuWJy6r6e8cB7xMbxrY8zopVFMGPy8FhsN7d4CN350eKV/fThz46pKgsb1EGXs7fweEasPAQ5j6JFmBTk4B5AkX64E/KR2ofFVtRR9jvn3YaG1KnrrdoTuk2W6BrdA4ksarrix1necCdSPgceaRGkn2A2Jx8tygEMMfO8sc+9FPWt/00uvP9al6GHzsNkB59+WmMvatkB6JdUk+D5ZFw442oPRNCJH7wKOd02tSE8o3YnlehsQeXAwMt6JPf6uytOkyvtRnB8cnTEe1RblRQqYfkS8Das9U29rLNYEv39b7LbwDImqjCvjqFy+/3e+fHjpjyLT8nUgwZx1uH607wrgB6+2YAq6XlSiju9+Xhvws4j8/X3qOb0Ql2AEOSTD8gdMlxQ0BtP9xxZyEqekkQ8QBfE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDlrdEFLelI3Y2hBMjdWaEZwOGRaZTM0dWlQbFRBOWpLYXB2WjBIcDVWMGI5?=
 =?utf-8?B?L01BWU1GcW1OMDRBQysrV2dadHFJU01tdW91T1k0RHNwSEFsbUtSNXE5Y0xO?=
 =?utf-8?B?K2lOajZ4aHRQdDUyN2ZIZlVtQTdvM3FZNDdEWFpxUlZvMEtiTXQvRzRhYU4y?=
 =?utf-8?B?dkllTkNBQVlNVXRzNDlpTlNUWFgxVEE5Q3pnZTRIZXljSDJFTHFyOTNBUm1T?=
 =?utf-8?B?SCt0TG1xaFJpd3R4K0daUXJTamxzaWY3RUJkbXV1SDBBNnVGRE16UkQvTkhu?=
 =?utf-8?B?WXFiYStCMDR1bGI5b21qNUpEWmY1S1BkaWtML1E4UU9hOXNabEphV0MyVGlJ?=
 =?utf-8?B?eVZCSFJhNTVpWjBEV0k4SjlUMVdLOVd6bHVrY2hqbjg4ZFNsek83Vk0zZjlD?=
 =?utf-8?B?SHNMVGR0ajRRZHlSWkZCQ0tTcmVWa0JJS1dqS2E5U3RoZmJmUWNZMnZYWWJa?=
 =?utf-8?B?R1VzU2NtdUc5aitLVVhJUlY3WWRSbWM1OUFkcTBsVEJSVHoyVHJQRXpqczBl?=
 =?utf-8?B?V1FZNU9ZUkdSWUpmT1ZUenA2MWx2QXlsNmJpdW9DU2tsbDNFSHFvakFTVXFw?=
 =?utf-8?B?eXRod3VrWk9mYlk2dXFmd2k5WG1CMXJLMnVLYUZ0QUE1ZDBaUjVicGVzVjNv?=
 =?utf-8?B?a1Y1cHNvR1UzeDdMQ2xiTGpaQkxoOW9DVlVrSklsam1yMk5aajhJVm91Z2Yw?=
 =?utf-8?B?aEE5NWRWTDAxVE5LSjRaQ3hxYVB5RVcvWSt4K0VVa2lrNGQ0cWhlTlpJcmNC?=
 =?utf-8?B?Rk82OUMrSEtCZ0xxanFlR09xbDZKanZIbWpPM0JEbnUzWi85Wk0yTXFQUThE?=
 =?utf-8?B?YzU0anpzbC9OaTRGTWJKa00yNUpQNGl0NU03bEh4V0kvVzVzWE03ZmhPeGJz?=
 =?utf-8?B?a2RvM1hsN2NlZ2t2WmtYbVB0U0xvdGNmZ2dTZDhYOXhxaG1hVVNicS9PL0dy?=
 =?utf-8?B?QlJNSnFWL3dsTTBUUGpZbmsxMm9vNmZmOW9KZi9WeUhHSjZpaWNxOXQ1alBG?=
 =?utf-8?B?RlNGdURhMElPODhXQjhodTFrR1UvRnJOMzl1THZENDFDNm5uWjdHL3IzVVNv?=
 =?utf-8?B?WTFVN3g2WHk4eG1FUlNuTDJxdGltQXN1NU94Qmw2UytJamZzaWE2VlVTanN4?=
 =?utf-8?B?aFBlUkpncmtjL0ZvaUlFaDV6eEthalFGeEpSMmYrZy9NenF6NUUvTFVJcCtO?=
 =?utf-8?B?a3Y5MCtMcFplRVNoVkltb0krWDZCc21aOXIyV1JtZnNSV1NQS3pJVHQwOWUy?=
 =?utf-8?B?b1VlZy9XVmU1R0dSamF2MVFwMGdrazUxTVc1TVFTZkgvVC9LVHN3cnFNTWZh?=
 =?utf-8?B?RjVGdHpnZSszTjVLLzdZM3V4eVhwMzhuZjRhK1FHK25PeWcyM2xiUmRBdUxy?=
 =?utf-8?B?V09FSEJ3d3BRdVVhaFdzRzJEMzlpNlVEZHJCWlFXN3RlejFDOXowb0gvVG8w?=
 =?utf-8?B?bDJnVGo1WW0wRjBNZHpWSWd3NmFqcldxUUJGZ1B2QnB1N2pFOUhSTXF4YTF5?=
 =?utf-8?B?NmtHejFRWjFUVFdkSFNrRUdyelkrOWZVbU8rd1BRNXYwSzdENVJXNEVmcmVZ?=
 =?utf-8?B?c0R2R3gwK0RJN0JVMmgySERUUHdjZmtEQkpRZmpXZDczTExOY2hjTUptTGNz?=
 =?utf-8?B?UEFNMHRNcXNlemV6ekhaejBidnBKcW0vdHZMVi8wNzYrNXJiVUJEOU5VeEl4?=
 =?utf-8?Q?2um/5UQI1m8foNW0Rq8V?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7430f4ad-7588-4709-9716-08db3c00bac0
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:23:23.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2P282MB0066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 02:21:49 +0000, Joan Bruguera Micó wrote:
> I have done some tests with Arch Linux which is also affected by this issue:
> 
> Base scenario: Running Arch Linux updated as of 2023-04-13.
>                Building the linux-mainline 6.3rc6-1 from AUR
>                (https://aur.archlinux.org/packages/linux-mainline)
>                with CONFIG_X86_KERNEL_IBT changed to 'y'
> Result:        Build fails with the "btf__dedup failed!" error

I use MANJARO with kernel version 6.2.10-1. We should be using the same kernel.

> Test 1: Update dwarves (=pahole package on Arch Linux) from the current version
>         (1:1.24+r29+g02d67c5-1) to the staging version (1:1.25-1).
> Result: The build works correctly.
> 
>         However, the notes section is still not parsed correctly, as confirmed
>         by `readelf -n` or adding a printf near the code on `cus__merging_cu`
>         (on `dwarf_loader.c`) pointed to by Tianyi.
> 
>         A bisect shows the commit that fixes the build is
>         a9498899109d3be14f17abbc322a8f55a1067bee
>         "dwarf_loader: Fix for BTF id drift caused by adding unspecified types"
>         I don't know why though.

Pahole reads .notes to look for LINUX_ELFNOTE_BUILD_LTO. When LTO is
enabled, pahole needs to call cus__merge_and_process_cu to merge compile
units, at which point there should only be one unspecified type (used to
represent some compilation information) in the global context.

However, when the kernel is compiled without LTO, if pahole calls
cus__merge_and_process_cu due to alignment issues with notes, multiple
unspecified types may appear after merging the cus, and older versions of
pahole only support up to one. This is why pahole 1.24 crashes, while
newer versions support multiple. However, the latest version of pahole
still does not solve the problem of incorrect LTO recognition, so
compiling the kernel may be slower than normal.

If the only objective is to fix the bug of incorrect LTO recognition,
perhaps this naive patch[1] could be sufficient.

[1]: https://lore.kernel.org/bpf/SY4P282MB1084A0E31D4228DF89FC42639DA29@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM/

> Test 2: Applying Josh's patch to force-align the ELF notes section to 4 bytes
>         (clarification: using the base pahole version again here)
> Result: The build works correctly.
>         I can read the notes correctly using `readelf -n` as well,
>         and they are aligned to 4 bytes instead of 8.

I'm still currently unable to reproduce this fix, but it may just be an
issue with my environment.

> Test 3: Similar to Josh's patch, but instead of force-aligning the sections,
>         I added `.note.gnu.property` to the `/DISCARD/` list in the line above.
> Result: The build works correctly.
>         I can read the notes correctly using `readelf -n` as well
>         (of course, the GNU notes which made the alignment be 8 bytes are gone;
>          I don't know if this has any negative effect).

I think discarding .note.gnu.property will not have side effects. For some
reason, this note does not exist in my final vmlinux. I also did not find
any usage of this property in the later steps of compiling the kernel.

> So, in summary, either upgrading dwarves/pahole from 1.24 to (not yet fully
> released?) 1.25, or applying Josh's patch fixes the issue for me.
> Despite the new dwarves/pahole version fixing the build, Josh's patch or
> something else to fix the notes alignment is needed.
