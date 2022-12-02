Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B364107E
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiLBWR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiLBWRt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:17:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7B193C1
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 14:17:44 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2K7PL6027516
        for <bpf@vger.kernel.org>; Fri, 2 Dec 2022 14:17:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=/GgPRlmKJtYx0PuMuDKUlbb/0L4DHjfyI9KdRt1HG8c=;
 b=kWxkIo7EnP4ztG4PCGqKq6vr8p6d/1hT+IjRFmVbW0d5SfUdb3T4KBKsknRxLuaT45/T
 kApbtdIz3ouuZ+Ol1joLeaGqsK4VvF8DcfQ/LCoKxTt1mXyKuPLD8fEQEzL5zKfMUepJ
 /P67M3DREjNfoXmfBMNsyi2/OqUQquk9ckJoT9Iv8fv817cWlShADADRb2ramYNu7xFY
 MaL+Lmj31BUs/DFluqD4aB2ouFBnAFy0abR2pQVyMWCnoAXtRFvAI4PptzADg+N+aET3
 1U5fn44+ItapTqMQ5No7tPvJ5O2pbKPeBny+ye3I8MG1tlnC83rNAOmpZDzjcFAeYOuW YA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m7gs5vv18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 14:17:43 -0800
Received: from twshared16837.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:17:42 -0800
Received: by devvm11876.prn0.facebook.com (Postfix, from userid 343873)
        id 364FC4052AC2; Fri,  2 Dec 2022 14:17:37 -0800 (PST)
From:   Sreevani Sreejith <ssreevani@meta.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <psreep@gmail.com>
CC:     <void@manifault.com>, <yhs@meta.com>, <mykolal@meta.com>
Subject: [PATCH v2 bpf-next 1/1] bpf, docs: BPF Iterator Document
Date:   Fri, 2 Dec 2022 14:17:10 -0800
Message-ID: <20221202221710.320810-2-ssreevani@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202221710.320810-1-ssreevani@meta.com>
References: <20221202221710.320810-1-ssreevani@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: 5jpQo3Gg7LwRJV2_LyrWoLMuZ_F73qfJ
X-Proofpoint-ORIG-GUID: 5jpQo3Gg7LwRJV2_LyrWoLMuZ_F73qfJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sreevani Sreejith <psreep@gmail.com>

Document that describes how BPF iterators work, how to use iterators,
and how to pass parameters in BPF iterators.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Sreevani Sreejith <psreep@gmail.com>
---
 Documentation/bpf/bpf_iterators.rst | 485 ++++++++++++++++++++++++++++
 Documentation/bpf/index.rst         |   1 +
 2 files changed, 486 insertions(+)
 create mode 100644 Documentation/bpf/bpf_iterators.rst

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_it=
erators.rst
new file mode 100644
index 000000000000..6d7770793fab
--- /dev/null
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -0,0 +1,485 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF Iterators
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+----------
+Motivation
+----------
+
+There are a few existing ways to dump kernel data into user space. The most
+popular one is the ``/proc`` system. For example, ``cat /proc/net/tcp6`` d=
umps
+all tcp6 sockets in the system, and ``cat /proc/net/netlink`` dumps all ne=
tlink
+sockets in the system. However, their output format tends to be fixed, and=
 if
+users want more information about these sockets, they have to patch the ke=
rnel,
+which often takes time to publish upstream and release. The same is true f=
or popular
+tools like `ss <https://man7.org/linux/man-pages/man8/ss.8.html>`_ where a=
ny
+additional information needs a kernel patch.
+
+To solve this problem, the `drgn
+<https://www.kernel.org/doc/html/latest/bpf/drgn.html>`_ tool is often use=
d to
+dig out the kernel data with no kernel change. However, the main drawback =
for
+drgn is performance, as it cannot do pointer tracing inside the kernel. In
+addition, drgn cannot validate a pointer value and may read invalid data i=
f the
+pointer becomes invalid inside the kernel.
+
+The BPF iterator solves the above problem by providing flexibility on what=
 data
+(e.g., tasks, bpf_maps, etc.) to collect by calling BPF programs for each =
kernel
+data object.
+
+----------------------
+How BPF Iterators Work
+----------------------
+
+A BPF iterator is a type of BPF program that allows users to iterate over
+specific types of kernel objects. Unlike traditional BPF tracing programs =
that
+allow users to define callbacks that are invoked at particular points of
+execution in the kernel, BPF iterators allow users to define callbacks that
+should be executed for every entry in a variety of kernel data structures.
+
+For example, users can define a BPF iterator that iterates over every task=
 on
