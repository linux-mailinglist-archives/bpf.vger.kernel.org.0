Return-Path: <bpf+bounces-51951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9CA3C33C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A9F188E501
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B41F419E;
	Wed, 19 Feb 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLK1Mfy9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B61F37C3;
	Wed, 19 Feb 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977977; cv=none; b=VZlgCsm5yitvWEg6kwt7xJrMHJKsWX4lAmD3H4NLifAoT8mCinJd1haGXw50wsXoLKBeHWfnDSmy6iAiVu6M1DjIzSmliiLeSiM4EgHdBUAI+k89FCwHmQ/VDZQABC0T/zaWO++nmIpuw9+6EWToUnn0aMZrJuZRYQFOM6qyIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977977; c=relaxed/simple;
	bh=4XKcl9PDsS77A34MYCKFCp67OI8caQR836vxK8sI+Sk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V2B/PSnS7My4h2LOqGjjE0wWWzIpTc5ukl6s5On8ivN62bq/b8/a+kPSHT95iQdJeqSPpAe37tiXEVqq7TwXOBsj0sWifbUBbKCkbXaGqhB/wQ4RRP/FzoTJyxHviQzC80+2Cct/SkQFQkjQC762LjJyojBkz0rG11d/9RSt4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLK1Mfy9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0155af484so32631285a.0;
        Wed, 19 Feb 2025 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977974; x=1740582774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpO+if+/loa3bPP+te0IoE6zBxpb8bPH3QpUBm0ETo8=;
        b=cLK1Mfy9/zsg0e77OdHfkVvcH1im4jMBZpEOaGAC51aen4m6rB/OwZW0cGCuWwVWv3
         vnl6nKiJTtRFijsMA17WlJzlM3cW5nfsz9/5FICcr8ngSXzkhhVuE4Dfz65cAPBDRGtO
         6WeHLQOHQnVc+UXJNmKvM9ccqjXnxv6DyD8KA/ELKVukLk8kgorRe+diFH7FL8LD2hbF
         AQPRXB/XX4AHvHST/zfj5/Faj3/17WpEtLkPv+garUUadHVVarxTKdWfoVX4MX55TCfz
         wFw/qk5jV9N1BoF8ji6qdCQojKaCvGnZrKz9zARA4LQojyihZMZH5pJhDUxbcX6MPRkZ
         YiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977974; x=1740582774;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpO+if+/loa3bPP+te0IoE6zBxpb8bPH3QpUBm0ETo8=;
        b=ieJU69Wu6Q/309+E61ZSsyMHha9sgOmfurdkPieyITN7ZsYHiCVJWWjs7OSEGYixb0
         bTVKSnXZinYFMKT4POw8fxfbY1lAqC/UfKhPxga7Ld0tPdPz+OggNkPxRzKciJ9e9qYf
         mEvKDdBsuUSDCoZMCbw3I4nKrep0DMPIDzn6N/EHM4ufoP/b9k4hDWhTuwGt8JHEUMNs
         K9AITEXeSe4865dMSwKl5Jw/zjBVOvY5Fbq4v9lSBD8Tci0zDkm9UdvyYmnJcAmiczHR
         VfH/4Ui8x8C+rjvrwWLwlySKG3Rbgx9D+DdD5W3aX1ij7jjMnj62/wyxgjhEHuJ6OPjW
         d/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVQpGml5XRmgJA9MR1Tj2k87vgIfnJunv4NXupE3xqN4iq8DtT15Py2/3LHwqhQQ3LIoHVKEcKz@vger.kernel.org, AJvYcCVk1Mrhyr1/nUjyUoUfby/rpKawk7pmbLdwhi6xsXSRzD1dKNbUNbVvCjWiZ+yY9Mfujuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUGz4llru6J70Ri4X4mboP7JbUecyXBm2I9gmcDBnm+1UzAGs
	G2X0Fue4apJI2H9qOwjW0z4UcdyTgHt2UN53cn+2lLIVIIjd4g4J
X-Gm-Gg: ASbGncu/ekpsuOh5dwkUFFk8CtUISk+q0MVg02EkW0eMccqoG2OMwvqLNXGmbiLlhMC
	cL9DgsncB70u8IXKcLjyC61JMSCTM8rQqyqBeNM3+muPysweTTUr816cq+XsTfhm/sqcC6z+rqk
	6lEEONADIiBVdoJm03fvs76Em61oyzwTYVMKrQDRuKItbiwOz+FGh4y0OL+VAxyOUtlXOQFfUxI
	8dZn5KhT+Us60U+4c/yvrGlMJHJf1RguvWzS558HHBWBKgFvgGBswip9r38Ib3wGJ6ovdKRDBIb
	aDjDjtlRaaFI7hjlXMkEVgIn17Xa7wkold3bWzcVIsPQzCQtoVsI7UdHWTBs2KU=
