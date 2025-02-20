Return-Path: <bpf+bounces-52009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D437A3CDFF
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E17117A7E6
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07223A0;
	Thu, 20 Feb 2025 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLiZrsa4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200636B;
	Thu, 20 Feb 2025 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009959; cv=none; b=PJqBnvnV9kSA4pu9k6hbrbBsxr02HJan2BWmzbZQusEzv4HS9E+IZibMW6aJGZ3Lvt3qN0+Q7izfq8WzH5s9AH34hfKBHzUELvWKIbDRAW6Z+5SAzcHg7J3aSIaUk87kibSm2TvSGxlZzC5icDTT4GZgI6AgBcSBDTa5WQeXfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009959; c=relaxed/simple;
	bh=GvlkiejnY1IbVPFVnvsT5ANQLUweKyrSCXZd2DegGos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJp/jM5z5u/kLo+i3/Vh2kiq7r54+LOvNlLhQCU5AypR1CjMfurv6jItQp2RvC2kp6nRZE8V6evhwTbtYxMOUMGWvhPAb//zrDw6wPkoAsUsoRxVMAHj8AkqetiNbvedeH8TO2+Cm1M9e1+Jri1niNgXP8bg7cvr/08yyrIVyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLiZrsa4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-84a012f7232so45703839f.0;
        Wed, 19 Feb 2025 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009957; x=1740614757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZyBvGX+Fxc2+2++nM3FlpG422+YGWcgDgREgyUJHoQ=;
        b=TLiZrsa4zBkAl+Lc1HkczQNXGbHgLXQMYQY+MmIt3QrBew0ef2CmN0e7y9xhjQEbTQ
         7H1NAmVI9vaaGE83xiitrjzHNAWe3L2akGK2WW9phZYy0tL0TQvEUS6iHYgUPEwOKUqY
         hCGb4wAeK1glUMi6Ykt+1LxxIgpb3wdLp3YdVV8sZiEIE2yuSy4yi3U1jtNgUhfp4ChH
         tRAu5FmdO8DiCLzFctHlvOgCz11zvIehY91B+6HUyJe24iAoXGPLFWr2gYN74jwIQZU6
         khQxMFuNHwXCFAh/iA2qV7FzUKKAxEw6+nnA7lrfIy9L53KnUDOR1xagLFwXdinw4fip
         jH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009957; x=1740614757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZyBvGX+Fxc2+2++nM3FlpG422+YGWcgDgREgyUJHoQ=;
        b=MakIN5I+b0qtuo3w0x/aqFRv3Y6gq42V1oijkKXSl0VUlmSS/SoUIpxn4RwDBs1FpL
         fzmEH4xlm7QC0OHuaKI0lvqEWnDHdFT0OX9XX37ReNumgDiwdSHlUGcSeC8BZYKea1nC
         EAYYKkqO9Bq5RpO/yxu5nKuBSz0B2BGuNztXfZUrV2BQ4zOqa5qfthx2NCrlKsuMHpNl
         qDPwluwU04O58uuugWZwS+srQNliuSkYgWfrC0uD3CMq6ldLC3489hq9tTrS2cxypsc4
         6v4BVxdXWq9yULopb2VMwZClGpn3IydVu8BieUdialNArDWjbo+dJRDJy037M35yVZaM
         27Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUDhGF/Io8BA3C0CpLbPHM4C6ivU0iUwWu6nlSatK+fw9PDAyERepeLUTJhXAHg/nAvAOU=@vger.kernel.org, AJvYcCUIkbjW6bgmEPtsbogHd7wbHmpKJlFQEHIIYdXh6tlm91T4WJ619Lz/D+u6krulV9ie3q4KwlsK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8N6ixZ0Z6MT5JYGYMLdHkm0EXfv1QxabG6FpycRn6PWvACL9
	2uPTYDIRI7ySC/LiZymRcNY/ogrN+SV8NyVrWQqm3TtYp9Wx9KQAwQC49Kf/GtcXAStVr9/eEtP
	LN9QxlzwAyC2t869hNa89PoZmt28=
