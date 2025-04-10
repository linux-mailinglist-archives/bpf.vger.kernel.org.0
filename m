Return-Path: <bpf+bounces-55699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC52A85058
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BB8C58E3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA13215162;
	Thu, 10 Apr 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO1JSl2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183533F6;
	Thu, 10 Apr 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329582; cv=none; b=ZwfcCBPI+HITelLI1Te+AGy+mn7gi1hW8e+opkH4OQFOPfDJq7JqCLZTy4G2mFuxdmbPWf+QrNUJI6gZw3fSDpC+T4YWg4ekHqI0LEqTTyft/CzIVQFqt9KvvC9Okd29/vN/EJlV4YPILnLoBxmeOzvCEDJuVKhAK6o1AuRCm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329582; c=relaxed/simple;
	bh=NpMzC4bxrHM5/0DEy2dml80E7Z/i+oiDT38P+VwDOCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O71xFH7F5YzUT2yKi5cfrF0DCUa9r91iWkReqU2vwNF9TZBTCX8BzZC0VUeUlROAvl/srCD2Dlkm9zKcA/r46Ze90nUxPMVz5upoxFKrYWQ2CagICHlla++hqeMeZtH90WE0wCkClb5uk43A9ldWrCLhnBFkntUjt69Dl+i0CnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO1JSl2C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso19386715ad.1;
        Thu, 10 Apr 2025 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744329580; x=1744934380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0e0WM8vtJ64W1/jIHavRDlAQ+FhQ1fuLmsSbX/9KkQ=;
        b=DO1JSl2CNJN4lBtZlhZSW9vJkFbb0kHdGg6f+pK0btiIAM8m7Z/8pycy74NTVm2+Kh
         nb+6H7uOXv6Pg34fFnLqEBmaMA/rarUShajj1gHCueOeLx3vJDK3GHjF3cK4v2fLx77n
         s+LuhKqSB2tPVGTL7EzAzcpXV2hDFoRndit4C7Qqcs+9+gbJ0R3LVixz/kRx7sBfXE7o
         U2EfCOXvyavnwqdk6iQvigpDEAQtSHT9uGS/fDdCS2cuYmFazFOaKp/LpsouVltr28Qz
         QfkccS5HPdiOHRVVUnruClENm305RcPzBZGwFXcZm5jXFxpLdTr0/aDY3koDJKnvpp7D
         5rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744329580; x=1744934380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0e0WM8vtJ64W1/jIHavRDlAQ+FhQ1fuLmsSbX/9KkQ=;
        b=jjyW37vnTTs2fH6+mr5iRmfclIW4hoRSU1CSJPyQIwO7+zs8w8FOD0wokawBKagDuB
         1rWL/JQpiURhbyvkGI66TMuU8XNW+SKXemgqePr0GtMsZAgbEMLuCyiwgvoflimjWrrB
         D+ttdJI27UfUcCIUiJZS7IvATjwMWtUZGpVvKQbtK0qtQzUfpif731V6vo2UA58MGc6h
         ujYPug5Sgl7+tcS80Y1X+QzVzm9llbvjrlwgn87UbgSwBxeH/+iaCsP7AAcC+76qleDo
         PizsPz4WRw7/HCFXF+2/g3KjflYtX5CSuvw9f8f6WtyYVZWGmM3R1RguaQoxAKjN8jvg
         i8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnzUW3Lkfuxy7dUEaNjvaDzQoQ4mzOFwetHOED/LN9q6jPcblKwRfX1cOb+8ehjoQQIY5+OVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrJNfF/6gXuPwIknqW5ERl4SOzsUqNv38cC3H9poDQ07cYVJ8
	GywTn/K5qQfbfqA+hPPcRL2/NoxlC6v3uKx9TXra3Q8D33bRpLwt7DHKcH/N+Kvx7QxQZIR2jPB
	2gr2uVCNN7MkMtgFRk3v55mOd1rA=
X-Gm-Gg: ASbGncuIx6S55KGvUZiHMppJNdZQ3zVnskYpkot4NOgWQKMGJEPmODC8LgjDgkgteW8
	hfQLZfcemYAxFxYvoDuRr5eJWE+zYf1WE5gDAZpNXSHuZT+wuCpioHb/2idCMRwUqIzhzIbTtFP
	rmENHH/Rgjbe6SL7Ro3nDCYlcwEANRRx4yhEBOx3oj9fYXNS915tQebQ==
X-Google-Smtp-Source: AGHT+IEbzlWaBNK3jwdPCBvmqtrUOg0FY0nYVKsZdsPiDar4idFKXp3Txc5W9/x1jxyM4+SPKOCuGoc1yM5pHaSf4Xo=
X-Received: by 2002:a17:902:e5cf:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22bea4efe58mr13011205ad.40.1744329579898; Thu, 10 Apr 2025
 16:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-9-ameryhung@gmail.com>
In-Reply-To: <20250409214606.2000194-9-ameryhung@gmail.com>
From: Martin KaFai Lau <iamkafai@gmail.com>
Date: Thu, 10 Apr 2025 16:59:28 -0700
X-Gm-Features: ATxdqUGJ6rf4pW_gXIyc7fpudX-AzAL_WnK3X810WKjsMuPpCGki0YZAvOz8iPI
Message-ID: <CABx7vpW8mCNpoCCDwJyWAXM1atSxfbc6O-su3g6BQA-GmzOm4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 08/10] selftests/bpf: Add a basic fifo qdisc test
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:49=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
> +void test_bpf_qdisc(void)

nit. re-name to "test_ns_bpf_qdisc"....

> +{
> +       struct netns_obj *netns;
> +
> +       netns =3D netns_new("bpf_qdisc_ns", true);

... then this can be saved.

> +       if (!ASSERT_OK_PTR(netns, "netns_new"))
> +               return;
> +
> +       if (test__start_subtest("fifo"))
> +               test_fifo();
> +
> +       netns_free(netns);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools=
/testing/selftests/bpf/progs/bpf_qdisc_common.h
> new file mode 100644
> index 000000000000..65a2c561c0bb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BPF_QDISC_COMMON_H
> +#define _BPF_QDISC_COMMON_H
> +
> +#define NET_XMIT_SUCCESS        0x00
> +#define NET_XMIT_DROP           0x01    /* skb dropped                  =
*/
> +#define NET_XMIT_CN             0x02    /* congestion notification      =
*/
> +
> +#define TC_PRIO_CONTROL  7
> +#define TC_PRIO_MAX      15
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
> +
> +u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
> +void bpf_kfree_skb(struct sk_buff *p) __ksym;
> +void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_fr=
ee) __ksym;
> +void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delt=
a_ns) __ksym;
> +void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *sk=
b) __ksym;

nit. These kfunc declarations should be no longer needed. vmlinux.h
should already have them. Update pahole if vmlinux.h does not have
them.

The set has been applied. Please consider following up the nits in
selftests. Thanks.

