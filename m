Return-Path: <bpf+bounces-30036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B698CA135
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB171C21395
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E27137C40;
	Mon, 20 May 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6r5qvve"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB74C8E;
	Mon, 20 May 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225690; cv=none; b=jS4BCF06Lc/G7YdnHj2QxV1I56dSjpVnptSIXOkfIiEEtRUojFyqjZY/ub6bIx3QRjZFfx21kVhP7Oid5Jx88YBH4OHVvh9wiuObAum7iTjSBgab7JVezhehkaDJg3Iun//bhIB90GxFpIKXrwhArEDSxNUwiMbDnoSWxv3oyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225690; c=relaxed/simple;
	bh=OZnW9vfi2DUIODfpEj0uies0vDDwpGFzQDtTd1lswyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzNPc4hzWVh62MORptcgmuFdsmxyl8SylNOPPbzshyuvm2uQeNDw2/imuzTenwLK9DCDFFUiau7+DX1TtV/EsfaLdwUERP/d6nmJzyf46JwXpbn4Dpm9mH2O8YnmlvDHHyjJlGLdTtg3LldN5QQpOgGMX5QhUYn9d+CCND9+I1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6r5qvve; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so31369005e9.0;
        Mon, 20 May 2024 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716225685; x=1716830485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXeQuSHX1zYWjO9ZnWv7a/qZoDGZHXxLiPtasH0d/Zg=;
        b=Q6r5qvveLF+1rlQoAc7FZZ9r9odjGxZMMQDA0xOfMLjbmbu8W+ICi58E8Q8aHhx4Or
         PI9PkA1JO3F8tsBfjtQMhWQzbdecHm3BxyGTnjiVxfs12BpMT7MDHl/YLfvpv6a1tgKq
         RQJX57XjTpwoTNln4kMGMVkfTzvylt1Ooqk+X+zHRSRFS41moN6JLslrh+8uAsJKulk2
         q2tGsDGJZtp0bYahc4pdn1N3R2GxJoWeUNhH8DV5h7ec13BcHDUHzB3KkXAto2ViX7ss
         A6xUe0qHC1DQ45q55aJd4/17THxJcj4XmlBcUQgrK2UGntru/TkbrDn45bP7oyiZnDBF
         Y4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716225685; x=1716830485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXeQuSHX1zYWjO9ZnWv7a/qZoDGZHXxLiPtasH0d/Zg=;
        b=A/9FO8vY2Q0UgHigekb5UEPhEjDQRGuGm5aNgpLxqjkG2I0/oU+DDx6iWTebnMOUYG
         gqz50nwPJyx/webtcbiL9CDbbyHeTa4qsLeq8/LvXjkFbqQPeCtJxsSEv4aKz5FXWCLP
         bOq2q0qhuzAM653L+ccbhlnAo5A9BQXSd2wtSkzwKVa2CfdzzrPriPwBRAqP9/KjGzgG
         +l05dESQtielYyluvg+XroAxaPgtnXbWE0fnC5W32MMuwRePsYiIxfIh/Py2+o1QjT78
         kzGLr7UwocCqWXlJ06sUQ+nMjb0VaEYNyO2VAxlgEYGrkxYV5pLhTMjpg8s5KZoj/r1n
         v4sw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7yR+d3KFEvowUWuIDe7TIfwFLb37uLXjl8zLtznywbt1yrNZjA/busrqLifxZRN7U+IMzqUGXDDNIIom2gymP4BkGap5NqBoNNrCtenim5ebTZtqUedaO/kCiXwq5sLH
X-Gm-Message-State: AOJu0YzzdRi6qpjt+R8hxiNtJfbUTp0N/6W2dp0C9u4Yav8pYSpWKhI9
	FGOYDtWzpwnI9M9X/38LwfKJ6fm3aypCU9jmx+zm/2aRsNMmDynbcBJPQBgGZ9BFwg/3QC6RzWG
	vl7G3DgcuaqjpczSt0jKmeoAZFI6zsXDm
X-Google-Smtp-Source: AGHT+IGaHg1HQE3EBgrLrtWkCMk71vFjHa4um/0oQbUj73t1jTQMqJOw2usnzouGreTZoScfKYxq3IpB6ea+KJQ8bZA=
X-Received: by 2002:a05:600c:354a:b0:420:2cbe:7f16 with SMTP id
 5b1f17b1804b1-4202cbe829dmr110312045e9.34.1716225685314; Mon, 20 May 2024
 10:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
 <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com> <5cb46d34-f4a3-49c7-8dd6-df6bc87b4f25@linux.dev>
