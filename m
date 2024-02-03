Return-Path: <bpf+bounces-21117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399BE847DB4
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4B52835FE
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B79643;
	Sat,  3 Feb 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7ke0U8J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D1625
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919727; cv=none; b=WSGLaYt2nEiQ49qVHD6egDG287ZKBO6/HZQS0DM+ZMSbUOPwnNOrwgFHGxCWViTqQODhxZXrmWFEbHppLLtJsuzMn6u5+4QcM4EbFGh5kQZe5kk4taPuEMc4GShx75/RjKt9rgc9qvQZwZNLszLfohj1fJoiz9M52uTFbiN2xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919727; c=relaxed/simple;
	bh=ka6J180fZTCuKeVMW/9Lbes9FAwuvrieXc1rcE/q/LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+E0Lfx8gjRG+hF/VZOp1EKNt6mtUl50UmoYaK6n6JiXqubkt+NKcdf4P9SsF/fD21nivjsB6ys4ANvxZ3n1hoM5fEvY1hJgJvk8RFgbpKIqi9x2b/3uC0L+dmYllpSj4JmObIuiULIXIcjHNhbDDxYOT92VqahAeKzxZ5gRUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7ke0U8J; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so2553040276.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 16:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706919724; x=1707524524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7dJk4z2Z5q7wX3PPd0H8+PQcX8ae1Pm/5cSfdvjye7Y=;
        b=V7ke0U8JjUN/f1obOO36qBMtDkSFV6rVYJcrZSFT7xcq8Z+Xhfef8v0gmRGG9pmyU9
         RIXqGA4YIVeLTMyE+yhCm/sA0jwK7Pe9ZbrDs4XIUS1RWiGAF2u4gfcw83ADikSM8qXK
         95u5y+huFKJM6FvIxlGmQeQdpGEnCv92NSJC7EF2RflSlNSKVlYuYIVWHATK9QLjVKP2
         jm3Q/tTDrFNktolcN/S54BqXwc/EH/6cVZhX+O2dih11jBCUJRpFqQRZ/jKtnyBr1rgp
         wwtsA3QHAuFRDjxeDIb7db/zk+BaVYOwRH3kmZBmMeQjeUwZ+lJwLSCE+3scDIozDwWW
         TYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919724; x=1707524524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dJk4z2Z5q7wX3PPd0H8+PQcX8ae1Pm/5cSfdvjye7Y=;
        b=JX1fEnUX/LdlQkQJ8KU4SMmZAGTAR9v1LM3SuAeI4a9eWTuISJVwfcBtp0s2Z9Toey
         ugrTFlsWonI1VERbZVkPBgoRw60JYysaOwhPvsd59Gtg3j5q5uMdeYEivbuiC0m/OR0U
         XmKKD7v6hpisBKJYG+hRAhQOZhNqu8ovVcDFdCKKse/8C7zB5eATU4xlSiHCOHv3mrg8
         BhlPuDqeRD80WI3lHYYrW58/RzuFE+WDDuVSPfHSgRYIA1gR2FND91npvlS9Kd1C1Odq
         33G8IVu//85VZd33S2H2cgAKEMpVfDdeLmm48zAFVrRwpbak1ra2XY+4OrRv1qz9urjc
         LUDg==
X-Gm-Message-State: AOJu0YxfGuH5H2dja0jGbXJLdUJj3kUkICZ87e2+k51WVA3YpeDs+IeD
	+jkOSP+iZAr9hm5k6PNb9Mjj/QtNJt+L6Y9k5dfPtb6y1LvWPieZgvv4K61VxyJpH9Pkb0zx8AP
	k9PZfM/h971+wPAtU9++FOWqDqOk=
X-Google-Smtp-Source: AGHT+IH+vL3ThT8Jhri/kHq4SditG6yMO1Y8ScSvshCcl4WDfyhhVj9cVojsAaxtRFi7kw3Z2hqm9LdMfCqHFrem3F8=
X-Received: by 2002:a5b:941:0:b0:dc6:2e29:4262 with SMTP id
 x1-20020a5b0941000000b00dc62e294262mr9472053ybq.58.1706919724220; Fri, 02 Feb
 2024 16:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>
 <ZbjAod-tqcjQJrTo@krava>
In-Reply-To: <ZbjAod-tqcjQJrTo@krava>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 2 Feb 2024 19:21:53 -0500
Message-ID: <CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: Prevent recursive deadlocks in BPF programs
 attached to spin lock helpers using fentry/ fexit
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"Williams, Dan" <djwillia@vt.edu>, "Somaraju, Sai Roop" <sairoop@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>, 
	"Craun, Milo" <miloc@vt.edu>, "sidchintamaneni@vt.edu" <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 04:25, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jan 24, 2024 at 10:43:32AM -0500, Siddharth Chintamaneni wrote:
> > While we were working on some experiments with BPF trampoline, we came
> > across a deadlock scenario that could happen.
> >
> > A deadlock happens when two nested BPF programs tries to acquire the
> > same lock i.e, If a BPF program is attached using fexit to
> > bpf_spin_lock or using a fentry to bpf_spin_unlock, and it then
> > attempts to acquire the same lock as the previous BPF program, a
> > deadlock situation arises.
> >
> > Here is an example:
> >
> > SEC(fentry/bpf_spin_unlock)
> > int fentry_2{
> >   bpf_spin_lock(&x->lock);
> >   bpf_spin_unlock(&x->lock);
> > }
> >
> > SEC(fentry/xxx)
> > int fentry_1{
> >   bpf_spin_lock(&x->lock);
> >   bpf_spin_unlock(&x->lock);
> > }
>
> hi,
> looks like valid issue, could you add selftest for that?

