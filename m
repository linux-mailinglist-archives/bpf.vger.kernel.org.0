Return-Path: <bpf+bounces-39595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC80974E79
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63041C21635
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E951714C7;
	Wed, 11 Sep 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QASijEmw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A505339F
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046884; cv=none; b=W3Rm09qcxcQjjizHAyYc0UP3AZejpF6hcQt08/n4PUj41/1A5ZJYgMFLXsGiXcXlRgKiDky6ojb4T3EQpcd37k6jR61piCORv79ucQRsGg2wF235+MHRi6BxqCZrodaNs9JsD9aKO4iQXnf4vJb30/PSfn7uAxKz002rFI3qr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046884; c=relaxed/simple;
	bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ycmw5WS/pzSPG/OpH/LPTdrJTNiz1BQN2Iw3+uRc7LUBr3uoh0CQ6szjqeRqTki/741vN+Ox3D6Db08n1jxnHPaFoMqo3l+d78JV2r+6DSK+LVowRXvbdHk0tOGTf+IlQ2FxP13C9HrzkOAiMH/4xnw4L5B+/O1dAUyJFKI8eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QASijEmw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
	b=QASijEmw1OFfNvisVK/bQRRuKoMakTj5zeCsdZRp7H+UCeP6GUbYWn7a7rniucdaYoyCXi
	k+9F36I958vEgSZrjfZ38D2eaXk4vChByDV9e+KA9L729Gmb8AHBjlzsFw22Z/Qv+9QNUm
	RHMeS2kQR0BMpSXEVmu27R2yjx6dxx0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-0kN_2Qy5MHG4awIbMMg0GQ-1; Wed, 11 Sep 2024 05:28:01 -0400
X-MC-Unique: 0kN_2Qy5MHG4awIbMMg0GQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7d2d414949so503608566b.0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 02:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046880; x=1726651680;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
        b=M6miGz621bEmzZYoonxLFaRdxkbmvfIeYs6PuaZrsWibXdqGnTYR0fHt6aTl64ZRl5
         RQoERX7aUlH4IR9kORL2X0E5Qu9vPgMhMeGeepHldx0SLr39JROLQFzTDUFHqBZFYTTx
         9yTPKBOcxq7evz3L4/cZKf8b/AuyEgmSMqrE3F7i0La+1Tc0X4w/Bv8ER8laNolxO1HN
         d4n3RN9vwUthoEGi5nk6TZpfaBsa/+qKKCc0cOcl8XoBNfvJd2dvwyriJA6zUGE0X0NB
         kpBHCKVOzWUFKtKj/SzlHxiITSTcuFNobvxXdlPbRm5WwTYeT2mzQSKKhuudtDAA3dee
         lQYA==
X-Forwarded-Encrypted: i=1; AJvYcCX1bDLT/iOM9w754nMjGxV+EZjjHJe37isq3jhTkevvB0KUqx2ouHJLrIgIZeMFyETaEVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc/t5Mv4+5gA/59fqXVPzh6yegMcq4Ff5IvGIgWaqjwrbSlGb
	hDBiX9UTXyxGH0+7b91dkuQ3rb1vnGlnDGUHL65yU59QF3UIWF7qCwy4VRMOgryAIEVu3kjRgqu
	6+BkZgKSM8jmZkYG6+qo2SlQcoCSvknudmy4rSY9cs37aVL3WTQ==
X-Received: by 2002:a17:907:97ce:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8ffab186e2mr337837866b.20.1726046879920;
        Wed, 11 Sep 2024 02:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnHzlMw1tu+Z+GQSp2X0RZmYzG1Uff+btBKKc7jIg8BK8u9Kh8sOEAmodgVs3w55sADXPe2w==
X-Received: by 2002:a17:907:97ce:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8ffab186e2mr337832966b.20.1726046878759;
        Wed, 11 Sep 2024 02:27:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a901c737f09sm16779066b.30.2024.09.11.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4C8F6152C4FE; Wed, 11 Sep 2024 11:27:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
 <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 linux-kselftest@vger.kernel.org, Florian Kauer
 <florian.kauer@linutronix.de>
Subject: Re: [PATCH net v4 2/2] bpf: selftests: send packet to devmap
 redirect XDP
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
 <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 11 Sep 2024 11:27:57 +0200
Message-ID: <874j6mee02.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> The current xdp_devmap_attach test attaches a program
> that redirects to another program via devmap.
>
> It is, however, never executed, so do that to catch
> any bugs that might occur during execution.
>
> Also, execute the same for a veth pair so that we
> also cover the non-generic path.
>
> Warning: Running this without the bugfix in this series
> will likely crash your system.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


