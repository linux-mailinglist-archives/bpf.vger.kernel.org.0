Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DED20286
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEPJ3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 May 2019 05:29:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36889 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfEPJ3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 05:29:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id q17so2089413lfo.4
        for <bpf@vger.kernel.org>; Thu, 16 May 2019 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HM9SvHS2yQg5lQDqjeY//dYhXZJ7+P9Sm7ZfbrJXCXU=;
        b=V1k3/XZxzovk7JJHkqCg3cH/W8kUyNgUXSi9/WPf1de6k7MSutSrHrHYIUTtkb8ngW
         5t2E2dQf3TQMSjodY05gI/CccMyZ379RU0hPVE/6M8CMJdW8Oyq8nKSvhuU5Kd2WQLcd
         LBf/nrR0cKxOB5jBDoYvUDwEadTJwcnV6WymY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HM9SvHS2yQg5lQDqjeY//dYhXZJ7+P9Sm7ZfbrJXCXU=;
        b=IbP0j6yHbz+NjmEF68at+PY9BM3ToxCQ/oVwHovxRlrepIvvIYITNsFNsfDVNEV0ls
         EikAA4BDgzT/pfk/lUvabCM+t1ir10hYZe6OwoHJRDglPPZHXtGAVWmC9smiX8CU5+sh
         Vbn15TZUCjxWBcjofM75P5lArv/c6ML+vduEpXugfl5dCZNkADAeZ69xsfuMhR6wufRt
         AGy3grAYfRPouRrf89RqJ4S2TeM2Aw3Cmmt1OeGMw1XgmTHBc4wMbIOHEfAu4lJrVXPa
         7QTJnAzBjjAGeYb2NNGp64RAd7uGuNsFj93ue3i9ANI/53SJyu/oHNoZYmmUSsnxuAkd
         fMMw==
X-Gm-Message-State: APjAAAUnLroBVYiBrgMYwoH49ZjrKdvkzwaBHtB9Q/42IMQFmh0/MuFU
        Ral9GYwZdatr8FJBuGMXeE4Vg7+k743zkp3UhXzrbA==
X-Google-Smtp-Source: APXvYqyvsOQM7w9EXRxEbtugoxgrFvrhiv21XJSHhpquhJVqYnCi1hEcUbucEs9/tSacw8t+EJ9lQo5qhf1d1S/q+2k=
X-Received: by 2002:a19:ae14:: with SMTP id f20mr22736742lfc.49.1557998989943;
 Thu, 16 May 2019 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190515134731.12611-1-krzesimir@kinvolk.io> <20190515134731.12611-3-krzesimir@kinvolk.io>
 <20190515144537.57f559e7@cakuba.netronome.com>
In-Reply-To: <20190515144537.57f559e7@cakuba.netronome.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 16 May 2019 11:29:39 +0200
Message-ID: <CAGGp+cGN+YYVjJee5ba84HstSrHGurBvwmKmzNsFRvb344Df3A@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester
 could not run a program
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     bpf@vger.kernel.org,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 15, 2019 at 11:46 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 15 May 2019 15:47:27 +0200, Krzesimir Nowak wrote:
> > This prints a message when the error is about program type being not
> > supported by the test runner or because of permissions problem. This
> > is to see if the program we expected to run was actually executed.
> >
> > The messages are open-coded because strerror(ENOTSUPP) returns
> > "Unknown error 524".
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index ccd896b98cac..bf0da03f593b 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unp=
riv, uint32_t expected_val,
> >                               tmp, &size_tmp, &retval, NULL);
> >       if (unpriv)
> >               set_admin(false);
> > -     if (err && errno !=3D 524/*ENOTSUPP*/ && errno !=3D EPERM) {
> > -             printf("Unexpected bpf_prog_test_run error ");
> > -             return err;
> > +     if (err) {
> > +             switch (errno) {
> > +             case 524/*ENOTSUPP*/:
> > +                     printf("Did not run the program (not supported) "=
);
> > +                     return 0;
> > +             case EPERM:
> > +                     printf("Did not run the program (no permission) "=
);
> > +                     return 0;
>
> Perhaps use strerror(errno)?

As I said in the commit message, I open-coded those messages because
strerror for ENOTSUPP returns "Unknown error 524".

>
> > +             default:
> > +                     printf("Unexpected bpf_prog_test_run error ");
> > +                     return err;
> > +             }
> >       }
> > -     if (!err && retval !=3D expected_val &&
> > +     if (retval !=3D expected_val &&
> >           expected_val !=3D POINTER_VALUE) {
> >               printf("FAIL retval %d !=3D %d ", retval, expected_val);
> >               return 1;
>


--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
