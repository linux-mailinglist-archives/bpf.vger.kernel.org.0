Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEF598F66
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346824AbiHRVW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346856AbiHRVWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 17:22:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49998DDA98;
        Thu, 18 Aug 2022 14:15:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so3411173edd.4;
        Thu, 18 Aug 2022 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=urJ4x4daK3qEX9oZLw5VGbCPYDe2Pbjud3LODXMY5SI=;
        b=MRXUnPkxgf54nxSOsWezWiISbU/cpg5JJ1xBtg4OeUeCbDBzOpvRdl7K1+aZSMaPTl
         b5B5NYHcQ31pwH0+64T3jgim2hyrGw+PXzwz3I8Z8JwZObRLgnjj0bcyrqigI4WvLkZt
         i1PxthtGyCrvyaQMQ4InhNghYV4BcfhDniwaqp1R6sr2uq1ES7MSlmcZeEuX8uroDy37
         UMVA8Dw3Qj5I2KKo/zlMm8Y4eBqK4xHpAH0lADBlzEHbqRDVxm4N8s0nV55aVyObxjF0
         +vX9Dej0AgZm9X5odtb2Jnucwt9f6PFwCjAT5VryMlaC61gMt7INwKVMqtXpRyVBGA/0
         agzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=urJ4x4daK3qEX9oZLw5VGbCPYDe2Pbjud3LODXMY5SI=;
        b=yjGzG4AAufcIQE98Ng+HmKgzoA6JwkvXlB7IGZvGRgH1njZn2IuiYY6PTnicYSPjJ5
         Y+4to0aJMzNT0qWQUT8xvLKBG9NNBz/aIBxW4gNZuuMMGl6hL614qTjzODgcU8AUW4jK
         FboitFVbsofyrhxEuwhipyPMMY935U5QWK81+Ogw03RWJXQUn/mqKWZsZkIG9QQAlciV
         7FAUaPEdegEkMss0JHUBRwDu4e7xFKGYwyVtsIS1w0PvuLMSWpMEuu8dZJOfX7XPmHm9
         CLwh1PtJKZ+GrYv8SDs6o8ZYn4clssXHFdlK8ihymBQLBYCzQWUzhfuE2QFOKNvMfpvn
         KgpQ==
X-Gm-Message-State: ACgBeo0sdO0ct42Y+5J1nT7fvk2tNHRoyGpGAvHxyaKFVQ4DCi4HX1Xc
        byDqpxEMh5c0/4t13cB+atk=
X-Google-Smtp-Source: AA6agR7mk/qo3ML0Xn/O6OL7EXQmf1zRRwbeq/JFAERAUzD0GpKWOmHQb+fyOv4fNfIl01CQmIGLRA==
X-Received: by 2002:a05:6402:190e:b0:43e:1588:4c32 with SMTP id e14-20020a056402190e00b0043e15884c32mr3623547edz.76.1660857274874;
        Thu, 18 Aug 2022 14:14:34 -0700 (PDT)
Received: from krava ([83.240.63.36])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906141500b00730a234b863sm1329344ejc.77.2022.08.18.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:14:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 18 Aug 2022 23:14:32 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yv6ruI/UFqztRaD2@krava>
References: <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava>
 <20220818165024.433f56fd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818165024.433f56fd@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:50:24PM -0400, Steven Rostedt wrote:
> On Thu, 18 Aug 2022 22:27:07 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > it puts function address into __patchable_function_entries section, which is
> > one of ftrace locations source:
> > 
> >   #define MCOUNT_REC()    . = ALIGN(8);     \
> >     __start_mcount_loc = .;                 \
> >     KEEP(*(__mcount_loc))                   \
> >     KEEP(*(__patchable_function_entries))   \
> >     __stop_mcount_loc = .;                  \
> >    ...
> > 
> > 
> > it looks like __patchable_function_entries is used for other than x86 archs,
> > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > __mcount_loc section?
> 
> So something like this:
> 
> #ifdef CONFIG_X86
> # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> # define MCOUNT_PATCHABLE
> #else
> # define NON_MCOUNT_PATCHABLE
> # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> #endif
> 
>   #define MCOUNT_REC()    . = ALIGN(8);     \
>     __start_mcount_loc = .;                 \
>     KEEP(*(__mcount_loc))                   \
>     MCOUNT_PATCHABLE			    \
>     __stop_mcount_loc = .;                  \
>     NON_MCOUNT_PATCHABLE		    \
>    ...
> 

is there a reason to keep NON_MCOUNT_PATCHABLE section for x86?  otherwise LGTM

jirka
