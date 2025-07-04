Return-Path: <bpf+bounces-62370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE082AF87CF
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AF5544FF7
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706E230BCB;
	Fri,  4 Jul 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDe4kSa1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A02AC17;
	Fri,  4 Jul 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610008; cv=none; b=bqKZFX7I9ZcufPcPWtUOwquqUXQvGTM1kl5oEMn+9MsMjldrbjH4nnrZYF6l+R6F/W82zcyP5pGbubu786MNdogUgBH+3kMrLYvt1c2TXNaPH8iVwbIIsJttakWWYjQ2M401Oc4/CWc839Oz6JNGCjEQ2XsJqdsYCbKQzUmrW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610008; c=relaxed/simple;
	bh=bNGu9mHczF9hVI0Z/iELMguAJBubV2MbQ1zutNIo94A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTEGbbJDNemmSJDJ3U/RKRTWHiIxoSPtqX4CoKOwkCXEPqtAysHnJJZS26IoMbtKnH+RMNHJM8w5WXpxLhA/bzWyn+ph92lr+22egYvLZNoa/A0KqLmeAALF2XxLEYlnwNEyWYcO8Kp7lTZq3jQtcz4ba+UqUlr8NFx4XZSGJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDe4kSa1; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso2589515ab.2;
        Thu, 03 Jul 2025 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751610006; x=1752214806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/CoBFIe0gSvYXpDYvNnjcPq7HUSrk8HsuXY1dt0XKo=;
        b=iDe4kSa1+iLWcCK60zvzJx72OzXrptDnBNITOYYhCPvrS5qRlT3lEPWdM804vIN7EN
         fi/js3Igs+5lJBhXy6TPqq/KMhlurbjnis9UIfyiCSRugKK2D3ML240e46b7xQOmZE3O
         58XRQmkLZX8oF0sQCxbXlfCjHJAvoGdLriNFblazbzwozD7RhGVvxID6QRA2SY/dEgZ8
         dYxo+SMv2Z963IiR5GByLP0AX2HbBmHQ/gAsYc/ZppptuqYV19W6R92sVF0jHRrusav2
         Gb97J+szGw29Wmf/N1sGkTaSWHAaugcyFB6QPiwvG39PtmdwDiuang/9T9Jg9vxdlqKQ
         JjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610006; x=1752214806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/CoBFIe0gSvYXpDYvNnjcPq7HUSrk8HsuXY1dt0XKo=;
        b=VSbcwyIfI9CvD4yUrn2gv+hfPr7g0KsibgyVGIV1agN5XtcTSPGUeAcQQk8p5e9CV7
         rp8zSeGJFduK1Evve1yddb5GwTKZ1NmAVLj5WFyRiAzDvkrLAUJ4Sx7ZtnOQUsqsRoL1
         UaV8avAKp/WAaS48k7BtPTW+HUDOXnzCfwQgrgXSFwGq3feoFtruRnOXvma1VkbDlDn6
         FAMv52Rb6xvzZ+Afqx/7YROx3gK29LpkSfAG86NrgbVkPVzWlhZ7p0vOgLh9+Q3uuZBE
         ASX/aWgCJeOO6SuSuR082ldIFT8kpg1e2y8EYjiwZZC1EDzSGXzB1RAkjL/eCPEgUe0G
         uViQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL0yf1TcKviqIW5GfihAsxn9ar0cZSo705AQNfK13lbCUIYEtouXtzyneY53PjfCLQEtUYs5P/@vger.kernel.org, AJvYcCXh4AbTlXKr9w2lT3HzoA+piDFaA/qOobX2kfzVBQP2Y/8yolI7DEQPPsSTcmkf9Y/ceV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKi3Xx3T7Jhe+dhCdJFf9YsQzCuJstF8YSo3YmQVYHBd6WzCUM
	2MDHnocNbS1LstHcaKh77GEmYI8xNWb6mQ+/BrDyfW5zH1TM0GRqctySX6Ung95Uwcp0aCuJZpK
	1KHYctXpUp4LEcKgkGm9drE51XV9KDHI=
X-Gm-Gg: ASbGncv9ioROuvsCIOm5ZMNMnfSjjBd3wh1WVNDfO1bar1LOrDucpuGCZYlM3YeZq9T
	lVCxwL2pHIYjfceneHzPjlgrUkfuVCeCCaVZVvO2bwe/mIV6gKY42Q9dvIw2orTTggAPwmfW03f
	Y8YO++wU7NdpoFncC1gTwyKvgzI29/tRKW344RkLD018M=
X-Google-Smtp-Source: AGHT+IGvOpnVLiRimJDRRhMWi47EfzF/46AOZxsq6BHe9oIcr6twPUUAwaeRC6qbxaF+xnlWUMMUalC4EYGa+SLvJPg=
X-Received: by 2002:a05:6e02:3702:b0:3df:3926:88b7 with SMTP id
 e9e14a558f8ab-3e13545d95dmr11204725ab.5.1751610005919; Thu, 03 Jul 2025
 23:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703145045.58271-1-kerneljasonxing@gmail.com> <2e1412dd-97c6-4fdb-ba7b-6529b032d6b9@redhat.com>
