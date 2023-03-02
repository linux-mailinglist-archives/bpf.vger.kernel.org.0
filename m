Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9A6A8A37
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCBU1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCBU1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:27:42 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B92F7B5;
        Thu,  2 Mar 2023 12:27:40 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d7so593380qtr.12;
        Thu, 02 Mar 2023 12:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677788859;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfp5lL1fP4eJjaLwSUHLj5KVea8nKrGdnw1nIo7cwGU=;
        b=y3W0oaNyZymYCz4GJf15X/qx9uR0V/PLdb21FrIVIZ1Ra/wmhwB3z1Eul9XqhdTmIC
         f1gfoRURdCZxboRejjjeSToS+dAiRoAnyiHKiEcFlC1yGO1HjGXr9IzpvFpCAzAsqKMZ
         6w3+8uDR2Op9mpz6+CsEgna9BDPjt3vN95KXbemUhK+Bz6XPpd5nv0yi16o/5K8EWnTU
         I3aI6G4yK+BE+1aE0AKMg7x9xN2TpSFra4s7cW+ODR610AHQYLHLI9MpgHEwmqOY8hZS
         Ea0Jjv5QXAV0epmtTMNRoM1BPSSL4GDVzfF5QBuDO+wdevnLSm88HKpHBRWhKp044wKv
         fzLA==
X-Gm-Message-State: AO0yUKW1hn6HtZumbsD6zoCk/Gwld0ZnT6IV72n/Z12F99uAAZFPZ4hm
        ibM9E3ok0cdtyGw+ib3fAZLU5UVUEB0BpGvw
X-Google-Smtp-Source: AK7set+Jcry/2yhKcFKUIWSgwn3bAeVo7lvLRVCku5dxx3OpiRouPyrjvkkcud+6kqsNfpSVOHtVTw==
X-Received: by 2002:a05:622a:1baa:b0:3a8:e9e:e194 with SMTP id bp42-20020a05622a1baa00b003a80e9ee194mr20327952qtb.40.1677788859096;
        Thu, 02 Mar 2023 12:27:39 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f18-20020ac80152000000b003bd21323c80sm381358qtg.11.2023.03.02.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:27:38 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:27:36 -0600
From:   David Vernet <void@manifault.com>
To:     Sreevani Sreejith <ssreevani@meta.com>
Cc:     bpf@vger.kernel.org, Linux-kernel@vger.kernel.org,
        andrii@kernel.org, mykolal@meta.com, psreep@gmail.com
