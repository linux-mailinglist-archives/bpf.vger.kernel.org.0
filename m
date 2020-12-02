Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983F32CCA61
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgLBXOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 18:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbgLBXOY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 18:14:24 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9AC0617A7
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 15:13:44 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id t33so297381ybd.0
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbszLHvIbi1C62g6PO8QvXU6s3SdorVZLw2Gv3CtMfc=;
        b=keCn2VXA87dZUEClIU3rhlTMJayUxkDSr5AWc6YzFoMxTwEzBWbyRdlvXs/jykha4H
         J5ScpPAVi7T7GHRDdCuLHEpJBjm28RS+lL1i6W1RoggRljawfEgsFr+R8koZkWm1HwrO
         LyYoYnFHOsW7Wp5rNhTPFlOIWTOqEc9daZiIWDo4PaEFQC/8FkP20jLwFEhcca/23lh7
         uhvV1oLo8OumULfZzd0SFQafZh9Q463GWsOZPsSHAcESworLJa+qMEX8K4ifl2V/esFj
         91HAmkr7aajrJOUKqZeupCaCEUxREb3MCHf07HmsDylZlTLFt/4Gw98t1eB65Ckx95N+
         /Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbszLHvIbi1C62g6PO8QvXU6s3SdorVZLw2Gv3CtMfc=;
        b=MaMbDgdrKyrOr0b+1q8uND+hCTi8Whq1IXAoj9C+avEqhAA6ddeqHXHHjEZu1jDWmr
         yaMATEMWBTwxwXeptaQ/g4kcGcN3PE0LZ/O/p+ZU7xidwaaPQMwKkMJSpv1/NDSKtjer
         bwzkgnnkUk0tktVF38dUoJO9t0RWK3U3uGxLgRYH5TQHYAwwBRXGbPWIeZagLbDJFxug
         tka34K8LcOroIaZUOm880txKjSziJmzY4VI5LCUR+AW7SHn26Jchp2yB8OhhajOsBjY5
         VXM8maC6WC7aV5trxSKch9SccwZXg8tGfsIM2pqZzz7BhoXNiJvKqXl//YbC+pXs3eLa
         dKJg==
X-Gm-Message-State: AOAM530kLF+w0DSlealf5Sbv67ddHHmNCXDHOZvGKsHGtxY5VT48uD7B
        7d8lOZkw40/V+VqkLEuoNRwIMPpFhnEpm9D+fKQ=
X-Google-Smtp-Source: ABdhPJxj0tC1hfrJIhKlOz9kjR/WxC6vc9ENJEqsLSrC5VnUgf3yF2/rFM+nEmdd9TixpV7QwgTZd6nLyoMc9tR3dQw=
X-Received: by 2002:a25:df82:: with SMTP id w124mr655451ybg.347.1606950823831;
 Wed, 02 Dec 2020 15:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org> <20201202223944.456903-2-kpsingh@chromium.org>
In-Reply-To: <20201202223944.456903-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 15:13:33 -0800
Message-ID: <CAEf4BzYUwP59SNhTFVFQ1PdVg6hfvTeKtHDqPSxoi6HMW+Q-pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Ensure securityfs mount
 before writing ima policy
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 2:39 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> SecurityFS may not be mounted even if it is enabled in the kernel
> config.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

please add those tags in v2 :)

>  tools/testing/selftests/bpf/ima_setup.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index d864c62c1207..1da2d97a0e72 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -14,6 +14,20 @@ usage()
>          exit 1
>  }
>
> +ensure_mount_securityfs()
> +{
> +        local securityfs_dir=$(grep "securityfs" /proc/mounts | awk '{print $2}')
> +
> +        if [ -z "${securityfs_dir}" ]; then
> +               securityfs_dir=/sys/kernel/security
> +               mount -t securityfs security "${securityfs_dir}"
> +       fi

again, something is off with indentation here

> +
> +       if [ ! -d "${securityfs_dir}" ]; then
> +               echo "${securityfs_dir} :securityfs is not mounted" && exit 1

nit: " :" => ": " or it was intended this way?


> +       fi
> +}
> +
>  setup()
>  {
>          local tmp_dir="$1"
> @@ -33,6 +47,7 @@ setup()
>          cp "${TEST_BINARY}" "${mount_dir}"
>         local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
>
> +        ensure_mount_securityfs
>          echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
>  }
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
