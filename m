Return-Path: <bpf+bounces-63345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E7B06505
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EDE1AA6813
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E3283FCB;
	Tue, 15 Jul 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioWIM/1m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE352594B7;
	Tue, 15 Jul 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600020; cv=none; b=CGA1/9k1efcRzNUIPFuAivMRdYp95pZI6IbhwDk9jNYssKi2pM88PHqdkp2Igl3d1D7pfUXy82Q+dHixbT45ep/S+OmN1eyp93fcqzyFxNT2J25Ck4WM44zZ9mRS2BVDXK07ZSA/0zbjFZRL9zxI7eJmLgGUHiHF54tZiGYI5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600020; c=relaxed/simple;
	bh=e77kAmfpAlkMTKqYx2eaQAwcK6FZnVDDegaeTNwiVQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSfmETBun7M7G1Fp/RXJdvNfd9zpa+jWR+4GPSWfa5OEnnqZwneWP/Mf58nzp/yhXSjA/wbQX5takT75N1gfz5aeYuMvEwgrgtsbYz+unehGcZuJLGeJIYpwojIXCoCt+Hry3UA1gqvNE/ypzmOuOoKDfHG0zBwb15hETg3VBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioWIM/1m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ef62066eso84340805ad.3;
        Tue, 15 Jul 2025 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600018; x=1753204818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqN98hHNSjb22DwO3xGUMLwww0a5Rpa6LC4wum+aj5o=;
        b=ioWIM/1mty7MWlDpopfnS5k16RqvK4M0rv3U4NJSz1pFuhERXCQOIADuB0j9yaLobf
         yCRY0zMSIvxyFaEPNzkSQxHi/9c2QzBPA/Fg39Cn+umbi2aBS/VMz3SUlkqQbvHUuUni
         M9S2qj8e8wmuUGXHq7B3r7U4n4/+02oVg7Sq4egn8zj1MNCBrE5YWxDAVEHBQqzv0dLY
         LuNCIn3lBE18xy+xoywHpqdPwu+hWmyClOgatX9NdEkLQ2xXmjSdF0nM854/iP0eIXHt
         z5XLzutguxFcnvFTliDn1IU2UAMNPyuHiRxz46iGFO9BYVXcKfoRL2A1i79ewM1fmHxZ
         Vprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600018; x=1753204818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqN98hHNSjb22DwO3xGUMLwww0a5Rpa6LC4wum+aj5o=;
        b=Pplq3kdAa3Jt7qp5wllAZegX8yXVgIZz80cobsbIaiRbOpKF+oj3oizXct8G8qoTub
         aHjBkeFtX0sTR6J0ByyjJaulKgaPywJ+L+hKWQ9BL9S/0H+GQt936A3XG3KoZbcoGXbP
         RE5MogxDKz3kgZFjikx1S+Omwb+UN6hrJtJxm0Du0CEudvNKg7YfBuADXWB50hkwSgxV
         mhc9X4/wcDVtlNpiNeLPhcZ2E+hVz13r+mjOJycVUki7OZbpJECOM6ProyVhAr9tqGfQ
         z/vLh59CBqlr4FOQ5DOxgURq70X1e32HJFtz2czSZw7QRqdYBfK1w210IRjJQR9m731H
         GWtw==
X-Forwarded-Encrypted: i=1; AJvYcCUVesews1I5nMsNRIa+QbZzzkgrp9bpuIisBvCpyf9TotIgZYD2WeDoC4dGwfmllssfTFs=@vger.kernel.org, AJvYcCVJZhBX5Q2uaPLLvZhC7+HLAAxT8TlBIrtAX763S5o5gHQBDZQ+5/TWBUp6ggMHsSX0oqcEVWSsdgN/G7Xp@vger.kernel.org
X-Gm-Message-State: AOJu0YztmhV9uvnAMyFYzSnpUrfqu90TENCAxJTtjWlCGWs09tKu4JK5
	mo+IisPGa9C94Y6sXMhYGFk5RBJc7LDgcOE6+lXnh5Dl2SfgvNEJOHmbPbN6/FBiAc2SLRD21Jp
	6vTFkNSe6fW9A4kxdMqZPg/YGUM2d6pQ=
