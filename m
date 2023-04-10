Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09896DC9AB
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjDJRBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJRB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 13:01:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46B1BF2
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 10:01:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt17so1707826ejb.11
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt2KV6lKophxHEHu2Q4gBf9vT+Lj2+YhOQxG8TKhnJw=;
        b=C97G2wyoIFklXi98Zkq85LP4wFnojto2PG5zZQq7V3/BNEQsZKSzMhXveXkq3S4Ktf
         01QZNOhMHVfLGLkUK0l5gWKWBvoQmFphfZspcNkcqvo9nddx5mm9gcDRfJnYgr9IUgEI
         IvkEHyIVAoWVgh4WBU7fr+Myedl0jwPTzHoAqumEF90kIEzNJQ6Hh34XcVxGplLPapfy
         Mx8yIMku9opDEqtzVbznnA9Rya506pwZEuDK0XPgcpKFjGlyvVxLW+fXJ5V0Qsxcikzb
         Z8FX3rK6I11fIIWCLaA2SLr/26KVQTBtKtOTCgBpd5TWxmlJdtLu/8L27EboLn27T2bu
         cLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt2KV6lKophxHEHu2Q4gBf9vT+Lj2+YhOQxG8TKhnJw=;
        b=yLZqDhkuuSYd/ijh8/+ZhqV56lb1/q2cpFEXzpMs+DbxOxYoFcqLz+dcGfOzTNYN2v
         9uLdrOTonSkIuP+NuVRXsQO6CkH62TPrl6JX+dhc/gCVd3Kzy6l+iO7k9aVP8HaxygjU
         ImYJxtAbtZ8KkTLebLqmAnQsVodDRbKIg8ZezYXtdszCy7Q5fbb//UMQE35bnYug2nIX
         Z5LoLF0DFfBV5fEUqIdwiE9y6n0mjQ4xPlpJCtJ5gHV8El9RQs3cXfJzbhBnJMmSMxiY
         sbf4mMbxQdJfWcfVnLTVnjLKVzPEtGw/1IKSED/ehTGDadeiS0hVW70mD+yhBQhGHytx
         IGYA==
X-Gm-Message-State: AAQBX9dwSYzbz+KQakf2RAdrBpf8hpYKBzwUBpGP3aLn9/fxypsEi276
        BCAUzshUGRLmdbQCadgp0Q7nYGdtqixm6vqG6M/6+jChwgw=
X-Google-Smtp-Source: AKy350bnyJmufjjahH+ON8VAJmOI0LUI+t5G0qzhai3P5FfJUrN9dmtQ23VungMjSBkbB0QolBSXZwTDmtXujz9ysMA=
X-Received: by 2002:a17:906:830c:b0:94a:7c21:6ade with SMTP id
 j12-20020a170906830c00b0094a7c216ademr1885053ejx.5.1681146086834; Mon, 10 Apr
 2023 10:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
 <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
 <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
 <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com>
 <20230405025726.nesfo5rwuiqnzgqc@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaD+8tStmJ4i5TeSNpCMhwZ4CkTYMYf+N9YHwK46EtCcA@mail.gmail.com> <CA+PiJmQ8_uVczuHTrOz9uJh2z2Ywf0HVNttbKMVPLF59oSQ4XQ@mail.gmail.com>
In-Reply-To: <CA+PiJmQ8_uVczuHTrOz9uJh2z2Ywf0HVNttbKMVPLF59oSQ4XQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Apr 2023 10:01:14 -0700
Message-ID: <CAEf4BzawdCjhrb=ksvofJ0LAPen1nnVWSYPEC1pE=Bcmv_6yYg@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 2:05=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> On Tue, Apr 4, 2023 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > so the idea that bpf prog will see opaque ctx =3D=3D name and a set
> > of kfuncs will extract different things from ctx into local dynptrs ?
> >
> > Have you considered passing dynptr-s directly into bpf progs
> > as arguments of struct_ops callbacks?
> > That would be faster or slower performance wise?
> >
>
> The kfunc records data that fuse then uses to clean up afterwards.
> That opaque struct seemed like the best place for it to live.
> Alternatively, I could provide dynpointers up front, but those are
> read only or read/write up front based on which operation they're
> dealing with, and may or may not be promotable to read/write, which
> involves creating a new dynpointer anyways. If I took that approach,
> I'd likely present a read-only dynpointer, and wrap it in a larger
> struct that contains the needed meta information. I'd definitely need
> to ensure that only fuse-bpf can call those kfuncs in that case.
>
> >
> > yep. Don't be shy from improving the verifier to your needs.
> >
>
> Uploaded a couple patches yesterday :)
> A patch to remove the buffer requirement for the slice functions, and
> another to accept dynpointer tagged mem as mem in helper functions.
>
>
> On Wed, Apr 5, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > note that even if bpf_dynptr_slice() accepts a buffer, it won't ever
> > touch it for LOCAL dynptrs, as the data is already linear in memory.
> > This buffer is filled out only for skb/xdp **and** only if requested
> > memory range can't be accessed as sequential memory. So you won't be
> > copying data.
> >
>
> I added an '__opt' tag annotation for this, so I can avoid needing to
> supply the buffer in those cases.
>
> > For bpf_dynptr_read(), yep, it will copy data. Regardless if you are
> > going to use it or not, we should relax the condition that final
> > buffer should be smaller or equal to dynptr actual size, it should be
> > bigger and we should just write to first N bytes of it.
> >
>
> Should dynptr_read return the length read? Otherwise you need to get
> the dynpointer length and adjust for all the offsets to figure out how
> much was probably read. But returning the length read would break
> existing programs.

