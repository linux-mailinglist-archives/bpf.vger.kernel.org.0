Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3267ECC4
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjA0Rx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjA0Rx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162037F333
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674841991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKC47YNfQPmpTC1HZekwMO/bf8rZVo8OHet19IfMNEs=;
        b=WqEKBWNrcmdYMC63QTGizxfdQhWNphZ/DfxAnzeqf5Cg9N2Mb2vbtz1ipycy6aIo36Jq8z
        omIIngCaq3zG6KUgBwkIsdt1ByycPlHNnnnUGC0YlWN2BZSD6Ixv1Hqn8qxubT2O7kPsmJ
        nE2aguSYRhTdkF3RxpFOFzt18OfbVSU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-00wUSwKjMpGLR1ACzbRSEA-1; Fri, 27 Jan 2023 12:53:04 -0500
X-MC-Unique: 00wUSwKjMpGLR1ACzbRSEA-1
Received: by mail-ej1-f69.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso3870661ejb.14
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKC47YNfQPmpTC1HZekwMO/bf8rZVo8OHet19IfMNEs=;
        b=hDJzpoQaSVhYmTpQBfpRe1dJQ6iHTKrjkbznE+Pi4Jyw4CWQAp01S7T04//+zNcSzR
         a0LSaAAXd6BEALd7mSNHjcPsgSH0Npk822UAKHSNM/9IxgLkjRxfEIweHtBNCeJWg6u7
         mzXh/ksKWwQ7oqVYUhK8C6184faAUM41sM2rzexd+fULWehrCSAHbybAWjnrTwPifDxy
         OJsM6y9GRggU4ejwK16dRjUqXcZYBUx3rgfGU2CbDwySNxJD0WD4PVuCulK3hUXKnX33
         CFuJOVBExVZrg0mLzn3zYaXNO5YDmsBkly3AudYgwXTeMD/X2B5ySNfI9Az3W3LWAZtO
         cvMg==
X-Gm-Message-State: AFqh2koTCTXgKu4qdWYEorOPZt5U5LLFTJ4AWbzHghNs8Pj7ZY8/Zr0b
        qd+jcih5Yjhig5CV01ChQ0mydCKWCNQEWZ6JUbors6JrQ+OqvllBPbl5qiOaEuypnlczsNpsQrl
        qjnAzqasipqcb
X-Received: by 2002:a17:907:8d16:b0:84d:43a0:7090 with SMTP id tc22-20020a1709078d1600b0084d43a07090mr50279961ejc.77.1674841982779;
        Fri, 27 Jan 2023 09:53:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtz3MxYIlvPyPf9mUsF+PDiLoQbsxPO6j/w9Te366IA2aVOkHxok3btTGqEGgbwfSU12QO3XQ==
X-Received: by 2002:a17:907:8d16:b0:84d:43a0:7090 with SMTP id tc22-20020a1709078d1600b0084d43a07090mr50279930ejc.77.1674841982527;
        Fri, 27 Jan 2023 09:53:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709061d0500b007ae693cd265sm2589832ejh.150.2023.01.27.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:53:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64FB59432A2; Fri, 27 Jan 2023 18:52:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, pabeni@redhat.com,
        edumazet@google.com, memxor@gmail.com, alardam@gmail.com,
        saeedm@nvidia.com, anthony.l.nguyen@intel.com, gospo@broadcom.com,
        vladimir.oltean@nxp.com, nbd@nbd.name, john@phrozen.org,
        leon@kernel.org, simon.horman@corigine.com, aelior@marvell.com,
        christophe.jaillet@wanadoo.fr, ecree.xilinx@gmail.com,
        mst@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
        lorenzo.bianconi@redhat.com, martin.lau@linux.dev
Subject: Re: [PATCH v3 bpf-next 8/8] selftests/bpf: introduce XDP compliance
 test tool
In-Reply-To: <CAKH8qBv9wKzkW8Qk+hDKCmROKem6ajkqhF_KRqdEKWSLL6_HsA@mail.gmail.com>
References: <cover.1674737592.git.lorenzo@kernel.org>
 <0b05b08d4579b017dd96869d1329cd82801bd803.1674737592.git.lorenzo@kernel.org>
 <Y9LIPaojtpTjYlNu@google.com> <Y9QJQHq8X9HZxoW3@lore-desk>
 <CAKH8qBv9wKzkW8Qk+hDKCmROKem6ajkqhF_KRqdEKWSLL6_HsA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Jan 2023 18:52:58 +0100
Message-ID: <874jsblv9h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

>> > > +
>> > > +   ctrl_sockfd = accept(sockfd, (struct sockaddr *)&ctrl_addr, &len);
>> > > +   if (ctrl_sockfd < 0) {
>> > > +           fprintf(stderr, "Failed to accept connection on DUT socket\n");
>> > > +           close(sockfd);
>> > > +           return -errno;
>> > > +   }
>> > > +
>>
>> [...]
>>
>> >
>> > There is also connect_to_fd, maybe we can use that? It should take
>> > care of the timeouts.. (requires plumbing server_fd, not sure whether
>> > it's a problem or not)
>>
>> please correct me if I am wrong, but in order to have server_fd it is mandatory
>> both tester and DUT are running on the same process, right? Here, I guess 99% of
>> the times DUT and tester will run on two separated devices. Agree?
>
> Yes, it's targeting more the case where you have a server fd and a
> bunch of clients in the same process. But I think it's still usable in
> your case, you're not using fork() anywhere afaict, so even if these
> are separate devices, connect_to_fd should still work. (unless I'm
> missing something, haven't looked too closely)

Just to add a bit of context here, "separate devices" can refer to the
hosts as well as the netdevs. I.e., it should also be possible to run
this in a mode where the client bit runs on a different physical machine
than the server bit (as it will not be feasible in any case to connect
things with loopback cables).

-Toke