X-Google-Smtp-Source: AGHT+IEG6q6j15oHjc7R3Q4dcdP7o54pbY5LZO0IvcuMoglpeak4Fu/Pk1fOCobAvKLW9TyPKO2y5Q==
X-Received: by 2002:a05:620a:2a0f:b0:7c0:6976:cea3 with SMTP id af79cd13be357-7c08a9aa3f3mr2492020185a.21.1739977974469;
        Wed, 19 Feb 2025 07:12:54 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09f00e355sm366804285a.38.2025.02.19.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:12:53 -0800 (PST)
Date: Wed, 19 Feb 2025 10:12:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b5f4f5990b0_1b78d829412@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCHsJ9KQf5w6TLHmQy9DrkhPHChRPQb=+9L_WKTTd8FQA@mail.gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
 <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
 <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
 <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch>
 <CAL+tcoCHsJ9KQf5w6TLHmQy9DrkhPHChRPQb=+9L_WKTTd8FQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > Now I wonder if I should use the u8 sk_bpf_cb_flags in V13 or just
> > > keep it as-is? Either way is fine with me :) bpf_sock_ops_cb_flags
> > > uses u8 as an example, thus I think we prefer the former?
> >
> > If it fits in a u8 and that in practice also results in less memory
> > and cache pressure (i.e., does not just add a 24b hole), then it is a
> > net improvement.
> 
> Probably I didn't state it clearly. I agree with you on saving memory:)
> 
> In the previous response, I was trying to keep the sk_bpf_cb_flags
> flag and use a u8 instead. I admit u32 is too large after you noticed
> this.
> 
> Would the following diff on top of this series be acceptable for you?
> And would it be a proper place to put the u8 sk_bpf_cb_flags in struct
> sock?
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 6f4d54faba92..e85d6fb3a2ba 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -447,7 +447,7 @@ struct sock {
>         int                     sk_forward_alloc;
>         u32                     sk_tsflags;
>  #define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> -       u32                     sk_bpf_cb_flags;
> +       u8                      sk_bpf_cb_flags;
>         __cacheline_group_end(sock_write_rxtx);
> 
>         __cacheline_group_begin(sock_write_tx);
> 
> The following output is the result of running 'pahole --hex -C sock vmlinux'.
> Before this series:
>         u32                        sk_tsflags;           /* 0x168   0x4 */
>         __u8
> __cacheline_group_end__sock_write_rxtx[0]; /* 0x16c     0 */
>         __u8
> __cacheline_group_begin__sock_write_tx[0]; /* 0x16c     0 */
>         int                        sk_write_pending;     /* 0x16c   0x4 */
>         atomic_t                   sk_omem_alloc;        /* 0x170   0x4 */
>         int                        sk_sndbuf;            /* 0x174   0x4 */
>         int                        sk_wmem_queued;       /* 0x178   0x4 */
>         refcount_t                 sk_wmem_alloc;        /* 0x17c   0x4 */
>         /* --- cacheline 6 boundary (384 bytes) --- */
>         long unsigned int          sk_tsq_flags;         /* 0x180   0x8 */
> ...
> /* sum members: 773, holes: 1, sum holes: 1 */
> 
> After this diff patch:
>         u32                        sk_tsflags;           /* 0x168   0x4 */
>         u8                         sk_bpf_cb_flags;      /* 0x16c   0x1 */
>         __u8
> __cacheline_group_end__sock_write_rxtx[0]; /* 0x16d     0 */
>         __u8
> __cacheline_group_begin__sock_write_tx[0]; /* 0x16d     0 */
> 
>         /* XXX 3 bytes hole, try to pack */
> 
>         int                        sk_write_pending;     /* 0x170   0x4 */
>         atomic_t                   sk_omem_alloc;        /* 0x174   0x4 */
>         int                        sk_sndbuf;            /* 0x178   0x4 */
>         int                        sk_wmem_queued;       /* 0x17c   0x4 */
>         /* --- cacheline 6 boundary (384 bytes) --- */
>         refcount_t                 sk_wmem_alloc;        /* 0x180   0x4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         long unsigned int          sk_tsq_flags;         /* 0x188   0x8 */
> ...
> /* sum members: 774, holes: 3, sum holes: 8 */
> 
> It will introduce 7 extra sum holes if this series with this u8 change
> gets applied. I think it's a proper position because this new
> sk_bpf_cb_flags will be used in the tx and rx path just like
> sk_tsflags, aligned with rules introduced by the commit[1].

Reducing a u64 to u8 can leave 7b of holes, but that is not great,
of course.

Since this bitmap is only touched if a BPF program is loaded, arguably
it need not be in the hot path cacheline groups.

Can you find a hole further down to place this in, or at least a spot
that does not result in 7b of wasted space (in the hotpath cacheline
groups of all places).

