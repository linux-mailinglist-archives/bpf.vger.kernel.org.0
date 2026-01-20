Return-Path: <bpf+bounces-79661-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAnuM43Ub2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79661-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:16:29 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9C4A235
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B562970B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3243CED7;
	Tue, 20 Jan 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAEBNje/"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE391346FA0
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931677; cv=none; b=lfQ59gt/O+aKwrhj0WNpuU/ABZmZXT7TQZ0bfbUEM0hZidNCFKmrG6IGDT3uuYXbcyGB7JLglfmjaoqAMOB42BcBxJKjQT9/oa9uOmqhk87TKZHa+dZX/W8QY2w1X306PrASfGeBOTDFwCpLnJPCWaS5fFVTv3EfMfbdFVbfScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931677; c=relaxed/simple;
	bh=NBwkl3L/qWZdERVFVMlJvthiX57LHnU+xEZMdYaMlo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrDwBIhfEjOZ9JyPcNOt/W8SkSpQ8cVE636mAgp5ygyYE/nLO4Ay1iM8bFbHY6eTCPqq4QkOtCoCue++yTXwiwoJ6jJsovbXVTZCHlliqP5zWzNb3lJAjmw31SFbS5NeGbAVBm6rg5DXSl5y2mkkFRbEwB7eTPiu61p4UwEVYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAEBNje/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f9ec651-337b-441a-9bd6-8e03e91e2eb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768931674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBwkl3L/qWZdERVFVMlJvthiX57LHnU+xEZMdYaMlo8=;
	b=WAEBNje/3YHB87sCep6qe7yE/b+eW4Mia6+J8QKLrjNGL6q4PEnE0Fov6epy1U7pPvVtAq
	pVIg91WKUqi60gqkyT8/pvXT4meUq+m3sfCeg8t0AKackYPksLPyogCYLLDqZfXoF7/EyU
	GMgIXm+zFYTLDz8Y9DXtUDb32sdv0hc=
Date: Tue, 20 Jan 2026 09:54:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 4/4] btf_encoder: Prefer strong function
 definitions for BTF generation
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-5-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79661-lists,bpf=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yonghong.song@linux.dev,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 43B9C4A235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/13/26 5:13 AM, Alan Maguire wrote:
> From: Matt Bobrowski <mattbobrowski@google.com>
>
> Currently, when a function has both a weak and a strong definition
> across different compilation units (CUs), the BTF encoder arbitrarily
> selects one to generate the BTF entry. This selection fundamentally is
> dependent on the order in which pahole processes the CUs.
>
> This indifference often leads to a mismatch where the generated BTF
> reflects the weak definition's prototype, even though the linker
> selected the strong definition for the final vmlinux binary.
>
> A notable example described in [0] involving function
> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> distinguished only by parameter names (e.g., file vs
> file__nullable). While the strong definition is linked into the
> vmlinux object, the generated BTF contained the prototype for the weak
> definition. This causes issues for BPF verifier (e.g., __nullable
> annotation semantics), or tools relying on accurate type information.
>
> To fix this, ensure the BTF encoder selects the function definition
> corresponding to the actual code linked into the binary. This is
> achieved by comparing the DWARF function address (DW_AT_low_pc) with
> the ELF symbol address (st_value). Only the DWARF entry for the strong
> definition will match the final resolved ELF symbol address.
>
> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>
> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


