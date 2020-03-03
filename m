Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBC177BDA
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 17:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgCCQ1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 11:27:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729598AbgCCQ1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 11:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583252859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXOES8R7lt1FaMV27O05pLr/5n+ZxyuO6JH2cTv43as=;
        b=RkOc0Jg1//pn7hkPo1PDqoOKGjEwZj+RWTM0xXYaUSD8vyF/Ju/lFciZqv0WRcnYWHLGM+
        pO51FojkZKjXcU/y5650njlQVg7dlAC28EX0/P3R4tXRz6H5gUAtEqBkKTRZD0uUFwYjPR
        XsKSpE27kHMGuH4YMU6hXWwsS15SCHo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Ihx8aoLcOkK9TZBNG1yjHA-1; Tue, 03 Mar 2020 11:27:37 -0500
X-MC-Unique: Ihx8aoLcOkK9TZBNG1yjHA-1
Received: by mail-wr1-f72.google.com with SMTP id q18so1456195wrw.5
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 08:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EXOES8R7lt1FaMV27O05pLr/5n+ZxyuO6JH2cTv43as=;
        b=MU6hAyCgyrB82aq8LzpmN5SVlxkQ6UVq8S4WMZAua/AmQvSTBh4lsRzhLqmZ83ss2P
         E3stX2spn06GygpUdau1WeNljkydQS0OXpbyXSB/9X3P3NwH59Ed898+hYvkuXW0LQR9
         p454yIrDFj1tM5n10emVLpRk1kk15zG0u0jCpyu8/yxp8b3asMNifmL3EQjws+3Kgfsp
         V0Ee/GokyDRBpbLOTK71LWYxi29ghzW/CuIU9eQWxP0utSZJOVMUwROSccdv0JyAwRef
         zoE7puFzxeqKXGvX+ohtgTAneAErT7JePuiSzEUYxd+69YGScfoz3Unrx/Q/jfPPy4EU
         +cuQ==
X-Gm-Message-State: ANhLgQ0q5F0+Msr+l1JsOg/XnwdvjwSuek8eCZZCOKChZNwbLchM6FEw
        ug182AExXAkJ2DrlE5zIxkw3rRRH7BKiYYhqIGPUO0FtXRFr7a+1HD5S/HIVPs/HHx6vZVLTdEL
        SPZrEF5X0MAZc
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr4859154wmc.71.1583252856091;
        Tue, 03 Mar 2020 08:27:36 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvnvh2YnX6Vor6VsCTeF6I03GVmPgt9Mvj+GG8GAzUkK8YR/9BFT2Rg2tJKqt2/1ZUHVcEc7A==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr4859137wmc.71.1583252855877;
        Tue, 03 Mar 2020 08:27:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b14sm24703675wrn.75.2020.03.03.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:27:34 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B816180331; Tue,  3 Mar 2020 17:27:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrey Ignatov <rdna@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Takshak Chahande <ctakshak@fb.com>
Subject: Re: [PATCH RFC] Userspace library for handling multiple XDP programs on an interface
In-Reply-To: <CAADnVQJM4M38hNRX16sFGMboXT8AwUpuSUrvH_B9bSiGEr8HzQ@mail.gmail.com>
References: <158289973977.337029.3637846294079508848.stgit@toke.dk> <20200228221519.GE51456@rdna-mbp> <87v9npu1cg.fsf@toke.dk> <20200303010318.GB84713@rdna-mbp> <877e01sr6m.fsf@toke.dk> <CAADnVQJM4M38hNRX16sFGMboXT8AwUpuSUrvH_B9bSiGEr8HzQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 03 Mar 2020 17:27:34 +0100
Message-ID: <871rq95rpl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Mar 3, 2020 at 1:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> This is the reason why I think the 'link' between the main program and
>> the replacement program is in the "wrong direction". Instead I want to
>> introduce a new attachment API that can be used instead of
>> bpf_raw_tracepoint_open() - something like:
>>
>> prog_fd =3D sys_bpf(BPF_PROG_LOAD, ...); // dispatcher
>> func_fd =3D sys_bpf(BPF_PROG_LOAD, ...); // replacement func
>> err =3D sys_bpf(BPF_PROG_REPLACE_FUNC, prog_fd, btf_id, func_fd); // doe=
s *not* return an fd
>>
>> When using this, the kernel will flip the direction of the reference
>> between BPF programs, so it goes main_prog -> replacement_prog. And
>> instead of getting an fd back, this will make the replacement prog share
>> its lifecycle with the main program, so that when the main program is
>> released, so is the replacement (absent other references, of course).
>> There could be an explicit 'release' command as well, of course, and a
>> way to list all replacements on a program.
>
> Nack to such api.
> We hit this opposite direction issue with xdp and tc in the past.
> Not going to repeat the same mistake again.

Care to elaborate? What mistake, and what was the issue?

-Toke

