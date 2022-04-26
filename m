Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887A510BD0
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 00:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355871AbiDZWUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355762AbiDZWTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 18:19:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1E24B40E
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 15:16:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p62so497805iod.0
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Suh7+guVSdI0inCEGfWce8f+AhBKVff3op+v4Gr8ASQ=;
        b=L2+Sl0H6ljaDpEboibP69AzkyV7o9WYn8PBUz5Xjsl1UAX4TPzcw5qY91aYKLzUfm6
         IVc80uQvgEAqV8AVcM2EodFjpfK7umh+nR/MyTI25bkWWJ0A3AQRxLIwKEYoyfTulqm9
         ubGjAqBDxsd4a1aRzyuoIugiYTX1CNg2C1/6XJ4MFdj0B4YWNZldOLWy2L3EuIzs059D
         wSNgqMIPVmaqyPCngaWMR59V8BPAPMJpHLeMNhCXnrbztO+gK87/Ep0KmCfUoJLaL/Dj
         vzUmU45/iNh20/Ecm6aHFhd6ULCgFhqVsnSbOzrOxrkx65gbxMOz+Q7AoyREIbr03N/H
         XF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Suh7+guVSdI0inCEGfWce8f+AhBKVff3op+v4Gr8ASQ=;
        b=UZ8UY2urmI3Rb+Xl2CFnTHxXR+1sSE4IUGF56D2+pXUwpjXrsEvdvklQcPCFIl+Jl+
         0cHi03xE6iy4MJwrhW8FIfs1QdaVPb+E1Lk10S5+WVWi8C7IQbD+ODXsjPv17uwUB/Rs
         vc8MUKBsIHW4ungDrCcUpAqFXcuBXHrk5fJIxIuiLJMlvxPeMLF+9wz3/TG05rKH6Gb2
         5JFK7t0x25nqh71F5pBNlDgHsONxKLO+5jQolwCy+t5gvVUttBnmbwH6/btoBj84mR52
         GXBulmK1f29KOw1JQPXbJnbGqNe9H32H3UgQJZWNP2h1qi5m6mWCjAOZDvB34g5TpxU5
         n/zA==
X-Gm-Message-State: AOAM532N1l48Q5X6hzR5Ulvx1D4VaicrDL6i4C/der03+IhYpCk3CnVs
        wBScKrSRBESVQi31+VN3wTWUU4OaZhz5wnSL0JA=
X-Google-Smtp-Source: ABdhPJziajyXP9JCPHzENDlFX36Rbi0mo0kgnPmRsnltKS+Vz/IiHMQOb+1s2X9M92fAGZrNCxFcQR3lHi6GcktRFOs=
X-Received: by 2002:a05:6e02:1ba3:b0:2cc:4158:d3ff with SMTP id
 n3-20020a056e021ba300b002cc4158d3ffmr9743252ili.98.1651011388911; Tue, 26 Apr
 2022 15:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220426004511.2691730-1-andrii@kernel.org> <20220426004511.2691730-10-andrii@kernel.org>
 <20220426185938.klfmm6qmwad7o7qr@MacBook-Pro.local>
In-Reply-To: <20220426185938.klfmm6qmwad7o7qr@MacBook-Pro.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 15:16:17 -0700
Message-ID: <CAEf4BzbY6hGQHL_0qXjemdAhEGPfWdHLm78tyUJLEyX1OE34kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: fix up verifier log for unguarded
 failed CO-RE relos
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Apr 26, 2022 at 11:59 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 25, 2022 at 05:45:10PM -0700, Andrii Nakryiko wrote:
> > Teach libbpf to post-process BPF verifier log on BPF program load
> > failure and detect known error patterns to provide user with more
> > context.
> >
> > Currently there is one such common situation: an "unguarded" failed BPF
> > CO-RE relocation. While failing CO-RE relocation is expected, it is
> > expected to be property guarded in BPF code such that BPF verifier
> > always eliminates BPF instructions corresponding to such failed CO-RE
> > relos as dead code. In cases when user failed to take such precautions,
> > BPF verifier provides the best log it can:
> >
> >   123: (85) call unknown#195896080
> >   invalid func unknown#195896080
> >
> > Such incomprehensible log error is due to libbpf "poisoning" BPF
> > instruction that corresponds to failed CO-RE relocation by replacing it
> > with invalid `call 0xbad2310` instruction (195896080 == 0xbad2310 reads
> > "bad relo" if you squint hard enough).
> >
> > Luckily, libbpf has all the necessary information to look up CO-RE
> > relocation that failed and provide more human-readable description of
> > what's going on:
> >
> >   5: <invalid CO-RE relocation>
> >   failed to resolve CO-RE relocation <byte_off> [6] struct task_struct___bad.fake_field_subprog (0:2 @ offset 8)
> >
> > This hopefully makes it much easier to understand what's wrong with
> > user's BPF program without googling magic constants.
> >
> > This BPF verifier log fixup is setup to be extensible and is going to be
> > used for at least one other upcoming feature of libbpf in follow up patches.
> > Libbpf is parsing lines of BPF verifier log starting from the very end.
> > Currently it processes up to 10 lines of code looking for familiar
> > patterns. This avoids wasting lots of CPU processing huge verifier logs
> > (especially for log_level=2 verbosity level). Actual verification error
> > should normally be found in last few lines, so this should work
> > reliably.
> >
> > If libbpf needs to expand log beyond available log_buf_size, it
> > truncates the end of the verifier log. Given verifier log normally ends
> > with something like:
> >
> >   processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> >
> > ... truncating this on program load error isn't too bad (end user can
> > always increase log size, if it needs to get complete log).
>
> and it didn't break test_verifier?
> In do_test_single() it does:
>   proc = strstr(bpf_vlog, "processed ");
>   insn_processed = atoi(proc + 10);
>   if (test->insn_processed != insn_processed) {

I forgot to check test_verifier locally, but it's fine according to CI
([0]). This truncation can only happen if libbpf fixes up verifier
log, which currently happens only when there is CO-RE relocation
failure. I don't think we have any CO-RE relocation failure tests in
test_verifier itself. For all other case there will be absolutely no
change in verifier log output.

  [0] https://github.com/kernel-patches/bpf/runs/6181657272?check_suite_focus=true
