Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12636DEC45
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLHLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDLHLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 03:11:09 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2153.outbound.protection.outlook.com [40.92.63.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B52708;
        Wed, 12 Apr 2023 00:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8o7398FxOiNjM9CdXIgoPMTXxMZDMNyoxaukg/0Qevy+UayTQQpxbnEd4yv/L0DosVVNTFPqAo5sw4I3hTjgOo90HZx7paGbWuhfflO+LGrzdWynOaAA4rB4DNXSn0KwvzvOF4vhJjKewBh1Z/0k9QnM0e8oWO9j7J+y58tIFhpvl3eK9+IlolDJIoiK3IubFbtTKVMk/2CPY0elXaGC1rpZOAAnE2+G0/UcdQ1wInnbX0ewHPs2TcDk6NO82xp5R6P4+MRDvA8IBh0LXJkbauSF3l0BYPVTKdjbYVidddD6zBNapWuL0yUXH3J4Gx2O9xRbBInj874KLZZ2gtW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VliPxvHJYl3OqGPzruBwHTL3OqCfGqGw2Ondvjo3kKc=;
 b=GSdrXLZS6o9kmYAYa7ZwvrRmjN3xaCr22lj+PIVrhBSdwGm6B4QSmqtk/8kT9J4A7Oli6/sB8MPaW/4qqz3GdPqfaTnd4wSj67zbWtvLxk2kaL0RtnxEeOxMwaaAgx4JaUbgPG7EmHqwWNPFBTofQNL+1hDhVf0mnokrbvAMU5bZ73dtyRbjMk3tVdDFRU37qKPodE6aHTjciL85Rh7iOH+rvF7PY9ry0XDn3ER86ifv5cInIq9NJY4cRqZC22osEwoXbnttZiynT932eACrU7dtc4M6/UnQDpvN90JKgcoNQ3/LwC2MlarzslgxJee/iXb6m3M29oUV0WfLEnMLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VliPxvHJYl3OqGPzruBwHTL3OqCfGqGw2Ondvjo3kKc=;
 b=LL4ww/nSEEQ83UO79+4+AeJA4I4q5uNaQBubvmQp4WTYbS+4kLnml9KBaOeYL0rmY8J3oXeOiLnN6tqJ3Shdh7UH2EX+kZAhiVxwpDLuutKudIMVVdOo0YQMfM5ECfFCxGTbW0EuZ9O5WGew8RLgDbpB+Ll8F61Byzor0Qvivb7KdwXAO0NS43+bMptRzpKXYZ3uVUOUp31dTljweqlwj+lokJmVbJrTXfj5vMjKGBoCSNmAjRlCb4FdQ+tYrHLPPnVZuouzG4ShVNqRGs6AoHvNOLCv0PrfPuDCaXTiR62RDKxkqUneVdFSsBT0/fCAfhRWwh1+i6uzK6XU2gQT+A==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 MEAP282MB0472.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:6b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28; Wed, 12 Apr 2023 07:10:59 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c096:a7b5:2bf5:2645%6]) with mapi id 15.20.6298.029; Wed, 12 Apr 2023
 07:10:59 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     jpoimboe@kernel.org
