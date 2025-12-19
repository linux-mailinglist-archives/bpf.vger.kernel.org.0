Return-Path: <bpf+bounces-77091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F3CCE222
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BBF3019B4E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A6221542;
	Fri, 19 Dec 2025 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dHZ/RBfE"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0135959
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107458; cv=none; b=NguzQ9BJKQoUezBY4AxTpTacE/D13RTDkBGey2mAF/9laV/UayVs62dl8U/EQoU0Vf67l5XUBnmeDX4qxtwxnKNSsmvLYyQ0NLpsFiyM3DNPN9EYcVhHG/x7/lmTDtt0O+hHpS6lmULuQn8ofHa+CwiEBCqTobV17wtkGU6hTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107458; c=relaxed/simple;
	bh=TcH9g79e0BODN8ZbYs0LkHQhL6TJuBZpzuzR0tflQUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9XtTGbJAkO3Y2dHkMx0iG4CTTX4Pnk49uPoUqvAvVQFgAxS/8YLEjoZzmKyqP1ANlBPD2sYgcscgl6AWBb0fXgEWuVdsThNyWrx3d/09Tzalomjbiaa1DMfLD/O6dZlTn4Oo790PyAys5Wbh4Bz0As8YwBtO5f0vDW9vKjItm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dHZ/RBfE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766107453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpTz0fnzo/dfwwwMtL0BQt88rbW9FSu9Iipd7LaDBwA=;
	b=dHZ/RBfEv46LChMhBVy+G8ZLDzARhbWRB/LG3UWlDsZjsR0tXhBlDTjMslXsyxvmk/oFdi
	JBn4fq0a6RmzR9Eb7Mb1y8C2vOWsMomXArgUKa1M9r9qJx36+PVyolRYUmAul/b8jr5eVJ
	2b2rahG/U+f5m+rodW5v+xIi4CDtHoQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/9] bpf: add tracing session support
Date: Fri, 19 Dec 2025 09:24:00 +0800
Message-ID: <3387829.aeNJFYEL58@7940hx>
In-Reply-To:
 <CAEf4BzY3=qjfX385teDBs7G4Ae8LqFKwX0qMmDnSkkLi5qiWBg@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <20251217095445.218428-2-dongml2@chinatelecom.cn>
 <CAEf4BzY3=qjfX385teDBs7G4Ae8LqFKwX0qMmDnSkkLi5qiWBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The tracing session is something that similar to kprobe session. It all=
ow
> > to attach a single BPF program to both the entry and the exit of the
> > target functions.
> >
> > Introduce the struct bpf_fsession_link, which allows to add the link to
> > both the fentry and fexit progs_hlist of the trampoline.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v4:
> > - instead of adding a new hlist to progs_hlist in trampoline, add the b=
pf
> >   program to both the fentry hlist and the fexit hlist.
> > ---
> >  include/linux/bpf.h                           | 20 +++++++++++
> >  include/uapi/linux/bpf.h                      |  1 +
> >  kernel/bpf/btf.c                              |  2 ++
> >  kernel/bpf/syscall.c                          | 18 +++++++++-
> >  kernel/bpf/trampoline.c                       | 36 +++++++++++++++----
> >  kernel/bpf/verifier.c                         | 12 +++++--
> >  net/bpf/test_run.c                            |  1 +
> >  net/core/bpf_sk_storage.c                     |  1 +
> >  tools/include/uapi/linux/bpf.h                |  1 +
> >  .../bpf/prog_tests/tracing_failure.c          |  2 +-
> >  10 files changed, 83 insertions(+), 11 deletions(-)
> >
>=20
> [...]
>=20
> >  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> >                                const struct bpf_ctx_arg_aux *info, u32 =
cnt);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 84ced3ed2d21..696a7d37db0e 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1145,6 +1145,7 @@ enum bpf_attach_type {
> >         BPF_NETKIT_PEER,
> >         BPF_TRACE_KPROBE_SESSION,
> >         BPF_TRACE_UPROBE_SESSION,
> > +       BPF_TRACE_SESSION,
>=20
> FSESSION for consistency with FENTRY and FEXIT

OK

>=20
> >         __MAX_BPF_ATTACH_TYPE
> >  };
> >
>=20
> [...]
>=20
> >  {
> > -       enum bpf_tramp_prog_type kind;
> > -       struct bpf_tramp_link *link_exiting;
> > +       enum bpf_tramp_prog_type kind, okind;
> > +       struct bpf_tramp_link *link_existing;
> > +       struct bpf_fsession_link *fslink;
> >         int err =3D 0;
> >         int cnt =3D 0, i;
> >
> > -       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > +       okind =3D kind =3D bpf_attach_type_to_tramp(link->link.prog);
> >         if (tr->extension_prog)
> >                 /* cannot attach fentry/fexit if extension prog is atta=
ched.
> >                  * cannot overwrite extension prog either.
> > @@ -621,13 +624,18 @@ static int __bpf_trampoline_link_prog(struct bpf_=
tramp_link *link,
> >                                           BPF_MOD_JUMP, NULL,
> >                                           link->link.prog->bpf_func);
> >         }
> > +       if (kind =3D=3D BPF_TRAMP_SESSION) {
> > +               /* deal with fsession as fentry by default */
> > +               kind =3D BPF_TRAMP_FENTRY;
> > +               cnt++;
> > +       }
>=20
> this "pretend we are BPF_TRAMP_FENTRY" looks a bit hacky and is very
> hard to follow. I think it would be cleaner to have explicit small
> special cases for BPF_TRAMP_SESSION, and then generalize
> hlist_for_each_entry case by using a local variable for storing
> &tr->progs_hlist[kind] (which for TRAMP_SESSION you'll set to
> &tr->progs_hlist[BPF_TRAMP_FENTRY]). You'll then just do extra
> hlist_add_head/hlist_del_init and count manipulation. IMO, it's better
> than keeping in head what kind and okind is...

