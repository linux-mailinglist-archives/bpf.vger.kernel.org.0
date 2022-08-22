Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AF59CC32
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiHVX2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 19:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiHVX2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 19:28:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479C491E1;
        Mon, 22 Aug 2022 16:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D902CE17B5;
        Mon, 22 Aug 2022 23:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C12C433D6;
        Mon, 22 Aug 2022 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661210925;
        bh=C/y0LdNNtXlAXGOZEQmwPtIqwbi52QXUTWsRN7pX07A=;
        h=Date:From:To:Cc:Subject:From;
        b=jICwVmT6DYQqVa5Cj5HHJgCacwtl+0ar9ft25BxUIwCF55sAC35ZbjmfOXs1R99+p
         RjH5UPUx45+EtsWZeNbw9lMyuFZ8ZqtJx5avzag/Qrdw19ZDQ1RHZEuuyddbxoqhqy
         Z25ysyItBCCKtEE+KlNb3qwVpscA+9VUSQYI1xtmsGfH3qUv+y+lvnzGUyw4a6O0cc
         6kMmHONGf+s2CYIt78nZbc0A+U0JyN/WT9Qc7f01G/4+sahwkLuVlRxIUqhzzhkqzR
         /rJ0UbuYZ1EISXySNv6JJvbXe/3VJTpnq9KADty3JzvUyYFB40lyHRqA+OTVBOZBFk
         oqp0uN16zHdcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AF7B404A1; Mon, 22 Aug 2022 20:28:43 -0300 (-03)
Date:   Mon, 22 Aug 2022 20:28:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum entries)
Message-ID: <YwQRKkmWqsf/Du6A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
  
	The v1.24 release of pahole and its friends is out, with faster
BTF generation by parallelizing the encoding part in addition to the
previoulsy parallelized DWARF loading, support for 64-bit BTF enumeration
entries, signed BTF encoding of 'char', exclude/select DWARF loading
based on the language that generated the objects, etc.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

BTF encoder:

- Add support to BTF_KIND_ENUM64 to represent enumeration entries with
  more than 32 bits.

- Support multithreaded encoding, in addition to DWARF multithreaded
  loading, speeding up the process.

  Selected just like DWARF multithreaded loading, using the 'pahole -j'
  option.

- Encode 'char' type as signed.

BTF Loader:

- Add support to BTF_KIND_ENUM64.

pahole:

- Introduce --lang and --lang_exclude to specify the language the
  DWARF compile units were originated from to use or filter.

  Use case is to exclude Rust compile units while aspects of the
  DWARF generated for it get sorted out in a way that the kernel
  BPF verifier don't refuse loading the BTF generated from them.

- Introduce --compile to generate compilable code in a similar fashion to:

   bpftool btf dump file vmlinux format c > vmlinux.h

  As with 'bpftool', this will notice type shadowing, i.e. multiple types
  with the same name and will disambiguate by adding a suffix.

- Don't segfault when processing bogus files.
