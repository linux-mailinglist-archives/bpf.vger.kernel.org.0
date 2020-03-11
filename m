Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437C9181C21
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgCKPPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 11:15:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39927 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKPPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 11:15:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id e16so2402644qkl.6
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+41engWsi9UoZh82ULHGWmLZ87Gc36Sb5PUQS0Hglg=;
        b=YzGAA2/Yx4cGcjMX6es7Pchi0Ndd7QQ01SCV6Y8F7Y0L75D17Gc2DrNb39FRqVUh9Z
         HGT/97GGFKmC6Z0Y+WN6boGgBjMTRPo1fkV17l2ApMaYI3otBzQIQTL07/Q1Sp5G7+F2
         hlxA2cO3V2rhzqOFYOrpOU5TUyMUDeMF7oQhvj9ULsnXuAk7+08aaB9/4dCG2Pj2Gs8s
         6Ry8CiW8TX5PLBBDPEAiZVhDoXFkVWz+gIW22UPAGx6nnRdXPeaoZQizg2f/PJRJ6pNY
         DKPCkIKoBQXm3vwPz32tLxpjdOVs/NlNu87NOvQGq4MyeFdTvjI8CEIkZhwLquOA1FG3
         A7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+41engWsi9UoZh82ULHGWmLZ87Gc36Sb5PUQS0Hglg=;
        b=tPVUBbstqplk5lpFH9oYDrtBbuBUeV/BdOgX4nuXLT6C9owsJgC0vI+aReD4f/DIqx
         7LtFjV1klpWPn+bJ9bOq9Z1dMBxA/VSTztzNnLhnDpmK3n4Na6jAD5i9UK3M0h2kV4h1
         o75UPv0UtmvNl5N+cwNtq/rnTW7NirkTDrATLJkQbdqhzJjVhNxwvWVB1MK0mWsadbI4
         Hy+TsrgEgY5RjSXVHGtEikYsfAnifa0YIounzJJEW3MdClsW0eow1RIr6D1cAkpVDhOh
         Y+6HbW7dF0lltrCKSxfugK9aoMBHXf8sRaNQlnFpjos2mhWaBHzUs2LnQNNvRoXC3xqe
         fWbA==
X-Gm-Message-State: ANhLgQ1BH6mtyHyr2hFFrqRZwxwPb2zmKVRam55vKBYe1vyUEfZ0/Euk
        PoUT0W6pbTZYxUGmJdgi7vvvyXUHLK4EJuRSJWw=
X-Google-Smtp-Source: ADFU+vu72uwN90JjWBzsYhGPYUvE3v/4V4FH8VJ+qPA6hKVsCFjFnSlAWm1V54W7nIATHYbwAZ0ADNh09FhFnzQyGS4=
X-Received: by 2002:a37:e40d:: with SMTP id y13mr3268469qkf.39.1583939744144;
 Wed, 11 Mar 2020 08:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <libbpf/libbpf/issues/138@github.com>
In-Reply-To: <libbpf/libbpf/issues/138@github.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Mar 2020 08:15:33 -0700
Message-ID: <CAEf4BzY7Qsu1aoN__nxyis4OgWvwWi5XJ9XJe3gOeEHJGdGFRw@mail.gmail.com>
Subject: Re: [libbpf/libbpf] Is it possible to do SHARED_UMEM between
 processes? (#138)
To:     "libbpf/libbpf" 
        <reply+AAD4BK6TLXS3OGWEWHS5PTF4OTGSDEVBNHHCFBYSRA@reply.github.com>,
        bpf <bpf@vger.kernel.org>
Cc:     "libbpf/libbpf" <libbpf@noreply.github.com>,
        Subscribed <subscribed@noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf@vger.kernel.org, it's a better place to ask questions about
bpf and libbpf.

On Wed, Mar 11, 2020 at 6:48 AM Maximilian Gaul
<notifications@github.com> wrote:
>
> I am struggling with my project to get SHARED_UMEM running between two or=
 more processes. I made some changes to the lib in order to be able to copy=
 struct xsk_umem into shared memory.
>
> But now I get the error:
>
> symbol lookup error: /lib/x86_64-linux-gnu/libpthread.so.0: undefined sym=
bol: _dl_allocate_tls, version GLIBC_PRIVATE
>
> In my opinion, a working example for SHARED_UMEM is strongly required. Th=
e only information I find about this topic is an e-mail from Nov, 2019 in t=
he linux mailing list and two sentences from here : https://www.kernel.org/=
doc/html/latest/networking/af_xdp.html#xdp-shared-umem-bind-flag
>
> Please!!
>
> =E2=80=94
> You are receiving this because you are subscribed to this thread.
> Reply to this email directly, view it on GitHub, or unsubscribe.
