Return-Path: <bpf+bounces-67635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64CB465E8
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9341CC77E3
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28F2FD7D5;
	Fri,  5 Sep 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcOvCxWT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC3302CA5
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108321; cv=none; b=Wg+th+YVk/W9GgQB9Dby0tR4OKRhuPfMJqBeg+Td6m9ajwdx/Gh5U2H3p2VHtrgYbayyGEnTHC8tWeYYixXqrUTm1Zo8VjoTWhzm8K+OkeNWv7iOKZaN8KVmvJLoueN40d1gEwhwttHUcSFUS5+vKmRLcZfDoueIlBk3LzpwLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108321; c=relaxed/simple;
	bh=yYtgB/lCesrOUCfcYrs+3wZVydl1upPeEBRgvcun8ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUsb+2s3Fpr7K43TIJKlHCt40DQmopVIP1rZzZ2jPSeGwTPIUc0E6eo/2iqABwVhLvUHFbVIKpx5Ua0Oag5p8TpFeIiHA0kyJiDycUrPfCzKG8l3B67p0sIVUvCBBwrohNgdh9fjaRCYPo5LaDT+mkUBaw5+BtkV13KQMhgDywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcOvCxWT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aff0775410eso497267966b.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108317; x=1757713117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTLENYJu/OsKF8041VDj4r4Xp9V1EUTD9fk/UwwiDAE=;
        b=RcOvCxWTR1742zUgeySABtIcgc9433zVQUHrx/siSCfaL6QI/vuPC+8VrnQnDJe8hd
         i7gb7/X8U+vzKC2GIIeotUFDmXwrK8CELLt3GvhsjFmDWdcAYnQP//RSKJ2sV5I+L7Ux
         5DkyW+J+At0Ubj/M/tzhVVLtAbtsMIB6sFtzZmPJACiinxIDm4132wmbvR8Skte7W3qm
         DfScbf99k7aPF+bVi17taIXJLxvrzF4n5uexSc9no0GkXF/q8suOm6kXKxBJbxtmvfHp
         vrX+vFBT0wcqDX0MF0HSC+9gdoPAf92MoIxLmPI566TTFxbH3IHT7eabBOl7n4Nh3pom
         0WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108317; x=1757713117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTLENYJu/OsKF8041VDj4r4Xp9V1EUTD9fk/UwwiDAE=;
        b=JqtVgaWiT/zLoNiBRfuEnEgC9X0TPoAzWJwVRHiVloHV8cNzemLAiGlcxH0OLkA1s5
         Qx/7zuC9n7C3wIxi2tQExsuCb8aZcRAZ01Hl9T+nDMDfWw4Kk6jbQqs9am2B6QVWKYRm
         H9And1gcgaBbxnVrr6zP21HmjIqaV/4qhJqHEvasq+KTC+5Li96drPN2+yWjWXNfbA49
         eewLswUB7N8P7cZ9TGNss2nmIfE22As34e/Ei5NV3r2MEhs/ydhFNLQUBHsY2VkIbWFa
         l+3m4jNu+JuCRflQdrq0OTzh6mnLAlVZqAu9+FGyYG/zNIFIc0UcgcJ1jOR0LV+PtKJ+
         Ch0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIBXHDrpw0IPjf6oHWQaz25NHyZKwkmTEoOgERfVjsS/z/vT5tMl5x7zLVSlSfkkbeOnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwCzKxT+vdj2W7mb0jH1E6LtN0jxTdB5iCVXtTU5JvJy1PleB
	LwW9mroggY/CnJdxICV5hdoCp/3hBjKb1koMfblfCzQjh1qmvymG6zQzRxi1Duu8X8kO7BXyihB
	8PLXIKdLb1cB1/1tJYeY+e1TFx2fWOUKYYAak
X-Gm-Gg: ASbGncv1PNIJ22hDC0JMnD8slT/LkDVswQcHG6gAnjYW4F0wzVaudPzurXwFsK1Vcds
	SHkRW0t/u1EqGf6A6vT+5JCZyz7HGPXwdfb3RVj4J49kmPtyBDOII2/A63xrHUO10nRDMWIwVPk
	6AWYtv2SKabbC5DaqnDDfdWTLZgqULW4KwKqaul+WTG4QcX1F5EttFN57QYn3RjKbdaXFLfLIyY
	Uf5
