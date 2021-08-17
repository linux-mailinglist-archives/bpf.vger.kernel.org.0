Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27A3EE0AA
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhHQADM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 20:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhHQADH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 20:03:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 273A360F46
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629158555;
        bh=gxv3TzyObxf81sffdDa6zg4Mu6eP7I2vh4B/K8473nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QZ4RED+8KLYJe9SRpOKSyFCF+DVwGQYe7A6vdp4WqgItAwTktkdJS/5BTk6I7nevn
         kXZ+RsXJpr9vMC1Z9X66Mm/pxOgisvYHRkjCrw3xG1afUhByekv+6paHXgGFHqrlU8
         bsetODZazpqTDigbEbwJGkAm+nAtycqGsZgVIg3giwIRrdHV0zMEB/VMvLHo968686
         zlWa0Vvr8l14/+nwzkbL/tpvU69MYGJKxQtQ1FGBmowI2j4g2XR1Ibh6EPSr+QRYWP
         hHT16MKLA5wD4xJOsDSRNeuyHnCwLf6vIm7e62zu/R4oh5rfifc7vkrNFaP0WBY9ru
         i6iiYen3kA5IA==
Received: by mail-lf1-f47.google.com with SMTP id w20so37842084lfu.7
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 17:02:35 -0700 (PDT)
X-Gm-Message-State: AOAM531PrIGIlW3pNvU+/TB9YMXPo5/r2+BWHKk+q5FOKGQQlR5Vpxtw
        92qA0T+v1e7XHNv5cCKMZODRKVuR11gCUoEY3TQ=
X-Google-Smtp-Source: ABdhPJyfNAABF688P8ZptZ7407++VFlnPGR9ngHAF4YxFMgzPDVItQXLl7hcmNetfSXVYcWmycsYWucUqvVVZ3l9Sh8=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr257463lfm.281.1629158553519;
 Mon, 16 Aug 2021 17:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210816231716.3824813-1-prankgup@fb.com> <20210816231716.3824813-2-prankgup@fb.com>
In-Reply-To: <20210816231716.3824813-2-prankgup@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Aug 2021 17:02:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4x5YBdwAVA8SAjpwrcAFhTt2ifO2PM5eT1LHoqyfBxpA@mail.gmail.com>
Message-ID: <CAPhsuW4x5YBdwAVA8SAjpwrcAFhTt2ifO2PM5eT1LHoqyfBxpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket
 options from setsockopt BPF
To:     Prankur gupta <prankgup@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, prankur.07@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 4:17 PM Prankur gupta <prankgup@fb.com> wrote:
>
> Add logic to call bpf_setsockopt and bpf_getsockopt from
> setsockopt BPF programs.
> Example use case, when the user sets the IPV6_TCLASS socket option
> we would also like to change the tcp-cc for that socket.
> We don't have any use case for calling bpf_setsockopt from
> supposedly read-only sys_getsockopti, so it is made available to
> BPF_CGROUP_SETSOCKOPT only.
>
> Signed-off-by: Prankur gupta <prankgup@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
