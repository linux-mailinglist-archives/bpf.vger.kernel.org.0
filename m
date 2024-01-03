Return-Path: <bpf+bounces-18838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14AA8225EF
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37181C21A38
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411937E;
	Wed,  3 Jan 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEJ5jZcO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF7365
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so6992610e87.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704241792; x=1704846592; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/NuEYRVMmU3j8zLeEzt2XMC1SMBWR9eBLbI2/u4otwI=;
        b=iEJ5jZcODMmYI2yfcGTXZzzifUqMvEDT/VSkDjurJfXRL7F5aysAtF+bm3NzCGhmnV
         MImMhhdI0ivg/oePt7fcJ+5vxqnMsFZIyJIQHJyFFl8oclmvfrDZNj8EzEPzI8b69i/+
         /x7qBPY+Ut6eI0COITDnRbKVWgdaZd1ApmV0zQeNoTN36eW2OflB/8oOLxc5teFqb660
         qSX4MwE/fw18Z8craPCpIn3OoAVnz0899KoOCnZmC/wdoZ9SuWLRjdQDrCGa19/Q06ik
         Mw8MIhDNaQ7cdOC4hgHQkqsO/1ZdigLtwzn5OXd1JOruSipj7U5JXxhEJLYSsqBEWlyE
         GQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704241792; x=1704846592;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NuEYRVMmU3j8zLeEzt2XMC1SMBWR9eBLbI2/u4otwI=;
        b=jTAt+S6RUQBp8/u60lFbFDvU2lMIyxNlse9nWMWqaZeuiXal9I3wmQyYt5VVzKXkfZ
         syoAX0R40hdWDtoXTXbAR4eIrdKy5inStia4aPEubptiVNenltHPJ53tcvFfp/YR6bvD
         aSngOHKDb0w0M55fmU4ObP/D/Mmw6KY89kO+mArtlw/8Afag9DndPAcVVzygM2etEdab
         f4/QH6bVTNmtOrnVoZzAklFM3qh7vi5tCLdvDMGViO4F7PO9ZUgh6RiOtNzkgnH9kRRm
         7jbecvD2my6ypfi414koGkHvqCWS9uQ0+n/c8kyAraXusnthZMNYL0rvapLvU9BwV7cS
         1Okw==
X-Gm-Message-State: AOJu0YxyzfAEne8IgvaI3rv9wd9mh3+rngw0JD01WBc9hQNRjcFbtlJA
	6AcpVbv3DX1v5bw1YFV+3eEzlgUFFaLi3g==
X-Google-Smtp-Source: AGHT+IGdRlZEhLlmXkHEmqj/Ap/urkgf8jW9ooXhMAhIAvbu4cI2Q5X/rBWwMWsPnBPiwdtQptHlBw==
X-Received: by 2002:a05:6512:2255:b0:50e:9c5d:35f5 with SMTP id i21-20020a056512225500b0050e9c5d35f5mr1500192lfu.121.1704241791442;
        Tue, 02 Jan 2024 16:29:51 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dg24-20020a0564021d1800b00552cf686df3sm16682116edb.52.2024.01.02.16.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:29:50 -0800 (PST)
Message-ID: <90cce906fd6628354c6cd3fab9820549f6337dd5.camel@gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Maciej
	=?UTF-8?Q?=C5=BBenczykowski?=
	 <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>
Date: Wed, 03 Jan 2024 02:29:44 +0200
In-Reply-To: <CAEf4BzaLyHbddd-FfCMWBjbGb0==D1a=xyi0-u0zpQHonkhfyg@mail.gmail.com>
References: 
	<CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
	 <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com>
	 <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
	 <CAEf4BzaLyHbddd-FfCMWBjbGb0==D1a=xyi0-u0zpQHonkhfyg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 16:06 -0800, Andrii Nakryiko wrote:
[...]
> For the fix that Eduard proposed (and checking
> try_match_pkt_pointers), should we do a similar simplification as we
> do for scalar register comparisons? Make sure that data_end is always
> on the right by swapping, if that's not the case. And also use
> corresponding rev_opcode() and flip_opcode() operations to minimize
> the amount of logic and duplicated code?
>=20
> And I mean not just for new JEQ/JNE cases, but let's also refactor and
> simplify existing logic as well?

Yes, this should simplify the function significantly.

