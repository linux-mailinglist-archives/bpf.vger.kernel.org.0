Return-Path: <bpf+bounces-42005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F599E42F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E68EB21CA9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C131E573A;
	Tue, 15 Oct 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzpEJmOT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C281E32D0;
	Tue, 15 Oct 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988738; cv=none; b=kp0lELzgmEVoCZQoPIcIWJQjt2MZPq/i5A7hTE2wdVHSbUNXzCt8jM1/S7vGfBE/QMjnXPLnqioQcZMZ9QEEv9xuwYU+H6OFCcsji/7YyZQ6kVLAVW4AWMaXBnn5gNIavQF17NWKmGGoOyiNNhj51cnkZ4TmKAdYvn6YLPvD/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988738; c=relaxed/simple;
	bh=F0R0hNcQCIuKcfxH8NbHa5BcSUl8VFWxtm1HRzXruXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSV8jnjRAOE41wZJpZA6NIEd/PclR5n3/s0sS6KEnUjUppMr5pspzcyMkSfghMOBTAdKzEDKJuCIOpVm/R9gceYrUz089dAGBNYMwKVofSAdMaWs63YXmYuaxjvUfgAeGMO/zKeym+F+xkDSMIEgQnUV/AUGiy81TC+uJtukIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzpEJmOT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e483c83dbso3319951b3a.3;
        Tue, 15 Oct 2024 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728988736; x=1729593536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HnAmpbtrkBA2/TC1MYqA8hPnz8VPq4bLs1qgVQiocao=;
        b=JzpEJmOT3d9txykgYfWKxC6AIVol4b9GIW3bFo0yb2oYkyHp7GmYqfEWgDJkW501dC
         OvpM/ro/oRbJCB1vWVTB7QmaajYl2w9+qYn1ZPmbWnxmQRlRXyxYEZD81PX/AUJh2a9s
         OuTb6IsWVqifo3uT+4MGRcCJt6tcOpCWlgIxKB83RRSRnjL+J27OeJEmSoteh9GOgfVg
         FlJqCVqYprgCuuy/FuDbDbBdulm7wqPIiPiopo4U+Y1DP/8KEUEfXp2VVFAcLxNn+/iZ
         fW+f+e+CCpJ2IReGKfl89XNgwsIcGvoC1al1GCF2IR4if2pnE2HAf/hSeJZxzS5HlgQ6
         M4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988736; x=1729593536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnAmpbtrkBA2/TC1MYqA8hPnz8VPq4bLs1qgVQiocao=;
        b=IrPtnt8lHsq3RVtcuyFrxTIhsrr6gHk4fyp34h42Tpn2Buh03fPoNPCWeMYls9hbns
         5EtGB4sfVPLtzThepzBzTQkpkME9+GrkaygpXG3GfaUd9ZP//AtsAj9PMK91SCobK7HD
         14OSWdghtAQs/Cvt7UOJmtcmEQUMvyfi6O2ERT9uwUCWhzS/s/RJJN+kGmKM5q9SX46h
         wKotca+vBIq+wRVbtiMIvvchH2GeK8nanWK4nSfn/OLDNrTKLdQmV2vT8GVdQ9WVLxwU
         HkXIBTUobZp3cd0ezBE8uZRaXsz3yHhZ08cdYhx89DaT41jLwqv5NJWEgg3DIbPCheuF
         7uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhytlHOEPR94qhmOSDqESNALG03F749JhDmMcwmvT+WDNXESYF8p2kmYaSxV0kzYAUcG54oj6ALw2X1YnH@vger.kernel.org, AJvYcCVsLkAv8jaR547u8/83jHnMt5P4cxkvlHt7srSPaO2rwlwQLvfRSFqF+XR+RpJMzFffX2o=@vger.kernel.org, AJvYcCW0cFhTRRVyoKnZ0A+lK++uweBmlWVPeQXBGdzp6qUNrKzmMvZUrbv9GtEmoWwtnU3+KDJHEMMn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ToD+EuW81q4gSbbqlb6+bONpe5ON44psj1xJmB5uFRwRtNTZ
	MOxrk+Qy9RDsLwqQp2+xlsybnDjKG84mQBu7+QBN0bjEC45Ke+kl
X-Google-Smtp-Source: AGHT+IE1IqAL+GxtTRO95OEpLWNhcBAtWMzi+njHghYEDUHxAnlXWULm8xDgIGcwM87ShLA4komByg==
X-Received: by 2002:a05:6a00:3d4c:b0:717:86e9:cc34 with SMTP id d2e1a72fcca58-71e37e4a5b1mr25076396b3a.8.1728988736216;
        Tue, 15 Oct 2024 03:38:56 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715be5sm1028519a12.79.2024.10.15.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:38:54 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:38:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
Message-ID: <Zw5GNHSjgut12LEV@fedora>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>

On Tue, Oct 15, 2024 at 12:53:08PM +0300, Nikolay Aleksandrov wrote:
> On 15/10/2024 11:17, Daniel Borkmann wrote:
> > On 10/15/24 5:36 AM, Hangbin Liu wrote:
> >> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
> >> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
> >> implements the .ndo_bpf function. However, for drivers like bonding, which
> >> only support native XDP for specific modes, this may result in an
> >> "unsupported" response.
> >>
> >> In such cases, let's fall back to SKB mode if the user did not explicitly
> >> request DRV mode.
> >>
> 
> So behaviour changed once, now it's changing again.. 

This should not be a behaviour change, it just follow the fallback rules.

> IMO it's better to explicitly
> error out and let the user decide how to resolve the situation. 

The user feels confused and reported a bug. Because cmd
`ip link set bond0 xdp obj xdp_dummy.o section xdp` failed with "Operation
not supported" in stead of fall back to xdpgeneral mode.

> The above commit
> is 4 years old, surely everyone is used to the behaviour by now. If you insist
> to do auto-fallback, then at least I'd go with Daniel's suggestion and do it
> in the bonding device. Maybe it can return -EFALLBACK, or some other way to
> signal the caller and change the mode, but you assume that's what the user
> would want, maybe it is and maybe it's not - that is why I'd prefer the
> explicit error so conscious action can be taken to resolve the situation.
> 
> That being said, I don't have a strong preference, just my few cents. :)
> 
> >> Fixes: c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags specified")
> >> Reported-by: Liang Li <liali@redhat.com>
> >> Closes: https://issues.redhat.com/browse/RHEL-62339
> > 
> > nit: The link is not accessible to the public.

I made it public now.

> > 
> > Also, this breaks BPF CI with regards to existing bonding selftest :
> > 
> >   https://github.com/kernel-patches/bpf/actions/runs/11340153361/job/31536275257

The following should fix the selftest error.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 18d1314fa797..0c380558a25d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5705,7 +5705,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
                if (dev_xdp_prog_count(slave_dev) > 0) {
                        SLAVE_NL_ERR(dev, slave_dev, extack,
                                     "Slave has XDP program loaded, please unload before enslaving");
-                       err = -EOPNOTSUPP;
+                       err = -EEXIST;
                        goto err;
                }

But it doesn't solve the problem if the slave has xdp program loaded while
using an unsupported bond mode, which will return too early.

If there is not other driver has this problem. I can try fix this on
bonding side.

Thanks
Hangbin

