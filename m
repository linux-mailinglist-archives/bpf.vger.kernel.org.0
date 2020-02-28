Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009EA1739B4
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1OW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 09:22:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54267 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgB1OW2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Feb 2020 09:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582899747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pokCd2WgI33NASBKEcAKs3sBBHBa2tJdpK/UFm3Icww=;
        b=CvT6GCe3f4eFYejjPWKE76Yk7/h3P5bTRBryPUiLVk8AKMbmuKCTulAa/cLMk+ExGivGtE
        KQDpzfX9TBaHzb/RlfOE6aCT9o1Pk6kjgncoft+YM8fh577ByQLoZ5R2QTZAwG+zdSz9k2
        HuRG7McOtAXbuBRBMY8VR/QSgJKnif4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-74AnBjgoNc-6fLTQVTRUlQ-1; Fri, 28 Feb 2020 09:22:24 -0500
X-MC-Unique: 74AnBjgoNc-6fLTQVTRUlQ-1
Received: by mail-lf1-f72.google.com with SMTP id j204so419740lfj.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2020 06:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=pokCd2WgI33NASBKEcAKs3sBBHBa2tJdpK/UFm3Icww=;
        b=SxvcCGcpAySCGGWn/wjYGq8/Fp5sUgzXJazZIpbiWKzJ7r+dItPPrNptlnEc6Z+Kvr
         KckdVyzqk+m3/p2iYJEqTpC/EiWHfW5d2xoGvIm13E1Dt/IgqdR9barLRDk3Vuba+bNf
         VDtYttVNa9VS3bGtE8N5PW4bEbiisbHKxQOKaniLjDWC2Vr3Xr8mIB+wY3k40yXZgWrY
         mVmdQ/ys0puV4s+r6tj8pig05IC5Ii8uXVxFvrbMIJ72UmkNVp3O6rtIPqdxdp5c8dGf
         zAzR7Ft83DYbrvQD+DzGXKGYN/LE43pSJUx10t6qHubB252hZkpe5PoPlD0w6BAeSL41
         ErKA==
X-Gm-Message-State: ANhLgQ1PxPZP4sTmbUyM1fYk3OXwSsaPyznTcKEiNoxNd+d7S5UCLv6W
        l1rnExIPo0QTuqhQvw94zOmFcF+lE3OVqg/RKCjq9i9Y681jHAGhOC7I5We9ZcIRtSVA/Lx3O7c
        LInUQ5YjM1Ukk
X-Received: by 2002:ac2:5df9:: with SMTP id z25mr2783381lfq.8.1582899742500;
        Fri, 28 Feb 2020 06:22:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtTYWGxcJ57E2xPAacR2BeALhkYGmGx13LyAWNPv3lsa9F39NXwBr+q8WJOLMYBCxxhk3sEmw==
X-Received: by 2002:ac2:5df9:: with SMTP id z25mr2783362lfq.8.1582899742128;
        Fri, 28 Feb 2020 06:22:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m16sm5100743lfb.59.2020.02.28.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:22:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0C2BE18036F; Fri, 28 Feb 2020 15:22:20 +0100 (CET)
Subject: [PATCH RFC] Userspace library for handling multiple XDP programs on
 an interface
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 28 Feb 2020 15:22:19 +0100
Message-ID: <158289973977.337029.3637846294079508848.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

As most of you are no doubt aware, we've had various discussions on how
to handle multiple XDP programs on a single interface. With the freplace
functionality, the kernel infrastructure is now there to handle this
(almost, see "missing pieces" below).

While the freplace mechanism offers userspace a lot of flexibility in
how to handle dispatching of multiple XDP programs, userspace also has
to do quite a bit of work to implement this (compared to just issuing
load+attach). The goal of this email is to get some feedback on a
library to implement this, in the hope that we can converge on something
that will be widely applicable, ensuring that both (a) everyone doesn't
have to reinvent the wheel, and (b) we don't end up with a proliferation
of subtly incompatible dispatcher models that makes it hard or
impossible to mix and match XDP programs from multiple sources.

My proposal for the beginnings of such a library is in the xdp-tools repository
on Github, in the 'xdp-multi-prog' branch.

To clone and compile simply do this:

$ git clone --recurse-submodules -b xdp-multi-prog https://github.com/xdp-project/xdp-tools
$ cd xdp-tools && ./configure && make

See lib/libxdp/libxdp.c for the library implementation, and xdp-loader/ for a
command-line loader that supports loading multiple programs in one go using the
dispatch (just supply it multiple filenames on the command line). There are
still some missing bits, marked with FIXME comments in the code, and discussed
below.

