Return-Path: <bpf+bounces-51882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85FA3ACC0
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D000F18987ED
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294F1DF254;
	Tue, 18 Feb 2025 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsUOoVj5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D61DE3D2;
	Tue, 18 Feb 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922220; cv=none; b=V6vwphG5WNeLJq49oBcZ55jJ7nRbvGVfEuS625hNE13yj+VzEyeuaFWALvIkuo7Ms38v4ZUzYBet65IRTckgVthv8TDlh7JSkCggAj/R6zFnGDGFGuOWoI71mcrkSdlK6vnwlV8Ls4zrbYZa1EqUKZjbSBr7ikmEeK8q0YrJHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922220; c=relaxed/simple;
	bh=R0mbgDEUYsAISp6DlRyjK1oSIF1vp0LJJTAv3Fm4DqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNbZcnNCmAOmzSIYMWQm/Zi3wEC5l/vx1Ka74h9Hauwh6WCY9BeX+KrZp1UVSG9XafsTaUEA6VnkTKnpYAfKQ1DSBC4NvgmstYzvhugPlQ0xFDp3SZhlGEDsgMus7Pz2eembEZqKBteR5cwU0oiYs8J6rVyKUTNG+JPEWZEB2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsUOoVj5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso53743775ab.1;
        Tue, 18 Feb 2025 15:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739922217; x=1740527017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/z5fXZ8Vib72gpFUXyR/uRzw54cXDVMxNmWLdPNKgg=;
        b=IsUOoVj5+uOvRWb7tWOyky8w1/fCRUfLkP9x96AaO+2K9ZnaOdS8X25K2HVW1HdDky
         qKTrjYhOe1TfumTNUHXuIKvQCOcyzC28EATRnCez/k6BNxOIQvlLUgWgJscTGdT8IyvK
         NHhjxOvd6TIFjHM30oJaET+iigZqGYWYAfzO1RLsG3rkcyLK5/Z2/LLXRmXQP8auvVn4
         ADQE9J2Xy7F0azugTJdmqiMgkwKPmzgWxdz3IkcBRzdt13Rh2E7ruc58I3lVBHZkrB5e
         nC8tsICEiQTwZdpDSlRE++hcW9YR8YqonyN8P+gcpiLd5vAovPSmTtEE7IKTOX4+NzFy
         C2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922217; x=1740527017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/z5fXZ8Vib72gpFUXyR/uRzw54cXDVMxNmWLdPNKgg=;
        b=oV6RAVA4oCLdxUW/l0ncE5aXedxM2F2W0fc5pFtMX8Hv4T82NC6PNpZok7CODYeGDY
         XLWtOx2JIgjSm4N/tKwuSr0Fco66aUUAE2To6cQOtpkzrmDxeGYTosRBXGxVfnO7YeC5
         NPNIGTrmlWCcoyVxIlq0BLV3EzAGxwCcFIy8S05Ssa3Hmq0P7KBo/GABRhWHbOYskBPc
         PKJgc77SetFcszbEv3sJaMDVxjApvfXZzRrkL/EOHvf0zs36A7tU3Cy+LbYX3I/scdJ4
         xwHhm9Go1xEDP23wTiMMYCnSnijlpkK5xBQFyR2Y5Zxc4sO0vc+BDzLgczvmJdRGs7x7
         mGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVBKnp3qJ/GFkbHy0sUtFCPvtb8UusvmvBzdGyg+JFc4hssARgRatljOgBYWR6plwByNfY=@vger.kernel.org, AJvYcCWwQBBCaO5MEv+C0Quaz/UduO1OimCCny+31/8AKG5B4vLzoPok1LmXRAMvyx/Ywtj6JGtmBuEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRAf2NXBtu85Nu5S4mpUTSnCfVx6VALAuaxyYG1xbztzC0VKu
	PU6NOepjsJPh2B5NdEjMLYCd6VlZ5gvTFVcDqFMdPgynsm0vrmoWs8rgeUgDv9wfshly0qCvdoB
	JKdwet/rdM3McNfz/ZVkbMCJH7XM=
X-Gm-Gg: ASbGnctzxkJTbC5OfDtVsD21a7uMkCJRXFsaZ+L/SDRSLqHD3W5Ql6dBmZ7PNnuPzvw
	mNPwMWtg3MLkT27n8/EUOyskOY9xT3JDUs9TQdPzPgZCXs4I4ojm7/IsRZBOw/rEs0LKHlybe
