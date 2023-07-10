Return-Path: <bpf+bounces-4616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B074DC68
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E811E2815AB
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F214262;
	Mon, 10 Jul 2023 17:25:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DD107B4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 17:25:55 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65C18C
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:25:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso5332415276.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689009899; x=1691601899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFtR5Yswn2zIsqAIyfzUxYZ7lIpXaSTx1psXxqq1XD8=;
        b=Yvz/elt/8HhORKMK799Ibn1sDr2Dq9plYlzqq+7JfZAwP/Ecu8JGjv0uk42yktW3X0
         gb2jmQPf5M4psBXrzLoRyZlX10c2mBsSm+Nit4smH1P5gSG8etQu6lLokNXyrBPGddaS
         zgzzamsGCJvpEwO0qkj4EXb9FIzAW4i3rjcfgR5swd1DGVVisKo31MuHjExEJgXsqIex
         W9ldSnv8iw+zeZrGEiqUhs2evRsqWk206i5cFLYa+x8EscJTdlQWmSnu0r4NadwLJBFT
         kIOv0et6JH2aTtJG1CJGYEHJv8nCkwCL0jS2DSnp4bggZv4PF/QFvry4rfo46QjjnohM
         3png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009899; x=1691601899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFtR5Yswn2zIsqAIyfzUxYZ7lIpXaSTx1psXxqq1XD8=;
        b=h19YZ4MHSkKr4jhHf36iwenUXiI3AEr8Wou5MCt/0UIi3rFnjBk/oSqX9YlA1Rpuol
         jW5P3njiTUuX8HfGSzj/tI2NMTIsMt2TU96ytqEr1Mafix8oac0LE7LaMDTSfU0JnJ7u
         bgNvEI6XAe1oe8Q/TauIPVZNThlcMxSUq0L16xDyvzjY9y3owTCHM8UR2PFAXKAmQNkZ
         fglNW3eQkmoga96kcAGZi55g0gFOfsLYYHh+XpyA0PV2WinSkV7ErSGFoKTNPT1L966J
         LzsqeIJbGNBKAlBcV8ACqaufoJX/0OSbF1vdVgf+jeZEXGEkf8hqMEqSJwrEAV8NYtKI
         Odhw==
X-Gm-Message-State: ABy/qLZTN+3EPpodB0/ZXD4RpkYmmWeKEGFj3JZCP2xW8oKz/0kxZZjC
	0lPqY/+1tkAmSXo+peQtOYEn4ys=
X-Google-Smtp-Source: APBJJlEEa2VOrjsQ01outn5Z4Dad68mUZLHGeqsd4BArFPiF9L06bVj/vezdwfgcbq3nUgkeriQMIb0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:508:b0:c4b:6ed6:6147 with SMTP id
 x8-20020a056902050800b00c4b6ed66147mr116654ybs.9.1689009898868; Mon, 10 Jul
 2023 10:24:58 -0700 (PDT)
Date: Mon, 10 Jul 2023 10:24:57 -0700
In-Reply-To: <20230710055614.1030300-1-sanpeqf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230710055614.1030300-1-sanpeqf@gmail.com>
Message-ID: <ZKw+6edWZJoSPGdn@google.com>
Subject: Re: [PATCH v2 2/2] libbpf: fix some typo of hashmap init
From: Stanislav Fomichev <sdf@google.com>
To: John Sanpe <sanpeqf@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/10, John Sanpe wrote:
> Remove the whole HASHMAP_INIT. It's not used anywhere in libbpf.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Doesn't look like it was ever used.

