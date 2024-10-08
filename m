Return-Path: <bpf+bounces-41240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50120994584
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B241C208F2
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDE1991D5;
	Tue,  8 Oct 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZl1aDcZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AFEEC8
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383740; cv=none; b=RfwdcsqFjN0xz9nbqF4N650cXj9KjZXpA3Z51cbd9qkEwpT+pee11nnubFS3unVlxP/mTvwiiDSTbzZ6Jr1X5bkuiVDEiFOvqs2+QAJxu/L7gbGmK+JrnsFuRMRq/MgFR7/YvYtf0nQxduRin6Px2P0IRLsNan494diTkNN7P9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383740; c=relaxed/simple;
	bh=OmSFPyqvPVkxATiYmTbkwLh3Q0HSISFPeLYjnAwWPw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nevaOKesLpG3vhjaiJrhqH+kPBPozAMN/MnYvTi/TH6vKgPqOSsBALKvW9X/HSxuoG0pe78IRz0JvqyBZvPYgGj657ljP3p1/aYkO838ZcfUhHIb4cbgdy/AkUZ2tEGKnzHhbGUghbAlqHMsVT/UynqvzTfHtAqek7IA4QMtSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZl1aDcZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728383737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=capTNDvn+70iFKKklusZCvfnkrYKBtdVOceaNvnI7Q4=;
	b=JZl1aDcZ8mFzHq2nIHTD7og5HnnT7v38Jz3DpiL7JYAYD0+nqw1Qx4WJBugrkyjtt8kvDB
	UzjrB5fOq3Q+4qJy5LwEgMlqSxtTZSm3ORk1yyQ/WZfd+f9fNIHomGt/RdbcvoVik2cb48
	iU2U10v+7e8Key79kY1wlbKlkIgLg28=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-qur9o8TqN5u_2EbZlU4Pjw-1; Tue, 08 Oct 2024 06:35:36 -0400
X-MC-Unique: qur9o8TqN5u_2EbZlU4Pjw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a996c29edaaso51584066b.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383735; x=1728988535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=capTNDvn+70iFKKklusZCvfnkrYKBtdVOceaNvnI7Q4=;
        b=ox6DIISEdvBO+ArggOYm1ea++1uLXA/xJyN9ksqN9moYjg5cxOXDTUbd/a3TvrVdC5
         EvttmthOxyoH264rea+P5GATByI+2FhPimY35tRob7CnOE1/JCtMPVFEFniW5dqVGGQv
         evmx380Equ1jAEA7l/C1vtjD1bvhEaJ4NMeyCR+sPN3N0ViC9Oeuaf+OxITR2faT/u/F
         wYo8Z8n+p86UJaX7MT6clY4zeu5PWzgG7wTFml6OPeN8Q8tm12vt4Td1r/aDjB0C/j34
         1l3HzUak1tmNt1M8RmhZCbek4BPy57OXKG2xgq9m/kWcuBYTGDXn2A/t5dM467wKeylQ
         CnYg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZkOhPvyJuZhPZA2FD1A5t4MaoUAg1rB9Yx6Buy9zwubsYMc9cSuKCpjfYUbMmUcsDQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeXi5b6e66D0ASuzEB8NCmbe/vziXCB/izC1L1KccI08PI29H
	K1SUCzArCASRNHXGhIHM9m/2czzpBJO5h5cFXHkf5ESSTrDVfe3VvQZdAsfE0EJoO67nNRC2Br6
	YwG5P97dlsKGxtQFcurLB+oSXRlN5KGE0i21rNlWwgBIvAPAQrA==
X-Received: by 2002:a17:906:6a1e:b0:a99:742c:5a6 with SMTP id a640c23a62f3a-a99742c40ebmr152254366b.10.1728383735173;
        Tue, 08 Oct 2024 03:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaGmneNO1vkNK9dFBBZXU+fP09aOxCjof0xbAj01qtmJroR79Ltjys231sET0EGN/eEkZrPg==
X-Received: by 2002:a17:906:6a1e:b0:a99:742c:5a6 with SMTP id a640c23a62f3a-a99742c40ebmr152252066b.10.1728383734795;
        Tue, 08 Oct 2024 03:35:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993657f469sm462729266b.223.2024.10.08.03.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:35:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EB1F515F3AD7; Tue, 08 Oct 2024 12:35:32 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 08 Oct 2024 12:35:16 +0200
Subject: [PATCH bpf 1/4] bpf: fix kfunc btf caching for modules
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-fix-kfunc-btf-caching-for-modules-v1-1-dfefd9aa4318@redhat.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
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
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 434de48cd24bd8d9fb008e4a1e9e0ab4d75ef90a..98d866ba90bf92e3666fb9a07b36f48d452779c6 100644
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


