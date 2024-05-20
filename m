Return-Path: <bpf+bounces-30038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A571D8CA22A
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7852824B1
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2701384BD;
	Mon, 20 May 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CHmfj0dG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830C13848D
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230669; cv=none; b=pwyeoOAB+kpFnPuKywYE+VR2lFJMZXk2HmoxLm9sZF/qujHfwLejUAnMG5VJzH2UZMAAkgyddg+ZMlkePuld1hRiGYzz87QNtTxNLl5JD/kF7U2qNRU+tZSk0OMmdwNelnBy2EsJtUQAErdMqdXKRzz0zJJBpRylwZD/oNKAifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230669; c=relaxed/simple;
	bh=YrF+BGB8KkA20GPMWSqiSRn6DYf3paXMT8yMVBT+jSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ7CEu/H4thw33mDeMeGsp2sRYN6cxhJISPDFSv0LSx5QRmi5GGZZXbVhepWrQD0zZBQXDre5XLzjxgIckUuW+HH8A9g7+ahVARKMDaR8sVixMRqjR4SUiDZUVUOJnHt9dSID47+kHdoqMLTepf4YLurH8TMRZhYzKkez5hR0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CHmfj0dG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bec6bab2bso30945467b3.1
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716230666; x=1716835466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUBLBSrsQ9qU9W/MCb1o7PdEzonP2nGcujZe+jtBzUg=;
        b=CHmfj0dG/dfHB5J5tRmNRw5zHNb1PTbyhUAqVvw8YouKRqPhXz+rYB5655qI/wMgfC
         PWmk0Y3NjrJtgpdJ3/mluq2W1lPj9q6Adz3azKRgR1xsqaZLi5yP4BlvrRBw3awXwVkG
         XgqZTfE9wV91CEPPDPdhjnewVy6c7KvPtcf6jSklNR39A/PNhH4J8Kv1ET29O1sr+2wE
         x9C2JRxYZIKLOPvPtfOlRIJE8mik6uRI+5RgcAfRjY7lS3wvBTHN8DzvDnFy9R66NAXB
         6Uwz7nEfvhCT0Xmpm0C9zwcqarBe8Rrguf16uI2tkXaYd8yERIFXv8bwFhK+GGTHc8iB
         0rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230666; x=1716835466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUBLBSrsQ9qU9W/MCb1o7PdEzonP2nGcujZe+jtBzUg=;
        b=X0e6sg3j5sc0N3n9VyuYvyHLW8PCgXIyem3QtQqY2oQz2Ddn9Ic5HzZAfUkLWFC66b
         KF8wdQfKwWp6ByWlDGwO4PC8oSdj5CaRNiAaGKtbqjCwGyRw0GVt4GqjJZYDdoKq9gFl
         AxCJygLjkk3GSJsNDRe31S+k72YRnxJdFVmfoSU2YGwIDBrDvd3C3fATnMaQSnKj37NI
         yGZuEdiapqATePrdnhMAK7Hm3zs2124aM9PhTq1Q4kCq/Sw8fUhQIgvHrdSlZfz24oyP
         LsqCL0eQiiDaF4E2dsc9xnoZ8Flj+CnKcaCIdU+rM5EAYwy7lM/HYK8lRIWTK47PyWN6
         sM8g==
X-Gm-Message-State: AOJu0Yzyy4Eu6q0Gy4oY5wr17+Ov7CCJ87sFn5lV1T8fptpZ5mRp8z6+
	7I8pmZNzu7nKfjUvoeNeWUajoeBFokX6zf9qurjehOuJAeWyLUr25rgviGcD2X8M/DwXrjOOSUu
	pilvaBOd66GIcb9ZHDY8JBZT3HMgPWMNQ8W7Zyg==
X-Google-Smtp-Source: AGHT+IGvyZOpdx1H3JIl7kIfbOIN88Bk9Xcg/DcZmycKNrAoDnBQxHbr227ZGQBGe//YeWl0iY2/9tS2NJGamgHvlxI=
X-Received: by 2002:a0d:e297:0:b0:627:77fe:d00f with SMTP id
 00721157ae682-62777ff81f8mr127465407b3.6.1716230665752; Mon, 20 May 2024
 11:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
 <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
