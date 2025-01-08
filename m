Return-Path: <bpf+bounces-48245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C799A05D2A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385431673ED
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8E199FA4;
	Wed,  8 Jan 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VRkXMmwQ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9B1F75B3;
	Wed,  8 Jan 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343935; cv=none; b=GtijnYsTA0LsxJ/Wzgb+HdI516msaPvNWwrNPDBvsyJYnbnK2ApQHYq7/kg57P0C9IorvIBuc0IqhaN25/O9frrjnclsNHUH1u3ttNCW3EzJCtIRgnge+sscaLa6Fp+6qA7tObSPl2eAMbWk10KOmNFZXZLAxdLZEf00kmy2m2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343935; c=relaxed/simple;
	bh=HbpdT9HkY7xxFWMxrkrd7qVDKm4x1pyECsN8AoEeNQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGN0uSfqPRPsfm1g8vCreWv40eMsM9cloT4jiLGSw3RNEBu8QLu1y7nNrpmRc/wsgRySyEcKzrl6DU1xXhXe/CSFEJ82nXduczvauik/sBDs/ihcyHrU3xeWB/KEvii97ofTEsPnE8x8Xl+e2/h5+52Sod5WgN/XF0+AhAE3YNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VRkXMmwQ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736343930; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=L1umNgqUP6pQ7JUaQ5lBzkMOWVEgdY9nQMF+Ck+7oa0=;
	b=VRkXMmwQWlzsuXelUh3/52OtLszfEntfzr/C3xczSrFhRd2R2+yj3jLLX1JUrOa/n4iOY6o5XbDFEuWxh86ewyUq7FkiZrXJaY0pOxQlhr9jiVHlzfSAyz+lGj1nE80OkqVdWtMDkd+g7cPq74zjznYcqilfgd5PPrTjOq/P9i0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNEGLEv_1736343927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 21:45:28 +0800
Date: Wed, 8 Jan 2025 21:45:27 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Xu <dlxu@meta.com>
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20250108134527.GA86266@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-5-alibuda@linux.alibaba.com>
 <2f56aca3-a27a-49b6-90de-7f1b2ff39df1@linux.dev>
 <20241223021036.GC36000@j66a10360.sqa.eu95>
 <f897692c-cbf2-4906-aa15-1661162621eb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f897692c-cbf2-4906-aa15-1661162621eb@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 07, 2025 at 03:24:51PM -0800, Martin KaFai Lau wrote:
> On 12/22/24 6:10 PM, D. Wythe wrote:
> >On Thu, Dec 19, 2024 at 02:43:30PM -0800, Martin KaFai Lau wrote:
> >>On 12/17/24 6:44 PM, D. Wythe wrote:
> >>>Here are four possible case:
> >>>
> >>>+--------+-------------+-------------+---------------------------------+
> >>>|        | st_opx_xxx  | xxx         |                                 |
> >>>+--------+-------------+-------------+---------------------------------+
> >>>| case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> >>>+--------+-------------+-------------+---------------------------------+
> >>>| case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> >>>+--------+-------------+-------------+---------------------------------+
> >>>| case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> >>>|        |             |             | vmlinux and mod.                |
> >>>+--------+-------------+-------------+---------------------------------+
> >>>| case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> >>>+--------+-------------+-------------+---------------------------------+
> >>>
> >>>At present, cases 0, 1, and 3 can be correctly identified, because
> >>>st_ops_xxx is searched from the same btf with xxx. In order to
> >>>handle case 2 correctly without affecting other cases, we cannot simply
> >>>change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> >>>to find_ksym_btf_id(), because in this way, case 1 will not be
> >>>recognized anymore.
> >>>  	snprintf(tname, sizeof(tname), "%.*s",
> >>>@@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >>>  	}
> >>>  	kern_type = btf__type_by_id(btf, kern_type_id);
> >>>+	ret = snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
> >>
> >>How about always look for "struct bpf_struct_ops_smc_ops" first,
> >>figure out the btf, and then look for "struct smc_ops", would it
> >>work?
> >
> >I think this might not work, as the core issue lies in the fact that
> >bpf_struct_ops_smc_ops and smc_ops are located on different btf.
> >Searching for one fisrt cannot lead to the inference of the other.
> 
> Take a look at btf_find_by_name_kind(btf, 1 /* from base_btf */,
> ...) and also btf_type_by_id(). It starts searching from the
> btf->base_btf which should be the btf_vmlinux here and should have
> the "struct smc_ops". Please try.

Got it, I will try it, thanks for your suggestion.

D. Wythe

