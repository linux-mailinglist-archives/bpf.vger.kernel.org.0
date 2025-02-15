Return-Path: <bpf+bounces-51667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB64A36F5B
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E169B170F65
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5C1DF990;
	Sat, 15 Feb 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My/ekh+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE21AAA1B;
	Sat, 15 Feb 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636314; cv=none; b=Cg5SZQ/IKSY5tWgF460nppmybBQrQO/vzLe7N/U/d/+d+HblCMzQJ0lhvwWjZADobI0POQUOd/34ixeKgBhTwcHLZOeLTBLOTJojsydH6ecOCQqfefyJ7MzKcLJCuurGK878YyOWt8ELwdsqtX4Y7kMtNKVm6OF/naS/FuHep4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636314; c=relaxed/simple;
	bh=iC1TQ9O1uGiS5HFNz2KXR5h9goxCftLgQoIBduzT8PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlKfKWpgJZTWag2NaFhxirkzg0cPiGLmjDbARq+tLduVGVnmH0Gae9ACEmtCbU57jBzqX2EUijH4Am1CPPinZPKWiiYhp8Sftaikb+/1B6ZWOj67HrHSKox21eZ7S3OiNCWuiQsmq9XQJiCkrTL/Dfyh1JVZtuQVFqIoYFUpQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My/ekh+U; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce85545983so7954975ab.0;
        Sat, 15 Feb 2025 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739636312; x=1740241112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+kHc6Pqb6VKTUdCKeSLYOZ3ZR0nTbqDWcmbUXyrCSc=;
        b=My/ekh+UPi7vw5knYCH1yLXD3BI6Yh4GCkO6q7wkpHtP4fLHofwqYMtnydep0gBfWG
         vZuerLbkW/iStCtVJpnLnjsyPVN4c0dVRCtJSDe9gHR7W0+2uDUULxDY2U7+17yGGFuD
         wvgjmZnH1R3X9WaBZqfMkJAljt91pjeo076PbAZIROy6yUv8dOrg5PEfCKLkn89FekfP
         6wizo8gOYv5o6HNsjXMbRFXM8jq6cERk3IB+S8q4LWtPPjwLUcFjtFBFHEIoqTx2aKi6
         y5eN8uaYutqpeNiSks4KRgfc5rzIjELmnPIi8WqhqJk4cQ8Tva1WLx9Js1ge/zJjjb22
         Uw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636312; x=1740241112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+kHc6Pqb6VKTUdCKeSLYOZ3ZR0nTbqDWcmbUXyrCSc=;
        b=bsRYzR5Pt7HUM8UuhGnCCsgdnNS0NxXDH02IN7swI3FG0ccNSaoTos4Tj2MlplInRH
         Or30JGGE959Z7nJ0ZMjCRr8gU4QkNwCmmVMH0KhuCCg6Edzoa+gy/8G8A5+0b6TpdOwi
         M9stQ7ogSBg2gc6o0TsaFLT3oQz/eFUccY9/o++OivZG8dv6wPZXNb6e6yzdCnTO87pp
         olMqRGiQ1lRa7RFB0JF5UJmGUuuwU8D/2hW4yAgINIj3Lw9qXRb8f/xQxcSdk3wZpk9/
         31C2uh1O10Z4XxJNxfIth8rDIxeq6nN7eCR7URfJPbhDeRpb1g9ZWF5Q+lany5BkwpkL
         E5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVSjVb6l0Wk9f17DzrflY5cU25sxPkULyNzcSc/aMPbnmoft5CBhjj8J6pR+whFhOe2yTY=@vger.kernel.org, AJvYcCXqy1nHasVlnykM260zoQOCRlJeMG2kAgsPqxxf4pno4q05hsau9BhhpRqLoh9yQ4PzpR2r8z2X@vger.kernel.org
X-Gm-Message-State: AOJu0YwrraGuOA8Ivrus5CGOla8X0dm5SCNQesr6D2uF6daiTu1vSEMb
	q4Voe4smqFDktVHOqAC0c2+uA8XVziBm6faxXa5rf5lqKHg0zqLXbiFn26rVNwR9uUFIFVY320k
	8IzQWfv4pMHfmw44bnRBL27aPu3M=
X-Gm-Gg: ASbGncv+qxDZQne/RDWf57m6uQdHOdnzN6+GsO9r5GML43J8wlYoVpWT/EU1L0OL2bU
	g4najSFXykQe4bmSPqZyaqMpo73h/EnOgYULla63iFd5aYawV5EOsngqfRTh5wlsIxuE5xjI=
X-Google-Smtp-Source: AGHT+IHZISV9yKfvzSFlI/H8LM5WVW2SbAFJ33ZvQt5DwLeYgOUri0cHfXfJJ/oQlbNSmCh7AgHdJXBgFN66OUK8iAQ=
X-Received: by 2002:a05:6e02:1d1a:b0:3d2:8bbc:8514 with SMTP id
 e9e14a558f8ab-3d28bbc8752mr5146355ab.9.1739636312156; Sat, 15 Feb 2025
 08:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-12-kerneljasonxing@gmail.com> <67b0ae562fc79_36e344294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b0ae562fc79_36e344294ab@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 00:17:56 +0800
X-Gm-Features: AWEUYZkMZ0U592zonr2w37wNDnB2ijG78bN6RfwZbjiw0pqT0HHgyfROrr4XM50
Message-ID: <CAL+tcoC=PROxQfPoa_LGJZ0JAPW1XuqSnTTHwJssjsC7-MPV_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/12] bpf: support selective sampling for
 bpf timestamping
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 11:10=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
> > selectively enable TX timestamping on a skb during tcp_sendmsg().
> >
> > For example, BPF program will limit tracking X numbers of packets
> > and then will stop there instead of tracing all the sendmsgs of
> > matched flow all along. It would be helpful for users who cannot
> > afford to calculate latencies from every sendmsg call probably
> > due to the performance or storage space consideration.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  kernel/bpf/btf.c  |  1 +
> >  net/core/filter.c | 33 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 9433b6467bbe..740210f883dc 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_p=
rog_type prog_type)
> >       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> >       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> >       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > +     case BPF_PROG_TYPE_SOCK_OPS:
> >               return BTF_KFUNC_HOOK_CGROUP;
> >       case BPF_PROG_TYPE_SCHED_ACT:
> >               return BTF_KFUNC_HOOK_SCHED_ACT;
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7f56d0bbeb00..3b4c1e7b1470 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12102,6 +12102,27 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >  #endif
> >  }
> >
> > +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern=
 *skops,
> > +                                           u64 flags)
> > +{
> > +     struct sk_buff *skb;
> > +     struct sock *sk;
> > +
> > +     if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     skb =3D skops->skb;
> > +     sk =3D skops->sk;
>
> nit: not used

BPF programs can use this in the future if necessary whereas the
selftests don't reflect it.

>
> > +     skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> > +     TCP_SKB_CB(skb)->txstamp_ack |=3D TSTAMP_ACK_BPF;
> > +     skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
>
> Can this overwrite the seqno previously calculated by tcp_tx_timestamp?

seqno? If you are referring to seqno, I don't think the BPF program is
allowed to modify it because SOCK_OPS_GET_OR_SET_FIELD() only supports
overwriting sk_txhash only. Please see sock_ops_convert_ctx_access().

Thanks,
Jason




>
> I suppose that that is safe as long as both calculate the same value.
> But good to have explicit.
>
> > +
> > +     return 0;
> > +}
> > +

