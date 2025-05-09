Return-Path: <bpf+bounces-57845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87711AB0E2C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1926D1C23790
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120E274FFE;
	Fri,  9 May 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4aIxehk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D76274FCA
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781513; cv=none; b=QYxNlOE9dLgH4UcZPNY50tB16MOnCs0hhmSF07OUhmq6sPQGuhCTYrdU6him+Itw5Ss8STj0XQvdo6475j0YU/KiQzUfJyaXaBLNiQDzvRjJJ8fq0QXVCctXMr7OBAEGUhmPfHVh/xY+YDB3H/8lyWwp0P/MtQQiUt/qRzO21Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781513; c=relaxed/simple;
	bh=trUsVSs1iOFkx4vC0pQuauaGDAtPMOnT3SxD3P3Zv4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZxvQ3p7ZMru8quH7rFKujd7yMXz/BKALoeBv9U9fJ4EHAXjyEjIneuBw6N3lI0DaU0nGXxdfAcv6I3VcA2SqYlso3bR1GD1pC1yHM4PKIEN7qbf7Pw8Ak6b8PsxZW/Cx2SaBQ11CjucET3BIzpkR/zVtuBIQK89vm/X1n19UHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4aIxehk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ADCC4CEE4;
	Fri,  9 May 2025 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746781512;
	bh=trUsVSs1iOFkx4vC0pQuauaGDAtPMOnT3SxD3P3Zv4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q4aIxehkHwcsU58tU0ykdIz7HAXWcZUFStCes+DCUrv+jMur6/o4D5IjmNfNoxpGX
	 Vl2aWITirY/zpiDawuH+lLLmA2ktlpuD+Hi5JH8cRbHq2MT/d0JmsTyPH8hj3tvaYj
	 zdZkCQbKru7l9V5g7XGS9JQi0QUZxmXhZTov5EfFsEI6z3I73O+vmuSxZwdL/NuZz5
	 fs6nI+/RPj/SR1moeAsh8DWCY7Ng/X5UbBdIxVHKPiq6nApBHbV66TbACUIMGTdEgu
	 Fc42khm2I84s0kRPQQS94WRMBYUCWlaRP9Kd5Z7RGzXMYsDhZoX5LGYk3/NAxW0eUu
	 wSUV3Ts4fuIew==
Message-ID: <cf2c78d2-3a7d-40bb-b7f1-5503e052cfae@kernel.org>
Date: Fri, 9 May 2025 10:05:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] scripts/bpf_doc.py: implement json output
 format
To: ihor.solodrai@linux.dev, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, dylan.reimerink@isovalent.com,
 kernel-team@meta.com
References: <20250508203708.2520847-1-isolodrai@meta.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250508203708.2520847-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-08 13:37 UTC-0700 ~ Ihor Solodrai <isolodrai@meta.com>
> bpf_doc.py parses bpf.h header to collect information about various
> API elements (such as BPF helpers) and then dump them in one of the
> supported formats: rst docs and a C header.
> 
> It's useful for external tools to be able to consume this information
> in an easy-to-parse format such as JSON. Implement JSON printers and
> add --json command line argument.
> 
> v3->v4: refactor attrs to only be a helper's field
> v2->v3: nit cleanup
> v1->v2: add json printer for syscall target
> 
> v3: https://lore.kernel.org/bpf/20250507203034.270428-1-isolodrai@meta.com/
> v2: https://lore.kernel.org/bpf/20250507182802.3833349-1-isolodrai@meta.com/
> v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.com/
> 
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>

Thanks a lot for this!

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

