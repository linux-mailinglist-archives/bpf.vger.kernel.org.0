Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCF5BE937
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiITOnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiITOnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 10:43:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A2543ED;
        Tue, 20 Sep 2022 07:43:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E0C843200A9B;
        Tue, 20 Sep 2022 10:43:06 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Tue, 20 Sep 2022 10:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663684986; x=1663771386; bh=b2NLgxbKTa
        U2l5yP5VXesj/Hv+T6knC6w277DZ3PdJA=; b=ih9ZoJHo9YEylOAnCcyOV5AWOK
        aKbXcUNOo4djhqP0JssSm9mFG1oJsWVSzqXSYsnq+luS4swJhxOMCM2zxsDQFgiS
        ncFdCXyR25YNVP/x3ImcAhGJKyIi/LqcYsB8jUB9sbC7iyWe4lstGu/5SsrYfAg1
        YIddBpOXXW1JsMQIWXe7BQkABkzU6hBJKX9xhSUKSJxwu6oOc1t+kkZGrQStFe/z
        wwb0t4cenVjDY/C6Mfke/3ZNnOjjN6ss5kfcafuvoK7s5DJuJcvJ5Sz+GQ8xJy2c
        6oGqrIBkDIf6+laRqhexs/ZLAOOE/vdBy4ebyiqwR2CPWdJKZK8FgQAhAbyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663684986; x=1663771386; bh=b2NLgxbKTaU2l5yP5VXesj/Hv+T6
        knC6w277DZ3PdJA=; b=vtKXxz+TRdNO6vZUGcoMywyPDZVHvxLVbR4ALCX+kNyk
        zt7L04kMWLLX6Q+BfKZF0ftn8Ihaj5SO1v0UqJKqk+GVTEAKnb4wCl9YX0KtTr1l
        /1GnvkjnzUvOprS+88gwuR/sg31hcqwjXS986lxrlN3kL8gwhf5eN/BBBYJxoQL9
        5TPLbZ4UUBoajIwxuyReLl+4ADXGnEayoZcNoIca8KVVETTBFNAeK8z6gsmupk6s
        pfKbvkwHNz4HsKGoEFNxYmVaO23YHQ/JnSza0pMpXOv4umOKxiHd7cFRFYwlIDIq
        MjUKoOG9cap8nhtrf71IUUEFGeMVqfWtT2v4BoQZfA==
X-ME-Sender: <xms:edEpY9UCEJtBUUVB0GO6X2RNy54fsRdl_zx21xd-w9QEKxTf7Why4w>
    <xme:edEpY9murgI72Nfu6q-H-iwLaeY397XZwQFlHixqw83SA5LNAdL9ZWhOEezSnIH5N
    WDwc4tU9zm7paZoPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfnohhrvghniicuuegruhgvrhdfuceoohhssheslhhm
    sgdrihhoqeenucggtffrrghtthgvrhhnpeffteegfffgffffueduiefhffeufffgleehge
    dtleelgefgfffgveefkeeftdffleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:edEpY5bA42ppEheW6rRmDymHpc7ZB5Uui1Wxt8epQrme9N1jCo9qkA>
    <xmx:edEpYwUwKwXT-fm8LaQIpU8sY0u8O9mmCdY-FxpwhqjSpIb8ngpYBA>
    <xmx:edEpY3m0Z9cit3h2KbooAVlM_2UniBxt1AC6wlFEZ-AGVfWaUSfIGA>
    <xmx:etEpYwAs5EotP83TNIuRrq_nhIHuFzHDsDgx1rXS9gjdPasni_pV2A>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8C06415A0087; Tue, 20 Sep 2022 10:43:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
In-Reply-To: <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
Date:   Tue, 20 Sep 2022 15:42:31 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     shaozhengchao <shaozhengchao@huawei.com>,
        "Stanislav Fomichev" <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 19 Sep 2022, at 11:55, shaozhengchao wrote:
> Sorry for the delay. I'm busy testing the TC module recently. I'm very 
> sorry for the user-space breakage.
>
> The root cause of this problem is that eth_type_trans() is called when
> the protocol type of the SKB is parsed. The len value of the SKB is
> reduced to 0. If the user mode requires that the forwarding succeed, or
>   if the MAC header is added again after the MAC header is subtracted, 
> is this appropriate?

We don't require forwarding to succeed with a 14 byte input buffer. We also don't look at the MAC header.

I think refusing to forward 0 length packets would be OK. Not 100% certain I understood you correctly, let me know if this helps.

Best
Lorenz
