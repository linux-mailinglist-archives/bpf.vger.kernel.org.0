Return-Path: <bpf+bounces-62392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E8AF8DB2
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021333BE608
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82A289E3C;
	Fri,  4 Jul 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owa8vW1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCC2882A9
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619573; cv=none; b=OLJ1l41NVNaIhETnqsyFKN8z8tBCUuilUqN4NE3M0C4Mew3IFenE3tZ0n4I4QGGBQuwxQVREusczF7O49HGdr6/5Iqc7pPvHJrF0PS2759Ms2gKT1LDYdW27YxwPSaCu9Ic7/K2Wyth70OtxdZdyoev33zYF3DY/fmxKq9big94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619573; c=relaxed/simple;
	bh=rmb3P3oE5WZ10e040vaaiFxYhhbqMpcXTSLRvtwZn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrLvQ4lHfL9gLMwRIwc9oh5QiseVwJVN5EwgXVu2pNeNd2GMDOHk8H5tP/BHQI2DlfXw6CoCzrKivesGx1x5rFw0FhYDaWeVDOXWiSiaI2Ne3AUNOThwCIucExrlPatda/8SLKm5Dq57Wip2yHzYLUxlMfWbUOwD2ynZUQNsJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owa8vW1n; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-70e767ce72eso6306477b3.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751619570; x=1752224370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFpOo2pmZgs+/6UKHcSf5M5sQ8adYZMHUUIE4mUY3zc=;
        b=Owa8vW1nbCEVYfmuK2obR9ZAdxobN4819/coVGpK9vOTncbpJ1YtddGgg9eoplJf2b
         BIkuPQabc0E5qSUjLI5xvvy+hn0OduQTTeiW8xRWfUMBri6lXj3XhqnRS2X7XAVKGAs6
         C+5azqA5je8FZp9XFKOGd5ejcHS/PzTOjOR3+tNde/AngseHVeNqhAvVnAHS+nO8o9u/
         d6iYi2OL1PL1F17H4GGnAveSriCLJ43ULhHUmiVlGN3fUizPtaRcoBBljHe7X5BFSb1/
         T4RIB20jtrLsRqiibvI9J6yzAY7DV6y5FmshbWIQ8odlXJe9151gfvcZvEXZHcnOmF9M
         QxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619570; x=1752224370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFpOo2pmZgs+/6UKHcSf5M5sQ8adYZMHUUIE4mUY3zc=;
        b=wCWhGeYK3GAG3MshpPSXQLzB2q1QS63hTyHDa0XJPdPgn929gCXULocEaLlbqF52Fy
         OH9YGw+pCCV//9jpLyFd5bAPha1mtgLVTHG7LkOpGErQ2V6foBCEScZG4jubuuBa9gt5
         6FyxPEyIZKhqO3HG3NE2xzuyyXlq3i0kGUahg0UktNfQel/1BuxwRfBSzm9O5t5B37VT
         yViT45pVd5UGhKnieQTnytR6pAUWCqYw9PsTi82EK7/H81VESQK53NVogsio7O4iKuME
         /oZDQuQxB5QCp/KknYVMSEKG63iueE9aNFXDpVlL+naCDX4Xs+st1pBgr8neRN4zdpZk
         /exQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsVRXXBJnn3hM2Xsmv4P5+FJ2enSz62Myz8LqwW2dr7C/3dWHPYFooLbFMrmRJVGQBtMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCxrb5M9NJT982C+LxZzz6urhKJYj/sBNPTjfe9IXs2KEMauU
	g33MMAl01kv1e5K9A43sb/YUGqsVjCLOdrEtek+KhLLFLJy2nB9qNN0m4gJJUFud3JMeRZSqITg
	C7puLyY7XYG2jbWoOpfPqNe3jUlzE+rQ=
X-Gm-Gg: ASbGncvWtIXj3RzXvmuuMeOrWpxV9JR/Kc1h+sFbw+KnpWfEFx94qIqNQYOu/69UQ89
	e36iPf8lFpQ3u9G37iHY5aRKNcArWfX9IAuTZaVk2ksnfgs2phtyWpKQEcT+fieeC6646vPDteR
	waBLUnV0whpvQsHNpT5FZJf9nMDy7c6eFzp2el14e1wLY=
