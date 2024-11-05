Return-Path: <bpf+bounces-44007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3F9BC456
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709541F220CE
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF771B3928;
	Tue,  5 Nov 2024 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkZia9dv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559C18E363
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780921; cv=none; b=mCEFzAk4My5Hkhs/ZwAm9MO5fA3ZzTTb/kJOe4LcNa9Oqu6Khm8rNikwSpO1NCbMXZnJ2yF6Hm8/rSAWJfvex/lovIvhVZYoL0uHb8Ts9fuwaYZk1ZB8JtehHaV7bdYSdRP02pJrcFPDGwzJzWtVR4b0OAPI0ZWV9kQYBSTY2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780921; c=relaxed/simple;
	bh=sPucVRogZDgtmadqgr/cQ9HAetPAiv9rl3/7hvt9lrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etfPPxsTt9/CR8gZQAp6/WeH5QFuGGC8VnY3tDgqJpdYe4hBrZTV0xD8WxvWizzju5Wr3gFVdpCN4gR+TY8hMziz1IRJIiC7gjqeXmUE/UE2pZypi/mUN3C3btrMt/ZiYzWwYmHK6ej74ygQmWDXmVM7F1m60L7XbS6N94QYIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkZia9dv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431ac30d379so40939985e9.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 20:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730780918; x=1731385718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHlpuAcYG+nubV+n3OTk9FM/KABOdoszyNxpu1kMLEc=;
        b=kkZia9dvJJVyxanu1hmylk+oie/HvJ4NcIrhw98GUJifq129J3dgWDX2ScbBAYc4/9
         TA83ZWIwUDMKPEvbYg/P5fIvwxUZl7EhLSrwY3ycM3aTMySnaEB9GdPmZE0B37rmIRed
         Ehk5ogNoSEvtOZlM1KhfehMNBq+SPIL51aB0bjDHe4QocTU6X43aOpMFOPPm8ccZk1y6
         uoYhOq/IMBnzRmQrmQZ16yzgEWIhcmsrK33pKMhEr6ZeuSzmB0YSw0+tXUk5AFnAtzC3
         7kEwIry9bKV7D8Gpv0RE2qqhRpdCrV4DW/Onm57s38G/gEh1y+kfjWt1MYmTrTK6pRWs
         reWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780918; x=1731385718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHlpuAcYG+nubV+n3OTk9FM/KABOdoszyNxpu1kMLEc=;
        b=H5jCOXgFVeDrSBDZHb5MgcWmzeO7CIdLKqSjvlC2NtndNi+yypVBPtskMYRytvqweT
         OOKgcCAMTfDQt5fuMbP2TfY+gPx+W8xcnouRI+zgf16Edl9Hix7ywUDLmcz9oTj5lDYY
         xpBRNsojbK/mJ6BhqaJmeGs/DOvS52HeXde09dwVJ56CAP0rAB1wUY6UO60TmJToP9Mq
         K0rdm6lFTnYgu+mccKWwebm3P/twTaLQR7BBjGMB2rSFvb7VA0dnPqV9PtCaWxVQN+6m
         wunMN/6aFvSNiduR4f1N7nWbwzbTDm8HzYTo3uge5JAkosI0VH5Lo7Sy1nELmL1zuZFp
         0/vQ==
X-Gm-Message-State: AOJu0YyEBv4ZsI87pPZyYPpb0ZIp4oXK71jGYQE4VfcvsSTEFtNqzzEp
	vsNgfqxt5PVL/ZQvehHtNiu9Wwcj8UkrLaBgPI0btQzpkp7Mw+OhpiwQLuTD6fASan6nzQZ6HsT
	+ZLOsD6zeywygpa9IELKKJ6sB3So=
X-Google-Smtp-Source: AGHT+IE3zT6YrNnLxD2YCJoYXcmc3Op4vjQ988sbqxHPG7xhKAVyKsotJiJs+9KvLGsssr8iB6Qh+MVB6nhc8b4yg1o=
X-Received: by 2002:a5d:6083:0:b0:37d:2db5:b50c with SMTP id
 ffacd0b85a97d-380610f2d67mr22589526f8f.8.1730780917801; Mon, 04 Nov 2024
 20:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev> <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev> <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev> <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
