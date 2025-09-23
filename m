Return-Path: <bpf+bounces-69474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5386B975A8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90E024E0655
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9B194A6C;
	Tue, 23 Sep 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLHnp32o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CD1D798E
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655987; cv=none; b=gIZM0Yws1q2xlUXx37+f1LZ8WAKHbCPcgf5hQ6+zjnhiGygu0V3O9FxsqaJHBOQBj1kvbS/81mVPELTnZFNlw33amt6PivHuy8EukZBfKxm4gTCUE+t8uhPHrW0R+jojtEVUA2YFmoZhFWl6km17QelPX6SdIFnZAECHk2GGGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655987; c=relaxed/simple;
	bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7IrgMvBMnx/p/Vx0vSVp6JoJ4ipIfwzykrKYW/2h++e2jwQigUb8rXKp1HL/PFP676eQMq7cbJMZC7Xn5fKdAW8tMgmfv10gZqW3KUPm6GPFGEtSeh2Xb0isSCt0w6XbplR+qwN6J7RavEhTD70ObzSlMy3FzxM9P+WNZK2dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLHnp32o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e29d65728so320745e9.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655984; x=1759260784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
        b=KLHnp32orXrM2GtsPRiP5QbRQMX7MqAkpHpNRJT21Iy2itg5e2MN7Bbgg21lowJXyL
         /Y6/hU3ZvJ9Nos1tw2pGfKOftzf7mdTeho7nWjlu/Bw08prtirC+2m9RASoLV1unSzpX
         y8TdY4oNFpn9t37n6D+a41brTR8cPYIDZo6ZbTPLfWYe+a4SUyjg2eAlROQ8u2RR74GY
         1WDssYXOMgY5iwkzKxHek0BfqtA1ndZou5ymSo5qYknhMDEpZ0mEaxtGXZwnkZBSECEG
         SotNnYjOp55iZS681rPitlvzXTAufk8eqluPaq0cNcJ6ZblbvkFixTGx23E1RrW/3pcq
         9g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655984; x=1759260784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MuzrNmVFvlrMIdu4Hu0o3+JM08RVibkcmhuvrt61xk=;
        b=mPrVjgjT6o9gbml7Da1SBSn4JG0jTl80ORfDyS8gmyqiBBhfXDZYmCTF4JG/icRsub
         hqwKlMsdiFfdtcayHpTpFzozW+2psxrtTVGm6UaEH0m75NMGrHTVWWgBLjJ+u+SqyDcW
         W3TTGxaUiY1FclZgwggw9FtpZ98ntJAk7t5iAqljCnYGVKmuwDYw8LbN4JIkFP9bffeP
         X95EpNGEIpQP0sCfwYhbbFLWz0QJaE8cpJGRfDa5re8Ngof+c6yjNvMEc1GH5QUGKuUp
         vkV7i111q3QsHz4AwrHp4n5mNZIOfJLMueuHIm7pxuAy4FPBynkECwMb0vR+HVol1GSk
         qJdw==
X-Forwarded-Encrypted: i=1; AJvYcCWqbFDXOUcS11lMO8tgLq/vPmOwmsAiUfP8MLb1SpowIK4SkX1x+qFcZ03UcESKT+gQ/XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R+XD88Egh8er1yyG5RTFGUUH27ZRyGM4JrG3rjl+ARQO8KJm
	hehZb/u7DgUiQ74CpnzDEyg8mZWtZo/suulbP0RZqXtThNUNVdEsdQaatqAQfrAvMzfYZaLH95v
	Ub2L52a5e1orbcfq4g41SI2gTNIUjNTY=
X-Gm-Gg: ASbGnctexjMcD3+KAiA04maK6ovE+RfVoAOgHjyikfT7buXD3DD5BzuqLDlXTaRyB5Q
	yep2yxDsmHEKC0Eu0Itt6MW77IqmBuY04PyZaqNi0lgqUcaWvNeTGVAuc8VhGoBQ0+LglLw18ds
	FB3ECjc7gFWkdJm7HcRVwDWjfx4Od7psqXpMzD9JwPzvBTFUFCUjx/kTJcW40vdTAa3RWzgkGTv
	6JV+YYb2nPJamjnug==
X-Google-Smtp-Source: AGHT+IE8XrcOsL1rWzwkMbgHflL8vbyW2fCrqZ3kwKccRiEzS6MH+EPt7ULGAqOqBI/jjSYJ4B8a4jczeivubLyQDNQ=
X-Received: by 2002:a05:600c:3b11:b0:46d:1046:d356 with SMTP id
 5b1f17b1804b1-46e1dac2e1cmr31049435e9.27.1758655983762; Tue, 23 Sep 2025
 12:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
 <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com> <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
In-Reply-To: <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:32:51 -0700
X-Gm-Features: AS18NWAN9XrK1XwDoJdvOpkTTC6Whfk3KPMyB7ODQPD4-VPHBDtcbbqqaxPHF-A
Message-ID: <CAADnVQ+XW_YC6Edauhf+AoWLx4uSNchbQUic33oTeNskp9yt3A@mail.gmail.com>
Subject: Re: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: Ariel Silver <arielsilver77@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:03=E2=80=AFAM Ariel Silver <arielsilver77@gmail.c=
om> wrote:
>
> Just so I understand.
> 1) The docs are indeed wrong, correct?

It's arguable, but removing if (ret...) check
from the example is worth doing.

> 2) Any idea why I get an automatic response of "CONFLICTS" when I send
> my patch? Even though im 1000% sure there are no conlicts

The patch doesn't apply to bpf-next tree.
Pls use the right tree as a base for your patch.

