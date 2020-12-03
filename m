Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679382CCEDA
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 06:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgLCFy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 00:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgLCFy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 00:54:26 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83BC061A4E
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 21:53:46 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id v92so987797ybi.4
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Pg5aHt5r6dC63BjegyM3eHJX9fUgptX9ZT2TfWjASs=;
        b=Hsy/HB1cwwrbiWUwFwBGNbvVXumu5j9pD76Ep25TNlIaCvJzPH46o/ZjV35x6sZsbr
         WwNBAN/JrjuDQmkiiwr+g36RWGsETAxO5qXeR2yinM0LFp+Qk4tBpQ3t1lcGI3DbPzM7
         kq8Rns/iPCSUpDlyvflmdb2t8RTkpBaaiYokAVneXVkljUMO0Z4/q9DLelYaLT2z5yqF
         rrnJZMiMrUM5lTqCjme2Lm1PGE9w/SlJecGpWP1vJCYr1TdtxWudTUgScJAS6NHFl2j4
         jyR052r41D/TJ7AOTWPRP4KlBZSiCM5h06M8MSzgMjefMkdqYNDFxaVzQVGtPDXgchno
         o5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pg5aHt5r6dC63BjegyM3eHJX9fUgptX9ZT2TfWjASs=;
        b=eD/207tjiip7MW5h0Rqz2mGYFUtC44HGOfezCvcJ/mFtSydDo5knp54QV8MW0U+dM+
         MlAt5JM4+Gx04UbjvNzuQ4zKaajUQPpvxCNWY7EoEudnXgYRBdVzpQrEFakMiMPsW/MW
         g43P2zKeMUC6axo116KpbtOB+iqdYMEjJi2OHziTzSCVxxE6z/mI6niRwlfWjIKOPQbZ
         zT0Ucej8vRAYMY6dUPxatt4H0VPySlgSmJ5No/kh1ZyyOtRDVXWNNM1TxZ7Y2D81OApe
         uoICfHwdQ0snfrQ9eTjezUP2Fzc/30FtGeAlfXtXYRvVBslve2A2JDJlslCDnl8U8nYG
         4/FQ==
X-Gm-Message-State: AOAM530UEW3uyWYAFqHfVno2aj0EkbvI8nUYybs4vO077xJ7102KyB3D
        vBo7fgJ8VXrxY7UnKiIJD4ypqL2eEYLzsT1hGQ4/JB+UOFMbQw==
X-Google-Smtp-Source: ABdhPJweGXow3ivtUwwqFR32OJ+KOMKHnoB9MLU3PnSAoJAVg7V8j2sXX2w88xP+43X3c1lM2PZqBfENGgA5nVwBP0Q=
X-Received: by 2002:a25:7717:: with SMTP id s23mr2324072ybc.459.1606974825907;
 Wed, 02 Dec 2020 21:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-3-kpsingh@chromium.org>
In-Reply-To: <20201203005807.486320-3-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 21:53:35 -0800
Message-ID: <CAEf4BzaQDqPa9JPwtoQ67yBNk+JHcGXjovUCDaG_zVeA-xxqhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: Ensure securityfs mount
 before writing ima policy
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
> SecurityFS may not be mounted even if it is enabled in the kernel
> config.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/ima_setup.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 137f2d32598f..b1ee4bf06996 100755
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
> +                securityfs_dir=/sys/kernel/security
> +                mount -t securityfs security "${securityfs_dir}"
> +        fi
> +
> +        if [ ! -d "${securityfs_dir}" ]; then
> +                echo "${securityfs_dir}: securityfs is not mounted" && exit 1
> +        fi
> +}
> +
>  setup()
>  {
>          local tmp_dir="$1"
> @@ -33,6 +47,7 @@ setup()
>          cp "${TEST_BINARY}" "${mount_dir}"
>          local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
>
> +        ensure_mount_securityfs
>          echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
>  }
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
