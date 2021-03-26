Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF83234AE85
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZS0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 14:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhCZS0G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 14:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616783165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHBvQNlInr7uhqwohEYYJ6fIrcun/FjuvH6xJlp8s4Y=;
        b=aRQY3cN8s/nh7EVZjxn7wFLQ1DAM+qm2MhWXbAZH9PW30TopBVswJh9sIFKiFloLSlKHwI
        jptKF4nTcLQfGHTCBKg7JcgLlBd76DqE82Ew1yMXB5fJOuoMPlxWVO9mlmj/O5C6iy8hjW
        LFmTyy1jxNI3xDBu9joILMRM72Y7ZNw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-3zNsXP_WMS6gaJDOWYjFGg-1; Fri, 26 Mar 2021 14:25:55 -0400
X-MC-Unique: 3zNsXP_WMS6gaJDOWYjFGg-1
Received: by mail-ed1-f70.google.com with SMTP id q25so4832588eds.16
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VHBvQNlInr7uhqwohEYYJ6fIrcun/FjuvH6xJlp8s4Y=;
        b=EBH+m4CjlnFq6Q0tzJghHZ1cLmLetShjjd1gqB8JF8KfJ6oKx6Vueilg8knnwgebPI
         7o8dYGSlb9AiiAdJIFITGERLLvfm5Pd5HT+hesOvD+LJtI920WSz62ANLdh00SeOLf6T
         AAeyCT31B5SuA9THU5TIRL3fOinhP9LpGh+giqBr7WvtqDUAK/NKi1D1JVxgYz+Cg1jW
         XBUOXNpg0Sw9OJZAkX46wf93ISB9TpUYPjpBnuhCDB4KkarkUSzptO6k6gAU8aRWzbVg
         8WsKfmybrD7HBtpej2DX5QW3Sk0Wbzuv9FazRRvXHnvJZVT8EYXqp3OOao6MX9I+r7LR
         lHvg==
X-Gm-Message-State: AOAM531Ay5/RRnsdP8UyQRSPiXYQllzG8p5SLD8hlRESy73cbq6cy7vf
        3a5LwME8Ym1t59h9HE+ZwmOVf3q8mv7Iz14I5sqhKQbT4ZA603y9Tw9Zv9HUesszjN/FEV4aDCp
        oTEOLT3Ty/zqi
X-Received: by 2002:a50:ee10:: with SMTP id g16mr16193143eds.215.1616783154409;
        Fri, 26 Mar 2021 11:25:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo9q1onPVZDjx15tDzJWa1xccA2pTrcCh71KUTRxb9IqNa6T+h3JwEblXu5DFP0NGTrT/j0w==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr16193124eds.215.1616783154277;
        Fri, 26 Mar 2021 11:25:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gn19sm3987476ejc.4.2021.03.26.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:25:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0B61D1801A3; Fri, 26 Mar 2021 19:25:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf/selftests: test that kernel rejects a
 TCP CC with an invalid license
In-Reply-To: <CAEf4BzaucswGy+LiXQC0q_zgQEOTtRJ3GQtaeq7CwJJW9EzGig@mail.gmail.com>
References: <20210325211122.98620-1-toke@redhat.com>
 <20210325211122.98620-2-toke@redhat.com>
 <CAEf4BzaxmrWFBJ1mzzWzu0yb_iFX528cAFVbXrncPEaJBXrd2A@mail.gmail.com>
 <87lfaacks9.fsf@toke.dk>
 <CAEf4BzaucswGy+LiXQC0q_zgQEOTtRJ3GQtaeq7CwJJW9EzGig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 19:25:53 +0100
Message-ID: <874kgxbwlq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:


>> Ah, thanks! I always get confused about CHECK() as well! Maybe it should
>> be renamed to ASSERT()? But that would require flipping all the if()
>> statements around them as well :/
>
> Exactly, it's the opposite of assert (ASSERT_NOT %-), that
> CHECK(!found) is "assert not not found", right?) and it throws me off
> every. single. time.

Yup, me too, I have to basically infer the right meaning from the
surrounding if statements (i.e., whether it triggers an error path or
not).

> Ideally we complete the set of ASSERT_XXX() macros and convert as much
> as possible to that. We can also have just generic ASSERT() for all
> other complicated cases.

Totally on board with that! I'll try to remember to fix any selftests I
fiddle with (and not introduce any new uses of CHECK() of course).

-Toke

