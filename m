Return-Path: <bpf+bounces-75928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB6C9D1AE
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 22:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 110503486E9
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298C283FC5;
	Tue,  2 Dec 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SovhuxEn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F4A55
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711621; cv=none; b=uWP4YjG9ZKqvNfqaEn2SCIwxntpTXfxT1dCBEFwOd93rhkPx29D2N/x4p8DTSkXAr7McquKpd8b51rQEDjjgt50C3YgS7YF4dII1xHmxGonPWtj+Zff/fGMNxFRZcHq1Uo7B6TP3j9ag4IIo700lR3jLuWdu7pq2IrnX8JO4dXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711621; c=relaxed/simple;
	bh=j9zdvYvRd5N/tm5PQHkeP0Z7BjaVssiEKq4ZU4AEBAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3viroZirUu6ZdFuPNI0zZ/c3tFBQkdDtryr9kDadxG26/rHMn6fjkaAJacW/Tai5w0oAX6kUDNvndRESj/CC/zTzGZgvOiMgLTqZawZg7921clQYcjjDoIdk+KZW83yEgBU90NlhyrZMaHWPBpemKfrR6EvrjpcKEYOSlOtQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SovhuxEn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so62316675e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764711617; x=1765316417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B21ia7hurs6U7fpjmTgQzMSCCLi3FObstT6giHU6CQ=;
        b=SovhuxEnEMR9sVwa4xYPhtDQQbIm/ZTNv+ipxwUTsCzkGmzgXd1nc50wK1hHoR/56Q
         UXECNCm+5ID8BRJ1uRglEa4wHYLOjDCqMbBDwJxC50JJVojve3/KUJ4MpPgIRbgbBr00
         /NW1Bm8jAcVP1kHcnsXGdouNyRusDaoeuKh4vRufIIXU7RAxTgjC1g6UltX3OfeyDgbf
         qCqVhFu37DCM1uEf32Xw0RHY3AzzREhveAWiJEZKl8yKHW/oNsMw4dYa5xut18UhCXFL
         +j9aQBjZphp3OlHvN3obEAWzxSZ/EoIic5BLrIRk2MuED2aWxTKC1HwF2QquIDucOVv8
         VFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711617; x=1765316417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/B21ia7hurs6U7fpjmTgQzMSCCLi3FObstT6giHU6CQ=;
        b=CXOXQe3cL6/q9MPOHXr8Mm3Gn04Rppndui0pKhOgJd1jssHBX1kQOAtUansujRZv3I
         4PGQNk4q4qLogUQWNKc7SFt+U5LfzW21MZfNtGS08QuXgtqpKHQMkKwJP4z6La6LevJF
         kHA9KtXhzIgHpZs6IOOECy50iNdQXYQGivAJRBpzaNMh4/CfWGhWU3fhv5zHvJMhPRwD
         goAaBAVr1HS/1VRUlmerukh/MsERHZk82I7Eq4g0q0/J2fHNNmYJNh357Gv9RZ7/143M
         bp8pefVv2FJjSd/AZ/fMa5MJ1mDDLhxMMSQ3PJTkzWwq4P720MSjBRYxGiABJzsGIUBp
         NQQA==
X-Forwarded-Encrypted: i=1; AJvYcCX65VC1362IXMZzJzRlqc/KMiDzUOjHSIT7GmFkH86g+Yoe1LrUbw/XYpsV7/UScC5ik50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWtvqVrWsbrJs/K0juHixFCrMzSdzcacTSvk9R+w+EapRs+0w
	Nqn5GcpsPfiFlwRIGZhkLIFyPCXOdg7xctDPtMEs3qbP0n4cPNRbg1fgTR9eF5RKIRxztCqSwSQ
	yd9xbzb5sR5xCgnw+bqxySFUY897r3wA=
X-Gm-Gg: ASbGncsmJC8B5bKdG6ogr/zL0w3Wdnq15scsWix0TF/25ayxuH9430XOKyVFwsMdedl
	Tr7/P/T81iBwxlgwiNUQdf2hMQacWo3rPxtjTTVHW61VPrVezII4wu8gBbDkvKHIjpi/nXOeFX5
	A1a/9xiIH05fj50n0XRKnJ3zT8z8xVaHieq++UiDkIh//fzPaNf3UVF+lajp98tYUCT7KK02D9s
	ctewwEyttT8kBpu6H6/eTU8+hwzPWZDTmDcEhYXEi9UHhtwWptd0p1xuYlMOJP/3lb6l4qBm3cs
	2H3/uAUZx/wjoddk5OoZxiCxABz1
