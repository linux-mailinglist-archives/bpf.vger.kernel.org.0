Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3F46F621
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 22:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhLIVtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 16:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIVtN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 16:49:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778AC061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 13:45:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id p13so6658747pfw.2
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCHfiU4tq4HbwDHN09Ikocjc2fuFWtUM4gkIujDO8GQ=;
        b=gqzQd8FSdJ0yYHN1f5H1bMTBCO6DDy7VzQ8uCo+qEocnzuJWOhk9hUyVcicTFgDY/m
         DXRMIOjvy37KZIo1c+l52KI6KZjylzTnXyxZZdic23WsbcsNIU6b8k6liNRbDmSlWxmG
         tQspvM0dQyKwil6a0DgFxkNKO9HSoWpevEdskSLk7c2gCcJv0eDTBcGOxMimjoVClavu
         xUtEGd1+mFlnsmUVlWW7yd94I4C/iyWTlRk7mFtLUt/4QMawuNp+0SLJlhBXYOxBzpPQ
         ZHR467EJErTH+LcfDMBrVD81wouZd3mV4Hvtvzj2hS/eVtfQeDL/8P57qnz2swCbSnyM
         xycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCHfiU4tq4HbwDHN09Ikocjc2fuFWtUM4gkIujDO8GQ=;
        b=kfwFl0nzT2U2VN7DHGUBd/NLjb67g7KQfgPiN0OD+kyFSgC12ndTwxdnFpHto1gtFd
         Eg8OgNiXoXPhtEqkXjHDL2wSb6Hu6MbqwlcVNIOQVLCfo4sbp9m+ohhRctm5+kbgBvZU
         FXPFbyN5MYZJ7+A5yIGHDARQURBbxOI+FKIGQ0NkZx7Nd+GMAbUuUzWzaH9zfZmGDVe+
         koN9Kv9TElgQ0XmJhqDvDqpSjNoxBkyOQqinQJidqzTHf+SPVKaOK5ZfXrdDWLroPdh5
         5gBtMbkf88jCoUX4Z8nHDP2M+/Mple/W8vyAoHQU6hDdwUaKLIvaMa9tdU3/q5EpQi0I
         tj+w==
X-Gm-Message-State: AOAM533LqCRqZEcySA78RahVfNB70W7P/pShIca0GMv2g1Q19FvVsRX9
        k4NATbRwdZsFS93ICnriAw9eu8Co/EtDgCgmUrM=
X-Google-Smtp-Source: ABdhPJwGw4FH7HvP8o0OAboYB0SgOJNpcctXTHlq0Z7sXnC5IuNbHvBulXhj+c26LFsAxLhWkDeageBRVYBAQN6YtzU=
X-Received: by 2002:a63:6881:: with SMTP id d123mr35211076pgc.497.1639086339550;
 Thu, 09 Dec 2021 13:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
 <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
 <CA+khW7gVp9bp0Q4OcqQxLW2ARL=6VjiOZu6f2vWOt4vvzj29UQ@mail.gmail.com> <CAEf4BzZ1-5Tbq5MXkJ=8REFGRFs5aXnT0aGbaQkWYKVo4vuqcA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1-5Tbq5MXkJ=8REFGRFs5aXnT0aGbaQkWYKVo4vuqcA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 Dec 2021 13:45:27 -0800
Message-ID: <CAADnVQJzq5j2WecExdzwG+oc8iTP3pSm5OXsmF5cLQvPKHNKeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 8, 2021 at 12:04 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > > +static const char *reg_type_str(enum bpf_reg_type type)
> > > > +{
> > > > +       static const char * const str[] = {
> > > > +               [NOT_INIT]              = "?",
> > > > +               [SCALAR_VALUE]          = "inv",
> > > > +               [PTR_TO_CTX]            = "ctx",
> > > > +               [CONST_PTR_TO_MAP]      = "map_ptr",
> > > > +               [PTR_TO_MAP_VALUE]      = "map_value",
> > > > +               [PTR_TO_STACK]          = "fp",
> > > > +               [PTR_TO_PACKET]         = "pkt",
> > > > +               [PTR_TO_PACKET_META]    = "pkt_meta",
> > > > +               [PTR_TO_PACKET_END]     = "pkt_end",
> > > > +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > > > +               [PTR_TO_SOCKET]         = "sock",
> > > > +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> > > > +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > > > +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > > > +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > > > +               [PTR_TO_BTF_ID]         = "ptr_",
> > > > +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > > > +               [PTR_TO_MEM]            = "mem",
> > > > +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > > > +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > > > +               [PTR_TO_FUNC]           = "func",
> > > > +               [PTR_TO_MAP_KEY]        = "map_key",
> > > > +       };
> > > > +
> > > > +       return str[base_type(type)];
> > >
> > > well... now we lose the "_or_null" part, that can be pretty important.
> > > Same will happen with RDONLY flag, right?
> > >
> > > What can we do about that?
> > >
> >
> > We can format the string into a global buffer and return the buffer to
> > the caller. A little overhead on string formatting.
>
> Can't use global buffer, because multiple BPF verifications can
> proceed at the same time.

I think reg_type_str() can still return a const char string
with flags.
It's not going to be a direct str[base_type(type)]; of course.
The str[] would be different.

If that doesn't work out we can try:
s/verbose(,"%s", reg_type_str[])
/verbose(, "%s%s", reg_type_str(), reg_type_flags_str())
