Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C472144EC
	for <lists+bpf@lfdr.de>; Sat,  4 Jul 2020 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGDKt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jul 2020 06:49:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgGDKt2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jul 2020 06:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593859766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgxXNTblZtjtwZ3l2pUTM1I0pvdGV+szIP4vvQDVznw=;
        b=aDRhEDLyJcnHkYtO/s/T6a5pjTQJdaQwvRELBqxtcEy3OLkhuk6eMeT1ZUC9GS/7a2cL8p
        ohpsVJ+LQUc5gBi2DqERY4RHmffWA5wTIajVOJOI1lIliTooENBY/oZiZ8JAPgchWQUyUS
        YFGSo7EJAdxJpeKxizcti+3wdZt9eEE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-mfKQfYMBNH-bNx5c24fQvA-1; Sat, 04 Jul 2020 06:49:23 -0400
X-MC-Unique: mfKQfYMBNH-bNx5c24fQvA-1
Received: by mail-pj1-f71.google.com with SMTP id t12so23126488pju.8
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2020 03:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fgxXNTblZtjtwZ3l2pUTM1I0pvdGV+szIP4vvQDVznw=;
        b=hnAAkOqcsjIBpxxBYRLx70Tpf1vCIz48bzoQazHWbmK2tABZa3zLOOYd0YpQ5C7cb7
         bPM5E3vjJtFkSZfDyvIs3IzxlhKj7auiymqUW3tTBH1PeNTHCUDP6bnyHLKtK6TNix/c
         C6bGYRbbqb/1gDcgL7DwS8rbZgYBiKZlLrhTCfRbHGAHmj/+GHvILENCX4hFvpD4Rdf3
         KkCnPAQ0slOs2CH+q6jdVxVBGIBgicrqK0d+lENpVFjV2bI4WVjQwp/gMAtovSyQQTeN
         3YofxKqkk1EAEXZg2WzBt21QMKx3V1bQwAnXIz9wQzTa/TgPGzNh+ntbYI2REjcO/ERY
         H7Ww==
X-Gm-Message-State: AOAM533FeVCrLuZoTZ4hy8mC63xWQcZBEtocAKEZP3n/4QvF7ZkqUZia
        dVt+uIdKYmdS4qlJAZuWjYD6GbK+bo62+fl1siFBRsJ+N/y/zW3ZdK3X6hfVf2mecOkDx2XNIn9
        gYvCf+BeJ4OSt
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr35207019plr.132.1593859726377;
        Sat, 04 Jul 2020 03:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgG6zrBf4VpsqZSMIJKnhhDaBFA21aEvkyZXAnY6AlBNY39M/iFFIr6XxNhIyD2RhiOvu2Ng==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr35207006plr.132.1593859726056;
        Sat, 04 Jul 2020 03:48:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m22sm15637484pfk.216.2020.07.04.03.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:48:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8FCFA1804A8; Sat,  4 Jul 2020 12:48:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     torvalds@linux-foundation.org, davem@davemloft.net,
        daniel@iogearbox.net, ebiederm@xmission.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/3] bpf: Populate bpffs with map and prog iterators
In-Reply-To: <20200704000745.hv4fyewbm4f5ttao@ast-mbp.dhcp.thefacebook.com>
References: <20200702200329.83224-1-alexei.starovoitov@gmail.com> <878sg0etik.fsf@toke.dk> <20200704000745.hv4fyewbm4f5ttao@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 04 Jul 2020 12:48:40 +0200
Message-ID: <87h7unmu7r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jul 03, 2020 at 01:18:43PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> > The user mode driver will load BPF Type Formats, create BPF maps, popu=
late BPF
>> > maps, load two BPF programs, attach them to BPF iterators, and finally=
 send two
>> > bpf_link IDs back to the kernel.
>> > The kernel will pin two bpf_links into newly mounted bpffs instance un=
der
>> > names "progs" and "maps". These two files become human readable.
>> >
>> > $ cat /sys/fs/bpf/progs
>> >   id name            pages attached
>> >   11    dump_bpf_map     1 bpf_iter_bpf_map
>> >   12   dump_bpf_prog     1 bpf_iter_bpf_prog
>> >   27 test_pkt_access     1
>> >   32       test_main     1 test_pkt_access test_pkt_access
>> >   33   test_subprog1     1 test_pkt_access_subprog1 test_pkt_access
>> >   34   test_subprog2     1 test_pkt_access_subprog2 test_pkt_access
>> >   35   test_subprog3     1 test_pkt_access_subprog3 test_pkt_access
>> >   36 new_get_skb_len     1 get_skb_len test_pkt_access
>> >   37 new_get_skb_ifi     1 get_skb_ifindex test_pkt_access
>> >   38 new_get_constan     1 get_constant test_pkt_access
>>=20
>> Do the iterators respect namespace boundaries? Or will I see all
>> programs/maps on the host if I cat the file inside a container?
>
> why are you asking? I'm pretty sure you know that bpf infra isn't namespa=
ced yet.

I thought I did, but this seemed to be something that implied I was
wrong, so figured maybe I missed something.

>> > Few interesting observations:
>> > - though bpffs comes with two human readble files "progs" and "maps" t=
hey
>> >   can be removed. 'rm -f /sys/fs/bpf/progs' will remove bpf_link and k=
ernel
>> >   will automatically unload corresponding BPF progs, maps, BTFs.
>>=20
>> Is there any way to get the files back if one does this by mistake
>> (other than re-mounting the bpffs)?
>
> Same as user A pining their prog/map/link in bpffs and user B removing it.

Right, sure, but in that case A can presumably restart their application
and get it back. Whereas in this case that's not possible, short of
clearing the whole bpffs and remounting it. Would it be possible to
re-trigger the UMH on an existing fs, say by issuing 'mount -o remount
bpf /sys/fs/bpf' (or some other debug mechanism)?

-Toke

