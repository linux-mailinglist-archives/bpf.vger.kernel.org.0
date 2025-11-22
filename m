Return-Path: <bpf+bounces-75300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DDFC7D344
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D18B34E954
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B78086349;
	Sat, 22 Nov 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKg8toTO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E722A7F1
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826369; cv=none; b=GX5fL8QFts/p2fcganH6drb6kKEnv6e+zaeaDL5nQIkyMHGybzb4gLB24wjAVPGBqI7PlFDeg0cNPG9t3c/cDYSDasIUx2RNN9lEs0bkxdMST6qlsBXOXGzeO8lhaxgFTC5Z7yP46WgAqS9mPMoq2GAo0bYyay3UBRz2HDagv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826369; c=relaxed/simple;
	bh=At1b2JdqfPTHgw7UdLD2B7l0bJqGYP1HThbRO6dSdy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx7+osZsuCruMvd1ce+jIw+TbO79Gd1sx3nDe+6kja4UCufjxZSt7xsBVGDxJkKbq+l0lwPY9WRbd4t8q8ulfwj8vQ246KIeknYy0OCdSBjofq9kYIonjn3B6R/cmYL71GWXidFeVWV/CBcv3P7z9l48DrWBnbLC5qlpK5tvoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKg8toTO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b71397df721so535491566b.1
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763826365; x=1764431165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At1b2JdqfPTHgw7UdLD2B7l0bJqGYP1HThbRO6dSdy8=;
        b=dKg8toTO/P0bqZbFI3QPid7P6zP8W3+b1MtNlh1hc6un9gXONS3caXavkER6j6yG2v
         vOsYuH6NMPO96iMcozPjEJzyy/Af8HQ30xlWKCmoSTXAU+cz8TBgBpQjWCNiwG6TgCQv
         IC2wVjgCjy4eVFU5FpqTTiE+z4XGGjUPzVbASLp+qjeI51K7oIu0g765Via3qrp/lJu+
         qg+Jr4KqiJcWr53wXat5eOvYNf3G1j4u2BydABHGEmEwQRh6N42iXxOnhDHP44uNjqxk
         WDPHTIL+gwkV+LbH9uBVTnml2hUqKIrnRMozNSd7JAtx7h89CEfeQIpi6njthQ1zvVah
         lAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763826365; x=1764431165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=At1b2JdqfPTHgw7UdLD2B7l0bJqGYP1HThbRO6dSdy8=;
        b=hNj0f6HNeM95I967SxAyEzSyrHzBHFwblBH7UT2qB+2We+UrFBYQy2n5dnkwjF7WXX
         /EgtyoSST6AYODsbzrThu+vIHha6IKB5mbJz0BZTeWyuGg7j3rbUQB2b9g/XZK0SPTRV
         /ln0BOIa+pfnu0oLqMOYzDa80Q1ZACzmrDFxNA1yZUhdWKA9T0tt6sdsPSmXWxg4YVXw
         gmH5JLnTn09zhBcetBpWTOJaq0fCv/P40jEZC9FI9muMw0KSgJpWUhRRucYW5QFhlYR/
         LC4/yQRXAqWKZJe85I9WU1gNJpB7pT69J5pzhLPeEgPaXmvK2/XFvwIuMg8WIseCgFKE
         2Hwg==
X-Forwarded-Encrypted: i=1; AJvYcCVhL3olFocZMUHlJxcwlDk8aXE91XxuTyBBMIuwIx02OA6ytOfqxN1MernooQ2ihskhLk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PP/EmKqiN6S5KmuIoULXp8ockWYj/orm0yveV5vin8Fjvsj+
	+t+OA/jMVVxkLeJhpaN33dK1TPx0UpHyOAkDRZR3XPG56RijuaerkrtJMWtmzDPqTi/lEj2sqUM
	AsN0AHm5YlpygcJggBImEvVfN819f/E0=
X-Gm-Gg: ASbGncu1Z7P96Avr2cxutN8ZUH0FYINd/vrG6Mn0K3MEJIkxJ6nV/oZnKwhZwz6IeGY
	YuGx0Qxbq7m3liWFAiJxKYca0ldJkQYcgRB8p3SZyX+jot1FXFyxjIZMZ1m/slVMCtsY72FuOTH
	vmzdQLMK4UcAz8pBOZROHLwtavwgQOqfXjDp9Y7SpSfrPIHgisSbm1kJILCi+B4hovKkedWE+MV
	Qg0DMBtOAPJjOMYu0ggybBABmcM1V+EVF+coTEVLhPcW/MKYAhg4jBRYFSueehqukiWB1Ls
X-Google-Smtp-Source: AGHT+IE9r8plOm2flMa8pJAQZwneq6MTI7kmz2vdI4HE4qnfnDja77MqPuu7SWhonl9hNMtzupsnwrXMPJG/uwn0utU=
X-Received: by 2002:a17:906:fd8a:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b7671a47e67mr639693066b.60.1763826364566; Sat, 22 Nov 2025
 07:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
 <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com> <ce92f733d24bfad103a9abcc209f411398e23332.camel@gmail.com>
In-Reply-To: <ce92f733d24bfad103a9abcc209f411398e23332.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 22 Nov 2025 23:45:52 +0800
X-Gm-Features: AWmQ_bleb4Gp11pn8wwgmS5twNuq6h_U5Tw1NNVWEhhrZWvpJilcXlcrpXIsG2w
Message-ID: <CAErzpmv-CQy42LMFR4hzD4ANqL4ENnWyb0uKr7_FH1fj98S2QA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 5:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2025-11-22 at 00:50 -0800, Eduard Zingerman wrote:
>
> [...]
>
> > > Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=
=E2=80=99t use
> > > btf_find_by_name_kind here because the search scope differs. For
> > > a module BTF, find_btf_percpu_datasec only searches within the
> > > module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
> > > searching the base BTF first. Thus, placing named types ahead is
> > > more effective here. Besides, I found that the '.data..percpu' named
> > > type will be placed at [1] for vmlinux BTF because the prefix '.' is
> > > smaller than any letter, so the linear search only requires one loop =
to
> > > locate it. However, if we put named types at the end, it will need mo=
re
> > > than 60,000 loops..
> >
> > But this can be easily fixed if a variant of btf_find_by_name_kind()
> > is provided that looks for a match only in a specific BTF. Or accepts
> > a start id parameter.
>
> Also, I double checked, and for my vmlinux the id for '.data..percpu'
> section is 110864, the last id of all. So, having all anonymous types
> in front does not change status-quo compared to current implementation.

Yes. If types are sorted alphabetically, the '.data..percpu' section will
have ID 1 in vmlinux BTF. In this case, linear search performance is
optimal when named types are placed ahead of anonymous types.

I would like to understand the benefits of having anonymous types at the
front of named types.

