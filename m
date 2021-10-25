Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8719843A80D
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJYXTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhJYXTO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 19:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635203811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMXbK4ePzk3n+ceTQNajazYCa4xaMoaeqduI1Kwqi4A=;
        b=DBH+PQziR9aAEFMtedsV7faRW/dbMZSwjSKa4qfLRhCLRpeykOIFAg8O3dIYnCFeGEAn+D
        C99dNFqqBqcFUcLysEuqK2cir9ApJRSLs3vhi9Og89YrZAXQUhayqqkJQ1NKtNcYJdJR37
        d/nCrW7L7Chra2VQLGsyW+9CPRHKtkk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-8dV2UBPwO8uW7T3cpJS7Xg-1; Mon, 25 Oct 2021 19:16:50 -0400
X-MC-Unique: 8dV2UBPwO8uW7T3cpJS7Xg-1
Received: by mail-ed1-f70.google.com with SMTP id f21-20020a0564021e9500b003dd77985601so1165154edf.9
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QMXbK4ePzk3n+ceTQNajazYCa4xaMoaeqduI1Kwqi4A=;
        b=k8wzbeQEU1v8kx/gBvBG7+Fs0uBg/dhI7Tk7+uOY2r5yDE8ec5pho/pnHIHoz28enR
         V20ypQ1BBMQAV+PkO8YvaFI2q5yYcLyC6fWLJwMNGGLLv4W5x+SrPxXTW8Y2lznaYjUM
         0ULv3CBZBh/JizY7gF6TLPUiCP2Ny2afsza1t/WTu7lzR9rsLLdG1T/4v9pEMOI/4nQK
         yIgr9non6FFhdt0QZi+tI/gpYBRAqppm2oOr9DweDO4gM4p3fzvLhLPtMPpv4VGvmvxW
         7ZYAWmTYdB6A0Ljqfy88lf0Tvin8lfp7GqxEGAF5taM1IvQRjOmVf154qEahdkK39X2B
         /4OA==
X-Gm-Message-State: AOAM532DFWyEgMiEBtzi2CzneNFjFBBXFGWmc7/NPzcShn+m2F/axTGP
        m9HRRUKjrih4SZvBsTT6IAl1kN7vQ1Kb/VsBoTeZJYMwoMaJ9a9E/WTPt1N6qSJRZiY5Y+vHo5R
        1xgp8QGx3SB30
X-Received: by 2002:a50:cd87:: with SMTP id p7mr30310507edi.205.1635203808117;
        Mon, 25 Oct 2021 16:16:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrKHHm8lIXLTrCOnw7KkbsrL+gOfuT7m5ziKQ/AyQBnD+BmD2waJkj9SGGtlDGGwMG4Dt7dg==
X-Received: by 2002:a50:cd87:: with SMTP id p7mr30310428edi.205.1635203807122;
        Mon, 25 Oct 2021 16:16:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qa16sm2908667ejc.120.2021.10.25.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:16:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 13B08180262; Tue, 26 Oct 2021 01:16:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: fix potential race in tail call
 compatibility check
In-Reply-To: <c1244c73-bc61-89b8-dca3-f06dca85f64e@iogearbox.net>
References: <20211025130809.314707-1-toke@redhat.com>
 <YXa/A4eQhlPPsn+n@lore-desk>
 <c1244c73-bc61-89b8-dca3-f06dca85f64e@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Oct 2021 01:16:45 +0200
Message-ID: <878rygbspu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/25/21 4:28 PM, Lorenzo Bianconi wrote:
>>> Lorenzo noticed that the code testing for program type compatibility of
>>> tail call maps is potentially racy in that two threads could encounter a
>>> map with an unset type simultaneously and both return true even though =
they
>>> are inserting incompatible programs.
>>>
>>> The race window is quite small, but artificially enlarging it by adding=
 a
>>> usleep_range() inside the check in bpf_prog_array_compatible() makes it
>>> trivial to trigger from userspace with a program that does, essentially:
>>>
>>>          map_fd =3D bpf_create_map(BPF_MAP_TYPE_PROG_ARRAY, 4, 4, 2, 0);
>>>          pid =3D fork();
>>>          if (pid) {
>>>                  key =3D 0;
>>>                  value =3D xdp_fd;
>>>          } else {
>>>                  key =3D 1;
>>>                  value =3D tc_fd;
>>>          }
>>>          err =3D bpf_map_update_elem(map_fd, &key, &value, 0);
>>>
>>> While the race window is small, it has potentially serious ramification=
s in
>>> that triggering it would allow a BPF program to tail call to a program =
of a
>>> different type. So let's get rid of it by protecting the update with a
>>> spinlock. The commit in the Fixes tag is the last commit that touches t=
he
>>> code in question.
>>>
>>> v2:
>>> - Use a spinlock instead of an atomic variable and cmpxchg() (Alexei)
>>>
>>> Fixes: 3324b584b6f6 ("ebpf: misc core cleanup")
>>> Reported-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>>   include/linux/bpf.h   |  1 +
>>>   kernel/bpf/arraymap.c |  1 +
>>>   kernel/bpf/core.c     | 14 ++++++++++----
>>>   kernel/bpf/syscall.c  |  2 ++
>>>   4 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 020a7d5bf470..98d906176d89 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -929,6 +929,7 @@ struct bpf_array_aux {
>>>   	 * stored in the map to make sure that all callers and callees have
>>>   	 * the same prog type and JITed flag.
>>>   	 */
>>> +	spinlock_t type_check_lock;
>>=20
>> I was wondering if we can use a mutex instead of a spinlock here since i=
t is
>> run from a syscall AFAIU. The only downside is mutex_lock is run inside
>> aux->used_maps_mutex critical section. Am I missing something?
>
> Hm, potentially it could work, but then it's also 32 vs 4 extra bytes. Th=
ere's
> also poke_mutex or freeze_mutex, but feels to hacky to 'generalize for re=
use',
> so I think the spinlock in bpf_array_aux is fine.
>
>>>   	enum bpf_prog_type type;
>>>   	bool jited;
>>>   	/* Programs with direct jumps into programs part of this array. */
>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>> index cebd4fb06d19..da9b1e96cadc 100644
>>> --- a/kernel/bpf/arraymap.c
>>> +++ b/kernel/bpf/arraymap.c
>>> @@ -1072,6 +1072,7 @@ static struct bpf_map *prog_array_map_alloc(union=
 bpf_attr *attr)
>>>   	INIT_WORK(&aux->work, prog_array_map_clear_deferred);
>>>   	INIT_LIST_HEAD(&aux->poke_progs);
>>>   	mutex_init(&aux->poke_mutex);
>>> +	spin_lock_init(&aux->type_check_lock);
>
> Just as a tiny nit, I would probably name it slightly different, since ty=
pe_check_lock
> mainly refers to the type property but there's also jit vs non-jit and as=
 pointed out
> there could be other extensions that need checking in future as well. May=
be 'compat_lock'
> would be a more generic one or just:
>
>          struct {
>                  enum bpf_prog_type type;
>                  bool jited;
>                  spinlock_t lock;
>          } owner;

Uh, I like that! Makes it easier to move as well (which we're doing as
part of the xdp_mb series). Will send a v3 with this :)

-Toke

