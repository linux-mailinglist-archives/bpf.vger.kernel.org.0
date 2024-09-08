Return-Path: <bpf+bounces-39204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382397093C
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838651C20E5B
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC717624F;
	Sun,  8 Sep 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbGviJRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905526281
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725820882; cv=none; b=TX3l6PTmhKoDE7umxrPFdkMFRGx3481qKRBCgjGYo03gIQGUdVXwwndd73oOznebQ1e+H6R2KTzE+CvUb9ua64yLq2MgZVw7qkLHVD4hI9iheNmM2r9W2rczqCABcgPTSAOige95IfckVTO1+0rDDgJ+j6UTzBF3buJfFBZ0/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725820882; c=relaxed/simple;
	bh=l3ByEftHhCbxweU0TTVrICzZR1Aci2uYbQdXS/CUaa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S5X4dFqjtpsspbNn46n6qZkQmJ1pQ82RP19UJyHA1ucmjUhUNCVnHbWNbSqiRl95WMs/287oSCpDx8ByJUk0d8jIeJihSJp5zC1MPvJWEt7CcNKlaNeP7Jnd0wTauB9Rh20pc04NgLvYNUQ0X92bDpd82AXDCVqLDhFlvW6uJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbGviJRo; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a8e305da0so3898055276.3
        for <bpf@vger.kernel.org>; Sun, 08 Sep 2024 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725820880; x=1726425680; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBQ7Pbvx+LcujbvVUbk/lB9kFOBJ6MldeIYBaFqODws=;
        b=NbGviJRonEoZSDPMggk2hwcR1THx7txkHV+A+qUwT8COPM3kPe9mlpVVrKb3XdE1ZD
         bqEZlG6hPQVYSWZNe6GdYJcvjzQNerV2y45rC4OoMleUGjFjjSQ+WrXSYqJRjfcjsftl
         6N/qYd3m4jYxwRDD0hNuuOaNzNRCi9QRsvzYDTYsqz+iUobfJERnY8VHOP/CA4rwp6mY
         q9AvtARnA3quFzKEUeOKlKzxX+8ql0DoSWLer5Q1yzA3ub1qBmMDX5bGqld0xfD6u1eP
         QiPvzwV+pl4tEVuIekzhruVo/wRLngoWgfohHPpVzfzyXuxaVhfyNLw4xTXVfyuu2sC0
         00Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725820880; x=1726425680;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBQ7Pbvx+LcujbvVUbk/lB9kFOBJ6MldeIYBaFqODws=;
        b=dzXjm9OdDSxXUv+Vs3BgON12IuJABFuQYu22DizVJbqc8R9r8BDb60su00erPWc3/7
         J6S8OA/xJZVC68JXCv8+CrgU47A4g6AhmxaJtwj/OOUZ8ZnXw/wWsWEXegKBsWFkiwtL
         OeZLtVy4Rdu0KoDEbTdT3AXxLE6KFFcl6M7A/z2SsVZ1EJZHdj5WQCrFIG7fG2M1FOyD
         BUcJ0nBv9XGjVA9JuOQRlMACev3BZTTGXKk6Bkn6NO06YmCUMLZNPWi0ae7Jmww4XgJc
         QKcxsimaK5N+1IPmZLClBINDS/VTWyTlGbdqh0zRhZYuJANO8Dr9+bYEf4t4c/Ygejot
         Jmkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9sag3wuO8w0zFPz/rjawg4lRWWTpVG7iMl1Z+r+CCKGddKHLMADDdnGBNIHm2dRT8dM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5grQ+P7d6qG1Z0s7v7NSBhR2C1cmZNdBfwSDVV5C+ApU0JJP6
	km2QVrRa8//qlDjA0E1b1IdXC1AXGY/ShFXjuLkoTo7Ce4ghQ7WTa/OrCmxrWIORKU5qKhyEqe0
	KX/ERzL+X0YIqVpVEh5ZvE2tlWiFtxQ==
