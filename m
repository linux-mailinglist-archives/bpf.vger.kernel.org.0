Return-Path: <bpf+bounces-50763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282ABA2C36F
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5297A41E0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A401EEA30;
	Fri,  7 Feb 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt3BIUZc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4F9454;
	Fri,  7 Feb 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934538; cv=none; b=LoJe+qqhUbG1Nj8gup5fw2H3SiuaFAYj+kFZX8UGqZImnzvpME6Iiub6FeMZ/g5RKPiJUJge5ZrAPKnxzi0cnFHgbvbSMOsqfrc6fFtlQF9WWydfZGdUSm+neVjUz+cjA9Yf6Ya+lduuHy4pYtNxtmQHuXoXIDy+fJDNcEgyW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934538; c=relaxed/simple;
	bh=Wy55z2A7zpIwkTIatDI+30hDYBAGCJb0t+R7kWx60D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiH6C5N9xl+nravN7R1Phf+XV+c3VQTGf6WizzW/tcWBeWyNa7U2RToKFrPCtZI0F0OTMvRFMq3UsK6o/8j9MQ/eVgUMj3FIovbQ21g9fiQrkO1hVpqRjZjxXK/U4i3RrCYx2u+S/LOf5FqNKrAq1sjgsOFOeFjDwvN4yRZI5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt3BIUZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFD4C4CED1;
	Fri,  7 Feb 2025 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738934537;
	bh=Wy55z2A7zpIwkTIatDI+30hDYBAGCJb0t+R7kWx60D8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dt3BIUZcjzE+jPzmJPe00GnR6cv0mZHVh/xlK6Eb3bSgl6MFSvm6bxqdAVm1smA+q
	 ksHrqvqWxhU1IDHWk3S7kFzs2LVmNZRU4ESSOlrsxh4g+jwft8/wmyD7EO95MUB1pW
	 2SYYwwLziycDT8P42CDYUsOaeVig89wpkpieHTBZuul/LwO2LcQ04wquIeGp6tNFK9
	 cszPLKnKWdno8HKAVConTypsF2hWUuWr+NSMJt5o1TOGNcAAGIsY3f5owPU/oL5tig
	 4c5yzGR67Xo5bDb5Kx7P/L7BoVpTPnL6HaJ4v/lsjUqcQzA4KooYlQZYZZ1jpBmJg7
	 mhTwIMxjSFDBA==
Message-ID: <62e8afae-46c9-47f4-9878-ff7064ca6a0e@kernel.org>
Date: Fri, 7 Feb 2025 13:22:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/1] bpftool: Using the right format
 specifiers
To: Jiayuan Chen <mrpre@163.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20250207123706.727928-1-mrpre@163.com>
 <20250207123706.727928-2-mrpre@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250207123706.727928-2-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 12:37, Jiayuan Chen wrote:
> Fixed some formatting specifiers errors, such as using %d for int and %u
> for unsigned int, as well as other byte-length types.
> 
> Signed-off-by: Jiayuan Chen <mrpre@163.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you.

