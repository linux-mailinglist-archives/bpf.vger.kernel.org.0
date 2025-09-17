Return-Path: <bpf+bounces-68681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD29B8128C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373BD1C25219
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73492FC86C;
	Wed, 17 Sep 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE6gZzxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF782F7AA8
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129834; cv=none; b=uDOWrxJlOy8c0yDElTD268qJVPtthORJVd97TG4I7KrEG2FmlAvjNU1ab4awyZfRbTkl2K3H841S4eE8KtMUK8pii8Mu5OKUeb2d3uRqYyvCbVDrfAIAwWy2tdoDDO69uOEjQ7PUGXICl+eWCsRtaHrZvapeiI6L4OVZ2Lo+PKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129834; c=relaxed/simple;
	bh=TZUbd2GLfy1MRkJqa1uqSqOmuAo8UwOs+RmqhyiAsEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXk83++vhKfc+wJ3q+tLAOdu8iFn14wumoocTE1XIfD6oGQnnhT1uj9cusnFuZZrDwfGa5aVwTJvtnAV/71UTVZ+JKmg1RUKEV57zQf2Ux5kUUb8OzR4r9/3WUQBP/YLDg+O3cy6GpoADD8feEvzTrxYS04OHgS2CJfvJ9AcLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE6gZzxz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d601859f5so929247b3.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758129832; x=1758734632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3DO+dRyUaKvk/Ean/5aYwmfLKnd1LbE8meMekDjjic=;
        b=TE6gZzxzoAuFZXTYGn5H3TGXJJSCmlwenzr2g7sm7RrdkMfC3NNxulFsxBNoDipn+S
         YyhOUMulqZeLejU5602LzMGfwCCM8rmYVFEfikfrKWGDRXBTZyJNtfY89f+bGUmyfc3q
         NAjYlOr5IyDQTVt8lZwo6380C3YN0jlSto+ZzNI/c+GNBgE90+oeuCgL2YzA/Dgup65B
         K6+96CY9HksqVc25sgE+YfaC4Yv4yK4NRVA1+j5JGbhG45B3Pix2galN7pnUtQyy+BnK
         VDFW3JPf3od67KYwdQC2FJ2QOw0LWgy7CrIYnnQaWbVoaOAM0tNuOdNUcNre+9QbdtPi
         BdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129832; x=1758734632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3DO+dRyUaKvk/Ean/5aYwmfLKnd1LbE8meMekDjjic=;
        b=R6cHdFTknsDUcbAsPyjBzA4USkNjZmKty5Zlg6yFD5S4TT9NDANDszSftcaO3yX6OA
         yxq95jNnltZFRBg28CKaO2obxlsOwM6OzQniG8Ude9nJFdPZ5y23tDeyrLkwwAIBlRk/
         I+ImD9Fihpl0cbn+zo5znp9F8UNXt0sLTRd4RvdLjPbPxo/Ob8t3qN/04K5K6lgsiyZT
         3JZ1zlm3YxZvpJe7GQyD9Ym9s90UQtynBZ5nGGlC90KBX5dDMQB0uWevLTYT4scK5DBw
         jKh4FMXaJkfKs3cEBofUFv5FPRz2cKaPN4eu8XZDZMG4xYdzyEtS35ZLFDgRmlo5BQLY
         fSaQ==
X-Gm-Message-State: AOJu0YzqF2ka+PK8E39bEpeu7y/Ri7avomIR4/si34vaYwzuAy/9gMzJ
	sBqB0jm4JSAA7RnPw+xKMtSTaTbDiuWsIEEKOgBGcpFGJgJUNeG2J8SFMlry07VG1vO06iTxXWb
	Hp+Nx93wQYzWrvumb+P+uHYGYtny1fvA=
X-Gm-Gg: ASbGnctN81rg2DuGwEuOAFsN3TMpT0T5IhjDX8GLeh7loqhbak9lWf2J2Jbct1QyrG/
	LcgM2VRlMSBuQM2Vsd7f6A3CFCyKRcfDx70uHg5OxKF1TjdMRrWn5Fry80RrrIt6qM/M93KRglR
	2309/Za6xD7qh+ISGO+B9yT9cPPiVaM7nhb9WumK2+/3F1/xN2EvUR+nextAsI+mHGP8z7GR7Kg
	aGbhmIHIAy/As7BQhzWJkQ=
