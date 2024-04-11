Return-Path: <bpf+bounces-26524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E028A1625
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D76281184
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50D14D45D;
	Thu, 11 Apr 2024 13:41:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9614D2A7;
	Thu, 11 Apr 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842897; cv=none; b=MwlaisBRcEU61w8+MCyVZRxU/JELOFael0iA5eEb5tiWr+xVVVSXzl4D9zk3+Dtvplh42GqIs2qDtd9kg0R00W+FkXJMIbynTbA+NGOV5cbclGpW1pXlrzX/J/yKoDCoKRRCgABVzscpPMfplQJTQhXhoAlC6d5+XPpiUPGEc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842897; c=relaxed/simple;
	bh=NKtJkO9gtfDh7lsMKghwFIyyj7BihvxBcp+VJqVXnr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbIIddgTFQZk9xpxqJtGLyALOkjDp83uk8WxTmvZIyBNr6lWJ6hjufKs/0sqf3ntR6GOi16TJhPaFsO5ga3qNB7izam9TrCC+9gUezygLuA1R4HpRH0aABgeHX8C+q2G8TiS0GwaztaXYgB9ym0AofCvsjX479XUr8oIe5GlnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso10440001a12.2;
        Thu, 11 Apr 2024 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842894; x=1713447694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvneUqZfd27xdH7i7ElGM/qtZ3lKBc7X3RH0Dlr3png=;
        b=Viv03LapGx7sHzM1tR4VYhuG+WggehdXbi3/orekybiztxFzNHkbiv7c2L4ePr84/f
         MG9Us5Ei+Pt70mTIHfOCQz6gHJGFaJdYxUMECR5tG1P0H3v5R9uhBrNItHZUz7XBVR54
         9LV1wZ1x9bQRfHmKh0q8f144HFbzithQ0ljrVZVthIuC4O/TNAlfGXD9J3p2bxQSoC7j
         hxFRDo4/fQiuzmodX19f5OUK0mADRtx8teV8EZiDmOCC+aLHV0gFAaTPQ2I1bB/dsKUV
         3D7BKd6Bp3SQ+sgFfu64KlMq+O0ZMMkUX2yuRu+Dh4QQKhLD8k+0y2I4Ymdf3GRVFJSd
         Ojwg==
X-Forwarded-Encrypted: i=1; AJvYcCWQjqkts0hff3dcPJcDzGC/Rndur/02VSsP+WLGcv+82NYxFm9uvl6SarXhUf3pM7agaU3sAHwI0p0g5Z3lmtnw9/Z+EXZ+X1VskQMO09vX77o5YuixgX3Ao269I4I/aUzrEGE/323aTi/ebQXWWWtX9t7OHE8v3xtxXVZDUwukgkjf9uvC+/uZ88rGMQiluG8zd5IkybHGmfo=
X-Gm-Message-State: AOJu0Yz7YLaTba2dTTlTm4w2QxIzaZMTVAhaj9AV+7+McIk3EmMO3s0s
	mWjnFhT0he2pYAoqjjVCJ7P0AUNxH2cqJbissk7lTAfhf+6PC7rR
X-Google-Smtp-Source: AGHT+IFVHCivSmrCJQ/y1EgrRPUwWuulRGSKey7Ag7Jr1OrzqAwr6UvPSa7kMM+1w1xBFvGGvQGbng==
X-Received: by 2002:a50:8e15:0:b0:56f:e4f7:fbd9 with SMTP id 21-20020a508e15000000b0056fe4f7fbd9mr1606203edw.20.1712842894052;
        Thu, 11 Apr 2024 06:41:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id j1-20020aa7de81000000b0056e62321eedsm706414edv.17.2024.04.11.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:41:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 06:41:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, geomatsi@gmail.com,
	kvalo@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	quic_jjohnson@quicinc.com, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, idosch@idosch.org
Subject: Re: [PATCH net-next v5 00/10] allocate dummy device dynamically
Message-ID: <Zhfoim8HbQGlvbAC@gmail.com>
References: <20240410131407.3897251-1-leitao@debian.org>
 <20240411060926.308788bf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411060926.308788bf@kernel.org>

On Thu, Apr 11, 2024 at 06:09:26AM -0700, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 06:13:41 -0700 Breno Leitao wrote:
> >   wifi: ath11k: allocate dummy net_device dynamically
> 
> Sorry Breno, I didn't notice earlier, patch 10 didn't make it
> to the list. The series wasn't ingested by CI and tested because 
> of this. Could you repost?

Thanks for the heads-up. I debugged it and it was my mistake, this is
how I've sent it.

	git send-email patches/v5-000*

I will repost.

