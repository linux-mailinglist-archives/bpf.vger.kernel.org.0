Return-Path: <bpf+bounces-7592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BF779574
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF1F281A0C
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA9320F91;
	Fri, 11 Aug 2023 16:59:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D35219C0
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:59:57 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127230C1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:59:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58960b53007so26255407b3.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773195; x=1692377995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=untyu5cPkqSeocr0e7g2AJW7Kz0HzBWNtTUvQZTy5oo=;
        b=5DP5lJFUvhDAbakc42v4F6JhqNfEhtf5706jOwb2pothaFWwWgrdshBhcnAIMtavPr
         y5Z9j14rSov3qH87AxlPd7GF6WPMskGlusDvru9TglXcqpt8Wy/1UoOFApBCg5egEzjg
         Fc6eRoyOMA7Dv4Eouq/dhZLubCTc68v2UhlSzNuLZNSP0RxAGJIP1+p6BHawezq7QUbQ
         mvkR3HSw/Qq+7ZYbVXt8cj2poIsnXH0GoFIB683vBnd6CJemFeGqHL5xMmtiXsV2V1RJ
         9A8WC6whP4mbbnGt6z2O+9Kfe3he3HqXcp0Q3LYsoOrNrgQILYMHKp2t1f8Q4/Ufdxs9
         agIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773195; x=1692377995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=untyu5cPkqSeocr0e7g2AJW7Kz0HzBWNtTUvQZTy5oo=;
        b=S+ZVWm5gZwuN9GABpEcXOLvDPbTOnasgbOctsAObOboteWzyTX9qz5kxJOtFsYu1m4
         eSJwXJJ2/78u1diruhVb/lJwP5RFaEfo4JjpRCa5lvFzvRGmwYBYCRwoREU5qG3Of3re
         St1N4+2mKN6NqeUGNxb97CsyCjzTuTgQFvfxU10eG0ThMs0UTBDzu0usQZ0+JMPg1Rq9
         K3UK6yJmuhIp8vvaBBQW9zcskJJ4aTQI++oscGDbbloUyNyix4Te4kAkVdfi0+HnbHt7
         crFA525Xnlv9r+UgBQcvKCiSeBqOLeSeHGE5VJLNbwlBdD2GF+j1k5AQNaXAxD0g7tzg
         pPQA==
X-Gm-Message-State: AOJu0YwhO28qdDwEv5sBH9xBg9KzvJCjsLe++Lw8DDHeg2rMNhWKYga7
	qvRnSCyXUoSkdFXQksrUKfbh4j4=
X-Google-Smtp-Source: AGHT+IFdOZHUUKKXlMAzPVp6EEK112wR0UOVV5jhW02Fden7yGUp6sTA53QQzugnAjHIrOqphKo442I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4f43:0:b0:d3f:ccc:2053 with SMTP id
 d64-20020a254f43000000b00d3f0ccc2053mr37037ybb.7.1691773195549; Fri, 11 Aug
 2023 09:59:55 -0700 (PDT)
Date: Fri, 11 Aug 2023 09:59:54 -0700
In-Reply-To: <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZNUnxJ26/4QfvoC+@google.com> <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
Message-ID: <ZNZpCqw7YiN7H3mU@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From: Stanislav Fomichev <sdf@google.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, chantr4@gmail.com, daniel@iogearbox.net, deso@posteo.net, 
	eddyz87@gmail.com, haoluo@google.com, iii@linux.ibm.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	martin.lau@linux.dev, mcoquelin.stm32@gmail.com, mykolal@fb.com, 
	rongtao@cestc.cn, rostedt@goodmis.org, shuah@kernel.org, song@kernel.org, 
	xukuohai@huawei.com, yonghong.song@linux.dev, zwisler@google.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Rong Tao wrote:
> Thanks for your advise, you are right, i just submit v2 [0].
> 
> I just found that, because of the modified patch, your email address was not
> obtained through scripts/get_maintainer.pl, so the v2 [0] email was not sent
> to you, sorry.

No worries, as long as it reaches the list I'll get to it :-)

