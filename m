Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC2256243
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgH1Uz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 16:55:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725979AbgH1Uz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 16:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598648125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rm0wGUOkdNeRWAqhDb1MgyJPPX4QlhsFFMLDtJU2Dw=;
        b=bM9G0/EmeFMJc8YTxRAVWDV2v8vuTdatMOurt5fN3AZeQzDcAc1xOn9DU3BYLfmw2RnFvb
        +wWwFYaxRz7gI7MjLTOnosS5FkNmpP44K37VNRLtek662lrejDG8nK8FQVdn72UCmV6zhG
        0ik/3EUOUbjNXvxwqn/jmn5aaxbEd3g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-30NSGep0M3uG4DB9DwpGcA-1; Fri, 28 Aug 2020 16:55:23 -0400
X-MC-Unique: 30NSGep0M3uG4DB9DwpGcA-1
Received: by mail-wm1-f70.google.com with SMTP id f125so176394wma.3
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 13:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0rm0wGUOkdNeRWAqhDb1MgyJPPX4QlhsFFMLDtJU2Dw=;
        b=VhU1/HqPqQQQlp8QCthPwIDLkxWIN1Wgpg9HySPZrDEYcX5qWGWWY4R1U41wPcew04
         Rx12rDIvh9p7DnFyymiknMegJ8xpu/iipQWp685AiuuyM8BWymfNgpVw9syBAd/n44Rh
         Jasx5hzn1V+5ywgaNmHrR06EMnIwSa5oxsDx/fEu3Q4cVpef5EGL2BZI969DQBCpoaSW
         jYPF/7Co+Z4pFgJjkf2cfgbM8HLQ2jUHFH2UCQ2/ToulyDDbA+1/7WsWqv+RAOYcTVyN
         Yzq08vj0RLlVq+EdSHSN8Y0t9AFHBy18xdLY/VjvwIzPe1fqpslav8nZCt7lsnPcwEW9
         xtVA==
X-Gm-Message-State: AOAM530SWDd4C9U5/ktwkCZP49BibDFshzEHHoCJxfNAMG6rxIdwlJpV
        2mIZCtW1KJ1ufecchDRq5AVtLZbQH1riatGLGC5ycUBcBTqhEJxWv52cK/UmYWOAJbS+VnD1uG4
        KvgscWXNg6IBK
X-Received: by 2002:a5d:5084:: with SMTP id a4mr678097wrt.191.1598648121896;
        Fri, 28 Aug 2020 13:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzslwT3GG2hEJSG4EHc7lkarET5XDLIpPp7e3QVmOOk+I3CMw+0GhYG3u7+fxm8pY6A9NClw==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr678082wrt.191.1598648121619;
        Fri, 28 Aug 2020 13:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c10sm786640wmk.30.2020.08.28.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A7654182B5E; Fri, 28 Aug 2020 22:55:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     sdf@google.com
Cc:     YiFei Zhu <zhuyifei@google.com>, Yonghong Song <yhs@fb.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
In-Reply-To: <20200828170010.GB48607@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com> <877dts5qah.fsf@toke.dk>
 <CAA-VZP=Jo0iQRpP+QEmB359C5TS=0BnDHTAzd6yC85aOkEJrsA@mail.gmail.com>
 <874kot2ors.fsf@toke.dk> <20200828170010.GB48607@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 Aug 2020 22:55:19 +0200
Message-ID: <877dtia3t4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sdf@google.com writes:

> On 08/23, Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen wrote:
>> YiFei Zhu <zhuyifei@google.com> writes:
>
>> > On Fri, Aug 21, 2020 at 3:58 AM Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen=
=20=20
>> <toke@redhat.com> wrote:
>> >> Yonghong Song <yhs@fb.com> writes:
>> >> > Not sure whether we need formal libbpf API to access metadata or no=
t.
>> >> > This may help other applications too. But we can delay until it is
>> >> > necessary.
>> >>
>> >> Yeah, please put in a libbpf accessor as well; I would like to use th=
is
>> >> from libxdp - without a skeleton :)
>> >>
>> >> -Toke
>> >
>> > I don't think I have an idea on a good API in libbpf that could be
>> > used to get the metadata of an existing program in kernel, that could
>> > be reused by bpftool without duplicating all the code. Maybe we can
>> > discuss this in a follow up series?
>
>> I think the most important part is getting a reference to the metadata
>> map. So a function that basically does what the top half of what your
>> show_prog_metadata() function does: given a prog fd, walk the map ids,
>> check if any of them looks like a metadata map, and if so return the map
>> fd.
>
>> Should be pretty straight-forward to reuse between bpftool/libbpf, no?
> Sounds good, I'll be taking over this patch series as YiFei's internship
> has ended. I'll try to address that.

Great, thanks! :)

-Toke

