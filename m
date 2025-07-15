Return-Path: <bpf+bounces-63334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA1B061CE
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E207A6D4A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745781F7586;
	Tue, 15 Jul 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ7tS0IN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19A1F2BAD;
	Tue, 15 Jul 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590988; cv=none; b=l2BUa+ypP/HV5JmT+YNHCVIPj3QbauaOQ7Y7HCEmdBLT3wz9EKyVxIA80K5AZATsJlWEL3JKf5CSQ9pdGOjfjBfHn2CAJWAxpJPmWk6GzpeBgUEuIsx2fti7aCdHOhcCFx7K/JuAcKpR4bUP2vGhZdJaNJQ+rf2KLUBbWOMKSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590988; c=relaxed/simple;
	bh=E89zHbYFIu3/6rQztCCdMZeq63swHg+cazrRhJA/6UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxDo8zLVyj33lngIdjtjnfL4OjQ1arvLP1LPBJxdnqkBYQPqDmlAWQ3/6ctQxPRnbTKtO4dpwFfM8vpRDlUnphuhhM0L8RKIKuI2BmvZkv5q49OpuECjjTNf3MOi0Pw+VY2k41igxF/bWCCYS3WMDgs1cEQJfHtCxxVx/Q3z+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ7tS0IN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso5351316f8f.3;
        Tue, 15 Jul 2025 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752590984; x=1753195784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNFBvz7x6VkkrfT1tcftcVPGyWEbY+Y5It0uYqlDnxE=;
        b=VZ7tS0IN13EhRkyIQ8QPBSuiImUk3G/D5IQ9zI//WfQNsNH3YZhlIhnM6bjsKcp4+p
         LS4fRF+U2qXfZjLkNc36mmPX1Jek2Q0U3SnatgcYlBDZdeK7XUMuIQM2ySY/MP4y/5RV
         NMtJNiIWXEYnpcJtD/vQqU2qIhNpzmmA1yVX7CADDiqrfYcNoREAVFQZffmleov4Hkfp
         RqXhCgjuK0B25TPWIRevGtsDlPv4Cpgq0SN5nlf2YzWBzPU+rbSd2C0/KafiMuiJ+l3Z
         Ah/FZ+SVj1QrJ/5iSz45k4ENpiOQTXrYruNaQKUB/YFDfPjRZdNxxp0aXkq3s+peg1Of
         djkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590984; x=1753195784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNFBvz7x6VkkrfT1tcftcVPGyWEbY+Y5It0uYqlDnxE=;
        b=vWU59zUPiR6Wy64TwaYdxEfTc6A56U3+j5GLbPvCIWqbJEYEE9PkKehW+XKdmwFxKA
         QUIG2WGZhwwe+zPW4aEGNhkYDNdGTN6EF8Qz+ddGh5F30JHt2pF5O0ZI1PRN1YKBZWS3
         e3MrR+r1eyEB4d6pIoA/owaAkJq4yW1pfcaAaqbdUO3GftKAgBj3QEawIjvrwEdODrXP
         2HwB6Phlji1uHIhBpGTkGE8U3ynky6jJgwipp8+CAHs0jqx+dBi6L276J12uh9HcUV8z
         CQ1BXNIZ8/4E35E20BaLeat56nIONfZFX3q60O4ULQm8qXYSKfoiFPBJKx1iTTzSgP6I
         Ts0A==
X-Forwarded-Encrypted: i=1; AJvYcCWm1qhiyySjqtWnka6EcAPP7nqzfmSgGgMTnlXKLbiiRIOuCBNH7HDdhVwNCLA3iDK6BmEME4/oI/yY1KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtVUXcCng/srmDFTYqYJRgnpUIoKBzIZoDhf/mH5b4IUKt2XW
	u6V+T23awSjkjOA1QEeEMEyWrdqOGQPgy5eZP+ggOVaV8+erTqI88S+B1lFZIaRm2wNKsFouOSF
	X8Ao0dcn27Jsr/ZPDaJxoWPdm3Eplwwg=
X-Gm-Gg: ASbGnctMcL6zX5Ghy6zmSteyHBG6WUS8AtkvHGLtAyq/c3ZaicySwFav5QhPhWBTNSW
	TBMfvcOUIUPoj7KaCs5wYqpOBjGIlEZVhUjkp/u1S69KKhLi5QzukfR7m1Y40kSJp7nnEBT7mJv
	dPXuFy4xm0PjoSFDs6LmUAvXAjxSe5ZRiwMPOdDNOQRkzMXeP/LiIVaVKH/FUSjISkgR+QSckqC
	Z/qpIYOEa2PiOIt/QS+X4okP2AhmHVYYg==
X-Google-Smtp-Source: AGHT+IHCxFJGH2xnmY5kjFul8ROGxrVizXCe4HKLVhkhcxYqn8azsdd7XP74gla1q9k6Rg0FnsHrisC4BbFKlpZBS2o=
X-Received: by 2002:a05:6000:ecf:b0:3b1:9259:3ead with SMTP id
 ffacd0b85a97d-3b60a1939cbmr2143309f8f.28.1752590984154; Tue, 15 Jul 2025
 07:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715075755.114339-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250715075755.114339-1-shankari.ak0208@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Jul 2025 07:49:33 -0700
X-Gm-Features: Ac12FXxNnEjYobwzioWQrHGM1rDtNPYKdcIy4LxebETOY9FWxuqqt2tylYrTZ1A
Message-ID: <CAADnVQJ6_pB8ZU2Cw5S6nB4J-6s7bw5Fp-Hst9M_EE9=HxN8+g@mail.gmail.com>
Subject: Re: [PATCH] bpf: restrict verifier access to bpf_lru_node.ref
To: Shankari Anand <shankari.ak0208@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:58=E2=80=AFAM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> syzbot reported a data race on the `ref` field of `struct bpf_lru_node`:
> https://syzkaller.appspot.com/bug?extid=3Dad4661d6ca888ce7fe11
>
> This race arises when user programs read the `.ref` field from a BPF map
> that uses LRU logic, potentially exposing unprotected state.
>
> Accesses to `ref` are already wrapped with READ_ONCE() and WRITE_ONCE().
> However, the BPF verifier currently allows unprivileged programs to
> read this field via BTF-enabled pointer, bypassing internal assumptions.
>
> To mitigate this, the verifier is updated to disallow access
> to the `.ref` field in `struct bpf_lru_node`.
> This is done by checking both the base type and field name
> in `check_ptr_to_btf_access()` and returning -EACCES if matched.
>
> Reported-by: syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6847e661.a70a0220.27c366.005d.GAE@goo=
gle.com/T/
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
>  kernel/bpf/verifier.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 169845710c7e..775ce454268c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7159,6 +7159,19 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>                 }
>
>                 ret =3D btf_struct_access(&env->log, reg, off, size, atyp=
e, &btf_id, &flag, &field_name);
> +
> +               /* Block access to sensitive kernel-internal fields */

This makes no sense. Tracing bpf progs are allowed to read
all kernel internal data fields.

Also you misread the kcsan report.

It says that 'read' comes from:

read to 0xffff888118f3d568 of 4 bytes by task 4719 on cpu 1:
 lookup_nulls_elem_raw kernel/bpf/hashtab.c:643 [inline]

which is reading hash and key of htab_elem while
write side actually writes hash too:
*(u32 *)((void *)node + lru->hash_offset) =3D hash;

Martin,
is it really possible for these read/write to race ?

--
pw-bot: cr

