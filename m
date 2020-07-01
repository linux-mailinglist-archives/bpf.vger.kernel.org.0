Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09F121155D
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGAVs4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGAVsz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 17:48:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D0C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 14:48:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so23742681qke.4
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D18JfeE2Nsc4ByUqIclByhIkqZd06DfKWvj88Etp6y4=;
        b=H2R8HvIk16sM1MuXKpMhZX+q+oOq9gg0CCC9QMy+fzUZLb/AqewzSP/SWYG5CA0+tv
         +BNzM3Uvy4/9JSFzpHhj2jIqmA0fiXvMpndUBbmsxkFUBLdyjnxe/tEevWgXXvi1OnKQ
         US1vrpzHeP7uxdkZ1X0ZoC2hqDBRz5MKFDyY6A0vJACiw2u6mqwBAp33VDGgCerjF4F8
         F9sJPoA7ijB/6WI5T/5kgXo8UPo+T/Q+6Fef/GbX1o4OzzL6sBDvS27ZTlP40hEsEfVm
         VrVQPluNSAtoxrmfidownR2I70pLsFadV164exQX38jQmw6G3kk+46tvsc3/Q8TvBK2T
         UjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D18JfeE2Nsc4ByUqIclByhIkqZd06DfKWvj88Etp6y4=;
        b=aPq4MHb/hYNdTeVBTCScIP8SdnAyGaENr1kMMiQr2eOfMs9jh/NnOgI//vluXbtOO1
         yWNFkCza7QyBVcb2etu1LKWeXIQGyL+0meheRing6265X7HAlwVcSRoJH+4Ca0Z4HkV1
         /EylDilyiHv1N7S/MmuiWaz/+2zIT6jwN/S+DKu2tILOCzx3DzN2nn6SW5TOrFSGuV94
         X1v1ASwvvL1bT0dq3CuxlrRpYfQLC0SztIUp8JIc5AzXy5WE4Va3DwbZ01N59BTwzcer
         yB9ZsE3V6DoN70N+F7/c2qVslECeQ9PFsj894O1zkuHdtfSDA6V623HfttvkSzama0TC
         jeeQ==
X-Gm-Message-State: AOAM530IHOqW+ew/mUlKq20eq8MYIh1bkxpE/RTZEk7tvoFUjqMDx4bA
        u1blcBwscxHz7CbRA08VV9bzgI2RqtX7ABZ24p8=
X-Google-Smtp-Source: ABdhPJyC4HUuLE0Klk5AOdb8QQzFYLr7KPj356Z3wUC9ZyqlVcZkcsIECFdb3XSomxhgqU/kr4ySxEVYid5Spb4Wae0=
X-Received: by 2002:ae9:f002:: with SMTP id l2mr16567768qkg.437.1593640134758;
 Wed, 01 Jul 2020 14:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <159363976938.930467.11835380146293463365.stgit@firesoul> <159363985751.930467.9610992940793316982.stgit@firesoul>
In-Reply-To: <159363985751.930467.9610992940793316982.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jul 2020 14:48:43 -0700
Message-ID: <CAEf4BzaMyQTvgnUv1diWSxhT+Q8+38B-DFmdQc63fFf490sLjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next V3 3/3] selftests/bpf: test_progs option for
 listing test names
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 2:44 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> The program test_progs have some very useful ability to specify a list of
> test name substrings for selecting which tests to run.
>
> This patch add the ability to list the selected test names without running
> them. This is practical for seeing which tests gets selected with given
> select arguments (which can also contain a exclude list via --name-blacklist).
>
> This output can also be used by shell-scripts in a for-loop:
>
>  for N in $(./test_progs --list -t xdp); do \
>    ./test_progs -t $N 2>&1 > result_test_${N}.log & \
>  done ; wait
>
> This features can also be used for looking up a test number and returning
> a testname. If the selection was empty then a shell EXIT_FAILURE is
> returned.  This is useful for scripting. e.g. like this:
>
>  n=1;
>  while [ $(./test_progs --list -n $n) ] ; do \
>    ./test_progs -n $n ; n=$(( n+1 )); \
>  done
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/test_progs.c |   15 +++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |    1 +
>  2 files changed, 16 insertions(+)
>

[...]
