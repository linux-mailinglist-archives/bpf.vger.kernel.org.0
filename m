Return-Path: <bpf+bounces-8189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037DE7834F6
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF5B280F2B
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BC12B6D;
	Mon, 21 Aug 2023 21:43:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735C11720
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 21:43:36 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37013CE
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 14:43:35 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58fb8963617so28071167b3.3
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692654214; x=1693259014;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQpZt+6iZ7VAKUTb9sllUFxcWckj48TuZ9Agl+nEWWw=;
        b=pDolk0x7rmx4nrS/5CxaplVQCyYzjmPNoXu8jQvHMq9K2rFVNGmX8rmUa9BO8GB7dj
         E0NWJlq9d84sojvNHJY4kvGKu9+W0qqnc/S3+xwqjIZGHNh//LD55h+dn1tjKaYmXY+X
         TUwfbtYah/XgRer6OLghpiWhIvrMxfyNd9O8/T3k/vaxuWfinq16eqPuZVOKljzOp703
         d1kAQBYR0ZvmGwuBxS3ywiBGfHaA4fsRDjALLnRXVgF60DlSzcAgVKhGg5AEp24CoDel
         14WQADVfnZfQEIP2ul0EXb4j9bVxLKxrhhs/r7vnjh+105Xxx8SZ++cwCtFEZhL4DCma
         bcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654214; x=1693259014;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQpZt+6iZ7VAKUTb9sllUFxcWckj48TuZ9Agl+nEWWw=;
        b=JT/P9LcH2r7eMmokDJRFwnYFLGVHPpXZs/hnOvsIO3idwvHkj6riZ8N7NnfTyt6Ahs
         UPIsSAY0OTQBHYsOr+QmVuSCvn0mx4hQPYkDy2F4qg/6CGg1TkqFG2NNUspswgBeagYO
         yiebv4eW3mgUKoyHke9KNJMLG2rmBChBcXSYdtaM+JmLZJqCnyuu8tIflJjgpxosd+X5
         WXQFaiESnKm2rgnQYGsawXnT2ThLQurVWiEadRCXt35XPsqfbgGC+GMqXtDiuhVMW9ZJ
         Z6xYQf8tR9WHcxCEauROjIeUfc5G4D7LfhWnWBktOGpovWzGuGsO/7PzPpxg84+pq1uq
         seSw==
X-Gm-Message-State: AOJu0YzisLSIWiajTvvqE5FeVmYunhc068EkcQZ464KjIDTfAWySJ68O
	mYL1SFKTOQppXLIGU+zJGkSXVnoWNi0=
X-Google-Smtp-Source: AGHT+IHgHRnwqvCNZSK4pBU3Mp4poY/hi74WB0qzBp7lz8p3QBZkjp0tva+t+k0sotaYdLYuLRB5BA==
X-Received: by 2002:a81:8882:0:b0:55a:3ce9:dc3d with SMTP id y124-20020a818882000000b0055a3ce9dc3dmr8123801ywf.13.1692654214041;
        Mon, 21 Aug 2023 14:43:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:982f:a154:4b04:d454? ([2600:1700:6cf8:1240:982f:a154:4b04:d454])
        by smtp.gmail.com with ESMTPSA id b16-20020a0dd910000000b00577139f85dfsm2436313ywe.22.2023.08.21.14.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 14:43:33 -0700 (PDT)
Message-ID: <e067ae2c-b22b-3452-8442-45ff1b431d72@gmail.com>
Date: Mon, 21 Aug 2023 14:43:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Rosenberg <drosen@google.com>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
Subject: Enabling the registration of struct_ops types through modules
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I start to work on a new API that empowers modules to register new BPF
struct_ops types upon loading, and seamlessly clean them up upon
unloading.

Daniel Rosenberg shared a patchset on the mailing list about FUSE with
BPF last year. He also gave a talk at LSFMMBPF earlier this year, where
the need for registering a new struct_ops type from a module was
discussed.

I'm unsure if anyone else is currently working on this feature. I'm
sending this email to ensure that those involved are aware of my
activity.


- https://lore.kernel.org/bpf/20220926231822.994383-1-drosen@google.com/
- 
http://vger.kernel.org/bpfconf2023_material/Fuse-BPF-LSFMMBPF-Presentation.pdf


