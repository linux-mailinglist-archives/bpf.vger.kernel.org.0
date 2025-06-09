Return-Path: <bpf+bounces-60096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6996AD28E0
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3171709FA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AA223DC7;
	Mon,  9 Jun 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0xvQlcx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337121B9F7;
	Mon,  9 Jun 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505195; cv=none; b=KiVko5cofWTNVRPj+df7ugzLAiaCxMJiU2odHaNP1fdaajAX4wkYX5QIY3Cfsjte3dC6H+LeXN13iozTfOjPsy50/9PuED/W2NcNEwLHUOUSRa2xtKZz1Hz82NgHFUAbu9qFGEgJm04NaruwYFiDlJQepV1JfLTaAEFvd0Xldg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505195; c=relaxed/simple;
	bh=dHTBJtRUwHwwJnO8gh9HlrtWQyq7cn60TV9L28XqLX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+JeDNAOD7VA7NKqZIWmwQA1nNjAJjKV8EaII59On/9LbJShcBDdo6tF6ZsAPKMeEUVHL2YuvWWR6w4+gw5IqtcjcLQ4TU/FyfPvXPMqeDIw6DHJbqADe7haWsmiKvY1LG8f07Gv2J1sif7gRRJRFYaCyI7v/tiJ0BxpwidimS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0xvQlcx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54700a463so1020222f8f.1;
        Mon, 09 Jun 2025 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505192; x=1750109992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mH2wTySiZjdMqcHG8KkPrIxg8vpz0eL/SdtBTWh3O8=;
        b=J0xvQlcxO/Yo1llL29nWDeFsxiKMI+fCh9jl2UtUXTFb6Ur8sw5euXq3oV1Ve9hyUc
         62XzaGOoMkxMwF6kz2YpunKvQL7z4zUIeWHxOqgrGDHWaZ1LQbeL3qGmsKDE87FO2Ldd
         ctBnb3A6Mf7ZzwELbh5zidP+7mm5AUBH75fM+tQed9Y67DffBfX7cm3LkHbXGdvhhywh
         xPAIbAvuYC4q83wHpT8lEKFCMvUYuFEJrZmAMoSnmA2xzKE7qiS7MrKrmSAePmryKN8r
         6El+NnYp6/4/P9Waai6EseloJFX4V4jzkAyxjl8dothajiqGJV9mFnyv/0RKqvA16JH0
         39Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505192; x=1750109992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mH2wTySiZjdMqcHG8KkPrIxg8vpz0eL/SdtBTWh3O8=;
        b=lPPSHu75uH+OgfMCkyt/3HVsvscz0kZmCFQ30z18ZAQz5egB2at8dfD4+tr2m9gDaO
         YGVLGEWiWRy7sQLH8RXdNMXKZixX6bhcRVeale+kC94qP82K/+SCO0dkCGXqkTMhrkyn
         EjHR0NwaVqp17jWVdarS1Voom+9Pl9N1Ae/7onwkILwChZt+pPc2IzetzkxTi6gULa29
         SUQXTYROJdQrqa6tiJidpTCL1A7lL6oMyr5Pf7oR7y4lF6deafFkFeoyKfrtUG76znoh
         tbbh2MU3HaNU8DpHpe7DyHsEOzlPREGAYwY77PDwuB3bl7JMn6ls3INrJi6TXVunytFr
         lb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBDljuPdHi2aU9JMq01H8hY11twRi60f7Pc93NcPAVKadFppQhAxrtzf0hLQP3yFJGW+lI9DISE6pKOoArFjB7zpfwVFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55qY0J2CWATVFud9rFITtyvS18WW3+ppSVnGzodxDE2iD0Uki
	h9bkc0bZTjoxPDBHksFEkIyiAbfU5SC4Fg0cy1+SG4FsSWgADNLRlvAoTY1Fs8HvWm0Gf1+rd42
	iyMZlfC4B25BDldjQYBvsQYduVvcvXyg=
X-Gm-Gg: ASbGncscyRtCIYqcEtP/3AxPrt8XA5zBkC1fZA6CHiIzOnlnlAnqiZG/Ek7iiCrYJxK
	PmaNK6o2A6WYyIovVY6WvsvOkd6UXBsHtof44bNK68B+iwvn05m2tjR47Zy+DbX0oVdfMwTZEhb
	MlgT0jYVIJl8Q1z323GdDQLpDhW0QFoSxwuvCx34Vj8lyK6qSV8iSi/zinryFsff8hmmf/dJef
X-Google-Smtp-Source: AGHT+IGBGcife4PrPtBb9sMk8n2tVgUVRU7AcRoZfcTHTqo407hJpEfra9mWFGuPDdorsgEQOPIY9JOZ9x3rVz2GQc8=
X-Received: by 2002:adf:cb13:0:b0:3a3:76d8:67a7 with SMTP id
 ffacd0b85a97d-3a55140272emr688705f8f.20.1749505191604; Mon, 09 Jun 2025
 14:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-9-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-9-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 14:39:39 -0700
X-Gm-Features: AX0GCFsJMmFNI49GGWJLgbLF4O1tlonGGxOLwKEohwKuP9XgnQyv-AQNA90sojw
Message-ID: <CAADnVQ+DvsdW60Edou4NcmrZnae7KYr70kD02pvAy1kYxmguQw@mail.gmail.com>
Subject: Re: [PATCH 08/12] bpf: Implement signature verification for BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> This patch extends the BPF_PROG_LOAD command by adding three new fields
> to `union bpf_attr` in the user-space API:
>
>   - signature: A pointer to the signature blob.
>   - signature_size: The size of the signature blob.
>   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
>     the user or session keyring) containing the trusted public keys.
>
> When a BPF program is loaded with a signature, the kernel:
>
> 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> 2.  Verifies the supplied signature against the BPF program's
>     instruction buffer.
> 3.  If the signature is valid and was generated by a key in the trusted
>     keyring, the program load proceeds.
> 4.  If no signature is provided, the load proceeds as before, allowing
>     for backward compatibility. LSMs can chose to restrict unsigned
>     programs and implement a security policy.
> 5.  If signature verification fails for any reason,
>     the program is not loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h            |  9 +++++++-
>  include/uapi/linux/bpf.h       | 10 +++++++++
>  kernel/bpf/syscall.c           | 39 +++++++++++++++++++++++++++++++++-
>  kernel/trace/bpf_trace.c       |  6 ++++--
>  tools/include/uapi/linux/bpf.h | 10 +++++++++
>  tools/lib/bpf/bpf.c            |  2 +-
>  6 files changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 35f1a633d87a..32a41803d61c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2778,7 +2778,14 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *pr=
og,
>  int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
>                        u16 btf_fd_idx, u8 **func_addr);
>
> -struct bpf_core_ctx {
> +__bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags);

No need for __bpf_kfunc attribute in prototypes.
It's only meaningful in definition.

> +__bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id);
> +__bpf_kfunc void bpf_key_put(struct bpf_key *bkey);
> +__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> +                                          struct bpf_dynptr *sig_p,
> +                                          struct bpf_key *trusted_keyrin=
g);
> +

We probably need to move them to kernel/bpf/helper.c first.
Since kernel/trace/bpf_trace.c depends on:
config BPF_EVENTS
        depends on BPF_SYSCALL
        depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS

They will still be guarded by CONFIG_KEYS, of course.

> +       struct bpf_core_ctx {

drop extra tab.

>         struct bpf_verifier_log *log;
>         const struct btf *btf;
>  };

