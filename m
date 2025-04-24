Return-Path: <bpf+bounces-56617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF882A9B297
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355D71B87A2F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36A27CB33;
	Thu, 24 Apr 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8kfPGpF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967522AE48;
	Thu, 24 Apr 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509159; cv=none; b=IYCBrqNYaOevHahkPGuHaR6L3eBJjsKzSyleGMB5loiAmvGUPbau/fHy++zcsccRmeL6TXZg8Nbra4XiOc0GaW6CMvrXP4RtnXRDbbdwzolwCoeTTPYJ9sJsnXU4IHoH24qEFlh8lJAeRWhnQpLq+iYDSLWCOEV2kFMqSa8hKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509159; c=relaxed/simple;
	bh=JeV7Xw/xEUEL07+MEg3U34n3r+CFPpAwz9gsuJ60xoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBnG1Z1C9PjtmdncZc5JxmhRh3PGZeTW49osodsvaUPUX7iegDgabcxSbQxyrQWjkD5keztQLNRNhjQwcit513aAVWpdij3Uh2Arh/NaW90hGAiV2c6WzYfVG1sYNhYj9AxJ0YOAZk/u1ELkRfrcX25YKbCVHxpGZtM7iDQhpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8kfPGpF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bb647eb23so1034104b3a.0;
        Thu, 24 Apr 2025 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509157; x=1746113957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1PHe0E0wssNt+6dkDnk5vrDJasb9FjMv5kuIhFoIog=;
        b=h8kfPGpFrKi+stKIcQwBK+qr4z1AwmDNyKp/wmqMIvcHLvPUnLoX7hIyDT3PHQlCF+
         lnrZbQfWDdv2vnUywHiGoiAvc4WhwoMMhgETz8Bn/q61yp3F90sAmNnPZBVygAdOmp2G
         Sgmf8tR1j3VG0jSfDAQ6qw47knXAiV6Yezx8nPA537+n8ZPa2WaAk0XwclUbN+tzkYbl
         901vdQxBG/xv3LecURcVr5W6BPkjadKkcNCbQ1aTLy5FesOKr3TGkjbSowcbELClBM/n
         JIX9yC0UxfrUn1nEYeqmmp6bI9hdom/2n3CqW5Qt2rq4cO7QcK9ioZKihsoeamURtKfO
         GuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509157; x=1746113957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1PHe0E0wssNt+6dkDnk5vrDJasb9FjMv5kuIhFoIog=;
        b=GKEHTCeB48/ga87lXtdAh7HJ7uSd0HWAHvXE5eISmRFHGOXDRNzGp4f7/vbIeVzP44
         ksO+HBaZ853UarJwAo+ae9ninbQl9QcdI2Q9krJi9CKUlbXVt1BjNvQVXCSnLQosmC4Q
         UgURf1XqFwlogCMAyfEcGcGLu/Q+hCp82fNnZY9DCc8qpFXe5bd1CEefEHSS6LUYAuDM
         7klaX5V9LL/775S/wzsD/yhQieoQmPZSZdZ2DchPHQzfezeLKwkFyrqfs6n4csqsB5/1
         4wC17BLB3Wh9muAlmfPFWa+4gaSIvqsUIdRAnJyyKkclO8jnzVXn2z8Cb+XDS+OvnNKD
         LUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM4ZkpqIVV3Bhrm01ax1FJufpzS6mObGU2sPAzJwaA/WjlkwWRzo8iMFXf6yaoGl2f7wpZwgAZ@vger.kernel.org, AJvYcCVQkalSkv+9ri4q2sHLTHodFOOP90hZdMAbZeV+MZBDH1fCTSrM22ok+Ru8ee4mbDsiqL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGzidtS3T+qnlUwjLXmLUMx/1nkeVKhqDU6gojw27KbVZX1kO
	eda5JiE8zvuz1wKh9SAcJxympzG0jsgUJbupM7fNwp220cftVX4=
