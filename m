Return-Path: <bpf+bounces-52008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF387A3CDFD
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C281897C2F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D323A0;
	Thu, 20 Feb 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck4uHcUR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5936B;
	Thu, 20 Feb 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009890; cv=none; b=onHVxfBkFwVpF55ISZOJ7NG+BQbX10P52NGLG26LAqdU2wrCRuCmx+VjmcIc9LaqFrNsY1dNil1EBCtYc/WK/A+6O+Lv301KhN4Bci+5tXPouh9zO+uU8fGxo37p7p9vlpIVNkOr+xhV1Isqr+YEGphe+6HuoSrw8iiIXuWlLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009890; c=relaxed/simple;
	bh=Vl8tWInZJseNtInJuez3V99KpCeOMUIfeG0NOtne1GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYPAAnhlLrK/M0FP74hmHXv2hWi7T/ALK0prDusoMulDB8U/dGx5coe9SuN56bQv1gRc9oCJOlFIQSKLoUU18yfqDpRyPtvjNQL0eU6Wn0doELGnO5KlhDgA92WUrWzxfWqy9uy2ByLNDRyKX/UMIcByhdJQ6Efzp1IQf78wRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck4uHcUR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d19e40a891so1065175ab.3;
        Wed, 19 Feb 2025 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009887; x=1740614687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKsDdYIRIIUwFa6KIwVsLiipV07cDi3c32LHexL5qS8=;
        b=Ck4uHcUR/lXE/x9Qfosc6kI+iwiY+KwKe+shToS/pAA4D4G3aWP1+bpF1nsX/adAne
         GOVB/rInfRqcyDkvuSEb0RgiptALNMzrcGTBR6NSiwgsMGSZjfOjA422Tbo2cSNTmIlu
         Vu+gHfyXJMG85XWSi1t+Y099drYsZr7SMi9AU/3auW2V4BR+aMUtuza2JT1hIOdqs9yC
         DKw1KLHvhWA9KPSRQCqom6lRahKuBAlXo3/umLd8+UAH6awrsaap1w3oMVGk9F0F1yDS
         /bK+F39HUTFWL6GsucG5JMgLZMrS6moGpa3ktRKw5i2+7PuZGFgbwWUEM+VuOykHru3N
         izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009887; x=1740614687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKsDdYIRIIUwFa6KIwVsLiipV07cDi3c32LHexL5qS8=;
        b=RJmk1pLpIJf6/wjSEPCZKmvzNemFMbFvIhdzfDPFbXRAYU1rivfLZ3fAv+paC9QtQK
         IakSdgx3dS1LYvpOjePsVF9Tj3UjvI43l5Cjq9ssy2LJ/CVc5oPwhhkCCu1HP+DcF+QY
         CldxQajyJpcIpv3MITutpThraIt13WASTcVjhuwxPIiiCoCYDkCwqZZOAeJvqr9zCkqw
         /LwDOKmgQfcby+Fwwjo1hjKp5WyTGoF8Zfy5gQ2QqrNX+7YUfLsv16x7Ap+SXXTyqjbF
         FJcpQBqz9m/8DrHF/pKGw4anbnHcrf+58JCofvyHHOlLY5TqC9Cem/SQQ1f4BAMahO8i
         Dnag==
X-Forwarded-Encrypted: i=1; AJvYcCVd6y5vmg1RlJB3o96c5kDuSNu/E2sKVARtDw8O3Vy4d+p3zCic3laosUeCsxmvNCM68e5nxb+y@vger.kernel.org, AJvYcCW+ALp077V5IyIdGTck+ZovbT0Ha8HMBoqXu5JgW0myfW0RMzl0uqpKmUdKHHvU2xd33y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+o2yTJCQEVs+ZWbaGgCJqKjUSYD4HZlk9K8c/7dmTupABe5y
	BLvTfWZQyjvXrICwgiI/Obkw9WqDougPDATz/rm4SlLO4OX9hJZi+EAJrPeGFgOmPhcU/mDVQFg
	n9+3RN+lS4D2lNoYK/2AkpFrg2yg=