In-Reply-To: <2e1412dd-97c6-4fdb-ba7b-6529b032d6b9@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Jul 2025 14:19:29 +0800
X-Gm-Features: Ac12FXz-GsmpNHRTJRqWYRc0KbzDHj3DVYHkBnZEoLP3H_uzVQSOocPD6-FpFAg
Message-ID: <CAL+tcoDd3CHXm=U+CUssrQPhmmTHLadZAs3+eB+5BdBPCepNVA@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET setsockopt
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 7/3/25 4:50 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch provides a setsockopt method to let applications leverage to
> > adjust how many descs to be handled at most in one send syscall. It
> > mitigates the situation where the default value (32) that is too small
> > leads to higher frequency of triggering send syscall.
> >
> > Considering the prosperity/complexity the applications have, there is n=
o
> > absolutely ideal suggestion fitting all cases. So keep 32 as its defaul=
t
> > value like before.
> >
> > The patch does the following things:
> > - Add XDP_MAX_TX_SKB_BUDGET socket option.
> > - Set max_tx_budget to 32 by default in the initialization phase as a
> >   per-socket granular control.
> > - Set the range of max_tx_budget as [32, xs->tx->nentries].
> >
> > The idea behind this comes out of real workloads in production. We use =
a
> > user-level stack with xsk support to accelerate sending packets and
> > minimize triggering syscalls. When the packets are aggregated, it's not
> > hard to hit the upper bound (namely, 32). The moment user-space stack
> > fetches the -EAGAIN error number passed from sendto(), it will loop to =
try
> > again until all the expected descs from tx ring are sent out to the dri=
ver.
> > Enlarging the XDP_MAX_TX_SKB_BUDGET value contributes to less frequency=
 of
> > sendto() and higher throughput/PPS.
> >
> > Here is what I did in production, along with some numbers as follows:
> > For one application I saw lately, I suggested using 128 as max_tx_budge=
t
> > because I saw two limitations without changing any default configuratio=
n:
> > 1) XDP_MAX_TX_SKB_BUDGET, 2) socket sndbuf which is 212992 decided by
> > net.core.wmem_default. As to XDP_MAX_TX_SKB_BUDGET, the scenario behind
> > this was I counted how many descs are transmitted to the driver at one
> > time of sendto() based on [1] patch and then I calculated the
> > possibility of hitting the upper bound. Finally I chose 128 as a
> > suitable value because 1) it covers most of the cases, 2) a higher
> > number would not bring evident results. After twisting the parameters,
> > a stable improvement of around 4% for both PPS and throughput and less
> > resources consumption were found to be observed by strace -c -p xxx:
> > 1) %time was decreased by 7.8%
> > 2) error counter was decreased from 18367 to 572
> >
> > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing=
@gmail.com/
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v7
> > Link: https://lore.kernel.org/all/20250627110121.73228-1-kerneljasonxin=
g@gmail.com/
> > 1. use 'copy mode' in Doc
> > 2. move init of max_tx_budget to a proper position
> > 3. use the max value in the if condition in setsockopt
> > 4. change sockopt name to XDP_MAX_TX_SKB_BUDGET
> > 5. set MAX_PER_SOCKET_BUDGET to 32 instead of TX_BATCH_SIZE because the=
y
> >    have no correlation at all.
> >
> > v6
> > Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonxin=
g@gmail.com/
> > 1. use [32, xs->tx->nentries] range
> > 2. Since setsockopt may generate a different value, add getsockopt to h=
elp
> >    application know what value takes effect finally.
> >
> > v5
> > Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxin=
g@gmail.com/
> > 1. remove changes around zc mode
> >
> > v4
> > Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxin=
g@gmail.com/
> > 1. remove getsockopt as it seems no real use case.
> > 2. adjust the position of max_tx_budget to make sure it stays with othe=
r
> > read-most fields in one cacheline.
> > 3. set one as the lower bound of max_tx_budget
> > 4. add more descriptions/performance data in Doucmentation and commit m=
essage.
> >
> > V3
> > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxin=
g@gmail.com/
> > 1. use a per-socket control (suggested by Stanislav)
> > 2. unify both definitions into one
> > 3. support setsockopt and getsockopt
> > 4. add more description in commit message
> >
> > V2
> > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxin=
g@gmail.com/
> > 1. use a per-netns sysctl knob
> > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > ---
> >  Documentation/networking/af_xdp.rst |  9 +++++++++
> >  include/net/xdp_sock.h              |  1 +
> >  include/uapi/linux/if_xdp.h         |  1 +
> >  net/xdp/xsk.c                       | 21 +++++++++++++++++++--
> >  tools/include/uapi/linux/if_xdp.h   |  1 +
> >  5 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networ=
king/af_xdp.rst
> > index dceeb0d763aa..95ff1836e5c6 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -442,6 +442,15 @@ is created by a privileged process and passed to a=
 non-privileged one.
> >  Once the option is set, kernel will refuse attempts to bind that socke=
t
> >  to a different interface.  Updating the value requires CAP_NET_RAW.
> >
> > +XDP_MAX_TX_SKB_BUDGET setsockopt
> > +----------------------------
>
> I'm sorry, kdoc is not happy about the above:
>
> /home/doc-build/testing/Documentation/networking/af_xdp.rst:442:
> WARNING: Title underline too short.XDP_MAX_TX_SKB_BUDGET setsockopt
> ----------------------------

Ah, I see... Sorry, I should have checked this.

I will post a v8 patch with this one and RCT issues solved.

Thanks,
Jason

>
> /P
>

