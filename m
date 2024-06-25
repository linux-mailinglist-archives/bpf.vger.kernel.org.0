Return-Path: <bpf+bounces-33060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE22916ACC
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2371F27FC6
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667216E888;
	Tue, 25 Jun 2024 14:41:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D63A8CB;
	Tue, 25 Jun 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326501; cv=none; b=kIt7HEyys7eLqFXLjurzso2HyVBCwYdhsWx9ebddnj4K8pkhhxkv5LafS1i2Xw97P7jAFPuk6HMSBtk7sqZU1eSNw8HZp9LnEn1qbaidzGYHfTJacn+1vpI1cI/AhKmZmRwqwc/c99NL9l+ss15w6a//TIdB8PYLsBAOUYI6FwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326501; c=relaxed/simple;
	bh=VosDvf0qt3pU/Covzt7D0pO5vvASRfaUya6aWxUxI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOTk62BSlcO7/hGXB8Fbw254TOXayt0jbF+CWAcC80jXfy9jklFmBU97Xg3aZfI8e+uaCAaQNGYHhogdPU+T61hRgNV+HkTaptVIwHXU4FS7Pmtzo+lJK+Fk8TjC06xGMWYkz0ivgiki415n7ZXpLaZIrbma0lxBJ47zaD7aMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDA7C4AF07;
	Tue, 25 Jun 2024 14:41:38 +0000 (UTC)
Date: Tue, 25 Jun 2024 10:41:37 -0400
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
Subject: Re: [PATCH v2 2/7] error-injection: support static keys around
 injectable functions
Message-ID: <20240625104137.7fbe294d@rorschach.local.home>
In-Reply-To: <20240620-fault-injection-statickeys-v2-2-e23947d3d84b@suse.cz>
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
	<20240620-fault-injection-statickeys-v2-2-e23947d3d84b@suse.cz>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 00:48:56 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> @@ -86,6 +104,7 @@ static void populate_error_injection_list(struct error_injection_entry *start,
>  		ent->start_addr = entry;
>  		ent->end_addr = entry + size;
>  		ent->etype = iter->etype;
> +		ent->key = (struct static_key *) iter->static_key_addr;

Nit, should there be a space between the typecast and the "iter"?

>  		ent->priv = priv;
>  		INIT_LIST_HEAD(&ent->list);
>  		list_add_tail(&ent->list, &error_injection_list);

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