X-Gm-Gg: ASbGnctOn9wm48tEru02Llrrmoxcqhr65gF6B7135DlNU3AB9OJnmDxJsVp6+Pig/Ol
	AJgp9ibY6HY1X2JFYQKoFE0NLpSWoE3n2vGDXDk2/xgUkcF5A9qBBKIlLFWEt04TYy7ReWVgt
X-Google-Smtp-Source: AGHT+IHA2tXemJRjuNQbYmgSAohhUwBEzASDc7dzU31eACLRCvja67vIaHl62RdmIK/ezd7BySOhrIDwrMYkTH6wvLk=
X-Received: by 2002:a05:6e02:19c8:b0:3d0:1db8:e824 with SMTP id
 e9e14a558f8ab-3d2807fd1e2mr177358335ab.10.1740009887496; Wed, 19 Feb 2025
 16:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com> <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev> <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
 <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch> <CAL+tcoCHsJ9KQf5w6TLHmQy9DrkhPHChRPQb=+9L_WKTTd8FQA@mail.gmail.com>
 <67b5f4f5990b0_1b78d829412@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b5f4f5990b0_1b78d829412@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 08:04:11 +0800
X-Gm-Features: AWEUYZm6MA2i2P9HrhrdvmIXWmJOf8zA28Hh35NE8BQaIBtKRKUYnEecU6yC94k
Message-ID: <CAL+tcoCJNM3YyLQpFCCUtHPN7dU+o721yBYE71+hs9-1r937Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:12=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > Now I wonder if I should use the u8 sk_bpf_cb_flags in V13 or just
> > > > keep it as-is? Either way is fine with me :) bpf_sock_ops_cb_flags
> > > > uses u8 as an example, thus I think we prefer the former?
> > >
> > > If it fits in a u8 and that in practice also results in less memory
> > > and cache pressure (i.e., does not just add a 24b hole), then it is a
> > > net improvement.
> >
> > Probably I didn't state it clearly. I agree with you on saving memory:)
> >
> > In the previous response, I was trying to keep the sk_bpf_cb_flags
> > flag and use a u8 instead. I admit u32 is too large after you noticed
> > this.
> >
> > Would the following diff on top of this series be acceptable for you?
> > And would it be a proper place to put the u8 sk_bpf_cb_flags in struct
> > sock?
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 6f4d54faba92..e85d6fb3a2ba 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -447,7 +447,7 @@ struct sock {
> >         int                     sk_forward_alloc;
> >         u32                     sk_tsflags;
> >  #define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> > -       u32                     sk_bpf_cb_flags;
> > +       u8                      sk_bpf_cb_flags;
> >         __cacheline_group_end(sock_write_rxtx);
> >
> >         __cacheline_group_begin(sock_write_tx);
> >
> > The following output is the result of running 'pahole --hex -C sock vml=
inux'.
> > Before this series:
> >         u32                        sk_tsflags;           /* 0x168   0x4=
 */
> >         __u8
> > __cacheline_group_end__sock_write_rxtx[0]; /* 0x16c     0 */
> >         __u8
> > __cacheline_group_begin__sock_write_tx[0]; /* 0x16c     0 */
> >         int                        sk_write_pending;     /* 0x16c   0x4=
 */
> >         atomic_t                   sk_omem_alloc;        /* 0x170   0x4=
 */
> >         int                        sk_sndbuf;            /* 0x174   0x4=
 */
> >         int                        sk_wmem_queued;       /* 0x178   0x4=
 */
> >         refcount_t                 sk_wmem_alloc;        /* 0x17c   0x4=
 */
> >         /* --- cacheline 6 boundary (384 bytes) --- */
> >         long unsigned int          sk_tsq_flags;         /* 0x180   0x8=
 */
> > ...
> > /* sum members: 773, holes: 1, sum holes: 1 */
> >
> > After this diff patch:
> >         u32                        sk_tsflags;           /* 0x168   0x4=
 */
> >         u8                         sk_bpf_cb_flags;      /* 0x16c   0x1=
 */
> >         __u8
> > __cacheline_group_end__sock_write_rxtx[0]; /* 0x16d     0 */
> >         __u8
> > __cacheline_group_begin__sock_write_tx[0]; /* 0x16d     0 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         int                        sk_write_pending;     /* 0x170   0x4=
 */
> >         atomic_t                   sk_omem_alloc;        /* 0x174   0x4=
 */
> >         int                        sk_sndbuf;            /* 0x178   0x4=
 */
> >         int                        sk_wmem_queued;       /* 0x17c   0x4=
 */
> >         /* --- cacheline 6 boundary (384 bytes) --- */
> >         refcount_t                 sk_wmem_alloc;        /* 0x180   0x4=
 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         long unsigned int          sk_tsq_flags;         /* 0x188   0x8=
 */
> > ...
> > /* sum members: 774, holes: 3, sum holes: 8 */
> >
> > It will introduce 7 extra sum holes if this series with this u8 change
> > gets applied. I think it's a proper position because this new
> > sk_bpf_cb_flags will be used in the tx and rx path just like
> > sk_tsflags, aligned with rules introduced by the commit[1].
>
> Reducing a u64 to u8 can leave 7b of holes, but that is not great,
> of course.
>
> Since this bitmap is only touched if a BPF program is loaded, arguably
> it need not be in the hot path cacheline groups.

Point taken.

>
> Can you find a hole further down to place this in, or at least a spot
> that does not result in 7b of wasted space (in the hotpath cacheline
> groups of all places).

There is one place where I can simply insert the flag.

The diff patch on top of this series is:
diff --git a/include/net/sock.h b/include/net/sock.h
index e85d6fb3a2ba..9fa27693fb02 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -446,8 +446,6 @@ struct sock {
        u32                     sk_reserved_mem;
        int                     sk_forward_alloc;
        u32                     sk_tsflags;
-#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
-       u8                      sk_bpf_cb_flags;
        __cacheline_group_end(sock_write_rxtx);

        __cacheline_group_begin(sock_write_tx);
@@ -528,6 +526,8 @@ struct sock {
        u8                      sk_txtime_deadline_mode : 1,
                                sk_txtime_report_errors : 1,
                                sk_txtime_unused : 6;
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+       u8                      sk_bpf_cb_flags;

        void                    *sk_user_data;
 #ifdef CONFIG_SECURITY


1) before applying the whole series:
...
        /* --- cacheline 10 boundary (640 bytes) --- */
        ktime_t                    sk_stamp;             /* 0x280   0x8 */
        int                        sk_disconnects;       /* 0x288   0x4 */
        u8                         sk_txrehash;          /* 0x28c   0x1 */
        u8                         sk_clockid;           /* 0x28d   0x1 */
        u8                         sk_txtime_deadline_mode:1; /* 0x28e: 0 0=
x1 */
        u8                         sk_txtime_report_errors:1; /*
0x28e:0x1 0x1 */
        u8                         sk_txtime_unused:6;   /* 0x28e:0x2 0x1 *=
/

        /* XXX 1 byte hole, try to pack */

        void *                     sk_user_data;         /* 0x290   0x8 */
        void *                     sk_security;          /* 0x298   0x8 */
        struct sock_cgroup_data    sk_cgrp_data;         /* 0x2a0  0x10 */
...
/* sum members: 773, holes: 1, sum holes: 1 */


2) after applying the series with the above diff patch:
...
        /* --- cacheline 10 boundary (640 bytes) --- */
        ktime_t                    sk_stamp;             /* 0x280   0x8 */
        int                        sk_disconnects;       /* 0x288   0x4 */
        u8                         sk_txrehash;          /* 0x28c   0x1 */
        u8                         sk_clockid;           /* 0x28d   0x1 */
        u8                         sk_txtime_deadline_mode:1; /* 0x28e: 0 0=
x1 */
        u8                         sk_txtime_report_errors:1; /*
0x28e:0x1 0x1 */
        u8                         sk_txtime_unused:6;   /* 0x28e:0x2 0x1 *=
/
        u8                         sk_bpf_cb_flags;      /* 0x28f   0x1 */
        void *                     sk_user_data;         /* 0x290
0x8 */
        void *                     sk_security;          /* 0x298   0x8 */
        struct sock_cgroup_data    sk_cgrp_data;         /* 0x2a0  0x10 */
...
/* sum members: 774 */

It turns out that the new sk_bpf_cb_flags fills the hole exactly. The
new field and some of its nearby fields are quite similar because they
are only/nearly written during the creation or setsockopt phase.

I think now it's a good place to insert the new flag?

Thanks,
Jason

