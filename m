Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450B53259C9
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBYWpS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBYWpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:45:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FDAC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:44:37 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id n195so7035378ybg.9
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM/mt/3lqD0uypOnJOzgB00qaiFL7tET6G7+dHKjKhA=;
        b=Ajs3mhN868OETYbC/+08LbpC7vgQPz2cJmxZMW/CwK1O9ujL7H4yHN/+VMGA0Aom+S
         4ZOPc27K4K8WMReBagBmG3nei2bAGiJ2oOjZSQOuOgA86CIpBNYKjNYUmX36HV7QPJJx
         r4YhwW09g8buClxY2yU0jvOWPgl0GSpuikmI32IYnXkzUsJknAwWUGW4ZGh+JmPQF6av
         1bfJb1n2TVCrKhdAqVPijaxFC3zp+LwuOBo6r/NOLkhTGB9OeKrk4gnZnu5CA/qzttju
         mgDsEMEhtqtgMCAtTkA3ctRnbDbJpTxx2bJ860/QHwXuX33AziYEJ9QqwxXdU/5W889j
         cs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM/mt/3lqD0uypOnJOzgB00qaiFL7tET6G7+dHKjKhA=;
        b=rtPD6nX8Iopxtu9AvntXOMuMjNfHO8kfFSd8gZJdGNHv4+0x6NAFMSgIygkXGpDbkf
         EDzGuIPz3VoCH/ngIulDFTqEGqDHLUmC6efJ/NfxkZfN+r1vEih1B9Dn6XnCVLEeWHmv
         G7qoeHadDKxz09gWnZjMFWzW38XkubvdssWAjCQOtaGNTCZV0iwd1anDWntGnSLyZ0wM
         jE+qqTjzI9nPHvHOXiA9BnAqYUYfisfhR/W/9rZOC7bpehF3ZMslTomZkimWorGqWnhU
         3oZcf6p7YCgJTld0Gj/Y3MZqZP6GJ1ApYJjxPvS/4ZyPAHxTuMTZwO8ntCA9wig+zNXi
         FFJw==
X-Gm-Message-State: AOAM5300PPMgoeI9y7OHQBm9zIQQtmxSMk34xdVD8PoUA+0nHjv9CgES
        GAZv08nVGwCw2EAwtM/3yKxFo4NJeIhsl3yJAhE=
X-Google-Smtp-Source: ABdhPJwNaXryEufWOsdRx7nYnan12YaAr0zJhyIAOOlsNo96q4ODXHcZZbgUy/CCoMiqudRQdL0bnsi6CZUMxVn9/oU=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr153984ybe.459.1614293070794;
 Thu, 25 Feb 2021 14:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073314.4121080-1-yhs@fb.com>
In-Reply-To: <20210225073314.4121080-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 14:44:19 -0800
Message-ID: <CAEf4Bzba5eSgnMKgCM84hzXGdkFew3vJOZ0riGnQ5HuFcbq4fA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/11] bpf: add hashtab support for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> This patch added support for hashmap, percpu hashmap,
> lru hashmap and percpu lru hashmap.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h   |  4 +++
>  kernel/bpf/hashtab.c  | 65 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 27 ++++++++++++++++++
>  3 files changed, 96 insertions(+)
>

[...]
