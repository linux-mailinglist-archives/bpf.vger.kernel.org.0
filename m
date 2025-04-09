Return-Path: <bpf+bounces-55522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE239A823FC
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006FE445CBF
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9538225523F;
	Wed,  9 Apr 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPTvMUEu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9F25DAF1
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199444; cv=none; b=Avj1sDoMIYGJq+pP27UzsRr1ApgFGGIvJIJzXnRRis0pfzAyuSrdmrabyiyOnp1X8i5Jr0ww+1hPENOnvawew8I01LljiFscXf+vHl+7LNbJ6w/FaK8sxZU8w2/02/n/R43MqW3ARdxcROFunh5FGXR632Pav59kpqMd8X0Ny0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199444; c=relaxed/simple;
	bh=iz7hGUeThO2pOoFkEYLyC60rVxruxbslzIpusyrw9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Vlbwg1Yx9/Iu8mIMiA06NC39/O5ddlWIuHpp9KD0yKv6g2RcVSmAAXWwukUHkbUUEBuIObyPowqoZMFzt78kXDTwLEsqLD5sJSTYPjjKYlKhopWX8ZGU9OXqneUBxWyVMtTRuGqUV/uogNx13b2NK1wrSd0UUqMfizRDHKmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPTvMUEu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744199440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMmVG5+2jOdZ04N8c2MqDN4J62ryFfX+ENG76OzBjCU=;
	b=CPTvMUEuRQ3FsNQltDUqcRDMRtaK3/+NN2KCtaugMSmvrbCE1vLA+ExSbKSF+gL2wvO5nT
	9qDkIzmeJjqzECXUR426q5hSvQF+mr4vG33X09hNbn5Wu/5jt+acVk5NcTZ+DMKyIdFGKE
	9bZ7k8IbhlD/fWDbemeSeEOtO1HGvRI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-mNAEURH2MSySMaaGVWqqiw-1; Wed,
 09 Apr 2025 07:50:35 -0400
X-MC-Unique: mNAEURH2MSySMaaGVWqqiw-1
X-Mimecast-MFC-AGG-ID: mNAEURH2MSySMaaGVWqqiw_1744199433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20E791955DCC;
	Wed,  9 Apr 2025 11:50:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3028B180B488;
	Wed,  9 Apr 2025 11:50:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Apr 2025 13:49:57 +0200 (CEST)
Date: Wed, 9 Apr 2025 13:49:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Message-ID: <20250409114950.GB32748@redhat.com>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <20250409112839.GA32748@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409112839.GA32748@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/09, Oleg Nesterov wrote:
>
> For the moment, lets forget about compat tasks on a 64-bit kernel, can't
> we simply do something like below?

...

> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,12 +840,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>  
> +	/* prefix* + nop[i]; same as jmp with .offs = 0 */
> +	for (i = 1; i <= ASM_NOP_MAX; ++i) {
> +		if (!memcmp(insn->kaddr, x86_nops[i], i))
> +			goto setup;
> +	}
> +
>  	switch (opc1) {
>  	case 0xeb:	/* jmp 8 */
>  	case 0xe9:	/* jmp 32 */
>  		break;
> -	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
> -		goto setup;

OK, I guess we can't remove this "case 0x90" because of prefixes, please
ignore this part.

Oleg.


