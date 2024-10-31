Return-Path: <bpf+bounces-43627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B38859B72DC
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 04:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23307B233D7
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 03:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1913A3FF;
	Thu, 31 Oct 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB5rDApr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0355136E01;
	Thu, 31 Oct 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730345263; cv=none; b=D3Br5k1E8oePDXSg3cBv88H5GV1IUbkzoSU1kguFzbgPeiJRoi/4RnJFtdJBcTtg/pruigD5DlIr01+Qqf8yADGl3Za94MJfHeX62QwqotIM9SPcO6KIdl82yMDmshyvfNIwxzt2Ev3v7DCpNd6MXWLFaIC4yYmXPlsfTlbk4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730345263; c=relaxed/simple;
	bh=y+P5qNNjgWJ/+Pfne+CdTEZ/vHKoOjz0ivT+iEg0xeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+FmAfcKMp/nQoSHIoB0V4C8h+ve/E3SfFnSd9wl41TRO25sHCNz3NaKbkC9dZaRwgfiFgOpZhmupfO3NTy3w6dVUKelf3+53WvvjPK1CwOn/XpRzbyF2SV32Fh1XaJhbxUgn/JH/uYv18Cqqa+sN781YjGlo/7hi/sfAdRvq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB5rDApr; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so1967385ab.0;
        Wed, 30 Oct 2024 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730345260; x=1730950060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWLJV/0FRlvOz7gSNZv3wvOPEwVqXryA0U9Tjb985Ps=;
        b=aB5rDAprMRJnztn4wiXPRZmAYtTfoqGXq0/YDI/Yym7upGSDoQ/tF24kwtKUAmS6EK
         9ctA3bLqpwcm/Mumjprs1ONraE2JGE6Jjw9ASJ5BpqnhvB+XEqw10oaqBrl7S/aZy9TF
         ydXsXr5f1TiMqtb/NKIMORCoKRONDnW+wheM3TiX1QxWrCveyNHN7jYkCYn49G6N/aYF
         FZHZquS44TO0EEeE9pvaglYZyWX94pDncUoEtBrVuRbLeV5e7zOJrHaTsErJU5r6fMbF
         1v8vDF9cdGDqPR6kguBtXgnHjlVjHPJemrMbewo7EmhYo57Q/P2k6KxI8rgGPNkmyml8
         mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730345260; x=1730950060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWLJV/0FRlvOz7gSNZv3wvOPEwVqXryA0U9Tjb985Ps=;
        b=j+cax7x3BlWOrO2X4kzyQj+uilSmaTBhv1WzXPJfxpzxEJkfFuufW4T1rSSiuVCxH2
         czuZcTAdIKD1Jg1+jTNSu3ScQlbmC5RdDB9n7tZYsn4e2ZARAZXJtRc59rZe5XU8CKYN
         fR9w43H1sZjgByRFEDYgDLz8mwr3D4sYVrJlaDugGk7mRSuuBIML0VsMpdCilI5HeN7Q
         7P1KHMFGYXDWUKN+8W7JveQQZfvJ//GeNqOpecvX6Q5NV1GFAhRh2c/HQVufDzrjN2rE
         8TJd2e4H9cV4U6JRMYMnwd5py9IL8Zq5NHmVPVPhJXhuhBjhVrNJu+KYrwxLjASb1o8E
         PMCw==
X-Forwarded-Encrypted: i=1; AJvYcCU+GqVApdO/9FC1EoRO8wBu3PZ0b/0BASMGkhFcBvbNO5Qez1528MB9alkAbFBTi4aOsGo=@vger.kernel.org, AJvYcCXEGvVOmNf/SCNPrFvlRFtSTqcbPyezYxJ75WeVrd3bGsJIUjXwa8v4sdWICl7iD8ctCOPJZfi2@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5Ip7wuZOlHq5fZyG/Ua2JmjqsFgM5GPTl8uEIunj9lRRoIJb
	1yfL4O81c7gI3xSc44IiRKRJzLbjGvjVon4P6o9HeNej7SrJXC+hnWrLRaZHKC0q97Spf8QqZgc
	HFr2T68eHN1/GefjNAH0E8fxSB3U=
X-Google-Smtp-Source: AGHT+IHDXVw2BmHoC2Wb6De9OZAVkUK04+YbQM4mvkNYycOo++dXsPP/e7Az6InBjchf8Eg85ILobHJzH3fXl/abWt0=
X-Received: by 2002:a92:c545:0:b0:3a0:ac0d:22b9 with SMTP id
 e9e14a558f8ab-3a4ed27bec6mr192694135ab.6.1730345259813; Wed, 30 Oct 2024
 20:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
 <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev> <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
