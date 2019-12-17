Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1D122710
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2019 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLQIwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Dec 2019 03:52:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfLQIwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Dec 2019 03:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576572730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sfzAo5vBd9xBpXpg/m9erufLQX8/hEzWPbggzsXBlI=;
        b=E0Pta9IuuNopFvNijTKjpCc7EMVRDfk/MH2lGveeCkuUbzF2fmqI7KSYv+EhukB8R+8vZ7
        l1sCl7yAIQmZaebLjgrMCH/TIO6v4i9xt8RR6zgB/uJoSa6DylVWIN/5yqZfNkzAzIbxKK
        8xIDQ5gwoPEmgxVcI3x44pd1f3TMXOI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-y_NiNpLcPQC7qYaL7RmNpw-1; Tue, 17 Dec 2019 03:52:06 -0500
X-MC-Unique: y_NiNpLcPQC7qYaL7RmNpw-1
Received: by mail-lf1-f69.google.com with SMTP id x23so929394lfc.5
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 00:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2sfzAo5vBd9xBpXpg/m9erufLQX8/hEzWPbggzsXBlI=;
        b=d5oq2P2B/MJWD6ZGmS28vVeqHg5AEkUjH/nhWz+x52LcLFwAPm8yIs8QfUzGhvqxfW
         83TBsrBDFPf7DP/tCTYaIjyhq0pQSTrL/p+7blzyEop52N9MljheSZIUhyQ5lRFSXYK4
         TkRXKsmHFXDynZuPPHftLMtRxxH3YFBFaFkNUyf6onCXMEndkB7t/Kvw72fFuOZEJfQi
         RC5dnfPSWhUeLgI0PjLYY0oDCAELBSbT3p583yeU/umOHWlcE6XI64VFbMR9pR7hZ77f
         UKPR2RHlEmHQGJpLXcLkI6OZF9k9plUFCDbTt7RC8jVsLH+wHGaVRODNw/5A+3CgHOBg
         G7Iw==
X-Gm-Message-State: APjAAAUdp7zu3fOdTgrbGWQOx9Cym9JhFOj/J7mVxrqgEfTUNqSyylKN
        0F30w82rPr1J9vm3B3l+VIHPIGSOr7lLjkMdPqAb4zFkKdth10EqymHjXIQkUlwus2PNhMHg8Kb
        +KUty2CuGIQtO
X-Received: by 2002:ac2:4c98:: with SMTP id d24mr2006037lfl.138.1576572724916;
        Tue, 17 Dec 2019 00:52:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUTXfP3gC+bSm0puS7McJoc6U2zWJVUpu+u+gPeGHHrQPXQVoIPgkHXF9gVHxdF264lxcjbw==
X-Received: by 2002:ac2:4c98:: with SMTP id d24mr2006024lfl.138.1576572724703;
        Tue, 17 Dec 2019 00:52:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i2sm10308240lfl.20.2019.12.17.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:52:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0265C1800B3; Tue, 17 Dec 2019 09:52:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn.topel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ido Schimmel <idosch@idosch.org>
Subject: Re: [RFC PATCH bpf-next] xdp: Add tracepoint on XDP program return
In-Reply-To: <20191217005944.s3mayy473ldlnldl@ast-mbp.dhcp.thefacebook.com>
References: <20191216152715.711308-1-toke@redhat.com> <CAJ+HfNhYG_hzuFzX5sAH7ReotLtZWTP_9D2jA_iVMg+jUtXXCw@mail.gmail.com> <20191217005944.s3mayy473ldlnldl@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Dec 2019 09:52:02 +0100
Message-ID: <87h81z8hcd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 16, 2019 at 07:17:59PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> On Mon, 16 Dec 2019 at 16:28, Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>> >
>> > This adds a new tracepoint, xdp_prog_return, which is triggered at eve=
ry
>> > XDP program return. This was first discussed back in August[0] as a wa=
y to
>> > hook XDP into the kernel drop_monitor framework, to have a one-stop pl=
ace
>> > to find all packet drops in the system.
>> >
>> > Because trace/events/xdp.h includes filter.h, some ifdef guarding is n=
eeded
>> > to be able to use the tracepoint from bpf_prog_run_xdp(). If anyone ha=
s any
>> > ideas for how to improve on this, please to speak up. Sending this RFC
>> > because of this issue, and to get some feedback from Ido on whether th=
is
>> > tracepoint has enough data for drop_monitor usage.
>> >
>>=20
>> I get that it would be useful, but can it be solved with BPF tracing
>> (i.e. tracing BPF with BPF)? It would be neat not adding another
>> tracepoint in the fast-path...
>
> That was my question as well.
> Here is an example from Eelco:
> https://lore.kernel.org/bpf/78D7857B-82E4-42BC-85E1-E3D7C97BF840@redhat.c=
om/
> BPF_TRACE_2("fexit/xdp_prog_simple", trace_on_exit,
>              struct xdp_buff*, xdp, int, ret)
> {
>      bpf_debug("fexit: [ifindex =3D %u, queue =3D  %u, ret =3D %d]\n",
>                xdp->rxq->dev->ifindex, xdp->rxq->queue_index, ret);
>
>      return 0;
> }
> 'ret' is return code from xdp program.
> Such approach is per xdp program, but cheaper when not enabled
> and faster when it's triggering comparing to static tracepoint.
> Anything missing there that you'd like to see?

For userspace, sure, the fentry/fexit stuff is fine. The main use case
for this new tracepoint is to hook into the (in-kernel) drop monitor.
Dunno if that can be convinced to hook into the BPF tracing
infrastructure instead of tracepoints. Ido, WDYT?

-Toke

