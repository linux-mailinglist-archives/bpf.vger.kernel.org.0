Return-Path: <bpf+bounces-63437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AAB07604
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D562D188E494
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E442F2C69;
	Wed, 16 Jul 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tVA94b8d"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291B19CC37
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669899; cv=none; b=V6NErFbIWOJeQyh0r2eMBF9k35bgCL1+kxVoLH5Ll32PSQkK1xKdqeA6BJY51UdUJLBwtOmriBJOHGO+dso3lh60/WZQBrgkCReVauEPBRFzNHC8/czWnp4xm4SwcjryuAxw8ZVDB6QnQ/IvxtdkKnWujUCdkwbbuRcWWB/1XK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669899; c=relaxed/simple;
	bh=ZUvAaiwQUwWuzZbUuPGLMhzTlnmlB0SfHQhbi2yhhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNemKuRE8OrNMH2r+UQpVaRb5VprIW1viSnSwp7cpB/3lmvlxmX89XzB+Ynm8n9jrJ60dEIvi01FDpMib0FTl4ar3jIWeQEU1gEZlkwGHSJ1ObnlpgLnReJd5CnbUckR07rn8UyJ7loUJO3PCZBi6c1phIIiAdqfNHrgbUQ40bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tVA94b8d; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752669894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ls8sORC0cw7MdN0wJu+juqBfDrsZD/thcgd7vtypmU=;
	b=tVA94b8dkd5pyLjT2eJddN68Ovo5vMMWrfEpl0vZ8hFBmJg+gsAXKLjgDTdPyDnKB4qvL8
	1h7WNX2MyEIzqYV1vAYulDICYZUuxWU0W5oS0VlGRZcH3VA/F88IgUEhUtJEQQCpfHbzzu
	5D1LKdZN1MmMEwVHSDEiDMViZpeo2+w=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 13/18] libbpf: support tracing_multi
Date: Wed, 16 Jul 2025 20:43:49 +0800
Message-ID: <2561816.jE0xQCEvom@7940hx>
In-Reply-To:
 <CAEf4BzZ-3rs2U8x7K+Gd3dDTn5OusBh5SsZ_cE3ZeuVHnoRzKQ@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <3c389877-eafe-497a-a73e-720a3fcbcadb@linux.dev>
 <CAEf4BzZ-3rs2U8x7K+Gd3dDTn5OusBh5SsZ_cE3ZeuVHnoRzKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wednesday, July 16, 2025 1:20 AM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> write:
