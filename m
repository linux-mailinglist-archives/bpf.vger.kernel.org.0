Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E83F6B4B
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 23:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhHXVlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhHXVlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Aug 2021 17:41:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA091C061764
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 14:40:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j2so8653072pll.1
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bdo96wNlDp0nsP8N49Gq9gKciXsugdqeS68XJJ7bCc=;
        b=Qyzz22rpgJ2QQB+0rEBPv5KEu8iGhlK/4HpB80dMEDKJcBZy3xomtOUe0JrHXYQ6Ke
         q7Ii6p4iWtVOTpc7opqMBYAEwM6VVQt8LtltJWKf8DJE8I7wPHl1X+4g23aNTcUbkxt1
         SjBB8aaBovJ/V0nCPiX2qvymux4SSXb3p0F8gpL4KGRvdaTg9r9N97hSTVyCui/eJoQE
         EPzKQn8a79ujPASdPg/mpo6ZIksuNveRRVnFESZO3DW88L7i9zdMJArk+M6bU/MuAapu
         JwffNNOO6L0YjBFs9dWDckrV+vEbflITGtfeUWmyMuszK3NpA6CFFJjJ82sN22cNCK1D
         9tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bdo96wNlDp0nsP8N49Gq9gKciXsugdqeS68XJJ7bCc=;
        b=hs7V8a3FJMrr1Bsz0GY1YPnjwTjo8wHUU4GmQYr3TbMLL3cBfoTZWESF5AXdi7SiOE
         TPHCLbrLZ/qWFHhYWMhK91Aqqy5FoN9Ae811cafM2S11ngFZdR68zgFPBH/UXkNcrKiK
         PJvVKz9hH3PZgi3mE9fr94TeXQ+XRAXRb5s6fOFu8FTVKf72tgUq06iyIxQFjNm3Q3CO
         EIrwHJ6mpgJqICbWCNvLpY1PA8NIXOjMFBk5eOBxYl0i8i6IkS8i5MpDBdpaRwN/huy0
         Bs5H2s79JLr6fTrLFpmziRMd/2kBvOsBtUjdRSKHrsy/Xx02mkwHX24h1yT+fcbKDEwk
         St6g==
X-Gm-Message-State: AOAM532isjw818C89YFv0HlbsvabPJf5hmUaB3W6LV4TdC9aco3cFhnM
        EvY6DWg/y7mnMdna6/93cieiXmmRVN3DYsJaW4s=
X-Google-Smtp-Source: ABdhPJxhjunnxmdOTuZjdi7H3X+TBYE2zZtVb4toqoxW+WYtCOR2lcnKsI8XuFqImGyvamB8pG/vHDCuq9ll1AR9RfA=
X-Received: by 2002:a17:902:82c6:b0:136:59b0:ed17 with SMTP id
 u6-20020a17090282c600b0013659b0ed17mr4468006plz.61.1629841219212; Tue, 24 Aug
 2021 14:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210820163935.1902398-1-rdna@fb.com>
In-Reply-To: <20210820163935.1902398-1-rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Aug 2021 14:40:08 -0700
Message-ID: <CAADnVQKemaH_0sw-v04b7Rnvmn98XSigseGtz5K14Zoophbbhw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix possible out of bound write in narrow
 load handling
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 20, 2021 at 9:39 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Fix a verifier bug found by smatch static checker in [0].
>
> [0] https://lore.kernel.org/bpf/20210817050843.GA21456@kili/
>
> v1->v2:
> - clarify that problem was only seen by static checker but not in prod;

Since it's a theoretical bug applied to bpf-next.
