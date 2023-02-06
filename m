Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0968C73A
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 21:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBFUFy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 15:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFUFy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 15:05:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AECB1F4B0;
        Mon,  6 Feb 2023 12:05:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p26so37432404ejx.13;
        Mon, 06 Feb 2023 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VARMVoJDZnLHdBAe/S8eMwwfBJvRO3Co6HTMJQN8y6o=;
        b=XMfl/fUCnVJMKzuTqLLGwn/lXfPVYwyxB7iUqh9+gASKCANmffE4nxRI7O8oKRKbh6
         bZeuOm4jJhH7eK1BddaupJ8Wm5JuVOQkbv0L3AO7DmskkySJh7AW/GEcrm7S4IW6eCXX
         qWUpN2FSPVDo3H8VYKLXAjP9pq7qkRV9M00mtEqBYwQ/OXRjXQ5VbTMPQ3Lw9cvL4xC3
         ZY3UEqUo7PwWyixgPLGVA76IBlT6IhlZfRzLZnKbN/nRpiUL/79mciENQVTe7gun4l3s
         pzMycn1F3oeeRCl+NPS5cETLYgr3Ot3WNKXlnmvvOfXG3DWvewxElZ0ugVO/xQhvBMpB
         6GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VARMVoJDZnLHdBAe/S8eMwwfBJvRO3Co6HTMJQN8y6o=;
        b=pH7YAEn0t4LwzFZtJ258ruBAoFxiMAg8sLUI1Ol3vBhVtfhIyY2/SUbBjahxje9iVG
         +lWxfH+GsbVOYVRhCnBMASxtWufDkCOeW+PF4nf7M+TBU1ZuqAMBLZucTVpzZhUpX0RN
         TrzI96bHcOhYL/6wpWbrIyFJ/RJXC5zBbgEs87FZRqtXgpKosOsh5H0Rx5RGt2W/dpB7
         jgtRv3d4vay6nmQAhzDGifaQGjokZezi6QOqAlE6Ui/Wjd/r9Gpp3aFMd9BTRVArh9FH
         hJBRu2vu+8YnSG05N2/eUHixPaDIsPdbmY9i093bS9Tz7qx6agrF2xW2bExRTj6ISAWp
         CpUA==
X-Gm-Message-State: AO0yUKUDILnbA4gqPxSQWDnpkLbEexW26SHOkNHvA9yq/RkDwqkuPaIJ
        Df+zlnvDOYT6UKADnBpBafiywFeyb+O6SDemyII=
X-Google-Smtp-Source: AK7set+dCI3964CMaYDK/u84slaqfWkyzXT370+yoCYdkf/9QZnKAg6ajp1NsgbOga1t+z098IaqdVRHTDY+5SoEfJI=
X-Received: by 2002:a17:906:924c:b0:877:5b9b:b426 with SMTP id
 c12-20020a170906924c00b008775b9bb426mr168613ejx.12.1675713951754; Mon, 06 Feb
 2023 12:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com> <20230203031742.1730761-3-imagedong@tencent.com>
In-Reply-To: <20230203031742.1730761-3-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Feb 2023 12:05:39 -0800
Message-ID: <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> And the testing passed:
>
> ./test_progs -t attach_probe
> $5       attach_probe:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---

Do you mind refactoring attach_probe test into multiple subtests,
where each subtest will only test one of the attach mode and type. The
reason is that libbpf CI runs tests with latest selftests and libbpf
against old kernels (4.9 and 5.5, currently). Due to attach_probe
testing all these uprobe/kprobe attach modes with extra features (like
cookie, ref count, etc), we had to disable attach_probe test in libbpf
CI on old kernels.

If we can split each individual uprobe/kprobe mode, that will give us
flexibility to selectively allowlist those tests that don't force
libbpf to use newer features (like cookies, LINK or PERF mode, etc).

It would be a great improvement and highly appreciated! If you don't
mind doing this, let's do the split of existing use cases into subtest
in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
of that patch.


>  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)
>

[...]
