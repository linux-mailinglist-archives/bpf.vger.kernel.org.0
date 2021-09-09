Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872924044B9
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhIIFMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIFMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:12:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F965C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:10:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z5so1480288ybj.2
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x9+QNtqnKay9g1btU2WQd6MFkZlhEIHG3noe8vU/Zw=;
        b=ANk8hFnV5jTWcSvFPxlx7rKVK8glr1b/+6Et+0oHU2jbyEMp058pHHuHGkPGBYmNSW
         ql6VMPFH6CGnj9rsuCFPoCRw1ARzDsj/uhwVptM56AANoXx3pxoNqcx/8Q84zvUeVhd0
         oHyrUSaNDmEzj2juwS2LK4+lQ9e3yQtZq+PHVUHtKkqI1eCqYM8S9YKKhtB1NCtpedxs
         UIrC2yBhR047PBtADrScEtZr4l7r+u8eHQreyO2GGiW2GyxwudD6WoWUk/n0FE8nTDwr
         arnS9sjVkqBtU3creZgsvAu71TZtEpE1yiGOVuYq7Q/+4jaiHM7W72neSKkzTg8IBQUE
         MkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x9+QNtqnKay9g1btU2WQd6MFkZlhEIHG3noe8vU/Zw=;
        b=XXfiQt/Q3YEEqB4UJ51vUPKuuTDynYtcOttSxAN4FjwGry3zRlePolP3R9ZDOaWQDe
         79JoTjsMmp+FjgFMzBc3Y0GMrq7Orc565QldWMhLpWv9wFPX826h7vG7z4ZdtGPDDOEL
         +rM2H6ADqaDOT8uI1KfGYzKlXjGiag5io9jToDwVLgs+YVGf5ArkZ6AhxFmJw9XywUWR
         8rGUyAc74gEvKW5X39fq7SqHlH9kwV0a8J9Sd0tB4Iz/1JIieCCeZq8W+A/PWzTXf8KX
         OzvJ/ibM5XWGQyJcCGX6A8t/DSxFDcwFtm7ZzIhDzT4MYDKZACAvK01XbpDcezNfP6Hs
         kPKw==
X-Gm-Message-State: AOAM533s+qJddFmI7v9ETbrg2QR81lr0plVXQI/wiPwCPCxqaHg9pGQb
        CJGxE9ojWaTmgjEOUnPRz8KXavNS1mty7jRy7Tk=
X-Google-Smtp-Source: ABdhPJxWi4h2WGYXFrSd+DDCHKcdFTSWc4F7nUxtj0oaEQ/nnlPSa94NTUkWQEB9mx+JTI7bDeyDoJWv2A/SQnGmFBI=
X-Received: by 2002:a25:ef46:: with SMTP id w6mr1506633ybm.546.1631164253531;
 Wed, 08 Sep 2021 22:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230100.1958061-1-yhs@fb.com>
In-Reply-To: <20210907230100.1958061-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:10:42 -0700
Message-ID: <CAEf4BzZOV3nty21vgZt6mj2e7P9uG_UW7xct1Tj=beG6Gq8K5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> This patch renames functions btf_{hash,equal}_int() to
> btf_{hash,equal}_int_tag() so they can be reused for
> BTF_KIND_TAG support. There is no functionality change for
> this patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

[...]
