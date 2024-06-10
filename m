Return-Path: <bpf+bounces-31750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CBC902AA3
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C1B1F229B3
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148474410;
	Mon, 10 Jun 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJGsVmyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02795558A5
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055209; cv=none; b=UnRATvF6neagn8YA+UBDonAHEAatktUqVbVDXMlJXWDTNcU84VvM9usPE++IkTWe/QVN+XEyGKgry3RHXUH8bXlXJicPLGixMmeDlL0ODeeZ0iXEZWUwupA5u062UUQsMFk/eWnHQLOzfFnj1qpC4GraSCzRvFSPkn4mI4AtDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055209; c=relaxed/simple;
	bh=0yBu0GixRXi4Ppeqwbh5M4bwKPiAv3KfPRnL1nr9SJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsjWmZyqeegLBeGdce7E0TorXZIATcBAuH8ZR5nQj0NEkunrJWqV2XGyJVQKoA/vuSMIMH8n+AFOzGL6RzN+uEzHZ8n6+nXaLE6zTsMrWfwXFDnxPyGExJ9HX+tzjmoXxtgTEk0xk3CkZ4QY3oYbqlm2i6bWkkygj4zwNQ4a6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJGsVmyn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405cf01a7fso44781cf.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718055206; x=1718660006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/1MZYkvJqGzXwxdxyKaiV/jOC5GN5vlXbEcMG/wWjo=;
        b=YJGsVmynJJtxmsp/Q1yx7d5kh7BZSBu5xnF1kpogxfrEgbfmLbtFY8E1FZkWqtjH1V
         8CCvJVIMcq0HjtrbA+7YnB7fQywT6Seto0CRAaNRgXHDGgNiH2KzeVXLQHpHUZhudpVY
         Seifi8i9VvYw6RbBc4j5oxKBk4gMuK4fdGUhnyt9m/x+7/5CXpRn2E7Fzp5q8Xjf5lUN
         NMqOjup3IVfBJ5tcnKCNp6LwYCDZyt/EayQ/bE+OBEIw9FL9K6KDduD9IHjE9P1Hi1Z8
         6XVghQYJeZUHTu4NTWjTJ3m1uucDujfbyeQEvFLzaEL7+jgXW6EI2LjcZexecwd2AhM+
         rkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718055206; x=1718660006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/1MZYkvJqGzXwxdxyKaiV/jOC5GN5vlXbEcMG/wWjo=;
        b=g/AMBrWqqvZ+Jl43WRbxYDfrIgoKT2N0AbaeEUS/ajB3NA12diyCdW5mKBIo8kDeEk
         KmMNAxET2fR+Opyy51vNzKGcir6sitpNBjCFaemyQAWPgR3JicE3F9UQ6VYiWkQvNmti
         QEOAvze1ZkZjHUvjC8ItpWuYcLq8vJ/2J8vqOoua2FGbxU3gncdvB2kZeL9FBa40p9J2
         7zmNskHnW9etBdBclG1gOT+vPeqfvDiJ38mWVCulbFJnnH7UMBkKXmJ8f/oKz8L9h7oo
         Vhf0/+PYh5VFEfyqEu0UIK/O3C3CG23ql1jMj/2U3JdoS9nUTnyyR4Ya1VBV/AZ7rddZ
         CKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUSQGb7OCUOU04WAH2BjQ/XHts1MaDTOabIu09rMlz6jTAxbQv1qGmocVX4RIc74KDKH1RGWj0luh8rzqulpSZHJoZe
X-Gm-Message-State: AOJu0Yz+XT5/Ywsatpe+tEF2jQpqWHM8x03xs2eEbdTJv+BQItINp93E
	i/+Q+sx28iP209454IwPtsn5wrp+eIvQn0L1htpPaBzFxw5lZHJkX1XwXF6Cg3Oxern9/MgoNNG
	aKSxFsDhTcpKbVkxenD7ovAw9A24TjbP7xwlV
