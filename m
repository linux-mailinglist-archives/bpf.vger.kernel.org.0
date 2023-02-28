Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD226A5C1F
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjB1Pis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 10:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjB1Pir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 10:38:47 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EA30F3
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 07:38:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c4so3120927pfl.0
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=khE6y9fxg25nULP98zI7omx6tfLEkOS6sqwmlMrEObk=;
        b=nSYgfnt2nxKfwaozy0+DiAhC5Yw0250IBe6cVuDka6WpAe0bHfHREB2zemvZTmBUHT
         TOY2t/1ctycfGajKsAt/ELcyQctktwWCn6qjh0hF56JaOxSlD3DsnlZABImhpsYZPpjc
         pmUTFhVwrvdrVTjhrIBHl2xouLUC08+r+RWfb3ehmUHocIPXX7aRw4HIgxK4gAH2cdym
         MXA8mBVDq8kb0ABj6pVs+WfT4uvY10HtZj6/iie2gGHDeqWKDxNtVltifeDzMiY97/gC
         wILmatXcW2UsbI9KfE/1rgoJxVIhRHca0VeyTxXgIwED8ZPc9lWWBBxqwEBUdepUgf2B
         ZjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khE6y9fxg25nULP98zI7omx6tfLEkOS6sqwmlMrEObk=;
        b=H3CD2I9f9kRuBhKz68zuvXeErdCLpL5qIqITYhBhmQsglrwjFTKnXHNIjYzOIvN1I4
         bj2oDJi41x7z0vwXdbvTRWmcALCDIG39cy72q5UVSd9Be0kgMm3yqF7xc/oCZvBnmDRV
         DKBbjj+jfXGoTQgXnpH2S+zKTEE05665lsJOjxVa1WyO0jdsv3iokFgqtNvc7+ovJP7a
         YopdvXoxoc74Zrey3uU+mB2ldtu9hzT0QTPb7Sfy2dzaeFlyuYmxfs2tyzvIqXBlvhA2
         PZtRgT2Ha+6M9qY3+oLgf2PrvuQxDdfP4EQ2X7dmqO2prJgEKTkzgrKaKmuFaBn3rNTH
         /C+A==
X-Gm-Message-State: AO0yUKX9QC67VW7/2Xn95DK8MSSGqkaZOA9Q5mseGP+XGMtyHnOW92Ll
        g8v+H+cx1OWTKnUD5qlBNFYwgOALlkPNX9NRQYPJIL/Qf3jiT4RWNx4=
X-Google-Smtp-Source: AK7set9LPn2TWZqtoRC3Yy08cY0JtzvAj0lgUUc58vUFTf6Gv5SqoEO6c8kysfW26N8yW0N3Y0BekXZdXdepXctebcM=
X-Received: by 2002:a63:3e02:0:b0:4fb:933a:91a with SMTP id
 l2-20020a633e02000000b004fb933a091amr950859pga.5.1677598709653; Tue, 28 Feb
 2023 07:38:29 -0800 (PST)
MIME-Version: 1.0
References: <f1ea109c-5f07-4734-83f5-12c4252fa5ae@app.fastmail.com>
In-Reply-To: <f1ea109c-5f07-4734-83f5-12c4252fa5ae@app.fastmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 28 Feb 2023 10:38:18 -0500
Message-ID: <CAEzrpqcC4Z_wpcnfVp8oL5-k8s9RL=W=9rz5Z6P5emd3w1tndw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] vmtest: Reusable virtual machine
 testing infrastructure
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 6:02 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> === Introduction ===
>
> Testing is paradoxically one of BPF's great strengths as well as one of it's
> current weaknesses. Fortunately, this weakness is not too far from being
> corrected.
>
> BPF_PROG_RUN is somewhat of a double edged sword. On the one hand, you can run
> reproducibly run progs in near-production context. On the other hand, since BPF
> is so deeply intertwined with the running kernel, you must make the kernel you
> run tests on as close to your production kernel as possible to get full testing
> benefits.
>
> This is going to be more of an issue going forward through the growth of kfuncs
> because kfuncs do not possess a stable ABI [5]. Proper testing should be
> encouraged at a community-wide level in order to avoid accidental surprises and
> potential loss of faith in BPF "stability".
>
> Most successful kernel-dependent projects deploy some form of
> virtual-machine-based testing [1][2][3][4] to solve the above issues. However,
> there are two problems with this:
>
> 1. VM-based testing is not quite common knowledge yet and remains somewhat of
>    a dark art to successfully implement.
>
> 2. Multiple implementations of what is essentially the same thing is somewhat
>    of a drain on resources.
>
> (These are not necessarily bad things -- it is useful and necessary to explore a
> problem space before settling on best practices)
>
> vmtest [0] aims to solve both problems.
>
> === Goals ===
>
> I'd like to do a short presentation on the design and ideas behind vmtest. I'd
> also like to show a quick demo. It shouldn't take very long. I'll probably
> also share what I'd like to implement next. I don't know what that's going
> to be at time of writing b/c I'm probably going to get to it before LSFMMBPF.
>
> For the rest of the time I'd like to discuss what the community would like to
> see in vmtest. And to hear what it'd take to see adoption from other projects.
> Obviously no one can be required to adopt vmtest but I think it'll save everyone
> a good deal of effort if done correctly.
>

FYI a lot of us have been working on kdevops
(https://github.com/linux-kdevops/kdevops), which has similar goals,
tho yours feels more in line with virt-me which I've used a bunch as
well.

I would very much love it if we could all get behind one project.  The
benefit of kdevops is it's very extensible, and being able to select
some config options and have an entire testing suite up and running is
very handy for new developers.

That being said I can definitely get behind have two sort of options,
the bigger swiss army knife that is kdevops, and something smaller
that's easier to do one-off runs.

kdevops using vagrant makes a lot of the pain of setting up the full
VM environments that existed before go away.  I can easily tear down
my 8 CI vm's and rebuild them all and having them testing again in 4
commands.  Nowadays I probably wouldn't use virt-me/anything lighter
because this is actually pretty easy to get up and running.

Again no trying to be discouraging, but you're absolutely right that
there's been a lot of fragmentation here, which is why I've spent
probably a lot more time than I should have making kdevops work for
me, as well have a lot of other kernel developers, and it's getting
pretty solid.  Thanks,

Josef
