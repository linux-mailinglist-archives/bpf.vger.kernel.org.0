Return-Path: <bpf+bounces-46864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E958D9F10A2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE86281BBC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5861DFE08;
	Fri, 13 Dec 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPTMOPu+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372E1DFE23;
	Fri, 13 Dec 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102964; cv=none; b=RcIHXDEvwOMd/kpsh3TOsdVLCR2j9mEMQ66EUt6teVF6Bmc192/rBMHPhNdYoHJJiTW0FalDR2Wt6VG5EGjdbSTBTfV60J4xl8Ve/NtaipmwKGW3MtrreAjSzVo7uQ66hKlKJOzxVlqmH4QAqTIngaIVR/U+CBk5MPSYYy0tEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102964; c=relaxed/simple;
	bh=gYOGS+e7CMSucdNnvE6+e8/W0T+IWoKW1qUUTC1SSyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vy2ugvzgCzp1+WpETDvxktlI7eFyyaiKmqHayJRs5KbQqtkgdYd3txp1oa6+/lD0tjHe09IMCrApdLju/YrShX0J/PTaU6bjnG5QXiy54FtFYhV3sTgQ/SX5mE2Z2kFS0SNHN44nWXC9UlC5deBGZiByAVaDelZebiwALejJEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPTMOPu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBF2C4CED0;
	Fri, 13 Dec 2024 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102964;
	bh=gYOGS+e7CMSucdNnvE6+e8/W0T+IWoKW1qUUTC1SSyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPTMOPu+S4khtrDrNgfxn7rl5fWSyl5AevX6kej7oZK+D9dG79KMS0MvSHuK2B4Ry
	 Lk8Qn4dmU1AOh1ZuCRoj7bzq48jjys5uhPaFTgPKrcyMVzssPhQEbB8giuGvekWL8/
	 WR3wFwAZymeWbTNRCJJpEPd0RPjFGB2lLtn3VHEuUAoi3Hc/LXeQIJTtkW4d/lmtfT
	 ioBVFckrrbjt5I4dUf80WIk0wtDHSfbLTRAZkuNxVTaAtycJP+rcJ5BWF/zDlMBibt
	 LyczVr5M4c8/C+OSYWPUwhpmmpAB0tgb9CP55U9zpXQal+q9FD0lPO6iuIV2y1DUKl
	 1knQo2sbaqURw==
Message-ID: <8d702d19-3c73-4908-980a-248773abcae2@kernel.org>
Date: Fri, 13 Dec 2024 15:15:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/4] bpftool: btf: Validate root_type_ids
 early
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com, antony@phenome.org,
 toke@kernel.org
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <5b5dbe4219d051f0184b8f40e35f47512ebde07a.1734052995.git.dxu@dxuuu.xyz>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <5b5dbe4219d051f0184b8f40e35f47512ebde07a.1734052995.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> Handle invalid root_type_ids early, as an invalid ID will cause dumpers
> to half-emit valid boilerplate and then bail with an unclean exit. This
> is ugly and possibly confusing for users, so preemptively handle the
> common error case before any dumping begins.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

