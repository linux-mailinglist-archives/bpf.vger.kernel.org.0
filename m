Return-Path: <bpf+bounces-78799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB8D1BE9E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CF7930124F8
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE329D27A;
	Wed, 14 Jan 2026 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHMAygz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CC2882A7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353862; cv=none; b=To04UOU+nV9rSgo7eIqhxGiOkk9ZOTPNxeKJTktO73VWGNbWNBikPYqH5mUlSxwDTPqp6sy5j8X3WrErdB3P9wtXhP18wqp8drXWvVhzbjVQRy7ZpEiiDxAlmA6jLRHH6Fsf9gFXmAJcux0AuN32jhbWwEJF9z06DzPaXgpMIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353862; c=relaxed/simple;
	bh=UHiLLPDUZNq2lC0Rbu5/55HLeeScZbrXZAnjwFwZ3JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8N3+GLUAR37/Ivsgml75ccInyLa67mjga8TU5idH1DoCSfjpDDDVu2TYWG/ZYmtDgJSQ43qH/YWmyoxMDDdu56hWRtcf8/zyoEjHoIfAx9bCDJoxLPKXXkQoom/huFm3/eulAHgTJOQfS/CcodJ1j0oHRyXDobptmcVls9pMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHMAygz2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so5898875a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353861; x=1768958661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDh3jptvWDHN1dEQL100hfQnO7IRwR8uvxexcBE/o70=;
        b=bHMAygz2nn9mpvhz4d7Eq0dEo+Cm8AWE9JjQnRlHEE2VbO8z0viK51hlIpJ41XhDkb
         76F6GgNpe3g6s6KBHFJDVf/wAtUEnNITAe6Artf+6pL/vlrgtU4Kbl7+DlPOgqe6ckKU
         r4FudASqzl7fxkOaL37N1tcSUSFV921dV8quaZP/GmV3CXTkpovkeUaTvotZ+jHiZvai
         zXTkyn3q4BEY1RjVX8crd2HKNQjOfsc6G4O+rPZs/3ge7WfUaOpGQdi5NmJqX9HYLnFE
         uOfIUFtfVmJAD1hqMsXACTK5YAyz1sHFWoF16od97tjqIAupUO56c6qCTA+if52ZYpQl
         NDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353861; x=1768958661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDh3jptvWDHN1dEQL100hfQnO7IRwR8uvxexcBE/o70=;
        b=QCQ5Du8WvhiIu/uBGMj2GLZQmgU/3Q8ehKlra2nqjJHQKLHqkmBhMyWgX6NrPpcJVQ
         ZV0LYrug+KalWLhIxFZIkmgCiR8J8Nwnbfa1uzx+YrxavDJM12ZcnzwfNPTabeBb//3q
         uypCelAaVpYkbpF4f0cojSmbHdW2yUghmxgVQyLl92+gnI0pTNYLwmFdS+De+0Dn6J9C
         F24seq/ZxGa2qgABK31yEJhS2RWSj7yuw41243SKT8tdiSvMfMOgSf2nZedBDIpKuwLg
         c23SHDClQGKp2XxG3oVEwdP5uP7Ta864v/3hx6FA5HebK2sm96WZTpZ2RDpz+2RdCRyu
         Mr8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6K58dIx37AzofD3IfOSjglejGZU1Ifs3Nfei+daw6EFW8ArwppSxfwBCGpTN+3wfqU9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1MB8j7GWP++HdAFgEC1GfULCFzNOgSxTOnpyqZNc7csimCKd
	Blcnqp7mFol/M93wi7CRMGbj0/7z784FAZloYj7OLSTLhkcg9EF/GHVJEdNGAdY1zs4WNsmluly
	Mb2QoOXTwwsqDRcSvJfaNnCKbz64LJkE=
X-Gm-Gg: AY/fxX4eIFyJXi6wvDtdDmzzSwt7Zk8eUBY6PDphhdecIt8wNORidXGe/SQDM5ETL1L
	YyDj0QqL/lqo0qTFzsFDWpPcouy6mNP1Q/Y3FX923A91xZShpZu/6PwdnNe00IafToKExvgfkZz
	zIrEbgj5J+vTWBZwBlDQfMSf7lRK4xshPstsQCy06y4r3bT1fD4Lu7SxA7z9TUcrGuMFw+BCfnv
	JmsbamFj47NmYu0aQH1keG6yWs1w/F45jVDNFs9o8ktYyldsaMhcO48WL83Y6iPsMScVHKMH5uP
	zKTbXX+n5uhJ2ReQGuAIoA==
X-Received: by 2002:a17:90b:57ed:b0:34c:253d:581d with SMTP id
 98e67ed59e1d1-351090b10fbmr963817a91.9.1768353860572; Tue, 13 Jan 2026
 17:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-6-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-6-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:58 -0800
X-Gm-Features: AZwV_QiWtwIX9SBSwYwesrM_vSOn6iW_s2J2Lu-xPs0I6--wXfm92DAtztvio8M
Message-ID: <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Implement session cookie for fsession. In order to limit the stack usage,
> we make 4 as the maximum of the cookie count.

This 4 is so random, tbh. Do we need to artificially limit it? Even if
all BPF_MAX_TRAMP_LINKS =3D 38 where using session cookies, it would be
304 bytes. Not insignificant, but also not world-ending and IMO so
unlikely that I wouldn't add extra limits at all.

>
> The offset of the current cookie is stored in the
> "(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
> session cookie with ctx[-offset].


ctx here is assumed u64 *, right? So offset is in 8-byte units? Can
you clarify please?