X-Google-Smtp-Source: AGHT+IG3jBkuXiXqj7FfBIzom7LtuNCPb7rdq8QD+NENcKxkUyV93Q5dy2F80CUciE+WIZiAfmkMyaBPCK1I9Tbc+7I=
X-Received: by 2002:a05:600c:1c23:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-4792af34a5fmr1105215e9.23.1764711617066; Tue, 02 Dec 2025
 13:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com> <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com> <aS87V-zpo-ZHZzu0@google.com>
In-Reply-To: <aS87V-zpo-ZHZzu0@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 13:40:04 -0800
X-Gm-Features: AWmQ_bnDjKuyZRg2fSsZzuUGlRpNo1e-dZwzZQO1mCh00Uu0qdS7p9xFfthlTMw
Message-ID: <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, hust-os-kernel-patches@googlegroups.com, 
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 11:17=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Tue, Dec 02, 2025 at 09:27:17AM -0800, Alexei Starovoitov wrote:
> > On Tue, Dec 2, 2025 at 6:55=E2=80=AFAM Matt Bobrowski <mattbobrowski@go=
ogle.com> wrote:
> > >
> > > On Tue, Dec 02, 2025 at 10:38:55AM +0000, Matt Bobrowski wrote:
> > > > On Tue, Dec 02, 2025 at 03:09:42PM +0800, =E6=A2=85=E5=BC=80=E5=BD=
=A6 wrote:
> > > > > Our fuzzer tool discovered a NULL pointer dereference vulnerabili=
ty in the BPF subsystem. The vulnerability is triggered when a BPF LSM prog=
ram, attached to the `bpf_lsm_mmap_file`, receives a NULL pointer for the `=
struct file *` argument during an anonymous memory mapping operation but at=
tempts to dereference it without a NULL check.
> > > > >
> > > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > > >
> > > > > ## Root Cause
> > > > >
> > > > > The crash is caused by a NULL pointer dereference within an eBPF =
program attached to the `bpf_lsm_mmap_file` LSM hook. The trigger occurs wh=
en a user calls the `mmap` syscall with the `MAP_ANONYMOUS` flag. This acti=
on creates a file-less memory mapping, causing the kernel to invoke the `se=
curity_mmap_file` hook with a NULL `struct file *` argument. If the attache=
d BPF program assumes this pointer is always valid and attempts to derefere=
nce it without a NULL check, it immediately causes a page fault, leading to=
 a kernel panic.
