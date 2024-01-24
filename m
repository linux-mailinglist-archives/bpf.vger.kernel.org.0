Return-Path: <bpf+bounces-20192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE44839FBE
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09EF1F2203A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209846B4;
	Wed, 24 Jan 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uxJp/mVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EA5C85
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065199; cv=none; b=G59nKG6sq5WrPV/9c0KnnKz0DkZ7PapufrcRSRvvyTMB9ZpmLfkfn6sXGoV4ZUuunZnTY0pw1/3wqSTuB0xj/2N7iA06iwlQ7c/Re2bSMt0t//bCzqpHSFRcQ9LNcDV7RqDgbm/NHCvhfoUvJt6ehrOd4jXWu5lzOsm4GTUNoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065199; c=relaxed/simple;
	bh=fPXQ85z2dk4ZElnoHE7IKEGnCx5Zs8ywjvfrYfs+rnc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mWSOH/gV2zI0oRVT739J28TMvy971fjSbneazdh/GEk1WKJT1eJWYassuWU7jgbCJPZy60XiG2xk53OSU49wsPIpyRTBl0MbT5u85tIqNfi+A0BUJFUOz0RL8E7SIsSIfJu5vWel43W2bz7+96UMmDU54ce+Q/p4PjMl0T8KciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=uxJp/mVX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6860ff3951aso19887336d6.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 18:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706065195; x=1706669995; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPXQ85z2dk4ZElnoHE7IKEGnCx5Zs8ywjvfrYfs+rnc=;
        b=uxJp/mVXJYZvYcyZpHLegAgJr4hnfl3p5iCCF0HIeEWHV0RxLJXZsrU8SDHMibym+1
         0efFBxpK2QZqQCEgUhX6WnKaOjiIgbysWrOE3pgw5jyVA3vE0C64T/DYrHnRWylKtHqw
         RWXTy5heNCT4ddFhbGBVrhPNlYYQtd33dLGNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065195; x=1706669995;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPXQ85z2dk4ZElnoHE7IKEGnCx5Zs8ywjvfrYfs+rnc=;
        b=tNh9auYSd1UO5bXnYjZKP+hxzOqfOJqEFXinS1Bcrj79/V3w0H3LMAKiffAAuA8hb9
         KnMemjyn7UdLb3XHiheGcsrgo9RzVZeXG62nsy50T4v1RLh03KE8Hgv2wlyp8y5/NnHu
         XugyAwmwUwwgGA4Ji4E/WmngYYcMOni0oa4wcVEBjfzN1rI5Ck7/fd5ftN0cw45rC7Au
         xKALfbHVzLMqO2PzxkX+eG3KdrowYwKtHcPD9NSvHPGc344uF2LjKhQ887hALFSNhJPk
         xzYCebXT0YMT5m5Pwpzk+Oe6nsMvu9JkJyYD6X42FyHbpH8NO/EMl7+zP7LW49ibWNwn
         rgFA==
X-Gm-Message-State: AOJu0Yy8d6V8OblJ8gVq4gbhBamn8ZRvaoEG123tfsP79s5L5a+GLAYT
	TQpr/q+G+gz1cWYaH6ADat3s0RlIyJVNYCsIo/Agwr8oRVrDvUTfFcKGn5gQEknWozH7a7NL1GP
	3
X-Google-Smtp-Source: AGHT+IG44QU/LDIhbmsiTW8NxQHUaWnDU30Dem3QjQRhFIOldFE7nmnnI4Pc+Ds9bCz6CkE8RcX4Lw==
X-Received: by 2002:a05:6214:2a48:b0:686:261a:76a0 with SMTP id jf8-20020a0562142a4800b00686261a76a0mr2165811qvb.52.1706065195477;
        Tue, 23 Jan 2024 18:59:55 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id qp19-20020a056214599300b0068688a2962fsm3018537qvb.29.2024.01.23.18.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 18:59:54 -0800 (PST)
Message-ID: <653c2448-614e-48d6-af31-c5920d688f3e@joelfernandes.org>
Date: Tue, 23 Jan 2024 21:59:50 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 David Vernet <void@manifault.com>, Sean Christopherson <seanjc@google.com>,
 Vineeth Pillai <vineethrp@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Suleiman Souhlal <suleiman@google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Subject: [LSF/MM/BPF TOPIC] Implementing KVM vCPU Priority boosting via BPF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We should discuss a new approach for increasing KVM virtual CPU (vCPU) priority
when guests need low latency. The last RFC posting [1] on this is thought to be
too rigid and baking too much policy into the kernel. Incorporating complex
policy logic directly into KVM seems problematic long-term for maintenance. Lets
discuss leveraging BPF programs to offload more scheduling policy decisions to
BPF / userspace.

Specific issues to discuss:

* Add support for enabling BPF programs to share memory and interface with guest.

* Create a kernel function allowing BPF programs to call sched_setscheduler(),
facilitating priority boosting.

* UAPI concerns.

* Challenges with loading BPF programs in guest userspace we don't control.

[1] https://lore.kernel.org/all/20231214024727.3503870-1-vineeth@bitbyteword.org/

