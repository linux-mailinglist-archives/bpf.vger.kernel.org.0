Return-Path: <bpf+bounces-51155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B2A3103B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3C168A68
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4A256C70;
	Tue, 11 Feb 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVyVzqYe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420702566F6
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289058; cv=none; b=q5fHfpsdJvvhkP2HZ3R85laAdQUoq6viN6PyLv1lPD4lRczTV13ygK6ICS/jnfWPQYPMsd0KtJE27iF7kvR64QHxefvFx99TAfLCnNXP6KCFJl0G2b+ZAHwxGD2KlG0K5kc63ZaZkFHAwV9X5EseRQ/4LnPEotKP4SWH4qiGbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289058; c=relaxed/simple;
	bh=w9fKiC5SiHjWDIiZd467Yi7DFoWOHi91Rf6xy7XS+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE4zG8cQJRRnYjSUjTfKTdGT4w0wDD4dGsXMmi8kVXZqF53nkkXVgeUkfqXhdNGYuP4bsGmBJ6hWL1SUxn6okooCOEoqiRgRwVZJXqGB7Zn1o3kzUvaaweLAzeaONrgyefjlZpjk/j/FY50p+6OyS0zL0Bp49p3thLAR4mvrd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVyVzqYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C29CC4CEDD;
	Tue, 11 Feb 2025 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739289057;
	bh=w9fKiC5SiHjWDIiZd467Yi7DFoWOHi91Rf6xy7XS+O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVyVzqYenOHwT4M1ZjI3t2WmwvGp7EhbCh5w2ZxXiZhMfZQDyUaTsbu3jWXCDh69C
	 B40s+tx3PyaytBiIjj0LM4PEktmhofldx7DJgsKjIP3ulnOgJPtUfM9DVliHrFw4+L
	 EoTkRRcV0ITerarZzlLPET4G4sF4ZXzlnVbUJSJKKtQLI0bSSVmJsuFXyj5bLPDoUB
	 lESQUGu1glyU8+d4bBfwGzdUsqdVP/ZUj8p69sNpQjmkagXWubdgCgWX9FinK5SDZ+
	 QbCzi44sjGdOYInk/4z5k/z6bBXYKv1ODYGk25Yrj9DeDgraj5VBIZsyjYhDaryxtX
	 aIrwCAOpBOn/Q==
Date: Tue, 11 Feb 2025 07:50:55 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, peterz@infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250211155055.q2kequxtplzz47u4@jpoimboe>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211023359.1570-2-laoar.shao@gmail.com>

On Tue, Feb 11, 2025 at 10:33:57AM +0800, Yafang Shao wrote:
> It will used by bpf to reject attaching fexit prog to functions
> annotated with __noreturn.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  {tools/objtool => include/linux}/noreturns.h |  0
>  tools/include/linux/noreturns.h              | 52 ++++++++++++++++++++

Instead of moving the file, please make a copy and add it to
tools/objtool/sync-check.sh.

-- 
Josh