> > > >
> > > > Thanks for the report. Can confirm, and a more simplified reproduce=
r
> > > > can be found below:
> > > >
> > > > BPF:
> > > > ```
> > > > SEC("lsm.s/mmap_file")
> > > > int BPF_PROG(mmap_file, struct file *file)
> > > > {
> > > >         bpf_printk("i_ino=3D%llu", file->f_inode->i_ino);
> > > >         return 0;
> > > > }
> > > > ```
> > > >
> > > > Stimulus:
> > > > ```
> > > > #include <stdio.h>
> > > > #include <string.h>
> > > > #include <sys/mman.h>
> > > >
> > > > int main(int argc, char** argv) {
> > > >   void* p;
> > > >
> > > >   p =3D mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
> > > >            MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > >   if (p =3D=3D MAP_FAILED) {
> > > >     perror("mmap");
> > > >     return 1;
> > > >   }
> > > >
> > > >   memset(p, 0, 4096);
> > > >   munmap(p, 4096);
> > > >   return 0;
> > > > }
> > > > ```
> > > >
> > > > My initial thought here is that bpf_lsm_is_trusted() is treating
> > > > pointer arguments provided to security_mmap_file() simply as
> > > > PTR_TRUSTED, when in reality it should be something like PTR_TRUSTE=
D |
> > > > PTR_MAYBE_NULL instead. Anyway, I can take a look and send through =
an
> > > > appropriate fix.
> > >
> > > So, thinking about this a little I think we have a couple options whe=
n
> > > it comes to addressing this. We can either:
> > >
> > > a) Add bpf_lsm_mmap_file() to the untrusted_lsm_hooks set. This will
> > > effectively mark the struct file pointer argument passed into
> > > bpf_lsm_mmap_file() as being untrusted (i.e. the register will not
> > > carry a PTR_TRUSTED type). The caveat with this approach however is
> > > that it'll have negative effects (i.e. cannot be supplied to BPF
> > > kfuncs that accept KF_TRUSTED_ARGS arguments) on those struct file
> > > pointer arguments that are considered to be valid and trusted.
> > >
> > > b) Update the generic LSM_HOOK() declaration for mmap_file
> > > (security_mmap_file()) within lsm_hook_defs.h such that the struct
> > > file pointer argument name contains a "__nullable" suffix. This will
> > > allow btf_ctx_access() to apply the PTR_MAYBE_NULL type onto the
> > > backing register holding a reference to the struct file pointer,
> > > ultimately forcing the BPF program to perform a NULL check before
> > > attempting to dereference it. The caveat with this approach is that
> > > BPF program verification, and ultimately its runtime safety
> > > guarantees, would be tied in with generic LSM infrastructure which I
> > > don't think is a good idea. Subtle breakage could occur literally at
> > > any point.
> > >
> > > c) Provide an override declaration/definition for bpf_lsm_mmap_file()
> > > within include/linux/bpf_lsm.h and kernel/bpf/bpf_lsm.c such that the
> > > struct file pointer argument is named file__nullable instead. Similar
> >
> > I don't yet see how you can accomplish this, but it's indeed the best
> > option.
> > There is already:
> > FUNC 'bpf_lsm_mmap_file' type_id=3D...
> > Magic hack to
> > #define LSM_HOOK(RET, DEFAULT, NAME, ...)       \
> > noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> > ?
>
> Hm, I too was questioning whether this was initially even possible,
> but I managed to get it working by doing the following (perhaps this
> is also what you had meant when you mentioned using the distinct
> suffix below):
>
> ```
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..ddb328ba856d 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -14,11 +14,18 @@
>
>  #ifdef CONFIG_BPF_LSM
>
> +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot=
,
> +                     unsigned long prot, unsigned long flags);
> +
> +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>
> +#undef bpf_lsm_mmap_file
> +
>  struct bpf_storage_blob {
>         struct bpf_local_storage __rcu *storage;
>  };
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 7cb6e8d4282c..48259738e032 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -20,6 +20,14 @@
>  /* For every LSM hook that allows attachment of BPF programs, declare a =
nop
>   * function where a BPF program can be attached.
>   */
> +noinline int bpf_lsm_mmap_file(struct file *file__nullable, unsigned lon=
g reqprot,
> +                             unsigned long prot, unsigned long flags)
> +{
> +       return 0;
> +}
> +
> +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original

so both functions will be in BTF and in .text ?
That's suboptimal. Hopefully there won't be many hooks that
need such annotation, but let's think of ways to avoid the waste.
Like there is BTF_TYPE_EMIT(). We haven't used it
to emit FUNC kind. It works for FUNC_PROTO kind, but that's not
enough here.

We can play tricks with __weak. Like:

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7cb6e8d4282c..60d269a85bf1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -21,7 +21,7 @@
  * function where a BPF program can be attached.
  */
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
-noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
+__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \

diff kernel/bpf/bpf_lsm_proto.c

+int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+                     unsigned long prot, unsigned long flags)
+{
+       return 0;
+}

and above one with __nullable will be in vmlinux BTF.

afaik __weak functions are not removed by linker when in non-LTO,
but it's still better than
+#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
No need to change bpf_lsm.h either.

> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
>  noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
>  {                                              \
> @@ -29,6 +37,8 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)      \
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>
> +#undef bpf_lsm_mmap_file
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
>  #include <linux/lsm_hook_defs.h>
> ```
>
> > or a flavor named with a distinct suffix ?
> > bpf_lsm_mmap_file___suffix(struct file *file__nullable, ...) ?
> >
> > To address the same issue with tracepoints we went with
> > raw_tp_null_args[].
> > It's ugly, but gets the job done. We can probably apply it
> > to lsm args too.
>
> Unfortunately, I'm not overly familiar with the whole
> raw_tp_null_args[] thing, so I don't really know how this works. I'll
> need to take a look.

I'll take back this suggestion. __weak hack above is cleaner
than raw_tp_null_args[].

> > tbh option (b) could have been a choice or even:
> > -int security_mmap_file(struct file *file, unsigned long prot,
> > +int security_mmap_file(struct file *file__nullable, unsigned long prot=
,
> >
> > but it's an operational headache due to different subsystems/maintainer=
s.
>
> Agree, hence why I think we should just add the necessary workaround
> directly within the BPF LSM.
>
> > Long term the plan is to wait for gcc/pahole to fully support
> > btf_decl_tags and switch to that.
>
> Yes, I literally hit send on my previous email only for this exact
> option to also pop into my head. But as I read more into it on my
> commute home, I gathered that there was some inherent dependency on
> the BPF toolchain which probably isn't ideal at this point either.
>
> Another alternative that has literally just come to mind is the
> possibility of introducing another BTF set (i.e. nullable_args). A
> function (LSM hook) associated with this new BTF set will basically
> force the BPF verifier to strictly treat all of its associated pointer
> type arguments as nullable.

This hammer is too big. imo

