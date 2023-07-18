Return-Path: <bpf+bounces-5189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA52758859
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A2D1C20E45
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 22:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6E17AA9;
	Tue, 18 Jul 2023 22:17:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EB17AA4
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 22:17:22 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7F198E
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:17:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so96422841fa.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689718634; x=1692310634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro75IzWT8TUaDzr5+qST3eOzqpkBJ7Tqh0wDFv4DPaM=;
        b=cg8BqI2a+vhm1KULnlCfgRDnkB7mQwBmGbzsVc9fSWPTsxMfz0lgZ0dKQ3+S3SRy93
         t/pV8rO/nCLcFaMBEFwvebdY8BGURmxnAbIJtr1Db1gjhCg36mgQHPsihYVqeNTKh2xS
         HR9YEn7wxcr3vpczZV6Lb95R6jILUNsbyWcwk7y37cVA/qns1u8Ep/khzwoYoxyni/zr
         T39nX/hR7HzX3aam3ApEv8EKfW4GOfmXpOjQL53dmkHLjB61UwOPA3CtNaauJw13oi2J
         sj6RvSy8dMn2OrsMnEZ5D6zKqvABbqchPDea4UT+tBowuj6IeLxcTkjMQybEIQRbGzG9
         vU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718634; x=1692310634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro75IzWT8TUaDzr5+qST3eOzqpkBJ7Tqh0wDFv4DPaM=;
        b=Eif9oMLCW0fRM+4pZ8gleEfjZfmP38GUDFjKJwjgQiYGieU8xUSux+WmHsBznxuMoy
         /v3nKpkM7w96E7CRqIHuVp2I77TWnh8DbDCBB0rvC6DFtB1HpzCQN//XrlcqMC06/DCm
         5pJ7EVYSVomLWCYm6c4snSjGe1s0TqHoBDsWHVppM07QDrnGgEKbrJEE7y1zFVY2CaJd
         Em5pt0flTYuv+RtVo18rHTw1eShSZdA1J9SwDZHZQVwQhuJh20c+baGqv6VtfzBUVE/H
         vnz3DdCA/6+OvZCBaASRrw2B+Z/71muoJrtPVF9t5HoJZkG2kkcOE1QuHfrkn+KfoA4E
         snNA==
X-Gm-Message-State: ABy/qLYeoT6W30AxTRrJ/tsEcdd7Y79q7lgB0OUbtOe6eqwhzipbqQfY
	ZG+Ux2hTjH3hZj8rE4Fw7UHO5gnb2E3illCQpL3GpqJbiz0=
X-Google-Smtp-Source: APBJJlFEwtGCxbOQQtna/cvBZGx6X0VLuvdwA2WnmprUY1qKUwFMsoLCNyRRGaXp8rysvH4kLg8b9samvccCQi32+YU=
X-Received: by 2002:a2e:b011:0:b0:2b8:4100:b565 with SMTP id
 y17-20020a2eb011000000b002b84100b565mr479762ljk.15.1689718633696; Tue, 18 Jul
 2023 15:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d6b05aa-f7c1-84ca-645a-f872813ca76f@google.com>
In-Reply-To: <1d6b05aa-f7c1-84ca-645a-f872813ca76f@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 15:17:02 -0700
Message-ID: <CAADnVQ+MtUZ27vjMnXbFG33j15ZV2FdZgpe4tcDrwXgmp41nxQ@mail.gmail.com>
Subject: Re: Repo for tips / tricks / common code?
To: Barret Rhoden <brho@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 9:15=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> Hi -
>
> Is there any interest in a repo or something for reusable BPF code bits?
>   I've got some stuff that I do in my programs that might be useful to
> others, but not to the level of a full bpf helper.
>
> For instance, one technique I've developed is to have list-like data
> structures for *mmappable* data that are e.g. per-cpu and per-task.
> Internally, it's an Array map, and each element is identified by its
> index in the array instead of by point.  And the linked-list is built
> with index integers instead of pointers.
>
> Anyway, that's just an example, and I imagine other people have their
> own techniques.  I've got the code sitting in an open-source repo
> elsewhere, and had a couple people off-list ask me about it.  I could
> email it to the list, but it'd get lost in the noise.
>
> If you're curious about specifics, the linked list code is here [1], and
> I briefly mentioned the data structures in my LPC 22 talk [2].  I've got
> an AVL tree that works with this stuff too.

I think github would be the best place for such code.
https://github.com/libbpf/.../ maybe?

> Thanks,
> Barret
>
>
> [1] https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h

btw, I'm working on adding 32-bit pointers to BPF,
so such link lists, AVL or anything else will look more natural and
will be mmap-able to user space as well.
So bpf program can implement its own hash table or rbtree and
user space can walk/modify it in parallel without crashing the kernel,
but potentially 'segfaulting' bpf program.
Still need to figure out a sane locking mechanism.

> [2]
> https://lpc.events/event/16/contributions/1365/attachments/986/1912/lpc22=
-ebpf-kernel-scheduling-with-ghost.pdf
>

