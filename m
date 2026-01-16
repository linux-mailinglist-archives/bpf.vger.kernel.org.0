Return-Path: <bpf+bounces-79171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88ED2976D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F32A03038987
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C730EF9F;
	Fri, 16 Jan 2026 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwgZtkyD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF23101DB
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524878; cv=pass; b=MmwxsMBYVR2t1T9YZfim026TYH2aNJgxWrVgSP3n6XKQb87TcEeq7qcz04ELVZqh5qNvHZ/1AkMQsLWxxTmkbf2we0r9MuFQmnWkVu7QIbPwaiCl59U3/LL2nqscC5t0oA6qwMOg8ESSThtAOFenMRN1YdkPuJx7LSOUSYZXh9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524878; c=relaxed/simple;
	bh=oeS3pd4PScIcoH3d4d6z3CMgUN6iKFWAVcj4dEp5IQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvTWEvJsigWVVu2+G2ubORCroiDO+FeIuTahVBmj/d9Sxms7hetrCttBKkKCiwZGTC+/0tASdjIoz9Rv//u1AIJJ2A9uLJ39ORjOeaiis/cT0d7lmqbSI5c/1Ur0Grg+wv5EMoL5Dg+A8jogLslw0O+8RMZ06BnaGsDWnmDb6Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwgZtkyD; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso658313a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768524875; cv=none;
        d=google.com; s=arc-20240605;
        b=OcQObXLfFirdrB+orHkJP1Kbgiz6F6eZ2lq6xAF/+5gOf0eg/HxfVBs9Hgp55KxXyj
         Px1cGjIyFo7uraPFA3+Kw/Rqfwcpvzi5zsKX2hbbtg9Ndab+W50As5puwm9QM0jRnmF7
         IU3GxUNCNCFRZWjL1PU02R1Ll62m2zBtPqAFbq0OFZrdOYI4klUSm4KdJb/lt0rYmTXz
         BD8Xi+bE28OHVODK7ziQT9u07GBszcbaBkz4t1U7pRHM8bqetNVlwDTPMlhDyAj9DI4a
         Z6/j8kBRC+lhNi3OQdcXkWapJIgqOei+3mWSflKLp9gQGftjpwF7ld4jnvzpS5uIcqEC
         VYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=ToeOyDGQRiWK66DPqlfBjRi8JRDCN4rlWmnMPaXmMG1V3J4q3HhXUoBpVzdqpbddKm
         yCOUftv4Daxo08YRfHHlb3jH03nWHWWSXoZwriwZpx9U+tg8onODcDXLoOI9YYMW48Jr
         MBJIv2nHit8wIEbhJjQ839RTRIK/MD3u08g7kEiXg3y8NEhD87lyLEmlZ+qEysrKYbIp
         9/gC0s0H4A0QMFWJ9076AHW1Eh/mYELwfcDLov2ahmRxo1m2+vZMPXojBWlQAJ6us93O
         rCF60b7NmMwR9DKOsEQ5sLp7y4tP8vyJWpJlJvaClJKVWjrGxNWSm9DF3UlmXdm6LMYS
         ehxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524875; x=1769129675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        b=SwgZtkyD0QFNe+nEPMmNykduOXAWDAKWMNufsbs65SIKsG+3+qL9065BH38eBWCkyz
         qPJq+JTDv02pcTC0XdtAqNfQ8BrYXM9rj+fAk/JYwLrB+JIdAfQc4r/nVdcYJlzdh6qP
         bcNagU+Km7CmgHMuKABTqNPnY0WTthvm1XZj46mLDcUcwJzalW4L+jICfF8ULZrOIM62
         9PRPXFHNGhbzG98H2QYSfLAcNegZQyN2vfivslGP//lyjtr7qdrfCQAqL8LqeJZUaCbS
         7/O8nS3TtcC1BuZRzptVcfPi0hOEHXJ/x5J2WrHPQoUFpc5YnubMPUB4tkJ4GK/UrUiz
         ci4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524875; x=1769129675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        b=NETpIBfLJQuHfL73n9dKzGCNW8YtvNpSlk9jppfilDAW/BTGyd7ZQnj6g8+/nZ0L6P
         ipPnX17oZHbSt8WY0TVfBRj/xyF8bkLzA8b3fTENIjmHs3HqpqE+eK5z/1nIjchXoDCY
         apWep/pVKikJlVJUYM44m1pKbzMheTneJ3YqCdWdbZQ1mNAgnYufUYiw+4Jsnx+MzLQW
         ut2BvbJCQuY324yv4slLLrmVPnYtZ5YCPD6M1dLLoWUtoe2ZjjCczIpX4v4lhFNVJUpm
         8vzf6NClSI0EUo27mvvRFHkxUTgXNPzlvv/jLH3lSIT63mrG7UWXaJyG7l+OTzyGuuVR
         Novg==
