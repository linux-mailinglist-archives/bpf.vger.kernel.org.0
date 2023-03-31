Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DE6D26FF
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaRuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjCaRuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 13:50:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03020C0B;
        Fri, 31 Mar 2023 10:50:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so92946659eda.0;
        Fri, 31 Mar 2023 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680285009; x=1682877009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTSInc1hEMlYXcRUzZw3sB6bDw/vkk8trNy0igsO77g=;
        b=JWHttF+U881liKLznpNczcG4ef0TQdscctTn0CgDG1RwxIWiPyAOZ51491+LCiBXkC
         jex/ue1YShWNuVgw8e4nKWECXs8nW0BpYfS0iph8SJSuAxxB2uYR3pyTzu4nSeo/qAMf
         xF1BF2rgSGzIXyfdjcvV71NpzXgXSujswcB8iBx1IXcBe17BBl4jb+LFwE11ZsLe6+Gq
         FZ5mkRfcAYOkpIFhSr4PJnFpsgsyGr6+zoxkPyo56C2ZY/QuesJhoF9LSgNsWGOjUbX3
         QQJ0f9Zt3Q9zG+XZuwVKZZVRX3aE6lWgUoLtZ+0AMENubqb0VsstJR6lSiRxdaSazPS8
         BdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285009; x=1682877009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTSInc1hEMlYXcRUzZw3sB6bDw/vkk8trNy0igsO77g=;
        b=5P7R9PI9RFY0ifXl2/pJdqZFT9MuY4+jGssY6u1Vv+eVdpngTxuUtR923wpHFyBzBx
         wbnF8hDF5dLytlRPzXXOPyEZnnxBsNMfBEbCvR5Ucs/XXW3a6sA3GdNTAfKu36GsRuvz
         UNJS/iOrARniELQAqbWsKCFTpLAIS2wK9gCrlebEffnj39O5p8P4L8TfWuWKnzwJtdaZ
         QZT1AQioS72XgD/r8RmRQsSj7aHEIwQXlCKxmG3vtOlQpKPc/vL78r0Q4KvLPFUgWJaE
         SXEKWsfdyR7khdSqdRaQL2DpdnxPMjz/DopjXe2xXC0VAHsqddI70Hd9pwnpr1HyjMtD
         M8FA==
X-Gm-Message-State: AAQBX9f0TWkm7XMP9TyzPvsdqacv7Q/3Ill8mnQzQqRf6bBjZpfMAEHL
        NSh7/8JKSr30i3qppQHi/Cqnp6QWi/uFrTt4PXw=
X-Google-Smtp-Source: AKy350ZaQREvHlzL1wEQgAvnMsWGVfuMrRYOa0aSKjiz5BVaTb3LHI+xesFk2pGbMJ83TiwkCTxVemd7s/e0YXyMojw=
X-Received: by 2002:a17:907:2d91:b0:931:3a19:d835 with SMTP id
 gt17-20020a1709072d9100b009313a19d835mr14952431ejc.3.1680285008891; Fri, 31
 Mar 2023 10:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230331005733.406202-1-void@manifault.com> <20230331005733.406202-2-void@manifault.com>
 <20230331170504.umr5zmcraburmtkg@dhcp-172-26-102-232.dhcp.thefacebook.com> <20230331173511.GA417548@maniforge>
In-Reply-To: <20230331173511.GA417548@maniforge>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 31 Mar 2023 10:49:57 -0700
Message-ID: <CAADnVQLUJF7v_NmM1z1_qtcEJ2=ePHJHAp=fs+AAo6snfU2nYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Make struct task_struct an RCU-safe type
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 10:35=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> On Fri, Mar 31, 2023 at 10:05:04AM -0700, Alexei Starovoitov wrote:
> > On Thu, Mar 30, 2023 at 07:57:31PM -0500, David Vernet wrote:
> > >  kernel/bpf/helpers.c                          | 11 ++-
> > >  kernel/bpf/verifier.c                         |  1 +
> > >  .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
> > >  .../selftests/bpf/progs/task_kfunc_common.h   |  5 +
> > >  .../selftests/bpf/progs/task_kfunc_failure.c  | 98 +++++++++++++++++=
--
> > >  .../selftests/bpf/progs/task_kfunc_success.c  | 52 +++++++++-
> > >  6 files changed, 153 insertions(+), 16 deletions(-)
> >
> > See CI failures on gcc compiled kernel:
> > https://github.com/kernel-patches/bpf/actions/runs/4570493668/jobs/8068=
004031
>
> Thanks for the heads up, I'll take a look and resubmit v2 with fixes for
> gcc. In general it seems like a good idea to test both gcc and clang
> selftest builds; I'll do that from now on.
>
> > >  __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct =
*p)
> > >  {
> > > -   return get_task_struct(p);
> > > +   if (refcount_inc_not_zero(&p->rcu_users))
> > > +           return p;
> > > +   return NULL;
> > >  }
> >
> > I wonder whether we should add a bit of safety net here.
> > Like do not allow acquire of tasks with PF_KTHREAD | PF_EXITING
>
> That's certainly an option, though I don't think it buys us much. It
> doesn't prevent the task from being pinned if it's acquired a bit
> earlier, and others in the kernel can acquire a task with
> get_task_struct() regardless of whether it's PF_EXITING (or an idle
> task, etc). IMO it's a better UX to provide a complementary API to
> get_task_struct(), but with RCU protection. On the other hand, it's
> already KF_RET_NULL, and I doubt needing to acquire a task that's
> PF_EXITING would be a common occurrence. We could always go the more
> restrictive route, and then loosen it if there's a valid use case? My
> only concern is that this safety net arguably doesn't really protect us
> from anything (given that you can just acquire the task before it's
> exiting), but maybe I'm wrong about that.
>
> > or at least is_idle_task ?
>
> Hmm, this one I'm really not sure about. On the one hand I can't think
> of a reason why anyone would need to acquire a reference to an idle
> task. On the other hand, it seems pretty benign to pin an idle task. I
> guess my sentiment is the same as above. I'm fine with adding a
> restriction and then loosening it later if there's a valid reason (and I
> can add a comment explaining this).

Good point about pinning earlier. Let's keep it as-is then.
bpf prog can do such checks on its own if it needs to.
