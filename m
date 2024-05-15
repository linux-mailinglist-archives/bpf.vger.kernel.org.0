Return-Path: <bpf+bounces-29789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACD8C6B44
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19272862E3
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8F39FE4;
	Wed, 15 May 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5fAH/9A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F5381BA
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792616; cv=none; b=d/kKhSsOWVt3yatS+NF7zw/zYZYMnB/4jtjVyeoiMj8fOAIXguxiRm9FviGLVFZ+fSqqpvBwubDHWVgoJiPx1MwJdPJSMjmDd3hafspvJ9vE2Fw4LC+5yIS+EtPQ9LODKqPIoI0eKMgUeiR5g+Ec9lVLQ2C/KVS/kWJoWH4sQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792616; c=relaxed/simple;
	bh=TKQQScGGSW80RMVVPkNLSS/x2KZgzC5d+z5kNB1T82A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOpB6eRzfynZpedjb0l9SKAUUFPfBmi85zsTF5D/SczIJqiil9Rs12G9ad5C6jtabtsj4ie7578TcDyon3OqNbG7+8pUUVv7AvZ9er+WVf5lJrD4lAlASmMA5J29MV4PGSREHRM4J7i6xP68hDeOnDrMABFzP/RjUamx9KonSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5fAH/9A; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a5a88339780so214550866b.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792613; x=1716397413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYQUvBG7AsY4Zy0RIsKk/tJtuddljbrs7bpvUpgPjBU=;
        b=X5fAH/9A29Ow50QsZuqFlQm9Et2xiNPkXqesmqwCWnNPGE9dgPWzSnV+m4pAubxM02
         00kISbGFPNRcXaKEEpg0D9TStWtwlXHpGSR78/00swOkHfmM/WxiVN2F8IbfMdTVvxug
         9HyWvNS6i/Ir1bLorfJOkYJsppdsW8um63BBjovmCoMEHVysPbn75/j+lAprXo1nPeDe
         VwOnVyEMm5sv5MR7wuSORvVpbcn3M2E6zx/uvVMJd8Fn1XZ0vj7kh5gyPUEPMb1b8wJQ
         xsiijI6JJzgpezm/4G6Evm3ayDrUTLqROPjKnKvcVROWrP6wJpbn6/gLCGHXa+TmoMRX
         L+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792613; x=1716397413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYQUvBG7AsY4Zy0RIsKk/tJtuddljbrs7bpvUpgPjBU=;
        b=mXivwQ3AU/fIlm8hy6lAHWWEDFUd/lS24CS5wg058wMkztEKe8j5o+1szButVsUtoJ
         j471jOVzSf2dIKwCQyZGR31Z8+aGwoPaG5dkpZ4RK1ogevWSG6ukpbdBQOs429LFjaXF
         HyUmOOMns+uPq5aAtmE4geMrG84Rrj5zDQb9aBElCBgMIiY62mIpMHfeuU78I3giDx4O
         bSRfY1jeqE6ZxTUWfPnq8mnil1AKlxrnA1yCT8G9mKP3FoIalIJSrHsDRQsEvSPndoUT
         /Sn4QaUbGuG8d2m8igqB72vFPIecr6xadkcZmkXfMyBqwcsbuDs7L0vk4++/2iAd5TwU
         hqYg==
X-Gm-Message-State: AOJu0YzZU98h3IKATC1uKk0GMXjBZdmlK7gI+kYhTJV3aQXJeDdJcPoi
	crdC9fwYmvOqxNnvwFPKZwH4fOR3jfRiWMWfOlhh4LNWPMZ9QixWPUqI2DqGzASFUXK82vjz3fz
	Grwn1J5B3ZVksf5v/4Q8GKeZmqGM=
X-Google-Smtp-Source: AGHT+IFTe9KjjVso9ihQ3LjFyTaZ/Z6dy3obt0QfZE0KC5R3G7TDSfALVBZ/l3QUbz6MN/q6Gw4zlO7hO+ZbsRifqDo=
X-Received: by 2002:a17:906:490d:b0:a59:ce1e:8541 with SMTP id
 a640c23a62f3a-a5a2d5d14a9mr1036476466b.37.1715792612841; Wed, 15 May 2024
 10:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
In-Reply-To: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 19:02:56 +0200
Message-ID: <CAP01T778YG3sL1BTJnPdOJkqhcNG=zv2dEp1hquUV1+aX+DXDA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Added selftests to check
 deadlocks in queue and stack map
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 14:41, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Added selftests to check for nested deadlocks in queue  and stack maps.
>
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
> test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> 384/1   test_queue_stack_nested_map/map_queue_nesting:OK
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
> test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> 384/2   test_queue_stack_nested_map/map_stack_nesting:OK
> 384     test_queue_stack_nested_map:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

CI fails on s390
https://github.com/kernel-patches/bpf/actions/runs/9081519831/job/24957489598?pr=7031
A different method of triggering deadlock is required. Seems like
_raw_spin_lock_irqsave being available everywhere cannot be relied
upon.