X-Google-Smtp-Source: AGHT+IHtRrrHKYuULyBDBqHFjos1LGJbWW8cwSAG01FYidwrLQMWBvWOCjVqgZa/MP61jyj+clui/e8sAGXTPMFw1Ag=
X-Received: by 2002:a05:6902:2382:b0:e1d:33f1:cb91 with SMTP id
 3f1490d57ef6-e1d34a37ccfmr9460172276.39.1725820879946; Sun, 08 Sep 2024
 11:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxriS06VxYSaCoo0WT2LtUPPwXopyMHr=-FyR5qRoeGWguBZg@mail.gmail.com>
 <b9262f12-73e8-a090-1197-2cf380ba3cea@huaweicloud.com> <72cac21d-f973-a40c-35de-cc7942ecae06@huaweicloud.com>
 <CAK3+h2zrDfOdouk5_uPrM2iwbTkMg3DecKJ7ro037F2hdK26fg@mail.gmail.com>
In-Reply-To: <CAK3+h2zrDfOdouk5_uPrM2iwbTkMg3DecKJ7ro037F2hdK26fg@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 8 Sep 2024 11:41:08 -0700
Message-ID: <CAK3+h2xEJpfDm2=ucwm8FQ_A0v3NbOY4uER3jXHiygrmku+=7Q@mail.gmail.com>
Subject: Re: Using BPF_MAP_TYPE_LPM_TRIE for string matching
To: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 4:33=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> Hi Tao,
>
> Sorry to hijack this old email thread :)
>
> On Mon, Dec 25, 2023 at 5:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > On 12/25/2023 10:24 PM, Hou Tao wrote:
> > > Hi,
> > >
> > > On 12/22/2023 8:05 PM, Dominic wrote:
> > >> Can BPF_MAP_TYPE_LPM_TRIE be used for string matching? I tried it bu=
t
> > >> the matching doesn't work as expected.
> > > Yes. LPM_TRIE will work for string matching.  Did you setup the key s=
ize
> > > of the map and the prefixlen field of bpf_lpm_trie_key correctly ?
> > > Because the unit of key_size is in-bytes and it should be the maximal
> > > length of these strings, but the unit of prefixlen is in-bits and it =
is
> > > the length of string expressed in bits. And could you share the steps=
 on
> > > how you used it ?
> >
> > Forgot to mention the trick when using LPM_TRIE for string matching.
> > Because LPM_TRIE uses longest prefix matching to find the target
> > element, so using the string abcd as key to lookup LPM_TRIE will match
> > the string abc saved in LPM_TRIE and it is not we wanted. To fix that,
> > we need to add the terminated null byte of the string to the key, so th=
e
> > string abc\0 will not be the prefix of the string abcd\0. The code
> > snippet looks as follows.
> >
> > map_fd =3D bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, name,
> > sizeof(bpf_lpm_trie_key) + max_string_length + 1, value_size,
> > max_entries, &opts);
> >
> > key.prefixlen =3D (strlen(str) + 1) * 8;
> > memcpy(key.data, str, strlen(str) + 1);
> > bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
> >
>
> I have a use case where I want to run an XDP program to parse the DNS
> packet to get the query domain name, then lookup the domain name in
> bpf map to decide if the query is allowed or not. For example if the
> LPM_TRIE map is pre-populated with "example.com", then  queries like
> "foo.example.com", "bar.example.com" should be matched, right?
>
> I haven't gone that far yet because  I haven't got a string match in
> hash map working, but that LPM_TRIE map would be my end goal.
>
> Here is the hash map string not matching problem
> https://github.com/vincentmli/xdp-tools/issues/2,  am I missing
> something about string terminator '\0'?
>
Sorry for the noise, my hash string key inserted from user space
missed characters like  "wwwbpfirenet" should have been
"3www6bpfire3net"
>
> > >
> > >> Thanks & Regards,
> > >> Dominic
> > >>
> > >> .
> > >
> > > .
> >
> >

