Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DEE695936
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 07:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBNGd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 01:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBNGd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 01:33:57 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2046.outbound.protection.outlook.com [40.92.52.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C581CF47
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 22:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUWEreb1SoNo+9gsTbAuyF2BV/Xo/em1MJ1nh9YZGThaRUyzpTdMcgXLoBX4vA9jTiTuAzCvwiZhskKLmMx/n2DJ+7ujlnsIMBDJ83iDk1UeIRxvi9MBrOp9GkqBShSavQo99rgN1jHtABHh8usfjnpTz8G0EmaFk80IlZIPqePRN8TYqivrRA6/RsuLti0O3KLJLL3RnyZYv6GdigZRK/QkkZt90OCBbP54VpqYxzYgk9ooFHQMtA31kNjvoOpKM3vUJgl6fc0pA54unM8JdkO6/ZDTQqIfT4taqW6n2EavcuZC5/mFtS9O+NGi391f1RShkb6KB9FJ7JN7Td+Gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhKvc6Mh2KADceBRi5G9+VLmB8Y1qxIHSK8IsGddSLw=;
 b=YPQGa6mdgCwL0dQCEGu9xePLWm1HJbpDICuAy89kj/MularFbCg3v70sbSCeUiE7f8NicIqhyKJ2ZoIXe2LiiuBZfo21ZWadSj55eEW6pwSFeAdJgHWdNAGZmJ9wD0UuNHLwhQ8IaseMtoq5qCafzuNfPtjMlskbK8xSMpUs5ES8GNwPsUQ1J+p9Yy6MtFaQp9Nt2UM2KU7MLaXdUhUyC7I973e1xHFoBykgHaLWiJUMXNErHdxNVnAj0bqMNEapcBUh2Dq8lku1pWE0C6t0DTccVkRfQzq9jRy7FFY3B1c3NS3VNQ0MJFaAGT/zIfNVad9S5XOGR6aWl+oyro/qwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhKvc6Mh2KADceBRi5G9+VLmB8Y1qxIHSK8IsGddSLw=;
 b=V5PHixKcUjicAJpmj5cDSL+kOi8gIyseL+NscB+xV+KeAq2S/zwjh0/fCCiN7hFXSSHXbdPVCi2qwAjPOMvO02fVUlN8D8oB669vX/YkrEfD2PwM2gbrxdpZG0mdhFjWllgmPVa8aaCQR8pdf6AIptSyySIcmsXlAsPdCSh+1npTn2soE1buzFDxekjvHNe8ICwh+McbTWktEKsIsvM0o66sDZeLME0UvXOBkf9BKaJ2gV9w9p2Gh4Na42eeRA6zBcAnA8HHcPmyzEZSnqr7VMHFubMatH9W49rpQ65dtrO3rXuLsk1+qIL5qpZsgtrwt7QuFRfuQdqU7GenGes64Q==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SYBP282MB4216.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ab::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 06:33:44 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::637e:ae7f:4307:e5ab]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::637e:ae7f:4307:e5ab%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:33:44 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     alexandref75@gmail.com, olsajiri@gmail.com
Cc:     acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org,
        dxu@dxuuu.xyz, yhs@fb.com, Tianyi Liu <i.pear@outlook.com>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Date:   Tue, 14 Feb 2023 14:33:02 +0800