Cc:     acme@kernel.org, alan.maguire@oracle.com, alexandref75@gmail.com,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, i.pear@outlook.com,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Wed, 12 Apr 2023 15:10:14 +0800
Message-ID: <SY4P282MB10847ED9277ECA2E7B8A52779D9B9@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411170058.7677oximl7oq4hkv@treble>
References: <20230411170058.7677oximl7oq4hkv@treble>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [rj92RrdQ6WmFMTI2lHC8NSV2W0pZwROgdEDe89ISvQEIedHfZDg94g==]
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230412071014.367405-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|MEAP282MB0472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8781dd-0f38-4eae-beef-08db3b25114a
X-MS-Exchange-SLBlob-MailProps: TdjdgrWvJeTLPQ2QVZQqgzGSlPzYkFhk5wHcPopXyNbgui4DhGlsTL9Xpe3elDviamxLQ6/veqkYtuB1WRAoGXRchbFM2bRoin6hSRFmMg+jMTPFjDAbpPTCWFPztArWa5a7mVWd9PBWpDq/e33+6bGqg2uxycvju8KcasKRfTyEt0Y5z5CL0sXjLmSVlNlvKLpJrZ39V01TOlaajaL0le9f/9yqEpohVCzwBJEvrrGwU1tpFk2mbHDY1WDuX6C45ePRiaHqo4H4LeSi//U7GddorXuU/NV1ElET2N2aIlo2gm8HJNTqva6ZxkZKtJaakT2tqtDxcUdc1Qo/ySwvaoggNXyVfK7XKyF8eSEY1mdp30+BdGg37COyCYstjZD3OFWwUc6JpakEaw82Khgy5drwzuZnWTo9+28Qe6nCrkO28en+kWJtn5ZiNeCzeoKNsEzGAa5GONhz65l2Df0jMN0eP+QUpH/offtgBL6lzODVBgh+OwA/ujx9YmcFSY2rVR5LCTW/oLtsDLDDordFWGg74Vwrs04xoQNpYcYbEk3jyikBAD1QbgsfelWq/NlZXA3TG12xydIXRyBcZcwuo7tJcY1H8pFsw3gxkS6PDHDgrJWCtAwE+WTm/+GnvRjxeWaaLI1Czrpy5C/odW7/2JUN/1d9a7EGvRen+38H/hVbd52pHa4egDfvdBg8Nxzr/hpEMzlIber8kTttpVNws/GNO1qNQvgF8sE7eJmdgOU77ITdGileU+u4tIXUOpA9hxUnbCc67MIbBLCF1TZ7ID126vXMPcPgEKdZDaGLSu2/EzyBVt+5GZlFuvCLUPnDSBFz8jflphA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ji72+kwgy3Sn316m6HfY8BCapUNU5GU2DE6JI9mFr2zJ2RLRxKlGi5ESYwbDwYhMJKH5y35RTGU9xAewuqKrQ9TbIk2EF0Z4bd3ODTZKzR4SvHwjk/DYhizMzHd4kpvMJbD4C5vtbyBSES9y1iR4DAloH9j/0i7oCIVxmDWrA5QXN7YSLQP4fsqv4gV0U7ZK2GLpL24eUZP6d/XzlFKsG793c0fmmkv0yPBp+0ENHapE1Mle19xJ+cbKGECFd+xeh2okq+x8kZquROOpViKPMOZqvxRYp5vYTb4LUJ6/ZZO0+cKXw4tXr98I1zg/c7HzEyp7yLLpF0bifADVwARkdFPz0lsj6VHU00nYKlEvW8jWmlj3EDPOh1zZm6tjCFTYqfka/pKbxYK1VecBtasIH0INRjYTTjWgyrO5vja864F56WIhB5PsrYabQJy+VuS3DCTh/7CkxWYJb5O0egb6L0BxgBsR+v4f4TfG2xCJwohcXqqXJqGJe+DAVRvdmn9KpnyHUWvfNOJPqMyPIlpMbRwtsoyjgNeQ/5WKazIFAlRlrGgn2m6mshoDwzDrorZ24D/sNWVBzizkNvOdKHO/jeqC8hQNkN4y0UsievnZjdMRyupKd2tbyddGF+buzuvpQg1vtackBm8JLdqtmXU1Q/BhWtwKCHSGhYlJrC8JoDU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BENIMwTA1DnZmTPZoLPZuorGGFnJs21I4U9CXZk7WAujylCfYBXtZvMhdu1o?=
 =?us-ascii?Q?/p2rfeGMXED8CE9N/FtckqL+W+mL5SZr1RFWN5xu86f7YNI8jP5CObttP7dL?=
 =?us-ascii?Q?KSjv4VcJjp4zNZc+647kxdRVMj9n+JH+5zcnQbxgHB/AdiMfd9ELyLpdkaTK?=
 =?us-ascii?Q?MW1sqijmMJqG4vLcdolm/nONQNkhQN/OmE1/YQbOL4zDIuQqUX9/e21+cimP?=
 =?us-ascii?Q?qWwnCjO5Dd9KvEXuB7MNUyQBnv7wqTS3zN0NuIB+qD6EP2+LlKbYHJkdr8eL?=
 =?us-ascii?Q?pH1qFWIN6pY5EWcKcyOgE9eNJM6nKa+mhqfK0lJIoBqUkuBdOXpypgDobHrs?=
 =?us-ascii?Q?5RH948A5wbrUB6HdQ0zh4laBxGu/rg/oHLHJF6OxEqpYrtU8t6VNcTBjSN30?=
 =?us-ascii?Q?1ofHIfyhqvlFchQPs7z6j96yFPQ1qxTh6ISyZaQWzNpMzBQtMUEMHTC6lKPq?=
 =?us-ascii?Q?GB+FfTvHNeggAYzS8Musp2ps+SNi+T04SbYXizGKYCLmEF5O0CFDHSfgDzcc?=
 =?us-ascii?Q?T+gwFsYaOiHCNiWLprAwvv6Oyv4GGbY3C9fMCeH9S97c39gdJe+riL5K418h?=
 =?us-ascii?Q?+rR7rrgmaS18Hsco8bdTAHiBpUYV+G5oCMbErxlTFuhBejCbKPvcVOmFj1Ze?=
 =?us-ascii?Q?KaUaQ62lTh4XMxHioDFFi+g2Fqy+lQQ9t2LCiyBlRDjftPFGjoj+IRMm+OEq?=
 =?us-ascii?Q?Aym4R4rtIsloxDIOy4THHvAwb9DetYjaZkmNBhsW5Vxou2OZB3itGL++Uqh+?=
 =?us-ascii?Q?0ZMGNFeDNFXrWfpmKmHKn+Up01kd/27m/qCEZk+qZhUVOkNlJ5AXtHwf0L1K?=
 =?us-ascii?Q?SBSurQR6CutNDzd10JYIoxttl9HQXTq+Bm4ssvxyiTg3fAWKD4PMvvuMSSSM?=
 =?us-ascii?Q?GO0u4YGJ6gcLRarCdTmstcHLrf1CvxZUlKglKjo3YL+3xx2824e9eFAWetsv?=
 =?us-ascii?Q?NnUHD6Kfqk9iaH/NIyeF1cowUgamKeI7bDhldCng1KBT4+86gz7o4pILv9Gl?=
 =?us-ascii?Q?b7UsTMewTwuPUUKh+HCXr78zON40geLEJ2IHjlC+j0Fh50Eu7z6e8vaq+lX9?=
 =?us-ascii?Q?uhEL0g+/T5788y/8xM2JgsCuWTpEYDHt7+2pHLhaYWM6UVqURxI6qK+tfnAn?=
 =?us-ascii?Q?FSJu5B45nJTRQi8ihJEaXcG6jad2PgPKhqLXB1Y1VgkHfLGJZuTSQvEOebNM?=
 =?us-ascii?Q?d95S64f0iTFCz9OJHbGoIiGcowGb9aGCrfBaMCkzUciAgXr+D7j24RsgT0qg?=
 =?us-ascii?Q?jCikhu8kaXjHYPuzSeII?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8781dd-0f38-4eae-beef-08db3b25114a
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 07:10:59.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 17:00 , Josh Poimboeuf wrote:
> On Tue, Feb 14, 2023 at 02:33:02PM +0800, Tianyi Liu wrote:
> > > LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> > > .tmp_vmlinux.btf
> > > btf_encoder__encode: btf__dedup failed!
> > > Failed to encode BTF
> > >
> > > Thanks,
> > >
> >
> > I encountered the same problem when building a new kernel and I found some
> > reasons for the error.
> >
> > In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
> > .notes section. In addition, due to historical problems, the alignment of
> > records in the .notes section is not unified, which leads to the inability of
> > gelf_getnote() to read the records after the wrong one.
> 
> Alexandre, Tianyi, are you still seeing this issue with the latest
> dwarves?  If so can you confirm the below patch fixes it?
> 