X-Gm-Gg: ASbGnct+6N++Bob8Vi/c7oSJt4ELQx9yi4oShkDQJUThxUiJIUxSu9V41UVrCp6GdCI
	6aOh06XoFNGH0450i741xV3UcxGvw0XlLxvvWqbQRs5j/K/59rYeQN1R1CuOJWBNZjXsrTzk=
X-Google-Smtp-Source: AGHT+IFCEvn/rMVlTewJTitX06Qt2DvxVvXTTWfcqlAdgTOdtN2+vvo3KCKNokpDMQbLHNdc9tW02wmKbjcQmKFpl9Q=
X-Received: by 2002:a05:6e02:388a:b0:3cf:c7bc:4523 with SMTP id
 e9e14a558f8ab-3d2c019994fmr13998615ab.6.1740009956916; Wed, 19 Feb 2025
 16:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com> <CAL+tcoBtd1V-dP_ShDNOVKTyfPvcaLy9ZHz2aEDZr5vOpgwdjA@mail.gmail.com>
 <24e9b1d8-ed6c-4053-8d27-185bcb840f87@linux.dev>
In-Reply-To: <24e9b1d8-ed6c-4053-8d27-185bcb840f87@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 08:05:19 +0800
X-Gm-Features: AWEUYZmsblFsdvKJvOrolK7wvJhRxGYQEicDu4DCQsCimqJ5qXDtFOEPLjuuF40
Message-ID: <CAL+tcoA8R8p28fwtxZx_few+iywY8myEX41ft1+5-FjjQ0DGFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:48=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/18/25 11:03 PM, Jason Xing wrote:
> > On Tue, Feb 18, 2025 at 1:02=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> >> added to bpf_get/setsockopt. The later patches will implement the
> >> BPF networking timestamping. The BPF program will use
> >> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> >> enable the BPF networking timestamping on a socket.
> >>
> >> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> >> ---
> >>   include/net/sock.h             |  3 +++
> >>   include/uapi/linux/bpf.h       |  8 ++++++++
> >>   net/core/filter.c              | 23 +++++++++++++++++++++++
> >>   tools/include/uapi/linux/bpf.h |  1 +
> >>   4 files changed, 35 insertions(+)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 8036b3b79cd8..7916982343c6 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -303,6 +303,7 @@ struct sk_filter;
> >>     *    @sk_stamp: time stamp of last packet received
> >>     *    @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architec=
tures only
> >>     *    @sk_tsflags: SO_TIMESTAMPING flags
> >> +  *    @sk_bpf_cb_flags: used in bpf_setsockopt()
> >>     *    @sk_use_task_frag: allow sk_page_frag() to use current->task_=
frag.
> >>     *                       Sockets that can be used under memory recl=
aim should
> >>     *                       set this to false.
> >> @@ -445,6 +446,8 @@ struct sock {
> >>          u32                     sk_reserved_mem;
> >>          int                     sk_forward_alloc;
> >>          u32                     sk_tsflags;
> >> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG)=
)
> >> +       u32                     sk_bpf_cb_flags;
> >>          __cacheline_group_end(sock_write_rxtx);
> >>
> >>          __cacheline_group_begin(sock_write_tx);
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index fff6cdb8d11a..fa666d51dffe 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -6916,6 +6916,13 @@ enum {
> >>          BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> >>   };
> >>
> >> +/* Definitions for bpf_sk_cb_flags */
> >
> > nit: s/bpf_sk_cb_flags/sk_bpf_cb_flags
> >
> > I will correct it.
> >
> >> +enum {
> >> +       SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> >> +       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING=
 - 1) |
> >> +                                          SK_BPF_CB_TX_TIMESTAMPING
> >> +};
> >
> > Martin, I would like to know if it's necessary to update the above new
> > enum in tools/include/uapi/linux/bpf.h as well?
>
> Yes, the tools/include/uapi/linux/bpf.h should be updated. If you diff th=
em, two
> of them should be exactly the same. This patch should do the same to keep=
 the
> tools bpf.h up-to-date.
>
> For other headers in tools/include/uapi, I guess it depends. e.g. the tcp=
.h in
> your another RTO patch, the two tcp.h files are very different already an=
d the
> selftest does not need the new macro either.

I learned. Thanks.

