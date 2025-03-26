Return-Path: <bpf+bounces-54742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED77A7144D
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4657A5E3B
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0941AF0D0;
	Wed, 26 Mar 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnC5bFlF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91E1A4E9E;
	Wed, 26 Mar 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983157; cv=none; b=mjHpHcBQpdUigKgBqZtpfsD2x/847dKqgsaJDv2cyLpF41SZEGVXG9uHHt5lKe89oBOFRauKpzjIKBFF/t8/mZZH6F7QMMPzRV/UjxaWzI9eYiIoJBZv2A5VEHI1e2GVC2DCN56qkFKgt3VaV2fuxG2Z9ERaI7KXa/nkLZZRFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983157; c=relaxed/simple;
	bh=u4zjEg0RqnOyFywdBYOZZLSxCRbb8Xy5WbAFX9icYOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xlf4fZptCdZU73HOBOUI75HAIBgR2NcHrdZe8yS5vSCZgcQGaqg2gxUqq1AEnziCjZ91pgTnnf40CIO1XdrS3Ydwmt9CBUlpzT3F9dLo+i3htabZUBWPiAa7tbDxdvd6/xGSM9DL9L5SVhgvQ4rrKfgyvLKRmmEOii6OQJ/q6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnC5bFlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4087C4CEE2;
	Wed, 26 Mar 2025 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742983154;
	bh=u4zjEg0RqnOyFywdBYOZZLSxCRbb8Xy5WbAFX9icYOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WnC5bFlFog83UeNSyxnT1JDJpaGLYW/FNwc+g5sVcGJJQOy/DsK7EZeMbLpbRKIrN
	 zivC/qBok1JhftrjYaIOxLAxXQIw9CM2TC/bWzS+WVl3bNnkuPCtX8UEfNN6GKkeD2
	 pt7ghVA55PbSJt6cBzIwyazPrKD48N1tc2QCD2FEAOMSQCJmVpED3/+c6vczpgFff6
	 bq8/xP60Oq5vWXjV6LdLs3TLS33h26ofGUAkwKcp78EfjCkqGSxwlA7x3u+z/OHDnW
	 sMKNe6Cu0sBWDFSD2JTFrwd2M2Y4rWAsgJHUuC/I1r9Ohy97mQMXnDtG1d/Ojnj49U
	 sySbKWJNmLH9g==
Message-ID: <67e8c04d-e021-4f98-8020-5ee030fa24e3@kernel.org>
Date: Wed, 26 Mar 2025 09:59:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/build: Use SYSTEM_BPFTOOL for system bpftool
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250326004018.248357-1-tglozar@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250326004018.248357-1-tglozar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-26 01:40 UTC+0100 ~ Tomas Glozar <tglozar@redhat.com>
> The feature test for system bpftool uses BPFTOOL as the variable to set
> its path, defaulting to just "bpftool" if not set by the user.
> 
> This conflicts with selftests and a few other utilities, which expect
> BPFTOOL to be set to the in-tree bpftool path by default. For example,
> bpftool selftests fail to build:
> 
> $ make -C tools/testing/selftests/bpf/
> make: Entering directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'
> 
> make: *** No rule to make target 'bpftool', needed by '/home/tglozar/dev/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'.  Stop.
> make: Leaving directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'
> 
> Fix the problem by renaming the variable used for system bpftool from
> BPFTOOL to SYSTEM_BPFTOOL, so that the new usage does not conflict with
> the existing one of BPFTOOL.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-kernel/5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com/
> Suggested-by: Quentin Monnet <qmo@qmon.net>


Let's use <qmo@kernel.org> if possible, please.


> Fixes: 8a635c3856dd ("tools/build: Add bpftool-skeletons feature test")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Looks good, thanks a lot!

Acked-by: Quentin Monnet <qmo@kernel.org>

