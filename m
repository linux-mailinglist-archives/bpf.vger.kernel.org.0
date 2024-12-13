Return-Path: <bpf+bounces-46769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C579F00AB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B67716A6C9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F77F9;
	Fri, 13 Dec 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3y/qs6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED914184;
	Fri, 13 Dec 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048734; cv=none; b=jKMGLDQJBfYisiY3hrxtajV6lixVdzakrU6QVADHnCc3Y1zzuWw/6eCSfoubpercwhYMMkCDW4cyjtvRsrcuTNarLJ1kjHEe2Tcfl2M05032YsLij8cF16no3tV7MtSDtbknLI5M7wgEU3rmzT1WVu3kr89oMsHs08qXlBJ/AMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048734; c=relaxed/simple;
	bh=207+odalPbxbEAPrHgzkwQzzkDVnOq57XEBAxHtieag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D41LjtShrKhjpQO+Atn1831+fM3FRh6BJIdhFMI0c4heJEmWMzIy3QerKOgYP4oXCd+cTM41tj/JgApWMYGIMrpbY01KRFUljfS7yZsE51GWE+i1IY4d3hJTHtWfHBuWv2Vj5FqjfXzIqTBRuvLP4iYLDjubKepTmra51bqanxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3y/qs6x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so878017a12.0;
        Thu, 12 Dec 2024 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734048732; x=1734653532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUcugkcBtA5iURiirDxOvWyTcW9Mof08SQApkdgzTEU=;
        b=L3y/qs6xCxWb4eMkxO1B3Vwycc3xxOJq0LUQBArlHGjyGG2ZL4Z8k9i+STINfBznR4
         d/UQuMD+wAd6N7LFr18ntOa490zn18QQHSZu3DfX/i+FLp2OuvCDrPW5RDVmPoSBI8U5
         qORlNgwCg4fTaEefJ+GCkO16GTJg/ru5UqrTv2XVt6wYqbDD/YWAmVgsj9CtnxrEQ784
         OKF8cE+x7Qc0EEKDXLQRXu4OXlUPT1kjrU4EHlt6WUIMLwoyfkdmz6B9ZRsgA0CzLUOG
         h1nZSVyXPpqB61trq1e/MRQm4O7VxeLU24olIQeZfNg/Aze8eYDKfBD63xY+iGCSTPhG
         +9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048732; x=1734653532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUcugkcBtA5iURiirDxOvWyTcW9Mof08SQApkdgzTEU=;
        b=qa+51I4f/l9NN6DC9RMO1hI83VPFbkg0Bm/p0/9vd7D232S6FkrcBkvafE8/PeTvXJ
         rQwRXN5eFXJp3th2SwJy4XisXouf4mobB3W1BXQDr4wwVi4iKF5K3wP1krb8a7Ujey44
         ZP3pYlNGuyoL6SXkMkLg7Twvb1bFe3cAViq16TlLqxVg5dwufdm6wI08bTAJs2p0C+JV
         NYNPoQrfVYbWjOrczMMvns9qa9WdFtsbBrZqG9pqzzfcqrDuSpW90ZZt3XUCbonl4LxW
         ot7ghe7Or81P2ZjDjQQ3vIR8DnEgUfo0ZkZsu11nt3OqG+UB3PhRmGHKAa3ezdlWL8Dr
         zLiw==
X-Forwarded-Encrypted: i=1; AJvYcCWLEE+RXehJkgtBnWi23A4WxeNoyZIRRQxCM0AgwTeUe6EqQvBcvxSLvJfp05bp05x6zbAi9Ig9Jy9ASoRo@vger.kernel.org, AJvYcCWYS6cb2V5zHlVYvvcW/+8EsGr9qgJo3Xc9UF9L8kdUey/6A1B12Zlnj68x2jTCjwrgBf0=@vger.kernel.org, AJvYcCXuP4HN2vk3+MEJm8YAMbOYAe3wXceZQpeE4AFVZZLNWCBzHGQ6DLfxCqS8euzVa/3Q3OpGZSpm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxns+bg8E0+HL6RCujeBaqtWpuMUXNhiLAbwI/Ja2acQuFxZBk3
	6accJli+gUAQSv+GkyMhTYTG9D0WJsPT5taOT7h/5Bqo7JunW2hOV+f6HkvZiA6jE79DxM02gED
	LS1juTl7U0jyxr+Kf9UYHmsxXZvU=
X-Gm-Gg: ASbGncuNOa+pNn+pAWRFaXudePCLrD6+yo6+seK07mWDGxCKOeMr7T22LrhfSMcczTg
	EH6Fgxnv15iC7QqwBC+TAbDbtCLpCecYIgEm4980fppFv4eR2bVRNQw==
X-Google-Smtp-Source: AGHT+IHb/7T6462Jz4uTyGtsoFbmgsDh8W3Ij/SzirHwHST2bRyANuhqvYXmv6MpOPpeEuq9XSP4dr5i+g8vjot6SdA=
X-Received: by 2002:a17:90b:2e4e:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2f290dbcdd7mr980448a91.35.1734048732206; Thu, 12 Dec 2024
 16:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733787798.git.dxu@dxuuu.xyz> <3bc17d33161961409dc77a5de29761bf2bed4980.1733787798.git.dxu@dxuuu.xyz>
 <CAEf4BzaA9_up=3npADgJv8pCVg4eVzsWevef69c3PkdyuWNXDQ@mail.gmail.com> <zf62rqtgvl63sawxltmpgcnpek5bt3w5pleznby3zqb7ezhvdz@wqlwxy2f43wt>
