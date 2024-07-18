Return-Path: <bpf+bounces-34995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5901934927
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61221C21F2F
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41386126;
	Thu, 18 Jul 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyfB4CZ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232555886;
	Thu, 18 Jul 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288589; cv=none; b=RAwyIJpmlyWszcWYhDinnvhR5ct8AzxrpMquAcwlZuMAry2xTw1ahcIuPr4uUD21eFQyH2id9Yjh8Dvq0rfO3UW7/vg9ZryJBCDnLgOJ3catwOq/usJbA9qdinobbp3oX9eT/6WdUpw872WT6hiu+Ot+wChBpb11lQVHj1AyizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288589; c=relaxed/simple;
	bh=7OH4lAaw3ROr42DEkY+s3wYVsOZVuyKYTkptABHbMrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocZqPAEInacXs7AUIm1Uot1SxpqNuA9tY27ixZwof6yB7xO1b3pxI1PTjAH7fXR5fp7op9RWAo+cP4XwrPzsvzMBWjtKoJBAqBNQr2S3KmpEFzloYvA2tvu7Xz4k+pt/Rir5GsdjrOlcpb/0eADuH700NmFfQ5fJ2uBQ1IRNqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyfB4CZ8; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-710437d0affso263782a12.3;
        Thu, 18 Jul 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721288587; x=1721893387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sMWKVvxIIRzLGcTr0dZ7aD8jM/PtmVOcbviJrMhz7I=;
        b=YyfB4CZ8KfhnqpLPWuNN6nwZ/QBKcxMOxTs08B256bunSBSCwnlrWFA0xysGPLOPad
         o1TJjd5C7B0KnfRlnNjEug1MS+XXVQF1LO3DHegiyaPS6rAuVtc7J0JwFVnH7GxtMk5X
         p/IyUmzMFxRn6ZZsoyETqkqss5pO4xnSeHAhEbDB/nSfZqawVJUNcQbVzyofaqszLLdJ
         qNHkmp8O8v4j/poH9taaB/ZWSxifIIHrDpffowtgMOmrjSF6Veijwy8J+yR7iI2Avaz4
         tEKkuPMu4Zi9Mq8PoIPHpFpeYkQXiqKMwXvMKQlAnf3n0DmDV4lZR2fYQ2XXG8ieh2Hx
         spUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288587; x=1721893387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sMWKVvxIIRzLGcTr0dZ7aD8jM/PtmVOcbviJrMhz7I=;
        b=wekVAsysd6KhEKJ4gHF8uW1LHrbGUbwW5R5HmdBDKn7x/k4TO62Kzzu/HjOVALtebZ
         GdY/QuaFZjX9WFu9tmCVmJFJLNCN/9F2PsL1iWPxXzj/q9WEnESHV3aBk54NM3bQ6l0S
         NDFyrjQif3MTxoFghE62fEhQqG83bQA/7VHqK3gXerVyNNL8903hJnve4ZhmLPZct8kc
         uZoACo+jVaMIOIRBiehY7xZgc0m5zktyeUiQqcd3yL5ZrSXMSwKaYyaF8Y+g7Ji09xro
         CNEWvPyY/n/cUSRZFn1Y/wSiEGXtpLIGl4wRidlAHyaRV1c5pYSE6HX9eA0l7KhEE6rF
         FSsw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSst0Qs3QitSscqUe/dabQiMd+23+14l9xq9AA5KkaRdUV9TwKXsyxcjhDvdrKrHm5JtB+03PzGp2S1FvwG+P6P7NUaRwBN1vMZXBWoGXburW4wyYMl6Y4rPPW7a6g4HEPv/LsjhlaYcf+wgfC7K/yeNMlmOfonzC
X-Gm-Message-State: AOJu0YzwgLqGP3R+CBsgirq+5Q47gFxrwYH+gqIQweO0VoQvBZ/hlOr4
	HFi94RFDv35UdjRLQOiTUrSSnHPCEBuw217lJDmm4l4wvvoL+g/q
X-Google-Smtp-Source: AGHT+IF+U+KhLSVEWz1cPe7jdRvQwJruoHccc05QhRR/znXwqUPhe/+0vP1gBxuaR1dEBocDmnuTMg==
X-Received: by 2002:a05:6a21:3981:b0:1c3:fcbb:5673 with SMTP id adf61e73a8af0-1c3fddb654fmr4139351637.44.1721288587435;
        Thu, 18 Jul 2024 00:43:07 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:f992:5417:cf7f:b3cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9c4d8sm87140125ad.77.2024.07.18.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:43:06 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dracodingfly@gmail.com,
	herbert@gondor.apana.org.au,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3] net: linearizing skb when downgrade gso_size
Date: Thu, 18 Jul 2024 15:42:56 +0800
Message-Id: <20240718074256.65274-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <6697f20876b11_34277329417@willemb.c.googlers.com.notmuch>
References: <6697f20876b11_34277329417@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> > Linearizing skb when downgrade gso_size because it may
> > trigger the BUG_ON when segment skb as described in [1].
> > 
> > v3 changes:
> >   linearize skb if having frag_list as Willem de Bruijn suggested[2].
> > 
> > [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
> > [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/
> > 
> > Signed-off-by: Fred Li <dracodingfly@gmail.com>
> 
> A fix needs a Fixed tag.
> 
> This might be the original commit that introduced gso_size adjustment,
> commit 6578171a7ff0c ("bpf: add bpf_skb_change_proto helper")
> 

Yes, this is the original commit, but it's already fixed by commit 
364745fbe981a (bpf: Do not change gso_size during bpf_skb_change_proto())

Another commit 2be7e212d5419 (bpf: add bpf_skb_adjust_room helper) introduced
gso_size too.

> Unless support for frag_list came later.
> 
> > ---
> >  net/core/filter.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index df4578219e82..70919b532d68 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
> >  	if (skb_is_gso(skb)) {
> >  		struct skb_shared_info *shinfo = skb_shinfo(skb);
> >  
> > -		/* Due to header grow, MSS needs to be downgraded. */
> > -		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
> > -			skb_decrease_gso_size(shinfo, len_diff);
> > -
> >  		/* Header must be checked, and gso_segs recomputed. */
> >  		shinfo->gso_type |= gso_type;
> >  		shinfo->gso_segs = 0;
> > +
> > +		/* Due to header grow, MSS needs to be downgraded.
> > +		 * There is BUG_ON When segment the frag_list with
> > +		 * head_frag true so linearize skb after downgrade
> > +		 * the MSS.
> > +		 */
> 
> Super tiny nit: no capitalization of When in the middle of a sentence.

Thanks, i'will fix.

> 
> > +		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
> > +			skb_decrease_gso_size(shinfo, len_diff);
> > +			if (shinfo->frag_list)
> > +				return skb_linearize(skb);
> 
> I previously asked whether it was safe to call pskb_expand_head from
> within a BPF external function. There are actually plenty of existing
> examples of this, so this is fine.
> 
> > +		}
> > +
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.33.0
> > 

