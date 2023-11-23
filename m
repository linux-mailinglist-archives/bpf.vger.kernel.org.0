Return-Path: <bpf+bounces-15770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336ED7F66CF
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E1C281D6B
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E244B5A1;
	Thu, 23 Nov 2023 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ESs1nbJ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D0D40
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 10:58:44 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cd3c4457a0so8867707b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700765924; x=1701370724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goFqCayMO3yd5dY9u5btIbV1m+XirfF8Vemv+7i3SQw=;
        b=ESs1nbJ6RmAA18M2Z0u0Qib1zrXXWQ1xHLPywqiMzYI8ta9I26yOH+yIg8ywerVFZ9
         4QFlb/KqojzrMpx7acFROUm9Ckd3m5jU4Xcdsz7aIll4cyMhUaZgeGe3hd1cjS4s6dzn
         5QrD2uN+pq8/HIOtFvOYOb45XliC+Tz9uyV98Nf5QgV8LZSYcU+2eaeE9p0Sr7INgx/9
         ZUAwIsav5nb+K375HVtxj6UXXVQpXJXQrFgqbHaQDZgvxmIhixdjnvgrlpPRp7DoBN7O
         RJR2wqsNrBRRd1Ef/4b0czu4PU/7kqjnPmS9fyzqnz93a82R7NWKt/4H8JGHux+UU5fW
         okAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765924; x=1701370724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goFqCayMO3yd5dY9u5btIbV1m+XirfF8Vemv+7i3SQw=;
        b=BMFNptgcDn5dIGu3+PWJj5xVwNvqKQAA6q/fFEmQKszyDRdqbLV+Y1On3qBGu5fPGo
         ExwHOwSPXyNDfYnzqr116TvrsrhiPZ79kbFT8kyRQYQuikbFAZ8yIlKDlR5xF0eRTtKm
         bgZ+GURdqSepN7jN1akchu2Zv4TcqpwfBxoa0/RAubt4V78vQO2xVTOkYoJ6V92jwxSk
         svPk4pg9n0OBOAGUhmNckykNOyxjD+dyp+AtFlWi2A1wnTF/xAyCDWitq7VmMKbCP/pM
         4D+a7J5iLQajR194uRt2CjeMdgY2F3Oe4/JDPDbUcmFnOAZMOZ3rVLvI2WPfln6iQTFw
         qCuQ==
X-Gm-Message-State: AOJu0YwLmoZoxN4dS6VkET/YFfO+0hmjtywoI0ojkz3wES9AjKsPHpC4
	Pw7JE5qLLuopGmopyHR+JW6hC/QZ9yUuq/rWbC3ucQ==
X-Google-Smtp-Source: AGHT+IGxh7f+3U0vyw2P8iu0aiecQXk3Ezk1ccqlrJE27RmNdJnL5NRM3kP9B8y1efAbyWx6KGThX2MF4Ve8XKUFCvI=
X-Received: by 2002:a0d:d9d6:0:b0:5cc:5b20:3aa7 with SMTP id
 b205-20020a0dd9d6000000b005cc5b203aa7mr199134ywe.17.1700765924142; Thu, 23
 Nov 2023 10:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho> <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho> <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho> <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho> <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
 <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com> <ZV+VVLWzL/j4ayAt@nanopsycho>
In-Reply-To: <ZV+VVLWzL/j4ayAt@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Nov 2023 13:58:32 -0500
Message-ID: <CAM0EoMkbCpPYM4LgdUdrGfN4ECBrhNr8YiaVtuu=z+-hGnWFMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jiri Pirko <jiri@resnulli.us>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, Vipin.Jain@amd.com, namrata.limaye@intel.com, 
	tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, dan.daly@intel.com, chris.sommers@keysight.com, 
	john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 1:09=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Nov 23, 2023 at 06:53:42PM CET, ecree.xilinx@gmail.com wrote:
> >On 23/11/2023 16:30, Jamal Hadi Salim wrote:
> >> I was hoping not to say anything but my fingers couldnt help themselve=
s:
> >> So "unoffloadable" means there is a binary blob and this doesnt work
> >> per your design idea of how it should work?
> >> Not that it cant be implemented (clearly it has been implemented), it
> >> is just not how _you_ would implement it? All along I thought this was
> >> an issue with your hardware.
> >
> >The kernel doesn't like to trust offload blobs from a userspace compiler=
,
> > because it has no way to be sure that what comes out of the compiler
> > matches the rules/tables/whatever it has in the SW datapath.
> >It's also a support nightmare because it's basically like each user
> > compiling their own device firmware.  At least normally with device
> > firmware the driver side is talking to something with narrow/fixed
> > semantics and went through upstream review, even if the firmware side i=
s
> > still a black box.
> >Just to prove I'm not playing favourites: this is *also* a problem with
> > eBPF offloads like Nanotubes, and I'm not convinced we have a viable
> > solution yet.
>
> Just for the record, I'm not aware of anyone suggesting p4 eBPF offload
> in this thread.
>
>
> >
> >The only way I can see to handle it is something analogous to proof-
> > carrying code, where the kernel (driver, since the blob is likely to be
> > wholly vendor-specific) can inspect the binary blob and verify somehow
> > that (assuming the HW behaves according to its datasheet) it implements
> > the same thing that exists in SW.
> >Or simplify the hardware design enough that the compiler can be small
> > and tight enough to live in-kernel, but that's often impossible.
>
> Yeah, that would solve the offloading problem. From what I'm hearing
> from multiple sides, not going to happen.

This is a topic that has been discussed many times. The idea Tom is
describing has been the basis of the discussion i.e some form of
signature that is tied to the binary as well as the s/w side of things
when you do offload. I am not an attestation expert - but isnt that
sufficient?

cheers,
jamal

> >
> >-ed

