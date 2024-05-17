Return-Path: <bpf+bounces-29899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A28C7FBC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9979A2842D1
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFF186A;
	Fri, 17 May 2024 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1CC1y/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096910FF
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911392; cv=none; b=l6KEyq6eQWm3Eqp2gKpEv+4RJ/tNP5gdSICvGqQJmoRkC0eyPf2cQTGUuSCHuvNZAHfr0KOw8rUQYTFoA/Zlh+4DJP6pH2UGwQ8g04YDbk+BZwO7B5yZp/xkAF5ndzpMtESD+NMotPH7XOoSwXc/cxKFGlxf0Z8RhzQ/noZDW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911392; c=relaxed/simple;
	bh=f2Qkq3AVkpSYcpd+NwWAWvFyih9jrpPL7DdvHcy4Pz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRCTLBUQ2VClVEEPJK5t3coU9mx4pciXch4Cw7ks1/BRb19yRDnwT9BU8OWrM+hQC9R9knBJxRgVIMCgTPzW+r5FU1D8wdM+MNbIu+oSQ6nIDUvuWX1J5gxFu24ivZ4tRz5gLhIApfqmMeGC1vfHSrQr9sGb1LXXrW7B8jG5VV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1CC1y/g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed41eb3382so1168905ad.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715911390; x=1716516190; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIvtBQ7J8HDi3RFvLtkhHk+4rQ/fWF2vp9RFyRSnx8A=;
        b=j1CC1y/g+EyAVSEe2GKXI14kIKi5rJJPMu0aYtiZXFnQu9vbIdFZuChVDK4pz5Wpzw
         +L32jpgGIxHMhYhzOswQqX8itUNVr6CYOqQNguYQNjptBkCxJBGGF67uZnybyg8tzFAz
         3uy+hIC15TEcvX/nRnklRXA1JVoVnaqZac6Z41t7tocULubOWoO0FUhAY4zFLEKD37sz
         x6lxJWQ05V0d+BGmChb/5y4YLZ/zgPNTgAmk5+AkOKepZmhPLaJVQ6zpHyvt+6YOENvp
         or7oxSUbDOOYzMtYm/3B1AwfSPxRDhyRdGSt0nYxWp+l5V20vaeOTtvmUmJST3CEyFLl
         QSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715911390; x=1716516190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIvtBQ7J8HDi3RFvLtkhHk+4rQ/fWF2vp9RFyRSnx8A=;
        b=QLu/+P3JVAhteRduKtlXGiJDY0wJiCOCMx+O5cma3e1fBQOtIPXLA2Mzov9tBQT2BV
         0WIb19jiVMioIifLGJqrT5JDQjmdV+gZ92uMsa7rzhkzJIjQN89YRJTl/vRAx+AfGqW2
         NQzsehGccoi9oJq8ilRwM2hGf9MHULIEp/wWjaIgoUnUPASD2vIGjEm1E8FSJ9toZf0a
         WvXAzfQa7u49AEouN+6pp5FreWEzGTZuNaOyL3AKvC/Mts+CnsJiR2oXpbRAcM6ZEtkF
         3nwktVp8x0rO9St1DIZWnj10B7ZXCOdxgPTBhHiMqZMHivreR9TLa+3ZIMJnWOBHxahh
         c4bA==
X-Gm-Message-State: AOJu0YxJ8OQL76icORLkCC26yFFDqQYcuvdXZynnzgMIFyBENgxfn4R+
	6M/EnJavxbj9PpNZCNzvsAqtKD6TtaRxgfN6v0bBqc9effswaP+WNlqp2Q==
X-Google-Smtp-Source: AGHT+IFN119FCeD/ZXqKipQk8ltEGvVe+65BxowwxTM+CA/jhSWig5kJrrqLHncuV55/+B4qprqiQw==
X-Received: by 2002:a17:902:b18b:b0:1ea:3798:e404 with SMTP id d9443c01a7336-1ef43d2ba22mr225951485ad.31.1715911390035;
        Thu, 16 May 2024 19:03:10 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c16093fsm145360645ad.281.2024.05.16.19.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 19:03:09 -0700 (PDT)
Message-ID: <875d8ac4289bba082d2b5c4515d169d62bdb64a6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/3] API to access btf_dump emit queue and
 print single type
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com, 
	alan.maguire@oracle.com
Date: Thu, 16 May 2024 19:03:08 -0700
In-Reply-To: <15424756c16cb1ace48c1b8de6d99074e31d859c.camel@gmail.com>
References: <20240516230443.3436233-1-eddyz87@gmail.com>
	 <15424756c16cb1ace48c1b8de6d99074e31d859c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-16 at 17:02 -0700, Eduard Zingerman wrote:
> On Thu, 2024-05-16 at 16:04 -0700, Eduard Zingerman wrote:
> > This is a follow-up to the following discussion:
> > https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle=
.com/
> >=20
> > As suggested by Andrii, this series adds several API functions to
> > allow more flexibility with btf dump:
> > - a function to add a type and all its dependencies to the emit queue;
> > - functions to provide access to the emit queue owned by btf_dump objec=
t;
> > - a function to print a given type (skipping any dependencies).
>=20
> The series fails on the CI despite passing local testing,
> I'll submit v2 when ready.
>=20
> [...]

The bug was caused by a logical error in typedefs handling.
Do not mark typedef as ORDERED, always emit a forward declaration for
it instead. Otherwise the following situation would be troublesome:

  typedef struct foo foo_alias;

  struct foo {};

  struct root {
     foo_alias *a;    <-- foo->a leads to forward declaration for 'foo',
     foo_alias b;         if 'foo_alias' is marked ORDERED
  };                      foo->b will not traverse to generate
                          full declaration for 'foo'.

The patch below fixes error.
CI builds seem ok:
https://github.com/kernel-patches/bpf/pull/7052

---

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cb233f891582..7e845ad9ca9e 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -653,12 +653,9 @@ static int btf_dump_order_type(struct btf_dump *d, __u=
32 id, __u32 cont_id, bool
                if (err < 0)
                        return err;
=20
-               /* typedef is always a named definition */
-               err =3D btf_dump_add_emit_queue_id(d, id);
+               err =3D btf_dump_add_emit_queue_fwd(d, id);
                if (err)
                        return err;
-
-               d->type_states[id].order_state =3D ORDERED;
                return 0;
        }
        case BTF_KIND_VOLATILE:


