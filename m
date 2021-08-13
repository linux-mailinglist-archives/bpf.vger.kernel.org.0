Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504C13EBC59
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHMTCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 15:02:04 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B08C061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 12:01:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a93so20663056ybi.1
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJtha2vyEPDd7hgRZwv8n5+luWsx3M3T3yEQqhBtSxE=;
        b=hUjcYCabqlAHNGwICejCMFfF/tyUlCtpm9N1mMLyQPB4j4KzZpaxL5y1FvvxDDZy9s
         pRf2CaZM+OduiZz/AZvk/X12aD3rRvHF8GtC6zhf1glVZZdgRo5VJ01bgcJRkElpFPOj
         UBdseb+pNi9M9PBBcsa32Mp137ymjvTLNjcMqQT33vFRix/tPM+DoppyBqhmCYj6xr60
         3RaqHVTDU8/HZQJBkZDZbowHtEgy8R1LEF6yviJUyT2QX7vMg208nVeupj5Iq63S/4D1
         Hy8ixwChfNjIF5L8Q5gdyd5LGau0cHX5jDdehCdq/P0fhV2gXUc2Etfbbqgc7u0juZbp
         vt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJtha2vyEPDd7hgRZwv8n5+luWsx3M3T3yEQqhBtSxE=;
        b=FcG/HUwDH/FN6JlhVZ/tBL/1zCb7gwGGuN8CEaxV4KOAiQxls1h7bRAJ93+Wzgapzy
         30cyQ1su9YlpPZfuZUHlEbTrBtLoMU2MJbO2ZTSVFcbp18NPVLW84KH+ppVpmtIwWa25
         BQJQYC8DMKhTj4jDWAiA1o9aPUdMGvbif7LuEMEFXYn+Jn4XGGtAXa+xb04zWE+WyTgG
         aZBRNrzuqqpMUb6AWy7hXWWxjM3TapoP3qLqROJJCCDkr9034qSDigO+e4Fd999p6tLv
         XpsRprSy88omX7k17anKMMIblOkqNmqjFYw1/aBOGNRmwXxbhnPto16ieiZBufVY1H+4
         s9Qg==
X-Gm-Message-State: AOAM5310O8NLAkelHv2h44y2S6AoEi9ql67DUHkaZMkYLH1wbLHk39Vz
        mS2LMFDLjtPc6CTJLU82DY3eqmEGS4u3mCsx8r8=
X-Google-Smtp-Source: ABdhPJxgfoYS1OUvAZlg6FL5Q6WC/Arn1AHCHXh4DZDZ7hNHJhw9QvwKlyFQPBmKKJXDXbjtE/9UVOuGbcdA8+2BaJQ=
X-Received: by 2002:a5b:648:: with SMTP id o8mr4860256ybq.260.1628881296925;
 Fri, 13 Aug 2021 12:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAL2pN5_4tPwhOxKu1g4YT3fEnzvhkQ0dLkP7-4RyUoEmPJiyVw@mail.gmail.com>
 <b307c1c2-e770-8926-7b68-3a0e69c659b0@fb.com>
In-Reply-To: <b307c1c2-e770-8926-7b68-3a0e69c659b0@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Aug 2021 12:01:25 -0700
Message-ID: <CAEf4BzYObyi3Mn6qh9vjhh-9dpyxWFzaaHgEOjZk3iKHWAzA8w@mail.gmail.com>
Subject: Re: libbpf attaching a raw socket
To:     Yonghong Song <yhs@fb.com>
Cc:     Mohan Parthasarathy <mposdev21@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 13, 2021 at 10:23 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/11/21 6:36 PM, Mohan Parthasarathy wrote:
> > Hi,
> >
> > I looked in the samples and header files, but could not find an
> > example for this. How does one convert this from bcc to libbpf. This
> > is the userspace code.
> >
> > bpf = BPF(src_file = "socket_filter.c", debug=0)
> > socket_filter = bpf.load_func("socket_filter", BPF.SOCKET_FILTER)
> > BPF.attach_raw_socket(socket_filter, "eth2")
> > socket_fd = socket_filter.sock
> >
> > I can do the following to set the type:
> >
> > err = bpf_program__set_socket_filter(obj);
> >
> > Is there any sample I can follow or any header files where I can look
> > for attaching a socket to the bpf code.
>
> There are a few examples in linux/samples/bpf directory:
>
> [~/work/bpf-next/samples/bpf] grep SOCKET_F *.c
> cookie_uid_helper_example.c:    prog_fd =
> bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
> fds_example.c:          return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
> sockex1_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
> sockex2_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
> sock_example.c: prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,

just please don't use bpf_load_program and bpf_prog_load, use proper
bpf_object APIs or BPF skeleton for loading programs.

> prog, insns_cnt,
>
> They should provide an example how to attach a socket_filter program
> to a socket.

You can probably also look at recently added bpf_tc_* APIs in
tools/testing/selftests/bpf/prog_tests/tc_bpf.c. I've CC'ed Kumar who
added those APIs recently.

>
> >
> > Thanks
> > Mohan
> >
