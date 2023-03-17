Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8E6BF55B
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCQWxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQWxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:53:05 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F943930;
        Fri, 17 Mar 2023 15:53:02 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d7so7302899qtr.12;
        Fri, 17 Mar 2023 15:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093582;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0GN70ryjtj4hxYbq9Bv/UdzPUMZMwajiakgC+VzRns=;
        b=VRFd4wOAe/gd3DJiarwrbki+R3A4T0m+mkIhkCAL9gWaFBarvAyEhFqvP2MAss9fSS
         l/kPXz9O8T52bjTncVvZ8BZNJhkPDGvuB/frEDZG1aeTVTo5oUSjtYakpMYX+NcFQtmH
         nIFvV2xqYJYRKm/nJnG3PAN6wfzNr9fZIq9nYDibISo34085BhvB8NhawBBD2H1kSUHW
         ueOcGqzftw+guBLqlW4aqyh6WcBph0J4Y53Z5LqR4IWfMPP17rPN11xKqddb22A3CTyF
         EDtTp9oISuwxChofWrQtkt2n3+ly4KxBbU5dXe1EHtmfAQdqbuGm6fKeJ7K3LADuP5T8
         qZ1g==
X-Gm-Message-State: AO0yUKVxCIFXyWfVfdo8ZhkNOVSAriYN6mkmGVRzoSQPMF62OhAj00r4
        uwmaNRMfIrR2sWLaKtcmR4w=
X-Google-Smtp-Source: AK7set9wftwZ4PfQ17aGk/ifn7boweiIf0LMoxRIbuxb2uYL0NuuX7RWfIu+6IgnmcErMpuNlExVvQ==
X-Received: by 2002:ac8:7f83:0:b0:3dc:1e1f:fe0e with SMTP id z3-20020ac87f83000000b003dc1e1ffe0emr3764125qtj.35.1679093581620;
        Fri, 17 Mar 2023 15:53:01 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b484])
        by smtp.gmail.com with ESMTPSA id y3-20020a37f603000000b0074382b756c2sm2518505qkj.14.2023.03.17.15.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:53:01 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:52:59 -0500
From:   David Vernet <void@manifault.com>
To:     Sreevani Sreejith <ssreevani@meta.com>
Cc:     bpf@vger.kernel.org, psreep@gmail.com, andrii@kernel.org,
        mykolal@meta.com, Linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
