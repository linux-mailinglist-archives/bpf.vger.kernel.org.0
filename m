Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC21452D7
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 11:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVKpM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 05:45:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729066AbgAVKpM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 05:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579689910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+qR5+2XnS/Jvtx+SCAflUuxRNQSv388iVEOgrKyFko=;
        b=Zi8nCovPI/uvjam6wyfx9NbMcE6UktrKhF3v/ztJaghcXIovSHrBtWQqG7au3rRKuSwGd3
        TGPLV0SuHWWgVeVkqyxllqgrMFkl8he1t+5z9FfVGL+9oIS2N4sRpt203zEzlyZuN4cHXL
        QSabQV4HQDQB3l+WbNxt22oP0A8oYXQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-4mj8Go-fOZKNDWAzuOrHmQ-1; Wed, 22 Jan 2020 05:45:06 -0500
X-MC-Unique: 4mj8Go-fOZKNDWAzuOrHmQ-1
Received: by mail-lf1-f72.google.com with SMTP id c15so2021371lfc.8
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 02:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7+qR5+2XnS/Jvtx+SCAflUuxRNQSv388iVEOgrKyFko=;
        b=ET03OGzJdyj4pWZoYcHiG2lrsrxYo3vnrDK1enhIjuxIOe3l5pXayWVrdyexP921bA
         s219WeLauow2Rv1r6s89/tceWpyh4UVkkt1TwjJ6BSFhERvZlkBvp/UPYfT8dLRfh2pB
         pfoQ09cf4irTU232d0s9Jc1FiQv4WEBTrT6CJzgaNZqOFR+JeTaQhyY84TGM+pFmVZ/+
         U8FIVlupbpwzcQVBk3y7y4lZst/QQGJFn6YvnpMuMaxIm9HGClkceptYJhMwegSHp10t
         DpLOThxx37r0uC1eOj8VJ8gDczuLaIo5LR+g03R8irwyzH1sNNybYNlS2102ykpdwR6s
         xCVg==
X-Gm-Message-State: APjAAAUUX+6Qm7RpKaPfo29zO4dnZEtM2gepEc5tFc1Z7iHWrW9KyYSA
        S5B274ALSD2juZCA1///DaIAFRnbGqkR8+gURu2bW86RbJBcKi0650NgqZo8mcNQ6Vq9iakqgLd
        EgYok1p1/nEtx
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr19902710lji.274.1579689905180;
        Wed, 22 Jan 2020 02:45:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoqSkStv/Ank9kut/W15i+iPFFZac/FxhESW/HCEnKQJ2MEbh0ocOFsM0TBUJACkC692mEVg==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr19902684lji.274.1579689904736;
        Wed, 22 Jan 2020 02:45:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d24sm19936365lja.82.2020.01.22.02.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:45:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 498AE180075; Wed, 22 Jan 2020 11:45:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: Program extensions or dynamic re-linking
In-Reply-To: <20200121165958.zfpvsz7kdcx2dotr@ast-mbp.dhcp.thefacebook.com>
References: <20200121005348.2769920-1-ast@kernel.org> <87k15kbz2c.fsf@toke.dk> <20200121165958.zfpvsz7kdcx2dotr@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 22 Jan 2020 11:45:03 +0100
Message-ID: <87blqvbwi8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jan 21, 2020 at 04:37:31PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <ast@kernel.org> writes:
>>=20
>> > The last few month BPF community has been discussing an approach to ca=
ll
>> > chaining, since exiting bpt_tail_call() mechanism used in production X=
DP
>> > programs has plenty of downsides. The outcome of these discussion was a
>> > conclusion to implement dynamic re-linking of BPF programs. Where root=
let XDP
>> > program attached to a netdevice can programmatically define a policy of
>> > execution of other XDP programs. Such rootlet would be compiled as nor=
mal XDP
>> > program and provide a number of placeholder global functions which lat=
er can be
>> > replaced with future XDP programs. BPF trampoline, function by function
>> > verification were building blocks towards that goal. The patch 1 is a =
final
>> > building block. It introduces dynamic program extensions. A number of
>> > improvements like more flexible function by function verification and =
better
>> > libbpf api will be implemented in future patches.
>>=20
>> This is great, thank you! I'll go play around with it; couldn't spot
>> anything obvious from eye-balling the code, except that yeah, it does
>> need a more flexible libbpf api :)
>>=20
>> One thing that's not obvious to me: How can userspace tell which
>> programs replace which functions after they are loaded? Is this put into
>> prog_tags in struct bpf_prog_info, or?
>
> good point. Would be good to extend bpf_prog_info. Since prog-to-prog
> connection is unidirectional the bpf_prog_info of extension prog will be =
able
> to say which original program it's replacing.

Yeah, that'll do. I can live with having to enumerate all programs and
backtrack to the attached XDP program to figure out its component parts.

> bpftool prog show will be able to print all this data. I think
> fenry/fexit progs would need the same bpf_prog_info extension.
> attach_prog_id + attach_btf_id would be enough.

Yes, please. I actually assumed this was already there for fentry/fexit,
which is why I was puzzled I couldn't find where this series hooked into
that. I'll just wait for such an extension to show up, then :)

> In the mean time I can try to hack drgn script to do the same.

That would be great, thanks!

-Toke

