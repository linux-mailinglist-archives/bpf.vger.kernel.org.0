Return-Path: <bpf+bounces-43489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A527D9B5A2E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 04:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639C92843F2
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55605194A54;
	Wed, 30 Oct 2024 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaFZGDGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98F4204F;
	Wed, 30 Oct 2024 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257537; cv=none; b=TEUAy3LxNrZDff2SXD2mvkbuzm2FQ/Weq/efuy8kmsmOLU1cbzxvyXjK7Y6/wZL+EtyIX8DOu+EcM6gAGGSPJZG4uHva/JMc6ggS61IYk+VJcxQj8kQnZPC927us2Z89BwtzBohJZJSG8tdDD2A/1W2+T/5N0+Sp+wyZqAUG/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257537; c=relaxed/simple;
	bh=AxSHQnlDxqpds3xROLlFAxqu8yRYYqwT1xPoxHxsMO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmID64E1jtbBgmKlj3h1aNaxdM0Qd6Squ1CPOPhYumcnYvBfnLooNkTRWrWRWNhAH890+E/2zda/AmZre07hrWukFqGCdp48YmqNHHlbhh4slQz+lib63kCThr7H7B8fMF1IEILsrDEzdMIcgH8539YAzu7e4rGsFdKH7av4oFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaFZGDGw; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso23486015ab.1;
        Tue, 29 Oct 2024 20:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730257534; x=1730862334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1ewx3ezz+908dFuD6Q4XFZB9ARbQAa6IO3+OdAnq9E=;
        b=iaFZGDGwMgPrRNKyo12Tw2SeYaRJ/dd4V4ck626Zk502URiOOovgqvZvHtfy7A++lF
         o/yR4/bvd1lmdRwtAUoxzXBjzMlDDAiJjmv/kmeIVMIdGDxnpMZ9UC/82SS4fscGHDS8
         +ewLcIA2BuLkb4JTQR2yEeC+g47yYcmF4c4twrzHoVOFD1aiDUtE33nJoKN5X49smovv
         JUnBgZJurTfPIR2dXp8vAFAkrBCg7C97+xHXzhkVdZ2fegI0Lj55XNJNg3vdiCGGHVsP
         U2pJC8oqK90WgREtRmFbJi8NVSnlkzQCbPUR9BCVhJiaHQlh/u0U0eRAGHgjg/AIywWx
         fyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730257534; x=1730862334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1ewx3ezz+908dFuD6Q4XFZB9ARbQAa6IO3+OdAnq9E=;
        b=qVF/zfYDxVgAQ18k8RNvCqhkDglcNZXqg7xhXYJLFX5rf2wmmQ99uPIs1cxcCJm12u
         Vo91Tszrn3EIRWuGciQsd/QClCB1bmRkn6DBkcU6ad7sQy0lJ0yRGmdjXsA5e4rLQ7Uq
         ZLyL8lY/tDG4cZORXAO+xWJkZpglA5ZdhJ78YB9HF/cB0lLPXS9pA0MaB/48gO0c4M7V
         NCVbbyiVnd6F6TpjA8Di240F2du4jNA0KGfKccLa7YshdaNHZzkoNdJdaULoyexq2Wpz
         y315goW/75YX7Z/9WLUpm5YDE7Fm+UuHwmXyUNzgsXV1gPsAKFx2W3iUBQlhHVuaPE8V
         Y+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFB54AHYfmZr6ogaURqdiiVbzY9QscvblZNATVtMhYJYA9uab1WH6C8v6ifq4N5sA1vgkx1VTe@vger.kernel.org, AJvYcCXvLVvcJ4ndUjz0x+RLqC+fygsT8fcQIzhpNcQUUJUkJ86JmR1wBVDSdu97w59VfarcjTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeeUW4D2TQb6n007Ce6MSDhvd3gGJjS8FvetxJJcKMCshXi/X
	i/oqKPabhCIfnNPE6Ow5NPxTfUtwks9IQ8KYuryb5a1wasAoXDg2jaSS5duWa0q1VF1xidVMEN4
	GcbU+6Qy+Q25gnCbL7DOSJCNtzOs=
X-Google-Smtp-Source: AGHT+IGnHLvVygaMxXFiRKA4j/jQwbwMzDCU5sdnQdN49S6XzfF8Tb+Xr9yncuAh/IXHuXxu70P6L2jLfc6kZxjhL8Q=
X-Received: by 2002:a05:6e02:20c2:b0:3a0:8f20:36e7 with SMTP id
 e9e14a558f8ab-3a5e2513c38mr18892135ab.19.1730257534525; Tue, 29 Oct 2024
 20:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com> <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
