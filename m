Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5071F37F294
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 07:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEMF1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 01:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEMF1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 01:27:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812EC061574;
        Wed, 12 May 2021 22:26:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e19so2425910pfv.3;
        Wed, 12 May 2021 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4PJcU19svcp9/MR6WVhgslZEMX/TOTb95M1ykjqumY=;
        b=kvNPjIHIodRIOmqPVUCvw2VJr1sLnyZ2/BwJCCIPSSU9PlFvNkNEQ4vDjHQxm986Pp
         KMWl74WGcaCD7dkmdzDG8PsGr4LFXz7m8icZEzE38r8H0RZDWjuBAQuJI9/zCXzoGWHR
         V2W5GIWIgfxhlU1no0qKTpg1FqmGVEZ63OyIIg1nNE77QXsJuJgecZrWn6UiKrA6mleF
         3npXu5/vTLuSnsUF9spv49LSizs79uWTAliScTjTZJRnpF7xIHTym4ruLlZM7kubo86B
         HtbEjHUcf7gNJrRYjTwp1cO2Jjmc8En4wUhWcAl47wallR/2OjWpBDMFxIfOQb1TIRIn
         RHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4PJcU19svcp9/MR6WVhgslZEMX/TOTb95M1ykjqumY=;
        b=JAZKd+G53rEclZFYtoX2/FWj3dXqAt5owV3pIUCJr/6/bo9T6L7M0xHrJNH8/Tsqz4
         aF4bCBLauxgBIklDepuJXb7T2FID7WjecqozgJdAZy2GPNAk8cjsRsxPpkngPLizFh6p
         /5tgF6r/9CJSIEfRqUxY33R3H2zP1x931H6CiVi0omARLWguTB1VirBDjdn5e2SwFh/Y
         zOxq/bdimy0TELlVVWvsLQ9E8XFHD+m9E0DqQoro9bpng5TUgpK/FuK3I5LZdtfpftXB
         /jBdgRSuw0rm2uL9YNniw+zmdxIjwKPhs+O5Q6y5K131Q+g2JFDaGgSQtgimogTOKrEV
         gVkQ==
X-Gm-Message-State: AOAM530zW2oUtW5MGmaWGc8WRkhHBgMD9VumQDhN9GxfV+u13sju9+EP
        d8lM7zUnUUgHM2N26ry/WPHoupTlSqj2DjAdZtk=
X-Google-Smtp-Source: ABdhPJwetf7ucCBgJMHapemhtdShZFEnneY9R/qxzx30AscHdVmsjKVKW/KoTs94eio7G5hx0yg6oHunkDwxUsq3Qq4=
X-Received: by 2002:a63:465b:: with SMTP id v27mr39714727pgk.445.1620883591109;
 Wed, 12 May 2021 22:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620499942.git.yifeifz2@illinois.edu> <53db70ed544928d227df7e3f3a1f8c53e3665c65.1620499942.git.yifeifz2@illinois.edu>
 <20210511020425.54nygajvrpxqnfsh@ast-mbp.dhcp.thefacebook.com>
 <CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1ANQvQK=FJQ@mail.gmail.com> <20210512223626.olex7ewf6xd6m2c4@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210512223626.olex7ewf6xd6m2c4@ast-mbp.dhcp.thefacebook.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 13 May 2021 00:26:19 -0500
Message-ID: <CABqSeAR9rgARxYGYUVZQgZ0a-wqZxy-qeoVpu495XHxpj0Ku=A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 5:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Typically the verifier does all the checks at load time to avoid
> run-time overhead during program execution. Then at attach time we
> check that attach parameters provided at load time match exactly
> to those at attach time. ifindex, attach_btf_id, etc fall into this category.
> Doing something similar it should be possible to avoid
> doing get_dumpable() at run-time.

Do you mean to move the check of dumpable to load time instead of
runtime? I do not think that makes sense. A process may arbitrarily
set its dumpable attribute during execution via prctl. A process could
do set itself to non-dumpable, before interacting with sensitive
information that would better not be possible to be dumped (eg.
ssh-agent does this [1]). Therefore, being dumpable at one point in
time does not indicate anything about whether it stays dumpable at a
later point in time. Besides, seccomp filters are inherited across
clone and exec, attaching to many tasks with no option to detach. What
should the load-time check of task dump-ability be against? The
current task may only be the tip of an iceburg.

[1] https://github.com/openssh/openssh-portable/blob/2dc328023f60212cd29504fc05d849133ae47355/ssh-agent.c#L1398

YiFei Zhu
