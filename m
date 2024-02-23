Return-Path: <bpf+bounces-22590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA1861600
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5621C23209
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355F823C6;
	Fri, 23 Feb 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHgzjM+U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA38484;
	Fri, 23 Feb 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702684; cv=none; b=Ufrz3ldiL+ADtUyMmLly3s+Jtm0dvssBMc8+4BqoBb1gg8i2WZvYPqMSFiI7YJ56YLedcvXMyfGEW9saQdLz8FZXP3tLPN9TyFHfZuz8mmO7V3j7z+h+IN10h7wiiR5DuVN3ZXqTlk/X3zZGeabN+91m3GYJM//d9VwWVBUT2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702684; c=relaxed/simple;
	bh=APBsN9+KlkPc+UrYUeuDlX7HNno6Yv7Gwghsm2RlvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjLjdC1EPrm1c3ZHsjCY/VXqZrSBvmcz2lkNd+XAp6C8j7J+cLAWnUA+xPmDKmpZlM3uuDFVaIJvQ3m/+lbN7Ws+cqxYwmI1sDc4MUEya/ZnibnS28YQtcNRiNs++PkETcSdvIt4Z2hE2sqeZh2szDN0xQN33vAC3pii/Ir6BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHgzjM+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44718C433C7;
	Fri, 23 Feb 2024 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708702684;
	bh=APBsN9+KlkPc+UrYUeuDlX7HNno6Yv7Gwghsm2RlvrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHgzjM+UMpdBglmrtj/aI9mYZlEir3q/Nq6zVBfYrJoRIYfhHdfXtzZoVyeCBwlgc
	 39zvMpxBMnHoe4brUJ7D+kZFNaBH8VqkB5qZVpdrC7yAvXHjc1YWWFaBKN4Of/cQj+
	 MxCGBZhf+wloTe0yY+s/W18qkaV6UIykGZXQ+35af/EKOi+ishr//JDbLTKZAON3PW
	 VLLcPfkKh/DuXxMnAI87g4EQy0UnZ+/YfZbRBzXOzJU84HqEngBWIsev3f9O/lgREz
	 62JLzl463AU2GVCPlKhQL89QFfp7E1GzPGZvU2etc68VG81FpM7S8qDCY5mwS94Jsf
	 /NlLoMEhHOL3A==
Date: Fri, 23 Feb 2024 07:38:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org,
 dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com,
 pctammela@mojatatu.com, victor@mojatatu.com
Subject: Re: [PATCH net-next v11 0/5] Introducing P4TC (series 1)
Message-ID: <20240223073802.13d2d3d8@kernel.org>
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 08:17:23 -0500 Jamal Hadi Salim wrote:
> This is the first patchset of two. In this patch we are only submitting 5
> patches which touch the general TC code given these are trivial. We will be
> posting a second patchset which handles the P4 objects and associated infra
> (which includes 10 patches that we have already been posting to hit the 15
> limit).

Don't use the limit as a justification for questionable tactics :|
If there's still BPF in it, it's not getting merged without BPF
maintainers's acks. So we're going to merge these 5 and then what?

BTW the diffstat at the end of the commit message is from the full set.

