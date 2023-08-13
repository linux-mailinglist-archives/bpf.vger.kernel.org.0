Return-Path: <bpf+bounces-7679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAA77A883
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7971B28101A
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BE8BFD;
	Sun, 13 Aug 2023 16:03:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB7848B
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 16:03:28 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520A271E
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 09:02:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99d6d5054bcso638944266b.1
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=Oj0mSsS46jeV/oUT5MAXfcjss6McfNfiKYQrraiQMRL8sTJBw4d8L4S8yxi/lYj7/A
         7r3S5rxoqAmN6oWXyEodKqbZEwXf6+pND145SyK6r7I//24q0FiBkBdxVi4vJltOF7bT
         lO4vZDPaKABMHKqKaR3tn6kp7YpOPeVcnRgOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=IerI6zRWW2CXKUGqbRQnlv9j+KRypSszkjWXdvNF8Tf4EDWegUL4qus+D1ZGLlBI7+
         2Q+KasZU/F7XKXX9eqNJ8T7w+cJta8PhKBV9JjufiPEl43RXQbloC+oov2Ytzbdeejrt
         POSRIEDMTT064gJ0m5TBnmSI4qZeD8nJEBpSz6fy7ZmAvRO0n0T4j0hZgbaUt/4+lTjU
         CSbW4WHX+KPPwRKppPNpWMvj41p9evJ98pOCaf54OgU8ZUJMx9LGsaklyKi8vnf6gc08
         3Ng5epU77Fg3+Ho2zn3mQkqQy8e+P31pbyy8q3q0L4yh9BGUIfOKvsV/fCjbAzEOsnSH
         uIuQ==
X-Gm-Message-State: AOJu0YzC7HWGEel4Ev5Km/ukWuaRlMMDEcQ6wNYpxD+aTuCsvDBVAv3W
	fwz5W4V46KXL6+FQ6xL/+UnzbkOCGFPM8C+dfGBZKb0H
X-Google-Smtp-Source: AGHT+IFmzQA4DsW8nbT+msMMiylWy9OWi1jvkZjkuu+cT7+iQderfyxRJ26372D1rIjyc7JbO5nDug==
X-Received: by 2002:a17:906:32c5:b0:99b:b398:53b6 with SMTP id k5-20020a17090632c500b0099bb39853b6mr8790954ejk.34.1691942549311;
        Sun, 13 Aug 2023 09:02:29 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906255300b0099b42c90830sm4690010ejb.36.2023.08.13.09.02.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 09:02:28 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9592083a12.0
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 09:02:27 -0700 (PDT)
X-Received: by 2002:aa7:c683:0:b0:523:3e27:caa7 with SMTP id
 n3-20020aa7c683000000b005233e27caa7mr6430259edq.20.1691942547533; Sun, 13 Aug
 2023 09:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000094ac8b05ffae2bf2@google.com> <000000000000ab16cf0602ce0f9d@google.com>
In-Reply-To: <000000000000ab16cf0602ce0f9d@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 Aug 2023 09:02:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
To: syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 13 Aug 2023 at 06:38, syzbot
<syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit f1962207150c
> ("module: fix init_module_from_file() error handling")
>
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35

Looks right. Apparently syzkaller had two different bugs attributed to
this. It was already marked as fixing syzbot issue
x=9c2bdc9d24e4a7abe741

#syz fix: module: fix init_module_from_file() error handling

             Linus

