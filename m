Return-Path: <bpf+bounces-10579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C697A9CE3
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A490E2859BF
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59201BD07;
	Thu, 21 Sep 2023 18:41:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772D8D60C;
	Thu, 21 Sep 2023 18:41:01 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F52C066C;
	Thu, 21 Sep 2023 11:40:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58dce1f42d6so35438467b3.0;
        Thu, 21 Sep 2023 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321630; x=1695926430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofSWuZZY4bEa02tXmv8xlB2YJR3Z2AWM+YX2J2Kxd10=;
        b=mtkZF+KAD5HlJHqOTZ2WDBfGQlhknJAr1lzNrklsP+vcO3mnlwVBil/26YhUFIk1Aa
         RQrj+UaVmcoH+U3Eg00ByPWmtx/sAecBraOESvoFr9oMDSJRQNzD5eGlNcO633VxT/1f
         Q78xC0p272Sy9mW5s/MABIe7yLrBJcBnZBhXegWdJaesCu62jOYs4j0GekYCgbZGkM5B
         +U4icQtgiX50gUjg+RoeRHJQahmejqKPnnehtNCohXqYe6lgJTJ9b07Pa6sYzNdis41J
         F6chWFpburnVk8nTBRFHNiGJzLEPlWc8KgpuONmaVkvEvp7EXCbXFb6qTvAJbnI/IqLu
         dNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321630; x=1695926430;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ofSWuZZY4bEa02tXmv8xlB2YJR3Z2AWM+YX2J2Kxd10=;
        b=uJLy7VQ4ffRRJe1sk2d/aEkT6h1mUXL3f7lwFbCAZrb2cpGsIiOKP0tubHpcrmfODW
         k6K8iVWAyQdIiuchQ709l5mvOy6fyZnN0W/mJJqZM9/5uI2DmKs80gSaER4vDj4gvKi6
         5/X3LbmebnfcWqw1tzHozf1JBDilsyLyobY8kp6xTPJsEDrIADx6qCHBQYTSlSNS41Jt
         TaWittHUA4Q1bqJ83d7vs6OvlvGcS3OOHP8UFh/OpKTpt+6ai/LEOYyFArVdCc6ZhgCk
         ly4psM1TB0b+4W08JoNPCTR/5Yi2HlPFofpfTcR21xLEfmFPuyD3UCFhzXZrYhmEWzTA
         RktA==
X-Gm-Message-State: AOJu0Yww+Yka5tAkW99FO3Qe3JNcTFuGMGaWS/taty3/6F+1d7e4EIwH
	dMtfjA14ohuNQ1iCgetUJ6yWlrUClFE=
X-Google-Smtp-Source: AGHT+IGIJZh89SHkayG95dKRNldnohSO7TVARbXQAfTa6hwHa8apb3a2ZwoBvaHU6riFVfmtkY0FTQ==
X-Received: by 2002:a05:6a00:2d16:b0:68c:44ed:fb6 with SMTP id fa22-20020a056a002d1600b0068c44ed0fb6mr6423829pfb.16.1695271955225;
        Wed, 20 Sep 2023 21:52:35 -0700 (PDT)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b0068a0b5df6b2sm352972pfo.196.2023.09.20.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 21:52:34 -0700 (PDT)
Date: Wed, 20 Sep 2023 21:52:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Kui-Feng Lee <sinquersw@gmail.com>, 
 Ma Ke <make_ruc2021@163.com>, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <650bcc10d2735_7d31e208e7@john.notmuch>
In-Reply-To: <d05b61ca-0575-de1e-8638-9815ad67f597@linux.dev>
References: <20230918093620.3479627-1-make_ruc2021@163.com>
 <dc84f39f-5b13-4a7d-a26c-598227fd9a42@gmail.com>
 <650b34ca2b41c_4e8122080@john.notmuch>
 <d05b61ca-0575-de1e-8638-9815ad67f597@linux.dev>
Subject: Re: [PATCH] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

Martin KaFai Lau wrote:
> On 9/20/23 11:07 AM, John Fastabend wrote:
> >>> pay much attention to their deletion. Compared with hash
> >>> maps, sockhash only provides spin_lock_bh protection.
> >>> This causes it to appear to have self-locking behavior
> >>> in the interrupt context, as CVE-2023-0160 points out.
> > 
> > CVE is a bit exagerrated in my opinion. I'm not sure why
> > anyone would delete an element from interrupt context. But,
> > OK if someone wrote such a thing we shouldn't lock up.
> 
> This should only happen in tracing program?
> not sure if it will be too drastic to disallow tracing program to use 
> bpf_map_delete_elem during load time now.

I don't think we have any users from tracing programs, but
might be something out there?

> 
> A followup question, if sockmap can be accessed from tracing program, does it 
> need an in_nmi() check?

I think we could just do 'in_nmi(); return EOPNOTSUPP;'

> 
> >>>    	hash = sock_hash_bucket_hash(key, key_size);
> >>>    	bucket = sock_hash_select_bucket(htab, hash);
> >>>    
> >>> -	spin_lock_bh(&bucket->lock);
> >>> +	spin_lock_irqsave(&bucket->lock, flags);
> > 
> > The hashtab code htab_lock_bucket also does a preempt_disable()
> > followed by raw_spin_lock_irqsave(). Do we need this as well
> > to handle the PREEMPT_CONFIG cases.
> 
> iirc, preempt_disable in htab is for the CONFIG_PREEMPT but it is for the 
> __this_cpu_inc_return to avoid unnecessary lock failure due to preemption, so 
> probably it is not needed here. The commit 2775da216287 ("bpf: Disable 
> preemption when increasing per-cpu map_locked")
> 
> If map_delete can be called from any tracing context, the raw_spin_lock_xxx 
> version is probably needed though. Otherwise, splat (e.g. 
> PROVE_RAW_LOCK_NESTING) could be triggered.

Yep. I'll look at it I guess. We should probably either block
access from tracing programs or add some tests.

