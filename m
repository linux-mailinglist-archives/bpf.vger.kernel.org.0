Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B580262B8D
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIJQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 05:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 05:16:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71FC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 02:16:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h17so1725029otr.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjOi/bbWMad20Ec0QztnNmD+ndSvVpYoN56P1CtMeqU=;
        b=XNULoNdpK6mF/hptn3B4F711PvI4Ltj5FvJpMYYPjddU+tNhSeoI3wzDynatrcvXrN
         RtnkeyfZI0n1nVl8QOybIM1eR/qXJSUXjM7WJiFigWy5BuHs0o6pUY8DjNySi1Tr9IO4
         LbGf9qwyo5q7jsX+YaVkm49KKjrkMw5Xa2vC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjOi/bbWMad20Ec0QztnNmD+ndSvVpYoN56P1CtMeqU=;
        b=d5xsdrDq5gokd30oJcdd4j6CVB2JmM6JKBrkCWCiUX4NWa1BUJmPc8AxDuXE00AjvY
         eLY/YVVAnUDkeVIk/cLnI088NGtbjxcrlfYyGEmPpPukAhr7HKqeVKTBcId/TA/hhQpD
         e4/PJLo93Zn08styZJkMcFgekgs0o7ljRZf66aRRz4q9UYTUR3qylsq6SUgjqxBvG05h
         eB2Om0lhk1AidcEx5cS7um81drEy4tTy6unpOyWfir7J4xC9Tzo1JMDtDU7dr/fuN7jl
         OPbdnhmx28a53asAGBZMMDgImdxG6lYpuGSxCio/HnDrE5Lk28xopWhniLmGevGoQmpv
         CpJA==
X-Gm-Message-State: AOAM532g8kChycO0MqsLbimtkNWBUkxq4MPODttpcrHaqgjJ8r11e2TR
        D9VNXU9uP7woj+xzcH1I93bxU/n++3jqo/w0cH4AUUK0EVmcOA==
X-Google-Smtp-Source: ABdhPJzMj5a3W8oLrwIpYbff8Up2JkBuMUKouwSSNSk90zRk0Pq42h5q6rZuSDqvJLJTtUjUN8orAfcC+47NM+HzFn0=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr57530otq.334.1599642995813;
 Wed, 09 Sep 2020 02:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200904095904.612390-1-lmb@cloudflare.com> <20200904095904.612390-2-lmb@cloudflare.com>
 <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com> <20200908195212.ekr3jn6ejnowhlz3@kafai-mbp>
In-Reply-To: <20200908195212.ekr3jn6ejnowhlz3@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 10:16:24 +0100
Message-ID: <CACAyw9-HZ0AzVYOg_2=PF9Y=xNwxNWUBk4VonxQLgRE6TmoZdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as PTR_TO_SOCKET
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 8 Sep 2020 at 20:52, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Sep 07, 2020 at 09:57:06AM +0100, Lorenz Bauer wrote:
> > On Sun, 6 Sep 2020 at 23:40, Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Fri, Sep 04, 2020 at 10:58:59AM +0100, Lorenz Bauer wrote:
> > > > Tracing programs can derive struct sock pointers from a variety
> > > > of sources, e.g. a bpf_iter for sk_storage maps receives one as
> > > > part of the context. It's desirable to be able to pass these to
> > > > functions that expect PTR_TO_SOCKET. For example, it enables us
> > > > to insert such a socket into a sockmap via map_elem_update.
> > > >
> > > > Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
> > > > equivalent to PTR_TO_SOCKET. There is one hazard here:
> > > > bpf_sk_release also takes a PTR_TO_SOCKET, but expects it to be
> > > > refcounted. Since this isn't the case for pointers derived from
> > > > BTF we must prevent them from being passed to the function.
> > > > Luckily, we can simply check that the ref_obj_id is not zero
> > > > in release_reference, and return an error otherwise.
> > > >
> > > > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
> > > >  1 file changed, 36 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index b4e9c56b8b32..509754c3aa7d 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
> > > >       return 0;
> > > >  }
> > > >
> > > > +BTF_ID_LIST(btf_fullsock_ids)
> > > > +BTF_ID(struct, sock)
> > > It may be fine for the sockmap iter case to treat the "struct sock" BTF_ID
> > > as a fullsock (i.e. PTR_TO_SOCKET).
> >
> > I think it's unsafe even for the sockmap iter. Since it's a tracing
> > prog there might
> > be other ways for it to obtain a struct sock * in the future.
> >
> > > This is a generic verifier change though.  For tracing, it is not always the
> > > case.  It cannot always assume that the "struct sock *" in the function being
> > > traced is always a fullsock.
> >
> > Yes, I see, thanks for reminding me. What a footgun. I think the
> > problem boils down
> > to the fact that we can't express "this is a full socket" in BTF,
> > since there is no such
> > type in the kernel.
> >
> > Which makes me wonder: how do tracing programs deal with struct sock*
> > that really
> > is a request sock or something?
> PTR_TO_BTF_ID is handled differently, by BPF_PROBE_MEM, to take care
> of cases like this.  bpf_jit_comp.c has some more details.

Thanks, that helps a lot. I also dug into the BTF pointer patchset as
well, and now your comment about PTR_TO_BTF_ID being NULL makes sense
as well. Sigh, I should've looked at this from the start.

What I still don't understand is how PTR_TO_BTF_ID is safe for a
struct sock* that points at a smaller reqsk for example. How do we
prevent a valid, non-faulting BPF read from accessing memory beyond
the reqsk?

>
> [ ... ]
>
> > > > @@ -4561,6 +4569,9 @@ static int release_reference(struct bpf_verifier_env *env,
> > > >       int err;
> > > >       int i;
> > > >
> > > > +     if (!ref_obj_id)
> > > > +             return -EINVAL;
> > > hmm...... Is it sure this is needed?  If it was, it seems there was
> > > an existing bug in release_reference_state() below which could not catch
> > > the case where "bpf_sk_release()" is called on a pointer that has no
> > > reference acquired before.
> >
> > Since sk_release takes a PTR_TO_SOCKET, it's possible to pass a tracing
> > struct sock * to it after this patch. Adding this check prevents the
> > release from
> > succeeding.
> Not all existing PTR_TO_SOCK_COMMON takes a reference also.
> Does it mean all these existing cases are broken?
> For example, bpf_sk_release(__sk_buff->sk) is allowed now?

I'll look into this. It's very possible I got the refcounting logic
wrong, again.

>
> >
> > >
> > > Can you write a verifier test to demonstrate the issue?
> >
> > There is a selftest in this series that ensures calling sk_release
> > doesn't work, which exercises this.b
> I am not sure what Patch 4 of this series is testing.
> bpf_sk_release is not even available in bpf tracing iter program.

I built a patched kernel where sk_release is available, and verified
the behaviour that way. My idea was that as long as the test fails
we've proven that releasing the sk is not possible. I realize this is
counterintuitive and kind of brittle. Maybe your point about
__sk_buff->sk will allow me to write a better test.

>
> There are ref tracking tests in tools/testing/selftests/bpf/verifier/ref_tracking.c.
> Please add all ref count related test there to catch the issue.

Ack.


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