X-Google-Smtp-Source: AGHT+IEXKMXKe1Oa9H7qyhXvZrXh+Pdp/6YMOAsNfwn49NYZU/XfCS5x/gnlu4IQuuWci4aGRI92GpxZtZHinQ+59xQ=
X-Received: by 2002:a05:690c:650f:b0:70a:2675:70b3 with SMTP id
 00721157ae682-71668deda65mr20456527b3.17.1751619570151; Fri, 04 Jul 2025
 01:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <aGeVH0VV_PRfOeZ9@krava> <CADxym3aj5WYUfP8jSFYAntpgjAbJuZ=z=BDT1AuZx5jZ3-PBbw@mail.gmail.com>
In-Reply-To: <CADxym3aj5WYUfP8jSFYAntpgjAbJuZ=z=BDT1AuZx5jZ3-PBbw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 4 Jul 2025 16:58:34 +0800
X-Gm-Features: Ac12FXwXkDoYktPAu4RsriLfGLxeK1wM4U1wOAqqYLfTKjNNnU8USA7PJe96f0I
Message-ID: <CADxym3ZqGDB4YsiYXk7Qy9wy2GC_JetH+YKWvhDiz50vTWAXzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/18] bpf: tracing multi-link support
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 4:52=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Fri, Jul 4, 2025 at 4:47=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Thu, Jul 03, 2025 at 08:15:03PM +0800, Menglong Dong wrote:
> > > (Thanks for Alexei's advice to implement the bpf global trampoline wi=
th C
> > > instead of asm, the performance of tracing-multi has been significant=
ly
> > > improved. And the function metadata that implemented with hash table =
is
> > > also fast enough to satisfy our needs.)
> > >
> > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed=
 to
> > > be attached to multiple hooks, and we have to create a BPF program fo=
r
> > > each kernel function, for which we want to trace, even through all th=
e
> > > program have the same (or similar) logic. This can consume extra memo=
ry,
> > > and make the program loading slow if we have plenty of kernel functio=
n to
> > > trace.
> >
> > hi,
> > what tree did you base your patchset on? I can't apply it on
> > bpf-next/master and I tried several other trees
>
> Sorry that I forgot to rebase to the latest bpf-next/master, and
> this patchset is based on this commit: c4b1be928ea0,
> which means I have not updated my tree for a week :/

Oh, it's not my fault. I conflict with the commit
5ab154f1463a ("bpf: Introduce BPF standard streams"), which was
applied 12h ago. That's why the CI didn't report the problem :/

>
> Thanks!
> Menglong Dong
> >
> > thanks,
> > jirka
> >
> > >
> > > In this series, we add the support to allow attaching a tracing BPF
> > > program to multi hooks, which is similar to BPF_TRACE_KPROBE_MULTI.
> > > Generally speaking, this series can be divided into 5 parts:
> > >
> > > 1. Add per-function metadata storage support.
> > > 2. Add bpf global trampoline support for x86_64.
> > > 3. Add bpf global trampoline link support.
> > > 4. Add tracing multi-link support.
> > >
> > > per-function metadata storage
> > > -----------------------------
> > > The per-function metadata storage is the basic of the bpf global
> > > trampoline. In short, it's a hash table and store some information of=
 the
> > > kernel functions. The key of this hash table is the kernel function
> > > address, and following data is stored in the hash value:
> > >
> > > * The BPF progs, whose type is FENTRY, FEXIT or MODIFY_RETURN. The st=
ruct
> > >   kfunc_md_tramp_prog is introduced to store the BPF prog and the coo=
kie,
> > >   and makes the BPF progs of the same type a list with the "next" fie=
ld.
> > > * The kernel function address
> > > * The kernel function arguments count
> > > * If origin call needed
> > >
> > > The budgets of the hash table can grow and shrink when necessary. Ale=
xei
> > > advised to use rhashtable. However, the compiler is not clever enough=
 and
