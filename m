Return-Path: <bpf+bounces-49004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3AA12F70
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7694165D59
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3701DDC07;
	Wed, 15 Jan 2025 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVe3IAbw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825812BF24;
	Wed, 15 Jan 2025 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985432; cv=none; b=qFMuCu+JQ8M309+eGOiUWtQlruFT5aV9/c0jYuSvfkdD84tKLwMxvauun9MCus/u3EzWZZACUZCbmwJO6v3k1fJ/uPZACWQ8ZuLuSmtv6/uLNr8yBkgzgB15nNA5wRN1DV5r5jRitUVLWKvjLnBaH+RXlP4VCN0sGHTlOqcy32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985432; c=relaxed/simple;
	bh=w5bHVEGXqQEU/JRGE2iDJpRQ+NWtuYxs68Sz6vmS+hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYyCm0tRIrv9vTB6iGrDCpllZY8nk41Kc03EIvOPTCElRTmQsPOeCYyn00JAXPnu+bXvEgK+WRvp4DZ4wVAj7le1og8FI8JRI/EueJRMf62XEjk5hgT/sU0YBWPbnQt7rG1oWQ6V0YK5TtkFSNJCRq+MwG/lGjQKctyQSssXO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVe3IAbw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844d555491eso12535039f.0;
        Wed, 15 Jan 2025 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736985430; x=1737590230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR271hMpY/GcOiJ4zf0tijaUPvQaWLjl4kn5oxsyD/A=;
        b=bVe3IAbwJ4SjTC0oEyEmHcxaq3eON5ZZrOHVdWcmvF3NmA9N11Ipkwn2Ht27w9+3lN
         2ZT7ZO+HEM2Us+fmg0D/aS+SibvNUCWl9ljahiiZRNoEXY6XR9BW/3gXrGBUpBJO/Mhc
         r711rJ4Von4XAV6J+cPQbBpA8nCZFkD9HKq2oOkrhWCuKCsLyQhs8suM4vfVIsjXqyuA
         H3N8mjuzFs+HRM9y5j2U3IN98m48J86FEge32j6uDs9+Ka4WXQBGnkSeDR7UddQTZ/sK
         8v1yRVBOPhIV2oJBVTCRHSMl/xNS0ENNRCLEe1zTdLnzGL7ZJgLlWIcbYtSa1th1QEgs
         MzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985430; x=1737590230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR271hMpY/GcOiJ4zf0tijaUPvQaWLjl4kn5oxsyD/A=;
        b=UxBcNgwUAo5g2rvF+MECJBNZMn9gE8ojLo36mKWtGKerkyEobMyrejgcB9+88xvcX1
         nweRA9mvikXxfF+N4UdaX0AGmCHFhDFRP3Y3XAhgM3Ob+JSzPcjzS0nmbhpFKHiA2mtj
         71sZYuEI7b0OcVeaH4r797AFZInZk1fwlNt3QsbvN0RwkCb1CXTfd+O7+aPui6O2VmvG
         DWNeuOYGyIFhEobvF5V2n759kGtKAM1nRkzTovUdyUKtns4I6ERLZqn9NBAraGX+5wjY
         JBnNhB+BW+ZiMPI/pWLzXS0IwYUC3jQ1puJM2Cgd2FY8MHrVpeKnO0H9XsUT/VlUi2MN
         3ifw==
X-Forwarded-Encrypted: i=1; AJvYcCUzZjbNFqlsuFI4iKNaVP7UOXQyElDx9xGLD/++I+2pSRCaXa0fZruNh6oq0hVNeovXtymtR0MC@vger.kernel.org, AJvYcCXD4mUp/VTnCUgFtofI/N6hhi+klJZvKPlz56y2ALlokgVoG+B4yvILQFqYN98j4rb37CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CC+iy+oGSLFAg0kqVNq3E8cY8fH8uv238Ys54nsJxqlO9TAH
	T1P6/squu7vTbbrrA8+mnWWtWw2YqDz2k2LVoDWy0q3+CbyYSappQJvFsA4bj2W77gjWiIdGwCq
	rVqN/yHPPyuMkm9AHTGreu3kRg1o=
X-Gm-Gg: ASbGnctaRbg0xfhTNmGDWJ3q5oua80az4gJ+rx0IRea+Y/V3r19K1ZnkcN0h+z3Z549
	4dmqDKQbeg9Y3trilVQ9AloKM6Gq8FY0NIhlG
X-Google-Smtp-Source: AGHT+IHn7q2eLlSYj8LL7sjTfAvuZfIL0y7Iui3f2YhxN5M23FJsmZ48RgX+DrYtdj63MKI0SPbQM1k/x7f2BqVvcpY=
X-Received: by 2002:a05:6e02:1b02:b0:3a7:e0a5:aa98 with SMTP id
 e9e14a558f8ab-3ce3a9d0a82mr227077365ab.13.1736985430541; Wed, 15 Jan 2025
 15:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-9-kerneljasonxing@gmail.com> <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
In-Reply-To: <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:56:34 +0800
X-Gm-Features: AbW1kvaFD6oyOtpTIazJcRrc5Iq_Y8GNF-dDzCQ2R19sho_8wvwCD9_yaH8662w
Message-ID: <CAL+tcoC+bXAPP94zLka5GcwbpWNQtFijxd0PcPnVrtS-F=h6vQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:48=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > Support SCM_TSTAMP_SND case. Then we will get the software
> > timestamp when the driver is about to send the skb. Later, I
> > will support the hardware timestamp.
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 169c6d03d698..0fb31df4ed95 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff *s=
kb, struct sock *sk, int tstype
> >       case SCM_TSTAMP_SCHED:
> >               op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >               break;
> > +     case SCM_TSTAMP_SND:
> > +             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
>
> For the hwtstamps case, is skb_hwtstamps(skb) set? From looking at a few
> drivers, it does not look like it. I don't see the hwtstamps support in p=
atch 10
> either. What did I miss ?

Sorry, I missed adding a new flag, namely, BPF_SOCK_OPS_TS_HW_OPT_CB.
I can also skip adding that new one and rename
BPF_SOCK_OPS_TS_SW_OPT_CB accordingly for sw and hw cases if we
finally decide to use hwtstamps parameter to distinguish two different
cases.

Thanks,
Jason

>
> > +             break;
> >       default:
> >               return;
> >       }

