Return-Path: <bpf+bounces-48368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF008A06FB5
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BA3A660F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7B21504F;
	Thu,  9 Jan 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1b2zKe+l"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE7214812;
	Thu,  9 Jan 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409985; cv=none; b=sg7v8391KvkY8rtHThBIRlPVbDxF1eBuDPPtMZePWKJHlmdzUGW25WLXXP5Iftro76qd+EULF7Hrcc5xqrmtjdiN4HX2rJ4rc3OVcbNYcBTvRNgIc/t8KawoVuERRKa8SL+IfjsQO4CbsZLlPoryKdzmoiy+gArO0sgYqG62l7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409985; c=relaxed/simple;
	bh=65zC2CwbsRoKY3ejZ5obn10u2j+VqNZDXPSqx9+fbFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax/4d6lghb41wu8mkLvlZTzFQTz8+MrXoCppFxn2V2SkSBf0MnO3nx1JWlRv3ZgLQwgXEa9Hikv3woectEiRG9YZnry1meDqJ08Ol5PfP5z1TZzZmq08sFHHn8XVgQbhHTt8r6ihv+md+UmB1xrv0y/2bueizXKqJBtJ7gkPGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1b2zKe+l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J+7TSGHXFL8/Y9YPMq/aeDzuJIsjLfw7/hMIKRXc/M4=; b=1b2zKe+let/4glvc6CEebbRQN4
	GitgyZO0o5i1jesnNGaKE/FZhb18mmWvEz3QGoScqAD3LL53847hb354Vs//hlMbuZ3MKr6YZ+U2h
	uLJwJT1O3V7M6IPkWkelZ1xJdan92GsNPcmGgDahedD5jwKlwAZRTbEKJNcjXDdj/qdEToXhy9Dji
	oiYU/u8YuyFfDA+6J7CBrMcW3Rhwn4LaiO65Zdn/Qn9zbTXmm9/GZuJjYhBls6xB8CpzKvJEPZQKb
	C09/FQ1MaIAQlDjtnikIb2ghvXS0t4wNVqFAU01PE6MbSa2e3JnlZuv3CbgwKKK9uPykETs9WoIxk
	dImQantQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnYP-0000000B8TT-3duK;
	Thu, 09 Jan 2025 08:06:09 +0000
Date: Thu, 9 Jan 2025 00:06:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <Z3-DcbY60SxoM0dN@infradead.org>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
 <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
 <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
 <2025010914-gangly-trodden-aa96@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010914-gangly-trodden-aa96@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 09, 2025 at 08:56:37AM +0100, Greg Kroah-Hartman wrote:
> The "pointless" penalty will go away once we convert all instances, and
> really, it's just one pointer check, sysfs files should NOT be a hot
> path for anything real, and one more pointer check should be cached and
> not measurable compared to the real logic behind the binary data coming
> from the hardware/kernel, right?
> 
> sysfs is NOT tuned for speed at all, so adding more checks like this
> should be fine.

Hey, when I duplicated the method to convert sysfs over to a proper
seq_file based approach that avoids buffer overflows you basically
came up with the same line that Alexei had here.  And that is a lot
more useful than constification. Not that I mind the latter, but it
would be better if it could be done without leaving both variants
in for long.


