Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1156905B
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiGFRMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiGFRMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:12:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADF286F9
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:11:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q18-20020a9d7c92000000b00616b27cda7cso12242597otn.9
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SqhLPm0UyAORNu7WmQbGZ/RqSM0DJgihZqlIL0/XkaU=;
        b=q05tn/Gs6sDIu22mXOp0aot2CVCGgn0YBYXUMz+NZm/B98IOzPlRknoL3E4dTO56FB
         iwfcSFkKEpfhR1IOtKK9l0iGf7Gm7Wj/4u2oEiZLoPu6tRGK1qCuPtpZJ1gfY4DeeHbn
         ijJj47RovPwZuebWeAJu0T0HY1g8l6JmAQ+BMCuCZITNG39IkqW/gC8dpUmo8yIGMkk4
         eFG8PdoS6953VW7DkbK64aPY1CmUlMws7R2W/yKyf1V6HduTownRPSxxxmzev8Xugt8A
         aTqNKiu2oEqAy4Eg7r4jLaRqEGtzMcnifehmn7xvLpwsFGgyMR13ogoV3WlNNIpe3V54
         jDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SqhLPm0UyAORNu7WmQbGZ/RqSM0DJgihZqlIL0/XkaU=;
        b=RCA/Vekc0LG8kKHXLMIhtGPm1Ndl7ejChUpHMgLNtComozt5TVpRNv2cLv19/wVgTM
         O0MTEifxaMl6McrSDgeEjLEzHEjiM9blWdof5mNpPu+00fVmQgyNH2lx/gyRFl3FgYbR
         a10rRan1Xme0xvTkIhP567k7wXrNAodQuOavLuJr1Oj51RPEjl2yl+/zKng4HL7YIfSA
         prDzfvKhEJ4+gsi+O4RcqGZMR2Tx/v8MMNc/CNkFcvTaOJyWMsM4AtwhgAHHELXIKZbJ
         9ywyTQ+1hDSO5SQ67IPHb8hX4EB7ZFsAn4kFqTfLSwlv6bNUYZyGZF/jMCIvBGfMhHsy
         EkBg==
X-Gm-Message-State: AJIora/DhOOM3wsmjIo7TUBbwJQLeC0awDAsBpugWLQLHWYvAsBkZcJY
        EmYFIAuNm4euepf89tfuTHygJUwT8MFF/He6PiC1FYtGDMI=
X-Google-Smtp-Source: AGRyM1tD7bbcoMG56XZcHJvQij9er8Jn1bs7l2VITbzkQpObLebYyLAQKZJ+S24WCftmu7IvPcyisI6WWif/+90DOy8=
X-Received: by 2002:a05:6830:4422:b0:616:ef53:918c with SMTP id
 q34-20020a056830442200b00616ef53918cmr18420599otv.151.1657127518087; Wed, 06
 Jul 2022 10:11:58 -0700 (PDT)
MIME-Version: 1.0
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 6 Jul 2022 11:11:47 -0600
Message-ID: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
Subject: bpftool gen object doesn't handle GCC built BPF ELF files
To:     bpf <bpf@vger.kernel.org>
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

Note I'm testing with the following patches:
https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/

It would appear there's some compatibility issues with bpftool gen and
GCC, not sure what side though is wrong here:
/home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
Error: failed to link
'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
Unknown error -2 (-2)

