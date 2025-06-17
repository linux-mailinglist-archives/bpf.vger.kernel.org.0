Return-Path: <bpf+bounces-60856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FCADDD69
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DEE3BE9B1
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194F289E06;
	Tue, 17 Jun 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahWZ5l07"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBD1E9B3A;
	Tue, 17 Jun 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193275; cv=none; b=IDhp0FndyoK4gIyS0h+QIqzI6lm44JYVCYME+2HlSuwcXV5aH8QFq2iX75qSjJxNTu/EUh0jmOcMGUru3TYXjFpVhip7WP+xQmo/noP4vH9phuVWvv/KHOM2PTm7ajr/vlaRzV1ANnyMuhcIj9Atuhm53Gc5vEOEoN+2BSlmNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193275; c=relaxed/simple;
	bh=aaVGUsqFEMAJaCCT4v44VqWtHjm46jp4PMHa3WZgIbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+jsF+/p6u+5H2LUqdv7SL8ksePOxLhvXvuUCd3Q1xjjSa9ShLXWOwQMnUBZsp/vCvL+aPRciogqwhIUvnXK2k6gAt8duwYVinyb4ySZ9yfGMGvwvLE3JCIluMx7PZ6JvOJdgBBo2gIPHKMILfAFrm4ZJ7dMIBUMBQSCgR75+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahWZ5l07; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00a1so55431085ad.3;
        Tue, 17 Jun 2025 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750193273; x=1750798073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T16xtPpO0tyE6T1eZ6sTmHKQ1msai+iZXYay+jVB/Qw=;
        b=ahWZ5l07HrCdcdp8Z3f6j+rQPUjzS8ApMeEfNDd+zqOxZSV70wZo4tF3dink7z2odz
         zDFnu9xZTx87GN24fi11iABOivS+3KNSiPxkVFuol/R6cBcyUOYosaw6RE+mt6qA/Cb2
         veiWv1ijDqJDe/kNzd6pmvOvmIlHSGzf8lv789NhQAFOTd8+dyoilhH3kUb+xTGhjjRb
         fLRHMJFjAAHzd7aKK7VUEuKm/p6+SS+BrO0eoYpERNB8UZjHAtvoLglTlh1bvK14Kiyr
         n7gBbp+bCHl4RlBM3SyajaipEKQ+0yZjgmVkJlJoGETH5rWpgDhEVVbFJbqp5QnGxG32
         RCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193273; x=1750798073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T16xtPpO0tyE6T1eZ6sTmHKQ1msai+iZXYay+jVB/Qw=;
        b=BEskF9OzCgkPf8ODKJ/yJgkLBChHChwI4VUWFbzgg6wXb2bJnegXbtR4XSv8s5vUQT
         rQrAoZkVx0fqIOAwiejnBib7Dg2M+XlpVjFHPsVT5c8yvysrBKHuwK9Xl+H+PFR/4aqF
         XVGeSaUsuO7T7/0B7Ys24zZfNybLkpZ2J/HNoc+UP592mZrGAmshYvyuO6mJHdGTOap3
         mA84ZfryeuK8KxnYS0Y06EhRpEcycsgBB8QetLisDE1s/chvIN9DYZCwFiq9LXMG5moA
         f1isXMVrRRZI9Dj9z1/DcYqZul1mBrunTWWaHYE22VWbwrmc7ovIfF73pFXdn4CCfk2t
         h/7A==
X-Forwarded-Encrypted: i=1; AJvYcCVijl92gjXW7sdOHKDbnOOlhC9NDi1ndxhrr3lyVBs058Hw2ihKhW2vUyP/jcjbfTB6nI7Jz4Wi@vger.kernel.org, AJvYcCVod2Fslkkl5kWOyeWdzCnNzwB1R9Qh/t0nh23MSAGm/aOzdlI/9ZrtAh2AWTqmE/NAgug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK0SijpJfacLny65/3zCfn4BjTi7i/o8wS+LfbO50mdo/mI5V
	vgdBJ711bNjClTHPAPgohuxQJgv4iJLwRyWBG5NhWf0mrh4aP5O/DCc=
X-Gm-Gg: ASbGncsDIGU7rXX2Rtw5EVv3tCPF9w0O/Mo3FTc7kqK6gsLbHKwzO0qLNeuIGlBgESe
	Pyz9dmsvGDyTcJlfCuVnCshePQh1C5fEYllk0xyyZ0h/eOo/i5iYJrOOtxPfliHZ8LtzFKLSdGj
	Hso92ITWyepgUj44p26i+9faU0rZNl3MoXKorXAqC3PwKFfod7TOpcLi1+X5tubUgYJi7tQfb0U
	Zla/e/XChAcyylTKOr+9GwC6xskeaXdnAdJRlyz0wFXXqWNdIinmhVyrsU0Ts7l9RhZTffj96cX
	74hdCEUtIPmKWMdv1iMzHcVYUEOFWzPPzfw12TEcbYS9cDxTFK5XX/Roza/PHyGvjlakQZdDSIE
	Jx4+2SE6r/Z6qOXEUQw01RG1iA1BPg3rTyA==
