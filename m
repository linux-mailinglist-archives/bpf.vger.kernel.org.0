Return-Path: <bpf+bounces-10072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831797A0C4D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692711C20A87
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB3266B2;
	Thu, 14 Sep 2023 18:14:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3763266A5
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 18:14:34 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E81FD0
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 11:14:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500c37d479aso2114947e87.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715272; x=1695320072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+px6xB3dKSOuOKTUx8ifL1ajg/qno+d0d5z5ssjqDw=;
        b=kc8FV9IbXiUdwKlVHQmHpeNXtM7RDDp5R9f4YMwtcObjgiYsXxcJvAWpyG9LJ0YQjg
         enLFyfVqMkd1gQ03Lhoh1kEyKQfXMj57iHEBvGl+IuGpxwneFx+va0ipbGP49x6KUxOJ
         NVUU8hMXHw/P+60u4OxeK07w/ntnzO6sNMj5BegxHCPq8LiRc9D9/XunxxErlhLfq7g8
         EV5Do3gdOhgny2TdG2yT25rh+1W26M+yn3jT/MOmeSMl54W4RhjwPyoXIfzaxoL3r8G5
         //Um39okrPmLmHovC9QeEIrChpz8j1M8JJpiQD08OnIBNXbe9DFzJOHUHCsiEFSUI3yC
         flnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715272; x=1695320072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+px6xB3dKSOuOKTUx8ifL1ajg/qno+d0d5z5ssjqDw=;
        b=FQ+bgK1939qn9NJK5HvXKfuS0bRu7fbABE7RR6hme0Gc8PtLqrTsrRbxBYuZ8rXnmT
         a1MvrUXvvcULXWdLdAeLx2ERn4Zz0CUFmvyG6mSyqe41qcVyXnszMwaGLSxM4eLjfcAf
         shttQt8kvvJ/VsOaQ67C6JPGi28/ftQuMLzSUZ7mwVQz3Pz8OPw0J6YMDPGG6Qs5FMEL
         z9JNp5eE1jMLTQk1SCcxnSKcTx7j+7NuUqV1JcDs4vOVyMsDiQWEPdYrAW4XP3ikCbs5
         zWNCh9UPEIq72T9HN4J+hV9rxbOHrjvBVQB+hMhtv7Ei0uCQR7uE2qklWZkFu4I0/P53
         A+Xw==
X-Gm-Message-State: AOJu0YzhDR/pnOQaqvx9a6rBNek50phUHdmnsBI81H7Clru2M1oyd543
	K7BX9sXW1Q0Oq93+Jirf46C1rqpYPcmUmZu9BKo=
X-Google-Smtp-Source: AGHT+IE/SAIvZUH2mYGIhXW2D+jjNFI/gSZEHoEVhKgyJbu/+f7/e/YwjgdnHrpcrFK4eNBJ/51d8t4cO7W03tJYSSc=
X-Received: by 2002:ac2:592d:0:b0:500:a6c1:36f7 with SMTP id
 v13-20020ac2592d000000b00500a6c136f7mr4800523lfi.3.1694715271697; Thu, 14 Sep
 2023 11:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava> <ZQLBm8sC+V53CIzD@krava> <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
 <ZQLX3oSCk95Qf4Ma@krava>
In-Reply-To: <ZQLX3oSCk95Qf4Ma@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 11:14:19 -0700
Message-ID: <CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 2:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 14, 2023 at 05:30:51PM +0900, Masahiro Yamada wrote:
>
> SNIP
>
> > > > so the change is about adding unique id that's basically path of
> > > > the object stored in base32 so it could be used as symbol, so we
> > > > don't really need to read the actual file
> > > >
> > > > the problem is when BTF_ID definition like:
> > > >
> > > > BTF_ID(struct, cgroup)
> > > >
> > > > translates in 2 separate objects into same symbol name because of
> > > > the matching __COUNTER__ macro values (like 380 below)
> > > >
> > > >   __BTF_ID__struct__cgroup__380
> > > >
> > > > this change just adds unique id of the path name at the end of the
> > > > symbol with:
> > > >
> > > >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5U=
GK3DQMVZHG
> > > >
> > > > so the symbol looks like:
> > > >
> > > >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > > >
> > > > and is unique over the sources
> > > >
> > > > but I still hope we could come up with some better solution ;-)
> > >
> > > so far the only better solution I could come up with is to use
> > > cksum (also from coreutils) instead of base32, which makes the
> > > BTF_ID_BASE value compact
> > >
> > > I'll run test to find out how much it hurts the build time
> > >
> > > jirka
> >
> >
> >
> > Seems a bad idea to me.
> >
> > It would fork a new shell and chsum for all files,
> > while only a few of them need it.
>
> right, I have a change to limit this on kernel and net directories,
> but it's still bad
>
> >
> > Better to consult BTF forks.
>
> perhaps there's better way within kbuild to get unique id/value
> for each object file?

let's just use __LINE__ + __COUNTER__ for now and teach resolve_btfids
to fail and complain loudly about duplicate symbols?


This will give us time and opportunity to implement a better approach
to .BTF_ids overall. Encoding the desired type name in the symbol name
always felt off. Maybe it's better to encode type + name as data,
which is discarded at the latest stage during vmlinux linking? Either
way, this baseid hack seems worse and unnecessary.

>
> thanks,
> jirka
>

