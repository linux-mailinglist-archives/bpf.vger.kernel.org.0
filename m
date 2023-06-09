Return-Path: <bpf+bounces-2239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B798072A0B8
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715642819FB
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ABD1C751;
	Fri,  9 Jun 2023 16:55:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC91B917
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:55:50 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68030FF
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:55:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543b599054dso815101a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686329748; x=1688921748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUDu/7DgpcEGYUfH66KF8LpEOa4YLrtNbTWtCaGIav4=;
        b=ONSRNQw5ZwRQNGUqQHq+j4pU5Ha8C0gKwcZ3tD5oLOjzGBRHgFACfAQprE0Q+TYg/P
         lf+3dNuqjPAt+6bwiyXizp0lNbypl7beDWmiXlNGIWMkLLAjabVD1wTly667BXz+g/1/
         L0qmBswoM4J2Qj7ObeKL7y1aiscGksRuGZGH+y0qRi/2Z2Sd22x2JWyc8VPhIiC75xmV
         um25gWcuJx/L65W+dXsFYQdrBRAaW8fT9PQY1fIL/dI8i3qz+DerYhTj+/L4zpj2zMjx
         FEriPApZU9uFQzNGhOvbKQRUGKr0Cqa6V3KXZjEuijTtKk53SdH5gRt/Bbqu82iTjBaU
         oKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329748; x=1688921748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUDu/7DgpcEGYUfH66KF8LpEOa4YLrtNbTWtCaGIav4=;
        b=kTPzs2a2+8HzLL2Ps99hswRWnOrlFJTnEwjoj/Fhscajc6QwslGrEzqknl13sLBDlj
         uo8fQEmXpkuq4wpxQYBz4uL6vOXmx1XmodI4VZpz+AncaIKg+5U2ALcnkLCXp+Zsfvtc
         RSKo8ebBsFOugwXz+750ARh4JrIOJPdtpcg3IhWjWxlCUPEA9XedIcENsWXeJzA/LS9B
         FYSCkxxmSsNSf/q2zJlkeNS86rtAs04D97MmQrBU97VB/DOXw9igHUgsaP0sXNQ+kvat
         UYN4wJ16/QN0PnbIArxtjX53O04ZSJOhlWqgT78Uo2qAqQXz4jx4JFdrXtlXSWOcjqDH
         dPrg==
X-Gm-Message-State: AC+VfDy2N1Vb3mD0h/hLWrsSzLJotkm3yYT+ZYcWQUWnadP2mFSlQhXE
	3mvm9ZvOz5sXqv9pzw1C/2AmRi1j6E754n3aP+qvvQ==
X-Google-Smtp-Source: ACHHUZ6HxN+lrJGAlL2C5V8qEiwPCFNyTuGmy18Ac5XNglz/yS9yLUF2jkuplc7nJeYWFDXq58+6+ZWVXbHGpZ6st18=
X-Received: by 2002:a17:90a:ca97:b0:256:3191:640f with SMTP id
 y23-20020a17090aca9700b002563191640fmr6690924pjt.4.1686329747571; Fri, 09 Jun
 2023 09:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzb2_THiWkqNRnbN5LsOif6+9=GY7LrtEbQf6o24cihhMQ@mail.gmail.com>
 <20230609093625.727490-1-zhangmingyi5@huawei.com>
In-Reply-To: <20230609093625.727490-1-zhangmingyi5@huawei.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 9 Jun 2023 09:55:36 -0700
Message-ID: <CAKH8qBu0AiB_0SZgU5N8EOmm4=hp5BRe=Yp5PHbyT1ZbRjdeOw@mail.gmail.com>
Subject: Re: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hsinweih@uci.edu, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kongweibin2@huawei.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, liuxin350@huawei.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, wuchangye@huawei.com, xiesongyang@huawei.com, 
	yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 2:38=E2=80=AFAM zhangmingyi <zhangmingyi5@huawei.com=
> wrote:
>
> On Fri, Jun 9, 2023 at 1:39 AM Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
>
> > On Thu, Jun 8, 2023 at 9:27=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 6:00=E2=80=AFAM zhangmingyi <zhangmingyi5@huaw=
ei.com> wrote:
> > > >
> > > > On 06/06,Stanislav Fomichev wrote:
> > > >
> > > > > On 06/05, Xin Liu wrote:
> > > > > > From: zhangmingyi <zhangmingyi5@huawei.com>
> > > > >
> > > > > > The sample_cb of the ring_buffer__new interface can transfer NU=
LL. However,
> > > > > > the system does not check whether sample_cb is NULL during
> > > > > > ring_buffer__poll, null pointer is used.
> > > >
> > > > > What is the point of calling ring_buffer__new with sample_cb =3D=
=3D NULL?
> > > >
> > > > Yes, as you said, passing sample_cb in ring_buffer__new to NULL doe=
sn't
> > > > make sense, and few people use it that way, but that doesn't preven=
t this
> > > > from being a allowed and supported scenario. And when ring_buffer__=
poll is
> > > > called, it leads to a segmentation fault (core dump), which I think=
 needs
> > > > to be fixed to ensure the security quality of libbpf.
> > >
> > > I dunno. I'd argue that passing a NULL to ring_buffer__new is an API
> > > misuse. Maybe ring_buffer__new should return -EINVAL instead when
> > > passed NULL sample_cb? Although, we don't usually have those checks
> > > for the majority of the arguments in libbpf...
> >
> > Right. I'd say we should add a proper doc comment specifying all
> > arguments and which ones are optional or not. And make it explicit
> > that callback is not optional. If we start checking every possible
> > pointer for NULL, libbpf will be littered with NULL checks, I'm not
> > sure that's good.
>
> I agree, we should add a proper doc comment specifying all
> arguments and which ones are optional or not.
> However, why does the external interface API in libbpf not verify input
> parameters or add verification where risky operations may exist?
> What's more, i think sample_cb=3DNULL is not strictly a mistake or
> prohibited use, and is meaningless.

It's not really customary in C to do it? So maybe you can follow up
with the update to the doc?

The kindergarten is over, you pass NULL you get SIGSEGV :-D