I'm also including libxdp as a patch in the next email, but only to facilitate
easy commenting on the code; use the version of Github if you actually want to
compile and play with it.

The overall goal of the library is to *make the simple case easy* but retain
enough flexibility for custom applications to specify their own load order etc
where needed. The "simple case" here being to just load one or more XDP programs
onto an interface while retaining any programs that may already be loaded there.

**** Program metadata

To do this, I propose two pieces of metadata that an XDP program can specify for
itself, which will serve as defaults to guide the loading:

- Its *run priority*: This is simply an integer priority number that will be
  used to sort programs when building the dispatcher. The inspiration is
  old-style rc init scripts, where daemons are started in numerical order on
  boot (e.g., /etc/rc.d/S50sshd). My hope here is that we can establish a
  convention around ranges of priorities that make sense for different types of
  programs; e.g., packet filters would use low priorities, and programs that
  want to monitor the traffic on the host will use high priorities, etc.

- Its *chain call actions*: These are the return codes for which the next
  program should be called. The idea here is that a program can indicate which
  actions it makes sense to continue operating on; the default is just XDP_PASS,
  and I expect this would be the most common case.

The metadata is specified using BTF, using a syntax similar to BTF-defined maps,
i.e.:

struct {
	__uint(priority, 10);
	__uint(XDP_PASS, 1); // chain call on XDP_PASS...
	__uint(XDP_ROP, 1);  // ...and on XDP_DROP
} XDP_RUN_CONFIG(FUNCNAME);

(where FUNCNAME is the function name of the XDP program this config refers to).

Using BTF for this ensures that the metadata stays with the program in the
object file. And because this becomes part of the object BTF, it will be loaded
into the kernel and is thus also retrievable for loaded programs.

The libxdp loaded will use the run priority to sort XDP programs before loading,
and it will use the chain call actions to configure the dispatcher program. Note
that the values defined metadata only serve as a default, though; the user
should be able to override the values on load to sort programs in an arbitrary
order.

**** The dispatcher program
The dispatcher program is a simple XDP program that is generated from a template
to just implement a series of dispatch statements like these:

        if (num_progs_enabled < 1)
                goto out;
        ret = prog0(ctx);
        if (!((1 << ret) & conf.chain_call_actions[0]))
                return ret;

        if (num_progs_enabled < 2)
                goto out;
        ret = prog1(ctx);
        if (!((1 << ret) & conf.chain_call_actions[1]))
                return ret;

        [...]

The num_progs_enabled and conf.chain_call_actions variables are static const
global variables, which means that the compiler will put them into the .rodata
section, allowing the kernel to perform dead code elimination if the
num_progs_enabled check fails. libxdp will set the values based on the program
metadata before loading the dispatcher, the use freplace to put the actual
component programs into the placeholders specified by prog0, prog1, etc.

The dispatcher program makes liberal use of variables marked as 'volatile' to
prevent the compiler from optimising out the checks and calls to the dummy
functions.

**** Missing pieces
While the libxdp code can assemble a basic dispatcher and load it into the
kernel, there are a couple of missing pieces on the kernel side; I will propose
patches to fix these, but figured there was no reason to hold back posting of
the library for comments because of this. These missing pieces are:

- There is currently no way to persist the freplace after the program exits; the
  file descriptor returned by bpf_raw_tracepoint_open() will release the program
  when it is closed, and it cannot be pinned.

- There is no way to re-attach an already loaded program to another function;
  this is needed for updating the call sequence: When a new program is loaded,
  libxdp should get the existing list of component programs on the interface and
  insert the new one into the chain in the appropriate place. To do this it
  needs to build a new dispatcher and reattach all the old programs to it.
  Ideally, this should be doable without detaching them from the old dispatcher;
  that way, we can build the new dispatcher completely, and atomically replace
  it on the interface by the usual XDP attach mechanism.

---

Toke Høiland-Jørgensen (1):
      libxdp: Add libxdp (FOR COMMENT ONLY)


 tools/lib/xdp/libxdp.c          |  856 +++++++++++++++++++++++++++++++++++++++
 tools/lib/xdp/libxdp.h          |   38 ++
 tools/lib/xdp/prog_dispatcher.h |   17 +
 tools/lib/xdp/xdp-dispatcher.c  |  178 ++++++++
 tools/lib/xdp/xdp_helpers.h     |   12 +
 5 files changed, 1101 insertions(+)
 create mode 100644 tools/lib/xdp/libxdp.c
 create mode 100644 tools/lib/xdp/libxdp.h
 create mode 100644 tools/lib/xdp/prog_dispatcher.h
 create mode 100644 tools/lib/xdp/xdp-dispatcher.c
 create mode 100644 tools/lib/xdp/xdp_helpers.h

