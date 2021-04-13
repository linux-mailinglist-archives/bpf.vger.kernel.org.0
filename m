Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9B35DA5B
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbhDMIuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 04:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhDMIuy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 04:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618303834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sV9a1msNbabLkW0lwkAKCZ1jGaKvU7dMIzjSYyaGxOE=;
        b=MHzPXuhkZQygjrw2E8TTbbnhYuOpZO+MAdtxM/3hY2Im6LTc4ZkcFkb5kh5Ris/VE0FkIl
        c4aQza3Ab3ghavK2+anaVCWxe2w9/0PxT+NZidz89oCi2v3vWSXOgpBsWNysQSZkpAsYej
        ikxiFW4vQ8dRn+I9WFpg5dNd9Q03tcU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-KEP5BFOiPnKX9lp_NOkkxA-1; Tue, 13 Apr 2021 04:50:32 -0400
X-MC-Unique: KEP5BFOiPnKX9lp_NOkkxA-1
Received: by mail-ej1-f72.google.com with SMTP id l25so236191ejr.16
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 01:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sV9a1msNbabLkW0lwkAKCZ1jGaKvU7dMIzjSYyaGxOE=;
        b=JSbHveBbRRPehYEecAV8i4le8rNHQjVvPoldOmEZFIAiIBUbilIsx7lQ4Omhqo5w8E
         ySSrbrEEqPj5qglaoSODN/mn4lPg5VodGsJTtOhbcN7Hk8gD3Zm1XCmAswx4HW1f+ytI
         grMpkSSHGzEnNhY4KfIJT82unesY3ou8+6VYnLue8wEuH6DeClFPT2CfTPnEsfMMz7vQ
         K0spj/yZqfLgISpVVN4r7TwIRY5ap0nNwvy7sO2hjL1sj2WYeXHb0G/oHWua6T26gNBR
         98uGi0sEfuFZrosC+ZVdY20x8ujX9JYqV0HWoXUI4xfhTgCZn+ELzSgp28P1nD+YvLfh
         +tUA==
X-Gm-Message-State: AOAM5336WW7FgLFZFPRxdb6N52kx90rvcoH1WyUaIx6WtdV150PhSoQ1
        fkBZTxKw9/mSmw9TyyjRsgfFjr0Dtt4cLj2z2j0oqIXZk2pj8u/I0p8Kdbq92q0Jtw5th12PUxv
        NUx9o/4g6MEkP
X-Received: by 2002:a17:906:80d1:: with SMTP id a17mr11674847ejx.55.1618303831151;
        Tue, 13 Apr 2021 01:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXizYmXzUfjLivsdVbm4Qe7jiS0uTDOrf2Va/1b0HhOkB3VEF4sE7QloS6yoSiFusfZpY8sg==
X-Received: by 2002:a17:906:80d1:: with SMTP id a17mr11674839ejx.55.1618303830956;
        Tue, 13 Apr 2021 01:50:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cy5sm9007537edb.46.2021.04.13.01.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:50:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5E271804E8; Tue, 13 Apr 2021 10:50:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
In-Reply-To: <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Apr 2021 10:50:29 +0200
Message-ID: <87im4qo9ey.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Apr 8, 2021 at 12:34 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Hi Andrii
>>
>> I'm getting some selftest failures that all seem to have something to do
>> with kern_sync_rcu() not being enough to trigger the kernel events that
>> the selftest expects:
>>
>> $ ./test_progs | grep FAIL
>> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
>> #15/1 lookup_update:FAIL
>> #15 btf_map_in_map:FAIL
>> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 =
=3D=3D expected 0
>> #123/2 exit_creds:FAIL
>> #123 task_local_storage:FAIL
>> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 =
=3D=3D expected 0
>> #123/2 exit_creds:FAIL
>> #123 task_local_storage:FAIL
>>
>> They are all fixed by adding a sleep(1) after the call(s) to
>> kern_sync_rcu(), so I'm guessing it's some kind of
>> timing/synchronisation problem. Is there a particular kernel config
>> that's needed for the membarrier syscall trick to work? I've tried with
>> various settings of PREEMPT and that doesn't really seem to make any
>> difference...
>>
>
> If you check kern_sync_rcu(), it relies on membarrier() syscall
> (passing cmd =3D MEMBARRIER_CMD_SHARED =3D=3D MEMBARRIER_CMD_GLOBAL).
> Now, looking at kernel sources:
>   - CONFIG_MEMBARRIER should be enabled for that syscall;
>   - it has some extra conditions:
>
>            case MEMBARRIER_CMD_GLOBAL:
>                 /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full=
. */
>                 if (tick_nohz_full_enabled())
>                         return -EINVAL;
>                 if (num_online_cpus() > 1)
>                         synchronize_rcu();
>                 return 0;
>
> Could it be that one of those conditions is not satisfied?

Aha, bingo! Found the membarrier syscall stuff, but for some reason
didn't think to actually read the code of it; and I was running this in
a VM with a single CPU, adding another fixed this. Thanks! :)

Do you think we could detect this in the tests? I suppose the
tick_nohz_full_enabled() check should already result in a visible
failure since that makes the syscall fail; but the CPU thing is silent,
so it would be nice with a hint. Could kern_sync_rcu() check the CPU
count and print a warning or fail if it is 1? Or maybe just straight up
fall back to sleep()'ing?

-Toke

