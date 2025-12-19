Return-Path: <bpf+bounces-77147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35228CCFB40
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB5C30CF633
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B26322B94;
	Fri, 19 Dec 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oG0rZKVs"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDD33064A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145701; cv=none; b=llYlCymqBo6rTqoHZgiSH2srUfqN+Xa4bDfqShbbDPCqmbUB6r3nk/bdm4i1UfhLigisq3qjMu7pFjfO5/Y38o2l6Dbd3nU6ZKqQ98FUoXstp30eoZvmD40+mwgZWWIJSClSUGlqJ+bGm6nACgapEsvm9Of8Q9W4tosK6mvytWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145701; c=relaxed/simple;
	bh=awYHUy8VmQa2VJYND9fMHo+aIh4bT/3BQ/2xM8rW764=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJVCgagsMpDt4o5yg3LiAUTrh/wnNMEeQQ3VbV2Z1eJ0gWsPVIyeoOOZoyFeyBBvZEJJpv5m5GgsvC0zwPMJspTFzKaXDkTPNfm64iD9IHNu3cY1n2/fQQebG+9fs4+oFfS28P/HPD97SpCdgMABPIIWHkcevVF5Oma9u8Te1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oG0rZKVs; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766145687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/h7COXsg2VJ9A30PFotoW9oYMmwM73seEz2N0UIoT0=;
	b=oG0rZKVsveGZmdx80xZNUV1FU9qPjRLVbpe1JEE0o2DdcW0NbUB2cAmJfZzHnTrXB1JhQa
	x6FoE4f/IODeLNfs5UU3YB/j6sF/D8p9IQhKPDjaw26cHjJNmm4R/U02PAVmCSbuKZNwlN
	hDtRwi70Wdy5xhuSnOzHddxsfn/yT8A=
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
Subject: Re: [PATCH bpf-next v4 4/9] bpf: add the kfunc bpf_fsession_cookie
Date: Fri, 19 Dec 2025 20:01:02 +0800
Message-ID: <12808306.O9o76ZdvQC@7950hx>
In-Reply-To: <2334439.iZASKD2KPV@7940hx>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <CAEf4Bza=Cuu-3LZs7XuK-d7FLKAU8ppkLneiuLqDejzfweHqqA@mail.gmail.com>
 <2334439.iZASKD2KPV@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/19 09:31, Menglong Dong wrote:
> On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Implement session cookie for fsession. In order to limit the stack us=
age,
> > > we make 4 as the maximum of the cookie count.
> > >
> > > The offset of the current cookie is stored in the
> > > "(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
> > > session cookie with ctx[-offset].
> > >
> > > The stack will look like this:
> > >
> > >   return value  -> 8 bytes
> > >   argN          -> 8 bytes
> > >   ...
> > >   arg1          -> 8 bytes
> > >   nr_args       -> 8 bytes
> > >   ip(optional)  -> 8 bytes
> > >   cookie2       -> 8 bytes
> > >   cookie1       -> 8 bytes
> > >
> > > Inline the bpf_fsession_cookie() in the verifer too.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v4:
> > > - limit the maximum of the cookie count to 4
> > > - store the session cookies before nr_regs in stack
> > > ---
> > >  include/linux/bpf.h      | 16 ++++++++++++++++
> > >  kernel/bpf/trampoline.c  | 14 +++++++++++++-
> > >  kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
> > >  kernel/trace/bpf_trace.c |  9 +++++++++
> > >  4 files changed, 56 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index d165ace5cc9b..0f35c6ab538c 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1215,6 +1215,7 @@ enum {
> > >
> > >  #define BPF_TRAMP_M_NR_ARGS    0
> > >  #define BPF_TRAMP_M_IS_RETURN  8
> > > +#define BPF_TRAMP_M_COOKIE     9
> > >
> > >  struct bpf_tramp_links {
> > >         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> > > @@ -1318,6 +1319,7 @@ struct bpf_trampoline {
> > >         struct mutex mutex;
> > >         refcount_t refcnt;
> > >         u32 flags;
> > > +       int cookie_cnt;
> >=20
> > can't you just count this each time you need to know instead of
> > keeping track of this? it's not that expensive and won't happen that
> > frequently (and we keep lock on trampoline, so it's also safe and
> > race-free to count)
>=20
> There is a for-loop below that use the "cookie_cnt" to clear all the
> cookie to zero. We limited the maximum of cookie_cnt to 4, so
> I guess we can count it directly there. I'll change it in the
> next version.

Sorry I messed it up with the 5th patch. I'll remove this cookie_cnt
and count it directly in __bpf_trampoline_link_prog(). And for the
other comments in the patch, all ACK.

Thanks!
Menglong Dong

>=20
> Thanks!
> Menglong Dong
>=20
> >=20
> > >         u64 key;
> > >         struct {
> > >                 struct btf_func_model model;
> > > @@ -1762,6 +1764,7 @@ struct bpf_prog {
> > >                                 enforce_expected_attach_type:1, /* En=
force expected_attach_type checking at attach time */
> > >                                 call_get_stack:1, /* Do we call bpf_g=
et_stack() or bpf_get_stackid() */
> > >                                 call_get_func_ip:1, /* Do we call get=
_func_ip() */
> > > +                               call_session_cookie:1, /* Do we call =
bpf_fsession_cookie() */
> > >                                 tstamp_type_access:1, /* Accessed __s=
k_buff->tstamp_type */
> > >                                 sleepable:1;    /* BPF program is sle=
epable */
> > >         enum bpf_prog_type      type;           /* Type of BPF progra=
m */
> >=20
> > [...]
> >=20
>=20
>=20
>=20
>=20
>=20





