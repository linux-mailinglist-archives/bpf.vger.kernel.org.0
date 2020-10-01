Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8530C2808E3
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgJAU5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 16:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732864AbgJAU5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 16:57:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A83C0613E2
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 13:57:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qp15so9180706ejb.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mFddp8qBk6Dwzi45sa2KHPnDPIBia0gy5sbwiCZZ4U=;
        b=V8gpdcJCL4n24CdIUlhIogI1Kr8L0/sHHo1SRLxtsQimGtRodzS5ANhq5V1w/h6TQH
         1MqLPAHckyqP4X520v9hcxx4vu5D5julIwvlEq/7s7YnsssC0zEOtmWIjdt77pYC8NJ+
         aKqFJ47Z9ZMEyquRdMjZm5N5JLRCyJUd19MFPThpUl8d6Gi9+4MUWaTcB/th1zhO9AWh
         TAc2tHEI6Yt8AVI2A84UB7GRmQTrVegpYI30C9/rr+1G+I1KrEcTV2a8SsPJkew8YxzY
         GkTGaMKsuKelI9/YBQYg8C+stVy4IsbPLzKldCt8/TtAkOb1VDD80Qm1SndfV/3L8IB0
         NqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mFddp8qBk6Dwzi45sa2KHPnDPIBia0gy5sbwiCZZ4U=;
        b=kLNVZ8TR5D1HTHBIO4ZOaDK9Ysm5ArlrI13Kp3HrXh5FSDeoVY7TphsEq+hHpHT0o2
         y4sPFp1AF8Tk0oB+jteDJ1H80U4uFP/PrRc3KUpnk6dGdCcMzy8S9F61OY5Y+5VZe5CS
         Rw+dgAwzisJKbrhWtFGBy21+a2QSYVeptJfYYIU5fBVJJtvhv3PIVgFYqInhQlUiIFd7
         1Qh7hk+5D/ZbYgBq4nuU/Z6Ce7/LxuFvJwmXi/Ovdqs4XLNX6VcMzAMz6Jj91BjMZGeA
         Xy2HcZdQ9kNOXswBvA/662Z6Wjbr7iSHyIv9Pd9sAULlV+Llk+CZqxKXRegb00TUETNM
         gLGA==
X-Gm-Message-State: AOAM531c9RaXpRCRdThEmTEY6VGzU2lGo71UFgwJJIbVYjO0FJ8LWIEA
        K9eDKswA9RDxPxAbMkgqDvghil4OGuwR5zHIFLPsFQ==
X-Google-Smtp-Source: ABdhPJyILKNDDwnF8/LRvPkwAgOxc6s2EDCd+Sw/kzTT82uGzpTazX0XnVNm/wY5/5KrPn93zIRyYAy7Tyn8LcEKRKU=
X-Received: by 2002:a17:906:70d4:: with SMTP id g20mr10500338ejk.413.1601585838413;
 Thu, 01 Oct 2020 13:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200825004523.1353133-1-haoluo@google.com> <20200826131143.GF1059382@kernel.org>
 <CA+khW7jf7Z=sMC1u5eyn6XOZDTFJaNjV-D0ogvQSyUGSKjC3LQ@mail.gmail.com>
 <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com> <CA+khW7imZ+1to15Y+6Suw5_RRQfOQ32X_mkcFACDedjHrNYFaQ@mail.gmail.com>
 <CAADnVQKkqtSLLiXsQk6EnMz61J3Em53HB9zPZtPeqE4jvzGt3g@mail.gmail.com>
 <20201001182415.GA101623@kernel.org> <CA+khW7iSd4EX0EdoQ0+FvnGg5CKai+TLsa4xbDUPA8tbiu3LZw@mail.gmail.com>
 <20201001202729.GA105734@kernel.org>
In-Reply-To: <20201001202729.GA105734@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 1 Oct 2020 13:57:07 -0700
Message-ID: <CA+khW7iVd3zUa0iwLuf=SwE3TtnNPB1ZGkUvWPfVt7JpJPcX5w@mail.gmail.com>
Subject: Re: [PATCH v1] btf_encoder: Handle DW_TAG_variable that has DW_AT_specification
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo, thanks for the update. In that case, I think on the kernel
side I need to skip encoding percpu vars for this pahole release, and
re-enable for the next pahole release. (assuming the flag for opt-out
is in this release). Alexei, do you have any better idea?

Hao

