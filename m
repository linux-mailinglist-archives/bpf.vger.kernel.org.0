Return-Path: <bpf+bounces-37626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E674695868C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2D1F27164
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B55190058;
	Tue, 20 Aug 2024 12:02:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8A190041;
	Tue, 20 Aug 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155364; cv=none; b=riNm6Epu8JbtYeWsNvb4M/GENwd6dRN8fyH4cnrnW0Z85OjTaRY062Cwe4x9XyiVUTD6mArLDu+LRTUtY/gUrFbdz22VXF3heynKJxUTn+fAka4QbjL/sBAXK4MSPQRD5cUNawUQ2qYLllGVBOq33GGV/d++oVq69+2EwrV/FwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155364; c=relaxed/simple;
	bh=zIT0r5oUZ/VoPNhTbfaUL/D1B33WScmcQrjzUJ1gHks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CFnZwJZaTVEj5x/0HRzG6knZ+kD4zPPyZyZTVdMKvHjx+4bP5p0kHqigwtEGEYM5Emjg8xnS0gBd8tHC75TRFaaB1Is2HpkHg/6CXoSOeyadnhLC6BR4rnrYb8MDfhY6az/lmOG+3aHsWOTxCeg7u4hr/cPu3sP3fOluKfUSc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so4243215a12.1;
        Tue, 20 Aug 2024 05:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155360; x=1724760160;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2E0+zUlgLfI+u72KWNPTlcu+1cxyIn6aTgvgxGbIVM=;
        b=c7s9GRdZqvCZK9iCusb3vbXfJh4EoTA49N2CUI7qtmAHGcgoxKDhGB/O0QQtUW3ScK
         K5in5FriIQmrwvt9cDRL7J84qacFPGqjXt/7RRZUXOdunx55qNN3U4aYUf1oj7d/k+W2
         ZohvnKxjtfu34bdzQ318l6ylaXkfSLTLsQu6rbTqrSN2xRv6Co7M3fZWbvUK8XPDcOQD
         McXutNOQJalJ04eP6ooNPSlI9FvKRNdZ9GZRZm3dKZrld7lkyevsKo+FGWKY7SovfcMm
         QVHbeHzIq5VDVVSW1cocbM4jG9jSKN+IGSP7SvYgYUjJE9TxXuFaXkDFLBVhjCH69WW8
         Uilg==
X-Forwarded-Encrypted: i=1; AJvYcCW3E5/ofASTggugVJ7Stxu6I/xUk2qoNJ8Frkt14t74JYzqtFswcVl+XHV5Dl7HbFkYurbrQaQ0gTrgxONkOAE1EBUD
X-Gm-Message-State: AOJu0YyqOKgXe5b21wKGtufzdunnujSJeSxx+r0bQ0CGeDd6XlLDjAdc
	KlgNyhgDErd0CS7HcVg1ZjOt6csc3tkN+DT9JIPYXaMaJ2zFFeWjSGBxYDw3
X-Google-Smtp-Source: AGHT+IHOHRbtr6F5lb+zZ9JJfMEbMa40CcYdo4x4mTnoCremkD6QCDXwcHsP64Ug1s1erexeLg/hVA==
X-Received: by 2002:a17:907:2da6:b0:a7a:9144:e23b with SMTP id a640c23a62f3a-a83928d3597mr922670366b.19.1724155359860;
        Tue, 20 Aug 2024 05:02:39 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd69sm753614766b.61.2024.08.20.05.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:02:39 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so7065470a12.0;
        Tue, 20 Aug 2024 05:02:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlOPy6DowQ37yL1mArM32i4Q9XHvUQRiZr7hCuQAE0WkaoFh3yFTNQBnL0cvQRDmu0aMKomybfP6IbCKd/kJXYLn7c
X-Received: by 2002:a05:6402:2811:b0:5be:e1b6:aaef with SMTP id
 4fb4d7f45d1cf-5bee1b6b348mr5076594a12.28.1724155359128; Tue, 20 Aug 2024
 05:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Tue, 20 Aug 2024 08:02:01 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8=t_cXKsWL0XSx3vF1gsArSWpychfbEf+yjM6wVz3Mjw@mail.gmail.com>
Message-ID: <CAEg-Je8=t_cXKsWL0XSx3vF1gsArSWpychfbEf+yjM6wVz3Mjw@mail.gmail.com>
Subject: Weird failure with bpftool when building 6.11-rc4 with clang+rust+lto
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	"Justin M. Forbes" <jforbes@fedoraproject.org>, Davide Cavalca <dcavalca@fedoraproject.org>, 
	Janne Grunau <jannau@fedoraproject.org>, Hector Martin <marcan@fedoraproject.org>, 
	Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hey all,

While working on enabling Rust in the Fedora kernel[1], we've managed
to get the setup almost completely working, but we have a build
failure with the clang+lto build variant[2][3].

Based on the build failure log[4][5], it looks like there's some
random mixing of Rust inside of C code or something of the sort (which
obviously would be invalid).

Can someone help with this?

Thanks in advance and best regards,

[1]: https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3295
[2]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts/1419488480/build_x86_64/7618803903/artifacts/
[3]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts/1419488480/build_aarch64/7618803917/artifacts/
[4]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1419488480/build_x86_64/7618803903/artifacts/build-failure.log
[5]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1419488480/build_aarch64/7618803917/artifacts/build-failure.log


-- 
Neal Gompa (FAS: ngompa)

