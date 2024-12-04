Return-Path: <bpf+bounces-46097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F09E42E4
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BA9169E0B
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B120E6E5;
	Wed,  4 Dec 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8T5nPtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356B205AB3;
	Wed,  4 Dec 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335071; cv=none; b=ZYOFbgU/mVHw8PXHVv0VfOFdmWxxRhKtWlEKWEwVDLTSeM9/KlaaCHdwCKRjhXRcp8b8uxtA16pgylRBbfIVeH2kGorjeH9pa0gVCzYmuOg/vZEhqH8yZhwMBKd7Z1J0ETy+Uhpoptn8yyhfCQtVaEhpd/EUgR3HbUBpNMTz4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335071; c=relaxed/simple;
	bh=X1InaroIQM2uf/1jpiGdU6NNyYPfyZraxWsbFwr+Bcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLMqN8t+Y1bFwtvxSqw3wjUKp9KdQQ3NHGSqGeexAJN3Jrcr+rgnIHmBQOgHUeDwL+bDAfLrkcRnkiyxcs8jnISHNXCY8mTPsfBKS+I3+vjhnfLYWkLMcvlldeCkqjtSadGzOJKqZlFbCiJopznw4HYRn/n6GQoFeHha6+helZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8T5nPtm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so562043566b.3;
        Wed, 04 Dec 2024 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335067; x=1733939867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwvLjmbQdkYwGPG8ZtaFfGORqko28S8AxolG82mkgsk=;
        b=U8T5nPtmsj2P0pHhazwnxmHErRH3QabF4jxjLhh8MbF4Uve9duoaxyUIQkWOVTSAnr
         8Q78Hrz746rOMB73QdBcg/6tE2or2yyvKrLGkWd3ZEWJnnSdoc8W2LnPV6fnniEP03+V
         QIYV/c3NTshoipMonlLbVu2O963GzfQG2RiP15Fb8KOd5BEy9TC5tFmrRjpwJEzNKC/t
         WxCvuffuHNEXCesMMFDqU+VL+kc1rIUTDGEdthDDHG6xPGEbV+j63oDekm7qBjpXISwc
         kQggRhBq6sj8u4CpQGkzREja/3JU2Mfl2pWvRuHSO+h9uvX7ON+f5C5YEaXCrkLaouQ+
         LyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335067; x=1733939867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwvLjmbQdkYwGPG8ZtaFfGORqko28S8AxolG82mkgsk=;
        b=eNmM8y2rqPo7kRBI0gLAhWZ1rzveHdP6x8+GL19I06Do1Alb1RLzzCzmf0nvn8Dm2c
         Hy4qv7RfM8ucGriwkcocfjgCwQbYAnGRwBw+49VRUySEyOHZ8TIqXIbiJzFCy9Y8mIOn
         ILVSHnjCmj6/9IIk9ngO90E6NESs015eE6sWcLI2sl6MPbl32TATXwH66v3Ew2EylGU9
         iSggzLXd6sAlxHIPdO+3mSBfktP/s9Z0cI2IzRrdQOF/vyLXW1g3G3Z90TlcxIWYNjO+
         5spnUBpqUu02GLBFszIXjxMM678oy00JJqI3XNvlLcuPi8+UuVYJt+wAnEpItIiTg4gk
         lZvg==
X-Forwarded-Encrypted: i=1; AJvYcCVF8TrJhU8nvDYNzYcjDUc0Yz+UZm7RFr35AADNFtI/lt5lEEeDmef3nqiZOMkUf1cHmF699xCiU30sQWFI@vger.kernel.org, AJvYcCX83gXjQMXtwWyAm7spKBa3ax8PfvBKrT7/1eoSXQ9mIShVFCRaKDpvNW5KJ/clqMp/R8gyTqw6p4FLfIei@vger.kernel.org, AJvYcCXjLYBtX1zsQklYEmL6nFewqAJDWWcQTzPIy5DlR6GhOGEwHRpgB2lXK3o8IABFSHgfCA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszcY7MNxqQYkwWFs43KJSnQQoRgWeC5p6kOClc/RPW2j7htQl
	PXz2obFn67KF0x4jz/fIdppAdI53NUki67YXFAhj1OVHEhs2MPnyds2dBU3yzU/ufk2yE+wjk4L
	ia2PvYBT7N2eccr2VpALeMym2PhQ=
X-Gm-Gg: ASbGncun7O/+Cz33Zo9CxDqr6LZhvJmrwS7EVmeVKqAO+T8gzjfIHJ9H9PlLdVnTmPv
	Kxak1ReEGwXjGaov+lDnVtlWbiuTAEvL0K3f/F7Zi4XWYZeQ=
X-Google-Smtp-Source: AGHT+IHtLhnUeXu2EkaEBs8dhojWXWD57YcrckBE5FnscUms54qFw7VbLXuxb1jFZe0p1Q1AVyR9dHToGmSCml8uohA=
X-Received: by 2002:a17:907:aa2:b0:aa5:4ea6:fcae with SMTP id
 a640c23a62f3a-aa60181a7c3mr581948566b.28.1733335066688; Wed, 04 Dec 2024
 09:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
 <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
 <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com>
 <9a11cf2f-ddca-4a50-817f-74183d31dcaf@t-8ch.de> <CAEf4BzZqeo00C5a9QO6Ah3i-doWRbg7v_2y=y9Kfg3=JyrA=zQ@mail.gmail.com>
 <d556fc2a-c4be-4f9e-bf13-bdf418265eb3@t-8ch.de>
