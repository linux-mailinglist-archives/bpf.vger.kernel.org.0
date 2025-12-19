Return-Path: <bpf+bounces-77095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A5CCE2CA
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E01C306FE4D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A123C8C7;
	Fri, 19 Dec 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K2SgAq6j"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78B23BD05
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766108552; cv=none; b=eMdDZzcl7IJGkxWH3Udb63wOqbxyj52NVhGwdU7dmSCGUGdyDi5J+CksHPuOvZ50AOR6gdsszgLqXGvYf8DOqQht39hdsQhnJecFU7qFuTam9EOqZnuY/8DBfD9renDot6nspdy9NUw+VALqW4OxsJFIW5CjPfeFRPxfiCfrXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766108552; c=relaxed/simple;
	bh=uOMfsM1CXxew8ORPCn2LfxbO7sBhu6RKPMS3iZlHigU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ/ZxFO1Lnif2nJXBBki3Sk8E5kOiVYd6Sd6Awxky8DdXmvFVR7/eZh0U4UMPg/nMYOTi5To/jOcFfZxcd3Y5QXf0thSA395OjPempk6YkEhRMJzv7VC+d53qWt4z+j+EMRy6Tgpo/A8Lqs/kwPqwdZZTXcTzyxlm8bGl3Kz64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K2SgAq6j; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766108547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5OZv2AD5ZUcIVpk5r2APPbP0OmuX04X2QRYxt7G3c0=;
	b=K2SgAq6j1Md6W7WSntMRaUd+LBcA6V3Ehq+0aYH0VhsdGhUI5CuRKBQcCEMAEdWxdVETg3
	8XtyFsVuFUYYYOdmgvtpUM/vDuG3bWNm+8XkFLXP4Ebq0hj07cWpVcNeBiui9mGZKIxdoc
	KXN5wwobr/FkdzRf+7+BEej6mHQ1nQg=
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
Subject: Re: [PATCH bpf-next v4 7/9] libbpf: add support for tracing session
Date: Fri, 19 Dec 2025 09:42:12 +0800
Message-ID: <6115584.MhkbZ0Pkbq@7940hx>
In-Reply-To:
 <CAEf4Bzb+epu=X9w1+11ZojGYL5hn6SSRNdV_pvoiH1xcdLTuJA@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <20251217095445.218428-8-dongml2@chinatelecom.cn>
 <CAEf4Bzb+epu=X9w1+11ZojGYL5hn6SSRNdV_pvoiH1xcdLTuJA@mail.gmail.com>
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
> > Add BPF_TRACE_SESSION to libbpf and bpftool.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  tools/bpf/bpftool/common.c | 1 +
> >  tools/lib/bpf/bpf.c        | 2 ++
> >  tools/lib/bpf/libbpf.c     | 3 +++
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> > index e8daf963ecef..534be6cfa2be 100644
> > --- a/tools/bpf/bpftool/common.c
> > +++ b/tools/bpf/bpftool/common.c
> > @@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_at=
tach_type t)
> >         case BPF_TRACE_FENTRY:                  return "fentry";
> >         case BPF_TRACE_FEXIT:                   return "fexit";
> >         case BPF_MODIFY_RETURN:                 return "mod_ret";
> > +       case BPF_TRACE_SESSION:                 return "fsession";
> >         case BPF_SK_REUSEPORT_SELECT:           return "sk_skb_reusepor=
t_select";
> >         case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:        return "sk_skb_=
reuseport_select_or_migrate";
> >         default:        return libbpf_bpf_attach_type_str(t);
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 21b57a629916..5042df4a5df7 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
> >         case BPF_TRACE_FENTRY:
> >         case BPF_TRACE_FEXIT:
> >         case BPF_MODIFY_RETURN:
> > +       case BPF_TRACE_SESSION:
> >         case BPF_LSM_MAC:
> >                 attr.link_create.tracing.cookie =3D OPTS_GET(opts, trac=
ing.cookie, 0);
> >                 if (!OPTS_ZEROED(opts, tracing))
> > @@ -917,6 +918,7 @@ int bpf_link_create(int prog_fd, int target_fd,
> >         case BPF_TRACE_FENTRY:
> >         case BPF_TRACE_FEXIT:
> >         case BPF_MODIFY_RETURN:
> > +       case BPF_TRACE_SESSION:
>=20
> no need, this is a legacy fallback path for programs that were (at
> some point for older kernels) attachable only through
> BPF_RAW_TRACEPOINT_OPEN. BPF_LINK_CREATE is sufficient, drop this
> line.

OK, I see.

>=20
> >                 return bpf_raw_tracepoint_open(NULL, prog_fd);
> >         default:
> >                 return libbpf_err(err);
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index c7c79014d46c..0c095195df31 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -115,6 +115,7 @@ static const char * const attach_type_name[] =3D {
> >         [BPF_TRACE_FENTRY]              =3D "trace_fentry",
> >         [BPF_TRACE_FEXIT]               =3D "trace_fexit",
> >         [BPF_MODIFY_RETURN]             =3D "modify_return",
> > +       [BPF_TRACE_SESSION]             =3D "trace_session",
>=20
> let's use fsession terminology consistently

OK, so we will use "trace_fsession" here.

Thanks!
Menglong Dong

>=20
>=20
> >         [BPF_LSM_MAC]                   =3D "lsm_mac",
> >         [BPF_LSM_CGROUP]                =3D "lsm_cgroup",
> >         [BPF_SK_LOOKUP]                 =3D "sk_lookup",
> > @@ -9853,6 +9854,8 @@ static const struct bpf_sec_def section_defs[] =
=3D {
> >         SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_=
ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC=
_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_A=
TTACH_BTF | SEC_SLEEPABLE, attach_trace),
> > +       SEC_DEF("fsession+",            TRACING, BPF_TRACE_SESSION, SEC=
_ATTACH_BTF, attach_trace),
> > +       SEC_DEF("fsession.s+",          TRACING, BPF_TRACE_SESSION, SEC=
_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_=
trace),
> >         SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BT=
=46, attach_lsm),
> >         SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BT=
=46 | SEC_SLEEPABLE, attach_lsm),
> > --
> > 2.52.0
> >
>=20





