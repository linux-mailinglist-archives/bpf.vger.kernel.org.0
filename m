Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7456CAED
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiGIR20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIR2Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 13:28:25 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCF371A8
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 10:28:24 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bec750eedso2303654fac.8
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uUec603TiauIag4MSPPvYQait6zXrkxgq4oUHDDXWs=;
        b=EuShF3Zavvpo1LwKD4zvBEbcPD09PhU4wWCsQvVJ4MByP4Ofl4SxmOUlJt8+6bcAUq
         JP5njnnyn0f1qGc0sEFlQhai7PASsp3/8lEsHMwiCM0hqicrZaYTdzi1scVcAqfqWkgL
         B4QJtUSUHCTepMV98V4L0QOd7J4/VxtgV1C3KwXRF9LQrvaILQN7AIlbC4GR9DWwTirm
         XiYeWt/k8glQ7a6vA8vxxEsde4TxUiwNM5gFWRybGUGlwYh67oPnLufwqz8vuY7DPAP+
         SzOcIkEzpx/dzPHqDWSa9Sh8w8l7kc25LVXc1S6Y6//0YYNXR46GE3vx9ZbNqwFOUBWY
         ohPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uUec603TiauIag4MSPPvYQait6zXrkxgq4oUHDDXWs=;
        b=uCLMEBhVIUFAunsCySVNV7/46BBEX5DEi1Bjn5nZp3LTnrlG1pFRnfkQjs67+TrsbA
         Rysb4gwmh2sGZx1gNqigsar41OmfOQANMDNf5STNskmov8Hzgikpwd2tEy74zyw8zKjs
         wMhlRPusIic/jgiEWa1sjQVfCPnl17vGD+X47jv9sEgIN+coJAJr2VlwcDJ/AYw/6ZMl
         msXb49g151uz66brZ8p+EQWeap35rf0J30fQi43FNMjDcmFsVCd57bSsvYXQrsxgFisG
         0hTLui/KIjFqV2+v5XpyLybKwaLR4STd0lfGotfCw6FV1ROKcINRuPKbBIyBy+pKmbRV
         aY2w==
X-Gm-Message-State: AJIora+/cIlj94IUz2L2ii2bemP8lSHY8ZQKV4FkVK35C3rTQY4XAmv6
        xbuv4O6I4rZEGnzqKGSFJs/aF8TuG7VBQnvupTymxgk3260eZw==
X-Google-Smtp-Source: AGRyM1uJIAuvXQ0yUOrWpvEpdDuwyu+zwmM6HxzJZL5tpjfa287aIkU0MGTmffgnaMMPbSUwB3x5Eacuzk64RTwp8ow=
X-Received: by 2002:a05:6870:d0ce:b0:f3:3856:f552 with SMTP id
 k14-20020a056870d0ce00b000f33856f552mr3435997oaa.99.1657387703246; Sat, 09
 Jul 2022 10:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
 <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
 <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com> <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
 <87v8s65hdc.fsf@oracle.com>
In-Reply-To: <87v8s65hdc.fsf@oracle.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 9 Jul 2022 11:28:12 -0600
Message-ID: <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
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

On Sat, Jul 9, 2022 at 11:24 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
> >> >> <james.hilliard1@gmail.com> wrote:
> >> >>>
> >> >>> Note I'm testing with the following patches:
> >> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
> >> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
> >> >>>
> >> >>> It would appear there's some compatibility issues with bpftool gen and
> >> >>> GCC, not sure what side though is wrong here:
> >> >>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> >> >>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> >> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> >> >>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
> >> >>> Error: failed to link
> >> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
> >> >>> Unknown error -2 (-2)
> >> >>>
> >> >>> Relevant difference seems to be this:
> >> >>> GCC:
> >> >>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
> >> >>> Clang:
> >> >>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
> >> >
> >> > For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
> >> > information, or so we thought: I just looked at bpftool/btf.c and I
> >> > found the linkage info for function types is expected to be encoded in
> >> > the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
> >> > instead???) which is surprising to say the least.
> >> >
> >> > We are changing GCC to encode the linkage info in vlen for these types.
> >> > Thanks for reporting this.
> >>
> >> Patch sent to GCC upstream:
> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html
> >
> > I applied that patch on top of GCC 12.1.0 and it appears to fix the
> > bpftool gen object bug.
> >
> > I am however now hitting a different error during skeleton generation:
> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > libbpf: elf: skipping unrecognized data section(9) .comment
> > libbpf: failed to alloc map 'restrict.bss' content buffer: -22
> > Error: failed to open BPF object file: Invalid argument
>
> What is the size of the .bss section in the object file?  Try with:
>
> $ size restrict-ifaces.bpf.o