> > > it refused to inline the hash lookup for me, which bring in addition
> > > overhead in the following BPF global trampoline. I have to replace th=
e
> > > "inline" with "__always_inline" for rhashtable_lookup_fast,
> > > rhashtable_lookup, __rhashtable_lookup, rht_key_get_hash to force it
> > > inline the hash lookup for me. Then, I just implement a hash table my=
self
> > > instead.
> > >
> > > bpf global trampoline
> > > ---------------------
> > > The bpf global trampoline is similar to the general bpf trampoline. T=
he
> > > bpf trampoline store the bpf progs and some metadata in the trampolin=
e
> > > instructions directly. However, the bpf global trampoline store and g=
et
> > > the metadata from the function metadata with kfunc_md_get_rcu(). This
> > > makes the bpf global trampoline more flexible and can be used for all=
 the
> > > kernel functions.
> > >
> > > The bpf global trampoline is designed to implement the tracing multi-=
link
> > > for FENTRY, FEXIT and MODIFY_RETURN.
> > >
> > > The global trampoline is implemented in C mostly. We implement the en=
try
> > > of the trampoline with a "__naked" function, who will save the regs t=
o
> > > an array on the stack and call bpf_global_caller_run(). The entry wil=
l
> > > pass the address of the array and the address of the rip to
> > > bpf_global_caller_run().
> > >
> > > The whole idea to implement the trampoline with C is inspired by Alex=
ei
> > > in [3]. It do have advantage to implement in C. Some function call, s=
uch
> > > as __bpf_prog_enter_recur, __bpf_prog_exit_recur, __bpf_tramp_enter
> > > and __bpf_tramp_exit, are inlined, which reduces some overhead. The
> > > performance of the global trampoline can be see below.
> > >
> > > bpf global trampoline link
> > > --------------------------
> > > We reuse part of the code in [2] to implement the tracing multi-link.=
 The
> > > struct bpf_gtramp_link is introduced for the bpf global trampoline li=
nk.
> > > Similar to the bpf trampoline link, the bpf global trampoline link ha=
s
> > > bpf_gtrampoline_link_prog() and bpf_gtrampoline_unlink_prog() to link=
 and
> > > unlink the bpf progs.
> > >
> > > The "entries" in the bpf_gtramp_link is a array of struct
> > > bpf_gtramp_link_entry, which contain all the information of the funct=
ions
> > > that we trace, such as the address, the number of args, the cookie an=
d so
> > > on.
> > >
> > > The bpf global trampoline is much simpler than the bpf trampoline, an=
d we
> > > introduce then new struct bpf_global_trampoline for it. The "image" f=
ield
> > > is a pointer to bpf_global_caller_x. We introduce the global trampoli=
ne
> > > array and kernel function with arguments count "x" can be handled by =
the
> > > global trampoline global_tr_array[x]. We implement the global trampol=
ine
> > > based on the direct ftrace, and the "fops" field for this propose. Th=
is
> > > means bpf2bpf is not supported by the tracing multi-link.
> > >
> > > When we link the bpf prog, we will add it to all the target functions=
'
> > > kfunc_md. Then, we get all the function addresses that have bpf progs=
 with
> > > kfunc_md_bpf_ips(), and reset the ftrace filter of the fops to it. Th=
e
> > > direct ftrace don't support to reset the filter functions yet, so we
> > > introduce the reset_ftrace_direct_ips() to do this work.
> > >
> > > tracing multi-link
> > > ------------------
> > > Most of the code of this part comes from the series [2].
> > >
> > > In the 6th patch, we add the support to record index of the accessed
> > > function args of the target for tracing program. Meanwhile, we add th=
e
> > > function btf_check_func_part_match() to compare the accessed function=
 args
