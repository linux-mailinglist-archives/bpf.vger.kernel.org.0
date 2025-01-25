Return-Path: <bpf+bounces-49761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB52A1C0C3
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1AF7A3F6D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7EC2063C6;
	Sat, 25 Jan 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0vWC7xM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3425A623;
	Sat, 25 Jan 2025 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737776641; cv=none; b=g/lzKf/4+JQ2jhTvVv58MYTFD7mQJG0J3TXT/0nudyseIw22TrcJMBf815fGNR/EHwVL2+OlOLKg6NbyLQ3pV4a+CRcmfkIDsFfCtw1eQysg9PqOqCD2RXDSxFZhqy4rbjcNsh75l4myH+2rTZtcceS8HjR7B/ia8ZPmCvKSABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737776641; c=relaxed/simple;
	bh=D8Uj8M3OuwehDdFEGohto7sP9twzr4Q1/8YJ0MSLbFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4tv9HmYEMVhpHGFvJloFm+Tg+AXZxr5Nl/alnJ2rpwTrqUoWwjL6/YhBlMmND5tPSCLTxqjNjgE320/tg4Pvlqq0bX1astB+ci5PK3CRr6+9CvyXiBFpaiMP7EhC6DmH7rKpTrlyPJmQSidyHvlZkgDUIPm44YJqcBnfUUwxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0vWC7xM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cf8c7b2dd5so8105915ab.0;
        Fri, 24 Jan 2025 19:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737776638; x=1738381438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP0HywNj7FbUm63qRFLpGxT4MU0gaAaTkr0ZZlHR7Is=;
        b=R0vWC7xMqq/FOnzUOs0V5k5L6Ek5YjGUdVQu0AbPA5pkaxY3ayAa74lE+4AlzXXaSs
         yTF5PyvX197tY+9lpNV1TT89dmSdnuni/HYRQnevGxvAYGPLZU163vCehemfPwf6Djtb
         odc7oFmkTsQnMSBiL8olJJDHyp+hhjM+BQ2w6uaT8wt/9cJ57nj6Arrg2RzngMtdhhac
         n7BywXA6mDG/Z90tIAiYpYNVzFO5kSUohkB6Yh9fizkFWJ0S8yMMueqWuhnvfDWfdN8a
         le+oy2sgkQknzBv9Hp1rKaWl6vBLaTctqUuHO7C5RkHJSawG3qbpt2/bnyAFZDRnZoq7
         pHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737776638; x=1738381438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP0HywNj7FbUm63qRFLpGxT4MU0gaAaTkr0ZZlHR7Is=;
        b=hQJiRQFZkebIBguTKkyXGa+6k6kgR77WN+Mrkn8lf/g5mnWOsRVV7v2m9rNi3MmYno
         iUtXZ5pPd7y7neA6PY8MZPdApvck/9Iq+qXPrTyQRt/AMTiw0dTjE5AP6MO8yvE5Pw0X
         ejFLNp2nb3e8Fv2iehtnROolbnsIf1S49daH6wguNL4yuwq89uQCIhA8/ZguaWHwKXaa
         PW3LqAhJD9JxrO6KAWMOXAoR1tIS1EkU5kuDU+PLqwJkbkdMj7A9V+Ok4/PwPsrnzc5D
         F2/z4M4cOzOe2n+eeYeahtvSSwMK0nBl/9HvLQJqy1K9HZLRUOlcWdN6JcLbyQ1OgaHX
         mA4A==
X-Forwarded-Encrypted: i=1; AJvYcCUnZyPE0+lyWYdCt32OEIxDXfkXlMHsFhojwtpVK9OP1wbfwIyfEt3R4MSaw7vcKKDXi4QI1F+5@vger.kernel.org, AJvYcCV1uuMf+D6BSW1mYAe5FMbgqDkSIU3A1duFUDD/bQxYnjVC+MD5pSnRBeWpcnR2rvjIgc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDicFh2Np4/0YRRmVUDCWJ4e5IO0hKEKvmJtt+uCpk719P5zPk
	MycLKnwFpLj5HuY2md1d8U8/rfcNKmvEb/3k8Uvyfl+HWU4Uf9HIa8z5wNalOE7eWS3tIFZQ1Nd
	yYj0k/drb8giOHAjj/G1r1pQq1tE=
X-Gm-Gg: ASbGncuj357M9wgQvZGI3PfbxNKeDJ17SlmvQd5bhLIyEUHWm1iqnTDLTAJWoEx2pfx
	W9m2yuZnnvgrEK9rktf0OH5Jgwhtv0MSdNdSrjYq6EkevDLPctKPHiAQS1EqNHg==
X-Google-Smtp-Source: AGHT+IEqLDmu1N9Jj+WmpwFiRgC/z7phFLDy81seSXCrTNSipJyriAEJTrrPLsw6Ab2FP2YoUhPhqgg/j0BFB6UIOqc=
X-Received: by 2002:a05:6e02:20c8:b0:3cf:c8ff:b5e with SMTP id
 e9e14a558f8ab-3cfc8ff0e49mr45690765ab.2.1737776638595; Fri, 24 Jan 2025
 19:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com> <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
 <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
 <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev> <5d523822-4282-442a-b816-e674ba0814ff@linux.dev>
In-Reply-To: <5d523822-4282-442a-b816-e674ba0814ff@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 11:43:22 +0800
X-Gm-Features: AWEUYZnb9DnPPt-GzYq8IdZ9ZEy2-luMrbcx7_VDcqRvzIOpEsoTJdeAIFdX2ms
Message-ID: <CAL+tcoBppGV_NrjeNUEXdamSEXH_05=J=bp2G=W42hWGWeKJgQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 11:12=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/24/25 6:25 PM, Martin KaFai Lau wrote:
> >>
> >> Sorry, I don't think it can work for all the cases because:
> >> 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_C=
B,
> >> if req exists, there is no allow_tcp_access initialization. Then
> >> calling some function like bpf_sock_ops_setsockopt will be rejected
> >> because allow_tcp_access is zero.
> >> 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
> >> fullsock. As far as I know, all the callers have the full stock for
> >> now, but in the future it might not.
> >
> > Note that the existing helper bpf_sock_ops_cb_flags_set and
> > bpf_sock_ops_{set,get}sockopt itself have done the sk_fullsock() test a=
nd then
> > return -EINVAL. bpf_sock->sk is fullsock or not does not matter to thes=
e helpers.
> >
> > You are right on the BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT=
_LEN_CB
> > but the only helper left that testing allow_tcp_access is not enough is
> > bpf_sock_ops_load_hdr_opt(). Potentially, it can test "if (!bpf_sock-
> >  >allow_tcp_access && !bpf_sock->syn_skb) { return -EOPNOTSUPP; }".
> >
> > Agree to stay with the current "bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HD=
R_OPT_CB"
> > as in this patch. It is cleaner.
>
> Also ignore my earlier comment on merging patch 3 and 4. Better keep patc=
h 4 on
> its own since it is not reusing the allow_tcp_access test. Instead, stay =
with
> the "bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB" test.

Got it!

Thanks,
Jason