In-Reply-To: <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 11:04:58 +0800
Message-ID: <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:47=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 30, 2024 at 9:45=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Wed, Oct 30, 2024 at 7:00=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On 10/28/24 4:05 AM, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > This patch has introduced a separate sk_tsflags_bpf for bpf
> > > > > > extension, which helps us let two feature work nearly at the
> > > > > > same time.
> > > > > >
> > > > > > Each feature will finally take effect on skb_shinfo(skb)->tx_fl=
ags,
> > > > > > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> > > > > > other types, so in __skb_tstamp_tx() we are unable to know whic=
h
> > > > > > feature is turned on, unless we check each feature's own socket
> > > > > > flag field.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >   include/net/sock.h |  1 +
> > > > > >   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++=
++
> > > > > >   2 files changed, 40 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > > index 7464e9f9f47c..5384f1e49f5c 100644
> > > > > > --- a/include/net/sock.h
> > > > > > +++ b/include/net/sock.h
> > > > > > @@ -445,6 +445,7 @@ struct sock {
> > > > > >       u32                     sk_reserved_mem;
> > > > > >       int                     sk_forward_alloc;
> > > > > >       u32                     sk_tsflags;
> > > > > > +     u32                     sk_tsflags_bpf;
> > > > > >       __cacheline_group_end(sock_write_rxtx);
> > > > > >
> > > > > >       __cacheline_group_begin(sock_write_tx);
> > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > index 1cf8416f4123..39309f75e105 100644
> > > > > > --- a/net/core/skbuff.c
> > > > > > +++ b/net/core/skbuff.c
> > > > > > @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk=
_buff *skb,
> > > > > >   }
> > > > > >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > > > > >
> > > > > > +/* This function is used to test if application SO_TIMESTAMPIN=
G feature
> > > > > > + * or bpf SO_TIMESTAMPING feature is loaded by checking its ow=
n socket flags.
> > > > > > + */
> > > > > > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, i=
nt tstype)
> > > > > > +{
> > > > > > +     u32 testflag;
> > > > > > +
> > > > > > +     switch (tstype) {
> > > > > > +     case SCM_TSTAMP_SCHED:
> > > > > > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > > > > > +             break;
> > > > > > +     case SCM_TSTAMP_SND:
> > > > > > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > > > > > +             break;
> > > > > > +     case SCM_TSTAMP_ACK:
> > > > > > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             return false;
> > > > > > +     }
> > > > > > +     if (tsflags & testflag)
> > > > > > +             return true;
> > > > > > +
> > > > > > +     return false;
> > > > > > +}
> > > > > > +
> > > > > >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > > > > >                                const struct sk_buff *ack_skb,
> > > > > >                                struct skb_shared_hwtstamps *hwt=
stamps,
> > > > > > @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct s=
k_buff *orig_skb,
> > > > > >       u32 tsflags;
> > > > > >
> > > > > >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > > > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > > > >
> > > > > I still don't get this part since v2. How does it work with cmsg =
only
> > > > > SOF_TIMESTAMPING_TX_*?
> > > > >
> > > > > I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not=
 return any tx
> > > > > time stamp after this patch.
> > > > >
> > > > > I am likely missing something
> > > > > or v2 concluded that this behavior change is acceptable?
> > > >
> > > > Sorry, I submitted this series accidentally removing one important
> > > > thing which is similar to what Vadim Fedorenko mentioned in the v1
> > > > [1]:
> > > > adding another member like sk_flags_bpf to handle the cmsg case.
> > > >
> > > > Willem, would it be acceptable to add another field in struct sock =
to
> > > > help us recognise the case where BPF and cmsg works parallelly?
> > > >
> > > > [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3=
b2@linux.dev/
> > >
> > > The current timestamp flags don't need a u32. Maybe just reserve a bi=
t
> > > for this purpose?
> >
> > Sure. Good suggestion.
> >
> > But I think only using one bit to reflect whether the sk->sk_tsflags
> > is used by normal or cmsg features is not enough. The existing
> > implementation in tcp_sendmsg_locked() doesn't override the
> > sk->sk_tsflags even the normal and cmsg features enabled parallelly.
> > It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
> > that, even if at some point users suddenly remove the cmsg use and
> > then the prior normal SO_TIMESTAMPING continues to work.
> >
> > How about this, please see below:
> > For now, sk->sk_tsflags only uses 17 bits (see the last one
> > SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 flags
> > (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With that
> > said, we could reserve the highest four bits for cmsg use for the
> > moment. Four bits represents four points where we can record the
> > timestamp in the tx case.
> >
> > Do you agree on this point?
>
> I don't follow.
>
> I probably miss the entire point.
>
> The goal for sockcm fields is to start with the sk field and
> optionally override based on cmsg. This is what sockcm_init does for
> tsflags.
>
> This information is for the skb, so these are recording flags.
>
> Why does the new datapath need to know whether features are enabled
> through setsockopt or on a per-call basis with a cmsg?
>
> The goal was always to keep the reporting flags per socket, but make
> the recording flag per packet, mainly for sampling.

If a user uses 1) cmsg feature, 2) bpf feature at the same time, we
allow each feature to work independently.

How could it work? It relies on sk_tstamp_tx_flags() function in the
current patch: when we are in __skb_tstamp_tx(), we cannot know which
flags in each feature are set without fetching sk->sk_tsflags and
sk->sk_tsflags_bpf. Then we are able to know what timestamp we want to
record. To put it in a simple way, we're not sure if the user wants to
see a SCHED timestamp by using the cmsg feature in __skb_tstamp_tx()
if we hit this test statement "skb_shinfo(skb)->tx_flags &
SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields to
help us.

Thanks,
Jason

