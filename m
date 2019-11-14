Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC41FC951
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNOz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 09:55:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfKNOz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 09:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573743355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVXcjwtBf3NZ36Eq0yDSwVNdrCXxD9u9+76H1pXkzIY=;
        b=fgCMZPehSmH+4TzAfdlwXjl2DD5FMLl7DAu7kSmoWex6R41nYHQ89Txe/L0fNwD4Ks2Dmy
        UtlKV75qIf2xO38bzrLb/3Z25DwxPA/gwN5DSeMBFFChSlznDPOwBvqFfg7DTuSqmyKocr
        CPh/ukzl/v+YjJnBtDW0cSWvvFoKB4U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Jwi_QT5xNNuXMHBL88Rmtw-1; Thu, 14 Nov 2019 09:55:54 -0500
Received: by mail-lf1-f71.google.com with SMTP id d11so2051713lfj.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 06:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rIBZiL1FWythDUin873DaL6ByyNzCAJsvbPWa35uar8=;
        b=AWPpoEp+Aw9+N12jtUxEVAhXnyQBM9qMLRC0L25ZztWH/bn2kAt8IwFpxLCiqgXeCS
         nWrSNeqbfOAfOX1o2talhDKhZqOSdqDZttXRdkvhJ9JPiPUHvtO1LP/vebyupO9Fmww+
         RrJxJqqdm/C01LyjDBJWMgL03UYU9JGojk7XkiDRMJtf930lDdW7uZ91KHnVtx5FczUn
         1HCbNETcZlymfeUVmq8sr7dlxB0jfpxRL+5WXPI67v4qPOVMq7oj/5ppR4maVOaTsGXz
         qn7E058KdkYQq3SQRbtTldUlHu1Ov0mko+c1tkIAdMyzyA62WsmKGKmTuvG7J8VYhWR2
         IWnQ==
X-Gm-Message-State: APjAAAXX/D5uadn/Ms19xpPCs6vT/9F1Y4/2MWRyZlAw/V5ZHg/HJ9C4
        260pve+qtqNNYXA/DyCE9KLTyIs6zZoNWqrWteVToHAp7g5HuXcq1gZsxsiAK/iju6r1MUM2FdB
        6O1TEUx+kBhw8
X-Received: by 2002:a19:ccd7:: with SMTP id c206mr6954009lfg.165.1573743352965;
        Thu, 14 Nov 2019 06:55:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDdMh8yqEOtvSSTWb+aD+1/y4JfNENnZFitaJOBGmj/dwnGACpjvDyAvuaqu4R5CeK4afWRg==
X-Received: by 2002:a19:ccd7:: with SMTP id c206mr6953994lfg.165.1573743352754;
        Thu, 14 Nov 2019 06:55:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d17sm2941336lja.27.2019.11.14.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 06:55:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3827B1803C7; Thu, 14 Nov 2019 15:55:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: introduce BPF dispatcher
In-Reply-To: <CAJ+HfNhPhCi4=taK7NcYuCvdcRBXVDobn7fpD3mi1eppTL7zLA@mail.gmail.com>
References: <20191113204737.31623-1-bjorn.topel@gmail.com> <20191113204737.31623-3-bjorn.topel@gmail.com> <87o8xeod0s.fsf@toke.dk> <7893c97d-3d3f-35cc-4ea0-ac34d3d84dbc@iogearbox.net> <CAJ+HfNhPhCi4=taK7NcYuCvdcRBXVDobn7fpD3mi1eppTL7zLA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 14 Nov 2019 15:55:51 +0100
Message-ID: <874kz6o6bs.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Jwi_QT5xNNuXMHBL88Rmtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Thu, 14 Nov 2019 at 14:03, Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>>
>> On 11/14/19 1:31 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>> >>
>> >> The BPF dispatcher builds on top of the BPF trampoline ideas;
>> >> Introduce bpf_arch_text_poke() and (re-)use the BPF JIT generate
>> >> code. The dispatcher builds a dispatch table for XDP programs, for
>> >> retpoline avoidance. The table is a simple binary search model, so
>> >> lookup is O(log n). Here, the dispatch table is limited to four
>> >> entries (for laziness reason -- only 1B relative jumps :-P). If the
>> >> dispatch table is full, it will fallback to the retpoline path.
>> >
>> > So it's O(log n) with n =3D=3D 4? Have you compared the performance of=
 just
>> > doing four linear compare-and-jumps? Seems to me it may not be that bi=
g
>> > of a difference for such a small N?
>>
>> Did you perform some microbenchmarks wrt search tree? Mainly wondering
>> since for code emission for switch/case statements, clang/gcc turns off
>> indirect calls entirely under retpoline, see [0] from back then.
>>
>
> As Toke stated, binsearch is not needed for 4 entries. I started out
> with 16 (and explicit ids instead of pointers), and there it made more
> sense. If folks think it's a good idea to move forward -- and with 4
> entries, it makes sense to make the code generator easier, or maybe
> based on static_calls like Ed did.

I don't really have anything to back it up, but my hunch is that only 4
entries will end up being a limit that people are going to end up
hitting. And since the performance falls off quite the cliff after
hitting that limit, I do fear that this is something we will hear about
quite emphatically :)

-Toke