Message-ID: <SY4P282MB1084A0E31D4228DF89FC42639DA29@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <CAMHq1ZuhecqT-YX8+yzUyhx8tmnQ7CDyuXV4GOuG=z44XTFsaw@mail.gmail.com>
References: <CAMHq1ZuhecqT-YX8+yzUyhx8tmnQ7CDyuXV4GOuG=z44XTFsaw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6VE1GIhRlJovlINQlo9ckhImQ3BZn5/dkwFjJHOl8WQjOIDkPsV+vg==]
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230214063302.467150-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SYBP282MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: d740d685-76a6-4b2b-22cd-08db0e556b73
X-MS-Exchange-SLBlob-MailProps: 5R4zPSLKzf7YusTWTL/hHXe0GbzMAKdWz9fPOjRpx6Hec/QKWIk/fujY2IWGzWtFB4CTYC/8bJGrJqpbsoSAMLAt3EM0NJKcy1RlaNM/XVevoC3954OdJTj9QaJ5R+Mq0dUejE2/a06LynDQe9hJet+vXu9pHGeX8Yt5MscCyIxV29x0A6wahA+7tgtW12wjsfviqOup7zsBZ00IDEbb/C1a8TAHeWHu0JoYPtlDoiBXYUbXjL8mOeONzzSKUpQnnsZ2zIKgLluHcL+HCZdFhRsdAd7DD00fRAuR96bgFty6HDJMZAtggTpxksr25DIDf92SjoadD/4cAGTakjZJyyELXOIZTuQuI3XQ3FOGKHZMNLC5x+lF+kNACETqfl1Y2HT2UWHCzkf4S+rwRJy7FqWV8HEuvtCn4rs+yNtb7SfCYXlNoy6+k0WnX1MjeLneaQAE+YQYUjrzkVApR4ORROdYoJq71vPhjdrTlyYq+sI9U4d0n280mtDOYRxnCxvTXfV+4w9ws4rjxlnk9ovsOcQ6ZeA7N/feD54/uQLNY7AneNsPVszCjJO1S3ft4bxblhcqz3K1PHxMi0tjmP/b9JJyIPeBWus9iJmPj9sLWVv1FgVxYiHT9bGW0at3VszPOC4eX5n6SQscqX3d4kvj4QUD1dNf4CVLWtTCIpQizYfc/+7OJQ5t8UPIazGqSrjOo2TEYeynyYcVVOastz3YPJ7C6ILSL7uB9aQmSWNzU32Vr/8L+G0L7VS2w1nircYLMjlR0eg+pULMnm6b1JclwFRK3Z1SoQaD0WRJv+k6c9BaHrU8knDrtHTMXE8X4guJ4F98DvHZqQF2Ry9bgYYaP4H87gV6a3CW
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDe64HXuLFFXjGfkS23heEMxlNKTA6qWAlNn8+TS26ldm/B+iFpL0hgXr4UglgAtgYCaBEVWR6m3CdO7REc6TbjVVDMxEtbgHqnVeCKYZi75uzLRHZvZCsmlARSvPvRItaYg4RIcG9yh148HjKLiixfBbqBt5/7SFx+RRzAGidU6DaHenUOuNIIFSpd3lhTT6Ey3Tdb7P9mz3E4zCKd6ZSggbeIguKXtuJZMVp0IqCqpNQ/Qzp/gNsSLYeagpZU70CNIs4CxIt8viYCl43FXzqaCYtSWc3Wm14KiUN9r/L6BWEhpj5ke3X1PpC7jxmszpioAkeyLq6tGGlfmM2/eddW5eciQn+HM0GPKyU5FvehoSb+ecO0w2bYAvgzoTLkmJjI6zB3v+gx02KTitu3SV01fwj6SKAGKiiy6sS12Rvcm20v/zi9a2TPiybkpgcg/tYfZVe+uFGjPYAOYxNCLuKVxkjgIvMZi9A4zTPonOz6Es2+CLwo/8aKgLxdJS79WTT5TyBODmkKFJhV6Ugxcxt7Gi8Cnsd2j3N8oC4ZznBn88TiFLZhWw5H6EECarYlQgsELDgX9/qivevy5Cszjm1l/itHeFCKoBxE3sHP5q+j8u+MLohtivOStMOTOQrOG25Eq9EhrykAhXRq87gOMMc76RXzkkTne8sfMabvaTAVv4Ytzol9pWnkIShO9iFtmPJ8N3aH7fTiwRdmCgYlFdw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INuiD38da95BULSZCdXvOcjp54i1d71d3QUT/Pj/wuxjKeBo2a+84G0cMWKy?=
 =?us-ascii?Q?LyOUTYGZBuVX9Br+msoN2C3+0KpHPvBCkR07wex53IqQMJN/ui0zFQnpccdR?=
 =?us-ascii?Q?hXObLmv6WTG64HyE01q9PM1Oe4558lKi5W1EGqZm7ivkz5GI/G9sCjHA+51I?=
 =?us-ascii?Q?rZTpjtzqEoxtvcAgTbmI7vmH0a1oTg7CuDsH+Zt8IlNijKZ/2lfVLYYKZNff?=
 =?us-ascii?Q?rLPcFxQjnaRx1ao1gEwIG9vi887veEcu9QNvjxXtv4UA39Ipk9aRZfcgeuqY?=
 =?us-ascii?Q?/gQLt8Pzz0xZ6AIp9t96tq4lrS9n15ekFvIuE1eFca6rcK+FoZdSTU9SXkX8?=
 =?us-ascii?Q?9jHTkzpf3dfn+qpI+4XmugPxJxJkqgJKzt5VmH9q9bUO1Y9Sb7+9XCkSND4m?=
 =?us-ascii?Q?lFx9HyE+QYYYVpfKl6J+HVPtS7jekQOLn2dqkn91e+IymN/YJPnwOUGTrcOj?=
 =?us-ascii?Q?I/MCa2SFiVeaWnQWnUXyhdRcqWN+fVtwNQXLUYcgo4zuunF04F4WI46nUH4b?=
 =?us-ascii?Q?lZNQZ2dI0WNXM3e+1PIVWBIm1JVzSM1r2MveMRVWBCd0JpiGVhkDl/Pb45ox?=
 =?us-ascii?Q?A3fLvuH9oU1qPLvKacdvU/gqAn7xMeflsCgkwrHenLUREYzxYId+4oLeLpmc?=
 =?us-ascii?Q?HtrcQanMFmbUSy+i1N4L+6x/frIwJHSVX8JQOQZKgoGnh/lrLBBuCF9BPJeH?=
 =?us-ascii?Q?UV7KV0VdrTroeXgt5XCzBUSXAYaLYF7xSdAvN4A7Cq4Q9/2gQkgvS9LTVLAC?=
 =?us-ascii?Q?wahMyUSIl6dztkJa+BLur++8k1UXXQL4MZgtQDQjD1UhWgn6FoKuNkJgkjo/?=
 =?us-ascii?Q?8/xtfeLQV7AU+ZdFKbOHkpA06+bwLGq54KWvgnbPhhCZyORLB1p2a9Jt8ZvE?=
 =?us-ascii?Q?tYDyp6DWq5GXwCeJE778TtYAZGtJKTA2LmqOeVzl1mi/21To6012T1r3ZAIj?=
 =?us-ascii?Q?FGeMbNSDQw3oW9bzrM/iC9iGj0f/OjWfGwY7zt6AXacg9tLDwk8VnRiqVcx2?=
 =?us-ascii?Q?IEoxgvb4h0bvm0ujNl84CLeOcKy/LVabHoalIiUZ8AyNu/ugm0CpTu3k+vQi?=
 =?us-ascii?Q?G3L5ukDBy9C3y/YQxaouUoytJ4/xpAHHdvAmCptEX5Re5KdlYl8DgMHUKd2e?=
 =?us-ascii?Q?9uZJrRZTuadrlGLCIBK6JnSZV2SvI1N2vYaSv03PEU8wfX0Jbq6kdwXN+ZFJ?=
 =?us-ascii?Q?YW3GRz5pLjwSwWG/J1nfPLhE1d+1o0hQwAZA2HVLWytKGMsUo3hHEPg9pJCI?=
 =?us-ascii?Q?6Fr9d5iaHKSMT9xLkUh1BCkf894dPLgKEOFYL4DrP8cXvdvXOzBpnLuhOQfE?=
 =?us-ascii?Q?5Go=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d740d685-76a6-4b2b-22cd-08db0e556b73
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:33:44.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB4216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alex and Jiri,

