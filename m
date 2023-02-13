Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E637694547
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBMMKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 07:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjBMMJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 07:09:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBE199CD;
        Mon, 13 Feb 2023 04:09:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB93661000;
        Mon, 13 Feb 2023 12:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2058BC433D2;
        Mon, 13 Feb 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676290175;
        bh=1NWrQgvO8iQvp6xHpJO3OkjSahCDQcgNiru+DBr2/Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cn61TnYg83AWZz7FlZdUt8zZE739OgEWUKtkKAmh8XnpirnWLOoRg0KorzkGkKuTo
         ug+yxedahDnYQrxGb2F7JIGG4ZnN2eQMJWX0P34h0a3+A1Ns+ZSlquMcMGwk9gRJ2U
         Tu+ZR/g48DRcGqNlcGfVfigbGQ9UiUbvVOwtUXkWNec4t/tdqDIPHtUAo/Udfoa3Y8
         K1lO+bAjiD0XdHGDRYOcx/JUDgGQDmCQW3cjhajaYRKbcrk3aMRajF4ZH3xk1m+Hcq
         BzvIcQnX8YlVLdNSrnfXiMKN7lK07V7EWYpXFlnrx2gmcAEikv2Vuayme8m3he69Fh
         Jy8Zfws7kVtOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7462540025; Mon, 13 Feb 2023 09:09:32 -0300 (-03)
Date:   Mon, 13 Feb 2023 09:09:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
Message-ID: <Y+oofL/aJmUjcxIR@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
 <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+atpJV5rqo08dQJ@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 10, 2023 at 05:48:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> I'll go thru the others to see if they are easy (or at least restricted
> to Rust CUs) as this one.

The namespace.o seems to be ok:

⬢[acme@toolbox pahole]$ cat ../pahole-rust-cases/namespace.rs
pub struct S {
    pub a: i32,
}

pub static S: (i32, S) = (42, S { a: 42 });
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ pahole --show_private_classes ../pahole-rust-cases/namespace.o
struct S {
	i32                        a __attribute__((__aligned__(4))); /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* forced alignments: 1 */
	/* last cacheline: 4 bytes */
} __attribute__((__aligned__(4)));
struct (i32, namespace::S) {
	i32                        __0 __attribute__((__aligned__(4))); /*     0     4 */
	struct S                   __1 __attribute__((__aligned__(4))); /*     4     4 */

	/* size: 8, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(4)));
⬢[acme@toolbox pahole]$

And encoding/decoding BTF for it:

⬢[acme@toolbox pahole]$ cp ../pahole-rust-cases/namespace.o .
⬢[acme@toolbox pahole]$ pahole --btf_encode namespace.o
⬢[acme@toolbox pahole]$ pahole -F btf namespace.o
struct S {
	i32                        a;                    /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};
struct (i32, namespace::S) {
	i32                        __0;                  /*     0     4 */
	struct S                   __1;                  /*     4     4 */

	/* size: 8, cachelines: 1, members: 2 */
	/* last cacheline: 8 bytes */
};
⬢[acme@toolbox pahole]$ readelf -SW namespace.o | grep BTF
  [18] .BTF              PROGBITS        0000000000000000 00065c 000089 00      0   0  1
⬢[acme@toolbox pahole]$


The core one needs work:

⬢[acme@toolbox pahole]$ pahole ../pahole-rust-cases/core.o |& head
die__process_class: tag not supported 0x2f (template_type_parameter)!
die__process_class: tag not supported 0x33 (variant_part)!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2fd8d> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2fdf7> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2fe61> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2fecb> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2ff35> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x2ff9f> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x30009> not handled!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x30073> not handled!
⬢[acme@toolbox pahole]$

 <1><90>: Abbrev Number: 7 (DW_TAG_namespace)
    <91>   DW_AT_name        : (indirect string, offset: 0x147): core
 <2><95>: Abbrev Number: 7 (DW_TAG_namespace)
    <96>   DW_AT_name        : (indirect string, offset: 0x14c): str
 <3><9a>: Abbrev Number: 7 (DW_TAG_namespace)
    <9b>   DW_AT_name        : (indirect string, offset: 0x150): iter
 <4><9f>: Abbrev Number: 8 (DW_TAG_structure_type)
    <a0>   DW_AT_name        : (indirect string, offset: 0x2e1): Split<core::str::IsWhitespace>
    <a4>   DW_AT_byte_size   : 64
    <a5>   DW_AT_alignment   : 8
 <5><a6>: Abbrev Number: 9 (DW_TAG_template_type_param)
    <a7>   DW_AT_type        : <0x41fc>
    <ab>   DW_AT_name        : (indirect string, offset: 0x162): P
 <5><af>: Abbrev Number: 4 (DW_TAG_member)
    <b0>   DW_AT_name        : (indirect string, offset: 0x164): __0
    <b4>   DW_AT_type        : <0xbb>
    <b8>   DW_AT_alignment   : 8
    <b9>   DW_AT_data_member_location: 0
 <5><ba>: Abbrev Number: 0
 <4><bb>: Abbrev Number: 8 (DW_TAG_structure_type)
    <bc>   DW_AT_name        : (indirect string, offset: 0x2ba): SplitInternal<core::str::IsWhitespace>
    <c0>   DW_AT_byte_size   : 64
    <c1>   DW_AT_alignment   : 8
 <5><c2>: Abbrev Number: 9 (DW_TAG_template_type_param)
    <c3>   DW_AT_type        : <0x41fc>
    <c7>   DW_AT_name        : (indirect string, offset: 0x162): P

- Arnaldo
