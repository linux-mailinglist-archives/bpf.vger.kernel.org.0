Return-Path: <bpf+bounces-52776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21C9A485AE
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90ACA7A52FE
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDCB1CAA96;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLB2jaNm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D41B21B8;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675026; cv=none; b=eAGj3XzIwuVHmjbMvYifbf3ivDd5P3+0KVDB0M8mGLPaD7b34vGI1V3ylhVan0Cyigyb6lJJmytFxUFxTimaJm2Q3wPh4hDeEDI9HE8Vzcomtqss0yKwakIkf/OpnGXCMRiSFP4U/kHYXJOgjpbWcT0FDLUENR8F8rylMKrMDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675026; c=relaxed/simple;
	bh=JAW9f9N92yK7POtGQNiZGOWSZkkGb8CrfNa1yfpMZkU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=he5jKmTdQBXxtSh2CsrTWruPJC1uuHFLd+xzXDXiZ6Hd5pWiwLDFN7CiTO2+RCpf30t+nF7w1CTv0DA7hs5vsVPFFInWSRb8EcQRPdmv5BXMT/qS3pK4bZH1IJJO2KzhMapdANoAUVoTfojXYROVMAPxm7vxReEe6V2rpkHHxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLB2jaNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17145C4CEE9;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675026;
	bh=JAW9f9N92yK7POtGQNiZGOWSZkkGb8CrfNa1yfpMZkU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=sLB2jaNmubzcaxnlOBGcN5vP7KXIPZiraqCMkM/AqMQfU5tagsLbrh2nVrf6AhjRU
	 iU62KnK4iJW7OYt2WBqYiSw8RvCpj9UIQB6IqmOWFWrEQ0VUFEMdcbFHcpiBFflV4R
	 QgIM5dEZ80VtHuGtB+FzUJBBR8jfTrY3h/0cDb7l8wrHURW5kYWc2hziQeJ0biZFO/
	 TX6QtOESv0N+YTsixdagyZENdncsmtqPOEQkHM7MiiVw0CcbV2Nmct3McpllOx7xqv
	 h/5hyYaDbTucRLSLocFNDM5GrvAyqrjqzX2B9G2+Qpxt2P+KN2Xup4s/2fZ3OqiSYt
	 hnUEkbR+yEB2g==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 Gabriele Monaco <gmonaco@redhat.com>
In-Reply-To: <20250207080446.77630-1-gmonaco@redhat.com>
References: <20250207080446.77630-1-gmonaco@redhat.com>
Subject: Re: [PATCH 1/2] perf ftrace latency: variable histogram buckets
Message-Id: <174067502605.1401960.295346748722727301.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Feb 2025 09:04:44 +0100, Gabriele Monaco wrote:
> The max-latency value can make the histogram smaller, but not larger, we
> have a maximum of 22 buckets and specifying a max-latency that would
> require more buckets has no effect.
> 
> Dynamically allocate the buckets and compute the bucket number from the
> max latency as (max-min) / range + 2
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



