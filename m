Return-Path: <bpf+bounces-12145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286897C87BF
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2F61C20F88
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68719BD6;
	Fri, 13 Oct 2023 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUY58HOn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947118E38
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 14:23:27 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D8BE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 07:23:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f6efd64so248065e87.2
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697207003; x=1697811803; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTL45VjMSVU4cHGu3Jtp+wAr9WA2LFmmIlofii13fNY=;
        b=KUY58HOnNT9o4HghpDlAe8dCNF3u5XmRfNT4n4q8lc1+n1z2pWVvFGo6kw9ZpfWKsQ
         8KiPOWR5PvpFapq5aobrGShHqBuu5cZRhPrxQQQoH3PfevYDeAU6NrXkkF7v8Bo59hIL
         qyryZVinp+oVww4iE8HM6pjfg299arjzgRIJGCjf2CrMXGYppiD6C0cYbQFHsRIc6Oub
         pvddtEiElgiVFACX0lSH6+O1mT0RwutcINVtlmvFXTATyNc/FpEoGyBbZv9KchHcnaAx
         t6L609s9R49srrvm76ycdc9a6qgVTa7vuMaVzNBmrxuDUSSlAcRS39HsJ6g3m8s4bp/I
         gYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697207003; x=1697811803;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTL45VjMSVU4cHGu3Jtp+wAr9WA2LFmmIlofii13fNY=;
        b=CgvgoY+3XozkGvIVZQhRpsNG3XI5ZDmRW2SPwodog0r4qAvaDUvX8DcHVufIzEryiE
         UTGlaiAaDrfHkGHfutXLGFn/na7qQ1yMbQWH9F/TEZADTqYmvU4SfOHvGxAvDRUspsp8
         gMCWcLhIe2lYmlUeTZZ8rVrh2qK5PfTPKQmCHSyYqESQrT/elCwXgSirSzMPLgdTHmgW
         LsqJ8xIMDwB2mZtjGDgnEiV0ascOP8kK8zC/k7qdbl+Ztf4CaWf3avinjBPPPO3mZEJq
         auikoaMd4tidu15K78k5ydxIeH0RdjZUMhKJcQQUBBUjauaIc94RDhrcOQPM4VP1m5uw
         E1Bw==
X-Gm-Message-State: AOJu0YxDWsFDfTR8d5Qs1B5UGTlXLDg/SR7dUROA0UM+lIUflfSSdQxw
	xbzNrNXnhsM/04WCwJnFF5C9DTgjvq2meg==
X-Google-Smtp-Source: AGHT+IGZcYHZrDddhErTe4GZbkeZwc2nwgpPDpPX52mMJYVkFMi4xP+YQI1IKXesDZma8kGivpREog==
X-Received: by 2002:a05:6512:1389:b0:503:102c:7a05 with SMTP id fc9-20020a056512138900b00503102c7a05mr28176871lfb.58.1697207003061;
        Fri, 13 Oct 2023 07:23:23 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24950000000b004ff8e79bc75sm3387861lfi.285.2023.10.13.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:23:22 -0700 (PDT)
Message-ID: <343194ce86ae73695d7591c87816938f1f8e4da6.camel@gmail.com>
Subject: Re: Is tools/testing/selftests/bpf/ maintained?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Date: Fri, 13 Oct 2023 17:23:21 +0300
In-Reply-To: <c73c0e02-4cc8-4927-bc62-dab33bd98ac4@I-love.SAKURA.ne.jp>
References: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
	 <26b213505abeefba2728d238927ddd1907967786.camel@gmail.com>
	 <261bfeec-8230-490a-b583-d52223e2d707@I-love.SAKURA.ne.jp>
	 <5695d6b472d932e7aba4d1f6cbd1a8002642a33f.camel@gmail.com>
	 <c73c0e02-4cc8-4927-bc62-dab33bd98ac4@I-love.SAKURA.ne.jp>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
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

On Fri, 2023-10-13 at 23:17 +0900, Tetsuo Handa wrote:
> Yes, I did something like below and build succeeded. Thank you.

Great :)

> wget https://apt.llvm.org/llvm.sh
> chmod +x llvm.sh
> ./llvm.sh 16
> apt remove clang
> ln -s /usr/bin/clang-16 /usr/bin/clang

I didn't know LLVM has a script to deal with repos, thanks.

