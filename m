Return-Path: <bpf+bounces-51914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD611A3B1F2
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 08:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D40A18866EE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3CB1BEF70;
	Wed, 19 Feb 2025 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcFYA5ck"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69618286285;
	Wed, 19 Feb 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948646; cv=none; b=B+EgnvFMNRFYYkCrqXjPJE4mXqsxz2NXNmSFyh6HhClQXj9YQC8PYf/gZjIxotHu08PBXT720dmAQBUKO8hgtfaL+7pLqEMWvbfjZF7zIJNB7grO5EpNiF0iIPH3ru8rVMGIQNBtxK4RkVXa66hhLOJae2+RK6CkCznDkBfv8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948646; c=relaxed/simple;
	bh=hnSlQwuSqrJuinGmr4UOFRZpf3O6I3EtKUs1XySdKxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+SF3wbiLurbNsKn7i0E7pioegISKjxf96BDCJdZbeTZv/mOizKmOoCBHogbBa3Gh7abrTnfCA8dgWzZE+AR3n8j2/PF5rJpPjdWjQQSBrIoA97Pi20i9a3bETCt85oz1dip4+6szDxiaH877uVxqi60ib8k76mxQZQA6WEm7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcFYA5ck; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso56151645ab.1;
        Tue, 18 Feb 2025 23:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739948644; x=1740553444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PT8mdB32KpYBgaAW/2vv7SoQagGzntpiOCptrArFag=;
        b=WcFYA5ckJG3WBaRocF+UoUJM3f6rsqVZPZcCzOHYcm2BoTjxAqTnoMPNZYSdjtn+ve
         rQ3x/hV/sKM4mUWhRE9d1I8fEpEWEmtdeY2W7yClavLjXYg/U31PLWk7SJzKWIKEk4i0
         tiqEwg8mn2023iR0E1Ar663662Xo50vX/++pjWM5vbk7A1QoKhgyUImBZ1GQQt6OB+vL
         cgmg+faJGrGJs3lNUOlgzfNuNEV1Mx23mgefzBR+/MvUgT4/fhxFpS67vk1jrC7QXvxv
         7sSALXL2WM1x+XqTtf1QSh23r6tzWv948wlYlUDE5W9y/hAAZLAsx2KrJSTZBZTCKuqX
         vGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948644; x=1740553444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PT8mdB32KpYBgaAW/2vv7SoQagGzntpiOCptrArFag=;
        b=kINiQ02xcyE+nROeqcmZMEUAPYlXTqEFBBLG9qsikd2LJjWmnawUsotGoFgfuLH5zU
         jRBg66TqPvx/pJa9JieyNY4BW2/jkW3QNTHxA7yC5O43ius8ofHoiOaZjbHsr+Cb6VzG
         Y09JB2/EBTMlNZIhdg6rmlXKI4m6+5uHug7tICSa5SQnXK9NG+Fo8Tmj5OPRVVLZuNI3
         ZYqHKrBSRzHq1w8QviRhW+C+6/3wAVK8vSkCOaLp/WGriLEKFarr7zx8DB96cRCWnpkp
         r+rVqTJu6KSH+gi4u+BqKnQ6V2W5qiO0ONObezV+hX2sMMzb2m7mExeE6NXkkTq+woIE
         v3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVREPtoGtN/cUhlukeHRDUjNYMarv0OchI0x0bpOy+RfE0obOIxrR4BkLDvKDbdR1xfSSVPw4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqtxC5QMsoDW8EJxtLkJWc3dTAkecYOxd2k9YI4J2/Igr0kKv
	jT6alc5P21b35XbDjVFSBhZ4j9wKOfR7toeNoaRLcKH51rCoT/VUQeh59h9EtDypcPvDHnfNSH/
	8i/QCk+NIWW/t//nQKQpTdSuek2c=
X-Gm-Gg: ASbGncuvdY2Ht3rPJCHg8lJRRivcF7S4WsQ/yY2Kl5Ve5i232LNOioXDB7HJ+Ka819s
	kVGed5WeokkGUJgx8lFQKUqGn5l7VqhnaJgD2RLzWHZy06spxbsYd3KGDsVikaMrfVcaC9bVr
X-Google-Smtp-Source: AGHT+IGXIoUI9BznYf6IgOD0DnCoBDveReAQEipdcvXOupv6kmhnAXp6qLtvx9P7rEfukKNsLnwqduuGrg9Modor8UQ=
X-Received: by 2002:a05:6e02:1aac:b0:3d1:9f4d:131 with SMTP id
 e9e14a558f8ab-3d2b529cbacmr28535245ab.1.1739948644468; Tue, 18 Feb 2025
 23:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com> <20250218050125.73676-2-kerneljasonxing@gmail.com>
In-Reply-To: <20250218050125.73676-2-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 15:03:28 +0800
X-Gm-Features: AWEUYZn0iQokQRHkQwcl25ft26garULeH8aywpCVpSAC5YmCy3_gMwpV7omHBb8
Message-ID: <CAL+tcoBtd1V-dP_ShDNOVKTyfPvcaLy9ZHz2aEDZr5vOpgwdjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:02=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> added to bpf_get/setsockopt. The later patches will implement the
> BPF networking timestamping. The BPF program will use
> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> enable the BPF networking timestamping on a socket.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/sock.h             |  3 +++
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  net/core/filter.c              | 23 +++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 35 insertions(+)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..7916982343c6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -303,6 +303,7 @@ struct sk_filter;
>    *    @sk_stamp: time stamp of last packet received
>    *    @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architecture=
s only
>    *    @sk_tsflags: SO_TIMESTAMPING flags
> +  *    @sk_bpf_cb_flags: used in bpf_setsockopt()
>    *    @sk_use_task_frag: allow sk_page_frag() to use current->task_frag=
.
>    *                       Sockets that can be used under memory reclaim =
should
>    *                       set this to false.
> @@ -445,6 +446,8 @@ struct sock {
>         u32                     sk_reserved_mem;
>         int                     sk_forward_alloc;
>         u32                     sk_tsflags;
> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> +       u32                     sk_bpf_cb_flags;
>         __cacheline_group_end(sock_write_rxtx);
>
>         __cacheline_group_begin(sock_write_tx);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fff6cdb8d11a..fa666d51dffe 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6916,6 +6916,13 @@ enum {
>         BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
>  };
>
> +/* Definitions for bpf_sk_cb_flags */

nit: s/bpf_sk_cb_flags/sk_bpf_cb_flags

I will correct it.

> +enum {
> +       SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> +       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING - =
1) |
> +                                          SK_BPF_CB_TX_TIMESTAMPING
> +};

Martin, I would like to know if it's necessary to update the above new
enum in tools/include/uapi/linux/bpf.h as well?

Thanks,
Jason

