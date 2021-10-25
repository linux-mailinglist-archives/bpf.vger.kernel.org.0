Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB343A572
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhJYVJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhJYVJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 17:09:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF934C061243
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:06:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x66so12105651pfx.13
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DN8Qzavp4YLteRc4KGzGxUD9hgR92pZ9XvMCgYnpPXk=;
        b=PVZq0VU4Akx2eoH48kG0TggVvavZroMiBYxyORlDzHjXWOO8JjUnXrF2tNvxprzpI6
         WwGhj7GbnibErKuoWZ502D9FKCgQEFbL6SJsITNVEy5dhgEp8fz8IrKjiuLe26sLYDs4
         YaVEdfywBD4ajBqs5cChAoWL5RIImMs3nUVlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DN8Qzavp4YLteRc4KGzGxUD9hgR92pZ9XvMCgYnpPXk=;
        b=Iu6M/g5v3ZU3lQx0jIAtEHPXM5Hh2Sc+RJsMQihaoihLaCM/YIjbK1APBlY37CHR4c
         IMUXP/X75/bY2V+cxos2MXDTspM0J3oJbib9dsz5Jj5dQK4RLyehtgKlUiIf9sHFPGgG
         nbTPoFkiC/zOhxm53O7FkCaaLy1BCBaIUm97aEHHuHCo6E81aR1ybFqh+keQ+/mBmj/Q
         /MQvX+DsNlTCxDJThtxvpluq6agW3m/X5VauCYThBAkVTr+cgOxyE7htdXbj+qQqwrUQ
         OIYB2Vom3469l9BF4rm2zsMsuJUoxKxeWuijEoSEmmTJcwtfGDHjpVDI7zfE1QGEDpfe
         4bPw==
X-Gm-Message-State: AOAM530oIILxKXSM3958hWx0Qa43p2Ijr1EyneuC4++4csKX+vPgVNM8
        p4AZ/u/rUCSsBtPNVrOraWUp7w==
X-Google-Smtp-Source: ABdhPJz1kqpwzqWdalvJQu8pOHW5xoT2O4iMGIjFvG7XILr1AJgkXIvTdmEInVgO8gZ/Kp7GqyqE2w==
X-Received: by 2002:a63:7c4f:: with SMTP id l15mr1289816pgn.273.1635196015236;
        Mon, 25 Oct 2021 14:06:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j126sm20471272pfd.113.2021.10.25.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:06:54 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:06:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Zhang, Qiang" <qiang.zhang@windriver.com>, robdclark@chromium.org,
        Christian Brauner <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v6 00/12] extend task comm from 16 to 24
Message-ID: <202110251406.56F87A3522@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <CAADnVQKm0Ljj-w5PbkAu1ugLFnZRRPt-Vk-J7AhXxDD5xVompA@mail.gmail.com>
 <20211025170503.59830a43@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025170503.59830a43@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 05:05:03PM -0400, Steven Rostedt wrote:
> On Mon, 25 Oct 2021 11:10:09 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > It looks like a churn that doesn't really address the problem.
> > If we were to allow long names then make it into a pointer and use 16 byte
> > as an optimized storage for short names. Any longer name would be a pointer.
> > In other words make it similar to dentry->d_iname.
> 
> That would be quite a bigger undertaking too, as it is assumed throughout
> the kernel that the task->comm is TASK_COMM_LEN and is nul terminated. And
> most locations that save the comm simply use a fixed size string of
> TASK_COMM_LEN. Not saying its not feasible, but it would require a lot more
> analysis of the impact by changing such a fundamental part of task struct
> from a static to something requiring allocation.
> 
> Unless you are suggesting that we truncate like normal the 16 byte names
> (to a max of 15 characters), and add a way to hold the entire name for
> those locations that understand it.

Agreed -- this is a small change for what is already an "uncommon"
corner case. I don't think this needs to suddenly become an unbounded
string. :)

-- 
Kees Cook
