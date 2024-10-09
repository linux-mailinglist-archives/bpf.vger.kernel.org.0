Return-Path: <bpf+bounces-41414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DD996E30
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB31F22517
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF815381A;
	Wed,  9 Oct 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL6gBNk5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546C2AD1C;
	Wed,  9 Oct 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484574; cv=none; b=a54VsIke0VJk0g+YUXbTGjCZyZukoqhzQDMg+Qf7mUqLSvbGggei1Q859qqrFDbTAGF84Psn2gs/JLH9kLT9kB/2GpM9mL+tj7eiFsoT383R8VLfIxnK2iAhKcZy9Ke36qmeoQkgLpVzZCjwczTuy/gqGpg06aE0Pvdr9RfC0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484574; c=relaxed/simple;
	bh=MiD5fL1h49qODLX0Rb6jBsCGfzj2PiRKHuPOEGiIHU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS0ATUqHsfYEyWlpnVT054Kfw1E5mc/oK7MtFxqnzSUs3Wlxtb3+SL7IiBjmW0Fg8uiwRIgMDeLkl+G8z9PLLxm3lW3m7kHUmGGnNNpmNJKS1zadlXZc/CoucxPyhACpAGjV44VmtSH+DpE9uROjsYvO5ZrnlzoqLqYiu3h4PQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL6gBNk5; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a397d670baso2813655ab.0;
        Wed, 09 Oct 2024 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484571; x=1729089371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SxsMG1VYWw16hjbhZIYIF/XQxcaIL/4UFuOdLmGmVk=;
        b=mL6gBNk5Zbipe9P/VQDz9XarkK1Og0CzYq9Ac4AJyvIjFlkO7XsQc37PTDEmlVT58I
         I5lzeLcZjTVxEUjAHfiUL1ZdbOqhfd4sVj+BrcXxo0rCzCSPqubBaXY0YOGJxy7+5bvN
         6R0NNR/3PcAdadh23914OHNdA5wg1TKOT4lVQmGH7dXuZX3Y/Wm0IbpE4K2vcoCzVS1R
         66kYOFXFZAUCMe6C/ypRyQ49YsR/dT6MBlq1DzzVxX+qwdq2SsDHhvvF/MKl5PsyFxlr
         6diUP3VJHzbxAlanlKHvs1B1tfUsHjYkc8XMgda2tdu7/4JKU+Mf3gA3zw6x+QDisNfR
         aBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484571; x=1729089371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SxsMG1VYWw16hjbhZIYIF/XQxcaIL/4UFuOdLmGmVk=;
        b=jsuNdluzcu1dfyM2taeLFaaj5umg+EgZVsLRWUkCdcxHfd7dVNYq8xHhPfeWKih79d
         TUmlwoqnQd5JsoNZkb/5emaDOLdpoT1oGd+jB0ctbltN2G/w58e7DafzE5gPjvdltrS8
         d6B9tgMvPeRT2unGgd5dd4Dd0EtE01C05OxtCIBpHzWKPbcU4Uohm+Rda/oFOUnqvzlo
         5IDkKiGUpxW47Rnb9DXh/Zw4QM9G0s3BAwUivZf1apAx6Gty2ZeSSx6R0Dv+FOhQLR/h
         /8ahpRh9fHacED0vA+UFQmInph9DB4YI/L6DOUiXiZsxCZCO1Eu17Xi34mJgzljZUTNo
         lcjA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZOBvd4F224acjsDx83VUwkBYb/WZYz8yLmx0HgnomVI+lzzg7z9S1xXTvxGevxv8PH0PoQXf@vger.kernel.org, AJvYcCXgmrOYAOOIksGmtTI6hwTiRGoD8wvIZVexWxeoxG/+BkalONWB5gmtXAolGmzmV8tFGrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBzQ8PuS7fnCMX744V1m8bgOjcpTnNUQxnGE9ut1UxFAPTgxa
	rbbv54F5jmHVEtUDSBr5y5ATri+IXXDXleOjv6FLDwFigKqlGiw8+RSY0BS2LD9jCX1Kw9piU0H
	C4wiOSXlFH67kKoeHgvRf0NuGHTA=
