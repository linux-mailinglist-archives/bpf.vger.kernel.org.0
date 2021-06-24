Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF63B2DD8
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFXLaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 07:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232274AbhFXLaM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624534073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nF0UhK3Tr0u38x+8i/4+COM0eyWxjXZTlIH47kl0kH4=;
        b=NhUJpXy6wZ4S8t7vv/Iojez+W/jHNeUZcwJzfLF+s8K8du6zpQzBHLO73G3X+UkxGHEZ8L
        jH8b2LauUHkeCZOmRhpnTq08mMd/HgPXMU9hU1Zbt+Zk4x+9MOXleVUmjqh1Z5S4nbwbuJ
        zF7/IJHNgMEBm/mYJt6OnVMmrrmiA3o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-gRPJ5L6xPdKqNsMP_JPTMw-1; Thu, 24 Jun 2021 07:27:49 -0400
X-MC-Unique: gRPJ5L6xPdKqNsMP_JPTMw-1
Received: by mail-ej1-f69.google.com with SMTP id u4-20020a1709061244b02904648b302151so1885428eja.17
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 04:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nF0UhK3Tr0u38x+8i/4+COM0eyWxjXZTlIH47kl0kH4=;
        b=VKYOKS1ZMQtVOsRy8MmfGvUOyje3vE5UrDb7kuEhfYG2zl6oxrDIWc1GSoSIheEbuF
         FKa5DYLgEdmMgqfQ0aYa/RbECty7Lh94LDl7MQiUSTXyG3mEzI1jOKusbPg71CxbkPns
         ohHWFT0EG4xiI1yY0hkL05mH3FzsKN5cE4kdd8FzBjEaF+w5Hth5y/nlet3EhY6PaJru
         JxoxMBbdHRt836soJ07ChKhevFqK4f2FLp+JsHr3BE0OmxaIB6q9Yx3PRNICCl7j2wcX
         TbUDQ9cJiikzEC9RCyBffjxDswJJK9qrwMHaLR2W34/mM9Gvb1DaL3vADT2lms6JkWix
         IE8A==
X-Gm-Message-State: AOAM531MD3Ntap2zhVPV95FC2Kkgkvmh65iW8xZIt+DzGhkGZ1oWvFF2
        h3TpapaAekAC9ezg+25M+139W3GkQHCDJs2zDBKf+01l84SpBVDe9SOtvri7xKmbPh3oEtSAcTE
        G0ZLd1C1Pt+La
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr4739836ejb.194.1624534068535;
        Thu, 24 Jun 2021 04:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiLkvv03dVbfxeXKIcI4MYuF7i/8ki5PwPd50/nXmW14AjctDZNd1qFBIZiijPXQNi2b5oWA==
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr4739802ejb.194.1624534067984;
        Thu, 24 Jun 2021 04:27:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cn10sm1789326edb.38.2021.06.24.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:27:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C90EB180731; Thu, 24 Jun 2021 13:27:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 0/8] bpf: Introduce BPF timers.
In-Reply-To: <20210624022518.57875-1-alexei.starovoitov@gmail.com>
References: <20210624022518.57875-1-alexei.starovoitov@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Jun 2021 13:27:46 +0200
Message-ID: <87sg17mril.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> The first request to support timers in bpf was made in 2013 before sys_bp=
f syscall
> was added. That use case was periodic sampling. It was address with attac=
hing
> bpf programs to perf_events. Then during XDP development the timers were =
requested
> to do garbage collection and health checks. They were worked around by im=
plementing
> timers in user space and triggering progs with BPF_PROG_RUN command.
> The user space timers and perf_event+bpf timers are not armed by the bpf =
program.
> They're done asynchronously vs program execution. The XDP program cannot =
send a
> packet and arm the timer at the same time. The tracing prog cannot record=
 an
> event and arm the timer right away. This large class of use cases remained
> unaddressed. The jiffy based and hrtimer based timers are essential part =
of the
> kernel development and with this patch set the hrtimer based timers will =
be
> available to bpf programs.
>
> TLDR: bpf timers is a wrapper of hrtimers with all the extra safety added
> to make sure bpf progs cannot crash the kernel.
>
> v2->v3:
> The v2 approach attempted to bump bpf_prog refcnt when bpf_timer_start is
> called to make sure callback code doesn't disappear when timer is active =
and
> drop refcnt when timer cb is done. That led to a ton of race conditions b=
etween
> callback running and concurrent bpf_timer_init/start/cancel on another cp=
u,
> and concurrent bpf_map_update/delete_elem, and map destroy.
>
> Then v2.5 approach skipped prog refcnt altogether. Instead it remembered =
all
> timers that bpf prog armed in a link list and canceled them when prog ref=
cnt
> went to zero. The race conditions disappeared, but timers in map-in-map c=
ould
> not be supported cleanly, since timers in inner maps have inner map's lif=
e time
> and don't match prog's life time.
>
> This v3 approach makes timers to be owned by maps. It allows timers in in=
ner
> maps to be supported from the start. This apporach relies on "user refcnt"
> scheme used in prog_array that stores bpf programs for bpf_tail_call. The
> bpf_timer_start() increments prog refcnt, but unlike 1st approach the tim=
er
> callback does decrement the refcnt. The ops->map_release_uref is
> responsible for cancelling the timers and dropping prog refcnt when user =
space
> reference to a map is dropped. That addressed all the races and simplified
> locking.

Great to see this! I missed v2, but the "owned by map + uref" approach
makes sense.

For the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

