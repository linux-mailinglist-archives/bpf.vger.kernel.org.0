Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9D304CC4
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbhAZWzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404681AbhAZTxN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 14:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611690704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ckZgHfZ9CAhIpGqWrvRjAhspOA6FtaecCy41F2UTQQ=;
        b=JS037huqNOEp4STDGPyz+h1TdGEvCEupc40jwTO0OzCyGPP+NsjlIuY6P7Fyny2P7eBr/O
        hAqJfOcoj6irygfSoO88UjJOnf4DUaHSJnte0SEMP2NXW0u3eny8QcmBmqYUS/qMQSZZoh
        ZyHkrqd9EQ/9TVGeCAviv7jLSeP+qVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-oyask2zxNzOZzwA4i98JLw-1; Tue, 26 Jan 2021 14:51:37 -0500
X-MC-Unique: oyask2zxNzOZzwA4i98JLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5BD4107ACE4;
        Tue, 26 Jan 2021 19:51:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.149])
        by smtp.corp.redhat.com (Postfix) with SMTP id 10C2319D61;
        Tue, 26 Jan 2021 19:51:33 +0000 (UTC)
Date:   Tue, 26 Jan 2021 20:51:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
Message-ID: <20210126195133.GA120879@krava>
References: <20210123004445.299149-1-kpsingh@kernel.org>
 <20210123004445.299149-2-kpsingh@kernel.org>
 <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 06:09:48PM -0800, Andrii Nakryiko wrote:

SNIP

> 
> 7. Is it just me, or when ./test_progs is run inside VM, it's output
> is somehow heavily buffered and delayed? I get no output for a while,
> and then a whole bunch of lines with already passed tests.  Curious if
> anyone else noticed that as well. When I run the same image locally
> and manually (not through your script), I don't have this issue.

I see the same thing, big delay on the test_prog start and then
chunk updates of its output

jirka

> 
> 8. I noticed that even if the command succeeds (e.g., ./test_progs in
> my case), the script exits with non-zero error code (32 in my case).
> That's suboptimal, because you can't use that script to detect test
> failures.
> 
> But again, it's the polish feedback, great work!
> 
> >  tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
> >  1 file changed, 353 insertions(+)
> >  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> >
> > diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> > new file mode 100755
> > index 000000000000..09bb9705acb3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> > @@ -0,0 +1,353 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -u
> > +set -e
> > +
> > +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
> > +X86_BZIMAGE="arch/x86/boot/bzImage"
> 
> Might be worth it to mention that this only works with x86_64 (due to
> image restrictions at least, right?).
> 
> > +DEFAULT_COMMAND="./test_progs"
> > +MOUNT_DIR="mnt"
> > +ROOTFS_IMAGE="root.img"
> > +OUTPUT_DIR="$HOME/.bpf_selftests"
> > +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config"
> > +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> > +NUM_COMPILE_JOBS="$(nproc)"
> > +
> > +usage()
> > +{
> > +       cat <<EOF
> > +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
> > +
> > +<command> is the command you would normally run when you are in
> > +tools/testing/selftests/bpf. e.g:
> > +
> > +       $0 -- ./test_progs -t test_lsm
> > +
> > +If no command is specified, "${DEFAULT_COMMAND}" will be run by
> > +default.
> > +
> > +If you build your kernel using KBUILD_OUTPUT= or O= options, these
> > +can be passed as environment variables to the script:
> > +
> > +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> 
> "relative_to_cwd" is a bit misleading, it could be an absolute path as
> well, I presume. So I'd just say "O=<kernel_build_path>" or something
> along those lines.
> 
> > +
> > +or
> > +
> > +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> > +
> 
> [...]
> 

