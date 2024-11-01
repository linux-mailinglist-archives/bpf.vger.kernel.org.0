Return-Path: <bpf+bounces-43683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E36D9B87C9
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0699B283B9B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410951AAC4;
	Fri,  1 Nov 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLejt1ST"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B17E571;
	Fri,  1 Nov 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421669; cv=none; b=drHirQdZF7RW00ZwNoY7GYE59u4J9yYHoE8TDtmnrpsM97b4tlTWruFwACaX3sJPoM18H9r5tzcUWVmSFAaNyVIjqwXdcmLw+T38m947kaDr3MZdHp7bBBxFmNJtot/7Yk+HGauhKO8ZWEiBKrxIQ3WmATdXv4x8JuT4X2VquQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421669; c=relaxed/simple;
	bh=twr7z/emcoBopme+4Tss4A9YUCHWjxImI6nYopsENi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNDBZ+YGgRWLYqpvwRej083nG8Z37sES7/zEewycw+7fpSNXGWg5Sz4rrrJkEaTMWWhieDeV4u7YBDX3Cb/BKV7ah7+oG3wtRVTAuagRe1Sy3I+GHs3pW2tJ3Wf3vsHaeE3zhe8E+q4g+8UJTR3PpVLfBXzRUnmYH0lGPoObONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLejt1ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CAFC4CEC3;
	Fri,  1 Nov 2024 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730421669;
	bh=twr7z/emcoBopme+4Tss4A9YUCHWjxImI6nYopsENi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLejt1STW/04OSGTqMCYkF3ZDOJgRmg9YpQaFMCzF0ClRqVhz/uWLsIfNa0SiMYA1
	 Zt1r+2cHZAkO5LB7aMoWpdAy0C6J9HWpXIIDHwpTKSXaZUMZ1fMD0onoMiQGLJwa45
	 NOUcH9MCHPACHMxJpS+YOvnaeIIgwKeYtlruSxSm7ddHdXAVz9sdOk1Gj3O8Ce30Yi
	 nmMmCwpbcom2iGKCNoRga40BeqFLYKN4bsmvYHViCdaIZfaGmKAWmjyMSBk2gme2fW
	 lud4s81C1GlisbEl0VYUdE9xbPv7jgsLnbDc8xiBTS1A3MhM2b5r16gVriUYh1H+bA
	 yKI+ja7f85Thg==
Date: Thu, 31 Oct 2024 17:41:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
Message-ID: <20241031174107.02216ff9@kernel.org>
In-Reply-To: <20241030165201.442301-11-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
	<20241030165201.442301-11-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 17:51:53 +0100 Alexander Lobakin wrote:
> -	struct xdp_mem_info mem;
> +	enum xdp_mem_type mem_type:32;

There is a new use of this field coming in from c40dd8c4732
Can we wait for that to propagate to net-next ?
I don't have any great ideas on how we can conditionally apply
a fix up in the CI infra..
-- 
pw-bot: rfc

