Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01A34F4FE
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 01:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhC3XZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 19:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhC3XZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 19:25:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593DC061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 16:25:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so27243547ejj.7
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9koZmPAEJRzgIrDt2bRH7p1u7OXFB+s4KAn7zzhv0Qs=;
        b=kN12xr53qkE+ha75AdVo9hwQDRY8p8LwQmPkCbVVvJd16jucH5b8sddO0qEgB7sRq/
         aEHo174vR3Htc54KfwLgm/m5qCRjqJ+pX38mgH2ZeO0idE32IKcn24f9/qPKH4KdcED5
         x3/X5lFWcga0JmWNxrdJGj79G7bsGREK4LOs/tlnxTQMRay1W0+ygHZuCelKhWdKjYGq
         WLncbo61i6qgAxAuTm/NzpHVlzRWH5ZIximPuriDBuJVCMpvQty9NbLFIXUTRdIVtmt3
         ad1DAKgO0NYgDCtXMUBCTBPRREtqrMIXXCeYlUhEe7wkApU6guGi7h0LFVZ0rwb1YKQC
         LLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9koZmPAEJRzgIrDt2bRH7p1u7OXFB+s4KAn7zzhv0Qs=;
        b=FIbDNJnDGOa2Wz+DQb0uD6xYoiREobwCpVp6b+7RklwAXf6wQiuI2xy+/cC09zfjV/
         yLxtVQKlPFW3ZP2+WxjhNYYjxSQxmyyNkcK716CKcqzZx4uQ6AnL6Z+UkWDsKW7/+OtC
         ty0tjMH43R2LnvURftflDACrNG6VRFhYkl55Wel6YIt5we7ebkhGJWF0Tv+pUPHR5KII
         cSTRrkvHLgOTcwJem0H+6P+O/kJ3rT86Y9CV/QwGV2aC35gv1SPlMZjgRrMPNR34LUcY
         hpSV9vixYhiPbr3NAB4rM8Kgb1yepGXaqH6Af8RnBor+LQHrzhd2EKjxgk0xBtoHzP62
         qQWQ==
X-Gm-Message-State: AOAM533c7YxlGxuHGJso0/OaU87ZY7kutZbW7XbAkSBpc3gwz4vasVBy
        +dUqG3I0Gdoqe/bnpLtG0jrcEiIerhHTMslcJAcB
X-Google-Smtp-Source: ABdhPJwoMMyhbBg/Tm30M4IY3OEPbbFWNKTZ9kPmmgYoYBjwigWdO4kI4/DPfL5xKJ0DsCtLUXdCmNd7Wa/qFotWq7M=
X-Received: by 2002:a17:906:af97:: with SMTP id mj23mr562304ejb.419.1617146713855;
 Tue, 30 Mar 2021 16:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210328201400.1426437-1-yhs@fb.com> <20210328201415.1428856-1-yhs@fb.com>
 <CAGG=3QUxQ+xfY9n8n+5QrTPAR4TDp=_TNfXtnKY32YZXH9WBaA@mail.gmail.com>
 <26c68f0c-6be9-7af5-0182-44e5a59f243f@fb.com> <CAGG=3QVHfkPanWc20HcjJJO57ynUfE3ZV4SV_SKEOHyEujw5qQ@mail.gmail.com>
 <a71634a6-4b91-1af0-a5aa-11623d391464@fb.com>