On Thu, Oct 1, 2020 at 1:27 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Oct 01, 2020 at 11:40:25AM -0700, Hao Luo escreveu:
> > Thanks!
>
> I must just apologise not having this in an officially released version
> yet, getting constantly postponed due to bug reports about corner cases
> and some features I got carried away working on, I'll fast pace a new
> version to avoid getting in the way of the larger eBPF effort.
>
> - Arnaldo
>
> > On Thu, Oct 1, 2020 at 11:24 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Thu, Oct 01, 2020 at 08:47:51AM -0700, Alexei Starovoitov escreveu:
> > > > Arnaldo,
> > > >
> > > > ping.
> > > > Is anything blocking this fix from merging?
> > > > The kernel patches are stalled waiting on the pahole.
> > >
> > > Applied locally, testing now, will push to the main branch ASAP.
> > >
> > > - Arnaldo
> > >
> > > > Thanks
> > > > On Tue, Sep 29, 2020 at 11:52 PM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > Arnaldo,
> > > > >
> > > > > Is this patch ready to be merged into Pahole's master branch? Alexei
> > > > > is testing the kernel patches that need this patch. Please let me know
> > > > > if there is anything I can do to help merging.
> > > > >
> > > > > Thank you,
> > > > > Hao
> > > > >
> > > > > On Wed, Aug 26, 2020 at 6:56 PM Arnaldo Carvalho de Melo
> > > > > <arnaldo.melo@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On August 26, 2020 3:35:17 PM GMT-03:00, Hao Luo <haoluo@google.com> wrote:
> > > > > > >Arnaldo,
> > > > > > >
> > > > > > >On Wed, Aug 26, 2020 at 6:12 AM Arnaldo Carvalho de Melo
> > > > > > ><acme@kernel.org> wrote:
> > > > > > >>
> > > > > > >> Em Mon, Aug 24, 2020 at 05:45:23PM -0700, Hao Luo escreveu:
> > > > > > >> > It is found on gcc 8.2 that global percpu variables generate the
> > > > > > >> > following dwarf entry in the cu where the variable is defined[1].
> > > > > > >> >
> > > > > > >> > Take the global variable "bpf_prog_active" defined in
> > > > > > >> > kernel/bpf/syscall.c as an example. The debug info for syscall.c
> > > > > > >> > has two dwarf entries for "bpf_prog_active".
> > > > > > >> >
> > > > > > >[...]
> > > > > > >>
> > > > > > >> Interesting, here I get, with binutils' readelf:
> > > > > > >>
> > > > > > >> [root@quaco perf]# readelf -wi
> > > > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> > > > > > >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> > > > > > >bpf_prog_active
> > > > > > >> [root@quaco perf]#
> > > > > > >>
> > > > > > >> Just one, as:
> > > > > > >>
> > > > > > >> [root@quaco perf]# readelf -wi
> > > > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active -B1 -A8
> > > > > > >>  <1><f6a0>: Abbrev Number: 103 (DW_TAG_variable)
> > > > > > >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> > > > > > >bpf_prog_active
> > > > > > >>     <f6a5>   DW_AT_decl_file   : 11
> > > > > > >>     <f6a6>   DW_AT_decl_line   : 1008
> > > > > > >>     <f6a8>   DW_AT_decl_column : 1
> > > > > > >>     <f6a9>   DW_AT_type        : <0xcf>
> > > > > > >>     <f6ad>   DW_AT_external    : 1
> > > > > > >>     <f6ad>   DW_AT_declaration : 1
> > > > > > >>  <1><f6ad>: Abbrev Number: 103 (DW_TAG_variable)
> > > > > > >>     <f6ae>   DW_AT_name        : (indirect string, offset: 0x3a5d):
> > > > > > >bpf_stats_enabled_mutex
> > > > > > >> [root@quaco perf]#
> > > > > > >>
> > > > > > >> I get what you have when I use elfutils' readelf:
> > > > > > >>
> > > > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> > > > > > >>              name                 (strp) "bpf_prog_active"
> > > > > > >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> > > > > > >> [root@quaco perf]#
> > > > > > >>
> > > > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B1 -A8
> > > > > > >\"bpf_prog_active\"
> > > > > > >>  [  f6a0]    variable             abbrev: 103
> > > > > > >>              name                 (strp) "bpf_prog_active"
> > > > > > >>              decl_file            (data1) bpf.h (11)
> > > > > > >>              decl_line            (data2) 1008
> > > > > > >>              decl_column          (data1) 1
> > > > > > >>              type                 (ref4) [    cf]
> > > > > > >>              external             (flag_present) yes
> > > > > > >>              declaration          (flag_present) yes
> > > > > > >>  [  f6ad]    variable             abbrev: 103
> > > > > > >>              name                 (strp) "bpf_stats_enabled_mutex"
> > > > > > >> [root@quaco perf]#
> > > > > > >>
> > > > > > >> And:
> > > > > > >>
> > > > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B5 \<bpf_prog_active\>
> > > > > > >>  [ 1bdf5]    variable             abbrev: 212
> > > > > > >>              specification        (ref4) [  f6a0]
> > > > > > >>              decl_file            (data1) syscall.c (1)
> > > > > > >>              decl_line            (data1) 43
> > > > > > >>              location             (exprloc)
> > > > > > >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> > > > > > >> [root@quaco perf]#
> > > > > > >>
> > > > > > >
> > > > > > >In binutils readelf, there is a extra entry
> > > > > >
> > > > > > Not here, tomorrow I'll triple check.
> > > > > >
> > > > > > >
> > > > > > > <1><1b24c>: Abbrev Number: 195 (DW_TAG_variable)
> > > > > > >    <1b24e>   DW_AT_specification: <0xf335>
> > > > > > >    <1b252>   DW_AT_decl_file   : 1
> > > > > > >    <1b253>   DW_AT_decl_line   : 43
> > > > > > >    <1b254>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> > > > > > > (DW_OP_addr: 0)
> > > > > > >
> > > > > > >which points to
> > > > > > >
> > > > > > > <1><f335>: Abbrev Number: 95 (DW_TAG_variable)
> > > > > > >    <f336>   DW_AT_name        : (indirect string, offset: 0xb37a):
> > > > > > >bpf_prog_active
> > > > > > >
> > > > > > >It just doesn't have the string 'bpf_prog_active', annotating entry.
> > > > > > >So eu-readelf and binutils readelf have the same results.
> > > > > > >
> > > > > > >> > Note that second DW_TAG_variable entry contains specification that
> > > > > > >> > points to the first entry.
> > > > > > >>
> > > > > > >> So you are not considering the first when encoding since it is just a
> > > > > > >> DW_AT_declaration, considers the second, as it should be, and then
> > > > > > >needs
> > > > > > >> to go see its DW_AT_specification, right?
> > > > > > >>
> > > > > > >> Sounds correct, applying, will test further and then push out,
> > > > > > >>
> > > > > > >
> > > > > > >Yes, exactly. The var tags to be considered are those that either have
> > > > > > >DW_AT_specification or not have DW_AT_declaration. This makes sure
> > > > > > >btf_encoder works correctly on both old and new gcc.
> > > > > > >
> > > > > > >> Thanks,
> > > > > > >>
> > > > > > >> - Arnaldo
> > > > > > >
> > > > > > >Suggested by Yonghong, I tested this change on a larger set of
> > > > > > >compilers this time and works correctly. See below.
> > > > > > >
> > > > > > >Could you also add 'Reported-by: Yonghong Song <yhs@fb.com>'? I should
> > > > > > >have done that when sending out this patch. The credit goes to
> > > > > > >Yonghong.
> > > > > >
> > > > > > Sure, and I'll add your results with different computers, for the record.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > - Arnaldo
> > > > > > >
> > > > > > >Thank you,
> > > > > > >Hao
> > > > > > >
> > > > > > >  clang 10:
> > > > > > >  [67] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [20168] VAR 'bpf_prog_active' type_id=67, linkage=global-alloc
> > > > > > >
> > > > > > >  clang 9:
> > > > > > >  [64] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [19789] VAR 'bpf_prog_active' type_id=64, linkage=global-alloc
> > > > > > >
> > > > > > >  gcc 10.2
> > > > > > >  [18] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [20319] VAR 'bpf_prog_active' type_id=18, linkage=global-alloc
> > > > > > >
> > > > > > >  gcc 9.3:
> > > > > > >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [21085] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> > > > > > >
> > > > > > >  gcc 8
> > > > > > >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [21084] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> > > > > > >
> > > > > > >  gcc 6.2
> > > > > > >  [22] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [21083] VAR 'bpf_prog_active' type_id=22, linkage=global-alloc
> > > > > > >
> > > > > > >  gcc 4.9
> > > > > > >  [17] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > > >  [20410] VAR 'bpf_prog_active' type_id=17, linkage=global-alloc
> > > > > >
> > > > > > --
> > > > > > Sent from my Android device with K-9 Mail. Please excuse my brevity.
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
