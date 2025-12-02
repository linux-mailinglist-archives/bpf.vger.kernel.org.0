Return-Path: <bpf+bounces-75901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34AC9C622
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A04534492F
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE372C0F6F;
	Tue,  2 Dec 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiKaFjy7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCB2C0307
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696452; cv=none; b=l7R1ot+m/EMK/MfMKIekPFWEC2mbiQWeA9NXEB2Ai/suWC1dSrRmh8k9w7DnQanPljQb10E4Ra/fID5mSQMLnM2I6BONgBo4sYBevAAXnkbLSphvKcsOnVZDtRoWtRTgQCzfdQlgUZiEM6a76fZc1rO+s2WIPjbOJkwyQujmYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696452; c=relaxed/simple;
	bh=mxt/R3jswEjHEqbIJhpL3n0mcc0dp5i4HmP0UQM4cb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVsWc4x/jXTP5WoDrrmkP55rhU1olrCcTO33NEmjHvu8QzarndhjfXvNg6Z46rzFJauYaOHUrXRiDcqNzCRLAS3thwHIr2zb7EZHVx14ahR1UoekHU8j108GGuXnHa5w9G77R3T75U6oSuYFn8RSOFLC/AUh5U8O9KzDnhu9kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiKaFjy7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2e08b27eso1417770f8f.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696449; x=1765301249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiOxYQJhaO3IlO9NDdk0d3kLgGsdjus6my0jmOXSblY=;
        b=JiKaFjy7wZPRbCET+4YF7rY/bO+/8aDGNM88OALQT5tSjCUMRKz5kK/Yjp+fbtYJS7
         xuC45pgo1OdDmbYd66pG4FqaTvP7qulQtO9rMhJlEo3UGpFtZC9gcHUEY9oVi9PwegG7
         fMM4NtU9p5C4bhVJuTVsfzEdVGXYDTxEkyuU/2RN9fT8Ndui8bukitXMhbtr/09TMMIg
         EAt+t8/5Rz2eH2QxaaD2KClaZzE1SUkezzmbNBmCHabVtO8WUEOZWX/TcBCWTKk2ozf5
         iWhN//CulRo4JWc+ererPrcddbVNZMmz1N49iwKOa4+ybYPIhDzhwTtZ4zh7it6MRALi
         K41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696449; x=1765301249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qiOxYQJhaO3IlO9NDdk0d3kLgGsdjus6my0jmOXSblY=;
        b=wP6nxiDl0kh0D01QrMkq9PkkhVL/cBmknlBmkThZzpuadZUuEaV7CGCGkHO5bDm0vN
         U9HzVdxdgjuJ/fb2cDd317WpPjIOLeB9PnQGKOfhR4ogZ25mq79n5ytfv8fQPy5YdunT
         rscIB/h5mTwHkO+wywNIUcBzL9LBZxU0Ww4BVGLnK3t0eWUdAG1Sdkq/w+3acx7cD5OR
         IvkJHcNAkr3oEf4+k2GgLJ5R20LPoSWOr8UWGfaXmRUbb3ijQyDApj55Z8uKu93nBJvS
         m7sBMdwTbcEu83H8xncuSTydk3oyJqlDVxaJuYda3fJf68dl5IWgRVXw5TpTujj2sr8v
         cGDw==
X-Forwarded-Encrypted: i=1; AJvYcCWMzgSrGBb50s4CJ1sCP0j8WyVVkmjxGrH7jOYMcH8kTdhtbJwm2ajn1o1IB0znlOIxncI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNe8X7zRyK0cYCBJGG0caY7Zq0z+izrnJb0RKbrhTzGq96ClMn
	tIX4AZkw3folz3JLnqqdf7EUgKTrCZx5uy9HpSgb+JKCZBCkseDDOUvfi53BpjL+RKjEPH32rkO
	YRkBJYIGdJPmZyJVxUG3kM1rpCkoNY8c=
X-Gm-Gg: ASbGncv10928o7r/4HOUnS4EzywHu1PCtmjHbIuN3fs4WpIJvktwFFZ51f3Cd5Bk/GH
	LWRxEz/zR1nHlnj8nEPJFC5oFhcU3IbjBgq/9KCNFKPwVuI5MJ2NQtWGjjliAZ1Uqd56/0ZjBxv
	iNnlAkcebJgkzxJSvHcnC50f2Pd6IBr971cEA2x448tc8w7Dg6+TVOUxnpE8zSLumL8RPCI0GRD
	4fCMVOQBwL/Z+ufJBc18biD9wFHcOyHlUXg2Q/BVFaNYyDOUR72bmFfA+NX/lxml3zgmrsRq4uD
	xPhgcAup5q7UivX6YXG17istD47s
X-Google-Smtp-Source: AGHT+IHcXowkINkhQ3ERa2rsWqjqCYAPEDw4w8SICRKFx3hz55wLbAQS6ONg0lhBh9g54+4p/dlASc+/Ja6COtqNeOQ=
X-Received: by 2002:a05:6000:2c11:b0:42b:3ee9:4776 with SMTP id
 ffacd0b85a97d-42cc1abe2bbmr45599683f8f.5.1764696448376; Tue, 02 Dec 2025
 09:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com> <aS79vYLul06oLPT2@google.com>
