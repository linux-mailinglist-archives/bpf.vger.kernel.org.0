Return-Path: <bpf+bounces-77645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B47CEC964
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB8423001192
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FD309F1D;
	Wed, 31 Dec 2025 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db9bex7p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F83064A9
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216898; cv=none; b=rXE2wvRCtG0k5c8Ja1b0mZC3F6ys7/15fYF5r8EJBQFnLoB3qCeEytunMoiuk4BpboxpHnb+o+meGzxS7Xm1cgrNMCe5Jn9btNmE0uJKP1xk3yqSPNZlte6a4lqaX/h16X5HiNXSXBdIh9OJN16sSK9zcPdvFnhbyCW1vZ4/kY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216898; c=relaxed/simple;
	bh=NkpxC+v+IEZhsd9ska/BWRQFaVRrwDGbf3fuEbg07AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6zEUvSuPxZHbRIkmCpzp4gJOHZkoEjsP6yET0arqA4BCCzaO0krjYSZRA1Czw1+LUwcncsz/Sg3qdG3NaUsrKVcAfNMQTih1qbYw1+gdGbbm8yboAuUEHO+ZfXTAlQGbdKsDxELfZrZHHh8UD0/Smx3nSvy7lagAKzbFWT8+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db9bex7p; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so5260127f8f.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767216895; x=1767821695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GleHLxzrqhi5Hmxay6c41BI3irva7zlljp3uEYcnh1A=;
        b=db9bex7pjZ0YvBZsfrVw3EOv1a2ziWD2wq3hw/GigqvN6Dsr6R+HYmz26vo0SSbOtN
         rKC14Tl6+Hif1Zz/sj6r0/m6vexA++ZMpGapNdSdTlYRUf+zV8q4VOe0iaA2kFHk7Q75
         wYnk3gAzt0H7fQ8n8kAR2YtGGnT4Oa4SyeuT4Fh5eapjxmoAJ84p5VvNBJqVhdA+XEqr
         GIEsXjNgwjd/3QV2bptxDKrQeOjdxlM5Loj+ykKRRfU8opnD8GfwO8AUFOGdUX0imf5f
         5PuJf3UJYTJSGg/BXqP/WdcF6rPDse8KA62BHUnP6cEjngV/RBqdZwxBCXDlhWR88ZMp
         r7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767216895; x=1767821695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GleHLxzrqhi5Hmxay6c41BI3irva7zlljp3uEYcnh1A=;
        b=vQGB1Yj13lg+6nWJoa+fd7e6iRR7rcCzPYglO7iUCba2iQNhM9KLszJb3jHv5E5Z1J
         wDhElq10YUMi/j8vnFgfGn1cMEJRrwGD1dKrQZORC6QPC4rxfjqBDPw77ci9edkK/k65
         Zm6X1bvhyhfsDOQj99tJkXIhoaY59vkkgZ4+bqVSVKn7H+MJqjlc47sbRJN1N5RGJQWc
         QXhWIMaB3Y6mTPNiw1/4BZ1RlZCAzPTeykD8txqL8ZI/ppn8jZv1vr32ewUhZLG/LWsl
         KUFjj124DT2WnU6zvczwk2IHyWrZKWsicVgkkxjNXIXJbx2+ddCdF4vedmHovgsgyByd
         wQNA==
X-Forwarded-Encrypted: i=1; AJvYcCWvdT5VZnDm8Mp0vZjDkow3qXvs3I1Hky0+qGJX/S7WGTSRDxLb8btn0R7MCiHVrv6zFxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HcyuIF/mCTHjMuo0YJ/jqHDfD2uf9UFbCMRP9C1m/VfwAAcx
	nIklOyHExyWPBYatesUQRq7S969/wZOBbti9NfBzot7N8pDzeEzdxXPMfqPJ7sBQXQ0fCw4xI4W
	B2uI59OQb9D+hrV6a8B4m6StjuKs/sWU=
