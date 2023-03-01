Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F76A7406
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCATHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCATHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:07:21 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB094D603
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 11:07:19 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321IV4sU022344
        for <bpf@vger.kernel.org>; Wed, 1 Mar 2023 11:07:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=bwe3QnT0aSkOztQjoqI0h3Sd8yjdym5D+0rzXHwDCfg=;
 b=fhceo2W7zVcUQcd36+NtnVL+gdR+IAdWcGvACsxhQjuL51XudX2sOLEje/FvKvoBz15D
 AV2DFdMN/CkXJMrnrycLhF4QopgW/91FPHEZWTIJkrmhOoxZo/qgacSwhLeu2kTuJYog
 98oWun2jz3viWaCGXrIPoE7rJ+wPWYWt9m0Dr9N4Jri+Qg45Lnj3WPwMzCj5XNxoLeQk
 Yd8F2BK5ORBeR6/rjLgcg/LgPNkM7qkV16jpJ1HEOdUkQwYVwm40JPQ+diAKHkwSOafe
 dDe5CeI3GU9M3TSyg4U4lA1sCZ1H/SPLhyfedEfE/ZH+Umu6pj681vXNmC2ZGOlImKA0 0w== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2c23ra6a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 11:07:18 -0800
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Mar 2023 11:07:16 -0800
Received: by devvm11876.prn0.facebook.com (Postfix, from userid 343873)
        id CA7A799A74C4; Wed,  1 Mar 2023 11:07:11 -0800 (PST)
From:   Sreevani Sreejith <ssreevani@meta.com>
To:     <bpf@vger.kernel.org>, <Linux-kernel@vger.kernel.org>,
        <andrii@kernel.org>, <void@manifault.com>, <mykolal@meta.com>,
        <psreep@gmail.com>
CC:     Sreevani <ssreevani@meta.com>
Subject: [PATCH bpf-next] BPF, docs: libbpf Overview Document
Date:   Wed, 1 Mar 2023 11:07:02 -0800
Message-ID: <20230301190702.3222292-1-ssreevani@meta.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: L0GxV_HC9zdZkk0Eq9GpvC_sivEWdTIv
X-Proofpoint-ORIG-GUID: L0GxV_HC9zdZkk0Eq9GpvC_sivEWdTIv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sreevani <ssreevani@meta.com>

Summary: Document that provides an overview of libbpf features for BPF
application development.

Reviewers:

Subscribers:

Tags: BPF, libbpf
Signed-off-by: Sreevani <ssreevani@meta.com>
---
 Documentation/bpf/libbpf/index.rst           |  24 ++-
 Documentation/bpf/libbpf/libbpf_overview.rst | 212 +++++++++++++++++++
 2 files changed, 228 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/libbpf_overview.rst

diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/=
index.rst
index f9b3b252e28f..f5da02972686 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -2,23 +2,31 @@

 .. _libbpf:

+=3D=3D=3D=3D=3D=3D
 libbpf
 =3D=3D=3D=3D=3D=3D

+If you are looking to develop BPF applications using the libbpf library, t=
his
+directory contains important documentation that you should read.
+
+To get started, it is recommended to begin with the "libbpf Overview" docu=
ment,
+which provides a high-level understanding of the libbpf APIs and their usa=
ge.
+This will give you a solid foundation to start exploring and utilizing the
+various features of libbpf to develop your BPF applications.
+
 .. toctree::
    :maxdepth: 1

+   libbpf_overview
    API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
    program_types
    libbpf_naming_convention
    libbpf_build

-This is documentation for libbpf, a userspace library for loading and
-interacting with bpf programs.

-All general BPF questions, including kernel functionality, libbpf APIs and
-their application, should be sent to bpf@vger.kernel.org mailing list.
-You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
-mailing list search its `archive <https://lore.kernel.org/bpf/>`_.
-Please search the archive before asking new questions. It very well might
-be that this was already addressed or answered before.
+All general BPF questions, including kernel functionality, libbpf APIs and=
 their
