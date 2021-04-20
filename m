Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7F364FB9
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 03:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhDTBMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 21:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhDTBMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 21:12:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E5C06174A;
        Mon, 19 Apr 2021 18:12:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z8so41545700ljm.12;
        Mon, 19 Apr 2021 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+jgaG8AKVPYo8O5Zjv+aQxBlQV35EmKPbl4eEMtW/g=;
        b=UX+87eGTctwV7xwp46787OcZqMe57p1qCFiQDc9TWUP43DluKlp6RzdEVQZupQbW+A
         lD1eXiK8a6kHrz4X8MKHkdSjxW7F2i0KH3VdD4ZvE9jGWmpKNj4GSBy6JsIbqaRygAks
         WCcFDrnQMdUpqsd/Z25IP19ziRL1HMxLhYEiP1svtj2vo1OAOMBU4IFR6vsBduV1jR2k
         MBnmr8zBbcOUJFVSNfgg86MXdq1HcUes0/unzeAaDJzbIsX/xofk0xqhzElhmDBgfS7W
         bzKgNCVId4GaCeDmBnd9ZtEVDSsRcX0SYnuj5srswpDecCmb/RYKc+Gh5mbeS6YXKHrI
         RdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+jgaG8AKVPYo8O5Zjv+aQxBlQV35EmKPbl4eEMtW/g=;
        b=XY2xn3YUEGMATTClRtC2W4er1NvrUzbtKPK0zLuFHIry2e/JZBGXwTrVdwyUzSOmC9
         LbKN10VVJIZpR44aBCFM0me4miHdpz2ZN/cvPJJ5ZzNr8sq6+Rj4/+JgejlVO6CvBQ2a
         auRBJoMiN2xw0oVfAugL8tCMduiIi1xuebq0BMEotv4BgQKHAgNf/Uswf/CVFxCG5ezZ
         FpqdE1fplV7Smq/adKzqDt+WDfIdz0yizZwnkT+6TOhI+vDQijHlbfkOZ1lC2nI8YVJK
         btZWFekI3Ss8+FV6uJ5sh+ZRoyuc4FC4lv6G2CjoISFzY7eBN7HR6peDUyIU+VLj3HA2
         DMjg==
X-Gm-Message-State: AOAM532799YHXzgdbQRs2ftvu45oBY3p+Ym4ly36GAh52LAOZn46yTi0
        WUmMqD/xBJ5U0klpU5ElAEbQXA73i7yL6q6Z0h8=
X-Google-Smtp-Source: ABdhPJwlwl+kqvuT5xwAnYpaWwrr4jbO6sumETaWaf0LOd2EfNnf2PjUqFDlxwzctmkk9b9mmW2DfnJ6OxnKXRb8i28=
X-Received: by 2002:a2e:9f49:: with SMTP id v9mr12852610ljk.44.1618881129736;
 Mon, 19 Apr 2021 18:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <1618399232-17858-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1618399232-17858-1-git-send-email-yangtiezhu@loongson.cn>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 19 Apr 2021 18:11:58 -0700
Message-ID: <CAADnVQJ2ijjamaBxrF9di-D5Owh919qzNuPv+CW+sQ1xUxRF4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix some invalid links in bpf_devel_QA.rst
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 4:20 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> There exist some errors "404 Not Found" when I click the link
> of "MAINTAINERS" [1], "samples/bpf/" [2] and "selftests" [3]
> in the documentation "HOWTO interact with BPF subsystem" [4].
>
> Use correct link of "MAINTAINERS" and just remove the links of
> "samples/bpf/" and "selftests" because there are no related
> documentations.
...
>  .. Links
>  .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
> -.. _MAINTAINERS: ../../MAINTAINERS
>  .. _netdev-FAQ: ../networking/netdev-FAQ.rst
> -.. _samples/bpf/: ../../samples/bpf/
> -.. _selftests: ../../tools/testing/selftests/bpf/

I'm fine with removing maintainers and samples links, but selftests
would be good to keep.
There is no documentation inside selftests, but clicking to go to
source code feels useful.
Instead of removing could you make it clickable?
