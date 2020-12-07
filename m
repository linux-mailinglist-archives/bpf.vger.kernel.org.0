Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66C42D1320
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLGOJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 09:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgLGOJC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 09:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607350056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f68iZRu/WdBikSsVv8YlnpzV5Hi/mSgEQNVLgxBduMA=;
        b=dzaqtDRYax8auqkexAQAn1xMi9UhsbnppdyhqEc2n0pr+Jb/Y05vjA79LUYsD0LZIA5DlG
        4MNZEYdBzaBohYWwamdFQYYJ9E1UM3s4Fs7UUDTvPmnml6+eX1IQWme7PPixY5e+9UdG4z
        mAvGsdtSMA0k4LNrAc6Cq0yBJf6VZPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-D5_jIQ3mNOSieIQD8LSEaQ-1; Mon, 07 Dec 2020 09:07:32 -0500
X-MC-Unique: D5_jIQ3mNOSieIQD8LSEaQ-1
Received: by mail-wm1-f71.google.com with SMTP id k128so5347379wme.7
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 06:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f68iZRu/WdBikSsVv8YlnpzV5Hi/mSgEQNVLgxBduMA=;
        b=fxYZGua9CWQzS+B433LRDmN9TOA+wyqNN1mFX5W5b/lwn+ADocDBDmSVmjO6J6LsIJ
         evRccmaXTh+yA3yX8Rf9Q+nsRIyCtfuSsIBw9eBaoM/ZgrXot6ugSx9WqnEdVIpYvHu/
         N+fps3V7t3L2ZNLygiqpB9LTC0w4GiHRGxgwRsVx9E0U1MOeZiUczrHc0SNL/iViSRDp
         PPuOZjpqfToczJQU66rxOMB58WZaunm92snl7pSm3CnkWXkLl5usyMHpzwVKcT+kxv8u
         ciIIxgvssf+JJ5khHDuu2A4d6SSyEBWIDXSMkju7VxeP4u8djg0ilCN631sNO0Ok3FbI
         LEIg==
X-Gm-Message-State: AOAM531OkJim7HoRK4FDZdeFlvqjDJCLzceyVkqL6qOCh5d3RbozPboR
        8y+/J/ySdDZj0WguFairi1VQBZ3K3VfrAuza7S0eOF+VzFGKvECfz/6jokxrjT+meZ7iDKK+Gom
        IxNThB5U1b6RK
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr18648338wme.113.1607350051333;
        Mon, 07 Dec 2020 06:07:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuKTXT9VjylEoopad3wtGlqLGRN+AzCEv1obwJwK40XnFtEennVUhJypx48PWbq6Rl81Mz4w==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr18648282wme.113.1607350050863;
        Mon, 07 Dec 2020 06:07:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z21sm13853864wmk.20.2020.12.07.06.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 06:07:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E0FD61843F5; Mon,  7 Dec 2020 15:07:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: return -EOPNOTSUPP when attaching to
 non-kernel BTF
In-Reply-To: <CAADnVQK25OLC+C7LLCvGY7kgr_F2vh5-s_4rnwCY7CqMEcfisw@mail.gmail.com>
References: <20201205030952.520743-1-andrii@kernel.org>
 <CAADnVQK25OLC+C7LLCvGY7kgr_F2vh5-s_4rnwCY7CqMEcfisw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 15:07:28 +0100
Message-ID: <87lfe9676n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Dec 4, 2020 at 7:11 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>> +                               return -EOPNOTSUPP;
>
> $ cd kernel/bpf
> $ git grep ENOTSUPP|wc -l
> 46
> $ git grep EOPNOTSUPP|wc -l
> 11

But also

$ cd kernel/include/uapi
$ git grep ENOTSUPP | wc -l
0
$ git grep EOPNOTSUPP | wc -l
8

(i.e., ENOTSUPP is not defined in userspace headers at all)

-Toke

