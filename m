Return-Path: <bpf+bounces-29551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17B8C2C83
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9081C2148E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C313CF85;
	Fri, 10 May 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca4vn291"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BE13D249;
	Fri, 10 May 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379411; cv=none; b=GZUxiDYzuOBsgwtzz0Ql1cBs94sqkWIfrTE4nSWicejKEl7aWKbLBLzka6YSZ7NF99unYEEUFo8R15ZubiS7jBxglAXST7gosSSORAcXxDbhZ86VkVuVwzKbIXcDjORCYDUXmz5iU9igACnqmq42Qjyiw11AfqcBcBZWKuTm+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379411; c=relaxed/simple;
	bh=5OfmgoAYcfgbRVZam+epYxmJECo8KxPiHXd4rLSQ43k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEaHCr99Xn8wiAfaBR1o8DlhALlDIYiIc4vvjvU2JyMkGAbBwXdB/sv1el+5U3Zr/yzRhjxWGEsXkv/Omd8fXrORI3AC/KBVnqHj3n1qXlWurYG1LOMdJeF2hAmNnLL8FrRZedN8M7bf76NJzQ9iIyi0T3h5Bzjp/lkfd1Xd3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca4vn291; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso2975367276.0;
        Fri, 10 May 2024 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715379403; x=1715984203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgEWVwj9CTy6eW4Gl2DhjkJwIccLS9CHbLse7CH8+Zo=;
        b=Ca4vn291yoaDLv87+QAVyLjisMVzPi/0ALYHU44FzJiPyr8UjnITuS8jfBCsk8/PpZ
         CWASNkZX3UlKxKGsxeSJbH2p4SDt8PwuvAtVVfGmCnyIzOQAW84P6K1dGxlYqf1z1GMU
         SOu21Cg0C/DaKR12Cm3Cen8+/Pp8GqP+FtNhvaZc8uHI8S5AmiSTarp8hIY/7jL6Q/FI
         FDMWvtH8qNChCAtVTYj4ZmoHdfftO7K8zW/Qcb/g8ylKfLniYbC140qCZjKcTvDQ2W80
         ze7TLd7p1+JoTn26DIWBe81rwiR02Nxuchm2mMVnf2/1xaFooHXRKKf+e2nQhBxbPzWL
         imlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379403; x=1715984203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgEWVwj9CTy6eW4Gl2DhjkJwIccLS9CHbLse7CH8+Zo=;
        b=P9hfUZ492ZsITdhZEcQj82h+aTzkPUG0Eoq3vTGrXBqcMmnSoMYl586olxvtDdOlP+
         T++SrQuaUs9sraZHAVHEcjz+u2Rf6g8ORFCIZQP/+ADgHCvgE2CsqxowW2LDgwb4jW3x
         Tkf18ZdALOwb9ZGeLS5Se6qzFSTY8JonAqBGYez7xnk5R06+eMjZG2IYgB9hBeBrchPT
         H5SKfJxJADDk+kIzRym0uZyG/kaQH39eC8SCpot6UXh4dVRVlAYfiE16WD0jBTVLBtYN
         lLrkjtzeoylp5YWL+731Vxl1WwCauXuG5Qx3lNWh9WEU6eZRmT216aFb2lmzzH0SUUpq
         m+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUByKPgH4Me8UfiGuW6gy8IFtRUh5P7OLkjpNvE2UdKm/Yq2Qy5j4UsZ5VubgxuaDgngLEZ8uT7gaaVr2CoAVKx8p/i
X-Gm-Message-State: AOJu0YyMLU/2YDzg1eq+dHDZfkkT1VUJwU9LQOWuTAp8lx0QMblWDlpD
	8zy3GVjF7uqnAac19Q2aG4IIB5d+wtX5VL8xnE94QM7cbNBz+druKXeom/gjsgPYYazZvbTAKJW
	w40wDhuu51nFyd4ioa/FHd29I8DE=
X-Google-Smtp-Source: AGHT+IFPstVJ9zjwRj0J3D+5ZU5oYSqAiysZbBcR98SC5jP45p7avlBHDk9SXoG1rntWZTSN2yZFxZj/VxRFE1iyoGU=
X-Received: by 2002:a25:ab48:0:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-dee4f32be93mr4118871276.14.1715379403488; Fri, 10 May 2024
 15:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com> <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
In-Reply-To: <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 10 May 2024 15:16:32 -0700
Message-ID: <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:33=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 5/10/24 12:23, Amery Hung wrote:
> > A reference is automatically acquired for a referenced kptr argument
> > annotated via the stub function with "__ref_acquired" in a struct_ops
> > program. It must be released and cannot be acquired more than once.
> >
> > The test first checks whether a reference to the correct type is acquir=
ed
> > in "ref_acquire". Then, we check if the verifier correctly rejects the
> > program that fails to release the reference (i.e., reference leak) in
> > "ref_acquire_ref_leak". Finally, we check if the reference can be only
> > acquired once through the argument in "ref_acquire_dup_ref".
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 +++
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
> >   .../prog_tests/test_struct_ops_ref_acquire.c  | 58 ++++++++++++++++++=
+
> >   .../bpf/progs/struct_ops_ref_acquire.c        | 27 +++++++++
> >   .../progs/struct_ops_ref_acquire_dup_ref.c    | 24 ++++++++
> >   .../progs/struct_ops_ref_acquire_ref_leak.c   | 19 ++++++
> >   6 files changed, 137 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct=
_ops_ref_acquire.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_a=
cquire.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_a=
cquire_dup_ref.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_a=
cquire_ref_leak.c
> >
> >
>   ... skipped ...
> > +
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c=
 b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
> > new file mode 100644
> > index 000000000000..bae342db0fdb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
> > @@ -0,0 +1,27 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +/* This is a test BPF program that uses struct_ops to access a referen=
ced
> > + * kptr argument. This is a test for the verifier to ensure that it re=
congnizes
> > + * the task as a referenced object (i.e., ref_obj_id > 0).
> > + */
> > +SEC("struct_ops/test_ref_acquire")
> > +int BPF_PROG(test_ref_acquire, int dummy,
> > +          struct task_struct *task)
> > +{
> > +     bpf_task_release(task);
>
> This looks weird for me.
>
> According to what you mentioned in the patch 1, the purpose is to
> prevent acquiring multiple references from happening. So, is it possible
> to return NULL from the acquire function if having returned a reference
> before?

The purpose of req_acquired is to allow acquiring a referenced kptr in
struct_ops argument just once. Whether multiple references can be
acquired/duplicated later I think could be orthogonal.

In bpf qdisc, we ensure unique reference of skb through ref_acquired and
the fact that there is no bpf_ref_count in sk_buff (so that users cannot
use bpf_ref_acquire()).

In this case, it is true that programs like below will be able to get
multiple references to task (Is this the scenario you have in mind?).
Thus, if the users want to enforce the unique reference semantic, they
need to make bpf_task_acquire() unavailable as well.

SEC("struct_ops/test_ref_acquire")
int BPF_PROG(test_ref_acquire, int dummy,
             struct task_struct *task)
{
        struct task_struct task2;
        task2 =3D bpf_task_acquire(task);
        bpf_task_release(task);
        if (task2)
            bpf_task_release(task2);
        return 0;
}


>
>
> > +
> > +     return 0;
> > +}
> > +
> > +
> ... skipped ...

