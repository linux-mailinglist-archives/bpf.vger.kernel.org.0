Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4148265D39
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKKAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:00:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgIKKAH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599818405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVo1WRAmc/BugDM1RHuU1sFqZsCYyVX+oKm++p7MNtE=;
        b=CpVhF2SkiQkVwWU19TUL/mmgnfXUe/YYJ6xRUKddKCKhER9xE8BzoK2a0UFktVdQ0gJfxe
        6VDbk4xYZ789ZEMfe1CJXLnsnLqwlObY5yjgmF8Emtf5cbv4aEaABRVechwqD80mkHJQnW
        KGrcA2OLvnd2Hz/T3Kfz83CExBdr2cE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-figXEklSO3ifv2JISptjxQ-1; Fri, 11 Sep 2020 06:00:04 -0400
X-MC-Unique: figXEklSO3ifv2JISptjxQ-1
Received: by mail-wm1-f72.google.com with SMTP id c72so1166839wme.4
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 03:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WVo1WRAmc/BugDM1RHuU1sFqZsCYyVX+oKm++p7MNtE=;
        b=f5lahhb9VYh80gesVXKebTspywK7S0YS2MFoOOgvz2sfT5swWtxakcyycoJToibD+X
         a3N5qn7w/chTY/0pjE7TuI4GHMYd7pfzuvgGzfnm6dh9r94RzWRuIJuziZpJzoyCGpRe
         gOuY3au2TCwUA7D7sLgb4efrOLb69W/wkdmD9tGlYe5aE3Qokp1cthYsDNlrZk0k7Qmf
         lsVg/OSUWUunri908vBHAy2Z4GK2OVL7/fceUXf2wiyNxzxJfheeA650oZ1KDfyKNggb
         tTvSSB1edvxi1BXuEGQt0zJru4bd1nDiq5gxPL3KtBFkLuHmP6Be8tN9hSuYS5W2Fs/E
         B/CQ==
X-Gm-Message-State: AOAM531L73ZUzvDlsYZ6DDJuXpUZtcNfNyYdiFHjg54Sw4N+NBEJemJk
        Es+aVmNU44mHUKnnPb7Z5VQtpNObjE4FLMGdMJE3cJRpAP94F2AFKb8FEgEYF6x8bPuaRNqkzF4
        4xP+rnfa9rE/X
X-Received: by 2002:a5d:610d:: with SMTP id v13mr1192045wrt.23.1599818402776;
        Fri, 11 Sep 2020 03:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9Kzlf3JnagLklLcTXO7nPbBxKi78Wtsma6YzImQPJ5hRP6cUR+eePi1QhB11DY29QoqylAA==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr1192019wrt.23.1599818402496;
        Fri, 11 Sep 2020 03:00:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f1sm3751336wrt.20.2020.09.11.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:00:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B50FF1829D7; Fri, 11 Sep 2020 12:00:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: change logging calls from
 verbose() to bpf_log() and use log pointer
In-Reply-To: <CAEf4BzZ-K7Myp7_2a==ic5y+TRCFL4Gf4gGWwqm8yAb0icOi5g@mail.gmail.com>
References: <159974338947.129227.5610774877906475683.stgit@toke.dk>
 <159974339060.129227.10384464703530448748.stgit@toke.dk>
 <CAEf4BzZ-K7Myp7_2a==ic5y+TRCFL4Gf4gGWwqm8yAb0icOi5g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Sep 2020 12:00:01 +0200
Message-ID: <87d02sbplq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Sep 10, 2020 at 6:13 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> In preparation for moving code around, change a bunch of references to
>> env->log (and the verbose() logging helper) to use bpf_log() and a direct
>> pointer to struct bpf_verifier_log. While we're touching the function
>> signature, mark the 'prog' argument to bpf_check_type_match() as const.
>>
>> Also enhance the bpf_verifier_log_needed() check to handle NULL pointers
>> for the log struct so we can re-use the code with logging disabled.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Only 4 out of 9 emails arrived, can you please resubmit your entire
> patch set again?

Sure, done :)

-Toke

