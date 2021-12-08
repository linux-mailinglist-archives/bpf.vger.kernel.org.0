Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF546D4DF
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhLHN6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 08:58:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44482 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLHN6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 08:58:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A8D2CE218E;
        Wed,  8 Dec 2021 13:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D69C00446;
        Wed,  8 Dec 2021 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638971698;
        bh=cEDXQeIeYpoFUpOU3IKFkwMae+ywV8Wwm9nSxohi4e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPxTF68+tOufg86FtiXdDh2k7dM6fG7kz0Qr1ovf6kNnW40gP4C9FDhcXbDBS42rZ
         KxE1IIakvaH5rXiRomelB3WV7wfqa8ZBVoszH5d6iFxf/5RnZjTkNgX2Ig6uDX7uUK
         MvNUG1uS0dBMnVN238iAyUKureBuNSX4UhX3Yrnn5zK/yCBJvR29pWlE3ZXdswTvYY
         QxUhV7V2+Qv6RveyOMzZTtiupO9/HtHf5TOpacPyc2V69Yvk7eCoxK0z6vc2ufuj1F
         GL5rCNafkkdJ5tiAh1p/ERr4BcWbS0LfmyOcQ9qylXhkf1DU7MwtxVhSt/bQxaYhrn
         wrN7XCzwjrZuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34465406C1; Wed,  8 Dec 2021 10:54:56 -0300 (-03)
Date:   Wed, 8 Dec 2021 10:54:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Message-ID: <YbC5MC+h+PkDZten@kernel.org>
References: <YSQSZQnnlIWAQ06v@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSQSZQnnlIWAQ06v@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.23 release of pahole and its friends is out, this time
the main new features are the ability to encode BTF tags, to carry
attributes to the kernel BPF verifier for further checks and the
inference of struct member unnatural alignment (__attribute__(__aligned__(N)))
to help in generating compileable headers matching the original type
layout from BTF data.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.23.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.23.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.23.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

- Arnaldo

DWARF loader:

- Read DW_TAG_LLVM_annotation tags, associating it with variables, functions,
  types. So far this is only being used by the BTF encoder, but the pretty
  printer should use this as well in a future release, printing these
  attributes when available.

- Initial support for DW_TAG_skeleton_unit, so far just suggest looking up a
  matching .dwo file to be used instead. Automagically doing this is in the
  plans for a future release.

- Fix heap overflow when accessing variable specification.

BTF encoder:

- Support the new BTF type tag attribute, encoding DW_TAG_LLVM_annotation DWARF
  tags as BTF_KIND_TYPE_TAG and BTF_KIND_DECL_TAG.

  This allows __attribute__((btf_type_tag("tag1"))) to be used for variables,
  functions, typedefs, so that contextual information can be stored in BTF and
  used by the kernel BPF verifier for more checks.

  The --skip_encoding_btf_type_tag option can be used to suppress this.

- Fix handling of percpu symbols on s390.

BTF loader:

- Use cacheline size to infer alignment.

btfdiff:

- Now that the BTF loader infers struct member alingment, and as that is just
  an heuristic, suppress printing the alignment when pretty printing from BTF
  info like is done when printing from DWARF.

pahole:

- Add --skip_missing so that we don't stop when not finding one of the types passed
  to -C.

Pretty printer:

- Fix __attribute__((__aligned__(N)) printing alignment for struct members.

- Fix nested __attribute__(__aligned__(N)) struct printing order, so that
  rebuilding from the printed source circles back to the original source code
  alignment semantics.

Build:

- No need to download libbpf source when using the system library (libbpf-devel).

- Make python optional
