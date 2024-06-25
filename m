Return-Path: <bpf+bounces-32987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AC5915BF1
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B047B21C6A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA41225CB;
	Tue, 25 Jun 2024 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+dmLe87"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C791CAB5;
	Tue, 25 Jun 2024 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280719; cv=none; b=rmbGrVhThdusYherz26rYipgrBDV4IcKpMS5uLU6cllS52HGV9fYozcGs/9/tuPLNXnPABqT8cL/Q/MydXpeJ9th+oMGnY9lUpmdSFs72OGIbWoCebXqVlSKyOoj31fUIgT+tYYQJSQQRwKExXnvJu6VjbarPP8FnGvwip7zUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280719; c=relaxed/simple;
	bh=Cw6jC/8l4oTtnF3R6KeDYzXV281+HtqdirWYcEf//Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5t7ekRMCNA/pgwie93Xz/z8sMIW1GPX+bmVKw2caPVJWtJde0CWIOcBOv8jkeUqau+pPTP30CzDQf1fHwcQ5ZWEWBJq4mmRpZalptssz5E6MbuSaJxVYT1iQCX6LtGd9kXZMFevFngBBJo3AcgHjLPvU8o43YW8lvKPYVd4p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+dmLe87; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25980546baeso2426605fac.2;
        Mon, 24 Jun 2024 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719280717; x=1719885517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le+LxDSHAK5LAQ0qgkOF43ZZOCdiKF+sLVTcN/8iO4M=;
        b=c+dmLe87FrYppUsklDgk1ZRHx9OghsSAfv3kO8tlKkUqSkouce5A06hfdQfM896p1d
         DsdbOb7PgMCbaZUJpRB2l+5nMSGN1PPOv900W3eGxzTNvatWYWwLIyGs/WHmEX2tW3Y2
         H8CyVz/xEPYC7cF+JxuKbM1Y8GqRe2xth+5Nex8H7+lKNI2KvCXI9U6ylzfsSLXW0nsF
         5/fKnuJ+5u4oR+ZKvy0FACv6KcCVdU5zvguaCfqLoU7NaKeJgea28y+cdFDYg/T9QIKS
         LKxYHPAJ+v0eq0ZjyS3JiNKCtlWfp1ALvdTewKVfIbie0cNYjDalGkOjyQW1C3urOGtw
         hzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719280717; x=1719885517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=le+LxDSHAK5LAQ0qgkOF43ZZOCdiKF+sLVTcN/8iO4M=;
        b=EBCaSLCO2SdS9lC0HDuiepi62sVHtlxxOis+DQJW/uoL/vHKSPQZWLNtfJiJXunx78
         fZI0j1WLSv0DT5MsGir1lh3mhMfM9MGUT38tO8uYrhtO7W+wAq46s6ChyzvThh5bOHCk
         zDd8XsQO0GZmOChfh0N60ej/SnvkEf+b5OK3ge80K9tQOqfsyuJKwPPnZFoL1jzYHegX
         lRjvDrwn7BRLSkDzBPIQdwRPznaqWZjWAUX09tOcRqNR1ESq6VZoqSPw3lEXkFeR/1+w
         vVYnqul0QcReg3nDzLu+8XjelKF6a5BnHnfZ00e+W847wy8l85MFzYJ1YsHKsGvQPgz7
         ICGA==
X-Forwarded-Encrypted: i=1; AJvYcCUE9U5QG0pawEJhdEnF30LsnyI7ssu2Ut+H837SjgMwXix4J7gxHzGQ5xUSWZL8LptNsMgyoN63DB2LKYdhWxkXZqESzJCzrBRFC69asmyB1fQOJYZdrWsn5asduPrn8HuaWk7AbpmgqEo671D5n3mTKsi/S23VNZuMPhJQOXE=
X-Gm-Message-State: AOJu0YxQnIcBNYdkycaIMMwF0DKYleV0gmrkn0rHN4e8nPMuV3kgHv08
	pgkOV4BQz3V+saVeXeiNjpfDpxL61na2UhB6UyI85PKVrlzf5oNJ
X-Google-Smtp-Source: AGHT+IEVXCi7ANK+NoEJf+GJJcCLQ/eTBndCvkwq5tkvIUYaZlgpy9PkTqSWE0csUKpr0AN5AtA4kA==
X-Received: by 2002:a05:6870:218c:b0:25c:bc3f:f924 with SMTP id 586e51a60fabf-25cfce319e0mr7843705fac.35.1719280717127;
        Mon, 24 Jun 2024 18:58:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067a63efafsm3313686b3a.109.2024.06.24.18.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 18:58:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 15:58:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: [PATCH sched_ext/for-6.11] sched_ext: Drop tools_clean target from
 the top-level Makefile
Message-ID: <ZnokS4YL71S61g71@slm.duckdns.org>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-11-tj@kernel.org>
 <ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com>

2a52ca7c9896 ("sched_ext: Add scx_simple and scx_example_qmap example
schedulers") added the tools_clean target which is triggered by mrproper.
The tools_clean target triggers the sched_ext_clean target in tools/. This
unfortunately makes mrproper fail when no BTF enabled kernel image is found:

  Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux/boot/vmlinux-4.15.0-136-generic".  Stop.
  Makefile:192: recipe for target 'sched_ext_clean' failed
  make[2]: *** [sched_ext_clean] Error 2
  Makefile:1361: recipe for target 'sched_ext' failed
  make[1]: *** [sched_ext] Error 2
  Makefile:240: recipe for target '__sub-make' failed
  make: *** [__sub-make] Error 2

Clean targets shouldn't fail like this but also it's really odd for mrproper
to single out and trigger the sched_ext_clean target when no other clean
targets under tools/ are triggered.

Fix builds by dropping the tools_clean target from the top-level Makefile.
The offending Makefile line is shared across BPF targets under tools/. Let's
revisit them later.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Link: http://lkml.kernel.org/r/ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com
Fixes: 2a52ca7c9896 ("sched_ext: Add scx_simple and scx_example_qmap example schedulers")
Cc: David Vernet <void@manifault.com>
---
Jon, this should fix it. I'll route this through sched_ext/for-6.11.

Thanks.

 Makefile |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1355,12 +1355,6 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
-tools-clean-targets := sched_ext
-PHONY += $(tools-clean-targets)
-$(tools-clean-targets):
-	$(Q)$(MAKE) -sC tools $@_clean
-tools_clean: $(tools-clean-targets)
-
 # Clear a bunch of variables before executing the submake
 ifeq ($(quiet),silent_)
 tools_silent=s
@@ -1533,7 +1527,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs) tools_clean
+mrproper: clean $(mrproper-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.rmeta' \) \