+the system and dumps the total amount of CPU runtime currently used by eac=
h of
+them. Another BPF task iterator may instead dump the cgroup information fo=
r each
+task. Such flexibility is the core value of BPF iterators.
+
+A BPF program is always loaded into the kernel at the behest of a user spa=
ce
+process. A user space process loads a BPF program by opening and initializ=
ing
+the program skeleton as required and then invoking a syscall to have the B=
PF
+program verified and loaded by the kernel.
+
+In traditional tracing programs, a program is activated by having user spa=
ce
+obtain a ``bpf_link`` to the program with ``bpf_program__attach()``. Once
+activated, the program callback will be invoked whenever the tracepoint is
+triggered in the main kernel. For BPF iterator programs, a ``bpf_link`` to=
 the
+program is obtained using ``bpf_link_create()``, and the program callback =
is
+invoked by issuing system calls from user space.
+
+Next, let us see how you can use the iterators to iterate on kernel object=
s and
+read data.
+
+------------------------
+How to Use BPF iterators
+------------------------
+
+BPF selftests are a great resource to illustrate how to use the iterators.=
 In
+this section, we=E2=80=99ll walk through a BPF selftest which shows how to=
 load and use
+a BPF iterator program.   To begin, we=E2=80=99ll look at `bpf_iter.c
+<https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/too=
ls/testing/selftests/bpf/prog_tests/bpf_iter.c>`_,
+which illustrates how to load and trigger BPF iterators on the user space =
side.
+Later, we=E2=80=99ll look at a BPF program that runs in kernel space.
+
+Loading a BPF iterator in the kernel from user space typically involves the
+following steps:
+
+* The BPF program is loaded into the kernel through ``libbpf``. Once the k=
ernel
+  has verified and loaded the program, it returns a file descriptor (fd) t=
o user
+  space.
+* Obtain a ``link_fd`` to the BPF program by calling the ``bpf_link_create=
()``
+  specified with the BPF program file descriptor received from the kernel.
+* Next, obtain a BPF iterator file descriptor (``bpf_iter_fd``) by calling=
 the
+  ``bpf_iter_create()`` specified with the ``bpf_link`` received from Step=
 2.
+* Trigger the iteration by calling ``read(bpf_iter_fd)`` until no data is
+  available.
+* Close the iterator fd using ``close(bpf_iter_fd)``.
+* If needed to reread the data, get a new ``bpf_iter_fd`` and do the read =
again.
+
+The following are a few examples of selftest BPF iterator programs:
+
+* `bpf_iter_tcp4.c <https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bp=
f-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c>`_
+* `bpf_iter_task_vma.c <https://git.kernel.org/pub/scm/linux/kernel/git/bp=
f/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c>`_
+* `bpf_iter_task_file.c <https://git.kernel.org/pub/scm/linux/kernel/git/b=
pf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c=
>`_
+
+Let us look at ``bpf_iter_task_file.c``, which runs in kernel space:
+
+Here is the definition of ``bpf_iter__task_file`` in `vmlinux.h
+<https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-=
and-co-re.html#btf>`_.
+Any struct name in ``vmlinux.h`` in the format ``bpf_iter__<iter_name>``
+represents a BPF iterator. The suffix ``<iter_name>`` represents the type =
of
+iterator.
+
+::
+
+    struct bpf_iter__task_file {
+            union {
+                struct bpf_iter_meta *meta;
+            };
+            union {
+                struct task_struct *task;
+            };
+            u32 fd;
+            union {
+                struct file *file;
+            };
+    };
+
+In the above code, the field 'meta' contains the metadata, which is the sa=
me for
+all BPF iterator programs. The rest of the fields are specific to different
+iterators. For example, for task_file iterators, the kernel layer provides=
 the
+'task', 'fd' and 'file' field values. The 'task' and 'file' are `reference
+counted
+<https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.=
html#file-descriptors-and-reference-counters>`_,
+so they won't go away when the BPF program runs.
+
+Here is a snippet from the  ``bpf_iter_task_file.c`` file:
+
+::
+
+  SEC("iter/task_file")
+  int dump_task_file(struct bpf_iter__task_file *ctx)
+  {
+    struct seq_file *seq =3D ctx->meta->seq;
+    struct task_struct *task =3D ctx->task;
+    struct file *file =3D ctx->file;
+    __u32 fd =3D ctx->fd;
+
+    if (task =3D=3D NULL || file =3D=3D NULL)
+      return 0;
+
+    if (ctx->meta->seq_num =3D=3D 0) {
+      count =3D 0;
+      BPF_SEQ_PRINTF(seq, "    tgid      gid       fd      file\n");
+    }
+
+    if (tgid =3D=3D task->tgid && task->tgid !=3D task->pid)
+      count++;
+
+    if (last_tgid !=3D task->tgid) {
+      last_tgid =3D task->tgid;
+      unique_tgid_count++;
+    }
+
+    BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
+            (long)file->f_op);
+    return 0;
+  }
+
+In the above example, the section name ``SEC(iter/task_file)``, indicates =
that
+the program is a BPF iterator program to iterate all files from all tasks.=
 The
