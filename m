Return-Path: <bpf+bounces-70383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EA1BB8FAB
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6501C34643E
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58327EC73;
	Sat,  4 Oct 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1aES74q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629127AC35
	for <bpf@vger.kernel.org>; Sat,  4 Oct 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594505; cv=none; b=DnM7UplbYnQFT8U9U3w8EWwm7epNdXk1E8y7XRxNx8tBY/MRXsj3VQJi52V1WRzZ/kD4VJ9ZEoiDyd4vyWWPWNeEr4Ld23pZAYfRRhsqqCOsHkW4pUBCpjYs7NwYMzgIDc2Lwu4t7W9hSwEmkys04z6YFztenKQ9LO7Fzw57G/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594505; c=relaxed/simple;
	bh=8o6UQf+gZU1yTFkaOSCz+N2+6NM/LJ0GmW6jYusoJmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnkFSV8lSP2zrcQNthSxervWSqPJkzKjVM0hz8Jqlob58mWBLYkq6STifYfKLAwUFJoSkEaIrSGln745vugcmo6pImkWEsXoi+FGmG83KSfUKHv+H2nBb7tQ4jV/NY8eyPZOegCeOdIU6cIFMRh5ippsZxyI8vbEHt4qr+LXndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1aES74q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77e6495c999so3438994b3a.3
        for <bpf@vger.kernel.org>; Sat, 04 Oct 2025 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759594503; x=1760199303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYj820t12DuT/Y3GHE/koJeP+yNK86CimN/bpcr4Dww=;
        b=K1aES74qTP40KTvUiLJM0zZhVG8djUVvVJqkHmhB/ArPWtyiyrVPxFyph8ci65JMeQ
         k+H56e8DBk0IpONMBtD+YpDQuQFi5T1TOHwpfoMCNd/UjLw8cLQL4i9B/vwPJw4Y9Uhp
         K+yGms1mq9lditqZjPb4E3eAEEJ3FxLufvuSawg3Kh0PfVjdVW77DPSQ7f8n+xSLiPyw
         t++rbHlt6cJjdGddYtXBYVHmntzMIa8xvzrAnQHHfmmsWvfvd2wThkEtCHahIp6kA/cL
         SDhsbm9ownR4Q/t9/mnpZVBhB5g0fUA7Xu5YPAZjtcRT8xyAsrKhXUARsKbadsjLI7g0
         +6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594503; x=1760199303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYj820t12DuT/Y3GHE/koJeP+yNK86CimN/bpcr4Dww=;
        b=PT/IZAsvJQqReNryRaYOxyJeEpK/7Sf0WpVU9mzwBQC2j/0aosH9vjeJ9Hc4FJu/kN
         4Kc5CeqlpuU0/3oBLI4rkEmlwYgkXchUr6U4kdVG0jeKqsnaWWLMYjw/rRkmIKrEUGW8
         YWmGM9SlDWm9fw28hTTl5gpgCg+1bh1tNysukThvho9W876x50fNSo4g3Fx+dRQWw0sL
         jRC2lLUHP4qZRoRYqVuYmiB3TP5vPImIw5A/9cwY3bpgPDMNYbbJ3HCQkHxj5/nHbq0o
         KnFxr7PuX1BQ5ELpsmmFRsf7/t06mJKhhK9M3X5y+EFaA0wy0aHGwjwBJWi7ZDshAkhG
         fJPg==
X-Forwarded-Encrypted: i=1; AJvYcCUrZAds6w7WWOSP6MewKO6iHPlVwpTZ7i9tp7r9ndEnSQqi/RCUbjKhGayu9y2I+TndhQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKs1RYqD+GM/lC122Jzv6gYoE/K+NNy5EpliXOYl2Si82BUUN
	5YqJhZwLZ8v2VH4gq7/jGN2nq2fKgWqZ0toXdhZrPXLpWsaWJ3T4ksj+
X-Gm-Gg: ASbGncsjlE84l4xS0SrHmJVlFPTJI792RY3Fu2oiMkeb9023Ni1XXORffQo7yL0dp2q
	ElE4gI84wqKIFMoasd/0WEyFrqfuMLf1yAzdzzKhPhza8R055HUO0n6StO0eEswCnN3ZyuQkAv3
	4jEZDVTWd84ql/UUJ0B+iJqpf4bBAiuGn3gXkT3i3ascMyw3WaXZwzvfVJRbQ0KmgD69ShMSa7t
	3PYqEwUaG7QE/eu9Vqwh9iG8ke8KtTMVxB1lv5wgorAvuvkhV/iNgGi71Owtd/2yPOc6N4zX4pJ
	z0aU4mGbCSUwwDLLB+J/fZmh9EgSEFHOT+g/yZPb5VUBrb959d17FF+6bwv1vS1W9oBOcFgjKpo
	BPsKRGOzhh5ZunX+bxt/OvkgKJoDwBPATuqIwJ1MWYuIKWrwusOKQ5OKCjbaZqARw9lFGfXxJZL
	hq7IYJec+rkg2I5s8gl+A7
X-Google-Smtp-Source: AGHT+IF5mMKQuy9GbvEclpfP5REvAas2+KA/9E9J64gOa1xJUCOWS7yTi4xFt+uA0ZVQvUiQ8KofXw==
X-Received: by 2002:a05:6a00:b54:b0:781:9f2:efb1 with SMTP id d2e1a72fcca58-78c98caeeb6mr7980762b3a.15.1759594502888;
        Sat, 04 Oct 2025 09:15:02 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2001:558:600a:7:f9d8:fc98:ee10:581e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206ea2fsm7848831b3a.66.2025.10.04.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 09:15:02 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:15:00 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, rongtao@cestc.cn, 
	bpf@vger.kernel.org
Subject: Re: [git pull] pile 6: f_path stuff
Message-ID: <7dhno3gp6f6wkgzndanvzyiwzwfkccgahx7bmlqzr65zytupnr@2r3v2lxvgyyc>
References: <20251003221558.GA2441659@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003221558.GA2441659@ZenIV>

On Fri, Oct 03, 2025 at 11:15:58PM +0100, Al Viro wrote:
> ----------------------------------------------------------------
> file->f_path constification
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ----------------------------------------------------------------
> Al Viro (24):
>       backing_file_user_path(): constify struct path *
>       constify path argument of vfs_statx_path()
>       filename_lookup(): constify root argument
>       done_path_create(): constify path argument
>       bpf...d_path(): constify path argument

This commit broke bpf, since you didn't update include/uapi/linux/bpf.h
and other places.

bpf mailing list was never cc-ed :(

Pushed the fix to bpf tree:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=de7342228b7343774d6a9981c2ddbfb5e201044b