Josh, first of all, thank you very much for your help. However, this patch
doesn't work in my environment. I am using gcc 12.2.1 20230201.
After compiling, when I use readelf -S to view ELF sections,
the align of .notes section is still 8:

$ readelf -S .tmp_vmlinux.btf
[20] .notes            NOTE             ffffffff8250b570  0170b570
     0000000000000084  0000000000000000   A       0     0     8

> Apparently the latest dwarves release fixes it on Fedora Rawhide [1],
> does anybody know if there a specific dwarves and/or libbpf change for
> this?
> 

It has been fixed in dwarves[1], but it may just be a coincidence.

> [1] https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2346#note_1348057786
> 
> ---8<---
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
> 
> When tooling reads ELF notes, it assumes each note entry is aligned to
> the value listed in the .note section header's sh_addralign field.
> 
> The kernel-created ELF notes in the .note.Linux and .note.Xen sections
> are aligned to 4 bytes.  This causes the toolchain to set those
> sections' sh_addralign values to 4.
> 
> On the other hand, the GCC-created .note.gnu.property section has an
> sh_addralign value of 8 for some reason, despite being based on struct
> Elf32_Nhdr which only needs 4-byte alignment.
> 
> When the mismatched input sections get linked together into the vmlinux
> .notes output section, the higher alignment "wins", resulting in an
> sh_addralign of 8, which confuses tooling.  For example:
> 
>   $ readelf -n .tmp_vmlinux.btf
>   ...
>   readelf: .tmp_vmlinux.btf: Warning: note with invalid namesz and/or descsz found at offset 0x170
>   readelf: .tmp_vmlinux.btf: Warning:  type: 0x4, namesize: 0x006e6558, descsize: 0x00008801, alignment: 8
> 
> In this case readelf thinks there's alignment padding where there is
> none, so it starts reading an ELF note in the middle.
> 
> With newer toolchains (e.g., latest Fedora Rawhide), a similar mismatch
> triggers a build failure when combined with CONFIG_X86_KERNEL_IBT:
> 
>   btf_encoder__encode: btf__dedup failed!
>   Failed to encode BTF
>   libbpf: failed to find '.BTF' ELF section in vmlinux
>   FAILED: load BTF from vmlinux: No data available
>   make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> 
> Fix it by forcing the .notes section input and output alignments to 4 to
> match the kernel's note entry alignments.
> 
> Note this doesn't break the 8-byte-aligned .note.gnu.property entries
> because their internal data representations fill the entire 8-byte
> alignment boundary, so there's no padding between entries to be
> misinterpreted.  And there's only a single entry in that section anyway.
> 
> Reported-by: Daniel Xu <dxu@dxuuu.xyz>
> Debugged-by: Tianyi Liu <i.pear@outlook.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d1f57e4868ed..1c7c87c9ae71 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -894,7 +894,7 @@
>   */
>  #define NOTES                                                           \
>          /DISCARD/ : { *(.note.GNU-stack) }                              \
> -       .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> +       .notes ALIGN(4) : AT(ADDR(.notes) - LOAD_OFFSET) SUBALIGN(4) {  \
>                  BOUNDED_SECTION_BY(.note.*, _notes)                     \
>          } NOTES_HEADERS                                                 \
>          NOTES_HEADERS_RESTORE
> --
> 2.39.2

[1] https://github.com/acmel/dwarves/commit/a9498899109d3be14f17abbc322a8f55a1067bee
