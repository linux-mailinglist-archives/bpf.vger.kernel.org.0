Return-Path: <bpf+bounces-77474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F5CE7C8F
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14D330198AE
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081B132B98A;
	Mon, 29 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jht35+NJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBD271456
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767030994; cv=none; b=cmSGObKTS8l7Ujb6Plij49BAkpnPMjuN55bXVPwhioyIXWiUrGMUAHiwKkFtayBDMopWiAAcA3vg4vS+crUJ3lrju40CVfDh3axbdaHEpSZmCHN7CtZMEIf8fFqPQM+pMO/9z8dnrLEpLRIlmLAfPk1sMHVFPM4ntDOgXQrKDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767030994; c=relaxed/simple;
	bh=CjWuNHHaVbrAnmI3EfkznNdEY9Q0OqfgNW2sSNmZyKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJhtdY3wD3hR1LPKgJGTgvX8m1AJqyUWkQbLmcvziojMnyA6yQhUWRI+jnxT0SeH5X7fo3Q1J2zbdg7xP51AQJWHkX3WN/EyUDqBKWFOYq1sPK9z2s7cJPNO1MVZniEMgSeXqVAqrICAwE9L8fwObiDgNsVpe8C8bmbNbrDL/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jht35+NJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72b12d0b-a513-41a6-91ac-076404a25713@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767030987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtPQFeJN2I2P2evtUp/h8YnGo3x2O/6C1PcR1entX1E=;
	b=Jht35+NJGiKlUg0dmkJElpAqxV6Fdy738vg1idA8pfrjd5hmV4fLpLFD5pk90ZzyzgbFkW
	dAaGmvV33Vs4xpouj/vdeRJ9LEnUbDOZbRS2y+w2c/9sl4SV4ISvnuqUdycfwD8qdkjB67
	m00VDb5lckmi3ekwtse3qUQFgT8LCPk=
Date: Mon, 29 Dec 2025 09:56:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next:master 8/9] ld.lld: error: .tmp_vmlinux1.btf.o is
 incompatible with elf32lriscv
To: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
References: <202512240559.2M06DSX7-lkp@intel.com>
 <20251228215613.GA2167770@ax162>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251228215613.GA2167770@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/28/25 1:56 PM, Nathan Chancellor wrote:
> On Wed, Dec 24, 2025 at 06:02:31AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>> head:   f14cdb1367b947d373215e36cfe9c69768dbafc9
>> commit: 522397d05e7d4a7c30b91841492360336b24f833 [8/9] resolve_btfids: Change in-place update with raw binary output
>> config: riscv-randconfig-002-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240559.2M06DSX7-lkp@intel.com/config)
>> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240559.2M06DSX7-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202512240559.2M06DSX7-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: .tmp_vmlinux1.btf.o is incompatible with elf32lriscv
> 
> While I have not verified this, I suspect this error occurs because the
> ${CC} command in gen_btf_o() in scripts/gen-btf.sh only includes
> CLANG_FLAGS for the target selection but not '-m32' or '-m64' from
> KBUILD_CFLAGS to control the word size (as documented in
> scripts/Makefile.clang).

Hi Nathan, thanks for the pointer.

I was able to reproduce this. Your suspicion is correct. 

The .o file generated by:

	echo "" | ${CC} ${CLANG_FLAGS} -c -x c -o ${btf_data} -

when cross-compiling to riscv is 64-bit, while vmlinux.o is 32-bit, hence the error.

This helps:

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 06c6d8becaa2..12244dbe097c 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -96,7 +96,7 @@ gen_btf_o()
        # deletes all symbols including __start_BTF and __stop_BTF, which will
        # be redefined in the linker script.
        info OBJCOPY "${btf_data}"
-       echo "" | ${CC} ${CLANG_FLAGS} -c -x c -o ${btf_data} -
+       echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
        ${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
                --set-section-flags .BTF=alloc,readonly ${btf_data}
        ${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}

I'll send a proper patch later today. Have another bug report to check.

> 
> Cheers,
> Nathan


