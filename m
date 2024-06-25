Return-Path: <bpf+bounces-33053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038109169DC
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C68B2460E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C93A167D80;
	Tue, 25 Jun 2024 14:08:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BE15FCE7;
	Tue, 25 Jun 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324502; cv=none; b=FJnuHE4olS+zt5CoVE4NiymdHNUjF8fC1fcYfVVg2f7JrDKC6Cf9TqPxq6CV3M83H0BRDat3ECIFYOqD922J6Wwq1R60JrkG5gR9xl+7s+rSnAu2SFx1LZ8x//VD8PRGCEJTMR6JuxyjvdKYain7talbB9t8/aXCsj32xGjPdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324502; c=relaxed/simple;
	bh=MkF7gsbve49E7iOED8XXlHYxiqFod6TCEopF86fOYic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oACqScrw62Caa9e6FJZlstMtdREJbDU62jcnfXCb55GasWvHg/QRaTo1P0H6vZXVE6VfLAKGxvCapo9zPfn/kJoRhvJR/PKnXKNu90pytsX2zHAelYwiNsZfMsjyjpf3b0JXMgid1+PFeQVP3iDfnP7c4vkcmyOAowWZRLBZb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2768DC32781;
	Tue, 25 Jun 2024 14:08:19 +0000 (UTC)
Date: Tue, 25 Jun 2024 10:08:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S
 Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fault-inject: add support for static keys around
 fault injection sites
Message-ID: <20240625100817.078318bf@rorschach.local.home>
In-Reply-To: <20240620-fault-injection-statickeys-v2-1-e23947d3d84b@suse.cz>
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
	<20240620-fault-injection-statickeys-v2-1-e23947d3d84b@suse.cz>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 00:48:55 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> +static int debugfs_prob_set(void *data, u64 val)
> +{
> +	struct fault_attr *attr = data;
> +
> +	mutex_lock(&probability_mutex);
> +
> +	if (attr->active) {
> +		if (attr->probability != 0 && val == 0) {
> +			static_key_slow_dec(attr->active);
> +		} else if (attr->probability == 0 && val != 0) {
> +			static_key_slow_inc(attr->active);
> +		}
> +	}

So basically the above is testing if val to probability is going from
zero or non-zero. For such cases, I find it less confusing to have:

	if (attr->active) {
		if (!!attr->probability != !!val) {
			if (val)
				static_key_slow_inc(attr->active);
			else
				static_key_slow_dec(attr->active);
		}
	}

This does add a layer of nested ifs, but IMO it's a bit more clear in
what is happening, and it gets rid of the "else if".

Not saying you need to change it. This is more of an FYI.

-- Steve


> +
> +	attr->probability = val;
> +
> +	mutex_unlock(&probability_mutex);
> +
> +	return 0;
> +}

