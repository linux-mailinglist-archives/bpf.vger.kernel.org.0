Return-Path: <bpf+bounces-46061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2619E3381
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 07:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F3E163370
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 06:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A5187858;
	Wed,  4 Dec 2024 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aXKVKy+C"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3CF136E;
	Wed,  4 Dec 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733293191; cv=none; b=NWnpyKDJfJLT2UMgrLyqEsq9mKzC9Ew7eHS3akMeUoGGPlog6TyZgqZ3fdS3VfiPKmjpzllvHBY+eAvEOP0NVQ3z4oLHrzrpS3BTg6as7q9f+H5t5o4laJmbJZAYtNOzoZumrH8HmHQKZTAv/wdPMXWwN+pzPQ/e5Prlf5byYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733293191; c=relaxed/simple;
	bh=Mer2Y3HAwbgB+Wip6EA8m2Q8D5ezjCsqGvB8X+pAV6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzjtdg73OTcCg86vdUqKp705tanHWdiTARO1/kjAmo3k6oRUBxAlNLaVGEKOeCP5vbmBQr8oOYgadrv1DnXHUlRKv572c3y0B1EjBAgZcqIA8isJTHg4furZIj1QyfZ3reGKJxqYWe/oihtoBZUGdCB49oc2qnKHZ0pAx1BjcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aXKVKy+C; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733293185;
	bh=Mer2Y3HAwbgB+Wip6EA8m2Q8D5ezjCsqGvB8X+pAV6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXKVKy+CKndFeqCAjOCJSeSBlZug0uEzXbXqVGrdapY1ddKFdAaRXRhxzl61q+wLZ
	 hSwSLMpjPqONjOUVrpDWxrJr9mW46k4nxrcpDw+71ssbySnhdDuBLLLeG6Trl0ZrVS
	 BjNrikEUkXXxapFC46vZpLIXHSfmbmkCtsCEXfFQ=
Date: Wed, 4 Dec 2024 07:19:43 +0100
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
Message-ID: <d556fc2a-c4be-4f9e-bf13-bdf418265eb3@t-8ch.de>
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
 <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
 <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com>
 <9a11cf2f-ddca-4a50-817f-74183d31dcaf@t-8ch.de>
 <CAEf4BzZqeo00C5a9QO6Ah3i-doWRbg7v_2y=y9Kfg3=JyrA=zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZqeo00C5a9QO6Ah3i-doWRbg7v_2y=y9Kfg3=JyrA=zQ@mail.gmail.com>

On 2024-12-03 18:06:26-0800, Andrii Nakryiko wrote:
> On Tue, Dec 3, 2024 at 3:09 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > On 2024-12-03 14:31:01-0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 26, 2024 at 1:17 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > Currently warnings emitted by resolve_btfids are buried in the build log
> > > > and are slipping into mainline frequently.
> > > > Add an option to elevate warnings to hard errors so the CI bots can
> > > > catch any new warnings.
> > > >
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > > > index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..571d29d2da97fea75e5f9c544a95b9ac65f9e579 100644
> > > > --- a/tools/bpf/resolve_btfids/main.c
> > > > +++ b/tools/bpf/resolve_btfids/main.c
> > > > @@ -141,6 +141,7 @@ struct object {
> > > >  };
> > > >
> > > >  static int verbose;
> > > > +static int warnings;
> > > >
> > > >  static int eprintf(int level, int var, const char *fmt, ...)
> > > >  {
> > > > @@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj)
> > > >                         if (id->id) {
> > > >                                 pr_info("WARN: multiple IDs found for '%s': %d, %d - using %d\n",
> > > >                                         str, id->id, type_id, id->id);
> > > > +                               warnings++;
> > > >                         } else {
> > > >                                 id->id = type_id;
> > > >                                 (*nr)--;
> > > > @@ -625,8 +627,10 @@ static int id_patch(struct object *obj, struct btf_id *id)
> > > >         int i;
> > > >
> > > >         /* For set, set8, id->id may be 0 */
> > > > -       if (!id->id && !id->is_set && !id->is_set8)
> > > > +       if (!id->id && !id->is_set && !id->is_set8) {
> > > >                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > > > +               warnings++;
> > > > +       }
> > > >
> > > >         for (i = 0; i < id->addr_cnt; i++) {
> > > >                 unsigned long addr = id->addr[i];
> > > > @@ -782,6 +786,7 @@ int main(int argc, const char **argv)
> > > >                 .funcs    = RB_ROOT,
> > > >                 .sets     = RB_ROOT,
> > > >         };
> > > > +       bool fatal_warnings = false;
> > > >         struct option btfid_options[] = {
> > > >                 OPT_INCR('v', "verbose", &verbose,
> > > >                          "be more verbose (show errors, etc)"),
> > > > @@ -789,6 +794,8 @@ int main(int argc, const char **argv)
> > > >                            "BTF data"),
> > > >                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
> > > >                            "path of file providing base BTF"),
> > > > +               OPT_BOOLEAN(0, "fatal-warnings", &fatal_warnings,
> > > > +                           "turn warnings into errors"),
> > >
> > > We are mixing naming styles here: we have "btf_base" with underscore
> > > separator, and you are adding "fatal-warnings" with dash separator. I
> > > personally like dashes, but whichever way we should stay consistent.
> > > So let's fix it, otherwise it looks a bit sloppy.
> >
> > Ack.
> >
> > >
> > > Please also use [PATCH bpf-next v3] subject prefix to make it explicit
> > > that this should go through bpf-next tree.
> >
> > Ack.
> >
> > >
> > > pw-bot: cr
> > >
> > > >                 OPT_END()
> > > >         };
> > > >         int err = -1;
> > > > @@ -823,7 +830,8 @@ int main(int argc, const char **argv)
> > > >         if (symbols_patch(&obj))
> > > >                 goto out;
> > > >
> > > > -       err = 0;
> > > > +       if (!(fatal_warnings && warnings))
> > > > +               err = 0;
> > >
> > > nit: just
> > >
> > > if (!fatal_warnings)
> > >     err = 0;
> > >
> > > ?
> >
> > This seems wrong. Now the actual warning counter is never evaluated.
> > And --fatal_warnings will always lead to an error exit code.
> 
> Ah, I missed that you are using default -1 value here. I wonder if we
> should make it a bit more explicit?
> 
> if (fatal_warnings)
>     err = warnings ? -1 : 0;
> else
>     err = 0;
> 
> Something like that?

The existing code was the same. Also the rest of the function
relies on this. IMO the pattern is clear when looking at the resulting
code and not the diff.
But if you prefer I can change it of course.

> > > >  out:
> > > >         if (obj.efile.elf) {
> > > >                 elf_end(obj.efile.elf);
> > > >
> > > > --
> > > > 2.47.1
> > > >

