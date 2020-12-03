Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72562CCED9
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 06:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgLCFxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 00:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLCFxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 00:53:31 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AB9C061A51
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 21:52:50 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so961327ybx.9
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 21:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqqDKnj/cYEzvY7zrrX4qGl70+82k7JYlPcHRdvnyAQ=;
        b=WX+rsPb20tLblPdX4Art9X9rPi6lQdE28gEll7a0RwdVI4Od5UeLDb6RyxFgl5xb/v
         Pam047FIA3rsZWmh0+cgBY2dSFAuQSzEWxHSHLj1yenvMG4WvO/pjG6kw170Bz+P0vIu
         m8vwcOur0NAcc/GWCMNPsO3WYWlv4iD1cSjgzIPipCb6PSPCCbs8/pD2ILbxQ1vR6aub
         7DWdV0HXQsUZMOXa/3aoWrCPzGEmrbpPDLB1nXTuCiOHyvZiWaiRWboavlex9xs0mvda
         E8bmkFhw2fzFCYAKPLu7fbVAftBXWhh8ia1F93o2gv4wYSW1OJg8q0Tn7LVBtJ5qGmrG
         I/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqqDKnj/cYEzvY7zrrX4qGl70+82k7JYlPcHRdvnyAQ=;
        b=Z6wiRn1TY0Z5HHC6SrioFSDKg/ZlMoWPhOq8i6xQ7zsH5/C54MjasePA4M337OANdV
         E5zRyD6d8bNY0gxIKgnHY6wMGiUM5UXbCEoEwQqGpF3Rqo3Ery/rP8PUZvNSAYB31IUO
         BeNuwTYsHroTKpVDsxN7kBTrhvNuzyCy3A2Wy7y/othkAMvQlKUE7noEV1Dgzb3KRtlB
         2xCy0/TWA7hB47gd0NjX6AhkieG4xLXBXZ7r5trZ0iWmakehkbixMyaJxmxpaieMQOdn
         MFwUmuJ7n+skMIPgdPCHKY4zBpeqhtiafifitpa9+JI8inh4nUFcJQ5BV1L/CJqPe4NN
         YBvg==
X-Gm-Message-State: AOAM530X2rE+ogDl7ph8DSRE4oWGqbd769c83T5ZU8TEs7zzkdMT2Fqw
        zT07PObAeum6uCimBDtaNgtfoAdvGTZMedgwWtU=
X-Google-Smtp-Source: ABdhPJzlUQq3ay/pdS7uq+UbkqS2fRnvb3FO5b9+Q0or1iZLSC2OY4HABiOFQKR+nnLMQIalCvGk5NSW0PO9kWpiGlI=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr2290267ybg.230.1606974769987;
 Wed, 02 Dec 2020 21:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-2-kpsingh@chromium.org>
In-Reply-To: <20201203005807.486320-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 21:52:39 -0800
Message-ID: <CAEf4BzZPNWVzTMuFeTZzBkgj+5Q0vxFM0+vY+60s0Eqb7_pcCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] selftests/bpf: Update ima_setup.sh for busybox
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * losetup on busybox does not output the name of loop device on using
>   -f with --show. It also dosn't support -j to find the loop devices

typo: doesn't

>   for a given backing file. losetup is updated to use "-a" which is
>   available on busybox.
> * blkid does not support options (-s and -o) to only display the uuid.

... so parse it from full blkid output.

> * Not all environments have mkfs.ext4, the test requires a loop device
>   with a backing image file which could formatted with any filesystem.
>   Update to using mkfs.ext2 which is available on busybox.

This one is great. It explains the problem, and what solution was
implemented, from the high-level. I'd just drop the " *" marks, it
makes it more pleasant to read as if it was written for humans, not
machines.

> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 15490ccc5e55..137f2d32598f 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -3,6 +3,7 @@
>

[...]
