Return-Path: <bpf+bounces-52093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44FA3E2F7
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8606E189EF96
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72C213E6C;
	Thu, 20 Feb 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6eAdfB4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA554213248;
	Thu, 20 Feb 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073610; cv=none; b=HmhRKh2ChfOiIkKeqmXkIt+/A32wwm3brksLc55bzW6O8jEJeRN0Evz+DDHXRKNRyif6HG4mF6lTQonZ7FCQKpK2/FOaVfGV+B23J9LQqtFebJ1DsppW2ezSPJIbCpUY32zhroj/Oebc8GwoNQhRSwsMp4MDRztbMXtPmAaX4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073610; c=relaxed/simple;
	bh=lLgqHdj21WZGU7caBZrmtcEgtGBVxsOciFSnbimYTvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9JR/oMmhboHANJYQes1S5Fo0R47F4yrwkO0BIlwaEXYI0YERAZBtAuTW0jT2EesoC2AA0XIFMI919MRusqibB3VnvFznWjpslYoI6JUny1/YjZOTOGspUCIf3X0v8vPrgPbVqtW8INgcwEVKLYPXfe23hpSC2QDk7xXSTgVepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6eAdfB4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21c2f1b610dso33901705ad.0;
        Thu, 20 Feb 2025 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073608; x=1740678408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9iAAhIY/WYuEVljfYef7cyJfBd4Oum7SIVPeN0CQ/w=;
        b=D6eAdfB4C7iAAkT9jqDPeY2jtVk+THXMDH/KOx7ckEi078HLA8CQce/8Nf4xlOzSbV
         93b+axzZxcH8GhEcZIWcECwFpHR/W07W+MuxLx4JuQEQJaDAVfCr3fR3KcbIxvZ82EAT
         knhYIH2KfMUDLuE4CqY3e6i91fzpZDVpsgSGxuYN7thXuhwGktdjMU0F5VWvUiYtc37l
         BFyADqg/5h1pjkXUEP1Y8XydWod2izpPEb5tFqCR5WYJNgt6HyrFmOfPk8D/h+f47ERs
         pKIc/rFHNQTBdmqvj5LKl5qvR7HHVo07RDnnC0t1kkSTkudSR5TEkl1CgZrPVZ6HqKvR
         4kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073608; x=1740678408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9iAAhIY/WYuEVljfYef7cyJfBd4Oum7SIVPeN0CQ/w=;
        b=w7jwONkg6SV9GBYIQC+GKwxpuGSSrq3esMHL7a3Q/dvkug8tuZ+1a/4ANaT6CB1yp7
         dkbaKjViUvrJBvgo+uSzLRqk3uQQMsI9GM1N5LIVOCZuEiIXRut0hdt2++NtMAG0g/lZ
         9o7SrHsWdwzzjyl03AluU283h0bisbrXLJHb9MD6ChCWJhI0jf732pAY7ivd3qU7GIpC
         IqoQ3o8NRfnHFNOi78etTubXRY3/friz/i7LPSVTwDk4wV5gioaFdjUU+kmpWoiBUfuj
         lwSqjka2LVfr1zaDfvmlNkKN3FE8E0uYQ2aRJt2AEWV0A6XAp5xgGXoCADLhxnLbc74G
         /nfg==
X-Forwarded-Encrypted: i=1; AJvYcCUe2AEXDsI24UslrrEhUibty7CsZ9LbSavCdoa6ZVHKymHZXPhYQYqt9OdquGPFT8ZUpfahQqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6w6k/NEoq09PP7BAhsiFil6nqgNGtMDMkzHKmjNxktl/U3Cy
	7giZmdnAgfZzLmSO/FjfbVChGRacqBfnHskKRLTDnvmZufPSzw4=
X-Gm-Gg: ASbGnctunWNkdFKmt3YVAs8qB99+ItJDKzm0alusTWwbypjTpsTYYQxgvpQD7jMv+/f
	5pRx2c4xLft0upaQ8bVJBCFPE3tdOc+vnSVu48N7Cpot8E1rx3Tm3RAEptutyI2HlMf60xEQwim
	42joVITLXI9g2JOLAHZ5CR4QRd5Zn1kENbV4N/LDVAloysgffz5e4vis01rSKXW7vjc9zZIji52
	S0psp9mxrio10GxedO4+/Oaun9wj+SH33QuhxqSyJzFlci0C/+nk3BDuG6o4v2txOFRRpi2W3sc
	d/q/tVJkNmAiwQs=
X-Google-Smtp-Source: AGHT+IHs01zHV9MMAq8D969ojGBf2w+gIIz3ayw66/TuAy+UI4Cfm7qiNgH1TEDBzOHMKqZyF9Hxxg==
X-Received: by 2002:a17:902:dac4:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-2219ff61deemr444635ad.26.1740073607820;
        Thu, 20 Feb 2025 09:46:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d3b1sm124284175ad.163.2025.02.20.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:46:47 -0800 (PST)
Date: Thu, 20 Feb 2025 09:46:46 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Message-ID: <Z7dqhiWcXDszRSYF@mini-arch>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-3-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220084147.94494-3-tushar.vyavahare@intel.com>

On 02/20, Tushar Vyavahare wrote:
> Introduce a new function, xsk_xdp_adjust_tail, within the XDP program to
> adjust the tail of packets. This function utilizes bpf_xdp_adjust_tail to
> modify the packet size dynamically based on the 'count' variable.
> 
> If the adjustment fails, the packet is dropped using XDP_DROP to ensure
> processing of only correctly modified packets.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Any reason not to combine patches 2..5 into a single one? I looked
through each one briefly and it's a bit hard to follow when trying
to put everything together..

