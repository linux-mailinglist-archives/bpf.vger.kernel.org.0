Return-Path: <bpf+bounces-131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D586F87C6
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA3128105A
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65156C8CE;
	Fri,  5 May 2023 17:38:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125F2F33
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 17:38:53 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A309F1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 10:38:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso4011656a12.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1683308330; x=1685900330;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ksdbP6alrqbkiMgUqELbenANh4JrSotycx0G2NsOiWI=;
        b=QKGkGnJZG7re+7fd040H+oCMSVshGsjCeUDgWjiHBQ7PaQ+Ec4YJd+Ipx7m1hamZqj
         JeIhO08NkLQFDPhlew8DaSofsU20qCzyXBK192C5w7XwpPqvapxp8s1cRyoUAngpo10H
         so6yM213D5ErQ3THoQ+Zf+v98v4CPN5i4G5QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308330; x=1685900330;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksdbP6alrqbkiMgUqELbenANh4JrSotycx0G2NsOiWI=;
        b=JlVMSRr3bvBYFLnlCgak4YVBJQr2n9j+I/1UrVarpo631KB/DFn1Lko8A8ZS8QPDBE
         kgY8SLAAP3xwuZL7z1yuuFLEX+M4bY1KykGGkbwuuBXg+gCulWjcu17mSj6BczfvK+65
         ecrNYkP7jSiSamJP5F2wbbw4UjwbC1DNfria2OH3amONzJYyQFYieUUyDSeLz/C1ZYht
         MwYlMsAneERbYc9h+ae3LtV+RbJamf6uCss9IKz2lodYaoOleKDxXJBqOCZieLKG37iL
         LqRWDKfnNr1X513ad8eDRss4a/DIm77z0xssGk1inka7P4lTmJy/3GLQhCqLhjQz7wag
         rmCw==
X-Gm-Message-State: AC+VfDxy+hVknVXjpVfwT2tkJCITqH4Skz5T38Jkns/XDLE11dHJ9oWy
	pKIMgBSVFyDPsFS/2dPDPT9SvA==
X-Google-Smtp-Source: ACHHUZ5A+VnGNTP6oPAYpyhCmaqKQYfmYzQq8W6v3D+q1d1q3+MSakYQopeJG7itTHmzupmbl0dVqQ==
X-Received: by 2002:aa7:dd4e:0:b0:50b:fc7f:b281 with SMTP id o14-20020aa7dd4e000000b0050bfc7fb281mr1997887edw.1.1683308330053;
        Fri, 05 May 2023 10:38:50 -0700 (PDT)
Received: from cloudflare.com (79.184.132.119.ipv4.supernova.orange.pl. [79.184.132.119])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640206cf00b004bd6e3ed196sm3162567edy.86.2023.05.05.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:38:49 -0700 (PDT)
References: <20230502155159.305437-1-john.fastabend@gmail.com>
 <20230502155159.305437-10-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v7 09/13] bpf: sockmap, pull socket helpers out of
 listen test for general use
Date: Fri, 05 May 2023 19:38:32 +0200
In-reply-to: <20230502155159.305437-10-john.fastabend@gmail.com>
Message-ID: <87fs8an0ev.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 08:51 AM -07, John Fastabend wrote:
> No functional change here we merely pull the helpers in sockmap_listen.c
> into a header file so we can use these in other programs. The tests we
> are about to add aren't really _listen tests so doesn't make sense
> to add them here.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

