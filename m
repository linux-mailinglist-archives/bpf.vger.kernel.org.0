Return-Path: <bpf+bounces-79655-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIHNOO26b2kOMQAAu9opvQ
	(envelope-from <bpf+bounces-79655-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:27:09 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE9488CC
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05F438230D6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE528C860;
	Tue, 20 Jan 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyYyXxcK"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA9441056
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925292; cv=none; b=LZGg5NnKZwwOvkWPtc9kLA7zGLHoNn2hgxTaIMP/C88kbhkvicHcIirsuPv16NKCR/+UGlvfdHcriwuaXkEmK0Zb/oPoqKG9G4EPHJfjOYn1YzYqwAt3BECh/P3G9OcViSVUcoBRD4v0bmjPxcwatsP+rHi0tUa3yqWuIJLl3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925292; c=relaxed/simple;
	bh=f/QC7FzwN9onimK80+gXZLxFwx7O7hVSRYIEouRG59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfU7uEbyOxuPCM0yUKiuhxuYduX9dDE7fBYHwOSefDeJrreap0QDdmKoyuvS52Ed2JjI1u+2B+9hjRJZSUTz7ebX/Igi3IMI529zfs4vjXtKFjLt60wpTYhabPkysL10PempZz6uSntfmz/bnrNaH++El15QhLbz9hJ36WzqKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyYyXxcK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0a09b42-4858-4c28-b7a6-6ac1e856d7bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768925283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6beUxqGFv/OlKjWUXcRthqjnv/MJaefBTXeSFu/wzgY=;
	b=GyYyXxcKjkNm3k0Vr+hZorNx+PxVfgjfv+Np7okYlTi9045XrFBA/x4UmtWoNY471F4W7J
	dom8FrfmsowtaDqqB83pewlq6OEQckcYKKppAW4FjYKGmspqdkQq2WKmPjJkSrqEB7BqA8
	7Sh2Vogv0xN7qBhqbNALvWZYmoOZHbs=
Date: Tue, 20 Jan 2026 08:07:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 1/4] dwarf_loader/btf_encoder: Detect reordered
 parameters
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-2-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-2-alan.maguire@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-79655-lists,bpf=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 99EE9488CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/13/26 5:13 AM, Alan Maguire wrote:
> When encoding concrete instances of optimized functions it is possible
> parameters get reordered, often due to a parameter being optimized out;
> in such cases the order of abstract origin references to the abstract
> function is different, and the parameters that are optimized out
> usually appear after all the non-optimized parameters with no
> DW_AT_location information [1].
>
> As an example consider
>
> static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
>
> It has - as expected - an abstract representation as follows:
>
>   <1><6392a2d>: Abbrev Number: 47 (DW_TAG_subprogram)
>      <6392a2e>   DW_AT_name        : (indirect string, offset: 0x261e25): __blkcg_rstat_flush
>      <6392a32>   DW_AT_decl_file   : 1
>      <6392a33>   DW_AT_decl_line   : 1043
>      <6392a35>   DW_AT_decl_column : 13
>      <6392a36>   DW_AT_prototyped  : 1
>      <6392a36>   DW_AT_inline      : 1   (inlined)
>      <6392a37>   DW_AT_sibling     : <0x6392bac>
>   <2><6392a3b>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>      <6392a3c>   DW_AT_name        : (indirect string, offset: 0xa7a9f): blkcg
>      <6392a40>   DW_AT_decl_file   : 1
>      <6392a41>   DW_AT_decl_line   : 1043
>      <6392a43>   DW_AT_decl_column : 47
>      <6392a44>   DW_AT_type        : <0x638b611>
>   <2><6392a48>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>      <6392a49>   DW_AT_name        : cpu
>      <6392a4d>   DW_AT_decl_file   : 1
>      <6392a4e>   DW_AT_decl_line   : 1043
>      <6392a50>   DW_AT_decl_column : 58
>      <6392a51>   DW_AT_type        : <0x6377f8f>
>
> However the concrete representation after optimization becomes:
>
> ffffffff8186d180 t __blkcg_rstat_flush.isra.0
>
> and has a concrete representation with parameter order switched:
>
> <1><6399661>: Abbrev Number: 110 (DW_TAG_subprogram)
>      <6399662>   DW_AT_abstract_origin: <0x6392a2d>
>      <6399666>   DW_AT_low_pc      : 0xffffffff8186d180
>      <639966e>   DW_AT_high_pc     : 0x169
>      <6399676>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
>      <6399678>   DW_AT_GNU_all_call_sites: 1
>      <6399678>   DW_AT_sibling     : <0x6399a8a>
>   <2><639967c>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>      <639967d>   DW_AT_abstract_origin: <0x6392a48>
>      <6399681>   DW_AT_location    : 0x1fe21fb (location list)
>      <6399685>   DW_AT_GNU_locviews: 0x1fe21f5
>   <2><63996e4>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>      <63996e5>   DW_AT_abstract_origin: <0x6392a3b>
>      <63996e9>   DW_AT_location    : 0x1fe2387 (location list)
>      <63996ed>   DW_AT_GNU_locviews: 0x1fe2385
>
> In other words we end up with
>
> static void __blkcg_rstat_flush.isra(int cpu, struct blkcg *blkcg);
>
> We are not detecting cases like this in pahole, so we need to
> catch it to exclude such cases since they could lead to incorrect
> fentry attachment.
>
> Future work around true function signatures will allow such functions
> with their "." suffixes, but even for such cases it is good to
> detect the reordering.
>
> In practice we just end up excluding a few more .isra/.constprop
> functions which we cannot fentry-attach by name anyway; see [2] for an
> example list from CI.
>
> [1] https://lore.kernel.org/bpf/101b74c9-949a-4bf4-a766-a5343b70bdd2@oracle.com/
> [2] https://github.com/alan-maguire/dwarves/actions/runs/20031993822
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


