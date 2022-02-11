Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041B04B1A42
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 01:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiBKARW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 19:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346204AbiBKARW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 19:17:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54345582
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:17:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so7210883pjh.3
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13aohBHaFHVivQmjHah2gMH/Wt39y5yUwi8fpY9RJvg=;
        b=Zs6KmmFQf9UqRZJITGeS87k6P17ZdzsFyNyHqdMdyxLM40n/ba7xymd1/fq6K51pK3
         isAfsCAoA3mRtvOmTcHJPGWmb9P3M4JnAXZGGO1eyAbdMv5FaTF32RkZRHJGteNw4b13
         /bsCE7Kk9e/gjKVirYnpsTbFCTm/+wW29W6iHX4q5lNzdlfKY2SAymKEjzM40UxZA7GY
         hpuyj8IfHwTFL8TAYBao2K6GKJPNqS0pc3jfnahgXrlG3ap+f4Gti453npwiuifB5Mj0
         EwmxcsM7IaK+jUAK3t8tnI54HrxUmvcFY80350HcDJvlrWZEMIwyEBkAyS3OFOBqAlwX
         WPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13aohBHaFHVivQmjHah2gMH/Wt39y5yUwi8fpY9RJvg=;
        b=jDF0p+FLy+aBVzXoyrg0mBya7moYFYYcG0qFqaYrv5F/L7k1co2bNk2srU7spWoeos
         NkDbbbvHimdELeUzlYzw3A4AvKccS709N7q0HuXJyeJEemCmUscSz3tuy7H2bcFLqe5c
         SzfRqYIuwapzPBE2O+o3zcTflC+zgwebuqK5GnajABOJIk7w60zWYFS2+OniHP2kQd+9
         B/ddLXR0xAU9jxaxwPh/yz8PyvJBED4rHoAIdFZBpRmwhIZJOt4iACaHqu5Lhttgg15Q
         MeVXFzkqwhaWnhvup5nrUntjk7/zG5JPCuOieAgcW7ofOWacFZqEgp0nRpMuoUX6QJG9
         x2uw==
X-Gm-Message-State: AOAM533GK88KYAqXxD51SeFBXX4WQQLDRfAJvnfbtJFKFsJoqXX2QLaD
        dRgnJOJxcIZAj4RSpBJLeEFfS9m/t7n/hhsj90Q=
X-Google-Smtp-Source: ABdhPJxW1As4wnH+DVXRbvb+ltl0ztnrd0mzHD9uyuOHdIvmj4GE7yy5xhDqn5tO6TXLCwfGPIFCKKzv0FXbAhZlbJY=
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr9890243pls.126.1644538642161;
 Thu, 10 Feb 2022 16:17:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <78216409-5892-6410-a82c-0ebf5fdb1504@fb.com>
 <CAADnVQKk-uOEkEiPuBu7W_oYx=gTGpruK6Kc0ShTcFYEAbCczA@mail.gmail.com> <b475429b1521d83c2b538f83b9013c9ee9b13d10.camel@fb.com>
In-Reply-To: <b475429b1521d83c2b538f83b9013c9ee9b13d10.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Feb 2022 16:17:11 -0800
Message-ID: <CAADnVQJmx39YO-ZU=Y12sED2pM-FadKDnqOo2n+L6AewZCai1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in skeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 3:59 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Thu, 2022-02-10 at 15:14 -0800, Alexei Starovoitov wrote:
> > So adding
> > _Static_assert(sizeof(type_in_skel) == const_size_from_kernel);
> > to skel.h would force users to pick types that are the same
> > both in bpf prog and in corresponding user space part.
>
> I'm not sure users have this much control over the definition of the types in
> their program though. If a kernel and uapi typedef differ in size, this approach
> would force the user to use kernel types for the entire program.
>
> If, for example, pid_t is a different size in glibc and the kernel, it would
> force you out of using any glibc functions taking pid_t (and potentially all of
> glibc depending on how entangled the headers are).

pid_t is a great example, since its meaning is different
in kernel and in user space.
One is thread and another is process.

static_assert will catch such issues and will force
users to pick u64 and think through the type
conversions. In kernel from pid_t -> u64 in bpf prog,
and in user space pid_t -> u64 in skel.
That would be an explicit action by users that hopefully
make them think about the differences in size and semantics.

> By normalizing to stdint types, we're saying that the contract represented by
> the skel does not operate with either uapi or kernel types and it's up to you to
> ensure you use the right one (or mix and match, if you can). It feels
> fundamentally more permissive to different types of situations than forcing the
> skel user to only use kernel types or refactor their program to isolate the
> kernel type leakage to only the compilation unit using the skel.

static_assert will force users to use compatible types, not kernel types.