On 2023/2/10 23:37, Alexandre Ferreira wrote:
> Jiri,
>
> On Fri, Feb 10, 2023 at 8:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>> On Fri, Feb 10, 2023 at 08:02:23AM -0600, Alexandre Peixoto Ferreira wrote:
>>> Alam,
>>>
>>> On 2/9/23 07:07, Alan Maguire wrote:
>>>> On 09/02/2023 04:15, Alexandre Peixoto Ferreira wrote:
>>>>> Jiri,
>>>>>
>>>>> On 1/31/23 09:18, Jiri Olsa wrote:
>>>>>> On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferreira wrote:
>>>>>>> Jirka and Daniel,
>>>>>>>
>>>>>>> On 1/27/23 18:00, Jiri Olsa wrote:
>>>>>>>> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>>>>>>>>> On 1/24/23 00:13, Daniel Xu wrote:
>>>>>>>>>> Hi Jiri,
>>>>>>>>>>
>>>>>>>>>> On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>>>>>>>>>>> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm getting the following error during build:
>>>>>>>>>>>>
>>>>>>>>>>>>              $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>>>>>>>>>>>              [...]
>>>>>>>>>>>>                BTF     .btf.vmlinux.bin.o
>>>>>>>>>>>>              btf_encoder__encode: btf__dedup failed!
>>>>>>>>>>>>              Failed to encode BTF
>>>>>>>>>>>>                LD      .tmp_vmlinux.kallsyms1
>>>>>>>>>>>>                NM      .tmp_vmlinux.kallsyms1.syms
>>>>>>>>>>>>                KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>>>>>>>>                AS      .tmp_vmlinux.kallsyms1.S
>>>>>>>>>>>>                LD      .tmp_vmlinux.kallsyms2
>>>>>>>>>>>>                NM      .tmp_vmlinux.kallsyms2.syms
>>>>>>>>>>>>                KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>>>>>>>>                AS      .tmp_vmlinux.kallsyms2.S
>>>>>>>>>>>>                LD      .tmp_vmlinux.kallsyms3
>>>>>>>>>>>>                NM      .tmp_vmlinux.kallsyms3.syms
>>>>>>>>>>>>                KSYMS   .tmp_vmlinux.kallsyms3.S
>>>>>>>>>>>>                AS      .tmp_vmlinux.kallsyms3.S
>>>>>>>>>>>>                LD      vmlinux
>>>>>>>>>>>>                BTFIDS  vmlinux
>>>>>>>>>>>>              FAILED: load BTF from vmlinux: No such file or directory
>>>>>>>>>>>>              make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>>>>>>>>>>              make[1]: *** Deleting file 'vmlinux'
>>>>>>>>>>>>              make: *** [Makefile:1264: vmlinux] Error 2
>>>>>>>>>>>>
>>>>>>>>>>>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>>>>>>>>>>> (2241ab53cb).
>>>>>>>>>>>>
>>>>>>>>>>>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>>>>>>>>>>> upstream pahole on master (02d67c5176) and upstream pahole on
>>>>>>>>>>>> next (2ca56f4c6f659).
>>>>>>>>>>>>
>>>>>>>>>>>> Of the above 6 combinations, I think I've tried all of them (maybe
>>>>>>>>>>>> missing 1 or 2).
>>>>>>>>>>>>
>>>>>>>>>>>> Looks like GCC got updated recently on my machine, so perhaps
>>>>>>>>>>>> it's related?
>>>>>>>>>>>>
>>>>>>>>>>>>              CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>>>>>>>>>>>
>>>>>>>>>>>> I'll try some debugging, but just wanted to report it first.
>>>>>>>>>>> hi,
>>>>>>>>>>> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>>>>>>>>>>
>>>>>>>>>>> there will be lot of output with patch below, but could contain
>>>>>>>>>>> some more error output
>>>>>>>>>> Thanks for the hints. Doing a regular build outside of vmtest.sh
>>>>>>>>>> seems to work ok. So maybe it's a difference in the build config.
>>>>>>>>>>
>>>>>>>>>> I'll put a little more time into debugging to see if it goes anywhere.
>>>>>>>>>> But I'll have to get back to the regularly scheduled programming
>>>>>>>>>> soon.
>>>>>>>>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>>>>>>>>> in pahole when CONFIG_X86_KERNEL_IBT is set.
>>>>>>>> could you plese attach your config and the build error?
>>>>>>>> I can't reproduce that
>>>>>>>>
>>>>>>>> thanks,
>>>>>>>> jirka
>>>>>>> My working .config is available at https://pastebin.pl/view/bef3765c
>>>>>>> change CONFIG_X86_KERNEL_IBT to y to get the error.
>>>>>>>
>>>>>>> The error is similar to Daniel's and is shown below:
>>>>>>>
>>>>>>>      LD      .tmp_vmlinux.btf
>>>>>>>      BTF     .btf.vmlinux.bin.o
>>>>>>> btf_encoder__encode: btf__dedup failed!
>>>>>>> Failed to encode BTF
>>>>>>>      LD      .tmp_vmlinux.kallsyms1
>>>>>>>      NM      .tmp_vmlinux.kallsyms1.syms
>>>>>>>      KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>>>      AS      .tmp_vmlinux.kallsyms1.S
>>>>>>>      LD      .tmp_vmlinux.kallsyms2
>>>>>>>      NM      .tmp_vmlinux.kallsyms2.syms
>>>>>>>      KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>>>      AS      .tmp_vmlinux.kallsyms2.S
>>>>>>>      LD      .tmp_vmlinux.kallsyms3
>>>>>>>      NM      .tmp_vmlinux.kallsyms3.syms
>>>>>>>      KSYMS   .tmp_vmlinux.kallsyms3.S
>>>>>>>      AS      .tmp_vmlinux.kallsyms3.S
>>>>>>>      LD      vmlinux
>>>>>>>      BTFIDS  vmlinux
>>>>>>> FAILED: load BTF from vmlinux: No such file or directory
>>>>>>> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>>>>> make[1]: *** Deleting file 'vmlinux'
>>>>>>> make: *** [Makefile:1264: vmlinux] Error 2
>>>>>> I can't reproduce that.. I tried with gcc versions:
>>>>>>
>>>>>>      gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
>>>>>>      gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
>>>>>>
>>>>>> I haven't found fedora setup with 12.2.1 20230111 yet
>>>>>>
>>>>>> I tried alsa with latest pahole master branch
>>>>>>
>>>>>> were you guys able to get any more verbose output
>>>>>> that I suggested earlier?
>>>>>>
>>>>>> jirka
>>>>> I compiled with and without IBT using the -V on pahole (LLVM_OBJCOPY=objcopy pahole -V -J --btf_gen_floats -j .tmp_vmlinux.btf) and the outfiles are a little too big (540MB). The error happens with this CONST type pointing to itself. That does not happen with the IBT option removed.
>>>>>
>>>>> $ grep  -n "CONST (anon) type_id" /tmp/with_IBT  | more
>>>>> 346:[2] CONST (anon) type_id=2
>>>>> 349:[5] CONST (anon) type_id=5
>>>>> 351:[7] CONST (anon) type_id=7
>>>>> 356:[12] CONST (anon) type_id=12
>>>>> 363:[19] CONST (anon) type_id=19
>>>>> 373:[29] CONST (anon) type_id=29
>>>>> 375:[31] CONST (anon) type_id=31
>>>>> 409:[63] CONST (anon) type_id=63
>>>>> 444:[89] CONST (anon) type_id=0
>>>>> 472:[97] CONST (anon) type_id=97
>>>>> 616:[129] CONST (anon) type_id=129
>>>>> 652:[131] CONST (anon) type_id=131
>>>>> 1319:[234] CONST (anon) type_id=234
>>>>> 1372:[246] CONST (anon) type_id=246
>>>>> ....
>>>>>
>>>>> $diff -ru with_IBT without_IBT
>>>>> --- with_IBT 2023-01-31 09:39:24.915912735 -0600
>>>>> +++ without_IBT 2023-01-31 09:46:23.456005278 -0600
>>>>> @@ -340,346 +340,14800 @@
>>>>>    Found per-CPU symbol 'cpu_tlbstate_shared' at address 0x2c040
>>>>>    Found per-CPU symbol 'mce_poll_banks' at address 0x1ad20
>>>>>    Found 341 per-CPU variables!
>>>>> -Found 61470 functions!
>>>>> +Found 61462 functions!
>>>>> +File .tmp_vmlinux.btf:
>>>>> +[1] FUNC_PROTO (anon) return=0 args=(void)
>>>>> +[2] FUNC verify_cpu type_id=1
>>>>> +[3] FUNC_PROTO (anon) return=0 args=(void)
>>>>> +[4] FUNC sev_verify_cbit type_id=3
>>>>> +search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
>>>>> +Found per-CPU symbol 'last_nmi_rip' at address 0x1a018
>>>>> +Found per-CPU symbol 'nmi_stats' at address 0x1a030
>>>>> +Found per-CPU symbol 'swallow_nmi' at address 0x1a020
>>>>> +Found per-CPU symbol 'nmi_state' at address 0x1a010
>>>>> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>> +Found per-CPU symbol 'nmi_cr2' at address 0x1a008
>>>>> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
>>>>> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>> ...
>>>>>
>>>>> And the lines 342-365 of the with_IBT result:
>>>>>        342 Found 341 per-CPU variables!
>>>>>        343 Found 61470 functions!
>>>>>        344 File .tmp_vmlinux.btf:
>>>>>        345 [1] INT long unsigned int size=8 nr_bits=64 encoding=(none)
>>>>>        346 [2] CONST (anon) type_id=2
>>>>>        347 [3] PTR (anon) type_id=6
>>>>>        348 [4] INT char size=1 nr_bits=8 encoding=(none)
>>>>>        349 [5] CONST (anon) type_id=5
>>>>>        350 [6] INT unsigned int size=4 nr_bits=32 encoding=(none)
>>>>>        351 [7] CONST (anon) type_id=7
>>>>>        352 [8] TYPEDEF __s8 type_id=10
>>>>>        353 [9] INT signed char size=1 nr_bits=8 encoding=SIGNED
>>>>>        354 [10] TYPEDEF __u8 type_id=12
>>>>>        355 [11] INT unsigned char size=1 nr_bits=8 encoding=(none)
>>>>>        356 [12] CONST (anon) type_id=12
>>>>>        357 [13] TYPEDEF __s16 type_id=15
>>>>>        358 [14] INT short int size=2 nr_bits=16 encoding=SIGNED
>>>>>        359 [15] TYPEDEF __u16 type_id=17
>>>>>        360 [16] INT short unsigned int size=2 nr_bits=16 encoding=(none)
>>>>>        361 [17] TYPEDEF __s32 type_id=19
>>>>>        362 [18] INT int size=4 nr_bits=32 encoding=SIGNED
>>>>>        363 [19] CONST (anon) type_id=19
>>>>>        364 [20] TYPEDEF __u32 type_id=7
>>>>>        365 [21] TYPEDEF __s64 type_id=23
>>>>>
>>>>> lines 342-362 of without_IBT
>>>>>
>>>>>        342 Found 341 per-CPU variables!
>>>>>        343 Found 61462 functions!
>>>>>        344 File .tmp_vmlinux.btf:
>>>>>        345 [1] FUNC_PROTO (anon) return=0 args=(void)
>>>>>        346 [2] FUNC verify_cpu type_id=1
>>>>>        347 [3] FUNC_PROTO (anon) return=0 args=(void)
>>>>>        348 [4] FUNC sev_verify_cbit type_id=3
>>>>>        349 search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
>>>>>        350 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>>        351 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>>        352 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>>        353 Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>>>>>        354 Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
>>>>>        355 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>>        356 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>>        357 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>>        358 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>>>>>        359 Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
>>>>>        360 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>>        361 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>>>>>        362 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>>>>>
>>>>> If the full debug files are useful or a target grep or diff is better let me know.
>>>>>
>>>> I managed to reproduce this too with IBT enabled; one thing I
>>>> noticed is with pahole built with an up-to-date libbpf and the
>>>> changes in https://github.com/acmel/dwarves/tree/next, the problem
>>>> went away. I didn't have time to root-cause it yet however.
>>>>
>>>> Not sure if you're in a position to do this, but if you can,
>>>> would you mind building pahole from
>>>>
>>>> https://github.com/acmel/dwarves/tree/next
>>>>
>>>> ...and re-testing to see if that helps? Thanks!
>>>>
>>>> Alan
>>>>> Thanks,
>>>>>
>>> I tried with libbpf compiled from master
>>> https://github.com/libbpf/libbpf.git and pahole compiled from next branch on
>>> https://github.com/acmel/dwarve with the same result.
>>> With IBT enabled pahole fails and removing it results in a successful
>>> kernel.
>> hi,
>> in case it slipped, you also need to add new options for pahole:
>>    https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguire@oracle.com/
>>
>> should be added for version 124 for now
>>
>> jirka
>
> Added the patch to include options on pahole but same problem.
> $ pahole --version
> v1.25
> $ ls -l /usr/lib64/libbpf.so.1.2.0
> -rwxr-xr-x 1 root root 422088 Feb  9 13:23 /usr/lib64/libbpf.so.1.2.0
>
>    UPD     include/generated/utsversion.h
>    CC      init/version-timestamp.o
>    LD      .tmp_vmlinux.btf
>    BTF     .btf.vmlinux.bin.o
> LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> .tmp_vmlinux.btf
> btf_encoder__encode: btf__dedup failed!
> Failed to encode BTF
>
> Thanks,
>

