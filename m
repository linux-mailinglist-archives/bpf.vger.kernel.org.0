Return-Path: <bpf+bounces-60434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7845AD65DF
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43201BC1B27
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAB1D5ACE;
	Thu, 12 Jun 2025 02:52:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCD28F1
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749696775; cv=none; b=lQ8cxOtDHlu43Ul4F84sgkPf6pxw4VhxHIljbVeiduqN7McczyBYzrSsf+kwDX2pogDoQPGjRLR4ZlIFrOHlj0Sk8Vj7GoNe8KU/GCEZK6SNYsd27JocheHrtkuLkoaldPSAPB6rt3W3cLQ8RFrahndp5qFVTFZ93Aq3HhnV6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749696775; c=relaxed/simple;
	bh=H158XPi9RANcSXiN0lzSeHifL+9udRgVA1GlXPYQCAQ=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=WO/7zHjansxwKo4UxyJDKJfl2KDE1LflVgHdUqJXJOJAs33JheMuKbdUYivQq7xXWEaHsVqRgtYhf3HVuwU6qi/9KBcIC2mbNGZhHfjHERqr+aZVjAEEOb7/Qw6oaqOue95DAX2ZuGmLXz/d6dPzipQUXYDbfpHMGu0xxN5yA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSWr6QEpox2gUAQ--.14101S3;
	Thu, 12 Jun 2025 10:52:42 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxLsf4QEpoMgwXAQ--.9322S3;
	Thu, 12 Jun 2025 10:52:41 +0800 (CST)
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [Build Error Report] Implicit Function declaration for bpf-next tree
Message-ID: <d602ae87-8bed-1633-d5b6-41c5bd8bbcdc@loongson.cn>
Date: Thu, 12 Jun 2025 10:52:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxLsf4QEpoMgwXAQ--.9322S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr1Dtr13Cw15Ar15GryUurX_yoWkJrgE9r
	n2q3W7uF1UWr48t3s7WFs8ZFW5tw1Iqr9Ikw1YqFnxA3WkX3yUCFs8uryfXF1UXr1DGrs5
	t3Wjyry5ArZ7AosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU
	=

There exists the following build error for bpf-next tree on LoongArch:

   CC      drivers/acpi/numa/srat.o
drivers/acpi/numa/srat.c: In function ‘acpi_parse_cfmws’:
drivers/acpi/numa/srat.c:467:13: error: implicit declaration of function 
‘numa_add_reserved_memblk’ [-Wimplicit-function-declaration]
   467 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
       |             ^~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:203: drivers/acpi/numa/srat.o] Error 1
make[4]: *** [scripts/Makefile.build:470: drivers/acpi/numa] Error 2
make[3]: *** [scripts/Makefile.build:470: drivers/acpi] Error 2
make[2]: *** [scripts/Makefile.build:470: drivers] Error 2

This is because the following two commits are not in bpf-next tree:

   commit 9559d5806319 ("LoongArch: Increase max supported CPUs up to 2048")
   commit a24f2fb70cb6 ("LoongArch: Introduce the numa_memblks conversion")

Is it possible to update bpf-next tree based on 6.16-rc1 or at least
apply the above two commits to avoid the build error?

Thanks,
Tiezhu


