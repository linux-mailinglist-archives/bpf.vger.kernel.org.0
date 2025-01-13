Return-Path: <bpf+bounces-48662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BEA0AE19
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 05:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45601166312
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 04:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CA14A4C7;
	Mon, 13 Jan 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdu8Kb89"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69398248C;
	Mon, 13 Jan 2025 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741302; cv=none; b=RVd0LplQKvRvRZGdr/aj1ibq+sVSsjNhDEm5sUrDE5aK1aEKY/pbxGotBLHDT3Fio2fc0t8CGBg8wJT6y9OlJ6ExOQu04kmtSvOVN6pYHE8/1ENMGU2MKGUTZbCXpmm6Kb86lzNf6e4PM6VTlTazkX8lgGxHJnSdp/I95MhBsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741302; c=relaxed/simple;
	bh=0Uz4yQG4wZ+nbc6zM7VzZVDYDJ+2olnmJX/iIu+0dXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKKRuk6JfI2PO1L45yYx+i8RK+wjID12YKgsp3nLWpNcEsUbjOqKwateKDSouAoQ0FNfVxMY7yActctlsnJ4wz2blLmAHGOWDQPZNW0WYBlFjuTEgHM+jCUB9aAJTHxzHwyf+/H/JxLtHHYDJlMT7Uqa9AZpI+MxEXQmreJY3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdu8Kb89; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166f1e589cso79154505ad.3;
        Sun, 12 Jan 2025 20:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736741300; x=1737346100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O61dNdsPd81LhYeEXdbyMEZmy6qvkd3iBvbUJscPe5A=;
        b=fdu8Kb89XMTXTNsa+EgfCmnaPsj5aegW9O7Dw5Dvo0X/IlDJwt7mfVShZcuG0pQJKj
         zFMy4NJM9YWy7Js9Y1yoU48iZSgSMB8UsLrS57Cl7hV6ZRBtKe8W3s6mIv6BGGBJiFsV
         iiUqM/jvbiUixp6vdyUu0aGjxD1RwqC1DK4EannHQbpbK2R2+Cja4dZ2y7yVSx+a+A0r
         cywx2qIocZFfMAifosi97aKleJ+pozD0qlx2727cpzrPnmcrrfbioTQVvEy4TBUa1ebV
         jmsQf7+yLdlaFij5eaBn2PJVVWfvAODv8xEbC1o7eKt95BkpF9TVxCWKZwv2aqJ199pl
         wmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736741300; x=1737346100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O61dNdsPd81LhYeEXdbyMEZmy6qvkd3iBvbUJscPe5A=;
        b=ITRYQjlEk7Z3/KxPkCr+AA8ZCMzwwkGIgvrjjawhNvyRnG0iGH/RO+TVB0PiUJNULF
         7P+BvSNWUujmuDC1C07cbLMt9BXaKbtvpYUnCNX+j0hL7gpClAA0Jq4SgaPlS84SNmMv
         mVov9GPImOYAxIWmAUlYC0TJAW/NQAo3abuRgtJZ9MzT6GldKKfMVj+OpJ5dSrfsdBcD
         lYERw1J71ZYGj7v6LB7n5lnXYBBMwWmMQmZnvNPFFn+afdGA1JnDayUKsdT59qLaXY3W
         aaNYVqHmZS/AkxU4xzSBvk38FHFN1c4+FhXPeQrRGXMeyNrzFZkEOLjRYjipkGWUn2Ui
         Eieg==
X-Forwarded-Encrypted: i=1; AJvYcCUZoE4Al09EMHlFQobv87Asng93vkebeEji4NjG/uGe40bFxIdvvr1/p0dhMe3n4jj6gukZOj2GQZZTQ8I=@vger.kernel.org, AJvYcCUoYL8BNh3Ea4iNgLFTgSxzs/yYh6IxP56Q0zvUZgLt8eSRS09+/vww0meCCxno1sLMfl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDp3bTlmISLzpIUi+YR9Gb8s2lYTFAjEON3BCVOqsYsCjrqyw
	jiam4paSRDPzVh05wu85pbn36T+FyBkxqtnmIWiUMr7Ai/QEpSnP3pJIGwYu
X-Gm-Gg: ASbGncuKNpf0xlWUGjITvEXlrdCcxct31tma2MDYV5b2gGfeaJ/FhNEI6yrhmnCdZED
	xwZNlHkGGmcJ9NGyqMXGZKcvMv0RX/mgIy3YyGu12cecinmaJXzvDuGBaZvHV2QH7TsqHhdy0z7
	Eu93yxR5VR5ooBq4x5Dv0AHnyCtBcc7FanpSEi/6oODUHGHKttPzVHSd6rCI2V6n0iYa91jnao1
	jtohwASqQM9FJARHQZlDl4eYtca/0Tjt9la7p5Rixa1M6fLrE89Ww==