Hello,
I have added selftest for the deadlock scenario.

>
> I wonder we could restrict just programs that use bpf_spin_lock/bpf_spin_unlock
> helpers? I'm not sure there's any useful use case for tracing spin lock helpers,
> but I think we should at least try this before we deny it completely
>

If we restrict programs (attached to spinlock helpers) that use
bpf_spin_lock/unlock helpers, there could be a scenario where a helper
function called within the program has a BPF program attached that
tries to acquire the same lock.

> >
> > To prevent these cases, a simple fix could be adding these helpers to
> > denylist in the verifier. This fix will prevent the BPF programs from
> > being loaded by the verifier.
> >
> > previously, a similar solution was proposed to prevent recursion.
> > https://lore.kernel.org/lkml/20230417154737.12740-2-laoar.shao@gmail.com/
>
> the difference is that __rcu_read_lock/__rcu_read_unlock are called unconditionally
> (always) when executing bpf tracing probe, the problem you described above is only
> for programs calling spin lock helpers (on same spin lock)
>
> >
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > ---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 65f598694d55..8f1834f27f81 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
> >  BTF_ID(func, __rcu_read_lock)
> >  BTF_ID(func, __rcu_read_unlock)
> >  #endif
> > +#if defined(CONFIG_DYNAMIC_FTRACE)
>
> why the CONFIG_DYNAMIC_FTRACE dependency?
As we described in the self-tests, nesting of multiple BPF programs
could only happen with fentry/fexit programs when DYNAMIC_FTRACE is
enabled. In other scenarios, when DYNAMIC_FTRACE is disabled, a BPF
program cannot be attached to any helper functions.
>
> jirka
>
> > +BTF_ID(func, bpf_spin_lock)
> > +BTF_ID(func, bpf_spin_unlock)
> > +#endif
> >  BTF_SET_END(btf_id_deny)
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..ffc2515195f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
 #endif
+#ifdef CONFIG_DYNAMIC_FTRACE
+BTF_ID(func, bpf_spin_lock)
+BTF_ID(func, bpf_spin_unlock)
+#endif
 BTF_SET_END(btf_id_deny)

 static bool can_be_sleepable(struct bpf_prog *prog)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_dead_lock.c
b/tools/testing/selftests/bpf/prog_tests/test_dead_lock.c
new file mode 100644
index 000000000000..8e2db654e963
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_dead_lock.c
@@ -0,0 +1,26 @@
+#include <test_progs.h>
+#include "test_dead_lock.skel.h"
+
+void test_dead_lock_fail(void){
+ struct test_dead_lock *skel;
+ int prog_fd;
+ int err;
+
+ LIBBPF_OPTS(bpf_test_run_opts, topts);
+ skel = test_dead_lock__open_and_load();
+ if(!ASSERT_OK_PTR(skel, "test_dead_lock__open_and_load"))
+ goto end;
+
+ err = test_dead_lock__attach(skel);
+ if (!ASSERT_OK(err, "test_dead_lock_attach"))
+ goto end;
+
+ prog_fd = bpf_program__fd(skel->progs.dead_lock_test_main);
+ err = bpf_prog_test_run_opts(prog_fd, &topts);
+ ASSERT_OK(err, "test_run");
+ ASSERT_EQ(topts.retval, 0, "test_run");
+
+end:
+ test_dead_lock__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_dead_lock.c
b/tools/testing/selftests/bpf/progs/test_dead_lock.c
new file mode 100644
index 000000000000..72c6a0b033c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dead_lock.c
@@ -0,0 +1,80 @@
+#include <linux/bpf.h>
+#include <linux/version.h>
+#include <bpf/bpf_helpers.h>
+
+struct hmap_elem {
+ int cnt;
+ struct bpf_spin_lock lock;
+};
+
+struct {
+ __uint(type, BPF_MAP_TYPE_HASH);
+ __uint(max_entries, 1);
+ __type(key, int);
+ __type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+SEC("fexit/bpf_spin_lock")
+int dead_lock_test_inner1(void *ctx){
+
+ struct hmap_elem *val;
+ int key = 1;
+ int err = 0;
+
+ val = bpf_map_lookup_elem(&hmap, &key);
+ if (!val) {
+ goto err;
+ }
+
+ bpf_spin_lock(&val->lock);
+ val->cnt++;
+ bpf_spin_unlock(&val->lock);
+
+err:
+ return err;
+}
+
+SEC("fentry/bpf_spin_unlock")
+int dead_lock_test_inner2(void *ctx){
+
+ struct hmap_elem *val;
+ int key = 1;
+ int err = 0;
+
+ val = bpf_map_lookup_elem(&hmap, &key);
+ if (!val) {
+ goto err;
+ }
+
+ bpf_spin_lock(&val->lock);
+ val->cnt++;
+ bpf_spin_unlock(&val->lock);
+
+err:
+ return err;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int dead_lock_test_main(void *ctx){
+
+ struct hmap_elem nval = {} ,*val;
+ int key = 1;
+ int err = 0;
+
+ val = bpf_map_lookup_elem(&hmap, &key);
+ if (!val) {
+ bpf_map_update_elem(&hmap, &key, &nval, 0);
+ val = bpf_map_lookup_elem(&hmap, &key);
+ if (!val) {
+ goto err;
+ }
+ }
+
+ bpf_spin_lock(&val->lock);
+ val->cnt++;
+ bpf_spin_unlock(&val->lock);
+err:
+ return err;
+}
+
+char _license[] SEC("license") = "GPL";

