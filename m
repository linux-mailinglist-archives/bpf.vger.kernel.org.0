Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3431A6FF
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBLVjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLVjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:39:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE432C061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:38:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d24so1492867lfs.8
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0okPSkJoE/6mP48kEmED6iGlAPtTo2fCziu9rnYfszY=;
        b=mgm4veUa4QjDrIdG7ENE50pvfeVJwck315u9s1T6F4RokCZfR9PvYcSLrTVAesEif7
         4BzWR7kb8i8ZYddWVFFPC4tv8yF13L9CDMJXXs38icgqKLbN7vI95D3u87UPh0tPft/B
         uym6WDB8XOjsnb/1Y4ykfrd1PoNQUoWqePmtG00zAuOsY9CbvaVo40rmbMi6BUR2/HnI
         sALsMnmZXI9ENNnYQMWHSrXp30u3Uk6GTEcca+sLrx4hrWUJZvxX4KM2VlJnm1cL+rAv
         uaRa2kJc4XkRK/J67J0uHJ1r1yW0pBO6viC940DdQk7oSD2q9LhwFirHvzX0SRFNFfms
         sjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0okPSkJoE/6mP48kEmED6iGlAPtTo2fCziu9rnYfszY=;
        b=S7QTLuM6QFVr8G7wwwEUSZKJ/2vyqiAnhAdGRax1QV0OSkXXirAj03MWG36OcJhpiF
         nMhJnZ1jMdljbwdlxK3N0A1kc1ex9LNJN7abmKqkNnTuuhwwi/0LRVzE5nptlJh6EL2e
         vsM8fPjiPcIaL0e5V/H/WNwtIbsFBtAZvAA1Z8QvHdSO+LHOCItXHtWBn9KLTkFmmmGH
         x1A31QxbpF4UXo0g+9VbflZDSN8rERtIe2CH2VbpUJn0FO30/AO25f9D4fY/yZlysyKE
         vUr/8BObNYIji+bgjuXQY/4IhpDbz+p8ZWVndE8Y/UT+aQahWXp0Pv4nPwxLhTZngLGd
         XAtg==
X-Gm-Message-State: AOAM5318eEUfYJLRx1Mt4EkIsSz7lP2dAiF76svlKiq5ktiwpgpgb8e8
        /9KTZUI6tHtiSYGfJVPBmS8pvm3M9EDoztVHDTk=
X-Google-Smtp-Source: ABdhPJzkCkLGv7QVPX9mRQo0VvL7eLyRwU4bU8cCAxOc9tFIrBPWj6fbWv4Fr2kxIduPf8yqALVIBAEM/TGlhIeFU40=
X-Received: by 2002:a19:2344:: with SMTP id j65mr2650054lfj.38.1613165916430;
 Fri, 12 Feb 2021 13:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20210212005926.2875002-1-yhs@fb.com>
In-Reply-To: <20210212005926.2875002-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Feb 2021 13:38:25 -0800
Message-ID: <CAADnVQKJdKto1pTe8gaZnb9gWu=W_snRjgsWJrE+uc8UoPixeA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix an unitialized value in bpf_iter
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 11, 2021 at 4:59 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
> cached btf_id in struct bpf_iter_target_info so later on
> if it can be checked cheaply compared to checking registered names.
>
> syzbot found a bug that uninitialized value may occur to
> bpf_iter_target_info->btf_id. This is because we allocated
> bpf_iter_target_info structure with kmalloc and never initialized
> field btf_id afterwards. This uninitialized btf_id is typically
> compared to a u32 bpf program func proto btf_id, and the chance
> of being equal is extremely slim.
>
> This patch fixed the issue by using kzalloc which will also
> prevent future likely instances due to adding new fields.
>
> Reported-by: syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com
> Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Though it's a fix it's too late in the cycle.
I've applied to bpf-next.
