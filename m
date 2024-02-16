Return-Path: <bpf+bounces-22190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20B858855
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40D01F229F4
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D11474CB;
	Fri, 16 Feb 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CprgrQje"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12947145FF7
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121200; cv=none; b=IlweJRbJPydkCGvk2bDdv4my6AW13tEBs4MqxDwXyPGr+lKKyhwnLv6QfKr4lRfZ4peHKqHiOxmsHfk6N6PisOgUZ6saUvd/zXylWyBkf7UWnLr76mmi7bOHKqXqIywYCLN0wasalrhbwT5xSpz0ErU1SMwhwybr2menExsZxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121200; c=relaxed/simple;
	bh=V2vBuZ0KVYpceEiTR8gcRVZJJoPUhUYusXz4X4EHlzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NltOmdBmmCVaoPq002hXZ7IUsBLJTYFomCm06QlqYEiHvBaBJgOBGVBDtmH+v+y7vyzVpgmi66qkQxAZjIjLe0bzCPPNTHwGaR0xMIbU2AnRgmovAx63o2HABtwcff3sm8qI32Jw7PVETWTE3KbZQ2PAmVMY80ot+8ae6niA25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CprgrQje; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso330363566b.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708121197; x=1708725997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QU99AvNDR0vlk5DbNBO/CB/KTzXFo52LS8xgyXAB9lM=;
        b=CprgrQjeGqKqS2QgzAa8Jjdsq+vYuge4OyqWUZmoJYciPc/wIxKo/JWwvlYYuA2gFT
         GpTaLMAFgDGvaW5d/H139swcRSdWlyBaiRaUbdsRNwd8JWm3AivxrrYrXpYpm110RfIh
         SHjvPJpIqvvgSbldNzt4hZzBzplci2kka3JvmSFg54qqcTGX6bBJceavjIF7Y+qN2Bsl
         m9kJ3BQ3zbsvJ5smyR7NPiwUmz0A+38zrqKPcHob2rJVans/nj+/F6JVZ2Q10chitLeH
         k6X67F0CfRGgPj7S2Z7dd4wGMmdYrEVSY+uiMpydLV+KXAJCPNhW7sygTe/PNiNd0Z9y
         2fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708121197; x=1708725997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU99AvNDR0vlk5DbNBO/CB/KTzXFo52LS8xgyXAB9lM=;
        b=YOS8jdxWXfXWqaG+JdkRfPZLnXu73hiRxYn9NfaEzTBZloSJFsnfrd157sqX7c5Bwu
         SbKmNFCLV1qqIWCkM3ryv/lwa8rWq2n+1OTJIY2zM7CwcByj34wa94ibVvOobo0yzGol
         9owEprZRJ9C41kQ1uHiY+5myY7s1AISSgKRMYYm3JEFDmlTc37rt9GIL+HIl7miZISny
         JGHY+Jaj+yV2VIWMe5G4G3xec+fFcI7RY1HUEpiNbw0M/NhAuymuvFrSGjLxILm2D/K2
         hvkE3aSlcfz9AHJdSzUoA2r44riW1yUdGFwXz3tu6KNiZuqJMIENCnYy4tdjBUzG8LZF
         CXtA==
X-Gm-Message-State: AOJu0YwC3vvplfWCUiNDr6HNpD4VJVW+8ycIjm6dsz90yZ1Z0P2gIM4L
	OI+3LO7bXpncgahNEfHNcIpU5WsbdC+fv0LZRzAEMBDSKgvSY2bt6xrftR8D8M7zFfOH8QnZIS1
	Sq4xaxZYrUDiIJV5hK/g9UqtXGu4=
X-Google-Smtp-Source: AGHT+IGF9pZBG/xaGuhogOxCMElIp954cCcI0NybyXnS6OsODGHGuyY87QrsQ3D1Swh97y3eM1WD/nJkux5bR3rqhxY=
X-Received: by 2002:a17:906:22d1:b0:a3d:4dc4:2672 with SMTP id
 q17-20020a17090622d100b00a3d4dc42672mr4048706eja.51.1708121197201; Fri, 16
 Feb 2024 14:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-6-memxor@gmail.com>
 <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com> <4ef073e2cf3f5b3c7094e81593001ff068ee9f64.camel@gmail.com>
In-Reply-To: <4ef073e2cf3f5b3c7094e81593001ff068ee9f64.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 23:06:00 +0100
Message-ID: <CAP01T754eL=NRWDk-Q-YsV9uWa1pkYaeXvjzy1SWG+A1HjQDsA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 12:23, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-15 at 20:24 +0200, Eduard Zingerman wrote:
> [...]
>
> > > +   case STACK_MISC:
> > > +   case STACK_INVALID:
> > > +           /* Create an invalid entry for MISC and INVALID */
> > > +           ret = gen_exception_frame_desc_reg_entry(env, &not_init_reg, off, frame->frameno);
> > > +           if (ret < 0)
> > > +                   return 0;
> >
> > No tests are failing if I comment out this block.
> > Looking at the merge_frame_desc() logic it appears to me that fd
> > entries with fd->type == NOT_INIT would only be merged with other
> > NOT_INIT entries. What is the point of having such entries at all?
>
> Oh, I got it, it's a mark that ensures that no merge would happen with
> e.g. some resource pointer. Makes sense, sorry for the noise.
>
> Still, I think that my STACK_ZERO remark was correct.

I will add tests to exercise these cases, but the idea for STACK_ZERO
was to treat it as if we had a NULL value in that stack slot, thus
allowing merging with other resource pointers. Sometimes when NULL
initializing something, it can be marked as STACK_ZERO in the verifier
state. Therefore, we would prefer to treat it same as the case where a
scalar reg known to be zero is spilled to the stack (that is what we
do by using a fake struct bpf_reg_state).

