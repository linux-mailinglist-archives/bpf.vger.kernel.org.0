Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFA57CA7A
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiGUMPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMO7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 08:14:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CEA863F4;
        Thu, 21 Jul 2022 05:14:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so1887068edd.9;
        Thu, 21 Jul 2022 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VSbWBr2PqZxxIcgEaWX5b/CKC10J1bxUMK1hG4Jb/vc=;
        b=NGpJOVfwssqjngg2xYTFLZrZBj/N8tDxK1KV8Ddk6vAjmjQBTwUtLzC+UgGiY9WO9X
         XccwZUffn8Vf53j0La4f05uzhgM7UBJ+/bV0tu5F6tAt4iegfs+2PAppV1fxV9lBfbyn
         vuPi56tV/3xg5tVp1u6Ch2TqX8ErgBvHAJEaJPrnZ4qnvveI4TC5REiAoJDqUwWXK6U4
         HBuavEfhc2b75fQ57IKbg9hrJUxb5RR5pshno53klRULSV1RTirbyuCBYpSCpURHqEll
         Od3eaFXHdHBn5PTQr5R4m10GdOd+8B3V7ZbqLY5+K0KFyRsaLG4EXSIer0EDig0UfGst
         zJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VSbWBr2PqZxxIcgEaWX5b/CKC10J1bxUMK1hG4Jb/vc=;
        b=j7HwctSvlT0exgr414DhF1NmI/KvNSRfPextccJ1To/ck1Wkt9sVhRJ9YSSWiShplw
         ZlHMpjfA9be7G7ivIYOz6KHlK3gmyWRKLxHAoQqg8UcQqyPr0xi0mWtnw0ABcHi7WuBH
         bi8pWnRJnqMUtzFQ+lTsmiDKdGRf9DoaIZH7AqshtCa53ARGnV6IKOTe1QDteGzTJswJ
         N7ucNtaTJaeCaitrDUGAvZRd88BQCV0zngOyXei9fo7lDoUQO3CGR4lHHVKr6gLMg8e9
         JMh87nmCx+PG5ZWsmoqaezgUM1XiPbj3hZGpyeXzNGrp14YW3hneSx1XvVMqJjqVFvGL
         RRGw==
X-Gm-Message-State: AJIora8+IQioW4Lfnr50jQ8BS2CWlnQcBeZLXa9LUW0nMqAECqn0cnXh
        KD3JEhxrTQV6RAaTFVwXuvc=
X-Google-Smtp-Source: AGRyM1vild5GzH+uGoclyDv0swbm3SShGCYbdIa8XwTOLqm8EYX2jhkQZkrvG6L1KMDPV6OSk29Mqw==
X-Received: by 2002:a05:6402:518b:b0:43a:dc65:35f8 with SMTP id q11-20020a056402518b00b0043adc6535f8mr57668291edd.185.1658405697000;
        Thu, 21 Jul 2022 05:14:57 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id kw26-20020a170907771a00b0072124df085bsm817249ejc.15.2022.07.21.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:14:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 21 Jul 2022 14:14:53 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YtlDPYQWDcORbP0o@krava>
References: <20220721111430.416305-1-lee@kernel.org>
 <Ytk+/npvvDGg9pBP@krava>
 <Ytk/jT+zyNZpafgn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ytk/jT+zyNZpafgn@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 12:59:09PM +0100, Lee Jones wrote:
> On Thu, 21 Jul 2022, Jiri Olsa wrote:
> 
> > On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
> > > The documentation for find_pid() clearly states:

typo find_vpid

> > > 
> > >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > > 
> > > Presently we do neither.

just curious, did you see crash related to this or you just spot that

> > > 
> > > In an ideal world we would wrap the in-lined call to find_vpid() along
> > > with get_pid_task() in the suggested rcu_read_lock() and have done.
> > > However, looking at get_pid_task()'s internals, it already does that
> > > independently, so this would lead to deadlock.
> > 
> > hm, we can have nested rcu_read_lock calls, right?
> 
> I assumed not, but that might be an oversight on my part.
> 
> Would that be your preference?

seems simpler than calling get/put for ppid

jirka

> 
> > > Instead, we'll use find_get_pid() which searches for the vpid, then
> > > takes a reference to it preventing early free, all within the safety
> > > of rcu_read_lock().  Once we have our reference we can safely make use
> > > of it up until the point it is put.
> > > 
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@google.com>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  kernel/bpf/syscall.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 83c7136c5788d..c20cff30581c4 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > >  	const struct perf_event *event;
> > >  	struct task_struct *task;
> > >  	struct file *file;
> > > +	struct pid *ppid;
> > >  	int err;
> > >  
> > >  	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > >  	if (attr->task_fd_query.flags != 0)
> > >  		return -EINVAL;
> > >  
> > > -	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > > +	ppid = find_get_pid(pid);
> > > +	task = get_pid_task(ppid, PIDTYPE_PID);
> > > +	put_pid(ppid);
> > >  	if (!task)
> > >  		return -ENOENT;
> > >  
> 
> -- 
> Lee Jones [李琼斯]
