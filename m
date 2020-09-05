Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D502725E889
	for <lists+bpf@lfdr.de>; Sat,  5 Sep 2020 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgIEO6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Sep 2020 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIEO6A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Sep 2020 10:58:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DAC061244
        for <bpf@vger.kernel.org>; Sat,  5 Sep 2020 07:57:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so12302445ejl.7
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2020 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XsG85+Pr6j5nI0LQtesW9JCghIykVKo4tOFt/+F8K0=;
        b=qeEMhrRoUbiQ/SuHWD0yGMzoNoVcyMveXpGVXsSp9j6mGTZGGoF/cYead1EUdx3cjp
         vEtryEmE5j26NM8tP3ImCxY+vkUeBXiycyWycudsxXHRy9mkBBpY4X8F67mn9alnlphG
         iqFSRxHhbER6QG87Z76BGaObHSNiARn3TGCcK6kh6DgwlQiy017EkUVhmF2bdIJT5ONo
         k6oBVWdiDJsYzAgX10SwYCdFijqb+2GodEo/iP/4mB/9ShWcYK4e76cmeisxDmyZKegf
         RC6wes+bK8kOoTu3b7a59QP2cPvm43WDbjCogZBnyHykHOdqu/SQ6dOfGQKrzCQQJ2nq
         DW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XsG85+Pr6j5nI0LQtesW9JCghIykVKo4tOFt/+F8K0=;
        b=JfrlTtiwfGNYE8G4wAPyfDfPg8DLIbMsvimeEloJ4cseMGcBhiBcfvp/toM6JdCXgh
         fFYurkHDQ0WJ2s2WAltT7WyBiwmQW3fduNfVGpOsBaCU5P2CbxJ4Lo6rKChH3W1K3hyJ
         RN5DvNR/WJ0kYqCChrjLjJ/dPzRUks81PN39MQkxYcaE2wm0cpuagnjnCIXRP6QkF9Nj
         wc20g/em+8cSdNlNygFV+jJ1K9CsednwG6IOJkzVO6fybCViLXR0sA10pgrwtFl8UToT
         OFDP5t+QWxrY0JlewHRiSHSt0DqLndG6Smo44FBGo7kOuIaJfVwozkf8MDmzV6Uvo7KI
         YBOQ==
X-Gm-Message-State: AOAM532tkyrttrk0xviYBVXUqXhkH5NvyFV1g7JDpk8SlWLTdCdY+sCp
        5qdQnuAFnNvsZE/K7f4aVe7Lr6e7OjyAb0sRVm89
X-Google-Smtp-Source: ABdhPJw0MV08U610TX7UhyFnt8r6QIlI2NK5yKlUy9x6PJ0y+hD+Io29XQsER/LG68N0r9xbNC+m9DjDJDDTRyFny+o=
X-Received: by 2002:a17:906:9718:: with SMTP id k24mr11885208ejx.365.1599317877558;
 Sat, 05 Sep 2020 07:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com> <CAFLU3KstRTXs3nwyE8uQY7q9k-sRr1yKCtOQX3gMq3nsxnwHXw@mail.gmail.com>
In-Reply-To: <CAFLU3KstRTXs3nwyE8uQY7q9k-sRr1yKCtOQX3gMq3nsxnwHXw@mail.gmail.com>
From:   KP Singh <kpsingh@google.com>
Date:   Sat, 5 Sep 2020 16:57:41 +0200
Message-ID: <CAFLU3Kt5p4FETB09ZxCRMEZzX1bRngzqv4GxjmAkkTURyjbNcQ@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Borna Cafuk <borna.cafuk@sartura.hr>, bpf <bpf@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[+lists, format=plain text]

On Sat, Sep 5, 2020 at 4:48 PM KP Singh <kpsingh@google.com> wrote:
>
>
>
> On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
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
>>
>> But if your use case it what stackoverflow says:
>> "
>> SEC("lsm/sb_alloc_security")
>> int BPF_PROG(sb_alloc_security, struct super_block *sb) {
>>     uuid_t key = sb->s_uuid; // use super block UUID as key to the outer_map
>>     // If key does not exist in outer_map,
>>     // create a new inner map and insert it
>>     // into the outer_map with the key
>> }
>> "
>
>
> Indeed, if you want to associate some information with super_block objects
> in LSM programs, local storage fits better.
>
> It would help if you can shed some more light on your use case.
>
>> Then it would be more efficient, faster, easier to use if you could
>> extend the kernel with per-sb local storage.
>
>
> Now that we have generalized local storage, this should not be much work.
>
> Please have a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/bpf_inode_storage.c
>
> and the example in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/local_storage.c#n121
>
> We will need something similar for super_block as well.
>
> - KP
>
>> We already have socket- and inode- local storage.
>> Other kernel data structures will fit the same infra.
>> You wouldn't need to hook into sb_alloc_security either.
>> From other lsm hooks you'll ask for super_block-local_stoarge and scratch
>> memory will be allocated on demand and automatically freed with sb.
