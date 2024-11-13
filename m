Return-Path: <bpf+bounces-44722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765469C6B86
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F9A2840B1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D7A1F77AC;
	Wed, 13 Nov 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="al5Jqn40"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30A18A6D1;
	Wed, 13 Nov 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490596; cv=pass; b=DvTVOPvl7BCEASpulsqy8sU6dc+OnkwM14U9YHrBisImS5jtY6owrJJfzsh2v7KE+/ysz823OwEdeonvxPOBo4cKUEZimesml6uTJkA+iHw2QZ96ITLvGs2tYSDWXeyRha/uprfYWahlFW5mEvSy4eImHTmxH7/IqeTOO9lQ3zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490596; c=relaxed/simple;
	bh=G/PPIWUKDquwuz1Fp1afut8we4tEfYfyAYTMs+8Hc9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzjmTB7e6tiAHLLGfzcdVVR0W+v2z8kE4a9QaCAjyKf7VcsPLpMNir7F7yJhmYM1V2JjZmmbgrj8xw5Q/KGgCodzCJDFYZQ7Y/zNWrwF0QW0ICqbU3CwTYhvBiBJ/WDOVz/LDivXW+pJqbxbc9rLpNxuXoOXXi5WBKztFl/zUMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=al5Jqn40; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731490582; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fIE6aOUOUMd0Ve6/RTlxdS6G7iMFSSethcOwWHFbOYgDDVnZXQgciiynV2l7Nct877vmC70zsgejx/r33gY4lztYHIBHErQFeI/HTkybQmyfBJrL1vhFrI9zQWURPc7rmPI86L0aFlLc8ZIMyLWNJpnwADrPbVhJun2sneOTg+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731490582; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TJfEmYEhbGQhswwb5+U7HA/wWFpu51ttU5Sd0h5wvgo=; 
	b=E31xkO2iwCSmt2Kl00mK+Wqdx/dR8sWuCZVks6n/k2glsT38Tt7sYP0Cvii5SN8pclfewj6/HSV92aea8uYksT8xPIfTkQeLdwWPkUroAuYeB5K8GPQxIRa/DmKoNOwC2IHpzUjUNMcAe3c2jikFdUhToO4EywgTO9T8lm43V7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731490582;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=TJfEmYEhbGQhswwb5+U7HA/wWFpu51ttU5Sd0h5wvgo=;
	b=al5Jqn40DBMKnXdJtWz+DGp78qDMJAKI4tkP7qL/LnBG9Hi/h7btkoDQ5iYfpPk9
	7w698vPtPvF18DEkfiNvN8jSgqi4+lHF1Uai4tqA3+J46N5y04PujFnsn3rFUxXDZPu
	Okv3/OWraAQgZS4koiU06L9m7L6olB88Pt8NAoEA=
Received: by mx.zohomail.com with SMTPS id 1731490581620674.1613596696902;
	Wed, 13 Nov 2024 01:36:21 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Date: Wed, 13 Nov 2024 10:37:03 +0100
Message-Id: <20241113093703.9936-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <90b3b613-8665-425b-8132-5b9ac86ab616@oracle.com>
References: <90b3b613-8665-425b-8132-5b9ac86ab616@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Alan,

On 11/7/24 16:05, Alan Maguire wrote:
> Thanks for the report! Judging from the config, you're seeing this with
> pahole v1.24. I have seen issues like this in the past where during a
> kernel build, module BTF has been built against vmlinux BTF, and then
> something later re-triggers vmlinux BTF generation. If that re-triggered
> vmlinux BTF does not use the same type ids for types, this can result in
> mismatch errors as above since modules are referring to out-of-date type
> ids in vmlinux. That's just a preliminary guess though, we'll
> need more info to help get to the bottom of this.
> 
> A few suggestions to help debug this:
> 
> - if you have build logs, check BTF generation of vmlinux. Did it in
> fact happen twice perhaps? Even better if, if kernel CI saves logs, feel
> free to send a pointer and I'll take a look.

Thanks for the pointers!

From what I can tell in the logs, the BTF generation of vmlinux only 
occurred once. The automated build process in KernelCI generally involves 
building the kernel first, followed by the modules and other artifacts 
(such as the kselftest archive). 
The full build log can be downloaded by selecting 'build_log' from 
the dropdown menu at the top of this page:

https://kernelci-api.westus3.cloudapp.azure.com/viewer?node_id=6732f41d58937056c61734ab

I do see some warnings reported in the logs though:

WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj

> - can you post the vmlinux (stripped of DWARF data if possible to limit
> size) and one of the failing modules somewhere so we can analyze?
> - Failing that,
> bpftool btf dump file /path/2/vmlinux_from_build > vmlinux.raw
> and upload of the vmlinux.raw and one of the failing module .kos would help.
> 

Currently, KernelCI only retains the bzImage, not the vmlinux binary. The 
bzImage can be downloaded from the same link mentioned above by selecting 
'kernel' from the dropdown menu (modules can also be downloaded the same
way). I’ll try to replicate the build on my end and share the vmlinux 
with DWARF data stripped for convenience.

Thanks,

Laura