Ah, the way now does seem a little hacky. I tried to make this series
looks less complex by modifying the code as less as possible.

I'll use a explicit way here as you advised.

>=20
>=20
> >         if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >                 return -E2BIG;
> >         if (!hlist_unhashed(&link->tramp_hlist))
> >                 /* prog already linked */
> >                 return -EBUSY;
> > -       hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tram=
p_hlist) {
> > -               if (link_exiting->link.prog !=3D link->link.prog)
> > +       hlist_for_each_entry(link_existing, &tr->progs_hlist[kind], tra=
mp_hlist) {
> > +               if (link_existing->link.prog !=3D link->link.prog)
> >                         continue;
> >                 /* prog already linked */
> >                 return -EBUSY;
>=20
> [...]
>=20
> > @@ -23298,6 +23299,7 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     insn->imm =3D=3D BPF_FUNC_get_func_ret) {
> >                         if (eatype =3D=3D BPF_TRACE_FEXIT ||
> > +                           eatype =3D=3D BPF_TRACE_SESSION ||
> >                             eatype =3D=3D BPF_MODIFY_RETURN) {
> >                                 /* Load nr_args from ctx - 8 */
> >                                 insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > @@ -24242,7 +24244,8 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >                 if (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     prog_extension &&
> >                     (tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FE=
NTRY ||
> > -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FE=
XIT)) {
> > +                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FE=
XIT ||
> > +                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_SE=
SSION)) {
> >                         /* Program extensions can extend all program ty=
pes
> >                          * except fentry/fexit. The reason is the follo=
wing.
> >                          * The fentry/fexit programs are used for perfo=
rmance
> > @@ -24257,7 +24260,7 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >                          * beyond reasonable stack size. Hence extendin=
g fentry
> >                          * is not allowed.
> >                          */
> > -                       bpf_log(log, "Cannot extend fentry/fexit\n");
> > +                       bpf_log(log, "Cannot extend fentry/fexit/sessio=
n\n");
>=20
> fsession?

OK

Thanks!
Menglong Dong

>=20
> >                         return -EINVAL;
> >                 }
> >         } else {
> > @@ -24341,6 +24344,7 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >         case BPF_LSM_CGROUP:
> >         case BPF_TRACE_FENTRY:
> >         case BPF_TRACE_FEXIT:
> > +       case BPF_TRACE_SESSION:
> >                 if (!btf_type_is_func(t)) {
> >                         bpf_log(log, "attach_btf_id %u is not a functio=
n\n",
> >                                 btf_id);
>=20
> [...]
>=20





