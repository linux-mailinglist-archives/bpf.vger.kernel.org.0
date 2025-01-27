Return-Path: <bpf+bounces-49859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41BA1D794
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A891888087
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B67200121;
	Mon, 27 Jan 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="b7gieUBM"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75010200100;
	Mon, 27 Jan 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986174; cv=none; b=pe/+/lJRQoviWP5+hrEiHQuEJ5e5g7RsJgIwwSXCfS8gOZUlhnRx1pYhPXuatK86mbQ5nWX8AFwP/8sJBGZLOIfxddnyzfLg8tTGL5FzbZ7P5oExGeXZY1SgzPxXeo3vjPdrkgSXHwJHDljS7X5aLQ2k5Fnie6EqUGibtGO9pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986174; c=relaxed/simple;
	bh=4OThCG/VyXaV3aAWewpWa5sUba95WcdjuRDMhuanKv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgS/HX3vq7EPcvQmh1KCmBYsSHmZS1xW96CcnlwwLqq0IXVlmlErMG9tQQtwDn7l8s9rkITSAiXCvfZzRlEGNfKmVUon49+Kg7933trGwAQ+Sj3RzF5puCJyvD68g/ZG/sXAp3USTxezYPorViPjFjyGa9pDmfSop7U/igiXr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=b7gieUBM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=iaSvE1tmCYtDKUbO/xVc6BrHlZj+GwfNR36Vu72ya94=; b=b7gieUBM5vJMzZaU
	+w9ibmeEAGhBHiRgS8NA/wNEeftvfnrTe6HOawf9A60nn9GmqmlLUhF15By6g0A29xAI4GqfQmM+C
	huUnSf16vMCprhvYlD0E24rANRscmJCIh0Y0E4n2p1BE45iLZU/cCBlbquEWhRDiaBG7EE/2Cb3Rq
	DSwO5O616bw2OI81OUlFIp2xyECEQAbJftNPaJ9cI1zKSCLnm7KGMWb9Az2zLnGgefay3U1xRn0EL
	+I5YVG2Z6HphIynHdG0R1l3b4pnr05b3Bw8GwAiEJLLRNxUHp+Ezfw3ayEr3fG8G/1uuBWZ92pjKb
	acq1xf5m4z5WI64w5Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcPaj-00CISv-19;
	Mon, 27 Jan 2025 13:55:53 +0000
Date: Mon, 27 Jan 2025 13:55:53 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, roberto.sassu@huaweicloud.com,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] bpf/umd possible deadcode
Message-ID: <Z5eQaeG92S5K8J7I@gallifrey>
References: <20241114022400.301175-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114022400.301175-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:55:34 up 264 days,  1:09,  1 user,  load average: 0.04, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 
> Hi,
>   I'm not 100% sure about these, since I'm not quite
> sure how to test it properly.
> 
>   As far as I can tell the UMD isn't needed by bpf itself
> any more; so I've got one patch that just removes that select.
> But then that leaves no users of umd itself; and I split that
> separately since I saw there was still some discussion this year
> on other uses.

Hi,
  Does anyone have any views on this pair?

Thanks,

Dave

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Dave
> 
> Dr. David Alan Gilbert (2):
>   bpf: Don't select USERMODE_DRIVER
>   umd: Remove
> 
>  include/linux/usermode_driver.h |  19 ----
>  kernel/Makefile                 |   1 -
>  kernel/bpf/preload/Kconfig      |   5 -
>  kernel/usermode_driver.c        | 191 --------------------------------
>  4 files changed, 216 deletions(-)
>  delete mode 100644 include/linux/usermode_driver.h
>  delete mode 100644 kernel/usermode_driver.c
> 
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

