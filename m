Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B963920A8
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhEZTNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhEZTNy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 15:13:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD3C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 12:12:21 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id o18so3573291ybc.8
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qfwceoorfDQckLQEjpSLtgrIG1ctNdi/PnmuDXclB3o=;
        b=Im3rRQzIsRFgBODMZFgBphWw2jK4MV1A5AODB33/i2affoP/BIi1hawaBjgZ7ex5up
         VI14dEZbnNWm7lEu4OYZ5ypbIXKBQAk/jA0WunS984CX2eRzQRiazit831m30vA/nLao
         sreRv5Hxx/i2DhEvXbFsYwhPkELIUjOJBFiNImadOSu33yXNwa68/+cu1bv2Ec3HUQ90
         qecsGWa0f/9xpEvCtaLJDbY7a/nd07Pwa7+IVHq73aqRmAJwKL9MvLKjQff7H/Ut0qjA
         Mkkz5AXOUvYS493uaUMe6Mj4Wm+LqJWbeg3+5RJxeJa9BDeYvuqH83bYnLJqQslGm/TP
         gs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qfwceoorfDQckLQEjpSLtgrIG1ctNdi/PnmuDXclB3o=;
        b=MpOjAh/oXQHRXhaxknZxso00GwpnOGJRzXqUbDRreaupvCYN5nSxS5M42KY7ryhC+e
         oZvcS/xG9Xw59E99d3LT4zpdJt3s5LT1cMM1my4NQrZM1+mDFNLXIGL6pqYLgTCvC9YW
         zyVf89ZhZzXb04KEnv7bnPd3mi/4TpBFK17rI5Z7nWSdYotJw0hl6QbRDhN0g++OqdQx
         jeVlmXV/nLGYBIMtfXrgwTwXWUCzCXiiu2aBSy1XjZA1xU8fqkgGCd8z8XGFw1NnTW11
         5/INHwHT061oqjxnzo9vlHET5QClATHa8BgXV5o9NpG6xWnhS0nGJmm+6JU2fnnJgPAF
         ZiZQ==
X-Gm-Message-State: AOAM531/wkG3x5RD/hMwBFJ6ZwnppbEn86etI2kghXruPR6oECHRUl3p
        vDiWlLzdauJMTeSNEdSapBlQQCb06/WV6GBRNMw=
X-Google-Smtp-Source: ABdhPJzj3Ji3Qib5dbLAhYKWIX5JbevTYsz15ima70qPCxJbQ1K0l7TbzyfB5RSIudJ6JJVF4qHmkVijhH+i5iFywEM=
X-Received: by 2002:a5b:286:: with SMTP id x6mr55050547ybl.347.1622056340372;
 Wed, 26 May 2021 12:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon>
In-Reply-To: <20210526125848.1c7adbb0@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 12:12:09 -0700
Message-ID: <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> Hi All,
>
> I see a need for a driver to use different XDP metadata layout on a per
> packet basis. E.g. PTP packets contains a hardware timestamp. E.g. VLAN
> offloading and associated metadata as only relevant for packets using
> VLANs. (Reserving room for every possible HW-hint is against the idea
> of BTF).
>
> The question is how to support multiple BTF types on per packet basis?
> (I need input from BTF experts, to tell me if I'm going in the wrong
> direction with below ideas).

I'm trying to follow all three threads, but still, can someone dumb it
down for me and use few very specific examples to show how all this is
supposed to work end-to-end. I.e., how the C definition for those
custom BTF layouts might look like and how they are used in BPF
programs, etc. I'm struggling to put all the pieces together, even
ignoring all the netdev-specific configuration questions.

As for BTF on a per-packet basis. This means that BTF itself is not
known at the BPF program verification time, so there will be some sort
of if/else if/else conditions to handle all recognized BTF IDs? Is
that right? Fake but specific code would help (at least me) to
actually join the discussion. Thanks.

>
> Let me describe a possible/proposed packet flow (feel free to disagree):
>
>  When driver RX e.g. a PTP packet it knows HW is configured for PTP-TS an=
d
>  when it sees a TS is available, then it chooses a code path that use the
>  BTF layout that contains RX-TS. To communicate what BTF-type the
>  XDP-metadata contains, it simply store the BTF-ID in xdp_buff->btf_id.
>
>  When redirecting the xdp_buff is converted to xdp_frame, and also contai=
ns
>  the btf_id member. When converting xdp_frame to SKB, then netcore-code
>  checks if this BTF-ID have been registered, if so there is a (callback o=
r
>  BPF-hook) registered to handle this BTF-type that transfer the fields fr=
om
>  XDP-metadata area into SKB fields.
>
>  The XDP-prog also have access to this ctx->btf_id and can multiplex on
>  this in the BPF-code itself. Or use other methods like parsing PTP packe=
t
>  and extract TS as expected BTF offset in XDP metadata (perhaps add a
>  sanity check if metadata-size match).
>
>
> I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this ide=
a,
> and they pointed out that AF_XDP also need to know what BTF-layout is
> used. As Magnus wrote in other thread; there is only 32-bit left in
> AF_XDP descriptor option. We could store the BTF-ID in this field, but
> it would block for other use-cases. Bj=C3=B8rn came up with the idea of
> storing the BTF-ID in the BTF-layout itself, but as the last-member (to
> have fixed offset to check in userspace AF_XDP program). Then we only
> need to use a single bit in AF_XDP descriptor option to say
> XDP-metadata is BTF described.
>
> In the AF_XDP userspace program, the programmers can have a similar
> callback system per known BTF-ID. This way they can compile efficient
> code per ID via requesting the BTF layout from the kernel. (Hint:
> `bpftool btf dump id 42 format c`).
>
> Please let me know if this it the right or wrong direction?
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
