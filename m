Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E63655D3
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfGKLgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 07:36:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45767 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfGKLgU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 07:36:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so5385643lje.12
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gowXtkeVITMmhGMj1myvSJOoQpKoOyUOuod6NvEyUrE=;
        b=Hi3T9qq9ZX2sD6OlJP2ck97V/bj59SRLuwSyxxvXrRXXQ7MdIFdmokLyXz1I3YuyMI
         OjeEYxUSQP/RtaA9jySG2RYRwt5j0L9EebWyTCfzAaXTdb0N0G4UlYRz3gun5bdokWfp
         xfRZrdk7ROnWHkyDLzvFZItkw9P76vDvWIOIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gowXtkeVITMmhGMj1myvSJOoQpKoOyUOuod6NvEyUrE=;
        b=DZy2BHPQeekz2aWBWySdXsgpPns7PjB6qjQIQSbw+GVyqwjyVD4vBCHsaIB0rOpLJP
         kjUVDl/xh67yWVL1ehOcoziBZhH+EERyACa8BRZeR8xD4sKPpJmH8iDx65lEne/CZaR8
         8gtj8wNuJ8IryHPZRP2SFKCpukVIrCZ+VCc061MmhqTc5/32ivcYI6mmgYShGdILziWO
         6GaGsMNYiiBJW5Vh1I5jGO2xGM5JHqAlN2xdUj1AwrWG9oV0TAVaWzXzwmBgSdMzVG+9
         /A7CD4Os9WNWpYWvXog2bAmzo9LLcpQYdS4Dhss7jTcMAlJY4bty6WfdeST7paR8k959
         TFKg==
X-Gm-Message-State: APjAAAV6IuGD3s/XMrD/fIUagPW62OYqEUhGOipTGs9g9+sZFCfw4dAu
        G3VmYh/RVg4ygBo2RQ6OaJQTvmtJgMS10kBNZ1s4Mg==
X-Google-Smtp-Source: APXvYqw5kNwuodXhvfXQH8fkFgdYYPfLmFnNga2XZAN6tMleSYRmWD7F5IxzAkKPtB74MWYBqSNrYa4ydBrrUmyskFE=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr2224230ljg.33.1562844977640;
 Thu, 11 Jul 2019 04:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190708163121.18477-1-krzesimir@kinvolk.io> <20190708163121.18477-2-krzesimir@kinvolk.io>
 <CAEf4BzYDOyU52wdCinm9cxxvNijpTJgQbCg9UxcO1QKk6vWhNA@mail.gmail.com>
In-Reply-To: <CAEf4BzYDOyU52wdCinm9cxxvNijpTJgQbCg9UxcO1QKk6vWhNA@mail.gmail.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 11 Jul 2019 13:36:06 +0200
Message-ID: <CAGGp+cEaGphDCuZL+sbo2aCVumk2jrq9_Lshifg-Ewphfm40Wg@mail.gmail.com>
Subject: Re: [bpf-next v3 01/12] selftests/bpf: Print a message when tester
 could not run a program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        xdp-newbies@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 11, 2019 at 1:45 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 3:42 PM Krzesimir Nowak <krzesimir@kinvolk.io> wro=
te:
> >
> > This prints a message when the error is about program type being not
> > supported by the test runner or because of permissions problem. This
> > is to see if the program we expected to run was actually executed.
> >
> > The messages are open-coded because strerror(ENOTSUPP) returns
> > "Unknown error 524".
> >
> > Changes since v2:
> > - Also print "FAIL" on an unexpected bpf_prog_test_run error, so there
> >   is a corresponding "FAIL" message for each failed test.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index c5514daf8865..b8d065623ead 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -831,11 +831,20 @@ static int do_prog_test_run(int fd_prog, bool unp=
riv, uint32_t expected_val,
> >                                 tmp, &size_tmp, &retval, NULL);
> >         if (unpriv)
> >                 set_admin(false);
> > -       if (err && errno !=3D 524/*ENOTSUPP*/ && errno !=3D EPERM) {
> > -               printf("Unexpected bpf_prog_test_run error ");
> > -               return err;
> > +       if (err) {
> > +               switch (errno) {
> > +               case 524/*ENOTSUPP*/:
> > +                       printf("Did not run the program (not supported)=
 ");
> > +                       return 0;
> > +               case EPERM:
> > +                       printf("Did not run the program (no permission)=
 ");
>
> Let's add "SKIP: " prefix to these?

Not sure about it. The important part of the test (the program being
verified by the kernel's verifier) was still executed, so the test is
not really skipped.


>
> > +                       return 0;
> > +               default:
> > +                       printf("FAIL: Unexpected bpf_prog_test_run erro=
r (%s) ", strerror(saved_errno));
> > +                       return err;
> > +               }
> >         }
> > -       if (!err && retval !=3D expected_val &&
> > +       if (retval !=3D expected_val &&
> >             expected_val !=3D POINTER_VALUE) {
> >                 printf("FAIL retval %d !=3D %d ", retval, expected_val)=
;
> >                 return 1;
> > --
> > 2.20.1
> >



--
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