In-Reply-To: <d556fc2a-c4be-4f9e-bf13-bdf418265eb3@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Dec 2024 09:57:31 -0800
Message-ID: <CAEf4Bzbxz2Bh2OkoTFA-bV5gejHD5msww9JaNt885GJMTqdwAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/resolve_btfids: Add --fatal-warnings option
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:19=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-12-03 18:06:26-0800, Andrii Nakryiko wrote:
> > On Tue, Dec 3, 2024 at 3:09=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@wei=
ssschuh.net> wrote:
> > >
> > > On 2024-12-03 14:31:01-0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 26, 2024 at 1:17=E2=80=AFPM Thomas Wei=C3=9Fschuh <linu=
x@weissschuh.net> wrote:
> > > > >
> > > > > Currently warnings emitted by resolve_btfids are buried in the bu=
ild log
> > > > > and are slipping into mainline frequently.
> > > > > Add an option to elevate warnings to hard errors so the CI bots c=
an
> > > > > catch any new warnings.
> > > > >
> > > > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_=
btfids/main.c
> > > > > index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..571d29d2da97fea75=
e5f9c544a95b9ac65f9e579 100644
> > > > > --- a/tools/bpf/resolve_btfids/main.c
> > > > > +++ b/tools/bpf/resolve_btfids/main.c
> > > > > @@ -141,6 +141,7 @@ struct object {
> > > > >  };
> > > > >
> > > > >  static int verbose;
> > > > > +static int warnings;
> > > > >
> > > > >  static int eprintf(int level, int var, const char *fmt, ...)
> > > > >  {
> > > > > @@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj=
)
> > > > >                         if (id->id) {
> > > > >                                 pr_info("WARN: multiple IDs found=
 for '%s': %d, %d - using %d\n",
> > > > >                                         str, id->id, type_id, id-=
>id);
> > > > > +                               warnings++;
> > > > >                         } else {
> > > > >                                 id->id =3D type_id;
> > > > >                                 (*nr)--;
> > > > > @@ -625,8 +627,10 @@ static int id_patch(struct object *obj, stru=
ct btf_id *id)
> > > > >         int i;
> > > > >
> > > > >         /* For set, set8, id->id may be 0 */
> > > > > -       if (!id->id && !id->is_set && !id->is_set8)
> > > > > +       if (!id->id && !id->is_set && !id->is_set8) {
> > > > >                 pr_err("WARN: resolve_btfids: unresolved symbol %=
s\n", id->name);
> > > > > +               warnings++;
> > > > > +       }
> > > > >
> > > > >         for (i =3D 0; i < id->addr_cnt; i++) {
> > > > >                 unsigned long addr =3D id->addr[i];
> > > > > @@ -782,6 +786,7 @@ int main(int argc, const char **argv)
> > > > >                 .funcs    =3D RB_ROOT,
> > > > >                 .sets     =3D RB_ROOT,
> > > > >         };
> > > > > +       bool fatal_warnings =3D false;
> > > > >         struct option btfid_options[] =3D {
> > > > >                 OPT_INCR('v', "verbose", &verbose,
> > > > >                          "be more verbose (show errors, etc)"),
> > > > > @@ -789,6 +794,8 @@ int main(int argc, const char **argv)
> > > > >                            "BTF data"),
> > > > >                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "=
file",
> > > > >                            "path of file providing base BTF"),
> > > > > +               OPT_BOOLEAN(0, "fatal-warnings", &fatal_warnings,
> > > > > +                           "turn warnings into errors"),
> > > >
> > > > We are mixing naming styles here: we have "btf_base" with underscor=
e
> > > > separator, and you are adding "fatal-warnings" with dash separator.=
 I
> > > > personally like dashes, but whichever way we should stay consistent=
.
> > > > So let's fix it, otherwise it looks a bit sloppy.
> > >
> > > Ack.
> > >
> > > >
> > > > Please also use [PATCH bpf-next v3] subject prefix to make it expli=
cit
> > > > that this should go through bpf-next tree.
> > >
> > > Ack.
> > >
> > > >
> > > > pw-bot: cr
> > > >
> > > > >                 OPT_END()
> > > > >         };
> > > > >         int err =3D -1;
> > > > > @@ -823,7 +830,8 @@ int main(int argc, const char **argv)
> > > > >         if (symbols_patch(&obj))
> > > > >                 goto out;
> > > > >
> > > > > -       err =3D 0;
> > > > > +       if (!(fatal_warnings && warnings))
> > > > > +               err =3D 0;
> > > >
> > > > nit: just
> > > >
> > > > if (!fatal_warnings)
> > > >     err =3D 0;
> > > >
> > > > ?
> > >
> > > This seems wrong. Now the actual warning counter is never evaluated.
> > > And --fatal_warnings will always lead to an error exit code.
> >
> > Ah, I missed that you are using default -1 value here. I wonder if we
> > should make it a bit more explicit?
> >
> > if (fatal_warnings)
> >     err =3D warnings ? -1 : 0;
> > else
> >     err =3D 0;
> >
> > Something like that?
>
> The existing code was the same. Also the rest of the function
> relies on this. IMO the pattern is clear when looking at the resulting
> code and not the diff.
> But if you prefer I can change it of course.

That new condition breaks my brain, but luckily I don't have to look
at it often, so I don't care all that much. Feel free to leave it as
is.

>
> > > > >  out:
> > > > >         if (obj.efile.elf) {
> > > > >                 elf_end(obj.efile.elf);
> > > > >
> > > > > --
> > > > > 2.47.1
> > > > >