Relevant difference seems to be this:
GCC:
[55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
Clang:
[27] FUNC 'sd_restrictif_i' type_id=26 linkage=global

GCC:

[1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
[2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
[3] TYPEDEF '__u8' type_id=2
[4] CONST '(anon)' type_id=3
[5] VOLATILE '(anon)' type_id=4
[6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
[7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
[8] TYPEDEF '__u16' type_id=7
[9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[10] TYPEDEF '__s32' type_id=9
[11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[12] TYPEDEF '__u32' type_id=11
[13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
encoding=(none)
[15] TYPEDEF '__u64' type_id=14
[16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
[19] CONST '(anon)' type_id=18
[20] TYPEDEF '__be16' type_id=8
[21] TYPEDEF '__be32' type_id=12
[22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
    'BPF_MAP_TYPE_UNSPEC' val=0
    'BPF_MAP_TYPE_HASH' val=1
    'BPF_MAP_TYPE_ARRAY' val=2
    'BPF_MAP_TYPE_PROG_ARRAY' val=3
    'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
    'BPF_MAP_TYPE_PERCPU_HASH' val=5
    'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
    'BPF_MAP_TYPE_STACK_TRACE' val=7
    'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
    'BPF_MAP_TYPE_LRU_HASH' val=9
    'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
    'BPF_MAP_TYPE_LPM_TRIE' val=11
    'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
    'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
    'BPF_MAP_TYPE_DEVMAP' val=14
    'BPF_MAP_TYPE_SOCKMAP' val=15
    'BPF_MAP_TYPE_CPUMAP' val=16
    'BPF_MAP_TYPE_XSKMAP' val=17
    'BPF_MAP_TYPE_SOCKHASH' val=18
    'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
    'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
    'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
    'BPF_MAP_TYPE_QUEUE' val=22
    'BPF_MAP_TYPE_STACK' val=23
    'BPF_MAP_TYPE_SK_STORAGE' val=24
    'BPF_MAP_TYPE_DEVMAP_HASH' val=25
    'BPF_MAP_TYPE_STRUCT_OPS' val=26
    'BPF_MAP_TYPE_RINGBUF' val=27
    'BPF_MAP_TYPE_INODE_STORAGE' val=28
    'BPF_MAP_TYPE_TASK_STORAGE' val=29
    'BPF_MAP_TYPE_BLOOM_FILTER' val=30
[23] UNION '(anon)' size=8 vlen=1
    'flow_keys' type_id=29 bits_offset=0
[24] STRUCT 'bpf_flow_keys' size=56 vlen=13
    'nhoff' type_id=8 bits_offset=0
    'thoff' type_id=8 bits_offset=16
    'addr_proto' type_id=8 bits_offset=32
    'is_frag' type_id=3 bits_offset=48
    'is_first_frag' type_id=3 bits_offset=56
    'is_encap' type_id=3 bits_offset=64
    'ip_proto' type_id=3 bits_offset=72
    'n_proto' type_id=20 bits_offset=80
    'sport' type_id=20 bits_offset=96
    'dport' type_id=20 bits_offset=112
    '(anon)' type_id=25 bits_offset=128
    'flags' type_id=12 bits_offset=384
    'flow_label' type_id=21 bits_offset=416
[25] UNION '(anon)' size=32 vlen=2
    '(anon)' type_id=26 bits_offset=0
    '(anon)' type_id=27 bits_offset=0
[26] STRUCT '(anon)' size=8 vlen=2
    'ipv4_src' type_id=21 bits_offset=0
    'ipv4_dst' type_id=21 bits_offset=32
[27] STRUCT '(anon)' size=32 vlen=2
    'ipv6_src' type_id=28 bits_offset=0
    'ipv6_dst' type_id=28 bits_offset=128
[28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
[29] PTR '(anon)' type_id=24
[30] UNION '(anon)' size=8 vlen=1
    'sk' type_id=32 bits_offset=0
[31] STRUCT 'bpf_sock' size=80 vlen=14
    'bound_dev_if' type_id=12 bits_offset=0
    'family' type_id=12 bits_offset=32
    'type' type_id=12 bits_offset=64
    'protocol' type_id=12 bits_offset=96
    'mark' type_id=12 bits_offset=128
    'priority' type_id=12 bits_offset=160
    'src_ip4' type_id=12 bits_offset=192
    'src_ip6' type_id=28 bits_offset=224
    'src_port' type_id=12 bits_offset=352
    'dst_port' type_id=20 bits_offset=384
    'dst_ip4' type_id=12 bits_offset=416
    'dst_ip6' type_id=28 bits_offset=448
    'state' type_id=12 bits_offset=576
    'rx_queue_mapping' type_id=10 bits_offset=608
[32] PTR '(anon)' type_id=31
[33] STRUCT '__sk_buff' size=192 vlen=33
    'len' type_id=12 bits_offset=0
    'pkt_type' type_id=12 bits_offset=32
    'mark' type_id=12 bits_offset=64
    'queue_mapping' type_id=12 bits_offset=96
    'protocol' type_id=12 bits_offset=128
    'vlan_present' type_id=12 bits_offset=160
    'vlan_tci' type_id=12 bits_offset=192
    'vlan_proto' type_id=12 bits_offset=224
    'priority' type_id=12 bits_offset=256
    'ingress_ifindex' type_id=12 bits_offset=288
    'ifindex' type_id=12 bits_offset=320
    'tc_index' type_id=12 bits_offset=352
    'cb' type_id=34 bits_offset=384
    'hash' type_id=12 bits_offset=544
    'tc_classid' type_id=12 bits_offset=576
    'data' type_id=12 bits_offset=608
    'data_end' type_id=12 bits_offset=640
    'napi_id' type_id=12 bits_offset=672
    'family' type_id=12 bits_offset=704
    'remote_ip4' type_id=12 bits_offset=736
    'local_ip4' type_id=12 bits_offset=768
    'remote_ip6' type_id=28 bits_offset=800
    'local_ip6' type_id=28 bits_offset=928
    'remote_port' type_id=12 bits_offset=1056
    'local_port' type_id=12 bits_offset=1088
    'data_meta' type_id=12 bits_offset=1120
    '(anon)' type_id=23 bits_offset=1152
    'tstamp' type_id=15 bits_offset=1216
    'wire_len' type_id=12 bits_offset=1280
    'gso_segs' type_id=12 bits_offset=1312
    '(anon)' type_id=30 bits_offset=1344
    'gso_size' type_id=12 bits_offset=1408
    'hwtstamp' type_id=15 bits_offset=1472
[34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
[35] CONST '(anon)' type_id=33
[36] PTR '(anon)' type_id=0
[37] STRUCT '(anon)' size=24 vlen=3
    'type' type_id=39 bits_offset=0
    'key' type_id=40 bits_offset=64
    'value' type_id=41 bits_offset=128
[38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
[39] PTR '(anon)' type_id=38
[40] PTR '(anon)' type_id=12
[41] PTR '(anon)' type_id=3
[42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
[43] CONST '(anon)' type_id=42
[44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
    '(anon)' type_id=36
    '(anon)' type_id=46
[45] CONST '(anon)' type_id=0
[46] PTR '(anon)' type_id=45
[47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
    'sk' type_id=48
[48] PTR '(anon)' type_id=35
[49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
    'sk' type_id=48
[50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
    'sk' type_id=48
[51] VAR '_license' type_id=43, linkage=static
[52] VAR 'sd_restrictif' type_id=37, linkage=global
[53] VAR 'is_allow_list' type_id=5, linkage=global
[54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=static
[55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
[56] FUNC 'sd_restrictif_e' type_id=49 linkage=static
[57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
[58] DATASEC 'license' size=0 vlen=1
    type_id=51 offset=0 size=18 (VAR '_license')
[59] DATASEC '.maps' size=0 vlen=1
    type_id=52 offset=0 size=24 (VAR 'sd_restrictif')
[60] DATASEC '.data' size=0 vlen=1
    type_id=53 offset=0 size=1 (VAR 'is_allow_list')



Clang:

[1] PTR '(anon)' type_id=3
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
[4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[5] PTR '(anon)' type_id=6
[6] TYPEDEF '__u32' type_id=7
[7] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[8] PTR '(anon)' type_id=9
[9] TYPEDEF '__u8' type_id=10
[10] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[11] STRUCT '(anon)' size=24 vlen=3
    'type' type_id=1 bits_offset=0
    'key' type_id=5 bits_offset=64
    'value' type_id=8 bits_offset=128
[12] VAR 'sd_restrictif' type_id=11, linkage=global
[13] PTR '(anon)' type_id=14
[14] CONST '(anon)' type_id=15
[15] STRUCT '__sk_buff' size=192 vlen=33
    'len' type_id=6 bits_offset=0
    'pkt_type' type_id=6 bits_offset=32
    'mark' type_id=6 bits_offset=64
    'queue_mapping' type_id=6 bits_offset=96
    'protocol' type_id=6 bits_offset=128
    'vlan_present' type_id=6 bits_offset=160
    'vlan_tci' type_id=6 bits_offset=192
    'vlan_proto' type_id=6 bits_offset=224
    'priority' type_id=6 bits_offset=256
    'ingress_ifindex' type_id=6 bits_offset=288
    'ifindex' type_id=6 bits_offset=320
    'tc_index' type_id=6 bits_offset=352
    'cb' type_id=16 bits_offset=384
    'hash' type_id=6 bits_offset=544
    'tc_classid' type_id=6 bits_offset=576
    'data' type_id=6 bits_offset=608
    'data_end' type_id=6 bits_offset=640
    'napi_id' type_id=6 bits_offset=672
    'family' type_id=6 bits_offset=704
    'remote_ip4' type_id=6 bits_offset=736
    'local_ip4' type_id=6 bits_offset=768
    'remote_ip6' type_id=17 bits_offset=800
    'local_ip6' type_id=17 bits_offset=928
    'remote_port' type_id=6 bits_offset=1056
    'local_port' type_id=6 bits_offset=1088
    'data_meta' type_id=6 bits_offset=1120
    '(anon)' type_id=18 bits_offset=1152
    'tstamp' type_id=20 bits_offset=1216
    'wire_len' type_id=6 bits_offset=1280
    'gso_segs' type_id=6 bits_offset=1312
    '(anon)' type_id=22 bits_offset=1344
    'gso_size' type_id=6 bits_offset=1408
    'hwtstamp' type_id=20 bits_offset=1472
[16] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=5
[17] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=4
[18] UNION '(anon)' size=8 vlen=1
    'flow_keys' type_id=19 bits_offset=0
[19] PTR '(anon)' type_id=38
[20] TYPEDEF '__u64' type_id=21
[21] INT 'unsigned long long' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[22] UNION '(anon)' size=8 vlen=1
    'sk' type_id=23 bits_offset=0
[23] PTR '(anon)' type_id=39
[24] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
    'sk' type_id=13
[25] FUNC 'sd_restrictif_e' type_id=24 linkage=global
[26] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
    'sk' type_id=13
[27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
[28] CONST '(anon)' type_id=29
[29] VOLATILE '(anon)' type_id=9
[30] VAR 'is_allow_list' type_id=28, linkage=global
[31] CONST '(anon)' type_id=32
[32] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[33] ARRAY '(anon)' type_id=31 index_type_id=4 nr_elems=18
[34] VAR '_license' type_id=33, linkage=static
[35] DATASEC '.maps' size=0 vlen=1
    type_id=12 offset=0 size=24 (VAR 'sd_restrictif')
[36] DATASEC '.rodata' size=0 vlen=1
    type_id=30 offset=0 size=1 (VAR 'is_allow_list')
[37] DATASEC 'license' size=0 vlen=1
    type_id=34 offset=0 size=18 (VAR '_license')
[38] FWD 'bpf_flow_keys' fwd_kind=struct
[39] FWD 'bpf_sock' fwd_kind=struct
