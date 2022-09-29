Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A05EEA84
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiI2AYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiI2AYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 20:24:15 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561211ADD9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:24:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so13520otu.7
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=3Lez/NsvCK8yP66AvATp6MFmmTKGfEE01cROmUj07MY=;
        b=sEn3e8c6dlJiMsqTPGJW1YsYY/2ZdftpMboN8TMxZ4PXawZi/25x51UfCVk3buLSuk
         VxgxFnPyGxK6vP+Ntt6DVb8Y4jmpJXzbxbt7wk8RxhppHIHICtFH3XAPjJItlc8PbRzP
         /50HPChdXTLx4GCzYpuCKswzrAceYMjTKNAEIuQVIngUBrF3Awf/Bc2VJCDsqxOXvluf
         zkssJWmTrFYEcn5rufrvFS7LKDOxIYFO4CV8RUPtit5VOFsR5QGPc7jNfUy2Q7VfvfBa
         p7SzQ3q3T2XAv5SrRzDuRqoXnn4shRZ3+WktKfzesrEDQTo7bJ5TTQ5MLgGG69+UZkmp
         geKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3Lez/NsvCK8yP66AvATp6MFmmTKGfEE01cROmUj07MY=;
        b=FQh+KgsYgyNqG/CkMbzuheARts4RqZ3kFHmLIOHGEoe3+vIpsiGA9ncjgXioC+y9Lb
         RqPE/4EnGxFo/JLEKUvlYAc6jFRzDqWHKuN6OXfhKIE3SW6KAYaNZCkhyhqosCW9A3so
         lDKKi8nd6OJphw71WTQ3Iauq7Fpk0fdFT2tbvYwFpaiHcc3bWSdME0ByGJVA937zR7Z6
         SbNRYlzqt93O6OOYJLcLjtn4wnsHXtrcT1nBiof+4CFaVgfDvUSSOKJkwuclaIc9aJfX
         gpwDqjdiwW8DRn5nhjVvCFhPADj+oI1+TBYylyk9zzUTEgcNAr6fHZnNQEENjLpNL4r6
         s/8A==
X-Gm-Message-State: ACrzQf31/VGdfHW6OiQu8jE3pquzRyRa+qNZzDWhl0Y9p04rsds2/c0P
        E2iDGQb/ISF1wGHCQD9NlFi6dDJbgTnweqMbr3Wy
X-Google-Smtp-Source: AMsMyM4JKBexbSSoQs6U8oMvBE8K/9vL6a/ssbZ5EPDMmhgaH8kIzFgEsUP/FsiS+0dKwz0pfMKzuBkeh+ZYTms/faw=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr234380otl.34.1664411053278; Wed, 28
 Sep 2022 17:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com> <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com> <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com> <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
 <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com> <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
 <87mtajss8j.fsf@toke.dk> <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
In-Reply-To: <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 20:24:02 -0400
Message-ID: <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 28, 2022 at 7:24 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote
> On Wed, 2022-09-28 at 12:33 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
> >
> > > On Wed, 2022-09-28 at 09:52 +0100, Lorenz Bauer wrote:
> > > > On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
> > > > > Uhm, if I get what you mean, you would like to add DAC controls
> > > > > to
> > > > > the
> > > > > pinned map to decide if you can get a fd and with which modes.
> > > > >
> > > > > The problem I see is that a map exists regardless of the pinned
> > > > > path
> > > > > (just by ID).
> > > >
> > > > Can you spell this out for me? I imagine you're talking about
> > > > MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not
> > > > great
> > > > maybe, but no gaping hole IMO.
> > >
> > > +linux-security-module ML (they could be interested in this topic
> > > as
> > > well)
> > >
> > > Good to know! I didn't realize it before.
> > >
> > > I figured out better what you mean by escalating privileges.
> > >
> > > Pin a read-only fd, get a read-write fd from the pinned path.
> > >
> > > What you want to do is, if I pin a read-only fd, I should get read-
> > > only
> > > fds too, right?
> > >
> > > I think here there could be different views. From my perspective,
> > > pinning is just creating a new link to an existing object.
> > > Accessing
> > > the link does not imply being able to access the object itself (the
> > > same happens for files).
> > >
> > > I understand what you want to achieve. If I have to choose a
> > > solution,
> > > that would be doing something similar to files, i.e. add owner and
> > > mode
> > > information to the bpf_map structure (m_uid, m_gid, m_mode). We
> > > could
> > > add the MAP_CHMOD and MAP_CHOWN operations to the bpf() system call
> > > to
> > > modify the new fields.
> > >
> > > When you pin the map, the inode will get the owner and mode from
> > > bpf_map. bpf_obj_get() will then do DAC-style verification similar
> > > to
> > > MAC-style verification (with security_bpf_map()).
> >
> > As someone pointed out during the discussing at LPC, this will
> > effectively allow a user to create files owned by someone else, which
> > is
> > probably not a good idea either from a security PoV. (I.e., user A
> > pins
> > map owned by user B, so A creates a file owned by B).
>
> Uhm, I see what you mean. Right, it is not a good idea, the owner of
> the file should the one that pinned the map.
>
> Other than that, DAC verification on the map would be still correct, as
> it would be independent from the DAC verification of the file.

I only became aware of this when the LSM list was CC'd so I'm a little
behind on what is going on here ... looking quickly through the
mailing list archive it looks like there is an issue with BPF map
permissions not matching well with their associated fd permissions,
yes?  From a LSM perspective, there are a couple of hooks that
currently use the fd's permissions (read/write) to determine the
appropriate access control check.

Is the plan to ensure that the map and fd permissions are correct at
the core BPF level, or do we need to do some additional checks in the
LSMs (currently only SELinux)?

--=20
paul-moore.com
