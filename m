Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A705FF244
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNQaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJNQaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 12:30:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2338F24B;
        Fri, 14 Oct 2022 09:30:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C5C7A5C010A;
        Fri, 14 Oct 2022 12:30:03 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Fri, 14 Oct 2022 12:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665765003; x=1665851403; bh=GAYIcATyO+
        U3d8Cs0weGT6w2j3h0taRYsRXzgJw9Zag=; b=enRkOL/Uq+Wxtj9IhyjIuvsw8x
        RKioRHwIPBRUm7O0UQ1Y6KzKgXKPWFfc0l80QAcneHMZgphkoacexgYqwplMKsbJ
        ixYSfmPtqRZBLpXDwCZhcIMcTYfcRNGiX8eTa8qhJajaP2WNy876RtQlBcYZC5DA
        kclTHeQSU+7G6gJvUtJ0lou+c/BABcCTwBl/vX0qcgscOwkGZadJIKUhwauYNhds
        zQqexTg3izQaQSG8U8z1cV3zqcJhwnYS1CohP0dGvwav+im5Nkxi6/m6BSeJ6e/m
        AXrvtvigTaEQN5rlmJ0uQboy0Gm/lwm280l7Ws96OQkWqe0eJppu0uUisZUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665765003; x=1665851403; bh=GAYIcATyO+U3d8Cs0weGT6w2j3h0
        taRYsRXzgJw9Zag=; b=QNN8nzK2im5TVsLPi1NzacLNqspuEJS8bZNU2uWP0z0r
        M0y2qY7vmNEh3RaRC6Z3CQZfX/gTqRZU+lxKV1Ebc/YqSv72g7wMAHitbNVOEnSK
        Plq1wb1CaCOoYaawsjx8rCIUxI4pdJDSo+ujV+NxJQoxJQvnuTHTBGNUlnAU2EV2
        6FlJDxWE5by9AKKQk9OFDCLe7J6ZIAYXfamLiuUb3x+sX7RHPDkgIYuq5PpAfv1v
        lEaa1PLcHjO5uwfGrRu/lAjQ8Sr5WnyWeEOHEH/YLGIgyi3XP4XM/59ubSXFTYOv
        W9+744nTukfXFHZYpOo90LSMvFXgBK0Muf1JiyLvwg==
X-ME-Sender: <xms:i45JYzGqB-CQ4g_VonfQyR8RhGlOnkkLwPojfECdSnrTVP5nHndG2Q>
    <xme:i45JYwWZTfEYMksc5W5YyBCT-jnP2rtX3mCq7QQY32OOvL3puvTnX2fg1yz0pKMzB
    QcX24PuP9vzINxOyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    ohhrvghniicuuegruhgvrhdfuceoohhssheslhhmsgdrihhoqeenucggtffrrghtthgvrh
    hnpefgfedtvefgvdeuveelheekhffgtefglefffffggfeugeekhfduvdehledutdduhfen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohhssheslhhmsgdrihho
X-ME-Proxy: <xmx:i45JY1L9gNN__VoQk0wXNXspEQdg68JyhWWTLysuWojahUZ1eHJyPA>
    <xmx:i45JYxH0_tmTYScyizx7frFlcq5VmYLHO012dzXSLiCrDINn3C0HsQ>
    <xmx:i45JY5X1xNrdfmGbgWgBLHTJrvBdtjcbxh4cM6xL15RbB_t0h0uL8A>
    <xmx:i45JY_yLdXuR_jzvF03pmg8yCInT99jGwbJWkf3MsSR6zWE1DK7eEw>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2482215A008B; Fri, 14 Oct 2022 12:30:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <04d2eb4a-7365-495a-ab74-704febac2789@app.fastmail.com>
In-Reply-To: <cf6a99a1-e77f-113d-101a-5b5a52111df5@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
 <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
 <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
 <cf6a99a1-e77f-113d-101a-5b5a52111df5@huawei.com>
Date:   Fri, 14 Oct 2022 17:29:41 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     shaozhengchao <shaozhengchao@huawei.com>,
        "Stanislav Fomichev" <sdf@google.com>
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 13 Oct 2022, at 11:44, shaozhengchao wrote:
> 	Sorry, I haven't fully understood your intentions yet.
> Can you explain it more detail?

I'll try! Roughly, we do the following:

1. Create a BPF_PROG_TYPE_SOCKET_FILTER program that just returns 0
2. Load the program into the kernel
3. Call BPF_PROG_RUN with data_size_in == 14

After your bugfix, it seems like step 3 is rejected due to data_size_in == 14. We had to increase data_size_in to 15 to
avoid this, see [0].

This breaks user space, so it would be great if you could fix this in a way that doesn't refuse BPF_PROG_RUN with
data_size_in == 14. Since I don't understand the original problem very well I can't tell you what the best fix is however.

0: https://github.com/cilium/ebpf/commit/a38fb6b5a46ab3b5639ea4d421232a10013596c0

Thanks
Lorenz
