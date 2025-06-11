Return-Path: <bpf+bounces-60363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A843AD5EF1
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0517319C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989F28B41A;
	Wed, 11 Jun 2025 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrZmepVS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168927CCF3
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669718; cv=none; b=sP+lsgowuU3yBMJqtOQoH6P5Zc/07+4CX0a4zO6xCZ5cv/aagGV5+zalrI1ZoxE6YjW9baux8OYoAUOCPQfcDu7l1+IqGMXljPqjVLypSP59gyucyV+eacK4ILC1JLzLka+SjXTCDp1QVj75br/JfFSNcx5Hm82TvVeP4QbFsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669718; c=relaxed/simple;
	bh=BmkEstGv2aoihR95MPiJaGda+u9tWzkXEB4qkEZQIto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYzzo8jGDHTD2Z0GoXtWbt8iCUW5M5O2n5HtqJ+zCjwQP6wrEPsEOD/vXMjTSeIZ6xK2QsFMZbeax/mbcDW0pYY7G2BhPuLsHY+rILJ0gLCQ8MGyL+Kf7Z/dh/Nl3e7ayh58UFgZ1unOA7f9rjRko0X04XwMT2Xaj6T/U71r3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrZmepVS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so1536925e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749669714; x=1750274514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j88ox16rfZkXqTvxG1XpXtyiJQMneu5Ksp4NRAzADtk=;
        b=JrZmepVShyCTKXUomgPmWtdLFp7XXBKocvPbggaqxWKOJT67nMwSPsPI6NCBXYqRlc
         w6VGTxcOHEpRIQhILT8WbnFTqJdbnSjI6nIAxZdoJKWjJsl/Q5p2VMcsff4kWO2R8d40
         pAi+dADR1TGseYfxOW6/dNyqflLJ07evoVVn0fZMc3HiMWxC1XyLG6jwSlkT3F11EXTw
         ta4zvFZYLCrFHjHNtlaapVWAWUTVBkVR2apKQ24UxaVt9dEBwOq4vlcw5cslvxGVBVyD
         E5DeR9zJDXGSangdgr4ZPgnc4PqHlbe6sWY1UiSkrdExIo+PB7QJzvo1xOarbmWJyKfH
         UwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669714; x=1750274514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j88ox16rfZkXqTvxG1XpXtyiJQMneu5Ksp4NRAzADtk=;
        b=U5YabkmHzMJge1MDPdGR1FL4n02VMhF4mEQQjzFU+Aok+InSQEeQuNYwWzYd69CHTn
         yLAgRUmn1AZlNpZfeeMTDvjcskTHw+Av/wV3mEDVJK/vuGKO6b6HtcFesakx1qnauUpI
         FCToZAkuwLKLaF2ACjc4nJxLLmrfa130FqzNkL6Ps50k+O9E7cTchF26pR7NrGVXsLNB
         eBR+0soGnCA9zkKOCNw8Jp6jCFhdy4dOWg3zXGeSFfbGe0QBtBwx9C7i/0f7eo05ivSn
         fDWU55wYLgHr+2V5epQk+ZsRXbRug/3GXt8arHCC7DrvWIBv9eg7Q/CYSYperKvDdV/o
         BAJg==
X-Gm-Message-State: AOJu0YyaaNTLcLvmu74DiVurY2SQL2R4cbOzyFiUERRGJZleWfZzCa0s
	J6FpSobkscEZzja325yMeLB/yimq0oC7hhDWMx9JZox+DzsZjarHnSX3mD1zqT7E9fVv4oPTQyT
	JD3PP7c5A+mhtuFu+o9/HBmKGfre1ahQ=
X-Gm-Gg: ASbGncsH/kyHGDvUUMHEryfayYHTJoR+reyFNc9fWCZGCtGUp5v6Do1wtMik9dAUT/4
	y8RQG2vLS0Gvx96ur2ft3Ri3WaBLw7P04B4WefwhBMFiTh+dS8KptgRprBUyKS+rHcRfbMCwD7y
	1FmOBut1JEz5gV65vxkHB2GzCrqQBoD8ylnvRyJOM4OsnbWV9vklLN29uBzwAih3LCcsbRkrmf
X-Google-Smtp-Source: AGHT+IFzJXMLBtGNq7r1f2v8T4/ViL0MRQYyNBdF5VpJ8UgMSMoMPBwX7dkSOeCzsFm5PIIWnFOmsxALL4cufo9Xm4A=
X-Received: by 2002:a05:600c:1c9b:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4532d2bdd3amr1892735e9.7.1749669713938; Wed, 11 Jun 2025
 12:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611171519.2033193-1-yonghong.song@linux.dev> <20250611171529.2034330-1-yonghong.song@linux.dev>
In-Reply-To: <20250611171529.2034330-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 12:21:43 -0700
X-Gm-Features: AX0GCFt2WYUMmukSzItJDUFaEb8JW6Rcz2T1Nwf9B6inFnv0d9MVsfhVIOnS9OY
Message-ID: <CAADnVQ+H+1eq3BqvCzeNwS=PZBXC7RAR3X6SkuSKC3CuEA88rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Fix two net related test
 failures with 64K page size
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:15=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> When running BPF selftests on arm64 with a 64K page size, I encountered
> the following two test failures:
>   sockmap_basic/sockmap skb_verdict change tail:FAIL
>   tc_change_tail:FAIL
>
> With further debugging, I identified the root cause in the following
> kernel code within __bpf_skb_change_tail():
>
>     u32 max_len =3D BPF_SKB_MAX_LEN;
>     u32 min_len =3D __bpf_skb_min_len(skb);
>     int ret;
>
>     if (unlikely(flags || new_len > max_len || new_len < min_len))
>         return -EINVAL;
>
> With a 4K page size, new_len =3D 65535 and max_len =3D 16064, the functio=
n
> returns -EINVAL. However, With a 64K page size, max_len increases to
> 261824, allowing execution to proceed further in the function. This is
> because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
> result in higher max_len values.
>
> Updating the new_len parameter in both tests from 65535 to 256K (0x40000)
> resolves the failures.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 5 ++++-
>  tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c=
 b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> index 2796dd8545eb..e4554ef05441 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> @@ -3,6 +3,9 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>
> +#define PAGE_SIZE 65536 /* make it work on 64K page arches */
> +#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_SOCKMAP);
>         __uint(max_entries, 1);
> @@ -31,7 +34,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
>                 change_tail_ret =3D bpf_skb_change_tail(skb, skb->len + 1=
, 0);
>                 return SK_PASS;
>         } else if (data[0] =3D=3D 'E') { /* Error */
> -               change_tail_ret =3D bpf_skb_change_tail(skb, 65535, 0);
> +               change_tail_ret =3D bpf_skb_change_tail(skb, BPF_SKB_MAX_=
LEN, 0);
>                 return SK_PASS;
>         }
>         return SK_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/to=
ols/testing/selftests/bpf/progs/test_tc_change_tail.c
> index 28edafe803f0..47670bbd1766 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
> @@ -7,6 +7,9 @@
>  #include <linux/udp.h>
>  #include <linux/pkt_cls.h>
>
> +#define PAGE_SIZE 65536 /* make it work on 64K page arches */
> +#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)

If you want it to match the kernel then let's use actual page size?
See bpf_arena_common.h and
#ifndef PAGE_SIZE
#define PAGE_SIZE __PAGE_SIZE

