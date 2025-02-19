Return-Path: <bpf+bounces-51897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F1A3AF9E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE7C16E10E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E217ADE8;
	Wed, 19 Feb 2025 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5pVTEdX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF588BE8;
	Wed, 19 Feb 2025 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932349; cv=none; b=oHL3GVnhFazYdGsYgV9n9EKLB/rBn7RruK4kkVbHcO5MgW8Ikea0ZwunFOSsBSs7VKpwEYj+LsIS6TSiCet6QQyGHPymOdyr9rlE1Jqok0xjn8mlzEJT7xF2ApgVUT/34jv8OQNEMyGD63EbFl0qlNMt1dUVC1HSEaHwiow7w64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932349; c=relaxed/simple;
	bh=z9M51dpaSIM0mxPAMyrqU9vwJoyOZlNncBqC2X+7aIE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AbefxIUs8MAVEi8MkXTSTdPOGKSjZ4GDLPZLU29TlbV2dpSy1RJIzqFdDQ/o7Lx+Sp7FC+1laJlqAZTG/Yu5WCzQdlpaykLLMntlS84PcTxV2jxg0/DKk0vcDzowhlquQkzLhmdQtQz0XmmUHrOUAKAj3V1qGs8VXWhPP7TAL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5pVTEdX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fe5e0a80so14101411cf.1;
        Tue, 18 Feb 2025 18:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932347; x=1740537147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfDvaR0AoDl2E78gyaGrhEzSgJHc8QM5IA9bB7HveuI=;
        b=Y5pVTEdXvH+azQJUzJz1ykc5BX/cmvzEU6eJiDKSviN567gHf5aI/MEHxKzJ2ksUsE
         xk+82Sygg6Wp8SIaU8fcn4vedkVmVAk/RiE7mS62z4UPcINDAJsAI96PBCXbAMv6peLt
         dzAnFXZGmrWy403xbYJpgh7+P+SKmZG0yUytpc+5G+8Dl8ZJPMDxZyGuwwU211A5qcOu
         3MdK3SopwhkC8qiCaY7gWr6qCKTm7fqDSUiYqkhzvHxRokKSmIZNvJXbFaIHGUkiwk4S
         mGC8+Zs9+1Hd4xCug5win0/7raIXDxw/ik82KmARfd1chDx1QtXcHrLG8Bjw+VINdaW9
         dR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932347; x=1740537147;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AfDvaR0AoDl2E78gyaGrhEzSgJHc8QM5IA9bB7HveuI=;
        b=UDSYFz8w7LqObeqbMceZ7De0bj4lsjq8MnDcMe8OClBDQY9aI8HyCQ3gUq+YK7UB60
         q5P3atA7pj3gFH/yQwOqipO42yHzls0irCnAOST1xr7jcknsSc1yIVv049qf8pAvrKdN
         mFrRbOJ5gxG8UPLodHeKytr6cb1y7drYugktnvdIHXspZLKS4rFNPlgkVaClTvOcYaY4
         3TKY4tmCO6WXLciB0NjUYUFGV4bLJUoFJ6fNhUEDnr15JGsoHNoMiefsa426mm85+Fff
         GmU9g3ZHE6wYU1KM9JYKGNaA7BiXPdImufxcLn82F6LD1DrsMQcG4dM4XR/y3g1Y1WWy
         HboA==
X-Forwarded-Encrypted: i=1; AJvYcCVKAuExLx5oEfvSiOvEK/QuQU6v2wjRIzs2Wp+m2UP4jdrkrPTfr5S8cO8XsBnJ5u1T5+J7X7cT@vger.kernel.org, AJvYcCWKlQQv1rsewGRONXbGoYBwNiO3SDksqaRvZGVnp+THGzW04kJMKC9A3L5fRO4g8Zw/+A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1L213u0nlYSTKPSVxrSSKks0alC6uthDcBGCmxI3vHYoKe9H
	RkXhyPHYhWlpx5lDCPBXDJCfRKgQeaDkFOWVfPKH2k1OclAjzVcq
X-Gm-Gg: ASbGnct8xfdOwnkVf/hOZkMlLK/zZcvlhJl9dHC9AZ95HqiuikIVPmEaAA93gZavndb
	z/CW5qSaqFHSdVT5Y22SiCDxQLLnjdCkow/Kc3h2jnIkEVld0HqixgMtbjyFrazB/3atuPrTM5V
	1x2YUGhjnlhfFpA0Q8FdSsmsuMm12kV1GoOBvRZLV9wTgGo6jSUop6uK+Yf2PpC8G0HN5ANSjqN
	r6KNP8+oCYSvN6VSv/S2SrZqZ/fCaDfu39WJXsascWKO2LrKEZGRt4tVNbCh+MFL1cfvsPYxym2
	z133521xWTo6HTS0s67A2ypd8/CKBvlff+ZVvG1GId8bnklWr1pbpAZ9cmgHGZU=
