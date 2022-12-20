Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC99665280C
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiLTUo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiLTUoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:44:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE2186DF
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:44:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v23so8391375pju.3
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wLE14m1hJaq0AjyblPUtFUz3szk8q598hBuV+O2/Q7Y=;
        b=czSeDDKjShp1MHbpu5nCLJOheuAcVZXD7IWN7SpODKWI5qBzknvgmwbLnDI1vevw7F
         9QC70aKRF2AR7IBr6XpE7rWRROW2Tpi5qWtYovvZU5GykLTiA6tlKNj+0qiJRFv8JF1d
         ScJoJtPJivhH3S1rxGyWFToIzheZGBz3LZOEzaF3Nr9xTNYczheve7IV7X/qQra4uX15
         jW4O/bO5lGzsrG41KS5oBlZGKKtkwUZU7SaznF8CTM+S33bWKkpz9WiS+8lOT4rMsgKp
         gpWn4SlmzLDTJwXvvK2E3OAOwIjztysYKYVeFfPPeOZ8x25O9NI5onzNsve5qfqlOTmP
         OM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLE14m1hJaq0AjyblPUtFUz3szk8q598hBuV+O2/Q7Y=;
        b=7N8pz7UF3lWFaQh/ORtbCmTkZ1fGph2ngCqNuZ2mHWchNtM3+597gXt3vUALhlXo5b
         hwxBJYBirBGXu7ON+FSv3z/Y/yIH/F495haegj1j8bIJBSwe6ViuACRTowM1csDsCwG7
         0Pme0cYP+F8VMj5nYkkHXqaJVwAY6GkDgmoqXoMtjF4Rm8BQ1A2mKi1U3DzJwlZV5C/y
         6PpUuD+jqxIocBy52RSt8JojEvIuuXTvTVdEduT9Kk7EILzNutkGH3PJkbkFZh1lKLi0
         tGQcbVOhqqEQP+6ZuyHjO1hd4ZiiYvgWeSY3au9M6R1Nx26FM6jJbtFWmOrWasJ1PhPz
         j2Rw==
X-Gm-Message-State: AFqh2kpGv7j5I2tlZaiVxngEKxW9Fpr/lCX9HyUsPdwEQsfToDZI/EDC
        2zzS1ch1mwPE5Hh/n6m4YVq0+pPrlPXByowp5qjV
X-Google-Smtp-Source: AMrXdXtKjmAWXlpuJdfPaH7BVF2Dw+p/vVrhbDvAiUoMMgs0ozRvxWYSDeIq3wQOaANeFSQk6p1cOSh1DL2CnB0yuS0=
X-Received: by 2002:a17:902:aa04:b0:191:2f59:904c with SMTP id
 be4-20020a170902aa0400b001912f59904cmr401738plb.56.1671569091462; Tue, 20 Dec
 2022 12:44:51 -0800 (PST)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com> <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
 <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
 <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
 <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
 <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com> <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
In-Reply-To: <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Dec 2022 15:44:40 -0500
Message-ID: <CAHC9VhQKa36C4xh1OiCdC1baNSeNL7OMLY9zg4O0UWahX-mzow@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 5:24 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> Ok, let me try to complete the solution for the issues Lorenz pointed
> out. Here I discuss only the system call side of access.
>
> I was thinking on the meaning of the permissions on the inode of a
> pinned eBPF object. Given that the object exists without pinning, this
> double check of permissions first on the inode and then on the object
> to me looks very confusing.
>
> So, here is a proposal: what if read and write in the context of
> pinning don't refer to accessing the eBPF object itself but to the
> ability to read the association between inode and eBPF object or to
> write/replace the association with a different eBPF object (I guess not
> supported now).
>
> We continue to do access control only at the time a requestor asks for
> a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
> (Andrii wanted to give read permission to a specific group). The owner
> is who created the eBPF object and who can decide (for DAC and ACL) who
> can access that object.
>
> The requestor obtains a fd with modes depending on what was granted. Fd
> modes (current behavior) give the requestor the ability to do certain
> operations. It is responsibility of the function performing the
> operation on an eBPF object to check the fd modes first.
>
> It does not matter if the eBPF object is accessed through ID or inode,
> access control is solely based on who is accessing the object, who
> created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
> operations will have the same access control.
>
> With my new proposal, once an eBPF object is pinned the owner or
> whoever can access the inode could do chown/chmod. But this does not
> have effect on the permissions of the object. It changes only who can
> retrieve the association with the eBPF object itself.

Just to make sure I understand you correctly, you're suggesting that
the access modes assigned to a pinned map's fd are simply what is
requested by the caller, and don't necessarily represent the access
control modes of the underlying map, is that correct?  That seems a
little odd to me, but I'll once again admit that I'm not familiar with
all of the subtle nuances around eBPF maps.  I could understand
allowing a process to grab a map fd where the access modes are bounded
by the map's access modes, e.g. a read-only fd for a read-write map;
however, that only makes sense if all of the map operations for *that
process* are gated by the access control policy of the fd and not
necessarily the map itself.  If the two access policies were disjoint
(fd/map), one could/should do permission checks between the calling
process and both the fd and the map ... although I'm having a hard
time trying to think of a valid use case where a map's fd would have a
*more* permissive access control policy than the map itself, I'm not
sure that makes sense.

> Permissions on the eBPF object could be changed with the bpf() syscall
> and with new operations (such as OBJ_CHOWN, OBJ_CHMOD). These
> operations are of course subject to access control too.
>
> The last part is who can do pinning. Again, an eBPF object can be
> pinned several times by different users. It won't affect who can access
> the object, but only who can access the association between inode and
> eBPF object.
>
> We can make things very simple: whoever is able to read the association
> is granted with the privilege to pin the eBPF object again.
>
> One could ask what happens if a user has only read permission on an
> inode created by someone else, but has also write permission on a new
> inode the user creates by pinning the eBPF object again (I assume that
> changing the association makes sense). Well, that user is the owner of
> the inode. If the user wants other users accessing it to see a
> different eBPF object, it is the user's decision.

-- 
paul-moore.com