X-Gm-Gg: AY/fxX7g/IclZY1iw5actzf1BipC1Aer9duDQgt5mDVR0CSRqIP0KezUr5CXf1Tlj7U
	q6g7uB6wrpoWGeB38Et9otljf5nhnqO7izO2M5lAj04MBVe7fpwaSlKic3nILfEBkZxuAqwz5Re
	HYxV0usaKq7vSgU4qtrzFyx3n5qjUqDLTtbC6NlGmp5Ttd+qSViNQQUeFv1FE82ZYVDyPvd+PpG
	e1JtLKjNtW5kgxXwIw3lhI4efLXyMYqTtct2Gk79edDeFN8oKBu8zlt8EPebybJ1IqrBR2g/t38
	3m7Fk40Zg8YkcPXFKPywwnWOhjdP
X-Google-Smtp-Source: AGHT+IHt+ldVyNL/+5ZYIaXtm4dZPxM9U/F2RXTc0isKzBzLrWGnTUAEyyc+PvTuMiqiJQmrxvIZRk9PjsPUty8TWTY=
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id
 ffacd0b85a97d-4324e4c9e98mr46013240f8f.22.1767216894870; Wed, 31 Dec 2025
 13:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231184711.12163-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20251231184711.12163-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 13:34:43 -0800
X-Gm-Features: AQt7F2r3FvMkanS_Kc02yR3b3z9fhG7p439EULDoQJrWc41KaD98QXyP6kRecGY
Message-ID: <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix qdisc kfunc declarations
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:47=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com>=
 wrote:
>
> The qdisc BPF selftests fail to build because qdisc-related kfuncs are
> used without proper declarations, and struct bpf_sk_buff_ptr is only
> introduced in a function prototype scope, triggering -Wvisibility and
> type mismatch errors under -Werror.
>
> Fix the build by:
>   - adding a file-scope forward declaration for struct bpf_sk_buff_ptr
>   - declaring qdisc kfuncs (bpf_qdisc_* and bpf_skb_get_hash/bpf_kfree_sk=
b)
>     as __ksym in the shared header
>   - including required BPF headers in qdisc test progs
>
> Tested: make -C tools/testing/selftests/bpf OUTPUT=3D/tmp/selftests-bpf \
> /tmp/selftests-bpf/bpf_qdisc_fifo.bpf.o \
> /tmp/selftests-bpf/bpf_qdisc_fq.bpf.o \
> /tmp/selftests-bpf/bpf_qdisc_fail__incompl_ops.bpf.o
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/progs/bpf_qdisc_common.h      | 17 +++++++++++++++++
>  .../bpf/progs/bpf_qdisc_fail__incompl_ops.c     |  4 ++++
>  .../selftests/bpf/progs/bpf_qdisc_fifo.c        |  4 ++++
>  .../testing/selftests/bpf/progs/bpf_qdisc_fq.c  |  1 +
>  4 files changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools=
/testing/selftests/bpf/progs/bpf_qdisc_common.h
> index 3754f581b328..bed2294c35f9 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> @@ -3,6 +3,9 @@
>  #ifndef _BPF_QDISC_COMMON_H
>  #define _BPF_QDISC_COMMON_H
>
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
>  #define NET_XMIT_SUCCESS        0x00
>  #define NET_XMIT_DROP           0x01    /* skb dropped                  =
*/
>  #define NET_XMIT_CN             0x02    /* congestion notification      =
*/
> @@ -14,6 +17,20 @@
>
>  struct bpf_sk_buff_ptr;
>
> +/* kfunc declarations provided via vmlinux BTF */
> +extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +                              struct bpf_sk_buff_ptr *to_free) __ksym;
> +
> +extern void bpf_qdisc_bstats_update(struct Qdisc *sch,
> +                                   const struct sk_buff *skb) __ksym;
> +
> +extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch,
> +                                       u64 expire, u64 delta_ns) __ksym;
> +
> +extern __u32 bpf_skb_get_hash(struct sk_buff *skb) __ksym;
> +
> +extern void bpf_kfree_skb(struct sk_buff *skb) __ksym;

Stop this spam.
You keep ignoring earlier feedback.

pw-bot: cr

