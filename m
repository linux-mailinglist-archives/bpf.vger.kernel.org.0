Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F71D496689
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiAUUo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiAUUo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 15:44:59 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C2C061401
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:44:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f21so1871402ljc.2
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CU7d6N2TyhYd51KHoDvsMP3R4d4RwWAQlCc6c2NhKCs=;
        b=DsviKe9ihwwlXrEXa3MlGUGSoJ19U687O425LiC7zdNwlqS1yaSP/7Qpu7muG9wy7k
         76bPktqYKw5IL49rTPfwNYeeAMBhreu0+gFQGwz51X4tlxxcIxm4fyLriho65hcSxIp6
         0NlSNmiqUTPvBGPWR+U+Senvvltz4hHCCdQsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CU7d6N2TyhYd51KHoDvsMP3R4d4RwWAQlCc6c2NhKCs=;
        b=GZMQYj+PO+4C4w8ZH0/F2PMvAO4nSuKjFAF2VzWlJYLt+6yOOQuFliCI7rdGlS5QRc
         gNWq/n/Gyfsr1UuoquobvqrD8dMWfNtfi08VJ96zOtjWzVuI/YewMseYQyT3c1VR0V06
         sWzSjeuoRydbKkdFrOUP1CsmD0FQ/CyfLSypd8UHqSTvTpkPPaiF+pFbCrzyV9pA7AV/
         c0DKbfiC30JnAJDJHAW9bH1etJ2bfbubPxNJfpEUl0ZaoPCUBYCidsMnd2U5QFTuWevD
         1XWI8vIiLS4YBALSdCjCmMJ+nZGM4WQqCjNp6NGpQfx++BFVQ3XSoh4YWksI3seRD6jw
         T2sg==
X-Gm-Message-State: AOAM531Yp7vZlct1cbXtWx7Lea6CXYHqoh74O2hjDrJ2k+gd3cCCJBmp
        ba8dEz9in+JcTyZ5WXMlPXn6fpMUrHTHOuppIFr1MA==
X-Google-Smtp-Source: ABdhPJx6VPwPJdjlVQM1Gs7oamI3Dr1XTcHiMcHm86HRPMZJZWbMx/sxdR8YIZ3xyVeh4S7vFT+69kV87CQxg5M4adI=
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr4324918ljn.301.1642797890154;
 Fri, 21 Jan 2022 12:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20220112142709.102423-1-mauricio@kinvolk.io> <20220112142709.102423-4-mauricio@kinvolk.io>
 <CAEf4BzZ2LEFzX1VoWY_NNowbS2+j04pCWS4DdrDi5nFe7CvcXw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2LEFzX1VoWY_NNowbS2+j04pCWS4DdrDi5nFe7CvcXw@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 21 Jan 2022 15:44:39 -0500
Message-ID: <CAHap4zsH97nNA8KSVeeKGxgfoh8bfno0jd0m45UH8CJN_trXbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpftool: Add gen btf command
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

On Fri, Jan 14, 2022 at 9:09 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 12, 2022 at 6:27 AM Mauricio V=C3=A1squez <mauricio@kinvolk.i=
o> wrote:
> >
> > This command is implemented under the "gen" command in bpftool and the
> > syntax is the following:
> >
> > $ bpftool gen btf INPUT OUTPUT OBJECT(S)
>
> "gen btf" doesn't really convey that it's a minimized BTF for CO-RE,
> maybe let's do something more verbose but also more precise, it's not
> like this is going to be used by everyone multiple times a day, so
> verboseness is not a bad thing here. Naming is hard, but something
> like `bpftool gen min_core_btf` probably would give a bit better
> pointer as to what this command is doing (minimal CO-RE BTF, right?)
>

I agree. `bpftool gen min_core_btf` seems just fine to us.

> >
> > INPUT can be either a single BTF file or a folder containing BTF files,
> > when it's a folder, a BTF file is generated for each BTF file contained
> > in this folder. OUTPUT is the file (or folder) where generated files ar=
e
> > stored and OBJECT(S) is the list of bpf objects we want to generate the
> > BTF file(s) for (each generated BTF file contains all the types needed
> > by all the objects).
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
> >  tools/bpf/bpftool/gen.c | 117 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >
>
> [...]
>
> > +
> > +       while ((dir =3D readdir(d)) !=3D NULL) {
> > +               if (dir->d_type !=3D DT_REG)
> > +                       continue;
> > +
> > +               if (strncmp(dir->d_name + strlen(dir->d_name) - 4, ".bt=
f", 4))
> > +                       continue;
> > +
> > +               snprintf(src_btf_path, sizeof(src_btf_path), "%s/%s", i=
nput, dir->d_name);
> > +               snprintf(dst_btf_path, sizeof(dst_btf_path), "%s/%s", o=
utput, dir->d_name);
> > +
> > +               printf("SBTF: %s\n", src_btf_path);
>
> What's SBTF? Is this part of bpftool "protocol" now? It should be
> something a bit more meaningful...
>

These are almost debug leftovers. I updated them to be more meaningful.



> > +
> > +               err =3D btfgen(src_btf_path, dst_btf_path, objs);
> > +               if (err)
> > +                       goto out;
> > +       }
> > +
> > +out:
> > +       if (!err)
> > +               printf("STAT: done!\n");
>
> similar, STAT? what's that? Do we need "done!" message in tool's output?
>
> > +       free(objs);
> > +       closedir(d);
> > +       return err;
> > +}
> > +
> >  static const struct cmd cmds[] =3D {
> >         { "object",     do_object },
> >         { "skeleton",   do_skeleton },
> > +       { "btf",        do_gen_btf},
> >         { "help",       do_help },
> >         { 0 }
> >  };
> > --
> > 2.25.1
> >
