Return-Path: <bpf+bounces-13697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1F7DC6E4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 08:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BA0B20F23
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36110797;
	Tue, 31 Oct 2023 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4pNF9cp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6375D2F3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 07:05:59 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF7D8
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:05:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso87473757b3.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698735957; x=1699340757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qqGrncn9z2siXQej+XDHf24Ibd6ZoQA9m8HlMMLQeA=;
        b=E4pNF9cpVKsLCV8RqNLMVA4Ah8sfPKqeXypmXkzvMSNhR7pNtVtkTBe8hPQPk5yfAi
         /GelG2BKDfknGKSJGeHFCoIji/RrZznsvMGQcq/39vaXt6XDfYvC5CWz3p0qaw7Q5p2t
         Vhg3IgOKDLMCkDWDqSpdwW+kFpyDPnAaDA57gnkUqum9FMOonk0xBHa+axNBNdZDNlHa
         oC51/y39sM7oJdooomRPYlUoTe2xfD6JWbiOusk8DOrcRrJUg62y+mdqbuOx+4DpQnck
         IpNdDGgrANe4Aihujpcs4qDzQJa8mjFdD6wEd1TACE9VRd8jBiLChUapUimHmGplUFxS
         Bs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698735957; x=1699340757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qqGrncn9z2siXQej+XDHf24Ibd6ZoQA9m8HlMMLQeA=;
        b=TVoJfm6QK3FIujxGXSPj+IJjps0IUKpGD0dUAx1dFsOxwqxBUHdiDXtzbny5iwswlM
         xSbnQ1W1wJwJch1SkNTLLlYviotpL2bmvs7QIafYJPM4zOgZIuGmdJxCQmL/eE7nyJtr
         QRC/DKJvYYsQ1oYfzQWnT+k0Lw/czb81+21yTLoqCpHRSJGJL9kcmzm22wAcpMhDpx6V
         H/uHomwFzY9Bl0iV5YeyS6E6lgltDNcIpZqnWODXJZa/yGRFdNpdkDqa1VXDG3EfoIuA
         1VuMoW2XshmA3b9f/Iu0UCMyOfNIH3alR31xnHHh8uo81B+d46FJ/6hxFnUbqfqUqpSl
         DDiA==
X-Gm-Message-State: AOJu0Yxx2ByDiZYvKOda0Sz1kI8foOEusGvsIvvbQDd9f1ujoeMi/laF
	g0K5mWRtOpw0UQNOPtTHv84apQH6YedpWwA=
X-Google-Smtp-Source: AGHT+IGeTB41EBMZVDThUiRregw55h2jTQnwYYNdAgFIlhpok596/J7uFljMgXDr/akkVeaXU4OUrOd5mjZ/+uQ=
X-Received: from nrengaraj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f4e])
 (user=nrengaraj job=sendgmr) by 2002:a0d:d5ca:0:b0:5a7:afd5:1cb1 with SMTP id
 x193-20020a0dd5ca000000b005a7afd51cb1mr246311ywd.1.1698735957697; Tue, 31 Oct
 2023 00:05:57 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:05:56 +0000
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031070556.400813-1-nrengaraj@google.com>
Subject: CVE-2023-39191 - Dynptr fixes - reg.
From: Nandhini Rengaraj <nrengaraj@google.com>
To: memxor@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, joannelkoong@gmail.com, martin.lau@kernel.org, 
	void@manifault.com
Content-Type: text/plain; charset="UTF-8"

Hi,
This is marked as a fix for CVE-2023-39191. Does this vulnerability also affect dynptr in stable kernel v6.1? If so, would you please be able to help us backport the fix to stable kernel v6.1?

Thank you,
Nandhini Rengaraj

