Return-Path: <bpf+bounces-54686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EDA70475
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA33AFDEC
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAC25B691;
	Tue, 25 Mar 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGdDPVGr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3925B668
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914804; cv=none; b=Ds/65h35ie9nCr1h7YWBH4fUcEuTlIvCBLMsV07UyY2HmU3UWHF51pQbWIY+SViMMHBCiMp+QrcocxqM01CgdNKc28PpkirFq62SfxZ+BCUvJwNhQEFkGvCPmjzl6OlccmjuCeJrLuMbISnEANfpWthS7bXvI1HICREdVhyDkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914804; c=relaxed/simple;
	bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtsB2T29KSowivwzxzLUCsb7W5JbqFlMUdmb0M+2B51qWAKC7jc83ogNwpJitjBNO1AcfsyAuatTYHILmMea/WnzZWZV/xjPSMPuTFxzMjxx4tW1/pPNMBBjc6BPdP0SlFoIzFO1sDl+FQIIpiNb5XXtcSqGTcke8hh1auTRGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGdDPVGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742914801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
	b=VGdDPVGr3VrxXuWcptIQGx7/oTBv6iiy0PSBV39hqEJ7D0qZc9IXd8a1biqlRR+BtBGXWe
	6n+uxFtFoboImNR1JReXTb2iMjK62e20spbv3rxXQr+SzLbqzem7P9jewh1Gmmy+qSZFk9
	e8B6iKSyzUckK0mp1Z0n7j4ey46NT/M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-z9o0Cz5nMMmmYBmto5qUIQ-1; Tue, 25 Mar 2025 11:00:00 -0400
X-MC-Unique: z9o0Cz5nMMmmYBmto5qUIQ-1
X-Mimecast-MFC-AGG-ID: z9o0Cz5nMMmmYBmto5qUIQ_1742914799
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac6ce5fe9bfso53150366b.1
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914799; x=1743519599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
        b=JhjMsN5ZoFmRSARjpGLjeactC1ybiUJ7+5j4M0ItzeRGX8zuCK342LwWC6LCsiu2AX
         9bQ4T+wYF2qzPKQYvRA29jgZnqLZSSHKY7nL3iHonDsbEU8ENAcXc1oOQK47Y926tdhn
         MGrqJrDxjG77xxZWgEZRzURZ8AveECz3sKqQFtTUoGZJaJbDtXmFD37yBeb6B8OYMzK/
         d/BZ0ZGRDAWNOZJGXPPmU0oi62TGW6lUpOfgmK7S6Yi4kzHNPI8EIBFKcnoFZb/amOGI
         3fx6lXmiWwvTCNrWr2NtGU+3E4GBhJcO/TgOqLm7utpYtsWRxCyZmkIHhAdWaKLOK4ex
         koWA==
X-Forwarded-Encrypted: i=1; AJvYcCXsvFU1CfzttSPPcv79d0zB7ghnE/ffVOQG28OrVuXOa8HE6izRSY60w+q98uDliALHHBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM44gpWcHln/2rO9V4XSp1TiHePm4abF/0N5zJdMLOZZJ8c14y
	QD/jiB2VZL8FisGrObNZwHSvzZ9DpjDmSvTarGi9Q0gJuGbI+FcCCcm42X5Q3lcMD5/Oya3XIzr
	dwUThZz20EAiInPty+Eu57wBfkhpoRCELhPVq0kg6WOIb09vcQFFVYJGSsITyDqf4L1s6CaHniU
	e8Wyq1DlQZWSrgnbHRYyMld8IS
X-Gm-Gg: ASbGnct26a2jpIosRRyi0QAiYlRuKSUhX9ZvFge/DszW1jsnKfqfwqWBHgB4ihVAJdJ
	FZ3d7yxhSLRQC+7zXd5jb7BtXY6WlpftC14qNgHX3saQhfF89Fbg6k1+z4/jGpY5ZaZppS0/c6A
	==
X-Received: by 2002:a17:907:1b05:b0:ac3:8626:607 with SMTP id a640c23a62f3a-ac3f251fbd3mr1795386766b.38.1742914798876;
        Tue, 25 Mar 2025 07:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+YUjGVWtfpyBwCFBLJ1QlJAEWsiUBcgZ5CATDRVTkA/NPywRDWZDxKGd2LtWzuRZROP8MS1zhzDRVTnbwctU=
X-Received: by 2002:a17:907:1b05:b0:ac3:8626:607 with SMTP id
 a640c23a62f3a-ac3f251fbd3mr1795382466b.38.1742914798382; Tue, 25 Mar 2025
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org>
In-Reply-To: <15370998-6a91-464d-b680-931074889bc1@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 15:59:44 +0100
X-Gm-Features: AQ5f1JoiLoJo4ZTpZl2aK1T1MfyI1PFI0KWuUJogAG7QL32ZnjVnpgltDvnuL14
Message-ID: <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Quentin, Venkat, Saket,

Thanks for looking into this.

=C3=BAt 25. 3. 2025 v 13:12 odes=C3=ADlatel Quentin Monnet <qmo@kernel.org>=
 napsal:
> If you talk about tools/tracing/rtla/Makefile failing to locate bpftool,
> it's another matter. As far as I understand, the RTLA Makefile assumes
> that bpftool is available from $PATH, this is why the commit introduced
> a probe in tools/build/feature: to ensure that bpftool is installed and
> available. So here again, I don't see the motivation for changing the
> path to the binary (And how do you know it's /usr/sbin/bpftool anyway?
> Some users have it under /usr/local/sbin/, for example). If the intent
> were to compile a bootstrap bpftool to make sure that it's available
> instead then it should replicate what other BPF utilities or selftests
> do, and get rid of the probe. But the commit description for
> 8a635c3856dd indicates that RTLA folks prefer not to compile bpftool and
> rely on it being installed.

Yes, that is correct. The reason why I opted to use the system bpftool
is that bpftool itself has a lot of dependencies, and they would have
to be available at the time of building RTLA. Since RTLA only requires
basic bpftool skeleton generation, and the only "special" feature it
uses is CO-RE which is already quite old now, I don't expect the build
to fail with system bpftool, so I chose to use that to make both the
build dependencies and the RTLA Makefiles simpler.

My commits sets BPFTOOL to bpftool since otherwise, the feature check
would fail, as BPFTOOL wouldn't be defined, since it is not passed to
the feature detection make call. I observed we are doing the same for
Clang and the LLVM toolchain in tools/scripts/Makefile.include;
obviously, there is no problem there, since neither of these are
in-kernel.

Shouldn't the selftests always test the in-tree bpftool instead of the
system one? Let's say there is a stray BPFTOOL environmental variable.
In that case, the tests will give incorrect, possibly false negative
results, if the user is expecting selftests to test what is in the
kernel tree. If it is intended to also be able to test with another
version of bpftool, we can work around the problem by removing the
BPFTOOL definition from tools/scripts/Makefile.include and exporting
it from the rtla Makefiles instead, to make sure the feature tests see
it. The problem with that is, obviously, that future users of the
bpftool feature check would have to do the same, or they would always
fail, unless the user sets BPFTOOL as an environment variable
themselves.

Tomas


