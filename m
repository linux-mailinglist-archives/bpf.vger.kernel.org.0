Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A445F773
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 01:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhK0A3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 19:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhK0A1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 19:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D796C06173E
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 16:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D311AB82951
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 00:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53369C004E1
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637972630;
        bh=KKsB8NQdhWxffvLwjyzTdOCL4cndJdqR4zssqFwvDH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fwv24SVVsbZl/ttJx3Gt63uBkoWs97mvTknW8QwuKRwiZPgZ52nqrB8vckpK3Lu/1
         6sQN4f6DvuTQ5L7nkEbiOFDIccbYqqHJv5Eil79JsSP6tTq7jWU9KE1xoiMsVDfzlx
         XRZFvD9/djJsSWpnQ8BZnfUg+0D5xuetzUeIgUxCmjJNP7h+AMbmtwS9NscOSClXZN
         AVZOikBHZbOdvkUzK+gBp/SuGz/TxG5eR0AMQ9Z2I4rfugkOmbr4j2HNocUwZ0t1Og
         DqgK41WOV8uxlSvcDwi5eRGEMdx/s6zYVmU8Sl2dILlpewJnVaqvWAlg7/4nD/XkNz
         BWw7Km4jQrEkQ==
Received: by mail-yb1-f174.google.com with SMTP id y68so24218501ybe.1
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 16:23:50 -0800 (PST)
X-Gm-Message-State: AOAM530HhtZobKGCRcOFfDVtE5Z0YCRJZ3dp1NPGKi7MXnbtnJChEYtu
        uzbpD4JHnboXVfUc80A1gamucw2GM9kLyey4vEA=
X-Google-Smtp-Source: ABdhPJybBMPmFS12v73XAnun5nLgXZpTWktVRjRCIAkvyjxvYHyc4+L+ZIr6Oi/6dSVbxVHRacOPja0Hx2pCBwv8coU=
X-Received: by 2002:a25:344d:: with SMTP id b74mr19462803yba.317.1637972629490;
 Fri, 26 Nov 2021 16:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20211122235733.634914-1-memxor@gmail.com> <20211122235733.634914-2-memxor@gmail.com>
In-Reply-To: <20211122235733.634914-2-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 16:23:38 -0800
X-Gmail-Original-Message-ID: <CAPhsuW59EM-eTwRoA292Yt+PTHKGD2kaQ66eHWsyTEVNQ-8cPQ@mail.gmail.com>
Message-ID: <CAPhsuW59EM-eTwRoA292Yt+PTHKGD2kaQ66eHWsyTEVNQ-8cPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Change bpf_kallsyms_lookup_name size
 type to ARG_CONST_SIZE_OR_ZERO
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 3:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Andrii mentioned in [0] that switching to ARG_CONST_SIZE_OR_ZERO lets
> user avoid having to prove that string size at runtime is not zero and
> helps with not having to supress clang optimizations.
>
>   [0]: https://lore.kernel.org/bpf/CAEf4BzZa_vhXB3c8atNcTS6=krQvC25H7K7c3WWZhM=27ro=Wg@mail.gmail.com
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
