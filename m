Return-Path: <bpf+bounces-41570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B19987AC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C61C234A7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE841CB528;
	Thu, 10 Oct 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGj0Vpcc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C21C9DD5
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566884; cv=none; b=lg3+m3uREBeuyB5v5YLKA7ld3xxIEPT0ZTEqdCYFFP2533/3bs224USvGatWkumm/r2DK/Ld9nnJfmsie17oausTkdo593EKZ/nPlH1CpwwhGVWYDjmmWSmKCoVcVHFysz+icd5cqXOiCjhgO9SIhIHMgoAWrhx+UyT+bSzktK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566884; c=relaxed/simple;
	bh=M0zCY90Fb2hTp6ShOKR2m5jT/6bRMm1u3v6q53MlWnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEjQ7vEZ7/cJrtTQrUdSRrcIkTcnNOXpaSvs8dduZKlBGzWdrdS91DkHcogJXZDY4PPQuJD5Nw77UNMi/KpprCvcEpA7znm34AU/dGkdiPEATA4OyXEWy/UXGCDtfBVD/UbuFA4Z5afJQCHO+c/hWKVNZ8PR00ddelBRBpdAI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGj0Vpcc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728566882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24xFVhHpUbv0GxX3vB78a7ab9wcPKJu6tPdj/V0Z/DE=;
	b=QGj0Vpccwxc9KphIlWuIDgJlBTpNdvQsM1r7HpEa7wbwaLfBCLsSg5/qgZ7QLeP9h5pHfi
	l7MsynCD5WY6jhTUYXBDm7ISxmVQR9tPjvxjkjyIJ667ew9B8lQAZR5z2MpQdxZXdJhNkP
	AqCTs4k8EsaVJHRHhSna1jHaiJgU3eY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-rqsC7n_MP16sEfEEvNa8Tg-1; Thu, 10 Oct 2024 09:28:01 -0400
X-MC-Unique: rqsC7n_MP16sEfEEvNa8Tg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so5836495e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 06:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566880; x=1729171680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24xFVhHpUbv0GxX3vB78a7ab9wcPKJu6tPdj/V0Z/DE=;
        b=jQ6z72RIYw66CzzM2mCY9ow63puKvHc7IFhx8ykhLbSQC0g6SkbI6tivvCVreotjle
         UHLMtL4bcOGL9xds84KntSpOn6s2gVw/NWfxWDM1SSUrQI8icYb6L55M/HLDuv7Wkcs5
         bsFEbuktYvtYDHkjhTLch/5Cama62flvuDmRuCblsYkGz/Z2GXghmBx4x6DrMM3prEsO
         jotlVag3CCGbM8YxfgTgACaAS3jSY35nijjJ6QJzbK33poz5JBBOUWfFCwdJ8FuyvR5d
         yj+Yq0tNOeF0+F/dZerf8br9LBC3asSuZRIITuDeb0CW0TJ5SJLHXlrh2pnpvcATU2/z
         np+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkFYRngGxrNKDFJMPwBKJ0Ho04HegVThTacV78GLjnhXLcrkpMAcHclOjy9uOHUq6q4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzLMDqmAVuYHOi4debWF+2vmnqX3eYBQJcolYVmAqp+AYiw+g
	1Ql6vHWbxJdTdfLnIj7jbLhQvPEbRicTU/AAJCWi2IhgFU/Sb96YUWawN9y6H9sU/CtF9WZhcnr
	ceGHXJmYYSkaRaZOP1WbnQ78JZ5VGuzbBzVrZCwB1pXfLEq0OOg==
X-Received: by 2002:a05:600c:1c23:b0:430:57f2:baf2 with SMTP id 5b1f17b1804b1-430d59b7873mr53577165e9.22.1728566879849;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRcQowUIpMvvFM5df2r+5d4cDIMgcqXOBgEHWpeiYvZjV/0LhU38epcMkm/fXkByH0ybFumw==
X-Received: by 2002:a05:600c:1c23:b0:430:57f2:baf2 with SMTP id 5b1f17b1804b1-430d59b7873mr53576895e9.22.1728566879373;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d8f6sm16592475e9.44.2024.10.10.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3F47515F3EA1; Thu, 10 Oct 2024 15:27:57 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 10 Oct 2024 15:27:07 +0200
Subject: [PATCH bpf v2 1/3] bpf: fix kfunc btf caching for modules
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-fix-kfunc-btf-caching-for-modules-v2-1-745af6c1af98@redhat.com>
References: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
In-Reply-To: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

The verifier contains a cache for looking up module BTF objects when
calling kfuncs defined in modules. This cache uses a 'struct
bpf_kfunc_btf_tab', which contains a sorted list of BTF objects that
were already seen in the current verifier run, and the BTF objects are
looked up by the offset stored in the relocated call instruction using
bsearch().

The first time a given offset is seen, the module BTF is loaded from the
file descriptor passed in by libbpf, and stored into the cache. However,
there's a bug in the code storing the new entry: it stores a pointer to
the new cache entry, then calls sort() to keep the cache sorted for the
next lookup using bsearch(), and then returns the entry that was just
stored through the stored pointer. However, because sort() modifies the
list of entries in place *by value*, the stored pointer may no longer
point to the right entry, in which case the wrong BTF object will be
returned.

The end result of this is an intermittent bug where, if a BPF program
calls two functions with the same signature in two different modules,
the function from the wrong module may sometimes end up being called.
Whether this happens depends on the order of the calls in the BPF
program (as that affects whether sort() reorders the array of BTF
objects), making it especially hard to track down. Simon, credited as
reporter below, spent significant effort analysing and creating a
reproducer for this issue. The reproducer is added as a selftest in a
subsequent patch.

The fix is straight forward: simply don't use the stored pointer after
calling sort(). Since we already have an on-stack pointer to the BTF
object itself at the point where the function return, just use that, and
populate it from the cache entry in the branch where the lookup
succeeds.

Fixes: 2357672c54c3 ("bpf: Introduce BPF support for kernel module function calls")
Reported-by: Simon Sundberg <simon.sundberg@kau.se>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 633fd6da40c2460094b82ca7c2b9305eade05cf6..bf9996ea34fe1d80cef1c1ff3bbdb1030a976710 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2750,10 +2750,16 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 		b->module = mod;
 		b->offset = offset;
 
+		/* sort() reorders entries by value, so b may no longer point
+		 * to the right entry after this
+		 */
 		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 		     kfunc_btf_cmp_by_off, NULL);
+	} else {
+		btf = b->btf;
 	}
-	return b->btf;
+
+	return btf;
 }
 
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)

-- 
2.47.0


