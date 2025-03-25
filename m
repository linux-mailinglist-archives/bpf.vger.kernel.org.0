Return-Path: <bpf+bounces-54632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51876A6F6EB
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06671891C62
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EE255E3D;
	Tue, 25 Mar 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVjLbNU/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EF1E833A;
	Tue, 25 Mar 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903125; cv=none; b=l/w4kG4ZhiHQEnX0o/yt5lDiMQCff9pwA5qEEXq1KgchpYc7pcBPvfouzNv3clq6t1OcXhz4aw6YRV79/Qatfk42qLJH5UH6BkX3P7p9BUXANExkIBXrAOcVx266UPR91c7K+ODkfRx+Uv6rHF/VlkhahDIMKfQELMM7KpCR2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903125; c=relaxed/simple;
	bh=ln3YIN/p3pvOOr6HTpKHmEmdZ4o2gfuuldLKRJWcKsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGDCUWlhuYyttwS43uB4+u5Xcws3/88TZ+O4R8vbjMv3QxrZ69itk7u88O9Y2SYUAMpUKcAOdJN8R7t82J0w68obNGpa1U869MNRDdpGzUddRozctnwsDGZ9WEGPDtZXpMEYJ53MLlzQzl2Eobd2aaNW3QzN2KFHuIuH+L2cj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVjLbNU/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P56dKK027910;
	Tue, 25 Mar 2025 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZeSvWIeDWkZDUBR4rtlXsoPy9rqPVD
	RaaZ2ycwV8IUc=; b=EVjLbNU/k5+hqrBMGzGH/Fx07OdHl42M4QPRgyplfcTT6J
	MwoJFMiFn5ij4vtQYKZws4avcfDpsg8HTGu+yk4smIpknNF1/LkS9KUAqwNixD79
	ad7FOtrMtYWSfMK+0y/k+iBDcS6qO2SkUM7X6JDEdc0QPeNWVoTr+oIu2kRcRv28
	DH0NIcG89cBtHwrkcT21EncIaY9Q921n7hd3XwjNstgoRdi+kOoqJidlt36eXkrq
	6W2i1ELzPn0x3ZKkp92ZwW92S6D4xMHM8O766zh98f74mqdkawWrPoNExbZDg3KS
	b4KT6ZUcufkzDEdKg+dAFe6vpOlRQKkw/S04GkGA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwvae5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:45:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PA0TZm009692;
	Tue, 25 Mar 2025 11:45:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkjy33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:45:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PBj2hk35258764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 11:45:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C5120043;
	Tue, 25 Mar 2025 11:45:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D19320040;
	Tue, 25 Mar 2025 11:44:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.39.189])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 11:44:58 +0000 (GMT)
Date: Tue, 25 Mar 2025 17:14:55 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Quentin Monnet <qmo@qmon.net>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com,
        williams@redhat.com, tglozar@redhat.com, rostedt@goodmis.org
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on
 linux-next-20250324
Message-ID: <Z+KXN0KjyHlQPLUj@linux.ibm.com>
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6J8TeICOWrWWtMDx4atpNlqvb8kZ_Apf
X-Proofpoint-ORIG-GUID: 6J8TeICOWrWWtMDx4atpNlqvb8kZ_Apf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250080

On Tue, Mar 25, 2025 at 11:09:24AM +0000, Quentin Monnet wrote:
> 2025-03-25 16:02 UTC+0530 ~ Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Greetings!!!
> > 
> > 
> > bpftool fails to complie on linux-next-20250324 repo.
> > 
> > 
> > Error:
> > 
> > make: *** No rule to make target 'bpftool', needed by '/home/linux/
> > tools/testing/selftests/bpf/tools/include/vmlinux.h'. Stop.
> > make: *** Waiting for unfinished jobs.....
> 
> 
> Thanks! Would be great to have a bit more context on the error (and on
> how to reproduce) for next time. Bpftool itself seems to compile fine,
> the error shows that it's building it from the context of the selftests
> that seems broken.
> 
> 
Yes, selftest build for BPF fails.
## pwd
/linux/tools/testing/selftests/bpf

# make -j 33

make: *** No rule to make target 'bpftool', needed by '/home/upstreamci/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'.  Stop.
make: *** Waiting for unfinished jobs....

> > Git bisect points to commit: 8a635c3856ddb74ed3fe7c856b271cdfeb65f293 as
> > first bad commit.
> 
> Thank you Venkat for the bisect!
> 
> On a quick look, that commit introduced a definition for BPFTOOL in
> tools/scripts/Makefile.include:
> 
> 	diff --git a/tools/scripts/Makefile.include .../Makefile.include
> 	index 0aa4005017c7..71bbe52721b3 100644
> 	--- a/tools/scripts/Makefile.include
> 	+++ b/tools/scripts/Makefile.include
> 	@@ -91,6 +91,9 @@ LLVM_CONFIG	?= llvm-config
> 	 LLVM_OBJCOPY	?= llvm-objcopy
> 	 LLVM_STRIP	?= llvm-strip
> 	
> 	+# Some tools require bpftool
> 	+BPFTOOL		?= bpftool
> 	+
> 	 ifeq ($(CC_NO_CLANG), 1)
> 	 EXTRA_WARNINGS += -Wstrict-aliasing=3
> 
> But several utilities or selftests under tools/ include
> tools/scripts/Makefile.include _and_ use their own version of the
> $(BPFTOOL) variable, often assigning only if unset, for example in
> tools/testing/selftests/bpf/Makefile:
> 
> 	BPFTOOL ?= $(DEFAULT_BPFTOOL)
> 
> My guess is that the new definition from Makefile.include overrides this
> with simply "bpftool" as a value, and the Makefile fails to build it as
> a result.
> 
> If I guessed correctly, one workaround would be to rename the variable
> in Makefile.include (and in whatever Makefile now relies on it) into
> something that is not used in the other Makefiles, for example
> BPFTOOL_BINARY.
> 
> Please copy the BPF mailing list on changes impacting BPF tooling (or
> for BPF-related patchsets in general).
> 
> Thanks,
> Quentin
Yes you are right that the new definition from Makefile.include overrides this
with simply "bpftool" as a value, and the Makefile in bpf selftest fails to 
build it as a result.

But the main cause is that it is not able to locate the bpftool binary.
So, is it good idea to both rename this variable in Makefile.include and 
use:

BPFTOOL ?= /usr/sbin/bpftool

This is the link to patch that is impacting: 
https://lore.kernel.org/all/20250218145859.27762-3-tglozar@redhat.com/

Thanks,
Saket

