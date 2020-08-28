Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710E25625D
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgH1VKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 17:10:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726584AbgH1VKR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Aug 2020 17:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598649015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqwTtONj5KNOC/pnXhqbs+sbySt/5ow/XPS2c3mPNYg=;
        b=aSH/P/47MnzLhkZKtI6zPJbLc7nnLdvEt0TeE1CVbzURphmova5CjyD5HNRJzAMfu9O4VQ
        hsQH39JtTbst5SmbVo1p/qJmuVB7kiHEG6G/EHYzFeBU+KIG392SrySu4hs6cizeliuAjy
        i7GzByEKPdHh3ZMWZcKXlZrIJepOJZQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-eNc8Ttw8PA-H-7GO4JUkhg-1; Fri, 28 Aug 2020 17:10:13 -0400
X-MC-Unique: eNc8Ttw8PA-H-7GO4JUkhg-1
Received: by mail-ed1-f69.google.com with SMTP id d23so813023edv.0
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 14:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TqwTtONj5KNOC/pnXhqbs+sbySt/5ow/XPS2c3mPNYg=;
        b=H94NPyVKEplku5JLXyii1BxMADAFPWo1VPss56OWxHsNDHeYZBQjLq5jZox4eERSHl
         kqiRqXTu5aljVoXJnfjQ51hvKvthwUPWKsi/71klQRvjczfNR4vKbn0X+jVW1YpX2aSw
         UoccraAEdXFXoCQUtAh2VvgaBRR2yACoUjtnezvVylom/wP2rmb9Pdg5w7dMo51rPvG0
         gS/KmRwv9EkSaRbP4HPRbSo/aZyl+pf6jQyWLuTciOfi0H81yqD1PpYmyYdeBHAeISRq
         hDNIN6yIdACeytBcFoT8wxNqKMC/+nV++y/sN+7xMZF51USwMpUev+3UEgpeoeDCP5yT
         4gMA==
X-Gm-Message-State: AOAM5327gtRe+YMUnQkfXpKDl/hTrXNzZQ9klihaQ4aSeY62lk25s/8t
        x5aZeas4PfD5h/zX1cK0c+HxPR/myB99M5BH34Q9q2+WlGT9HxGNp+CN8r6oUwhiMmYZhi2SV8g
        RNiv42og4Al0i
X-Received: by 2002:a05:6402:d8:: with SMTP id i24mr691648edu.294.1598649012317;
        Fri, 28 Aug 2020 14:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmbKmlKE7UpE06nJ0b5dBXyOxC1WdWIIjyBaw5a/W8DPMDLZAjjh3y/1hPuUPPIWWdsBYG2w==
X-Received: by 2002:a05:6402:d8:: with SMTP id i24mr691629edu.294.1598649012008;
        Fri, 28 Aug 2020 14:10:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a18sm285837ejy.71.2020.08.28.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:10:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3BB97182B5E; Fri, 28 Aug 2020 23:10:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: implement bpf_prog_find_metadata
In-Reply-To: <20200828193603.335512-5-sdf@google.com>
References: <20200828193603.335512-1-sdf@google.com>
 <20200828193603.335512-5-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 Aug 2020 23:10:10 +0200
Message-ID: <874koma34d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> This is a low-level function (hence in bpf.c) to find out the metadata
> map id for the provided program fd.
> It will be used in the next commits from bpftool.
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: YiFei Zhu <zhuyifei1999@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/lib/bpf/bpf.c      | 74 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h      |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 76 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5f6c5676cc45..01c0ede1625d 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -885,3 +885,77 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>=20=20
>  	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
>  }
> +
> +int bpf_prog_find_metadata(int prog_fd)
> +{
> +	struct bpf_prog_info prog_info =3D {};
> +	struct bpf_map_info map_info;
> +	__u32 prog_info_len;
> +	__u32 map_info_len;
> +	int saved_errno;
> +	__u32 *map_ids;
> +	int nr_maps;
> +	int map_fd;
> +	int ret;
> +	int i;
> +
> +	prog_info_len =3D sizeof(prog_info);
> +
> +	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
> +	if (ret)
> +		return ret;
> +
> +	if (!prog_info.nr_map_ids)
> +		return -1;
> +
> +	map_ids =3D calloc(prog_info.nr_map_ids, sizeof(__u32));
> +	if (!map_ids)
> +		return -1;
> +
> +	nr_maps =3D prog_info.nr_map_ids;
> +	memset(&prog_info, 0, sizeof(prog_info));
> +	prog_info.nr_map_ids =3D nr_maps;
> +	prog_info.map_ids =3D ptr_to_u64(map_ids);
> +	prog_info_len =3D sizeof(prog_info);
> +
> +	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
> +	if (ret)
> +		goto free_map_ids;
> +
> +	ret =3D -1;
> +	for (i =3D 0; i < prog_info.nr_map_ids; i++) {
> +		map_fd =3D bpf_map_get_fd_by_id(map_ids[i]);
> +		if (map_fd < 0) {
> +			ret =3D -1;
> +			goto free_map_ids;
> +		}
> +
> +		memset(&map_info, 0, sizeof(map_info));
> +		map_info_len =3D sizeof(map_info);
> +		ret =3D bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
> +		saved_errno =3D errno;
> +		close(map_fd);
> +		errno =3D saved_errno;
> +		if (ret)
> +			goto free_map_ids;

If you get to this point on the last entry in the loop, ret will be 0,
and any of the continue statements below will end the loop, causing the
whole function to return 0. While this is not technically a valid ID, it
still seems odd that the function returns -1 on all error conditions
except this one.

Also, it would be good to be able to unambiguously distinguish between
"this program has no metadata associated" and "something went wrong
while querying the kernel for metadata (e.g., permission error)". So
something that amounts to a -ENOENT return; I guess turning all return
values into negative error codes would do that (and also do away with
the need for the saved_errno dance above), but id does clash a bit with
the convention in the rest of the file (where all the other functions
just return -1 and set errno)...

-Toke

