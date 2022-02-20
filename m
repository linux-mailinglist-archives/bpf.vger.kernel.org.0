Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728D4BCC7E
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 06:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiBTF3v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 00:29:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiBTF3u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 00:29:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E546662
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 21:29:30 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id bn33so10021219ljb.6
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 21:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtNb25XTuco6DZesvKOp0h38Z2ylZ4+d+qOrxTT2hXU=;
        b=bWiOdd53EIBIGLrFXznNoZdm8wofLgtXdgxwJiRooGjfc170t0IXJoT/YTnjDHNHpU
         dW/ePaaLlF4ewPt07mRJpyqcM8dXXCCA50BiyZHhxYTViNpvZmuJ2Zw8Th7/j1F/au7P
         y6QkIWTURu4fyHVr0y65K23xyEyz3P1crbgwnufS8/OaQP1KgPW3ji5mJcHRk/Dm/Not
         czfvUIW4xQZLo1m7dtkVf1gyywB8HTLCMnFbXVyBRhtrAqwEsYmQWaHOXsqDpcdhfue2
         gy/XfTLsR5XnfMZn4qQR/i+37eZH7Ha0Cqyi7RLEVxly4XKzQpbXLK85qRUyQk8wTJO/
         v8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtNb25XTuco6DZesvKOp0h38Z2ylZ4+d+qOrxTT2hXU=;
        b=5p0gc8B5GXSL0bEwlUCqPfXbQqb38ObdbHYbc89ZpgwqbdXMZrEJUVheJ2nr0QDdoe
         IaLXI14vjgTcYXXM0lZFkCWunkVAq/uOs19IKXMe3gfpgAnHQhVN9ARu2afrBtHMb2PF
         PAsg2FfV3qqeKrWeLCNzmIW5Nok8VvMmQ4CTy0fFRY+ZvctRxyUFgL0VCuctk3f58QWu
         3Qu3oNQeR9jqzFSScwXA8KNDl2+8fzNZ641VQjZ6wGJHj79FTsj82ZLK7qkHBdGBHXjy
         HCrOBtA8vskG0i14AeLHElhTaBLa9+aa0U15xveDQbqt1liT7o6XnS50lBY/Wl1EDmPG
         p2zA==
X-Gm-Message-State: AOAM531Kw4O+hzc1Y0BmbKp5b/JVYmwKgUXXvbK6bA3NYRnFFDzqIdL/
        FAWCi0jBFzmDJWX3/KQivIxk9Ode1DSKR6336i52pAHj
X-Google-Smtp-Source: ABdhPJy2GrKZWPuhXcisnMJ/9OEb6cqQClaLalHmQ/1HgwWkuKcEBV65HxY2GXWbwJd/aCF03PF2U7qziAHG0jBLJac=
X-Received: by 2002:a2e:879a:0:b0:244:c85f:6f6 with SMTP id
 n26-20020a2e879a000000b00244c85f06f6mr10664418lji.242.1645334968426; Sat, 19
 Feb 2022 21:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20220220042720.3336684-1-andrii@kernel.org>
In-Reply-To: <20220220042720.3336684-1-andrii@kernel.org>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Sat, 19 Feb 2022 21:29:02 -0800
Message-ID: <CAJygYd3JsTGfgqbwTKAi+V6FvYq2Q_Z-kwud=MHFdekxMLjpRA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: fix btfgen tests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks and it looks great! CI is passing too
https://github.com/kernel-patches/bpf/runs/5262640148?check_suite_focus=true

Acked-By: Yucong Sun <sunyucong@gmail.com>
