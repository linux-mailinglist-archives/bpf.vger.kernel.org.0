Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACE120ED2
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfLPQIf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 11:08:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbfLPQIf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 11:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576512513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJFNFTYus131wY/x9jHRX7vgYg0Fp1HJyonMa/UF2qc=;
        b=JfzxBcuJnSHIUZ0RJm0Z+hNctBlRWLVbUAE2feA1Y1egnyKEfx5/EImfpywugeDzb9qpSK
        nPqDmoq/bR3ycA/JjBWN+OO1In8+hTcBGSMW5M9nakClKkH1K5iD0LuXMPhSb2NbkV/Ilf
        40WrxLOHQ1XhV5QJQckoqiU9qhAtk4I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-AKzTXZfZNXmCTcHhyd-yVw-1; Mon, 16 Dec 2019 11:08:32 -0500
X-MC-Unique: AKzTXZfZNXmCTcHhyd-yVw-1
Received: by mail-lj1-f200.google.com with SMTP id b12so2293551ljo.11
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 08:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WJFNFTYus131wY/x9jHRX7vgYg0Fp1HJyonMa/UF2qc=;
        b=eS/UDCtDg6W7s7lCb98GKQXqJI/ixK//zi3eFgYvesrXMDKiwLU7hHjHvi8KZDmtok
         CWt2z2PXIhluznENG1736kCKH4uXg+DNX/DQA7ztgWEr9ZK6OKkuYsh8yk0pvIEC6kGC
         RELt0nnHR0o1GKOUvU8dZ/GeCR3wIJt2F71Jrq1jdAXv3o11A+ZmiCTp+5is03//YRS8
         WTz1w5ZAfFjqAlSFMDu3vxSoYg5UPLxTdo7Y2Uc+N7kB7SB6fCQAKouv2Jnj5lPEyNSY
         XF/GhEM8e3mZW8v+xf4C+G3lzCBwWddLWAcLNgRjpeK3A4d25ClMdADCMi8KWNUJ0jYw
         Qf8Q==
X-Gm-Message-State: APjAAAVaRqkVfkqukleSSrc2bTuKIgXvcOZ9VU4xEi0w9WcHMv5SDFYd
        OEUREm4xzeICrvdtHnrpmcGqvflFb/Ak1Bdk1soDfXjm2FRqQ98H0jvmCIdf+Ya8u9hWwKn4lid
        EaR8xnotbPAnO
X-Received: by 2002:ac2:4212:: with SMTP id y18mr17158263lfh.2.1576512510900;
        Mon, 16 Dec 2019 08:08:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6B3M33nH8IIoV5WUjlsvpxTy5Ng5N5Mpg7cNDSOfojhgbdGyLJ3wml64C/rrsAPMvKmCc/w==
X-Received: by 2002:ac2:4212:: with SMTP id y18mr17158244lfh.2.1576512510673;
        Mon, 16 Dec 2019 08:08:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g24sm4105982lfb.85.2019.12.16.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:08:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 496DA180960; Mon, 16 Dec 2019 17:08:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Print hint about ulimit when getting permission denied error
In-Reply-To: <20191216155336.GA28925@linux.fritz.box>
References: <20191216124031.371482-1-toke@redhat.com> <20191216145230.103c1f46@carbon> <20191216155336.GA28925@linux.fritz.box>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Dec 2019 17:08:29 +0100
Message-ID: <87y2vc8d8i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Mon, Dec 16, 2019 at 02:52:30PM +0100, Jesper Dangaard Brouer wrote:
>> On Mon, 16 Dec 2019 13:40:31 +0100
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>>=20
>> > Probably the single most common error newcomers to XDP are stumped by =
is
>> > the 'permission denied' error they get when trying to load their progr=
am
>> > and 'ulimit -r' is set too low. For examples, see [0], [1].
>> >=20
>> > Since the error code is UAPI, we can't change that. Instead, this patch
>> > adds a few heuristics in libbpf and outputs an additional hint if they=
 are
>> > met: If an EPERM is returned on map create or program load, and geteui=
d()
>> > shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
>> > output a hint about raising 'ulimit -r' as an additional log line.
>> >=20
>> > [0] https://marc.info/?l=3Dxdp-newbies&m=3D157043612505624&w=3D2
>> > [1] https://github.com/xdp-project/xdp-tutorial/issues/86
>> >=20
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>=20
>> This is the top #1 issue users hit again-and-again, too bad we cannot
>> change the return code as it is UAPI now.  Thanks for taking care of
>> this mitigation.
>
> It's an annoying error that comes up very often, agree, and tooling then
> sets it to a high value / inf anyway as next step if it has the rights
> to do so. Probably time to revisit the idea that if the user has the same
> rights as being able to set setrlimit() anyway, we should just not account
> for it ... incomplete hack:

It did always seem a bit odd to me that there was this limit that was
setable by the user it was supposed to limit (for XDP anyway). So I
would totally be in favour of fixing it in the kernel; but probably a
good idea to put the hint into libbpf anyway, for those with older
kernels...

-Toke

