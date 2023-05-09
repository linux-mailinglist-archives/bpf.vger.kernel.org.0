Return-Path: <bpf+bounces-236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C26FC18D
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209FE2811DB
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59F17AD8;
	Tue,  9 May 2023 08:18:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95C5673
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 08:18:35 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD355AD
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 01:18:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f37a36b713so55757535e9.1
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683620313; x=1686212313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efeMKStGUpycVFL3KYzn846+lLbtXX/MNpZeJMLxyFo=;
        b=LZgUx5kC91jzNo0nrALiIflchKjb7wVF3/iCy0VhRut65T/6wMO1KfkPQQq5i83uh0
         52LiKHfRK2ZWlIYZ5/4T3a1GindmyXIxwB4uQHroWHX3xRydv//C0Dy5eYYihEa6jotV
         ehfmYAm3F0/auHk693ibPYFROVTGGsRxaKCOiY4/IFOpbop8qWHfeZ1jkHoVDd/cx5A1
         /9ld+i1W310JuNlcqOGkvwzrx1PUSE8kJNW3OcwCockd49z+1Rm6oU4AGXwvK09RYaF8
         hRqiqpvwPzKEQH1QrdPAjKC+zXGC4ZGWKlAb0zX16N2ubJdftADiNdjJrQYmU51ygbli
         OQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620313; x=1686212313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efeMKStGUpycVFL3KYzn846+lLbtXX/MNpZeJMLxyFo=;
        b=a5npKtATkcDdy/fCH1ONWjZGafxqnTYBS+X773anPSidVbKFOZ7dLfMQGqFLYINmBM
         Bd0CbhxMjHltm0e0qb90FINPvOJwXlag0W9hGI1ihRt9OAJPmeAEbxLMQFE8ZkLrXzri
         rn/TWUlQTcF6eoTVuhEwoS4qy/f+IaBakIMRx7nXZSwU1O24dcWVr0bs9mYPz7lWnl9A
         XM1gDesN8zb0K5cL9XE9i6DHz7cLjt3enQte2/ORWsMc1qKcmOYanFrJOyO6/wrytTpu
         Nzig16pw85Ualvoa4WkFh8ubLLje7ED75ZgyYyshQa9cJ8noUF5/1/vN5M+YvC4EbDqL
         yNgQ==
X-Gm-Message-State: AC+VfDyzYhBz/e03cdJ9RCujRCSMgs09Yz41yI21zhSsIkhVfGKix+BG
	4jDWfSls/L/znBmP0wxBkNdKjA==
X-Google-Smtp-Source: ACHHUZ5SmOlr1igK00A8IP3uEESLXRVmuDfk3UJUzDEVKoGnEvTyrIzY4vzCKkQtx6uHHLaT4H+duQ==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:2895 with SMTP id 10-20020a05600c22ca00b003f421582895mr5054484wmg.3.1683620312809;
        Tue, 09 May 2023 01:18:32 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:844b:4aa5:8f07:ee4c? ([2a02:8011:e80c:0:844b:4aa5:8f07:ee4c])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm6392822wmj.45.2023.05.09.01.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:18:32 -0700 (PDT)
Message-ID: <a1f6bde7-df60-9254-9fea-09446221b16d@isovalent.com>
Date: Tue, 9 May 2023 09:18:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 bpf-next] bpftool: Support bpffs mountpoint as pin path
 for prog loadall
Content-Language: en-GB
To: Pengcheng Yang <yangpc@wangsu.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
References: <1683342439-3677-1-git-send-email-yangpc@wangsu.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <1683342439-3677-1-git-send-email-yangpc@wangsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-06 11:07 UTC+0800 ~ Pengcheng Yang <yangpc@wangsu.com>
> Currently, when using prog loadall, if the pin path is a bpffs
> mountpoint, bpffs will be repeatedly mounted to the parent directory
> of the bpffs mountpoint path.
> 
> For example,
>     $ bpftool prog loadall test.o /sys/fs/bpf
> currently bpffs will be repeatedly mounted to /sys/fs.
> 
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

