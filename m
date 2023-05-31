Return-Path: <bpf+bounces-1550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A8718D69
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45F61C20F6E
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DB3D3B9;
	Wed, 31 May 2023 21:44:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B719E7C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 21:44:50 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE90A3;
	Wed, 31 May 2023 14:44:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53f832298acso101952a12.0;
        Wed, 31 May 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685569488; x=1688161488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8caNu+Z//IMCGkxo6v7uAZBbgdxL0hMk+H8KUvHR80=;
        b=iU4kkVSVjaTrW3zNUeVLWJPzb8/Z9pybDQJewnbN+R4uod9eTpqVQgijkF1M0EZRPk
         RGTNi7GoFQTeUslvEqxaZuR1c0wHJhwAI2P68wRALdiTT293sc6agZMF3QRRk7ebLdy5
         G6y7cVxzaFqNDVNXpA59n72piybf55ATLvbkM5XEaSs4p80REBB5kptyhntKHVwye6p0
         uadU/ZDAE2fZKjYHIche8YpnVPkf0Cpo9od1t5MqaOYWheRq8UCs4r1TVwB7YGFvYKfe
         hYjYpI8dQCRKYE1KwmmZQfcW4m/z+o/u8TnabqjaVRy9CHhm1coBcSbsuBfO70FjW+yW
         hTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685569488; x=1688161488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8caNu+Z//IMCGkxo6v7uAZBbgdxL0hMk+H8KUvHR80=;
        b=MpuaOKMTNPlxRXZOp13WG3Ob0F+b4G2I2zjt6WObom8FoGeCLKd6Q+W8EFw0Hqoq/d
         TfNPgYlCZhnUYV30HFLT6VdCNaoYUPyuS9OKeKRkBnDusiWcGbJgSMIZQqtpWUe+lE8e
         8FvFPSW7wniZXreYHJkw3EWvZ7Y4LyT9TQz/KFumHeEY1BFS6t/ncfIcXck5n+7xSdJU
         vqhPc2CFJmA26QTjUynysml7I/RIX+h2/Rd8UUePJlgWWEaEXmMNB4hMUq0JlAl8kujO
         UQhzzl4EeQC36VidfGfCCaHO+Vniu8wkKc1UpUZipYLVeLsjTkOKaXQIN6Kwn7r4NvIv
         CmXw==
X-Gm-Message-State: AC+VfDyO9whR69wOydmmerjiW2zQUCERb0qzlbIV6qvXbcqCIqvT8PpT
	RA+rc5iuzRfR9k10R+bTitM81fapX3M=
X-Google-Smtp-Source: ACHHUZ6ThzdhIZv/6FdYXGy/LpZxDceL+PruuH9RmuAhEouspIXPJQD2w3dd9IPutJN4Z0eHqB7F6A==
X-Received: by 2002:a17:902:d485:b0:1ae:7421:82b5 with SMTP id c5-20020a170902d48500b001ae742182b5mr5693992plg.45.1685569488053;
        Wed, 31 May 2023 14:44:48 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:a01a])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027d8300b001a525705aa8sm1872797plm.136.2023.05.31.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:44:47 -0700 (PDT)
Date: Wed, 31 May 2023 14:44:44 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	dcook@linux.microsoft.com, brauner@kernel.org,
	dthaler@microsoft.com, bpf@vger.kernel.org
Subject: Re: [PATCH 0/5] tracing/user_events: Add auto-del flag for events
Message-ID: <20230531214444.5dqcbclgycfk3q77@MacBook-Pro-8.local>
References: <20230530235304.2726-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530235304.2726-1-beaub@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 04:52:59PM -0700, Beau Belgrave wrote:
> As part of the discussions for user_events aligning to be used with eBPF
> it became clear [1] we needed a way to delete events without having to rely
> upon the delete IOCTL. Steven suggested that we simply have an owner

This patch set is not addressing the issues I pointed out earlier.
It adds a new flag and new api. It's not a fix.

> for the event, however, the event can be held by more than just the
> first register FD, such as perf/ftrace or additional registers. In order
> to handle all those cases, we must only delete after all references are
> gone from both user and kernel space.
> 
> This series adds a new register flag, USER_EVENT_REG_AUTO_DEL, which
> causes the event to delete itself upon the last put reference. We cannot

Do not introduce a new flag. Make this default.

> fully drop the delete IOCTL, since we still want to enable events to be
> registered early via dynamic_events and persist. If the auto delete flag
> was used during dynamic_events, the event would delete immediately.

You have to delete this broken "delete via ioctl" api.
For persistent events you need a different api in its own name scope,
so it doesn't conflict with per-fd events.

> We have a few key events that we enable immediately after boot and are
> monitored in our environments. Today this is done via dynamic events,
> however, it could also be done directly via the ABI by not passing the
> auto delete flag.
>
> NOTE: I'll need to merge this work once we take these [2] [3] patches
> into for-next. I'm happy to do so once they land there.
> 
> 1: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/
> 2: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn/
> 3: https://lore.kernel.org/linux-trace-kernel/20230519230741.669-1-beaub@linux.microsoft.com/
> 
> Beau Belgrave (5):
>   tracing/user_events: Store register flags on events
>   tracing/user_events: Track refcount consistently via put/get
>   tracing/user_events: Add flag to auto-delete events
>   tracing/user_events: Add self-test for auto-del flag
>   tracing/user_events: Add auto-del flag documentation
> 
>  Documentation/trace/user_events.rst           |  21 +-
>  include/uapi/linux/user_events.h              |  10 +-
>  kernel/trace/trace_events_user.c              | 183 ++++++++++++++----
>  .../testing/selftests/user_events/abi_test.c  | 115 ++++++++++-
>  4 files changed, 278 insertions(+), 51 deletions(-)
> 
> 
> base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
> -- 
> 2.25.1
> 

