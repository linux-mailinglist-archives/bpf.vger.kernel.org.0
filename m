Return-Path: <bpf+bounces-15877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6D7F9758
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F66B20A69
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEA110C;
	Mon, 27 Nov 2023 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvxRoZpJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D9110
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 18:04:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-333030a6537so75448f8f.1
        for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 18:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701050650; x=1701655450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Z6nql6+pIKONlM1Tv06oqW9omEKYJTRZDkS+yk1Ao=;
        b=MvxRoZpJQhFAZWBjSt+9TLl5FXl8Xv4HqZDO4i3ugOIExtqdQzOv72cSNUZhXdOhL5
         wYil9ToHlkQdUZknReNQWQsounZyhtiBhbZqq9CxEbMWBu7mEibsb5QGXFK7vkKAHm/C
         VRx3yyykVi5L0xcaEfOdqD8AUuktoVfGwiKgX07KrXpkiKjLzEaV8JGN4V2TcUTIxyD4
         /L6IMNrkDa/geiTFf0h64JHKv1r620tgjWv3VjeaBLkJjbzrQhVuBTG5NZ2FsQJQJ1qg
         vaI5y2ZfC1JUTQChQ3U21kavFuFIOL4f1+IQsNvglpl4kkjxlj56uLfPTauL/AEtP2mE
         AZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050650; x=1701655450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3Z6nql6+pIKONlM1Tv06oqW9omEKYJTRZDkS+yk1Ao=;
        b=Wtptu4GpHuahjcY/e3BlTHqC9ZU9E+tdBCnlqwxa1066h8915vi20E0pNXOIdXmHdX
         F8SWYye+f08pNG8tJBS29UxVQPxy4l/nLl33sRLgTPcbJBP4wzEF4EbQYJTP4befKqn0
         +2hAOj4MjR/PN5WDvyf/6pq2NPe+3WLHxCb3Fz/sRkFdAa9LN87xRlsqXcghCWoPw1Qx
         7pdVH1bdhUOgUGkfcfzy9ob4dA8x0SKGVhqOK9H8SVnS3CvoOQK/O3bFyUpnndoPZNEz
         NldhxV79axTXqiq1fjAjmNE9RTpGM+vwWLCGeVDP7aiqo2n5+7/YU4uhXpGVgUyM0sqo
         xdfQ==
X-Gm-Message-State: AOJu0YwnUfOdBP8kzuFhOqhBYmAQC/nmlMgu2l1LgyK2M/tzFDOq5QTr
	6M2sVGlk7tqdqucjL44PWUwxgpN5fQOUIYcJTm0=
X-Google-Smtp-Source: AGHT+IECjvbBAZpsToaYb8Qf5hWmz2d9LttRIR83Ns69m5ePsEnB37PVCTD78Q1WvtZPq4tcC2hm4abfmV/v2al60fk=
X-Received: by 2002:a5d:590d:0:b0:332:c789:4bf0 with SMTP id
 v13-20020a5d590d000000b00332c7894bf0mr7119093wrd.71.1701050650071; Sun, 26
 Nov 2023 18:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
 <07e4414b-3347-49e4-9c19-57d101ccd009@linux.dev> <07cd47c4-3cd5-6a77-16a5-2057188f1e0e@huaweicloud.com>
 <01cfdfc4-5192-4fb6-bc86-571c871bfac4@linux.dev>
In-Reply-To: <01cfdfc4-5192-4fb6-bc86-571c871bfac4@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Nov 2023 18:03:58 -0800
Message-ID: <CAADnVQLxAtGVx50m+UE4kw2UAJZVKX=zEYaAg95qS+yqKGThmg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 7:09=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/12/23 7:59 PM, Hou Tao wrote:
> > Hi,
> >
> > On 11/13/2023 10:34 AM, Yonghong Song wrote:
> >> On 11/10/23 8:38 PM, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is=
 no
> >>> free object in free list, but it doesn't initialize the allocation hi=
nt
> >>> for the returned pointer. It may lead to bad memory dereference when
> >>> freeing the pointer, so fix it by initializing the allocation hint.
> >>>
> >>> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
> >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> LGTM based on my reading of the code. Maybe you could explain
> >> how you found this issue and whether a test case can be constructed
> >> relatively easily to expose this issue?
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Thanks for the review. I found the issue through code inspection when
> > trying to use c->unit_size to select the target cache in bpf_mem_free()=
.
> > I think it is hard to trigger the problem under x86-64 or arm64 when
> > PREEMPT_RT is disabled. Because with disabled PREEMPT_RT, irq work is
> > invoked in IPI context and free_llist will be refilled timely and
> > unit_alloc() will always return a free object under normal process
> > context. But when PREEMPT_RT is disabled, irq work is invoked under a
>
> In the above 'when PREEMPT_RT is disable' =3D> 'when PREEMPT_RT is enable=
d".
>
> What you described makes sense. It is indeed hard to construct a test
> case with current kernel.

Applied. Thanks.
Sorry for the delay.

