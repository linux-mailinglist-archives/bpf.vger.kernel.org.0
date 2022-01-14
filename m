Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12AD48EDBD
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiANQN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 11:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiANQN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 11:13:26 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEFC061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 08:13:26 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id c36so17656172uae.13
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1iWtPWGYSJm4Jp73zetGidx8CluhYu83Zkb07tJv8sA=;
        b=KBpwl1WT9S1KK53mLSP+bzp26MoKZ9dK0HdFxSBDStxp+AVAHnJNxaoviQgvBzYvKL
         XyJMADeqWxbztjH7fCPSNTmG5emll0A8v26nyVuSQs6e5/PFVdz/if26F//s4p7QclCO
         23SM6ryD6oMdXlGXBnIw5JujajnSJbedfQn9FaQHNXuPvl1xB3mHGC2qLOAJl3iGoei3
         X+uhewOy97e1CLt7LsTPVRxN7sBTSVyuswgAtkWToFxg5bLjEqOChHN0MRpzQWUDdzYi
         tE3fiBlUpZl5RV59UqcNgPzzBGp0LsMwiH8xfTynecSVhaIEnMr7ShMJ6y5Sx6UFOZMK
         iuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1iWtPWGYSJm4Jp73zetGidx8CluhYu83Zkb07tJv8sA=;
        b=HH0L3i2KqiUzghatRL4WJDN6416+3rhXF3kFd1JmRbcuYJEgJzzRIctPvCjnWCiBF7
         itlvfAVidWctOeOMjyd7L6mTDTuhVaKFcFVwICnqc8s+/wvrPJ6zgaDfk/CMGXV9b362
         NzkSiXiJTOBw+NBhBitPyGMk1VD8yqK2Do6VK4hiwSdDX2Xio8GhoCZ1H+HmpS5t4zyu
         ufA/53iG2XVS3SA1ToyXMD61FkPp6ZYt2yaMRAuxRFvcu9w/dmCPIjPlLRfensDHky4E
         X5gv2yxk+VrRIwJ9IU4/KZAzxS55tW31GS/nJorNXCNlXITE5yN5k+fRrULNLlVsFGKs
         H8hA==
X-Gm-Message-State: AOAM530yPmmRSpcz5uPq+hMNNaZx4tZetbvenO67QS6YpIcBXFSPXPVa
        NbmfcP+yDKviyga/g/sjPfkwcGw6eQuaET+7IiM=
X-Google-Smtp-Source: ABdhPJwk+JD7CQQVGSDLh2Ia0QttAuBlXH6s1vmRPo7mR0Hxc1pkJPPn4vYGl/+WBw83J5k268OpE6yYwuloOKIA9Jg=
X-Received: by 2002:a67:e144:: with SMTP id o4mr616373vsl.4.1642176805044;
 Fri, 14 Jan 2022 08:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAGnuNNtdvbk+wp8uYDPK3weGm5PVmM7hqEaD=Mg2nBT-dKtNHw@mail.gmail.com>
 <20220113233708.1682225-1-kennyyu@fb.com> <CAGnuNNsVxz+Cd51Es=Hd1sXvCTX7ZH4Pq0RRBmdSKgOz_vC0OQ@mail.gmail.com>
In-Reply-To: <CAGnuNNsVxz+Cd51Es=Hd1sXvCTX7ZH4Pq0RRBmdSKgOz_vC0OQ@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Fri, 14 Jan 2022 16:13:14 +0000
Message-ID: <CAGnuNNvgtfBtU5d2FJ9qhjRCQpZTTq7gibgQntt7+SUstn6VKA@mail.gmail.com>
Subject: Re: Proposal: bpf_copy_from_user_remote
To:     Kenny Yu <kennyyu@fb.com>
Cc:     ast@kernel.org, bpf <bpf@vger.kernel.org>, daniel@iogearbox.net,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have to correct myself. Looking at my notes, I actually came across
access_process_vm. However this line in the comment threw me off and I
stopped looking deeper into it

* Source/target buffer must be kernel space,

I should've read that and the function signature more carefully. I
thought this meant both source and target were supposed to be kernel
space. I switched to access_process_vm (but kept my signature) and got
something that works as intended for my use.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7a163a3146b..05060a709609 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2150,6 +2150,7 @@ extern const struct bpf_func_proto
bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
+extern const struct bpf_func_proto bpf_copy_from_user_remote_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba5af15e25f5..436c703f3a13 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4938,6 +4938,14 @@ union bpf_attr {
  * **-ENOENT** if symbol is not found.
  *
  * **-EPERM** if caller does not have permission to obtain kernel address.
+ *
+ * long bpf_copy_from_user_remote(void *dst, u32 size, const void
*user_ptr, pid_t pid)
+ * Description
+ * Read *size* bytes from user space address *user_ptr* of the prodess
+ * *pid* and store the data in *dst*. This is essentially a wrapper of
+ * **process_vm_readv**\ ().
+ * Return
+ * 0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN) \
  FN(unspec), \