I encountered the same problem when building a new kernel and I found some
reasons for the error.

In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
.notes section. In addition, due to historical problems, the alignment of
records in the .notes section is not unified, which leads to the inability of
gelf_getnote() to read the records after the wrong one.

For example:

$readelf -n linux-6.2-rc7-with-IBT/.tmp_vmlinux.btf
Displaying notes found in: .notes
   Owner               Data size   Description
   GNU                  0x00000020       NT_GNU_PROPERTY_TYPE_0
       Properties: x86 feature used: x86, x87, MMX, XMM, FXSR, XSAVE
         x86 ISA used: x86-64-baseline, x86-64-v2, x86-64-v3
   Linux                0x00000004       func
    description data: 06 00 00 00
readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
readelf: Warning: type: 0x78, namesize: 0x100, descsize: 0x756e694c, alignment: 8

$readelf -n linux-6.2-rc7-no-IBT/.tmp_vmlinux.btf
Displaying notes found in: .notes
   Owner              Data size   Description
   GNU                  0x00000020       NT_GNU_PROPERTY_TYPE_0
       Properties: x86 feature used: x86, x87, MMX, XMM, FXSR, XSAVE
         x86 ISA used: x86-64-baseline, x86-64-v2, x86-64-v3
   GNU                  0x00000014       NT_GNU_BUILD_ID (unique build ID bitstring)
     Build ID: 073b8e5b0373cdc806fac20a9559461be75570a8
