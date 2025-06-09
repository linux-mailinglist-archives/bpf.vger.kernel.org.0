Return-Path: <bpf+bounces-60074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A569CAD252D
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6161716E88C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513620C480;
	Mon,  9 Jun 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/OaptsK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F2149C53;
	Mon,  9 Jun 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749491184; cv=none; b=Vj21eKjXhqN1oi62AMaBaBEz9dxpo43i8C68TA7zMO0CQ90Zm10Z8rn/I4N3/LRuxVzEM6e/5KDm8RdtsUdm/tJXrlDKketugwELWTNeiAbZ2p6f4/92pkaWl01mCodmjBLB9ipcrjTTkfgM6x7ghzEY74WlHqVcylGEDMy+OgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749491184; c=relaxed/simple;
	bh=/GRxL/Shs5t5KAxppGgjU1LYWepOYAf4OzsGm4awp5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOPneLx51piVz1Ekmgl/CyVmV65gFY/y3TXRvFdPO/2XoNGEDyfcDcFC4mnxx0AH+IiKyfR6SycdkNMqzfpGwQuBY+p0r33BjCCWvUniKu4hF+f5e6KraKmKLvZXx+sVkEEnLJNCLyuW2BdsObxcuwMOCzu8Wng++EyhKJB19mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/OaptsK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2547941f8f.2;
        Mon, 09 Jun 2025 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749491181; x=1750095981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6OfLuzibQl1UKiS8t7iPVAzINkPcYfeArqcO9P3Gio=;
        b=G/OaptsKg/I71hr42zUGg83RRDaRzqL+UNlS4njUqxtLS8pSD2nTdOSY6mcgbG/K5p
         meM/hp5xpKNcsBtVrDcYmuzE2nxy9tH3Mh/hmgCoiA/7H+qJewQ6zXl2Z+3oyVUf/wTb
         EXZwFv7XwoFGmOfvEcM9bngRgqTGJiQKOdr+SOFo16Jy1avRirjfK0BDEUM9YarNFt9r
         laYATOiomIii5tJjfTJ8iUkh7O89/NkNzqO45RhM7bekeXbpbxgDzT3us0wFcjtJSXHm
         4V8PHkq5+LNVRxqSHBr/sXh8dRJZGQKchE9GvG+6nzxqW+K4uWjbSRtcJVD5HVpxctYN
         qhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749491181; x=1750095981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6OfLuzibQl1UKiS8t7iPVAzINkPcYfeArqcO9P3Gio=;
        b=mnGwBvYOUGRnXkb4d2+58DBQV38VjpqjRAxr0lXPC8450JtlpIvMI2FzHj6DubxwFB
         VAfoy+1wrfNHQdG3lyJEW62TVCBsjDgVTALmSOLsPytf23bz370tTkRAD3Hkm0hp+bom
         2a9sKR+SbbF5QS8g3xK9axHAVNYRwlbau2Z/+5jpVNacYEWmZE3z/HCmrNdkDmSsst7h
         hkXhCZO9gxUu1tYjmiAHp0qeotKCcucQTov2o6yvKg3/m4DaWiSHmGkqpDQr+N25LY+p
         1Prpo6dpzznyxZ/s6Jf+kIQZObQps1QNwqzLmqajF8XdJ0uTMlYWqIXb51ROx4ysCqf5
         yu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzwFd/7t+6oNRmluM1nb2zTdNJ7o1D/kxd1AbjneM1bYqK0kLZXhRr3W2a2r1WL4svwUEMN+rmrRRkHFAQczsIU8ae8UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1pvLQqiA+UQNdObxLobbF2n+s7Glg1tC6Rc6BAk0O2Y1tAS0
	7U6a2xanGOqhGyZf9KRU+RybD5dAcBq84i5EmgdSt3rmwRTrzhP1OBqg0jMf025476MUcHwSlbP
	NSz6/laSY8uNg0Rnj1EYaBjMFPq3b/o0=
X-Gm-Gg: ASbGncsfsgKMqdn0L7StE/D6dzV2F6wx6PqNYElb6ujxcFstCS72PacArh00oSbwJIU
	zO9frw7h4VdiAUazZnOjZrlJSK2omugQ/id+3mPpyEtEvFABo2oDwn9ZT/ABuwNntrI+yUA851x
	9gFiiyRnHcWq1OD8G526+MHVA5GN/8sYcJo3jLdlNAD8cNgHMOJ0xJOphLT4QjLJCfsaO4sGM0
X-Google-Smtp-Source: AGHT+IGWqY6NaSgntZldko9HfMvloeMJihIpe9i9lemNJqhiHMQHIHGe4ziTxqmMsOGmHZQOiRZh323OLBF10TyouIM=
X-Received: by 2002:a05:6000:430a:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3a531cedc5cmr10715302f8f.58.1749491180958; Mon, 09 Jun 2025
 10:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-3-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-3-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 10:46:09 -0700
X-Gm-Features: AX0GCFtGRJQQ1FN9ypDYJaCGM3WQ3BIHNBuvlxyc22-Gzbc19YvJMzDbj_E7jrY
Message-ID: <CAADnVQLJYuy3N0_kpk=UDvy8f08L=NSzjL5G0zimXsNjX_EMQQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] bpf: Update the bpf_prog_calc_tag to use SHA256
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Exclusive maps restrict map access to specific programs using a hash.
> The current hash used for this is SHA1, which is prone to collisions.
> This patch uses SHA256, which  is more resilient against
> collisions. This new hash is stored in bpf_prog and used by the verifier
> to determine if a program can access a given exclusive map.
>
> The original 64-bit tags are kept, as they are used by users as a short,
> possibly colliding program identifier for non-security purposes.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h    |  8 ++++++-
>  include/linux/filter.h |  6 ------
>  kernel/bpf/core.c      | 49 ++++++------------------------------------
>  3 files changed, 14 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d5ae43b36e68..77d62c74a4e7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -31,6 +31,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/cfi.h>
>  #include <asm/rqspinlock.h>
> +#include <crypto/sha2.h>
>
>  struct bpf_verifier_env;
>  struct bpf_verifier_log;
> @@ -1669,7 +1670,12 @@ struct bpf_prog {
>         enum bpf_attach_type    expected_attach_type; /* For some prog ty=
pes */
>         u32                     len;            /* Number of filter block=
s */
>         u32                     jited_len;      /* Size of jited insns in=
 bytes */
> -       u8                      tag[BPF_TAG_SIZE];
> +       union {
> +               u8 digest[SHA256_DIGEST_SIZE];
> +               struct {
> +                       u8 tag[BPF_TAG_SIZE];
> +               };
> +       };

Why extra anon struct ?
union {
  u8 digest[SHA256_DIGEST_SIZE];
  u8 tag[BPF_TAG_SIZE];
};
should work ?

>         struct bpf_prog_stats __percpu *stats;
>         int __percpu            *active;
>         unsigned int            (*bpf_func)(const void *ctx,
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..3aa33e904a4e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -997,12 +997,6 @@ static inline u32 bpf_prog_insn_size(const struct bp=
f_prog *prog)
>         return prog->len * sizeof(struct bpf_insn);
>  }
>
> -static inline u32 bpf_prog_tag_scratch_size(const struct bpf_prog *prog)
> -{
> -       return round_up(bpf_prog_insn_size(prog) +
> -                       sizeof(__be64) + 1, SHA1_BLOCK_SIZE);
> -}

Nice that we don't need this roundup anymore.

