Return-Path: <bpf+bounces-62138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91420AF5D9E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891AC1BC1BF4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB04B2D77F8;
	Wed,  2 Jul 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGMvB/1g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DF27FD6E;
	Wed,  2 Jul 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471351; cv=none; b=PUNHfOvZgvNZeAqU7kPT4RqysmjlSsEc8Y49bJYO6L9QvIEzerDZ4cDIfZSRUTu1Nn3VSGoDIH1sInVRfmjdKXAYlR3uPD96+UVu58tump4LSUj39HdIqJbC8dT159ACS05rjBKYm10QOJQTjw01TASggbPxyDcI0e9VqoYf6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471351; c=relaxed/simple;
	bh=586wFa8htyS0qcLO7gZAiI/mFbgYQVkR7FJxQCHtSPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI38an7BPY1Mlygj0uK7XtciZKgMpdMuHWVyZDqopRZkDpL2fk8EjPij8X3B9bvA1LraaRn+QWx1rTWaCaMJI0NsQpkfuGxXd85yvsDVxIJCiNfln7yHIUseSznIRBw5a9PYdiwFYWUz0AARz8NKZqS31Ao2jYJlMATpNqOYyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGMvB/1g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235f9ea8d08so65137845ad.1;
        Wed, 02 Jul 2025 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751471346; x=1752076146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fstSFSI0Fl8MRJDVYv0DJK8lPUPHRZ4KsA6tkgOV2s=;
        b=BGMvB/1gHtoSZzFSBVc8MpTy0ovMo0hlXitkdV9gvhw0wVCpzQwDrC7CUh52DWXbvg
         vF7+51yC7Hr7mqGOLgOJK6O0moE5kSDb3NqcZMG36aZdEgJSdCyac6ZHi2XTTfyZpLHU
         l1T4YDQu4L5dunOSCtzbPNT1Sz3SgU5qVkMS9Oe98o06jsScJJelz9ap1xMKcZAUfa5q
         fMPMIYx+EjgKQ7LaKeyDyKZvOImM88fh+/wcJrA92Dwp3YapId+qcBEjqnDcKYsFlOIJ
         gXmnDDuuZMp9xWwucXeL9+L1HB+b3X9S4oyzqt56EHcG30Zw7T1eLOMTfsvJCndPgPs+
         H/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471346; x=1752076146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fstSFSI0Fl8MRJDVYv0DJK8lPUPHRZ4KsA6tkgOV2s=;
        b=l81Bl9yMrdMijfQk+GMnPX7B/Qrh8MW88VKNlTBqvdE9Ui4cH7POtAmGxaf+ojuHRB
         Ehiimu0oGiPlSa4v0zFUNQ8PY4kxhsI9TCVRYopJxGd8lIL/nAH5YqM4v9YZKuYSwP6c
         FfDvTVAo82g8bhLOmvaBwp4HTqMbyuWgbFoQUFcFyNs8ncHnqzPEDMuMIpK9t293JBKj
         MBetQqhvpImfXQTIsjNf0WPUyCLzu+YnzZrlDqLmdiuSFx2+P785HsvzHSkS73XiuqA0
         HRr8GIXvxVge30Mej9F1sQE6pQWjD6T8mnAgJc9uHQ9c4GWcTGh8BC2g/1KzPNIbNOCA
         zlHw==
X-Forwarded-Encrypted: i=1; AJvYcCWhe44nOdMsjKwJc4DBVKbuayUiArBUQ1wnulORs0hAX3tSEV70kHgGEn1HXff+puXmUXKAjxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIe7xCtqyym5UJWKFUdSdzCE210Lr1cE+18TNtJQ/UuCsDbxK
	Wzdlz+/Fbp8TaPk7s0exciXlTh3Iu1yuosmwudyTma6BURH/mbG6Keo=
