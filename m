Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50264280716
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgJASki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgJASki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 14:40:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C3C0613E2
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 11:40:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so9599618ejb.1
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Psz+quLxDJOoncsISy9AuOtQDy923hseaYyvvlOIbFU=;
        b=U6M6e9erHq11GBx804QFaExkr6h334hfjp7ZYHNwVpMniqrRiCu2LVTRp3mf/Ps3Xl
         uJHOMMF85Acyv5ghSNGewsJPMV+ogPkahcB6jU9gEJJbB5Kme0320mvXFuONCDhhbzFc
         NzO1I+1PnkFosTaayHPMgz/HffWQ3ByLps/wKdsHFMAt51vJ14J1PvRXp4m0q/Lv8iJQ
         0MqHRZ/Skt0j3gMl2YMXOr/DzrdTHORS8kOSnbbARmNzrc6OY0QiOfxNw/K05GDb9ewT
         Cf+Detn6M1hPhpErziV4M64uwFw+71xBjW3zOGy9LbCg9kUsElqVrqL07hPQHeKUyzZP
         O2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Psz+quLxDJOoncsISy9AuOtQDy923hseaYyvvlOIbFU=;
        b=k2bRvpUpSzLQ7kGAfweIo7GrHaFlpZSx0GJgbl3hKgFWNhShTnIFJZ8mc4BmopjUbg
         dwlsSN3hQRvLC7Zmzy30SflQHZ4vD8dcN3aRW6rEU8rxmRywW3m2/Ry0sbsuC+62rLx+
         RBsP2KZ4Bs+u0cpL4cSKQG/sPQEQdz6U7M382lx5e/rjmWJT0FWJemL+jJxyI1hgyU1o
         Z8qAOE8mejWyg9O1qVttElVkskpSbxCaTJoL6tXwyZp/Tzo+62k/b7mZEfpLq6kwUOb0
         9PngP5byyViEYKlYi7p2kFZyd1jJHYebGAOXTZHckh0lXzHFYsmXRZs2OiGZR2jk7Cz7
         5VTA==
X-Gm-Message-State: AOAM5323yroRrI3k+5uGS/vJKhfBwZXrejrBVtCRoeX2Re0Uso0XoQd9
        2VanlAzedPhzeWfUNDHE7D3QmbYPpgAiEZwO4yx79A==
X-Google-Smtp-Source: ABdhPJwMVrgB3riXARKHGfLBSXFEeGX3d15UnLTqDNaHCKoV+BcwsBT0556VnUSC4hzMXKEhMHfQJpKRrB9w36Lx0rM=
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr10072299ejb.359.1601577636230;
 Thu, 01 Oct 2020 11:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200825004523.1353133-1-haoluo@google.com> <20200826131143.GF1059382@kernel.org>
 <CA+khW7jf7Z=sMC1u5eyn6XOZDTFJaNjV-D0ogvQSyUGSKjC3LQ@mail.gmail.com>
 <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com> <CA+khW7imZ+1to15Y+6Suw5_RRQfOQ32X_mkcFACDedjHrNYFaQ@mail.gmail.com>
 <CAADnVQKkqtSLLiXsQk6EnMz61J3Em53HB9zPZtPeqE4jvzGt3g@mail.gmail.com> <20201001182415.GA101623@kernel.org>
In-Reply-To: <20201001182415.GA101623@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 1 Oct 2020 11:40:25 -0700
Message-ID: <CA+khW7iSd4EX0EdoQ0+FvnGg5CKai+TLsa4xbDUPA8tbiu3LZw@mail.gmail.com>
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

Thanks!

