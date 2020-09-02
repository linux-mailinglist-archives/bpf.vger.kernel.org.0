Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE025A8CC
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIBJng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 05:43:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBJnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 05:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599039810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjDRzq77L5RcjBz9v6vn2oQ22UJVjvMIc/2TJOmBKnc=;
        b=dKH8kUgu03FLJ129lT6Qefj5xGta54X1+mx4kM9sV6xVO0TEB+hK5qHRXpitiCc+b73Z7m
        b9WcMcmCMzpXjMGsVuW+ZWKNt/Q+6aFeRjoeFRJdZKR+Fjtq3jmf9MKqPBnJbCXzioxsnP
        nZpHrqLt9MyQcvi4+A9ZWWbGDKx2Cdc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-M-9JkDFrOrOhqagfQzUtmA-1; Wed, 02 Sep 2020 05:43:29 -0400
X-MC-Unique: M-9JkDFrOrOhqagfQzUtmA-1
Received: by mail-ej1-f71.google.com with SMTP id r26so1889719ejz.13
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 02:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sjDRzq77L5RcjBz9v6vn2oQ22UJVjvMIc/2TJOmBKnc=;
        b=cUgSlG/DpnLJyefNgwNPdTbGf9nWxkjfLCuimA+o1PYFFK5EH+UmqyMK8NTUnHz4RD
         NcP3cj8MvQ2iLjLdZkrmS4rntPtCso7Dp3uE8eiShWBwr7T8L/2zxHAMI/Qd9KoW5bqb
         6TXK1LoTt5IpLjaSi40mB3+OfwJVDH4/rOOo10mQHJggH30ZKvA8CynOOj3UqqtdtGTG
         YfZwp2IGQcJI4J3Bkq/zYIjquAY2o0E3HP6TZ2UXxVMS7Vmkcg7UR7BPmdNR6DHSzy/e
         TsM8fo5d+cQAig82KQmC+jGVcZu05xpxRR2IckPocenZKJlte2qlyCEABWnxUw/z2bj4
         ZGnQ==
X-Gm-Message-State: AOAM531X57jLhwjQkCVW+JUKL4sM/u16ts4i1KUsigG/bP0JAjZOG4kN
        mFKSD8iguS4jZ88wfYSfxmAK58OJJfygB03P2qUfrH5EHhriv08ujLwAbA9JoeYfYoAuxh8yThe
        kG/zc3mw1bNG1
X-Received: by 2002:a50:eb92:: with SMTP id y18mr5481426edr.373.1599039807980;
        Wed, 02 Sep 2020 02:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy61WaMepVfpVs5T6DRdHNesNs7HCd2m4YWpZnCVZnOk1l6pdCM/qq/nGaCXHYRYiFePCENug==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr5481400edr.373.1599039807617;
        Wed, 02 Sep 2020 02:43:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l26sm3763345ejr.78.2020.09.02.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:43:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 810A718200B; Wed,  2 Sep 2020 11:43:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, sdf@google.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net,
        YiFei Zhu <zhuyifei1999@gmail.com>, andriin@fb.com
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: implement bpf_prog_find_metadata
In-Reply-To: <20200901225841.qpsugarocx523dmy@ast-mbp.dhcp.thefacebook.com>
References: <20200828193603.335512-1-sdf@google.com>
 <20200828193603.335512-5-sdf@google.com> <874koma34d.fsf@toke.dk>
 <20200831154001.GC48607@google.com>
 <20200901225841.qpsugarocx523dmy@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Sep 2020 11:43:26 +0200
