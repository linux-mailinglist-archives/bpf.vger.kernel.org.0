Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A12CCA5E
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 00:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgLBXOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbgLBXOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 18:14:19 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7BC0617A6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 15:13:39 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 10so248578ybx.9
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 15:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkQ5VhiTjOWTcEcaZ5PrPU7vDNQ0UxbJG4SPrbZBhIA=;
        b=ovVyWKhVbVn25ysEVJ/4grPpMSuaq0vxT/iczbEFBIAwJN2sorm73M1kG9k2cgCclh
         g59mTtSqVhl9j2hBnWfEKujn1zJNSxU5IyCD+zh6A0wnj0O/fbSYbZWW0ZJ+hYYeRDVc
         U/+wCYC176gwfcpl1z68HwihX7IQa13zNx0IWUF/J/rrG0gSIrNiT+virxNbMI7d4g1+
         WtuI3svbOIGqSU3iYRyxGGeu94esqOf3joDCE4yAXCeeNIO5Ww/4jIs0ZNv4P0Tc6E/r
         06gXsTxGDBZpNkNGGH8o/Dw9D8Gfy64Y9pZTpr+lKFZ9eGvd0FOw6KdFkW7BYl49VqBU
         pOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkQ5VhiTjOWTcEcaZ5PrPU7vDNQ0UxbJG4SPrbZBhIA=;
        b=ZRNlVguHPOKIEiS7UBwmLUAAGE+KZKdJ2mG3iNlW957rB7Az7cD4E9bVXncAcj6Z+L
         550eYiQSodiQMgSSn3o9fsTNo5pm80fssITgbfvQMmywPYruJP0h2oPWuWIh8bvwOn2F
         9oceJnkCLQzqyQLEbqxMZbwoEBRjNGWtgHpzJY4UbDr3aolxmCSTHdTQU5di7i9LdVCQ
         AhII5DwYyfIpt2JHNAdYTS2o8wk6P7No4Q/xvsJ76rWaHd0VtiUJ244l7oWuR1rjCGFr
         PinHvXWOIrYPKtPTPUkR3r1Gr2YR2SUbhiF3W4pZiWV4hW9++Rlvec+BgdTmgxYPktmU
         ARzw==
X-Gm-Message-State: AOAM533hccysE9taxywwkg4dSb1Nrj+XcndujEd6vrGQRMStPREgbC0H
        QDMIaNOQSXFrU5xY6H6WlMSQwnMUinx8NBbFWABotvIXoXQ=
X-Google-Smtp-Source: ABdhPJz5irBRnP0p+ZVQ69MFPy42TlsAcjUCJ/4cEmVvA+KOL6n6esIFWV8Zm0cKviP2MNxCEXjGQ4K0uBgkhXtoljQ=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr616592ybe.403.1606950818528;
 Wed, 02 Dec 2020 15:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org>
In-Reply-To: <20201202223944.456903-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 15:13:27 -0800
Message-ID: <CAEf4BzaijbvqoajZGT+Gar57ACbCdNJcmBtYbfO2DdOhDevhNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Update ima_setup.sh for busybox
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 2:39 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * losetup on busybox does not output the name of loop device on using
>   -f with --show. It also dosn't support -j to find the loop devices
>   for a given backing file. losetup is updated to use "-a" which is
>   available on busybox.
> * blkid does not support options (-s and -o) to only display the uuid.
> * Not all environments have mkfs.ext4, the test requires a loop device
>   with a backing image file which could formatted with any filesystem.
>   Update to using mkfs.ext2 which is available on busybox.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Thanks for the fixes!

You have three related patches, please add a cover letter to the patch
set as well.

>  tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 15490ccc5e55..d864c62c1207 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -3,6 +3,7 @@
>
>  set -e
>  set -u
> +set -o pipefail
>
>  IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
>  TEST_BINARY="/bin/true"
> @@ -23,13 +24,15 @@ setup()
>
>          dd if=/dev/zero of="${mount_img}" bs=1M count=10
>
> -        local loop_device="$(losetup --find --show ${mount_img})"
> +        losetup -f "${mount_img}"
> +        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
>
> -        mkfs.ext4 "${loop_device}"
> +        mkfs.ext2 "${loop_device:?}"
>          mount "${loop_device}" "${mount_dir}"
>
>          cp "${TEST_BINARY}" "${mount_dir}"
> -        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> +       local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"

tabs/spaces mix up here?

> +
>          echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
>  }
>
> @@ -38,7 +41,8 @@ cleanup() {
>          local mount_img="${tmp_dir}/test.img"
>          local mount_dir="${tmp_dir}/mnt"
>
> -        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
> +        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)

didn't know about :?, fancy


> +
>          for loop_dev in "${loop_devices}"; do
>                  losetup -d $loop_dev
>          done
> --
> 2.29.2.576.ga3fc446d84-goog
>
