Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C956CB65
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 22:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiGIUjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 16:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUjq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 16:39:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A011DDE92
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 13:39:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so1512427otl.7
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Rr6OaHYoilf1qhA9IoOLYAD1jUUCePHq85ezOnqAi8=;
        b=bBo6rIBRzUkcfxCZVS+r6D6tRDpl/+L946vU/ZBRo26Y/fqiwap4T+XvjksvCy2Tl9
         O62+FpZaQ9t7noG/gokjm04H8FcMSHZkXeJzZWcD+/HqfD/uwxvdWuSVGyNtQDuUd5cg
         rEEbAyC0hSzUsoHxSyIk++zfY8DE3/6lFjbSh3/t86FMmpWpzwj6g4ErJGGMVqALRd3B
         9wTR/WrqcNvPVcEGwfeC4N6EPvUkVHi2z3piLHq6sd0P9/oSghHV80mUrMllvtM+GRou
         n6iufl1+bBBnL6bGpbO+aIVKauJNV4nzPETisAYog5YUft3ngoccP4+FPZQMo3iSuuHo
         tMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Rr6OaHYoilf1qhA9IoOLYAD1jUUCePHq85ezOnqAi8=;
        b=iFTjTIuDqEOtVVdK5qV45hMpa5mx9IkxPSFwh9vLwjlU1lNiMzTNFFry/b2fmb7Cjm
         SEAVU2/Mzy2/o0Z8nTTC+mYgBShBXircZsY57OYu/BDQbNMjImQQ0mbXYBBcsaUu07E7
         V06ubZRE4qnFUCsTjSVnTmHqvIkji4ay+U66cRtuDd5P2AWd86qk8ECM/Z+e/rmvJsrX
         xCGcbGPKsGVQS5g/iV2nQhHMMyG+RbAjAmrktPLmJs+l1CPrJPq3s7GVt2MoCxk5P0R1
         jEaE6YH3u1jHhej1HYzcGZ537BgWzPy0fQoB9Lp9EOsjyWWrCnJLpzoNBIeijx8fM6+l
         HPQw==
X-Gm-Message-State: AJIora+IooU2X2XwTlqB/+QQlSDpc+BGrtIBTe2ugomalzRNmDzY2UYv
        4LUDcL9Dojr2+WXzyaatIegDLRAgYz7ooxO4md0=
X-Google-Smtp-Source: AGRyM1tpwzcysV6RYRZVQQzHnlN2nX2pudbpnvUe0ptZT8a9IavYFvpTQ0JqoBJXiIl3euLYN2HYXC1Uh8+6JOFENVU=
X-Received: by 2002:a05:6830:61cc:b0:616:cba6:c72 with SMTP id
 cc12-20020a05683061cc00b00616cba60c72mr4441390otb.30.1657399182758; Sat, 09
 Jul 2022 13:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
 <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
 <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com> <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
 <87v8s65hdc.fsf@oracle.com> <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
 <8735fa3unq.fsf@oracle.com> <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
