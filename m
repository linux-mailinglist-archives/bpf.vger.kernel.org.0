Return-Path: <bpf+bounces-38154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C5960A14
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DBEB2276D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55EA1B4C3E;
	Tue, 27 Aug 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewfZ7R9s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB291B4C2D;
	Tue, 27 Aug 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761520; cv=none; b=a+KTWwDRO1K+lXeYo0NVVlpmMZrZk2KW4NWRSn9qg3QZrrwEcA6gmw8++9Ik5AyH+BlqDslKZosgSHDFp3sGiTJ8qddnN5D0lnUAt2c6yBdjCmkD4zUMMbFet/Jriustx5N8/Xye4uiKtz5vls9nFSrP5Z+wQEdPT+B6HzgTJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761520; c=relaxed/simple;
	bh=Qnlb3gzI+fD0av5A4j+IPx7bavbCkcKgy1ctqjJ5VZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiMwrJ7dSiLP7oVNirnFilW7YRUU+ntkTt+w5fTlaW2TfOuoL9YHp/Wh5XFOLoQKrhGJoGA2vlvYDC44NZ4PHJHZYUIgyUUIv/HCqhFFeTd002CUda7ubrbGkCKAz5YiXsLS5+IMOHF65W0sQfIbStPBom/IlEfKFLxko2ln+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewfZ7R9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D9C61041;
	Tue, 27 Aug 2024 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724761519;
	bh=Qnlb3gzI+fD0av5A4j+IPx7bavbCkcKgy1ctqjJ5VZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewfZ7R9s3E0uhuSqrGMJjOrbQzKKCsb3tKrHcyVNEvxNaZOxKcaG9/i2Qx2w584s/
	 wItpWc1QKD2RCjXBKFR7s7O4JusvulIJOe1vZT3rNagc8iCNkhNIhAWd+b2tYOV3f4
	 K2jJUTkO/iCtZVbLsT6xQQVLPlbn2qTCWPxR3yA4=
Date: Tue, 27 Aug 2024 14:25:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.10 2/2] selftests/bpf: Add a test to verify
 previous stacksafe() fix
Message-ID: <2024082706-strongbox-driving-46c5@gregkh>
References: <20240823014631.114866-1-shung-hsi.yu@suse.com>
 <20240823014631.114866-2-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823014631.114866-2-shung-hsi.yu@suse.com>

On Fri, Aug 23, 2024 at 09:46:31AM +0800, Shung-Hsi Yu wrote:
> From: Yonghong Song <yonghong.song@linux.dev>
> 
> [ Upstream commit 662c3e2db00f92e50c26e9dc4fe47c52223d9982 ]
> 
> A selftest is added such that without the previous patch,
> a crash can happen. With the previous patch, the test can
> run successfully. The new test is written in a way which
> mimics original crash case:
>   main_prog
>     static_prog_1
>       static_prog_2
> where static_prog_1 has different paths to static_prog_2
> and some path has stack allocated and some other path
> does not. A stacksafe() checking in static_prog_2()
> triggered the crash.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Link: https://lore.kernel.org/r/20240812214852.214037-1-yonghong.song@linux.dev
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Now queued up, thanks.

greg k-h

