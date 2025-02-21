Return-Path: <bpf+bounces-52223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE865A40394
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 00:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0586519C1429
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835820B21F;
	Fri, 21 Feb 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBbi6trk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B218DB0B;
	Fri, 21 Feb 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181233; cv=none; b=ff4ntypMVrY28FZ2gl1ugJNG1Cnp2C5eNqeqEiKXHODWWyesJ2f8lqOQRP7QaW2WQ7xZLEo3YpUYDBWASmpTfcqbXhWX8x2GXMeYmhiV7TncYBKzZ8qRx8T++spCeB8JPw0B18ldrN+B5N/brdXUz+pH7As1MCRBXbmwPzkNs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181233; c=relaxed/simple;
	bh=ZWn8yYSn8uQ8UCfwtAVNWvLesEqQcvP6HMF1xDer8kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHoEGTtBk5Bva+TLKcxfrOKAOgPeApTzLX2wor/fhwHrNARiNVHz6LZSQ5EdgjibBWgvosq5/Q+zCuRZnhjOBzHFf7wS5oJTkQLWG26iiE6B4HCNdmxpavWM0GRVUFDFJHUwh8y4cJcObh5pfVdArYPEiGrZx0bU5WV9RSu499M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBbi6trk; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dad00b2e6so2411675276.3;
        Fri, 21 Feb 2025 15:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740181231; x=1740786031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uFQuVa/FJCk6wKcXBfJoG6v5LmVIIjERgdYjCcMM0=;
        b=WBbi6trkRmLejVujvwfhbUDUKFr9mmKoS1zZLA8xyh3tx6yUQ1AXKSdj6wk5rwxIvd
         ubmPR2XKsOXdeFZVl4fXgg1V2Bk10KmQpza1kZgBqDvw3PgifMsFvLj47RXlya6rPU2C
         7j3k2DyyBAjPc1OMjd5gXtPxyTF/nYlYpnmfMZ6clFauvq5Sv5dN90C00vb2r+p1y/AL
         TopK4zDpJMMSx5UuuXwPYIriRGpkd3NcodHVXC4jDFB0TcMXwnXSZhJDcbrQmejKmGRX
         f1pdx0iJc8Sa3Fl45gOlgt6rLAzJbkAnfYf1bX5M9U0T+nZm9NGhrAs9f/6zNXF+fM+w
         u4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740181231; x=1740786031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0uFQuVa/FJCk6wKcXBfJoG6v5LmVIIjERgdYjCcMM0=;
        b=Qg4kkIsfmz8efOncvymNkXAQfjwFW0toYGPQl/TC/RxI7zFX/oO/byWWlzjLozCAlb
         s+nl+qDDcj7UnS2IvmzGvQuQAJgVxCGWn9GqX511sIT4ck5uLLHUo1R/sbJTECNTeKQO
         39znSas2yVWMzokPAGaxq1nfXtAXVfLTGFDTOMC9lPzak07JhPkpbNmRyMp6NTd3tgKS
         YL+7D+y6MrB1CdaT27XI5XIuJCtbA2nmOtZJ81hBHdwf4Jbk2Ja+aocmDGlYu0rNaE+N
         I5jrqO5Sb+rvZfN6113bZA79iRbTVn2yafAL4t50HBLpl7+qZ/6kq2TxhVzOKGs2Sgq/
         ojoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqd7GTHI5X1/9zzmgx0VjyI4SKwkqnnsB97r4VWxeVMUFIKNTQRMY8wRDt1+wyoJdN88wYr2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDs7ImC/BnLOdTKEqQ1A5UpgaO5BPKBcZZPT0UAe7Y5cqKRT5W
	BwjIWsELfgWmSuFd9N4Pzt7ftKH2esyzZnV/P1JqtrNTZGRRl6Ugb2yrUHSeh70Vmg3lU5UyybA
	InJhuj8KpyEOkJJexLWDK7lRdDZGRQjew
X-Gm-Gg: ASbGncsybkXka14eCV5XWew0PvBm5DIn31duxCj7XFdH+QVIRrEap4zNvNFWXRpROvu
	j606AjUckoOSLHMbSP2JSpj5iRgYdQyLV0Vu/4XMS5ABk+riTI3/joBg+2gxP9t3+6IabA5qw1c
	/yGHbEwRE=
