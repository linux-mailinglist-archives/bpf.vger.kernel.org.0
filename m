Return-Path: <bpf+bounces-40427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D29889F9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD47283D25
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45B1C230E;
	Fri, 27 Sep 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRz4V+y+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17D136E28;
	Fri, 27 Sep 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460959; cv=none; b=efwrvDzLHZYq3XmJevVn2AxDmk13Iale6NwGskKM3+NEYtVAWK2y3wiAiDFm0HuJOsCS6C8Wn9bc7itXQG1GuQHSEAujbZEoA5ZJMls/vvJTY+keqtV76VxvJQpMJNhD3hJvwPmv7P2s5zgmhaMdEO5VQnQ4sN5pJTQsqb3SnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460959; c=relaxed/simple;
	bh=VsXoDAk/3cgXnKaNj9IIe1/ClxMRI1S89qYD1FBDWjI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uEgwTD4b8lrmiMDtbn9UFP07Jpw3ZcWjJo1dGkbBz6uv5d6LkpqAHxXSO5+w+ltJKIz8I494LpMPGqoDVs6BydErUswtKTffkmk5Ix7fXLMZyY2LDFg39LRoQj2lXq4TOF3yca8vNFOCb/eR9gDYWaJILfFf1YXkDu5vWLhZl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRz4V+y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE14C4CEC7;
	Fri, 27 Sep 2024 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727460957;
	bh=VsXoDAk/3cgXnKaNj9IIe1/ClxMRI1S89qYD1FBDWjI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YRz4V+y+76TPvXCCHF6p3SZH/WWhAjhQ7qHx7bVrEEWS8Z6/orbgNWcRTJr0Iu5iI
	 bufKra0ucZske2c26x6r3rBd4fJHKBFqXpx/cwCqMTt43gNJ39Dkv2ihArqs24AbhM
	 s8WeBgV4b0hzYBgNJa5bJyNXkCko0o8koy26xaHhXdqktKdBBPgeQ6Ag2wGcnybI9K
	 iYmal/+CtFF0raFtVMd6HWdAY0spCP87tJGovzX5hlTFqCugugsIB5kSCngzjAEdSq
	 dZ4zDs9K5UCjwfGKw85soR2fWAdYvAciwX1Wen48lCfUKS7OeWpemdbDvmJFMGv1Bp
	 PLf24FhNrssXQ==
Date: Fri, 27 Sep 2024 20:15:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH HID] HID: bpf: fix cfi stubs for hid_bpf_ops
In-Reply-To: <20240927-fix-hid-bpf-stubs-v1-1-5bbf125f247c@kernel.org>
Message-ID: <nycvar.YFH.7.76.2409272015390.31206@cbobk.fhfr.pm>
References: <20240927-fix-hid-bpf-stubs-v1-1-5bbf125f247c@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Sep 2024, Benjamin Tissoires wrote:

> With the introduction of commit e42ac1418055 ("bpf: Check unsupported ops
> from the bpf_struct_ops's cfi_stubs"), a HID-BPF struct_ops containing
> a .hid_hw_request() or a .hid_hw_output_report() was failing to load
> as the cfi stubs were not defined.
> 
> Fix that by defining those simple static functions and restore HID-BPF
> functionality.
> 
> This was detected with the HID selftests suddenly failing on Linus' tree.
> 
> Cc: stable@vger.kernel.org # v6.11+
> Fixes: 9286675a2aed ("HID: bpf: add HID-BPF hooks for hid_hw_output_report")
> Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Hi,
> 
> This commit should directly go in Linus tree before we start creating
> topic branches for 6.13 given that the CI is now failing on our HID
> master branch.

Applied now to for-6.12/upstream-fixes, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs


