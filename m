Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C652F7D0
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 05:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiEUDAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 23:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354400AbiEUDAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 23:00:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05031195BD0
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 20:00:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh17so5597297ejc.6
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8y1fSGTOmygkP390NLyY/duHVCTwNV3nBe97WgtbRU=;
        b=COupurDvuBPOCMLJjQz6y/ipZZMd7tYb2/urgCBJP7quhh+CDJBjfVFDetlGnsA9RM
         1TLdRkYYuEjrIT/W5x1oF9ouIZhs+/HxMh6wh1n1P4BLoMF4GRYrBOQZWXNIL5Dq47m5
         9HD54vSfGyOQB2ixyZfQuSCY5S2Muue6cwsjMopB7NvR6CouuQultysSfcp6kej1PWHC
         z208j5Qn/UaJVsy1/imC0J/gl1kgbZD+1iqDIZu4kAZsP1Z59jEWNqsvEVdwq2xUWDZ3
         BrRzo4EXJAtoTD3x5ZjivcpKNA+Ha1yIJspxKKJjXfSVdCw6KVZFZbmgcEF+Hqmg0GdD
         tb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8y1fSGTOmygkP390NLyY/duHVCTwNV3nBe97WgtbRU=;
        b=YE4p/OcDGchtgHdhnEbLxZcvXUePFa3dcEM6Yd5puImnB/sSWirg5Y51DlX4lYCd8a
         p+YuxLvv4q6Du0x4wJBgWX7iquUbtHbROVjuzPKynRgxFPV5pU528kWcVW5oufDdSDbV
         hvqp4J+eRNo4m2TNHek3666/6Ccu3iBLmKGlXzhg7EH6O5D1974MfwwfbAQTcLB+WFPL
         WRS9MA6YjFGBrfTCg7D/Cqw+gvD2ACT+HjNCTJk0+/ejeTq+OuzdtO8joe+5R4PdUAWO
         S6cguLKDrqxOJjt2OU9Op/7L4UxzeDOtc1wn+iSoIuvrXeqRYdRhjdXxfVd6or2+9HSY
         /Kuw==
X-Gm-Message-State: AOAM530h9A/897izyBT9PwtoIHs3BF89Q+67geaWpkvLK5WwlkRks4Zv
        UJUTfcLkt+oahv1z6Qqbfv/OJniowC2zfiCUWrQ=
X-Google-Smtp-Source: ABdhPJzfRcMAMeeoWMazdce+t2ma7ho+/HT1pneqRbsPNeakmny0oCnCMZQBGuyxA44KVQ/Mb3FUfrg8gJLqnDRwzb8=
X-Received: by 2002:a17:906:9f0c:b0:6f5:bed:d0a8 with SMTP id
 fy12-20020a1709069f0c00b006f50bedd0a8mr11221070ejc.94.1653102038462; Fri, 20
 May 2022 20:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com> <1652970334-30510-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1652970334-30510-3-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 20 May 2022 20:00:26 -0700
Message-ID: <CAADnVQKsz4jrajs3bNkz75gUgA2eQxTV93TfWLu6HL3FSm4a8g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: add tests verifying
 unprivileged bpf behaviour
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 7:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> +void test_unpriv_bpf_disabled(void)
> +{
> +       char *map_paths[NUM_MAPS] = {   PINPATH "array",
> +                                       PINPATH "percpu_array",
> +                                       PINPATH "hash",
> +                                       PINPATH "percpu_hash",
> +                                       PINPATH "perfbuf",
> +                                       PINPATH "ringbuf",
> +                                       PINPATH "prog_array" };
> +       int map_fds[NUM_MAPS];
> +       struct test_unpriv_bpf_disabled *skel;
> +       char unprivileged_bpf_disabled_orig[32] = {};
> +       char perf_event_paranoid_orig[32] = {};
> +       struct bpf_prog_info prog_info = {};
> +       __u32 prog_info_len = sizeof(prog_info);
> +       struct perf_event_attr attr = {};
> +       int prog_fd, perf_fd, i, ret;
> +       __u64 save_caps = 0;
> +       __u32 prog_id;
> +
> +       skel = test_unpriv_bpf_disabled__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       skel->bss->test_pid = getpid();
> +
> +       map_fds[0] = bpf_map__fd(skel->maps.array);
> +       map_fds[1] = bpf_map__fd(skel->maps.percpu_array);
> +       map_fds[2] = bpf_map__fd(skel->maps.hash);
> +       map_fds[3] = bpf_map__fd(skel->maps.percpu_hash);
> +       map_fds[4] = bpf_map__fd(skel->maps.perfbuf);
> +       map_fds[5] = bpf_map__fd(skel->maps.ringbuf);
> +       map_fds[6] = bpf_map__fd(skel->maps.prog_array);
> +
> +       for (i = 0; i < NUM_MAPS; i++)
> +               ASSERT_OK(bpf_obj_pin(map_fds[i], map_paths[i]), "pin map_fd");
> +
> +       /* allow user without caps to use perf events */
> +       if (!ASSERT_OK(sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_event_paranoid_orig,
> +                                 "-1"),
> +                      "set_perf_event_paranoid"))
> +               goto cleanup;
> +       /* ensure unprivileged bpf disabled is set */
> +       ret = sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled",
> +                        unprivileged_bpf_disabled_orig, "2");
> +       if (ret == -EPERM) {
> +               /* if unprivileged_bpf_disabled=1, we get -EPERM back; that's okay. */
> +               if (!ASSERT_OK(strcmp(unprivileged_bpf_disabled_orig, "1"),
> +                              "unpriviliged_bpf_disabled_on"))
> +                       goto cleanup;
> +       } else {
> +               if (!ASSERT_OK(ret, "set unpriviliged_bpf_disabled"))
> +                       goto cleanup;
> +       }

Alan,

same as in v3 the BPF CI complained when selftests are built with clang.

/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c:267:7:
error: variable 'perf_fd' is used uninitialized whenever 'if'
condition is true [-Werror,-Wsometimes-uninitialized]
                if (!ASSERT_OK(ret, "set unpriviliged_bpf_disabled"))
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c:301:8:
note: uninitialized use occurs here
        close(perf_fd);
              ^~~~~~~
/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c:267:3:
note: remove the 'if' if its condition is always false
                if (!ASSERT_OK(ret, "set unpriviliged_bpf_disabled"))
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Looks like clang found the real issue.
I've addressed with:
-       int prog_fd, perf_fd, i, ret;
+       int prog_fd, perf_fd = -1, i, ret;

while applying.

Please pay attention to CI errors.

To repro do: make LLVM=1 -j
