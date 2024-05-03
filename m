Return-Path: <bpf+bounces-28503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AAE8BAA1F
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD6B234DC
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F214F9F8;
	Fri,  3 May 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii0ghA/Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3E14F9CE;
	Fri,  3 May 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729458; cv=none; b=qyq2BGrXvisgE/LBJfk4+EqUfKQxJS6G0KAQa52P4GLrYQVNDZxwAcDg80qrCQ6ve/6J6ENnFdw1C5Eblho2Nv5o3QI/rjlEEc7am9flK92Ph0+6e51LGgCygSEBeW/DMZ5bPjgHDzNEtaiWtPFrPaNtXmqXNwpSqydb0VoQxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729458; c=relaxed/simple;
	bh=DWh57NqU0/01iRmPDMXy/K+8zd+9eqAkFxqVGj8kOtg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCGpcz/Dvzf/b8kC2SNdFES4hTyXxdl7y8q5fkVRwrcv+QOy+HgPmRLB0PJ79Pp5yY0vOCMiDWdNdk3HEkIIJ10wOeFYUHXkQESNSb3RpCU2+AzbA2BLPpp7Imka8f3Gz/W/0k3vXtlOO416sKROnisSzpSgO+wGC+t1yvbPHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii0ghA/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DE5C116B1;
	Fri,  3 May 2024 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714729457;
	bh=DWh57NqU0/01iRmPDMXy/K+8zd+9eqAkFxqVGj8kOtg=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=Ii0ghA/YVJREs60D0+Ol82Qa7xqhrfxI3ebnu+ap6H+s/XvbpHlpdyZcjGT9yU1xj
	 0ouwwgj1ekvfQGDee3NfIQtTuS3YJgBm7e6diV5hBWGkZEp24JjmwuMEqErTDWEpHg
	 R1j6rtZtycwh6UT7gMDURnHQNCYQYs3adtjU6f0HpfIN143LXGTXM+UNurA40g9tH5
	 2r6/SGQs3dXHRXzyFx7oQ8yTxniTjxPN0asI9OF0vtqPAJPsEXHHUwPKB/uvzCKsvL
	 7XYqwW8hiJ5H2sMZaRIDEKVDY2jeaFXHiJhp/OB5S0O9QN7wP1/Qxzf5PcNAyIiZy4
	 yYz3+ALAyP2tQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Sumit Garg
 <sumit.garg@linaro.org>, Stephen Boyd <swboyd@chromium.org>, Douglas
 Anderson <dianders@chromium.org>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
In-Reply-To: <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com>
References: <20240502123449.2690-1-puranjay@kernel.org>
 <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com>
Date: Fri, 03 May 2024 09:44:14 +0000
Message-ID: <mb61p4jbf8c29.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 5/2/24 18:04, Puranjay Mohan wrote:
>> arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
>> because smp.h includes percpu.h. The next commit will remove percpu.h
>> from smp.h and it will break this usage.
>> 
>> Explicitly include percpu.h and remove smp.h
>
> But this particular change does not seem to be necessary for changing
> raw_smp_processor_id() as current_thread_info()->cpu being done in the
> later patch ? You might still leave header <asm/percpu.h> inclusion in
> arch/arm64/include/asm/smp.h while dropping the per cpu cpu_number ?

commit 57c82954e77f ("arm64: make cpu number a percpu variable")
created this percpu variable and included <asm/percpu.h> in <asm/smp.h>

Now we are removing the percpu variable cpu_number from smp.h, so there
is no need to keep percpu.h in smp.h

I feel users of DECLARE_PER_CPU_[...], etc. should include percpu.h and
not smp.h as it makes reading the code more easier and can thwart build
issues in the future, when headers are changed. 

Thanks,
Puranjay

