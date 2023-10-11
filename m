Return-Path: <bpf+bounces-11849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92157C4693
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E441C20F29
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A539A;
	Wed, 11 Oct 2023 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/WmXYc5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D9381
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 00:25:30 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A318D
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:24:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60778a3bfso52599515ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983890; x=1697588690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkMbt4JFmtSlUfUc5YRj1RfdWAlOvg8CzC6z2aU7wME=;
        b=H/WmXYc5wLeD6GCUU5yH5W0liVCMjCEkZ519SinlMcVsVwMF3XJdd+P+166jtLXXod
         BRXJ+wo29duSV+FqDpb5WqrkgSUnUfLNsNEeHzUFNnGU+kxcNxBZwsd39GgggJoSNaTH
         KnyXNf89RhBLOB1oCPQzs0xXRnfrnwpKdnfN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983890; x=1697588690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkMbt4JFmtSlUfUc5YRj1RfdWAlOvg8CzC6z2aU7wME=;
        b=EAycVGegtaJ3Tt3lg7huuo+PdAfU8PcApWHuxE0wqb97yW6mWknIibEg0wbNewZnir
         cnOp4KuvcAnrXiJxnoUguq6qaVSdj/Q/jFqCUCCr9bBbkxX/z6DT2lLHlWFZzqXzeMJm
         TjDzt6mS1S8YXjgKXWLEghMrW+7HEFEhYQk7nY6tvT0c1hca+9MKaN/WBjyEwRPnVTOI
         9NKwmHQd8F8SkGUBjb2iCNWEtHnn6vdfGq6SlPC33l970XEhg5MRjsol8fCW7DKkk4HS
         t7B2c/5IbqC4c7RbDWCrLEXnWHrLuRlKxTAEEvfsNhC/SVd4uXEIku+xCF8hhhEdSxkQ
         vMTQ==
X-Gm-Message-State: AOJu0Yxn+5IPAqmK7H7vlWDTWzYbavk/Gh3WfSmknllyfrkUM4E3yclq
	qOs7j/Sgs+F+V8rjQ+RpVggF+w==
X-Google-Smtp-Source: AGHT+IGf7ddXmS08xcp36Zh8uXKutL7OrkQnwSoTTPICtp9fPdkqjS7NSRkkFHEb94c/5QNvI+WnEg==
X-Received: by 2002:a17:902:ce8e:b0:1c8:8d9a:48a with SMTP id f14-20020a170902ce8e00b001c88d9a048amr17314965plg.66.1696983890661;
        Tue, 10 Oct 2023 17:24:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b001c739768214sm12442005plp.92.2023.10.10.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:24:50 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:24:47 -0700
From: Kees Cook <keescook@chromium.org>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
Message-ID: <202310101722.B6D6E6CEC@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-3-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-3-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:40:44PM +0000, Hengqi Chen wrote:
> This patch adds a new operation named SECCOMP_LOAD_FILTER.
> It accepts the same arguments as SECCOMP_SET_MODE_FILTER
> but only performs the loading process. If succeed, return a
> new fd associated with the JITed BPF program (the filter).
> The filter can then be pinned to bpffs using the returned
> fd and reused for different processes. To distinguish the
> filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

This part looks okay, I think. I need to spend some more time looking at
the BPF side. I want to make sure it is only possible to build a
BPF_PROG_TYPE_SECCOMP prog by going through seccomp. I want to make sure
we can never side-load some kind of unexpected program into seccomp,
etc. Since BPF_PROG_TYPE_SECCOMP is part of UAPI, is this controllable
through the bpf() syscall?

One thought I had, though, is I wonder if flags are needed to be
included with the fd? I'll ponder this a bit more...

-- 
Kees Cook