X-Google-Smtp-Source: AGHT+IGmhet9oAIKMSii4iwHB7ez148VxH6bFDTlFPTXroqUm58h35zj33g7DHxfZ4p9oOsfx7TJvw==
X-Received: by 2002:a17:902:d4cd:b0:215:6f9b:e447 with SMTP id d9443c01a7336-21a83f665d4mr281988345ad.30.1736741299933;
        Sun, 12 Jan 2025 20:08:19 -0800 (PST)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:ffaa:4903])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0b9sm44731935ad.44.2025.01.12.20.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 20:08:19 -0800 (PST)
Date: Mon, 13 Jan 2025 12:08:14 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
Message-ID: <Z4SRrrXeoZ2MwH96@fedora>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
 <20250107120417.1237392-9-tom.leiming@gmail.com>
 <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>

Hello Alexei,

Thanks for your comments!

On Thu, Jan 09, 2025 at 05:43:12PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 7, 2025 at 4:08 AM Ming Lei <tom.leiming@gmail.com> wrote:
> > +
> > +/* Return true if io cmd is queued, otherwise forward it to userspace */
> > +bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
> > +                         queue_io_cmd_t cb)
> > +{
> > +       ublk_bpf_return_t ret;
> > +       struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > +       struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> > +       struct ublk_bpf_io *bpf_io = &data->bpf_data;
> > +       const unsigned long total = iod->nr_sectors << 9;
> > +       unsigned int done = 0;
> > +       bool res = true;
> > +       int err;
> > +
> > +       if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
> > +               ublk_bpf_prep_io(bpf_io, iod);
> > +
> > +       do {
> > +               enum ublk_bpf_disposition rc;
> > +               unsigned int bytes;
> > +
> > +               ret = cb(bpf_io, done);
> 
> High level observation...
> I suspect forcing all sturct_ops callbacks to have only these
> two arguments and packing args into ublk_bpf_io
> will be limiting in the long term.

There are three callbacks defined, and only the two with same type for
queuing io commands are covered in this function.

But yes, callback type belongs to API, which should be designed
carefully, and I will think about further.

> 
> And this part of api would need to be redesigned,
> but since it's not an uapi... not a big deal.
> 
> > +               rc = ublk_bpf_get_disposition(ret);
> > +
> > +               if (rc == UBLK_BPF_IO_QUEUED)
> > +                       goto exit;
> > +
> > +               if (rc == UBLK_BPF_IO_REDIRECT)
> > +                       break;
> 
> Same point about return value processing...
> Each struct_ops callback could have had its own meaning
> of retvals.
> I suspect it would have been more flexible and more powerful
> this way.

Yeah, I agree, just the 3rd callback of release_io_cmd_t isn't covered
in this function.

> 
> Other than that bpf plumbing looks good.
> 
> There is an issue with leaking allocated memory in bpf_aio_alloc kfunc
> (it probably should be KF_ACQUIRE)

It is one problem which troubles me too:

- another callback of struct_ops/bpf_aio_complete_cb is guaranteed to be
called after the 'struct bpf_aio' instance is submitted via kfunc
bpf_aio_submit(), and it is supposed to be freed from
struct_ops/bpf_aio_complete_cb

- but the following verifier failure is triggered if bpf_aio_alloc and
bpf_aio_release are marked as KF_ACQUIRE & KF_RELEASE.

```
libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
Global function ublk_loop_comp_cb() doesn't return scalar. Only those are supported.
```

Here 'struct bpf_aio' instance isn't stored in map, and it is provided
from struct_ops callback(bpf_aio_complete_cb), I appreciate you may share
any idea about how to let KF_ACQUIRE/KF_RELEASE cover the usage here.

> and a few other things, but before doing any in depth review
> from bpf pov I'd like to hear what block folks think.

Me too, look forward to comments from our block guys.

> 
> Motivation looks useful,
> but the claim of performance gains without performance numbers
> is a leap of faith.

Follows some data:

1) ublk-null bpf vs. ublk-null with bpf

- 1.97M IOPS vs. 3.7M IOPS  

- setup ublk-null

	cd tools/testing/selftests/ublk
	./ublk_bpf add -t null -q 2

- setup ublk-null wit bpf

	cd tools/testing/selftests/ublk
	./ublk_bpf reg -t null ./ublk_null.bpf.o
	./ublk_bpf add -t null -q 2 --bpf_prog 0

- run  `fio/t/io_uring -p 0 /dev/ublkb0`

2) ublk-loop

The built-in utility of `ublk_bpf` only supports bpf io handling, but compared
with ublksrv, the improvement isn't so big, still with ~10%. One reason
is that bpf aio is just started, not optimized, in theory:

- it saves one kernel-user context switch
- save one time of user-kernel IO buffer copy
- much less io handling code footprint compared with userspace io handling

The improvement is supposed to be big especially in big chunk size
IO workload.


Thanks,
Ming