X-Gm-Gg: ASbGnctdiWWSNowJcYvaCVx8havP+VRibnvquxNWgpOIjraG4dzo/y+0pzEwftCfqv/
	NVylI82uhW9UT2ZBeE+fmfUFgfZTR/3V/AhU0U3u42yOXhtRx+nwClghBUmQDd0XXnYlwNo69UP
	vyHrwiaiuHjyueokAtnFs2kNlNomrv9EmxSH4mirtaU8cAG5Crt30P2hrGRsPoyzJxC/ChDcEYl
	uQA7Tyvsk4lraqVuz66spah0GsSdECi8pCuqumWhH18OAWW7Ucw5O512uroEpnsLP9GkuQRzS7x
	N0IZa7U1CJOZU/jlu75UQPH6vpuhp4w5yMuleW0Xb4XOyub0asQZhcjNy5O+KyvgFR5ejOWzV2I
	lo00QxynsFWsDrW3KTK8MhC0zDb8rD00ZUg==
X-Google-Smtp-Source: AGHT+IGm3OEywytT4Eos3pbYa82GIRTAHzoK/sgO/0docnU5STU3/zR/Ecg5AP4v5ywrJZRICdXcPg==
X-Received: by 2002:a17:902:e852:b0:234:a063:e2b5 with SMTP id d9443c01a7336-23c6e58e526mr50058275ad.30.1751471346251;
        Wed, 02 Jul 2025 08:49:06 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e1b03sm139239825ad.10.2025.07.02.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:49:05 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:49:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH bpf] xsk: fix immature cq descriptor production
Message-ID: <aGVU8Nz6-t7IrIzo@mini-arch>
References: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
 <aGUSM6EncW/7j/B1@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGUSM6EncW/7j/B1@boxer>

On 07/02, Maciej Fijalkowski wrote:
> On Wed, Jul 02, 2025 at 12:16:48PM +0200, Maciej Fijalkowski wrote:
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> > 
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when xsk multi-buffer got introduced.
> > 
> > Store addrs at the beginning of skb's linear part and have a sanity
> > check if in any case driver would encapsulate headers in a way that data
> > would overwrite the [head, head + sizeof(xdp_desc::addr) *
> > (MAX_SKB_FRAGS + 1)] region, which we dedicate for umem addresses that
> > will be produced onto xsk_buff_pool's completion queue.
> > 
> > This approach appears to survive scenario where underlying driver
> > linearizes the skb because pskb_pull_tail() under the hood will copy
> > header part to newly allocated memory. If this array would live in
> > tailroom it would get overridden when pulling frags onto linear part.
> > This happens when driver receives skb with frag count higher than what
> > HW is able to swallow (I came across this case on ice driver that has
> > maximum s/g count equal to 8).
> > 
> > Initially we also considered storing 8-byte addr at the end of page
> > allocated by frag but xskxceiver has a test which writes full 4k to frag
> > and this resulted in corrupted addr.
> > 
> > xsk_cq_submit_addr_locked() has to use xsk_get_num_desc() to find out
> > frag count as skb that we deal with within destructor might not have the
> > frags at all - as mentioned earlier drivers in their ndo_start_xmit()
> > might linearize the skb. We will not use cached_prod to update
> > producer's global state as its value might already have been increased,
> > which would result in too many addresses being submitted onto cq.
> > 
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  net/xdp/xsk.c       | 92 +++++++++++++++++++++++++++++++--------------
> >  net/xdp/xsk_queue.h | 12 ++++++
> >  2 files changed, 75 insertions(+), 29 deletions(-)
> > 
> 
> There's a CI failure regarding xsk metadata selftest which I didn't run on
> my side, I focused on xdpsock+xskceiver, so I'll be taking a look into
> that plus I think we can avoid skb headroom hack by allocating struct with
> num_desc + addrs array and carry it via destructor_arg.

+1 on making it more explicit. Maybe we can pre-allocate extra array (with
an element per tx descriptor slot) to hold the extra info we need? And then
pass the pointer to it via descriptor_arg.