Subject: Re: [PATCH V4 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <20230317225259.GA28462@maniforge>
References: <20230315195405.2051559-1-ssreevani@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315195405.2051559-1-ssreevani@meta.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 12:54:05PM -0700, Sreevani Sreejith wrote:
> From: Sreevani <ssreevani@meta.com>
> 
> This patch documents overview of libbpf, including its features for
> developing BPF programs.
> 
> Signed-off-by: Sreevani <ssreevani@meta.com>

Looks great, thanks Sreevani.

Acked-by: David Vernet <void@manifault.com>

> ---
> Changelog:
> 
> v3 = https://lore.kernel.org/all/20230310180928.2462527-1-ssreevani@meta.com/
> v3 -> v4:
>    * Update BTF types link
>    * Update patch summary
>    * Indent code options line
>    * Update "See also" wording 
> 
>  Documentation/bpf/libbpf/index.rst           |  27 ++-
>  Documentation/bpf/libbpf/libbpf_overview.rst | 228 +++++++++++++++++++
>  2 files changed, 246 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/bpf/libbpf/libbpf_overview.rst
> 
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
> index f9b3b252e28f..3ac8c06fb8f4 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -2,23 +2,32 @@
>  
>  .. _libbpf:
>  
> +######
>  libbpf
> -======
> +######
> +
> +If you are looking to develop BPF applications using the libbpf library, this
> +directory contains important documentation that you should read.
> +
> +To get started, it is recommended to begin with the :doc:`libbpf Overview
> +<libbpf_overview>` document, which provides a high-level understanding of the
> +libbpf APIs and their usage. This will give you a solid foundation to start
> +exploring and utilizing the various features of libbpf to develop your BPF
> +applications.
>  
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
> index 000000000000..493a2b90d221
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/libbpf_overview.rst
> @@ -0,0 +1,228 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +***************
> +libbpf Overview
> +***************
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
> +* Provides overall support for the BPF object skeleton generated by bpftool.
> +  The skeleton file simplifies the process for the user space programs to access
> +  global variables and work with BPF programs.
> +* Provides BPF-side APIS, including BPF helper definitions, BPF maps support,
> +  and tracing helpers, allowing developers to simplify BPF code writing.
> +* Supports BPF CO-RE mechanism, enabling BPF developers to write portable
> +  BPF programs that can be compiled once and run across different kernel
> +  versions.
> +
> +This document will delve into the above concepts in detail, providing a deeper
> +understanding of the capabilities and advantages of libbpf and how it can help
> +you develop BPF applications efficiently.
> +
> +BPF App Lifecycle and libbpf APIs
> +==================================
> +
> +A BPF application consists of one or more BPF programs (either cooperating or
> +completely independent), BPF maps, and global variables. The global
> +variables are shared between all BPF programs, which allows them to cooperate on
> +a common set of data. libbpf provides APIs that user space programs can use to
> +manipulate the BPF programs by triggering different phases of a BPF application
> +lifecycle.
> +
> +The following section provides a brief overview of each phase in the BPF life
> +cycle:
> +
> +* **Open phase**. In this phase, libbpf parses the BPF
> +  object file and discovers BPF maps, BPF programs, and global variables. After
> +  a BPF app is opened, user space apps can make additional adjustments
> +  (setting BPF program types, if necessary; pre-setting initial values for
> +  global variables, etc.) before all the entities are created and loaded.
> +
> +* **Load phase**. In the load phase, libbpf creates BPF
> +  maps, resolves various relocations, and verifies and loads BPF programs into
> +  the kernel. At this point, libbpf validates all the parts of a BPF application
> +  and loads the BPF program into the kernel, but no BPF program has yet been
> +  executed. After the load phase, it’s possible to set up the initial BPF map
> +  state without racing with the BPF program code execution.
> +
> +* **Attachment phase**. In this phase, libbpf
> +  attaches BPF programs to various BPF hook points (e.g., tracepoints, kprobes,
> +  cgroup hooks, network packet processing pipeline, etc.). During this
> +  phase, BPF programs perform useful work such as processing
> +  packets, or updating BPF maps and global variables that can be read from user
> +  space.
> +
> +* **Tear down phase**. In the tear down phase,
> +  libbpf detaches BPF programs and unloads them from the kernel. BPF maps are
> +  destroyed, and all the resources used by the BPF app are freed.

Can we use colons (:) after the bolded terms instead of periods?

> +
> +BPF Object Skeleton File
> +========================
> +
> +BPF skeleton is an alternative interface to libbpf APIs for working with BPF
> +objects. Skeleton code abstract away generic libbpf APIs to significantly
> +simplify code for manipulating BPF programs from user space. Skeleton code
> +includes a bytecode representation of the BPF object file, simplifying the
> +process of distributing your BPF code. With BPF bytecode embedded, there are no
> +extra files to deploy along with your application binary.
> +
> +You can generate the skeleton header file ``(.skel.h)`` for a specific object
> +file by passing the BPF object to the bpftool. The generated BPF skeleton
> +provides the following custom functions that correspond to the BPF lifecycle,
> +each of them prefixed with the specific object name:
> +
> +* ``<name>__open()`` – creates and opens BPF application (``<name>`` stands for
> +  the specific bpf object name)
> +* ``<name>__load()`` – instantiates, loads,and verifies BPF application parts
> +* ``<name>__attach()`` – attaches all auto-attachable BPF programs (it’s
> +  optional, you can have more control by using libbpf APIs directly)
> +* ``<name>__destroy()`` – detaches all BPF programs and
> +  frees up all used resources
> +
> +Using the skeleton code is the recommended way to work with bpf programs. Keep
> +in mind, BPF skeleton provides access to the underlying BPF object, so whatever
> +was possible to do with generic libbpf APIs is still possible even when the BPF
> +skeleton is used. It's an additive convenience feature, with no syscalls, and no
> +cumbersome code.
> +
> +Other Advantages of Using Skeleton File
> +---------------------------------------
> +
> +* BPF skeleton provides an interface for user space programs to work with BPF
> +  global variables. The skeleton code memory maps global variables as a struct
> +  into user space. The struct interface allows user space programs to initialize
> +  BPF programs before the BPF load phase and fetch and update data from user
> +  space afterward.
> +
> +* The ``skel.h`` file reflects the object file structure by listing out the
> +  available maps, programs, etc. BPF skeleton provides direct access to all the
> +  BPF maps and BPF programs as struct fields. This eliminates the need for
> +  string-based lookups with ``bpf_object_find_map_by_name()`` and
> +  ``bpf_object_find_program_by_name()`` APIs, reducing errors due to BPF source
> +  code and user-space code getting out of sync.
> +
> +* The embedded bytecode representation of the object file ensures that the
> +  skeleton and the BPF object file are always in sync.
> +
> +BPF Helpers
> +===========
> +
> +libbpf provides BPF-side APIs that BPF programs can use to interact with the
> +system. The BPF helpers definition allows developers to use them in BPF code as
> +any other plain C function. For example, there are helper functions to print
> +debugging messages, get the time since the system was booted, interact with BPF
> +maps, manipulate network packets, etc.
> +
> +For a complete description of what the helpers do, the arguments they take, and
> +the return value, see the `bpf-helpers
> +<https://man7.org/linux/man-pages/man7/bpf-helpers.7.html>`_ man page.
> +
> +BPF CO-RE (Compile Once – Run Everywhere)
> +=========================================
> +
> +BPF programs work in the kernel space and have access to kernel memory and data
> +structures. One limitation that BPF applications come across is the lack of
> +portability across different kernel versions and configurations. `BCC
> +<https://github.com/iovisor/bcc/>`_ is one of the solutions for BPF
> +portability. However, it comes with runtime overhead and a large binary size
> +from embedding the compiler with the application.
> +
> +libbpf steps up the BPF program portability by supporting the BPF CO-RE concept.
> +BPF CO-RE brings together BTF type information, libbpf, and the compiler to
> +produce a single executable binary that you can run on multiple kernel versions
> +and configurations.
> +
> +To make BPF programs portable libbpf relies on the BTF type information of the
> +running kernel. Kernel also exposes this self-describing authoritative BTF
> +information through ``sysfs`` at ``/sys/kernel/btf/vmlinux``.
> +
> +You can generate the BTF information for the running kernel with the following
> +command:
> +
> +::
> +
> +  $ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> +
> +The command generates a ``vmlinux.h`` header file with all kernel types
> +(:doc:`BTF types <../btf>`) that the running kernel uses. Including
> +``vmlinux.h`` in your BPF program eliminates dependency on system-wide kernel
> +headers.
> +
> +libbpf enables portability of BPF programs by looking at the BPF program’s
> +recorded BTF type and relocation information and matching them to BTF
> +information (vmlinux) provided by the running kernel. libbpf then resolves and
> +matches all the types and fields, and updates necessary offsets and other
> +relocatable data to ensure that BPF program’s logic functions correctly for a
> +specific kernel on the host. BPF CO-RE concept thus eliminates overhead
> +associated with BPF development and allows developers to write portable BPF
> +applications without modifications and runtime source code compilation on the
> +target machine.
> +
> +The following code snippet shows how to read the parent field of a kernel
> +``task_struct`` using BPF CO-RE and libbf. The basic helper to read a field in a
> +CO-RE relocatable manner is ``bpf_core_read(dst, sz, src)``, which will read
> +``sz`` bytes from the field referenced by ``src`` into the memory pointed to by
> +``dst``.
> +
> +.. code-block:: C
> +   :emphasize-lines: 6
> +
> +    //...
> +    struct task_struct *task = (void *)bpf_get_current_task();
> +    struct task_struct *parent_task;
> +    int err;
> +
> +    err = bpf_core_read(&parent_task, sizeof(void *), &task->parent);
> +    if (err) {
> +      /* handle error */
> +    }
> +
> +    /* parent_task contains the value of task->parent pointer */
> +
> +In the code snippet, we first get a pointer to the current ``task_struct`` using
> +``bpf_get_current_task()``.  We then use ``bpf_core_read()`` to read the parent
> +field of task struct into the ``parent_task`` variable. ``bpf_core_read()`` is
> +just like ``bpf_probe_read_kernel()`` BPF helper, except it records information
> +about the field that should be relocated on the target kernel. i.e, if the
> +``parent`` field gets shifted to a different offset within struct
> +``task_struct`` due to some new field added in front of it, libbpf will

struct should be included in the code markup (i.e. `struct
task_struct`).

> +automatically adjust the actual offset to the proper value.
> +
> +Getting Started with libbpf
> +===========================
> +
> +Check out the `libbpf-bootstrap <https://github.com/libbpf/libbpf-bootstrap>`_
> +repository with simple examples of using libbpf to build various BPF
> +applications.
> +
> +See also `libbpf API documentation
> +<https://libbpf.readthedocs.io/en/latest/api.html>`_.
> +
> +libbpf and Rust
> +===============
> +
> +If you are building BPF applications in Rust, it is recommended to use the
> +`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_ library instead of bindgen
> +bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
> +Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF code
> +compilation and skeleton generation. Using Libbpf-rs will make building user
> +space part of the BPF application easier. Note that the BPF program themselves
> +must still be written in plain C.
> +
> +Additional Documentation
> +========================
> +
> +* `Program types and ELF Sections <https://libbpf.readthedocs.io/en/latest/program_types.html>`_
> +* `API naming convention <https://libbpf.readthedocs.io/en/latest/libbpf_naming_convention.html>`_
> +* `Building libbpf <https://libbpf.readthedocs.io/en/latest/libbpf_build.html>`_
> +* `API documentation Convention <https://libbpf.readthedocs.io/en/latest/libbpf_naming_convention.html#api-documentation-convention>`_
> -- 
> 2.34.1
> 
