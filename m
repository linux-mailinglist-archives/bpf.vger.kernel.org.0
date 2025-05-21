Return-Path: <bpf+bounces-58683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E56ABFEDC
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E797A9819
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339042BCF6D;
	Wed, 21 May 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvklfIuU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13C1624CE
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862384; cv=none; b=CE+pkk48Uqvji/9aIT7+oup9xJfqyHmbb8IAah6Ynxn5To1aG5ukMjm2+D7hh8APH+DPVb5t8Id8jT0LiLzE40/6plBDWCl7Q7QLKEls0AbzfTeHddYFjqoi+ZmAWiyknRVl59HNYcMf/YA1Tkr47m+kcZLBx22zlheTv5CFo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862384; c=relaxed/simple;
	bh=vzrjN7mfktkmmWaZzIIOnSfZy81wQCmDhbvthcxM17Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA7sDApOozVDAQHywrN/n+j6o3AkP/nJCjcnSCS1Dt51v0JxwE+cU0S8lKboo0mSa8z6kz46Hi/4VzdvzarRZ2ibEpQiYFhTJsC4Xau5j+0L3w7CHpngQloOjgyyuI+Khh0ICix45hrsmBJ4tWVvNYlB4jj5eorKuCt2jXKNgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvklfIuU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so44739465e9.2
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747862381; x=1748467181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5tCcxClDHjLSw/7+lo/TiMXpPb1X2UnaFL/6Ld0WiY=;
        b=kvklfIuUWNuxIBp57LY+hZvBFm6ztVJnpdXMnE8hYVlHtP0bjy+QwKxZ27qgcfy6NA
         kf0Ci6PRUk48+2suH94l1FDn7e1x5ut0Zd53swcaR97gAYP9JTBRj0lohmjcU2GEY6LN
         oc1DpkrUPSEe6c0HxPiYYleYHBRJKR96Dyz2OZeUZxr8seMKuwXvKTMgmxg/AoMAunEk
         HlMe8j+RD71GOdRQcabyG97A9IYgohikrsWW8kKXiswE4nEmYxLiOZV51tEltkqwmf6S
         ErC+V0mvQZ3nGzEPq8mVosR8U+0sQgV1vHTv5THgxXN96l3L2xBlU8FQzZ6uppddzYEy
         SA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747862381; x=1748467181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5tCcxClDHjLSw/7+lo/TiMXpPb1X2UnaFL/6Ld0WiY=;
        b=h/bdY0fVfiQT9hDeBXMHbnyHhSpoeO1QYMDyVrq6iEBxHYj+p643tX+JOrYuNjyvqy
         zEKJm954dRpWlK0XKF2pW8NJDfU9h7GdB566cJzsJjeveMX/gnb6whOXg2v6IW5i2kL/
         GTycbBigoRzuT9K5tTHZ+krEfAIBomSBBGkwBJymq7w66SdxjBNdn1o1C9vol1uxHqba
         GRDIGgEJDtRPnCfbDeBol1ojO1ZcEClAPyXjskHl1MRLnPXSy0yKUKbQR5Wb4pnD2Tml
         ddvPmpjw8SFl3zMORAKxfmzop9H/fIiz31JtE8SV2qOfOYeh8IivtvmBnZjI9dmvTa+e
         ZLBA==
X-Gm-Message-State: AOJu0Yx+cdQEPhiYQ9Xc3fwR7Px2pfBiIJj2hqIzKShaqdJTWnWt3NCh
	NrgBP0l05hCBC8CtokiA2RVTcTBVkIxjdspGlMydf8sATiCmzksHIXBJ
