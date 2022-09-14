Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA685B8723
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiINLUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 07:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiINLUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 07:20:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104A2FFF3;
        Wed, 14 Sep 2022 04:20:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D4C875C016D;
        Wed, 14 Sep 2022 07:20:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 14 Sep 2022 07:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1663154405; x=1663240805; bh=g5
        nrhku7XzOq1sKHPJflx7TIWuD1FqVOgdP2P6w9enc=; b=WsybmA4GEiX2AoM+AQ
        SMLx9NbIM2YpucB2Gyf6h+yyPAoaT+NquJaqqm60VxCsYNFd5numGa98kIIYkN9R
        j4BCw8hBqTUsOT7b7sBZCKU94oSc96qcekYNaGQpDG6UOuxKUS5xB8XNZMjbhgzB
        +jrHH3oDZnJM+WPw22x6Kgvc/r3+tk3qXJCBKITAzskEsNArLR7W+i2SujyRuNdn
        X7MWbINNyL/ECmg0pUGJ3zL4xpwsXT4C2JBMV5U1sj660AxkMVH58qgHwYxRcFqY
        ongOnEZFCMEh/5jSKyId6oSx7e9EwDAo+ff/YQhP+UcMUcZhh/1GvaWUGwUPrV2G
        9XNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663154405; x=1663240805; bh=g5nrhku7XzOq1
        sKHPJflx7TIWuD1FqVOgdP2P6w9enc=; b=boZ1l8ntoCcSTeNPdTmksFTkU15Nq
        meXMrwqbtUlWftVSVsrdsvUKw3OMvGJY6bkD9+9Fni/VFqh0YIZ0/cKw7+JUI61y
        WHK9li6/mp6tbV3F7PKrulAKhxhWx1ENgzEFpFozUpZVc8lXKROIxhPvhzCOGmU6
        rx7myiUIbp18YCR/2yjRzIh82U+CihyJCZqYwTPAXrFNeZl4q0xZzn/0fc5///6F
        KjcUQ0zQDatAKhg68iWrcnEa4iMveqmk2gp2dpBF4nNxKIvhYjFlo3Hes+5W5EUV
        k78N7GTo98aN9aPd3EDmZY2kBU+m9meFgDUAMqDm/cOSI38r5C3MipFwA==
X-ME-Sender: <xms:5bghY8DACsSbbx70DWxK1UC8tlBGzBMkUeqy7iba569P3XadnhXqPg>
    <xme:5bghY-ittppfDZYHnnvW6MwMQ_aoZe1DCqaNl7vE4Tg4zdzB_LzhGC5dL1EZwapad
    dUm7NOrr60QbuDTpg>
X-ME-Received: <xmr:5bghY_nTRnnObcxBRCKViDnrmWft9GOBV9qeevzHLZj4WzGT5elzjHyvjJK__MaUuoLrAj29>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefnohhrvghniicuuegruhgvrhcuoehoshhssehlmhgsrdhi
    oheqnecuggftrfgrthhtvghrnhepfeegledtgeehgeekgfffteeihfevieejhedvudeuie
    euhefgvdevudevteefvdetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrd
    hioh
X-ME-Proxy: <xmx:5bghYyxjCeL_4v9xPOjUS7y0sne7BoixouJJkXX4dE6IPkrIfX9PRQ>
    <xmx:5bghYxSG7H3TPQFOd4_kFJsB_t90kx6eSwesf66cQWA728iIcjybkg>
    <xmx:5bghY9aqgZGQitDD_qROBSv-W3G2AQt1-RqXUgKEpFTCTGJ9Gw0s6w>
    <xmx:5bghYwHWqd5fFEF-DhdZ53hBWC_TMJzIi4jO-wMOsCJdq-Jc_ul8Rw>
Feedback-ID: icd3146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Sep 2022 07:20:03 -0400 (EDT)
From:   Lorenz Bauer <oss@lmb.io>
To:     shaozhengchao@huawei.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sdf@google.com,
        yuehaibing@huawei.com, Lorenz Bauer <oss@lmb.io>
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
Date:   Wed, 14 Sep 2022 11:19:36 +0000
Message-Id: <20220914111936.19881-1-oss@lmb.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715115559.139691-1-shaozhengchao@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I think this patch is causing user-space breakage, see [0].

The gist is that we do BPF_PROG_RUN of a socket filter with 14 byte input to determine whether
BPF_PROG_RUN is available or not. I'll fix this in cilium/ebpf, but I think this patch
needs more work since users may be doing the same thing in their code.


Thanks,
Lorenz

0: https://github.com/cilium/ebpf/pull/788