In-Reply-To: <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 11:27:03 +0800
Message-ID: <CAL+tcoD5Owoa+xajSzCWHHN+AUWrmT-xu_Nm8SK2_obED_iWBA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:41=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Thu, Oct 31, 2024 at 9:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 10/29/24 11:50 PM, Jason Xing wrote:
> > > On Wed, Oct 30, 2024 at 1:42=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > >>
> > >> On 10/28/24 4:05 AM, Jason Xing wrote:
> > >>> +/* Used to track the tskey for bpf extension
> > >>> + *
> > >>> + * @sk_tskey: bpf extension can use it only when no application us=
es.
> > >>> + *            Application can use it directly regardless of bpf ex=
tension.
> > >>> + *
> > >>> + * There are three strategies:
> > >>> + * 1) If we've already set through setsockopt() and here we're goi=
ng to set
> > >>> + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey =
and will
> > >>> + *    keep the record of delta between the current "key" and previ=
ous key.
> > >>> + * 2) If we've already set through bpf_setsockopt() and here we're=
 going to
> > >>> + *    set for application use, we will record the delta first and =
then
> > >>> + *    override/initialize the @sk_tskey.
> > >>> + * 3) other cases, which means only either of them takes effect, s=
o initialize
> > >>> + *    everything simplely.
> > >>> + */
> > >>> +static long int sock_calculate_tskey_offset(struct sock *sk, int v=
al, int bpf_type)
> > >>> +{
> > >>> +     u32 tskey;
> > >>> +
> > >>> +     if (sk_is_tcp(sk)) {
> > >>> +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> > >>> +                     return -EINVAL;
> > >>> +
> > >>> +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > >>> +                     tskey =3D tcp_sk(sk)->write_seq;
> > >>> +             else
> > >>> +                     tskey =3D tcp_sk(sk)->snd_una;
> > >>> +     } else {
> > >>> +             tskey =3D 0;
> > >>> +     }
> > >>> +
> > >>> +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > >>> +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->=
sk_tskey);
> > >>> +             return 0;
> > >>> +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPIN=
G_OPT_ID)) {
> > >>> +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey=
) - tskey;
> > >>> +     } else {
> > >>> +             sk->sk_tskey_bpf_offset =3D 0;
> > >>> +     }
> > >>> +
> > >>> +     return tskey;
> > >>> +}
> > >>
> > >> Before diving into this route, the bpf prog can peek into the tcp se=
q no in the
> > >> skb. It can also look at the sk->sk_tskey for UDP socket. Can you ex=
plain why
> > >> those are not enough information for the bpf prog?
> > >
> > > Well, it does make sense. It seems we don't need to implement tskey
> > > for this bpf feature...
> > >
> > > Due to lack of enough knowledge of bpf, could you provide more hints
> > > that I can follow to write a bpf program to print more information
> > > from the skb? Like in the last patch of this series, in
> > > tools/testing/selftests/bpf/prog_tests/so_timestamping.c, do we have =
a
> > > feasible way to do that?
> >
> > The bpf-prog@sendmsg() will be run to capture a timestamp for sendmsg()=
.
> > When running the bpf-prog@sendmsg(), the skb can be set to the "struct
> > bpf_sock_ops_kern sock_ops;" which is passed to the sockops prog. Take =
a look at
> > bpf_skops_write_hdr_opt().
>
> Thanks. I see the skb field in struct bpf_sock_ops_kern.
>
> >
> > bpf prog cannot directly access the skops->skb now. It is because the s=
ockops
> > prog sees the uapi "struct bpf_sock_ops" instead of "struct
> > bpf_sock_ops(_kern)". The conversion is done in sock_ops_convert_ctx_ac=
cess. It
> > is an old way before BTF. I don't want to extend the uapi "struct bpf_s=
ock_ops".
>
> Oh, so it seems we cannot use this way, right?
>
> I also noticed a use case that allow users to get the information from on=
e skb:
> "int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)" in
> tools/testing/selftests/bpf/progs/netif_receive_skb.c
> But it requires us to add the tracepoint in __skb_tstamp_tx() first.
> Two months ago, I was planning to use a tracepoint for some people who
> find it difficult to deploy bpf.
>
> >
> > Instead, use bpf_cast_to_kern_ctx((struct bpf_sock_ops *)skops_ctx) to =
get a
> > trusted "struct bpf_sock_ops(_kern) *skops" pointer. Then it can access=
 the
> > skops->skb.
>
> Let me spend some time on it. Thanks.
>
> > afaik, the tcb->seq should be available already during sendmsg. it
> > should be able to get it from TCP_SKB_CB(skb)->seq with the bpf_core_ca=
st. Take
> > a look at the existing examples of bpf_core_cast.
> >
> > The same goes for the skb->data. It can use the bpf_dynptr_from_skb(). =
It is not
> > available to skops program now but should be easy to expose.
>
> I wonder what the use of skb->data is here.
>
> >
> > The bpf prog wants to calculate the delay between [sendmsg, SCHED], [SC=
HED,
> > SND], [SND, ACK]. It is why (at least in my mental model) a key is need=
ed to
> > co-relate the sendmsg, SCHED, SND, and ACK timestamp. The tcp seqno cou=
ld be
> > served as that key.
> >
> > All that said, while looking at tcp_tx_timestamp() again, there is alwa=
ys
> > "shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;". shinfo->tskey=
 can be
> > used directly as-is by the bpf prog. I think now I am missing why the b=
pf prog
> > needs the sk_tskey in the sk?
>
> As you said, tcp seqno could be treated as the key, but it leaks the
> information in TCP layer to users. Please see the commit:
> commit 4ed2d765dfaccff5ebdac68e2064b59125033a3b
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Mon Aug 4 22:11:49 2014 -0400
>
>     net-timestamp: TCP timestamping
> ...
>     - To avoid leaking the absolute seqno to userspace, the offset
>     returned in ee_data must always be relative. It is an offset between
>     an skb and sk field.
>
> It has to be computed in the kernel before reporting to the user space, I=
 think.

Well, I'm thinking since the BPF program can only be used by _admin_,
we will not take any risk even if the raw seq is exported to the BPF
program.

Willem, I would like to know your opinions about this point (about
whether we can export the raw seqno or not). Thanks.

Thanks,
Jason

