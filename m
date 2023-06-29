Return-Path: <bpf+bounces-3753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DB742F23
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 22:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AA11C20B5A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA272FBFA;
	Thu, 29 Jun 2023 20:57:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC3848A
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 20:57:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F411F
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688072230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdKAVBvrdTlXSRJ5Gzip6C4quTmo3/FhLIwtVCecIjM=;
	b=U07dS7ydzzmbLZSr+jZ/2ndpdb3q0RrXTi3nmlNj9BDvF8sg2MhN7q9rHeHoiXkr7iluT0
	sY7Kk1TIuOzFl9eU0Lw2MSI/qRtbbVBA0Gj9pnhDQ4Yadd3ZxJRo1GMkZxIcuhHoEpzITK
	hK84U0S7j/X4dPQ9fr/KscU0jTF3/5k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-VLK3R31rOwSJCTFz1zdoqQ-1; Thu, 29 Jun 2023 16:57:08 -0400
X-MC-Unique: VLK3R31rOwSJCTFz1zdoqQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so85300966b.2
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072227; x=1690664227;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdKAVBvrdTlXSRJ5Gzip6C4quTmo3/FhLIwtVCecIjM=;
        b=FplkcSi2SgkTwsEcRMcT/TQigi1vA553ZO0AH+lAEZ1iE+am6By+/2ytYPxPqbUpFF
         gVPrLBVsOZfABlKgWEBLmadboMeIKXE8IM6eeQnlxrLgO936L6WMr9IcSGughxiUlunT
         l0q5asjT4KvDZmTQZc3IqsxfXI1DuHnRQkzuTIYPS1K1UXVgCXBt9Ip9E6sM5sXCgXvR
         02Qr9Jjnk9Fv7hdLMyYqplCM2B+xNDZ6OT0MeQCiFP0wVCo7PqyzFoSB5RGuRQhONaWa
         uJojZJqsURC55BaybdzYKTBTXcozcgOaNtwU62R/VFxdySFT+auKB6zsTZKPzTXyxtFf
         SDyQ==
X-Gm-Message-State: ABy/qLanUHnDlis1BJTK9OxAt5Tk2KUk7DJ1T26g0tyVLrFCxpErzhMy
	V/3+G2Y3XPO33V+Y+KJXKsEoHyu1L+4GW9wCsr6WVnOVRvZcATaSsYSYfu6wMrmJo0XeCDZg6z7
	aPYNNYAuydr/z
X-Received: by 2002:a17:906:4d46:b0:992:48b7:99e1 with SMTP id b6-20020a1709064d4600b0099248b799e1mr368072ejv.47.1688072227714;
        Thu, 29 Jun 2023 13:57:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhd4w0+lvCVJ0pwJ2Ij4PVBzkjDwTpI3LE28LuFoCOb5qTNE9/3xsvxzDo+KQ4/O1RTsTjvg==
X-Received: by 2002:a17:906:4d46:b0:992:48b7:99e1 with SMTP id b6-20020a1709064d4600b0099248b799e1mr368055ejv.47.1688072227141;
        Thu, 29 Jun 2023 13:57:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b009888aa1da11sm7165217ejb.188.2023.06.29.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:57:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA3A7BC04EB; Thu, 29 Jun 2023 22:57:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <ZJ3pgau3icByxQxE@boxer>
References: <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk> <ZJx9WkB/dfB5EFjE@boxer> <87edlvgv1t.fsf@toke.dk>
 <ZJ3pgau3icByxQxE@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 22:57:05 +0200
Message-ID: <87zg4idm1q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Wed, Jun 28, 2023 at 11:02:06PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> > index a4270fafdf11..b24244f768e3 100644
>> > --- a/net/core/netdev-genl.c
>> > +++ b/net/core/netdev-genl.c
>> > @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct=
 sk_buff *rsp,
>> >  		return -EMSGSIZE;
>> >=20=20
>> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
>> > +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
>> > +			netdev->xdp_zc_max_segs) ||
>>=20
>> Should this be omitted if the driver doesn't support zero-copy at all?
>
> This is now set independently when allocing net_device struct, so this can
> be read without issues. Furthermore this value should not be used to find
> out if underlying driver supports ZC or not - let us keep using
> xdp_features for that.
>
> Does it make sense?

Yes, I agree we shouldn't use this field for that. However, I am not
sure I trust all userspace applications to get that right, so I fear
some will end up looking at the field even when the flag is not set,
which will lead to confused users. So why not just omit the property
entirely when the flag is not set? :)

-Toke


