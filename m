Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7A2932E8
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 03:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbgJTB6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 21:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJTB6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 21:58:12 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1ABC0613CE
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 18:58:10 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c3so458503ybl.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6N+zEZdpGCMSjZ6Hx0ZZUIkx/nwROY1sIBasTIMtPw=;
        b=M+LD5R7oPQgGrvjxZ+aGix1ftVk1B0liOi0pYwnAAvlygWzVC8TXqbeiwGYZ5E15gZ
         otBg2Uky2i/VgxrFLMMsk8M4gIjCnPahd908Omii5aeDUsLJuWszJF5l7EERvdXiafiL
         /JQdYP8jd6QCUaBy+xYHBaAvmEEiw3Yi2mcMde5R78Vkx3R5wlPzQlcnd5aZHeDkVDuI
         DlaXIKIXgOtMjYEk0KAj4iM0v7fRdvPVT5ZrN1X2MVwUZCXIvmLZZySnV4LFveG65n1x
         MhjcyxN6eVYTfuVtC7wuDuHo9EoXMNRxn2WSPFEul8k/qvMnRcJDVcz+uzF16U8/dYTg
         eR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6N+zEZdpGCMSjZ6Hx0ZZUIkx/nwROY1sIBasTIMtPw=;
        b=Juxuqdy3xyzoDKPORQpTs2ZDv4HHHarvKRtMgsMQEZ20JN8HoTTl3b730NlzBzS5LB
         NdnpZ+8kpbusluFS8Cz1o0H5spWnCMzj/KzQzkL8WcYEpxY5QdzsTL5GInB433KCylZ6
         izEeNEOhucs8QWuIE2Tw4UZBt0ppdXEgX5UGv80EmcXlMXVYbcziKNt3rB/nPZDEGeGZ
         hso/BFisEWIpA2QjWeeOwD8Jxr1AO8A4nWbmU83Grpdxn4GxbO9MUKZFL/FUFOXu3Qdz
         Xy8FM66dPGdmWpGP8o6c9VCV0CApoT7uqmlYvIF3hM0wksYBwgt4exe++WfrJ4z5TZWV
         6G+Q==
X-Gm-Message-State: AOAM5304HZX/d7mcKCDingV9G+NoUlsSTQBMCtTYlFqkU6uZ+82+sKoJ
        fMmyEkZJtcjVIHIiNm0irigY7w9hf/GGg70PHLdRHo0FYaw=
X-Google-Smtp-Source: ABdhPJy3T42ZwSSP/KubY+K6XyNfSPCWAJbtAazrsemZlPz/Lq3EAV+lvuwMEzY6aWNiYk173riXZhNtQVXaMtWQzXU=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr999527ybl.347.1603159090032;
 Mon, 19 Oct 2020 18:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAON2a1G_rqvOLumP-0Vcw0v2qiAiwc0hR32TegvNYyEd26e9bA@mail.gmail.com>
In-Reply-To: <CAON2a1G_rqvOLumP-0Vcw0v2qiAiwc0hR32TegvNYyEd26e9bA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Oct 2020 18:57:59 -0700
Message-ID: <CAEf4BzZBKco0=-HDfjOKPOJDXnicxOVyOY6ouAu+00s78_CJng@mail.gmail.com>
Subject: Re: help using bpf_probe_read_user with uprobe on linux 4.19 for aarch64
To:     sheng chen <eason.sheng.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the third identical email you've sent, please don't spam the
mailing list. Sometimes it takes a bit of time on the mailing list to
get an answer. Re-sending your email will just annoy people and won't
help you get an answer.

As an advice for the future, please try to formulate your problem
clearly, before asking a seemingly-random set of questions. See below,
I tried to answer your questions as best as I could.


On Mon, Oct 19, 2020 at 6:45 PM sheng chen <eason.sheng.chen@gmail.com> wro=
te:
>
> Hi Andrii,
>
> I'm developing bpftrace tools for Android aarch64 devices to analyze perf=
ormance, mostly using uprobe/uretprobe and kprobe/kretprobe.
>
> I'm using the project https://github.com/facebookexperimental/ExtendedAnd=
roidTools for build bpftrace cmd tool. libbpf still not included.
>
>
> First question:
>
> Currently there is an issue(https://github.com/iovisor/bpftrace/issues/15=
03) block me to correctly access the pointer address of the uprobe paramete=
rs.
>
> Seems like this require bpf_probe_read_user on linux 5.5(as mension in ht=
tps://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md), if I use=
 the older kernel, I need to apply the patch about the function bpf_probe_r=
ead_user, is there any reference code I need to apply as well?

I don't understand what reference code you mean. And given this is a
bpftrace question, it's probably best to route it to bpftrace Github
repo? This mailing list is discussing kernel BPF subsystem and libbpf,
for the most part.

>
> like the following parts:
>
> linux/include/linux/bpf.h
> linux/include/uapi/bpf.h
> linux/include/linux/filter.h
> linux/include/uapi/filter.h
> linux/kernel/bpf/
> linux/net/core/filter.c
> linux/kernel/trace/bpf_trace.c
> linux/tools/bpf/
> linux/tools/lib/bpf/
>
>
> Second question:
>
> Does the trace program like using uprobe/uretprobe and kprobe/kretprobe n=
eed libbpf built-in?
>

I don't think bpftrace relies on libbpf, so I suppose no?

> For a specific kernel(like 4.19), how to choose the right version of libb=
pf for build as the dependency for bcc?

You should build with whatever version of libbpf BCC depends on. But
then I'm even more confused between you talking about bpftrace, BCC,
and libbpf. All three are quite independent projects, with libbpf used
by BCC for some functionality.

>
> Third question:
>
> Does my kernel need support BTF? Since I need to access the struct member=
s from kernel and userspace.

I don't know, because I don't know which kernel is *your* kernel.
bpftrace has --btf parameter with which it can use kernel BTF, so I'm
guessing that's what you are asking about? If yes, kernels starting
from 5.2 version support emitting kernel BTF, but you need to enable
it through CONFIG_DEBUG_INFO_BTF=3Dy config value.

>
>
> Thanks
>
> Eason
