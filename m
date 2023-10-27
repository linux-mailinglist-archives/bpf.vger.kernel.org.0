Return-Path: <bpf+bounces-13418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447C7D98E8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D87E28241A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A2156E1;
	Fri, 27 Oct 2023 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cji/7DvS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264C8F5B
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:48:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871FF1BE
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698410886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15g1EMYRE6YyJVRDmaQ2tXDePrnPefUa55j6xZ4k+Kw=;
	b=cji/7DvS2eh95ZF1kQNLB+lXttAeA2O8Ji8BEdb+jID4y/0ZrkF8W6KvMkNlpgsTDbCI7X
	MEYjEAxux+981nrtr2QjVATENypuOqZYQv4BtEY/fHtk+dP0hUctG453+fCxxngf/eIHnf
	Qu1fM6vZaDXrlq9gIbd1uuoAVUozIbI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_rttl33yMzG6Nmfa_qsz-A-1; Fri, 27 Oct 2023 08:47:55 -0400
X-MC-Unique: _rttl33yMzG6Nmfa_qsz-A-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2ef9e4c25so2849573b6e.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 05:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698410874; x=1699015674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15g1EMYRE6YyJVRDmaQ2tXDePrnPefUa55j6xZ4k+Kw=;
        b=oTTrCYCFJL2F1EN8i8UW4Pd7l26kR2TKE/14ZiIAsiKqUfK3b+Fbd388g/PfiiiTHh
         2v4ybD6opF/RoUzQfFLEJOWhZoXfMTmHLVvDLJBxIG4m/m84Pc2Oo0W35wojdVCAeDnT
         A5VlFvXTm6JvP9QAr0s/NJPX7AwKzokHoc9TkiTKm8EBtQwQI6abT4fMiiQvTnKGDaKb
         n3wold+9Br0CwsnMaLFtpqjuhYbLp7dDkyEzmcvUC1iJ7oFlq9NO0FhnCspo0Ox2K3MQ
         cbrQDG+zwfhAv9RpbXJnhyZdolp21so7UeO9R8RN0zlKSkzJfArXNOMO/5nMvvh4mvmg
         9w4A==
X-Gm-Message-State: AOJu0YwKgFgQtQWfaBtgR7yOh8EGIshVuk+jCwkuXecsEFzM0NiC3ul1
	s727O/FrcVFoWCS1XsynHBaCQzbaC5dFMqntvZ4g2IZgNxwdIW/ADcQfdI3V+CaS9SZ2Ydt0+Ta
	byE1MyGcr6WzZ+TXkJT5DKoxsmUfW17PmWt8y
X-Received: by 2002:a05:6808:4d9:b0:3b2:e5f2:5a59 with SMTP id a25-20020a05680804d900b003b2e5f25a59mr2575324oie.35.1698410874507;
        Fri, 27 Oct 2023 05:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwgmaJDh22XYFSp+tuH5AvFEKThrSJVm5C8j53ddL/E1f+Dw9RSRxO7QiB7fR7i9ofR4k6SEXMFrYAbEOVsSw=
X-Received: by 2002:a05:6808:4d9:b0:3b2:e5f2:5a59 with SMTP id
 a25-20020a05680804d900b003b2e5f25a59mr2575317oie.35.1698410874255; Fri, 27
 Oct 2023 05:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6g7J+s_LFaA2sauAG2NJsW0-ob7bxmcCYZFDu1GWp_dtEbww@mail.gmail.com>
In-Reply-To: <CAP6g7J+s_LFaA2sauAG2NJsW0-ob7bxmcCYZFDu1GWp_dtEbww@mail.gmail.com>
From: Mohamed Mahmoud <mmahmoud@redhat.com>
Date: Fri, 27 Oct 2023 08:47:43 -0400
Message-ID: <CAP6g7JJqSZLFKc6uuJ=EXky9TZqxYJWLWdK4N3kuOTGWob8BgQ@mail.gmail.com>
Subject: Re: experiencing very odd behavior with TCP traffic with TC hook
To: bpf@vger.kernel.org
Cc: Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi All:

I have been looking at an issue while attempting to track DNS over TCP packets
I am using "do dig www.google.com +tcp; sleep 10; done" to test the code
I noticed the TC hook seeing inconsistent pkt length which causing my call to
bpf_skb_load_bytes() sometimes return EFAULT
I collected some info for working and non working cases

working
======
"dns_record": {
                        "id": 40514,
                        "flags": 34176,
                        "latency": 185794,
                        "errno": 0,
                        "offset": 68,
                        "tcp_len": 34,
                        "skb_len": 291
                    },
none working
==========
"dns_record": {
                        "id": 0,
                        "flags": 0,
                        "latency": 0,
                        "errno": 7,
                        "offset": 68,
                        "tcp_len": 34,
                        "skb_len": 66
                    },

as u see in the failing cases sbk_len is only 66 bytes that explains
why call to load bytes fails, IMHO this very odd behavior and inconsistent
it's not clear what I can do in my application to get consistent behavior
I am seeing this with RHEL9.2 kernel
uname -r
5.14.0-284.36.1.el9_2.x86_64
is this a known issue that was fixed in latest or this is expected behavior

Thanks!
Mohamed