Subject: Re: [PATCH bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <ZAEGuLO/j9HEUsS0@maniforge>
References: <20230301190702.3222292-1-ssreevani@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301190702.3222292-1-ssreevani@meta.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 01, 2023 at 11:07:02AM -0800, Sreevani Sreejith wrote:
> From: Sreevani <ssreevani@meta.com>

Hi Sreevani,

This is looking great, and is a very good start. Left some comments
below.

> 
> Summary: Document that provides an overview of libbpf features for BPF
> application development.
> 
> Reviewers:
> 
> Subscribers:
> 
> Tags: BPF, libbpf

Please do not include such extraneous tags in your patches.

> Signed-off-by: Sreevani <ssreevani@meta.com>
> ---
>  Documentation/bpf/libbpf/index.rst           |  24 ++-
>  Documentation/bpf/libbpf/libbpf_overview.rst | 212 +++++++++++++++++++
>  2 files changed, 228 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/bpf/libbpf/libbpf_overview.rst
> 
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
> index f9b3b252e28f..f5da02972686 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -2,23 +2,31 @@
> 
>  .. _libbpf:
> 
> +======
>  libbpf
>  ======
> 
> +If you are looking to develop BPF applications using the libbpf library, this
> +directory contains important documentation that you should read.
> +
> +To get started, it is recommended to begin with the "libbpf Overview" document,

Can we link directly to the libbpf overview page, rather than just
quoting it? To do that, you can create a label at the top of
libbpf_overview.rst with

.. _libbpf-overview-label:

and then link it from here with :ref`libbpf-overview-label`.

> +which provides a high-level understanding of the libbpf APIs and their usage.
> +This will give you a solid foundation to start exploring and utilizing the
> +various features of libbpf to develop your BPF applications.
> +
>  .. toctree::
>     :maxdepth: 1
> 
> +   libbpf_overview
>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
>     program_types
>     libbpf_naming_convention
>     libbpf_build
> 
> -This is documentation for libbpf, a userspace library for loading and
> -interacting with bpf programs.
> 
> -All general BPF questions, including kernel functionality, libbpf APIs and
> -their application, should be sent to bpf@vger.kernel.org mailing list.
> -You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
> -mailing list search its `archive <https://lore.kernel.org/bpf/>`_.
> -Please search the archive before asking new questions. It very well might
> -be that this was already addressed or answered before.
> +All general BPF questions, including kernel functionality, libbpf APIs and their
> +application, should be sent to bpf@vger.kernel.org mailing list.  You can
> +`subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the mailing list
> +search its `archive <https://lore.kernel.org/bpf/>`_.  Please search the archive
> +before asking new questions. It may be that this was already addressed or
> +answered before.
> diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/bpf/libbpf/libbpf_overview.rst
> new file mode 100644
> index 000000000000..15b4f1e28f48
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/libbpf_overview.rst
> @@ -0,0 +1,212 @@

The top of this file needs an SPDX license identifier:

.. SPDX-License-Identifier: GPL-2.0

FYI for future reference, checkpatch.pl would have caught that for you:

[void@maniforge bpf-next]$ ./scripts/checkpatch.pl
~/patches/0001-BPF-docs-libbpf-Overview-Document.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need
updating?
#66:
new file mode 100644

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#71: FILE: Documentation/bpf/libbpf/libbpf_overview.rst:1:
+================

> +================
> + libbpf Overview

Extra empty space at beginning of line

> +================
> +
> +libbpf is a C-based library containing a BPF loader that takes compiled BPF
> +object files and prepares and loads them into the Linux kernel. libbpf takes the
> +heavy lifting of loading, verifying, and attaching BPF programs to various
> +kernel hooks, allowing BPF application developers to focus only on BPF program
> +correctness and performance.
> +
> +The following are the high-level features supported by libbpf:
> +
> +* Provides high-level and low-level APIs for user space programs to interact
> +  with BPF programs. The low-level APIs wrap all the bpf system call
> +  functionality, which is useful when users need more fine-grained control
> +  over the interactions between user space and BPF programs.
> +* Provides overall support for the BPF object skeleton generated by the bpftool.

s/the bpftool/bpftool

> +  The skeleton file simplifies the process for the user space programs to access
> +  global variables and work with BPF programs.
> +* Provides BPF-side APIS, including BPF helper definitions, BPF maps support
> +  and, tracing helpers, allowing developers to simplify BPF code writing.

s/support and,/support, and (move comma to previous word)

> +* Supports BPF CO-RE mechanism, enabling BPF developers to write portable
> +  BPF programs that can be compiled once and run across different kernel
> +  versions.
> +
> +This document will delve into the above concepts in detail, providing a deeper
> +understanding of the capabilities and advantages of libbpf and how it can help
> +you develop BPF applications efficiently.
> +
> +#################################
> +BPF App Lifecycle and libbpf APIs
> +#################################
> +
> +BPF application consists of a set of BPF programs, either cooperating or
> +completely independent, and BPF maps and global variables, shared between all

IMO this sentence reads kind of awkwardly because of the grammar and
punctuation. Wdyt about this:

A BPF application consists of one or more BPF programs (either
cooperating or completely independent), BPF maps, and global variables.
The global variables are shared between all BPF programs, which allows
them to cooperate on a common set of data.

> +BPF programs (allowing them to cooperate on a common set of data). llibbpf

s/llibbpf/libbpf

> +provides APIs that user space programs can use to manipulate the BPF programs by
> +triggering different phases of a BPF application lifecycle. The APIs abstract
> +away the complexity of BPF programs and provide a more intuitive way to manage
> +the lifecycle of BPF applications. The differents phases and corresponding

There are quite a few sentences throughout that sound a bit like libbpf
marketing. IMO they just add noise to what's trying to be conveyed. I
think you can remove the whole "The APIs abstract away..." sentence. If
we want to go into details about what specific complexities are being
abstracted in a phase, we can do that when we explain the phase below.

> +libbpf APIs to trigger are listed below:

I don't think the libbpf APIs (e.g. bpf_object__ope()) really belong
here. This section (which is super useful) is describing the lifecycle
of a BPF program. This lifecycle applies regardless of whether you're
using bpf_object__open() or some other skeleton APIs.

Most users will also probably never use "core" APIs like
bpf_object__open() directly, so IMO if we're going to go over them, we
should just mention them briefly when we talk about skeletons to give a
bit more background on how things are implemented at a lower level.

> +
> +* **Open phase** (``bpf_object__open()``). In this phase, libbpf parses the BPF
> +  object file and discovers BPF maps, BPF programs, and global variables. After
> +  a BPF app is opened, user space apps can make additional adjustments
> +  (setting BPF program types, if necessary; pre-setting initial values for
> +  global variables, etc.) before all the entities are created and loaded.
> +
> +* **Load phase** (``bpf_object__load()``). In the load phase, libbpf creates BPF
> +  maps, resolves various relocations, and verifies and loads BPF programs into
> +  the kernel. At this point, libbpf validates all the parts of a BPF application
> +  and loads the BPF program into the kernel, but no BPF program has yet been
> +  executed. After the load phase, it’s possible to set up the initial BPF map
> +  state without racing with the BPF program code execution.
> +
> +* **Attachment phase** (``bpf_program__attach()``). In this phase, libbpf
> +  attaches BPF programs to various BPF hook points (e.g., tracepoints, kprobes,
> +  cgroup hooks, network packet processing pipeline, etc.). This is also the
> +  phase at which BPF starts performing useful work and read/update BPF maps and
> +  global variables.

Wdyt about rephrasing this last sentence as:

This is the phase during which BPF programs are performing useful work,
such as processing packets, or updating BPF maps and global variables
which can be read from user space.

> +
> +* **Tear down phase** (``bpf_program__destroy()``). In the tear down phase,
> +  libbpf detaches BPF programs and unloads from the kernel. BPF maps are

s/and unloads from/and unloads them from

> +  destroyed, and all the resources used by the BPF app are freed.
> +
> +By leveraging the libbpf APIs, developers write code that can easily interact
> +with BPF programs and ensure that they are working effectively and efficiently.

I would suggest removing this sentence as well. It doesn't provide any
new information.

> +
> +########################
> +BPF Object Skeleton File
> +########################
> +
> +BPF skeleton is an alternative and complementary interface to libbpf APIs for
> +working with BPF objects. You can generate the skeleton header file
> +``(.skel.h)`` for a specific object file by passing the BPF object to the
> +bpftool. The generated ``.skel.h`` file simplifies the code to load and work
> +with the BPF objects, maps, programs, and global data from the user space. For
> +example, the generated BPF skeleton has corresponding functions to trigger each
> +phase in the BPF life cycle:

I think this paragraph can be improved. Describing how skeletons are
generated here is a bit premature. I think we need to first describe
what they are and why they're useful. I'd also argue that it's fair to
say that skeleton are the common / recommended APIs for manipulating BPF
applications from user space. If you agree that's the case, I'd suggest
mentioning that here as well, as the way it's worded now seems to imply
that bpf_object__open() and friends are the default / commonly used
APIs.

> +
> +* ``<name>__open()`` – creates and opens BPF application (``<name>`` stands for
> +  the corresponding bpf object name)
> +* ``<name>__load()`` – instantiates, loads,and verifies BPF application parts
> +* ``<name>__attach()`` – attaches all auto-attachable BPF programs (it’s
> +  optional, you can have more control by using libbpf APIs directly)
> +* ``<name>__destroy()`` – detaches all BPF programs and
> +  frees up all used resources
> +
> +Keep in mind, BPF skeleton provides access to the underlying BPF object, so
> +whatever was possible to do with generic libbpf APIs is still possible even when
> +the BPF skeleton is used. It's an additive convenience feature, no syscalls, and
> +no cumbersome code.
> +
> +
> +Other Advantages of Using SkeletonFile:
> +########################################

Misaligned title underscore (extra =). Also, can you add a #### above
the title as well to keep things consistent with the rest of the doc.
Lastly, there's a space missing between Skeleton and File.

> +
> +* BPF skeleton provides a convenient interface to work with BPF global
> +  variables from the user space by memory mapping BPF global variables into the

s/the user space/user space

> +  user space as a struct. The struct interface allows user space programs to
> +  easily set up initial values of variables before the BPF load phase and fetch

"easily set up initial values of variables" is IMO kind of odd wording,
and is arguably a bit incomplete in terms of the scope it implies. What
about just "initialize BPF programs" (also removing the word 'easily').

> +  and update data from user space afterward.
> +
> +* The ``skel.h`` file reflects the object file structure by listing out the
> +  available maps, programs, etc. BPF skeleton provides direct access to all the
> +  BPF maps and BPF programs as struct fields. This eliminates the need for
> +  string-based lookups with ``bpf_object_find_map_by_name()`` and
> +  ``bpf_object_find_program_by_name()`` APIs, reducing errors due to BPF source
> +  code and user-space code getting out of sync.
> +
> +* The generated skeleton file is embedded with a bytecode representation of the
> +  object file, ensuring that the skeleton and the BPF object file are always in
> +  sync.
> +
> +###########
> +BPF Helpers
> +###########
> +
> +libbpf provides BPF-side APIs that BPF programs can use to interact with the
> +system. libbpf conveniently provides definitions of BPF helpers, allowing you to
> +use them in BPF code as any other plain C function. For example, there are

"conveniently provides" -- Similar to my suggestions above, I recommend
removing such qualifiers. I'd remove this whole sentence, as I think
"BPF-side APIs that BPF programs can use" implies that there are
functions they can call.

> +helper functions to print debugging messages, get the time since the system was
> +booted, interact with BPF maps, manipulate network packets, etc.
> +
> +For a complete description of what the helpers do, the arguments they take, and
> +the return value, see the `bpf-helpers
> +<https://man7.org/linux/man-pages/man7/bpf-helpers.7.html>`_ man page.
> +
> +#########################################
> +BPF CO-RE (Compile Once – Run Everywhere)
> +#########################################
> +
> +libbpf works with the compiler to support BPF CO-RE mechanism to produce a
> +single executable binary that you can run on multiple kernel versions and
> +configurations. This approach allows developers to write portable BPF
> +applications and run them in any Linux system without modifications and runtime
> +source code compilation on the target machine.
> +
> +To support CO-RE programs, libbpf relies on the header file, ``vmlinux.h``, to
> +tailor the BPF program code to a particular running kernel on the host.
> +``vmlinux.h`` file includes all kernel types (BTF type) that the running kernel

s/BTF type/BTF types

I'd also recommend linking to the BTF docs page here
(Documentation/bpf/btf.rst).

> +uses. Including this header file in your BPF program can eliminate dependency on
> +system-wide kernel headers. You can generate ``vmlinux.h`` using the following
> +bpftool command:
> +
> +::
> +
> +$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> +
> +
> +libbpf looks at the BPF program’s recorded BTF type and relocation information
> +and matches them to BTF information provided by the running kernel. libbpf
> +resolves and matches all the types and fields, and updates necessary offsets and
> +other relocatable data to ensure that BPF program’s logic is correctly
> +functioning for a specific kernel on the host.

Can we add an example of CO-RE in action here? I think showing a small
BPF program that accesses a kernel struct field which changes between
kernel versions would really drive the point home.

> +
> +##############
> +libbpf Vs. BCC
> +##############
> +
> +Historically, `BCC <https://github.com/iovisor/bcc/>`_ was a framework of choice
> +for developing BPF applications that required efficient kernel tracing for
> +analyzing kernel components. BCC compiles BPF programs on the host machine,
> +ensuring that the memory layout your BPF program expects is precisely the same
> +as that of the target host. However, BCC relies on runtime compilation and
> +brings the entire huge LLVM/Clang library in and embeds it inside itself. This
> +results in many consequences, such as heavy resource utilization, kernel headers
> +dependency, and detecting even trivial compilation errors only during run time,
> +all of which are less than ideal.
> +
> +libbpf aims at eliminating overheads associated with BPF app development by
> +reducing heavy dependency on system-wide headers. libbpf enables you to generate
> +small binaries that can be compiled once and run anywhere, which is better at
> +resource usage and keeps runtime overhead to a minimum. libbpf offers several
> +benefits by playing the role of a BPF program loader, performing mundane setup
> +work (relocations, loading and verifying BPF programs, creating BPF maps,
> +attaching to BPF hooks, etc.), and letting developers worry only about BPF
> +program correctness and performance. With these features, libbpf makes the
> +overall developer experience much more pleasant.

This reads like more marketing to me. I think most, if not all, of this
entire paragraph can arguably be removed.

> +
> +###########################
> +Getting Started with libbpf
> +###########################
> +
> +Check out the `libbpf-bootstrap <https://github.com/libbpf/libbpf-bootstrap>`_
> +repository with simple examples of using libbpf to build various BPF
> +applications.
> +
> +Also, find the libbpf API documentation `here
> +<https://libbpf.readthedocs.io/en/latest/api.html>`_
> +
> +###############
> +libbpf and Rust
> +###############
> +
> +If you are building BPF applications in Rust, it is recommended to use
> +`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_  ibrary instead of bindgen

Can you add a "the" after "recommended to use"?

s/ibrary/library


> +bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
> +Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF code
> +compilation and skeleton generation. Using Libbpf-rs will make building user
> +space part of the BPF application easier. However, you are still expected to

I would rephrase "you are still expected to". Saying that users are
"expected to" do something a certain way implies that there are other
ways they _could_ do it, which is not the case. Perhaps something like
this is clearer: "Note, however, that the BPF the program themselves
must still be written in C."

> +write BPF program code in plain C, utilizing all the BPF-side APIs of libbpf
> +directly.

I think the part about "utilizing all the BPF-side APIs" can be removed.
It's implied that the developer will have to use those C APIs if they're
writing their BPF programs in C.

> +
> +########################
> +Additional Documentation
> +########################
> +
> +* `Program types and ELF Sections <https://libbpf.readthedocs.io/en/latest/program_types.html>`_
> +* `API naming convention <https://libbpf.readthedocs.io/en/latest/libbpf_naming_convention.html>`_
> +* `Building libbpf <https://libbpf.readthedocs.io/en/latest/libbpf_build.html>`_
> +* `API documentation Convention <https://libbpf.readthedocs.io/en/latest/libbpf_naming_convention.html#api-documentation-convention>`_
> --
> 2.30.2
> 
