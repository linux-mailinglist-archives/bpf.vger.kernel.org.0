Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78762F822
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiKROt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 09:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiKROt4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 09:49:56 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317F6154;
        Fri, 18 Nov 2022 06:49:55 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id c15so3217491qtw.8;
        Fri, 18 Nov 2022 06:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMsdvV5a7suQ8MunIGDInzS0Zzy91Hzd5F0yaDIYmY8=;
        b=nzuUgxoQEH9WO/4OJR1i9XzARSihBbcH9zrwhZYWOQZ261UUKuFIcbBwf5AwDLWgpY
         euDPzOpKrZYp9PpO7NGqK99bU7ILcvQ5/gYc8gkcA7I6iXghHZQwYjhrioiOPcYjNA7U
         PgU9AYEIpWYcO3q3XY/NQlyEC+SGQFDMUyixZXLcZb8c8CMQwZ5J2p5uE4dB4VwRMKJ5
         XDsFzFNaktiFk2VKYi7Z2BJpbIRc4RKAdF3YssmNksujH8JM8jV6nl5+X4KOhvrO/Iax
         7pOgbKDK6eUfy21otkoTEY4Kubr9AGwkQ6kYaT0FX/UzHwu/vBLuzgcE+JFQGBoHkY1Y
         3VMQ==
X-Gm-Message-State: ANoB5pkm9bB75twBlTT8vTz60qeoWT/oVaS6l289HlwbHewra52yfS2P
        LRgY8Ma1RQKqijq4WQL45zQ=
X-Google-Smtp-Source: AA0mqf6E0huMlShZvO1jR53KShljpFuOz0Ge7w6wqFikW3r9wrLg8iDtv4n/fQS8EDnTL3UyJ6BF8A==
X-Received: by 2002:ac8:140c:0:b0:3a5:46e5:c5e4 with SMTP id k12-20020ac8140c000000b003a546e5c5e4mr6950410qtj.236.1668782994873;
        Fri, 18 Nov 2022 06:49:54 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a25d200b006e16dcf99c8sm2500522qko.71.2022.11.18.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:49:54 -0800 (PST)
Date:   Fri, 18 Nov 2022 08:49:56 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] bpf/selftests: Add selftests for new
 task kfuncs
Message-ID: <Y3eblFzToIh4hL8m@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-4-void@manifault.com>
 <20221118022100.qqer2hzuaahcgrml@MacBook-Pro-5.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022100.qqer2hzuaahcgrml@MacBook-Pro-5.local>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 06:21:00PM -0800, Alexei Starovoitov wrote:

[...]

> > +static inline int tasks_kfunc_map_insert(struct task_struct *p)
> > +{
> > +	struct __tasks_kfunc_map_value local, *v;
> > +	long status;
> > +	struct task_struct *acquired, *old;
> > +	s32 pid;
> > +
> > +	status = bpf_probe_read_kernel(&pid, sizeof(pid), &p->pid);
> > +	if (status)
> > +		return status;
> > +
> > +	local.task = NULL;
> > +	status = bpf_map_update_elem(&__tasks_kfunc_map, &pid, &local, BPF_NOEXIST);
> > +	if (status)
> > +		return status;
> > +
> > +	v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> > +	if (!v) {
> > +		bpf_map_delete_elem(&__tasks_kfunc_map, &pid);
> > +		return status;
> 
> here it will return 0, but probably should be returning error?

Ah, yes this should be returning -ENOENT. Thanks for catching this.

[...]

> > +SEC("tp_btf/task_newtask")
> > +int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
> > +{
> > +	struct __tasks_kfunc_map_value local, *v;
> > +	long status;
> > +	struct task_struct *acquired, *old;
> > +	s32 pid;
> > +
> > +	status = bpf_probe_read_kernel(&pid, sizeof(pid), &task->pid);
> > +	if (status)
> > +		return 0;
> > +
> > +	local.task = NULL;
> > +	status = bpf_map_update_elem(&__tasks_kfunc_map, &pid, &local, BPF_NOEXIST);
> > +	if (status)
> > +		return status;
> > +
> > +	v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> > +	if (!v)
> > +		return status;
> 
> should be return error instead?

Yep, here as well.

I'll fix both of these in v8.

[...]
