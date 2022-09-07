Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8265AFD40
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIGHRV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIGHRV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 03:17:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F65A2DB0;
        Wed,  7 Sep 2022 00:17:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u6so18265203eda.12;
        Wed, 07 Sep 2022 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=qhwXdLhrBXs286e4r1ztCl42k4NswLVRSkGgFG4DTWk=;
        b=aOAtus9+3XemKZO9YquVZVVYGLyibQWiOTCQCKLmu8E6rC2NHM6OtQBfjlYTbNkJZL
         FX6ivN6gLnjmKSaPe16zBMaOlTzoE33sHxeNfFGR2vLMGW2XbmyykstnR+hFO4I0b4mj
         S7IAFo5JwUBd79NHwWGlNMJw8SCr0ISyyiU5UWDSXhSIKT65jytyzj+39/RhyV0ZjGe+
         IRXc6TJ5zJ3zzqQ2KVuQCmE9l/1dEq7+E4psnRzm7jcm6QLRJJtLlI075SFkcnzL6Ayk
         wkWXc4uBMb3dpitraYo34ZNCJSjkdEH+RLs+PgQc+9S/AvAzG62Sx20XOPTLDsQUqbkI
         BLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qhwXdLhrBXs286e4r1ztCl42k4NswLVRSkGgFG4DTWk=;
        b=eZxpVfXNlO21T9aoCdcIGwdcPDZDvDGZ0eJ/mPHsf3MWaUVH3PakoqiKGzQdzM7WjP
         mxxpWIDnWDse7in+2TlRJ26PW8onZK91pmgIqvXbs+Uf8CrxnQSUeyTSE0UhRkMZ4n1a
         IyxHVkbZ6/15+4cM0YmPRr4SB7esDhoAv9O3v57C048mzFvpND3GXvX6RMBmfq1B/3B3
         vwD5WWMBHqCf9cdncy6wTPxH2JJfSpJ01EMnnPBbZRKSQ6Sn+Uc2uqYul1UAmNLMMjFf
         xVcTcxyj5s82muNDusWhhX2OQQk5/9dxfSX/6BVekObFuPda+2x4zb4WDTdBjM7JYi+a
         ZDqQ==
X-Gm-Message-State: ACgBeo2/oxkqCEH7My0VvsiTVb2spQLLOd+FjIdyrrx1AZLt+8AvmXQ6
        6zJJZ0PHrYCzwQC58ItKKuw=
X-Google-Smtp-Source: AA6agR7cecyd4hrepTVhA3gpB5uAXT0Cz2JB1iGhZH3EfW9bDJ14ffnACzpoAxcEqzHEJi8a9IpZ4Q==
X-Received: by 2002:a05:6402:4150:b0:44a:ec16:def4 with SMTP id x16-20020a056402415000b0044aec16def4mr1958930eda.21.1662535038111;
        Wed, 07 Sep 2022 00:17:18 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o14-20020a056402038e00b0044ef2ac2650sm1877167edv.90.2022.09.07.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:17:17 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 7 Sep 2022 09:17:15 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        syzbot <syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [syzbot] WARNING in bpf_bprintf_prepare (2)
Message-ID: <YxhFe3EwqchC/fYf@krava>
References: <0000000000008be47905e7e08b85@google.com>
 <YxXZT6NxSSLufivZ@krava>
 <CAADnVQKthoffNDuO8TsjyCx1JF8jvsyh_pvmT+Q3yB493OeQeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKthoffNDuO8TsjyCx1JF8jvsyh_pvmT+Q3yB493OeQeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 06, 2022 at 08:02:39PM -0700, Alexei Starovoitov wrote:

SNIP

> > >  __mutex_lock_common kernel/locking/mutex.c:605 [inline]
> > >  __mutex_lock+0x13c/0x1350 kernel/locking/mutex.c:747
> > >  __pipe_lock fs/pipe.c:103 [inline]
> > >  pipe_write+0x132/0x1be0 fs/pipe.c:431
> > >  call_write_iter include/linux/fs.h:2188 [inline]
> > >  new_sync_write fs/read_write.c:491 [inline]
> > >  vfs_write+0x9e9/0xdd0 fs/read_write.c:578
> > >  ksys_write+0x1e8/0x250 fs/read_write.c:631
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > looks like __bpf_trace_contention_begin needs bpf_prog_active check
> > (like below untested), which would prevent the recursion and bail
> > out after 2nd invocation
> >
> > should be easy to reproduce, will check
> >
> > jirka
> >
> >
> > ---
> > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > index 6a13220d2d27..481b057cc8d9 100644
> > --- a/include/trace/bpf_probe.h
> > +++ b/include/trace/bpf_probe.h
> > @@ -4,6 +4,8 @@
> >
> >  #ifdef CONFIG_BPF_EVENTS
> >
> > +DECLARE_PER_CPU(int, bpf_prog_active);
> > +
> >  #undef __entry
> >  #define __entry entry
> >
> > @@ -82,7 +84,11 @@ static notrace void                                                  \
> >  __bpf_trace_##call(void *__data, proto)                                        \
> >  {                                                                      \
> >         struct bpf_prog *prog = __data;                                 \
> > +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))      \
> > +               goto out;                                               \
> >         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > +out:                                                                   \
> > +        __this_cpu_dec(bpf_prog_active);
> 
> I don't think we can use this big hammer here.
> raw_tp progs attached to different hooks need to
> run on the same cpu otherwise we will lose events.

might be good place to use prog->active
I managed to reproduce it localy, will try that

jirka
