Return-Path: <bpf+bounces-8398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94590785EF3
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7451D281276
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE41F196;
	Wed, 23 Aug 2023 17:53:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF0C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:53:39 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317BE7E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:53:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9a2033978so91083281fa.0
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692813216; x=1693418016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My0jrSUSASUI6AFhA1YUi6F1Ex1l6ZY9A/bnBxWZz0Q=;
        b=nh+Uha3GJiZIP0I+I8LfeXwk6U1VzZDmICwwqat6gcMAcbIG+NB4EpRdntJzHzf0q4
         T90vsSX+DU42U84VQwk/CGsxIqUpxpQCAuvpj4yoliC6gMLH98HMJhgZxHQV8ZLLoVGq
         C1uXL6ByJ/VCZMclILUCdxqbpujvxRm6sd+9ycbHGwB2bxn6tXPPkFojYExHC0zTxkTX
         Tasfe7X2daE1i0/vYROGhHWAHq6UnLl21h5g1uY4HopzvcC/Su+aaziRzEcGM6KSpxp/
         Umu8GhTyl/mVUi2EX3J4TXD+iBlNpt/MtzVSCOhRYSUuIXMuFJbVPC1z7/Ih9TRtndIJ
         LzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692813216; x=1693418016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My0jrSUSASUI6AFhA1YUi6F1Ex1l6ZY9A/bnBxWZz0Q=;
        b=KB2nS4GRnpT09Y9/8uc2+FNY7Kix0LBTUKuU7XpJZCoASrUEiMwzkdDuB0qNNhuLAv
         phd0vdkYIT0jjAmCxCL4XOCE0rPuUs5+O8H9yak2mA4O7ekDSzll2KUjbHrRX8EDxGgb
         XnD/vO4SuuTakvED8Jw4QCMxAFQ/lnqXbdjDebYwCExZFqSRLUi2B+dOVyl+wjAWIvIy
         1kpzo/XQ0i5IWOkIFamYdMABXWqdIWPA7EtEnGtaC9FISZjHVt4ZFagpZLhc7k156LTS
         RFYI3F8IHhQa69IQRKekG6MA0Dd+fyuUilnKEm7va2sOQDNvXDhbNPJbXpq36aKkhX/u
         TcNg==
X-Gm-Message-State: AOJu0YyagXsj7tsjpE46w/toCoEZHxSC7/nyjJi633Uykuy9RHUjnWbU
	dyg4qhA7A5uaSDAT2YjGReUUY5JyJD3b762kz6I=
X-Google-Smtp-Source: AGHT+IHq203VdU5WEGp34KvCeWTgD9+zXo21Ij1qCZtIKGrFYsEJmtvYJe9jQbGbgzxvBeYqhHm+PMdrPGoTN+CwXxE=
X-Received: by 2002:a2e:8605:0:b0:2bc:c650:81b with SMTP id
 a5-20020a2e8605000000b002bcc650081bmr5189811lji.15.1692813215909; Wed, 23 Aug
 2023 10:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
 <36463876-1370-71d6-78f3-2350278f61c7@linux.dev> <CAADnVQK4LVKS7QUYbVOzHFLj1zv9_vieOVAqcoCULZorQ4wjMA@mail.gmail.com>
 <CAEf4BzbU=Qp3YoYGQJSOQ=WJBZbJsTHSaODnxtK0ydxK5+mUiw@mail.gmail.com>
In-Reply-To: <CAEf4BzbU=Qp3YoYGQJSOQ=WJBZbJsTHSaODnxtK0ydxK5+mUiw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 10:53:24 -0700
Message-ID: <CAADnVQJ_4H6yiW6KNcBheUzeqeYOYF4rSOMHWs30HJHobb7FFg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:14=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > Long term we need to think how to extend bpf ISA with alloca.
>
> To be frank, I'm not following how alloca is relevant here. We don't
> have anything dynamically sized on the stack.
>
> Unless you envision protocol where we have a separate function to get
> size of iter struct, then alloca enough space, then pass that to
> bpf_iter_xxx_new()? Not sure whether this is statically verifiable,
> but given it's long-term, we can put it on backburner for now.

With alloca bpf_for_each() macro can allocate whatever stack necessary.

In other words:

struct bpf_iter_task_vma *it;

it =3D bpf_alloca(bpf_core_type_size(struct bpf_iter_task_vma));
bpf_for_each2(task_vma, it, ...) { .. }

While struct bpf_iter_task_vma can come from vmlinux.h

size of kern data struct is CO-RE-able, so no worries about increase
in size due to maple tree or lockdep on/off.
And no concern of failing allocation at run-time.
(the verifier would reject big stack alloc at load time).

