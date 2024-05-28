Return-Path: <bpf+bounces-30714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9388D1AFE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7924E28322B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4116D4EB;
	Tue, 28 May 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUJcofve"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FE79F5;
	Tue, 28 May 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898815; cv=none; b=NKn84Ybn3Y5vh63LtQ73uPdUHzWqUqkl1Q718U+e9sEJZwGGifDHdydOpALLis2nobYUQZxsk4zYo6MneM956koqZ2Th0UHTDtyXPfB2p8DfID4Quj1KwqLO59B0uCfe0OgenJSOa52DxGxQ3/pvGm8RwWKr+P+5R5vmK2k9iRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898815; c=relaxed/simple;
	bh=L3WhHmiorW7MFOt+LyYCXDut/bcUzwlL0rlxJZmGid8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMqlrXUfHYqWUuWHDFSrTc/r+iWDX0bjYwZ0DMlhTQSgQI7uWkbBORnBEoanGReIj1YoPBW/IxaosfNxRbKoiTKF5OO4zftsYZ7wD33fReslsOXZ+ADgFsf+HPoF2F+qFnhGZVGx7UIxMAn1H/lOzaaLoo8i79K4yt1u9xxLhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUJcofve; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529be98ad96so484665e87.0;
        Tue, 28 May 2024 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898812; x=1717503612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPKynHoA1RZiJcMOYXRI1Hw3OSBgUrOAHrq/dZgZeTk=;
        b=DUJcofve7x1gVYa7W5Yq8u1PbsxQYicZOxlefmMP9EYneGDCb3i4bQzdRQCjQBNxAV
         vtsEUODP36nQqRgQGb6S8uPK89bkKemasPVxXDOTLYrRpxFI3TKmG7xxfp9r5USGVPtw
         3DYFNshfhCGWFqfZAjqkQnPlJ5pcTzvq9psrcXgxtiMj4j2dn6oznn2KkHvXAq1eVKCs
         z8THXV7KNwPlSJSsWzp84nqN2BelvFqSJKsvILTvZwWqYOLlHpcUsLzLa6Dx2rcWG2zN
         oztXuiuLm0nP49LsFntDBS6+z8bd6sxpJTF9NwOTY7C2cVaWBXURPJdRXkog4Qf+KeNj
         hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898812; x=1717503612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPKynHoA1RZiJcMOYXRI1Hw3OSBgUrOAHrq/dZgZeTk=;
        b=E8eeoWcBRqR9T7Va2e6MC/8mGOOwknSUDTDEtJlDRhskpy4Z++VGBc9oULc6wk3WWS
         9xlDILkIz7WWVUSG30esrl96svJLNKN1uAqMOHPQElhpZfAE+YFFAhNIYV2tj0FAKwD9
         ftbSR461MWNPAl89yTGxqAXplNPvCErddcy5WhduJ8ikAb0og7rsxbH26U0bxhsQOJ5H
         hTXS5jqgkU/toZxoKvmsZppeeszCjjt1VKWWi+B3Dqc+ig/RqKFni632IkF3fezfzpZ1
         +5JUn2omO9MZQjiAVopFTEoksOVFsDf2VKCYitl2Qv8Sfvzlb8LS93PHZyZcK0AGpUA5
         /Ekw==
X-Forwarded-Encrypted: i=1; AJvYcCUY6AMVbFg8Pod3TeUy3kFl2jVEJO96rT4ZTt2GPj/mg0svOPp8MQP2St2fm+dYLrG+KuNI3Hk+1eLHHRoQB+lqRTJqFkOmx6+N7qdq0Bgk0bsuY+4pCMPXFDw6+lUCmx3U0jMR5dVCEHrF8BtD6spwq756j7Q4fhDe
X-Gm-Message-State: AOJu0YyL7RxtDwOGN196g6tOephA+UW/BVn1+crfa66OFoyuh+Svq2Wy
	fkzcDtsueIT5mkR/5Jlvz5DQIjJTzAkKUSNm0qygU04cSeCn1GLh
X-Google-Smtp-Source: AGHT+IFd9FmeuCiizQK6KkHMRIGCvCqTEl6HKh6TZkn0NQYapBUStdMJunq8pk+wjXVdH5HQ+5qNng==
X-Received: by 2002:a19:ca44:0:b0:51f:5872:dd8c with SMTP id 2adb3069b0e04-529651991afmr6873605e87.39.1716898811701;
        Tue, 28 May 2024 05:20:11 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4bfabsm937711e87.84.2024.05.28.05.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:20:11 -0700 (PDT)
Date: Tue, 28 May 2024 15:20:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] net: stmmac: Prevent RGSMIIIS IRQs flood
Message-ID: <fg7ib32lqeeuzef4eoskdnwrufwpdm6cdm2bdjlro7e3gtmp4u@mrni2hltc32o>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <ZlWw3hJdOARzdl2S@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWw3hJdOARzdl2S@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 11:24:30AM +0100, Russell King (Oracle) wrote:
> On Sat, May 25, 2024 at 12:02:57AM +0300, Serge Semin wrote:
> > Without reading the GMAC_RGSMIIIS/MAC_PHYIF_Control_Status the IRQ line
> > won't be de-asserted causing interrupt handler executed over and over. As
> > a quick-fix let's just dummy-read the CSR for now.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I think it would make sense to merge these into the patches that do the
> conversion to avoid a git bisect hitting on a patch that causes an
> interrupt storm. Any objection?

Of course, no objection. This patch content was intended to be merged
into yours.

-Serge(y)

> 
> (I'm now converting these two in separate patches, so would need to
> split this patch...)
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