X-Gm-Gg: ASbGncswPF8sxqvwkVtckH9iIkuG742zqs7Gwg+SRFiNsmfB8yQYczKyqFsYq/zzpxN
	KHTmcNoNlADYREIeVaXHj+G/17URVs7tNMZgGysbrqzgx38teBxYtvtXVwdMueRWm3E/zgfdSLD
	jlt/KGIMjyaNZkOdtuEQ0JgtBTcAPyOmlVJtthwk0750Q4Tk0iwgvrLtMW8kkwPXbY2BbhRjxAi
	sZYdNdNpzQs0KQX6oBo7YU=
X-Google-Smtp-Source: AGHT+IFh8R4HHh///mpuww5FmN6oeVaE7GRMdnWD9U03OrNBUDCvi8XsINRZ3sPAHy0lQG5Iu5iDOqFsu/Ry7A+De1w=
X-Received: by 2002:a17:903:1b26:b0:234:ba37:87b6 with SMTP id
 d9443c01a7336-23dede3897amr293774395ad.17.1752600018056; Tue, 15 Jul 2025
 10:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-14-dongml2@chinatelecom.cn> <CAEf4BzaxLm1qm-WxFKDWO0rHqUrvfg8sC0737MMKKQb77cRe7Q@mail.gmail.com>
 <3c389877-eafe-497a-a73e-720a3fcbcadb@linux.dev>