>
> The stack will look like this:
>
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ip (optional) -> 8 bytes
>   cookie2       -> 8 bytes
>   cookie1       -> 8 bytes
>
> Implement and inline the bpf_session_cookie() for the fsession in the
> verifier.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v9:
> - remove the definition of bpf_fsession_cookie()
>
> v7:
> - reuse bpf_session_cookie() instead of introduce new kfunc
>
> v5:
> - remove "cookie_cnt" in struct bpf_trampoline
>
> v4:
> - limit the maximum of the cookie count to 4
> - store the session cookies before nr_regs in stack
> ---
>  include/linux/bpf.h     | 15 +++++++++++++++
>  kernel/bpf/trampoline.c | 13 +++++++++++--
>  kernel/bpf/verifier.c   | 22 +++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2640ec2157e1..a416050e0dd2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1231,6 +1231,7 @@ enum {
>
>  #define BPF_TRAMP_M_NR_ARGS    0
>  #define BPF_TRAMP_M_IS_RETURN  8
> +#define BPF_TRAMP_M_COOKIE     9

this is not wrong, but certainly weird. Why not make IS_RETURN to be
the upper bit (63) and keep cookie as a proper second byte?


(also I think all these should drop _M and have _SHIFT suffix)


>
>  struct bpf_tramp_links {
>         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> @@ -1783,6 +1784,7 @@ struct bpf_prog {
>                                 enforce_expected_attach_type:1, /* Enforc=
e expected_attach_type checking at attach time */
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
> +                               call_session_cookie:1, /* Do we call bpf_=
session_cookie() */
>                                 tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
>                                 sleepable:1;    /* BPF program is sleepab=
le */
>         enum bpf_prog_type      type;           /* Type of BPF program */
> @@ -2191,6 +2193,19 @@ static inline int bpf_fsession_cnt(struct bpf_tram=
p_links *links)
>         return cnt;
>  }
>
> +static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
> +{
> +       struct bpf_tramp_links fentries =3D links[BPF_TRAMP_FENTRY];
> +       int cnt =3D 0;
> +
> +       for (int i =3D 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
> +               if (fentries.links[i]->link.prog->call_session_cookie)
> +                       cnt++;
> +       }
> +
> +       return cnt;
> +}
> +
>  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
>                                const struct bpf_ctx_arg_aux *info, u32 cn=
t);
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 11e043049d68..29b4e00d860c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -592,6 +592,8 @@ static int bpf_freplace_check_tgt_prog(struct bpf_pro=
g *tgt_prog)
>         return 0;
>  }
>
> +#define BPF_TRAMP_MAX_COOKIES 4
> +
>  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>                                       struct bpf_trampoline *tr,
>                                       struct bpf_prog *tgt_prog)
> @@ -600,7 +602,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tram=
p_link *link,
>         struct bpf_tramp_link *link_exiting;
>         struct bpf_fsession_link *fslink;
>         struct hlist_head *prog_list;
> -       int err =3D 0;
> +       int err =3D 0, cookie_cnt =3D 0;
>         int cnt =3D 0, i;
>
>         kind =3D bpf_attach_type_to_tramp(link->link.prog);
> @@ -637,11 +639,18 @@ static int __bpf_trampoline_link_prog(struct bpf_tr=
amp_link *link,
>                 /* prog already linked */
>                 return -EBUSY;
>         hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
> -               if (link_exiting->link.prog !=3D link->link.prog)
> +               if (link_exiting->link.prog !=3D link->link.prog) {
> +                       if (kind =3D=3D BPF_TRAMP_FSESSION &&
> +                           link_exiting->link.prog->call_session_cookie)
> +                               cookie_cnt++;
>                         continue;
> +               }
>                 /* prog already linked */
>                 return -EBUSY;
>         }
> +       if (link->link.prog->call_session_cookie &&
> +           cookie_cnt >=3D BPF_TRAMP_MAX_COOKIES)
> +               return -E2BIG;
>
>         hlist_add_head(&link->tramp_hlist, prog_list);
>         if (kind =3D=3D BPF_TRAMP_FSESSION) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b0292a03186..b91fd8af2393 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12508,7 +12508,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>         bool arg_mem_size =3D false;
>
>         if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_c=
tx] ||
> -           meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_is_ret=
urn])
> +           meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_is_ret=
urn] ||
> +           meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie=
])
>                 return KF_ARG_PTR_TO_CTX;
>
>         if (argno + 1 < nargs &&
> @@ -14294,6 +14295,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         return err;
>         }
>
> +       if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie]=
)
> +               env->prog->call_session_cookie =3D true;
> +
>         return 0;
>  }
>
> @@ -22571,6 +22575,22 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 insn_buf[1] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRA=
MP_M_IS_RETURN);
>                 insn_buf[2] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
>                 *cnt =3D 3;
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_session=
_cookie] &&
> +                  env->prog->expected_attach_type =3D=3D BPF_TRACE_FSESS=
ION) {
> +               /* inline bpf_session_cookie() for fsession:
> +                *   __u64 *bpf_session_cookie(void *ctx)
> +                *   {
> +                *       u64 off =3D (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COO=
KIE) & 0xFF;
> +                *       return &((u64 *)ctx)[-off];
> +                *   }
> +                */
> +               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,=
 -8);
> +               insn_buf[1] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRA=
MP_M_COOKIE);
> +               insn_buf[2] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> +               insn_buf[3] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +               insn_buf[4] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG=
_1);
> +               insn_buf[5] =3D BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
> +               *cnt =3D 6;
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.52.0
>

