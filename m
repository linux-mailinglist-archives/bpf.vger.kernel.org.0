Return-Path: <bpf+bounces-4653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859D74E245
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6B6281176
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA82168B2;
	Mon, 10 Jul 2023 23:43:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9F154B1
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 23:43:15 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5A19C;
	Mon, 10 Jul 2023 16:43:14 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79702eee5a8so1194747241.1;
        Mon, 10 Jul 2023 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689032593; x=1691624593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUaJuZLn2HQHTJjVwoie7/nnRDaNlyZQ3eHS6hMyjpY=;
        b=NOehtBZUrPXylJYfZWxW8nf74sjL6u0w8pZz7WFFmV0fBRd7gYUGnj5TEYaRokMuQa
         4pBLn40oBxlCPy84h9F84Pjk3UUXeXk6WSoxO/3J2+r8s2w8ho0vmRGzqhujPNYYfZIe
         o5uDSW9ct00r5j/14t3fquAH8Mc7JYnixjzxzoS4K3IgqFyQoBoFBbMXWZigBmMZULcG
         5gR3XYaM2HBPpBwCYPK7f4jfrh0/NW/ZMPtkmmCOfDk2QDCrtFEQPyXPHYlfslTi6BRS
         CthI3XncwEXJurXgAcn07gD0WFuTX9jGOYx0K5MDKtnmTMK17hKttJFLz3ediwmUCZkP
         PZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689032593; x=1691624593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUaJuZLn2HQHTJjVwoie7/nnRDaNlyZQ3eHS6hMyjpY=;
        b=XRDpIEbCnYbVvUVNRc7zPUnp8VkqtVfSunLM7zGohBedhDEMm7oj510Mg3JKzGI4LL
         o7WaXrQwsLcV00s5BifbAteIJBcS5Pvxp0sklA72N7VWQUSH/lj6MTWvRV18jKMM+6Lb
         9EapuNYrnLTTAhla+dWzl/ok38vDmuXST9mE5lVdryMK4CHUMRuo6FkSjbkcnm0AKB7i
         o+Py/y8j9HbIkzsGXbPdmCcth2iILTDcHP8ISlVE6b7TpkUcUzZdOjUcOsykzBETGJmP
         Ga3xd/NdxgPqIBJszck+jCLSSrAAznKxZPNik5wXwIkoUNQEC6UEsrM967vOgfqjlX02
         hr5w==
X-Gm-Message-State: ABy/qLbRSTt5eYalQdnDrxKM3ofRnvqDMXqlakPLAvWTbVJJjxbOFwkl
	HSiqS7LAySgDC4aWuAgNDq4eErK2cxksZVkBC9cDrv7Op9D/pVa9p5g=
X-Google-Smtp-Source: APBJJlEEWdCGox1zITHfkC2lwxsdykiZoHmYyzEtl8SiYSsXs69oED61ARYe7S9dlDnx0zh2PzCWltUFBPUCxVx4lwE=
X-Received: by 2002:a05:6102:282b:b0:444:c644:c231 with SMTP id
 ba11-20020a056102282b00b00444c644c231mr7683110vsb.12.1689032593456; Mon, 10
 Jul 2023 16:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner> <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk> <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
 <87lefrhnyk.fsf@toke.dk> <CAEf4BzZAeSKYOgHq5UTgPp+=z7bm6Fr5=OFC9Efr0aj4uVbaAQ@mail.gmail.com>
 <87pm53fklx.fsf@toke.dk> <CAEf4BzYd-vKGQ4GoCVGSPjroV4D1yHODTaRO-RwLZtUdYnkoZg@mail.gmail.com>
In-Reply-To: <CAEf4BzYd-vKGQ4GoCVGSPjroV4D1yHODTaRO-RwLZtUdYnkoZg@mail.gmail.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Tue, 11 Jul 2023 01:42:46 +0200
Message-ID: <CAEiveUfw1QXdbC-iUBtKZrxfoDBJpNE43BEOTqTGToqu8UbW_Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 1:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
...
> > >
> > > Why can't distro disable this in some more dynamic way, though? With
> > > existing LSM mechanism, sysctl, whatever? I think it would be useful
> > > to let users have control over this and decide for themselves without
> > > having to rebuild a custom kernel.
> >
> > A sysctl similar to the existing one for unprivileged BPF would be fine
> > as well. If an LSM ends up being the only way to control it, though,
> > that will carry so much operational overhead for us to get to a working
> > state that it'll most likely be simpler to just patch it out of the
> > kernel.
>
> Sounds good, I will add sysctl for the next version.

What would be the purpose of the sysctl? or a kconfig? AFAICT the
operation is still privileged, and it's an opt-in? anyway...

It is obvious that this should be part of the BPF core... The other
user space proxy solution tries to solve another use case competing
with LSMs. It won't be able to handle the full context (or today's
nested workload) at bpf() call time... There are obvious reasons why
LSMs do exist...

Thanks for agreeing that it should be attached to the user namespace
at creation time as it is crucial to get it right... and Christian
(thanks BTW ;-) ) maybe we make it walk user ns list up to parent and
allow the token if it's coming from a parent namespace that is part of
the same hierarchy, then theoretically the parent ns is more
privileged...  will check again and reply to the corresponding email.

Thanks!