X-Google-Smtp-Source: AGHT+IEiBy9RTEz0v1QYBlI6ASuFnTzWpTIrwJc1MfW3EQMTDXbXWRWtrrGn089c0JvrGMejbzsYe0doN7r9/2sB+10=
X-Received: by 2002:a92:c56d:0:b0:3a0:a3f0:ff57 with SMTP id
 e9e14a558f8ab-3a397cfc363mr22463515ab.15.1728484571171; Wed, 09 Oct 2024
 07:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch> <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
 <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev> <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
 <CAL+tcoD47VfZJFPJcQOgPsQuGA=jPfKU2548fJp2NBH14gEoHA@mail.gmail.com>
 <9c5b405c-9b3d-4c1f-b278-303fe24c7926@linux.dev> <CAL+tcoDDmcPQVUMN-AoGFC4SsmRwdVN+q0MAu+gAWY92Xy_zEA@mail.gmail.com>
 <fd159d60-fe59-4bfa-b143-2432671681b5@linux.dev>
In-Reply-To: <fd159d60-fe59-4bfa-b143-2432671681b5@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 22:35:34 +0800
Message-ID: <CAL+tcoCX4ayowenaT9pBTqGzKQ=pH9BdRPa=1QB2PiJ=+yFxSg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:58=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 09/10/2024 14:47, Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 9:16=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 09/10/2024 12:48, Jason Xing wrote:
> >>> On Wed, Oct 9, 2024 at 7:12=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> >>>>
> >>>> On Wed, Oct 9, 2024 at 5:28=E2=80=AFPM Vadim Fedorenko
> >>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>
> >>>>> On 09/10/2024 02:05, Jason Xing wrote:
> >>>>>> On Wed, Oct 9, 2024 at 7:22=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
> >>>>>>> <willemdebruijn.kernel@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Jason Xing wrote:
> >>>>>>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>>>>>
> >>>>>>>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature b=
y using
> >>>>>>>>> tracepoint to print information (say, tstamp) so that we can
> >>>>>>>>> transparently equip applications with this feature and require =
no
> >>>>>>>>> modification in user side.
> >>>>>>>>>
> >>>>>>>>> Later, we discussed at netconf and agreed that we can use bpf f=
or better
> >>>>>>>>> extension, which is mainly suggested by John Fastabend and Will=
em de
> >>>>>>>>> Bruijn. Many thanks here! So I post this series to see if we ha=
ve a
> >>>>>>>>> better solution to extend.
> >>>>>>>>>
> >>>>>>>>> This approach relies on existing SO_TIMESTAMPING feature, for t=
x path,
> >>>>>>>>> users only needs to pass certain flags through bpf program to m=
ake sure
> >>>>>>>>> the last skb from each sendmsg() has timestamp related controll=
ed flag.
> >>>>>>>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_=
tsflags
> >>>>>>>>> and wait for the moment when recvmsg() is called.
> >>>>>>>>
> >>>>>>>> As you mention, overall I am very supportive of having a way to =
add
> >>>>>>>> timestamping by adminstrators, without having to rebuild applica=
tions.
> >>>>>>>> BPF hooks seem to be the right place for this.
> >>>>>>>>
> >>>>>>>> There is existing kprobe/kretprobe/kfunc support. Supporting
> >>>>>>>> SO_TIMESTAMPING directly may be useful due to its targeted featu=
re
> >>>>>>>> set, and correlation between measurements for the same data in t=
he
> >>>>>>>> stream.
> >>>>>>>>
> >>>>>>>>> After this series, we could step by step implement more advance=
d
> >>>>>>>>> functions/flags already in SO_TIMESTAMPING feature for bpf exte=
nsion.
> >>>>>>>>
> >>>>>>>> My main implementation concern is where this API overlaps with t=
he
> >>>>>>>> existing user API, and how they might conflict. A few questions =
in the
> >>>>>>>> patches.
> >>>>>>>
> >>>>>>> Agreed. That's also what I'm concerned about. So I decided to ask=
 for
> >>>>>>> related experts' help.
> >>>>>>>
> >>>>>>> How to deal with it without interfering with the existing apps in=
 the
