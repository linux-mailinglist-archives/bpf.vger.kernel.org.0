Return-Path: <bpf+bounces-63045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23215B01B56
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 14:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9375A25D3
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18428937F;
	Fri, 11 Jul 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiWrZtj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B5944E;
	Fri, 11 Jul 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235285; cv=none; b=BYHXJx80EXt4plaq5ME2HbbJi5OrXnRsTjJej5u3S2uoqcJG1TKbLcW+aXpqkkdsHikwZaclq/LCDNPcouLBgvkIIPQdZed6PDfe7HSwuEoeTm4sG7cHWXB2VfcVzNOj9l3FVnsXY50o7GuBsp09PkiZ6Z/AcrFDhjLyLaMVpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235285; c=relaxed/simple;
	bh=44FoQT6SK/ZgICkMw/I79alO3WyPgcpbY35lDvTtBQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWypaGCtBT6pD3YQNyRLy2JUi56g4NL5b6il99V/LjVaVFih8SrWjNPbeObu0RzQpXUDWChpm5Pj4KB8L7RnqqbpeZH03mc/peh90mLXz+KE3jFnjfDlAbgyd4dhmos5mbsbVOh04GWuD1vPexFhiCKJ4rQd6+VjZL2Gc+OakL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiWrZtj6; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-710e344bbf9so20391867b3.2;
        Fri, 11 Jul 2025 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235282; x=1752840082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDHOb5QPFnpEDCoZi4dKVCZ6qNSnWfYIdsA5ijHoqBA=;
        b=aiWrZtj6YP9Yyl9PoV2iwrhakQZkUGmqc6DGgJgfK80lNfjTrQrjXSlmn0eOm2kaxs
         xsHWbsqxGH+djqOw0Mpn6htaT75mU5WvmyAUWDY6Xw+vGLQMiJ+8ahddLvGTgtW+kL47
         MTiyRlRpg292uMkLdwEkSPTS1drEQMDU3WJYrR+qYdg+RlhfpqExLm16UarJBctLvphy
         I4KMMhq4JB+3ry5LHr3db0iz4P9qt6P8hi4rvr6OnvNCMZiwt1img6VjUV+XaBtb5ed1
         xHZcoq3NmYP9HZ/n5wO2GdUfykLsfxEMHrpUIyR7BRO1l3gcJGbqyWdtbjeJMS9arj6F
         0VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235282; x=1752840082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDHOb5QPFnpEDCoZi4dKVCZ6qNSnWfYIdsA5ijHoqBA=;
        b=eCMmUCrqogh77zQ6LJcPh7Z1x0A920pJNrhansdk2fosRAvjBiRoCIMp+LDeHb/8df
         wjamULWpe13dLG64PmwY9N/15BvZOxckhdXRPi3eVkNdgxX2EfERgrsv660jLI03HnlF
         mP1tyz1T5H6Xu5+SpZIH0jbyB6SUYtP7f4Ac/rRC5OGPe/Z0JB+7+lugbRq3VYexQSCq
         LVWIt/5oy9Et+Wdb1s1jCCzl8jMyNtBdXw8MWmOwwv9cQAnw3m8vKH4kbXKcVl4biu/2
         xXFBG0ZVqsfnwMvTpOnN0QuVuPIkzXOwAuhRrRCT/S106QBx1SGzYsdVnleHh79DlP7d
         Yl0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNniQojSyIy3pEboRc2niT3+u/OnKao77hguSp+37F6UyyLN5CZ4WF3TO5kgjyeGPMxgc=@vger.kernel.org, AJvYcCWUNDZn6gewI9zHXsSzuNJqfppLnK1J917A9UXajDz6od2YS1+kXr4qK/H2sBVffHj5m4iPzwwOX0kWhlNc@vger.kernel.org
X-Gm-Message-State: AOJu0YywrytEiMrYv7JhX9fL1dO+B5KvTIOySV7VHeAKpqTUK2axoGTo
	JI4qi6bEsnT95Y5F4WAbTE2X0TO7UFY2Dk/phMUBbkAlmyAu+YmKiMC+bGY4GYVwEM84T0nl2f/
	sM3N3A/VNLc1WtB+BfhUfvXGZXQMbW0s=
X-Gm-Gg: ASbGncvNitmNPlCwsyjOR55DrzEFMrreQpeMHDHZBzs1fELFCFKLUsekVx4ozccEQr4
	BoI6MWqX8jIxEv8QZwFzWueRVPfrkiTxxALgkZUEnZ1NVG2A8dJSZfJEfs3EAqQhu/wt30g9CjX
	BNtjuD6xNQIZb8K+WJMB0+Y/KO1o3XU2NSDVCNDgBDr3xLA5RjB1rA1kHVpmI3g2yve1jeSg/TH
	skVTsw=
X-Google-Smtp-Source: AGHT+IG9arsIlOSJmPJBsbxOiZ5daR1wc4SOTaEO3oaz2q1ylRHbNBTz8gU659wji9v+agQNUymlwmxzdqWat4I7Imo=
X-Received: by 2002:a05:690c:6d0d:b0:70d:f47a:7e40 with SMTP id
 00721157ae682-717d790e42emr46748907b3.16.1752235282447; Fri, 11 Jul 2025
 05:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev> <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
 <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com> <aHD0IdJBqd3XNybw@krava>