In-Reply-To: <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 20:28:26 -0800
Message-ID: <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:50=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 11/4/24 6:53 PM, Yonghong Song wrote:
> >
> > On 11/4/24 5:55 PM, Alexei Starovoitov wrote:
> >> On Mon, Nov 4, 2024 at 5:35=E2=80=AFPM Yonghong Song
> >> <yonghong.song@linux.dev> wrote:
> >>>
> >>> On 11/4/24 5:21 PM, Alexei Starovoitov wrote:
> >>>> On Mon, Nov 4, 2024 at 11:35=E2=80=AFAM Yonghong Song
> >>>> <yonghong.song@linux.dev> wrote:
> >>>>> The bpf_prog_check_recur() funciton is currently used by trampoline
> >>>>> and tracing programs (also using trampoline) to check whether a
> >>>>> particular prog supports recursion checking or not. The default cas=
e
> >>>>> (non-trampoline progs) return true in the current implementation.
> >>>>>
> >>>>> Let us make the non-trampoline prog recursion check return false
> >>>>> instead. It does not impact any existing use cases and allows the
> >>>>> function to be used outside the trampoline context in the next patc=
h.
> >>>> Does not impact ?! But it does.
> >>>> This patch removes recursion check from fentry progs.
> >>>> This cannot be right.
> >>> The original bpf_prog_check_recur() implementation:
> >>>
> >>> static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
> >>> {
> >>>           switch (resolve_prog_type(prog)) {
> >>>           case BPF_PROG_TYPE_TRACING:
> >>>                   return prog->expected_attach_type !=3D BPF_TRACE_IT=
ER;
> >>>           case BPF_PROG_TYPE_STRUCT_OPS:
> >>>           case BPF_PROG_TYPE_LSM:
> >>>                   return false;
> >>>           default:
> >>>                   return true;
> >>>           }
> >>> }
> >>>
> >>> fentry prog is a TRACING prog, so it is covered. Did I miss anything?
> >> I see. This is way too subtle.
> >> You're correct that fentry is TYPE_TRACING,
> >> so it could have "worked" if it was used to build trampolines only.
> >>
> >> But this helper is called for other prog types:
> >>
> >>          case BPF_FUNC_task_storage_get:
> >>                  if (bpf_prog_check_recur(prog))
> >>                          return &bpf_task_storage_get_recur_proto;
> >>                  return &bpf_task_storage_get_proto;
> >>
> >> so it's still not correct, but for a different reason.
> >
> > There are four uses for func bpf_prog_check_recur() in kernel based on
> > cscope: 0 kernel/bpf/trampoline.c bpf_trampoline_enter 1053 if
> > (bpf_prog_check_recur(prog)) 1 kernel/bpf/trampoline.c
> > bpf_trampoline_exit 1068 if (bpf_prog_check_recur(prog)) 2
> > kernel/trace/bpf_trace.c bpf_tracing_func_proto 1549 if
> > (bpf_prog_check_recur(prog)) 3 kernel/trace/bpf_trace.c
> > bpf_tracing_func_proto 1553 if (bpf_prog_check_recur(prog)) The 2nd
> > and 3rd ones are in bpf_trace.c. 1444 static const struct
> > bpf_func_proto * 1445 bpf_tracing_func_proto(enum bpf_func_id func_id,
> > const struct bpf_prog *prog) 1446 { 1447 switch (func_id) { ... 1548
> > case BPF_FUNC_task_storage_get: 1549 if (bpf_prog_check_recur(prog))
> > 1550 return &bpf_task_storage_get_recur_proto; 1551 return
> > &bpf_task_storage_get_proto; 1552 case BPF_FUNC_task_storage_delete:
> > 1553 if (bpf_prog_check_recur(prog)) 1554 return
> > &bpf_task_storage_delete_recur_proto; 1555 return
> > &bpf_task_storage_delete_proto; ... 1568 default: 1569 return
> > bpf_base_func_proto(func_id, prog); 1570 } 1571 } They are used for
> > tracing programs. So we should be safe here. But if you think that
> > changing bpf_proc_check_recur() and calling function
> > bpf_prog_check_recur() in bpf_enable_priv_stack() is too subtle, I can
> > go back to my original approach which makes all supported prog types
> > explicit in bpf_enable_priv_stack().
>
> Sorry. Format issue again. The below is a better format:
>
> There are four uses for func bpf_prog_check_recur() in kernel based on cs=
cope:
>
> 0 kernel/bpf/trampoline.c bpf_trampoline_enter 1053 if (bpf_prog_check_re=
cur(prog))
> 1 kernel/bpf/trampoline.c bpf_trampoline_exit 1068 if (bpf_prog_check_rec=
ur(prog))
> 2 kernel/trace/bpf_trace.c bpf_tracing_func_proto 1549 if (bpf_prog_check=
_recur(prog))
> 3 kernel/trace/bpf_trace.c bpf_tracing_func_proto 1553 if (bpf_prog_check=
_recur(prog))
>
> The 2nd and 3rd ones are in bpf_trace.c.
>
> 1444 static const struct bpf_func_proto *
> 1445 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_pr=
og *prog)
> 1446 {
> 1447     switch (func_id) {
> ...
> 1548     case BPF_FUNC_task_storage_get:
> 1549         if (bpf_prog_check_recur(prog))
> 1550             return &bpf_task_storage_get_recur_proto;
> 1551         return &bpf_task_storage_get_proto;
> 1552     case BPF_FUNC_task_storage_delete:
> 1553         if (bpf_prog_check_recur(prog))
> 1554             return &bpf_task_storage_delete_recur_proto;
> 1555         return &bpf_task_storage_delete_proto;
> ...
> 1568     default:
> 1569         return bpf_base_func_proto(func_id, prog);
> 1570     }
> 1571 }
>
> They are used for tracing programs. So we should be safe here. But if you=
 think that
> changing bpf_proc_check_recur() and calling function bpf_prog_check_recur=
()
> in bpf_enable_priv_stack() is too subtle, I can go back to my original ap=
proach
> which makes all supported prog types explicit in bpf_enable_priv_stack().

What do you mean 'it's safe' ?
If you change bpf_prog_check_recur() to return false like this patch does
then kprobe progs will not have recursion protection
calling task_storage_get() helper.
In the context of this helper it means that kprobe progs have to use:
nobusy =3D bpf_task_storage_trylock();
With this patch as-is there will be a deadlock in bpf_task_storage_lock()
when kprobe is using task storage.
So it looks broken to me.

I also don't understand the point of this patch 2.
The patch 3 can still do:

+ switch (prog->type) {
+ case BPF_PROG_TYPE_KPROBE:
+ case BPF_PROG_TYPE_TRACEPOINT:
+ case BPF_PROG_TYPE_PERF_EVENT:
+ case BPF_PROG_TYPE_RAW_TRACEPOINT:
+   return PRIV_STACK_ADAPTIVE;
+ default:
+   break;
+ }
+
+ if (!bpf_prog_check_recur(prog))
+   return NO_PRIV_STACK;

which would mean that iter, lsm, struct_ops will not be allowed
to use priv stack.

Unless struct_ops will explicit request priv stack via bool flag.
Then we will also add recursion protection in trampoline.

