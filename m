Return-Path: <bpf+bounces-18899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CB82357E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F201C23513
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E441CA82;
	Wed,  3 Jan 2024 19:21:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE61CA94
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-427f4407624so41219871cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309684; x=1704914484;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwPRK0zAj9tD4xKnX8S7kHpHVKs3gXEuGG8fgWy0h/M=;
        b=ZQ19veyiaCdqJ/y1TjgcX9nSbjLJlq5vYs6PGmjcquHzCGIW7gJDzmDVg1AyN7clol
         wAwSmoHw4kVtj+mEmcbM0is9ZnsogdoDoyX5nw9Kv0oWEsChhhQA/oo1hq3frfDq53er
         omZp6hPlEKfq3DA+cgb047BG6uqePImDX71OVoXQ7q5ZPQpFRK2BCcPQYYWLKgFVIwJA
         rxyT43Ec2thqfdjlH8PDGAJaPIz4atutqxRUh5ATPotJh5EemcLKX4N3tO7RzrHrp8cf
         IxkxZc38Rg9QcH890UNL+VN81vkFi6b5+UPai9mXaGsvmdSuNlekAK4cDF/A8ZKnI2AG
         NXxQ==
X-Gm-Message-State: AOJu0Yzua4mRwtIebUxe3VgZmTK8SUYb6woknz+3v7Dah3y95Tvy7HWF
	zpZTS/klDUaBTnv5Cp45bRfohLThICscAg==
X-Google-Smtp-Source: AGHT+IFl9drQojN3HjGPVVQnaE1dRauoCbOWuOn/vUrHts/WudRhyinc6bg1moakNGGTfjtq469J6A==
X-Received: by 2002:a05:622a:1393:b0:428:208f:aa6f with SMTP id o19-20020a05622a139300b00428208faa6fmr5349172qtk.113.1704309683699;
        Wed, 03 Jan 2024 11:21:23 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id fv22-20020a05622a4a1600b00427f0fdcd44sm7641329qtb.1.2024.01.03.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:21:22 -0800 (PST)
Date: Wed, 3 Jan 2024 13:21:20 -0600
From: David Vernet <void@manifault.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Polymorphic Kfuncs
Message-ID: <20240103192120.GA303539@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQiZGGwi1gOxAmf9"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


--dQiZGGwi1gOxAmf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Kfuncs [0] allow BPF programs to call out to the main kernel. They are
the modern version of BPF helpers, and don't require any UAPI changes.
With sched_ext, we define a variety of kfuncs for many different
purposes.  For example, the scx_bpf_dispatch() [1] kfunc is used to
"dispatch" a task to a dispatch queue. Other kfuncs are used to e.g. get
a cpumask that tracks idle cores.

[0]: https://docs.kernel.org/bpf/kfuncs.html
[1]: https://github.com/sched-ext/sched_ext/blob/6b747e0ee5fca284330d065a0c777d1991290bc4/kernel/sched/ext.c#L3921

One thing that's interesting about scx_bpf_dispatch() is that while the
interface and advertised semantics of the kfunc are the same regardless
of where it's called, the implementation of the kfunc varies depending
on its calling context. If it's called from a certain set of struct_ops
progs, we do something differently than if it's called from another, due
to implementation details of the subsystem.

We can (and already do) enable this behavior by setting a per-cpu
variable that we check in the kfunc implementation to determine where we
were called from, but it would be more ergonomic if we could instead
specify that a different kfunc implementation should be invoked
depending on which prog it was invoked from as part of the core kfunc
interface. Or, in other words, if we supported "polymorphic" kfuncs.

I'd like to go into more details on how this feature would be used, and
of course to also discuss possible designs.

Thanks,
David

--dQiZGGwi1gOxAmf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZWzsAAKCRBZ5LhpZcTz
ZGToAQDNk6NVA2mBY5k7FyI4XasEGiylxNd7nkcsmPl/G9JpWAEAsqM7q7TR5ntF
lfqKho/P9rgQLMx7MtSpD9MTVSE3JQw=
=beb2
-----END PGP SIGNATURE-----

--dQiZGGwi1gOxAmf9--

