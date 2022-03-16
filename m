Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69A4DACED
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 09:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354640AbiCPIyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiCPIyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 04:54:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731B27CEA
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 01:53:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qt6so2616120ejb.11
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=NvgUTqVtgWUOFTsgAP3XYX4qyxvUaDUYv7I3OXrHf38=;
        b=SuilHwMMOP/VEXvbUwxVLSPFD5B9ZpB81dG+xl+srKAfK/bVUDMQwvVkJWbqwcB8gE
         D4flw6stwL9Hpno2uFmT8+at16t0bhVEGuRv7IsUoVvQ/8YR/xxo8PiVffDkWrE5m1zv
         iOuipa/DcfH7pUvYYyPr6YY04eWUUsdYNrZBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=NvgUTqVtgWUOFTsgAP3XYX4qyxvUaDUYv7I3OXrHf38=;
        b=HH4Q0zR6+xaPf8Yc8S8v4etI+AIALSLKYbuinV8O4b80Cky0ANeZb39a0tN1iDKTCe
         vLWqXYQu0FEEtV2xrj4sugB+2G+yM/+2R+tFS/auOTa6Dw5gA4s+PkJZw/huJjxGEXud
         ErKg66QPJ2yTuhdeWviV9eT1rTHZNwG8l8uUD1ugKmjnauspIztj+6DqDJfOwf1ijrMz
         j/endjtjHYHYn9GU9mkei777xUGCeavjeF/TjFDMu+CUgiNXryzKpkDNweplNYQ4zy3O
         c46ITPva56W+bUfxw1anKn6ssZ0zB41YWoDsQtOTCYE7wZwa9t2Sq304LjxakZ3FZoZl
         7/uw==
X-Gm-Message-State: AOAM530segszh3q3qjwbzzKq+I84l8hyh2oeb0QpQPjw05yMq4zDEV20
        MFW9GBMVI0joTx0ejlWuH5cyNQ==
X-Google-Smtp-Source: ABdhPJyA6f8csTDLfngXH2GypmC9Y6PgGMvcsN6hh3n5L+FW0iLLhn0iYkd8YDEGY0XX8QmLleZmpw==
X-Received: by 2002:a17:906:698a:b0:6ce:b983:babf with SMTP id i10-20020a170906698a00b006ceb983babfmr26173661ejr.553.1647420803560;
        Wed, 16 Mar 2022 01:53:23 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id ec21-20020a170906b6d500b006d170a3444csm588020ejb.164.2022.03.16.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:53:23 -0700 (PDT)
References: <20220222105156.231344-1-maximmi@nvidia.com>
 <DM4PR12MB51508BFFCFACA26C79D4AEB9DC0C9@DM4PR12MB5150.namprd12.prod.outlook.com>
 <CAADnVQKwqw8s7U_bac-Fs+7jKDYo9A6TpZpw2BN-61UWiv+yHw@mail.gmail.com>
 <DM4PR12MB51501E2FEDF409170BEA3AF3DC0F9@DM4PR12MB5150.namprd12.prod.outlook.com>
 <CAADnVQKasn7ZDM8FYu67FM8FzMyQPqyP=1gYvqaYQBfMkM3pbA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Arthur Fabre <afabre@cloudflare.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH bpf v3] bpf: Support dual-stack sockets in
 bpf_tcp_check_syncookie
Date:   Wed, 16 Mar 2022 09:48:52 +0100
In-reply-to: <CAADnVQKasn7ZDM8FYu67FM8FzMyQPqyP=1gYvqaYQBfMkM3pbA@mail.gmail.com>
Message-ID: <87bky6xoql.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 02:26 PM -07, Alexei Starovoitov wrote:
> On Mon, Mar 14, 2022 at 10:49 AM Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>>
>> > -----Original Message-----
>> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> >
>> > On Fri, Mar 11, 2022 at 8:36 AM Maxim Mikityanskiy <maximmi@nvidia.com>
>> > wrote:
>> > >
>> > > This patch was submitted more than two weeks ago, and there were no new
>> > > comments. Can it be accepted?
>> >
>> > The patch wasn't acked by anyone.
>> > Please solicit reviews for your changes in time.
>>
>> Could you elaborate? I sent the patch to the mailing list and CCed the
>> relevant people. That worked for v1 and v2, I received comments,
>> addressed them and sent a v3. What extra steps should I have done to
>> "solicit reviews"? What shall I do now?
>
> cloudflare folks are original authors of this helper and
> de-facto owners of this piece of code.
> They need to ack it.
> So you have to rebase, resubmit and solicit reviews.

Thanks for pulling me into the loop.

It's just a case of unfortunate timing. Lorenz left Cloudflare end of
Feb and he must have missed the email.

Adding Arthur to CC, who will be able to help with review and testing
once the rebased patch gets resubmitted.
