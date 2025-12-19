Return-Path: <bpf+bounces-77092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3DCCE25B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3111E30421B7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4923373D;
	Fri, 19 Dec 2025 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8jJhT7z"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E314F112
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107898; cv=none; b=nyJeztFJVNbWjrDCAk3dFQgxDgOIpldSlJFVgdkFqlPIA25yXOmHqTFAZXn5e7cfAB7r5yBSGL/qpKkZMJTrNjD10Uj2i5Q3iKnT3UUiQDwF7lVIiaviHhxF8pL96XrylRWo2DGMDsAhAv/7F3PeqE7U6Z6qpa7CI3R5zwhNCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107898; c=relaxed/simple;
	bh=0mcAgtKW5YfSfd0o76y1SFff2gIzdtO+pSy6ZXc0U90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIVkNrqDfKVYOblx1J/K+Vw988V8n8xA3/QhHqRVoUjmyeoGsw18MIIKD+cqYWxLF0fWASmsLXJXpQcRGkZfKjcxufnDEbkNbVqjg3o+RV8l+zrQ4M0n6CAWz4zDCaRLBSkQNwc0MnGaQslmRaTG7uQQuH1pJ2KORdj3Irs8s6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8jJhT7z; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766107879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DqlQx2Z2v0fASWsZ6YgDhJUlJqweRBPgJSWdzMub7g=;
	b=o8jJhT7zZd/OGa0OoTEtN0nrtAS+Y+UcuD1lwd6PBa4ripfR84ppaga6k4K+lVWts7LFA4
	IQNKjHzn0vZnRB+SSBRhkOC4Am95AqOukeoUxkPyBGuSHSGSUDG5rAVD3ESSY7jI4+cGko
	pwTJR1v2DMZiDGrTqs6wwsq1nJ3ajjw=
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
Date: Fri, 19 Dec 2025 09:31:05 +0800
Message-ID: <2334439.iZASKD2KPV@7940hx>
In-Reply-To:
 <CAEf4Bza=Cuu-3LZs7XuK-d7FLKAU8ppkLneiuLqDejzfweHqqA@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <20251217095445.218428-5-dongml2@chinatelecom.cn>
 <CAEf4Bza=Cuu-3LZs7XuK-d7FLKAU8ppkLneiuLqDejzfweHqqA@mail.gmail.com>
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
> > Implement session cookie for fsession. In order to limit the stack usag=
e,
> > we make 4 as the maximum of the cookie count.
> >
> > The offset of the current cookie is stored in the
> > "(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
> > session cookie with ctx[-offset].
> >
> > The stack will look like this:
> >
> >   return value  -> 8 bytes
> >   argN          -> 8 bytes
> >   ...
> >   arg1          -> 8 bytes
> >   nr_args       -> 8 bytes
> >   ip(optional)  -> 8 bytes
> >   cookie2       -> 8 bytes
> >   cookie1       -> 8 bytes
> >
> > Inline the bpf_fsession_cookie() in the verifer too.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v4:
> > - limit the maximum of the cookie count to 4
> > - store the session cookies before nr_regs in stack
> > ---
> >  include/linux/bpf.h      | 16 ++++++++++++++++
> >  kernel/bpf/trampoline.c  | 14 +++++++++++++-
> >  kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
> >  kernel/trace/bpf_trace.c |  9 +++++++++
> >  4 files changed, 56 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d165ace5cc9b..0f35c6ab538c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1215,6 +1215,7 @@ enum {
> >
> >  #define BPF_TRAMP_M_NR_ARGS    0
> >  #define BPF_TRAMP_M_IS_RETURN  8
> > +#define BPF_TRAMP_M_COOKIE     9
> >
> >  struct bpf_tramp_links {
> >         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> > @@ -1318,6 +1319,7 @@ struct bpf_trampoline {
> >         struct mutex mutex;
> >         refcount_t refcnt;
> >         u32 flags;
> > +       int cookie_cnt;
>=20
> can't you just count this each time you need to know instead of
> keeping track of this? it's not that expensive and won't happen that
> frequently (and we keep lock on trampoline, so it's also safe and
> race-free to count)

There is a for-loop below that use the "cookie_cnt" to clear all the
cookie to zero. We limited the maximum of cookie_cnt to 4, so
I guess we can count it directly there. I'll change it in the
next version.

Thanks!
Menglong Dong

>=20
> >         u64 key;
> >         struct {
> >                 struct btf_func_model model;
> > @@ -1762,6 +1764,7 @@ struct bpf_prog {
> >                                 enforce_expected_attach_type:1, /* Enfo=
rce expected_attach_type checking at attach time */
> >                                 call_get_stack:1, /* Do we call bpf_get=
_stack() or bpf_get_stackid() */
> >                                 call_get_func_ip:1, /* Do we call get_f=
unc_ip() */
> > +                               call_session_cookie:1, /* Do we call bp=
f_fsession_cookie() */
> >                                 tstamp_type_access:1, /* Accessed __sk_=
buff->tstamp_type */
> >                                 sleepable:1;    /* BPF program is sleep=
able */
> >         enum bpf_prog_type      type;           /* Type of BPF program =
*/
>=20
> [...]
>=20





