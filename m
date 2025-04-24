Return-Path: <bpf+bounces-56637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD0A9B6E4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB044A7FF8
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515928FFD5;
	Thu, 24 Apr 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eEcj8RSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA749288C97
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521146; cv=none; b=pPWotD6g+oPe8sZcGnhg5U352PISy34ptRa/nvMj2a2kdLPbMe88lamJymlfzzJk7fNUdS/Uj/KEVfWUWcbGPeRlDeh2DQnI/XNkbi9sxI6v+HC0E/muMlPgufzfiWU+NSADF3M0OLjBiA4ISjj5Vv0YQsDofMEnaw1T8cdw0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521146; c=relaxed/simple;
	bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IAGaJT/2WoR2XzzSmDepc/Rkjr5Jpvyl8/u8k7iMOj++uM3HpAwSdquERLU+ZiRsyObNHhUIcw977CLbt7at6rfGNDFW7FJnYQErr4gs1pxaDIkyW6rgR+I4C1J0v6vhHOj90OB86ffSS8Porf4MArFJgGt4ibwsRy8cytLQvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eEcj8RSz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acacb8743a7so238719966b.1
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745521143; x=1746125943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
        b=eEcj8RSzy/N/ftU8FV8WUpbEg23lf0GKlw8FpdcGADRGIojt7dVQ4UdWydyAYlc/xO
         7kTubFJIG/iEo1KOI0zZPWcg9/3TiWaVVJVgMXR3XDK6s8KYG1CIiUCcrdUWhIqAGWyU
         TjQ/BCm7UVb+Yy4mH/Vl7uKbsu8A6D+Q1RD8c+e+POFDG/Rie+azx3WZSb/H5XDjfXZq
         7Ng2OTJzggopUc17E/Xg/VDVHnf8cMEjh43H2lFI5F9c0C24EJJxd9MINFw4/c/t4uFl
         ZEig2Nb9szj6SPokEZMx+CGTyiqg5BzN/6pDJwx3rxnzC3IL7WKPuaH/W5dt5IQvNnHG
         oxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745521143; x=1746125943;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
        b=FloEik70eNVCuJd6L8qBs4nMC+Fpo56WKz0Mld2Lnyt15gLymQIdK1qjJOnvijEV5J
         Ix/gUP3PmNwCTTldrr9s3hgxaHrIZWI6/BoKRDJEOvhlXiePmFJUP951O4HTivDLDnIO
         GjSNVlwfgQRzuD0Fx+qFwmzc8mS+6dXi2Hq22jSuDc9tf5YS3lvlOomJJIiQw9OiOUZv
         dz9Gr8m04zu4FnmB+RVn4PkwJ5e4hpWlZgWERh8N2VSIblR8Pj4a3AaKjAkXp5mYrJzZ
         6sleXh5SZ2N6LL0wB5LIS1xCd9OJA3wBXRZnCmnLQW6Tw2/QYPon2pdrvaagW2nwupc4
         8mLA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwbX8hghK6i8GfaALNer7Y4sEyX4av+YMG8ZrYjOuhHiBO7MSCfwsEFn5k6GlQrG8tRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmh/2fCPAr3+/RHSjvGtfUmyf37m4AS3/Su/0s5fXMfiNzmPme
	d3XqJgXhhMX9sbkclWWNVIn8U/rSugmNM6e0rSB0C9JZWNxIIBBwef+yJ2thfQaQxM7hqoKSdM1
	T
X-Gm-Gg: ASbGncvAe5PmAwdDYnNUp+1BDVuPjGBOcF4Qyz6W8jLopDeq8XrGTbxDX3SIm3iTY9+
	50tfUqYJOzvfhBrNCJgxWvsSF7D5e6diQN6dVQM/YDTTSyGRMfvK9yPNWQah0fL4OymY22CTDe3
	mHsHov6SELULdVdo4s3Re36W/llzuqyCeZGfEddPcbaAqHwzPj5PGub57X1b37qNhNmJL+0uft1
	VY1Zb3x5q8Cb4CUeoMeyj9puQT104rr49GyaxYK2TZRFQ1Wd865jfT0paOtNlleGOjawsZrNuFx
	ffyL26HUixsSPicndew25ZtE35KFQwDGUQ==
X-Google-Smtp-Source: AGHT+IE1WfJB2yNHVG6dN5YP24a45RQi+2yyfaZDzZalpZ3qP62lfwp2ZK6hXPfRQCwsO6Nbp9kfIw==
X-Received: by 2002:a17:907:60ca:b0:ac6:e29b:8503 with SMTP id a640c23a62f3a-ace5a124436mr310160866b.1.1745521143004;
        Thu, 24 Apr 2025 11:59:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7a25sm7201166b.52.2025.04.24.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:59:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,  Arthur
 Fabre
 <arthur@arthurfabre.com>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  hawk@kernel.org,  yan@cloudflare.com,  jbrandeburg@cloudflare.com,
  lbiancon@redhat.com,  ast@kernel.org,  kuba@kernel.org,
  edumazet@google.com, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
In-Reply-To: <aApbI4utFB3riv4i@mini-arch> (Stanislav Fomichev's message of
	"Thu, 24 Apr 2025 08:39:15 -0700")
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
	<20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
	<aAkW--LAm5L2oNNn@mini-arch>
	<D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
	<aAl7lz88_8QohyxK@mini-arch> <87tt6d7utp.fsf@toke.dk>
	<aApbI4utFB3riv4i@mini-arch>
Date: Thu, 24 Apr 2025 20:59:01 +0200
Message-ID: <87msc5e68a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 08:39 AM -07, Stanislav Fomichev wrote:
> On 04/24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

[...]

>> Being able to change the placement (and format) of the data store is the
>> reason why we should absolutely *not* expose the internal trait storage
>> to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
>> The trait get/set API very deliberately does not expose any details
>> about the underlying storage for exactly this reason :)
>
> I was under the impression that we want to eventually expose trait
> blobs to the userspace via getsockopt (or some other similar means),
> is it not the case? How is userspace supposed to consume it?

Yes, we definitely want to consume and produce traits from userspace.

Before last Netdev [1], our plan was for the socket glue layer to
convert between the in-kernel format and a TLV-based stable format for
uAPI.

But then Alexei suggested something that did not occur to us. The traits
format can be something that BPF and userspace agree on. The kernel just
passes it back and forth without needing to understand the content. This
naturally simplifies changes in the socket glue layer.

As Eric pointed out, this is similar to exposing raw TCP SYN headers via
getsockopt(TCP_SAVED_SYN). BPF can set a custom TCP option, and
userspace can consume it.

The trade-off is that then the traits can only be used in parts of the
network stack where a BPF hook exist.

Is that an acceptable limitation? That's what we're hoping to hear your
thoughts on.

One concern that comes to mind, since the network stack is unaware of
traits contents, we will be limited to simple merge strategies (like
"drop all" or "keep first") in the GRO layer.

[1] https://www.netdevconf.info/0x19/sessions/talk/traits-rich-packet-metad=
ata.html