+context of the program is ``bpf_iter__task_file`` struct.
+
+The user space program invokes the BPF iterator program running in the ker=
nel
+by issuing a ``read()`` syscall. Once invoked, the BPF
+program can export data to user space using a variety of BPF helper functi=
ons.
+You can use either ``bpf_seq_printf()`` (and BPF_SEQ_PRINTF helper macro) =
or
+``bpf_seq_write()`` function based on whether you need formatted output or=
 just
+binary data, respectively. For binary-encoded data, the user space applica=
tions
+can process the data from ``bpf_seq_write()`` as needed. For the formatted=
 data,
+you can use ``cat <path>`` to print the results similar to ``cat
+/proc/net/netlink`` after pinning the BPF iterator to the bpffs mount. Lat=
er,
+use  ``rm -f <path>`` to remove the pinned iterator.
+
+For example, you can use the following command to create a BPF iterator fr=
om the
+``bpf_iter_ipv6_route.o`` object file and pin it to the ``/sys/fs/bpf/my_r=
oute``
+path:
+
+::
+
+  $ bpftool iter pin ./bpf_iter_ipv6_route.o  /sys/fs/bpf/my_route
+
+And then print out the results using the following command:
+
+::
+
+  $ cat /sys/fs/bpf/my_route
+
+
+-------------------------------------------------------
+Implement Kernel Support for BPF Iterator Program Types
+-------------------------------------------------------
+
+To implement a BPF iterator in the kernel, the developer must make a one-t=
ime
+change to the following key data structure defined in the `bpf.h
+<https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/inc=
lude/linux/bpf.h>`_
+file.
+
+::
+
+  struct bpf_iter_reg {
+            const char *target;
+            bpf_iter_attach_target_t attach_target;
+            bpf_iter_detach_target_t detach_target;
+            bpf_iter_show_fdinfo_t show_fdinfo;
+            bpf_iter_fill_link_info_t fill_link_info;
+            bpf_iter_get_func_proto_t get_func_proto;
+            u32 ctx_arg_info_size;
+            u32 feature;
+            struct bpf_ctx_arg_aux ctx_arg_info[BPF_ITER_CTX_ARG_MAX];
+            const struct bpf_iter_seq_info *seq_info;
+  };
+
+After filling the data structure fields, call ``bpf_iter_reg_target()`` to
+register the iterator to the main BPF iterator subsystem.
+
+The following is the breakdown for each field in struct ``bpf_iter_reg``.
+
+.. list-table::
+   :widths: 25 50
+   :header-rows: 1
+
+   * - Fields
+     - Description
+   * - target
+     - Specifies the name of the BPF iterator. For example: ``bpf_map``,
+       ``bpf_map_elem``. The name should be different from other ``bpf_ite=
r`` target names in the kernel.
+   * - attach_target and detach_target
+     - Allows for target specific ``link_create`` action since some targets
+       may need special processing. Called during the user space link_crea=
te stage.
+   * - show_fdinfo and fill_link_info
+     - Called to fill target specific information when user tries to get l=
ink
+       info associated with the iterator.
+   * - get_func_proto
+     - Permits a BPF iterator to access BPF helpers specific to the iterat=
or.
+   * - ctx_arg_info_size and ctx_arg_info
+     - Specifies the verifier states for BPF program arguments associated =
with
+       the bpf iterator.
+   * - feature
+     - Specifies certain action requests in the kernel BPF iterator
+       infrastructure. Currently, only BPF_ITER_RESCHED is supported. This=
 means
+       that the kernel function cond_resched() is called to avoid other ke=
rnel
+       subsystem (e.g., rcu) misbehaving.
+   * - seq_info
+     - Specifies certain action requests in the kernel BPF iterator
+       infrastructure. Currently, only BPF_ITER_RESCHED is supported. This=
 means
