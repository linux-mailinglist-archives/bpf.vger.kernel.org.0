Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA46DBC7A
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDHSzq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 14:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHSzp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 14:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD0D93C1;
        Sat,  8 Apr 2023 11:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537F060C3A;
        Sat,  8 Apr 2023 18:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9EEC4339B;
        Sat,  8 Apr 2023 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980142;
        bh=lh3grPdy6EB2X5Jq3Oc6U3TqpizfIftGvgsJOhiCeA0=;
        h=Date:From:To:Cc:Subject:From;
        b=bnwPo/ofXmZzW79/jKVNSnd2DQYNay9ibBKql+JdmJkaghCHIqOkzlYvoh2K1i5It
         hItcj4ySVpDCyT9Q4vghUOetqdX9qVDdnTzuqDo9WFs4Zobv20NSavS1tnvEn8S2+o
         v68adhcKKGkLymgMffEEK3/SzONPemNrzWxCLjCdHs9Il8/xyRtx2ucE1GK2AEEVvH
         /CpchsKqYC/7ofFfjBUkoP39H1aAj6Auw+FSJMPEx5j79NeyecHqHdwpQOj4wL/3Ql
         NVDpc0dtexm6xYteVbRBOwMbciwh4XBpkj2q56zBBFzy80ur5SzcWwrVZzNcI3hCF7
         wdDEEaHd9o0Sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7591403EB; Sat,  8 Apr 2023 15:55:39 -0300 (-03)
Date:   Sat, 8 Apr 2023 15:55:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        David Lamparter <equinox@diac24.net>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Domenico Andreoli <cavok@debian.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: ANNOUNCE: pahole v1.25 (Unspecified type, Atomic types, BTF for
 optimized functions)
Message-ID: <ZDG4qxirpIfmbiip@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
  
	The v1.25 release of pahole and its friends is out, fixing the
handling of DW_TAG_unspecified type in assembly functions that came with
binutils 2.40, allowing the BTF encoding of optimized functions (ending in
.constprop, .isra), excluding from BTF optimized functions not following
the calling convention, support for DW_TAG_atomic_type, support the
DW_TAG_LLVM_annotation BTF equivalent (BTF_KIND_TYPE_TAG) on the BTF
loader and for now suppressing it when pretty printing, etc.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.25.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.25.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.25.tar.sign

	For 1.26 the immediate plan is to fixup the merge conflicts with
the branch that adds support for dwz compressed DWARF files that is
available at:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=alt_dwarf

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

- Arnaldo

DWARF loader:

- Support for DW_TAG_unspecified_type more generally, that in binutils 2.40 is used
  for assembly functions, resulting in BTF encoding problems when building the Linux
  kernel.

- Make sure struct member offsets are in ascending order. This is part of the set of
  changes to support encoding BTF for Rust for use with the Linux kernel, where the
  BTF verifier considers invalid offset unordered struct members.

- Support C atomic types (DW_TAG_atomic_type), that are not used in the Linux kernel but
  is present in user space components such as Open VSwitch.

BTF loader:

- Initial support for DW_TAG_LLVM_annotation, used for BTF type tags, to encode things
  like __rcu, __user annotations in the Linux kernel. This is still in flux with changes
  in how these are encoded that resulted from the discussion to support this in gcc in
  addition to in clang, where it was first designed.

BTF encoder:

- Exclude functions with the same name (static functions in different CUs),
  inconsistent prototypes or not following calling convention.

- Allow generation of BTF for optimized functions, those that end with a .isra*
  suffix (inter procedural scalar replacement of aggregates) or .constprop*
  (constant propagation).

Pretty printer:

- For now the DW_TAG_LLVM_annotation tags are being suppressed, so the output from
  BTF and DWARF matches, further work is planned to support it so that the output
  matches the original source code and can be recompilable, resulting in the same
  DWARF info.

- Support C atomic types, allowing the generation of source code that can be
  compiled with resulting DWARF info matching the original source code.

pahole:

- Support --lang=/--lang_exclude=asm, the DW_LANG_ define for assembly is out
  of order, special case it to support asking for CUs written in assembly to be
  selected or excluded.

- Support suppressing the atomic type modifiers/attributes.

- Allow filtering out functions optimized by the compiler, where the calling convention isn't
  the one expected by BPF or arguments are optimized out.

- Support --compile from DWARF in addition to from BTF, this allows user space components
  such as Open VSwitch to use pahole to generate compilable code for its data structures.

btfdiff:

- Exclude RUST CUs, as those are not yet being BTF encoded.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
