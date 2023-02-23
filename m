Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BD6A0FAE
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjBWSrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjBWSr0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:26 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9651158B8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 10:47:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5384ff97993so84777147b3.2
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WjA32Jpx57cVd32SZNOzuTDW+6o0QlN93xjAZYLFqW8=;
        b=Et512GEBd/i+QztxG9BP68ZUka2FWMV/oMXCyp7HLAZl0+O3To3Kp2C3Puqw4RxUfs
         ne7x2wh5uEYAwuDQiCtjd4+7+PfwDf7yJZAoyko3kPff+eukaUMR+DNt7sl/v0qOiN3D
         D8vE3rHELk9k8etzpnjAuzvIqxC2qlcWLklCP5QAxYar8obSgaOTHY/zjBEIY7b6cTOh
         zaq55yCvEsz0gS/dJrlKPs3o0iyom5iocEQ+RYzTiCWzf/rFWxLGchBy4nxhHQPQsDQ7
         Skog1g8yfBFBOUiepq3XKDbO8FtV/rl9wMPaD5RQ8c9xJsQOvI44c6el6QOP5vttPaMU
         EltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjA32Jpx57cVd32SZNOzuTDW+6o0QlN93xjAZYLFqW8=;
        b=40f6ol4ABkYD9njCD9kgxnBnAZyrIMWTgF/eloH0afjNiCIModEZkPx+r8yV0pnmX3
         GMqED1ibNtMiiYne2mpM17Lz69ISsEVod40OZ6xaLi/GjtzXIzWvIx+nlJcqqWtPy++0
         vYFNp6/DMbKgjOjE5CW2ysDSB8/28djQF9gehM56GY8meAAQulyA+KEdtMCt8LiZWcGs
         KXZuey3IQxkdgA3YInkTJ3m9nL6UsCk9OUYIrqKhnP1+deY33Lf4cBRMIsbzMavoyTgL
         6xe6elx7NaJGLotwwdl5ES5tDmV6GZh31BQN5GLGQTqyalm8remGzVYsp2ekTfIuUpxM
         FFcg==
X-Gm-Message-State: AO0yUKXpKY70e+cPCsEGBLvWmAtV9RKJ7NmPsw6qM4hNtO+G/yH4J2ii
        n7m5o/0t/B7D9sNA67ErN1DaB1pUSmC2HfG5bX/SHA==
X-Google-Smtp-Source: AK7set98S9Wal9BCX+UN2eVq/NYxQWlplu7di3H8NX1Jc9j4OW0mPv3/2yhgLX+OIKLyZr60rmWfEOsxoQfG80GcRqo=
X-Received: by 2002:a5b:907:0:b0:932:8dcd:3a13 with SMTP id
 a7-20020a5b0907000000b009328dcd3a13mr2538488ybq.5.1677178036613; Thu, 23 Feb
 2023 10:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20230222192925.1778183-1-edliaw@google.com> <20230222192925.1778183-2-edliaw@google.com>
 <Y/crdG+quVvKMF0m@kroah.com>
In-Reply-To: <Y/crdG+quVvKMF0m@kroah.com>
From:   Edward Liaw <edliaw@google.com>
Date:   Thu, 23 Feb 2023 10:46:50 -0800
Message-ID: <CAG4es9Wa+PxomxmK348O8nxfXny8jo=9kqQ0KOYgQq82gTNeaQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 v2 1/4] bpf: Do not use ax register in interpreter on div/mod
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
        kernel-team <kernel-team@android.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> What is the git commit id in Linus's tree of this commit?

Hi Greg,
It is a partial revert of 144cd91c4c2bced6eb8a7e25e590f6618a11e854.

Thanks,
Edward
