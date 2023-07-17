Return-Path: <bpf+bounces-5115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E87568E0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28141C20AE9
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC4BA55;
	Mon, 17 Jul 2023 16:17:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC2253CA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:17:13 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F4FC
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:17:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4fba86f069bso7468607e87.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610630; x=1692202630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KigaZXaBas0HfHAgB8L24DdbGQFnqCgzOfD518q2RQ0=;
        b=ghSm2aj20THJpH1x+td47JSbDr+lMyKDUD0kBojQUBXBkVlVqMO8AkDlnzXuaeen0c
         6O/fzOHzB30URATWNa3yDYzJM/YH/qLriHyot6WLZlNJQqBl0ThtdEjy7Zlio9bA00ps
         HUWdzd1IQQQ3ouiZro+ogelEcIBfHmyVcMuty5vlaPsbkJKLgO4J/+HmyH9xx/H4Rn8F
         vY07mROMEFKjpJ/B5ZdNaSqVrrW+D+kSY6YUSnnrMEopIcE7e3E8aKdA7X/LnE7pL7VS
         2b8SDnpwPlidew06IQw5n7UB1nmQZFto2LlQLHz/XmzBTX+7dl0pe1FzkNcoFGk7EPrV
         EhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610630; x=1692202630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KigaZXaBas0HfHAgB8L24DdbGQFnqCgzOfD518q2RQ0=;
        b=a5+S1EL4dfXF0OEGBz9YlVD19GXzN028Qw7qLm6QsBMjYKMc3HHtVgLlScb4PBf8iq
         +u6npDDFyTSovEpC7rkgJ4p/j/3RRyhRQQqugyO3AifM+OO1G7IVhCZ4E0rOq29UeF4G
         StOYlvGxQc+7A0pLGrmTyPUiz42ROa49DjYMEhkrWYrZ1KDLiDWPWXQXAsiiEOrFltsk
         xlt6LirFk0E4LmKS/TKwGtFfhGVYuMaXz79X38kv0c3NEWNgtVdBJ+3TKuUU+A6u2ddC
         3qezSjisQ6ysh8Ojq0vqcX86YwfauUmQAX5KJ9/irPtnsjZ+7eeymeg82DybzJoxfCUf
         xI5g==
X-Gm-Message-State: ABy/qLacZ6H6fMynYiUM2sYBpQi+qTWN7izD4UNFBAWWwAaNLdW5gHHY
	3ZGfuaiSJLpA58kRVziKMQ4X5gIeqCnZgUta1QY=
X-Google-Smtp-Source: APBJJlGCGn0LxbDkcyNzmR536VJaMeXlmn6tyDTgnY+JZ8Y8gU7+AfG5m9MuZ9O6KQETwkuvvYMDvLeTcWvAYvongR0=
X-Received: by 2002:ac2:4461:0:b0:4fb:911b:4e19 with SMTP id
 y1-20020ac24461000000b004fb911b4e19mr7668880lfl.35.1689610629410; Mon, 17 Jul
 2023 09:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713003118.1327943-1-memxor@gmail.com> <20230713003118.1327943-3-memxor@gmail.com>
 <20230714214851.cfadshwpijm6z2vg@MacBook-Pro-8.local>
In-Reply-To: <20230714214851.cfadshwpijm6z2vg@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 21:46:29 +0530
Message-ID: <CAP01T76rGNMkAaJ4-XyixGgoW_kjJhsNaGmP3sX571SM=9Q9jg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] bpf: Repeat check_max_stack_depth for async callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 15 Jul 2023 at 03:18, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 06:01:17AM +0530, Kumar Kartikeya Dwivedi wrote:
> > While the check_max_stack_depth function explores call chains emanating
> > from the main prog, which is typically enough to cover all possible call
> > chains, it doesn't explore those rooted at async callbacks unless the
> > async callback will have been directly called, since unlike non-async
> > callbacks it skips their instruction exploration as they don't
> > contribute to stack depth.
> >
> > It could be the case that the async callback leads to a callchain which
> > exceeds the stack depth, but this is never reachable while only
> > exploring the entry point from main subprog. Hence, repeat the check for
> > the main subprog *and* all async callbacks marked by the symbolic
> > execution pass of the verifier, as execution of the program may begin at
> > any of them.
> >
> > Consider a function with following stack depths:
> > main : 256
> > async : 256
> > foo: 256
> >
> > main:
> >     rX = async
> >     bpf_timer_set_callback(...)
> >
> > async:
> >     foo()
> >
> > Here, async is never seen to contribute to the stack depth of main, so
> > it is not descended, but when async is invoked asynchronously when the
> > timer fires, it will end up breaching MAX_BPF_STACK limit imposed by the
> > verifier.
>
> The fix is correct, but the above paragraph is misleading.
> async doesn't and shouldn't contribute to the stack depth of main prog.
> Could you rephrase it?
>

Agreed, I sent a v2 with a clearer commit message.