X-Gm-Gg: ASbGncubXRsdaMTgPOxrp/b7dGsTuNV2ejN3lmOYc2j5SeB/XKTbC9w47jlo673iZfB
	XwSKl/JX2tQ5Dlz/iRxmv4uypdMt1yZYPH7YNDGdhZX9koYtDYyM7xd1fVUUZDa0Byh2Up1BpaL
	n6aOKPEVpBYKE1BWunO1/6dzJwpq8CS2T11mlOtZGvvynOts/oTYntfJcYd/VG3LRaozXGqDov3
	sj0Xb/C27Pa90Ewxt/hM6CvaShX+M0r8HpNTlpZU2jLp4r13E5PrpZu+P3pYkRyuvtIbKxz/sn8
	t4d4DQ+NIHGQVHktvPmiwVkngGyvFnvoRNZzBSGqPy8M08gu141ouqHc9165RY1j4zcbxkyggo/
	WIz2IBhfnH40K0XPBVK0rbuxXKy2DpLQbGnYPzKCzXbgj2M+gxA==
X-Google-Smtp-Source: AGHT+IF6NWJKQ/T9SfGGFQ3uqbCscw3dbYlVWCbxQoyb7F23E/lz4tCPXK4FvJMEpTLKBUsMWFlb2g==
X-Received: by 2002:a05:600c:1c0a:b0:442:f482:c421 with SMTP id 5b1f17b1804b1-442fd66f017mr150754395e9.22.1747862380976;
        Wed, 21 May 2025 14:19:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0021e296f3a2e79df3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:21e2:96f3:a2e7:9df3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb7fsm79156595e9.26.2025.05.21.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:19:40 -0700 (PDT)
Date: Wed, 21 May 2025 23:19:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: Support L4 csum update for IPv6
 address changes
Message-ID: <aC5DamQVPviBmNe5@mail.gmail.com>
References: <aCz84JU60wd8etiT@mail.gmail.com>
 <CAADnVQL8zB_aC8hDDBVuW30mSwc1pu2=04yMiiOfZSZFcEgQEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL8zB_aC8hDDBVuW30mSwc1pu2=04yMiiOfZSZFcEgQEQ@mail.gmail.com>

On Tue, May 20, 2025 at 06:07:15PM -0700, Alexei Starovoitov wrote:
> On Tue, May 20, 2025 at 3:06 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > In Cilium, we use bpf_csum_diff + bpf_l4_csum_replace to, among other
> > things, update the L4 checksum after reverse SNATing IPv6 packets. That
> > use case is however not currently supported and leads to invalid
> > skb->csum values in some cases. This patch adds support for IPv6 address
> > changes in bpf_l4_csum_update via a new flag.
> >
> > When calling bpf_l4_csum_replace in Cilium, it ends up calling
> > inet_proto_csum_replace_by_diff:
> >
> >     1:  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
> >     2:                                       __wsum diff, bool pseudohdr)
> >     3:  {
> >     4:      if (skb->ip_summed != CHECKSUM_PARTIAL) {
> >     5:          csum_replace_by_diff(sum, diff);
> >     6:          if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
> >     7:              skb->csum = ~csum_sub(diff, skb->csum);
> >     8:      } else if (pseudohdr) {
> >     9:          *sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
> >     10:     }
> >     11: }
> >
> > The bug happens when we're in the CHECKSUM_COMPLETE state. We've just
> > updated one of the IPv6 addresses. The helper now updates the L4 header
> > checksum on line 5. Next, it updates skb->csum on line 7. It shouldn't.
> >
> > For an IPv6 packet, the updates of the IPv6 address and of the L4
> > checksum will cancel each other. The checksums are set such that
> > computing a checksum over the packet including its checksum will result
> > in a sum of 0. So the same is true here when we update the L4 checksum
> > on line 5. We'll update it as to cancel the previous IPv6 address
> > update. Hence skb->csum should remain untouched in this case.
> 
> Is ILA broken then?
> net/ipv6/ila/ila_common.c is using
> inet_proto_csum_replace_by_diff()
> 
> or is it simply doing it differently?

As far as I can tell, yes, it's affected by the same issue. Maybe nobody
noticed because 1) it only happens for CHECKSUM_COMPLETE and 2) only the
adj-transport checksum mode for ILA is affected. That mode doesn't look
covered in selftests and isn't the one recommended to users.

With ILA also affected, maybe passing the IPv6 flag to
inet_proto_csum_replace_by_diff is a better solution. That way we could
keep using csum_diff + l4_csum_replace.


