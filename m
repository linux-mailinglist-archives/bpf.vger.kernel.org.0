Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706FB6AB519
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 04:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCFDk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 22:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFDkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 22:40:53 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D81969D;
        Sun,  5 Mar 2023 19:40:52 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-53852143afcso160699937b3.3;
        Sun, 05 Mar 2023 19:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678074051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEsb2PcrVmsOtwKmZLcSjj7+FCn46/zcXnRbCf5Zqhg=;
        b=o6oQiZDbG2e/pfwvOXYaOvzOpROTPyD6zXmDZGGtaoPTzD22A+leMk8If15iqTUva6
         7hJtapelmD0wqj79UM7e9icEBf/Z4PqaJiz5eLX1HQGalgLnhGoZoSZAksFlJieSb80g
         m/TtQyP6SaBbusT1tvODYPMJnAZVLsX0kVXB7t0wBbCXU8whKjP5SHB+Sf3bblGmopgA
         BeYowCyfv32M6dz7+HSsU6PwTrrHGIoUkocRv18obx/Vq8aDvXCkLU5n/TY/LzAnlDLN
         iQqEkTjjggHEwMZsYz3i9yq44UDNHL7j3QXG03iEQKO+qvbbywmAkcHzCKXkLbl2DB9+
         APlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678074051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEsb2PcrVmsOtwKmZLcSjj7+FCn46/zcXnRbCf5Zqhg=;
        b=Mu+Wm7NSe0hwSYKUFoAqY4NIa9i365WJVQlqf7neexk5KyZwvbpvac5n1fteViSDo2
         a4XGzOyslxQmVPE4lncELCWU+nI5bzgwxmW8S9jrXHRlUswX2jDunkqXH9wgWdm727Fu
         RpSa8J2B9ZUykxEs/Q+VhDLoqeJIJ7tTlWWUcaO+A2KCTmTLcqyNYvwhwvs+Bx7kI1qM
         qJQH2PGNTu+Uzi4WbkfumixNtrb57slSoUWqNXvYChZIi70FtIBjsrt/ALaFTHRBEv7j
         NIsw2OsJVAkFDnBacHgn1aLQ2Nw07s+1CQKpEvjraW8/xbvFnvhW8G4/U9PSBrc1jq0J
         Fu9w==
X-Gm-Message-State: AO0yUKWNRuT/XpX1Rzyn+sRcmqFcR69bODyoCSdd8H/yGF7BaljhCann
        zYVym1Ru1s0BjLbL80cxUoqbrccVHZdlSc+nqL0=
X-Google-Smtp-Source: AK7set/sUfIr8Lt7rth08kincWVh2LgfUsLYn/YERYQr32Bad1rLhhAfvE15h+UwdQEM0U+CGcBpXBKP38OBpuprq4A=
X-Received: by 2002:a81:ae4e:0:b0:52e:ac97:115f with SMTP id
 g14-20020a81ae4e000000b0052eac97115fmr5979134ywk.5.1678074051094; Sun, 05 Mar
 2023 19:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com>
 <20230221025347.389047-3-imagedong@tencent.com> <CAEf4Bzac+SmdosLf=nnieuEBx6azVTg1_fVNWScsWb9-Hap6pw@mail.gmail.com>
In-Reply-To: <CAEf4Bzac+SmdosLf=nnieuEBx6azVTg1_fVNWScsWb9-Hap6pw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 6 Mar 2023 11:40:39 +0800
Message-ID: <CADxym3YT1JGQ+ZiwLrfrBz_J=4XPNv-7ic+9mMyaCHwDyQARdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: split test_attach_probe
 into multi subtests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 5:53=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > In order to adapt to the older kernel, now we split the "attach_probe"
> > testing into multi subtests:
> >
> >   manual // manual attach tests for kprobe/uprobe
> >   auto // auto-attach tests for kprobe and uprobe
> >   kprobe-sleepable // kprobe sleepable test
> >   uprobe-lib // uprobe tests for library function by name
> >   uprobe-sleepable // uprobe sleepable test
> >   uprobe-ref_ctr // uprobe ref_ctr test
> >
> > As sleepable kprobe needs to set BPF_F_SLEEPABLE flag before loading,
> > we need to move it to a stand alone skel file, in case of it is not
> > supported by kernel and make the whole loading fail.
> >
> > Therefore, we can only enable part of the subtests for older kernel.
> >
> > Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> > v3:
> > - rename test_uporbe_ref_ctr() to test_uprobe_ref_ctr() to fix the
> >   typo
> > ---
>
>
> One of the patches in this patch set broke BPF CI ([0]), please take a lo=
ok
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/4267719970/jobs/=
7429701318
>

It is caused by the fact that I didn't use OPTS_GET(), as you mentioned
before.

> >  .../selftests/bpf/prog_tests/attach_probe.c   | 268 +++++++++++-------
> >  .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
> >  .../selftests/bpf/progs/test_attach_probe.c   |  23 +-
> >  3 files changed, 208 insertions(+), 106 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprob=
e_sleepable.c
> >
>
> [...]
