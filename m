Return-Path: <bpf+bounces-7072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4F0770F7A
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513EB1C20AC3
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08549BE55;
	Sat,  5 Aug 2023 11:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5013A94A
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 11:42:15 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B5E55
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 04:42:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d8332f50so395157466b.0
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691235733; x=1691840533;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Y9MNbIt5MMr2JktZgXr7fTuliQI1Ck5YB33zesjx4=;
        b=XiEYqHCjrDcHG55aUzGYQuK1EczndKnWBI6Bhk8PO8x7RmpuM2FSd6O9f0xZIImxnZ
         K80M8YZkYW6c9WOIZ8ATSsDw3fASmOkxR6Z7qj1+eyteH3EMdTfNUDizuWhzHQcep0Rz
         TkQmf7DFK7P6Zua3Od6tNUrwPR/05QVd6Q61Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691235733; x=1691840533;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6Y9MNbIt5MMr2JktZgXr7fTuliQI1Ck5YB33zesjx4=;
        b=A/UY+130Pf/kuVTbZ2IJd2xhqkEa+DEC3mTrj1YsVQNwnxZObaJ9RN4y2Iz1g64+zK
         FnUashWxNPz8hpawV3VU16RTJq8O66kRLSIRzPEgIeHrSlF7DtNmyeMgx/SqWsPSarxX
         Of2oJVy4dUW2DtcSRpP5LrvlZ7H0PKq9Kb6hViM0Fk8UoQnvr/GAQvZiKzF5VvD6KBx5
         EpDloeL38KNnPUuUF7G4F5SmQBA25uy9AfyFjV2F/i61MRc13uU20y9uhMsre32WvIvW
         3GXyaUrzp53gEEcOhQR9dFbGfqW5mmq0Ef6NJ/s3L0lVvlzEcbn8P15XzWLM/EnOYEuG
         3N6w==
X-Gm-Message-State: AOJu0Yyr3MEHsP5az1t5TBgegV6hxLRTgzuZQmjGdSi2VdcHSntbwDeu
	SZ1iVXoKYKK/dFw5z8sqhfSeWw==
X-Google-Smtp-Source: AGHT+IGTs0CwwRaOkTaLx3T6Sd7D3qdIfFpZYkNjlkKWuleOZnLuzPAmjNoBgvkSYFBoriZd9m1OHw==
X-Received: by 2002:a17:906:3014:b0:99b:f8ab:f675 with SMTP id 20-20020a170906301400b0099bf8abf675mr3729947ejz.14.1691235732980;
        Sat, 05 Aug 2023 04:42:12 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b00988f168811bsm2604423ejb.135.2023.08.05.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 04:42:12 -0700 (PDT)
References: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, John Fastabend
 <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Date: Sat, 05 Aug 2023 13:41:41 +0200
In-reply-to: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
Message-ID: <87zg35wwa4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:56 AM -04, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
> both types have member named "progs", the offset of "progs" member in
> these two types is different, so "progs" should be accessed with the
> real map type.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

