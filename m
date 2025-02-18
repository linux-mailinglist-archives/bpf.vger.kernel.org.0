Return-Path: <bpf+bounces-51811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBFCA39441
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 09:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBA97A1339
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EBB20C00C;
	Tue, 18 Feb 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Il8DsjEP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E92066C1;
	Tue, 18 Feb 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865601; cv=none; b=iCoIC1QSamjsV6BLoWpcZTGRxqrnqRtPuSPQRfyB7WPeM2wWjiFqBk7ONzLq8qDYYylPzRW6bHysS+YeEzSvnfo770HI1xHnOslIF57WhNgipxFTYiBJ4TJpxdxKfBZSXD/TPF0shhecAl7/0Eu73srp+HJ8T0cLniBW2dtWgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865601; c=relaxed/simple;
	bh=ziEzK7wRUsoPk34tXG4PKX0kfZMyG09T1TuFOZsMGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTJSiNOJNkR/EYZaVn6qto2a4fck2ZNFv4RdWMlTjtfm8+JSwwNYM9CsBHYM/A3kkm0tJbZk76P1tTs8VdV3pW0B/88Op4Frpn2qMDZ6+zAkyrRWIP0POsv1pCP1bczpSTh46JY4hiQE7IgI61eh9v1+v77wlbZoBQc4c4ejIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Il8DsjEP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739865600; x=1771401600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ziEzK7wRUsoPk34tXG4PKX0kfZMyG09T1TuFOZsMGH8=;
  b=Il8DsjEPYt8gsPOdIAdONGzNkYRwugGkyXiYyVfUpRQdSY8vuF4fAlC2
   lW34dlDaC169qW646ZxZXME7hK1FNXJP2wFWtDM5xPmil9+GERQM9ylUh
   fHq1TawIPHqS4tTlzUC2DYDK+InYAUjhrc0rbA/t+cHcMAiT20ggUkJtF
   /hKJdhGxx7don89No1qKBzJc7Oawv4rTj37aleK8432ctKqF6VskmWVLf
   kU/SkLPcwos2lIfrFg1eReSBQQLw2LTJ40Nitf68fE71UgvIL/jDe1ZcR
   CDArJCMT0G5zkyc/QViocClFOlylukjvRvs1Z3eDzW/wQbzqrhU0968v1
   w==;
X-CSE-ConnectionGUID: Kep8qXXcS+KckG0knDufkw==
X-CSE-MsgGUID: FRseRXI1QY6uqmVjGOl5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57954571"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57954571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:59:59 -0800
X-CSE-ConnectionGUID: wQGNfdpkTraGbuexWoXZ6w==
X-CSE-MsgGUID: In4y45QdQsCSaspdTULcUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="119419175"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:59:55 -0800
Date: Tue, 18 Feb 2025 08:56:16 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, kuba@kernel.org,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	qmo@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
Message-ID: <Z7Q9ILUfC90Vd490@mev-dev.igk.intel.com>
References: <20250218011744.2397726-1-haoxiang_li2024@163.com>
 <CAH-L+nP5w7hRbONxPNG7NJtJzb-A0JOEMSq1hKNepM9GpFkt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nP5w7hRbONxPNG7NJtJzb-A0JOEMSq1hKNepM9GpFkt-g@mail.gmail.com>

On Tue, Feb 18, 2025 at 08:14:49AM +0530, Kalesh Anakkur Purayil wrote:
> On Tue, Feb 18, 2025 at 6:49 AM Haoxiang Li <haoxiang_li2024@163.com> wrote:
> >
> > Add check for the return value of nfp_app_ctrl_msg_alloc() in
> > nfp_bpf_cmsg_alloc() to prevent null pointer dereference.
> >
> > Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> > - remove the bracket for one single-statement. Thanks, Guru!
> > ---
> >  drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> > index 2ec62c8d86e1..b02d5fbb8c8c 100644
> > --- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> > +++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> > @@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
> >         struct sk_buff *skb;
> >
> >         skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
> > +       if (!skp)
> > +               return NULL;
> It looks like you did not compile this change.
> 
> Also, next time you push a new version, please modify the subject as:
> "[PATCH net v3] xxxx"

Yeah, you need to send v3 (skp -> skb). Fix looks fine, other call to
nfp_app_ctrl_msg_alloc() is checking returned value as here.

Feel free to add my RB tag in v3.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> >         skb_put(skb, size);
> >
> >         return skb;
> > --
> > 2.25.1
> >
> >
> 
> 
> -- 
> Regards,
> Kalesh AP



