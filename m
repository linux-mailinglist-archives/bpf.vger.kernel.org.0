Return-Path: <bpf+bounces-57521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B70AAC74C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB603B0D5C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21241280CE7;
	Tue,  6 May 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk4qYI+u"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719A278745
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540127; cv=none; b=i3uBsTOtJmQyyerfjFUaaNDtc7Q7iP+w8OV/2H5ZcKq5CSd7IxwtlnZOSljp/rhtD9RE7KYU1KfnjjtTRTwt5dOi378LFpz0a7candM0F19jtq19agluONDGjD+wUUP9NUo4Z9+vMq3CluXo2Mp+1cyid/5A7+BiQr9RQsxMunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540127; c=relaxed/simple;
	bh=elWDGJ+LtHAh+h9iroKMz3JrCxWSflZYm2pNtHBZfMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhO5CRgWo77dkjpOqRR0XLjXntZy50h/tMNsG1nLPq8VLOOWe7oheY5gedtAzjG4fyxWQ5ZTuEgVIED7gHBemTYnErtYpSegwY1jEFRc71mS32GhE6CYrn0Z24mgr4fJT12pHLpiO8eMHdNmeHkdSBCLV9jfLbVCRQEI0MuML5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zk4qYI+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746540124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ye8i/UsqJKvQlKKIVYrfpekN4xF7RuPErJdU2N3amU=;
	b=Zk4qYI+uJmmTP5NOzzE5+Ghzp9YlptO/F5rdoT/53WhkrTAJw40aiMkxngnUaejFv/VUP2
	Y5Z1LKpaG0WLWSGdMnlCwUqjXDWm+lt+H7uUTaMiMoWf7deZF5PBHC6aBITXKETztyKfz9
	XKgmDnQyaioVwCVJwBAqw156oNnOW2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-gyyi02GDNNa0H7zDO120Cg-1; Tue,
 06 May 2025 10:01:57 -0400
X-MC-Unique: gyyi02GDNNa0H7zDO120Cg-1
X-Mimecast-MFC-AGG-ID: gyyi02GDNNa0H7zDO120Cg_1746540114
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1640A1801A3E;
	Tue,  6 May 2025 14:01:54 +0000 (UTC)
Received: from fedora (unknown [10.44.33.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8BE141800360;
	Tue,  6 May 2025 14:01:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 May 2025 16:01:53 +0200 (CEST)
Date: Tue, 6 May 2025 16:01:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aBoWEydkftHO_q1N@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
 <aA9dzY-2V3dCpMDq@krava>
 <aBoKnP4L-k8CweMy@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoKnP4L-k8CweMy@krava>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I'm on PTO and traveling until May 15 without my working laptop, can't read
the code.

Quite possibly I am wrong, but let me try to recall what this code does...

- So. uprobe_register() succeeds and changes ref_ctr from 0 to 1.

- uprobe_unregister() fails but decrements ref_ctr back to zero. Because the
  "Revert back reference counter if instruction update failed" logic doesn't
  apply if is_register is true.

  Since uprobe_unregister() fails, this uprobe won't be removed. IIRC, we even
  have the warning about that.

- another uprobe_register() comes and re-uses the same uprobe. In this case
  install_breakpoint() will do nothing, ref_ctr won't be updated (right ?)

- uprobe_unregister() is called again and this time it succeeds. In this case
  ref_ctr is changed from 0 to -1. IIRC, we even have some warning for this
  case.

No?

Sorry, I can't check my thinking until I return.

Oleg.

On 05/06, Jiri Olsa wrote:
>
> On Mon, Apr 28, 2025 at 12:51:57PM +0200, Jiri Olsa wrote:
> > On Sun, Apr 27, 2025 at 04:13:35PM +0200, Oleg Nesterov wrote:
>
> SNIP
>
> > >
> > > -------------------------------------------------------------------------------
> > > OTOH, I think that the current logic is not really correct too,
> > >
> > > 	/* Revert back reference counter if instruction update failed. */
> > > 	if (ret < 0 && is_register && ref_ctr_updated)
> > > 		update_ref_ctr(uprobe, mm, -1);
> > >
> > > I think that "Revert back reference counter" logic should not depend on
> > > is_register. Otherwise we can have the unbalanced update_ref_ctr(-1) if
> > > uprobe_unregister() fails, then another uprobe_register() comes at the
> > > same address, and after that uprobe_unregister() succeeds.
> >
> > sounds good to me
>
> actualy after closer look, I don't see how this code could be triggered
> in the first place.. any hint on how to hit such case? like:
>
>   - ref_ctr_offset is updated
>
>   - we fail somehow
>
>   - "if (ret < 0 && ref_ctr_updated)" is true on the way out
>
> thanks,
> jirka
>


