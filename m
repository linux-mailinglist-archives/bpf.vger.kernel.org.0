Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81734531D37
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiEWU7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEWU7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 16:59:49 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20B39156
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:59:47 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7C954240028
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653339585; bh=22WCBUKzmcYTiuZ9oU4SHwRhA1qlTuAdHc9ZWvnz3+0=;
        h=Date:From:To:Cc:Subject:From;
        b=AIX0ibMbjY2+0kpG+mwHlDRbuQ+guWkBIrEZNcyrEQTMQUasgJ4mczW7LKCQmSAIl
         dI8QSXZum5K/26d2Gzn9/GC02beqnT69ECKPHK3zCCAqB8vTHRoEFJKaDkrBmvErIG
         L534kkmhCY7IBB59A5w2KvC+Aac3QIe3ZBO9KoYFTUAmMAlimtxCl2QMkH7Atfc7+j
         WUx85KNAcq1AO79pMGshssN6iaR0HWyMkqWzwcViNdIPSxfYY4cLofwoAPF8aZAUbS
         Cblf8+VRQP7LdbAVNB3q6rgfcsjO23peCFBm65zVFhAsa9f1EryrKiAoexXDfcg1Sa
         U+4iOygPLPxsQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6V7y1Jdmz9rxG;
        Mon, 23 May 2022 22:59:41 +0200 (CEST)
Date:   Mon, 23 May 2022 20:59:38 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next v3 00/12] libbpf: Textual representation of enums
Message-ID: <20220523205938.cozu2v2h2uz6k2h6@muellerd-fedora-MJ0AC3F3>
References: <20220519213001.729261-1-deso@posteo.net>
 <CAEf4BzYZ+XY+uhSw1tOC=2KZe19hPsgAuq8o6CRsqCDfbqr59Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYZ+XY+uhSw1tOC=2KZe19hPsgAuq8o6CRsqCDfbqr59Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 04:45:42PM -0700, Andrii Nakryiko wrote:
> On Thu, May 19, 2022 at 2:30 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This patch set introduces the means for querying a textual representation of
> > the following BPF related enum types:
> > - enum bpf_map_type
> > - enum bpf_prog_type
> > - enum bpf_attach_type
> > - enum bpf_link_type
> >
> > To make that possible, we introduce a new public function for each of the types:
> > libbpf_bpf_<type>_type_str.
> >
> > Having a way to query a textual representation has been asked for in the past
> > (by systemd, among others). Such representations can generally be useful in
> > tracing and logging contexts, among others. At this point, at least one client,
> > bpftool, maintains such a mapping manually, which is prone to get out of date as
> > new enum variants are introduced. libbpf is arguably best situated to keep this
> > list complete and up-to-date. This patch series adds BTF based tests to ensure
> > that exhaustiveness is upheld moving forward.
> >
> > The libbpf provided textual representation can be inferred from the
> > corresponding enum variant name by removing the prefix and lowercasing the
> > remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
> > bpftool does not use such a programmatic approach for some of the
> > bpf_attach_type variants. We decided changing its behavior to work with libbpf
> > representations. However, for user inputs, specifically, we do keep support for
> > the traditionally used names around (please see patch "bpftool: Use
> > libbpf_bpf_attach_type_str").
> >
> > The patch series is structured as follows:
> > - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
> >   bpf_link_type}:
> >   - we first introduce the corresponding public libbpf API function
> >   - we then add BTF based self-tests
> >   - we lastly adjust bpftool to use the libbpf provided functionality
> >
> > Changelog:
> > v2 -> v3:
> > - use LIBBPF_1.0.0 section in libbpf.map for newly added exports
> >
> > v1 -> v2:
> > - adjusted bpftool to work with algorithmically determined attach types as
> >   libbpf now uses (just removed prefix from enum name and lowercased the rest)
> >   - adjusted tests, man page, and completion script to work with the new names
> >   - renamed bpf_attach_type_str -> bpf_attach_type_input_str
> >   - for input: added special cases that accept the traditionally used strings as
> >     well
> > - changed 'char const *' -> 'const char *'
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Cc: Quentin Monnet <quentin@isovalent.com>
> >
> 
> So this looks good to me for libbpf and selftests/bpf changes. I'll
> wait for Quentin to give his acks at least for bpftool changes.
> Quention, please take a look when you get a chance.
> 
> Few small nits, please accommodate them in next version, if you happen
> to send another one. If not, I'll try to remember to fix it up when
> applying.
> 
> 1. Received Acked-by/Reviewed-by tags should be added to each
> individual patch, not cover letter.

Thanks for pointing that out. Will fix that up.

> 2. You are using /** ... */ comments, which are considered to be kdoc
> comments and they have some additional formatting, which some of the
> tooling run on patches in Patchworks complains about [0]. Please use
> just /* ... */ style everywhere where it's not actual kdoc (or libbpf
> API documentation).

Force of habit. Fixed.

Thanks for taking a look!

Daniel

[...]
