Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551085FD728
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJMJhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMJhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 05:37:12 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348841217F9;
        Thu, 13 Oct 2022 02:37:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0685F320070D;
        Thu, 13 Oct 2022 05:37:09 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 13 Oct 2022 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665653829; x=1665740229; bh=94gmUViEmx
        ZNAoGT1K6i8LMnLlUOVqZvX3qw2bZpGzY=; b=496j8BpNYVYjDufuizPiYKuK3u
        AFk7ktnw6wQnoDLEKjDkcNGmuWlWcDxewSLhGSSZLDFk8NErcPItc5YCF7qB0FyE
        tTRKyUDJcBK7Pg9aCrAH46wsvFSKpTXa8Qjv3C6B7m2IwaXSHkCEWSyN0ind1kn6
        JB+LmF04WTczVcPEv+RpANhPLC48EMp10n9isEkyTJDukuDLSV02MSFQiUOS1j3Q
        zn/hUIb87RCiLyZA0pzZmjKqO9wA2QWMiM+ChflG0DXBcTE4DuLzByHoZTjJrBgq
        t9lwjeV5+urXcw4o6tDCIQHxYGgWcmwUov29VuddB8AsJ/M7DqesqiyqmD8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665653829; x=1665740229; bh=94gmUViEmxZNAoGT1K6i8LMnLlUO
        VqZvX3qw2bZpGzY=; b=dbMuSmN402f2sHIAl0/VYJcMHc5fvNrMERwwxLxZdVpt
        wKPpp8t3x3pLpgae4oGgfs6XPtOcnw7KZAZFCeDAAL/65tzbTQDZLiiOPDZTSvKr
        Av+icqEeRXzzNfAmQpZtu9WzCeggc3BQvRGWcRtIcPBWTPgHWJd5nH7ehdoaWs06
        XhKZumqXSQaSeabp7JWpCCkuxnW8tzwk8Lo+WjWGa+kmD7cXU4+yyE8bmh1J2gQW
        M0GbdXXnlRqPcRHb2Q3EZ7D8YhNtClTn+KPx4KCnYDCv+L8r/qFtA0TfPLyV5UxG
        QT54CpUEmR7BYRqMxTGh5z6Z9WbTb9fQxBoTS41+Pg==
X-ME-Sender: <xms:RdxHY18eLI9tsLljB4YXHWHV2-KVmfVFJfk2irG2m35y9xbh6jdxNw>
    <xme:RdxHY5tknEKBXzDZkmkCO2GArUg0MpeDvL4jf8eUQkESjjHlVe-BGmVq3ALGOOb4A
    PTCinl_pvN8KvBs6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffetgeffgfffffeuudeihfffueffgfelheegtdelleeggfffgfevfeekfedtffelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhssheslh
    hmsgdrihho
X-ME-Proxy: <xmx:RdxHYzBwPv8ro9NwVIwnOwJaDY0-v1jvaNn2arbixoo8d5PB-EjfoA>
    <xmx:RdxHY5dQhBcvsnXhi9QqvDqGwmrXVcOJtk-hYps_4UoXiqgBeseQ9Q>
    <xmx:RdxHY6O-NV3cmEmc-WF3O1lc1BCjFiBP-_EZJdlQLPCfqj1XSV-p9w>
    <xmx:RdxHY3ronHjIDFTt22ku2L4JA5rwtoF-miW8kadUIGpeQVcAAy-lTg>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4EA7E15A0087; Thu, 13 Oct 2022 05:37:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
In-Reply-To: <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
 <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
Date:   Thu, 13 Oct 2022 10:36:49 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     shaozhengchao <shaozhengchao@huawei.com>,
        "Stanislav Fomichev" <sdf@google.com>
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>, bpf@vger.kernel.org,
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

On Wed, 21 Sep 2022, at 09:48, shaozhengchao wrote:
> Hi Lorenz
> 	Sorry. But how does the rejection of the 0 length affect the
> test case? Is the return value abnormal, send packet failure or some
> others?

Hi Zhengchao,

Did you get around to submitting another fix for this?

Best
Lorenz
