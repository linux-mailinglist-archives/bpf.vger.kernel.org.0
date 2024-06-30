Return-Path: <bpf+bounces-33444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FE91D027
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 08:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FB31F216CC
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A72C3B2BB;
	Sun, 30 Jun 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlcoB+1k"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F330358
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729070; cv=none; b=t30aKeciIdYl4Liq3myMJjd1KhT+TQizEM31yoVSWGC1LoD3S4FyuYk6yjrJw5fKf4k6wrlRefWvBDeVG0UgOHkcAyk3moXd3FWLl5I/NtrkxeIEdAatdDKfes0bcpxhwHESCs8x/acwVp3tQgsiHpP4l5Aj38MM4o6+POko8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729070; c=relaxed/simple;
	bh=nFsORew67a/rZmPX+lXujxGMRL3SU/JD61ZaOMlF6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD+4SVU7i7MQvTfLaXGtnIcj3LooMckdyn4Hvws4q+9V1u7t2+0I7I/NrR1kCWl+xzpPwnqcw9MWl4BNIPMpvv2QUCRJ7+eW/vBsZtCKczTP/3cWT44k8SWuVP7SQfoX2qV91/meGT50fayrQOxMWz0+MMbpyPFTIj+mdk+HUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlcoB+1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719729067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrQLQYs/c1TN4fMfLr0qEglsctNmbRE0xMqs8gdbCqs=;
	b=QlcoB+1kYlYIYPRa350LFH7nH6D6y1EEys4w38kWDjSJvn3+0WWTVBMC560bayQz4LNbVh
	LLyTligJ2eIqKBlpBDlI4mp52D8OW4T1BAzf+YcsjaGGEf5H3dg+8lQNzAR0G+cfccOKO/
	f5kbscT3IoN0JaeSmeK/hz/jalgVDH4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-j6yIIMv6NYm2wG_F9dmPjw-1; Sun,
 30 Jun 2024 02:31:00 -0400
X-MC-Unique: j6yIIMv6NYm2wG_F9dmPjw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19AF619560A2;
	Sun, 30 Jun 2024 06:30:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C87301955E80;
	Sun, 30 Jun 2024 06:30:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Jun 2024 08:29:22 +0200 (CEST)
Date: Sun, 30 Jun 2024 08:29:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, andrii.nakryiko@gmail.com,
	andrii@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
	kernel@xen0n.name, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	mhiramat@kernel.org, nathan@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] LoongArch: make the users of larch_insn_gen_break()
 constant
Message-ID: <20240630062916.GA11898@redhat.com>
References: <20240627173806.GC21813@redhat.com>
 <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com>
 <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
 <20240629150313.GB4504@redhat.com>
 <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/30, Huacai Chen wrote:
>
> > +static __init int check_emit_break(void)
> > +{
> > +       BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
> > +       BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
> > +       return 0;
> > +}
> > +arch_initcall(check_emit_break);
> Do you mind if I remove the runtime checking after Tiezhu tests the correctness?

Sure, please remove, thanks.

Oleg.


