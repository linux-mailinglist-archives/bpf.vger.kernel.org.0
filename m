Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A612184B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfLPSAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 13:00:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41566 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbfLPSAL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 13:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576519209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8OYKMcfujhNjK8AEmQgJ/I1VwMzTEpLP9Q81r8ttM8=;
        b=N4lYk5stYCWiIkDDEr5AkVISy6UsLyTHWV2/ka5gLy5h7Q08hV7un1ctfLiuyO3EwxMyA/
        UOWpVdU3JMYdM8t9CtdEZTi+W9z1lCaHBW52yAwoFulsMrX/YzSUyAaV6C4AaRFuxuTi8s
        B1QO5fK6QHZRlCOCMBS4mwBDbz8lco4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--vZqa0RuO4mcETaeR5M2uQ-1; Mon, 16 Dec 2019 13:00:08 -0500
X-MC-Unique: -vZqa0RuO4mcETaeR5M2uQ-1
Received: by mail-lf1-f71.google.com with SMTP id d7so674067lfk.9
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 10:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=P8OYKMcfujhNjK8AEmQgJ/I1VwMzTEpLP9Q81r8ttM8=;
        b=U0eP4UzR5dehJGJIxl5RUpTY0G8NiXJ2W5nxBwcuQ8G4sEuphRr4+ih5hqt0ciSftB
         rUhHpIiNTkol8MNGlsBNh9VzoTY+akxBjAK46zSi8HLCBnf4k/tNlNtBCRXHsgYmMGCT
         XpuH04/FRVXh/4Bp+Ud+0C8utbNSuGntelFqjCsm5yTwA/i55zblzyE+x8CtWWzFo2Az
         axH50kLlQmcU4+CItI+lkCGpBvxC8avnn4+tStyEpmJQJfj77SH9+0F5ldtdaTteVRux
         z+5K/inc1VoSVpHQugytbo+4v9414wMbX7yLLS6FX1aKEN1VT+wT4gz43NkhnnzRnE47
         91yg==
X-Gm-Message-State: APjAAAUfplMcDz8OZK8ErWgDuK7lOAVabWnRLpOwo1+8kb6qoySwGYfI
        gOxGqLC8cuxl4rm9PYlurideAdGNBhvean2DpspVq02EeAMJICpc3QP6Sj1rsowEBHpwsMGcc09
        E8PVbhoKGg+qC
X-Received: by 2002:a19:6d13:: with SMTP id i19mr201115lfc.6.1576519206609;
        Mon, 16 Dec 2019 10:00:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxh/vvO8yzMc5Mg/c6CA5AJMtI+JugQ5TVXTp2xmIojkcAcGAWuH7MDCiVVCg8O6WMEvdSLeQ==
X-Received: by 2002:a19:6d13:: with SMTP id i19mr201101lfc.6.1576519206365;
        Mon, 16 Dec 2019 10:00:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m8sm9423870lfp.4.2019.12.16.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 10:00:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A5500180960; Mon, 16 Dec 2019 19:00:04 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next] libbpf: Print hint about ulimit when getting permission denied error
In-Reply-To: <2146814b-f70e-b401-3ed3-4d113ab47e34@fb.com>
References: <20191216124031.371482-1-toke@redhat.com> <2146814b-f70e-b401-3ed3-4d113ab47e34@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Dec 2019 19:00:04 +0100
Message-ID: <87mubs882j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 12/16/19 4:40 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Probably the single most common error newcomers to XDP are stumped by is
>> the 'permission denied' error they get when trying to load their program
>> and 'ulimit -r' is set too low. For examples, see [0], [1].
>>=20
>> Since the error code is UAPI, we can't change that. Instead, this patch
>> adds a few heuristics in libbpf and outputs an additional hint if they a=
re
>> met: If an EPERM is returned on map create or program load, and geteuid()
>> shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
>> output a hint about raising 'ulimit -r' as an additional log line.
>>=20
>> [0] https://marc.info/?l=3Dxdp-newbies&m=3D157043612505624&w=3D2
>> [1] https://github.com/xdp-project/xdp-tutorial/issues/86
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> LGTM with one minor no-essential suggestion below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   tools/lib/bpf/libbpf.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>=20
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a2cc7313763a..aec7995674d2 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -41,6 +41,7 @@
>>   #include <sys/types.h>
>>   #include <sys/vfs.h>
>>   #include <sys/utsname.h>
>> +#include <sys/resource.h>
>>   #include <tools/libc_compat.h>
>>   #include <libelf.h>
>>   #include <gelf.h>
>> @@ -100,6 +101,24 @@ void libbpf_print(enum libbpf_print_level level, co=
nst char *format, ...)
>>   	va_end(args);
>>   }
>>=20=20=20
>> +static void pr_perm_msg(int err)
>> +{
>> +	struct rlimit limit;
>> +
>> +	if (err !=3D -EPERM || geteuid() !=3D 0)
>> +		return;
>> +
>> +	err =3D getrlimit(RLIMIT_MEMLOCK, &limit);
>> +	if (err)
>> +		return;
>> +
>> +	if (limit.rlim_cur =3D=3D RLIM_INFINITY)
>> +		return;
>> +
>> +	pr_warn("permission error while running as root; try raising 'ulimit -=
r'? current value: %lu\n",
>> +		limit.rlim_cur);
>
> Here we print out in terms of bytes. Maybe in terms of kilo bytes or=20
> mega bytes is more user friendly, esp. we want them to set a different=20
> value?

Yeah, thought about that, but was too lazy to actually implement it :)

Can send a v2 with that added...

-Toke

