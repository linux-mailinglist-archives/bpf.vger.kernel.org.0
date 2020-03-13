Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFC184530
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 11:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgCMKtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 06:49:12 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39569 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMKtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Mar 2020 06:49:11 -0400
Received: by mail-ot1-f54.google.com with SMTP id a9so9582160otl.6
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zDGO/wMxvrULSwnGrzp2vXAOiGJ3kcXIpE9vC2i8y8=;
        b=WwN6oyzLs9EJlWG8xeaOqjoSRKkHcUrxVPS4hP3RB6KEjnhDoLBZP1cHlDL1mm9ykt
         9MM4iXO17h/q7vcsKSAn/OpS69ax/PN/69E+G8vXsK1b2wPfVks7KiNM30p7XEJr87vP
         zNsRF5+xDZ98S99R3ZRMdtI6/ImX6dO6aacR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zDGO/wMxvrULSwnGrzp2vXAOiGJ3kcXIpE9vC2i8y8=;
        b=YiOLdOapT0zIPA9/eE8HBVOdOT9Cm9+/juESEQ9rcj8E5v6ZrWHM6bFnYze6YCqdSI
         0zsSzN9heorV6cmUKbfrzcJrG9oAz35Yk5d4BrStzx69i8zDHNpCesG1swEwgRlXkv/P
         MOCtvmJUE3m9AgAAjkrI1QcYg2QndwVi94GF/DZJIas5JFpsIw9ghs1U7hgjLzureayD
         pmwpDcr258bIT3TkBbTnnPVxqBBmj4ZLZtV9gv1m7gRK21FXq//BVpCDB8iiJgBkiH4e
         pVCH/C7TgdZl7dl07D94c3P0GH2HgVKpOE0p8aYtcMUVnAQbWo6DMi9aYHj+V426t+Ww
         4pbA==
X-Gm-Message-State: ANhLgQ2jfTwB9MrF06pF1MwzVnWjVaF5DUnIQigQGe/R2AFQlE4EK1vZ
        /SOhIjJTgheN8lxt9TJJF+RTT2w7W6Rg7u7iDpQUrw==
X-Google-Smtp-Source: ADFU+vuPV0GNj/N7z+pf4dTOlYOrubct10RZnwzq2aA4zEWV92DQuyeumEpwtMML9PEoyaZhDBeyK4gkswV114IkEyk=
X-Received: by 2002:a9d:10d:: with SMTP id 13mr10867912otu.334.1584096549164;
 Fri, 13 Mar 2020 03:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200312015822.bhu6ptkx5jpabkr6@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-Ui5FECjAaehP8raRjcRJVx2nQAj5=XPu=zXME2acMhg@mail.gmail.com> <20200312175828.xenznhgituyi25kj@ast-mbp>
In-Reply-To: <20200312175828.xenznhgituyi25kj@ast-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 13 Mar 2020 10:48:57 +0000
Message-ID: <CACAyw98cp2we2w_L=YgEj+BbCqA5_3HvSML1VZzyNeF8mVfEEQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Return fds from privileged sockhash/sockmap lookup
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 12 Mar 2020 at 17:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> but there it goes through ptrace checks and lsm hoooks, whereas here similar
> security model cannot be enforced. bpf prog can put any socket into sockmap and
> from bpf_lookup_elem side there is no way to figure out the owner task of the
> socket to do ptrace checks. Just doing it all under CAP_NET_ADMIN is not a
> great security answer.

Reading between the lines, you're concerned about something like a sock ops
program "stealing" the socket and putting it in a sockmap, to be retrieved by an
attacker later on?

How is that different than BPF_MAP_GET_FD_BY_ID, except that it's CAP_SYS_ADMIN?

> but bpf side may still need to insert them into old.
> you gonna solve it with a flag for the prog to stop doing its job?
> Or the prog will know that it needs to put sockets into second map now?
> It's really the same problem as with classic so_reuseport
> which was solved with BPF_MAP_TYPE_REUSEPORT_SOCKARRAY.

We don't modify the sockmap from eBPF:
   receive a packet -> lookup sk in sockmap based on packet -> redirect

Why do you think we'll have to insert sockets from BPF?

> I think sockmap needs a redesign. Consider that today all sockets can be in any
> number of sk_local_storage pseudo maps. They are 'defragmented' and resizable.
> I think plugging socket redirect to use sk_local_storage-like infra is the
> answer.

Maybe Jakub can speak more to this but I don't see how this solves our problem.
We need a way to get at struct sk * from an eBPF program that runs on
an skb context,
to make BPF socket dispatch feasible. How would we use
sk_local_storage if we don't
have a sk?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
