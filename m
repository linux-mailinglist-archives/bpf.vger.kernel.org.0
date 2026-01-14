Return-Path: <bpf+bounces-78809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86BD1C193
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0110630303A8
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087B2F25FB;
	Wed, 14 Jan 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPivotPb"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945072BD031
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356674; cv=none; b=NcaDvuRVXLRtE396rzrewwT0omX/YjRGU7YW6K2VHpAy7+3RKInenAL8yjGL78+93TLpVXqLkkataCKXP1VAKP+2RPAOOszIfrzvnmgg4i9yWdtUh/34G0eyHIOl4lahPRLbHhw+guantJRWAE+HU1vYZFX+TShSPlOqpEvytlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356674; c=relaxed/simple;
	bh=CKgNMAlyXUEaP0ClIHmSnWXgsw4NQ5DkwT20XP6F+oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoRA6gXf0+RK1wplBf82LKb0VDP90xDgDBjfwUpxAwqTkVeSmg3mMhBooaYrWLxC3y+zP6/bBh94EBEnTLUpfh37RJDDshen33lVHxTunL+mudq3TblacpN1LmXjOqM7ljq1XRkjj142jI1YBmjzf4QTE/F9dPrUjFlvic+wf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPivotPb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768356660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xz599r0iAUAk9Mbp8CSuSAzFPjvdTeSdvAeJZE5alw=;
	b=hPivotPbhkRDVcGCCgtSO4P6+52chtnjmzDYHhrrFdZIsjtKdU9d40fqtV531LyTMP4k8P
	lclzlb4/Ov1DyK1bkRBzlOlUnznlWBh0hL5x+qPNxRCioDALntXww3R/+UQ7Mh2BxZd94b
	Ywc15a+sF6HInPXswFZgioXAgoXghLQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 01/11] bpf: add fsession support
Date: Wed, 14 Jan 2026 10:10:48 +0800
Message-ID: <3026834.e9J7NaK4W3@7940hx>
In-Reply-To:
 <CAEf4Bzb+p4fXkCL01MVrvCwPvboeMWXgu4uTSMhweO_MYL+tqg@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-2-dongml2@chinatelecom.cn>
 <CAEf4Bzb+p4fXkCL01MVrvCwPvboeMWXgu4uTSMhweO_MYL+tqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The fsession is something that similar to kprobe session. It allow to
> > attach a single BPF program to both the entry and the exit of the target
> > functions.
> >
[...]
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_=
verifier_log *log, const struct
> >                 case BPF_TRACE_FENTRY:
> >                 case BPF_TRACE_FEXIT:
> >                 case BPF_MODIFY_RETURN:
> > +               case BPF_TRACE_FSESSION:
> >                         /* allow u64* as ctx */
> >                         if (btf_is_int(t) && t->size =3D=3D 8)
> >                                 return 0;
> > @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                         fallthrough;
> >                 case BPF_LSM_CGROUP:
> >                 case BPF_TRACE_FEXIT:
> > +               case BPF_TRACE_FSESSION:
>=20
> According to the comment below we make this exception due to LSM.
> FSESSION won't be using FSESSION programs, no? So this is not
> necessary?

The comment describe the LSM case here, but the code
here is not only for LSM. It is also for FEXIT, which makes
sure that we can get the return value with "ctx[nr_args]".
So I think we still need it here, as we need to access the
return value with "ctx[nr_args]" too.