In-Reply-To: <a71634a6-4b91-1af0-a5aa-11623d391464@fb.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 30 Mar 2021 16:25:02 -0700
Message-ID: <CAGG=3QVX78tV80BSniB=xNkfhbD+tBEqvmpemDyhTdKxdZC_6A@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/3] dwarf_loader: permit merging all dwarf
 cu's for clang lto built binary
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 3:28 PM Yonghong Song <yhs@fb.com> wrote:
> On 3/30/21 2:44 PM, Bill Wendling wrote:
> > On Tue, Mar 30, 2021 at 1:15 PM Yonghong Song <yhs@fb.com> wrote:
> >> On 3/30/21 1:08 PM, Bill Wendling wrote:
> >>> On Sun, Mar 28, 2021 at 1:14 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>> For vmlinux built with clang thin-lto or lto, there exist
> >>>> cross cu type references. For example, the below can happen:
> >>>>     compile unit 1:
> >>>>        tag 10:  type A
> >>>>     compile unit 2:
> >>>>        ...
> >>>>          refer to type A (tag 10 in compile unit 1)
> >>>> I only checked a few but have seen type A may be a simple type
> >>>> like "unsigned char" or a complex type like an array of base types.
> >>>>
> >>>> To resolve this issue, the tag DW_AT_producer of the first
> >>>> DW_TAG_compile_unit is checked. If the binary is built
> >>>> with clang lto, all debuginfo dwarf cu's will be merged
> >>>> into one pahole cu which will resolve the above
> >>>> cross-cu tag reference issue. To test whether a binary
> >>>> is built with clang lto or not, The "clang version"
> >>>> and "-flto" will be checked against DW_AT_producer string
> >>>> for the first 5 debuginfo cu's. The reason is that
> >>>> a few linux files disabled lto for various reasons.
> >>>>
> >>>> Merging cu's will create a single cu with lots of types, tags
> >>>> and functions. For example with clang thin-lto built vmlinux,
> >>>> I saw 9M entries in types table, 5.2M in tags table. The
> >>>> below are pahole wallclock time for different hashbits:
> >>>> command line: time pahole -J vmlinux
> >>>>         # of hashbits            wallclock time in seconds
> >>>>             15                       460
> >>>>             16                       255
> >>>>             17                       131
> >>>>             18                       97
> >>>>             19                       75
> >>>>             20                       69
> >>>>             21                       64
> >>>>             22                       62
> >>>>             23                       58
> >>>>             24                       64
> >>>>
> >>>> The problem is with hashtags__find(), esp. the loop
> >>>>       uint32_t bucket = hashtags__fn(id);
> >>>>       const struct hlist_head *head = hashtable + bucket;
> >>>>       hlist_for_each_entry(tpos, pos, head, hash_node) {
> >>>>               if (tpos->id == id)
> >>>>                       return tpos;
> >>>>       }
> >>>>
> >>>> Say we have 9M types and (1 << 15) buckets, that means each bucket
> >>>> will have roughly 64 elements. So each lookup will traverse
> >>>> the loop 32 iterations on average.
> >>>>
> >>>> If we have 1 << 21 buckets, then each buckets will have 4 elements,
> >>>> and the average number of loop iterations for hashtags__find()
> >>>> will be 2.
> >>>>
> >>>> Note that the number of hashbits 24 makes performance worse
> >>>> than 23. The reason could be that 23 hashbits can cover 8M
> >>>> buckets (close to 9M for the number of entries in types table).
> >>>> Higher number of hash bits allocates more memory and becomes
> >>>> less cache efficient compared to 23 hashbits.
> >>>>
> >>>> This patch picks # of hashbits 21 as the starting value
> >>>> and will try to allocate memory based on that, if memory
> >>>> allocation fails, we will go with less hashbits until
> >>>> we reach hashbits 15 which is the default for
> >>>> non merge-cu case.
> >>>>
> >>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>>> ---
> >>>>    dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>    1 file changed, 120 insertions(+)
> >>>>
> >>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
> >>>> index aa6372a..a51391e 100644
> >>>> --- a/dwarf_loader.c
> >>>> +++ b/dwarf_loader.c
> >>>> @@ -51,6 +51,7 @@ struct strings *strings;
> >>>>    #endif
> >>>>
> >>>>    static uint32_t hashtags__bits = 15;
> >>>> +static uint32_t max_hashtags__bits = 21;
> >>>>
> >>>>    static uint32_t hashtags__fn(Dwarf_Off key)
> >>>>    {
> >>>> @@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static bool cus__merging_cu(Dwarf *dw)
> >>>> +{
> >>>> +       uint8_t pointer_size, offset_size;
> >>>> +       Dwarf_Off off = 0, noff;
> >>>> +       size_t cuhl;
> >>>> +       int cnt = 0;
> >>>> +
> >>>> +       /*
> >>>> +        * Just checking the first cu is not enough.
> >>>> +        * In linux, some C files may have LTO is disabled, e.g.,
> >>>> +        *   e242db40be27  x86, vdso: disable LTO only for vDSO
> >>>> +        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
> >>>> +        * Fortunately, disabling LTO for a particular file in a LTO build
> >>>> +        * is rather an exception. Iterating 5 cu's to check whether
> >>>> +        * LTO is used or not should be enough.
> >>>> +        */
> >>>> +       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> >>>> +                           &offset_size) == 0) {
> >>>> +               Dwarf_Die die_mem;
> >>>> +               Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
> >>>> +
> >>>> +               if (cu_die == NULL)
> >>>> +                       break;
> >>>> +
> >>>> +               if (++cnt > 5)
> >>>> +                       break;
> >>>> +
> >>>> +               const char *producer = attr_string(cu_die, DW_AT_producer);
> >>>> +               if (strstr(producer, "clang version") != NULL &&
> >>>> +                   strstr(producer, "-flto") != NULL)
> >>>
> >>> Instead of checking for flags, which can be a bit brittle, would it
> >>> make more sense to scan the abbreviations to see if there are any
> >>> "sec_offset" encodings used for type attributes to indicate that LTO
> >>> was used?
> >>
> >> Do you have additional info related to "sec_offset"? I scanned through
> >> my llvm-dwarfdump result and didn't find it.
> >>
> > Sorry about that. It was the wrong thing to check. I consulted our
> > DWARF expert here and he said this.
> >
> > "DW_FORM_ref_addr is the important thing used for cross-CU references,
> > like in the DW_AT_abstract_origin of the DW_TAG_inlined_subroutine. In
> > intra-CU references, DW_FORM_ref4 is used instead."
>
> Thanks. I checked with lto dwarf, it should work. The only drawback is
> that it needs to traverse all DW_TAG_inlined_subroutine
> and DW_TAG_type's in the cu. If nothing found, going to the next.
> This is exactly what I tried to avoid in the beginning, going deep
> in the dwarf cu. I could remember the maximum and minimum of the ref.
> type tags for each cu, if it is beyond the current cu
> range, it means cross-cu access. But I didn't use this approach
> as it is something every pahole user will pay the price regardless
> of whether their binary is lto or not (mostly probably not.)
>
> I checked my current vmlinux-lto. I will be able
> to find a DW_FORM_ref_addr in the 5th cu. May not be too bad.
> We could have a heuristic to only check the first 10 cu's.
> If no cross cu reference, that means not lto. Not perfect.
> But for sure we don't want to go through all cu's just to
> find it is not lto build.
>
> Still feel we should get whether it is a lto built binary
> as soon as possible. With an explicit option, compiler flags
> seem second choice...
>
That's a good point. It sounds like restricting the search to the
first X CUs will be even more brittle than looking at the command line
flags. It's probably fine then to go with what you originally have.
Sorry for the noise.

-bw
