Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3824964119E
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiLBXnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 18:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiLBXnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 18:43:39 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA54ED6AE
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 15:43:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z20so8333026edc.13
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GhYw/MP2P/kk33kERZBpJ7c0CjgQmqx4q329Et5K3HM=;
        b=eHglnY9NxMIjZg11fxu45XxV7dE0WJnbWIKn/xQeDgFSw6Um9yf154kKHBRJV1/Mik
         aT9vQnWDUe5yF/g2d2AoLrICN7tpR24sNqinHzWXKfCJlULAjXtNvpcurH3DW2dosWsO
         5J8aSwl12yEil5UBYFTcL7BRJvnzgIa+DAtjMbHJf9mNRBbtiHuodY130ROSBwt74tH1
         fvD9C3t+jRGaULJ6gm/YZx5kNYHCyF3cZnoo1tCfbPZd9hXgNpTK2CzNJ3Jr8rtbZWWf
         gUmPxpaGUeeRzRTspbNfwrYoeYyaVpnsxZKat2ntahOgUmlC/nsRw5jq51TRAzlCubz/
         CH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhYw/MP2P/kk33kERZBpJ7c0CjgQmqx4q329Et5K3HM=;
        b=60pCRtkMUDMKfCTM1kE5ctPAe2kJlpiQsnjwgRFoEogl5v6iXJI7JrGyc6NmlLs/31
         7zdFUAb3qTovtETwotpUXIXvI/+SQMDLEPiclLeX8vWw2YQ/2+zvKjeY8YySxYznHFzw
         dGLyBHYob2ty99nlTMaQWUt/o04eAXhQ7UpyzLD2OkNi0ZwbvGOVknxDSeUGu+1qAFh0
         Ydzl8FttbAgqxhLOSTigt28cGmpF3je7rylLAuN+XC8jMzLxnS8hb8y42vEEjscsX4LB
         Qs16yQMWgSbN1ndXm7Yn7FFegdfHKiUt39wZ4Rq7xaZ14KzPMS2uYeCjhIyrqLcnvEy2
         B0NA==
X-Gm-Message-State: ANoB5pnnV5uv7vLs0+/67PSm+o5ACeF6IOGESPpV9RORNhIHh/FzCwQc
        nJnceYRLAuBu1HZYhtAHx4YbfQlukjLQzC0oMqpetpDj
X-Google-Smtp-Source: AA0mqf5VeIAwTvBhG6dmRDYhBucoGA8Q/GxVfev2DIyPrJY0mP3fSnxo7EYSJBrTw+0v5tprqYL5NIb+adDtaV4oepA=
X-Received: by 2002:a05:6402:4008:b0:458:dd63:e339 with SMTP id
 d8-20020a056402400800b00458dd63e339mr46818651eda.81.1670024616144; Fri, 02
 Dec 2022 15:43:36 -0800 (PST)
MIME-Version: 1.0
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
 <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzZtOUXxKurpmHzsZ+8FP6aahUNEmcPz=Rr=gkuQPu0yaA@mail.gmail.com>
 <658aa4e6-d1ea-c518-0c0d-318811eb48fd@oracle.com> <CAEf4Bzb0Se8n4uO1UDWzQf3t_eYF6Eor8_nRqO5QR77Cdp669A@mail.gmail.com>
 <d51186d9-076b-1905-97f6-4debea92d3ed@oracle.com>
