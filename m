Return-Path: <bpf+bounces-10454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7D7A88D0
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46D928279D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB03C69C;
	Wed, 20 Sep 2023 15:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DF38DEB
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:46:20 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAECC6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:46:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fcc860911so14952675ab.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224777; x=1695829577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fugOWHrPqq1busnXecRWMqe+THndaqYOsufFWS0Xqow=;
        b=JrupESA3ifvWrubYV4GaRMBLb209sViz42Zrd1mJglX/XM2oDgOJDzEeGJAQWV4L7s
         dgmYUHFYb4hV0DC9J5fnLgfIEsgpKL11Ax+2PPzJB2Lqpw4bm4YKqjQhRxP2lOWa59sM
         pqm1eeXnfsXTzyBQx7gaSpXPO/QdjFBu3oS2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224777; x=1695829577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fugOWHrPqq1busnXecRWMqe+THndaqYOsufFWS0Xqow=;
        b=CxlzO1JwH1fXV2fnLr/58uT0+xaiDCNs94Mw9FPFXdPLRhhlzXDx7lCViyVzbb/evb
         2xHWIdRB6AtVim7kRHXB7mvl3yiu1KXgQGQg5bSdkjSX+yIg0e3STLaVSxZbqkKxY9Y8
         Zvgsk5Z5+Rint+HRDJNznew5IJKnc2lqCIm31hdVGsmK1DCASzRls+P63gjW6MW405bE
         e/b92FLFiWFbsQoITA4weQ8p8F3OtzD0wG02Fp6DVm4NQu8vIUiwuoq8JD3sepWANCcb
         4OaNU08T37JNOCFo0kOus1NAFCsjEeZAouAAGvNykGZfGjaAyDlowpIrVNzFH6ytfJYa
         pu9Q==
X-Gm-Message-State: AOJu0YwwPY1HBTR0DbDY+jIqQbUbFyvW5K/V1Smdxky5TC/hiQVcvJ+Y
	gx3BdhYPxZjVlGd2ePk0eYj/tCvQfUTQyK9NN40=
X-Google-Smtp-Source: AGHT+IFNi7xEOtVESqYkfKhRk1H3VLPk+u5Ua2QxRGgB0mvHwWoPITpdMvyjyUj4hoHXqz+zpMnY4A==
X-Received: by 2002:a05:6e02:ca9:b0:34b:ae46:8040 with SMTP id 9-20020a056e020ca900b0034bae468040mr2753947ilg.5.1695224777631;
        Wed, 20 Sep 2023 08:46:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j16-20020aa79290000000b0068fb59a16edsm10737385pfa.175.2023.09.20.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:17 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:46:16 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 1/5] kernel: Add helper macros for loop unrolling
Message-ID: <202309200845.76E5E48002@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-2-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-2-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:24:55PM +0200, KP Singh wrote:
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
> 
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
> 
> As an example:
> 
> 	#include <linux/unroll.h>
> 
> 	#define MACRO(N, a, b)            \
> 		int add_##N(int a, int b) \
> 		{                         \
> 			return a + b + N; \
> 		}
> 
> 	UNROLL(2, MACRO, x, y)
> 
> expands to:
> 
> 	int add_0(int x, int y)
> 	{
> 		return x + y + 0;
> 	}
> 
> 	int add_1(int x, int y)
> 	{
> 		return x + y + 1;
> 	}
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

A handy bit of macro fun to have. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