$ size output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
   text       data        bss        dec        hex    filename
    386         25          0        411        19b
output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o

>
> Looking at libbpf.c, it seems to me that this may be due of trying to
> mmap 0 bytes in `bpf_object__init_internal_map':
>
>         map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         if (map->mmaped == MAP_FAILED) {
>                 err = -errno;
>                 map->mmaped = NULL;
>                 pr_warn("failed to alloc map '%s' content buffer: %d\n",
>                         map->name, err);
>                 zfree(&map->real_name);
>                 zfree(&map->name);
>                 return err;
>         }
>
> I see no check for zero sized sections in
> bpf_object__init_global_data_maps.
>
> Is maybe GCC failing to allocate stuff in BSS that is supposed to be
> there?
>
> > Stripped file passed to gen skeleton:
> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > btf dump file
> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> > format raw
> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> > [3] TYPEDEF '__u8' type_id=2
> > [4] CONST '(anon)' type_id=3
> > [5] VOLATILE '(anon)' type_id=4
> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
> > [8] TYPEDEF '__u16' type_id=7
> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > [10] TYPEDEF '__s32' type_id=9
> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > [12] TYPEDEF '__u32' type_id=11
> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
> > encoding=(none)
> > [15] TYPEDEF '__u64' type_id=14
> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > [19] CONST '(anon)' type_id=18
> > [20] TYPEDEF '__be16' type_id=8
> > [21] TYPEDEF '__be32' type_id=12
> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
> >     'BPF_MAP_TYPE_UNSPEC' val=0
> >     'BPF_MAP_TYPE_HASH' val=1
> >     'BPF_MAP_TYPE_ARRAY' val=2
> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
> >     'BPF_MAP_TYPE_LRU_HASH' val=9
> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
> >     'BPF_MAP_TYPE_DEVMAP' val=14
> >     'BPF_MAP_TYPE_SOCKMAP' val=15
> >     'BPF_MAP_TYPE_CPUMAP' val=16
> >     'BPF_MAP_TYPE_XSKMAP' val=17
> >     'BPF_MAP_TYPE_SOCKHASH' val=18
> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
> >     'BPF_MAP_TYPE_QUEUE' val=22
> >     'BPF_MAP_TYPE_STACK' val=23
> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
> >     'BPF_MAP_TYPE_RINGBUF' val=27
> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
> > [23] UNION '(anon)' size=8 vlen=1
> >     'flow_keys' type_id=29 bits_offset=0
> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
> >     'nhoff' type_id=8 bits_offset=0
> >     'thoff' type_id=8 bits_offset=16
> >     'addr_proto' type_id=8 bits_offset=32
> >     'is_frag' type_id=3 bits_offset=48
> >     'is_first_frag' type_id=3 bits_offset=56
> >     'is_encap' type_id=3 bits_offset=64
> >     'ip_proto' type_id=3 bits_offset=72
> >     'n_proto' type_id=20 bits_offset=80
> >     'sport' type_id=20 bits_offset=96
> >     'dport' type_id=20 bits_offset=112
> >     '(anon)' type_id=25 bits_offset=128
> >     'flags' type_id=12 bits_offset=384
> >     'flow_label' type_id=21 bits_offset=416
> > [25] UNION '(anon)' size=32 vlen=2
> >     '(anon)' type_id=26 bits_offset=0
> >     '(anon)' type_id=27 bits_offset=0
> > [26] STRUCT '(anon)' size=8 vlen=2
> >     'ipv4_src' type_id=21 bits_offset=0
> >     'ipv4_dst' type_id=21 bits_offset=32
> > [27] STRUCT '(anon)' size=32 vlen=2
> >     'ipv6_src' type_id=28 bits_offset=0
> >     'ipv6_dst' type_id=28 bits_offset=128
> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
> > [29] PTR '(anon)' type_id=24
> > [30] UNION '(anon)' size=8 vlen=1
> >     'sk' type_id=32 bits_offset=0
> > [31] STRUCT 'bpf_sock' size=80 vlen=14
> >     'bound_dev_if' type_id=12 bits_offset=0
> >     'family' type_id=12 bits_offset=32
> >     'type' type_id=12 bits_offset=64
> >     'protocol' type_id=12 bits_offset=96
> >     'mark' type_id=12 bits_offset=128
> >     'priority' type_id=12 bits_offset=160
> >     'src_ip4' type_id=12 bits_offset=192
> >     'src_ip6' type_id=28 bits_offset=224
> >     'src_port' type_id=12 bits_offset=352
> >     'dst_port' type_id=20 bits_offset=384
> >     'dst_ip4' type_id=12 bits_offset=416
> >     'dst_ip6' type_id=28 bits_offset=448
> >     'state' type_id=12 bits_offset=576
> >     'rx_queue_mapping' type_id=10 bits_offset=608
> > [32] PTR '(anon)' type_id=31
> > [33] STRUCT '__sk_buff' size=192 vlen=33
> >     'len' type_id=12 bits_offset=0
> >     'pkt_type' type_id=12 bits_offset=32
> >     'mark' type_id=12 bits_offset=64
> >     'queue_mapping' type_id=12 bits_offset=96
> >     'protocol' type_id=12 bits_offset=128
> >     'vlan_present' type_id=12 bits_offset=160
> >     'vlan_tci' type_id=12 bits_offset=192
> >     'vlan_proto' type_id=12 bits_offset=224
> >     'priority' type_id=12 bits_offset=256
> >     'ingress_ifindex' type_id=12 bits_offset=288
> >     'ifindex' type_id=12 bits_offset=320
> >     'tc_index' type_id=12 bits_offset=352
> >     'cb' type_id=34 bits_offset=384
> >     'hash' type_id=12 bits_offset=544
> >     'tc_classid' type_id=12 bits_offset=576
> >     'data' type_id=12 bits_offset=608
> >     'data_end' type_id=12 bits_offset=640
> >     'napi_id' type_id=12 bits_offset=672
> >     'family' type_id=12 bits_offset=704
> >     'remote_ip4' type_id=12 bits_offset=736
> >     'local_ip4' type_id=12 bits_offset=768
> >     'remote_ip6' type_id=28 bits_offset=800
> >     'local_ip6' type_id=28 bits_offset=928
> >     'remote_port' type_id=12 bits_offset=1056
> >     'local_port' type_id=12 bits_offset=1088
> >     'data_meta' type_id=12 bits_offset=1120
> >     '(anon)' type_id=23 bits_offset=1152
> >     'tstamp' type_id=15 bits_offset=1216
> >     'wire_len' type_id=12 bits_offset=1280
> >     'gso_segs' type_id=12 bits_offset=1312
> >     '(anon)' type_id=30 bits_offset=1344
> >     'gso_size' type_id=12 bits_offset=1408
> >     'hwtstamp' type_id=15 bits_offset=1472
> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
> > [35] CONST '(anon)' type_id=33
> > [36] PTR '(anon)' type_id=0
> > [37] STRUCT '(anon)' size=24 vlen=3
> >     'type' type_id=39 bits_offset=0
> >     'key' type_id=40 bits_offset=64
> >     'value' type_id=41 bits_offset=128
> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
> > [39] PTR '(anon)' type_id=38
> > [40] PTR '(anon)' type_id=12
> > [41] PTR '(anon)' type_id=3
> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
> > [43] CONST '(anon)' type_id=42
> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
> >     '(anon)' type_id=36
> >     '(anon)' type_id=46
> > [45] CONST '(anon)' type_id=0
> > [46] PTR '(anon)' type_id=45
> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> >     'sk' type_id=48
> > [48] PTR '(anon)' type_id=35
> > [49] VAR '_license' type_id=43, linkage=static
> > [50] VAR 'is_allow_list' type_id=5, linkage=global
> > [51] VAR 'sd_restrictif' type_id=37, linkage=global
> > [52] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> > [53] FUNC 'sd_restrictif_e' type_id=47 linkage=global
> > [54] FUNC 'restrict_network_interfaces_impl' type_id=47 linkage=static
> > [55] DATASEC '.data' size=1 vlen=1
> >     type_id=50 offset=0 size=1 (VAR 'is_allow_list')
> > [56] DATASEC 'license' size=18 vlen=1
> >     type_id=49 offset=0 size=18 (VAR '_license')
> > [57] DATASEC '.maps' size=24 vlen=1
> >     type_id=51 offset=0 size=24 (VAR 'sd_restrictif')
> >
> > File before being stripped using bpftool gen object:
> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> > btf dump file
> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> > format raw
> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> > [3] TYPEDEF '__u8' type_id=2
> > [4] CONST '(anon)' type_id=3
> > [5] VOLATILE '(anon)' type_id=4
> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
> > [8] TYPEDEF '__u16' type_id=7
> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > [10] TYPEDEF '__s32' type_id=9
> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > [12] TYPEDEF '__u32' type_id=11
> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
> > encoding=(none)
> > [15] TYPEDEF '__u64' type_id=14
> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> > [19] CONST '(anon)' type_id=18
> > [20] TYPEDEF '__be16' type_id=8
> > [21] TYPEDEF '__be32' type_id=12
> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
> >     'BPF_MAP_TYPE_UNSPEC' val=0
> >     'BPF_MAP_TYPE_HASH' val=1
> >     'BPF_MAP_TYPE_ARRAY' val=2
> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
> >     'BPF_MAP_TYPE_LRU_HASH' val=9
> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
> >     'BPF_MAP_TYPE_DEVMAP' val=14
> >     'BPF_MAP_TYPE_SOCKMAP' val=15
> >     'BPF_MAP_TYPE_CPUMAP' val=16
> >     'BPF_MAP_TYPE_XSKMAP' val=17
> >     'BPF_MAP_TYPE_SOCKHASH' val=18
> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
> >     'BPF_MAP_TYPE_QUEUE' val=22
> >     'BPF_MAP_TYPE_STACK' val=23
> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
> >     'BPF_MAP_TYPE_RINGBUF' val=27
> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
> > [23] UNION '(anon)' size=8 vlen=1
> >     'flow_keys' type_id=29 bits_offset=0
> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
> >     'nhoff' type_id=8 bits_offset=0
> >     'thoff' type_id=8 bits_offset=16
> >     'addr_proto' type_id=8 bits_offset=32
> >     'is_frag' type_id=3 bits_offset=48
> >     'is_first_frag' type_id=3 bits_offset=56
> >     'is_encap' type_id=3 bits_offset=64
> >     'ip_proto' type_id=3 bits_offset=72
> >     'n_proto' type_id=20 bits_offset=80
> >     'sport' type_id=20 bits_offset=96
> >     'dport' type_id=20 bits_offset=112
> >     '(anon)' type_id=25 bits_offset=128
> >     'flags' type_id=12 bits_offset=384
> >     'flow_label' type_id=21 bits_offset=416
> > [25] UNION '(anon)' size=32 vlen=2
> >     '(anon)' type_id=26 bits_offset=0
> >     '(anon)' type_id=27 bits_offset=0
> > [26] STRUCT '(anon)' size=8 vlen=2
> >     'ipv4_src' type_id=21 bits_offset=0
> >     'ipv4_dst' type_id=21 bits_offset=32
> > [27] STRUCT '(anon)' size=32 vlen=2
> >     'ipv6_src' type_id=28 bits_offset=0
> >     'ipv6_dst' type_id=28 bits_offset=128
> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
> > [29] PTR '(anon)' type_id=24
> > [30] UNION '(anon)' size=8 vlen=1
> >     'sk' type_id=32 bits_offset=0
> > [31] STRUCT 'bpf_sock' size=80 vlen=14
> >     'bound_dev_if' type_id=12 bits_offset=0
> >     'family' type_id=12 bits_offset=32
> >     'type' type_id=12 bits_offset=64
> >     'protocol' type_id=12 bits_offset=96
> >     'mark' type_id=12 bits_offset=128
> >     'priority' type_id=12 bits_offset=160
> >     'src_ip4' type_id=12 bits_offset=192
> >     'src_ip6' type_id=28 bits_offset=224
> >     'src_port' type_id=12 bits_offset=352
> >     'dst_port' type_id=20 bits_offset=384
> >     'dst_ip4' type_id=12 bits_offset=416
> >     'dst_ip6' type_id=28 bits_offset=448
> >     'state' type_id=12 bits_offset=576
> >     'rx_queue_mapping' type_id=10 bits_offset=608
> > [32] PTR '(anon)' type_id=31
> > [33] STRUCT '__sk_buff' size=192 vlen=33
> >     'len' type_id=12 bits_offset=0
> >     'pkt_type' type_id=12 bits_offset=32
> >     'mark' type_id=12 bits_offset=64
> >     'queue_mapping' type_id=12 bits_offset=96
> >     'protocol' type_id=12 bits_offset=128
> >     'vlan_present' type_id=12 bits_offset=160
> >     'vlan_tci' type_id=12 bits_offset=192
> >     'vlan_proto' type_id=12 bits_offset=224
> >     'priority' type_id=12 bits_offset=256
> >     'ingress_ifindex' type_id=12 bits_offset=288
> >     'ifindex' type_id=12 bits_offset=320
> >     'tc_index' type_id=12 bits_offset=352
> >     'cb' type_id=34 bits_offset=384
> >     'hash' type_id=12 bits_offset=544
> >     'tc_classid' type_id=12 bits_offset=576
> >     'data' type_id=12 bits_offset=608
> >     'data_end' type_id=12 bits_offset=640
> >     'napi_id' type_id=12 bits_offset=672
> >     'family' type_id=12 bits_offset=704
> >     'remote_ip4' type_id=12 bits_offset=736
> >     'local_ip4' type_id=12 bits_offset=768
> >     'remote_ip6' type_id=28 bits_offset=800
> >     'local_ip6' type_id=28 bits_offset=928
> >     'remote_port' type_id=12 bits_offset=1056
> >     'local_port' type_id=12 bits_offset=1088
> >     'data_meta' type_id=12 bits_offset=1120
> >     '(anon)' type_id=23 bits_offset=1152
> >     'tstamp' type_id=15 bits_offset=1216
> >     'wire_len' type_id=12 bits_offset=1280
> >     'gso_segs' type_id=12 bits_offset=1312
> >     '(anon)' type_id=30 bits_offset=1344
> >     'gso_size' type_id=12 bits_offset=1408
> >     'hwtstamp' type_id=15 bits_offset=1472
> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
> > [35] CONST '(anon)' type_id=33
> > [36] PTR '(anon)' type_id=0
> > [37] STRUCT '(anon)' size=24 vlen=3
> >     'type' type_id=39 bits_offset=0
> >     'key' type_id=40 bits_offset=64
> >     'value' type_id=41 bits_offset=128
> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
> > [39] PTR '(anon)' type_id=38
> > [40] PTR '(anon)' type_id=12
> > [41] PTR '(anon)' type_id=3
> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
> > [43] CONST '(anon)' type_id=42
> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
> >     '(anon)' type_id=36
> >     '(anon)' type_id=46
> > [45] CONST '(anon)' type_id=0
> > [46] PTR '(anon)' type_id=45
> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> >     'sk' type_id=48
> > [48] PTR '(anon)' type_id=35
> > [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> >     'sk' type_id=48
> > [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> >     'sk' type_id=48
> > [51] VAR '_license' type_id=43, linkage=static
> > [52] VAR 'is_allow_list' type_id=5, linkage=global
> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=global
> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=global
> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
> > [58] DATASEC 'license' size=0 vlen=1
> >     type_id=51 offset=0 size=18 (VAR '_license')
> > [59] DATASEC '.maps' size=0 vlen=1
> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
> > [60] DATASEC '.data' size=0 vlen=1
> >     type_id=52 offset=0 size=1 (VAR 'is_allow_list')
> >
> >>
> >> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
> >> >> expects it to be marked as such in BTF.
> >> >>
> >> >>
> > https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
> >> >>
> >> >>
> >> >>> GCC:
> >> >>>
> >> >>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> >> >>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> >> >>> [3] TYPEDEF '__u8' type_id=2
> >> >>> [4] CONST '(anon)' type_id=3
> >> >>
> >> >> [...]
