Return-Path: <bpf+bounces-50764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82527A2C371
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436D63ABAF0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB781F5430;
	Fri,  7 Feb 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBjZ6piQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C61F4165;
	Fri,  7 Feb 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934542; cv=none; b=UJWXsQmLUpu3c1w5mmWe9CU/Q56hkwakVNLtn14uK+s0yIkYdQ2gEZkOvv4IVJD/xC5CK6ZxAEpioXZVZkeN2ObN9Ac9x0Egni/ZuuX8HFoXord2xxrVcbIYiJhCBjjtAvyTfHigqhOyNOtcOOMnA2sK03SDWYxjts8Owusvt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934542; c=relaxed/simple;
	bh=dSV3dqxheMYoNM9PXtB6XmpfYvI3Q2PxwDLgOjXU1UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOQsCVSLJNm4ZhObkrHq1AmOGBqWBsox/jQ6NQuf2dKXFsY/sgRt1j93b21hbXjRNoe2nvBjh/J94+9G3MZZEbRX/FZp2owwQXEypRtYAf9xlHIO02rJvNPITxIOpS1m9l/0zB6xCgvokdobnMoPCMVCb4JJUn2cvxy/MRZyOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBjZ6piQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC89C4CED6;
	Fri,  7 Feb 2025 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738934542;
	bh=dSV3dqxheMYoNM9PXtB6XmpfYvI3Q2PxwDLgOjXU1UU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBjZ6piQqQlFgaxrZ/IDKtDZSaGoiJ148a/J+BTJD+5/c9KFDFm1UJL9gpUVM0jbn
	 thg7M6WCToyiFsfKkFVH5wcbXeWrAOhNd7lCFNQk4wjdNYCzKWQ4ZFIgIzJNwdkwwo
	 MVRyLRpwF1R+mZbXQ1lJFB632eYzB05GrhGr61mKMqXQusMEv58k9M9+H6A3L0hK2g
	 pena44Gt12XXXzgIt+1rxwxetTEWHswnOF/++h26sj+8YgfQQPnthlXb9v9wDvc+Vg
	 kRxpx8cmdyhFW9P/8bTjv8sg1A66+JYHejWv7KdV7Qz8JHtgfMbvmF7/6Z7vXhu8OD
	 M0H8WORM31R4Q==
Message-ID: <88cb50b1-a0f2-4763-a340-e74bff9f9f8b@kernel.org>
Date: Fri, 7 Feb 2025 13:22:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/1] Using the right format specifiers for
 bpftool
To: Jiayuan Chen <mrpre@163.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20250207123706.727928-1-mrpre@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250207123706.727928-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 12:37, Jiayuan Chen wrote:
> Fixed some incorrect formatting specifiers that were exposed when I added
> the "-Wformat" flag to the compiler options.
> 
> This patch doesn't include "-Wformat" in the Makefile for now, as I've
> only addressed some obvious semantic issues with the compiler warnings.
> There are still other warnings that need to be tackled.
> 
> For example, there's an ifindex that's sometimes defined as a signed type
> and sometimes as an unsigned type, which makes formatting a real pain
> - sometimes it needs %d and sometimes %u. This might require a more
> fundamental fix from the variable definition side.
> 
> If the maintainer is okay with adding "-Wformat" to the
> tools/bpf/bpftool/Makefile, please let us know, and we can follow up with
> further fixes.

No objection from the maintainer, thanks for looking into this. Did you
catch these issues with just "-Wformat"? I'm asking because I need to
use an additional flag, "-Wformat-signedness", to have my compiler
display the %d/%u reports.

Thanks,
Quentin