You are right, that's a pretty big change in semantics. I take it
back, let's keep bpf_dynptr_read() as is. As it is currently, it
matches bpf_probe_read_{kernel,user} behavior and return semantics, so
it's good to keep all that consistent.

But I think that's ok, because your use case is solvable once we land
Joanne's bpf_dynptr_get_size() helper from her latest dynptr patch
set. Just to test, here's what I tried, and it works, so I think it
will also for for you with bpf_dynptr_get_size() to get a minimum of
your fixed buffer size and actual dynptr content size:

$ git diff
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..4e0172156cc9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -37,7 +37,7 @@ int test_read_write(void *ctx)
        char write_data[64] =3D "hello there, world!!";
        char read_data[64] =3D {};
        struct bpf_dynptr ptr;
-       int i;
+       int n, i;

        if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
                return 0;
@@ -46,9 +46,15 @@ int test_read_write(void *ctx)

        /* Write data into the dynptr */
        err =3D bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0=
);
+       if (err)
+               goto cleanup;
+
+       n =3D bpf_get_prandom_u32();
+       if (n >=3D sizeof(read_data))
+               n =3D sizeof(read_data);

        /* Read the data that was written into the dynptr */
-       err =3D err ?: bpf_dynptr_read(read_data, sizeof(read_data), &ptr, =
0, 0);
+       err =3D bpf_dynptr_read(read_data, n, &ptr, 0, 0);

        /* Ensure the data we read matches the data we wrote */
        for (i =3D 0; i < sizeof(read_data); i++) {
@@ -58,6 +64,7 @@ int test_read_write(void *ctx)
                }
        }

+cleanup:
        bpf_ringbuf_discard_dynptr(&ptr, 0);
        return 0;
 }


> I also noticed that the various dynpointer offset/length checks don't
> seem to account for both the dynpointer offset and the read/write etc
> offset. All of the bounds checking there could use another pass.

If there are bugs, then yeah, let's definitely fix all of them. I
think offset problems are not noticeable right now, because we haven't
yet added the bpf_dynptr_advance() API, so currently offset is always
zero. So nothing should be broken right now, but please send fixes if
you've spotted issues.

>
> > >
> > > > At the moment I'm using bpf_dynptr_slice and declaring an empty and
> > > > unused buffer. I'm then hitting an issue with bpf_strncmp not
> > > > expecting mem that's tagged as being associated with a dynptr. I'm
> > > > currently working around that by adjusting check_reg_type to be les=
s
> > > > picky, stripping away DYNPTR_TYPE_LOCAL if we're looking at an
> > > > ARG_PTR_TO_MEM. I suspect that would also be the case for other dyn=
ptr
> > > > types.
> >
> > So this seems unintended (or there is some unintentional misuse of
> > memory vs dynptr itself), we might be missing something in how we
> > handle arguments right now. It would be nice if you can send a patch
> > with a small selftest demonstrating this (and maybe a fix :) ).
> >
>
> Done :) Though not sure if the selftests I added are sufficient.
> https://lore.kernel.org/bpf/20230406004018.1439952-1-drosen@google.com/

Yep, thanks! Already reviewed, let's iterate on respective patch set.

>
> >
> > We had previous discussions about whether to treat read-only as a
> > runtime-only or statically known attribute. There were pros and cons,
> > I don't remember what we ended up deciding. We do some custom handling
> > for some SKB programs, but it would be good to handle this
> > universally, yep.
> >
>
> I think it's currently not tracked, although the read only tag was
> being used for the dynptr itself. Almost tricked me there. In that
> case it'd probably be easier to add dynptr_data_ro than to add that
> information everywhere.
>

Not sure how hard it is to add static tracking of r/o vs r/w, but a
separate helper for read-only data probably makes sense anyways.

> >
> > +1. I feel like we are just missing a few helpers to help extract
> > and/or compare variable-sized strings (like bpf_dynptr_strncmp
> > mentioned earlier) for all this to work well. But a concrete use case
> > would allow us to design a coherent set of APIs to help with this.
>
> Should be able to get that patch set together soon. I'm reworking the
> test code with the verifier changes I mentioned above, and then will
> be doing a round of cleanup to make it a bit more possible to see
> what's actually in use now.

Nice.