In-Reply-To: <aS79vYLul06oLPT2@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 09:27:17 -0800
X-Gm-Features: AWmQ_bnlq4JhNpbkhNFxuTrgKuE2gLgLAOiOHOiDkrKg3T9ma9EypN-3NmGfOZw
Message-ID: <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, hust-os-kernel-patches@googlegroups.com, 
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:55=E2=80=AFAM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Tue, Dec 02, 2025 at 10:38:55AM +0000, Matt Bobrowski wrote:
> > On Tue, Dec 02, 2025 at 03:09:42PM +0800, =E6=A2=85=E5=BC=80=E5=BD=A6 w=
rote:
> > > Our fuzzer tool discovered a NULL pointer dereference vulnerability i=
n the BPF subsystem. The vulnerability is triggered when a BPF LSM program,=
 attached to the `bpf_lsm_mmap_file`, receives a NULL pointer for the `stru=
ct file *` argument during an anonymous memory mapping operation but attemp=
ts to dereference it without a NULL check.
> > >
> > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > >
> > > ## Root Cause
> > >
> > > The crash is caused by a NULL pointer dereference within an eBPF prog=
ram attached to the `bpf_lsm_mmap_file` LSM hook. The trigger occurs when a=
 user calls the `mmap` syscall with the `MAP_ANONYMOUS` flag. This action c=
reates a file-less memory mapping, causing the kernel to invoke the `securi=
ty_mmap_file` hook with a NULL `struct file *` argument. If the attached BP=
F program assumes this pointer is always valid and attempts to dereference =
it without a NULL check, it immediately causes a page fault, leading to a k=
ernel panic.
> >
> > Thanks for the report. Can confirm, and a more simplified reproducer
> > can be found below:
> >
> > BPF:
> > ```
> > SEC("lsm.s/mmap_file")
> > int BPF_PROG(mmap_file, struct file *file)
> > {
> >         bpf_printk("i_ino=3D%llu", file->f_inode->i_ino);
> >         return 0;
> > }
> > ```
> >
> > Stimulus:
> > ```
> > #include <stdio.h>
> > #include <string.h>
> > #include <sys/mman.h>
> >
> > int main(int argc, char** argv) {
> >   void* p;
> >
> >   p =3D mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
> >            MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >   if (p =3D=3D MAP_FAILED) {
> >     perror("mmap");
> >     return 1;
> >   }
> >
> >   memset(p, 0, 4096);
> >   munmap(p, 4096);
> >   return 0;
> > }
> > ```
> >
> > My initial thought here is that bpf_lsm_is_trusted() is treating
> > pointer arguments provided to security_mmap_file() simply as
> > PTR_TRUSTED, when in reality it should be something like PTR_TRUSTED |
> > PTR_MAYBE_NULL instead. Anyway, I can take a look and send through an
> > appropriate fix.
>
> So, thinking about this a little I think we have a couple options when
> it comes to addressing this. We can either:
>
> a) Add bpf_lsm_mmap_file() to the untrusted_lsm_hooks set. This will
> effectively mark the struct file pointer argument passed into
> bpf_lsm_mmap_file() as being untrusted (i.e. the register will not
> carry a PTR_TRUSTED type). The caveat with this approach however is
> that it'll have negative effects (i.e. cannot be supplied to BPF
> kfuncs that accept KF_TRUSTED_ARGS arguments) on those struct file
> pointer arguments that are considered to be valid and trusted.
>
> b) Update the generic LSM_HOOK() declaration for mmap_file
> (security_mmap_file()) within lsm_hook_defs.h such that the struct
> file pointer argument name contains a "__nullable" suffix. This will
> allow btf_ctx_access() to apply the PTR_MAYBE_NULL type onto the
> backing register holding a reference to the struct file pointer,
> ultimately forcing the BPF program to perform a NULL check before
> attempting to dereference it. The caveat with this approach is that
> BPF program verification, and ultimately its runtime safety
> guarantees, would be tied in with generic LSM infrastructure which I
> don't think is a good idea. Subtle breakage could occur literally at
> any point.
>
> c) Provide an override declaration/definition for bpf_lsm_mmap_file()
> within include/linux/bpf_lsm.h and kernel/bpf/bpf_lsm.c such that the
> struct file pointer argument is named file__nullable instead. Similar

I don't yet see how you can accomplish this, but it's indeed the best
option.
There is already:
FUNC 'bpf_lsm_mmap_file' type_id=3D...
Magic hack to
#define LSM_HOOK(RET, DEFAULT, NAME, ...)       \
noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
?

or a flavor named with a distinct suffix ?
bpf_lsm_mmap_file___suffix(struct file *file__nullable, ...) ?

To address the same issue with tracepoints we went with
raw_tp_null_args[].
It's ugly, but gets the job done. We can probably apply it
to lsm args too.

tbh option (b) could have been a choice or even:
-int security_mmap_file(struct file *file, unsigned long prot,
+int security_mmap_file(struct file *file__nullable, unsigned long prot,

but it's an operational headache due to different subsystems/maintainers.

Long term the plan is to wait for gcc/pahole to fully support
btf_decl_tags and switch to that.

