Return-Path: <bpf+bounces-56753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64408A9D5EA
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CB1927A93
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256B29614A;
	Fri, 25 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWBJbnrC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB23224AE1;
	Fri, 25 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621514; cv=none; b=TwtXeqYptP+1ld2pdoRuMY8E2qNmN4N5lxjH6IQNX7Gqexx+hAjpJ6QNXdZEbW7I2sCMm+g8pW1FUqONRAA9Etaa+2VYZ4ogB9DaKD9F6KIt5/ch5gqRyfFxlF+80bQOHZ1Z9CFYwwWsfSMHc+q88Dm8qjRj12NlrSagS6MwDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621514; c=relaxed/simple;
	bh=zNbdVDsWfFoqJaRDGsTJAkSBJEdBMH8ebC4YyJqLcaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2WYlZE+fQOUhD6MpiVHEe9/EAZTCMy7qxLYpL8eScsSlBLpDrlY0nGQaNwZhLvXsU0yVq28VmO7jE9o/xn0N2gBAaOQLq7t81wINDzp0R8P6yeeFROVLdgOKPwENM0vssk7z9Q0kGI+T/YhaFUMXfvcDwnpXwgODxX6WpYazds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWBJbnrC; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ff1e375a47so32165967b3.1;
        Fri, 25 Apr 2025 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745621512; x=1746226312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAdDz9du01ShWOGUuze7WbsCqL878Y5hXPeTjWvtcUc=;
        b=SWBJbnrC/gbPGvcMhKhYGbWZNIOM0dP0kSe5uGy8rvtnw5xWh/9ecm97Xz54KxAaVL
         9B1kzowp0HBK3S7EKDVChg3g5L7/NV2V6U5owYsQRcVPDVbkUFeBfYhCEgS1o1LwTd3g
         1eeBcgzYv2jpk/l49x/6bcN275skpzqbq494iP5TTPq0/2NMRRjQqQrAb/jX6okl5x7b
         tgBW+v31ejl+EDDKiScy/bKdQttvd4StIinuOMUCt8v7YscX2I5cCWR0fb1kL9x+Y9d4
         9Oo/4H6MsLS4TBsg3WHt2sH3TSGTVGUZ5iOFJgAbH1LMatrGNit/Mqkjofds3dmG4Z8N
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621512; x=1746226312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAdDz9du01ShWOGUuze7WbsCqL878Y5hXPeTjWvtcUc=;
        b=ve1sjexyjDZ8g5H5zLkf1S9urvzeuHJdvHMGd4LYJFXYKtx5HIDmoyTirM3CVthiez
         WtMky4tYmGaA9i2xrllDd37e4cU0QM+HaVpqs5Ho7eVAApHkTRQjDyFIaX2sD6Z0KpPt
         qJbeHCLYw1UkMkZWBq1XsZXodmJdIHo+WLIWsbRl8cYBU5GpLoVaYSdP23Mvy+S1oCNT
         6gZQlBoAB7UdICAzUUKanRd1vNjkbukWN+U2a5VEn1xNcaTqdPlrqb6inVWGvJbrL1WL
         WaE2ZU0bYNnqKRBrtvZ8b6t7QU9d+jQIzrLm/1nr5in2cgTN9M6Y2OWDykbMbaz3v03z
         sZBA==
X-Forwarded-Encrypted: i=1; AJvYcCWKhONhI7HvQoWDwNZZVafBs+SpOWOFSWiuGDNBWbTlJeQ6WeErZy/epEy3TM03YxbzCbcNIPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxXKwnTyry8RdN0R0zs0RlFYpSBgjpt3xLG63lLhu1U/n94rJ
	fO5MarsXSzQccoKyxQuO+gHOHQTxHSuMvDojbk7eZUNogyb4BNLTU7W9+ceH0unRF76SVtmOu1B
	tJ7rzkN1QdIDtRFkWu9hbxzqEBVI=
X-Gm-Gg: ASbGncvDpwAyIShOsxzwGefmfJ0fHe1tvxTSvv6kYiNCcaBFTnP1HpWwutkKgO3s+M3
	mtrnDvvva9Ge/RYyFc/ZkLq8cGThrceRp4plpF5BCkMZcBAQ0gmAO1OrtTcBTbKp9kbANNThrOX
	PjlbtRZmrr9V4stsZp65VRw/ZfgVYPGM9k
X-Google-Smtp-Source: AGHT+IFb6I3oavfH8W4C56IT9mNhcdJn42p9aE8Rfs4y4LEOY3oGR6LCE8CLwcCnr8BIYbE6f60uFcmXnCSJuKwERNM=
X-Received: by 2002:a05:690c:3703:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-7085f0633c0mr20507937b3.1.1745621511622; Fri, 25 Apr 2025
 15:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <20250425214039.2919818-3-ameryhung@gmail.com>
 <aAwI3k4FeJHmHFKv@slm.duckdns.org>
In-Reply-To: <aAwI3k4FeJHmHFKv@slm.duckdns.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 25 Apr 2025 15:51:40 -0700
X-Gm-Features: ATxdqUE9gXV19zrCeOTnVWkTIxtpFHG3KZZzpVe1cO513exJOqHJhroJUPMAGDI
Message-ID: <CAMB2axMQsFLO-85q2tRNE==s8t_Y3A2iPaGTm0=NkjJ4wz0X=g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] selftests/bpf: Test basic workflow of task
 local data
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:12=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Apr 25, 2025 at 02:40:34PM -0700, Amery Hung wrote:
> ...
> > +bpf_tld_key_type_var("test_basic_value3", int, value3);
> > +bpf_tld_key_type_var("test_basic_value4", struct test_struct, value4);
>
> I think it'd be fine to always require key string.
>
> > diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data_bas=
ic.c b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
> > new file mode 100644
> > index 000000000000..345d7c6e37de
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
> ...
> > +     bpf_tld_init_var(&tld, test_basic_value3);
> > +     bpf_tld_init_var(&tld, test_basic_value4);
>
> Would it make more sense to make the second parameter to be a string? The
> key names may contain tokens that are special to C and it becomes odd to
> escape naked strings.
>

Totally makes sense. I will only keep bpf_tld_key_type_var() that
requires a key string in the declaration.

I will also add the key string as the third argument to
bpf_tld_init_var() and rename it to bpf_tld_fetch_key(). I don't think
the symbol type argument that refers to one of the members of struct
task_local_data_offsets can be removed.

So it becomes:

bpf_tld_fetch_key(&tld, test_basic_value3, "something.test_basic_value3");

Later, bpf programs still do:

bpf_tld_lookup(&tls, test_basic_value3);

> Thanks.
>
> --
> tejun

