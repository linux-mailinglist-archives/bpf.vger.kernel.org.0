Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74F196903
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgC1T4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 15:56:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgC1T4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 15:56:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id z18so15304726wmk.2
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RaAner1AOy6mqRxgg2s6OrVjNWEeXrUvVQ99ZwBacLY=;
        b=j83qG6wi8FIVqxHB6qtn71NfG8/D64pOANqSOp43lzviKNip7DW6ja7q0RUBFEWDt9
         2qRLkPeJzAuE70oECTtOchfpQpUZVJuRpiXtDT5LxoUxTZQv0ZlkwNgp0Nzk4wbDrMI6
         1A0Mfd0tSNraiuW9a9o7EI1TosBTOTlHz5Nc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RaAner1AOy6mqRxgg2s6OrVjNWEeXrUvVQ99ZwBacLY=;
        b=aXojLldwFvt0O6x50tapsWDUSaF3BMHBzUH1+j9nnMpvCY23ErJjfhGzsr3tfQbOqV
         XZX7B9srKSW8K9790wnSqHs6hI1lWcGW7MzcBUqe3+siUVbpSrLyh7e9aPK/v6b4Nf/F
         jsH33MCdbzrouu7JSaN5JWsizLhz0JJgwa0SIphMUlqlHZMPaadgWBveS8gNDjDBGo+w
         o/vDVXfAAPRUpaIJZ0t63Y3e7BuDTr/idPtiIC3HTVUBwmjVkAvW5VaO61MErnTbveOC
         8iIRsdrX2I7u6gkFc6xqedyrbgeVVLcToy/8L4ex4ANA/jyqtGIhNRBjS34V04TWGx7y
         5ydQ==
X-Gm-Message-State: ANhLgQ2/PxxOo+htijKUfRfOEOJwcBvSah0zdB0KHX6WmOCBJeIKIHF+
        g3vUz8fWBR/Xr/XY0YhXYjdXjA==
X-Google-Smtp-Source: ADFU+vvaYd97z0o5WsUXqObkXdOSUk66yt71KeGEJtWcfmHE/YKKvWPVUVfd0xksvz+KE13VM1E8og==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr5091509wma.82.1585425398431;
        Sat, 28 Mar 2020 12:56:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id s11sm14547650wrw.58.2020.03.28.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 12:56:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 28 Mar 2020 20:56:36 +0100
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200328195636.GA95544@google.com>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28-Mar 18:18, Daniel Borkmann wrote:
> Hey KP,
> 
> On 3/27/20 8:28 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > # v7 -> v8
> > 
> >    https://lore.kernel.org/bpf/20200326142823.26277-1-kpsingh@chromium.org/
> > 
> > * Removed CAP_MAC_ADMIN check from bpf_lsm_verify_prog. LSMs can add it
> >    in their own bpf_prog hook. This can be revisited as a separate patch.
> > * Added Andrii and James' Ack/Review tags.
> > * Fixed an indentation issue and missing newlines in selftest error
> >    a cases.
> > * Updated a comment as suggested by Alexei.
> > * Updated the documentation to use the newer libbpf API and some other
> >    fixes.
> > * Rebase
> > 
> > # v6 -> v7
> > 
> >    https://lore.kernel.org/bpf/20200325152629.6904-1-kpsingh@chromium.org/
> > 
> [...]
> > KP Singh (8):
> >    bpf: Introduce BPF_PROG_TYPE_LSM
> >    security: Refactor declaration of LSM hooks
> >    bpf: lsm: provide attachment points for BPF LSM programs
> >    bpf: lsm: Implement attach, detach and execution
> >    bpf: lsm: Initialize the BPF LSM hooks
> >    tools/libbpf: Add support for BPF_PROG_TYPE_LSM
> >    bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
> >    bpf: lsm: Add Documentation
> 
> I was about to apply, but then I'm getting the following selftest issue on
> the added LSM one, ptal:
> 
> # ./test_progs
> [...]
> #65/1 test_global_func1.o:OK
> #65/2 test_global_func2.o:OK
> #65/3 test_global_func3.o:OK
> #65/4 test_global_func4.o:OK
> #65/5 test_global_func5.o:OK
> #65/6 test_global_func6.o:OK
> #65/7 test_global_func7.o:OK
> #65 test_global_funcs:OK
> test_test_lsm:PASS:skel_load 0 nsec
> test_test_lsm:PASS:attach 0 nsec
> test_test_lsm:PASS:exec_cmd 0 nsec
> test_test_lsm:FAIL:bprm_count bprm_count = 0
> test_test_lsm:FAIL:heap_mprotect want errno=EPERM, got 22

The test seems to pass for me [classic, "works on my machine" ;)]

  ./test_progs -t test_lsm
  #66 test_lsm:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

and also in the complete run of test_progs.

Since the attachment succeeds and the hook does not get called, it
seems like "bpf" LSM is not being initialized and the hook, although
present, does not get called.

This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
there by default as we added it to default value of CONFIG_LSM and
also for other DEFAULT_SECURITY_* options.

Let me know if that's the case and it fixes it.

- KP

> #66 test_lsm:FAIL
> test_test_overhead:PASS:obj_open_file 0 nsec
> test_test_overhead:PASS:find_probe 0 nsec
> test_test_overhead:PASS:find_probe 0 nsec
> test_test_overhead:PASS:find_probe 0 nsec
> test_test_overhead:PASS:find_probe 0 nsec
> test_test_overhead:PASS:find_probe 0 nsec
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x31)[0x56100f25eb51]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f9d8d225890]
> /lib/x86_64-linux-gnu/libc.so.6(+0x18ef2d)[0x7f9d8cfb0f2d]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_calloc+0x372)[0x7f9d8cebc3a2]
> /usr/local/lib/libelf.so.1(+0x33ce)[0x7f9d8d85a3ce]
> /usr/local/lib/libelf.so.1(+0x3fb2)[0x7f9d8d85afb2]
> ./test_progs(btf__parse_elf+0x15d)[0x56100f27a141]
> ./test_progs(libbpf_find_kernel_btf+0x169)[0x56100f27ee83]
> ./test_progs(+0x43906)[0x56100f266906]
> ./test_progs(bpf_object__load_xattr+0xe5)[0x56100f26e93c]
> ./test_progs(bpf_object__load+0x47)[0x56100f26eafd]
> ./test_progs(test_test_overhead+0x252)[0x56100f24a922]
> ./test_progs(main+0x212)[0x56100f22f772]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f9d8ce43b97]
> ./test_progs(_start+0x2a)[0x56100f22f8fa]
> Segmentation fault (core dumped)
> #
> 
> (Before the series, it runs through fine on my side.)
> 
> Thanks,
> Daniel