X-Google-Smtp-Source: AGHT+IElMXNeGlC9ZlE3ImBvjhskJoIafB/wkBmYH9UOfHRvmtV5mhWnp8ju/7cnNpvZyRWMpGK0vQ==
X-Received: by 2002:a05:622a:6f05:b0:471:ef27:a314 with SMTP id d75a77b69052e-471ef27a513mr113037581cf.18.1739932346913;
        Tue, 18 Feb 2025 18:32:26 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fe6c81e4sm17443311cf.44.2025.02.18.18.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:32:26 -0800 (PST)
Date: Tue, 18 Feb 2025 21:32:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
 <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
 <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Feb 19, 2025 at 5:55=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 2/18/25 6:22 AM, Willem de Bruijn wrote:
> > > Jason Xing wrote:
> > >> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> > >> added to bpf_get/setsockopt. The later patches will implement the
> > >> BPF networking timestamping. The BPF program will use
> > >> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> > >> enable the BPF networking timestamping on a socket.
> > >>
> > >> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > >> ---
> > >>   include/net/sock.h             |  3 +++
> > >>   include/uapi/linux/bpf.h       |  8 ++++++++
> > >>   net/core/filter.c              | 23 +++++++++++++++++++++++
> > >>   tools/include/uapi/linux/bpf.h |  1 +
> > >>   4 files changed, 35 insertions(+)
> > >>
> > >> diff --git a/include/net/sock.h b/include/net/sock.h
> > >> index 8036b3b79cd8..7916982343c6 100644
> > >> --- a/include/net/sock.h
> > >> +++ b/include/net/sock.h
> > >> @@ -303,6 +303,7 @@ struct sk_filter;
> > >>     *        @sk_stamp: time stamp of last packet received
> > >>     *        @sk_stamp_seq: lock for accessing sk_stamp on 32 bit =
architectures only
> > >>     *        @sk_tsflags: SO_TIMESTAMPING flags
> > >> +  * @sk_bpf_cb_flags: used in bpf_setsockopt()
> > >>     *        @sk_use_task_frag: allow sk_page_frag() to use curren=
t->task_frag.
> > >>     *                           Sockets that can be used under mem=
ory reclaim should
> > >>     *                           set this to false.
> > >> @@ -445,6 +446,8 @@ struct sock {
> > >>      u32                     sk_reserved_mem;
> > >>      int                     sk_forward_alloc;
> > >>      u32                     sk_tsflags;
> > >> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (F=
LAG))
> > >> +    u32                     sk_bpf_cb_flags;
> > >>      __cacheline_group_end(sock_write_rxtx);
> > >
> > > So far only one bit is defined. Does this have to be a 32-bit field=
 in
> > > every socket?
> >
> > iirc, I think there were multiple callback (cb) flags/bits in the ear=
lier
> > revisions, but it had been simplified to one bit in the later revisio=
ns.
> >
> > It's an internal implementation detail. We can reuse some free bits f=
rom another
> > variable for now. Probably get a bit from sk_tsflags? SOCKCM_FLAG_TS_=
OPT_ID uses
> > BIT(31). Maybe a new SK_TS_FLAG_BPF_TX that uses BIT(30)? I don't hav=
e a strong
> > preference on the name.
> >
> > When the BPF program calls bpf_setsockopt(SK_BPF_CB_FLAGS,
> > SK_BPF_CB_TX_TIMESTAMPING), the kernel will set/test the BIT(30) of s=
k_tsflags.
> >
> > We can wait until there are more socket-level cb flags in the future =
(e.g., more
> > SK_BPF_CB_XXX will be needed) before adding a dedicated int field in =
the sock.
> =

> Sorry, I still preferred the way we've discussed already:

Adding fields to structs in the hot path is a tragedy of the commons.

Every developer focuses on their specific workload and pet feature,
while imposing a cost on everyone else.

We have a duty to be frugal and mitigate this cost where possible.
Especially for a feature that is likely to be used sparingly.

> 1) Introducing a new field sk_bpf_cb_flags extends the use for bpf
> timestamping, more than SK_BPF_CB_TX_TIMESTAMPING one flag. I think
> SK_BPF_CB_RX_TIMESTAMPING is also needed in the next move. And more
> subfeatures (like bpf extension for OPT_ID) will use it. It gives us a
> separate way to do more things based on this bpf timestamping.
> 2) sk_bpf_cb_flags provides a way to let the socket-level use new
> features for bpf while now we only have a tcp_sock-level, namely,
> bpf_sock_ops_cb_flags. It's obviously good for others.
> =

> It's the first move to open the gate for socket-level usage for BPF,

Can you give a short list of bits that you could see being used, to
get an idea of the count. In my mind this is a very short list, not
worth reserving 32 bits for. But you might have more developed plans.

> just like how TCP_BPF_SOCK_OPS_CB_FLAGS works in sol_tcp_sockopt(). So
> I hope we will not abandon this good approach :(
> =

> Now I wonder if I should use the u8 sk_bpf_cb_flags in V13 or just
> keep it as-is? Either way is fine with me :) bpf_sock_ops_cb_flags
> uses u8 as an example, thus I think we prefer the former?

If it fits in a u8 and that in practice also results in less memory
and cache pressure (i.e., does not just add a 24b hole), then it is a
net improvement.


