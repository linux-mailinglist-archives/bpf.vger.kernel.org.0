Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27815B4600
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiIJLDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIJLDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 07:03:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9D419A2;
        Sat, 10 Sep 2022 04:03:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 91F015C0106;
        Sat, 10 Sep 2022 07:03:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Sat, 10 Sep 2022 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662807791; x=1662894191; bh=o5jZhftShA
        83xT4QYlsfa2imJlMCefWDbzLmSihS/B8=; b=P8gKKKQ59zQLw6PpOSPUtkqhRI
        4PisNxzPdWs6Z8wwwTsAqKG3/WiRt6MP6fUzXkokHGx7rB4BliOe5fHa8LzwchXy
        DcGNmIdZ44G5XjjMNhfDYKJQI/MnN2JQRUlDEyg6YcTvL1WoR2YQ625Gq/PVvrAx
        HkIq3f4scoEjae1Yb52lOVSMEHA+CbiVCpj5Op4Q3M3eXI/ifa7CP8BL0prmpw47
        spcq9b7y0oK9+vL75w5facpid6WkL4yHP3J8LpYKkOvNoDTQghoZXA9eFZsikR6L
        MKvD4y0f/pkmTG26p6VrV0Dv3wbLvm5TZ4BLrKkZXjWXUjpreFTT72KV/ErQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662807791; x=1662894191; bh=o5jZhftShA83xT4QYlsfa2imJlMC
        efWDbzLmSihS/B8=; b=enSK4GF0iMl17UvUYvBX2haRUqvWlZ0QN3fp+B3Ommd1
        ImrXKbYcsbPfcbY41mUTRxUkc6+r4a3tsnPwtjJ96BwpKzt4hvZ/f7WCSRxnq9A7
        YKK9wkHxg9MM7GjCGZxPRyRjscZJb82hRhU5Jhe+WEAKPq2Ha5LGtPTSf8AMtvWw
        6LXkrac9RUIJmXQk/7N0Bq8XdevEsdZV0n8Xi/JE37GXLEne4nFQQWWUQYVBCi0b
        QPFhrtXs4Bj/oUcntbOWUQJq/5IAjSKXIANqqGzf+0GwnwI03rO+Z8zM1WInawl5
        ijwVGHkkC8O05MttH4QIHp9BY2vSgXZ1zuBBiBVPUg==
X-ME-Sender: <xms:724cY1hsHUaUEwyZE2kYOdSVkBGovX052UrOlhM-YtrLtFz4KArGQw>
    <xme:724cY6BN9MLPv0CU_pJ83Q6yP_Yd2heqL4bwvHdsQ9b4lTyr5vxr2XvcxlXxghu27
    nXMmlbMB6h0IwdHPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epgfeftdevgfdvueevleehkefhgfetgfelffffgffgueegkefhuddvheeluddtudfhnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:724cY1Elo8aF2jVSduYh6tqZsrrHaQ9qZw8tvn1-Br2SkvllMBpmkw>
    <xmx:724cY6QVjRABq8vJZJAz5mD8Up8FnAZf0aOPw7WJSK88ErdLqOBrsw>
    <xmx:724cYyxT9zQ8NsCf1n5nm6I7vRQRnzL8B199feCQbqiRhevMOcYn4w>
    <xmx:724cY3oIySFbwwoISsD6lhOif_7LNo_dJiv7ipXYRoAeULh4TPZuVw>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B30815A0087; Sat, 10 Sep 2022 07:03:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <17ef2c79-b5e8-43f0-886f-641ce45f18ee@www.fastmail.com>
In-Reply-To: <d2fd289d-a5b5-f0af-3125-417ba9d242f0@linux.dev>
References: <20220909092107.3035-1-oss@lmb.io>
 <d2fd289d-a5b5-f0af-3125-417ba9d242f0@linux.dev>
Date:   Sat, 10 Sep 2022 12:02:41 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Martin KaFai Lau" <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Song Liu" <song@kernel.org>, "Yonghong Song" <yhs@fb.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH bpf] bpf: btf: fix truncated last_member_type_id in
 btf_struct_resolve
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 9 Sep 2022, at 19:17, Martin KaFai Lau wrote:
>
> The fix tag should be
>
> Fixes: a0791f0df7d2 ("bpf: fix BTF limits")

Ah, thanks very much! Sent a v2.

> The change makes sense.
>
> The kernel's vmlinux and module btf parsing doesn't go through this 
> resolve check though.  Are you trying to __sys_bpf(BPF_BTF_LOAD) the btf 
> from the vmlinux file into the kernel ?

Yes, with the twist that the BTF was serialised by github.com/cilium/ebpf instead of libbpf.
