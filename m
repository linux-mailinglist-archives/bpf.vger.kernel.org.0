Return-Path: <bpf+bounces-44817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C361B9C7ED3
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 00:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694CE1F22F09
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBF18CC0C;
	Wed, 13 Nov 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="ps0+9BJe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43917DFE9
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540789; cv=none; b=S/Sn+waV0FveyfkjOXM8xjEzCYUaVMCqmwlfxl+Eim/8KeiVyz7fGj8tZ/IhVav9De3PLaAkcT+Xw/jgVHGS0uUWtenp3tmvudzyzBz2gg75I40ik/LmP2jxHhtDsHefzgP99uljn4ZaEfXqRk6TEV/lKSX6FBdfz3+9/yUeRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540789; c=relaxed/simple;
	bh=jTEng0aWpmjTS3cTFZeHnF8tjVT8x5QlSqRHJ70d01c=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=YbhvYrfHkQFh+25ZjiczxTt+NJyiaLlPMcfmiwUqSjYrc0EtLXtC5lEUOlIKhZh56ZDZvtoFes9AZ/eqfvS7F6RUrpIRXXXuYdSsCmy8ghEE5WI+35lo9eK2y8P0q/4+O/FMmJdQWhGm7xBJiCWJPar6tJscjtLRoiFIF4MpVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=ps0+9BJe; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id A81586000254
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 23:33:03 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id xI8RMk6pxSWZ for <bpf@vger.kernel.org>;
 Wed, 13 Nov 2024 23:33:01 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 592456000868
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 23:33:01 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1731540781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3t30Nob68ezWtTm5s5wZnyLUQ4qxGICUEV1thtAFkO0=;
	b=ps0+9BJevUyUvjC2fmpcnE2CxgFuo4S5DHjGfvo/VNu2TwaKN1kjCF5O/+vz40RCVsYJoK
	6r6Va4+U21jXbo9PYoW8qEQ8p894cHMfU7BpgT9MLxiJN7B1eKKsrOcdnDJcdRA7eDu3K6
	QRpbBQS94+VZ5MTe1ZocMUkb+mVKQ00=
Received: from webmail.tecnico.ulisboa.pt (webmail4.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::8a3:363d])
	(Authenticated sender: ist426067)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 3A84D36009A
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 23:33:01 +0000 (WET)
Received: from a95-93-247-17.cpe.netcabo.pt ([95.93.247.17])
 via vs1.ist.utl.pt ([2001:690:2100:1::33])
 by webmail.tecnico.ulisboa.pt
 with HTTP (HTTP/1.1 POST); Wed, 13 Nov 2024 23:33:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 23:33:01 +0000
From: =?UTF-8?Q?Sebasti=C3=A3o_Santos_Boavida_Amaro?=
 <sebastiao.amaro@tecnico.ulisboa.pt>
To: bpf@vger.kernel.org
Subject: uprobe overhead when specifying a pid
User-Agent: Roundcube Webmail
Message-ID: <66ba4183c94d28f7020c118029d45650@tecnico.ulisboa.pt>
X-Sender: sebastiao.amaro@tecnico.ulisboa.pt
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I am using:
libbpf-cargo = "0.24.6"
libbpf-rs = "0.24.6"
libbpf-sys = "1.4.3"
On kernel 6.8.0-47-generic.
I contacted the libbpf-rs guys, and they told me this belonged here.
I am attaching 252 uprobes to a system, these symbols are not regularly 
called (90ish times over 9 minutes), however, when I specify a pid the 
throughput drops 3 times from 12k ops/sec to 4k ops/sec. When I do not 
specify a PID, and simply pass -1 the throughput remains the same (as it 
should, since 90 times is not significant to affect overhead I would 
say). It looks as if we are switching from userspace to kernel space 
without triggering the uprobe.
Do not know if this is a known issue, it does not look like an intended 
behavior.

