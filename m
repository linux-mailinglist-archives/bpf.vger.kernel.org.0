Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1248C2C5
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiALLDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiALLDq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 06:03:46 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A2C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:03:45 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id o1so3995833uap.4
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dOqUWFErrfWfghpJk2fxOhBmgFBMTLMEXPsWDLlzbAQ=;
        b=CxTqqzvmvMfgqZNhRnSbWVDnCdh1/pY4CkMTrq6lKP6VC66VRwjvp7AF4j5ycAP4Ok
         56FbSy3cbt7immgmMDDXg1KcyaAPf0yioHAqiH466cz8dJ0lRppqZP2mRT0i3md7USBw
         dp0ONuSu3TztTLY8+9bd+FqygPqPdtYO0lQu8acg9SFehduK5NNKA4s9Ar+f7EO+olfO
         mVNytkVr9drkhh/7ifCjTSnMfQjtKbvyTm81KNHonSz9z9QZk3x6sEA+pvKehM3zODA9
         8uoFZ6NgKoeNzBcK/VJordhzq9Iz2w49m+rSmOSTglAZZmQAbRItSNKHP0Wh7ruEG4LO
         4VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dOqUWFErrfWfghpJk2fxOhBmgFBMTLMEXPsWDLlzbAQ=;
        b=id9gRIQxCBSA92T9IWa7HitS4TvM6jMPtUJpIdFBVvd/lgGsxdp9EJ8M2/5Jw/V0KK
         Yz5eD4ry5e2kYWwI2j/j2FYypQ05kPaAZc0ATlM4f1jW4jMZxIafWCxq2GGpYFhZ7KfT
         u0162pISfkyF6ztcBsqHaaq2Z3joX0fXDDUwa5nBwNtWPx9Tx5VoQW+lf3rzX8F53bYA
         aDeWV3bPdspcSfFCBLAh9TJDrHUjZIKRUvfqxj4Z9uznIZwvOjeYp3DpadQksTzIVF7L
         rRfnESRK9W6GLczo3oxfJUD3I5oH0qIARnNgazywF2aItLtKz0cMMI65YPAgqUU46/aQ
         tXMg==
X-Gm-Message-State: AOAM533fjdrOys9dbOdLUXANffdINUhsjunxyKd/BfPYWB9B4hTtgvoH
        V0bUSA/e0Ot/tryXM74vGwVhtsDHIAkqsrcWeAGh5M8de50=
X-Google-Smtp-Source: ABdhPJzDjeRJzWOx03oXufiGfKmSI1uu/S9ayicIR27bpe9O2Ik28mmB6FMUIZMNbq1iJgYBV23WY62aeIGkXqCgPnY=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr3775634uap.56.1641985424605;
 Wed, 12 Jan 2022 03:03:44 -0800 (PST)
MIME-Version: 1.0
From:   Gabriele <phoenix1987@gmail.com>
Date:   Wed, 12 Jan 2022 11:03:33 +0000
Message-ID: <CAGnuNNtdvbk+wp8uYDPK3weGm5PVmM7hqEaD=Mg2nBT-dKtNHw@mail.gmail.com>
Subject: Proposal: bpf_copy_from_user_remote
To:     bpf <bpf@vger.kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi there

As I have mentioned in another thread
(https://lore.kernel.org/bpf/CAGnuNNt7va4u78rvPmusYnhXAuy5e9aRhEeO6HDqYUsH9=
79QLQ@mail.gmail.com/T/)
I started looking into adding a BPF wrapper around process_vm_readv to
allow BPF programs to read the userspace VM of a remote process.

Given my unfamiliarity with the code, I hope you would indulge me in
asking for feedback on my current approach to see whether it makes
sense or not. I have tried to model my change on top of the patch that
introduced bpf_copy_from_user
(https://lwn.net/ml/netdev/20200630043343.53195-4-alexei.starovoitov@gmail.=
com/)
and this is what I have got so far.

Cheers,
Gab

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
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..8af855d62a5f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3391,5 +3391,8 @@ static inline int seal_check_future_write(int
seals, struct vm_area_struct *vma)
  return 0;
 }

+extern ssize_t process_vm_read(pid_t pid, void * dst, ssize_t size,
+ const void __user * user_ptr, unsigned long flags);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
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
index 649f07623df6..0343870a8c03 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -15,6 +15,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/mm.h>

 #include "../../lib/kstrtox.h"

@@ -656,6 +657,37 @@ const struct bpf_func_proto bpf_copy_from_user_proto =
=3D {
  .arg3_type =3D ARG_ANYTHING,
 };

+BPF_CALL_4(bpf_copy_from_user_remote, void *, dst, u32, size,
+    const void __user *, user_ptr, pid_t, pid)
+{
+ int ret;
+ struct iovec local, remote;
+
+ local.iov_base =3D dst;
+ remote.iov_base =3D (void *) user_ptr;
+
+ local.iov_len =3D remote.iov_len =3D size;
+
+ ret =3D process_vm_read(pid, dst, size, user_ptr, 0);
+
+ if (unlikely(ret)) {
+ memset(dst, 0, size);
+ ret =3D -EFAULT;
+ }
+
+ return ret;
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
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 4bcc11958089..90097267b567 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -302,3 +302,12 @@ SYSCALL_DEFINE6(process_vm_writev, pid_t, pid,
 {
  return process_vm_rw(pid, lvec, liovcnt, rvec, riovcnt, flags, 1);
 }
+
+ssize_t process_vm_read(pid_t pid, void * dst, ssize_t size,
+ const void __user * user_ptr, unsigned long flags)
+{
+    struct iovec lvec =3D {.iov_base =3D dst, .iov_len =3D size};
+    struct iovec rvec =3D {.iov_base =3D (void *) user_ptr, .iov_len =3D s=
ize};
+
+ return process_vm_rw(pid, &lvec, 1, &rvec, 1, flags, 0);
+}
\ No newline at end of file

--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
