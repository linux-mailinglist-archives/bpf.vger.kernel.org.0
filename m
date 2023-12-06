Return-Path: <bpf+bounces-16909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A04807765
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B6281EEF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE676E5AB;
	Wed,  6 Dec 2023 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoiNalCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40014D44
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:17:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1d6f4a0958so229556966b.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701886666; x=1702491466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijBuMUmdUDLrGFS1qQY6dr4cHoc2hAbGn3MRZrZG19g=;
        b=ZoiNalCRI539vhFj4ExU4WWdJiQzJouSr0dxWI5PwBMUItwE3zRimA87cqW0J0/5AV
         Y5pYZFM1qU/o+CwPlxobLI27qENN4kqpjV4rlfse9dVWfAPLQM6UPmDHnuPNs/twCcWR
         SPqn9xru1TDdaOwsrT5u7Ycw31WZrq+dyq/Ecw9O2wNghcGFDeCsj3lboIu6Iu9LkYv9
         gyRyEb3FErOXOF3MJgqMI3K/yDAmVjnVoLXVyO/poPAZHKIALbKM1+gsgQAK1qIDIViT
         zht6SuPQnelCql8TeESyqId3GPMWzHUkVDpyhueZW4+DM2mwFH4UpFFFCJ0rr0vITuZI
         sASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886666; x=1702491466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijBuMUmdUDLrGFS1qQY6dr4cHoc2hAbGn3MRZrZG19g=;
        b=bWY5wOpk85yB6bp8aR3QUrpZREUwEm+6Pp3r43KuRop/uwZAl6+lzyQXYVYYZydyVx
         rsVyPvlWdic+BftcoBBBuBuOeAoNCHbXM1rCz0OqiRJFIIwZuPlVuKp6GSczrcvow11H
         3lFjOqIksqUpLTh6KEQe6wVkcAwVhunbA38/mCnQTmu0iNoGMBBC44z4y+rcYLc3iB9Q
         tIDu+dzvZb53/6IpccBwafK7r88YT+wJEM5CH49A5W9QS658Q4QOUC1T/K78cON4cQXA
         liq7JOT/cE1RNTwKgnMuL5U23SWYP4WWrnpxi8+1pz5W42wNtgW+/rhj0NzykUOVLeHG
         /R8A==
X-Gm-Message-State: AOJu0Yx09UD95fULYnWzIM6gZCZ99S3pshpq416W67Db4SEJCRV1lmKj
	zYYGzbmT0rGdG7TpDyOEDCUzA8/VImGKOGF9BY0=
X-Google-Smtp-Source: AGHT+IGNIOax6WGnwzEVfbPkIzwxSgh29p0hlyUtPKrJpXLbPbgPuG8pmTseTQRFACxvbusZ2w6JdDWOS0mTuehibBM=
X-Received: by 2002:a17:906:6b93:b0:a1d:b77e:12de with SMTP id
 l19-20020a1709066b9300b00a1db77e12demr1334304ejr.73.1701886665616; Wed, 06
 Dec 2023 10:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-12-andrii@kernel.org>
 <0f3d582a2ec646c36625325843aef301932d31b4.camel@gmail.com>
In-Reply-To: <0f3d582a2ec646c36625325843aef301932d31b4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 10:17:33 -0800
Message-ID: <CAEf4BzbROM6dLaKMarvAur5T=fbbn8r3cmo7gvXXwz9-imXxRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/13] bpf: add dynptr global subprog arg tag support
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> > Add ability to pass a pointer to dynptr for global functions by using
> > btf_decl_tag("arg:dynptr") tag hint. This allows to have global subprog=
s
> > that accept and work with generic dynptrs that are created by caller.
>
> Why is this preferable to a check that parameter's BTF type is
> STRUCT 'bpf_dynptr'?
>

For `struct bpf_dynptr *` I think it's acceptable to guess that it's a
CONST_PTR_TO_DYNPTR instead of requiring tagging, there is little
chance for user's application to have their own data struct called
bpf_dynptr. I can make a change to infer this from the type name then.


> [...]
>
>