In-Reply-To: <d51186d9-076b-1905-97f6-4debea92d3ed@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Dec 2022 15:43:24 -0800
Message-ID: <CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/5] libbpf: provide libbpf API to encode BTF kind information
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 2:38 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 29/11/2022 17:01, Andrii Nakryiko wrote:
> > On Tue, Nov 29, 2022 at 5:51 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> <snip>>>> I really don't like this approach, even if *technically* it would
> >>> work. But even if so, it would add quite a bunch of size to BTF just
> >>> to self-describe it.
> >>>
> >>> Let's go again (and in more detail) over my alternative proposal I
> >>> briefly described in another email thread.
> >>>
> >>> So, what I'm proposing is similar in spirit and solves all the same
> >>> goals you have (and actually some more, I'll point this out below).
> >>> The only downside is that we'll need to, again, teach kernel to
> >>> understand this BTF format extension to allow kernel to use it (so we
> >>> still will need an opt-in flag for pahole, unfortunately, but
> >>> hopefully just this one time). That's pretty much the only downside.
> >>> But it's more compact, simpler and more straightforward, more elegant
> >>> (IMO), and it is easy for libbpf to sanitize it for old kernels.
> >>>
> >>> Ok, so it's pretty much completely described by these changes:
> >>>
> >>> --- a/include/uapi/linux/btf.h
> >>> +++ b/include/uapi/linux/btf.h
> >>> @@ -8,6 +8,21 @@
> >>>  #define BTF_MAGIC      0xeB9F
> >>>  #define BTF_VERSION    1
> >>>
> >>> +struct btf_kind_meta {
> >>> +       /* extra flags, initially define just one:
> >>> +        * 0x01 - required or optional (is it safe to skip if unknown)
> >>> +        */
> >>> +       __u16 flags;
> >>> +       __u8 info_sz;
> >>> +       __u8 elem_sz;
> >>> +};
> >>> +
> >>> +struct btf_metadata {
> >>> +       __u8 kind_meta_cnt;
> >>> +       __u32 :0;
> >>> +       struct btf_kind_meta[];
> >>> +};
> >>> +
> >>>  struct btf_header {
> >>>         __u16   magic;
> >>>         __u8    version;
> >>> @@ -19,6 +34,8 @@ struct btf_header {
> >>>         __u32   type_len;       /* length of type section       */
> >>>         __u32   str_off;        /* offset of string section     */
> >>>         __u32   str_len;        /* length of string section     */
> >>> +       __u32   meta_off;
> >>> +       __u32   meta_len;
> >>>  };
> >>>
> >>
> >> Ok, if we're going this route though, let's try to think through any
> >> other info we need to add so the format changes are a one-time thing.
> >> We should add flags too. One current use-case would be the
> >> "is this BTF standalone, or does it require base BTF?" [1]. Either using
> >> an existing value in the header flags field, or using the space for a flags
> >> field in  struct btf_metadata would probably make sense.
> >
> > Yes, it's a good idea. But instead of a flag, I wonder if we should
> > add some sort of "build ID" concept here, so that we can check
> > validity of base BTF as expected by split BTF?
> >
>
> I think that would be valuable; it would be great to be able
> to spot up-front an incompatibility between split and base
> BTF. Are you thinking a hash over the type and string sections
> or similar? Any such id shouldn't require actual BTF parsing
> I think, since a simple validation could occur absent actual

yep, I was thinking of just a simple CRC32 as a checksum algorithm?

> parsing of the base BTF object. Would we maintain an id
> for base and split BTF, or just record the base id in split BTF
> to validate the base? Not needing to recompute the base id
> each time for module BTF generation seems like it would make
> it worthwhile to record the BTF id of the current object as well
> as the id of the base object it is built upon.

I'd record "my checksum" and "base checksum, if split"? I presume zero
is a valid value for CRC32, so probably a separate flag for whether
BTF is split or not would be necessary after all.

>
> So something like
>
> struct btf_metadata {
>         __u32 id;
>         __u32 base_id;

so these are not IDs, that shouldn't be confused with kernel's BTF
object ID. It's checksums.

>         __u8 kind_meta_cnt;
>         __u32 :0;
>         struct btf_kind_meta[];
> };
>
> ...where a 0 base_id implies the object is a root/standalone BTF object?

see above, probably need a separate flag, because zero might be a valid checksum

>
>
> >>
> >> Do we have any other outstanding issues with BTF that would be eased
> >> by some sort of up-front declaration? If we can at least tackle those
> >> things at once, the pain will be somewhat less when updating the toolchain.
> >
> > Base vs split BTF + some check whether base BTF is valid is the only
> > thing that currently comes to mind.
> >
>
> The topic of multiple levels of split BTF has come up before, but I don't
> think that has any additional implications from a metadata perspective;
> each level would specify the base_id of the level below.

yep, it's still a split BTF, I don't think any extra stuff is needed.
Technically libbpf already supports multi-level split BTFs.

>
> >>
> >>>
> >>> So, we add meta_off/meta_len fields to btf_header, which, if non-zero,
> >>> will point to a piece of metadata (4-byte aligned) that's described by
> >>> struct btf_metadata.
> >>>
> >>> In btf_metadata, the first byte records the number of known BTF kinds,
> >>> we have three more bytes for extra flags or counters for
> >>> extensibility, they should be zeroed out right now.
> >>>
> >>
> >> Right; see above for one flags use-case.
> >>
> >>> After these 4 bytes we have kind_meta_cnt struct btf_kind_meta
> >>> entries, each 4-byte long. It's a 1-indexed array, where each entry
> >>> corresponds to sequentially numbered BTF kinds. First two bytes are
> >>> reserved for flags and stuff like that. Among those, I think the most
> >>> useful right now would be the "optional flag". If set, it would mean
> >>> that generally speaking it's safe to skip types of that kind without
> >>> losing integrity of the data. So e.g., we could have used that for
> >>> DECL_TAGS, or perhaps even for FUNCs, if we had this metadata back
> >>> then, as these kinds are, generally speaking, not referenced from
> >>> other types (not 100% for FUNCs, as we can have FUNC externs, but
> >>> those came later). Anyways, for kernel needs we can say that optional
> >>> kinds don't cause failure to validate BTF.
> >>>
> >>
> >> This would definitely be useful; but are you saying here that
> >> a struct with a reference to an unknown kind should fail BTF
> >> validation (something like a struct with an enum64 member parsed by a
> >> libbpf prior to enum64 support)? Not sure there's any alternative
> >> for a case like that...
> >
> > From the kernel validation point -- yes, probably. From generic
> > tooling and libbpf-side -- perhaps not. I think kernel will always
> > have to be pretty strict due to security reasons.
> >
> >
> >>
> >>> *But for security reasons we should make the kernel zero-out
> >>> corresponding parts of type information, just to prevent injection of
> >>> well-known data by malicious user*.
> >>>
> >>> Next, to the meat of the proposal. info_sz is size in bytes of an
> >>> additional singular information (e.g., btf_array for ARRAY kind,
> >>> 4-byte info for INT kind, etc) that goes after common 12-byte struct
> >>> btf_type. It can be zero, of course. elem_sz is a size in bytes of
> >>> each nested element (field info for STRUCT, arg info for FUNC_ARG,
> >>> etc). Number of elements is defined by btf_vlen(t), which works for
> >>> any kind, regardless if it's known or not. If elem_sz is zero, KIND
> >>> can't have nested elements (and thus if vlen is non-zero, that's a
> >>> corruption).
> >>>
> >>> That's it. We don't allow mixing differently-sized nested elements
> >>> within a single kind, but we don't have that today and we don't have
> >>> any meaningful ways to express this. And I don't think we'd want to do
> >>> this anyways (there are way to work around that if absolutely
> >>> necessary, as well).
> >>>
> >>> From libbpf's point of view, this metadata section is easy to
> >>> sanitize, as kernel allows btf_headers of bigger size than is known to
> >>> it, provided they are zeroed out. So libbpf will just zero out
> >>> meta_off/meta_len fields, and contents of the metadata section.
> >>>
> >>> As for the size, it adds just 8 + 4 + 19 * 4 = 88 bytes to the overall
> >>> BTF size. It's nothing. I didn't count the total size for your
> >>> approach, but at the very least it would be 19 * 2 * sizeof(struct
> >>> btf_type) (=12) = 456, but that's super conservative.
> >>>
> >>> Note also that each btf_type can always have a name (described by
> >>> btf_type->name_off), so generic BTF tools can easily output what is
> >>> the name of the skipped entity, regardless of its actual kind. Tools
> >>> can also point out how many nested elements it is supposed to have.
> >>> Both are quite nice features, IMO.
> >>>
> >>> Anyways, that's what I had in mind. I think we should bite a bullet
> >>> and do it, so that future extensions can make use of this
> >>> self-describing metadata.
> >>>
> >>> Thoughts?
> >>>
> >>
> >> It'll work, a few specific questions we should probably resolve up front:
> >>
> >> - We can deduce the presence of the metadata info from the header length, so we
> >>   don't need a BTF version bump, right?
> >
> > yep
> >
> >>
> >> - from the encoding perspective, you mentioned having metadata opt-in;
> >>   so I presume we'd have a btf__add_metadata() API (it is zero by default so
> >>   accepted by the kernel I think) if --encode_metadata is set? Perhaps eventually
> >>   we could move to opt-out.
> >
> > I'd say that btf__new() should by default produce metadata, unless
> > opted out through opts. But pahole should default for opt-out to not
> > regress on old kernels built with new pahole.
> >
>
> Ok; we'll need new APIs btf__new_empty[_split]_opts() to handle this I think.
>

Perhaps it's time to generalize to btf__new_opts() and support
split/non-split and data/no-data as options?

> Alan
>
> >>
> >> - there are some cases where what is valid has evolved over time. For example,
> >>   kind flags have appeared for some kinds; should we have a flag for "supports kind
> >>   flag"? (set for struct/union/enum/fwd/eum64)?
> >>
> >
> > "supports kind flag" seems way too specific, tbh. Seems wrong to have
> > such a flag.
> >
> >
> >> I can probably respin what I have, unless you want to take it on?
> >
> > Let's discuss base vs split BTF identification first.
> >
> >>
> >> [1] https://lore.kernel.org/bpf/CAEf4BzYXRT9pFmC1RqnNBmvQWGQkd0zs9rbH9z9Ug8FWOArb_Q@mail.gmail.com/
> >>
> >>>

[...]