+application, should be sent to bpf@vger.kernel.org mailing list.  You can
+`subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the mailing l=
ist
+search its `archive <https://lore.kernel.org/bpf/>`_.  Please search the a=
rchive
+before asking new questions. It may be that this was already addressed or
+answered before.
diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/b=
pf/libbpf/libbpf_overview.rst
new file mode 100644
index 000000000000..15b4f1e28f48
--- /dev/null
+++ b/Documentation/bpf/libbpf/libbpf_overview.rst
@@ -0,0 +1,212 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ libbpf Overview
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+libbpf is a C-based library containing a BPF loader that takes compiled BPF
+object files and prepares and loads them into the Linux kernel. libbpf tak=
es the
+heavy lifting of loading, verifying, and attaching BPF programs to various
+kernel hooks, allowing BPF application developers to focus only on BPF pro=
gram
+correctness and performance.
+
+The following are the high-level features supported by libbpf:
+
+* Provides high-level and low-level APIs for user space programs to intera=
ct
+  with BPF programs. The low-level APIs wrap all the bpf system call
+  functionality, which is useful when users need more fine-grained control
+  over the interactions between user space and BPF programs.
+* Provides overall support for the BPF object skeleton generated by the bp=
ftool.
+  The skeleton file simplifies the process for the user space programs to =
access
+  global variables and work with BPF programs.
+* Provides BPF-side APIS, including BPF helper definitions, BPF maps suppo=
rt
+  and, tracing helpers, allowing developers to simplify BPF code writing.
+* Supports BPF CO-RE mechanism, enabling BPF developers to write portable
+  BPF programs that can be compiled once and run across different kernel
+  versions.
+
+This document will delve into the above concepts in detail, providing a de=
eper
+understanding of the capabilities and advantages of libbpf and how it can =
help
+you develop BPF applications efficiently.
+
+#################################
+BPF App Lifecycle and libbpf APIs
+#################################
+
+BPF application consists of a set of BPF programs, either cooperating or
+completely independent, and BPF maps and global variables, shared between =
all
+BPF programs (allowing them to cooperate on a common set of data). llibbpf
+provides APIs that user space programs can use to manipulate the BPF progr=
ams by
+triggering different phases of a BPF application lifecycle. The APIs abstr=
act
+away the complexity of BPF programs and provide a more intuitive way to ma=
nage
+the lifecycle of BPF applications. The differents phases and corresponding
+libbpf APIs to trigger are listed below:
+
+* **Open phase** (``bpf_object__open()``). In this phase, libbpf parses th=
e BPF
+  object file and discovers BPF maps, BPF programs, and global variables. =
After
+  a BPF app is opened, user space apps can make additional adjustments
+  (setting BPF program types, if necessary; pre-setting initial values for
+  global variables, etc.) before all the entities are created and loaded.
+
+* **Load phase** (``bpf_object__load()``). In the load phase, libbpf creat=
es BPF
+  maps, resolves various relocations, and verifies and loads BPF programs =
into
+  the kernel. At this point, libbpf validates all the parts of a BPF appli=
cation
+  and loads the BPF program into the kernel, but no BPF program has yet be=
en
+  executed. After the load phase, it=E2=80=99s possible to set up the init=
ial BPF map
+  state without racing with the BPF program code execution.
+
+* **Attachment phase** (``bpf_program__attach()``). In this phase, libbpf
+  attaches BPF programs to various BPF hook points (e.g., tracepoints, kpr=
obes,
+  cgroup hooks, network packet processing pipeline, etc.). This is also the
+  phase at which BPF starts performing useful work and read/update BPF map=
s and
+  global variables.
+
+* **Tear down phase** (``bpf_program__destroy()``). In the tear down phase,
+  libbpf detaches BPF programs and unloads from the kernel. BPF maps are
+  destroyed, and all the resources used by the BPF app are freed.
+
+By leveraging the libbpf APIs, developers write code that can easily inter=
act
+with BPF programs and ensure that they are working effectively and efficie=
ntly.
+
+########################
+BPF Object Skeleton File
+########################
+
+BPF skeleton is an alternative and complementary interface to libbpf APIs =
for
+working with BPF objects. You can generate the skeleton header file
+``(.skel.h)`` for a specific object file by passing the BPF object to the
+bpftool. The generated ``.skel.h`` file simplifies the code to load and wo=
rk
+with the BPF objects, maps, programs, and global data from the user space.=
 For
+example, the generated BPF skeleton has corresponding functions to trigger=
 each