+       that the kernel function cond_resched() is called to avoid other ke=
rnel
+       subsystem (e.g., rcu) misbehaving.
+
+
+`Click here
+<https://lore.kernel.org/bpf/20210212183107.50963-2-songliubraving@fb.com/=
>`_
+to see an implementation of the ``task_vma`` BPF iterator in the kernel.
+
+---------------------------------
+Parameterizing BPF Task Iterators
+---------------------------------
+
+By default, BPF iterators walk through all the objects of the specified ty=
pes
+(processes, cgroups, maps, etc.) across the entire system to read relevant
+kernel data. But often, there are cases where we only care about a much sm=
aller
+subset of iterable kernel objects, such as only iterating tasks within a
+specific process. Therefore, BPF iterator programs support filtering out o=
bjects
+from iteration by allowing user space to configure the iterator program wh=
en it
+is attached.
+
+--------------------------
+BPF Task Iterator Program
+--------------------------
+
+The following code is a BPF iterator program to print files and task infor=
mation
+through the ``seq_file`` of the iterator. It is a standard BPF iterator pr=
ogram
+that visits every file of an iterator. We will use this BPF program in our
+example later.
+
+::
+
+  #include <vmlinux.h>
+  #include <bpf/bpf_helpers.h>
+
+  char _license[] SEC("license") =3D "GPL";
+
+  SEC("iter/task_file")
+  int dump_task_file(struct bpf_iter__task_file *ctx)
+  {
+        struct seq_file *seq =3D ctx->meta->seq;
+        struct task_struct *task =3D ctx->task;
+        struct file *file =3D ctx->file;
+        __u32 fd =3D ctx->fd;
+        if (task =3D=3D NULL || file =3D=3D NULL)
+                return 0;
+        if (ctx->meta->seq_num =3D=3D 0) {
+                BPF_SEQ_PRINTF(seq, "    tgid      pid       fd      file\=
n");
+        }
+        BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
+                        (long)file->f_op);
+        return 0;
+  }
+
+----------------------------------------
+Creating a File Iterator with Parameters
+----------------------------------------
+
+Now, let us look at how to create an iterator that includes only files of a
+process.
+
+First,  fill the ``bpf_iter_attach_opts`` struct as shown below:
+
+::
+
+  LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+  union bpf_iter_link_info linfo;
+  memset(&linfo, 0, sizeof(linfo));
+  linfo.task.pid =3D getpid();
+  opts.link_info =3D &linfo;
+  opts.link_info_len =3D sizeof(linfo);
+
+``linfo.task.pid``, if it is non-zero, directs the kernel to create an ite=
rator
+that only includes opened files for the process with the specified ``pid``=
. In
+this example, we will only be iterating files for our process. If
+``linfo.task.pid`` is zero, the iterator will visit every opened file of e=
very
+process. Similarly, ``linfo.task.tid`` directs the kernel to create an ite=
rator
+that visits opened files of a specific thread, not a process. In this exam=
ple,
+``linfo.task.tid`` is different from ``linfo.task.pid`` only if the thread=
 has a
+separate file descriptor table. In most circumstances, all process threads=
 share
