Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778F1421B6B
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 03:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJEBIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 21:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJEBIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 21:08:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC1A610A8
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633396001;
        bh=SktD94DznT691r6dkDbAq1H4r/wS7lEyCYfXE1BWHmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ItWCes++B6JktuNMagD8wsRZ4n/cn7h6Z0YXZQoZcq10UYnDihT4MqI+k1pBlxeiI
         UwlFfWxr0GOIVimvw8aFZUKnfNkEvz0bgEe9wzkyzluuU5/XbQNFk9VmUsRDkCERvj
         lIFYKc49Dk5f0W7C2Q+aGT+nx0zMB3LuoItANURm+pF8iOtrl5K2hZfna3I4O+v7WN
         8/uCbCHM+1ceZpcvl822ymFcV2Kq5KQtTzvU26Ihdb2FU8dQdD4UXHpB3jtPZgjQNI
         qEd50dmAdGwof7hvHftjgixpNaXGmq4KReYfc3QHgL/eKjI+VvTAh4exnNrbPB7uWO
         QFN6f/8POP5iA==
Received: by mail-lf1-f52.google.com with SMTP id n8so23338786lfk.6
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 18:06:41 -0700 (PDT)
X-Gm-Message-State: AOAM530foTsS7iaIKalBXBaP22Mnc+Q+ivsHqnlvgj8Ko3rhJ6wVkNYB
        EFrE32R8a7j3R9GotI/uvz7x9SyEkJ9xBj2j3Qw=
X-Google-Smtp-Source: ABdhPJy7kEz5HWopb7uFxz7uF7fvwaAY/67zbc7L/RiHmJ6Ka15hhxCwp5q5oI24SCQbrhEPVKnCbPr0O1pdiVmCswg=
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr19210158ljj.527.1633396000214;
 Mon, 04 Oct 2021 18:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211002161000.3854559-1-hengqi.chen@gmail.com>
In-Reply-To: <20211002161000.3854559-1-hengqi.chen@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 4 Oct 2021 18:06:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7GxToBCDVzD+H-83NAJw-a-EraNVD=+xcFfGqKduejUw@mail.gmail.com>
Message-ID: <CAPhsuW7GxToBCDVzD+H-83NAJw-a-EraNVD=+xcFfGqKduejUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Deprecate bpf_object__unload() API
 since v0.7
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 2, 2021 at 9:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> BPF objects are not re-loadable after unload. User are expected to use
> bpf_object__close() to unload and free up resources in one operation.
> No need to expose bpf_object__unload() as a public API, deprecate it.[0]
> Add bpf_object_unload() as an alias to bpf_object__unload() and replace
> all bpf_object__unload() to avoid compilation errors.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/290
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