On Thu, Oct 1, 2020 at 11:24 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Oct 01, 2020 at 08:47:51AM -0700, Alexei Starovoitov escreveu:
> > Arnaldo,
> >
> > ping.
> > Is anything blocking this fix from merging?
> > The kernel patches are stalled waiting on the pahole.
>
> Applied locally, testing now, will push to the main branch ASAP.
>
> - Arnaldo
>
> > Thanks
> > On Tue, Sep 29, 2020 at 11:52 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Arnaldo,
> > >
> > > Is this patch ready to be merged into Pahole's master branch? Alexei
> > > is testing the kernel patches that need this patch. Please let me know
> > > if there is anything I can do to help merging.
> > >
> > > Thank you,
> > > Hao
> > >
> > > On Wed, Aug 26, 2020 at 6:56 PM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > On August 26, 2020 3:35:17 PM GMT-03:00, Hao Luo <haoluo@google.com> wrote:
> > > > >Arnaldo,
> > > > >
> > > > >On Wed, Aug 26, 2020 at 6:12 AM Arnaldo Carvalho de Melo
> > > > ><acme@kernel.org> wrote:
> > > > >>
> > > > >> Em Mon, Aug 24, 2020 at 05:45:23PM -0700, Hao Luo escreveu:
> > > > >> > It is found on gcc 8.2 that global percpu variables generate the
> > > > >> > following dwarf entry in the cu where the variable is defined[1].
> > > > >> >
> > > > >> > Take the global variable "bpf_prog_active" defined in
> > > > >> > kernel/bpf/syscall.c as an example. The debug info for syscall.c
> > > > >> > has two dwarf entries for "bpf_prog_active".
> > > > >> >
> > > > >[...]
> > > > >>
> > > > >> Interesting, here I get, with binutils' readelf:
> > > > >>
> > > > >> [root@quaco perf]# readelf -wi
> > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> > > > >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> > > > >bpf_prog_active
> > > > >> [root@quaco perf]#
> > > > >>
> > > > >> Just one, as:
> > > > >>
> > > > >> [root@quaco perf]# readelf -wi
> > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active -B1 -A8
> > > > >>  <1><f6a0>: Abbrev Number: 103 (DW_TAG_variable)
> > > > >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> > > > >bpf_prog_active
> > > > >>     <f6a5>   DW_AT_decl_file   : 11
> > > > >>     <f6a6>   DW_AT_decl_line   : 1008
> > > > >>     <f6a8>   DW_AT_decl_column : 1
> > > > >>     <f6a9>   DW_AT_type        : <0xcf>
> > > > >>     <f6ad>   DW_AT_external    : 1
> > > > >>     <f6ad>   DW_AT_declaration : 1
> > > > >>  <1><f6ad>: Abbrev Number: 103 (DW_TAG_variable)
> > > > >>     <f6ae>   DW_AT_name        : (indirect string, offset: 0x3a5d):
> > > > >bpf_stats_enabled_mutex
> > > > >> [root@quaco perf]#
> > > > >>
> > > > >> I get what you have when I use elfutils' readelf:
> > > > >>
> > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> > > > >>              name                 (strp) "bpf_prog_active"
> > > > >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> > > > >> [root@quaco perf]#
> > > > >>
> > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B1 -A8
> > > > >\"bpf_prog_active\"
> > > > >>  [  f6a0]    variable             abbrev: 103
> > > > >>              name                 (strp) "bpf_prog_active"
> > > > >>              decl_file            (data1) bpf.h (11)
> > > > >>              decl_line            (data2) 1008
> > > > >>              decl_column          (data1) 1
> > > > >>              type                 (ref4) [    cf]
> > > > >>              external             (flag_present) yes
> > > > >>              declaration          (flag_present) yes
> > > > >>  [  f6ad]    variable             abbrev: 103
> > > > >>              name                 (strp) "bpf_stats_enabled_mutex"
> > > > >> [root@quaco perf]#
> > > > >>
> > > > >> And:
> > > > >>
> > > > >> [root@quaco perf]# eu-readelf -winfo
> > > > >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B5 \<bpf_prog_active\>
> > > > >>  [ 1bdf5]    variable             abbrev: 212
> > > > >>              specification        (ref4) [  f6a0]
> > > > >>              decl_file            (data1) syscall.c (1)
> > > > >>              decl_line            (data1) 43
> > > > >>              location             (exprloc)
> > > > >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> > > > >> [root@quaco perf]#
> > > > >>
> > > > >
> > > > >In binutils readelf, there is a extra entry
> > > >
> > > > Not here, tomorrow I'll triple check.
> > > >
> > > > >
> > > > > <1><1b24c>: Abbrev Number: 195 (DW_TAG_variable)
> > > > >    <1b24e>   DW_AT_specification: <0xf335>
> > > > >    <1b252>   DW_AT_decl_file   : 1
> > > > >    <1b253>   DW_AT_decl_line   : 43
> > > > >    <1b254>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> > > > > (DW_OP_addr: 0)
> > > > >
> > > > >which points to
> > > > >
> > > > > <1><f335>: Abbrev Number: 95 (DW_TAG_variable)
> > > > >    <f336>   DW_AT_name        : (indirect string, offset: 0xb37a):
> > > > >bpf_prog_active
> > > > >
> > > > >It just doesn't have the string 'bpf_prog_active', annotating entry.
> > > > >So eu-readelf and binutils readelf have the same results.
> > > > >
> > > > >> > Note that second DW_TAG_variable entry contains specification that
> > > > >> > points to the first entry.
> > > > >>
> > > > >> So you are not considering the first when encoding since it is just a
> > > > >> DW_AT_declaration, considers the second, as it should be, and then
> > > > >needs
> > > > >> to go see its DW_AT_specification, right?
> > > > >>
> > > > >> Sounds correct, applying, will test further and then push out,
> > > > >>
> > > > >
> > > > >Yes, exactly. The var tags to be considered are those that either have
> > > > >DW_AT_specification or not have DW_AT_declaration. This makes sure
> > > > >btf_encoder works correctly on both old and new gcc.
> > > > >
> > > > >> Thanks,
> > > > >>
> > > > >> - Arnaldo
> > > > >
> > > > >Suggested by Yonghong, I tested this change on a larger set of
> > > > >compilers this time and works correctly. See below.
> > > > >
> > > > >Could you also add 'Reported-by: Yonghong Song <yhs@fb.com>'? I should
> > > > >have done that when sending out this patch. The credit goes to
> > > > >Yonghong.
> > > >
> > > > Sure, and I'll add your results with different computers, for the record.
> > > >
> > > > Thanks,
> > > >
> > > > - Arnaldo
> > > > >
> > > > >Thank you,
> > > > >Hao
> > > > >
> > > > >  clang 10:
> > > > >  [67] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [20168] VAR 'bpf_prog_active' type_id=67, linkage=global-alloc
> > > > >
> > > > >  clang 9:
> > > > >  [64] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [19789] VAR 'bpf_prog_active' type_id=64, linkage=global-alloc
> > > > >
> > > > >  gcc 10.2
> > > > >  [18] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [20319] VAR 'bpf_prog_active' type_id=18, linkage=global-alloc
> > > > >
> > > > >  gcc 9.3:
> > > > >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [21085] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> > > > >
> > > > >  gcc 8
> > > > >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [21084] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> > > > >
> > > > >  gcc 6.2
> > > > >  [22] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [21083] VAR 'bpf_prog_active' type_id=22, linkage=global-alloc
> > > > >
> > > > >  gcc 4.9
> > > > >  [17] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > >  [20410] VAR 'bpf_prog_active' type_id=17, linkage=global-alloc
> > > >
> > > > --
> > > > Sent from my Android device with K-9 Mail. Please excuse my brevity.
>
> --
>
> - Arnaldo