Message-ID: <874kogike9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Aug 31, 2020 at 08:40:01AM -0700, sdf@google.com wrote:
>> On 08/28, Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen wrote:
>> > Stanislav Fomichev <sdf@google.com> writes:
>>=20
>> > > This is a low-level function (hence in bpf.c) to find out the metada=
ta
>> > > map id for the provided program fd.
>> > > It will be used in the next commits from bpftool.
>> > >
>> > > Cc: Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen <toke@redhat.com>
>> > > Cc: YiFei Zhu <zhuyifei1999@gmail.com>
>> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> > > ---
>> > >  tools/lib/bpf/bpf.c      | 74 +++++++++++++++++++++++++++++++++++++=
+++
>> > >  tools/lib/bpf/bpf.h      |  1 +
>> > >  tools/lib/bpf/libbpf.map |  1 +
>> > >  3 files changed, 76 insertions(+)
>> > >
>> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> > > index 5f6c5676cc45..01c0ede1625d 100644
>> > > --- a/tools/lib/bpf/bpf.c
>> > > +++ b/tools/lib/bpf/bpf.c
>> > > @@ -885,3 +885,77 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>> > >
>> > >  	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
>> > >  }
>> > > +
>> > > +int bpf_prog_find_metadata(int prog_fd)
>> > > +{
>> > > +	struct bpf_prog_info prog_info =3D {};
>> > > +	struct bpf_map_info map_info;
>> > > +	__u32 prog_info_len;
>> > > +	__u32 map_info_len;
>> > > +	int saved_errno;
>> > > +	__u32 *map_ids;
>> > > +	int nr_maps;
>> > > +	int map_fd;
>> > > +	int ret;
>> > > +	int i;
>> > > +
>> > > +	prog_info_len =3D sizeof(prog_info);
>> > > +
>> > > +	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len=
);
>> > > +	if (ret)
>> > > +		return ret;
>> > > +
>> > > +	if (!prog_info.nr_map_ids)
>> > > +		return -1;
>> > > +
>> > > +	map_ids =3D calloc(prog_info.nr_map_ids, sizeof(__u32));
>> > > +	if (!map_ids)
>> > > +		return -1;
>> > > +
>> > > +	nr_maps =3D prog_info.nr_map_ids;
>> > > +	memset(&prog_info, 0, sizeof(prog_info));
>> > > +	prog_info.nr_map_ids =3D nr_maps;
>> > > +	prog_info.map_ids =3D ptr_to_u64(map_ids);
>> > > +	prog_info_len =3D sizeof(prog_info);
>> > > +
>> > > +	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len=
);
>> > > +	if (ret)
>> > > +		goto free_map_ids;
>> > > +
>> > > +	ret =3D -1;
>> > > +	for (i =3D 0; i < prog_info.nr_map_ids; i++) {
>> > > +		map_fd =3D bpf_map_get_fd_by_id(map_ids[i]);
>> > > +		if (map_fd < 0) {
>> > > +			ret =3D -1;
>> > > +			goto free_map_ids;
>> > > +		}
>> > > +
>> > > +		memset(&map_info, 0, sizeof(map_info));
>> > > +		map_info_len =3D sizeof(map_info);
>> > > +		ret =3D bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
>> > > +		saved_errno =3D errno;
>> > > +		close(map_fd);
>> > > +		errno =3D saved_errno;
>> > > +		if (ret)
>> > > +			goto free_map_ids;
>>=20
>> > If you get to this point on the last entry in the loop, ret will be 0,
>> > and any of the continue statements below will end the loop, causing the
>> > whole function to return 0. While this is not technically a valid ID, =
it
>> > still seems odd that the function returns -1 on all error conditions
>> > except this one.
>>=20
>> > Also, it would be good to be able to unambiguously distinguish between
>> > "this program has no metadata associated" and "something went wrong
>> > while querying the kernel for metadata (e.g., permission error)". So
>> > something that amounts to a -ENOENT return; I guess turning all return
>> > values into negative error codes would do that (and also do away with
>> > the need for the saved_errno dance above), but id does clash a bit with
>> > the convention in the rest of the file (where all the other functions
>> > just return -1 and set errno)...
>> Good point. I think I can change the function signature to:
>>=20
>> 	int bpf_prog_find_metadata(int prog_fd, int *map_id)
>>=20
>> And explicitly return map_id via argument. Then the ret can be used as
>> -1/0 error and I can set errno appropriately where it makes sense.
>> This will better match the convention we have in this file.
>
> I don't feel great about this libbpf api. bpftool already does
> bpf_obj_get_info_by_fd() for progs and for maps.
> This extra step and extra set of syscalls is redundant work.
> I think it's better to be done as part of bpftool.
> It doesn't quite fit as generic api.

Why not? We are establishing a convention for how to store (and read)
metadata from a program; by having an API to get this, we make sure that
every application that wants to access this metadata agrees on how to do
so. If we don't have it, people will have to go look at bpftool code,
and we'll end up with copied code snippets, which seems less than ideal.

-Toke