X-Google-Smtp-Source: AGHT+IE2oVD7QAe0nD/gru3sJCBjYJQssg/NRVaZrMCqHZ96jYj3WmoKmOINKGmHa8llrdJDzXC5Q+nKjyn8PK92kgE=
X-Received: by 2002:a05:622a:4114:b0:440:5441:56bf with SMTP id
 d75a77b69052e-4413ec32cd5mr1245251cf.0.1718055205534; Mon, 10 Jun 2024
 14:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172147.2779890-1-howardchu95@gmail.com>
In-Reply-To: <20240608172147.2779890-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Jun 2024 14:33:10 -0700
Message-ID: <CAP-5=fVW0coox1KFpoVTq5wf54yyppM0JgXNT5mLfLOCX_Jugg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mic@digikod.net, gnoack@google.com, brauner@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 10:21=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> This is a bug found when implementing pretty-printing for the
> landlock_add_rule system call, I decided to send this patch separately
> because this is a serious bug that should be fixed fast.
>
> I wrote a test program to do landlock_add_rule syscall in a loop,
> yet perf trace -e landlock_add_rule freezes, giving no output.
>
> This bug is introduced by the false understanding of the variable "key"
> below:
> ```
> for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
>         struct syscall *sc =3D trace__syscall_info(trace, NULL, key);
>         ...
> }
> ```
> The code above seems right at the beginning, but when looking at
> syscalltbl.c, I found these lines:
>
> ```
> for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
>         if (syscalltbl_native[i])
>                 ++nr_entries;
>
> entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct syscall) * nr_=
entries);
> ...
>
> for (i =3D 0, j =3D 0; i <=3D syscalltbl_native_max_id; ++i) {
>         if (syscalltbl_native[i]) {
>                 entries[j].name =3D syscalltbl_native[i];
>                 entries[j].id =3D i;
>                 ++j;
>         }
> }
> ```
>
> meaning the key is merely an index to traverse the syscall table,
> instead of the actual syscall id for this particular syscall.


Thanks Howard, I'm not following this. Doesn't it make sense to use
the syscall number as its id?

>
>
> So if one uses key to do trace__syscall_info(trace, NULL, key), because
> key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
> my X86_64 machine, this number is 373, it will end up neglecting all
> the rest of the syscall, in my case, everything after `rseq`, because
> the traversal will stop at 373, and `rseq` is the last syscall whose id
> is lower than 373
>
> in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
> ```
>         ...
>         [334] =3D "rseq",
>         [424] =3D "pidfd_send_signal",
>         ...
> ```
>
> The reason why the key is scrambled but perf trace works well is that
> key is used in trace__syscall_info(trace, NULL, key) to do
> trace->syscalls.table[id], this makes sure that the struct syscall return=
ed
> actually has an id the same value as key, making the later bpf_prog
> matching all correct.


Could we create a test for this? We have tests that list all perf
events and then running a perf command on them. It wouldn't be
possible to guarantee output.

