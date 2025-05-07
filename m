Return-Path: <bpf+bounces-57715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72305AAEDE9
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 23:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAF71BA8F2F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36AC2040B2;
	Wed,  7 May 2025 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCdFvXaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0623DE
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653454; cv=none; b=T5IkMN/UovMmyvgNbSsaKy0p1Pf3XPmLvQS5wh2ncoqdHfgvV/bDuM2caoTYIZY2hmv0dDb/Q7iEwmzqBXIkhWxS2HJOTeink+XaHThCXxFSQVeBaItwjI/2HluydVVsZMex1kca9gFjssc6qOos/gNgKLldNFq3nL8aee+weYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653454; c=relaxed/simple;
	bh=al1tSQnbe8goX+rnyBPk9zdbefwDs8Unyc8hKbgj6Uc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WBPqJs7mj4Qi5UY+4IYk03Nevororjx7finlqFyrZ27TjRH2WXNUjnIdIyfl3UtRalRjNbCSwgYRp6RMVBZT/Kmw0qTwoVq2HUYxDn9W2y5xLL0JrQiYMyE0bQ3gdRMyubXvRuvuVc8lKbuxDjMffNv+6ka6BuWOHVrYBUoQteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCdFvXaF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f5499c21bbso6432956d6.3
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746653451; x=1747258251; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OHdHT6sJbThl3pfYyLFv/2Hv99pNOUYCOQlGojSpGng=;
        b=kCdFvXaFoRGIdB3iEjSbfxNBqbJKhT/tyamYoeW3SA/a+lhiK+Ono/OgggIxrspu9P
         7AXWwly1H+O3lDNnU6hj0UMrhfYANGR1DldxWOcQxO/yeqQW7I7ZzfTajdOAdKjOKsbL
         tWw4gh1CDLbdFjdnTnRyVeBidixu+HYotcfvsh4N7IGx6pIf3QLDWgnaeuDdOrvBC1zS
         ibDR37+KliC1OoqOeIZfhdRVfuCXyL0kUNE8Nbt5aC32iplGP3G6h/eLU1Dk5V+UBl4+
         l4yPfoE7WZuS3ecRrVhJjOHlnVkYXzl5zUUubNzqRt8nGdrvM/PjRo1N88KM/dAQdaHh
         E6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746653451; x=1747258251;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHdHT6sJbThl3pfYyLFv/2Hv99pNOUYCOQlGojSpGng=;
        b=Hts7o6AF8VePeniwnhuiw25SKuh9JWfSa4znVqEQTi1z6Rytz9sUkvK0MmUmiGstbd
         8P9DJcDZ1tUFiTywQsLIg9jyK3m+5WcpUmx2uEbGTyCaF8M6Z4M4zxmcmxmP2EeqFcyQ
         Z5MxaC3lWgYiD8TMf7QOV7O212taBiLhFCG3L2h+GUQVqQcOJig0nhQtD4F0DuTnbI36
         Qj/+nXOQKZT71WcFmzlxCRF26E2YjJqCoxFlyUdhdl3d1LLFdWDEAP9J+iEnPpFnqoI8
         v749U5HjKQeKUNI023kLM/48VMR1U9dtyEa21FS45GLAum+pmre1fQZz95ptxjL88Hk1
         uWLw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3sKpXvchFzAcOoOP5P8qCxmJnmg3xJYOD0HbxBFc5fa0qtoxXB5FEsOInFUnOyPue4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkubIM0rLmvg6tCzSffe5AyFIOrriIDe5LiYmRXIrPR8w4mtY
	C5j2rWsfoU1A2KVyO1mUzsG7PteiQhNooe3yU/FMN+HAg5DvVEBMyBFp4ewOuLkyUkPDsNJ8oal
	6m9o/fhrlmiSpwZbmbq8jjaadrViD2Qi0
X-Gm-Gg: ASbGncvVeI/hMhmdXFhMtWZgh5jozByBRP9QEAxgcPvCjHz8h7nbLTma9YmsF5MIcT8
	2IQYwqnKqWq7Cl50PEOUnMngULxxzAGnymhB/G8ZAXWqtEwYqgUzkB7/3/J9aFWNHl82lJ7xyjc
	blAxWTRQOaPzkCKhEjR8jZfrU=
X-Google-Smtp-Source: AGHT+IHt1+zx/IBUEMpNCsYMY+Ou6aTB386blQSTuYtECzq9pw7XCvz0jwz83seqBc6ZfkxJtHNIY6oqgDW3AE3/qao=
X-Received: by 2002:a05:6214:29eb:b0:6d4:dae:6250 with SMTP id
 6a1803df08f44-6f542aa3215mr76103456d6.34.1746653440451; Wed, 07 May 2025
 14:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 7 May 2025 14:30:29 -0700
X-Gm-Features: ATxdqUFfQKKYyJauQ7BMy05pT0Ja3iBMbptRZS1m9IGykxzLMmgGsCWcmTFks5E
Message-ID: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
Subject: [QUESTION] Loongarch bpf selftest liburandom_read.so build error
To: loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I tried to build kernel 6.15-rc5 bpf selftests on Loongarch machine
running Fedora, the bpf test programs seems built ok, but I got
liburandom_read.so build error below:

  LIB      liburandom_read.so

/usr/bin/ld: cannot find crtbeginS.o: No such file or directory

/usr/bin/ld: cannot find -lstdc++: No such file or directory

/usr/bin/ld: cannot find -lgcc: No such file or directory

/usr/bin/ld: cannot find -lgcc_s: No such file or directory

clang: error: linker command failed with exit code 1 (use -v to see invocation)

make: *** [Makefile:253:
/usr/src/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1

Am I missing  gcc tools for Fedora loongarch?

Thanks,

Vincent