X-Google-Smtp-Source: AGHT+IGkWdVWEgNNWEXOlIdY00KRDH1oZ7EWZVb+0n5e99zDGBZRSGsYBYGDRHQL8iDGsVSNKTbDA5a/DR3q3lyd1Rs=
X-Received: by 2002:a05:690c:4991:b0:72c:139c:24fa with SMTP id
 00721157ae682-73892659a83mr23746317b3.52.1758129831375; Wed, 17 Sep 2025
 10:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915224801.2961360-1-ameryhung@gmail.com> <20250915224801.2961360-5-ameryhung@gmail.com>
 <bc297803-68e6-4f59-a32d-490398b8e590@linux.dev>
In-Reply-To: <bc297803-68e6-4f59-a32d-490398b8e590@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 17 Sep 2025 10:23:40 -0700
X-Gm-Features: AS18NWA4M21sdZhYBO_RtkwB2Gg37crKxhyeqsBqYKRLCZsFSHDXVgAqSq7uSPE
Message-ID: <CAMB2axMmHzDjpe40Xr64m1iEc=RRTJgQ+O4YQu9krqEYtskxFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:59=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/15/25 3:47 PM, Amery Hung wrote:
> > To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
> > as free linear data area after xdp->data_end needs to be created.
> > However, bpf_prog_test_run_xdp() always fills the linear area with
> > data_in before creating fragments, leaving no space to pull data. This
> > patch will allow users to specify the linear data size through
> > ctx->data_end.
> >
> > Currently, ctx_in->data_end must match data_size_in and will not be the
> > final ctx->data_end seen by xdp programs. This is because ctx->data_end
> > is populated according to the xdp_buff passed to test_run. The linear
> > data area available in an xdp_buff, max_data_sz, is alawys filled up
> > before copying data_in into fragments.
> >
> > This patch will allow users to specify the size of data that goes into
> > the linear area. When ctx_in->data_end is different from data_size_in,
> > only ctx_in->data_end bytes of data will be put into the linear area wh=
en
> > creating the xdp_buff.
> >
> > While ctx_in->data_end will be allowed to be different from data_size_i=
n,
> > it cannot be larger than the data_size_in as there will be no data to
> > copy from user space. If it is larger than the maximum linear data area
> > size, the layout suggested by the user will not be honored. Data beyond
> > max_data_sz bytes will still be copied into fragments.
> >
> > Finally, since it is possible for a NIC to produce a xdp_buff with empt=
y
> > linear data area, allow it when calling bpf_test_init() from
> > bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
> > xdp_buff.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   net/bpf/test_run.c                            | 26 ++++++++++++------=
-
> >   .../bpf/prog_tests/xdp_context_test_run.c     |  4 +--
> >   2 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 4a862d605386..558126bbd180 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -660,12 +660,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, K=
F_RELEASE)
> >   BTF_KFUNCS_END(test_sk_check_kfunc_ids)
> >
> >   static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size=
,
> > -                        u32 size, u32 headroom, u32 tailroom)
> > +                        u32 size, u32 headroom, u32 tailroom, bool is_=
xdp)
>
> Understood that the patch has inherited this function. I found it hard to=
 read
> when it is called by xdp but this could be just me. For example, what is =
passed
> as "size" from the bpf_prog_test_run_xdp(), which ends up being "PAGE_SIZ=
E -
> headroom - tailroom". I am not sure how to fix it. e.g. can we always all=
ocate a
> PAGE_SIZE for non xdp callers also. or may be the xdp should not reuse th=
is
> function. This probably is a fruit of thoughts for later. Not asking to c=
onsider
> it in this set.
>
> I think at least the first step is to avoid adding "is_xdp" specific logi=
c here.
>
> >   {
> >       void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
> >       void *data;
> >
> > -     if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - ta=
ilroom)
> > +     if (!is_xdp && user_size < ETH_HLEN)
>
> Move the lower bound check to its caller. test_run_xdp() does not need th=
is
> check. test_run_flow_dissector() and test_run_nf() already have its own c=
heck.
> test_run_nf() actually has a different bound. test_run_skb() is the only =
one
> that needs this check, so it can be explicitly done in there like other c=
allers.
>

