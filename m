Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825FB5722F
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFZUFN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 16:05:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40806 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUFN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 16:05:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so2440931lff.7;
        Wed, 26 Jun 2019 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2zmKJo2VtijLlWc4slNGMFioWOkeMTocZiK11ccxII=;
        b=CjAsEbbCoxJByXYTLbRXo2DNrikWbe3orPG4AFaj5saY5KjaJjAGs17ilXPQKVVx9c
         7rGMijHgtUBknkD6z5sL3OraKHsm1jtiHAVWXJvtdCE2gJ+SRkAltND8qHfVEhY/+aJ9
         ja8juk+ss1Mdp5Al26LUgPEzfMrk1zWHiDAXJ0liif9hFo4zKIB/VElDOuUOlYSy8V6R
         h93MANRtYoSUWpulyYaQPk2k6W1VLWgTpg9e7RHYz3y7pNsQyL4bhURmM82PuZMSxyMH
         N1O5Vm5hSHUTm9tSZ4qNQIoCMH0cSWO6Ljoq4hH8BKqkWg9MIQhW+CWpZdmoUJQ3Hugl
         KNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2zmKJo2VtijLlWc4slNGMFioWOkeMTocZiK11ccxII=;
        b=GoxxCxRGVEypznW7oDLmtR0U6hUxSHIX1LrM6e56pFKBw9z3xd27Q0957obL+dTR2+
         4/YGVvddPLt6ni89MNfY7kFQM+VFj9tMr6deK/4oeAkm6msiadPWDeTasACGLoL9/wHT
         ugVnqHf/3mS6NjtTCxQwzqoIwD0i9bhEzABe/Ef9WqmuR0odd2JmUwc5+G+nZsPcsK4n
         /I5KfkCbWaUKV2OdaI7yGNaC5oyo9JT/6QIaanLlHVUIhAykGep6zGqedMfK/+3YcWmi
         /tmLmWpvxyH+8PJiS/47a8wUyoflHOORQkEHTJsFMmEScb0jO/g+nMbeCeqGUM16XZU1
         kLXA==
X-Gm-Message-State: APjAAAX4F9vbpYhdjAtZ88YtjzvK9zUqVQBJEc56BkJQnFpSYj8/pd/I
        r70N2WzvkZvaF+U78e/BczduhvIxANJZSOCr/ZY=
X-Google-Smtp-Source: APXvYqxzn8aLoF5ivVzptd25fkmnfutmDPv7fJI/F/I1IpUhl6t7Jye9DvgsU4wu9s1jYbque2urbRjt+UhTm5cPO2g=
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr3728351lfg.19.1561579511372;
 Wed, 26 Jun 2019 13:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190625213858.22459-1-guro@fb.com>
In-Reply-To: <20190625213858.22459-1-guro@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 13:04:59 -0700
Message-ID: <CAADnVQLMG5_Liz_UkG7m3mN0r9ZOwkCdAOmWgbgdgir6t+tBfg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: fix cgroup bpf release synchronization
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 25, 2019 at 2:39 PM Roman Gushchin <guro@fb.com> wrote:
>
> Since commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
> from cgroup itself"), cgroup_bpf release occurs asynchronously
> (from a worker context), and before the release of the cgroup itself.
>
> This introduced a previously non-existing race between the release
> and update paths. E.g. if a leaf's cgroup_bpf is released and a new
> bpf program is attached to the one of ancestor cgroups at the same
> time. The race may result in double-free and other memory corruptions.
>
> To fix the problem, let's protect the body of cgroup_bpf_release()
> with cgroup_mutex, as it was effectively previously, when all this
> code was called from the cgroup release path with cgroup mutex held.
>
> Also let's skip cgroups, which have no chances to invoke a bpf
> program, on the update path. If the cgroup bpf refcnt reached 0,
> it means that the cgroup is offline (no attached processes), and
> there are no associated sockets left. It means there is no point
> in updating effective progs array! And it can lead to a leak,
> if it happens after the release. So, let's skip such cgroups.
>
> Big thanks for Tejun Heo for discovering and debugging of this
> problem!
>
> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from
> cgroup itself")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Applied. Thanks
