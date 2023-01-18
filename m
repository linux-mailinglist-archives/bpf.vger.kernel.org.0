Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8167216F
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjARPgs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 10:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjARPgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 10:36:36 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5435B9;
        Wed, 18 Jan 2023 07:36:34 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id t10so25521324vsr.3;
        Wed, 18 Jan 2023 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k1MyFwiLDNIcgELLI1pyHSb8UiFg9DjutwEkM/zD8k=;
        b=SA9i4YhM/XnAJb3VGSeE7hQXEDCMMTn1QNNAeUvN3HhBsJkcWCwTFv0WPJ1mNJvmz8
         XiB/HIo9OOnIsfqtrd4uZmabT7nKKZ3+LzRXdeW2uag0Pye2Ist2SglHa+HXXZHf4IVK
         q65U0W+22MqWPSD1THSo2pOAQ5SCOlMnCczYtZK0PDXN5GM6kDgu2C28zVgl3lsOBuKJ
         vux8kN/UOyY1hxxvFLUPHvLQFK27xwzXwmzHDMbouvboMii1usp1jZWYssAOPse/jaBe
         7KxFN5YxvF5He+TGLCu5KnJcevTaYKPPUR9DeQFO5SdPa+iJ6n2FPBxEwvVr9sR+FM3W
         v4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k1MyFwiLDNIcgELLI1pyHSb8UiFg9DjutwEkM/zD8k=;
        b=xnMi8qYy/72sOV6wU8jYZbZO7rkeuE/9AvPiJ4UNi1VQONW+cQyjCX/xKuYJ/eys3d
         Rlx175j6leeAMBOQNTYZ2rtuZy7YwNgGVNRokoVSJuEgZ9oZ+atlx+DmkYhHng8/GnPF
         4FTgdAf93c3OS/tzrlmX/ELjklyGZlFhPSM4GvVfz+PipUZGpV7/WmqfwjlsYmu88z3N
         NOYoCHBgn53mgICqkiGSFrE8s3rlfP37OcjbAgeVq2CLRbHXFWqLBoO42gfMLI940ELy
         83+sU+canJ0s9guKTMb2vtbaHC6u/vAr4iALfS7TDfApqPu+sEH6/ZsE8lJIMUpjWl5X
         SxtA==
X-Gm-Message-State: AFqh2koxKOBbeR1JWnjamCR7kAVg8xgBvs+rm+mmqkw5qblDEOkVuR7l
        hKMCUzID4G4SDisH8m4/GKDlIdb6S6qfRNf6QXE=
X-Google-Smtp-Source: AMrXdXuIttqD3ycI2753x+4UmQ94cs+FZCJ9kfvdrJsGv3ZSprB6yLjIZJOM2pId1lEpXm1IWrCFljVfux9kskm8FAU=
X-Received: by 2002:a67:bb02:0:b0:3d4:53d:9320 with SMTP id
 m2-20020a67bb02000000b003d4053d9320mr801095vsn.21.1674056193355; Wed, 18 Jan
 2023 07:36:33 -0800 (PST)
MIME-Version: 1.0
References: <ef9b8445-b02b-3f6a-a566-587695f322b7@iogearbox.net> <20230118111854.744810-1-clangllvm@126.com>
In-Reply-To: <20230118111854.744810-1-clangllvm@126.com>
From:   Djalal Harouni <tixxdz@gmail.com>
Date:   Wed, 18 Jan 2023 16:36:06 +0100
Message-ID: <CAEiveUd_N8qHy54AS0q90FuUSQ=7mePm8FL88Aw-sY7fT7NqFQ@mail.gmail.com>
Subject: Re: [PATCH V2] bpf: security enhancement by limiting the offensive
 eBPF helpers
To:     Yi He <clangllvm@126.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, yhs@meta.com,
        linux-security-module@vger.kernel.org
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

On Wed, Jan 18, 2023 at 1:38 PM Yi He <clangllvm@126.com> wrote:
[...]
> Thanks for your feedback.
>
> This patch aims to mitigate the offensive eBPF problem which has been dic=
ussed since 2019 [1]. Recently, we find that enable eBPF in container envir=
onemnt can lead to container escape or cross-nodes attacks (which may compr=
omise mutiple VMs) in the Kubernetes [2]. Since lots of eBPF based tools ar=
e used in containers, mutiple containers have the CAP_SYS_ADMIN needed by e=
BPF which may be abused by untrusted eBPF code.

Then solution should be toward restricting eBPF in container, there is alre=
ady
sysctl, per process seccomp, LSM + bpf LSM for that.

...
> > I'm not applying this.. i) this means by default you effectively remove=
 these
> > helpers from existing users in the wild given integrity mode is default=
 for
> > secure boot, but also ii) should we lock-down and remove the ability fo=
r other
> > privileged entities like processes to send signals, seccomp to ret_kill=
, ptrace,
> > etc given they all "can affect userspace processes"
>
> It does not affect other privielge processes (e.g., ptrace) to kill proce=
ss. Seccomp is classic bpf does not use this eBPF helper [4].

Those are more or less same as bpf sending signal. Supervisors are using
seccomp to ret kill process and/or sending signals. Where will you draw the
line? should we go restrict those too? IMHO this does not relate to lockdow=
n.

This reasoning will kill any effort to improve sandbox mechanisms that are
moving some functionality from seccomp ret kill to a more flexible and
transparent bpf-LSM model where privileged installs the sandbox. Actually,
we are already doing this and beside eBPF flexibility and transparency
(change policy at runtime without restart) from a _user perspective_
I don't see that much difference between a seccomp kill and ebpf signal.

Thanks!