In-Reply-To: <aHD0IdJBqd3XNybw@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Jul 2025 20:01:20 +0800
X-Gm-Features: Ac12FXyLwAXSMkcFgvutUNn1sEUE84fPcpCc2ae7ts4USMeD9mwj-LoiLtrO_CM
Message-ID: <CADxym3bC=qkRLEgQ=kNXb1JyOqj60d49DctKv662s5r3TFkLjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:23=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jul 11, 2025 at 01:51:31PM +0800, Menglong Dong wrote:
> > On Fri, Jul 11, 2025 at 11:46=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> > >
> > >
> > >
> > > On 7/10/25 8:10 PM, Yonghong Song wrote:
> > > >
> > > >
> > > > On 7/10/25 12:08 AM, Menglong Dong wrote:
> > > >> For now, we lookup the address of the attach target in
> > > >> bpf_check_attach_target() with find_kallsyms_symbol_value or
> > > >> kallsyms_lookup_name, which is not accurate in some cases.
> > > >>
> > > >> For example, we want to attach to the target "t_next", but there a=
re
> > > >> multiple symbols with the name "t_next" exist in the kallsyms, whi=
ch
> > > >> makes
> > > >> the attach target ambiguous, and the attach should fail.
> > > >>
> > > >> Introduce the function bpf_lookup_attach_addr() to do the address
> > > >> lookup,
> > > >> which will return -EADDRNOTAVAIL when the symbol is not unique.
> > > >>
> > > >> We can do the testing with following shell:
> > > >>
> > > >> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> > > >> do
> > > >>    if grep -q "^$s\$"
> > > >> /sys/kernel/debug/tracing/available_filter_functions
> > > >>    then
> > > >>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
> > > >>    fi
> > > >> done
> > > >>
> > > >> The script will find all the duplicated symbols in /proc/kallsyms,=
 which
> > > >> is also in /sys/kernel/debug/tracing/available_filter_functions, a=
nd
> > > >> attach them with bpftrace.
> > > >>
> > > >> After this patch, all the attaching fail with the error:
> > > >>
> > > >> The address of function xxx cannot be found
> > > >> or
> > > >> No BTF found for xxx
> > > >>
> > > >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > >
> > > > Maybe we should prevent vmlinux BTF generation for such symbols
> > > > which are static and have more than one instances? This can
> > > > be done in pahole and downstream libbpf/kernel do not
> > > > need to do anything. This can avoid libbpf/kernel runtime overhead
> > > > since bpf_lookup_attach_addr() could be expensive as it needs
> > > > to go through ALL symbols, even for unique symbols.
> >
> > Hi, yonghong. You are right, the best solution is to solve
> > this problem in the pahole, just like what Jiri said in the V2:
> >   https://lore.kernel.org/bpf/aG5hzvaqXi7uI4GL@krava/
> >
> > I wonder will we focus the users to use the latest pahole
> > that supports duplicate symbols filter after we fix this problem
> > in pahole? If so, this patch is useless, and just ignore it. If
> > not, the only usage of this patch is for the users that build
> > the kernel with an old pahole.
> >
> > >
> > > There is a multi-link effort:
> > >    https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@china=
telecom.cn/
> > > which tries to do similar thing for multi-kprobe. For example, for fe=
ntry,
> > > multi-link may pass an array of btf_id's to the kernel. For such case=
s,
> > > this patch may cause significant performance overhead.
> >
> > For the symbol in the vmlinux, there will be no additional overhead,
> > as the logic is the same as previous. If the symbol is in the
> > modules, it does have additional overhead. Following is the
> > testing that hooks all the symbols with fentry-multi.
> >
> > Without this patch, the time to attach all the symbols:
> > kernel: 0.372660s for 48857 symbols
> > modules: 0.135543s for 8631 symbols
> >
> > And with this patch, the time is:
> > kernel: 0.380087s for 48857 symbols
> > modules: 0.176904s for 8631 symbols
> >
> > One more thing, is there anyone to fix the problem in pahole?
> > I mean, I'm not good at pahole. But if there is nobody, I still can
> > do this job, but I need to learn it first :/
>
> I'm testing change below, I'll send the patch after some more testing

Awesome, thank you :/

>
> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 16739066caae..29ff86bac7de 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2143,6 +2143,31 @@ int btf_encoder__encode(struct btf_encoder *encode=
r, struct conf_load *conf)
>         return err;
>  }
>
> +static void remove_dups(struct elf_functions *functions)
> +{
> +       struct elf_function *n =3D &functions->entries[0];
> +       bool matched =3D false;
> +       int i, j;
> +
> +       for (i =3D 0, j =3D 1; i < functions->cnt && j < functions->cnt; =
i++, j++) {
> +               struct elf_function *a =3D &functions->entries[i];
> +               struct elf_function *b =3D &functions->entries[j];
> +
> +               if (!strcmp(a->name, b->name)) {
> +                       matched =3D true;
> +                       continue;
> +               }
> +
> +               if (!matched)
> +                       *n++ =3D *a;
> +               matched =3D false;
> +       }
> +
> +       if (!matched)
> +               *n++ =3D functions->entries[functions->cnt - 1];
> +       functions->cnt =3D n - &functions->entries[0];
> +}
> +
>  static int elf_functions__collect(struct elf_functions *functions)
>  {
>         uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab)=
;
> @@ -2168,6 +2193,7 @@ static int elf_functions__collect(struct elf_functi=
ons *functions)
>
>         if (functions->cnt) {
>                 qsort(functions->entries, functions->cnt, sizeof(*functio=
ns->entries), functions_cmp);
> +               remove_dups(functions);
>         } else {
>                 err =3D 0;
>                 goto out_free;

