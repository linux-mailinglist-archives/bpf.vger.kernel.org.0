Return-Path: <bpf+bounces-10186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99417A284B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B635C1C20F1B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39A19BD3;
	Fri, 15 Sep 2023 20:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063291805C
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:41:40 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34618D
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 13:41:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ffe67b5daso93514f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694810497; x=1695415297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsmwCyMERanGcX5LEJwV1E7MJ5UloYIvZ7Y9MjRRTaU=;
        b=cUB5KHPFB/wAtOUDYIVUeYIkBsMJo46zDSZpkdG/c1Od8dIqzIoM1ThR0sBRKxHAHm
         aKbLWinjhe549Fuu7KCq9IMlWCZidLLK9KVhT8k5qusO08UZ9vjHOOH+Y07SJ5UgcRSz
         yTdkqwEM/G2AqhbWnRvjTuPhaJgvTwByQieKBrobViKEAHdsLV7DxVpIzgnaGKYS1yLj
         XNlHZlkDQLo7v+X4x2Jfju2BW9EXgRWaxHuNRMum6l5bRH8zzrsxdkDqxbTd+RtIZMaD
         gZG7+UCK5FeovpdCsqfpj+ewLJeiIOk4Pl9z7f+9eogKPl1CsJMFZpk+NXECfB0YvLtH
         svgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810497; x=1695415297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsmwCyMERanGcX5LEJwV1E7MJ5UloYIvZ7Y9MjRRTaU=;
        b=m9lpsi2lDeq4dddv+SpkYNuBzjqqJlWouoGzm8xS8YwX4KH8d77Ws4IcmAtL3RYmwE
         VwXOvPHbEGAnEDsBJmQvuNe8ljD3AGS+bkVgAQ+vKm1NoArxlRpAJk3H+AJqD3oFsw8i
         gTC/P3/152qQfeNeN7lr6Wlzygx2q/Cw+Y45PmCZSANRuwxQfaLnQ0fFOvK/GoJuha8z
         5MiQaO2FoJ8XtCU9SoipreKqevSEZxWztfXO364HOQZAkYKRLtlqKV6tEImLdC8BvM5L
         OTCY7ly0Wd+WAH/xVcXJtmcROrSy3ibm4mSZZIt2ib0ZQdA6Cuawue928iwln5FvGNMp
         0vJg==
X-Gm-Message-State: AOJu0YxK8ZzPpBuO+B7TOYDxO4M9vyTTkZX7ipouyY9c3xW+Hr16nNZf
	mcVyuSkyIGO+ExMbkxd2NeCjNYsM9ETGwml+z6Q=
X-Google-Smtp-Source: AGHT+IH3j2ZsQ/aR51o2TfvxS5E61tFZc51Q4hGXRGse6Up66wK5mWLQj32gyCjw6U/5T1F8HN8U3PWQNHqeTxzPbd0=
X-Received: by 2002:a5d:684d:0:b0:31f:ec91:39a7 with SMTP id
 o13-20020a5d684d000000b0031fec9139a7mr2385360wrw.14.1694810496570; Fri, 15
 Sep 2023 13:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava> <ZQLBm8sC+V53CIzD@krava> <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
 <ZQLX3oSCk95Qf4Ma@krava> <CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com>
 <ZQQVr35crUtN1quS@krava>
In-Reply-To: <ZQQVr35crUtN1quS@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Sep 2023 13:41:25 -0700
Message-ID: <CAEf4BzZe_27FPzMwjaU3d5gPuyXX3iTQJGzT64CCTZLEfpQUvQ@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 1:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 14, 2023 at 11:14:19AM -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 14, 2023 at 2:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Sep 14, 2023 at 05:30:51PM +0900, Masahiro Yamada wrote:
> > >
> > > SNIP
> > >
> > > > > > so the change is about adding unique id that's basically path o=
f
> > > > > > the object stored in base32 so it could be used as symbol, so w=
e
> > > > > > don't really need to read the actual file
> > > > > >
> > > > > > the problem is when BTF_ID definition like:
> > > > > >
> > > > > > BTF_ID(struct, cgroup)
> > > > > >
> > > > > > translates in 2 separate objects into same symbol name because =
of
> > > > > > the matching __COUNTER__ macro values (like 380 below)
> > > > > >
> > > > > >   __BTF_ID__struct__cgroup__380
> > > > > >
> > > > > > this change just adds unique id of the path name at the end of =
the
> > > > > > symbol with:
> > > > > >
> > > > > >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4D=
GF5UGK3DQMVZHG
> > > > > >
> > > > > > so the symbol looks like:
> > > > > >
> > > > > >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > > > > >
> > > > > > and is unique over the sources
> > > > > >
> > > > > > but I still hope we could come up with some better solution ;-)
> > > > >
> > > > > so far the only better solution I could come up with is to use
> > > > > cksum (also from coreutils) instead of base32, which makes the
> > > > > BTF_ID_BASE value compact
> > > > >
> > > > > I'll run test to find out how much it hurts the build time
> > > > >
> > > > > jirka
> > > >
> > > >
> > > >
> > > > Seems a bad idea to me.
> > > >
> > > > It would fork a new shell and chsum for all files,
> > > > while only a few of them need it.
> > >
> > > right, I have a change to limit this on kernel and net directories,
> > > but it's still bad
> > >
> > > >
> > > > Better to consult BTF forks.
> > >
> > > perhaps there's better way within kbuild to get unique id/value
> > > for each object file?
> >
> > let's just use __LINE__ + __COUNTER__ for now and teach resolve_btfids
> > to fail and complain loudly about duplicate symbols?
>
> ok, will send that.. but it fails during link before resolve_btfids
> takes place
>
> >
> >
> > This will give us time and opportunity to implement a better approach
> > to .BTF_ids overall. Encoding the desired type name in the symbol name
> > always felt off. Maybe it's better to encode type + name as data,
> > which is discarded at the latest stage during vmlinux linking? Either
>
> hum, so maybe having a special section (.BTF_ids_desc below)
> that would have record for each ID placed in .BTF_ids section:
>
> asm(                                           \
> ".pushsection .BTF_ids,\"a\";        \n"       \
> "1:                                  \n"       \
> ".zero 4                             \n"       \
> ".popsection;                        \n"       \
> ".pushsection .BTF_ids_desc,\"a\";   \n"       \
> ".long 1b                            \n"       \
>
> and somehow get prefix and name pointers in here:
>
> ".long prefix
> ".long name
>
> ".popsection;                        \n");
>
> so resolve_btfids would iterate .BTF_ids_desc records and fix
> up .BTF_ids data..
>

Something like that. I don't think it's even a regression in terms of
vmlinux space usage, because right now we spend as much space on
storing symbol names. So just adding string pointers would be already
a win due to repeating "struct", "func", etc strings.


> we might need to do one extra link phase to get rid of the
> .BTF_ids_desc secion

Hopefully we can find a way to avoid this, we already do like 3 link
phases at least (for kallsyms), so doing all that on the first one and
then stripping it out using link script at subsequent one would be
best.

>
> > way, this baseid hack seems worse and unnecessary.
>
> yes, it's bad
>
> jirka

