Return-Path: <bpf+bounces-10070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F018B7A0C2F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53951F2436B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD13266A1;
	Thu, 14 Sep 2023 18:05:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AE1D54D
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 18:05:16 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5AEB9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 11:05:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so1479143a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694714713; x=1695319513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT4pFbV2Cww33ESpzW/l6C+DiWNd4rOt8QY1sbxAtDY=;
        b=C6fZkpUC4x2SLlxxoDve14FBKzP8HqIuxdmxkO8AhyTGUjkIDCYSu2T8KLvw/vfL0P
         fxH4L/eURPgaAUWZxP1beVhoI31cpGHO31hztSFyzEaV+vE8WNJBFX6h08Z2EP+gP9DO
         SB5T1ZKvOlod9BPIXOOGY2NGdO1gGhk7Ixn09bZd7AqAcbwZmODoFGX4aDPuH1bF0JdB
         BeVJzF6Y8ah3+zRrLiJSZvjSWPOORvUCY8+N8CFaKGEuayXCIeb1pg8GndtHObB55OEf
         oazl78epufWXhqwPqjx0KhRaXHp2BayC3cW02baz7yyIa7ZGnfEH/azKJMDQ6xWS/z6F
         LuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714713; x=1695319513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT4pFbV2Cww33ESpzW/l6C+DiWNd4rOt8QY1sbxAtDY=;
        b=MfpCMNGYqew7/9wrMV/CRNjoLiDXx4/1lMGFSLh1Z/4nWkW+uwkWrajK5p0/W3C+3l
         Lhbv8T4hxBKSqkyO7ETYPiu6+xfkZ05lq4LTm5/d+i0awDG3uHvPlm/Xsj2deDoCzuLe
         Q0S3U0/BPQA8x/W+R8gQg0MDZSDmW1Bog44xtG5HAV4hOGLREwnt7Dd/k2nG5RpmUWbR
         FugPrF+x3ty+ZmP5EVS7jIPt1T1SXlcw1VCagcC8uw+zU0MAClQw8psg+dX9mzFsdu/r
         EJwb30AiEWXZxCZ07nrnb+bdhI1Sv1YlAuuFGNzUqrUq62tcrYpQZ+Z6FqyOFi/NLXac
         OoUQ==
X-Gm-Message-State: AOJu0YzdxggccKoTXzNIjFo2jCkda4UzAhYUuw0PKhB9iD/pjDE1xHL3
	/PyJpISzHFgLTQ7mVze/mP3dVuu5ZRWpzWe/j3+L6Ddr
X-Google-Smtp-Source: AGHT+IHZLBV86nfqcwxBCBSxhLw49uqyvp4+fz8yzji1SF6TeMYP32Ti59hL3w3nT1pW1sYvDx0XIgbymzGZ8dyj0OQ=
X-Received: by 2002:aa7:c0cb:0:b0:52e:1d58:a6fa with SMTP id
 j11-20020aa7c0cb000000b0052e1d58a6famr5792319edp.36.1694714713298; Thu, 14
 Sep 2023 11:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f76a8cb2-6cc7-be5d-0335-cc6b98baaed8@crowdstrike.com>
In-Reply-To: <f76a8cb2-6cc7-be5d-0335-cc6b98baaed8@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 11:05:01 -0700
Message-ID: <CAEf4BzYubqYZ=Hu2yzZ3FXGW-oGJ+-3k9=s+EAhvu07OCzgh+w@mail.gmail.com>
Subject: Re: Best way to check for fentry attach support
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Rahul Shah <rahul.shah@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 11:50=E2=80=AFAM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Hi all,
>
> I'm trying to figure out the best way to handle the fact that
> fentry/fexit trampolines are not fully supported on all architectures
> and kernel versions. As an example, I want to be able to load an fentry
> if the kernel supports it, and a kprobe otherwise.
>
> It's tempting to use libbpf_probe_bpf_prog_type for this, but on ARM64
> kernels >=3D 5.5 (when BPF trampolines were introduced) but before the
> most recent ones, loading an fentry program will pass, but attaching it
> will still fail. This also means that libbpf_probe_bpf_prog_type will
> return true even if the program can't be attached, so that can't be used
> to test for attachability.

Right, because libbpf_probe_bpf_prog_type() is testing whether given
program type can be loaded, not attached.

>
> I can work around this by attempting to attach a dummy fentry program in
> my application, but I'm wondering if this is something that should be
> done more generally by libbpf. Some possible ways to do this are:
>
> - Extend the libbpf_probe API to add libbpf_probe_trampoline or similar,
> attempting attach to a known-exported function, such as the BPF syscall,
> or to a user-specified symbol.
>
> - Extend the libbpf_probe API to add a generic libbpf_probe_attach API
> to check if a given function is attachable. However, as attach code is
> different depending on the hook, this might be very complex and require
> a ton of parameters.
>
> - Maybe there are other options that I haven't thought of.
>
> I have a patch I could send for libbpf_probe_trampoline, but I wanted to
> first check if this is a good idea or if it's preferred to simply have
> applications probe this themselves.

It doesn't seem too hard for an application to try to attach and if
attachment fails fallback to attaching kprobe-based program. So I'd
prefer that over much more maintenance burden of keeping this "can
attach" generic API. At least for now.

>
> Thanks,
>
> Martin
>
>

