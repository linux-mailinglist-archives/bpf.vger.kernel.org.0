Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8621D424B2D
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 02:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhJGAib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 20:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhJGAia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 20:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C0CA611CA
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633566998;
        bh=VQE1V/DJAPN0nmYGDrGNxnV0VaTLTfTuGLEeWJ/zPJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OE2eryM1pddgomffw3D52jaJGYaaVZwsSL555dy9cH2/t19w/hnsjEz6FHufJBpX/
         WihLkj/L/11yUYWnXgBd8LsaK2TjylboO1vFBimfgNqaq0aNZcpmD3Cyi9mtOjxElG
         zNJmFFlwl5pKPvGwWh/HqmntC/+L65v/Lkl4jZQKdo1qEplA2NycDbhtF1AmnsdWx8
         tRlazLU7t/ahGfzdUaHH+VleAjUIXNqg1+yl8XUXDqJAZ7dSKdrzqqDxd6pnUsNp6D
         ej2cllYTSDSdBN3X53llCIFm5S9K17cRPUbeiXfNbCHVccIVQWBs+yQOyswpWn91fC
         gYXODLrHHKr1A==
Received: by mail-lf1-f51.google.com with SMTP id j5so17470052lfg.8
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 17:36:37 -0700 (PDT)
X-Gm-Message-State: AOAM531Gu/uCqDPdF8E8BXECb2QgZEglIG6kF/G3d0I+NeZ5mMkV+ppt
        gVHPuWLCh5XIClauK8S5p4S9Sta0jrPyticUePw=
X-Google-Smtp-Source: ABdhPJwXM+QyL7EoF8ft3RNzQIiiHoU4rCTqyRv1e6isIaKUc0ElLWWeHwSfdD7bHIZHdjlnyo7kbbFi5bs5wxIlUZY=
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr1192766ljc.527.1633566996385;
 Wed, 06 Oct 2021 17:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <f90f33fb1eacfaf69874e3c769f0cd81ada61e8a.1633535940.git.zhuyifei@google.com>
In-Reply-To: <f90f33fb1eacfaf69874e3c769f0cd81ada61e8a.1633535940.git.zhuyifei@google.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 6 Oct 2021 17:36:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7K_qa2KNBbz-eA6P7kQfCS=jwQUEOSiHMifmMyfR03KQ@mail.gmail.com>
Message-ID: <CAPhsuW7K_qa2KNBbz-eA6P7kQfCS=jwQUEOSiHMifmMyfR03KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Make BPF_PROG_RUN_ARRAY return -errno
 instead of allow boolean
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 9:04 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> Right now BPF_PROG_RUN_ARRAY and related macros return 1 or 0
> for whether the prog array allows or rejects whatever is being
> hooked. The caller of these macros then return -EPERM or continue
> processing based on thw macro's return value. Unforunately this is
> inflexible, since -EPERM is the only errno that can be returned.
>
> This patch should be a no-op; it prepares for the next patch. The
> returning of the -EPERM is moved to inside the macros, so the outer
> functions are directly returning what the macros returned if they
> are non-zero.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