In-Reply-To: <3c389877-eafe-497a-a73e-720a3fcbcadb@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:20:05 -0700
X-Gm-Features: Ac12FXzdlrwspRsYaNuaM7cAhw4AclSBiSuGZ5DnO88_hXSfBoftPaQMPYI0fKE
Message-ID: <CAEf4BzZ-3rs2U8x7K+Gd3dDTn5OusBh5SsZ_cE3ZeuVHnoRzKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/18] libbpf: support tracing_multi
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:59=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> On 7/15/25 06:07, Andrii Nakryiko wrote:
> > On Thu, Jul 3, 2025 at 5:24=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >> Add supporting for the attach types of:
> >>
> >> BPF_TRACE_FENTRY_MULTI
> >> BPF_TRACE_FEXIT_MULTI
> >> BPF_MODIFY_RETURN_MULTI
> >>
> >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >> ---
> >>   tools/bpf/bpftool/common.c |   3 +
> >>   tools/lib/bpf/bpf.c        |  10 +++
> >>   tools/lib/bpf/bpf.h        |   6 ++
> >>   tools/lib/bpf/libbpf.c     | 168 +++++++++++++++++++++++++++++++++++=
+-
> >>   tools/lib/bpf/libbpf.h     |  19 +++++
> >>   tools/lib/bpf/libbpf.map   |   1 +
> >>   6 files changed, 204 insertions(+), 3 deletions(-)
> >>
> > [...]
> >
> >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >> index 1342564214c8..5c97acec643d 100644
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -422,6 +422,12 @@ struct bpf_link_create_opts {
> >>                  struct {
> >>                          __u64 cookie;
> >>                  } tracing;
> >> +               struct {
> >> +                       __u32 cnt;
> >> +                       const __u32 *btf_ids;
> >> +                       const __u32 *tgt_fds;
> > tgt_fds are always BTF FDs, right? Do we intend to support
> > freplace-style multi attachment at all? If not, I'd name them btf_fds,
> > and btf_ids -> btf_type_ids (because BTF ID can also refer to kernel
> > ID of BTF object, so ambiguous and somewhat confusing)
>
>
> For now, freplace is not supported. And I'm not sure if we will support
>
> it in the feature.
>
>
> I think that there should be no need to use freplace in large quantities,
>
> so we don't need to support the multi attachment for it in the feature.
>
>
> Yeah, I'll follow your advice in the next version.
>

great

>
> >
> >> +                       const __u64 *cookies;
> >> +               } tracing_multi;
> >>                  struct {
> >>                          __u32 pf;
> >>                          __u32 hooknum;
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 530c29f2f5fc..ae38b3ab84c7 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -136,6 +136,9 @@ static const char * const attach_type_name[] =3D {
> >>          [BPF_NETKIT_PEER]               =3D "netkit_peer",
> >>          [BPF_TRACE_KPROBE_SESSION]      =3D "trace_kprobe_session",
> >>          [BPF_TRACE_UPROBE_SESSION]      =3D "trace_uprobe_session",
> >> +       [BPF_TRACE_FENTRY_MULTI]        =3D "trace_fentry_multi",
> >> +       [BPF_TRACE_FEXIT_MULTI]         =3D "trace_fexit_multi",
> >> +       [BPF_MODIFY_RETURN_MULTI]       =3D "modify_return_multi",
> >>   };
> >>
> >>   static const char * const link_type_name[] =3D {
> >> @@ -410,6 +413,8 @@ enum sec_def_flags {
> >>          SEC_XDP_FRAGS =3D 16,
> >>          /* Setup proper attach type for usdt probes. */
> >>          SEC_USDT =3D 32,
> >> +       /* attachment target is multi-link */
> >> +       SEC_ATTACH_BTF_MULTI =3D 64,
> >>   };
> >>
> >>   struct bpf_sec_def {
> >> @@ -7419,9 +7424,9 @@ static int libbpf_prepare_prog_load(struct bpf_p=
rogram *prog,
> >>                  opts->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI=
;
> >>          }
> >>
> >> -       if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> >> +       if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->=
attach_btf_id) {
> >>                  int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
> >> -               const char *attach_name;
> >> +               const char *attach_name, *name_end;
> >>
> >>                  attach_name =3D strchr(prog->sec_name, '/');
> >>                  if (!attach_name) {
> >> @@ -7440,7 +7445,27 @@ static int libbpf_prepare_prog_load(struct bpf_=
program *prog,
> >>                  }
> >>                  attach_name++; /* skip over / */
> >>
> >> -               err =3D libbpf_find_attach_btf_id(prog, attach_name, &=
btf_obj_fd, &btf_type_id);
> >> +               name_end =3D strchr(attach_name, ',');
> >> +               /* for multi-link tracing, use the first target symbol=
 during
> >> +                * loading.
> >> +                */
> >> +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> >> +                       int len =3D name_end - attach_name + 1;
> > for multi-kprobe we decided to only support a single glob  as a target
> > in declarative SEC() definition. If a user needs more control, they
> > can always fallback to the programmatic bpf_program__attach_..._opts()
> > variant. Let's do the same here, glob is good enough for declarative
> > use cases, and for complicated cases programmatic is the way to go
> > anyways. You'll avoid unnecessary complications like this one then.
>
>
> In fact, this is to make the BPF code in the selftests simple. With such
>
> control, I can test different combination of the target functions easily,
>
> just like this:
>
>
> SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_a=
rg_13")
> int BPF_PROG2(fentry_success_test1, struct bpf_testmod_struct_arg_2, a)
> {
>      test_result =3D a.a + a.b;
>      return 0;
> }
>
> SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_a=
rg_10")
> int BPF_PROG2(fentry_success_test2, int, a, struct
> bpf_testmod_struct_arg_2, b)
> {
>      test_result =3D a + b.a + b.b;
>      return 0;
> }
>
>
> And you are right, we should design it for the users, and a single glob i=
s
>
> much better. Instead, I'll implement the combination testings in the
>
> loader with bpf_program__attach_trace_multi_opts().
>

sgtm. I'd also think if we can construct a glob that would describe
functions you need (and if necessary to rename testmod functions
slightly - so be it, it's all for testing anyways)

>
> >
> > BTW, it's not trivial to figure this out from earlier patches, but
> > does BPF verifier need to know all these BTF type IDs during program
> > verification time? If yes, why and then why do we need to specify them
> > during LINK_CREATE time. And if not, then great, and we don't need to
> > parse all this during load time.
>
>
> It doesn't need to know all the BTF type IDs, but it need to know one
>
> of them(the first one), which means that we still need to do the parse
>
> during load time.
>
>
> Of course, we can split it:
>
> step 1: parse the glob and get the first BTF type ID during load time
>
> step 2: parse the glob and get all the BTF type IDs during attachment
>
>
> But it will make the code a little more complex. Shoud I do it this way?
>
> I'd appreciate it to hear some advice here :/

I think I have a bit of disconnect here, because in my mind
multi-fentry/fexit cannot be type-aware, in general, at BPF
verification time. I.e., verifier should not assume any specific
prototype, and this gets back to my suggestion to just use
bpf_get_func_arg/cnt. While in some special cases you might want to
attach to a small number of functions that, say, have task_struct
argument and we can take a bit of advantage of this in BPF code by
verifier ensuring that all attached functions have that task_struct, I
do think this is unnecessary complication and limitation, and I'd
rather make multi-fentry/fexit not type-aware in the same way as
fentry/fexit is. With that, verifier won't need to know BTF ID, and so
multi-fentry will work very similarly to multi-kprobe, just will be
slightly cheaper at runtime.

And I'm saying all this, because even if all attached functions have
task_struct as that argument, you can achieve exactly that by just
doing `bpf_core_cast(bpf_get_func_arg(0), struct task_struct)`, and
that's all. So I'd simplify and make working with multi-fentry easier
for multi-function tracers (which is the challenging aspect with
fentry today). If you have 2-3-4-5 functions you are attaching to and
hoping to get that task_struct, you might as well just attach 2-3-4-5
times, get performance benefit, without really compromising much on
attachment time (because 5 attachments are plenty fast).

>
>
> >
> >> +                       char *first_tgt;
> >> +
> >> +                       first_tgt =3D malloc(len);
> >> +                       if (!first_tgt)
> >> +                               return -ENOMEM;
> >> +                       libbpf_strlcpy(first_tgt, attach_name, len);
> >> +                       first_tgt[len - 1] =3D '\0';
> >> +                       err =3D libbpf_find_attach_btf_id(prog, first_=
tgt, &btf_obj_fd,
> >> +                                                       &btf_type_id);
> >> +                       free(first_tgt);
> >> +               } else {
> >> +                       err =3D libbpf_find_attach_btf_id(prog, attach=
_name, &btf_obj_fd,
> >> +                                                       &btf_type_id);
> >> +               }
> >> +
> >>                  if (err)
> >>                          return err;
> >>
> >> @@ -9519,6 +9544,7 @@ static int attach_kprobe_session(const struct bp=
f_program *prog, long cookie, st
> >>   static int attach_uprobe_multi(const struct bpf_program *prog, long =
cookie, struct bpf_link **link);
> >>   static int attach_lsm(const struct bpf_program *prog, long cookie, s=
truct bpf_link **link);
> >>   static int attach_iter(const struct bpf_program *prog, long cookie, =
struct bpf_link **link);
> >> +static int attach_trace_multi(const struct bpf_program *prog, long co=
okie, struct bpf_link **link);
> >>
> >>   static const struct bpf_sec_def section_defs[] =3D {
> >>          SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> >> @@ -9565,6 +9591,13 @@ static const struct bpf_sec_def section_defs[] =
=3D {
> >>          SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SE=
C_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >>          SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, S=
EC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >>          SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC=
_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >> +       SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC=
_ATTACH_BTF, attach_trace),
> > duplicate
>
>
> Get it :/
>
>
> Thanks!
>
> Menglong Dong
>
>
> >
> >
> >> +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MULT=
I, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> >> +       SEC_DEF("fmod_ret.multi+",      TRACING, BPF_MODIFY_RETURN_MUL=
TI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> >> +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MULTI=
, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> >> +       SEC_DEF("fentry.multi.s+",      TRACING, BPF_TRACE_FENTRY_MULT=
I, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> >> +       SEC_DEF("fmod_ret.multi.s+",    TRACING, BPF_MODIFY_RETURN_MUL=
TI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> >> +       SEC_DEF("fexit.multi.s+",       TRACING, BPF_TRACE_FEXIT_MULTI=
, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> >>          SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attac=
h_trace),
> >>          SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_=
BTF, attach_lsm),
> >>          SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_=
BTF | SEC_SLEEPABLE, attach_lsm),
> >> @@ -12799,6 +12832,135 @@ static int attach_trace(const struct bpf_pro=
gram *prog, long cookie, struct bpf_
> >>          return libbpf_get_error(*link);
> >>   }
> >>
> > [...]
> >

