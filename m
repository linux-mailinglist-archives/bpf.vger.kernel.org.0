Return-Path: <bpf+bounces-56639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED9A9B90F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F3D4C4E20
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA62165E4;
	Thu, 24 Apr 2025 20:22:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E421215F76;
	Thu, 24 Apr 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526155; cv=none; b=cI9fOaEVZOU4yEd+E2NgCarcgbfc40jXAuvela5aFQIYg/8vgciulB/J6wJiT0kCnrEjwvbd1QKUQYIBGpVnfbbeOCf45x12ntygjfQEUJO68etaZ8kTqUlJenU7bmIFcuE/lgML3eVxNBvVSDX7gZ/lcmXnLzNPe39zJi6O+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526155; c=relaxed/simple;
	bh=zglUIWtIpjxITwUkqoR+XY+5dgozTLcQisj7iUGCIu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSRGSHFzyYgvNHeHT4uzQCq63REJelyrrM3C64GGSV7B3F6C3ChmYOBMA1y17pXgZDGvnRdaI59bfSniRxO5/AWpDruozOZROFE76jx7mY1OBCTuDbxbecW6iZa3Vwu/qBolxuorfGNLcVQQKFiCV6kfUQgND5ixAltpIrW1AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af76d.dynamic.kabel-deutschland.de [95.90.247.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E62B6016243D;
	Thu, 24 Apr 2025 22:22:20 +0200 (CEST)
Message-ID: <e9bacdea-4d33-4116-a0a5-d78f14270e52@molgen.mpg.de>
Date: Thu, 24 Apr 2025 22:22:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
 DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
 115a4a9!
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org
References: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
 <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
 <273137fb-74c3-4c74-b228-099cde3869e7@molgen.mpg.de>
 <CA+JHD91HTtODD7+qmw5VQzYvZtaNik0M7R--W=o-fYCmw1zirg@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CA+JHD91HTtODD7+qmw5VQzYvZtaNik0M7R--W=o-fYCmw1zirg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Arnaldo,


Thank you for your answer.

Am 24.04.25 um 22:08 schrieb Arnaldo Carvalho de Melo:
> On Thu, Apr 24, 2025, 4:59 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 24.04.25 um 20:07 schrieb Alan Maguire:
>>> On 22/04/2025 14:33, Paul Menzel wrote:
>>
>>>> Trying to build Linux 6.12.23 with BTF and pahole 1.30, I get the build
>>>> failure below:
>>>>
>>>>       $ more .config
>>>>       […]
>>>>       #
>>>>       # Compile-time checks and compiler options
>>>>       #
>>>>       CONFIG_DEBUG_INFO=y
>>>>       CONFIG_AS_HAS_NON_CONST_ULEB128=y
>>>>       # CONFIG_DEBUG_INFO_NONE is not set
>>>>       # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>>>>       # CONFIG_DEBUG_INFO_DWARF4 is not set
> 
> There are partial units, please try with the above set

Sorry, but what should I set exactly? I am unable to set all, as they 
exclude each other. With `CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y` I 
get the same error.

```
[…]
#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_ULEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
[…]
```


Kind regards,

Paul

