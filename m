Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914224B1A63
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 01:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiBKAZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 19:25:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbiBKAZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 19:25:38 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEA55A0
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:25:38 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h7so9561811iof.3
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Gg+0oVqNEX6Bb4x4dd0ObAvenQ4OLZwI2tBbJDssAQw=;
        b=A42WuzyffxQkQP+h+NsyQh+8pbxBinz+MPNU1+FI8sFkjF+r3Wij+6zsGwvwpOBPdv
         1l5ynypBAgf6H7ytXFFr0PTyxIXQhDw/MSxO8Nv1eBkofwxvpiLeukh3rfogFLQvauUv
         WpH8a/riSvS2Qk83JLKzX38KAfzYEg6IB+7jJjVzPHXsBcEhD9Him+jVbj+iHs1ufIAy
         VhCjZtd4mI7J/SSwHCBxXYPOPqKspZztx1fIkYVEnDQRs+upz9JpmxxlCvsj6WTZ3+/g
         hIF5jxpCK5rNyeSpTwYjHzKn66xGrrNZj6eFoX/NgvFSdgdZTZTf96yA6HqblnFiz7f1
         zBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Gg+0oVqNEX6Bb4x4dd0ObAvenQ4OLZwI2tBbJDssAQw=;
        b=eBoBoSkXYr9LcOaPk8ZwmzFOvGvE5cCUTCwNjz6ILGG3bateNGvhOrir8FqbxTf9Yv
         zEeRSB5aeGACZkF8B0ygdunp7QxMrSUE12TYKzO/Ve/SAPJKy0XKpLp8DaDgGMv7E5aE
         f2A9lpe2bf8e8dPrkf0BWLsWG5BOcLzO1ijrzMAekKgTDrZjJt40WhPwqQdNRbs5Vf8B
         UmAWB9t1iZEOJIlzrnJ9kEbhD30EPDQZZZ+LhXeEAIDnBoZwyoAOvBtu3i/bmVcfov/i
         ywn9HAxocUtTaxBE+9Kd6FWHdNXO4f9j0hJGxbqbfSIgnDUH/s1SoiDdvds1w6EPPqDa
         7Ymg==
X-Gm-Message-State: AOAM530ZgquhD5UyYn65MVpKZCb33nzxFC5oJ3ZriHjQy+yO7YEGh63M
        dxxpByMGh1RB5bvAdIOjyXntPXHqdVJpvjgQP0EzCauD7dM=
X-Google-Smtp-Source: ABdhPJxUpqeT96l7EWsZyrU/4AjjCeAMknUZCnObaesE4RpQ5eoTTWc+/oxCWAD7jOEF9Rf0Jcw6SUgbFwNNFAUIDFg=
X-Received: by 2002:a02:7417:: with SMTP id o23mr5644622jac.145.1644539137655;
 Thu, 10 Feb 2022 16:25:37 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Feb 2022 16:25:26 -0800
Message-ID: <CAEf4BzYZqzAaJxbC=onWn7=Kra4QXPxXKWxrmv3jBw6Dufh_cQ@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v0.7 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

libbpf v0.7 was just released ([0]). It features a bunch of new
features, quality of life improvements (e.g., automatic handling of
RLIMIT_MEMLOCK), and a bunch of further deprecations. Also, more APIs
got better documentation, as well as various bugs were fixed and
support for older kernels was improved.

Overall, libbpf v0.7 should be the last version with lots of
deprecations before libbpf 1.0 release. libbpf v0.8 should get a few
extra features helping with libbpf 1.0 migration, as well as the usual
stream of further improvements, but no major new deprecations are
planned so far. We are definitely getting pretty close to be ready for
the actual v1.0 release!

Thanks to all the contributors for pushing libbpf forward!


## Important updates towards Libbpf 1.0
  - no need for explicit `setrlimi(RLIMIT_MEMLOCK)` when
`LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK` is passed to
`libbpf_set_strict_mode()`. libbpf will determine whether this is
necessary automatically based on kernel's support for memcg-based
memory accounting for BPF;
  - legacy BPF map definitions (using `struct bpf_map_def`) are
deprecated when `LIBBPF_STRICT_MAP_DEFINITIONS` is passed to
`libbpf_set_strict_mode()`. Please use BTF-defined map definitions.
  - another batch of API deprecations.

## New features and APIs:
  - ability to control and capture BPF verifier log output on
per-object and per-program level;
  - CO-RE support and other improvements for "light skeleton";
  - further libbpf API documentation improvements;
  - new feature-probing APIs (`libbpf_probe_bpf_helper()`,
`libbpf_probe_bpf_prog_type()`, `libbpf_probe_bpf_map_type()`);
  - new streamlined low-level XDP APIs (`bpf_xdp_attach()`,
`bpf_xdp_detach()`, `bpf_xdp_query()`, `bpf_xdp_query_id()`);
  - new `SEC("xdp.frags")`, `SEC("xdp.frags/cpumap")`,
`SEC("xdp.frags/devmap")` section definitions;
  - new `SEC("iter.s/xxx")` section definitions for sleepable BPF
iterator programs.

## BPF-side APIs and features:
  - `bpf_loop()` helper;
  - `bpf_func_arg()`, `bpf_func_ret()`, `bpf_func_arg_cnt()` helpers;
  - added syscall-specific `PT_REGS_xxx()` macros for retrieving
syscall arguments;
  - added `BPF_KPROBE_SYSCALL()` helper macro for syscall kprobes;
  - `bpf_get_retval()` and `bpf_set_retval()` helpers;
  - `bpf_xdp_get_buff_len()` helper;
  - `bpf_copy_from_user_task()` helper for sleepable BPF programs.

## Bug fixes and compatibility improvements:
  - fixed compilation error for C++ due to `btf_dump__new()` macro magic;
  - improved `LINUX_VERSION_CODE` detection for Ubuntu;
  - improved multiple kprobe support for legacy kprobe mode on old kernels;
  - improved compilation when system BTF UAPI headers are outdated;
  - a bunch of fixes of `PT_REGS_PARMn*()` macros for various architectures.

**Full Changelog**: https://github.com/libbpf/libbpf/compare/v0.6.0...v0.7.0

  [0] https://github.com/libbpf/libbpf/releases/tag/v0.7.0

-- Andrii
