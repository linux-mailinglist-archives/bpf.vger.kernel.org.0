Return-Path: <bpf+bounces-8030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D078016D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 01:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB828220E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B931B7CD;
	Thu, 17 Aug 2023 23:00:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71726F9D5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 23:00:46 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDA136
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:00:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so4092901fa.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692313243; x=1692918043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MctEsfvFNLHg7WRHPIqFjEdh1DeDKph4Mhn9IIDCa0=;
        b=L/V7ikxx+LSPr4jRNQyAlYzZU5C0WBAn40KN77Yig8VYtoAPswEiK1L/K+t7yhBBbX
         PNGrZSIgBSLmNmDE6EfJSiq1dASfbqZmcPanxhb2tvN1M6g/Z+Vo1mQ0oV5kYMjZ+jSH
         128eVR4aSrd/I852QA39OhFQZSJJ+IIW2yDxAWjy7bMtFs3VfpBPkXXha+vjt6YWodPv
         fVoYTxCrTIwPqu35iKTKnN12zGI6YaXA/Ym5Gs6wkSYz1ODyIGL95QeEK/nq5DLt09Qd
         aqda3Z/1Jk6GBVoAzun/HJA/GmTjf6Yq+GjAfi4sjOVuPqZULQ2bFQJFhpV1U7zljv3e
         o3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692313243; x=1692918043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MctEsfvFNLHg7WRHPIqFjEdh1DeDKph4Mhn9IIDCa0=;
        b=JvCUGtRj5Xuf3Q/+1KgK56oT2UPvae5kdPJwJG9f55f3rq2rVWx3wAQvmEWH9qWEqz
         C2akDSrdwW2LsNVr6caDJE7ErO98cxQvdTe1fEJiuBqmkimTnO65bxtvuFgaF0GZ5xNV
         IdinUnQ4mN7YqkbprS7M8g5FTcFHsj7/uV8NvmuX4xaqfeTndbPkrCz4JkhKuTjVzhhn
         P4WsFQS7aobRIJkzVNLPPqbB21EGwek1cl9+thjfmkteAXVPSHb+fF4dEgaUxssHzqFN
         Jq6jkzSwbdnKsrxXg1QmMg8pco0xOjTZKuJdmRgtTCnjSpw8jWpTrpmEsHlg8wjUqivS
         cKWA==
X-Gm-Message-State: AOJu0YzDu6/TIQtJZtS1uxSiSmcNfWuuoGnQv4Lps7j0dI78LpR2fFXP
	8vdnTLv5rVvX7dwuAYr2JxLXPCaTMJlX2ZHNJME=
X-Google-Smtp-Source: AGHT+IEWehboN2nW4MIFt8/NFWmKmXjv8TwDdDZAs/xdcRbJ7kaKUbA2tsAtwsMV8GnYzNjvjGYkuZcaXZEzLy0P8Fo=
X-Received: by 2002:a05:651c:106e:b0:2b9:b8ce:4219 with SMTP id
 y14-20020a05651c106e00b002b9b8ce4219mr1512219ljm.6.1692313242920; Thu, 17 Aug
 2023 16:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
In-Reply-To: <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 16:00:31 -0700
Message-ID: <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 11:35=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> ping ?

Sorry for the delay. I've been on PTO.

> On 8/3/2023 9:28 PM, Hou Tao wrote:
> >
> > On 8/3/2023 9:19 PM, Hou Tao wrote:
> >> Hi,
> >>
> >> I am preparing for qp-trie v4, but I need some help on how to support
> >> variable-sized key in bpf syscall. The implementation of qp-trie needs
> >> to distinguish between dynptr key from bpf program and variable-sized
> >> key from bpf syscall. In v3, I added a new dynptr type:
> >> BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], so
> >> both bpf program and bpf syscall will use the same type to represent t=
he
> >> variable-sized key, but Andrii thought ptr+size tuple was simpler and
> >> would be enough for user APIs, so in v4, the type of key for bpf progr=
am
> >> and syscall will be different. One way to handle that is to add a new
> >> parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_elem() =
to
> >> tell whether the key comes from bpf program or syscall or introduce ne=
w
> >> APIs in bpf_map_ops for variable-sized key related syscall, but I thin=
k
> >> it will introduce too much churn. Considering that the size of
> >> bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse the
> >> lowest 1-bit of key pointer to tell qp-trie whether or not it is a
> >> bpf_dynptr_kern or a variable-sized key pointer from syscall. For
> >> bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must be 0=
,
> >> and for variable-sized key from syscall, I could allocated a 4B-aligne=
d
> >> pointer and setting the lowest bit as 1, so qp-trie can distinguish
> >> between these two types of pointer. The question is that I am not sure
> >> whether the idea above is a good one or not. Does it sound fragile ? O=
r
> >> is there any better way to handle that ?

Let's avoid bit hacks. They're not extensible and should be used
only in cases where performance matters a lot or memory constraints are ext=
reme.

ptr/sz tuple from syscall side sounds the simplest.
I agree with Andrii exposing the dynptr concept to user space
and especially as part of syscall is unnecessary.
We already have LPM as a precedent. Maybe we can do the same here?
No need to add new sys_bpf commands.

If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we can
use new kfuncs from bpf prog and LPM-like map accessors from syscall.

