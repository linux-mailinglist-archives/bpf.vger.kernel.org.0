Return-Path: <bpf+bounces-54690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C625A70565
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C30318934EE
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007A251790;
	Tue, 25 Mar 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLLCp2Rg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CD1922FA
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917538; cv=none; b=hj2WJH0hp4kazjaIWsevX2pBtGTw+58UFrfP0eZNnj/C8YwnJC0CTlb0k7NcPEL8cLYluiR6l4qREnqFIVi9oG/c0Q4PDuGbs4sm7gULf46BoY+KY4aATImBe4xH2dFSCVSccbs8mLJsbpcsfNq8n1RRBz5lU/fah3mwscmZVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917538; c=relaxed/simple;
	bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZxY3iKvWxDkUWAGeZ9ZLfQyWza1mKpb6uYbzIMIZcjktz1Sd7iZB0/Z5wZihg8xB7bHpUjyu/IpSq49qJ2WV2KbFJLvBBSOinB7u3A056blyDanxm/UOYCRA4BgaQHF1+/eF0jI9lc2kgITQFt2YCe+oyZPpKhCVI55+JWxOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLLCp2Rg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
	b=RLLCp2RgsSLHXrfCJm0thA8LtUFop2lroLG95JhEOGSugTd7hqp7HQps9Q5GBRlnlwLSzk
	8qLOSksbllWPqx3OPA5KYj+LAE0qDk2oIy+1fxiZZqjOlkGXzIBluQQnjadWpuGunsHw9b
	F/T/iaQesKgZzmSrf/kHKBKnCDNIB84=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-3ygt3-WlOBO72WaCHJRwWw-1; Tue, 25 Mar 2025 11:45:31 -0400
X-MC-Unique: 3ygt3-WlOBO72WaCHJRwWw-1
X-Mimecast-MFC-AGG-ID: 3ygt3-WlOBO72WaCHJRwWw_1742917530
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso562563266b.2
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917529; x=1743522329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
        b=Cwai57uy16zOuO56pVFHeaRNx40CGJSEp/Rsu1ghuW8dDowuMUT1ANZ/eCalBdNyah
         MJILXk7Qsz3anKJdsPmgvEPFa/34yfeXW/oZyJt961IROWwceTmC6J0xAfBgWGV3KgcR
         IPjJLIVkzYUleqZupdQvqKTfSr027q8ax6gp2ZJ4XwEAraL8Muqgk1/zofFgttirRMHs
         Pgx9QiUPO3zh3zhfMJKbN/6P7HSFUxtaZT7K+OoxWti9p1X+areOxytY3PtCVdM/K2X5
         N8jgzEmqjUsVgZqQfp91ot3NX+eAJ6IVaJOH1jzFl4aDr1kCxGlTUJ9TUJueFbVw0vwO
         gMQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4xI8+h6/fzISgN78ZLiHgfR3sRWJOhAbcw3FGs/HG9XqEgUSYFa1AKPFZmFzmEEJ6O3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYg2oUu5C2efJZ2Ye8sMA3q4yvaGiZN0WD6qrJhgAP3s204iPf
	CQsHCtyZpEdBhXfY9lxiIFpZ+8IwhlLaAj19ox5BFwRsBSm/rRMEMKy8hF0CM3JmAj9V/p6MhVw
	evG2Ct5ofRzRiMbaeHyyXf60QlGvQai+Ht/fq2EjKdIOxcUpThEWvJ9CIguR2Q5BXIdyYztAMnU
	pImv8+WFNCxQmml0+Sg0+JFWa5
X-Gm-Gg: ASbGncvefxZZRj+MjRa3yv9/iOUC+E5HSqoH8G4fKfUTaeIwq0gQpVOVYaLoOvhOF+E
	pCIZb8U7AX0ZwpVcd69aZYGalcI70VXA3G/7Xz9kMdOjrJsApJuml24kRoRJF/WceDzXhYeg2Kw
	==
X-Received: by 2002:a17:907:d7c8:b0:ac4:4c5:9f26 with SMTP id a640c23a62f3a-ac404c5a21cmr1536626166b.38.1742917529634;
        Tue, 25 Mar 2025 08:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeETmw4framl80aCDPCZ4HSMAoLbK1xiEJNCo4pPB8lZTQdmb6dcWKlzwYlP9rfQiUfuMemc5QS9iw9mUlDig=
X-Received: by 2002:a17:907:d7c8:b0:ac4:4c5:9f26 with SMTP id
 a640c23a62f3a-ac404c5a21cmr1536622666b.38.1742917529240; Tue, 25 Mar 2025
 08:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org> <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
 <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com> <a5cccd3a-ff63-4adc-aec1-ad61a58a4b25@kernel.org>
In-Reply-To: <a5cccd3a-ff63-4adc-aec1-ad61a58a4b25@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:45:16 +0100
X-Gm-Features: AQ5f1Jqv6H0g9eUrhfuNsHW2oA4i9dAk4ttrUyj157jQhQy6qdUHoOKA23K7Rx0
Message-ID: <CAP4=nvTUcMfXgfLNai2OQmnEiy5wv9OHGZyA1agdA+pUi2cHYw@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 3. 2025 v 16:27 odes=C3=ADlatel Quentin Monnet <qmo@kernel.org>=
 napsal:
> Sorry I don't understand the issue, why not simply rename the variable
> that you introduced in tools/build/feature/Makefile at the same time, as
> well? That should solve it, no? This way you don't have to export it
> from the rtla Makefiles. Or am I missing something?
>

If I set BPFTOOL in the rtla makefiles, then it won't propagate to the
feature check, unless exported. I observed feature testing of clang
works, because CLANG is set in tools/scripts/Makefile.include, and did
the same thing for BPFTOOL.

> I think this was the intent.

I see.

> The variable name needs to change either for rtla + probe, or for all
> BPF utilities relying on it, indeed. As far as I can see, this is the
> sched_ext and runqslower utilities as well as the selftests for bpf,
> sched_ext, and hid. I'd argue that the variable has been in use in the
> Makefiles for these tools and selftests for a while, and renaming it
> might produce errors for anyone already using it to pass a specfic
> version of bpftool to try.

That sounds much better than renaming the existing BPFTOOL variable,
thanks for the suggestion. I will send a patch tomorrow and give you a
Suggested-by.

> Note: Not that many dependencies, most of them are optional. For
> bootstrap bpftool we pass -lelf, -lz, sometimes -lzstd.

Noted. I must have been thinking of the entire long list of
dependencies in tools/perf/Makefile.config, completely unrelated to
this. Sorry for the confusion.

Tomas