X-Google-Smtp-Source: AGHT+IEbzBzWfM2Sc8HuwKGQJAqmMHQUWD9w1MfFax3aAXbfMpjtAn6Ae2xe21bNCbWf9DNAIYmIY+z94OjgTkpID8s=
X-Received: by 2002:a17:906:7954:b0:b04:1d85:7106 with SMTP id
 a640c23a62f3a-b04931f4b3bmr473484466b.21.1757108316975; Fri, 05 Sep 2025
 14:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
 <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
 <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com> <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
In-Reply-To: <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:38:21 -0700
X-Gm-Features: Ac12FXzOiZRQp7LNanNyh2e0s7S7kuG0I739bLvKchclZITYD8foxGuKhxg_i68
Message-ID: <CAEf4BzawRYXXSJDiK4GzuYo=g-N_-QMgUXQAGN15eaPYuWXBWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-09-05 at 12:14 -0700, Andrii Nakryiko wrote:
> > On Fri, Sep 5, 2025 at 12:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2025-09-05 at 15:08 +0100, Mykyta Yatsenko wrote:
> > > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >
> > > > Add the ability to dump BPF program instructions directly from veri=
stat.
> > > > Previously, inspecting a program required separate bpftool invocati=
ons:
> > > > one to load and another to dump it, which meant running multiple
> > > > commands.
> > > > During active development, it's common for developers to use verist=
at
> > > > for testing verification. Integrating instruction dumping into veri=
stat
> > > > reduces the need to switch tools and simplifies the workflow.
> > > > By making this information more readily accessible, this change aim=
s
> > > > to streamline the BPF development cycle and improve usability for
> > > > developers.
> > > > This implementation leverages bpftool, by running it directly via p=
open
> > > > to avoid any code duplication and keep veristat simple.
> > > >
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > ---
> > >
> > > Lgtm with a small nit.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > > @@ -1554,6 +1573,35 @@ static int parse_rvalue(const char *val, str=
uct rvalue *rvalue)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static void dump(__u32 prog_id, enum dump_mode mode, const char *f=
ile_name, const char *prog_name)
> > > > +{
> > > > +     char command[64], buf[4096];
> > > > +     FILE *fp;
> > > > +     int status;
> > > > +
> > > > +     status =3D system("which bpftool > /dev/null 2>&1");
> > >
> > > Fun fact: if you do a minimal Fedora install (dnf group install core)
> > >           "which" is not installed by default o.O
> > >           (not suggesting any changes).
> >
> > I switched to `command -v bpftool` for now, is there any gotcha with
> > that one as well?
>
> Should be fine, I guess:
>
>   $ rpm -qf /usr/sbin/command
>   bash-5.2.37-1.fc42.x86_64

command is actually a shell built-in ([0]). At least for Bourne shells, I t=
hink.

  [0] https://pubs.opengroup.org/onlinepubs/009695399/utilities/command.htm=
l

>
> > >
> > > > +     if (status !=3D 0) {
> > > > +             fprintf(stderr, "bpftool is not available, can't prin=
t program dump\n");
> > > > +             return;
> > > > +     }
> > >
> > > [...]
> > >
> > > > @@ -1630,8 +1678,13 @@ static int process_prog(const char *filename=
, struct bpf_object *obj, struct bpf
> > > >
> > > >       memset(&info, 0, info_len);
> > > >       fd =3D bpf_program__fd(prog);
> > > > -     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =
=3D=3D 0)
> > > > +     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =
=3D=3D 0) {
> > > >               stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> > > > +             if (env.dump_mode & DUMP_JITED)
> > > > +                     dump(info.id, DUMP_JITED, base_filename, prog=
_name);
> > > > +             if (env.dump_mode & DUMP_XLATED)
> > > > +                     dump(info.id, DUMP_XLATED, base_filename, pro=
g_name);
> > >
> > > Nit: if you do `./veristat --dump=3Djited iters.bpf.o` there would be=
 an empty line
> > >      after dump for each program, but not for --dump=3Dxlated.
> > >
> >
> > Yeah, bpftool's output isn't consistent. I just added an extra empty
> > line, that makes dump a bit more clean (and I didn't mind two empty
> > lines, whatever).
>
> +1
>
> >
> > I was also finding it hard to notice where the dump for a given
> > program starts, so I reformatted header a bit. Overall, applied the
> > following changes and pushed to bpf-next, thanks for a useful feature!
>
> Yeap, nice little feature.
> I was doing bogus __xlated("foo") before in tests,
> just to see how assembly looks like.

