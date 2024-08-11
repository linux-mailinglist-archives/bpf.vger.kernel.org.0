Return-Path: <bpf+bounces-36842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50794E0C4
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 12:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9413D1F21782
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D53D393;
	Sun, 11 Aug 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3dYTZjH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E61BF24;
	Sun, 11 Aug 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723370943; cv=none; b=S7WYw9FQyMhq4OBTRUzhkC2CHyllcYD8eSkBAH/HF7es2hzGDNGSIyLlDawjqX/hZT+BlsJgkmcihca6vg20PeOSP91m1kgaDp7cHh9BVF8WJCUkjYz2HN7AFPGLO2dmbDz24s7iXEiS98lqPyiVA1ZezOdEYpPGUf/64xkYEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723370943; c=relaxed/simple;
	bh=wuajA0ZnMyfkOsfEIXk02pSEr3JtqAnoSajcnVhXru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quyB1wCANWA+1aGVmsCTXyj1QUmSPVr1HsTK0WA7YXsg2uiXCI33lt9j37JAh8HZ+bI1p4lV1C4vv+BphXkqufMoiOmyMlexokpcJO/AbFf8DYUZltXfep8f6U+RdlpsNkA09rqhU011Ii14CIsL2FsFRLaZUyJEF8ggnG4k0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3dYTZjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE03C32786;
	Sun, 11 Aug 2024 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723370943;
	bh=wuajA0ZnMyfkOsfEIXk02pSEr3JtqAnoSajcnVhXru8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3dYTZjHgyvAyYzQ+CFgHrqC5fFOmP4Hi3nxHdOG9O+UsA5KSYGNDheosOBifJAQR
	 gIhZBFagJRsr21hiSBgg45fsB/9PvagCclsD9aE8EAvLf3NYfi31O2V2plp+k9BSX8
	 pPfSfcbcAtV5IKxneJEzlJdjTIP9VHq3/a2RY1Z0=
Date: Sun, 11 Aug 2024 12:08:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: toracat@elrepo.org, stable@vger.kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: bpf tool build failure in latest stable-rc 6.1.103-rc3 due to
 missing backport
Message-ID: <2024081147-straggler-reclaim-3e10@gregkh>
References: <v8lqgl$15bq$1@ciao.gmane.io>
 <1723141233-21006-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723141233-21006-1-git-send-email-hargar@linux.microsoft.com>

On Thu, Aug 08, 2024 at 11:20:33AM -0700, Hardik Garg wrote:
> adding the BPF maintainers

There was no data here at all for anyone to respond to :(

