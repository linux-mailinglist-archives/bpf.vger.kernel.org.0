Return-Path: <bpf+bounces-37753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1159695A450
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7421F22BF7
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECD1B3B29;
	Wed, 21 Aug 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULuxs7d3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6D1B2EF0;
	Wed, 21 Aug 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263341; cv=none; b=KQllrymL1DcDnc3lS7v5e0hNrkOk62w+IBs4SGkZJOpJBHOr3TC8nHer6h99PJY4RM3AuUD4DgFBd1yAVnD7a8iscztlxDbaBR6OtJkPlm8qXhZQd1UGiWEUVIFWNlwX3eMtOgslL7vyZasSu2IwFR5D8m2/NLNGn5gBDLW79Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263341; c=relaxed/simple;
	bh=b+mYeFiVZHbVG8ssmWhsOdlhBdLi1hOPl4SC6cw/oBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmHYZoW5jzS9wvoOldL+fW5UyHNKyGBTJxqSziTAq73clvpVhcm0IDUPmWpAC+Ow2u89QEGd0i/Op89bOLJKcJJ8wcXC2JR1FLbsqYqJNPG2xq6nSb5MhVmD+z6lYnhvxraO04zjVNYpCbxojLsOAllTp3UmK6BVCBlXndhvWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULuxs7d3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso56096305e9.0;
        Wed, 21 Aug 2024 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263338; x=1724868138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+WA3ONqKSKn0c11QXINszItxJ2m3gC1pQyHe2RXITo=;
        b=ULuxs7d3aDd4ikN70VgE/l2YZHpE6wMcbFBCTTf2uWT4mqrY9giRHg8MS0/81BLzSg
         auRHCL16oh3CwhwtHMif4+1l5kTirf3sHTrwOz2gONef1UMOZv/D4z3qUn3hi6YVlJV5
         SRxjnWAJZYK/QarUNnLPGuyrlBF3m5QAueqzrsX8sa5qOoAWavskNpPK4Kmnbuyug4n1
         KC3N8z3QU4u9LHchb4APHXZyaxDmA3DUgSQZF9alZPcxHnq2fOOrgRjZc/I1uhH0GNNu
         DBwcD2ZA9qKiLup579ZteFOltmWB8dVmqVRHN077dM5nrGIryJgeevkgZPWfmKRpI8ve
         FUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263338; x=1724868138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+WA3ONqKSKn0c11QXINszItxJ2m3gC1pQyHe2RXITo=;
        b=n9F92ael9SJ+VugLm25bdE8Ik4LZ1YwPK3DNOfO4OTBhvaP1yq9ylS6khPILZldVqX
         vawkBs8VCfyH6gM+f9aZdumg/UWDOyQ/CF81GlwqGA9f9ZBwu9VATwQhhave39kzDvDg
         ZkZsn7aLFA0MbksfX64RvDOyiyA1MFAbvojAu+Jy6vP1cb+CBMmp/pG4xwS3kr6BFatZ
         ZJi2w4MUR7jpl5DMs0TK8Jh4VP0wr5UEi3ixPFh3ILMz3Ga3u53igHCNCkAS4BGaN7yf
         mYcLQiziL8dWKE7u8bRWvSfQ7mSR5fV1jIDFVG9X5l95Fx/o/vZeQiH+CXlEktz8jElh
         eo2w==
X-Forwarded-Encrypted: i=1; AJvYcCVwbt9S/B4FS4OfL1n6BYNBgYecX1Q0aVs8Z676ZVIfT0XEwB+0ybnzn6prZKOA5ATWqrisbmdzZQFJW9gj@vger.kernel.org, AJvYcCXOEgzFZNPzLkXMH9j/tW48CnfsZVGci6kOdaAhWckIGjXzGnmOdejFcCThH34XOZUFq04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHglsOHX5KuA+PzMIsme/T2yUnSE+Xg/EZuFxkwDdxW4+Cetz
	x0Do82CfK3WtZfMqnBLYLdBztUrwF9r2jzn2lvvQGlqlBzWuHE5C8Zg+lpDLRNLLMWyhtsr7CB5
	v7cUAHNWCr7ap+KRGbfdn5VFM+pU=
X-Google-Smtp-Source: AGHT+IGehUX8KP5ZFwQK5AObzHD1ANuVkEBjBoPnPbLE19cpFKTYNGiZElYxFxhDB7ibXD55/4qzJLpkFgMHbDHCTlI=
X-Received: by 2002:a05:600c:190e:b0:42a:ab31:c248 with SMTP id
 5b1f17b1804b1-42abd11dc5amr22619445e9.14.1724263337284; Wed, 21 Aug 2024
 11:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 11:02:05 -0700
Message-ID: <CAADnVQ+wbFj7-s-VH=bx2MVbWJ5ea_2xdzY-mDKss1m146Ux1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Relax KF_ACQUIRE kfuncs strict type
 matching constraint on non-zero offset pointers
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:24=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently the non-zero offset pointer constraint for KF_TRUSTED_ARGS
> kfuncs has been relaxed in commit 605c96997d89 ("bpf: relax zero fixed
> offset constraint on KF_TRUSTED_ARGS/KF_RCU"), which means that non-zero
> offset does not affect whether a pointer is valid.
>
> But currently we still cannot pass non-zero offset pointers to
> KF_ACQUIRE kfuncs. This is because KF_ACQUIRE kfuncs requires strict
> type matching, but non-zero offset does not change the type of pointer,
> which causes the ebpf program to be rejected by the verifier.
>
> This can cause some problems, one example is that bpf_skb_peek_tail
> kfunc [0] cannot be implemented by just passing in non-zero offset
> pointers.
>
> This patch makes KF_ACQUIRE kfuncs not require strict type matching
> on non-zero offset pointers.
>
> [0]: https://lore.kernel.org/bpf/AM6PR03MB5848CA39CB4B7A4397D380B099B12@A=
M6PR03MB5848.eurprd03.prod.outlook.com/
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ebec74c28ae3..3a14002d24a0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11484,7 +11484,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
>          * btf_struct_ids_match() to walk the struct at the 0th offset, a=
nd
>          * resolve types.
>          */
> -       if (is_kfunc_acquire(meta) ||
> +       if ((is_kfunc_acquire(meta) && !reg->off) ||

Agree that relaxing is fine and calling acquire kfunc like:
  bpf_kfunc_nested_acquire_test(&sk->sk_write_queue);

should be allowed,
but above check is strange, since
if offsetof(&sk_write_queue) =3D=3D 0
it will disallow calling a kfunc.
I mean if the field is the first in the outer struct this
condition will force strict type match which will fail, right?

So should we remove the above is_kfunc_acquire() check instead?

pw-bot: cr