X-Google-Smtp-Source: AGHT+IFbJTbIZEuiy0yjtYqoNP+UFrunLpoGuSXLjw86go8CIpcUYuBRakSrjbi+zHz+MpzATohzB00H8sM9kAwrNMU=
X-Received: by 2002:a92:c54d:0:b0:3d2:6f1e:8a59 with SMTP id
 e9e14a558f8ab-3d2b536da12mr16344275ab.14.1739922217200; Tue, 18 Feb 2025
 15:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com> <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
In-Reply-To: <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 07:43:01 +0800
X-Gm-Features: AWEUYZmxaFFtHME10fmWhWTut863I6IHSHYZSYxRjAK-Zc1kAbC4IlL9eaMZs_Y
Message-ID: <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:55=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/18/25 6:22 AM, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> >> added to bpf_get/setsockopt. The later patches will implement the
> >> BPF networking timestamping. The BPF program will use
> >> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> >> enable the BPF networking timestamping on a socket.
> >>
> >> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> >> ---
> >>   include/net/sock.h             |  3 +++
> >>   include/uapi/linux/bpf.h       |  8 ++++++++
> >>   net/core/filter.c              | 23 +++++++++++++++++++++++
> >>   tools/include/uapi/linux/bpf.h |  1 +
> >>   4 files changed, 35 insertions(+)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 8036b3b79cd8..7916982343c6 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -303,6 +303,7 @@ struct sk_filter;
> >>     *        @sk_stamp: time stamp of last packet received
> >>     *        @sk_stamp_seq: lock for accessing sk_stamp on 32 bit arch=
itectures only
> >>     *        @sk_tsflags: SO_TIMESTAMPING flags
> >> +  * @sk_bpf_cb_flags: used in bpf_setsockopt()
> >>     *        @sk_use_task_frag: allow sk_page_frag() to use current->t=
ask_frag.
> >>     *                           Sockets that can be used under memory =
reclaim should
> >>     *                           set this to false.
> >> @@ -445,6 +446,8 @@ struct sock {
> >>      u32                     sk_reserved_mem;
> >>      int                     sk_forward_alloc;
> >>      u32                     sk_tsflags;
> >> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG)=
)
> >> +    u32                     sk_bpf_cb_flags;
> >>      __cacheline_group_end(sock_write_rxtx);
> >
> > So far only one bit is defined. Does this have to be a 32-bit field in
> > every socket?
>
> iirc, I think there were multiple callback (cb) flags/bits in the earlier
> revisions, but it had been simplified to one bit in the later revisions.
>
> It's an internal implementation detail. We can reuse some free bits from =
another
> variable for now. Probably get a bit from sk_tsflags? SOCKCM_FLAG_TS_OPT_=
ID uses
> BIT(31). Maybe a new SK_TS_FLAG_BPF_TX that uses BIT(30)? I don't have a =
strong
> preference on the name.
>
> When the BPF program calls bpf_setsockopt(SK_BPF_CB_FLAGS,
> SK_BPF_CB_TX_TIMESTAMPING), the kernel will set/test the BIT(30) of sk_ts=
flags.
>
> We can wait until there are more socket-level cb flags in the future (e.g=
., more
> SK_BPF_CB_XXX will be needed) before adding a dedicated int field in the =
sock.

Sorry, I still preferred the way we've discussed already:
1) Introducing a new field sk_bpf_cb_flags extends the use for bpf
timestamping, more than SK_BPF_CB_TX_TIMESTAMPING one flag. I think
SK_BPF_CB_RX_TIMESTAMPING is also needed in the next move. And more
subfeatures (like bpf extension for OPT_ID) will use it. It gives us a
separate way to do more things based on this bpf timestamping.
2) sk_bpf_cb_flags provides a way to let the socket-level use new
features for bpf while now we only have a tcp_sock-level, namely,
bpf_sock_ops_cb_flags. It's obviously good for others.

It's the first move to open the gate for socket-level usage for BPF,
just like how TCP_BPF_SOCK_OPS_CB_FLAGS works in sol_tcp_sockopt(). So
I hope we will not abandon this good approach :(

Now I wonder if I should use the u8 sk_bpf_cb_flags in V13 or just
keep it as-is? Either way is fine with me :) bpf_sock_ops_cb_flags
uses u8 as an example, thus I think we prefer the former?

Thanks,
Jason

