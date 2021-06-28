Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42683B6B08
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhF1Wq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 18:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhF1Wq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 18:46:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB2C061574
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 15:43:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l24so265821edr.11
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73hLMKdVoRqxwgfRW2NqWRHvgNVWFIhcX75t56intpI=;
        b=T94NfHr8X2vFc56fEztBgSPItjLSlacIfow9DzN/QEbltrt7+fAEhvX0rS924z5ev7
         zC4nR/5VzX+loaQf1fg01aQjUhDEpprpYgCHKSS4VTT1iIkxhAMEAwGJXrcW1El2i6A1
         7r+UqhYwUe37RjjaFUP3k4ZFp924PnxTasvPgjjTDPW47QDut963yQygBlBmA+eW/e0W
         /P2A8mrgDrzjlwUH+cdL8qcgFVBM4CYMcY5O0WsDGRGGLGpsC6EB3Aw4jCdVi/0x9zvD
         gWrkbL+fqmRU+CZqkmc0WRD6Twi8gTVMtbFNIid5D3COW18+0AAZBBMxHIa8KCND/ZTA
         WxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73hLMKdVoRqxwgfRW2NqWRHvgNVWFIhcX75t56intpI=;
        b=MoQlI7Su0WY1Fi/xo8VT1nZRwXgvnwFuG47Zu+S9NGkNpzHT0fOTKv1zLk3Sbcvxm/
         CIrayFur2S7EDOY8mh3SxAxDmLjpPlo/kU1F8ju4Z+meTR7hmrmGGmGKd+sXOV+cmYOa
         sRoW2I0QIae9aBjQLaO0ujdN08OB0ihwEPlzCxHASp6FFYvPPkmP4eWX6WxAi1AuA892
         gFx6VpDACetuvvo6t9xECUf0cHLi65hWfNf1LokiEt7iVJdyiLoFYFxdtgzqZhq6GewY
         0F8FGDe5IhJMKWGF1lonvQ0VNIGnMClF3YCBJZ6j4hdPwRfdhBXgm/ltE0jjBBVcwEcZ
         +gdA==
X-Gm-Message-State: AOAM532OSrd1sXSLUldBKv3d92tUQLOwTpGpp/jsGJtkpKwm6c/rgMJB
        NXmrdH0KPM8aRIsggYbQ29CEZYZ7ubywOl4LU/ra
X-Google-Smtp-Source: ABdhPJw+cPBBLNiR5YTeSVbi5e3DXb/AzCzyp2HNoXUOnsAMd8AlumYblSXH514TyE0NP7bPcOHFVg/m0Zc4pJOvqRo=
X-Received: by 2002:aa7:d592:: with SMTP id r18mr1593035edq.269.1624920237966;
 Mon, 28 Jun 2021 15:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
 <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de> <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
 <efb74f33-6876-48ec-bb9c-87b2247bdedb@t-8ch.de>
In-Reply-To: <efb74f33-6876-48ec-bb9c-87b2247bdedb@t-8ch.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jun 2021 18:43:46 -0400
Message-ID: <CAHC9VhTKOZepgVwpc=rh65-ziMTvSvgtCjP6S9+SQ=YDqg-vsA@mail.gmail.com>
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 28, 2021 at 1:58 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> Hi again!

!!! :)

> On Mo, 2021-06-28T13:34-0400, Paul Moore wrote:
> > On Mon, Jun 28, 2021 at 1:13 PM Thomas Wei=C3=9Fschuh <linux@weissschuh=
.net> wrote:
> > > On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> > > > On Mon, Jun 28, 2021 at 9:25 AM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:

...

> > Remember that seccomp filters are inherited across forks, so if your
> > application loads an ABI specific filter and then fork()/exec()'s an
> > application with a different ABI you could be in trouble.  We saw this
> > some years ago when people started running containers with ABIs other
> > than the native system; if the container orchestrator didn't load a
> > filter that knew about these non-native ABIs Bad Things happened.
>
> My application will not be able to spawn any new processes.
> It is limited to write() and exit().
> Also this is a low-level system application so it should always be compil=
ed for
> the native ABI.
> So this should not be an issue.
>
> > I'm sure you are already aware of libseccomp, but if not you may want
> > to consider it for your application.  Not only does it provide a safe
> > and easy way to handle multiple ABIs in a single filter, it handles
> > other seccomp problem areas like build/runtime system differences in
> > the syscall tables/defines as well as the oddball nature of
> > direct-call and multiplexed socket related syscalls, i.e. socketcall()
> > vs socket(), etc.
>
> For a larger application this would be indeed my choice.
> But for a small application like mine I don't think it is worth it.
> libseccomp for example does provide a way to get the native audit arch:
> `uint32_t seccomp_arch_native(void);`. It is implemented by ifdef-ing on
> various compiler defines to detect the ABI compiled for.
>
> I'd like the kernel to provide this out-of-the box, so I don't have to ha=
ve the
> same ifdefs in my application(s) and keep them up to date.
>
> I found that the kernel internally already has a definition for my usecas=
e:
> SECCOMP_ARCH_NATIVE.
> It is just not exported to userspace.

I'm not sure that keeping the ifdefs up to date is going to be that
hard, and honestly that is the right place to do it IMHO.  The kernel
can support any number of ABIs, but in the narrow use case you are
describing in this thread you only care about the ABI of your own
application; it doesn't sound like you really care about the kernel's
ABI, but rather your application's ABI.

> > I'm sorry, but I don't quite understand what you are looking for in
> > the header files ... ?  It might help if you could provide a concrete
> > example of what you would like to see in the header files?
>
> I want to do something like the follwing inside my program to assemble a
> seccomp filter that will be loaded before the error-prone parts of the
> application will begin.
>
> 1: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_arch),
> 2: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SECCOMP_ARCH_NATIVE, 0, $KILL)
> 3: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_nr),
> 4: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_write, $ALLOW, $KILL),
>
> In line 4 I can already have the kernel headers provide me the correct sy=
scall
> number for the ABI my application is compiled for.
>
> For line 2 however I need to define AUDIT_ARCH_CURRENT on my own instead =
of
> having a kernel header provide the correct value.

--=20
paul moore
www.paul-moore.com
