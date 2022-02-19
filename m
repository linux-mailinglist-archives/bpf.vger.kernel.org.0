Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D954BC4A2
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 02:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiBSBsX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 20:48:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSBsW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 20:48:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE73A24092
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 17:48:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AD85B82741
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 01:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74A2C340EF
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645235281;
        bh=Pj032YNm1G4tODZYAITQoc+iO6pKRv4v7ZXQOc4Mmg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bfp8cTG1ErdQO45Lfswe9xcSCdR+OrxYZyJB3plwgLmriZHN0CbHfU6hykFnhkG0m
         GDASpk7SeR60qxBRYWyVYp9dBHSOElLFTmhSW+GNYKvj96q5TkRgOdS/W3sTgihq7K
         IH7ide2aFR+Z/hZ532oJsEKmi8Pv2gsLLh1Wdu+qNfV7WyJNFWEjTp7nabnGkQKpne
         RJnx7aPSSYQ6tTHA/7p38aE94Am8aHfXzgCDK8MyGjO0ri/7IIPSeISXAAOmPqRWCV
         REGTXxkJ7d9+FeUh+ov47EqZdNm+LqC/rd1U6oPL8E0PcWwU9LcQwYUV9ix16zy+u7
         pSFPWFeM3oIoQ==
Received: by mail-yb1-f174.google.com with SMTP id v186so22934845ybg.1
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 17:48:01 -0800 (PST)
X-Gm-Message-State: AOAM533KenD7qKDydG24IiOW8MqiuYha/lMFpzhPGgMpnjOSPwZvB/2V
        k19bGFYFrTVjggzQEMyz5wzDf11DQHVmc+o70Ss=
X-Google-Smtp-Source: ABdhPJxYDol48Ug59q58/l9mwluxKfWJ6EUWAwcOYezNqPyiJ4Dgq/HNMp1mPJbvqM53MT5cJTGUAF7M/1MWfp8OoVY=
X-Received: by 2002:a25:d60c:0:b0:610:dc8d:b3bd with SMTP id
 n12-20020a25d60c000000b00610dc8db3bdmr10022148ybg.561.1645235281058; Fri, 18
 Feb 2022 17:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20220219003004.1085072-1-mykolal@fb.com>
In-Reply-To: <20220219003004.1085072-1-mykolal@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 18 Feb 2022 17:47:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Rz_9bzXK-X-i2uc3aeQdCbY+b3QfRFvTN9HrraCs0ZQ@mail.gmail.com>
Message-ID: <CAPhsuW4Rz_9bzXK-X-i2uc3aeQdCbY+b3QfRFvTN9HrraCs0ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 18, 2022 at 4:30 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> In send_signal, replace sleep with dummy cpu intensive computation
> to increase probability of child process being scheduled. Add few
> more asserts.

How often do we see the test fail because the child process is not
scheduled?

[...]

>  static void sigusr1_handler(int signum)
>  {
> -       sigusr1_received++;
> +       sigusr1_received = 1;
>  }
>
>  static void test_send_signal_common(struct perf_event_attr *attr,
> @@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 int old_prio;
>
>                 /* install signal handler and notify parent */
> +               errno = 0;
>                 signal(SIGUSR1, sigusr1_handler);
> +               ASSERT_OK(errno, "signal");
>
>                 close(pipe_c2p[0]); /* close read */
>                 close(pipe_p2c[1]); /* close write */
> @@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>
>                 /* wait a little for signal handler */
> -               sleep(1);
> +               for (int i = 0; i < 1000000000; i++)
> +                       volatile_variable++;
>
>                 buf[0] = sigusr1_received ? '2' : '0';

^^^^ this "? :" seems useless as we assert sigusr1_received == 1. Let's fix it.

> +               ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
> +
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>
>                 /* wait for parent notification and exit */
> @@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
>
>         /* trigger the bpf send_signal */
> +       skel->bss->signal_thread = signal_thread;
>         skel->bss->pid = pid;
>         skel->bss->sig = SIGUSR1;
> -       skel->bss->signal_thread = signal_thread;

Does the order matter here?