>=20
> >                         /* When LSM programs are attached to void LSM h=
ooks
> >                          * they use FEXIT trampolines and when attached=
 to
> >                          * int LSM hooks, they use MODIFY_RETURN trampo=
lines.
>=20
> [...]
>=20
> > @@ -4350,6 +4365,7 @@ attach_type_to_prog_type(enum bpf_attach_type att=
ach_type)
> >         case BPF_TRACE_RAW_TP:
> >         case BPF_TRACE_FENTRY:
> >         case BPF_TRACE_FEXIT:
> > +       case BPF_TRACE_FSESSION:
> >         case BPF_MODIFY_RETURN:
> >                 return BPF_PROG_TYPE_TRACING;
> >         case BPF_LSM_MAC:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 2a125d063e62..11e043049d68 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog =
*prog)
> >
> >         return (ptype =3D=3D BPF_PROG_TYPE_TRACING &&
> >                 (eatype =3D=3D BPF_TRACE_FENTRY || eatype =3D=3D BPF_TR=
ACE_FEXIT ||
> > -                eatype =3D=3D BPF_MODIFY_RETURN)) ||
> > +                eatype =3D=3D BPF_MODIFY_RETURN || eatype =3D=3D BPF_T=
RACE_FSESSION)) ||
> >                 (ptype =3D=3D BPF_PROG_TYPE_LSM && eatype =3D=3D BPF_LS=
M_MAC);
>=20
> this is getting crazy, switch to the switch (lol) maybe?

ACK

>=20
> >  }
> >
> > @@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_=
tramp(struct bpf_prog *prog)
> >                 return BPF_TRAMP_MODIFY_RETURN;
> >         case BPF_TRACE_FEXIT:
> >                 return BPF_TRAMP_FEXIT;
> > +       case BPF_TRACE_FSESSION:
> > +               return BPF_TRAMP_FSESSION;
> >         case BPF_LSM_MAC:
> >                 if (!prog->aux->attach_func_proto->type)
> >                         /* The function returns void, we cannot modify =
its
> > @@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tr=
amp_link *link,
> >  {
> >         enum bpf_tramp_prog_type kind;
> >         struct bpf_tramp_link *link_exiting;
> > +       struct bpf_fsession_link *fslink;
>=20
> initialize to NULL to avoid compiler (falsely, but still) complaining
> about potentially using uninitialized value

ACK

>=20
> > +       struct hlist_head *prog_list;
> >         int err =3D 0;
> >         int cnt =3D 0, i;
> >
>=20
> [...]
>=20
> > -       hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> > -       tr->progs_cnt[kind]++;
> > +       hlist_add_head(&link->tramp_hlist, prog_list);
> > +       if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > +               tr->progs_cnt[BPF_TRAMP_FENTRY]++;
> > +               fslink =3D container_of(link, struct bpf_fsession_link,=
 link.link);
> > +               hlist_add_head(&fslink->fexit.tramp_hlist,
> > +                              &tr->progs_hlist[BPF_TRAMP_FEXIT]);
>=20
> fits under 100 characters? keep on a single line then

ACK

>=20
> > +               tr->progs_cnt[BPF_TRAMP_FEXIT]++;
> > +       } else {
> > +               tr->progs_cnt[kind]++;
> > +       }
> >         err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >         if (err) {
> >                 hlist_del_init(&link->tramp_hlist);
> > -               tr->progs_cnt[kind]--;
> > +               if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > +                       tr->progs_cnt[BPF_TRAMP_FENTRY]--;
> > +                       hlist_del_init(&fslink->fexit.tramp_hlist);
> > +                       tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> > +               } else {
> > +                       tr->progs_cnt[kind]--;
> > +               }
> >         }
> >         return err;
> >  }
> > @@ -659,6 +683,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_=
tramp_link *link,
> >                                         struct bpf_trampoline *tr,
> >                                         struct bpf_prog *tgt_prog)
> >  {
> > +       struct bpf_fsession_link *fslink;
>=20
> used in only one branch, move declaration there?

ACK

Thanks!
Menglong Dong

>=20
> >         enum bpf_tramp_prog_type kind;
> >         int err;
> >
> > @@ -672,6 +697,11 @@ static int __bpf_trampoline_unlink_prog(struct bpf=
_tramp_link *link,
> >                 guard(mutex)(&tgt_prog->aux->ext_mutex);
> >                 tgt_prog->aux->is_extended =3D false;
> >                 return err;
> > +       } else if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > +               fslink =3D container_of(link, struct bpf_fsession_link,=
 link.link);
> > +               hlist_del_init(&fslink->fexit.tramp_hlist);
> > +               tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> > +               kind =3D BPF_TRAMP_FENTRY;
> >         }
> >         hlist_del_init(&link->tramp_hlist);
> >         tr->progs_cnt[kind]--;
>=20
> [...]
>=20