In-Reply-To: <zf62rqtgvl63sawxltmpgcnpek5bt3w5pleznby3zqb7ezhvdz@wqlwxy2f43wt>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:12:00 -0800
Message-ID: <CAEf4BzZOL5f4m=y6P0RF5=QtcegEDNXKXPav4uqVy97VN0kLOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpftool: btf: Support dumping a single
 type from file
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, qmo@kernel.org, 
	davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org, kuba@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, antony@phenome.org, 
	toke@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:41=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Thu, Dec 12, 2024 at 11:09:34AM GMT, Andrii Nakryiko wrote:
> > On Mon, Dec 9, 2024 at 3:45=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > Some projects, for example xdp-tools [0], prefer to check in a minimi=
zed
> > > vmlinux.h rather than the complete file which can get rather large.
> > >
> > > However, when you try to add a minimized version of a complex struct =
(eg
> > > struct xfrm_state), things can get quite complex if you're trying to
> > > manually untangle and deduplicate the dependencies.
> > >
> > > This commit teaches bpftool to do a minimized dump of a single type b=
y
> > > providing an optional root_id argument.
> > >
> > > Example usage:
> > >
> > >     $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_=
state'"
> > >     [12643] STRUCT 'xfrm_state' size=3D912 vlen=3D58
> > >
> > >     $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 forma=
t c
> > >     #ifndef __VMLINUX_H__
> > >     #define __VMLINUX_H__
> > >
> > >     [..]
> > >
> > >     struct xfrm_type_offload;
> > >
> > >     struct xfrm_sec_ctx;
> > >
> > >     struct xfrm_state {
> > >             possible_net_t xs_net;
> > >             union {
> > >                     struct hlist_node gclist;
> > >                     struct hlist_node bydst;
> > >             };
> > >             union {
> > >                     struct hlist_node dev_gclist;
> > >                     struct hlist_node bysrc;
> > >             };
> > >             struct hlist_node byspi;
> > >     [..]
> > >
> > > [0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf=
/vmlinux.h
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 +++++--
> > >  tools/bpf/bpftool/btf.c                       | 21 +++++++++++++++++=
+-
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/=
bpf/bpftool/Documentation/bpftool-btf.rst
> > > index 245569f43035..4899b2c10777 100644
> > > --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > > +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > > @@ -24,7 +24,7 @@ BTF COMMANDS
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >  | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
> > > -| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> > > +| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_i=
d** *ROOT_ID*]
> > >  | **bpftool** **btf help**
> > >  |
> > >  | *BTF_SRC* :=3D { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP*=
 [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> > > @@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
> > >      that hold open file descriptors (FDs) against BTF objects. On su=
ch kernels
> > >      bpftool will automatically emit this information as well.
> > >
> > > -bpftool btf dump *BTF_SRC* [format *FORMAT*]
> > > +bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
> > >      Dump BTF entries from a given *BTF_SRC*.
> > >
> > >      When **id** is specified, BTF object with that ID will be loaded=
 and all
> > > @@ -67,6 +67,9 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
> > >      formatting, the output is sorted by default. Use the **unsorted*=
* option
> > >      to avoid sorting the output.
> > >
> > > +    **root_id** option can be used to filter a dump to a single type=
 and all
> > > +    its dependent types. It cannot be used with any other types of f=
iltering.
> > > +
> > >  bpftool btf help
> > >      Print short help message.
> > >
> > > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > > index 3e995faf9efa..18b037a1414b 100644
> > > --- a/tools/bpf/bpftool/btf.c
> > > +++ b/tools/bpf/bpftool/btf.c
> > > @@ -993,6 +993,25 @@ static int do_dump(int argc, char **argv)
> > >                                 goto done;
> > >                         }
> > >                         NEXT_ARG();
> > > +               } else if (is_prefix(*argv, "root_id")) {
> > > +                       __u32 root_id;
> > > +                       char *end;
> > > +
> > > +                       if (root_type_cnt) {
> > > +                               p_err("cannot use root_id with other =
type filtering");
> >
> > this is a confusing error if the user just wanted to provide two
> > root_id arguments... Also, why don't we allow multiple root_ids?
> >
> > I'd bump root_type_ids[] to have something like 16 elements or
> > something (though we can always do dynamic realloc as well, probably),
> > and allow multiple types to be specified.
> >
> > Thoughts?
>
> That's a good point. I added this check b/c I didn't think it would
> make sense to allow `root_id` filtering in combination with map dump
> filtering (which uses same root_type_ids param):
>
>         map MAP [{key | value | kv | all}]
>
> But code can easily be tweaked to still block combination but allow
> multiple `root_id`s when used alone. 16 seems sufficient to me.
>
> Do you think it'd be more bpftool-y to require "root_id" each time or to
> just take a comma separated value?

root_id 123 root_id 345 root_id 789

definitely more bpftool-y

