Return-Path: <bpf+bounces-8400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE39785F5D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0141281328
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401F1F93A;
	Wed, 23 Aug 2023 18:13:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DE1F923
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 18:13:25 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480CCE6
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 11:13:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso7693227a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692814402; x=1693419202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4MDqlgXVmxAmtSxftRbMxV5grolyOFXeFh6MuMlBxw=;
        b=ditEhH424KjM+AwFNvytz6PCnh+WkMosjjZnhhJFTfElIoenSGlqPgps8XWhPUPnUg
         FBBXimxSUQvfFSPbKI2d4rZEmEuz5ZFeubCn+pHiwt/Hc+UgwDf5H6mV7gA51//C9XEt
         /hziyVmo5XBPYYHaUAl65NxgclShlR0isiSLNc0wOnhDoQH1XDQMwDtJXQdMwLCKv92J
         A5u2+BZmPpnbToY2I4dTe0i7dsxrg3hJbicOqNkRJvGbGvaHNst/h71P6ZsxPV8O+pal
         J9lvnqmJc82nFriwQmLcsjb5JdXygrlSrOUdwSyGoOxCIkmcDmsT3pede8UCPFtOozPg
         lVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692814402; x=1693419202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4MDqlgXVmxAmtSxftRbMxV5grolyOFXeFh6MuMlBxw=;
        b=BcXkOVI9LyHh3S8imFHqJgH6kPlWzl1Wcu83hzqscRJmKqZUjdCQlf4tiCxyfmDARD
         GDQaXnpTQ0Re7rQldo/SgR75jTHNJB8BkLp6ozNXCiTbY/+R4jng9tTw0OFQcaz6lXkb
         8L+Fksj/3/J2/cCQPZ1tyxNkOXdtXP+zVZ2YAw0qJZwRVf7yKophiSNo2qgsHoy2TdCj
         FnTExYp4gIAglt3BrQrHvOsOsrGb2g6kxqYPjI/CNbBf9CBr0zxDH68y7FkMHRK+4mC+
         6GOTvm/J2dytuOBRjgr+aZV+4x490+VmqaN9Ws1rPfSj4iz241U8vaZ6hfxzJQG2FlWZ
         LmwA==
X-Gm-Message-State: AOJu0YzIZ0o5nMuENuYwoylSx2ogUp6ZGzLOtnEpIqemrOVXkkkjakRB
	6P2Lekvq9DJK/y4puy6HaoLnUqY12Q7ZEY5LLiw=
X-Google-Smtp-Source: AGHT+IHOKJl5d8EMpRZZYmmSzUlbnjHup5uvD6obXNbnamFGmCSd1ARst+l0tuK32fy0cq9vuxAvxpXVIjA/lXllXto=
X-Received: by 2002:a05:6402:74f:b0:514:9ab4:3524 with SMTP id
 p15-20020a056402074f00b005149ab43524mr9901483edy.7.1692814402246; Wed, 23 Aug
 2023 11:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
 <36463876-1370-71d6-78f3-2350278f61c7@linux.dev> <CAADnVQK4LVKS7QUYbVOzHFLj1zv9_vieOVAqcoCULZorQ4wjMA@mail.gmail.com>
 <CAEf4BzbU=Qp3YoYGQJSOQ=WJBZbJsTHSaODnxtK0ydxK5+mUiw@mail.gmail.com> <CAADnVQJ_4H6yiW6KNcBheUzeqeYOYF4rSOMHWs30HJHobb7FFg@mail.gmail.com>
In-Reply-To: <CAADnVQJ_4H6yiW6KNcBheUzeqeYOYF4rSOMHWs30HJHobb7FFg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 11:13:09 -0700
Message-ID: <CAEf4BzbLGdGLckTKQdz-txxTNk+i=APQBT7FPqF5=hDmz2oESw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 23, 2023 at 10:14=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > Long term we need to think how to extend bpf ISA with alloca.
> >
> > To be frank, I'm not following how alloca is relevant here. We don't
> > have anything dynamically sized on the stack.
> >
> > Unless you envision protocol where we have a separate function to get
> > size of iter struct, then alloca enough space, then pass that to
> > bpf_iter_xxx_new()? Not sure whether this is statically verifiable,
> > but given it's long-term, we can put it on backburner for now.
>
> With alloca bpf_for_each() macro can allocate whatever stack necessary.
>
> In other words:
>
> struct bpf_iter_task_vma *it;
>
> it =3D bpf_alloca(bpf_core_type_size(struct bpf_iter_task_vma));
> bpf_for_each2(task_vma, it, ...) { .. }

ah, I see, not a dedicated kfunc, just CO-RE relocation. Makes sense.

>
> While struct bpf_iter_task_vma can come from vmlinux.h
>
> size of kern data struct is CO-RE-able, so no worries about increase
> in size due to maple tree or lockdep on/off.
> And no concern of failing allocation at run-time.
> (the verifier would reject big stack alloc at load time).

yep, makes sense, the size will be statically known to the verifier. I
was overcomplicating this in my mind with extra kfunc.