X-Gm-Gg: ASbGncu/zkLbzOFuRXWPEzymG7d1T5KZbgKSIQjfEV7grOQIFdnlxJvvgqjJVPwWxql
	ENuku0STfdsEjDxcYYOs35qdxJaHRctRXtP2eCDD9wF3Jh46CS6HSHnxv2XOkC8GGqsPbZcsbuh
	yoVcRvLaxVRaeff4zZVUnqezkDIVPfAbVpLZpzs5XUZhV9jyU3K/Wls2VldxW8/dXJTR2u8A2ex
	SOEpewGyZ4aDkLn48S16pjIeaSihHtn4uikDTi98CbIk8MkcdfZ65vR31D6rWzpVSfWm8AyLsP3
	W1RDlqrKw95BlfYqaUecCZiaLiAlddAg0/RmvfCQ
X-Google-Smtp-Source: AGHT+IE6ZjgWltNd9sxCnZSKKRuvyhv4bFISv9Ai0Q+TY4aAXHM2YfWpCg4hH1+7nXnc83x9V6rgFQ==
X-Received: by 2002:a05:6a00:a22:b0:739:4a93:a5db with SMTP id d2e1a72fcca58-73e330c5d88mr171225b3a.22.1745509157267;
        Thu, 24 Apr 2025 08:39:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25a6a8desm1583390b3a.99.2025.04.24.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:39:16 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:39:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Arthur Fabre <arthur@arthurfabre.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, jakub@cloudflare.com, hawk@kernel.org,
	yan@cloudflare.com, jbrandeburg@cloudflare.com, lbiancon@redhat.com,
	ast@kernel.org, kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
Message-ID: <aApbI4utFB3riv4i@mini-arch>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
 <aAkW--LAm5L2oNNn@mini-arch>
 <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
 <aAl7lz88_8QohyxK@mini-arch>
 <87tt6d7utp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt6d7utp.fsf@toke.dk>

On 04/24, Toke Høiland-Jørgensen wrote:
> Stanislav Fomichev <stfomichev@gmail.com> writes:
> 
> > On 04/23, Arthur Fabre wrote:
> >> On Wed Apr 23, 2025 at 6:36 PM CEST, Stanislav Fomichev wrote:
> >> > On 04/22, Arthur Fabre wrote:
> >> > > Call the common xdp_buff_update_skb() helper.
> >> > > 
> >> > > Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
> >> > > ---
> >> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
> >> > >  1 file changed, 4 insertions(+)
> >> > > 
> >> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> > > index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2fa45e6256d98574c2 100644
> >> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> > > @@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
> >> > >  			}
> >> > >  		}
> >> > >  	}
> >> > > +
> >> > > +	if (xdp_active)
> >> > > +		xdp_buff_update_skb(&xdp, skb);
> >> >
> >> > For me, the preference for reusing existing metadata area was
> >> > because of the patches 10-16: we now need to care about two types of
> >> > metadata explicitly.
> >> 
> >> Having to update all the drivers is definitely not ideal. Motivation is:
> >> 
> >> 1. Avoid trait_set() and xdp_adjust_meta() from corrupting each other's
> >>    data. 
> >>    But that's not a problem if we disallow trait_set() and
> >>    xdp_adjust_meta() to be used at the same time, so maybe not a good
> >>    reason anymore (except for maybe 3.)
> >> 
> >> 2. Not have the traits at the "end" of the headroom (ie right next to
> >>    actual packet data).
> >>    If it's at the "end", we need to move all of it to make room for
> >>    every xdp_adjust_head() call.
> >>    It seems more intrusive to the current SKB API: several funcs assume
> >>    that there is headroom directly before the packet.
> >
> > [..]
> >
> >> 3. I'm not sure how this should be exposed with AF_XDP yet. Either:
> >>    * Expose raw trait storage, and having it at the "end" of the
> >>      headroom is nice. But userspace would need to know how to parse the
> >> 	 header.
> >>    * Require the XDP program to copy the traits it wants into the XDP
> >>      metadata area, which is already exposed to userspace. That would
> >> 	 need traits and XDP metadata to coexist.
> >  
> > By keeping the traits at the tail we can just expose raw trait storage
> > and let userspace deal with it. But anyway, my main point is to avoid
> > having drivers to deal with two separate cases. As long as we can hide
> > everything behind a common call, we can change the placement later.
> 
> Being able to change the placement (and format) of the data store is the
> reason why we should absolutely *not* expose the internal trait storage
> to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
> The trait get/set API very deliberately does not expose any details
> about the underlying storage for exactly this reason :)

I was under the impression that we want to eventually expose trait
blobs to the userspace via getsockopt (or some other similar means),
is it not the case? How is userspace supposed to consume it?