> On Mon, Jul 14, 2025 at 6:59=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 7/15/25 06:07, Andrii Nakryiko wrote:
> > > On Thu, Jul 3, 2025 at 5:24=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >> Add supporting for the attach types of:
> > >>
> > >> BPF_TRACE_FENTRY_MULTI
> > >> BPF_TRACE_FEXIT_MULTI
> > >> BPF_MODIFY_RETURN_MULTI
> > >>
> > >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > >> ---
> > >>   tools/bpf/bpftool/common.c |   3 +
> > >>   tools/lib/bpf/bpf.c        |  10 +++
> > >>   tools/lib/bpf/bpf.h        |   6 ++
> > >>   tools/lib/bpf/libbpf.c     | 168 +++++++++++++++++++++++++++++++++=
+++-
> > >>   tools/lib/bpf/libbpf.h     |  19 +++++
> > >>   tools/lib/bpf/libbpf.map   |   1 +
> > >>   6 files changed, 204 insertions(+), 3 deletions(-)
> > >>
> > > [...]
> > >
> > >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > >> index 1342564214c8..5c97acec643d 100644
> > >> --- a/tools/lib/bpf/bpf.h
> > >> +++ b/tools/lib/bpf/bpf.h
> > >> @@ -422,6 +422,12 @@ struct bpf_link_create_opts {
> > >>                  struct {
> > >>                          __u64 cookie;
> > >>                  } tracing;
> > >> +               struct {
> > >> +                       __u32 cnt;
> > >> +                       const __u32 *btf_ids;
> > >> +                       const __u32 *tgt_fds;
> > > tgt_fds are always BTF FDs, right? Do we intend to support
> > > freplace-style multi attachment at all? If not, I'd name them btf_fds,
> > > and btf_ids -> btf_type_ids (because BTF ID can also refer to kernel
> > > ID of BTF object, so ambiguous and somewhat confusing)
> >
> >
> > For now, freplace is not supported. And I'm not sure if we will support
> >
> > it in the feature.
> >
> >
> > I think that there should be no need to use freplace in large quantitie=
s,
> >
> > so we don't need to support the multi attachment for it in the feature.
> >
> >
> > Yeah, I'll follow your advice in the next version.
> >
>=20
> great
>=20
> >
> > >
> > >> +                       const __u64 *cookies;
> > >> +               } tracing_multi;
> > >>                  struct {
> > >>                          __u32 pf;
> > >>                          __u32 hooknum;
> > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > >> index 530c29f2f5fc..ae38b3ab84c7 100644
> > >> --- a/tools/lib/bpf/libbpf.c
> > >> +++ b/tools/lib/bpf/libbpf.c
> > >> @@ -136,6 +136,9 @@ static const char * const attach_type_name[] =3D=
 {
> > >>          [BPF_NETKIT_PEER]               =3D "netkit_peer",
> > >>          [BPF_TRACE_KPROBE_SESSION]      =3D "trace_kprobe_session",
> > >>          [BPF_TRACE_UPROBE_SESSION]      =3D "trace_uprobe_session",
> > >> +       [BPF_TRACE_FENTRY_MULTI]        =3D "trace_fentry_multi",
> > >> +       [BPF_TRACE_FEXIT_MULTI]         =3D "trace_fexit_multi",
> > >> +       [BPF_MODIFY_RETURN_MULTI]       =3D "modify_return_multi",
> > >>   };
> > >>
> > >>   static const char * const link_type_name[] =3D {
> > >> @@ -410,6 +413,8 @@ enum sec_def_flags {
> > >>          SEC_XDP_FRAGS =3D 16,
> > >>          /* Setup proper attach type for usdt probes. */
> > >>          SEC_USDT =3D 32,
> > >> +       /* attachment target is multi-link */
> > >> +       SEC_ATTACH_BTF_MULTI =3D 64,
> > >>   };
> > >>
> > >>   struct bpf_sec_def {
> > >> @@ -7419,9 +7424,9 @@ static int libbpf_prepare_prog_load(struct bpf=
_program *prog,
> > >>                  opts->expected_attach_type =3D BPF_TRACE_UPROBE_MUL=
TI;
> > >>          }
> > >>
> > >> -       if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> > >> +       if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog=
=2D>attach_btf_id) {
> > >>                  int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
> > >> -               const char *attach_name;
> > >> +               const char *attach_name, *name_end;
> > >>
> > >>                  attach_name =3D strchr(prog->sec_name, '/');
> > >>                  if (!attach_name) {
> > >> @@ -7440,7 +7445,27 @@ static int libbpf_prepare_prog_load(struct bp=
f_program *prog,
> > >>                  }
> > >>                  attach_name++; /* skip over / */
> > >>
> > >> -               err =3D libbpf_find_attach_btf_id(prog, attach_name,=
 &btf_obj_fd, &btf_type_id);
> > >> +               name_end =3D strchr(attach_name, ',');
> > >> +               /* for multi-link tracing, use the first target symb=
ol during
> > >> +                * loading.
> > >> +                */
> > >> +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> > >> +                       int len =3D name_end - attach_name + 1;
> > > for multi-kprobe we decided to only support a single glob  as a target
> > > in declarative SEC() definition. If a user needs more control, they
> > > can always fallback to the programmatic bpf_program__attach_..._opts()
> > > variant. Let's do the same here, glob is good enough for declarative
> > > use cases, and for complicated cases programmatic is the way to go
> > > anyways. You'll avoid unnecessary complications like this one then.
> >
> >
> > In fact, this is to make the BPF code in the selftests simple. With such
> >
> > control, I can test different combination of the target functions easil=
y,
> >
> > just like this:
> >
> >
> > SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct=
_arg_13")
> > int BPF_PROG2(fentry_success_test1, struct bpf_testmod_struct_arg_2, a)
> > {
> >      test_result =3D a.a + a.b;
> >      return 0;
> > }
> >
> > SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct=
_arg_10")
> > int BPF_PROG2(fentry_success_test2, int, a, struct
> > bpf_testmod_struct_arg_2, b)
> > {
> >      test_result =3D a + b.a + b.b;
> >      return 0;
> > }
> >
> >
> > And you are right, we should design it for the users, and a single glob=
 is
> >
> > much better. Instead, I'll implement the combination testings in the
> >
> > loader with bpf_program__attach_trace_multi_opts().
> >
>=20
> sgtm. I'd also think if we can construct a glob that would describe
> functions you need (and if necessary to rename testmod functions
> slightly - so be it, it's all for testing anyways)

It works if I define all the functions that I need in the testmod.
However, most of the functions in the testing is reusing the
existing function, so it's a little complex to change them :/

>=20
> >
> > >
> > > BTW, it's not trivial to figure this out from earlier patches, but
> > > does BPF verifier need to know all these BTF type IDs during program
> > > verification time? If yes, why and then why do we need to specify them
> > > during LINK_CREATE time. And if not, then great, and we don't need to
> > > parse all this during load time.
> >
> >
> > It doesn't need to know all the BTF type IDs, but it need to know one
> >
> > of them(the first one), which means that we still need to do the parse
> >
> > during load time.
> >
> >
> > Of course, we can split it:
> >
> > step 1: parse the glob and get the first BTF type ID during load time
> >
> > step 2: parse the glob and get all the BTF type IDs during attachment
> >
> >
> > But it will make the code a little more complex. Shoud I do it this way?
> >
> > I'd appreciate it to hear some advice here :/
>=20
> I think I have a bit of disconnect here, because in my mind
> multi-fentry/fexit cannot be type-aware, in general, at BPF
> verification time. I.e., verifier should not assume any specific
> prototype, and this gets back to my suggestion to just use
> bpf_get_func_arg/cnt. While in some special cases you might want to
> attach to a small number of functions that, say, have task_struct
> argument and we can take a bit of advantage of this in BPF code by
> verifier ensuring that all attached functions have that task_struct, I
> do think this is unnecessary complication and limitation, and I'd
> rather make multi-fentry/fexit not type-aware in the same way as
> fentry/fexit is. With that, verifier won't need to know BTF ID, and so
> multi-fentry will work very similarly to multi-kprobe, just will be
> slightly cheaper at runtime.

I see your idea now, which will free us from the function prototype
checking, and we don't need to do any consistency checking during
the attaching.

In my origin design, I tried to make the fentry-multi easy to use, and
keep the same usage with fentry.

So the only shortcoming of the method you said is that the user
can't access the function argument with ctx[x] directly, and the
bpf_core_cast() need to be used. Considering the use case, I think it's
OK in this way. After all, the common use case is we attach the bpf
prog to all the functions that has "task_struct" and store the argument
index in the cookie. And get the task_struct with
`bpf_core_cast(bpf_get_func_arg(cookie), struct task_struct)`.

I'll implement this part in this way, which can reduce 100+ line code :/

Thanks!
Menglong Dong

>=20
> And I'm saying all this, because even if all attached functions have
> task_struct as that argument, you can achieve exactly that by just
> doing `bpf_core_cast(bpf_get_func_arg(0), struct task_struct)`, and
> that's all. So I'd simplify and make working with multi-fentry easier
> for multi-function tracers (which is the challenging aspect with
> fentry today). If you have 2-3-4-5 functions you are attaching to and
> hoping to get that task_struct, you might as well just attach 2-3-4-5
> times, get performance benefit, without really compromising much on
> attachment time (because 5 attachments are plenty fast).
>=20
> >
> >
> > >
> > >> +                       char *first_tgt;
> > >> +
> > >> +                       first_tgt =3D malloc(len);
> > >> +                       if (!first_tgt)
> > >> +                               return -ENOMEM;
> > >> +                       libbpf_strlcpy(first_tgt, attach_name, len);
> > >> +                       first_tgt[len - 1] =3D '\0';
> > >> +                       err =3D libbpf_find_attach_btf_id(prog, firs=
t_tgt, &btf_obj_fd,
> > >> +                                                       &btf_type_id=
);
> > >> +                       free(first_tgt);
> > >> +               } else {
> > >> +                       err =3D libbpf_find_attach_btf_id(prog, atta=
ch_name, &btf_obj_fd,
> > >> +                                                       &btf_type_id=
);
> > >> +               }
> > >> +
> > >>                  if (err)
> > >>                          return err;
> > >>
> > >> @@ -9519,6 +9544,7 @@ static int attach_kprobe_session(const struct =
bpf_program *prog, long cookie, st
> > >>   static int attach_uprobe_multi(const struct bpf_program *prog, lon=
g cookie, struct bpf_link **link);
> > >>   static int attach_lsm(const struct bpf_program *prog, long cookie,=
 struct bpf_link **link);
> > >>   static int attach_iter(const struct bpf_program *prog, long cookie=
, struct bpf_link **link);
> > >> +static int attach_trace_multi(const struct bpf_program *prog, long =
cookie, struct bpf_link **link);
> > >>
> > >>   static const struct bpf_sec_def section_defs[] =3D {
> > >>          SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > >> @@ -9565,6 +9591,13 @@ static const struct bpf_sec_def section_defs[=
] =3D {
> > >>          SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, =
SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> > >>          SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN,=
 SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> > >>          SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, S=
EC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> > >> +       SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, S=
EC_ATTACH_BTF, attach_trace),
> > > duplicate
> >
> >
> > Get it :/
> >
> >
> > Thanks!
> >
> > Menglong Dong
> >
> >
> > >
> > >
> > >> +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MU=
LTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> > >> +       SEC_DEF("fmod_ret.multi+",      TRACING, BPF_MODIFY_RETURN_M=
ULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> > >> +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MUL=
TI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> > >> +       SEC_DEF("fentry.multi.s+",      TRACING, BPF_TRACE_FENTRY_MU=
LTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> > >> +       SEC_DEF("fmod_ret.multi.s+",    TRACING, BPF_MODIFY_RETURN_M=
ULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> > >> +       SEC_DEF("fexit.multi.s+",       TRACING, BPF_TRACE_FEXIT_MUL=
TI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> > >>          SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, att=
ach_trace),
> > >>          SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTAC=
H_BTF, attach_lsm),
> > >>          SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTAC=
H_BTF | SEC_SLEEPABLE, attach_lsm),
> > >> @@ -12799,6 +12832,135 @@ static int attach_trace(const struct bpf_p=
rogram *prog, long cookie, struct bpf_
> > >>          return libbpf_get_error(*link);
> > >>   }
> > >>
> > > [...]
> > >
>=20





