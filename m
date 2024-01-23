Return-Path: <bpf+bounces-20100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3523839546
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC21F2F4D5
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27B811EE;
	Tue, 23 Jan 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UG0iJbJw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8B8003E
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028337; cv=none; b=t42ktFZDw5MV56uPk37VNJMs7SeeSzHFX6WJCflKjQNDjSYQQD8u6PlvXhgbJ+00m1BrvvrpORxvJ+nzdXlFtcHN553tC2GwpQEC9xq9VO5a0VzPjMUxIefYUQUgbkzaPE3zAjL+wfjfDqInzlfZ2J0LGEPPqc6PEcIlKUV7Inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028337; c=relaxed/simple;
	bh=dRFUgGo5pvYYX7PbjaDmbyD1PuEmwTtMqyMUOf26NRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WycwgRgrzgbpDludL3hm1JoW2PvbynKx9kKVrgxUf7BEM3YH22a2H/9y9z1M2IKdhZKR84ray32WmXwLbDmjRmM9AI9TQj6xqAAyxGo3hXenDmXeYtIgr3D8XMn2b10UgYWbsqtAooEr9ZwjGemsv65bzVBdIza97DPk0FsFdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UG0iJbJw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d72f71f222so15475245ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706028335; x=1706633135; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hJeeRlgxsANlNz0Rt6d8ZvxzmvGfpTKOibTWewiQ6bE=;
        b=UG0iJbJwjoTkKhZPdVmcsqqmFG5o+Rbd3UTZYE2WG2wkK3FTlEzVi5n/FZ/yHWKGeL
         1AXMV5FyqZEtlKuPmgHE0TEz8gxe4rloTH8L2eCI+nslOAzIziIZ6OXIPo69GXAykpnS
         ohBDvitUTpBATspqmoRuOuoJ2GVcmAkl1ECshMDujlqCmbziARIqRhtUi7l8mLFYmi3l
         qhAjDoajqHx694pLNA8kxkLSrJUIbRJUKfN958AT2mEOkAyt4XUoh3hurK9DKkhuwN3m
         kQj8LOz5zqaVq0fyijH4WLQtR3AW5cupKUCrN8iqIGuzp1PcMXaddl+9E4YilxdvVOa+
         0xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028335; x=1706633135;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJeeRlgxsANlNz0Rt6d8ZvxzmvGfpTKOibTWewiQ6bE=;
        b=uGD2BaPhe2inLaOz6/p16srhenwjOMPgSxZxH/09bqkhyKU3YT7f5YFRnjOXa/Hzfg
         ra+Y0ELXfsEsaF67VHsSTBOkAEREJEPOkT9UsGQtwztOQvqEIpDSsu8CqCKLeGNNtfa3
         /wRZY+wXmxhmWi0d6PLmKvPhx7WhT3GnOppbggmgweldZ2V4Gpc4dp5/HN7sGKiGO26Q
         BMqqG9yqQWK9O9Rr/k4O3xlM5RMEdgK0j2k0KqV4k4xfGAeUAUFEg9XKoxdasgvQHb5p
         jTZs8N6UusKslCkf6xb81BIX6mM9Y+PdJCOO2yCLQurNhXXyfUJP1lB1ubniEFgZuqH6
         6leQ==
X-Gm-Message-State: AOJu0YwawOS0zo2xwwj1NDtWenYMTmcUnBmp++cU6BPbOIobAgZbGJ8o
	JDwQXTIUm+j5NM5OG5ihGuN0u0hVcnLNJtU0C8o2WAPsX01A2J+i98fjMFizujU=
X-Google-Smtp-Source: AGHT+IH5YOleyWPKHKBftw+0ZioHtNO2oUluCSxlv4Wypt1/y5qBh/9M6rgZ/7N0ez8IC7oUZ9wG4Q==
X-Received: by 2002:a17:902:d2ca:b0:1d7:6e2d:db5d with SMTP id n10-20020a170902d2ca00b001d76e2ddb5dmr1038301plc.40.1706028334876;
        Tue, 23 Jan 2024 08:45:34 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902988400b001d7180b107fsm7618936plp.228.2024.01.23.08.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:45:34 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>
Cc: <bpf@vger.kernel.org>
Subject: Standardizing BPF assembly language?
Date: Tue, 23 Jan 2024 08:45:32 -0800
Message-ID: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
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
Thread-Index: AdpOGXKikUBFay9kQuqigSHEQGpbcw==
Content-Language: en-us

At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).

Jose wrote in that link:
> There are two dialects of BPF assembler in use today:
>
> - A "pseudo-c" dialect (originally "BPF verifier format")
>  : r1 = *(u64 *)(r2 + 0x00f0)
>  : if r1 > 2 goto label
>  : lock *(u32 *)(r2 + 10) += r3
>
> - An "assembler-like" dialect
>  : ldxdw %r1, [%r2 + 0x00f0]
>  : jgt %r1, 2, label
>  : xaddw [%r2 + 2], r3

During Jose's talk, I discovered that uBPF didn't quote match the second
dialect
and submitted a bug report.  By the time the conference was over, uBPF had
been updated to match GCC, so that discussion worked to reduce the number of
variants.

As more instructions get added and supported by more tools and compilers
there's the risk of even more variants unless it's standardized.

Hence I'd recommend that BPF assembly language get documented in some WG
draft.  If folks agree with that premise, the first question is then: which
document?
One possible answer would be the ISA document that specifies the
instructions,
since that would the IANA registry could list the assembly for each
instruction,
and any future documents that add instructions would necessarily need to
specify
the assembly for them, preventing variants from springing up for new
instructions.

A second question would be, which dialect(s) to standardize.  Jose's link
above
argues that the second dialect should be the one standardized (tools are
free to
support multiple dialects for backwards compat if they want).  See the link
for
rationale.

Thoughts?

Dave









