Return-Path: <bpf+bounces-50771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADFA2C534
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A8A7A056C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941D23ED6D;
	Fri,  7 Feb 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H10DeDCw"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD021DE895;
	Fri,  7 Feb 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938501; cv=none; b=Ey9fzCEXcTQ7dWsrWG5SE7UYBp2FxXBweyrxaJ5N79CCgOVADHsju1iFwtdRi2CP9eMF2rku8U1KgjXruD9sX61XOcZ33HK2apUqt4EV1IG/dEmSdITljP0YTWzu5mWGliS9aO8GBBUO44bm8G9jQR12uuajhT+CxLBFVPSWYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938501; c=relaxed/simple;
	bh=MwdoeEXQ8mJeE7G3ap2eNU3NTu0GZZJpUYE0xplhaeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du7Qn5fR9OCfN6R+N8SbWaXcUSYMaOE1n6zJMOPwLeBmARAg//yPhfdVD6Y1indSyT7Omf6Im2iHkayLZWmlriUz5RfMK2J8L2jQPE9aWZ0Ad3L/Noau8cNNqBHB2azJDps5PWQQhHLALZRCyAtYTSSpST+23rZg8QN2tSmwmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H10DeDCw; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=kOAPgohBMCKwPydygDCBgfWNNOv6S5QNC10c3453SRM=;
	b=H10DeDCwqDYSX5D+zHqGCPLt9YxIImjZW+NKJcBbOUVdFTYBqotThOgVrtjS+i
	VeEO8pzsl5fTL3vtjZotJdM7aDKVg5eTNbsx/i4aBvYKg0hNlvg7ctYyGw9QDEHv
	V66xJ5mENhbafcfxx7KIYX9geodP7V1zDT0m+dG8C+Mm4=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHmTw8GKZn4EPrKg--.3845S2;
	Fri, 07 Feb 2025 22:27:10 +0800 (CST)
Date: Fri, 7 Feb 2025 22:27:08 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v1 0/1] Using the right format specifiers for
 bpftool
Message-ID: <7gpn4zamubd3j6d3wiywpfftbu7vxawrlwzjwse3lbv3ovejlu@2vfemcisx5pi>
References: <20250207123706.727928-1-mrpre@163.com>
 <88cb50b1-a0f2-4763-a340-e74bff9f9f8b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88cb50b1-a0f2-4763-a340-e74bff9f9f8b@kernel.org>
X-CM-TRANSID:_____wBHmTw8GKZn4EPrKg--.3845S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDKryxKF13Xr1kCryxuFg_yoW8JFW8pa
	ykAw4DKF4kAF13Kws3A3yrZryFqwn3J343JF1Fqw1DCwn8WF93XryxKw4UZryq9rs3X3W2
	va4Sq3y5WF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiNV9UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwbsp2emD090uwABsN

On Fri, Feb 07, 2025 at 01:22:19PM +0000, Quentin Monnet wrote:
> On 07/02/2025 12:37, Jiayuan Chen wrote:
> > Fixed some incorrect formatting specifiers that were exposed when I added
> > the "-Wformat" flag to the compiler options.
> > 
> > This patch doesn't include "-Wformat" in the Makefile for now, as I've
> > only addressed some obvious semantic issues with the compiler warnings.
> > There are still other warnings that need to be tackled.
> > 
> > For example, there's an ifindex that's sometimes defined as a signed type
> > and sometimes as an unsigned type, which makes formatting a real pain
> > - sometimes it needs %d and sometimes %u. This might require a more
> > fundamental fix from the variable definition side.
> > 
> > If the maintainer is okay with adding "-Wformat" to the
> > tools/bpf/bpftool/Makefile, please let us know, and we can follow up with
> > further fixes.
> 
> No objection from the maintainer, thanks for looking into this. Did you
> catch these issues with just "-Wformat"? I'm asking because I need to
> use an additional flag, "-Wformat-signedness", to have my compiler
> display the %d/%u reports.
> 
> Thanks,
> Quentin
Yes, I previously added '-Wformat -Wformat-signedness', but I just tried
again and it turns out that only '-Wformat-signedness' takes effect.