@@ -5120,6 +5128,7 @@ union bpf_attr {
  FN(trace_vprintk), \
  FN(skc_to_unix_sock), \
  FN(kallsyms_lookup_name), \
+ FN(copy_from_user_remote), \
  /* */

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 649f07623df6..07e9540c6e3a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -15,6 +15,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/mm.h>

 #include "../../lib/kstrtox.h"

@@ -656,6 +657,31 @@ const struct bpf_func_proto bpf_copy_from_user_proto =
=3D {
  .arg3_type =3D ARG_ANYTHING,
 };

+BPF_CALL_4(bpf_copy_from_user_remote, void *, dst, u32, size,
+    const void __user *, user_ptr, pid_t, pid)
+{
+ struct task_struct * task;
+
+ if (unlikely(size =3D=3D 0))
+ return 0;
+
+ task =3D find_get_task_by_vpid(pid);
+ if (!task)
+ return -ESRCH;
+
+ return access_process_vm(task, (unsigned long) user_ptr, dst, size, 0);
+}
+
+const struct bpf_func_proto bpf_copy_from_user_remote_proto =3D {
+ .func =3D bpf_copy_from_user_remote,
+ .gpl_only =3D false,
+ .ret_type =3D RET_INTEGER,
+ .arg1_type =3D ARG_PTR_TO_UNINIT_MEM,
+ .arg2_type =3D ARG_CONST_SIZE_OR_ZERO,
+ .arg3_type =3D ARG_ANYTHING,
+ .arg4_type =3D ARG_ANYTHING,
+};
+
 BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 {
  if (cpu >=3D nr_cpu_ids)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ae9755037b7e..b9f27b0b62f9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1208,6 +1208,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id,
const struct bpf_prog *prog)
  return &bpf_get_branch_snapshot_proto;
  case BPF_FUNC_trace_vprintk:
  return bpf_get_trace_vprintk_proto();
+ case BPF_FUNC_copy_from_user_remote:
+ return prog->aux->sleepable ? &bpf_copy_from_user_remote_proto : NULL;
  default:
  return bpf_base_func_proto(func_id);
  }
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..bd092f1692e2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -614,6 +614,7 @@ class PrinterHelpers(Printer):
             'const struct sk_buff': 'const struct __sk_buff',
             'struct sk_msg_buff': 'struct sk_msg_md',
             'struct xdp_buff': 'struct xdp_md',
+            "pid_t": "int",
     }
     # Helpers overloaded for different context types.
     overloaded_helpers =3D [
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index ba5af15e25f5..436c703f3a13 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4938,6 +4938,14 @@ union bpf_attr {
  * **-ENOENT** if symbol is not found.
  *
  * **-EPERM** if caller does not have permission to obtain kernel address.
+ *
+ * long bpf_copy_from_user_remote(void *dst, u32 size, const void
*user_ptr, pid_t pid)
+ * Description
+ * Read *size* bytes from user space address *user_ptr* of the prodess
+ * *pid* and store the data in *dst*. This is essentially a wrapper of
+ * **process_vm_readv**\ ().
+ * Return
+ * 0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN) \
  FN(unspec), \
@@ -5120,6 +5128,7 @@ union bpf_attr {
  FN(trace_vprintk), \
  FN(skc_to_unix_sock), \
  FN(kallsyms_lookup_name), \
+ FN(copy_from_user_remote), \
  /* */

 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er

On Fri, 14 Jan 2022 at 10:00, Gabriele <phoenix1987@gmail.com> wrote:
>
> Hi Kenny
>
> Your patch series looks neat! I haven't come across access_process_vm
> during my source exploration. Indeed, passing a process descriptor
> seems like a good idea. I presume one would then use, e.g.,
> find_task_by_pid_ns to convert a pid+ns to a struct task_struct.
>
> My use cases are about general observability into runtimes like
> Python. For profiling, I would like to make a BPF version of Austin.
> There is a variant for Linux that can be used to collect native
> (including kernel) stacks (see
> https://github.com/P403n1x87/austin#native-frame-stack), but this
> works in a "traditional" way, using ptrace via libunwind. My idea is
> to implement Python stack unwinding as a BPF program so that native
> and runtime stacks could be both collected and then interleaved, like
> austinp currently does. I think that, perhaps, I'd need a sleepable
> version of the perf_event section to achieve this.
>
> I have debugging use cases for Python in mind too, in particular for
> native extensions. I believe these are similar to your C++ use cases.
> I don't expect to be needing to iterate over all running tasks, so as
> long as the new helper can be used against specific processes that can
> be identified via pid (and namespace) then I'm totally fine with your
> patch series.
>
> Cheers,
> Gab
>
> On Thu, 13 Jan 2022 at 23:37, Kenny Yu <kennyyu@fb.com> wrote:
> >
> > Hi Gabriele,
> >
> > I just submitted a patch series that adds a similar helper to read
> > userspace memory from a remote process, please see: https://lore.kernel=
.org/bpf/20220113233158.1582743-1-kennyyu@fb.com/T/#ma0646f96bccf0b95779305=
4de7404115d321079d
> >
> > In my patch series, I added a bpf helper to wrap `access_process_vm`
> > which takes a `struct task_struct` argument instead of a pid.
> >
> > In your patch series, one issue would be it is not clear which pid name=
space
> > the pid belongs to, whereas passing a `struct task_struct` is unambiguo=
us.
> > I think the helper signature in my patch series also provides more flex=
ibility,
> > as the bpf program can also provide different flags on how to read
> > userspace memory.
> >
> > Our use case at Meta for this change is to use a bpf task iterator prog=
ram
> > to read debug information from a running process in production, e.g.,
> > extract C++ async stack traces from a running program.
> >
> > A few questions:
> > * What is your use case for adding this helper?
> > * Do you have a specific requirement that requires using a pid, or woul=
d a
> >   helper using `struct task_struct` be sufficient?
> > * Are you ok with these changes? If so, I will proceed with my patch se=
ries.
> >
> > Thanks,
> > Kenny Yu
>
>
>
> --
> "Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
> cerchi, ed altre figure
> geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamen=
te parola;
> senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."
>
> -- G. Galilei, Il saggiatore.



--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
