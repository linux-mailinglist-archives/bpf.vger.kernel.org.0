Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCC30E9FF
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 03:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhBDCLv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 21:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhBDCLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 21:11:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0BC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 18:11:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so1624569wrq.6
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 18:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzsgPFRYL4FFjxbWJ1E0V3mhlzFWK8ROzeUpsCdhD9c=;
        b=03orHVLTXcqUEHAl1tr0EFz94VZi6Qo5YLmw4/nnBSBrS9B6TW4Fcc3gfP+/HvM7Wm
         ylaAyQklQkl6zEOlRvsX/XEcMsnUoPHM1QZYhT3G9N7/cLBnhU0bUj5/J5F3tmLFRAjy
         d6pougKctEMmDDobprlxiDDNkLyDAkkTzj9NBftJ9l3x+u09bfAebwPkP6+itGGpSuqR
         RchJQKT4ONX5DNaSDHhBo+O50maNv6pva5E6krqUlgt+6NS74iYdSOZI1A9FAVeRjOsf
         FwhouaC2WywD4zPjYiub106oyuS5KwXTQ/qEV264plBbKihwgU5r5QUjOrOVqwTLqk24
         LtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzsgPFRYL4FFjxbWJ1E0V3mhlzFWK8ROzeUpsCdhD9c=;
        b=sdNK+9+elz0kSd9znrYGmGtn8oGxXSwEGvwgwjeZNzSmaYcFc5TdHuGp5FJ+lk/iSl
         Ue4/sq9uhNvcxwD72Rvpyw8V36Bd4rEmZxWqGk//Amuiss2nVSG8KxeLI80P1dOI8nOE
         PdKNZKPYMSI8G6CEiwbYbFJILJDowAKPv+b3rI0adoaKneiE0CfZe8Pc+1T85ENhkKy0
         1NGRmsafTZRDdpjJRyO6jv36Fs2Bt3sIUp08OcncDLxLNTgQwPqBgxgtsmSopceHCW+4
         UAmOYpq9EBHBPjrPXTGZO16Z5DOaC56ABn+Vw2G4uMGfNW1Z8hFHL85BsERKw05TuJLl
         QUlA==
X-Gm-Message-State: AOAM530WsdkFOAdU970tOSiBps5rqP7H45cjwBc2eY3m97aBifuTY3yZ
        VTGynb6rR7ZmhPlh+4NZrvQj1m9EU9GBLW2WmQ5F8A==
X-Google-Smtp-Source: ABdhPJy7qiqpQudgvlgOKJ/LmYkGuMWJE6ff3aPR503VMYWVUHci+UlQG+7XEckXpxO/FFlrlhlMKBWtaRhEODXnMBQ=
X-Received: by 2002:a5d:6686:: with SMTP id l6mr6504472wru.236.1612404668985;
 Wed, 03 Feb 2021 18:11:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org> <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
 <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
In-Reply-To: <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 19:10:52 -0700
Message-ID: <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 7:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 5:21 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 6:00 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Wed, Feb 03, 2021 at 05:46:48PM -0700, Chris Murphy escreveu:
> > > > This is just the vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 file
> > > >
> > > > https://drive.google.com/file/d/1G_2qLVRIy-ExaJI1-cTqDssrDu3sWo-m/view?usp=sharing
> > >
> > > Can you please provide the vmlinux for this file as well?
> >
> > Used this
> > $ /usr/src/kernels/5.11.0-0.rc6.141.fc34.x86_64/scripts/extract-vmlinux
> > /boot/vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 > vmlinux
> >
> > https://drive.google.com/file/d/1h6cC9oZ16oLbR6NyPqKkVGaoUQ2u1UQz/view?usp=sharing
> >
> > I recompiled with gcc 10.2.1 and I'm not having these problems, so it
> > might be that.
> >
>
> sched_reset_on_fork is a bitfield in task_struct. You don't see issue
> on gcc 10.2, but see it on gcc 11. GCC 11 started emitting DWARF5 by
> default, right? It's something that Arnaldo probably already fixed in
> the latest pahole. Could you please try to build pahole from sources
> and see if you run into the same problem again?
>
> Verifier is catching a real issue with offsets going backwards. Here's
> excerpt from BTF dump of task_struct:
>
>         'pdeath_signal' type_id=17 bits_offset=18048
>         'jobctl' type_id=1 bits_offset=18112
>         'personality' type_id=6 bits_offset=18176
>         'sched_reset_on_fork' type_id=6 bits_offset=0
>         'sched_contributes_to_load' type_id=6 bits_offset=0
>         'sched_migrated' type_id=6 bits_offset=0
>         'sched_psi_wake_requeue' type_id=6 bits_offset=0
>
> ...
>
> eventually we get to non-bitfield field
>
>         'atomic_flags' type_id=1 bits_offset=18304
>
> So it's a bitfield offset breakage that should be fixed in pahole 1.20.


Rawhide is currently still on
dwarves-1.19-2.fc34.x86_64

This might also be related:
https://bugzilla.redhat.com/show_bug.cgi?id=1922707#c9



-- 
Chris Murphy
