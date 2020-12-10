Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876B42D625D
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLJQrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 11:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbgLJQrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 11:47:03 -0500
X-Gm-Message-State: AOAM532oWcMLzoCEuU7obA2grufCmaBs3v5aTL2UiR3CsQQXQNyuIAix
        ygX+elv48r5Uq5v6RRzGPL6uzsLHJI2aFWOSZbAomA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607618783;
        bh=P4xOVs5lT2ILkg1FXMNwGPeExVVRw4nLvd0EKRebOkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSffpouLgybABdy5r2AfYcO0wXlz+wqGey+1fg6z2vGMT2azsvPrGw4sSjZJrv2NI
         9DOVkER5oBZW4U41/0+k0vDApRSZwklX7krx8cFs6i0Eef3RIMSv4P3bj7pJiCkWDh
         HdRB7vct1oqX2X6WxlzDQbSECmbt1M2keynX46gINpJk/4pY8qsM9XFRa9BSza3j/r
         L0VCQwUzg/DgTGX9qBxdg5SauySU8FKAqb5/2WFFU7wzl2ncvsAHnzYT56HW09LK83
         bUI2SdNlPYzY52qxa9VwP39ZVAKneSoDJ0pGcxgdMYZcU8TbrCJSvyLUGXQNAKf12I
         mAh4n/nNS/AKw==
X-Google-Smtp-Source: ABdhPJyKZzv8at0BHYSnhm/wBm7rPfDbzGMjGgNZbmCfVFCp0Oe3Um1x3yiYcss5adRwcxLz7Nr1nnOVOzpt2/6PvX4=
X-Received: by 2002:a05:6512:329a:: with SMTP id p26mr2892482lfe.96.1607618781237;
 Thu, 10 Dec 2020 08:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20201209000120.2709992-1-kpsingh@kernel.org> <CAEf4BzZC+Oz3BL5m4aAbtSKsz-6xBrH42C0CvDZbBT=ubH8gMA@mail.gmail.com>
In-Reply-To: <CAEf4BzZC+Oz3BL5m4aAbtSKsz-6xBrH42C0CvDZbBT=ubH8gMA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 10 Dec 2020 17:46:10 +0100
X-Gmail-Original-Message-ID: <CANA3-0c-b9ns7b1vfSwG2D3jSaoBJHYd+CnfME01T5QmDwu1Lg@mail.gmail.com>
Message-ID: <CANA3-0c-b9ns7b1vfSwG2D3jSaoBJHYd+CnfME01T5QmDwu1Lg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Silence ima_setup.sh when not
 running in verbose mode.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]
> >
> > +       if [[ "${verbose}" -eq 0 ]]; then
> > +               exec 1> /dev/null
> > +               exec 2>&1
>
> can't this be done with one exec, though:
>
> exec 2>&1 1>/dev/null

Yep, fixed.

>
> ?
>
> It also actually would be nice to not completely discard the output,
> but rather redirect it to a temporary file and emit it on error with
> trap. test_progs behavior is no extra output on success, but emit it
> fully at the end if test is failing. Would be nice to preserve this
> for shell script as well, as otherwise debugging this in CI would be
> nearly impossible.
>

Yep, this is better for debuggability. I will update and send another version.