X-Google-Smtp-Source: AGHT+IGbQ+YHNkTYmEXCvUz+7DNTiQs8cI661fUAVAzlp3HxeSdh/h4wJ6WL0vPx3YdGw9ct/Lt/8Q==
X-Received: by 2002:a17:903:2ace:b0:234:a66d:cce5 with SMTP id d9443c01a7336-2366b14a1f9mr225485515ad.46.1750193273199;
        Tue, 17 Jun 2025 13:47:53 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365d8a5b4bsm85519395ad.54.2025.06.17.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:47:52 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:47:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Daniel Borkmann <borkmann@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	arzeznik@cloudflare.com, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aFHUd98juIU4Rr9J@mini-arch>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch>
 <ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org>
 <aFA5hxzOkxVMB_eZ@mini-arch>
 <1221e418-a9b8-41e8-a940-4e7a25288fe0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1221e418-a9b8-41e8-a940-4e7a25288fe0@kernel.org>

On 06/17, Jesper Dangaard Brouer wrote:
> 
> 
> On 16/06/2025 17.34, Stanislav Fomichev wrote:
> > On 06/13, Jesper Dangaard Brouer wrote:
> > > 
> > > On 11/06/2025 05.40, Stanislav Fomichev wrote:
> > > > On 06/11, Lorenzo Bianconi wrote:
> > > > > > Daniel Borkmann <daniel@iogearbox.net> writes:
> > > > > > 
> > > > > [...]
> > > > > > > > 
> > > > > > > > Why not have a new flag for bpf_redirect that transparently stores all
> > > > > > > > available metadata? If you care only about the redirect -> skb case.
> > > > > > > > Might give us more wiggle room in the future to make it work with
> > > > > > > > traits.
> > > > > > > 
> > > > > > > Also q from my side: If I understand the proposal correctly, in order to fully
> > > > > > > populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
> > > > > > > to collect the data from the driver descriptors (indirect call), and then yet
> > > > > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
> > > > > > > xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
> > > > > > > meta data aren't you better off switching to tc(x) directly so the driver can
> > > > > > > do all this natively? :/
> > > > > > 
> > > > > > I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
> > > > > > hope was (back when we added the initial HW metadata support) that we
> > > > > > would be able to inline them to avoid the function call overhead.
> > > > > > 
> > > > > > That being said, even with half a dozen function calls, that's still a
> > > > > > lot less overhead from going all the way to TC(x). The goal of the use
> > > > > > case here is to do as little work as possible on the CPU that initially
> > > > > > receives the packet, instead moving the network stack processing (and
> > > > > > skb allocation) to a different CPU with cpumap.
> > > > > > 
> > > > > > So even if the *total* amount of work being done is a bit higher because
> > > > > > of the kfunc overhead, that can still be beneficial because it's split
> > > > > > between two (or more) CPUs.
> > > > > > 
> > > > > > I'm sure Jesper has some concrete benchmarks for this lying around
> > > > > > somewhere, hopefully he can share those :)
> > > > > 
> > > > > Another possible approach would be to have some utility functions (not kfuncs)
> > > > > used to 'store' the hw metadata in the xdp_frame that are executed in each
> > > > > driver codebase before performing XDP_REDIRECT. The downside of this approach
> > > > > is we need to parse the hw metadata twice if the eBPF program that is bounded
> > > > > to the NIC is consuming these info. What do you think?
> > > > 
> > > > That's the option I was asking about. I'm assuming we should be able
> > > > to reuse existing xmo metadata callbacks for this. We should be able
> > > > to hide it from the drivers also hopefully.
> > > 
> > > I'm not against this idea of transparently stores all available metadata
> > > into the xdp_frame (via some flag/config), but it does not fit our
> > > production use-case.  I also think that this can be added later.
> > > 
> > > We need the ability to overwrite the RX-hash value, before redirecting
> > > packet to CPUMAP (remember as cover-letter describe RX-hash needed
> > > *before* the GRO engine processes the packet in CPUMAP. This is before
> > > TC/BPF).
> > 
> > Make sense. Can we make GRO not flush a bucket for same_flow=0 instead?
> > This will also make it work better for other regular tunneled traffic.
> > Setting hash in BPF to make GRO go fast seems too implementation specific :-(
> 
> I feel misunderstood here.  This was a GRO side-note to remind reviewers
> that netstack expect that RX-hash isn't zero at napi_gro_receive().
> This is not a make GRO faster, but a lets comply with netstack.
> 
> The important BPF optimization is the part that you forgot to quote in
> the reply, so let me reproduce what I wrote below.  TL;DR: RX-hash
> needed to be the tunnel inner-headers else outer-headers SW hash calc
> will land everything on same veth RX-queue.

Might be useful to expand more on this in v2, the full path.
I'm still holding on to the GRO case from the cover letter :-[

Btw, will Jakub's suggestion from 0 work? This seems like a simpler mental
model. Each driver will get a set of metadata setter operations, and you
can use existing headroom to plumb the metadata in whatever format you
like. In cpumap xdp hook, you'll call 'set' operations to (somehow, tbd)
export them to the xdp->skb conversion.

0: https://lore.kernel.org/netdev/76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org/T/#ma746c47e42fbc24be5bb1c6c4b96be566821b03d

