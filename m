Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977B633288
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiKVB77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 20:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKVB76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 20:59:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85574C8C97
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 17:59:55 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g62so12999479pfb.10
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 17:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ3xsi3K8ikglpE0LPOmSAkI1KsXboLV/cvaUbRFux4=;
        b=hq2P5HxcMml81Y1HNGMJbTPxDovGrTYG+TyTX7ltdWkFrNYTx0Wt2ngJy68X1adJIs
         CicJiqS+XHvuY4ckoIGYjnhqJ25s8Pm5IG/DOK1kgfpQ0xcxOe8XCsRMdJZm9Pd9eojZ
         YuPWFPj4tFA9lJQ6UVDKmMwWaHm2QDEM9WsnpBpvORd0OQKttQ+ov0q/C4CTqLboyMuF
         /mPke/pK6L3BhTAGJQmuNi1Qs2j+ElZdqgGF6DQVoeLFN0ma0EopHC5TuKVe1HVzhgzp
         NCZDZLApKXoDzYL/gRntMVmtJqwwyX5ljh1SvhMYC6TR/CbY9m4Fah6TRC3oLoHB7GBd
         1gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQ3xsi3K8ikglpE0LPOmSAkI1KsXboLV/cvaUbRFux4=;
        b=p3ij/sQT5d1Ymhxx9v4Ew+rf9YjcoKnpo6RD1esWfRWBIKju1rqUWfecalGGIPJllK
         0eSRhRjjfIDrxOy6dQCJYoolkWpsUcXYG9iV/vEgTT0t0VnFDT/JNVtqFIyROO+OH6Xs
         Wo5cckkkfzUxlOTCcJTKiz8fIcLg0p67FaL6UHdExZNQTvHxwKmxemQ3DIj/O9svRswq
         e4wkLtE6HuD7IXQB5xnYfbE3kZnEPuNn8j+d/+LN9HUBEJV5eQOsfJ+XRl2zVoehX9IZ
         taypCMPDoTQ3ijhyLC2PAQrI4UsRYTz+8Vae8upDUMQxXYVQG/kY+g6f3zFtoGkXpWSh
         bpRw==
X-Gm-Message-State: ANoB5plZSRRkND06v518ohcITQFXOWK3oy9nPx6rJnRT+tOZ+1d4O+I4
        Mfkg2ulAEVS1XtDhNko7X7SkoYiDj+E=
X-Google-Smtp-Source: AA0mqf4M/Y2OXlkFY4cgPlF3CyNjlgBAOIXiFZbkWZ7tfT69tQYDiT1KC9+7pQmn+xqqrtzEIsyL6A==
X-Received: by 2002:a63:de01:0:b0:476:32a2:253 with SMTP id f1-20020a63de01000000b0047632a20253mr4245057pgg.133.1669082394948;
        Mon, 21 Nov 2022 17:59:54 -0800 (PST)
Received: from localhost ([2605:59c8:6f:2810:f4d9:9612:b71b:8711])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b001767f6f04efsm10541957plg.242.2022.11.21.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:59:54 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:59:52 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <637c2d1826988_18ed920851@john.notmuch>
In-Reply-To: <20221121170536.1198240-1-yhs@fb.com>
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170536.1198240-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next v7 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Add a few positive/negative tests to test bpf_rcu_read_lock()
> and its corresponding verifier support. The new test will fail
> on s390x and aarch64, so an entry is added to each of their
> respective deny lists.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

[...]

> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int nested_rcu_region(void *ctx)
> +{
> +	struct task_struct *task, *real_parent;
> +
> +	/* nested rcu read lock regions */
> +	task = bpf_get_current_task_btf();
> +	bpf_rcu_read_lock();
> +	bpf_rcu_read_lock();
> +	real_parent = task->real_parent;
> +	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
> +	bpf_rcu_read_unlock();
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}

I think you also need the nested imbalance case is this
handled? It looks like the active_rcu is just a bool?

 +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
 +int nested_rcu_region(void *ctx)
 +{
 +	struct task_struct *task, *real_parent;
 +
 +	/* nested rcu read lock regions */
 +	task = bpf_get_current_task_btf();
 +	bpf_rcu_read_lock();
 +	bpf_rcu_read_lock();
 +	real_parent = task->real_parent;
 +	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
 +      // imbalance unlock()
 +	bpf_rcu_read_unlock();
 +	return 0;
 +}
