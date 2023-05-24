Return-Path: <bpf+bounces-1169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3A70F86C
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495DB1C20849
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70718C06;
	Wed, 24 May 2023 14:16:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411918B0A
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:16:17 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD706119
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 07:16:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7748ca56133so4714739f.0
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684937776; x=1687529776;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiOLRIi3DHfMDnXvxWOJoB40jJavD8Yydt2FXOwoBZU=;
        b=e2DKdPlooJHrLrUxwNjplTsZN6eiBscHOUxA7JOdrqIcKIDUT9VeoqzPO+QP0HPGOy
         BWsNw6abVGVIDqoHPIo+nONiMbUGW9of3+8al9q6OR+jpuTk9E0y6vUI2C5kMzijiuOn
         lfo3/swYsXRKJfsoE3TQkA6orMYgDAS9YL1T18bF9i2VXhQ7sEWakkPPyv6bxz767uo4
         hJo5YfEWUICWt2QyVqVegDSssRRTlv53Po8UqgOqgeNNVIcU+Z2Lol4HszqsvQ5Jhw4f
         OvuRuhHrCtah/TDofElxtUBE+KWrQoFJrqjHHW1533sh23Gp2mq/HaOa1hqRhmXQyO1M
         SgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937776; x=1687529776;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiOLRIi3DHfMDnXvxWOJoB40jJavD8Yydt2FXOwoBZU=;
        b=knWO2gNfB0RLSHeVYkZH1R2V3rQMb5XpHRYxPrBtmBuqpOQe/fB+A03pGEKsrP0/Ol
         jFf/UtLWEYhktiLCU+EZKbeJBZg8acbkFqKYfTR40lmEKkOL7sZpmEKnG2saeuvtToXS
         dWDV2hN2DTfNehZ2j+AlNqSeE8FM/Vsk4b2J1sTim0+0XSTJZgSwBP4CL5YZaGO0D2PM
         fMFHKsk0KihlKDd4WsOo2CO3ea+O/DIGlBicrpJYn98ibFKU+9YdyFyjQ2fpt+jaki6B
         LrhZXgA+8eOwk9rJAzMYlzITMrA7ARGMwCnXNyHR6JelMuUlr3UgBt7y493nlpB1NmgE
         2xZg==
X-Gm-Message-State: AC+VfDxEvG2K1RupCc+DHFLMlRaj10SOsWWo1VYRp5iAUHdrk9aBxmQS
	SpUBVChVMRNdnpDKoX68GjfrZg==
X-Google-Smtp-Source: ACHHUZ66QYZkD5ylIRgxYXw/SO2wyAzNV5OzKckqd/kMSgpVwCT6QKbIA50/dE+PvcxRh7gDiqgAXg==
X-Received: by 2002:a6b:3b85:0:b0:774:8d63:449c with SMTP id i127-20020a6b3b85000000b007748d63449cmr1945566ioa.0.1684937776029;
        Wed, 24 May 2023 07:16:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k6-20020a02a706000000b0041cd0951a93sm16376jam.8.2023.05.24.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:16:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
 yhs@meta.com, Francis Laniel <flaniel@linux.microsoft.com>
In-Reply-To: <20230520084057.1467003-1-hengqi.chen@gmail.com>
References: <20230520084057.1467003-1-hengqi.chen@gmail.com>
Subject: Re: [PATCH] block: introduce block_io_start/block_io_done
 tracepoints
Message-Id: <168493777523.545508.7296231125702799266.b4-ty@kernel.dk>
Date: Wed, 24 May 2023 08:16:15 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sat, 20 May 2023 08:40:57 +0000, Hengqi Chen wrote:
> Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
> kprobes to blk_account_io_start/blk_account_io_done to implement
> their functionalities. This is fragile because the target kernel
> functions may be renamed ([1]) or inlined ([2]). So introduces two
> new tracepoints for such use cases.
> 
>   [0]: https://github.com/iovisor/bcc
>   [1]: https://github.com/iovisor/bcc/issues/3954
>   [2]: https://github.com/iovisor/bcc/issues/4261
> 
> [...]

Applied, thanks!

[1/1] block: introduce block_io_start/block_io_done tracepoints
      commit: 03fcc599757cd74dbcf1a5977f9c6497a6798587

Best regards,
-- 
Jens Axboe




