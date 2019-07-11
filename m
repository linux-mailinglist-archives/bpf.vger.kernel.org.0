Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C836565A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfGKMFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 08:05:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42230 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfGKMFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 08:05:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so5501026lje.9
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YFCxGO6KV5W4HnGiTTvC8J1Y11PoOncGzlRaAH+YitY=;
        b=gqHdZrhydiZVnlVQy4pXamlOAmehSSQyqPVvYp1XIWDNaJIflXL/y4ej78BNjvmDaT
         wjE4YsuM3hdrMdUB0VaTKvxtXl2poyXQwc/m8RN1z/8tvvHBETHl3ZTSZM6RniSAVqwV
         pZOz19hsGlInW+f5P9Q5Ejvr2x52m5Xtb4Ick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YFCxGO6KV5W4HnGiTTvC8J1Y11PoOncGzlRaAH+YitY=;
        b=FGz6UziHRgbi+lOCPUAfaWniM6XI/v5XO9aqEuHDi6F3ZNIq+xZsd2KlyqG0cU148V
         wsiTIStGUPwIvdKfHTqGbSgot53GTyD0BH+uuVdgF/sy1QKgAcI2XHXFhsi74jD5efYA
         +MeoYRXbjrPnX4rbczk2nsgroO7DdKUPTT9CD2I2MNS8E8cAGWDzwugCtrI5QhvgtdvH
         b/K7M0lab7BAwL1BE1590DYwjISNrm8wB682Rd1VKOh+9icgWwOlVwfsKjwjAK4PLcc2
         rU9dX7ftPtsx2IopUXNuSgyvE+j5pDTJMBAU17T2Xc1BXfmN0zgXSfW3wOTcxVaPT1MX
         8Xeg==
X-Gm-Message-State: APjAAAUioOqMfThAGEoRc8qtS+toNddZAiaFTxiMFPcySavusYu3uFjf
        0F8GGoH9Ys6rZtBeCtGEp0r861+JwH4MYuWdbxRHJw==
X-Google-Smtp-Source: APXvYqy/Vz9FGOUgNf13SFed5ZNaL8L9LUuJauqPxNNzGUQUaWoOaZowfSiu0Yr4jPIs+S/05vQRVoFtTPtN+Yo+kKc=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr2286572ljj.151.1562846722686;
 Thu, 11 Jul 2019 05:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708163121.18477-1-krzesimir@kinvolk.io> <20190708163121.18477-4-krzesimir@kinvolk.io>
 <CAEf4BzbM6EiCkN5mwK1YP-NC2bavkkHV7nFR-PXCWGOvVt7nTg@mail.gmail.com>
In-Reply-To: <CAEf4BzbM6EiCkN5mwK1YP-NC2bavkkHV7nFR-PXCWGOvVt7nTg@mail.gmail.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 11 Jul 2019 14:05:11 +0200
Message-ID: <CAGGp+cHi0siwc1+q--JM_+a0QOO6tWgJiOkqsdbjGxjMP3G1Zw@mail.gmail.com>
Subject: Re: [bpf-next v3 03/12] selftests/bpf: Avoid another case of errno clobbering
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

On Thu, Jul 11, 2019 at 1:57 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 3:43 PM Krzesimir Nowak <krzesimir@kinvolk.io> wro=
te:
> >
> > Commit 8184d44c9a57 ("selftests/bpf: skip verifier tests for
> > unsupported program types") added a check for an unsupported program
> > type. The function doing it changes errno, so test_verifier should
> > save it before calling it if test_verifier wants to print a reason why
> > verifying a BPF program of a supported type failed.
> >
> > Changes since v2:
> > - Move the declaration to fit the reverse christmas tree style.
> >
> > Fixes: 8184d44c9a57 ("selftests/bpf: skip verifier tests for unsupporte=
d program types")
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> >  tools/testing/selftests/bpf/test_verifier.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index 3fe126e0083b..c7541f572932 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -864,6 +864,7 @@ static void do_test_single(struct bpf_test *test, b=
ool unpriv,
> >         int run_errs, run_successes;
> >         int map_fds[MAX_NR_MAPS];
> >         const char *expected_err;
> > +       int saved_errno;
> >         int fixup_skips;
>
> nit: combine those ints? or even with i and err below as well?

Will do.

>
> >         __u32 pflags;
> >         int i, err;
> > @@ -894,6 +895,7 @@ static void do_test_single(struct bpf_test *test, b=
ool unpriv,
> >                 pflags |=3D BPF_F_ANY_ALIGNMENT;
> >         fd_prog =3D bpf_verify_program(prog_type, prog, prog_len, pflag=
s,
> >                                      "GPL", 0, bpf_vlog, sizeof(bpf_vlo=
g), 4);
> > +       saved_errno =3D errno;
> >         if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
> >                 printf("SKIP (unsupported program type %d)\n", prog_typ=
e);
> >                 skips++;
> > @@ -910,7 +912,7 @@ static void do_test_single(struct bpf_test *test, b=
ool unpriv,
> >         if (expected_ret =3D=3D ACCEPT) {
> >                 if (fd_prog < 0) {
> >                         printf("FAIL\nFailed to load prog '%s'!\n",
> > -                              strerror(errno));
> > +                              strerror(saved_errno));
> >                         goto fail_log;
> >                 }
> >  #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > --
> > 2.20.1
> >



--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