+phase in the BPF life cycle:
+
+* ``<name>__open()`` =E2=80=93 creates and opens BPF application (``<name>=
`` stands for
+  the corresponding bpf object name)
+* ``<name>__load()`` =E2=80=93 instantiates, loads,and verifies BPF applic=
ation parts
+* ``<name>__attach()`` =E2=80=93 attaches all auto-attachable BPF programs=
 (it=E2=80=99s
+  optional, you can have more control by using libbpf APIs directly)
+* ``<name>__destroy()`` =E2=80=93 detaches all BPF programs and
+  frees up all used resources
+
+Keep in mind, BPF skeleton provides access to the underlying BPF object, so
+whatever was possible to do with generic libbpf APIs is still possible eve=
n when
+the BPF skeleton is used. It's an additive convenience feature, no syscall=
s, and
+no cumbersome code.
+
+
+Other Advantages of Using SkeletonFile:
+########################################
+
+* BPF skeleton provides a convenient interface to work with BPF global
+  variables from the user space by memory mapping BPF global variables int=
o the
+  user space as a struct. The struct interface allows user space programs =
to
+  easily set up initial values of variables before the BPF load phase and =
fetch
+  and update data from user space afterward.
+
+* The ``skel.h`` file reflects the object file structure by listing out the
+  available maps, programs, etc. BPF skeleton provides direct access to al=
l the
+  BPF maps and BPF programs as struct fields. This eliminates the need for
+  string-based lookups with ``bpf_object_find_map_by_name()`` and
+  ``bpf_object_find_program_by_name()`` APIs, reducing errors due to BPF s=
ource
+  code and user-space code getting out of sync.
+
+* The generated skeleton file is embedded with a bytecode representation o=
f the
+  object file, ensuring that the skeleton and the BPF object file are alwa=
ys in
+  sync.
+
+###########
+BPF Helpers
+###########
+
+libbpf provides BPF-side APIs that BPF programs can use to interact with t=
he
+system. libbpf conveniently provides definitions of BPF helpers, allowing =
you to
+use them in BPF code as any other plain C function. For example, there are
+helper functions to print debugging messages, get the time since the syste=
m was
+booted, interact with BPF maps, manipulate network packets, etc.
+
+For a complete description of what the helpers do, the arguments they take=
, and
+the return value, see the `bpf-helpers
+<https://man7.org/linux/man-pages/man7/bpf-helpers.7.html>`_ man page.
+
+#########################################
+BPF CO-RE (Compile Once =E2=80=93 Run Everywhere)
+#########################################
+
+libbpf works with the compiler to support BPF CO-RE mechanism to produce a
+single executable binary that you can run on multiple kernel versions and
+configurations. This approach allows developers to write portable BPF
+applications and run them in any Linux system without modifications and ru=
ntime
+source code compilation on the target machine.
+
+To support CO-RE programs, libbpf relies on the header file, ``vmlinux.h``=
, to
+tailor the BPF program code to a particular running kernel on the host.
+``vmlinux.h`` file includes all kernel types (BTF type) that the running k=
ernel
+uses. Including this header file in your BPF program can eliminate depende=
ncy on
+system-wide kernel headers. You can generate ``vmlinux.h`` using the follo=
wing
+bpftool command:
+
+::
+
+$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
+
+
+libbpf looks at the BPF program=E2=80=99s recorded BTF type and relocation=
 information
+and matches them to BTF information provided by the running kernel. libbpf
+resolves and matches all the types and fields, and updates necessary offse=
ts and
+other relocatable data to ensure that BPF program=E2=80=99s logic is corre=
ctly
+functioning for a specific kernel on the host.
+
+##############
+libbpf Vs. BCC
+##############
+
+Historically, `BCC <https://github.com/iovisor/bcc/>`_ was a framework of =
choice
+for developing BPF applications that required efficient kernel tracing for
+analyzing kernel components. BCC compiles BPF programs on the host machine,
+ensuring that the memory layout your BPF program expects is precisely the =
same
+as that of the target host. However, BCC relies on runtime compilation and
+brings the entire huge LLVM/Clang library in and embeds it inside itself. =
This
+results in many consequences, such as heavy resource utilization, kernel h=
eaders
+dependency, and detecting even trivial compilation errors only during run =
time,
+all of which are less than ideal.
+
+libbpf aims at eliminating overheads associated with BPF app development by
+reducing heavy dependency on system-wide headers. libbpf enables you to ge=
nerate
+small binaries that can be compiled once and run anywhere, which is better=
 at
+resource usage and keeps runtime overhead to a minimum. libbpf offers seve=
ral
+benefits by playing the role of a BPF program loader, performing mundane s=
etup
+work (relocations, loading and verifying BPF programs, creating BPF maps,
+attaching to BPF hooks, etc.), and letting developers worry only about BPF
+program correctness and performance. With these features, libbpf makes the
+overall developer experience much more pleasant.
+
+###########################
+Getting Started with libbpf
+###########################
+
+Check out the `libbpf-bootstrap <https://github.com/libbpf/libbpf-bootstra=
p>`_
+repository with simple examples of using libbpf to build various BPF
+applications.
+
+Also, find the libbpf API documentation `here
+<https://libbpf.readthedocs.io/en/latest/api.html>`_
+
+###############
+libbpf and Rust
+###############
+
+If you are building BPF applications in Rust, it is recommended to use
+`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_  ibrary instead of bind=
gen
+bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
+Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF c=
ode
+compilation and skeleton generation. Using Libbpf-rs will make building us=
er
+space part of the BPF application easier. However, you are still expected =
to
+write BPF program code in plain C, utilizing all the BPF-side APIs of libb=
pf
+directly.
+
+########################
+Additional Documentation
+########################
+
+* `Program types and ELF Sections <https://libbpf.readthedocs.io/en/latest=
/program_types.html>`_
+* `API naming convention <https://libbpf.readthedocs.io/en/latest/libbpf_n=
aming_convention.html>`_
+* `Building libbpf <https://libbpf.readthedocs.io/en/latest/libbpf_build.h=
tml>`_
+* `API documentation Convention <https://libbpf.readthedocs.io/en/latest/l=
ibbpf_naming_convention.html#api-documentation-convention>`_
--
2.30.2

