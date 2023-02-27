Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDAB6A4D92
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjB0VxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjB0VxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:53:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A83C145;
        Mon, 27 Feb 2023 13:53:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg37so31606210edb.12;
        Mon, 27 Feb 2023 13:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9z124L20+hh0HCTcO7AmeuiFRfRqYkVMIUFf5toEJs=;
        b=NGPYEbDWEhSbOy6wnJ2m7XIky7l5xE3MF5HAnxi42VXm5C0eLVxz/rHMMsgc4ZbjqX
         5khgFYU7rJaPNw7pD1i3pqApw7TSXLTvwYtm0fY+HHsYMseY2cRhhkDZOXgijhQz4jA8
         BajWlcQJrCiCcJuES9SbZIb8XfBQokBbCJlzlM9iI9DWJvUEtPkgkTVWABwJNC0OogDx
         VdO5tU7qQGEMmadCfVBL1o/w8SzdXoOcJg+fasa0lrULwOaE0DblvBPf5gJgJupNQBp7
         wWNk0naBQ3alcQv/tARNhi094s+a2gbbq3NhSxFTIyvedjUXnXIXfrCNMXN4V3pHP1zM
         ITXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9z124L20+hh0HCTcO7AmeuiFRfRqYkVMIUFf5toEJs=;
        b=LIvropUqgp58jDjvE3a5+pe97QIuLup5LteJY2TwU2JxoYQ0YWNR725B0rcbq6pLSp
         /HUCc1n7d7bFoj0BoGPMaf9iez379bAhKfXqi8cfPLe+DJRTzW1eYoqmpCXK394q+IIz
         2F5aMm+6qVrXJys6e6oCVYx/6EJDQUjfVSvMV3Jso3VjRM1MOJZRUPyLrFa9BJpevogM
         av6tDD/oxqHzo6GAvR5qMK0Kw7+7wODtWyMSFoK5c1S4W8g7o82rt6J8mXYhyCqbJSN0
         BSGRfHMvB0dXb8KduDtQH7zNhrWF1bdrpVzdpizigPbp71jyJ1ys1BlgDXgcSq7v/PZf
         ngVw==
X-Gm-Message-State: AO0yUKUhMwE9J5PsxZhDrBsh8k9hHSuaNBQCatli1CjoXRPbA2EWv34T
        xUMqHB1EXs/5XujX2GHkJDX0706NF+vc1J/VC5I=
X-Google-Smtp-Source: AK7set+gHPmXspe3hy+PNeH9+HNlPSO1DERqWhmqOOgQltNSdEDqhehgsls0/3Xcs4yd7/DVrgFNv7u2l0M6clq5at4=
X-Received: by 2002:a17:907:60cd:b0:8b1:3540:7632 with SMTP id
 hv13-20020a17090760cd00b008b135407632mr7168607ejc.2.1677534788434; Mon, 27
 Feb 2023 13:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com> <20230221025347.389047-3-imagedong@tencent.com>
In-Reply-To: <20230221025347.389047-3-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:52:56 -0800
Message-ID: <CAEf4Bzac+SmdosLf=nnieuEBx6azVTg1_fVNWScsWb9-Hap6pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: split test_attach_probe
 into multi subtests
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In order to adapt to the older kernel, now we split the "attach_probe"
> testing into multi subtests:
>
>   manual // manual attach tests for kprobe/uprobe
>   auto // auto-attach tests for kprobe and uprobe
>   kprobe-sleepable // kprobe sleepable test
>   uprobe-lib // uprobe tests for library function by name
>   uprobe-sleepable // uprobe sleepable test
>   uprobe-ref_ctr // uprobe ref_ctr test
>
> As sleepable kprobe needs to set BPF_F_SLEEPABLE flag before loading,
> we need to move it to a stand alone skel file, in case of it is not
> supported by kernel and make the whole loading fail.
>
> Therefore, we can only enable part of the subtests for older kernel.
>
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
> v3:
> - rename test_uporbe_ref_ctr() to test_uprobe_ref_ctr() to fix the
>   typo
> ---


One of the patches in this patch set broke BPF CI ([0]), please take a look

  [0] https://github.com/kernel-patches/bpf/actions/runs/4267719970/jobs/74=
29701318

>  .../selftests/bpf/prog_tests/attach_probe.c   | 268 +++++++++++-------
>  .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
>  .../selftests/bpf/progs/test_attach_probe.c   |  23 +-
>  3 files changed, 208 insertions(+), 106 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_=
sleepable.c
>

[...]
