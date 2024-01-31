Return-Path: <bpf+bounces-20787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E98434FF
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A691C1F26550
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 05:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF03D0CE;
	Wed, 31 Jan 2024 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FifW53ua"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AA3D3A2
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677495; cv=none; b=XIoQrVKNq/wC0wuu0M4SJBcAadhlsJ9Sri8N3F0bisNCCgx3Swb06Hz0H0HwHgH8wtNxUKmrtOugWt/xfPhx7gDMBIkRU07Xo787RJk/ulHKxDTMdaueyAH9RNcgqQtnDI1QQ+5IYQFvRdvcOHI1yEXUGz2W5+Jc0r1Db/cKbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677495; c=relaxed/simple;
	bh=C9vWX+awcFfBp63hcUfmSVYdgIy2fALJDOlCmoC9sZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvLBEoTQm3Lw5Btadmk9tjWA1zVP068mlM2kNVBtyIi4s7HFAkMdTTVGx8idaPBRJ4McwNPbIXoanUH3/FeuNU+ZrhKTXjvpSTYFxsi8sqSj3vlC4r/zDBOWiB38g7n1QujdTAn5AEk5wtvRESRm2+kdMHdyYJE1H+TdtugeEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FifW53ua; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00be02a5-2265-4626-ab61-1e32de5fc2fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706677490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvsfyZrrJe2Jr40+m/WpNq+ooiB4MBn8T/fEziQfXfw=;
	b=FifW53ua0rLjNBFXh+9q3XLslx6fmeyS9O/SOXeJFRFt8dQMlUKeaqfOt2p/nHB8SXFx8B
	XoZ2O1OYyl9/osKs9UyhH/uCRV3f25KoAHXqWUlF24wsTrLkV3W3socN5rO4Jhy9m2k2td
	RmC4h65aE5jOivU4ePXalNRYAen13Xw=
Date: Tue, 30 Jan 2024 21:04:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/5] libbpf: call memfd_create() syscall directly
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-2-andrii@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240130193649.3753476-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> Some versions of Android do not implement memfd_create() wrapper in
> their libc implementation, leading to build failures ([0]). On the other
> hand, memfd_create() is available as a syscall on quite old kernels
> (3.17+, while bpf() syscall itself is available since 3.18+), so it is
> ok to assume that syscall availability and call into it with syscall()
> helper to avoid Android-specific workarounds.
>
> Validated in libbpf-bootstrap's CI ([1]).
>
>    [0] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7701003207/job/20986080319#step:5:83
>    [1] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7715988887/job/21031767212?pr=253
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