> > > of two function prototype. This function will be used in the next com=
mit.
> > >
> > > In the 7th patch, we refactor the struct modules_array to ptr_array, =
as
> > > we need similar function to hold the target btf, target program and k=
ernel
> > > modules that we reference to in the following commit.
> > >
> > > In the 11th patch, we implement the multi-link support for tracing, a=
nd
> > > following new attach types are added:
> > >
> > >   BPF_TRACE_FENTRY_MULTI
> > >   BPF_TRACE_FEXIT_MULTI
> > >   BPF_MODIFY_RETURN_MULTI
> > >
> > > We introduce the struct bpf_tracing_multi_link for this purpose, whic=
h
> > > can hold all the kernel modules, target bpf program (for attaching to=
 bpf
> > > program) or target btf (for attaching to kernel function) that we
> > > referenced.
> > >
> > > During loading, the first target is used for verification by the veri=
fier.
> > > And during attaching, we check the consistency of all the targets wit=
h
> > > the first target.
> > >
> > > performance comparison
> > > ----------------------
> > > We have implemented the following performance testings in the selftes=
ts in
> > > bench_trigger.c:
> > >
> > > - trig-fentry-multi
> > > - trig-fentry-multi-all
> > > - trig-fexit-multi
> > > - trig-fmodret-multi
> > >
> > > The "fentry_multi_all" is used to test the performance of the functio=
n
> > > metadata hash table and all the kernel function is hooked during test=
ings.
> > >
> > > The mitigations is disabled during the testings. It is enabled by def=
ault
> > > in the kernel, and we can disable it with the "mitigations=3Doff" cmd=
line
> > > to do the testing.
> > >
> > > The testings is done with the command:
> > >   ./run_bench_trigger.sh fentry fentry-multi fentry-multi-all fexit \
> > >                          fexit-multi fmodret fmodret-multi
> > >
> > > Following is the testings results, and the unit is "M/s":
> > >
> > > fentry  | fm     | fm_all | fexit  | fexit-multi | fmodret | fmodret-=
multi
> > > 103.303 | 94.532 | 98.009 | 55.155 | 55.448      | 58.632  | 56.379
> > > 107.564 | 98.007 | 97.857 | 55.278 | 53.997      | 59.485  | 55.855
> > > 106.841 | 97.483 | 95.064 | 55.715 | 55.502      | 59.442  | 56.126
> > > 109.852 | 97.486 | 93.161 | 56.432 | 55.494      | 59.454  | 56.178
> > > 109.791 | 97.973 | 96.728 | 55.729 | 55.363      | 59.445  | 56.228
> > >
> > > * fm: fentry-multi, fm_all: fentry-multi-all
> > >
> > > Following is the results to run all the bench testings:
> > >
> > >   usermode-count :  746.907 =C2=B1 0.323M/s
> > >   kernel-count   :  313.423 =C2=B1 0.031M/s
> > >   syscall-count  :   18.179 =C2=B1 0.013M/s
> > >   fentry         :  107.149 =C2=B1 0.051M/s
> > >   fexit          :   56.565 =C2=B1 0.019M/s
> > >   fmodret        :   59.495 =C2=B1 0.024M/s
> > >   fentry-multi   :   99.073 =C2=B1 0.087M/s
> > >   fentry-multi-all:   97.920 =C2=B1 0.095M/s
> > >   fexit-multi    :   55.426 =C2=B1 0.045M/s
> > >   fmodret-multi  :   56.589 =C2=B1 0.163M/s
> > >   rawtp          :  166.774 =C2=B1 0.137M/s
> > >   tp             :   61.947 =C2=B1 0.035M/s
> > >   kprobe         :   43.719 =C2=B1 0.018M/s
> > >   kprobe-multi   :   47.451 =C2=B1 0.087M/s
> > >   kretprobe      :   18.358 =C2=B1 0.026M/s
> > >   kretprobe-multi:   24.523 =C2=B1 0.016M/s
> > >
> > > From the above test data, it can be seen that the performance of fent=
ry-multi
> > > is approximately 10% worse than that of fentry, and fmodret-multi is =
~5%
> > > worse then fmodret, fexit-multi is almost the same to fexit.
> > >
> > > The bpf global trampoline has addition overhead in comparison with th=
e bpf
> > > trampoline:
> > > 1. We do more checks. We check if origin call is need, if the prog is
> > >    sleepable, etc, in the global trampoline.
> > > 2. We do more memory read and write. We need to load the bpf progs fr=
om
> > >    memory, and save addition regs to stack.
> > > 3. The function metadata lookup.
> > >
> > > However, we also have some optimization:
> > > 1. For fentry, we avoid 2 function call: __bpf_prog_enter_recur and
> > >    __bpf_prog_exit_recur, as we make them inline in our case.
> > > 2. For fexit/fmodret, we avoid another 2 function call: __bpf_tramp_e=
nter
> > >    and __bpf_tramp_exit by inline them.
> > >
> > > The performance of fentry-multi is closer to fentry-multi-all, which =
means
> > > the hash table is O(1) and fast enough.
> > >
> > > Further work
> > > ------------
> > > The performance of the global trampoline can be optimized further.
> > >
> > > First, we can avoid some checks by generate more bpf_global_caller, s=
uch
> > > as:
> > >
> > > static __always_inline notrace int
> > > bpf_global_caller_run(unsigned long *args, unsigned long *ip, int nr_=
args,
> > >                       bool sleepable, bool do_origin)
> > > {
> > >     xxxxxx
> > > }
> > >
> > > static __always_used __no_stack_protector notrace int
> > > bpf_global_caller_2_sleep_origin(unsigned long *args, unsigned long *=
ip)
> > > {
> > >     return bpf_global_caller_run(args, ip, nr_args, 2, 1, 1);
> > > }
> > >
> > > And the bpf global caller "bpf_global_caller_2_sleep_origin" can be u=
sed
> > > for the functions who have 2 function args, and have sleepable bpf pr=
ogs,
> > > and have fexit or modify_return. The check of sleepable and origin ca=
ll
> > > will be optimized by the compiler, as they are const.
> > >
> > > Second, we can implement the function metadata with the function padd=
ing.
> > > The hash table lookup for metadata consume ~15 instructions. With
> > > function padding, it needs only 5 instructions, and will be faster.
> > >
> > > Besides the performance, we also need to make the global trampoline
> > > collaborate with bpf trampoline. For now, FENTRY_MULTI will be attach=
ed
> > > to the target who already have FENTRY on it, and -EEXIST will be retu=
rned.
> > > So we need another series to make them work together.
> > >
> > > Changes since V1:
> > >
> > > * remove the function metadata that bases on function padding, and
> > >   implement it with a resizable hash table.
> > > * rewrite the bpf global trampoline with C.
> > > * use the existing bpf bench frame for bench testings.
> > > * remove the part that make tracing-multi compatible with tracing.
> > >
> > > Link: https://lore.kernel.org/all/20250303132837.498938-1-dongml2@chi=
natelecom.cn/ [1]
> > > Link: https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglo=
ng.8@bytedance.com/ [2]
> > > Link: https://lore.kernel.org/bpf/CAADnVQ+G+mQPJ+O1Oc9+UW=3DJ17CGNC5B=
=3DusCmUDxBA-ze+gZGw@mail.gmail.com/ [3]
> > > Menglong Dong (18):
> > >   bpf: add function hash table for tracing-multi
> > >   x86,bpf: add bpf_global_caller for global trampoline
> > >   ftrace: factor out ftrace_direct_update from register_ftrace_direct
> > >   ftrace: add reset_ftrace_direct_ips
> > >   bpf: introduce bpf_gtramp_link
> > >   bpf: tracing: add support to record and check the accessed args
> > >   bpf: refactor the modules_array to ptr_array
> > >   bpf: verifier: add btf to the function args of bpf_check_attach_tar=
get
> > >   bpf: verifier: move btf_id_deny to bpf_check_attach_target
> > >   x86,bpf: factor out arch_bpf_get_regs_nr
> > >   bpf: tracing: add multi-link support
> > >   libbpf: don't free btf if tracing_multi progs existing
> > >   libbpf: support tracing_multi
> > >   libbpf: add btf type hash lookup support
> > >   libbpf: add skip_invalid and attach_tracing for tracing_multi
> > >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> > >   selftests/bpf: add basic testcases for tracing_multi
> > >   selftests/bpf: add bench tests for tracing_multi
> > >
> > >  arch/x86/Kconfig                              |   4 +
> > >  arch/x86/net/bpf_jit_comp.c                   | 290 ++++++++++++-
> > >  include/linux/bpf.h                           |  59 +++
> > >  include/linux/bpf_tramp.h                     |  72 ++++
> > >  include/linux/bpf_types.h                     |   1 +
> > >  include/linux/bpf_verifier.h                  |   1 +
> > >  include/linux/btf.h                           |   3 +-
> > >  include/linux/ftrace.h                        |   7 +
> > >  include/linux/kfunc_md.h                      |  91 ++++
> > >  include/uapi/linux/bpf.h                      |  10 +
> > >  kernel/bpf/Makefile                           |   1 +
> > >  kernel/bpf/btf.c                              | 113 ++++-
> > >  kernel/bpf/kfunc_md.c                         | 352 ++++++++++++++++
> > >  kernel/bpf/syscall.c                          | 395 ++++++++++++++++=
+-
> > >  kernel/bpf/trampoline.c                       | 220 +++++++++-
> > >  kernel/bpf/verifier.c                         | 161 ++++---
> > >  kernel/trace/bpf_trace.c                      |  48 +--
> > >  kernel/trace/ftrace.c                         | 183 +++++---
> > >  net/bpf/test_run.c                            |   3 +
> > >  net/core/bpf_sk_storage.c                     |   2 +
> > >  net/sched/bpf_qdisc.c                         |   2 +-
> > >  tools/bpf/bpftool/common.c                    |   3 +
> > >  tools/include/uapi/linux/bpf.h                |  10 +
> > >  tools/lib/bpf/bpf.c                           |  10 +
> > >  tools/lib/bpf/bpf.h                           |   6 +
> > >  tools/lib/bpf/btf.c                           | 102 +++++
> > >  tools/lib/bpf/btf.h                           |   6 +
> > >  tools/lib/bpf/libbpf.c                        | 296 ++++++++++++-
> > >  tools/lib/bpf/libbpf.h                        |  25 ++
> > >  tools/lib/bpf/libbpf.map                      |   5 +
> > >  tools/testing/selftests/bpf/Makefile          |   2 +-
> > >  tools/testing/selftests/bpf/bench.c           |   8 +
> > >  .../selftests/bpf/benchs/bench_trigger.c      |  72 ++++
> > >  .../selftests/bpf/benchs/run_bench_trigger.sh |   1 +
> > >  .../selftests/bpf/prog_tests/fentry_fexit.c   |  22 +-
> > >  .../selftests/bpf/prog_tests/fentry_test.c    |  79 +++-
> > >  .../selftests/bpf/prog_tests/fexit_test.c     |  79 +++-
> > >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------
> > >  .../selftests/bpf/prog_tests/modify_return.c  |  60 +++
> > >  .../bpf/prog_tests/tracing_multi_link.c       | 210 ++++++++++
> > >  .../selftests/bpf/progs/fentry_multi_empty.c  |  13 +
> > >  .../selftests/bpf/progs/tracing_multi_test.c  | 181 ++++++++
> > >  .../selftests/bpf/progs/trigger_bench.c       |  22 +
> > >  .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 ++
> > >  tools/testing/selftests/bpf/test_progs.c      |  50 +++
> > >  tools/testing/selftests/bpf/test_progs.h      |   3 +
> > >  tools/testing/selftests/bpf/trace_helpers.c   | 283 +++++++++++++
> > >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> > >  48 files changed, 3349 insertions(+), 464 deletions(-)
> > >  create mode 100644 include/linux/bpf_tramp.h
> > >  create mode 100644 include/linux/kfunc_md.h
> > >  create mode 100644 kernel/bpf/kfunc_md.c
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_mu=
lti_link.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/fentry_multi_em=
pty.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_t=
est.c
> > >
> > > --
> > > 2.39.5
> > >
> > >

