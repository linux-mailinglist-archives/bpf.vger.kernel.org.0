Return-Path: <bpf+bounces-9459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0319797E80
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 00:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDF2817D4
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FD14295;
	Thu,  7 Sep 2023 22:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456C14287
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 22:01:12 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704031BC5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:01:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414ba610766so125491cf.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694124068; x=1694728868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+9W+cIUqnkYjU4lTHh4H1Mm4lUORJaSRy/C8dyTa4Y=;
        b=5tSxhaJwbiP/3HmgWPsMKLkA4P6xnY4ocnUmmozyuBiZ41Yjym2xnCUmg8dGKK4dJd
         h6hmp85qTpMQCB6MKs33ewOKWNIKgC5Wge/shJgmbUdKhAQN0Xr+JCElRPhzUoYZas5Q
         7+sOWYvgHyOgpZ50WnkTGNs0upjFseMR1s4ekpRBZoT6mouNQ84UEAS25UgrtJuodSqM
         3n6pnmtBVExWIK/RQ49/LvjSVJAxaVeNLw9qObvrO2sGgo8XHGoKRmttFcaPKtSY+7hI
         lhC//CPrUR0QJpwiQZ/1+kPsgfQKrgLAwJ4alvQBAQvBnnGmaOtTrAQ5MPlsl9lDCfSA
         n05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694124068; x=1694728868;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+9W+cIUqnkYjU4lTHh4H1Mm4lUORJaSRy/C8dyTa4Y=;
        b=E2i4VMNfZ+asZu37g0ftaP7DTbAbf/6HGSjpY5pDyM5PGiKFObID+usMbBgdQ7ZNEV
         2zhZn/irxSFxQOEjJn2xa1oclPCAm7SEjUaP2dfg1XwxKaUokaJwVn6J8YKp5jNDQYfH
         MSJc4P13PxHqn3Kc0+q6VTgFY9SLpX0j+lE02wVLAsExwdDgiEpc5AEAIHbI3WHePUVJ
         Wxs7BWp5+z54pc1gFSD91BCWP2t4dNR4eLRsJ81BNSIMAG+1UOw1w+NRkH8Wt/O00e2L
         k/8ZwaNuB2QH9LTyH0o80bLkivtRoZX74onVyEl6mBCQdyHEnPa11CEjKH5Q0nQAGFLS
         ieXA==
X-Gm-Message-State: AOJu0YxfznMrZpM1/7mMY2KRdu1pq9QGkD91/UZeswScruBEVpRb8/qr
	7KIpf/n8ZqHSvkLbE2e82wUAcHdqWKkOH6OhE1CkZw==
X-Google-Smtp-Source: AGHT+IEcufkwP8kstZo83oLEqPg3u9paC4bidpy9Y7NdlHxdHZDNk5sSDkONA4sIDWRXpyGGuOfJCXEJ2hXSa+lgemo=
X-Received: by 2002:a05:622a:453:b0:403:ff6b:69b9 with SMTP id
 o19-20020a05622a045300b00403ff6b69b9mr30517qtx.13.1694124068476; Thu, 07 Sep
 2023 15:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Don <joshdon@google.com>
Date: Thu, 7 Sep 2023 15:00:56 -0700
Message-ID: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
Subject: BPF memory model
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Hao Luo <haoluo@google.com>, davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>, 
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>, 
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paul,

I was chatting with Dave Marchevsky about the BPF memory model, and
had some followup questions you might be able to answer.

I've been using the built-in RMW operations to do a lot of lockless
programming, for concurrent BPF-BPF, but also especially for
userspace-BPF (the latter of which has become a lot more interesting
with the sched_ext work from Meta). It would of course be nice to
sometimes lower the synchronization overhead to a hardware barrier or
a compiler barrier, to allow for general use acquire/release semantics
(rather than needing to fall back to a lock RMW instruction). I saw
your presentation from 2021 on this topic here:
https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-memory-model.2020.09.22a.pdf

Has there been any further interest in supporting additional
kernel-style atomics in BPF that you know of?

And on a different BPF note, one thing I wasn't sure about was the
ability of the cpu to reorder loads and stores across the BPF program
call boundary. For example, could the load of "z" in the BPF program
below be reordered before the store to x in the kernel? I'm sure that
no compiler barrier is ever necessary here since the BPF program is
compiled separately from the kernel, but I'm not sure whether a
hardware barrier is necessary.
<kernel>
x = 3
call_bpf();
  <bpf>
  int y = z;

Best,
Josh

