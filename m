Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB555EA54
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiF1QzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiF1Qyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:54:35 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2262B268;
        Tue, 28 Jun 2022 09:52:40 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q11so17938546oih.10;
        Tue, 28 Jun 2022 09:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E648dBFHTDJv9vUh9mhheRk7gXIcU15BjfaY5SWNU/4=;
        b=gSOVjOcaZjALmK5EbfhepRESzg4GXINUrjHEeizQpL7tEMR01Fpqo/0q9LiBDhPxjX
         7FoTvZhsbl8QY9p66GREDRk1O92ugUyTjYH+QjUSX3EpIIG9322ru9vWy8ZgkCw0vfAE
         Cy2gLMtYI3WUUBD64a6VsoRSPjMke93xJt0GqfZQjAG+ZYK8eAilDLZHaB9pmrMRNuU0
         Kp0zRpUJxraFtu0xJMnHHGD3q4ZFLWTGV0ENtljaPzrZAJRvmWZ5nZiOiyDvHxabd4kX
         Whsi7Z1bUSvinvIhyTN4mQ0Qhbd9bgMvL5Em4piMmIsX6BsqCQ5Qp8tkMtqQ32frgKtG
         /XBQ==
X-Gm-Message-State: AJIora9iM6tLltSP80PZLveZ4OwdsovipQY1RTXzxjnmmdOkw4grTvZD
        AUcfnCodqQKbbuVF40rhZ1eW6HWtVDMad2ZLq7M=
X-Google-Smtp-Source: AGRyM1sbCijzlGmpKPdegGoOMfsLP5Ed4vha/ePGdTsixV1iBn+35ReKPUl0TQoX1sPRdZ7ta5gDOyitlr+H1Ui4kzg=
X-Received: by 2002:aca:bb56:0:b0:32f:2160:bfd8 with SMTP id
 l83-20020acabb56000000b0032f2160bfd8mr402430oif.92.1656435159732; Tue, 28 Jun
 2022 09:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220624231313.367909-1-namhyung@kernel.org> <20220624231313.367909-2-namhyung@kernel.org>
 <YrsT3iw+FEXb6kxF@kernel.org>
In-Reply-To: <YrsT3iw+FEXb6kxF@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Jun 2022 09:52:28 -0700
Message-ID: <CAM9d7ciPK4Z05LYNNukAsTdEMEce4hOWRa83THbENDuWjXcyEQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf offcpu: Fix a build failure on old kernels
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 7:44 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 24, 2022 at 04:13:08PM -0700, Namhyung Kim escreveu:
> > Old kernels have task_struct which contains "state" field and newer
> > kernels have "__state".  While the get_task_state() in the BPF code
> > handles that in some way, it assumed the current kernel has the new
> > definition and it caused a build error on old kernels.
> >
> > We should not assume anything and access them carefully.  Do not use
> > the task struct directly and access them using new and old definitions
> > in a row.
>
> I added a:
>
> Fixes: edc41a1099c2d08c ("perf record: Enable off-cpu analysis with BPF")
>
> Ok?

Sure, thanks for doing this!
Namhyung
