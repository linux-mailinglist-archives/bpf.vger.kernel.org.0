Return-Path: <bpf+bounces-61883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D8AEE6E6
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FE1188592B
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDC2EA163;
	Mon, 30 Jun 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmAQbjmg"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5B1F0E39
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308628; cv=none; b=FsxWCYk1/o87+3g2ZiZiuIwJDLYrn81uMlN5cmsCprhU3R8F2SSkQEI/YOvYxb6MlRf29rBtU6r5XyibShwrSvwtH4srW8Lz1qPUt+duP7ZVhr50vmTbc7XswAkLtO8U+T5TJ7qQattKMxtBmfCLrvRAakalekZL36PDV/OK2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308628; c=relaxed/simple;
	bh=4sUHkB+pkTc2LfPer8jo6Y0ff3Qvszwnbo2cQ60hhx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SbbohAlY+krv3fJ1rmHbHuOQFxJtzHPCk5D1DyeR6TgPdCAXwubOci1AGHU8StSELEEQTTyuu+tf4wAMTpBAC/jtBPrNG0ZgbebuJ1LQOkW1BpGw+g15+O8EYF2oAvROPuZfAm1WMXoDpQtjMQZ6fEc2pAOXCNNs6Xmx5Dxo59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmAQbjmg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b9b2e516-5591-4c0b-a1aa-6fa89f002181@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751308620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zg05sbQVwx9FmpKGInpwiGWCwZAIXhzdMC6XDVVrew=;
	b=xmAQbjmgKdekTSAdUvjJZbFbo7x7IY3oFzIJlfobJPWZxm86cEGCBp31kcCilpDBcg0E0j
	qedLsYxcn1cPqIcAI1SqslQ/Es+YX1kiBc5LoHEb8N5Ln8FYpCwNxw/pn9xIRwQIYp2RJl
	0/va1dYjBkAgmkVRXQK80e5/upau6h8=
Date: Mon, 30 Jun 2025 11:36:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 2/2] github CI: Add comparison of generated BTF
 functions between baseline, change
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20250630101537.2680289-1-alan.maguire@oracle.com>
 <20250630101537.2680289-3-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
In-Reply-To: <20250630101537.2680289-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/30/25 3:15 AM, Alan Maguire wrote:
> Sometimes changes can be introduced that modify the set of functions
> encoded in BTF, or change aspects of that encoding.  Add a non-fatal
> comparison job to compare between the change and the base branch,
> by default the "next" branch.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
>   .github/workflows/vmtest.yml         |  4 ++++
>   2 files changed, 34 insertions(+)
>   create mode 100755 .github/scripts/compare-functions.sh
> 

Hi Alan. That's a good addition. See a couple of comments below.

> diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
> new file mode 100755
> index 0000000..062f15c
> --- /dev/null
> +++ b/.github/scripts/compare-functions.sh
> @@ -0,0 +1,30 @@
> +#!/usr/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +
> +GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
> +REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
> +VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
> +SELFTESTS=${GITHUB_WORKSPACE}/tests

nit: SELFTESTS isn't used

> +export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
> +which pahole
> +pahole --version
> +cd $REPO_TARGET
> +pfunct --all --format_path=btf $VMLINUX > functions_latest
> +# now use baseline pahole for comparison
> +export PAHOLE=/usr/local/bin/pahole

So we assume that the baseline is installed at this path?
And that would be an installation done by
libbpf/ci/setup-build-env action?

I would not rely on that behavior.  I think a better approach is to
build and use master (or whatever is the baseline) explicitly.

> +rm -f vmlinux vmlinux.o
> +export PATH=/usr/local/bin:${PATH}
> +make oldconfig
> +make -j $((4*$(nproc))) all
> +pfunct --all --format_path=btf $VMLINUX > functions_base
> +echo "Comparing vmlinux BTF functions generated with this change vs baseline."
> +echo "Differences are non-fatal to the workflow, but should be examined for correctness."

You might find it useful to dump a formatted diff to
$GITHUB_STEP_SUMMARY, to get a rendered output in github UI.

See here: 
https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions?versionId=free-pro-team%40latest&productId=actions#adding-a-job-summary 


> +set +e
> +diff functions_base functions_latest
> +if [[ $? -eq 0 ]]; then
> +	echo "Function lists are identical."
> +fi
> +set -e
> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
> index 0f66eed..54bb92e 100644
> --- a/.github/workflows/vmtest.yml
> +++ b/.github/workflows/vmtest.yml
> @@ -60,3 +60,7 @@ jobs:
>           shell: bash
>           run: .github/scripts/run-selftests.sh
>   
> +      - name: Compare functions generated
> +        shell: bash
> +        run: .github/scripts/compare-functions.sh
> +


