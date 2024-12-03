Return-Path: <bpf+bounces-46037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4E9E2F89
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA3282E4F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7C20A5E3;
	Tue,  3 Dec 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b1ASdtAH"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458078460;
	Tue,  3 Dec 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267357; cv=none; b=Pwr9j/PbgaKTglohvRnS3Q/NkshYLBd280u1ruFcWoPaC4BSfM09QqIMFkNABx3WivkaYv/8bMoNdYliHhkOnQlJojAFLlLTXcn0S2ZZ0zlw+UGIOAQfvgmlwEYh22ggXbApuy7X7nVtCgfYnriqqTmUvpz4FimeVZUM/z2yB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267357; c=relaxed/simple;
	bh=3zN1x3N+s9QrJx4DCJMFRRP/JtlOXiWxV6oDmoR/K0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOKyQ/ivVknfuovA8kp62ZZgBn2FuchtCUS8ciTOKk0h0mvup7uFLwK6QBo5aAdOOfs5+S5USVG0RVKOyKtOg2nWL62sh6iGh2Qt7u0bXS5h1yulex6aIhwZuga1taLkGBfO7Ewen6fuK0b87blTmRG+/9qZIC94AtRyxxW+JBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b1ASdtAH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733267349;
	bh=3zN1x3N+s9QrJx4DCJMFRRP/JtlOXiWxV6oDmoR/K0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1ASdtAHY6b2cx0XrR2Y7/JBFvWsaNY22fJtiUq98k0Rkk9vF4BvVGNeGmqFWijz4
	 MNQY1TwPW7/kF2houjesmHMja7FUDIaWYCHxNP1v8GbxgvCLEo/AIHtmM+1KnfZ9Dy
	 NGnV5GWwWzh9YbSgHeG6l6Rfad+CuHi3mEKhlBPM=
Date: Wed, 4 Dec 2024 00:09:08 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/resolve_btfids: Add --fatal-warnings option
Message-ID: <9a11cf2f-ddca-4a50-817f-74183d31dcaf@t-8ch.de>
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
 <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
 <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com>

On 2024-12-03 14:31:01-0800, Andrii Nakryiko wrote:
> On Tue, Nov 26, 2024 at 1:17 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Currently warnings emitted by resolve_btfids are buried in the build log
> > and are slipping into mainline frequently.
> > Add an option to elevate warnings to hard errors so the CI bots can
> > catch any new warnings.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..571d29d2da97fea75e5f9c544a95b9ac65f9e579 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -141,6 +141,7 @@ struct object {
> >  };
> >
> >  static int verbose;
> > +static int warnings;
> >
> >  static int eprintf(int level, int var, const char *fmt, ...)
> >  {
> > @@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj)
> >                         if (id->id) {
> >                                 pr_info("WARN: multiple IDs found for '%s': %d, %d - using %d\n",
> >                                         str, id->id, type_id, id->id);
> > +                               warnings++;
> >                         } else {
> >                                 id->id = type_id;
> >                                 (*nr)--;
> > @@ -625,8 +627,10 @@ static int id_patch(struct object *obj, struct btf_id *id)
> >         int i;
> >
> >         /* For set, set8, id->id may be 0 */
> > -       if (!id->id && !id->is_set && !id->is_set8)
> > +       if (!id->id && !id->is_set && !id->is_set8) {
> >                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > +               warnings++;
> > +       }
> >
> >         for (i = 0; i < id->addr_cnt; i++) {
> >                 unsigned long addr = id->addr[i];
> > @@ -782,6 +786,7 @@ int main(int argc, const char **argv)
> >                 .funcs    = RB_ROOT,
> >                 .sets     = RB_ROOT,
> >         };
> > +       bool fatal_warnings = false;
> >         struct option btfid_options[] = {
> >                 OPT_INCR('v', "verbose", &verbose,
> >                          "be more verbose (show errors, etc)"),
> > @@ -789,6 +794,8 @@ int main(int argc, const char **argv)
> >                            "BTF data"),
> >                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
> >                            "path of file providing base BTF"),
> > +               OPT_BOOLEAN(0, "fatal-warnings", &fatal_warnings,
> > +                           "turn warnings into errors"),
> 
> We are mixing naming styles here: we have "btf_base" with underscore
> separator, and you are adding "fatal-warnings" with dash separator. I
> personally like dashes, but whichever way we should stay consistent.
> So let's fix it, otherwise it looks a bit sloppy.

Ack.

> 
> Please also use [PATCH bpf-next v3] subject prefix to make it explicit
> that this should go through bpf-next tree.

Ack.

> 
> pw-bot: cr
> 
> >                 OPT_END()
> >         };
> >         int err = -1;
> > @@ -823,7 +830,8 @@ int main(int argc, const char **argv)
> >         if (symbols_patch(&obj))
> >                 goto out;
> >
> > -       err = 0;
> > +       if (!(fatal_warnings && warnings))
> > +               err = 0;
> 
> nit: just
> 
> if (!fatal_warnings)
>     err = 0;
> 
> ?

This seems wrong. Now the actual warning counter is never evaluated.
And --fatal_warnings will always lead to an error exit code.

> >  out:
> >         if (obj.efile.elf) {
> >                 elf_end(obj.efile.elf);
> >
> > --
> > 2.47.1
> >

