Return-Path: <bpf+bounces-35694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB093CCAD
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 04:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65081C21ABB
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBB18E11;
	Fri, 26 Jul 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqsFsRbZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7E1BF53
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960495; cv=none; b=AzzOjD/8PAFwMkEcBb02afgnUh3RRAm+WoFR7IOK3QHBwS6/GvNX9gZkicbNdgMS6Nly5dJ+ROIqnIF7SXuzI2QPYeZCVMwwf72trFGfelmw2INkFrofH+xmFsec8LJrcDxeNd6qtaEUsaPDAt/fLCv1MWGS6XCWrJBhLbtzKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960495; c=relaxed/simple;
	bh=9pPNleW41JbaEoT5d7ZdvPpk9ik8QLyyrEts7kTbW5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNxGCIZKRZ8TPZO7zuqTYFjaNRFVNTnm2wX2wuMpBR72UYZcyCupemzskD90PrXKX/lVzEbyKey3TQwq4W7LjlIR+FJIjX09CsRlpIlm3KdNLWWcChh5PHFOpovHU9hd3THeplu0lWOJaIV8VG+nO24Vy3qPjFYSsa8F3AV1ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqsFsRbZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721960492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
	b=OqsFsRbZ4TUmoa5MXkurESv9YPA54iPBk5i1jHqzr5+Lk3QnaeyMywcCkHwAYUEaeUgLVx
	EdmxxbBjps3Wxt5XKer7aFdfcPLG0hW6N5SWNAmqXfgl9ZI4z2d5DbxMrN+h26NP9dv/vl
	XLxAPfHY4Q6sRiRqM9nu0ikbvKuM3Tk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Z2daRwkeOOqLg49VFlfK4g-1; Thu, 25 Jul 2024 22:21:29 -0400
X-MC-Unique: Z2daRwkeOOqLg49VFlfK4g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb54eac976so592325a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 19:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721960488; x=1722565288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
        b=apZlnWQ8UWjOc1OsaJRCJ1PSUzQzVAZqMSlw8gduHcNTxm7r5rDOeL+Nm2NyTcUEeh
         NmsLQ0pl8ate6+ckGzDquei/NrxKiDUAuYIZoYq6gqmQ3/ZC6Hmb9M/gqqxWHJKsvxRQ
         otUZ2M7DPmAFTeWVJalCLYqAKqgODepHS2nHC8kYY8MYahNo0sBL8G+3GdphhyicVSb7
         b8Kth6hXbdeyCFvI+lW+iMiMYNbGYDczXW5keHH0vIgHDOnwppythgYi3onSeqYva4l0
         EqKCC59LTJYW9gheAOe5N3P79fLEyVKBbyVSIThPBc9S/yZpaouLyCXiAcx3JnPbBpjf
         oBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUPu6JC/JTOnHqw4kIznubbuN9OKRUWnmOGAGFi0hBh12okGpanywcu5cDECswRb5bpzkSV8P+Sg0AZuDWTWpXpTDkX
X-Gm-Message-State: AOJu0YyiMSY+gJYJ/+x+k7NsgN9iVaQ1L9NaK1aygEnoivatcdw0dLgE
	HRVblOECc4+usd9ub2tMOPcIYtIQzZWMzSsn93n1SaesKt53JXfs4UMvfJcmkF5qJX6UZfDy3hN
	lS67r5w5P2mbJ6IrgbTtn+rx3lPe27srW00JU9qlmSfZhb7DjgvuP4jZUdOE1+ey0dQ9pinyRP6
	CKHW0BBBIAWNSNPzbNrpWjMBLy
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id 98e67ed59e1d1-2cf2ea0f4e6mr4277356a91.23.1721960488161;
        Thu, 25 Jul 2024 19:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mJhruNRcMlENqGhBASXD6O3mnsHAgEZxCXB60xz9QTVgQMj2Rq6goVxIFQ40Heya4tJ4Y2caqJ4tY1oGqOI=
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2cf2ea0f4e6mr4277333a91.23.1721960487690; Thu, 25 Jul 2024
 19:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009d1d0a061d91b803@google.com> <20240725214049.2439-1-aha310510@gmail.com>
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:21:16 +0800
Message-ID: <CACGkMEv2DZhp71-QdckH+9ycerdNd7+F5vFyq3g=qquEsm9rHw@mail.gmail.com>
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	willemdebruijn.kernel@gmail.com, bigeasy@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:41=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> There are cases where do_xdp_generic returns bpf_net_context without
> clearing it. This causes various memory corruptions, so the missing
> bpf_net_ctx_clear must be added.
>
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(Looks like the do_xdp_generic() needs some tweak for example we can
merge the two paths for XDP_DROP at least).

Thanks

> ---
>  net/core/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ea1d20676fb..751d9b70e6ad 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5150,6 +5150,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struc=
t sk_buff **pskb)
>                         bpf_net_ctx_clear(bpf_net_ctx);
>                         return XDP_DROP;
>                 }
> +               bpf_net_ctx_clear(bpf_net_ctx);
>         }
>         return XDP_PASS;
>  out_redir:
> --
>