> >>>>>>> right way is the key problem.
> >>>>>>
> >>>>>> What I try to implement is let the bpf program have the highest
> >>>>>> precedence. It's similar to RTO min, see the commit as an example:
> >>>>>>
> >>>>>> commit f086edef71be7174a16c1ed67ac65a085cda28b1
> >>>>>> Author: Kevin Yang <yyd@google.com>
> >>>>>> Date:   Mon Jun 3 21:30:54 2024 +0000
> >>>>>>
> >>>>>>        tcp: add sysctl_tcp_rto_min_us
> >>>>>>
> >>>>>>        Adding a sysctl knob to allow user to specify a default
> >>>>>>        rto_min at socket init time, other than using the hard
> >>>>>>        coded 200ms default rto_min.
> >>>>>>
> >>>>>>        Note that the rto_min route option has the highest preceden=
ce
> >>>>>>        for configuring this setting, followed by the TCP_BPF_RTO_M=
IN
> >>>>>>        socket option, followed by the tcp_rto_min_us sysctl.
> >>>>>>
> >>>>>> It includes three cases, 1) route option, 2) bpf option, 3) sysctl=
.
> >>>>>> The first priority can override others. It doesn't have a good
> >>>>>> chance/point to restore the icsk_rto_min field if users want to
> >>>>>> shutdown the bpf program because it is set in
> >>>>>> bpf_sol_tcp_setsockopt().
> >>>>>
> >>>>> rto_min example is slightly different. With tcp_rto_min the doesn't
> >>>>> expect any data to come back to user space while for timestamping t=
he
> >>>>> app may be confused directly by providing more data, or by not prov=
iding
> >>>>> expected data. I believe some hint about requestor of the data is n=
eeded
> >>>>> here. It will also help to solve the problem of populating sk_err_q=
ueue
> >>>>> mentioned by Martin.
> >>>>
> >>>> Sorry, I don't fully get it. In this patch series, this bpf extensio=
n
> >>>> feature will not rely on sk_err_queue any more to report tx timestam=
ps
> >>>> to userspace. Bpf program can do that printing.
> >>>>
> >>>> Do you mean that it could be wrong if one skb carries the tsflags th=
at
> >>>> are previously set due to the bpf program and then suddenly users
> >>>> detach the program? It indeed will put a new/cloned skb into the err=
or
> >>>> queue. Interesting corner case. It seems I have to re-implement a
> >>>> totally independent tsflags for bpf extension feature. Do you have a
> >>>> better idea on this?
> >>>
> >>> I feel that if I could introduce bpf new flags like
> >>> SOF_TIMESTAMPING_TX_ACK_BPF for the last skb based on this patch
> >>> series, then it will not populate skb in sk_err_queue even users
> >>> remove the bpf program all of sudden. With this kind of specific bpf
> >>> flags, we can also avoid conflicting with the apps using
> >>> SO_TIEMSTAMPING feature. Let me give it a shot unless a better
> >>> solution shows up.
> >>
> >> It doesn't look great to have duplicate flags just to indicate that th=
is
> >> particular timestamp was asked by a bpf program, even though it looks
> >
> > Or introduce a new field in struct sock or struct sk_buff so that
> > existing SOF_TIMESTAMPING_* can be reused.
>
> Well, I was thinking about this way. We can potentially add an array of
> tsflags meaning the index of the array is the requestor. That will be
> more flexible in terms of adding new requestor (like scheduler or
> congestion control algo) if needed. But it comes with increased memory
> usage on hot path which might be a blocker.

Is the following code snippet what you expect? But I wonder why not
just add a u32 field instead and then use each bit of it defined in
include/uapi/linux/net_tstamp.h?

diff --git a/include/net/sock.h b/include/net/sock.h
index b32f1424ecc5..4677f53da75a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -445,6 +445,7 @@ struct sock {
        u32                     sk_reserved_mem;
        int                     sk_forward_alloc;
        u32                     sk_tsflags;
+       u32                     new_tsflags[10];
        __cacheline_group_end(sock_write_rxtx);

        __cacheline_group_begin(sock_write_tx);

I could be missing something. Sorry. If possible, could you show me
some code snippets?

As for the new requestor, IIUC, do you want to add more tx timestamp
generating points in the future?

Thanks,
Jason

