Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED620BD42
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 01:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFZXwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgFZXwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 19:52:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106EC03E97A
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 16:52:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so10425809qkc.6
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAA8ABCzwjipcqq8eM4x/9IKsZ3JzkSLkDu0d2A7seM=;
        b=atoEPKv0ZD7lgPzK0HKGk3ChdTczB/1U8jJ1FL7VjlLurFsNZnE3le7Ht9lSGM2Iwm
         3spOQy4iM3JXj3mcswIhuEu7cJztBrd/nfJ0IBjAzqi2YxZEeGMgAXIIwebQnCH1Eue+
         rzKbmDNXsN0mhJUjGxqdB6DVMp58/deO9zTrVzqL7unznPI80yRaf45lKgoeSTjcCiAY
         hFdsE7rnzxY+h0ZMtx1fmPNO2sYDJlXReT95xSi7pkjpfbZP6r1y3/KWqkhCYev0PubX
         Q4C+vnzZOPE9LQmhAenVR6UoaQgumu3VnccqUHRTgEcJTjoZVc6Y1VNat2eUk+oWHArP
         Qw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAA8ABCzwjipcqq8eM4x/9IKsZ3JzkSLkDu0d2A7seM=;
        b=KAIBt52gNx1uGzEaMwdO4pMJ0KmkiSCp409hVxMUNBVxH/zBAk28VFgjI654AZ0DpA
         5dkZsfByWjP4Kg7T9pvJi2lXs2uPBu7RUQkbQJ7Q1hUl9BNPN2D01CiM06Di+CPOrs6O
         5TpcMjB5j8ABXZArOVKPE0ZccBdLy8jZvpIlP5dQ0gaW+68E/fzhETjV9cZ/H4EqhDJ5
         irncDJX6cKNEvat+ed0xqZqCZdk8tcsuePgUo359kNLDcw2iag0YA0lDlQKw29KtFFp7
         DbVTVJu9CD92Ju9rpzAaKttL75Y+LOkuE9CTM7qmuFzLuLIXxOiffZ0mFcyvoRT3ZnfF
         pY5g==
X-Gm-Message-State: AOAM5309if069OSag+5q3kzu+lBKKQVmjgDhhTImT8bH9FJOyoEkEukd
        PJQOmKnCuQHK/qYFk65OHMaCSP4pp23VPyv7gd8ak6g7
X-Google-Smtp-Source: ABdhPJx21jIeSfIWsfpASN600xu4ofZ8Uf4WmEKHzEysehzmxGp3lEMXwwozacZ7zIdCGuTj9CugQAcGtbs6YxPIyBE=
X-Received: by 2002:a37:8a02:: with SMTP id m2mr5025080qkd.17.1593215555254;
 Fri, 26 Jun 2020 16:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200626165231.672001-1-sdf@google.com> <20200626165231.672001-3-sdf@google.com>
 <862111f0-b71a-0b7a-1f52-4f2fed28b8ff@iogearbox.net>
In-Reply-To: <862111f0-b71a-0b7a-1f52-4f2fed28b8ff@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 26 Jun 2020 16:52:24 -0700
Message-ID: <CAKH8qBvmdV=4xh0qBReB4DTmyzjrUJQY2R8-naaAyvfPJ5iBTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpftool: support BPF_CGROUP_INET_SOCK_RELEASE
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 26, 2020 at 4:08 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 6/26/20 6:52 PM, Stanislav Fomichev wrote:
> > Support attaching to sock_release from the bpftool.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/bpf/bpftool/main.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> > index 5cdf0bc049bd..0a281d3cceb8 100644
> > --- a/tools/bpf/bpftool/main.h
> > +++ b/tools/bpf/bpftool/main.h
> > @@ -92,6 +92,7 @@ static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
> >       [BPF_CGROUP_INET_INGRESS] = "ingress",
> >       [BPF_CGROUP_INET_EGRESS] = "egress",
> >       [BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
> > +     [BPF_CGROUP_INET_SOCK_RELEASE] = "sock_release",
> >       [BPF_CGROUP_SOCK_OPS] = "sock_ops",
> >       [BPF_CGROUP_DEVICE] = "device",
> >       [BPF_CGROUP_INET4_BIND] = "bind4",
>
> This one is not on latest bpf-next, needs rebase due to 16d37ee3d2b1 ("tools, bpftool: Define
> attach_type_name array only once").
Sure, will follow up with a v3 to address Andrii's suggestions + will
rebase on top of the latest bpf-next!
