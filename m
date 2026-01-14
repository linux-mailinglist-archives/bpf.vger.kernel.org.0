Return-Path: <bpf+bounces-78796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B1D1BEB3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69FC03027CFF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973F299AAB;
	Wed, 14 Jan 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2jGFA+F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302EA293B75
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353826; cv=none; b=B1OoSV6YKMIq28eYBhxQnqksNNnZRyT9DdRhM/UNNha1tt7LDUxmjVx604miYWx7036xwPSAdRdORoxxrBEoqWmfyx4XvT5ZC1cw0hQEhd1KOE3QY+xMx7xkMpexiLeBbx7QW0frktgsqM1OdBl+UVMRVBurku9QKV0H+k3a55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353826; c=relaxed/simple;
	bh=ijykEvQGSiIaTAZlysg8PO4CQBusHMugRnqZTrQnFN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZCIKXyBhiEholjKEbmD3P3Zq4i373KTiEEfPAM4oE30pcGIfMkzdiObVeyx7iCYmlnDCWlH/eKa674gBcScacIyR5fnePkT5fdar/CRe8bNOjbb4vcdxBbU7YWxFp665quinzZgyGvttXWYMeXMZT0GchArlybhugtilV7wJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2jGFA+F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b86f212c3b0so64474466b.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353822; x=1768958622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NlyFcwZyRpcDosThA8F5NVUJa+yBeYcQ1mCq5w9CEo=;
        b=E2jGFA+FwygLzlz2Ymyd3b4/iPYEThAJBb3gXntmFXNRsiSZVBtm1yfYIOus6Qg8FY
         Y77XplbVuq2h10F1wxEkTDliuWU59inrEygIRSN+1d8CWI2jrdE5mYAiH/tEOc+JHWsD
         ba092p9cyoa0A/gkU/yham768mmZJj7QDoAS7VoDoAbIS/vkeXKe5gEoHZO3BkEBurhc
         uxwi82zyR9PKbNt18jV7vEeRn+IVpDjFl4DnTP2ESxEE+OEYgjcsUUhT1wvjtzYhaVYG
         gWYGEgVD8Lr4qQDAI7WqdkpC1kYL7/Hw4v+alaD8bdUblRjjlwL7/Cs2dKXh3px2jTNP
         GnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353822; x=1768958622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NlyFcwZyRpcDosThA8F5NVUJa+yBeYcQ1mCq5w9CEo=;
        b=xNfxdfDnoVyqJ8UhNJX/glQF4CKlr/XWz9yZQ46jD/P42TvD7rpGSaydkXkfH3A9TQ
         NYR/11pckp9D04wmiJBEh/wmBqZgtxhCtg6nHxYoVwhixPtwOmi1oQM/u63o+GzXKTU7
         GmJa0ejEQYR4fJgc021Na8XcOmS5HB8jxJP4G3QliahxyeY7N8CdRdDZjuog0FueaPwI
         jvBSM7UKreYTPQSEQJZ2GZ7UMy21rU64GiwsC5o9E7LOmYcxUflN/Pl3CzM2SInYbqqS
         oaKoixc+RKoGWB38DSkAP1wANsuaNNvOgin7F9n+o2ccIbGYjNWCT6Aq+zIbxVHWA2xi
         asLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1LMP09ip/M5bN/GGdnH6e/5+tkaSXBIXg855a9/n8CdtXc38E/VzdBrWMUhFNIatVQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXoSWNWSZs3jsBxGGcS5qJRiKE1GLZQTOuvUpYiEKJ6IwbnJq
	/tvZ/0gGgxL/FPwCyNq93c87SOY5YlnCqoZ1D5Mi7xVVAcL+LkUNsAXWjuQPxAtEW+RSYrE2r8q
	Gcyg/j9yvq+86LUYXMoAlUjiLoxF8R+Q=
X-Gm-Gg: AY/fxX4J7/sE+vvGg2OTx/34qC51JUhn8MXKjKhF1nj6QTgUPjtHttWFkTJjktRMzcm
	kKAPnUPVtlGyYUiNjZsYlPQdAEh+lCBL8yUM5NeUuRzu/tgm1AHZRyK0rwlSDWMwMrRPQpyFmP+
	dpL7RyyzszOWlN6rkTfwRzgjF2Oaf8ceGbHvIbZXoagDb9E0Gkmt5rQkJQSgYVYC6vx6eZ8Hqt4
	/ZB9ZJEEMj7k6yIBdr0IaPvPC7jOChTWnSvU43NMm5ocBFHd+qfusSwEtxffqwXOX7ZqlExv9VY
	vyuozDKJIQg=
X-Received: by 2002:a17:907:7288:b0:b76:3472:52df with SMTP id
 a640c23a62f3a-b8761c22084mr83731566b.10.1768353822219; Tue, 13 Jan 2026
 17:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-4-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-4-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:48 -0800
X-Gm-Features: AZwV_QgyLOtjG3Jx55TRrPtsosRVCNp0IhR4LULmLvQwemr6cEdA33RlbTpC_bk
Message-ID: <CAEf4BzYid4WaAkNLBegeN5FLiLTjZ1scToA-Sdpz3tqL6iE=Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
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
> Add the function argument of "void *ctx" to bpf_session_cookie() and
> bpf_session_is_return(), which is a preparation of the next patch.
>
> The two kfunc is seldom used now, so it will not introduce much effect
> to change their function prototype.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/bpf_trace.c                             |  4 ++--
>  tools/testing/selftests/bpf/bpf_kfuncs.h             |  4 ++--
>  .../bpf/progs/kprobe_multi_session_cookie.c          | 12 ++++++------
>  .../selftests/bpf/progs/uprobe_multi_session.c       |  4 ++--
>  .../bpf/progs/uprobe_multi_session_cookie.c          | 12 ++++++------
>  .../bpf/progs/uprobe_multi_session_recursive.c       |  8 ++++----
>  6 files changed, 22 insertions(+), 22 deletions(-)
>

LGTM, let's do it

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 5f621f0403f8..297dcafb2c55 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run=
_ctx *ctx)
>
>  __bpf_kfunc_start_defs();
>
> -__bpf_kfunc bool bpf_session_is_return(void)
> +__bpf_kfunc bool bpf_session_is_return(void *ctx)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> @@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
>         return session_ctx->is_return;
>  }
>
> -__bpf_kfunc __u64 *bpf_session_cookie(void)
> +__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index e0189254bb6e..dc495cb4c22e 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -79,8 +79,8 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
>                                       struct bpf_dynptr *sig_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
>
> -extern bool bpf_session_is_return(void) __ksym __weak;
> -extern __u64 *bpf_session_cookie(void) __ksym __weak;
> +extern bool bpf_session_is_return(void *ctx) __ksym __weak;
> +extern __u64 *bpf_session_cookie(void *ctx) __ksym __weak;
>

(and actually drop these, vmlinux.h will have them)

>  struct dentry;
>  /* Description

[...]