+a single file descriptor table.
+
+Now, in the userspace program, pass the pointer of struct to the
+``bpf_program__attach_iter()``.
+
+::
+
+  link =3D bpf_program__attach_iter(prog, &opts); iter_fd =3D
+  bpf_iter_create(bpf_link__fd(link));
+
+If both *tid* and *pid* are zero, an iterator created from this struct
+``bpf_iter_attach_opts`` will include every opened file of every task in t=
he
+system (in the namespace, actually.) It is the same as passing a NULL as t=
he
+second argument to ``bpf_program__attach_iter()``.
+
+The whole program looks like the following code:
+
+::
+
+  #include <stdio.h>
+  #include <unistd.h>
+  #include <bpf/bpf.h>
+  #include <bpf/libbpf.h>
+  #include "bpf_iter_task_ex.skel.h"
+
+  static int do_read_opts(struct bpf_program *prog, struct bpf_iter_attach=
_opts *opts)
+  {
+        struct bpf_link *link;
+        char buf[16] =3D {};
+        int iter_fd =3D -1, len;
+        int ret =3D 0;
+
+        link =3D bpf_program__attach_iter(prog, opts);
+        if (!link) {
+                fprintf(stderr, "bpf_program__attach_iter() fails\n");
+                return -1;
+        }
+        iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+        if (iter_fd < 0) {
+                fprintf(stderr, "bpf_iter_create() fails\n");
+                ret =3D -1;
+                goto free_link;
+        }
+        /* not check contents, but ensure read() ends without error */
+        while ((len =3D read(iter_fd, buf, sizeof(buf) - 1)) > 0) {
+                buf[len] =3D 0;
+                printf("%s", buf);
+        }
+        printf("\n");
+  free_link:
+        if (iter_fd >=3D 0)
+                close(iter_fd);
+        bpf_link__destroy(link);
+        return 0;
+  }
+
+  static void test_task_file(void)
+  {
+        LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+        struct bpf_iter_task_ex *skel;
+        union bpf_iter_link_info linfo;
+        skel =3D bpf_iter_task_ex__open_and_load();
+        if (skel =3D=3D NULL)
+                return;
+        memset(&linfo, 0, sizeof(linfo));
+        linfo.task.pid =3D getpid();
+        opts.link_info =3D &linfo;
+        opts.link_info_len =3D sizeof(linfo);
+        printf("PID %d\n", getpid());
+        do_read_opts(skel->progs.dump_task_file, &opts);
+        bpf_iter_task_ex__destroy(skel);
+  }
+
+  int main(int argc, const char * const * argv)
+  {
+        test_task_file();
+        return 0;
+  }
+
+The following lines are the output of the program.
+::
+
+  PID 1859
+
+     tgid      pid       fd      file
+     1859     1859        0 ffffffff82270aa0
+     1859     1859        1 ffffffff82270aa0
+     1859     1859        2 ffffffff82270aa0
+     1859     1859        3 ffffffff82272980
+     1859     1859        4 ffffffff8225e120
+     1859     1859        5 ffffffff82255120
+     1859     1859        6 ffffffff82254f00
+     1859     1859        7 ffffffff82254d80
+     1859     1859        8 ffffffff8225abe0
+
+------------------
+Without Parameters
+------------------
+
+Let us look at how a BPF iterator without parameters skips files of other
+processes in the system. In this case, the BPF program has to check the pi=
d or
+the tid of tasks, or it will receive every opened file in the system (in t=
he
+current *pid* namespace, actually). So, we usually add a global variable i=
n the
+BPF program to pass a *pid* to the BPF program.
+
+The BPF program would look like the following block.
+
+  ::
+
+    ......
+    int target_pid =3D 0;
+
+    SEC("iter/task_file")
+    int dump_task_file(struct bpf_iter__task_file *ctx)
+    {
+          ......
+          if (task->tgid !=3D target_pid) /* Check task->pid instead to ch=
eck thread IDs */
+                  return 0;
+          BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, =
fd,
+                          (long)file->f_op);
+          return 0;
+    }
+
+The user space program would look like the following block:
+
+  ::
+
+    ......
+    static void test_task_file(void)
+    {
+          ......
+          skel =3D bpf_iter_task_ex__open_and_load();
+          if (skel =3D=3D NULL)
+                  return;
+          skel->bss->target_pid =3D getpid(); /* process ID.  For thread i=
d, use gettid() */
+          memset(&linfo, 0, sizeof(linfo));
+          linfo.task.pid =3D getpid();
+          opts.link_info =3D &linfo;
+          opts.link_info_len =3D sizeof(linfo);
+          ......
+    }
+
+``target_pid`` is a global variable in the BPF program. The user space pro=
gram
+should initialize the variable with a process ID to skip opened files of o=
ther
+processes in the BPF program. When you parametrize a BPF iterator, the ite=
rator
+calls the BPF program fewer times which can save significant resources.
+
+---------------------------
+Parametrizing VMA Iterators
+---------------------------
+
+By default, a BPF VMA iterator includes every VMA in every process.  Howev=
er,
+you can still specify a process or a thread to include only its VMAs. Unli=
ke
+files, a thread can not have a separate address space (since Linux 2.6.0-t=
est6).
+Here, using *tid* makes no difference from using *pid*.
+
+----------------------------
+Parametrizing Task Iterators
+----------------------------
+
+A BPF task iterator with *pid* includes all tasks (threads) of a process. =
The
+BPF program receives these tasks one after another. You can specify a BPF =
task
+iterator with *tid* parameter to include only the tasks that match the giv=
en
+*tid*.
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 1bc2c5c58bdb..1a8d372b6faf 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -24,6 +24,7 @@ that goes into great technical depth about the BPF Archit=
ecture.
    maps
    bpf_prog_run
    classic_vs_extended.rst
+   bpf_iterators
    bpf_licensing
    test_debug
    other
--=20
2.30.2

