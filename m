Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A758E2C0358
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 11:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgKWKbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 05:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728162AbgKWKbs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 05:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606127507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm53+5neEtPB6+THbZqEn6D6DMkbZbE7CDMkDaMnWcU=;
        b=fA+t2laeJeYMlgyl1KZka25DEfq5eLFAdOvjtiEww+JmjXVWcewzNdpBRl334qZDnHBseu
        kYFPPOqsw/eJl4xrMylAsvIjlIBz1V5hre25gb3a4/9WwHSu7/zp4ZfKCrfbLBE9EmF2sF
        G4ss6nyBTW37sLM+5Cg3QczcPgX8c/g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-3LD0G7h1OHWCxhO8JYI1pA-1; Mon, 23 Nov 2020 05:31:45 -0500
X-MC-Unique: 3LD0G7h1OHWCxhO8JYI1pA-1
Received: by mail-ed1-f69.google.com with SMTP id v7so6476722edy.4
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 02:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nm53+5neEtPB6+THbZqEn6D6DMkbZbE7CDMkDaMnWcU=;
        b=L0LMG0xNMYQyF92PH7KSC4/r0/dTIThJL4Yzn20gc5s+DSnnpB3xDXtrYxq77GmDyM
         +Xr/EJBrSz4B48zPcfsd6HfC8AZkCNsRrXtHxaHCSTchtzSz9wlLJpoK3/wJ7ACbuOcK
         NkFy7iSQbylWdFtjXaqzrcjOursWSiGGFJhLTNH5DkEu3AyuITbklbNvs2eCaBgvTSxn
         Tc5i5doZIvdSNiMpXk+R+MIjfItYGFdxdm40vbz6un9H5BmjQ0WWWQYblwgoitj26ITp
         M1rXgFyxEvqw1v3srisoReVv7awVTJd7ZLhS8DUipNp7v70F2bFJfeP/qQrc6N7/778E
         6FSQ==
X-Gm-Message-State: AOAM533gnXqKP3cY1pmXiZkn6AMNu4gHyO+Qqxhl43/R2e6gNbSMTUbc
        MTpcs9xAqymMHFOy2CdX8CsAUYBuDORWDTf+8uZWvDEmwPFVLMY+TZm41FFSOpE0UZFRcV5jbnH
        g7mZ0deTDrxsK
X-Received: by 2002:aa7:d8c4:: with SMTP id k4mr45494044eds.248.1606127503627;
        Mon, 23 Nov 2020 02:31:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoCn0yiHfoaStLQGbxMgypbBcxw98Vu4awds48yqDRMXwn6JTfdCoylEM2Jg/gyo8K8WCnFQ==
X-Received: by 2002:aa7:d8c4:: with SMTP id k4mr45494023eds.248.1606127503324;
        Mon, 23 Nov 2020 02:31:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u15sm4894103edt.24.2020.11.23.02.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:31:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 84BD6183064; Mon, 23 Nov 2020 11:31:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@mellanox.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Subject: Re: Is test_offload.py supposed to work?
In-Reply-To: <CAEf4BzaYPXKCSUX50UrkvbGZ+Ne_YqHLfcgtXzwWFpCvugC8jg@mail.gmail.com>
References: <87y2iwqbdg.fsf@toke.dk>
 <CAEf4BzaYPXKCSUX50UrkvbGZ+Ne_YqHLfcgtXzwWFpCvugC8jg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Nov 2020 11:31:42 +0100
Message-ID: <87zh38mkj5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 20, 2020 at 7:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Hi Jakub and Jiri
>>
>> I am investigating an error with XDP offload mode, and figured I'd run
>> 'test_offload.py' from selftests. However, I'm unable to get it to run
>> successfully; am I missing some config options, or has it simply
>> bit-rotted to the point where it no longer works?
>>
>
> See also discussion in [0]
>
>   [0] https://www.spinics.net/lists/netdev/msg697523.html

Ah, right, thanks for the pointer :)

-Toke

