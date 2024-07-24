Return-Path: <bpf+bounces-35546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAF993B679
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6826283358
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3815F316;
	Wed, 24 Jul 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QycMUXg2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451D155A24
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844704; cv=none; b=AuDUVZEw5TOBF0GW9Yjl1C2AzyhtvY2Gykokyr3sENi67FNVu6Yca8jBFKj6Cl4uUWNgJZhVObylMOo+uCFCWXByZvd7IrQP+fuBzBMU36wYh/EYHXqdRzwDEWX/GvH32VU1ofe/2DOHpesdFyxYumLlKzxm+7MQtC20bB2EKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844704; c=relaxed/simple;
	bh=9NITEOeRO29hYYiGUAA/AELcGyNRsTVa+djSoTloFU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSm4vKGhCv0reM45HKAhWxKnoL7qwaYb4oa1zqjYaLebTl2Cuq8eDfY8Zb9HZFytEWTX32d5yraZkPqMuN9rD/BslwuzRE2BDsehajJ/TqylwSya/hpyJNQw0zWa6xR6aEKpM4IvG5yp8kbLFHCswsPafAyBXwSzD3CZWYvugvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QycMUXg2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso91658a91.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721844703; x=1722449503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB4Yfqr9oH1bRjGjHR2TLStJhto9cprJeX8TX1htzq0=;
        b=QycMUXg2aL3rVJkpgtefyIMFYj7ERqVQpqiGMQd8b4rvA/DX6yEN8DfaewlU2uMt0I
         AWmdVlvU8xvSTRx3DWrdEi/S1Vso0RqhmAQim+iaB+Yjy3B56/5O/iXNWG19JY0o2zfV
         Cz79AQJNliV+IuOaCk7R/Nq/h9sF9mMY8DjcTGJUVnm+MdzBKvK7ByzPCGfDX8YmD9ke
         QtL6ll5r7vOxX9YujLBq0f1oj1acxvXRawcJ2LorXQ66OUfPUJW4iWD32dEiiALkZJrZ
         tXSl8IZVcS3YCLGsxU0XFxh5+7vfO+criXeEqQbzuYzTUDLfkXzPuL/kldF2CGtvKxTn
         /o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844703; x=1722449503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lB4Yfqr9oH1bRjGjHR2TLStJhto9cprJeX8TX1htzq0=;
        b=czFLSeHta/AKLccMZpdlRV+K2qnMKk+SRr2GYAvGG+BxsOFXc76o5SGv+6CBBHRrsc
         +qAiiOodmDRIfXkZ/TR/Rww2Pto8FqHliUmJFBNLxPa3QyPIOhHb72I7Zozb00rk83VU
         C94RdNOjjKa/iH7+JmSDWRdbiHNoj1SR4lAZtQJwoGav2DylO1ZDewniYDW3QlG00/OU
         OEUDQvlA5/PxvmlkL61/pBaIA0xv9ftAxqolhnzGmRfCcCM2iZISYhzOL8MLgMlRTAyb
         9nZ3cbVhxh3GVmXGFYOfD+1qYK/fOC5/TV0+y55zsWJj1RrkOFL+unrZT19e3KsOhWpI
         M5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0cdJydAU/GRDUtdjqHCvpvApLt/Q6rpBIPM6IQOjhiyJaHuF4M85TS+7NqDTsDxP8G2cXaLbc/cD1d9laC7VTUFyp
X-Gm-Message-State: AOJu0YxTgO6h0KDirfqlrdm7gfsmMWENwMvbCyVeHV7lK8FruFIOFvI9
	2X8GepYrV4cOOpFycJIfwu45pv0lhex0Q8jAVGAsRL+iOLPCyauw1c7paLwBHXi07PUyRfJQc1g
	eOUIp+gnf85iW9p6hjnUX5sfachc=
X-Google-Smtp-Source: AGHT+IHgOJjnzC0OgjCvPZQdmnIgAbfuvPPnjsjfbVHPm9xcZ+Rlt+TEfze6d0c4oXuXrfLj/aZpa4g/OM9O9thNVEs=
X-Received: by 2002:a17:90b:3e8b:b0:2c8:538d:95b7 with SMTP id
 98e67ed59e1d1-2cf238ccb87mr351178a91.32.1721844702614; Wed, 24 Jul 2024
 11:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-4-thinker.li@gmail.com> <14043bdeb2621f6f283fbe59eff0084bbf8179fa.camel@kernel.org>
 <134682b6-2be8-4757-9852-ecbfb3e3b79a@gmail.com>
In-Reply-To: <134682b6-2be8-4757-9852-ecbfb3e3b79a@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 11:11:30 -0700
Message-ID: <CAEf4BzYy+RRnPqYQ7Bf+wi1YsZ7fzTQ=bQGDmn34T1kLbBXxEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Monitor traffic for sockmap_listen.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, sdf@fomichev.me, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:24=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 7/24/24 02:32, Geliang Tang wrote:
> > On Tue, 2024-07-23 at 11:24 -0700, Kui-Feng Lee wrote:
> >> Enable traffic monitor for each subtest of sockmap_listen.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> >> b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> >> index e91b59366030..62683ccb6d56 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> >> @@ -28,6 +28,7 @@
> >>   #include "test_sockmap_listen.skel.h"
> >>
> >>   #include "sockmap_helpers.h"
> >> +#include "network_helpers.h"
> >>
> >>   static void test_insert_invalid(struct test_sockmap_listen *skel
> >> __always_unused,
> >>                              int family, int sotype, int mapfd)
> >> @@ -1893,14 +1894,21 @@ static void test_udp_unix_redir(struct
> >> test_sockmap_listen *skel, struct bpf_map
> >>   {
> >>      const char *family_name, *map_name;
> >>      char s[MAX_TEST_NAME];
> >> +    struct tmonitor_ctx *tmon;
> >>
> >>      family_name =3D family_str(family);
> >>      map_name =3D map_type_str(map);
> >>      snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
> >> __func__);
> >>      if (!test__start_subtest(s))
> >>              return;
> >> +
> >> +    tmon =3D traffic_monitor_start(NULL);
> >> +    ASSERT_TRUE(tmon, "traffic_monitor_start");
> >
> > Using ASSERT_TRUE() on a pointer is a bit strange, it's better to use
> > ASSERT_NEQ(NULL) like patch 2.
>
> Sure!

we have ASSERT_OK_PTR() for pointers

>
> >
> >> +
> >>      inet_unix_skb_redir_to_connected(skel, map, family);
> >>      unix_inet_skb_redir_to_connected(skel, map, family);
> >> +
> >> +    traffic_monitor_stop(tmon);
> >>   }
> >>
> >>   static void run_tests(struct test_sockmap_listen *skel, struct
> >> bpf_map *map,
> >

