Return-Path: <bpf+bounces-76375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D25CB089C
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677E6300CA38
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1285301024;
	Tue,  9 Dec 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="rHx1PWGE";
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="rHx1PWGE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.mpi-sp.org (smtp.mpi-sp.org [141.5.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95B25B311
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.5.46.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297263; cv=none; b=qoS7bWDetfHK3ix6hGmh+tQw5Fjw+zGns08Lfb5TNIEfHWfrjyvXQPrmx1gvLhJf7iYxOzA84CIuBlCLEPgmSnClrtEN51Z0kLYnF4fIcElZal/ovObzmcFlob/3qsb1J5rU9AAFAUGcYejcXvG/zWsYf8WEA+tapBgZd3DOsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297263; c=relaxed/simple;
	bh=gvQI3CfhhF1QeqlonSSajuUz18BnvU/fD1J5wqS7K34=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IQshI9XIgwo/EG9pcorHpz9338gjLlmxNlYqHlaCVJI8gvTKYK9iaaXecStbP6eUQqFXaXqP6Z+2xC0AMX4XKvuRjXSHFys1nG+q6bgM4qFAZiS9oLbPCy2jc5s3CwUHIw0QZqTT2uy04k+KjmIEjnufrEBd+rVoEs5hVBLy4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org; spf=pass smtp.mailfrom=mpi-sp.org; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=rHx1PWGE; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=rHx1PWGE; arc=none smtp.client-ip=141.5.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpi-sp.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1765296902; bh=gvQI3CfhhF1QeqlonSSajuUz18BnvU/fD1J5wqS7K34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHx1PWGEnEJmMPFpVS7P6RxbfAfKmRIkJ00/6VRbNZTaacgavgXESieIOUYtSY4No
	 3SxMl9/BdUIvJ4Eu4WPewXbCdy2lx7oYp7FpPcBTwacfMNBQkChyjVwCgT4rNUo7CF
	 e85SAWpP1oNUmY/1UkM+nJvKB18GAWxrBJ+shZMoxXxirv4U/ESwIngGEEJEHmSCdL
	 2Y1iRJIedbOM1ZB0Orix/V37jzfa06BoYTVswnhFx1y6uNRcep14L2CxWK7wgMNLQm
	 1FPxtRvZoIS230EdFfvJ0uEDOzFv1ez4pgDgxpkCINn81SNvCy+g/F6KzJQYU9weiy
	 N0243BOhwoZzYnsGpXni6F7X5grSFDYFvP/AYeXvR0braSoIF/qa9Z2+g+gceNmN24
	 VE1yZguuNNPZ/O4cjozzC+5RGBxRKyyFFdIWvKult5XPthlbcisMJUL/rzsTDSfqH0
	 oKKo5i0HxnaGNXjOEsNFFn2r2WRMGNU++oz6Dn9aad7ppCt5BFjrI9rPbarZTrUo5/
	 7NRRfx79RdsmnE9mj4LjfmwdPOktK5AUR147vwju8HHliuZNBDWIW7s/YY3Gx+pHV3
	 wKrr+tdlUkDGG4f0Tj5D4UbhaKIoAw03qXih8ttROHvyiQlRMJ+Wj6Rzlv7L8Gm4KM
	 GrdTD90Ob0gC8+AbB6vpF+iw=
