Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45665F925
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 02:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAFBcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 20:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjAFBck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 20:32:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C76160
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 17:32:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 041D9B81C1F
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 01:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B863EC43396
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672968756;
        bh=z9kyY/DW8gOJpCM4Sh33H7wp0Nn5FHgW3KJIf6Jj0+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PK8B2BUwSA7Tka/btGxqbDWdHLTxVcebM+uycQys+CCuhtv2Z3j8XzgEyo40wILOr
         kef8aUqn1uO9FeAnu34XodrOGz/mLNlwnvkuvj9xPW/Yuc1xaFSIm+v9DN1qSbsJF2
         pQGUeYb1lOTx3TCvEB8O3Ijvi6jgxHXPn0nO+i+bzurjXjtxcbbfm3rIVgjnhMMP4f
         cQrJgHbxAwMx9DNB6JKudzvjgI/FUismyA+aCrCWlXwS0WNID74fol6QEQOjaczoGG
         9KDZSQiGHjw4sGG8gXzoH/qEsYiJLyqGQMDyONHlfjqNWxaVjEcIzljUwlVMmVA6EC
         bTCaO86Cw6iXw==
Received: by mail-ej1-f51.google.com with SMTP id t17so632860eju.1
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 17:32:36 -0800 (PST)
X-Gm-Message-State: AFqh2kp/CmbGqenAa9tmnusvbhLy05Ag4lUtTu4mEm5yxoqfBVcdMwzz
        ubV4sI827QiqzGRjkKombpQ0dQ3ACQOCg1OkdAiHMQ==
X-Google-Smtp-Source: AMrXdXu0rxhmd3gU+epckdEcLqDWCT0x1xK09c0d5YxllwCvAnYxT+G4D/ckMEoGkOnJLslmpGprJOJk4Nm+gyl4r9M=
X-Received: by 2002:a17:907:8024:b0:84d:df2:81f5 with SMTP id
 ft36-20020a170907802400b0084d0df281f5mr293045ejc.406.1672968754932; Thu, 05
 Jan 2023 17:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net> <20230104193735.ji4fa5imvjvnhrqf@macbook-pro-6.dhcp.thefacebook.com>
 <5cde0738-67d3-ca70-d025-cbd1769b0900@linux.dev> <CACYkzJ4WEZ8J5-3L=e3TV0qGi=Xx9bEiDEYsOnOio4gnz5D_0A@mail.gmail.com>
 <CAEf4Bza=HHoDPgeNTWzVhKtpAK=qTF--VHZxLnRc3uJGEdzVoQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza=HHoDPgeNTWzVhKtpAK=qTF--VHZxLnRc3uJGEdzVoQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 6 Jan 2023 02:32:23 +0100
X-Gmail-Original-Message-ID: <CACYkzJ55nqsGNHjwVCysD=KMz8D_AgVYJrH7FFEdjv_tQMX0mg@mail.gmail.com>
Message-ID: <CACYkzJ55nqsGNHjwVCysD=KMz8D_AgVYJrH7FFEdjv_tQMX0mg@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > I see two paths forward here:
>
> As I mentioned in another reply, I took a liberty to add "BPF helpers
> freeze" as a topic for next BPF office hours. It's probably going to
> be a bit more productive to discuss it there. WDYT?

Perfect, much easier to discuss during office hours. Thanks for adding it!

>
> >
> > [a] We want to somewhat preserve the developer experience of [2] and
> > we find a way to do somewhat stable APIs. kfuncs have the benefit that

[...]