X-Google-Smtp-Source: AGHT+IGxwkKGp7734gFQO04pUvI45oaeWxVNjU8kaAIwv4PoZexZ/GbiN8VfRp4aUkMLeeEHuVg6YZhl0tvgwerTN48=
X-Received: by 2002:a05:6902:1086:b0:e5d:c0db:b3de with SMTP id
 3f1490d57ef6-e5e2467a803mr4627440276.34.1740181230695; Fri, 21 Feb 2025
 15:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <20250220134503.835224-3-maciej.fijalkowski@intel.com> <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
 <Z7iUMK1XePvptYc5@boxer> <CAMB2axNJjsytoFrYF=PdsOOWE-bbficZa-54C9YHT5JFu5PFBQ@mail.gmail.com>
 <Z7jfXXQ06MrlallF@boxer>
In-Reply-To: <Z7jfXXQ06MrlallF@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 21 Feb 2025 15:40:19 -0800
X-Gm-Features: AWEUYZksvBSvS1N6L0RDkQvOuWoFxsCkeFLaQzDRz4FQm_SloMWNrP-pDR71dsg
Message-ID: <CAMB2axPtxo+egJs_=SG0LMKdJ1DGyUVhSeGDUY2SDR8syAdeRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:17=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Feb 21, 2025 at 11:11:27AM -0800, Amery Hung wrote:
> > On Fri, Feb 21, 2025 at 6:57=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 03:25:03PM -0800, Amery Hung wrote:
> > > >
> > > >
> > > > On 2/20/2025 5:45 AM, Maciej Fijalkowski wrote:
> > > > > These have been mostly taken from Amery Hung's work related to bp=
f qdisc
> > > > > implementation. bpf_skb_{acquire,release}() are for increment/dec=
rement
> > > > > sk_buff::users whereas bpf_skb_destroy() is called for map entrie=
s that
> > > > > have not been released and map is being wiped out from system.
> > > > >
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > >   net/core/filter.c | 62 ++++++++++++++++++++++++++++++++++++++++=
+++++++
> > > > >   1 file changed, 62 insertions(+)
> > > > >
> > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > index 2ec162dd83c4..9bd2701be088 100644
> > > > > --- a/net/core/filter.c
> > > > > +++ b/net/core/filter.c
> > > > > @@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(=
struct __sk_buff *s, struct sock *sk,
> > > > >   __bpf_kfunc_end_defs();
> > > > > +__diag_push();
> > > > > +__diag_ignore_all("-Wmissing-prototypes",
> > > > > +             "Global functions as their definitions will be in v=
mlinux BTF");
> > > > > +
> > > > > +/* bpf_skb_acquire - Acquire a reference to an skb. An skb acqui=
red by this
> > > > > + * kfunc which is not stored in a map as a kptr, must be release=
d by calling
> > > > > + * bpf_skb_release().
> > > > > + * @skb: The skb on which a reference is being acquired.
> > > > > + */
> > > > > +__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
> > > > > +{
> > > > > +   if (refcount_inc_not_zero(&skb->users))
> > > > > +           return skb;
> > > > > +   return NULL;
> > > > > +}
> > > > > +
> > > > > +/* bpf_skb_release - Release the reference acquired on an skb.
> > > > > + * @skb: The skb on which a reference is being released.
> > > > > + */
> > > > > +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> > > > > +{
> > > > > +   skb_unref(skb);
> > > > > +}
> > > > > +
> > > > > +/* bpf_skb_destroy - Release an skb reference acquired and excha=
nged into
> > > > > + * an allocated object or a map.
> > > > > + * @skb: The skb on which a reference is being released.
> > > > > + */
> > > > > +__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
> > > > > +{
> > > > > +   (void)skb_unref(skb);
> > > > > +   consume_skb(skb);
> > > > > +}
> > > > > +
> > > > > +__diag_pop();
> > > > > +
> > > > > +BTF_KFUNCS_START(skb_kfunc_btf_ids)
> > > > > +BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
> > > > > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > > > > +BTF_KFUNCS_END(skb_kfunc_btf_ids)
> > > > > +
> > > > > +static const struct btf_kfunc_id_set skb_kfunc_set =3D {
> > > > > +   .owner =3D THIS_MODULE,
> > > > > +   .set   =3D &skb_kfunc_btf_ids,
> > > > > +};
> > > > > +
> > > > > +BTF_ID_LIST(skb_kfunc_dtor_ids)
> > > > > +BTF_ID(struct, sk_buff)
> > > > > +BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
> > > > > +
> > > > >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags=
,
> > > > >                            struct bpf_dynptr *ptr__uninit)
> > > > >   {
> > > > > @@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf=
_kfunc_set_tcp_reqsk =3D {
> > > > >   static int __init bpf_kfunc_init(void)
> > > > >   {
> > > > > +   const struct btf_id_dtor_kfunc skb_kfunc_dtors[] =3D {
> > > > > +           {
> > > > > +                   .btf_id       =3D skb_kfunc_dtor_ids[0],
> > > > > +                   .kfunc_btf_id =3D skb_kfunc_dtor_ids[1]
> > > > > +           },
> > > > > +   };
> > > > > +
> > > > >     int ret;
> > > > >     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &b=
pf_kfunc_set_skb);
> > > > > @@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
> > > > >     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &=
bpf_kfunc_set_xdp);
> > > > >     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP=
_SOCK_ADDR,
> > > > >                                            &bpf_kfunc_set_sock_ad=
dr);
> > > > > +   ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_=
CLS, &skb_kfunc_set);
> > > > > +
> > > > > +   ret =3D ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > > > > +                                            ARRAY_SIZE(skb_kfunc=
_dtors),
> > > > > +                                            THIS_MODULE);
> > > >
> > > > I think we will need to deal with two versions of skb dtors here. B=
oth qdisc
> > > > and cls will register dtor associated for skb. The qdisc one just c=
all
> > > > kfree_skb(). While only one can exist for a specific btf id in the =
kernel if
> > > > I understand correctly. Is it possible to have one that work
> > > > for both use cases?
> > >
> > > Looking at the current code it seems bpf_find_btf_id() (which
> > > btf_parse_kptr() calls) will go through modules and return the first =
match
> > > against sk_buff btf but that's currently a wild guess from my side. S=
o
> > > your concern stands as we have no mechanism that would distinguish th=
e
> > > dtors for same btf id.
> > >
> > > I would have to take a deeper look at btf_parse_kptr() and find some =
way
> > > to associate dtor with its module during registering and then use it
> > > within btf_find_dtor_kfunc(). Would this be sufficient?
> > >
> >
> > That might not be enough. Ultimately, if the user configures both
> > modules to be built-in, then there is no way to tell where a trusted
> > skb kptr in a bpf program is from.
>
> Am I missing something or how are you going to use the kfuncs that are
> required for loading skb onto map as kptr without loaded module? Dtors ar=
e
> owned by same module as corresponding acquire/release kfuncs.
>

bpf qdisc will be either built-in (CONFIG_NET_SCH_BPF=3Dy) or not
enabled (=3Dn). classifier can be either y or m.

Dtors are associated with (btf, btf_id). So in case both are built in,
only one of them should be registered to (btf_vmlinux, struct skb).
The current implementation does not check if a dtor of a btf id is
already registered in register_btf_id_dtor_kfunc, but I don't think we
should do it in the first place.
}



> >
> > Two possible ways to solve this:
> >
> > 1. Make the dtor be able to tell whether the skb is from qdisc or cls.
> > Since we are both in the TC layer, maybe we can use skb->cb for this?
> >
> > 2. Associate KF_ACQUIRE kfuncs with the corresponding KF_RELEASE
> > kfuncs somehow. Carry this additional information as the kptr
> > propagates in the bpf world so that we know which dtor to call. This
> > seems to be overly complicated.
> >
> >
> > > >
> > > > >     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_C=
LS, &bpf_kfunc_set_tcp_reqsk);
> > > > >   }
> > > > >   late_initcall(bpf_kfunc_init);
> > > >