>
> After fixing this bug, I can do perf trace on 38 more syscalls, and
> because more syscalls are visible, we get 8 more syscalls that can be
> augmented.
>
> before:
>
> perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "open" BPF sys_enter augmenter for "access"
> Reusing "connect" BPF sys_enter augmenter for "accept"
> Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> Reusing "connect" BPF sys_enter augmenter for "bind"
> Reusing "connect" BPF sys_enter augmenter for "getsockname"
> Reusing "connect" BPF sys_enter augmenter for "getpeername"
> Reusing "open" BPF sys_enter augmenter for "execve"
> Reusing "open" BPF sys_enter augmenter for "truncate"
> Reusing "open" BPF sys_enter augmenter for "chdir"
> Reusing "open" BPF sys_enter augmenter for "mkdir"
> Reusing "open" BPF sys_enter augmenter for "rmdir"
> Reusing "open" BPF sys_enter augmenter for "creat"
> Reusing "open" BPF sys_enter augmenter for "link"
> Reusing "open" BPF sys_enter augmenter for "unlink"
> Reusing "open" BPF sys_enter augmenter for "symlink"
> Reusing "open" BPF sys_enter augmenter for "readlink"
> Reusing "open" BPF sys_enter augmenter for "chmod"
> Reusing "open" BPF sys_enter augmenter for "chown"
> Reusing "open" BPF sys_enter augmenter for "lchown"
> Reusing "open" BPF sys_enter augmenter for "mknod"
> Reusing "open" BPF sys_enter augmenter for "statfs"
> Reusing "open" BPF sys_enter augmenter for "pivot_root"
> Reusing "open" BPF sys_enter augmenter for "chroot"
> Reusing "open" BPF sys_enter augmenter for "acct"
> Reusing "open" BPF sys_enter augmenter for "swapon"
> Reusing "open" BPF sys_enter augmenter for "swapoff"
> Reusing "open" BPF sys_enter augmenter for "delete_module"
> Reusing "open" BPF sys_enter augmenter for "setxattr"
> Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> Reusing "open" BPF sys_enter augmenter for "getxattr"
> Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> Reusing "open" BPF sys_enter augmenter for "listxattr"
> Reusing "open" BPF sys_enter augmenter for "llistxattr"
> Reusing "open" BPF sys_enter augmenter for "removexattr"
> Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> Reusing "open" BPF sys_enter augmenter for "mq_open"
> Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> Reusing "open" BPF sys_enter augmenter for "symlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> Reusing "connect" BPF sys_enter augmenter for "accept4"
> Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> Reusing "open" BPF sys_enter augmenter for "memfd_create"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
>
> after
>
> perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "open" BPF sys_enter augmenter for "access"
> Reusing "connect" BPF sys_enter augmenter for "accept"
> Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> Reusing "connect" BPF sys_enter augmenter for "bind"
> Reusing "connect" BPF sys_enter augmenter for "getsockname"
> Reusing "connect" BPF sys_enter augmenter for "getpeername"
> Reusing "open" BPF sys_enter augmenter for "execve"
> Reusing "open" BPF sys_enter augmenter for "truncate"
> Reusing "open" BPF sys_enter augmenter for "chdir"
> Reusing "open" BPF sys_enter augmenter for "mkdir"
> Reusing "open" BPF sys_enter augmenter for "rmdir"
> Reusing "open" BPF sys_enter augmenter for "creat"
> Reusing "open" BPF sys_enter augmenter for "link"
> Reusing "open" BPF sys_enter augmenter for "unlink"
> Reusing "open" BPF sys_enter augmenter for "symlink"
> Reusing "open" BPF sys_enter augmenter for "readlink"
> Reusing "open" BPF sys_enter augmenter for "chmod"
> Reusing "open" BPF sys_enter augmenter for "chown"
> Reusing "open" BPF sys_enter augmenter for "lchown"
> Reusing "open" BPF sys_enter augmenter for "mknod"
> Reusing "open" BPF sys_enter augmenter for "statfs"
> Reusing "open" BPF sys_enter augmenter for "pivot_root"
> Reusing "open" BPF sys_enter augmenter for "chroot"
> Reusing "open" BPF sys_enter augmenter for "acct"
> Reusing "open" BPF sys_enter augmenter for "swapon"
> Reusing "open" BPF sys_enter augmenter for "swapoff"
> Reusing "open" BPF sys_enter augmenter for "delete_module"
> Reusing "open" BPF sys_enter augmenter for "setxattr"
> Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> Reusing "open" BPF sys_enter augmenter for "getxattr"
> Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> Reusing "open" BPF sys_enter augmenter for "listxattr"
> Reusing "open" BPF sys_enter augmenter for "llistxattr"
> Reusing "open" BPF sys_enter augmenter for "removexattr"
> Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> Reusing "open" BPF sys_enter augmenter for "mq_open"
> Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> Reusing "open" BPF sys_enter augmenter for "symlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> Reusing "connect" BPF sys_enter augmenter for "accept4"
> Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> Reusing "open" BPF sys_enter augmenter for "memfd_create"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
>
> TL;DR:
>
> These are the new syscalls that can be augmented
> Reusing "openat" BPF sys_enter augmenter for "open_tree"
> Reusing "openat" BPF sys_enter augmenter for "openat2"
> Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
> Reusing "openat" BPF sys_enter augmenter for "move_mount"
> Reusing "open" BPF sys_enter augmenter for "fsopen"
> Reusing "openat" BPF sys_enter augmenter for "fspick"
> Reusing "openat" BPF sys_enter augmenter for "faccessat2"
> Reusing "openat" BPF sys_enter augmenter for "fchmodat2"
>
> as for the perf trace output:
>
> before
>
> perf $ perf trace -e faccessat2 --max-events=3D1
> [no output]
>
> after
>
> perf $ ./perf trace -e faccessat2 --max-events=3D1
>      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent"=
)                               =3D 0
>
> P.S. The reason why this bug was not found in the past five years is
> probably because it only happens to the newer syscalls whose id is
> greater, for instance, faccessat2 of id 439, which not a lot of people
> care about when using perf trace.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c   | 32 +++++++++++++++++++++-----------
>  tools/perf/util/syscalltbl.c | 21 +++++++++------------
>  tools/perf/util/syscalltbl.h |  5 +++++
>  3 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c42bc608954e..5cbe1748911d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3354,7 +3354,8 @@ static int trace__bpf_prog_sys_exit_fd(struct trace=
 *trace, int id)
