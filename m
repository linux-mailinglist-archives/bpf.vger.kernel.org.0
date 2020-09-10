Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3102642AA
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIJJpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 05:45:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730179AbgIJJo4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 05:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599731094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aCy+XOEaRsEQY0LQO/vOTZfwSOMrqiVn05uKYSgtpvo=;
        b=iHJcvySfzhYsCXoPn/5141QU/+UV4kn88ljXmM9vHfi588WfvjY1ZVcsiBc8u64zYvDCsv
        rSt+O4NMON5iRmrHNbSGZMSxJLeinSOVI1Snxvp2vD7TQ+FXeEE87ssx9TgUEImaAgNojh
        j46LyWkBUCQY1zSZ7eoPu/82UfeCkfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-6_73DCNoMf-ljEMn55CqMA-1; Thu, 10 Sep 2020 05:44:52 -0400
X-MC-Unique: 6_73DCNoMf-ljEMn55CqMA-1
Received: by mail-wr1-f69.google.com with SMTP id r15so2042471wrt.8
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 02:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aCy+XOEaRsEQY0LQO/vOTZfwSOMrqiVn05uKYSgtpvo=;
        b=JhDJVe5wyECg+utLGvoKAnzN7MISokCRg6gYeNhfjMMZQmb0SH/QvdOESvWeVm2wbZ
         /M+na25liOFBOpQvRBLSNE4fVfHygd0wuIG8BYdlUr9biCk9nglsA4GhCd/cRZpeAV0y
         I+Y9egt0gSsRnRVTTvxxdafAE7n7o/vp6ZTA4IbZa5SFjNu7cI8XOHV75lj6sjgJkZPC
         HNGPq9ejpw597duOF0mcNjFeTWbaG4rfuF7O3w/nlcy5JxqC5RHx0J1zC6J8L3lKTSPL
         SiNOk4tLbK8bz+9mrVFiRrp7qessZ1TXXobCdiuyLKW5b/hBhHAxViplJ0n4+6pb3cVS
         SPBg==
X-Gm-Message-State: AOAM533eEVZVv23E9UPHJpl2aYFu9EW0yq1l1oyr4491M7NzHpEX16M/
        iBDMhhwfIHKzpPNOBVQqjIrChkjqNkXq9TWvwbnFO4KUml/kA2Rx628tuT3e7CRZGNI7vQ2HP1O
        Eoxv2I2ME2EP/
X-Received: by 2002:adf:c44d:: with SMTP id a13mr7883851wrg.11.1599731091781;
        Thu, 10 Sep 2020 02:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfCeAoXe3tOPQILTBWWxMnePItSYSr/aajG3+6ac5qGnErTf+SK51jURDCq9LkJoZlD7FQcA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr7883838wrg.11.1599731091629;
        Thu, 10 Sep 2020 02:44:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n21sm2870497wmi.21.2020.09.10.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 02:44:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7D2D11829D4; Thu, 10 Sep 2020 11:44:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Ahern <dsahern@gmail.com>
Cc:     Hangbin Liu <liuhangbin@gmail.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCHv11 bpf-next 2/5] xdp: add a new helper for dev map
 multicast support
In-Reply-To: <CAADnVQ+CooPL7Zu4Y-AJZajb47QwNZJU_rH7A3GSbV8JgA4AcQ@mail.gmail.com>
References: <20200903102701.3913258-1-liuhangbin@gmail.com>
 <20200907082724.1721685-1-liuhangbin@gmail.com>
 <20200907082724.1721685-3-liuhangbin@gmail.com>
 <20200909215206.bg62lvbvkmdc5phf@ast-mbp.dhcp.thefacebook.com>
 <20200910023506.GT2531@dhcp-12-153.nay.redhat.com>
 <a1bcd5e8-89dd-0eca-f779-ac345b24661e@gmail.com>
 <CAADnVQ+CooPL7Zu4Y-AJZajb47QwNZJU_rH7A3GSbV8JgA4AcQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Sep 2020 11:44:50 +0200
Message-ID: <87o8mearu5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Sep 9, 2020 at 8:30 PM David Ahern <dsahern@gmail.com> wrote:
>> >
>> > I think the packets modification (edit dst mac, add vlan tag, etc) should be
>> > done on egress, which rely on David's XDP egress support.
>>
>> agreed. The DEVMAP used for redirect can have programs attached that
>> update the packet headers - assuming you want to update them.
>
> Then you folks have to submit them as one set.
> As-is the programmer cannot achieve correct behavior.

The ability to attach a program to devmaps is already there. See:

fbee97feed9b ("bpf: Add support to attach bpf program to a devmap entry")

But now that you mention it, it does appear that this series is skipping
the hook that will actually run such a program. Didn't realise that was
in the caller of bq_enqueue() and not inside bq_enqueue() itself...

Hangbin, you'll need to add the hook for dev_map_run_prog() before
bq_enqueue(); see the existing dev_map_enqueue() function.

-Toke

