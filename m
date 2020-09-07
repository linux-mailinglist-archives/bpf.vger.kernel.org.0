Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05062260265
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgIGRYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 13:24:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49418 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729624AbgIGNlY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 09:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599486082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mx0HitpHOfVEuxavEK5m2SMEcJVCFnXIoy6pEZlAL9w=;
        b=KSy7/aimN1Tc/FMrvJvulDHfb/MYTVTVaxFXDXhINm+1LuHx2JFBcNjC16//xK6tmc8x9F
        emhW1VIGiSMoZUzvAxF6t+VgRU+/p37CN9ZJKgyTUlZz7VxjtoQvKI1pnmuGBRtUFyXQcZ
        nOyobn2GCJktid/9eHZoMs4mn/MlmUw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-CyjkLx4kN5Km9b8_puugSQ-1; Mon, 07 Sep 2020 09:33:00 -0400
X-MC-Unique: CyjkLx4kN5Km9b8_puugSQ-1
Received: by mail-wr1-f70.google.com with SMTP id v12so5718871wrm.9
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 06:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mx0HitpHOfVEuxavEK5m2SMEcJVCFnXIoy6pEZlAL9w=;
        b=seRA5xWxYU83VdMrVLtHF1Eatqqkw31ga6qcyMBfJd+s3QPgBx6g+m4DYH4pvRRXGR
         jczirAIlRfV2UI1tHi1gioMFawIR/5VYinHBKhnK4AXeTpyuU8rhwBe+xz6/pGK9D8wF
         OVVt3jyIMYLV+rSFg49uvYePMuAPwuKt7W5vh8yhCAYWkMXfUeCWtUwHxfMUI7bGWnJm
         zDmgPrvn0L0TAlDTowtsOSR/h+zCvLygMY0s3/nYIT6RxKJzNr8cJ2MYmX+NcQDAOv48
         D9jA179S6jzp+u2ZcH9Fs3WjgXUt/1unPj4CKRcXX8WrmqBdO9kFNhJmnQLF5/h1cNyf
         p6Cg==
X-Gm-Message-State: AOAM532TRjW8Hq17NyrMM8N01/nc4KFVV3h7bqSMdKg4iXO38ArueLi+
        oJQeHdU9pXlrOiblyfLuaQY7MTpJ/YhftbQPSy9/Fk6FZYxGPBHVRVGdjFMZf6EGRKN6KqNvq42
        nup/tp77YPAbg
X-Received: by 2002:adf:a18c:: with SMTP id u12mr22429550wru.90.1599485578833;
        Mon, 07 Sep 2020 06:32:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTQDEUKyKYpoKhV6e9kqnUpqInxvY6mXvKDlN1WLTG+p30H/JZ2ZVv0WLVSsrs9mojCzV9xg==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr22429519wru.90.1599485578415;
        Mon, 07 Sep 2020 06:32:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t22sm20618520wmt.1.2020.09.07.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 06:32:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64EF1180497; Mon,  7 Sep 2020 15:32:57 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Borna Cafuk <borna.cafuk@sartura.hr>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        kpsingh@google.com
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
In-Reply-To: <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
 <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Sep 2020 15:32:57 +0200
Message-ID: <878sdlpv92.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Borna Cafuk <borna.cafuk@sartura.hr> writes:

> On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Sep 4, 2020 at 7:57 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
>> >
>> > Hello everyone,
>> >
>> > Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can only be created
>> > from the userspace. This seems quite limiting in regard to what can be done
>> > with them.
>> >
>> > Are there any plans to allow for creating the inner maps from BPF programs?
>> >
>> > [0] https://stackoverflow.com/a/63391528
>>
>> Did you ask that question or your use case is different?
>> Creating a new map for map_in_map from bpf prog can be implemented.
>> bpf_map_update_elem() is doing memory allocation for map elements.
>> In such a case calling this helper on map_in_map can, in theory, create a new
>> inner map and insert it into the outer map.
>
> No, it wasn't me who asked that question, but it seemed close enough to
> my issue. My use case calls for modifying the syscount example from BCC[1].
>
> The idea is to have an outer map where the keys are PIDs, and inner maps where
> the keys are system call numbers. This would enable tracking the number of
> syscalls made by each process and the makeup of those calls for all processes
> simultaneously.
>
> [1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.bpf.c

Well, if you just want to count, map-in-map seems a bit overkill? You
could just do:

struct {
  u32 pid;
  u32 syscall;
} map_key;

and use that?

-Toke