readelf: Warning: note with invalid namesz and/or descsz found at offset 0x58
readelf: Warning: type: 0x756e694c, namesize: 0x4, descsize: 0x101, alignment: 8


As shown above, whether IBT is enabled or not, readelf can't read all records
in the .notes section. And gelf_getnote() has the same behaviour.

In dwarf_loader.c:3001, cus__merging_cu() determines whether cu(compile unit)
should be merged by detecting the value of LINUX_ELFNOTE_LTO_INFO. It is from
https://github.com/torvalds/linux/blob/master/include/linux/elfnote-lto.h#L9,
and its value must be 0 or 1. But in the above output from readelf, it reads
"06 00 00 00"(=6), which is impossible. This confirms that the .notes record
has format compatibility problems. There's also something similar at
https://lore.kernel.org/linux-arm-kernel/20210428172847.GC4022@arm.com/

dwarf_loader.c:3001 uses "!= 0" for judgement. So with IBT=y, gelf_getnote()
reads "0x6" and return "true"; while gelf_getnote() crushed before reading the
LINUX_ELFNOTE_LTO_INFO with IBT=n, and returns the right result("false")
coincidently. Since the kernel is not built with CONFIG_LTO, merging compile
units will lead to undefined behaviors.

Specifically, there are tags such as DW_TAG_unspecified_type in the origin cus,
but were filtered out in BTF encders. This causes the small_id(dwarf reader assigned)
is malposed with the offset(which btf encoder uses), and finally leads to the
"btf__dedup failed!" error.

There's an simple fix for pahole. To some extent, this prevents cus__merging_cu()
from being disturbed by alignment errors, but the fundamental solution is to
fix the alignment problem of .notes section.

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a77598d..b2e9863 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2998,7 +2998,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 				if (strcmp((char *)data->d_buf + name_off, "Linux") != 0)
 					continue;
 
-				return *(int *)(data->d_buf + desc_off) != 0;
+				return *(int *)(data->d_buf + desc_off) == 1;
 			}
 		}
 	}
-- 
2.39.1

