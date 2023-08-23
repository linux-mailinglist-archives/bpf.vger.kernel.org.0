Return-Path: <bpf+bounces-8395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD1785E84
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063E3281241
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CB1F181;
	Wed, 23 Aug 2023 17:26:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0476C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:26:50 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E16EE67
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:26:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so90995481fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692811604; x=1693416404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo8BRYNTIFSkJrffus9YUnh5ulw3pIHq33YKNgUSZn0=;
        b=mGUMX/zsXFTf4oWxryfUmoY/piEpFqZY68BTIgLiaA8J+Nx2g79IUt4qPdgnst/UWp
         U98Jq2XhjUKDrZwe3q7EAJq4mWXozFWDBfKByZigeHagboVTuMlg1qYsEcR/HrwAdAQc
         a/ysww7ckrOq+wHzR8IwziykEm/C1NzjhP6fY3K7UIBN6l6vD15dl0I+EnSlw8hwOTh7
         qHzHpYNCKIoxjpeptRLfu5Mf7cixJY5O2XLci6gXUpffXnMgE8gOlNwiSzuCyb7V2v5D
         KVggrkZoFu0/JgZ50mfMsuPrf7C+hYzUgmK+f5ltIse5AS132iDnbzDgznmVclW9BCYf
         YmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692811604; x=1693416404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mo8BRYNTIFSkJrffus9YUnh5ulw3pIHq33YKNgUSZn0=;
        b=XtmSUtrtmKVRkRG8nCcMcavt1KIQ6E0JChdkszK1lEz6kAmp45jRiNw55HCgm0Kj1F
         swIEfFL62kroFxaJcs01Fx0+J2oMedPjm29Eqd7V4fJYe+i8PFPEKGpAwgmIf+MpVygG
         kOKQ4wJpIU6afCr0D5RjtO43wkas4OjSrBK83OoOve3WNDCkmCwmqHy+eP8TZC9PBh9c
         rraS6pzHXhQtuClD0w54j4pfX5EAsW8zbzRtUoQJ6lcR1WkJjMULloroAkAiJrSXF9Ur
         GZNbuSa7zCTIOKUewkil156NKTrourzcl3/AGyJu6wWfumoM/WRD03b43RJJq447j0Oe
         H1Tw==
X-Gm-Message-State: AOJu0YxUS8ppOZ2Hz0s+Bn5n3URX3/7jcQB7n1Q+RVy2EtjIDvW9AWV4
	FX/Njq8aO3jhFFOE+IrIoAbo0BQx8qX01zsM8WQ=
X-Google-Smtp-Source: AGHT+IFPOpwQQTRkKGIwhDvLUR5IYDtOPHukADNYVap5ernogjfyVNHTtlIfZ9c2lycbF2jowxzSjyjomweV0urP4mg=
X-Received: by 2002:a2e:7d01:0:b0:2b9:ee3e:2412 with SMTP id
 y1-20020a2e7d01000000b002b9ee3e2412mr11232927ljc.22.1692811604240; Wed, 23
 Aug 2023 10:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
 <36463876-1370-71d6-78f3-2350278f61c7@linux.dev> <CAEf4BzbpjVbXjmKHo3dshR4qVWUwCK+1LVZb-6CJ1TM5T+r3AA@mail.gmail.com>
In-Reply-To: <CAEf4BzbpjVbXjmKHo3dshR4qVWUwCK+1LVZb-6CJ1TM5T+r3AA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 10:26:33 -0700
Message-ID: <CAADnVQKcG9tOFw3xtEa8y2KvVNZaTTnBSmbX9sdrqp-vpEejTg@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:07=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Yes, I think we'll have to have BUILD_BUG_ON. And yes, whoever
> increases vma_iter by more than 13 bytes will have to interact with
> us.

A bit of history.
Before maple tree the vma_iterator didn't exist. vma_next would walk rb tre=
e.
So if we introduced task_vma iterator couple years ago the maple tree
change would have grown our bpf_iter_task_vma by 64 bytes.
If we reserved an 8 or 16 byte gap it wouldn't have helped.
Hence it's wishful thinking that a gap might help in the future.

Direct stack alloc of kernel data structure is also dangerous in
presence of kernel debug knobs. There are no locks inside vma_iterator
at the moment, but if it was there we wouldn't be able to use it
on bpf prog stack regardless of its size, because lockdep on/off
would have changed the size.
I think it's always better to have extra indirection between bpf prog
and kernel object.

