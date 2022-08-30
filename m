Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C05A6570
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiH3NtY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiH3Nsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:48:42 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35612101E1;
        Tue, 30 Aug 2022 06:46:19 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id y17so1548264qvr.5;
        Tue, 30 Aug 2022 06:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=21bngEPsx9nENODhGKloV6uJhY/ub47K75lzmtVSqjY=;
        b=ajVTQTfgysLWpj7YHSxQdryhNnfQ1uiutmZpgxOdyGGyHIbBe+t2010ZGQq1FRORMn
         i+gB9FaiiqwZOhzLvfaDMjYUH2LlgRCp6IcLc3Owfw0aOb2JBK/AbMIq5oPN+tA4sUC4
         Bwg/pUEPf39uQ7VraDZHvmft4erZSxhzhDafk/9W4bTu8xeDdSBEaDYIIimFSVkOhCxm
         +HdFzblzWv7J+GK3NqKJW/w06RVvLoe0ZxBEXLAghKj3iOrwNtFsYqrmFBfZfpsJqvfB
         1XmTU+lkX64pxC7OAKj5OBMSVrg7A9a0hK9H+yJuM4TG1VA6di5gwZz9HMkeQQ1FcyUK
         IBYQ==
X-Gm-Message-State: ACgBeo3yT7zIDI97m6hGamOaN4aBZCSSADt5EyqfUSXAUROdGmL+nMmK
        IP7lnfZ5mFPG2OAkPiOTA4U=
X-Google-Smtp-Source: AA6agR6qsN5IRB4YXJCP4WyzhBkFmtmh4gNPDHtZPGWlp0qMb55XioYmJX4BacH+uy69tJMFjYAokg==
X-Received: by 2002:a05:6214:d6d:b0:496:e11b:69e9 with SMTP id 13-20020a0562140d6d00b00496e11b69e9mr15334444qvs.45.1661867171236;
        Tue, 30 Aug 2022 06:46:11 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2341])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a248d00b006baed8f3a2esm7870099qkn.103.2022.08.30.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:46:10 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:46:12 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests/bpf: Add selftests validating the user
 ringbuf
Message-ID: <Yw4UpK4uPZP9fYD+@maniforge.dhcp.thefacebook.com>
References: <20220818221212.464487-1-void@manifault.com>
 <20220818221212.464487-5-void@manifault.com>
 <CAEf4Bzbj0ACUmZqQLhRR5DvEX9Zphqz5UwBWdkTdXfKqxWM0mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbj0ACUmZqQLhRR5DvEX9Zphqz5UwBWdkTdXfKqxWM0mQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 03:03:54PM -0700, Andrii Nakryiko wrote:

[...]

> > +                       CHECK(read <= 0, "snprintf_comm",
> > +                             "Failed to write index %d to comm\n", i);
> 
> please, no CHECK() use in new tests, we have ASSERT_xxx() covering all
> common cases

No problem, I'll make this change in v4. Unless I missed something,
CHECK() isn't documented as deprecated in test_progs.h. I'll take care
of adding that in a separate change.

> > +static long
> > +bad_access1(struct bpf_dynptr *dynptr, void *context)
> > +{
> > +       const struct sample *sample;
> > +
> > +       sample = bpf_dynptr_data(dynptr - 1, 0, sizeof(*sample));
> > +       bpf_printk("Was able to pass bad pointer %lx\n", (__u64)dynptr - 1);
> > +
> > +       return 0;
> > +}
> > +
> > +/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
> > + * not be able to read before the pointer.
> > + */
> > +SEC("?raw_tp/sys_nanosleep")
> 
> there is no sys_nanosleep raw tracepoint, use SEC("?raw_tp") to
> specify type, that's enough

Got it, thanks for catching that. Will fix.

> > diff --git a/tools/testing/selftests/bpf/test_user_ringbuf.h b/tools/testing/selftests/bpf/test_user_ringbuf.h
> > new file mode 100644
> > index 000000000000..1643b4d59ba7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/test_user_ringbuf.h
> 
> nit: I'd probably put it under progs/test_user_ringbuf.h so it's
> closer to BPF source code. As it is right now, it's neither near
> user-space part of tests nor near BPF part.

Fair enough, will fix.

Thanks,
David
