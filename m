Return-Path: <bpf+bounces-16520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A653801E5B
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2D71C208D9
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C82110D;
	Sat,  2 Dec 2023 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TZmKRvGR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761EAB
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:51:53 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d34f8f211fso32092557b3.0
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701546713; x=1702151513; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVX0qvTOmorhdO0DNiBrTIQzItZCLgg4Yy6zAZ0ixYo=;
        b=TZmKRvGR0wWIvVw+aJcnhq1erZPPKlJf9A2UHEKnvkt0ujc5GVaQJivUWh4YWC+Uz5
         TaGCnbEcZtrBNEcxMu3tZEXnrALumKpZQ0ucYddQM+2jGU8qxcQuHWrHyuwTSGiHx7RO
         Fxxlcu1ZxW2HSejjT9K1YUtc1FoqC69kqaeE05H2pPMzJTZ1cYAXeoM6xvEscqSRgfRr
         hf0Sv894R/4Qan9imK23/cdHVvSBOi3p4DWCgQ+ui8geZhheW4cN+D9GnMZy5HYXv7sp
         T6FgLNF5dZuIRNLkC/bl/4Oirgd93Lxk9p0SawQBWsFKrp77ToVc2GZjcIud23+8bRko
         ynoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701546713; x=1702151513;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVX0qvTOmorhdO0DNiBrTIQzItZCLgg4Yy6zAZ0ixYo=;
        b=XAVkVIZjqidzHWMvyf6EJUdV2XZWso0nJe4Mb4H1oeeGz2qi9JMqUGfj1p+rZ0G3BQ
         k2QLuaTZRPaWcLiyBP9VAUHGuaU/LJNIntJpkfVMOP4YS1afB/fWPZUbv4PzTbwh1imU
         fepmXv5EnhFju3l+7MJam10qTpzs/sKn55p1hpzrLt22K9Mqaqi4pl2PV5DdaNavbBqi
         qpWmGbtEIOsTe/75ms7nvfShleKy/uLE/IYp8HvXqI1fhAG245/5cNJCjhup9XZIY8DV
         W7iJ8OlZQbfGdEkISfeg3TtmNCs6/yhlS7aSpFb36zUgjdzNvFoMmZV5H25Qr6sPNtTW
         e3XQ==
X-Gm-Message-State: AOJu0Yx3ZkZxqJEPlSsvD/NxhIMLifvxp21+bVcYAw2+9rylDlobbc0h
	vC8Ktz7mu94oQ0+mRW5imr2LFC+wSuokcA==
X-Google-Smtp-Source: AGHT+IG4/2gJaqctvwdym2R1wwATk2b95a9iMCUDgEUJsYYRU3riRtJxCKeKk7vYK/Xw6/nUgO1NQA==
X-Received: by 2002:a0d:cccc:0:b0:5d3:c436:b05e with SMTP id o195-20020a0dcccc000000b005d3c436b05emr1307770ywd.25.1701546712682;
        Sat, 02 Dec 2023 11:51:52 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d125-20020a0df483000000b005d7993a2675sm312658ywf.31.2023.12.02.11.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Dec 2023 11:51:52 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <20231127201817.GB5421@maniforge>
In-Reply-To: <20231127201817.GB5421@maniforge>
Subject: BPF ISA conformance groups
Date: Sat, 2 Dec 2023 11:51:50 -0800
Message-ID: <072101da2558$fe5f5020$fb1df060$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdolVnQZkE/iSEhRQEGd1bBxuSER0Q==
Content-Language: en-us

From David Vernet's WG summary:
> After this update, the discussion moved to a topic for the BPF ISA
document that has yet to be resolved:
> ISA RFC compliance. Dave pointed out that we still need to specify which
instructions in the ISA are
> MUST, SHOULD, etc, to ensure interoperability.  Several different options
were presented, including
>  having individual-instruction granularity, following the clang CPU
versioning convention, and grouping
> instructions by logical functionality.
>
> We did not obtain consensus at the conference on which was the best way
forward. Some of the points raised include the following:
>
> - Following the clang CPU versioning labels is somewhat arbitrary. It
>   may not be appropriate to standardize around grouping that is a result
>   of largely organic historical artifacts.
> - If we decide to do logical grouping, there is a danger of
>   bikeshedding. Looking at anecdotes from industry, some vendors such as
>   Netronome elected to not support particular instructions for
>   performance reasons.

My sense of the feedback in general was to group instructions by logical
functionality, and only create separate
conformance groups where there is some legitimate technical reason that a
runtime might not want to support
a given set of instructions.  Based on discussion during the meeting, here's
a strawman set of conformance
groups to kick off discussion.  I've tried to use short (like 6 characters
or fewer) names for ease of display in
document tables, and potentially in command line options to tools that might
want to use them.

A given runtime platform would be compliant to some set of the following
conformance groups:

1. "basic": all instructions not covered by another group below.
2. "atomic": all Atomic operations.  I think Christoph argued for this one
in the meeting.
3. "divide": all division and modulo operations.  Alexei said in the meeting
that he'd heard demand for this one.
4. "legacy": all legacy packet access instructions (deprecated).
5. "map": 64-bit immediate instructions that deal with map fds or map
indices.
6. "code": 64-bit immediate instruction that has a "code pointer" type.
7. "func": program-local functions.

Things that I *think* don't need a separate conformance group (can just be
in "basic") include:
a. Call helper function by address or BTF ID.  A runtime that doesn't
support these simply won't expose any
    such helper functions to BPF programs.
b. Platform variable instructions (dst = var_addr(imm)).  A runtime that
doesn't support this simply won't
    expose any platform variables to BPF programs.

Comments? (Let the bikeshedding begin...)

Dave


