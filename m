Return-Path: <bpf+bounces-7491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9427781B2
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F84B281A60
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D322F1C;
	Thu, 10 Aug 2023 19:38:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397522F08
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:38:36 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2526B6
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:38:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so1655931a12.3
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691696313; x=1692301113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7mMJ7rTKOWJCear5NMKn/TNGr+m48j8+W5fnEcZRsY=;
        b=njtInBPTla/ddkoQIf6YE+MYOHLXxDkLscpHcyTuXfLZ8X7Pr/hWWRkGfAzoeYOEYa
         CyxMqBqUpIZBMioH2YzEWY2SgpD7hbg93u6at9zTgzICDMOguE8DBMuUMsgxu9TXGyrA
         hCUPxinBAZ3V802Lx/1c0PnwTOPkIpiM/qWKzFPhfkvzFM8pBGZDkUG1pBMdZjVa864u
         KXygtjAc1fK5oU6RfCI+04Emu9/YRDGN2sFPoPfR8zW2gjbuQXljF3XUqHrXyU2IlJ6k
         dQC71lsWxOJbahVYJF0rMfA05WBb7yk34JvObD6xaapFj0AXbruhHihssrA8jJ8x+S6Q
         S9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696313; x=1692301113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7mMJ7rTKOWJCear5NMKn/TNGr+m48j8+W5fnEcZRsY=;
        b=g/2WcqQu2yNiTiQ+Vaeup2/71a41jpehrW4Pd5ZqXtWMx2g7Ixg88VSzsEUckuD2W1
         0h28YBlEqehxqkBfsfFJ7NZTGpiA87aeGTYf5cVsCYKDYAPr2loVBB0ovJI2pgN9kMp5
         T0M8nk+ozVLQl4REq1FSpMgJEDH8sd12CUSwIyJrKo0NdM/GwxSGAcx0HIH0D24gOc+X
         33M/hUXearI7ykk4UMpX7MnXGzeyyKgu63VqTPPmFI9hSkVJdDmATQNfLIKCe7TGNlBc
         vtKIJF8w0cmyygvINVx4GY03cJqQ7dEkaP2vdOA3GqgLIMXWPOVCJ1Uf99gRahHECbws
         a6iQ==
X-Gm-Message-State: AOJu0YwV8VHBtttyzp6osy8P/U7Vlvp/8cHW5p8znZhCrh7hCTWsFzT+
	lWZsgTT5f3ydLGdZpzILKiY=
X-Google-Smtp-Source: AGHT+IHWL0pFkD27NEhh30nymMlLMFNyapeVcp6uebXfc8HNT745GM6BOBVMzATWtI8E5F/p6nfmwg==
X-Received: by 2002:a17:906:7388:b0:99b:4fff:6bb with SMTP id f8-20020a170906738800b0099b4fff06bbmr3028037ejl.4.1691696313505;
        Thu, 10 Aug 2023 12:38:33 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709064a0400b0099cce6f7d50sm1331753eju.64.2023.08.10.12.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:38:33 -0700 (PDT)
Message-ID: <7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, Nick Desaulniers
	 <ndesaulniers@google.com>
Date: Thu, 10 Aug 2023 22:38:31 +0300
In-Reply-To: <87v8dmhfwg.fsf@oracle.com>
References: <87edkbnq14.fsf@oracle.com>
	 <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	 <87a5uyiyp1.fsf@oracle.com>
	 <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	 <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	 <87v8dmhfwg.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-10 at 21:10 +0200, Jose E. Marchesi wrote:
[...]
> Note the same fix would be needed in the inline asm in
> selftests/bpf/progs/iters.c:iter_err_unsafe_asm_loop.

Right, sorry. Tested with that change as well, no changes in the
generated object files for clang. Can't grep "p" anywhere else in
selftests.

[...]

