Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6645C5B3B1F
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIIOvc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiIIOvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 10:51:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962D12E19D
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 07:51:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b23so1454191iof.2
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=konjf3UZoGyDhySZ36x4DhLthFmW/e+Z6wvF5gpW5BU=;
        b=T2eTKlQCwuqB/1iiTVYnJck1sLHUas6HivydT4M3teid81YDTJGJx+i0KfP5nxApz8
         kZttHjkJd3I6cc3aGQwF328nmzdTWSgKTHoiHJyFtUQzCH1BsCTxtV1YCafWUSsPOdir
         wpch1VoYUC5iWZbThb/RJyL6cQAYSoUteHFagRwpICSoWlLCkWk9SrZ9y/Ub0RcUcH2/
         wacrFsQEgvupA5gpoy9ho6WD4HIq6kjc5RT9Y0nuF4VC7fM0TdUPMxHx+wfHONFetZkq
         gMI3ggX9edJoa1SjgLjrsYw3sxHvh3hxO4z9vm/tYNefVagTKOhvWKTOSCNikdaGi+iQ
         dxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=konjf3UZoGyDhySZ36x4DhLthFmW/e+Z6wvF5gpW5BU=;
        b=ToGHErI9V9LHRmgESVvUwlsgWyIjVpXDfOCTqJJwnd69zS5g06P/m20GC1iVt/0x68
         BpJbez1mtXYqen1gJxabiVc9OvuNvSAWhahn8OWRwKfxOxy3ewX38q+6Lh3sejkiEOHI
         iq8ip/IP8sD/Kyyfd4YF/MJg3UslrLIxkV2n7qNC4XTnj0kurhyeKs+IyYanjGbtUUwK
         SLwkFIDkG6ZqwtrD6ovNo/xNsgZkl0j3HObveMOPAM28WOxqMrJ74MNJVji1ZCi6BrLQ
         ay2kdygA//eMnEZ31ICyjW91DMfvuq3n8bZRR7KYGjfUDZyeVyV4HzgbUicHpR5xY1DH
         YxEA==
X-Gm-Message-State: ACgBeo3QhgxlLqg5t14MuWhxsBQnArUHr0obkDMs7lu+q2Gm4B0p9NqC
        cqs5Rev7mFoZXqZdolFjQIpw6O9oty65ukkRYM0=
X-Google-Smtp-Source: AA6agR5F76h6s1zIM5M/qA4MwXPm4/q8WMj/LcwM05zOSH0RteiG2XxfHestNDgmPvHg4xNygJn1TaEAinMXt2c+vfk=
X-Received: by 2002:a05:6602:2d8b:b0:688:ece0:e1da with SMTP id
 k11-20020a0566022d8b00b00688ece0e1damr6606859iow.18.1662735089369; Fri, 09
 Sep 2022 07:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
In-Reply-To: <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 9 Sep 2022 16:50:52 +0200
Message-ID: <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > > Global variables reside in maps accessible using direct_value_addr
> > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > disallows us from holding locks which are global.
> > > >
> > > > This is not great, so refactor the active_spin_lock into two separate
> > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > enough to allow it for global variables, map lookups, and local kptr
> > > > registers at the same time.
> > > >
> > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > whether bpf_spin_unlock is for the same register.
> > > >
> > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > are doing lookup for the same map value (max_entries is never greater
> > > > than 1).
> > > >
> > >
> > > For libbpf-style "internal maps" - like .bss.private further in this series -
> > > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> > >
> > >   struct bpf_spin_lock lock1 SEC(".bss.private");
> > >   struct bpf_spin_lock lock2 SEC(".bss.private");
> > >   ...
> > >   spin_lock(&lock1);
> > >   ...
> > >   spin_lock(&lock2);
> > >
> > > will result in same map but different offsets for the direct read (and different
> > > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> > >
> >
> > That won't be a problem. Two spin locks in a map value or datasec are
> > already rejected on BPF_MAP_CREATE,
> > so there is no bug. See idx >= info_cnt check in
> > btf_find_struct_field, btf_find_datasec_var.
> >
> > I can include offset as the third part of the tuple. The problem then
> > is figuring out which lock protects which bpf_list_head. We need
> > another __guarded_by annotation and force users to use that to
> > eliminate the ambiguity. So for now I just put it in the commit log
> > and left it for the future.
>
> Let's not go that far yet.
> Extra annotations are just as confusing and non-obvious as
> putting locks in different sections.
> Let's keep one lock per map value limitation for now.
> libbpf side needs to allow many non-mappable sections though.
> Single bss.private name is too limiting.

In that case,
Dave, since the libbpf patch is yours, would you be fine with
reworking it to support multiple private maps?
Maybe it can just ignore the .XXX part in .bss.private.XXX?
Also I think Andrii mentioned once that he wants to eventually merge
data and bss, so it might be a good idea to call it .data.private from
the start?
