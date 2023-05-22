Return-Path: <bpf+bounces-1047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83F70CC6C
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FC62810B9
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B7174E0;
	Mon, 22 May 2023 21:31:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3D174D7
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 21:31:16 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3F9D
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 14:31:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f850b32caso677781566b.3
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684791074; x=1687383074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WipZ8PQyK4AQGRff5+7xr9p8DZQdoGZ7btQ8zI4SpIQ=;
        b=U5BQ5cYP2NrOSfOerf+URg+C68bkdaBosxTWcMxORRQkfGI0mD8WPOLbogfwh2bYWE
         g+jOSwIp3C5UCQcV3/jTK95BboNXovRbnaXpfzl0Vs5dw/h7pUN8KtvPeM4fsPw08a56
         kZZitjLQ5HXq0wrdfb6dj09WHK6AVHx14N44X//HgAe40uZFOrHakUepIXrfpjVFC49/
         rnPSAMn2oYUZX/5LIXVAdNTtXsTYq7Fw65ouC5qnlVLJs1r25XJuZ84tGoa34BIgBAy7
         rH8+mNlDQ9OL9QEZKSRRB4qX/mvLxWJC3xTedlE71QuPLvdyy283CO57CXXT1EomR0rA
         ud2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684791074; x=1687383074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WipZ8PQyK4AQGRff5+7xr9p8DZQdoGZ7btQ8zI4SpIQ=;
        b=N4KqcVG6hfR76YSmMGUJ37xaWH1qSjCzGAJHEH7g8HNFKpN/oWdu4Q/0dmwPmb/FqB
         uqV7jDQ4B6FCx7igSL3D4mKJKRXxzfDd4Wx5xapwY0qDJNDRACiKYADufRZCVlCw/vL/
         tC/i2252T1rVE8+RuO67ERCQqQOXjNTBr9Q1ghE3Ma/UAvNQFiIaGvB02mZ5db8zI/f8
         jVUp0KJ2VYKSX5bgfA4kucC5nvQrK9esH6oUL+MIEMy0sO0YfIOeNKFf3PasDxqKlRcL
         55YOXIw6m7cCh40q6kQt7cAW0GZCvtSaQ7tnwpPS5lOrsZDcHmkJaS7/2/GdYPFt5Jzd
         dX4A==
X-Gm-Message-State: AC+VfDzWeEaJeMbL1OuTOBqilszp6XH3Nq9/H946NpzaeQ+S9ymiaPxk
	PpDZEG9E3/jfOVBhKDfL77UECVq5khsdgOxTDiU=
X-Google-Smtp-Source: ACHHUZ7/rtQB9yNHLXgFXNTd9uPH5QCkRJ2pBxju77Ml3sU8lEEO8F3BkJftA2SGIeOWiHx54Yv8+Piayw35bcLpL7A=
X-Received: by 2002:a17:907:846:b0:96f:4db5:df69 with SMTP id
 ww6-20020a170907084600b0096f4db5df69mr10564413ejb.23.1684791073451; Mon, 22
 May 2023 14:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava>
 <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com> <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
In-Reply-To: <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 May 2023 14:31:01 -0700
Message-ID: <CAEf4BzZZ1yP1_2zkGQnp_Zusn_z702eSi8h8ExEkTS8sfmk8_Q@mail.gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yafang Shao <laoar.shao@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 18, 2023 at 11:26=E2=80=AFAM Yonghong Song <yhs@meta.com> wro=
te:
> > > I wonder now when the address will be stored as number (not string) w=
e
> > > could somehow generate relocation records and have the module loader
> > > do the relocation automatically
> > >
> > > not sure how that works for vmlinux when it's loaded/relocated on boo=
t
> >
> > Right, actual module address will mostly not match the one in dwarf.
> > Some during module btf load, we should modify btf address as well
> > for later use? Yes, may need to reuse some routines used in initial
> > module relocation.
>
>
> Few thoughts:
>
> Initially I felt that single FUNC with multiple DECL_TAG(addr)
> is better, since BTF for all funcs is the same and it's likely
> one static inline function that the compiler decided not to inline
> (like cpumask_weight), so when libbpf wants to attach prog to it
> the kernel should automatically attach in all places.
> But then noticed that actually different functions with
> the same name and proto will be deduplicated into one.
> Their bodies at different locations will be different.
> Example: seq_show.
> In this case it's better to let libbpf pick the exact one to attach.
> Then realized that even the same function like cpumask_weight()
> might have different body at different locations due to optimizations.
> I don't think dwarf contains enough info to distinguish all the combinati=
ons.
>
> Considering all that it's better to keep one BTF kind_func -> one addr.
> If it's extended the way Alan is proposing with kind_flag
> the dedup logic will not combine them due to different addresses.

I've discussed this w/ Alexei and Yonghong offline, so will summarize
what I said here. I don't think that we should go the route of adding
kflag to BTF_KIND_FUNC. As Yonghong pointed out, previously only vlen
and kind determined byte size of the type, and so adding a third
variable (kflag), which would apply only to BTF_KIND_FUNC, seems like
an unnecessary new complication.

I propose to go with an entirely new kind instead, we have plenty of
them left. This new kind will be pretty kernel-specific, so could be
targeted for kernel use cases better without adding unnecessary
complications to Clang. BTF_KIND_FUNCs generated by Clang for .bpf.o
files don't need addr, they are meaningless and Clang doesn't know
anything about addresses anyways. So we can keep Clang unchanged and
more backwards compatible.

But now that this new kind (BTF_KIND_KERNEL_FUNC? KFUNC would be
misleading, unfortunately) is kernel-specific and generated by pahole
only, besides addr we can add some flags field and use them to mark
function as defined as kfunc or not, or (as a hypothetical example)
traceable or not, or maybe we even have inline flag some day, etc.
Something that makes sense mostly for kernel functions.

Having said all that, given we are going to break all existing
BTF-aware tools again with a new kind, we should really couple all
this work with making BTF self-describing as discussed in [0], so that
future changes like this won't break older bpftool and other similar
tools, unnecessarily.

Which, btw, is another reason to not use kflag to determine the size
of btf_type. Proposed solution in [0] assumes that kind + vlen defines
the size. We should probably have dedicated discussion for
self-describing BTF, but I think both changes have to be done in the
same release window.

  [0] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=3D=
Nuc1g8JPFC34MA@mail.gmail.com/#t

>
> Also turned out that the kernel doesn't validate decl_tag string.
> The following code loads without error:
> __attribute__((btf_decl_tag("\x10\xf0")));
>
> I'm not sure whether we want to tighten decl_tag validation and how.
> If we keep it as-is we can use func+decl_tag approach
> to add 4 bytes of addr in the binary format (if 1st byte is not zero).
> But it feels like a hack, since the kernel needs to be changed
> anyway to adjust the addresses after module loading and kernel relocation=
.
> So func with kind_flag seems like the best approach.
>
> Regarding relocation of address in the kernel and modules...
> We just need to add base_addr to all addrs-es recorded in BTF.
> Both for kernel and for module BTFs.
> Shouldn't be too complicated.

yep, KASLR seems simple enough to handle by the kernel itself at boot time.

