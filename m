Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C4425FD2
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 00:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhJGW3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 18:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233370AbhJGW3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 18:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031F961130
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633645681;
        bh=i89fDCUZrswvhyhcNn6wcFQkEAf1ur1A5nx1V5o+RP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VKwvMf+v2FOfwudy9t+5E3338e5+1TJLpgyWbhIpoaCSAEpCRPZdeALZh1UW2u717
         oqM1KFaw0DwmxV7YevOLXihUHWoVNnntwnjcWnWktx0hUldnVB8gIiwsAXDochQK5n
         hibf2DIbZxncK6AJaRDdQ75fxpWpcaTjXlKLJQCipMx7I/xpekM2n7F7ML675iEiWe
         k5rcw4LU2rQsdDUYx7Ph31LESZCyKes//QgqaFNNNeNrDLfy5x57a8eZVOgMhiNvDz
         ebjowdtUUTWg561QxGCUk2Mi1gI9gAE61+Nv1B0Uy9BYWYkWwpE3dISoleQJsCwlWh
         NBKbP2dthypgw==
Received: by mail-lf1-f47.google.com with SMTP id n8so29232616lfk.6
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 15:28:00 -0700 (PDT)
X-Gm-Message-State: AOAM532rcehKqZXKbk4V5y49Zvuz4C327GD9cOfNiIsw9czFxSwwKiL0
        c2SsXSnMse4zSqlTnzZcbkCihm6MxEPFCmdgtU4=
X-Google-Smtp-Source: ABdhPJzU3C/6cxVf17k2IxMaQlbsQCvrIxBthsdoT4R7SLqSDTje9mNTdEyI+PnxvHTfIM9EAgkovYSa/YwIiJ5E3Kk=
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr7201192ljc.527.1633645679341;
 Thu, 07 Oct 2021 15:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211007173329.381754-1-iii@linux.ibm.com>
In-Reply-To: <20211007173329.381754-1-iii@linux.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 15:27:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW51tYCC99NVVF3iWarE9qza-sAv1wP456Ooy_bvw8+JMA@mail.gmail.com>
Message-ID: <CAPhsuW51tYCC99NVVF3iWarE9qza-sAv1wP456Ooy_bvw8+JMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, selftests: Skip verifier tests that fail to
 load with ENOTSUPP
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 12:44 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The verifier tests added in commit c48e51c8b07a ("bpf: selftests: Add
> selftests for module kfunc support") fail on s390, since the JIT does
> not support calling kernel functions. This is most likely an issue for
> all the other non-Intel arches, as well as on Intel with
> !CONFIG_DEBUG_INFO_BTF or !CONFIG_BPF_JIT.
>
> Trying to check for messages from all the possible add_kfunc_call()
> failure cases in test_verifier looks pointless, so do a much simpler
> thing instead: just like it's already done in do_prog_test_run(), skip
> the tests that fail to load with ENOTSUPP.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>
