Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B53182C2A
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLJQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 05:16:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39694 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLJQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 05:16:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id a9so5361187otl.6
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAMw405Z2I4+Abs+opHY3r5ZOWNvTtzJUiJNOPxVtPI=;
        b=rHqoJ6QGCxOky7urAwPH4FGhioj5JIMXoSDlwY9zTBHLJ8aeYKHNXLS3tQbRIZPZZ8
         KdmtCY63VBupFWWNm3zICSVHObycPq57RQTrsoOvVqR9PCxcjtr3POPMK1oU/u4GstWJ
         z3mLNzdpYVJOI3ex4M4Vjj78XnewbiokIzf54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAMw405Z2I4+Abs+opHY3r5ZOWNvTtzJUiJNOPxVtPI=;
        b=lbNtW+vax/NtWZaAdZYpiq33LMZOuWyWNG+PdXTQ0EBtPYA/461nw2kCEO5ULD7cvE
         iju4ZTxr0o1X+BjewU3vJyzXTZu6U539shTOoXuIDci9dHEm5Kqw6b9lL68nndhuTSk2
         d4OcbsR/ou+5lRY9QXsPVCySnHeZghXnibjv29dBTuSWW8+xilizZZ5i/1moL8p+IVnL
         xyvbC4W8SrDxR7Ai/SY4Kbkdid85OCRJ32JcZzzswulbQR6ig0lWTpgpb0S6z6ZwuTn8
         BGdhH5pWR3O5rlQ9nAo4ciiS12CCR3k8PXljucnfJnVDs2Qfqby6gTrY3fr4EshIwO3w
         WcQA==
X-Gm-Message-State: ANhLgQ0gutHugKzc/kQ1CgobL4QeFenbZakbeN4zpZmvrdtI7s90NmxJ
        zQsymua3wkfOX+fQ0OOLSbV7aVMkEdWedKaXBTQl9w==
X-Google-Smtp-Source: ADFU+vsdJMOalgUIpdt+aKol4bjP/txCqYfA3vDI7yyHw+g9tMIoPWM9O/s2/G+B+Anfuz52IPyABEZd1GZB0YAIuPg=
X-Received: by 2002:a9d:10d:: with SMTP id 13mr5781391otu.334.1584004605574;
 Thu, 12 Mar 2020 02:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200312015822.bhu6ptkx5jpabkr6@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200312015822.bhu6ptkx5jpabkr6@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 12 Mar 2020 09:16:34 +0000
Message-ID: <CACAyw9-Ui5FECjAaehP8raRjcRJVx2nQAj5=XPu=zXME2acMhg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Return fds from privileged sockhash/sockmap lookup
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 12 Mar 2020 at 01:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> we do store the socket FD into a sockmap, but returning new FD to that socket
> feels weird. The user space suppose to hold those sockets. If it was bpf prog
> that stored a socket then what does user space want to do with that foreign
> socket? It likely belongs to some other process. Stealing it from other process
> doesn't feel right.

For our BPF socket dispatch control plane this is true by design: all sockets
belong to another process. The privileged user space is the steward of these,
and needs to make sure traffic is steered to them. I agree that stealing them is
weird, but after all this is CAP_NET_ADMIN only. pidfd_getfd allows you to
really steal an fd from another process, so that cat is out of the bag ;)

Marek wrote a PoC control plane: https://github.com/majek/inet-tool
It is a CLI tool and not a service, so it can't hold on to any sockets.

You can argue that we should turn it into a service, but that leads to another
problem: there is no way of recovering these fds if the service crashes for
some reason. The only solution would be to restart all services, which in
our set up is the same as rebooting a machine really.

> Sounds like the use case is to take sockets one by one from one map, allocate
> another map and store them there? The whole process has plenty of races.

It doesn't have to race. Our user space can do the appropriate locking to ensure
that operations are atomic wrt. dispatching to sockets:

- lock
- read sockets from sockmap
- write sockets into new sockmap
- create new instance of BPF socket dispatch program
- attach BPF socket dispatch program
- remove old map
- unlock

> I think it's better to tackle the problem from resize perspective. imo making it
> something like sk_local_storage (which is already resizable pseudo map of
> sockets) is a better way forward.

Resizing is only one aspect. We may also need to shuffle services around,
think "defragmentation", and I think there will be other cases as we gain more
experience with the control plane. Being able to recover fds from the sockmap
will make it more resilient. Adding a special API for every one of these cases
seems cumbersome.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
