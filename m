Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1034220FB39
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbgF3SAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbgF3SAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:00:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E47C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:00:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so23655594ljc.8
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDN1sKFOQsCW+DDYXAqeHWLrPECMCPoQZlHzTd52gUc=;
        b=eaB7Ug6tU9EitrE/CbaYfbutJtnkTVAbW1I1jIjUM69LSjRuX8tOjNiZeKD5GgRVPz
         8XvH3WjIiKoXtGczYWQmh/DtMFb0OwtsrvQjXYioSsi3qOAy+IZWtjJ6QgqcvfEtOMCY
         yumWh+MtLcix7MqlxCRmlFuJGU+VWZJXiu+sdqLUMLEVYBXEszDeorrS0ijqzivEzG43
         b0Hg5L6Aw6jg5W51sOg1mHK1n16RttvCsgYMHnEQWm5AAXnNxRX5/08T9Xi2H3MKTlTi
         SMokaP7TRym4HA5/jQhahFMYIpXSqxKei4sDy8/HyI1OLhcTmdm8FjAuss7yHQqxU5vB
         P1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDN1sKFOQsCW+DDYXAqeHWLrPECMCPoQZlHzTd52gUc=;
        b=qx75xcL9cI5eTUmCHl6InRDcyQVRGQ1f9iBG9ylDL2DemYcfmcCS7cz2OlxucEqJkf
         sqosd8I49CyKn3vFoXtJw2aqGdJx+C8maAhVAkN1VSFCnS5O7Fp2H8O7Z5582Nr3hAed
         VY2Hj0VFBM1mYIEgRh+LvZsEn0wburs82+GB5j3U6xnxM9tKT+eyqi9nukEc+To7ynJW
         2VEAZFjMkPS4WNnkcqkCBZuM9JnVDasGGM+clA6NzTugAyc2vdbvPUVH2ieidSxhXQOq
         qJ53vVADKpcsunuVvl86dTTZEC8jD1auXRzR+1psog57klqbrI5EFZq9xSsRmkMF8jKg
         V2Zw==
X-Gm-Message-State: AOAM5329hTe3agews9eK/HR+0pCFfWxzpnRcBI0is07kDXYYmXpFJzdm
        Kr5YstgL+6l7rmg6I820NbY8bieH+oTLKYuMlQs=
X-Google-Smtp-Source: ABdhPJx6ETJE9tVQ2jyuBeouoBrzYIgge8oKTGdqO2rGEn7w0IJFi8e3Q1gQpiLBwO11eO+MVhbhn5gVCw5ehxNdNRg=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8mr1540551ljl.51.1593540022672;
 Tue, 30 Jun 2020 11:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com>
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Jun 2020 11:00:11 -0700
Message-ID: <CAADnVQ+VN6nUCQC51nByeKa+uHG=O-GyzeEpWQgJ8OP815RB2A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 2:59 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Both sockmap and flow_dissector ingnore various arguments passed to
> BPF_PROG_ATTACH and BPF_PROG_DETACH. We can fix the attach case by
> checking that the unused arguments are zero. I considered requiring
> target_fd to be -1 instead of 0, but this leads to a lot of churn
> in selftests. There is also precedent in that bpf_iter already
> expects 0 for a similar field. I think that we can come up with a
> work around for fd 0 should we need to in the future.
>
> The detach case is more problematic: both cgroups and lirc2 verify
> that attach_bpf_fd matches the currently attached program. This
> way you need access to the program fd to be able to remove it.
> Neither sockmap nor flow_dissector do this. flow_dissector even
> has a check for CAP_NET_ADMIN because of this. The patch set
> addresses this by implementing the desired behaviour.
>
> There is a possibility for user space breakage: any callers that
> don't provide the correct fd will fail with ENOENT. For sockmap
> the risk is low: even the selftests assume that sockmap works
> the way I described. For flow_dissector the story is less
> straightforward, and the selftests use a variety of arguments.
>
> I've includes fixes tags for the oldest commits that allow an easy
> backport, however the behaviour dates back to when sockmap and
> flow_dissector were introduced. What is the best way to handle these?
>
> This set is based on top of Jakub's work "bpf, netns: Prepare
> for multi-prog attachment" available at
> https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/

Folks, you should have used 'bpf' in the subject of Jakub's patches.
I've dropped Jakub's set from bpf-next and re-applied to bpf tree.
And applied this set on top.
Thanks!