Yeah, is _xdp is bad. I will move lower bound checks to callers.
Thanks for pointing this out.

> > +             return ERR_PTR(-EINVAL);
> > +
> > +     if (user_size > PAGE_SIZE - headroom - tailroom)
> >               return ERR_PTR(-EINVAL);
> >
> >       size =3D SKB_DATA_ALIGN(size);
> > @@ -1003,7 +1006,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> >
> >       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> >                            size, NET_SKB_PAD + NET_IP_ALIGN,
> > -                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> > +                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)),
> > +                          false);
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
> >
> > @@ -1207,8 +1211,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> >   {
> >       bool do_live =3D (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES)=
;
> >       u32 tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +     u32 retval =3D 0, duration, max_data_sz, data_sz;
> >       u32 batch_size =3D kattr->test.batch_size;
> > -     u32 retval =3D 0, duration, max_data_sz;
> >       u32 size =3D kattr->test.data_size_in;
> >       u32 headroom =3D XDP_PACKET_HEADROOM;
> >       u32 repeat =3D kattr->test.repeat;
> > @@ -1246,7 +1250,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> >
> >       if (ctx) {
> >               /* There can't be user provided data before the meta data=
 */
> > -             if (ctx->data_meta || ctx->data_end !=3D size ||
> > +             if (ctx->data_meta || ctx->data_end > size ||
> >                   ctx->data > ctx->data_end ||
> >                   unlikely(xdp_metalen_invalid(ctx->data)) ||
> >                   (do_live && (kattr->test.data_out || kattr->test.ctx_=
out)))
> > @@ -1256,14 +1260,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >       }
> >
> >       max_data_sz =3D PAGE_SIZE - headroom - tailroom;
> > -     if (size > max_data_sz) {
> > +     data_sz =3D (ctx && ctx->data_end < max_data_sz) ? ctx->data_end =
: max_data_sz;
>
> hmm... can the "size" (not data_sz) be directly updated to ctx->data_end =
in the
> above "if (ctx)".
>

That simplifies things a lot. Will change in the next version.

> > +     if (size > data_sz) {
> >               /* disallow live data mode for jumbo frames */
> >               if (do_live)
> >                       goto free_ctx;
> > -             size =3D max_data_sz;
> > +             size =3D data_sz;
> >       }
> >
> > -     data =3D bpf_test_init(kattr, size, max_data_sz, headroom, tailro=
om);
> > +     data =3D bpf_test_init(kattr, size, max_data_sz, headroom, tailro=
om, true);
> >       if (IS_ERR(data)) {
> >               ret =3D PTR_ERR(data);
> >               goto free_ctx;
> > @@ -1386,7 +1391,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_p=
rog *prog,
> >       if (size < ETH_HLEN)
> >               return -EINVAL;
> >
> > -     data =3D bpf_test_init(kattr, kattr->test.data_size_in, size, 0, =
0);
> > +     data =3D bpf_test_init(kattr, kattr->test.data_size_in, size, 0, =
0, false);
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
> >
> > @@ -1659,7 +1664,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
> >
> >       data =3D bpf_test_init(kattr, kattr->test.data_size_in, size,
> >                            NET_SKB_PAD + NET_IP_ALIGN,
> > -                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> > +                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)),
> > +                          false);
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_ru=
n.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > index 46e0730174ed..178292d1251a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > @@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
> >       /* Meta data must be 255 bytes or smaller */
> >       test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0,=
 0);
> >
> > -     /* Total size of data must match data_end - data_meta */
> > -     test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
> > -                            sizeof(data) - 1, 0, 0, 0);
> > +     /* Total size of data must be data_end - data_meta or larger */
> >       test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
> >                              sizeof(data) + 1, 0, 0, 0);
> >
>