In-Reply-To: <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 9 Jul 2022 14:39:31 -0600
Message-ID: <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hilliard1@gmail.com> wrote:
>
> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
> >
> >
> > > On Sat, Jul 9, 2022 at 11:24 AM Jose E. Marchesi
> > > <jose.marchesi@oracle.com> wrote:
> > >>
> > >>
> > >> > On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
> > >> > <jose.marchesi@oracle.com> wrote:
> > >> >>
> > >> >>
> > >> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
> > >> >> >> <james.hilliard1@gmail.com> wrote:
> > >> >> >>>
> > >> >> >>> Note I'm testing with the following patches:
> > >> >> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
> > >> >> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
> > >> >> >>>
> > >> >> >>> It would appear there's some compatibility issues with bpftool gen and
> > >> >> >>> GCC, not sure what side though is wrong here:
> > >> >> >>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > >> >> >>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > >> >> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> > >> >> >>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
> > >> >> >>> Error: failed to link
> > >> >> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
> > >> >> >>> Unknown error -2 (-2)
> > >> >> >>>
> > >> >> >>> Relevant difference seems to be this:
> > >> >> >>> GCC:
> > >> >> >>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
> > >> >> >>> Clang:
> > >> >> >>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
> > >> >> >
> > >> >> > For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
> > >> >> > information, or so we thought: I just looked at bpftool/btf.c and I
> > >> >> > found the linkage info for function types is expected to be encoded in
> > >> >> > the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
> > >> >> > instead???) which is surprising to say the least.
> > >> >> >
> > >> >> > We are changing GCC to encode the linkage info in vlen for these types.
> > >> >> > Thanks for reporting this.
> > >> >>
> > >> >> Patch sent to GCC upstream:
> > >> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html
> > >> >
> > >> > I applied that patch on top of GCC 12.1.0 and it appears to fix the
> > >> > bpftool gen object bug.
> > >> >
> > >> > I am however now hitting a different error during skeleton generation:
> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > >> > gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > >> > libbpf: elf: skipping unrecognized data section(9) .comment
> > >> > libbpf: failed to alloc map 'restrict.bss' content buffer: -22
> > >> > Error: failed to open BPF object file: Invalid argument
> > >>
> > >> What is the size of the .bss section in the object file?  Try with:
> > >>
> > >> $ size restrict-ifaces.bpf.o
> > >
> > > $ size output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > >    text       data        bss        dec        hex    filename
> > >     386         25          0        411        19b
> > > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> >
> > Right, so the .bss section is empty.  I see a `const volatile unsigned
> > char is_allow_list = 0;' in restrict-ifaces.bpf.c, but that goes to
> > .data and not to .bss, as expected.
> >
> > If you build restrict-ifaces.bpf.o with LLVM, is the bss still empty?  I
> > don't think the code in libbpf.c even checks for this eventuality...
>
> LLVM version(which skeleton generation works with):
> $ size restrict-ifaces.bpf.o
>    text       data        bss        dec        hex    filename
>     323         24          0        347        15b    restrict-ifaces.bpf.o
>
> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> btf dump file restrict-ifaces.bpf.o format raw
> [1] PTR '(anon)' type_id=3
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
> [4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [5] PTR '(anon)' type_id=6
> [6] TYPEDEF '__u32' type_id=7
> [7] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [8] PTR '(anon)' type_id=9
> [9] TYPEDEF '__u8' type_id=10
> [10] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> [11] STRUCT '(anon)' size=24 vlen=3
>     'type' type_id=1 bits_offset=0
>     'key' type_id=5 bits_offset=64
>     'value' type_id=8 bits_offset=128
> [12] VAR 'sd_restrictif' type_id=11, linkage=global
> [13] PTR '(anon)' type_id=14
> [14] CONST '(anon)' type_id=15
> [15] STRUCT '__sk_buff' size=192 vlen=33
>     'len' type_id=6 bits_offset=0
>     'pkt_type' type_id=6 bits_offset=32
>     'mark' type_id=6 bits_offset=64
>     'queue_mapping' type_id=6 bits_offset=96
>     'protocol' type_id=6 bits_offset=128
>     'vlan_present' type_id=6 bits_offset=160
>     'vlan_tci' type_id=6 bits_offset=192
>     'vlan_proto' type_id=6 bits_offset=224
>     'priority' type_id=6 bits_offset=256
>     'ingress_ifindex' type_id=6 bits_offset=288
>     'ifindex' type_id=6 bits_offset=320
>     'tc_index' type_id=6 bits_offset=352
>     'cb' type_id=16 bits_offset=384
>     'hash' type_id=6 bits_offset=544
>     'tc_classid' type_id=6 bits_offset=576
>     'data' type_id=6 bits_offset=608
>     'data_end' type_id=6 bits_offset=640
>     'napi_id' type_id=6 bits_offset=672
>     'family' type_id=6 bits_offset=704
>     'remote_ip4' type_id=6 bits_offset=736
>     'local_ip4' type_id=6 bits_offset=768
>     'remote_ip6' type_id=17 bits_offset=800
>     'local_ip6' type_id=17 bits_offset=928
>     'remote_port' type_id=6 bits_offset=1056
>     'local_port' type_id=6 bits_offset=1088
>     'data_meta' type_id=6 bits_offset=1120
>     '(anon)' type_id=18 bits_offset=1152
>     'tstamp' type_id=20 bits_offset=1216
>     'wire_len' type_id=6 bits_offset=1280
>     'gso_segs' type_id=6 bits_offset=1312
>     '(anon)' type_id=22 bits_offset=1344
>     'gso_size' type_id=6 bits_offset=1408
>     'hwtstamp' type_id=20 bits_offset=1472
> [16] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=5
> [17] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=4
> [18] UNION '(anon)' size=8 vlen=1
>     'flow_keys' type_id=19 bits_offset=0
> [19] PTR '(anon)' type_id=34
> [20] TYPEDEF '__u64' type_id=21
> [21] INT 'unsigned long long' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [22] UNION '(anon)' size=8 vlen=1
>     'sk' type_id=23 bits_offset=0
> [23] PTR '(anon)' type_id=35
> [24] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
>     'sk' type_id=13
> [25] FUNC 'sd_restrictif_e' type_id=24 linkage=global
> [26] FUNC 'sd_restrictif_i' type_id=24 linkage=global
> [27] CONST '(anon)' type_id=28
> [28] VOLATILE '(anon)' type_id=9
> [29] VAR 'is_allow_list' type_id=27, linkage=global
> [30] CONST '(anon)' type_id=31
> [31] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [32] ARRAY '(anon)' type_id=30 index_type_id=4 nr_elems=18
> [33] VAR '_license' type_id=32, linkage=static
> [34] FWD 'bpf_flow_keys' fwd_kind=struct
> [35] FWD 'bpf_sock' fwd_kind=struct
> [36] DATASEC '.rodata' size=1 vlen=1
>     type_id=29 offset=0 size=1 (VAR 'is_allow_list')
> [37] DATASEC 'license' size=18 vlen=1
>     type_id=33 offset=0 size=18 (VAR '_license')
> [38] DATASEC '.maps' size=24 vlen=1
>     type_id=12 offset=0 size=24 (VAR 'sd_restrictif')
>

Skeleton generation debug output for GCC(failing) and LLVM(working)
which may be helpful:

GCC:
$ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
--debug gen skeleton
output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
libbpf: loading object 'restrict_ifaces_bpf' from buffer
libbpf: elf: section(2) .symtab, size 336, link 1, flags 0, type=2
libbpf: elf: section(3) .data, size 1, link 0, flags 3, type=1
libbpf: elf: section(4) .bss, size 0, link 0, flags 3, type=8
libbpf: elf: section(5) cgroup_skb/egress, size 184, link 0, flags 6, type=1
libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
insn offset 0 (0 bytes), code size 23 insns (184 bytes)
libbpf: elf: section(6) cgroup_skb/ingress, size 184, link 0, flags 6, type=1
libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
insn offset 0 (0 bytes), code size 23 insns (184 bytes)
libbpf: elf: section(7) license, size 18, link 0, flags 2, type=1
libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=1
libbpf: elf: section(9) .comment, size 49, link 0, flags 30, type=1
libbpf: elf: skipping unrecognized data section(9) .comment
libbpf: elf: section(10) .relcgroup_skb/egress, size 32, link 2, flags
40, type=9
libbpf: elf: section(11) .relcgroup_skb/ingress, size 32, link 2,
flags 40, type=9
libbpf: elf: section(12) .BTF, size 3606, link 0, flags 0, type=1
libbpf: looking for externs among 14 symbols...
libbpf: collected 0 externs total
libbpf: map 'sd_restrictif': at sec_idx 8, offset 0.
libbpf: map 'sd_restrictif': found type = 1.
libbpf: map 'sd_restrictif': found key [12], sz = 4.
libbpf: map 'sd_restrictif': found value [3], sz = 1.
libbpf: map 'restrict.data' (global data): at sec_idx 3, offset 0, flags 400.
libbpf: map 1 is "restrict.data"
libbpf: map 'restrict.bss' (global data): at sec_idx 4, offset 0, flags 400.
libbpf: failed to alloc map 'restrict.bss' content buffer: -22
Error: failed to open BPF object file: Invalid argument

LLVM:
$ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
--debug gen skeleton restrict-ifaces.bpf.o
libbpf: loading object 'restrict_ifaces_bpf' from buffer
libbpf: elf: section(2) .symtab, size 384, link 1, flags 0, type=2
libbpf: elf: section(3) cgroup_skb/egress, size 152, link 0, flags 6, type=1
libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
insn offset 0 (0 bytes), code size 19 insns (152 bytes)
libbpf: elf: section(4) cgroup_skb/ingress, size 152, link 0, flags 6, type=1
libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
insn offset 0 (0 bytes), code size 19 insns (152 bytes)
libbpf: elf: section(5) .rodata, size 1, link 0, flags 2, type=1
libbpf: elf: section(6) license, size 18, link 0, flags 2, type=1
libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
libbpf: elf: section(7) .maps, size 24, link 0, flags 3, type=1
libbpf: elf: section(8) .relcgroup_skb/egress, size 32, link 2, flags 40, type=9
libbpf: elf: section(9) .relcgroup_skb/ingress, size 32, link 2, flags
40, type=9
libbpf: elf: section(10) .BTF, size 1988, link 0, flags 0, type=1
libbpf: elf: section(11) .BTF.ext, size 376, link 0, flags 0, type=1
libbpf: looking for externs among 16 symbols...
libbpf: collected 0 externs total
libbpf: map 'sd_restrictif': at sec_idx 7, offset 0.
libbpf: map 'sd_restrictif': found type = 1.
libbpf: map 'sd_restrictif': found key [6], sz = 4.
libbpf: map 'sd_restrictif': found value [9], sz = 1.
libbpf: map 'restrict.rodata' (global data): at sec_idx 5, offset 0, flags 480.
libbpf: map 1 is "restrict.rodata"
libbpf: sec '.relcgroup_skb/egress': collecting relocation for
section(3) 'cgroup_skb/egress'
libbpf: sec '.relcgroup_skb/egress': relo #0: insn #4 against 'sd_restrictif'
libbpf: prog 'sd_restrictif_e': found map 0 (sd_restrictif, sec 7, off
0) for insn #4
libbpf: sec '.relcgroup_skb/egress': relo #1: insn #7 against 'is_allow_list'
libbpf: prog 'sd_restrictif_e': found data map 1 (restrict.rodata, sec
5, off 0) for insn 7
libbpf: sec '.relcgroup_skb/ingress': collecting relocation for
section(4) 'cgroup_skb/ingress'
libbpf: sec '.relcgroup_skb/ingress': relo #0: insn #4 against 'sd_restrictif'
libbpf: prog 'sd_restrictif_i': found map 0 (sd_restrictif, sec 7, off
0) for insn #4
libbpf: sec '.relcgroup_skb/ingress': relo #1: insn #7 against 'is_allow_list'
libbpf: prog 'sd_restrictif_i': found data map 1 (restrict.rodata, sec
5, off 0) for insn 7

> >
> > >>
> > >> Looking at libbpf.c, it seems to me that this may be due of trying to
> > >> mmap 0 bytes in `bpf_object__init_internal_map':
> > >>
> > >>         map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
> > >>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > >>         if (map->mmaped == MAP_FAILED) {
> > >>                 err = -errno;
> > >>                 map->mmaped = NULL;
> > >>                 pr_warn("failed to alloc map '%s' content buffer: %d\n",
> > >>                         map->name, err);
> > >>                 zfree(&map->real_name);
> > >>                 zfree(&map->name);
> > >>                 return err;
> > >>         }
> > >>
> > >> I see no check for zero sized sections in
> > >> bpf_object__init_global_data_maps.
> > >>
> > >> Is maybe GCC failing to allocate stuff in BSS that is supposed to be
> > >> there?
> > >>
> > >> > Stripped file passed to gen skeleton:
> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > >> > btf dump file
> > >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > >> > format raw
> > >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> > >> > [3] TYPEDEF '__u8' type_id=2
> > >> > [4] CONST '(anon)' type_id=3
> > >> > [5] VOLATILE '(anon)' type_id=4
> > >> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
> > >> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
> > >> > [8] TYPEDEF '__u16' type_id=7
> > >> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > >> > [10] TYPEDEF '__s32' type_id=9
> > >> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > >> > [12] TYPEDEF '__u32' type_id=11
> > >> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > >> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
> > >> > encoding=(none)
> > >> > [15] TYPEDEF '__u64' type_id=14
> > >> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > >> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > >> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > >> > [19] CONST '(anon)' type_id=18
> > >> > [20] TYPEDEF '__be16' type_id=8
> > >> > [21] TYPEDEF '__be32' type_id=12
> > >> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
> > >> >     'BPF_MAP_TYPE_UNSPEC' val=0
> > >> >     'BPF_MAP_TYPE_HASH' val=1
> > >> >     'BPF_MAP_TYPE_ARRAY' val=2
> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=9
> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
> > >> >     'BPF_MAP_TYPE_DEVMAP' val=14
> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=15
> > >> >     'BPF_MAP_TYPE_CPUMAP' val=16
> > >> >     'BPF_MAP_TYPE_XSKMAP' val=17
> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=18
> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
> > >> >     'BPF_MAP_TYPE_QUEUE' val=22
> > >> >     'BPF_MAP_TYPE_STACK' val=23
> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
> > >> >     'BPF_MAP_TYPE_RINGBUF' val=27
> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
> > >> > [23] UNION '(anon)' size=8 vlen=1
> > >> >     'flow_keys' type_id=29 bits_offset=0
> > >> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
> > >> >     'nhoff' type_id=8 bits_offset=0
> > >> >     'thoff' type_id=8 bits_offset=16
> > >> >     'addr_proto' type_id=8 bits_offset=32
> > >> >     'is_frag' type_id=3 bits_offset=48
> > >> >     'is_first_frag' type_id=3 bits_offset=56
> > >> >     'is_encap' type_id=3 bits_offset=64
> > >> >     'ip_proto' type_id=3 bits_offset=72
> > >> >     'n_proto' type_id=20 bits_offset=80
> > >> >     'sport' type_id=20 bits_offset=96
> > >> >     'dport' type_id=20 bits_offset=112
> > >> >     '(anon)' type_id=25 bits_offset=128
> > >> >     'flags' type_id=12 bits_offset=384
> > >> >     'flow_label' type_id=21 bits_offset=416
> > >> > [25] UNION '(anon)' size=32 vlen=2
> > >> >     '(anon)' type_id=26 bits_offset=0
> > >> >     '(anon)' type_id=27 bits_offset=0
> > >> > [26] STRUCT '(anon)' size=8 vlen=2
> > >> >     'ipv4_src' type_id=21 bits_offset=0
> > >> >     'ipv4_dst' type_id=21 bits_offset=32
> > >> > [27] STRUCT '(anon)' size=32 vlen=2
> > >> >     'ipv6_src' type_id=28 bits_offset=0
> > >> >     'ipv6_dst' type_id=28 bits_offset=128
> > >> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
> > >> > [29] PTR '(anon)' type_id=24
> > >> > [30] UNION '(anon)' size=8 vlen=1
> > >> >     'sk' type_id=32 bits_offset=0
> > >> > [31] STRUCT 'bpf_sock' size=80 vlen=14
> > >> >     'bound_dev_if' type_id=12 bits_offset=0
> > >> >     'family' type_id=12 bits_offset=32
> > >> >     'type' type_id=12 bits_offset=64
> > >> >     'protocol' type_id=12 bits_offset=96
> > >> >     'mark' type_id=12 bits_offset=128
> > >> >     'priority' type_id=12 bits_offset=160
> > >> >     'src_ip4' type_id=12 bits_offset=192
> > >> >     'src_ip6' type_id=28 bits_offset=224
> > >> >     'src_port' type_id=12 bits_offset=352
> > >> >     'dst_port' type_id=20 bits_offset=384
> > >> >     'dst_ip4' type_id=12 bits_offset=416
> > >> >     'dst_ip6' type_id=28 bits_offset=448
> > >> >     'state' type_id=12 bits_offset=576
> > >> >     'rx_queue_mapping' type_id=10 bits_offset=608
> > >> > [32] PTR '(anon)' type_id=31
> > >> > [33] STRUCT '__sk_buff' size=192 vlen=33
> > >> >     'len' type_id=12 bits_offset=0
> > >> >     'pkt_type' type_id=12 bits_offset=32
> > >> >     'mark' type_id=12 bits_offset=64
> > >> >     'queue_mapping' type_id=12 bits_offset=96
> > >> >     'protocol' type_id=12 bits_offset=128
> > >> >     'vlan_present' type_id=12 bits_offset=160
> > >> >     'vlan_tci' type_id=12 bits_offset=192
> > >> >     'vlan_proto' type_id=12 bits_offset=224
> > >> >     'priority' type_id=12 bits_offset=256
> > >> >     'ingress_ifindex' type_id=12 bits_offset=288
> > >> >     'ifindex' type_id=12 bits_offset=320
> > >> >     'tc_index' type_id=12 bits_offset=352
> > >> >     'cb' type_id=34 bits_offset=384
> > >> >     'hash' type_id=12 bits_offset=544
> > >> >     'tc_classid' type_id=12 bits_offset=576
> > >> >     'data' type_id=12 bits_offset=608
> > >> >     'data_end' type_id=12 bits_offset=640
> > >> >     'napi_id' type_id=12 bits_offset=672
> > >> >     'family' type_id=12 bits_offset=704
> > >> >     'remote_ip4' type_id=12 bits_offset=736
> > >> >     'local_ip4' type_id=12 bits_offset=768
> > >> >     'remote_ip6' type_id=28 bits_offset=800
> > >> >     'local_ip6' type_id=28 bits_offset=928
> > >> >     'remote_port' type_id=12 bits_offset=1056
> > >> >     'local_port' type_id=12 bits_offset=1088
> > >> >     'data_meta' type_id=12 bits_offset=1120
> > >> >     '(anon)' type_id=23 bits_offset=1152
> > >> >     'tstamp' type_id=15 bits_offset=1216
> > >> >     'wire_len' type_id=12 bits_offset=1280
> > >> >     'gso_segs' type_id=12 bits_offset=1312
> > >> >     '(anon)' type_id=30 bits_offset=1344
> > >> >     'gso_size' type_id=12 bits_offset=1408
> > >> >     'hwtstamp' type_id=15 bits_offset=1472
> > >> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
> > >> > [35] CONST '(anon)' type_id=33
> > >> > [36] PTR '(anon)' type_id=0
> > >> > [37] STRUCT '(anon)' size=24 vlen=3
> > >> >     'type' type_id=39 bits_offset=0
> > >> >     'key' type_id=40 bits_offset=64
> > >> >     'value' type_id=41 bits_offset=128
> > >> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
> > >> > [39] PTR '(anon)' type_id=38
> > >> > [40] PTR '(anon)' type_id=12
> > >> > [41] PTR '(anon)' type_id=3
> > >> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
> > >> > [43] CONST '(anon)' type_id=42
> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
> > >> >     '(anon)' type_id=36
> > >> >     '(anon)' type_id=46
> > >> > [45] CONST '(anon)' type_id=0
> > >> > [46] PTR '(anon)' type_id=45
> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> > >> >     'sk' type_id=48
> > >> > [48] PTR '(anon)' type_id=35
> > >> > [49] VAR '_license' type_id=43, linkage=static
> > >> > [50] VAR 'is_allow_list' type_id=5, linkage=global
> > >> > [51] VAR 'sd_restrictif' type_id=37, linkage=global
> > >> > [52] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> > >> > [53] FUNC 'sd_restrictif_e' type_id=47 linkage=global
> > >> > [54] FUNC 'restrict_network_interfaces_impl' type_id=47 linkage=static
> > >> > [55] DATASEC '.data' size=1 vlen=1
> > >> >     type_id=50 offset=0 size=1 (VAR 'is_allow_list')
> > >> > [56] DATASEC 'license' size=18 vlen=1
> > >> >     type_id=49 offset=0 size=18 (VAR '_license')
> > >> > [57] DATASEC '.maps' size=24 vlen=1
> > >> >     type_id=51 offset=0 size=24 (VAR 'sd_restrictif')
> > >> >
> > >> > File before being stripped using bpftool gen object:
> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > >> > btf dump file
> > >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> > >> > format raw
> > >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> > >> > [3] TYPEDEF '__u8' type_id=2
> > >> > [4] CONST '(anon)' type_id=3
> > >> > [5] VOLATILE '(anon)' type_id=4
> > >> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
> > >> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
> > >> > [8] TYPEDEF '__u16' type_id=7
> > >> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > >> > [10] TYPEDEF '__s32' type_id=9
> > >> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > >> > [12] TYPEDEF '__u32' type_id=11
> > >> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > >> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
> > >> > encoding=(none)
> > >> > [15] TYPEDEF '__u64' type_id=14
> > >> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > >> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > >> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > >> > [19] CONST '(anon)' type_id=18
> > >> > [20] TYPEDEF '__be16' type_id=8
> > >> > [21] TYPEDEF '__be32' type_id=12
> > >> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
> > >> >     'BPF_MAP_TYPE_UNSPEC' val=0
> > >> >     'BPF_MAP_TYPE_HASH' val=1
> > >> >     'BPF_MAP_TYPE_ARRAY' val=2
> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=9
> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
> > >> >     'BPF_MAP_TYPE_DEVMAP' val=14
> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=15
> > >> >     'BPF_MAP_TYPE_CPUMAP' val=16
> > >> >     'BPF_MAP_TYPE_XSKMAP' val=17
> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=18
> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
> > >> >     'BPF_MAP_TYPE_QUEUE' val=22
> > >> >     'BPF_MAP_TYPE_STACK' val=23
> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
> > >> >     'BPF_MAP_TYPE_RINGBUF' val=27
> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
> > >> > [23] UNION '(anon)' size=8 vlen=1
> > >> >     'flow_keys' type_id=29 bits_offset=0
> > >> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
> > >> >     'nhoff' type_id=8 bits_offset=0
> > >> >     'thoff' type_id=8 bits_offset=16
> > >> >     'addr_proto' type_id=8 bits_offset=32
> > >> >     'is_frag' type_id=3 bits_offset=48
> > >> >     'is_first_frag' type_id=3 bits_offset=56
> > >> >     'is_encap' type_id=3 bits_offset=64
> > >> >     'ip_proto' type_id=3 bits_offset=72
> > >> >     'n_proto' type_id=20 bits_offset=80
> > >> >     'sport' type_id=20 bits_offset=96
> > >> >     'dport' type_id=20 bits_offset=112
> > >> >     '(anon)' type_id=25 bits_offset=128
> > >> >     'flags' type_id=12 bits_offset=384
> > >> >     'flow_label' type_id=21 bits_offset=416
> > >> > [25] UNION '(anon)' size=32 vlen=2
> > >> >     '(anon)' type_id=26 bits_offset=0
> > >> >     '(anon)' type_id=27 bits_offset=0
> > >> > [26] STRUCT '(anon)' size=8 vlen=2
> > >> >     'ipv4_src' type_id=21 bits_offset=0
> > >> >     'ipv4_dst' type_id=21 bits_offset=32
> > >> > [27] STRUCT '(anon)' size=32 vlen=2
> > >> >     'ipv6_src' type_id=28 bits_offset=0
> > >> >     'ipv6_dst' type_id=28 bits_offset=128
> > >> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
> > >> > [29] PTR '(anon)' type_id=24
> > >> > [30] UNION '(anon)' size=8 vlen=1
> > >> >     'sk' type_id=32 bits_offset=0
> > >> > [31] STRUCT 'bpf_sock' size=80 vlen=14
> > >> >     'bound_dev_if' type_id=12 bits_offset=0
> > >> >     'family' type_id=12 bits_offset=32
> > >> >     'type' type_id=12 bits_offset=64
> > >> >     'protocol' type_id=12 bits_offset=96
> > >> >     'mark' type_id=12 bits_offset=128
> > >> >     'priority' type_id=12 bits_offset=160
> > >> >     'src_ip4' type_id=12 bits_offset=192
> > >> >     'src_ip6' type_id=28 bits_offset=224
> > >> >     'src_port' type_id=12 bits_offset=352
> > >> >     'dst_port' type_id=20 bits_offset=384
> > >> >     'dst_ip4' type_id=12 bits_offset=416
> > >> >     'dst_ip6' type_id=28 bits_offset=448
> > >> >     'state' type_id=12 bits_offset=576
> > >> >     'rx_queue_mapping' type_id=10 bits_offset=608
> > >> > [32] PTR '(anon)' type_id=31
> > >> > [33] STRUCT '__sk_buff' size=192 vlen=33
> > >> >     'len' type_id=12 bits_offset=0
> > >> >     'pkt_type' type_id=12 bits_offset=32
> > >> >     'mark' type_id=12 bits_offset=64
> > >> >     'queue_mapping' type_id=12 bits_offset=96
> > >> >     'protocol' type_id=12 bits_offset=128
> > >> >     'vlan_present' type_id=12 bits_offset=160
> > >> >     'vlan_tci' type_id=12 bits_offset=192
> > >> >     'vlan_proto' type_id=12 bits_offset=224
> > >> >     'priority' type_id=12 bits_offset=256
> > >> >     'ingress_ifindex' type_id=12 bits_offset=288
> > >> >     'ifindex' type_id=12 bits_offset=320
> > >> >     'tc_index' type_id=12 bits_offset=352
> > >> >     'cb' type_id=34 bits_offset=384
> > >> >     'hash' type_id=12 bits_offset=544
> > >> >     'tc_classid' type_id=12 bits_offset=576
> > >> >     'data' type_id=12 bits_offset=608
> > >> >     'data_end' type_id=12 bits_offset=640
> > >> >     'napi_id' type_id=12 bits_offset=672
> > >> >     'family' type_id=12 bits_offset=704
> > >> >     'remote_ip4' type_id=12 bits_offset=736
> > >> >     'local_ip4' type_id=12 bits_offset=768
> > >> >     'remote_ip6' type_id=28 bits_offset=800
> > >> >     'local_ip6' type_id=28 bits_offset=928
> > >> >     'remote_port' type_id=12 bits_offset=1056
> > >> >     'local_port' type_id=12 bits_offset=1088
> > >> >     'data_meta' type_id=12 bits_offset=1120
> > >> >     '(anon)' type_id=23 bits_offset=1152
> > >> >     'tstamp' type_id=15 bits_offset=1216
> > >> >     'wire_len' type_id=12 bits_offset=1280
> > >> >     'gso_segs' type_id=12 bits_offset=1312
> > >> >     '(anon)' type_id=30 bits_offset=1344
> > >> >     'gso_size' type_id=12 bits_offset=1408
> > >> >     'hwtstamp' type_id=15 bits_offset=1472
> > >> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
> > >> > [35] CONST '(anon)' type_id=33
> > >> > [36] PTR '(anon)' type_id=0
> > >> > [37] STRUCT '(anon)' size=24 vlen=3
> > >> >     'type' type_id=39 bits_offset=0
> > >> >     'key' type_id=40 bits_offset=64
> > >> >     'value' type_id=41 bits_offset=128
> > >> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
> > >> > [39] PTR '(anon)' type_id=38
> > >> > [40] PTR '(anon)' type_id=12
> > >> > [41] PTR '(anon)' type_id=3
> > >> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
> > >> > [43] CONST '(anon)' type_id=42
> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
> > >> >     '(anon)' type_id=36
> > >> >     '(anon)' type_id=46
> > >> > [45] CONST '(anon)' type_id=0
> > >> > [46] PTR '(anon)' type_id=45
> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> > >> >     'sk' type_id=48
> > >> > [48] PTR '(anon)' type_id=35
> > >> > [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> > >> >     'sk' type_id=48
> > >> > [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> > >> >     'sk' type_id=48
> > >> > [51] VAR '_license' type_id=43, linkage=static
> > >> > [52] VAR 'is_allow_list' type_id=5, linkage=global
> > >> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
> > >> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=global
> > >> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> > >> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=global
> > >> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
> > >> > [58] DATASEC 'license' size=0 vlen=1
> > >> >     type_id=51 offset=0 size=18 (VAR '_license')
> > >> > [59] DATASEC '.maps' size=0 vlen=1
> > >> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
> > >> > [60] DATASEC '.data' size=0 vlen=1
> > >> >     type_id=52 offset=0 size=1 (VAR 'is_allow_list')
> > >> >
> > >> >>
> > >> >> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
> > >> >> >> expects it to be marked as such in BTF.
> > >> >> >>
> > >> >> >>
> > >> > https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
> > >> >> >>
> > >> >> >>
> > >> >> >>> GCC:
> > >> >> >>>
> > >> >> >>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > >> >> >>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> > >> >> >>> [3] TYPEDEF '__u8' type_id=2
> > >> >> >>> [4] CONST '(anon)' type_id=3
> > >> >> >>
> > >> >> >> [...]
