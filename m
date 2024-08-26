Return-Path: <bpf+bounces-38043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CF95E74E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 05:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F12819DD
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E12F870;
	Mon, 26 Aug 2024 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="k2QtItAY"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A164BE6F;
	Mon, 26 Aug 2024 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643001; cv=none; b=fa9nAYVsnPhUDIHgT/PeqBuDXZ4AQ5uBBheiumBewbYMyiPlzOBOhmKboqP0shEfp9GNzzZuNnFrh/57XtlHDsbxdwxaIkDs728tkgDvsYMVs882hHMk4QgbZvd7Uhp7ONKcLy1yjRaUF44oF/z0pmbIQRMUxtV5W/6jSu89YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643001; c=relaxed/simple;
	bh=M4KMCyQsiCR7R5r1mHLGg0HM7/ZwFUGzj3Ob9FSsQeg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qME9hLpopy0AUM2tTNaKUUwBmHDg424Ub+GhS8O0IP8GsJzG650xqg78AMW4EGHjj9SS8vmoL9uSzBX7pmKvJ4pLVG+3J3uuaJqL66hi2SOKd/xOsNt9RrRkpF0BGxBvMCWyvqf/jVwgp2anD/O3TlDKNXveDjEr66bzX/mcW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=k2QtItAY; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724642988;
	bh=/vjvGYarx8NbrGjDYDUIldEzqX5UWX8m8pZ3iDls3ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k2QtItAYn51FPRDneriE0CnNtFDKRbLrsLGKg1l6YQ5dbJ3MCqXSEWztbzB0UjrX3
	 mLzvaJ4FTYvMvBEg4Njk9x39c0GVD1nzrsCHbgyWASHhpoaztViE2MCjE9tpmOAffV
	 SIxoi7DuDNbYgGAOD7cT91ztGM/MC8MMnIj/PiOw=
Received: from localhost ([39.156.73.13])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 76F2E8C0; Mon, 26 Aug 2024 11:29:47 +0800
X-QQ-mid: xmsmtpt1724642987t73clno9p
Message-ID: <tencent_EB51CDCA4E189E271032DFEC7E042B752008@qq.com>
X-QQ-XMAILINFO: NiDupExshEc7csfxVbjAgBIlLQaPO+YPGCTa2poKcBWsMOUB4QszjpIOhWEIjM
	 YHrefu2k+vZzz8hoP6Yd0o/kJ2ngph1YcqihZ8LMalCLe5Ro4UuHoHVorv574wVHXn1d6e68koZU
	 ruNg6E2TsrmbsnMtT78EHvG8zVWF2S5+JzE7ayz7jYCRXHV+aBguOZj98i59yLpfYyKolch2r5HP
	 0dc/u/gkZUGSKAoXL/uPjOljKxzyRvrJRAel4m4pPl8BVa4ZhGWoaiTPq0xyJLZFazLU7B+P+XM+
	 vbnDsYLiD0aFwlQpPFNTRCjICfLg2vXPyu0pthRRP8IO410WTs9XtO9GGORI0KHccKVPFwxN8ng7
	 uOixhPupF36b06Hlug9r7DL1fv5rs9Q4iDsza+bK9zKk+wHyONja+QNzJJs8ur16RU+PxXLGaFHe
	 0+iert2hycPc5gqzfjahtehylbl7LqC1UEDf0EznhDiF8hN9FqZzGhErJKYu4ASpi6ZgWHld6UIR
	 FOquvhZBWDg6mr1z8NZWnBs7aaKVkuZrS7iY1oidqvUz8/aIjcIjHN19Sesl0tIFgitJf/o50Tzu
	 rJOfducwCbFdgE8EkWUySvBnxO5hpKm/bHzLZwCjOEOSq3sdn6MpbcNVKi1+DeWGluOeS4LozsaN
	 DbVFyKmml7NvNky9VNTz+y4QjienFUJArcinXopP4VzQqG+EkVCnRRm0r3J+IojJen3AjTumZRwu
	 odm3JBq8RGT9ZwQUmjETxZWth+jk6atwgs5vYGDmTsK5+WISzfvyr/cdAm1O52wmL4kdKkQ9IBJ+
	 i4w6ao7bkIZqO2vvEMPkdWzeNsyohGh2wEn93tPJIFtE5KwsH5SpqJZ47zGhsPSKzDkU3PKxNuXR
	 FMcGnHOyQwMNUtSOy+50icmBv/lzpylbs3tqjg1+7gXE289y+C0H2AE7SriTK3dGEjPnEhkoSz4C
	 tUKeMSl1c7TBrZ10A8agd0lHlGvBEsBh12ntPW6QmhJaOpxZRpuQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Date: Mon, 26 Aug 2024 11:29:47 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
X-OQ-MSGID: <Zsv2q8C7QmPTcyVa@yangang-TM1701>
References: <tmcxv429u9-tmgrokbfbm@nsmail7.0.0--kylin--1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tmcxv429u9-tmgrokbfbm@nsmail7.0.0--kylin--1>

Hi Alexei:
It's my honor to recieve your reply. The response to your concerns is attached below 
for your review.
On Mon, Aug 26, 2024 at 10:57:12AM +0800, Gang Yan wrote:
> On Thu, Aug 22, 2024 at 8:33 AM Jakub Kicinski wrote:
> >
> > On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
> > > diff --git a/net/socket.c b/net/socket.c
> > > index fcbdd5bc47ac..63ce1caf75eb 100644
> > > --- a/net/socket.c
> > > +++ b/net/socket.c
> > > @@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int family, int type, int protocol)
> > > {
> > > return protocol;
> > > }
> > > +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
> >
> > IDK if this falls under BPF or directly net, but could you explain
> > what test will use this? I'd prefer not to add test hooks into the
> > kernel unless they are exercised by in-tree tests.

> This looks unnecessary.
> update_socket_protocol is already registered as fmodret.
> There is even selftest that excises this feature:
> tools/testing/selftests/bpf/progs/mptcpify.c
> 
> It doesn't need to be part of the error-inject.

The 'update_socket_protocol' is a BPF interface designed primarily to
fix the socket protocol from TCP protocol to MPTCP protocol without
requiring modifications to user-space application codes. However,
when attempting to achieve this using the BCC tool in user-space,
the BCC tool doesn't support 'fmod_ret'. Therefore, this patch aims to 
further expand capabilities, enabling the 'kprobe' method can overriding 
the update_socket_protocol interface.

As a Python developer, the BCC tool is a commonly utilized instrument for 
interacting with the kernel. If the kernel could permit the use of an 
error-inject method to modify the `update_socket_protocol`, it would significantly 
benefit the subsequent promotion and development of MPTCP applications. 
Thank you for considering this enhancement.

Best wishes!
Gang Yan