>  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trac=
e *trace, struct syscall *sc)
>  {
>         struct tep_format_field *field, *candidate_field;
> -       int id;
> +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
> +       int id, _id;
>
>         /*
>          * We're only interested in syscalls that have a pointer:
> @@ -3368,10 +3369,13 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
>
>  try_to_find_pair:
>         for (id =3D 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
> -               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 id);
> +               struct syscall *pair;
>                 struct bpf_program *pair_prog;
>                 bool is_candidate =3D false;
>
> +               _id =3D scs[id].id;
> +               pair =3D trace__syscall_info(trace, NULL, _id);
> +
>                 if (pair =3D=3D NULL || pair =3D=3D sc ||
>                     pair->bpf_prog.sys_enter =3D=3D trace->skel->progs.sy=
scall_unaugmented)
>                         continue;
> @@ -3456,23 +3460,26 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
>  {
>         int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
nter);
>         int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
xit);
> -       int err =3D 0, key;
> +       int err =3D 0, key, id;
> +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
>
>         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
>                 int prog_fd;
>
> -               if (!trace__syscall_enabled(trace, key))
> +               id =3D scs[key].id;
> +
> +               if (!trace__syscall_enabled(trace, id))
>                         continue;
>
> -               trace__init_syscall_bpf_progs(trace, key);
> +               trace__init_syscall_bpf_progs(trace, id);
>
>                 // It'll get at least the "!raw_syscalls:unaugmented"
> -               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, key);
> -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_fd,=
 BPF_ANY);
> +               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, id);
> +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd, =
BPF_ANY);
>                 if (err)
>                         break;
> -               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, key);
> -               err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd, =
BPF_ANY);
> +               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, id);
> +               err =3D bpf_map_update_elem(map_exit_fd, &id, &prog_fd, B=
PF_ANY);
>                 if (err)
>                         break;
>         }
> @@ -3506,10 +3513,13 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
>          * array tail call, then that one will be used.
>          */
>         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> -               struct syscall *sc =3D trace__syscall_info(trace, NULL, k=
ey);
> +               struct syscall *sc;
>                 struct bpf_program *pair_prog;
>                 int prog_fd;
>
> +               id =3D scs[key].id;
> +               sc =3D trace__syscall_info(trace, NULL, id);
> +
>                 if (sc =3D=3D NULL || sc->bpf_prog.sys_enter =3D=3D NULL)
>                         continue;
>
> @@ -3535,7 +3545,7 @@ static int trace__init_syscalls_bpf_prog_array_maps=
(struct trace *trace)
>                  * with the fd for the program we're reusing:
>                  */
>                 prog_fd =3D bpf_program__fd(sc->bpf_prog.sys_enter);
> -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_fd,=
 BPF_ANY);