Received: from smtp.mpi-sp.org (localhost [127.0.0.1])
	by smtp.mpi-sp.org (Postfix) with ESMTP id 2979E8801E9;
	Tue,  9 Dec 2025 17:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1765296902; bh=gvQI3CfhhF1QeqlonSSajuUz18BnvU/fD1J5wqS7K34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHx1PWGEnEJmMPFpVS7P6RxbfAfKmRIkJ00/6VRbNZTaacgavgXESieIOUYtSY4No
	 3SxMl9/BdUIvJ4Eu4WPewXbCdy2lx7oYp7FpPcBTwacfMNBQkChyjVwCgT4rNUo7CF
	 e85SAWpP1oNUmY/1UkM+nJvKB18GAWxrBJ+shZMoxXxirv4U/ESwIngGEEJEHmSCdL
	 2Y1iRJIedbOM1ZB0Orix/V37jzfa06BoYTVswnhFx1y6uNRcep14L2CxWK7wgMNLQm
	 1FPxtRvZoIS230EdFfvJ0uEDOzFv1ez4pgDgxpkCINn81SNvCy+g/F6KzJQYU9weiy
	 N0243BOhwoZzYnsGpXni6F7X5grSFDYFvP/AYeXvR0braSoIF/qa9Z2+g+gceNmN24
	 VE1yZguuNNPZ/O4cjozzC+5RGBxRKyyFFdIWvKult5XPthlbcisMJUL/rzsTDSfqH0
	 oKKo5i0HxnaGNXjOEsNFFn2r2WRMGNU++oz6Dn9aad7ppCt5BFjrI9rPbarZTrUo5/
	 7NRRfx79RdsmnE9mj4LjfmwdPOktK5AUR147vwju8HHliuZNBDWIW7s/YY3Gx+pHV3
	 wKrr+tdlUkDGG4f0Tj5D4UbhaKIoAw03qXih8ttROHvyiQlRMJ+Wj6Rzlv7L8Gm4KM
	 GrdTD90Ob0gC8+AbB6vpF+iw=
Received: from imap.mpi-sp.org (imap.mpi-sp.org [10.100.1.36])
	by smtp.mpi-sp.org (Postfix) with ESMTPSA id E0D118801DA;
	Tue,  9 Dec 2025 17:15:01 +0100 (CET)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Dec 2025 17:15:01 +0100
From: "syeda-mahnur.asif" <syeda-mahnur.asif@mpi-sp.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net
Subject: Re: Sanitizer flags an eBPF bug
In-Reply-To: <da6b0f1c28c53e9e39ce3e949b0885c2@mpi-sp.org>
References: <cd5e012f7d365821707c9788bf382e3b@mpi-sp.org>
 <da6b0f1c28c53e9e39ce3e949b0885c2@mpi-sp.org>
Message-ID: <c032d4a0d93986ff9c4b20396b53af35@mpi-sp.org>
X-Sender: syeda-mahnur.asif@mpi-sp.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi,

I would like to disclose this at a conference in a few weeks, and it 
would be great if there is any confirmation / update on this?

Best regards,
Mahnur

On 2025-11-27 14:59, syeda-mahnur.asif wrote:
> Hi,
> 
> Just wondering if there is any update on this?
> 
> Best regards,
> Mahnur
> 
> On 2025-11-03 15:02, syeda-mahnur.asif wrote:
>> Hi,
>> 
>> I've been playing around with eBPF and have sanitizers enabled, a 
>> "BUG: Invalid wait context" is thrown in some specific instances:
>> 1. The eBPF program is of Tracing type
>> 2. Ringbuf helper functions are used.
>> 3. The program is attached to perf_event related symbols in the 
>> kernel.
>> 
>> I'm attaching a folder with two instances of such programs and the 
>> info dumped by the sanitizer. The attached files for each instance 
>> include:
>> 1. bpf_prog(x).c
>> 2. bpf_prog(x).o - object file that is compiled with "clang-16 -O2 -g 
>> -target bpf -c bpf_progx.c -o bpf_progx.o" and loaded by libbpf (v1.6)
>> 3. trig(x).c - File in C that is compiled as a binary and when 
>> executed causes the bpf program to run
>> 4. dump(x).txt - Sanitizer dump
>> 5. vmlinux.h - Specific vmlinux file used in compiling the ebpf 
>> program object files
>> 
>> Happy to provide any other additional info that might be relevant.
>> 
>> Best regards,
>> Mahnur

