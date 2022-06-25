Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B336B55AB44
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiFYPW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jun 2022 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiFYPW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jun 2022 11:22:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730613D3A;
        Sat, 25 Jun 2022 08:22:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u15so10380178ejc.10;
        Sat, 25 Jun 2022 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BcaUv7xgJEuarwlAmIEp3dF0pi23WDsk1UWCQCDopAc=;
        b=OCRF2t/kaZgohKQ23v2S4mq/j6YGQmVxFF+x5SXISrhv4QHHvcrpEnDUHGotlvdLrg
         T/nq2kI7vUfFBtvWPYq3SlgHOSwD7kF1y/PgGB8fiSagRK09pm2JL13A8trV93/3KLSn
         0rlhHgye18QE+mmB7q5P15cfzJrsXFvuFNYlk82RbY9B3pwSnDnge0FnhlgsRVhNWdjA
         RyfC9wajNMmiajSgbqgoBVn219xDEsdMBBy/cG3ZVnS+Qm40WpRNFJSvq/4kLQNeO0uZ
         V/+1FPQlWlBnTXNp4X8mqu5HQyy6t/8whm//9gCrNVm4lNwzqo/Vje7VYM0sZoxgAS+0
         /4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BcaUv7xgJEuarwlAmIEp3dF0pi23WDsk1UWCQCDopAc=;
        b=JfTo73vxUTvSIurOo3fdVVFc992zL9nRGTdnXYBY+zIqw/Swun0FyO/dlRToSjC6lc
         FdZUHTPWu7IuG6qoowtkeuwLCCXInePlyUb/r68khA7iAoZqtW8ASNFkbeoy7J3fZGg0
         SX0D3+iiVkL1zJUvMmBII+2G94zx/cD+e0N9euTmpujczlxnqfdQuoij+KXlF/Y2yQ+l
         gGTHcVKBbfS4waYUeFksfjJpMgIgArXuZErdYijebsIu2QjWFbXaB48msw1SczR9VLN/
         Kk5EI4Jcb4bkxIIAJiN05u9B3gUeY/D0CW8tFLFte1PfvF/66QfEJ5bHWnllqIJgYb4w
         wf7A==
X-Gm-Message-State: AJIora/58qlol4UvDCyd4T2ImmrdrtNpVebwkAr/PHJJOfrYXr3hlN0Z
        We0/AnGwKwTd7XesfgLb7JY=
X-Google-Smtp-Source: AGRyM1uYjblcaHFVr/zTOwDWvM6xTiioxpDUZ9AJMokK6lng8bHJlwZc0wUUqc8MmxHuWYtXO90QYw==
X-Received: by 2002:a17:906:b294:b0:726:2a95:7e1a with SMTP id q20-20020a170906b29400b007262a957e1amr4336952ejz.404.1656170543566;
        Sat, 25 Jun 2022 08:22:23 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d0c6000000b0043572ffafe0sm4110787edo.92.2022.06.25.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:22:23 -0700 (PDT)
Date:   Sat, 25 Jun 2022 17:21:19 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220625152119.f4k4unepbcdwxcpe@erthalion.local>
References: <20220615211559.7856-1-9erthalion6@gmail.com>
 <20220619013137.6d10a232246be482a5c0db82@kernel.org>
 <20220622085421.k2kikjndluxfmf7q@ddolgov.remote.csb>
 <20220623234727.db1dda76c11d660200b2b804@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623234727.db1dda76c11d660200b2b804@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Jun 23, 2022 at 11:47:27PM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Jun 2022 10:54:21 +0200
> Dmitry Dolgov <9erthalion6@gmail.com> wrote:
>
> > > On Sun, Jun 19, 2022 at 01:31:37AM +0900, Masami Hiramatsu wrote:
> > > On Wed, 15 Jun 2022 23:15:59 +0200
> > > Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > >
> > > > From: Song Liu <songliubraving@fb.com>
> > > >
> > > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> > >
> > > I'm not sure what environment you are considering to use this
> > > feature, but is 4095 enough, and are you really need to specify
> > > the maxactive by linear digit?
> > > I mean you may need the logarithm of maxactive? In this case, you
> > > only need 4 bits for 2 - 65546 (1 = 2^0 will be used for the default
> > > value).
> >
> > From what I see it's capped by KRETPROBE_MAXACTIVE_MAX anyway, which
> > value is 4096. Do I miss something, is it possible to use maxactive with
> > larger values down the line?
>
> Ah, I forgot to cap the maxactive in trace_kprobe. Yes, kretprobe's
> maxactive has no limitation check (it depends on how much memory you
> can allocate in the kernel.) If you think that is not enough, you
> can expand the maximum number. Unless a huge system which runs
> a ten thoudsands of similar process/threads, 4096 will be a good
> number. So, it up to you. But personally I think the maxactive
> should be specified by log2.

Thanks for clarification. Yep, makes sense to me, I'll prepare a new
version soon.
