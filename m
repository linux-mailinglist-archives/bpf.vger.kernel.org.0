Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7569960B2D5
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiJXQvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiJXQuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 12:50:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9917054;
        Mon, 24 Oct 2022 08:33:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E9F103200312;
        Mon, 24 Oct 2022 11:28:13 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 24 Oct 2022 11:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666625293; x=1666711693; bh=q4fzVob94O
        +Bj0fcl99z5CvnsJigYyvI50uZH9qLdLQ=; b=gE9VoD+k5nuto7UW3tGPkjrh4Z
        LBPp1sOCTOR+PMEVTN+amj0Su9uWbyFg0HFn9tIAW3xLKYs8AEudtbc2AYpGqt0/
        s8s9HscR0DrTrK+WxzsBanU6MytNxDou9BHdX0I6T5XmCVO0COy87EiJ3S7vsRmb
        Pz9g+IB1TmftSsh+UmIXDaV407JKYzlBW9AMbsrpzvBjotlNkzknPbBSF427ZXCT
        NvAe537LeJ3Wo3AZ+xKqKeYLtoED4anUUs09Dq81AWsAylnHVpZAz+74ngmd3x8S
        ChGRohwpIMi/Xg1PLFvPQgFOyT+7FQfRjy6f/iQl8mEYQjff90eMb2enM7zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666625293; x=1666711693; bh=q4fzVob94O+Bj0fcl99z5CvnsJig
        YyvI50uZH9qLdLQ=; b=VKNjPbUVy84sNof68wyF5lA3rZWmQB8RTY+iy4R4T/ct
        gui83QOxvC/onSgZiaOds17v5HqyMqarCGkeSmbobWeaK+QH76r5ZUol9LxjKCKR
        Btdw7m7Tv1DeZ7EXWSpr2+/ngXDwf2KHLHn97VbYhjt3hACLuXEsj56IDzOfRpmD
        YvzDfC66h1TobFQB7xxauJE6YwKTNhW23hu7cr0TsosqfovH+SIocaZfqT0bWjrM
        NDdRx2h9nwrcDcZt1WZGsPX05tOQO4QfXOz7Ru5ybqXy21zAEunW7066nJ3kGSft
        yuS7eXi1mvRdZQTrr0IMNjhZOHhxrlaSu8b25bUtgA==
X-ME-Sender: <xms:Da9WY8Si5Qwn8-KAfWStUJcj3BWClEyNbJoW2gxfaHS1FNDuaPXuXQ>
    <xme:Da9WY5yBqBrPC2AfbkY3z_hl4HWlK1WIumMtLywhvIOjKlxEBjBht18Y3005_Qr0s
    RQYsTC3DPjpiayKcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffdugfeggfeiheefieehffetgeektddvtdffheekffeiueeiuddvffeljedvheevnecu
    ffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohhssheslhhmsgdrihho
X-ME-Proxy: <xmx:Da9WY52vYXkrFSWZU2lNPQ_VMP_x9hDLpRthaK5jAj7sjx3DY7Ci0Q>
    <xmx:Da9WYwBA_sHQeq3E_5Tmc2su5ThPUUAFBH4x-eDJJdCbTVWQL93i7A>
    <xmx:Da9WY1gEBUOYH4Qdqdd7jENf2P__CFKz-R7EeVHrY6XmpTA7R0XYTA>
    <xmx:Da9WY8Xx6e36INu7jeMRtUSlftqxweUm9CLA09A1axjU745wVQgAFA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09BEC15A0087; Mon, 24 Oct 2022 11:28:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <6c859203-68a4-4dd9-bd7c-e93c65c686f2@app.fastmail.com>
In-Reply-To: <20221018122708.823792-1-jolsa@kernel.org>
References: <20221018122708.823792-1-jolsa@kernel.org>
Date:   Mon, 24 Oct 2022 16:26:21 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Jiri Olsa" <jolsa@kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>
Cc:     "Akihiro HARAI" <jharai0815@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Martin KaFai Lau" <kafai@fb.com>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@chromium.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>
Subject: Re: [PATCH] x86: Include asm/ptrace.h in syscall_wrapper header
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 18 Oct 2022, at 13:27, Jiri Olsa wrote:
> From: Jiri Olsa <olsajiri@gmail.com>
>
> With just the forward declaration of the 'struct pt_regs' in
> syscall_wrapper.h, the syscall stub functions:
>
>   __[x64|ia32]_sys_*(struct pt_regs *regs)

I think arm64 has a similar problem: https://elixir.bootlin.com/linux/v6.1-rc2/source/arch/arm64/include/asm/syscall_wrapper.h#L11

Best
Lorenz
