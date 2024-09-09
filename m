Return-Path: <bpf+bounces-39313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F14971945
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682991F2217D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72211B78F9;
	Mon,  9 Sep 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Owt3Lkx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C761779B8
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884696; cv=none; b=jG7gjNc9rK+VsevYvPLkE5UCFwb+JNKV3nH98w9kBtqVoOdMmABu4Coq9glYCi5BnM75aK1U38uJC7HNPvsf8hu+N3F0OSdAuufW3uQzIRZJU+odIdyIoqpqS4skZNCznLzyt+EdiG7jpDuYsseW71+XEcIshjBraC2m2C/Olns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884696; c=relaxed/simple;
	bh=qbd9clm6ZaYmfnu/T/GAs+LGauF4KDaQQfG33kp+ZiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRbVanC2tKJZLmYzmnGm9fYs8WIfFYdJHLnLWtGbxRRb5CLem3UVI6xGxbr+HXQPNDQtnUt3yukkCYqnU5Y+RqOLjEIDbCxiyBxZpSEgvxOrfxESSGBnR3t6kPEvD/yu9Uc1BeXIsNBmF8cRbt1tDyVR5t1hQuS+ZHEprWNKLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Owt3Lkx+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-536584f6c84so3945348e87.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725884692; x=1726489492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8O1MECMS6vYU5/wY9YLnw9CPhcIj1REa6kn0lOjiOo=;
        b=Owt3Lkx+eGGNae5FkFGGW85pREezfTVpl/qh/y9fjb3gV8XOcSV6sWIFn8va5ti+jF
         xGMT00JQWy/nmwvt6HnX7BN8s0aPTi0RnZjCbne+Q7JSyY2y0tsd+rdBW9LmfueJdTAQ
         Oz2TmPWvABssknYC4RMOmcGAuj8mOrZ73H6LVc7GN1tVnmdq499ZnkSLaT8hHgf956BQ
         PJ9W5lqZN4QQQWTjWdpqgIdzkjFKhO69/RdofZkbqpmhi+/0BQUvBpXI+RTDWGIIUWO5
         5sGQhjAd/DKkAWplz0lk7TJ8zyToX/H0RFjmNrGRHIPz6pXRCdpEpk+mReXNkWnQhonb
         R7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725884692; x=1726489492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8O1MECMS6vYU5/wY9YLnw9CPhcIj1REa6kn0lOjiOo=;
        b=vPVjJEZ53/wSE2PgUzA9RwaLNI4ArOBu6x9Dfu1vem8qt7lJNft+T+TQYH7Q57XOca
         DxdOSTZmc5LNjmfTKP8p5ssIqJZhRO30nOX8QTKRstSlYsUnZBmihI08Alv/2XgTQA9B
         Lj0y9sejkwzF11B7haYP6MmlCEUm1eyA/DuffljzXeG/KySEyjV2pcwLGcuOAlPeZpmG
         h9U/hP05fNsdACVH8D7vMTr5SOeWZnBNd3ZOzyOD0cBawO5IPsOnXrEHcEmaN/ipxt9f
         40iKYcWYdAc9Mt4CE6xFkfIwW+uF2pJme3h36B2CakHfzpJcfPCaO+ooeGuGHjwWAS4C
         vgfQ==
X-Gm-Message-State: AOJu0YyeYny3GVUQA7pLa+wU8LESeSAFSvJ4slmaok+LilIPD3i2a4aM
	nb9pTj6bN2iDC3zpOEVAEPgJpOp5u+oJO1NzK/2tFZGedkiC1sq+8fE+CxWLB2Uc1sHGHxQ3JTk
	3epI=
X-Google-Smtp-Source: AGHT+IF/WiX+uUFAWp3HrDKxMKzEMIO61VTydEnEwXU5GF3ZULTuvGja6+COKnUuxmwRvhFBnCppfQ==
X-Received: by 2002:a05:6512:3987:b0:52f:244:206f with SMTP id 2adb3069b0e04-53658809f15mr6740612e87.53.1725884692231;
        Mon, 09 Sep 2024 05:24:52 -0700 (PDT)
Received: from u94a (1-174-29-79.dynamic-ip.hinet.net. [1.174.29.79])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dbebsm1076603173.17.2024.09.09.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:24:51 -0700 (PDT)
Date: Mon, 9 Sep 2024 20:24:45 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	kongln9170@gmail.com
Subject: Re: [PATCH bpf-next v4 4/8] bpf: Improve check_raw_mode_ok test for
 MEM_UNINIT-tagged types
Message-ID: <3lw4bugtgnznmxm3hebolgyfpyicd2vzsfjkmlhc5jd6dkpu6k@wy4l3ztrs3ux>
References: <20240906135608.26477-1-daniel@iogearbox.net>
 <20240906135608.26477-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906135608.26477-4-daniel@iogearbox.net>

On Fri, Sep 06, 2024 at 03:56:04PM GMT, Daniel Borkmann wrote:
> When checking malformed helper function signatures, also take other argument
> types into account aside from just ARG_PTR_TO_UNINIT_MEM.
> 
> This concerns (formerly) ARG_PTR_TO_{INT,LONG} given uninitialized memory can
> be passed there, too.
> 
> The func proto sanity check goes back to commit 435faee1aae9 ("bpf, verifier:
> add ARG_PTR_TO_RAW_STACK type"), and its purpose was to detect wrong func protos
> which had more than just one MEM_UNINIT-tagged type as arguments.
> 
> The reason more than one is currently not supported is as we mark stack slots with
> STACK_MISC in check_helper_call() in case of raw mode based on meta.access_size to
> allow uninitialized stack memory to be passed to helpers when they just write into
> the buffer.
> 
> Probing for base type as well as MEM_UNINIT tagging ensures that other types do not
> get missed (as it used to be the case for ARG_PTR_TO_{INT,LONG}).
> 
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