> +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd, =
BPF_ANY);
>                 if (err)
>                         break;
>         }
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 63be7b58761d..16aa886c40f0 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -44,22 +44,17 @@ const int syscalltbl_native_max_id =3D SYSCALLTBL_LOO=
NGARCH_MAX_ID;
>  static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
>  #endif
>
> -struct syscall {
> -       int id;
> -       const char *name;
> -};
> -
>  static int syscallcmpname(const void *vkey, const void *ventry)
>  {
>         const char *key =3D vkey;
> -       const struct syscall *entry =3D ventry;
> +       const struct __syscall *entry =3D ventry;
>
>         return strcmp(key, entry->name);
>  }
>
>  static int syscallcmp(const void *va, const void *vb)
>  {
> -       const struct syscall *a =3D va, *b =3D vb;
> +       const struct __syscall *a =3D va, *b =3D vb;
>
>         return strcmp(a->name, b->name);
>  }
> @@ -67,13 +62,14 @@ static int syscallcmp(const void *va, const void *vb)
>  static int syscalltbl__init_native(struct syscalltbl *tbl)
>  {
>         int nr_entries =3D 0, i, j;
> -       struct syscall *entries;
> +       struct __syscall *entries;
>
>         for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
>                 if (syscalltbl_native[i])
>                         ++nr_entries;
>
> -       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct syscal=
l) * nr_entries);
> +       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct __sysc=
all) *
> +                                                nr_entries);
>         if (tbl->syscalls.entries =3D=3D NULL)
>                 return -1;
>
> @@ -85,7 +81,8 @@ static int syscalltbl__init_native(struct syscalltbl *t=
bl)
>                 }
>         }
>
> -       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), =
syscallcmp);
> +       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct __syscall)=
,
> +             syscallcmp);
>         tbl->syscalls.nr_entries =3D nr_entries;
>         tbl->syscalls.max_id     =3D syscalltbl_native_max_id;
>         return 0;
> @@ -116,7 +113,7 @@ const char *syscalltbl__name(const struct syscalltbl =
*tbl __maybe_unused, int id
>
>  int syscalltbl__id(struct syscalltbl *tbl, const char *name)
>  {
> -       struct syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> +       struct __syscall *sc =3D bsearch(name, tbl->syscalls.entries,
>                                      tbl->syscalls.nr_entries, sizeof(*sc=
),
>                                      syscallcmpname);
>
> @@ -126,7 +123,7 @@ int syscalltbl__id(struct syscalltbl *tbl, const char=
 *name)
>  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *sy=
scall_glob, int *idx)
>  {
>         int i;
> -       struct syscall *syscalls =3D tbl->syscalls.entries;
> +       struct __syscall *syscalls =3D tbl->syscalls.entries;
>
>         for (i =3D *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
>                 if (strglobmatch(syscalls[i].name, syscall_glob)) {
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index a41d2ca9e4ae..6e93a0874c40 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -2,6 +2,11 @@
>  #ifndef __PERF_SYSCALLTBL_H
>  #define __PERF_SYSCALLTBL_H
>

It'd be  nice to document the struct with examples that explain the
confusion that's happened and is fixed here.

Thanks,
Ian

> +struct __syscall {
> +       int id;
> +       const char *name;
> +};
> +
>  struct syscalltbl {
>         int audit_machine;
>         struct {
> --
> 2.45.2
>

