Return-Path: <bpf+bounces-69583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A73B9AE69
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 797504E1527
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207D313E06;
	Wed, 24 Sep 2025 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBnx+snA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A23043B0
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732231; cv=none; b=QHcqVd9i4U7JmwEhVoXPxaOCEbAOsI2i5REBcjwX+TByqxp/sG8s3EgWqg/4x/Gey+Sgm4nKXAOyIU99imxzDxDbmUu+C5M8kGgBKS7+LbtEyjtsNGopXK03AvsSllq3Zk9vpRgVIAO9iVI3nKZnWzposl6YdDyvEsz9Pf+Yvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732231; c=relaxed/simple;
	bh=MseU3Uno7T+Huxe5/5TXNXeCJNCLfok7bpRdT5iwiuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qr1CigpNLj7a+eju29Jf8ojFkpQlntKiK8f10vyI8AXzk+nA6KU342cd3Ak+CRW6ShtK2I/WkL3g/4BeD281gVKYrNr9U0QAHRpr2FyHefAI4DVI7/+lBZSbQkYiIv8EbPk1D/wYUj/JZGwHSpz/7q0ILdKl0XsICdxiFwDBOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBnx+snA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso51288835e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758732227; x=1759337027; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvG1q5VAcn4UfMB+UlaThR5RtAbaYTyjD7e4k8Uzx8I=;
        b=MBnx+snA4JizOWzHBk4QEmoZbKjahjTnJXp32nT18uKNSTc01vb10F5BM8f+jBbqp2
         3XKLPEs5gQEviJCHWDy3A7rhhWsRepRrOnqjUWTAnszOgj3GaLN2LTxk+oYuVoI0CqX2
         oobRPfm/Yz0D0ZbZc9QLVba1DHyf9UkrBP3TO5aFkNbY5UtTDyO8bgQ7UGx623SEhI3F
         anrBmN1MTq06TbizcBx/1SuAVY21MtRTi+dllnHYAN6s0AAGUzgKKW6so3sJIernxBY/
         foYm4fbZc/YY/MzDriQa7TO19PvU9oTToyaZysNkxeoR8wqIPHz+6plGRQpbr+sdZMEJ
         yYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732227; x=1759337027;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvG1q5VAcn4UfMB+UlaThR5RtAbaYTyjD7e4k8Uzx8I=;
        b=nmhqQSfmPBm+svqNJ92ziFlHNC6Ut73PT768gb5+tUIffFppzUT0m4Hfptjpk6A3uA
         piTipcyao2po4gNUFILHIfUk5jzHtr4p8lZl7uwLqHz6l0JCaPK0XKMwVtPsBEP31kKJ
         rUN29nn+Pv69CzTqfNZNzx/ewfwiH0cc/66QVkCLEB+g8feAG0SHv+q8idZt65s+8v5t
         CgIJgPymlF8DK6G6EH+AfzzdovnSGBv5F3ycf8Mg/No3KEXAPtwrnGLFeMON3Tn7IRL7
         xgk7t8CVPNKFPxGmvgiGS0tU3KGIyH7RyW3CkUaN6lcTAIYmlv4N1rbii/+iqktdQ02u
         lgMA==
X-Gm-Message-State: AOJu0YwUPRLNKcIjJN4WKIZwYS04DB7KaYnHRy0LSqpk9QZ/A/qyUDAy
	Rf6Y37kf3IHQGEc1QTIBchD0L0zQf1jxLNE8QX/2u5ul5oRXddMBGYfxCdk81CS8k8e/h+EfQFS
	HUQeF
X-Gm-Gg: ASbGncuJ/WQiN6J6vTxal5LhgAqAPcEwYdo0sz+xFr0rRUU8pezJKEGtq7Z64rnXPZq
	8pj5Iz4UpgVkGSEbJ294E/gMyFTA4AL0GGKT6fzNOCBvBM/J/30LN9kP6KYqmChg8LiMPbh6fZC
	lTqR/4qQbXLuzDgUi5kltJfPd0TTymZ21XSw2TIRAxmLRzlaSrPTt4l74odU1AUY+Sll2rCTn8l
	JYb4JcVkqCm7I9DoxWMKWsrLjElt72s16Caah6H+tAPuz+EK3YHbpKSHiAHD0c9DttOsBggG4Ns
	6QX1uNf71je8IoBllNFxj+5XJ4ZkcvvOj3em/ngqHoxLKoH29WLO6OXs1XmErKCagSTCypZAwe4
	iVasLIdnmq8FZKf/0l3HgOm0s9yM=
X-Google-Smtp-Source: AGHT+IEXySUnHCJRj+blR0yIhEEqn1vRkbQnZ5cAYioVwURyQt+ZUkndYoqhBe0Fqn8g6+XVam9M6A==
X-Received: by 2002:a05:600c:1c05:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-46e3299ed80mr5606415e9.1.1758732227434;
        Wed, 24 Sep 2025 09:43:47 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2aae3d58sm43152915e9.21.2025.09.24.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:43:47 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:43:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: callchain sensitive stack liveness tracking using
 CFG
Message-ID: <aNQfvqHgUDKjsjDt@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Eduard Zingerman,

Commit b3698c356ad9 ("bpf: callchain sensitive stack liveness
tracking using CFG") from Sep 18, 2025 (linux-next), leads to the
following Smatch static checker warning:

	kernel/bpf/liveness.c:527 propagate_to_outer_instance()
	error: 'outer_instance' dereferencing possible ERR_PTR()

kernel/bpf/liveness.c
    514 static int propagate_to_outer_instance(struct bpf_verifier_env *env,
    515                                        struct func_instance *instance)
    516 {
    517         struct callchain *callchain = &instance->callchain;
    518         u32 this_subprog_start, callsite, frame;
    519         struct func_instance *outer_instance;
    520         struct per_frame_masks *insn;
    521         int err;
    522 
    523         this_subprog_start = callchain_subprog_start(callchain);
    524         outer_instance = get_outer_instance(env, instance);

This needs if (IS_ERR(outer_instance)) check.

    525         callsite = callchain->callsites[callchain->curframe - 1];
    526 
--> 527         reset_stack_write_marks(env, outer_instance, callsite);
                                             ^^^^^^^^^^^^^^

    528         for (frame = 0; frame < callchain->curframe; frame++) {
    529                 insn = get_frame_masks(instance, frame, this_subprog_start);
    530                 if (!insn)
    531                         continue;
    532                 bpf_mark_stack_write(env, frame, insn->must_write_acc);
    533                 err = mark_stack_read(env, outer_instance, frame, callsite, insn->live_before);
    534                 if (err)
    535                         return err;
    536         }
    537         commit_stack_write_marks(env, outer_instance);
    538         return 0;
    539 }

regards,
dan carpenter

