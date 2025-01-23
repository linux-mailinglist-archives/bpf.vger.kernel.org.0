Return-Path: <bpf+bounces-49600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E88A1AA5B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87968169E15
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E1156228;
	Thu, 23 Jan 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXWX0qfu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54817741
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660899; cv=none; b=GaJ6DPca1tacJqJBv8Rr6I+AH6e9nbLzs2RR/L0VT0Kt66lTSekg/cLxdUma3kvjWL0Urq/dzckf8fi0CkfsDH/TayFibl/tdN2uBOExOv9Lj12joCphsSUq3w0lRzd0xwCJgWWilMCNohlyulGMW2tQKhpr78xE0FzTasykFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660899; c=relaxed/simple;
	bh=6SaESWWCqCIxvluVy/oE/LgZrICJeKAzfEmSH+m3pOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzEBPZl3vj2r2ukG5hBzgfcT4f3lWPEqmWZVdWlkbArQ7LJx3ddp2ZpjJzD7NIBOVG07jVG9TtH7m46Lxrb90KVLctnBgmWfevTs+2PT+g9rRbcPuk2wMSMGCsZbp93Tj2Lpxj1uQ0dJxT37AzGBXrErB6HYPfwYHn4kyoSeQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXWX0qfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737660896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbnekrAGQBHrTCFmVqgMjT60X/cn1LFrEz4eI7zVj7g=;
	b=BXWX0qfuXzfGz1EFA7MJCH56b5JN4a7jDKln+3aHyldhnbwhpaJt8B2AClwXH7NW8Iwiq7
	BkuznGf2Fbp9X8B9hZPWgPNY76crGnz3nv5n6AhbRG9lFt+xdaGdUryrvTvijoeHses1od
	4Ymhl7YO56G9uR6RZcHumSsBHFB1Tdg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-9U7xIEyNO2a_YfWgeIsB5w-1; Thu, 23 Jan 2025 14:34:54 -0500
X-MC-Unique: 9U7xIEyNO2a_YfWgeIsB5w-1
X-Mimecast-MFC-AGG-ID: 9U7xIEyNO2a_YfWgeIsB5w
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab39f65dc10so135750766b.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 11:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660893; x=1738265693;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbnekrAGQBHrTCFmVqgMjT60X/cn1LFrEz4eI7zVj7g=;
        b=q/aP4aQAhmLwaPQDuiyz3prCf2sZd1ZAW9M9jeXd5ZV4pPNx1BBsOXk1w/SYEvtVpP
         6sJfQRUe1Z4Hq18558lUgOjnDzTtxaQ0+e+v0aX65fGCMlIA+A78saDSlT5E9E2lNxML
         nBM+sAAVsLpEZK7W8BQcfN67B2w91pVDug3tb0Ecs2QydgFpv3uSSF8lPJUGRdo2FAXo
         qk5Q8SjkLyFt66zYKtzx3Ttzz44SK0w+HK/u7PmRxHjqysW/P4ldQvpwLquWGxUPTV53
         fmO4tmaCuuWd6lH09iwzWhhbGj/VisfGurM7jMCvSVtWPHAQVmp6Kp3/E6iO5AYhunnV
         HyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWlhBIr8L7VO7NpXljsmV4RuPgdA4x32+v7ijEmZ5PzjjqMACAOPNgR4f2ZLbcqbLEFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JiPCrgIEIRqbYthSRdeEac8duqEGQn6I5rMtrQwMG4XpjDij
	nVHFRDXxJ8WTT7R+yJsY+DyEwbQRiF5n+GMSic6gbCtCgpLYe5EDoVEdts20Ytb8VNmdpGf/GkV
	xTlAhP0yywoFGLjSSGfUY0jXnLoGwadXBiNpIJxSbkwabFGAcgg==
X-Gm-Gg: ASbGncurewHYymlN4UYoNsDa/UtRQ999lGEJ0LLpkm4/OFYzca2aity1UQroexkyEcL
	mtTAsTBwb7C5vzlJl8Jn8Zb1b06iuxi5VauFoaqcZ25EfrFaTTz4jLaIolzR2DuwcnYY0dzWeqV
	oeOQUp/I49dpZnIVeuE1jWsurSuTToDIGWlO54dlY+zpRmLO7O1rTq994+KEHgCkSRWUgAVDSaw
	VmyAR4avHYkUqWagxTGSJRvBCx/ZA/+0V1luWwI3FRyk9KQAXF2Byz3z9Jsie86kJffPVz1Q1Iq
	i/aNXrNZtSHn8BkfFj0=
X-Received: by 2002:a17:907:2da3:b0:aa6:85d0:1492 with SMTP id a640c23a62f3a-ab38b378c99mr2653632766b.37.1737660893379;
        Thu, 23 Jan 2025 11:34:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgBKug9UtJ2gSQ/3tLYma0Agu2mYnkfMTxPOBSa+lsFtPV4DB9goJYmOE1HJTUy2p1A4AblQ==
X-Received: by 2002:a17:907:2da3:b0:aa6:85d0:1492 with SMTP id a640c23a62f3a-ab38b378c99mr2653630766b.37.1737660893009;
        Thu, 23 Jan 2025 11:34:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab237sm7271966b.120.2025.01.23.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:34:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B791B180A864; Thu, 23 Jan 2025 20:34:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, bpf@vger.kernel.org
Subject: Re: RX metadata kfuncs cause kernel panic with XDP generic mode
In-Reply-To: <Z5KU2KM-cB_tS9sU@mini-arch>
References: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
 <87msfhqydl.fsf@toke.dk> <Z5KU2KM-cB_tS9sU@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 23 Jan 2025 20:34:51 +0100
Message-ID: <87h65pqq78.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 01/23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
>>=20
>> > There is probably a check missing somewhere that prevents the use of
>> > these kfuncs in the scope of do_xdp_generic?
>>=20
>> Heh, yeah, we should definitely block device-bound programs from being
>> attached in generic mode. Something like the below, I guess. Care to
>> test that out?
>>=20
>> -Toke
>>=20
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index afa2282f2604..c1fa68264989 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9924,6 +9924,10 @@ static int dev_xdp_attach(struct net_device *dev,=
 struct netlink_ext_ack *extack
>>                         NL_SET_ERR_MSG(extack, "Program bound to differe=
nt device");
>>                         return -EINVAL;
>>                 }
>> +               if (bpf_prog_is_dev_bound(new_prog->aux) && mode =3D=3D =
XDP_MODE_SKB) {
>> +                       NL_SET_ERR_MSG(extack, "Can't attach device-boun=
d programs in generic mode");
>> +                       return -EINVAL;
>> +               }
>>                 if (new_prog->expected_attach_type =3D=3D BPF_XDP_DEVMAP=
) {
>>                         NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs =
can not be attached to a device");
>>                         return -EINVAL;
>>=20
>
> I'm assuming you'll properly post a patch at some point?
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Yes, will do - thanks for the ACK!

> Might be a good idea to extend bpf_offload.py with that condition.

Right, I'll take a look.

-Toke


