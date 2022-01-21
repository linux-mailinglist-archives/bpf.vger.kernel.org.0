Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA088496690
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiAUUpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAUUpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 15:45:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786CC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:45:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a28so6120932lfl.7
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uxTrw+AT4Z4hFq9OQh3UXx0QiOHdIRBcnwHs8G1s3f4=;
        b=bTkkgx/ru/kjbankRrw2xRbbbD6du9RHIAVIUMOfBU4t9A3gfQHVeLaUvdQGw9ubmq
         SXC4mf4OjW9HX/NL2+2Le/RUKYrOLASIRlMIgTHrIRgNprVtF6x1J+fIVUDriVnNbWao
         KUbSXWbd5uPQrA4w8ljByUE+4ZIgBEpqbTGz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uxTrw+AT4Z4hFq9OQh3UXx0QiOHdIRBcnwHs8G1s3f4=;
        b=16ZQo3fTXBPzLfRb725sfHXi6VuoQ8Q6CQIZ6fSKu64R4tjbrpD9GULUGj2eYdlBge
         3gyQkZXNvsb2KqgOhSyDX6lcDsv68sE7II65DMNT7prLfy+76NMXFCoARm5Pp6STFwdV
         33JGOcwklcCOZMMY7N6jTeytrPkKbD9z/PnwgMuUmxQY7ecqVt6jvX+ZXOaGufj7+1GA
         OPFNW+w/OwX7E/xf2w1NWLY+ge+etxjlJb1fXLzT7PF+bxnVfMTOeM4NUPa7zIqgtUzF
         eDUJim7yH5xcszZ23damXoLBanb5qmyvHxdGylRU28WRivE7xHco3yCFO7tFj8DTyl77
         e1aA==
X-Gm-Message-State: AOAM5324zjG3UO2NlLr/wjFdqDw2FHN1lniS+1TRzdDLJxz9S8c7iFqd
        JjDeP4cO0OCTvZc/X4eS3ukKmh8SnYmM41xXQq4beg==
X-Google-Smtp-Source: ABdhPJyrKkp6VxgHmqOWhq9Zu/IYvR/JTejtQJyAIJpfUjyaGp3WLf+spqeL0H3S/3DvaUyL4/TNUkBU1ckPRvAujGM=
X-Received: by 2002:a05:6512:151b:: with SMTP id bq27mr4777460lfb.56.1642797928816;
 Fri, 21 Jan 2022 12:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20220112142709.102423-1-mauricio@kinvolk.io> <20220112142709.102423-5-mauricio@kinvolk.io>
 <CAEf4BzZN39SM85zuOV+6gP1KK0fdvUGVxL3THpzRNWTOi7KCxw@mail.gmail.com>
In-Reply-To: <CAEf4BzZN39SM85zuOV+6gP1KK0fdvUGVxL3THpzRNWTOi7KCxw@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 21 Jan 2022 15:45:17 -0500
Message-ID: <CAHap4ztH7vaVjhYMvBKbpkrbVP93egxwNSy08TrNv=GaJWRBGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] bpftool: Implement btf_save_raw()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 9:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 12, 2022 at 6:27 AM Mauricio V=C3=A1squez <mauricio@kinvolk.i=
o> wrote:
> >
> > Helper function to save a BTF object to a file.
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
> >  tools/bpf/bpftool/gen.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
>
> See suggestions, but either way:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index cdeb1047d79d..5a74fb68dc84 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1096,6 +1096,36 @@ static int do_help(int argc, char **argv)
> >         return 0;
> >  }
> >
> > +static int btf_save_raw(const struct btf *btf, const char *path)
> > +{
> > +       const void *data;
> > +       FILE *f =3D NULL;
> > +       __u32 data_sz;
> > +       int err =3D 0;
> > +
> > +       data =3D btf__raw_data(btf, &data_sz);
> > +       if (!data) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
>
> can do just return -ENOMEM instead of goto
>
> > +
> > +       f =3D fopen(path, "wb");
> > +       if (!f) {
> > +               err =3D -errno;
> > +               goto out;
> > +       }
> > +
> > +       if (fwrite(data, 1, data_sz, f) !=3D data_sz) {
> > +               err =3D -errno;
> > +               goto out;
> > +       }
> > +
> > +out:
> > +       if (f)
>
> with early return above, no need for if (f) check
>

After those suggestions I decided to completely remove the out label.



> > +               fclose(f);
> > +       return err;
> > +}
> > +
> >  /* Create BTF file for a set of BPF objects */
> >  static int btfgen(const char *src_btf, const char *dst_btf, const char=
 *objspaths[])
> >  {
> > --
> > 2.25.1
> >
