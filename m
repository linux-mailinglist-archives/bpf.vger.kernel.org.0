Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87A2B9AD7
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 19:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgKSSo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgKSSo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 13:44:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6CC0613CF;
        Thu, 19 Nov 2020 10:44:28 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so5012377pgp.10;
        Thu, 19 Nov 2020 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iuwg6IYEd7EKVGUt96wlfcbkMOsvzHw4fPieXvt+LKQ=;
        b=rua3zrDa2ATl8eRD4ZvrJ/u0/zhgyeEFCb8/umw2v/TzgrYjv4NSwcJbZ4ZKFV/ViK
         2vy7hJFILziUTxZ7BOUiuzkEfniZm2AN1LC+jvAQqoimFeLCohaqjjfiQYnLsyJdt0sX
         I3ulbYNtuRndXdyXvmnzbvz88HWhEtPSleyNr20mSWZEuS5q+36xaG5yfsfC7hHjjExY
         8sWYZpckwdQheykw1i+96FCNSPZyIbwJi1whubGuWPu8vgjfl709s5GSPUZTlKP9D75O
         ZBpvndJUSwGnc8nquOCrjMXbRnI64v/KZ7AxgATbDpVuJBccij+H0vs2iIWhn28u4P/2
         flkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iuwg6IYEd7EKVGUt96wlfcbkMOsvzHw4fPieXvt+LKQ=;
        b=b184UASfNHTCKGoZi8JAXhiar4l0qZHinXesCqz+6XrlKoPkKp/7MC25Hy3m9Zg937
         zwg27MyVv4Z1v+vHRBeEa4twa/XzbYvu3GL2QxvfQ9Q6aRc64wVOjK9rOp7XGiNBd6js
         6EJYm7ImYaDFzr9HOLkrDfHXu6cLaMm+rNeVIWFfFUtpNMnxOEGOIBojvOb+q4o/L1h2
         0SdU4SW5XvjR5Oto0+EEfE8KQgKxLm7y2ww/6m6LiPQ2CMHlTuL8nA+BJf0otO6Ohdjf
         8PRuLpdICU/geMTQxkZ4m3CgseT03lLxn035X1hqaBIhwUK4Zi2AmrkKE/PqBdl5/W9q
         AfPg==
X-Gm-Message-State: AOAM530Yvzj9QilH/pHmX7LSYhwpnH5audwb1EfZy39kpvR5pHCO+smM
        bybmvuAw1bNqZZHabSLsFdMCMjGzTrI=
X-Google-Smtp-Source: ABdhPJxeZ0q3hA3ZQegTJlS7udKKI8t3Nju4P20Pg/NUQPAXEew4eYko2HevzOiV8+to+XN/zRdxGA==
X-Received: by 2002:a17:90a:f3d3:: with SMTP id ha19mr5805389pjb.177.1605811467748;
        Thu, 19 Nov 2020 10:44:27 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:c1e7])
        by smtp.gmail.com with ESMTPSA id t10sm558898pfq.110.2020.11.19.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 10:44:26 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:44:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201119184424.deufdcmxymd6ep7j@ast-mbp>
References: <cover.1605642949.git.dxu@dxuuu.xyz>
 <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
 <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com>
 <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
 <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 19, 2020 at 10:40:21AM -0800, Linus Torvalds wrote:
> On Thu, Nov 19, 2020 at 10:34 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > ping.
> 
> I'm ok with this series that adds explanations for why you care and
> what bpf does that makes it valid.

Great.

> So this one you can put in the bpf tree.
> 
> Or, if you want me to just apply it as a series, I can do that too, I
> just generally assume that when there's a git tree I usually get
> things from, that's the default, so then it needs ot be a very loud
> and explicit "Linus, can you apply this directly".

Right. The set will go through the normal bpf.git->net.git route to make
sure it is tested by humans and CIs.
Thanks!