In-Reply-To: <5cb46d34-f4a3-49c7-8dd6-df6bc87b4f25@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 10:21:13 -0700
Message-ID: <CAADnVQ+jw2d81J=dJmJ9Y8EReQpOpQ9tvEv6+S4jPASR8Lza5A@mail.gmail.com>
Subject: Re: bpftool does not print full names with LLVM 17 and newer
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 10:01=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 5/17/24 5:33 PM, Alexei Starovoitov wrote:
> > On Fri, May 17, 2024 at 2:51=E2=80=AFPM Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> >> Hello,
> >>
> >> We recently bumped LLVM used for bpftool compilation from 15 to 18 and
> >> our alerting system notified us about some unknown bpf programs. It
> >> turns out, the names were truncated to 15 chars, whereas before they
> >> were longer.
> >>
> >> After some investigation, I was able to see that the following code:
> >>
> >>      diff --git a/src/common.c b/src/common.c
> >>      index 958e92a..ac38506 100644
> >>      --- a/src/common.c
> >>      +++ b/src/common.c
> >>      @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
> >> bpf_prog_info *prog_info, int prog_fd,
> >>          if (!prog_btf)
> >>              goto copy_name;
> >>
> >>      +    printf("[0] finfo.type_id =3D %x\n", finfo.type_id);
> >>          func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
> >>      +    printf("[1] finfo.type_id =3D %x\n", finfo.type_id);
> >>          if (!func_type || !btf_is_func(func_type))
> >>              goto copy_name;
> >>
> >> When ran under gdb, shows:
> >>
> >>      (gdb) b common.c:439
> >>      Breakpoint 1 at 0x16859: file common.c, line 439.
> >>
> >>      (gdb) r
> >>      3403: tracing  [0] finfo.type_id =3D 0
> >>
> >>      Breakpoint 1, get_prog_full_name (prog_info=3D0x7fffffffe160,
> >> prog_fd=3D3, name_buff=3D0x7fffffffe030 "", buff_len=3D128) at common.=
c:439
> >>      439        func_type =3D btf__type_by_id(prog_btf, finfo.type_id)=
;
> >>      (gdb) print finfo
> >>      $1 =3D {insn_off =3D 0, type_id =3D 1547}
> >>
> >>
> >> Notice that finfo.type_id is printed as zero, but in gdb it is in fact=
 1547.
> >>
> >> Disassembly difference looks like this:
> >>
> >>      -    8b 75 cc                 mov    -0x34(%rbp),%esi
> >>      -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
> >>      +    31 f6                    xor    %esi,%esi
> >>      +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
> >>
> >> This can be avoided if one removes "const" during finfo initialization=
:
> >>
> >>      const struct bpf_func_info finfo =3D {};
> >>
> >> This seems like a pretty annoying miscompilation, and hopefully
> >> there's a way to make clang complain about this loudly, but that's
> >> outside of my expertise. There might be other places like this that we
> >> just haven't noticed yet.
> >>
> >> I can send a patch to fix this particular issue, but I'm hoping for a
> >> more comprehensive approach from people who know better.
> > Wow. Great catch. Please send a patch to fix bpftool and,
>
> Indeed, removing 'const' modifier should allow correct code
> generation.
>
> > I agree, llvm should be warning about such footgun,
> > but the way ptr_to_u64() is written is probably silencing it.
>
> Yes, ptr_to_u64() cast a 'ptr to const value' to a __u64
> which later could be used as 'ptr to value' where the 'value'
> could be changed.
>
> > We probably should drop 'const' from it:
> > static inline __u64 ptr_to_u64(const void *ptr)
> >
> > and maybe add a flavor of ptr_to_u64 with extra check
> > that the arg doesn't have a const modifier.
> > __builtin_types_compatible_p(typeof(ptr), void *)
> > should do the trick.
>
> I guess we could introduce ptr_non_const_to_u64() like
>
> static inline __u64 ptr_non_const_to_u64(void *ptr)
> {
>          static_assert(__builtin_types_compatible_p(typeof(ptr), void *),=
 "expect type void *");
>          return (__u64)(unsigned long)ptr;
> }
>
> and add additional check in ptr_to_u64() like
>
> static inline __u64 ptr_to_u64(const void *ptr)
> {
>         static_assert(__builtin_types_compatible_p(typeof(ptr), const voi=
d *), "expect type const void *");
>         return (__u64)(unsigned long)ptr;
> }
>
> But I am not sure how useful they are. If users declare the variable as '=
const'
> and use ptr_to_u64(), compilation will succeed but the result could be wr=
ong.

I mean to flip the default. Make ptr_to_u64(void *) and
assert when 'const void *' is passed,
and introduce const_ptr_to_u64(const void *)
and use it in a few cases where data is indeed const.

And do the same in libbpf and bpftool.

> Compiler could do the following analysis:
>    (1) ptr_to_u64() argument is a constant and the result is __u64 (let u=
s say u64_val =3D ptr_to_u64(...)).
>    (2) u64_val has address taken and its content may be modified in the c=
urrent function or
>        through the function call. If this is true, compiler might warn. T=
his will require some
>        analysis and the warning may not be always true (esp. it requires =
inter-procedural analysis and
>        in this case, bpf_prog_get_info_by_fd() eventually goes into the l=
ibrary/kernel so compiler has no
>        way to know whether the value could change).
> So I guess it will be very hard for compiler to warn for this particular =
case.

indeed.

