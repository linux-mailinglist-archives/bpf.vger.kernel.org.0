Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C73ECDBE
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 06:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhHPEbN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhHPEbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 00:31:13 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F71C061764
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 21:30:41 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 67so7045660uaq.4
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NePFxqSJ4koOwPTYZX78u0mK6tmFuDn3PPMt/c1ymF4=;
        b=bXUN9JK4K6N8w5QMtVY6V6UpO24Wbu3046J0Xy5RB1XVv1UJsJlFw+8RG/wb55+8Nf
         cjg7UZRqX1OYysRMjFNqOkinGsRCOAqAyaFaxN1uL9TxTooOEmWNqRYsggLHNy+0aLwi
         Mf60RWLydqxGZZq+s9ekQncRb3iHsxaMq/8dKV666/GszUYimN7V2C7Tl0R9LOz259ug
         Mr361HSaWa4KONAsKRKWZ7Aj24W+oKBNWcQmi1UsNvlFyr28KFB8GsS8CUpFZhKmTiXS
         Vnej/YuE9VCHoO4xBaS9tq7R9jALaTNGnIfXKcAflaKyF3ZgYu+tcn2LxTEsYqWDvXJx
         MRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NePFxqSJ4koOwPTYZX78u0mK6tmFuDn3PPMt/c1ymF4=;
        b=EsvdqC/d+IWdY+gYf7XVbVOTQowvz+hw7RS2tXf2hrgUqeoRvo4RR+fx8xeak/SXwW
         7am4phFOWEwl+otM/81L0iQMJO5TaNTffKIdk9oAurfTOQQSTFKD9ruW/dk5v5qPxYif
         eTO4lD15xVN/sWsr+6uzq06OIpYaakPDjIdXhJTCnLttli68Pn05lLfq5JsGwzhpY+KE
         Q9+QdTDVlk84tbm6MMda1zHLSDxXf7G+BMFZNo6kWeCx/eQdnZjMnln0CAsO0LmtHi4Q
         g7WyY6RsY4hJAu14CEUxmEEA8yuiwnGjaeIMJZJYTuPoJnQ+abgj0mQEsYnH9uQtSfc9
         kT2w==
X-Gm-Message-State: AOAM531WtQV3t+DU3umXjZtMz75YwGHxoU2pt0+yuIdw3HuGLATVBs08
        MUrB99jTeQ/inaXsc3dMb0xuuDQoJghtCDssMZo=
X-Google-Smtp-Source: ABdhPJwFR0P7slaSR8wuMsoQT2LUg4E0VmThZrWmggKXIiqWdYwnx70M3BK93mgTInOrpzNUPfpfzJPYteaiA9Me7Rs=
X-Received: by 2002:ab0:249:: with SMTP id 67mr1732510uas.103.1629088240555;
 Sun, 15 Aug 2021 21:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAL2pN5_4tPwhOxKu1g4YT3fEnzvhkQ0dLkP7-4RyUoEmPJiyVw@mail.gmail.com>
 <b307c1c2-e770-8926-7b68-3a0e69c659b0@fb.com> <CAEf4BzYObyi3Mn6qh9vjhh-9dpyxWFzaaHgEOjZk3iKHWAzA8w@mail.gmail.com>
In-Reply-To: <CAEf4BzYObyi3Mn6qh9vjhh-9dpyxWFzaaHgEOjZk3iKHWAzA8w@mail.gmail.com>
From:   Mohan Parthasarathy <mposdev21@gmail.com>
Date:   Sun, 15 Aug 2021 21:30:29 -0700
Message-ID: <CAL2pN5-ynjixsGa=6PinNs68QGOVGmVYMSCbdSMp1oG-qfZoqw@mail.gmail.com>
Subject: Re: libbpf attaching a raw socket
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I see examples both under

- samples/bpf/sock*
-tools/testing/selftests/bpf/progs

The programs under bpf seem to include bpf_legacy.h for load_byte etc.
Is this still valid or this will go away in the future?

Thanks
Mohan

On Fri, Aug 13, 2021 at 12:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 13, 2021 at 10:23 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 8/11/21 6:36 PM, Mohan Parthasarathy wrote:
> > > Hi,
> > >
> > > I looked in the samples and header files, but could not find an
> > > example for this. How does one convert this from bcc to libbpf. This
> > > is the userspace code.
> > >
> > > bpf = BPF(src_file = "socket_filter.c", debug=0)
> > > socket_filter = bpf.load_func("socket_filter", BPF.SOCKET_FILTER)
> > > BPF.attach_raw_socket(socket_filter, "eth2")
> > > socket_fd = socket_filter.sock
> > >
> > > I can do the following to set the type:
> > >
> > > err = bpf_program__set_socket_filter(obj);
> > >
> > > Is there any sample I can follow or any header files where I can look
> > > for attaching a socket to the bpf code.
> >
> > There are a few examples in linux/samples/bpf directory:
> >
> > [~/work/bpf-next/samples/bpf] grep SOCKET_F *.c
> > cookie_uid_helper_example.c:    prog_fd =
> > bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
> > fds_example.c:          return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
> > sockex1_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
> > sockex2_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
> > sock_example.c: prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
>
> just please don't use bpf_load_program and bpf_prog_load, use proper
> bpf_object APIs or BPF skeleton for loading programs.
>
> > prog, insns_cnt,
> >
> > They should provide an example how to attach a socket_filter program
> > to a socket.
>
> You can probably also look at recently added bpf_tc_* APIs in
> tools/testing/selftests/bpf/prog_tests/tc_bpf.c. I've CC'ed Kumar who
> added those APIs recently.
>
> >
> > >
> > > Thanks
> > > Mohan
> > >