X-Gm-Message-State: AOJu0YyK4/5cQdTseppC3Ehk9kHLBA+pycISpxaBduDIK3aLxA63ETWP
	36ertnteIKESUPjwwJ94Xfssn6v7z5dhixALfINxhBB2YE77x7bj95slrnKG38Qp7clbNLpE5GI
	6DNLqtNkIkNf4s+4md1jg6f4j4BKkkSE=
X-Gm-Gg: AY/fxX5/ghA7TDsxiaIEzMbwzM/r6BJz+2gIeTceSNwnOlVfCyy5NlzXevLixQ1fnbi
	yBgtsGKVs4ywo+bgDqTGq5IvRSOwo6Zuh2uN5c6b2ImClni045jUNaDWE6ckWwFGpKNj0B+EBBK
	If1g1TpZFeNCEU/9aNJhTezwE+zGfFfc1zoHg3OaN2eABxgjbBNjjJfuzX70NxurPVVk3KELufz
	PX8DvLbSNcqKZdK5STO3oPEfZJJ3f/eH9aDXU8W5LZGrEu97HnJ4QC3XA5DIEHbr5GwceHbKBJQ
	we6Q5bJZ
X-Received: by 2002:a17:90b:2f45:b0:34e:5516:3fe3 with SMTP id
 98e67ed59e1d1-35272ee1c8bmr989693a91.11.1768524874635; Thu, 15 Jan 2026
 16:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-5-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:54:21 -0800
X-Gm-Features: AZwV_QgEDyBTV1rBmwgvFCqTetxY1gptMuOZxPzb9k8dRkyCkG_1Ej0bF21H380
Message-ID: <CAEf4BzZbcA2T8+OR1_68sxq9Chukmh8beyz+018O22U=SsafrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Add syscall common attributes
 support for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> The log buffer of common attributes would be confusing with the one in
> 'union bpf_attr' for BPF_PROG_LOAD.
>
> In order to clarify the usage of these two log buffers, they both can be
> used for logging if:
>
> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> * One of them is missing, then another one will be used for logging.
>
> If they both have 'log_buf' but they are not same totally, return -EUSERS=
.

why use this special error code that we don't seem to use in BPF
subsystem at all? What's wrong with -EINVAL. This shouldn't be an easy
mistake to do, tbh.

>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c         |  9 ++++++---
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c9632c40059..da2d37ca60e7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -637,9 +637,11 @@ struct bpf_log_attr {
>         u32 log_level;
>         struct bpf_attrs *attrs;
>         u32 offsetof_log_true_size;
> +       struct bpf_attrs *attrs_common;
>  };
>
> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs);
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs,
> +                               struct bpf_attrs *attrs_common);
>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_veri=
fier_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 457b724c4176..eba60a13e244 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>  }
>
>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_a=
ttrs *attrs, u64 log_buf,
> -                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size)
> +                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size,
> +                            struct bpf_attrs *attrs_common)
>  {
> +       const struct bpf_common_attr *common_attr =3D attrs_common ? attr=
s_common->attr : NULL;
> +

There is something to be said about naming choices here :) it's easy
to get lost in attrs_common being actually bpf_attrs, which contains
attr field, which is actually of bpf_common_attr type... It's a bit
disorienting. :)

>         memset(log_attr, 0, sizeof(*log_attr));
>         log_attr->log_buf =3D log_buf;
>         log_attr->log_size =3D log_size;
>         log_attr->log_level =3D log_level;
>         log_attr->attrs =3D attrs;
>         log_attr->offsetof_log_true_size =3D offsetof_log_true_size;
> +       log_attr->attrs_common =3D attrs_common;
> +
> +       if (log_buf && common_attr && common_attr->log_buf &&
> +               (log_buf !=3D common_attr->log_buf ||
> +                log_size !=3D common_attr->log_size ||
> +                log_level !=3D common_attr->log_level))
> +               return -EUSERS;
> +
> +       if (!log_buf && common_attr && common_attr->log_buf) {
> +               log_attr->log_buf =3D common_attr->log_buf;
> +               log_attr->log_size =3D common_attr->log_size;
> +               log_attr->log_level =3D common_attr->log_level;
> +       }
> +
>         return 0;
>  }
>

[...]

