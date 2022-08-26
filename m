Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742D65A2282
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 10:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiHZIBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiHZIBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 04:01:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01FD3ECE;
        Fri, 26 Aug 2022 01:01:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so886516wri.0;
        Fri, 26 Aug 2022 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=YKvx6Cj1xYUX2DCCsWQM+Zo2QVYcF66rAfcZQEp7iEQ=;
        b=T42JkReyAMSo4VSqTWGrerpNlXhidixAmat1mZ0sQX1NCfY85uNUSkEv188VYmQoZv
         tr94poynOv2itOtjfretoErIELTWi2u1CcgLTxj13h7TNV7+V1cpnCrl2/kM37TyL8w6
         sAlgiW0FfnJUCwWa2xqAI+SeLsFzljhoO4ECrsxFTPNmrL3xO2F28KnuXhtH1/TIsbPF
         pbhYYtri0YLLPUO75mC3QZ2k85W2/81CBLyHcBkQf8rdCJc+OBinKqOWYUaHneaZ8bzR
         K1yNCLfCf2VC0c1sU6HihdvfKDACL1oyCXYjnnfolQUugZCy6SJxOC6HJPAdZOAszwsj
         VcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=YKvx6Cj1xYUX2DCCsWQM+Zo2QVYcF66rAfcZQEp7iEQ=;
        b=6d5vJp3s3PIizdsEM6IYY8/feqmFfNm7cxfPJQ1Wv+0SliHGuGCX0A4duNpmKHA5hx
         9ZfDNE2q1A99jVZhYn0mSDJx3ui1V9r9GwyG9FT9U8jmliFguvQh7oIQijFDHhRp2W97
         uPtbLcwvH0BR0b9VCz+soWqf02wYIFz/2yFl5Ku5QxDSrbRrgWQiD7rfdgLD5iIFuFje
         CuB4POo0B/xUapQFCvfxuAvtnO0FUGUzOYScs95p1aY0NrMQRk/wuq9Oz1TslIIvvDVJ
         pCIszl9NJGMc3k8qFNnWomVN6n8DqUIvURbtz1+lWv2bzQbSnOhnorgPR2yQBvnqK1lt
         ihwQ==
X-Gm-Message-State: ACgBeo1DPaduIlEgg6COHfsFSyCDJr8CVU3baofJJMwh6912hSagg6Ca
        pl3M3LGLMQ/Uybb28JrjGBI=
X-Google-Smtp-Source: AA6agR50DqvB0YCyRCtnNZIMYF3rLVQtp8wNj2e/H+sDHsFqdKxFun9l/A5Ec9xDjcwIAitKznYcZA==
X-Received: by 2002:a5d:64e2:0:b0:225:79d3:d6d9 with SMTP id g2-20020a5d64e2000000b0022579d3d6d9mr3873080wri.240.1661500862157;
        Fri, 26 Aug 2022 01:01:02 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d6701000000b0022571d43d32sm1239859wru.21.2022.08.26.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:01:01 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 26 Aug 2022 10:00:58 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Ywh9uo7fhRMQjrSl@krava>
References: <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava>
 <20220818165024.433f56fd@gandalf.local.home>
 <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
 <Yv6wB4El4iueJtwX@krava>
 <Yv933mq/DTIz5g7q@krava>
 <CAADnVQK=kbCRuj9ZF9oV0YGf0pN-am3vFXYBMQ6m2ze5--nqtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK=kbCRuj9ZF9oV0YGf0pN-am3vFXYBMQ6m2ze5--nqtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 10:23:24AM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 19, 2022 at 4:45 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Aug 18, 2022 at 11:32:55PM +0200, Jiri Olsa wrote:
> > > On Thu, Aug 18, 2022 at 02:00:21PM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Aug 18, 2022 at 1:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > On Thu, 18 Aug 2022 22:27:07 +0200
> > > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > > > > > it puts function address into __patchable_function_entries section, which is
> > > > > > one of ftrace locations source:
> > > > > >
> > > > > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > > > > >     __start_mcount_loc = .;                 \
> > > > > >     KEEP(*(__mcount_loc))                   \
> > > > > >     KEEP(*(__patchable_function_entries))   \
> > > > > >     __stop_mcount_loc = .;                  \
> > > > > >    ...
> > > > > >
> > > > > >
> > > > > > it looks like __patchable_function_entries is used for other than x86 archs,
> > > > > > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > > > > > __mcount_loc section?
> > > > >
> > > > > So something like this:
> > > > >
> > > > > #ifdef CONFIG_X86
> > > > > # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> > > > > # define MCOUNT_PATCHABLE
> > > > > #else
> > > > > # define NON_MCOUNT_PATCHABLE
> > > > > # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> > > > > #endif
> > > > >
> > > > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > > > >     __start_mcount_loc = .;                 \
> > > > >     KEEP(*(__mcount_loc))                   \
> > > > >     MCOUNT_PATCHABLE                        \
> > > > >     __stop_mcount_loc = .;                  \
> > > > >     NON_MCOUNT_PATCHABLE                    \
> > > > >    ...
> > > > >
> > > > > ??
> > > >
> > > > That's what more or less Peter's patch is doing:
> > > > Here it is again for reference:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e
> > >
> > > ah nice, and discards the __patchable_function_entries section, great
> > >
> >
> > tested change below with Peter's change above and it seems to work,
> > once it get merged I'll send full patch
> 
> Peter,
> what is the ETA to land your changes?
> That particular commit is detached in your git tree.
> Did you move it to a different branch?
> 
> Just trying to figure out the logistics to land Jiri's fix below.
> We can take it into bpf-next, since it's harmless as-is,
> but it won't have an effect until your change lands.
> Sounds like they both will get in during the next merge window?

I discussed with Peter and I'll send his change together with my fix

jirka
