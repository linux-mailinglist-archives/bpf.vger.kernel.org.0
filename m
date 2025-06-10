Return-Path: <bpf+bounces-60255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E861AD46A7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC2D3A5FF2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EB26E718;
	Tue, 10 Jun 2025 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngo2sLUt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E92D540A
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597863; cv=none; b=s+nZsCQPvCp8HttjyLtQ7nGggV1bepabYoxnC5ld0y0Z7ekyfIhy3L8vO9/cQIpEAs9UT+ofFCYCJezP0Jj+0tUIwaLVpxZsTr7PYAb342LXExWLEt9vkWhiuXOB/WLRkHJAD5cUMMw8J5wtpojMlCWI22pHMSEf9E8mnKfMVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597863; c=relaxed/simple;
	bh=4UsSX14k43cbBEcCcUrL+qqAqViHnY0h+wnCdlT3yMw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I63npI/Cae8QmTTgfdEwH5MogvA1ZiS/v01yvGITrWkbQ9kWLiaYqQIR86D0MgesqbQnPACRLCI0OONDw6pjbjAOUBM20Lw7E1uLneDsj9d5zsEx/M9859L61K+5EmsBVnKuS6DVd3mUzpLQFJ8zSaL/TbJTYpaWEQ4/p6Vu//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngo2sLUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D723FC4CEED;
	Tue, 10 Jun 2025 23:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749597862;
	bh=4UsSX14k43cbBEcCcUrL+qqAqViHnY0h+wnCdlT3yMw=;
	h=Date:From:To:Subject:From;
	b=ngo2sLUt0q7y6q4/AcbHbBy9Ban0DKJPk5DRm4ZcwhrXmRBPZnmE0jvVDWzq1GkgP
	 VtGSc1L1U90tM4/vNTdm0DF+X/GANJDkqC8vnKloze4EDXXYyEPkbbrpNdEKFvfjUV
	 dAOi9fu3oy61K+hShq+sIkPsPGPIyDWac90MxFY930ZhLy52A2X57sBRxu/AoVKmar
	 TX5ZthSAX/QZqryt49YKczmGIDnGnC8kkKgoR+tadU0np9Z7bmlVhCfqgJin09R/1N
	 A/tFqEu7TOE2MjZmYaNt3zar9Rn4ZC9T587LTaUa1F5hCbYkUru10eWTl1QwnYv1RX
	 1ge6efpx/4H+g==
Date: Tue, 10 Jun 2025 16:24:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: bpf-restrict-fs fails to load without
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS on arm64
Message-ID: <20250610232418.GA3544567@ax162>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I recently adjusted my kernel configuration for my arm64 systems that
boot Fedora to enable debug information so that BTF could be generated
so that systemd's bpf-restrict-fs program [1] can run, as it would show

  systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process

in the kernel log. After doing so though, I still get an error when the
program is loaded:

  systemd[1]: bpf-restrict-fs: Failed to link program; assuming BPF LSM is not available.

With Fedora's configuration from upstream, I see:

  systemd[1]: bpf-restrict-fs: LSM BPF program attached

I was able to figure out that enabling CONFIG_CFI_CLANG was the culprit
for the change in behavior but it does not appear to be the root cause,
as I can get the same error with GCC and the following diff (which
happens with CFI_CLANG because of the CALL_OPS dependency):

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331af337..a55754e54cd8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -210,8 +210,8 @@ config ARM64
        select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
                if (GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS || \
                    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
-       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
-               if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
+       #select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
+       #       if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
        select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
                if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
                    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))

which results in the following diff between the good and bad
configurations (and I already ruled out HID-BPF being involved here):

diff --git a/good-config b/bad-config
index 252f730..539e8fd 100644
--- a/good-config
+++ b/bad-config
@@ -4882,7 +4882,6 @@ CONFIG_HID_NTRIG=y
 #
 # HID-BPF support
 #
-CONFIG_HID_BPF=y
 # end of HID-BPF support

 CONFIG_I2C_HID=y
@@ -7534,7 +7533,6 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_FUNCTION_GRAPH_FREGS=y
 CONFIG_HAVE_FTRACE_GRAPH_FUNC=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
-CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
 CONFIG_HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=y
 CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
@@ -7558,7 +7556,6 @@ CONFIG_FUNCTION_GRAPH_RETVAL=y
 # CONFIG_FUNCTION_GRAPH_RETADDR is not set
 CONFIG_FUNCTION_TRACE_ARGS=y
 CONFIG_DYNAMIC_FTRACE=y
-CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
 CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=y
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
 CONFIG_FPROBE=y

Is this expected behavior or is there some other issue here? I have not
tried different kernel versions yet but I certainly can if it would be
worthwhile. If it is not expected, I am happy to provide any information
that would be helpful for narrowing this down or test patches. This is
reproducible for me in a Fedora VM in QEMU as well, if it makes
reproducing easy.

[1]: https://github.com/systemd/systemd/blob/abe149d669c68bbf2a8dd4fab325c7e715f1fd85/src/core/bpf-restrict-fs.c

Cheers,
Nathan