In-Reply-To: <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 20 May 2024 11:44:14 -0700
Message-ID: <CABWYdi14d61j9=nei6q7YCT8ZLv2DDc1uqmY_f_DimBUAW5MCA@mail.gmail.com>
Subject: Re: bpftool does not print full names with LLVM 17 and newer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 4:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 17, 2024 at 2:51=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> >
> > Hello,
> >
> > We recently bumped LLVM used for bpftool compilation from 15 to 18 and
> > our alerting system notified us about some unknown bpf programs. It
> > turns out, the names were truncated to 15 chars, whereas before they
> > were longer.
> >
> > After some investigation, I was able to see that the following code:
> >
> >     diff --git a/src/common.c b/src/common.c
> >     index 958e92a..ac38506 100644
> >     --- a/src/common.c
> >     +++ b/src/common.c
> >     @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
> > bpf_prog_info *prog_info, int prog_fd,
> >         if (!prog_btf)
> >             goto copy_name;
> >
> >     +    printf("[0] finfo.type_id =3D %x\n", finfo.type_id);
> >         func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
> >     +    printf("[1] finfo.type_id =3D %x\n", finfo.type_id);
> >         if (!func_type || !btf_is_func(func_type))
> >             goto copy_name;
> >
> > When ran under gdb, shows:
> >
> >     (gdb) b common.c:439
> >     Breakpoint 1 at 0x16859: file common.c, line 439.
> >
> >     (gdb) r
> >     3403: tracing  [0] finfo.type_id =3D 0
> >
> >     Breakpoint 1, get_prog_full_name (prog_info=3D0x7fffffffe160,
> > prog_fd=3D3, name_buff=3D0x7fffffffe030 "", buff_len=3D128) at common.c=
:439
> >     439        func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
> >     (gdb) print finfo
> >     $1 =3D {insn_off =3D 0, type_id =3D 1547}
> >
> >
> > Notice that finfo.type_id is printed as zero, but in gdb it is in fact =
1547.
> >
> > Disassembly difference looks like this:
> >
> >     -    8b 75 cc                 mov    -0x34(%rbp),%esi
> >     -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
> >     +    31 f6                    xor    %esi,%esi
> >     +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
> >
> > This can be avoided if one removes "const" during finfo initialization:
> >
> >     const struct bpf_func_info finfo =3D {};
> >
> > This seems like a pretty annoying miscompilation, and hopefully
> > there's a way to make clang complain about this loudly, but that's
> > outside of my expertise. There might be other places like this that we
> > just haven't noticed yet.
> >
> > I can send a patch to fix this particular issue, but I'm hoping for a
> > more comprehensive approach from people who know better.
>
> Wow. Great catch. Please send a patch to fix bpftool and,
> I agree, llvm should be warning about such footgun,
> but the way ptr_to_u64() is written is probably silencing it.
> We probably should drop 'const' from it:
> static inline __u64 ptr_to_u64(const void *ptr)
>
> and maybe add a flavor of ptr_to_u64 with extra check
> that the arg doesn't have a const modifier.
> __builtin_types_compatible_p(typeof(ptr), void *)
> should do the trick.

In bpftool there's just two call sites that are unhappy if I remove
"const" in the arguments:

* this problematic one
* "GPL" literal passed

I'll send the patch to drop "const" from the struct initialization
today or tomorrow (it works great in our internal build), but I'll
leave the bigger change to you. There seem to be many places in libbpf
and I'm far from being a C expert to drive this change.

I managed to bisect clang to find the commit that introduced the change:

* https://github.com/llvm/llvm-project/commit/0b2d5b967d98

I also mentioned the commit author and they have some ideas about
UBSAN catching this (it doesn't in the current state):

* https://mastodon.ivan.computer/@mastodon/112465898861074834

