Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57860539B27
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 04:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbiFACQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFACQv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 22:16:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06536959A
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 19:16:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q203so383292iod.0
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oer42FJjntZqJNavHcu5LSKKk3Dftd2hay8RaEDOmsg=;
        b=NeovFTM3wD/ZbcqdqiMv2JuDjEd2SgtBDXw6jpzOeawp24IV6aJ7ZdtLafFgc3uIrf
         RwmR2nIkHcJw9EYBSfL7Fnqe3IkwZxLnVduslQLDudf+j9CkqYsikYKiMUsyXaf9mgKB
         T37Aw8OtwuZ4NSshqHbB9flyVdOA9VF1lDZ1JyyjikG+r7v7SIqcnRTZJjdv1BOTsy23
         YO86/JjmgdAPinR6sbC8R1zVKmfAIUg1G4JfbUW0lJPhrUXZkSjtmszAvX0rqdyn2pCZ
         1w9CzZYRblenvxgL4HsuGcQF55sMJ+pczUE8w2nyBFpQGNCgmqgaGHlMeGIoHa7rmfvb
         Kn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oer42FJjntZqJNavHcu5LSKKk3Dftd2hay8RaEDOmsg=;
        b=RD2ryXdxnHHiNxS+P3eH8o9oQc0FZMqm/Asms6dNlwHDmeWsO+TRETsV70mWBR+jAn
         3w3l8S3sb67ernaSFPdoXLoh9ancfP6xWDMMuYECHGXEq12Qb/IKMRdVWUa0dOiksWB/
         fL9at5c/7ODb2m65fuU/0B1uwfj+/UVK+wdA09qYMseTpqdeirkNy5n9a4o5OQDi6crh
         EhgKH/JIcO11yX3P/yd8tXrQx5/huT579ZO5uf6YjUma4glsFYdfsjJzKWKVERLQlN4F
         73WBH8GgoVCw5qc++kSVoU4L68N+loA6/l8WX2edHv+A2e10y+wC4a+k15knP60zbtHU
         bBMA==
X-Gm-Message-State: AOAM530BFYrET/IEv8hCXpYoRxnG/EhjvZV2X9Kt901AteEMEvZARr0t
        +2xI//j5Huly4b7rb/L5ofk+pg7ueexHq35dA+M=
X-Google-Smtp-Source: ABdhPJxs1eSNyTDCZZg1Wu9y3vtG3sZC4+GztjKmiSjCl0JdvkE3G3ltwddv5ugqZuXK8p0h3GJlxHXpa1yKgAMvC0E=
X-Received: by 2002:a05:6638:411f:b0:32e:a114:54e with SMTP id
 ay31-20020a056638411f00b0032ea114054emr27921640jab.82.1654049809435; Tue, 31
 May 2022 19:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
 <CAEf4BzbiiZd7OJxN17=3ikZTor_mcqVO2XTdK6dbpcm9NqgX8w@mail.gmail.com>
In-Reply-To: <CAEf4BzbiiZd7OJxN17=3ikZTor_mcqVO2XTdK6dbpcm9NqgX8w@mail.gmail.com>
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Tue, 31 May 2022 21:16:37 -0500
Message-ID: <CAPxVHdJL6-m3BbDSaHOn_kq31cBh2LEHeEqNnw7ecOXz7Aqijg@mail.gmail.com>
Subject: Re: BPF_CORE_READ issue with nvme_submit_cmd kprobe.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I pulled the latest libbpf-bootstrap and rebuilt my programs. The
error message is clearer now. I think last time I tried
libbpf-bootstrap was still linked to 0.7 instead of 0.8.

The new message is the following which makes sense in regard to what you said.

<invalid CO-RE relocation>
failed to resolve CO-RE relocation <byte_off> [14] struct
nvme_command.common.opcode (0:0:0:0 @ offset 0)
processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

This struct is part of the nvme driver, which is running on this
system as it only has nvme devices (including boot device). I've been
able to access this data using bpftrace on the same system. If I don't
try to access this struct I can count the correct number of
nvme_submit_cmd triggers, so I believe the probe is working correctly.
Is this a case where I need to define more/all of the struct?

On Tue, May 31, 2022 at 7:22 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 27, 2022 at 3:07 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> >
> > While attempting to learn more about BPF and libbpf, I ran into an
> > issue I can't quite seem to resolve.
> >
> > While writing some tools to practice tracing with libbpf, I came
> > across a situation where I get an error when using BPF_CORE_READ,
> > which appears to be that CO-RE relocation failed to find a
> > corresponding field. Compilation doesn't complain, just when I try to
> > execute.
> >
> > Error Message:
> > ---------------------------------------------
> > 8: (85) call unknown#195896080
> > invalid func unknown#195896080
>
> This means CO-RE relocation failed. If you update libbpf submodule (or
> maybe we already did it for libbpf-bootstrap recently), you'll get
> more meaningful error and details. But basically in running kernel
> there is no cmd->common.opcode.
>
> >
> > I'm using the Makefile from libbpf-bootstrap to build my program. The
> > other example programs build and execute properly, and I've also
> > successfully used tracepoints to trace the nvme_setup_cmd and
> > nvme_complete_rq functions. My issue appears to be when I attempt to
> > use kprobes for the nvme_submit_cmd function.
> >
>
> [...]
