Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F230717A345
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEKhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 05:37:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgCEKhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 05:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583404639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cN2+Xtsw8LFHYSKRE5JLybvu7mt3LSwgE56sTy83ajY=;
        b=XDjd7+UA+Bf6DIZnLnS+aleQCXxsBzbSofA1jPC9u0msf7GpxX3DaUsAu2EW+xZCUZn5ms
        8RApggNhNrWISGKaRD1wUjIogI4LkGLHLOBDZK47Sj6rbDtHA/n/1pJ2aEoUoo0Ax18ve+
        MWx956lXj38513pIICLe6JXaAqnqjXw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Y56zVVoJPIKT49LcalZYgg-1; Thu, 05 Mar 2020 05:37:15 -0500
X-MC-Unique: Y56zVVoJPIKT49LcalZYgg-1
Received: by mail-wr1-f71.google.com with SMTP id n7so2130392wro.9
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 02:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cN2+Xtsw8LFHYSKRE5JLybvu7mt3LSwgE56sTy83ajY=;
        b=jw+XQqulwtLXdmLOyzbBLTtceRjZa2vrUf1kJk/gWscKBNNGAfViQFCwcM2BIVFZ9z
         aOkxZnSbcyXnrtwpP63Wgisus9b0km2icNZn9CntuvwHvTvkhX7jz/hx2N1F7ugenZ6D
         HSVC/2kCzo19ua8MheEhCp74RSAshQH3MNyj82q4epaoECTBrYWKgqdSOIteYOZsGQOF
         k86ehfVeFr+GQ5dFS8TBUU3OZ3z5CdRdKoVEok9cfVCkms0SXegu2hxDUSLbs4OSbMTH
         N1We64D+FgcKtS5ewqRo5hp95OIn0oRKuvazBv7hs7jbzg6RbTXMhw7vCAH2tTdDB5MO
         BqwA==
X-Gm-Message-State: ANhLgQ1ZqlQL96SoLdV0WQlgHualunxyS8a1o6+kWnxBjJjtnh70kgDp
        lYtQNKjN+/cOMUJxFbR72F+kk2HiObCQ/BvSgO9y1gS69Wj0U+At0JtXXzbQRTvWX0XXKy+DsUK
        LmCVQ3y2BVG4t
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr8605485wma.84.1583404633854;
        Thu, 05 Mar 2020 02:37:13 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtSN2Z1i7gazNJ5t55HgT/w5e17SJlDdJDTAxQbMRlrJnWJ+YYhn/+Xjuakn6SxCytU/uJsSA==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr8605462wma.84.1583404633618;
        Thu, 05 Mar 2020 02:37:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i7sm28527745wro.87.2020.03.05.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:37:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EABF018034F; Thu,  5 Mar 2020 11:37:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <20200304154757.3tydkiteg3vekyth@ast-mbp>
References: <094a8c0f-d781-d2a2-d4cd-721b20d75edd@iogearbox.net> <e9a4351a-4cf9-120a-1ae1-94a707a6217f@fb.com> <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp> <87h7z44l3z.fsf@toke.dk> <20200304154757.3tydkiteg3vekyth@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 05 Mar 2020 11:37:11 +0100
Message-ID: <874kv33x60.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Mar 04, 2020 at 08:47:44AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> >
>> >> And what about the case where the link fd is pinned on a bpffs that is
>> >> no longer available? I.e., if a netdevice with an XDP program moves
>> >> namespaces and no longer has access to the original bpffs, that XDP
>> >> program would essentially become immutable?
>> >
>> > 'immutable' will not be possible.
>> > I'm not clear to me how bpffs is going to disappear. What do you mean
>> > exactly?
>>=20
>> # stat /sys/fs/bpf | grep Device
>> Device: 1fh/31d	Inode: 1013963     Links: 2
>> # mkdir /sys/fs/bpf/test; ls /sys/fs/bpf
>> test
>> # ip netns add test
>> # ip netns exec test stat /sys/fs/bpf/test
>> stat: cannot stat '/sys/fs/bpf/test': No such file or directory
>> # ip netns exec test stat /sys/fs/bpf | grep Device
>> Device: 3fh/63d	Inode: 12242       Links: 2
>>=20
>> It's a different bpffs instance inside the netns, so it won't have
>> access to anything pinned in the outer one...
>
> Toke, please get your facts straight.
>
>> # stat /sys/fs/bpf | grep Device
>> Device: 1fh/31d	Inode: 1013963     Links: 2
>
> Inode !=3D 1 means that this is not bpffs.
> I guess this is still sysfs.

Yes, my bad; I was confused because I was misremembering when 'ip'
mounts a new bpffs: I thought it was on every ns change, but it's only
when loading a BPF program, and I was in a hurry so I didn't check
properly; sorry about that.

Anyway, what I was trying to express:

> Still that doesn't mean that pinned link is 'immutable'.

I don't mean 'immutable' in the sense that it cannot be removed ever.
Just that we may end up in a situation where an application can see a
netdev with an XDP program attached, has the right privileges to modify
it, but can't because it can't find the pinned bpf_link. Right? Or am I
misunderstanding your proposal?

Amending my example from before, this could happen by:

1. Someone attaches a program to eth0, and pins the bpf_link to
   /sys/fs/bpf/myprog

2. eth0 is moved to a different namespace which mounts a new sysfs at
   /sys

3. Inside that namespace, /sys/fs/bpf/myprog is no longer accessible, so
   xdp-loader can't get access to the original bpf_link; but the XDP
   program is still attached to eth0.

If this happens, and the bpf_link locks the program in place, doesn't
that mean that anything inside executed inside that namespace will be
unable to remove the XDP program? Thus making it 'immutable' from their
PoV.

-Toke

