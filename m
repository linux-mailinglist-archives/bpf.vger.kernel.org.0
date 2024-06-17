Return-Path: <bpf+bounces-32353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4990BD83
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C328287D
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5D19923B;
	Mon, 17 Jun 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX4IhxYt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D56187575;
	Mon, 17 Jun 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663234; cv=none; b=CjVynzI/7exsdG/jURxCsBj1g/nGGmi1CLDUWs2CET5IRLaTo53K2SSzgCm4zPWzImVJrWy7uxzOfVHmsYiAr/zGv5KAsTvHoiHiBQwJVBY36zgzXP2hxYS6tyUYmicbudmwbn2jeXECytUvBtVuFhAZE4MDzxLyAXMol0SQA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663234; c=relaxed/simple;
	bh=3iFsARL3S0u51tZXSvcuDEE7s7I+2Vu/dLJZTGzXwa8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciWhNsoTo3R1lj8YOAtZBoP2YQ+YNdTto2aRaJ33MrqjttSctn356ESO8GC6wAASE43fVrCDGFXVaSNk2wW1Z349/PlebqE5G7Kbyf8vjsSN3CcgdSxe7gyB54dn4bAy4Z9qvdYAObfjEATE3CkuswfmQUyRyhAX0h7CsFpcQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX4IhxYt; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25528eb4078so2707287fac.0;
        Mon, 17 Jun 2024 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718663232; x=1719268032; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMBjT8Al2sD0zx/2TxbjsA/q14tPjnRqGNYkshyClzw=;
        b=nX4IhxYtwxuZ4E4eI1osbYmhUz/JmUSE1lSh51hVqK+Pd7E/mOiBnE7UENZlubamnM
         cGr6dYB3qa3XTRVGAHEB4xhFVlzEvV+y5hL7mJn0gpOLe6XzY65k6QTQlNbdengBzPn7
         i5efElaYx0s2E+uvvKSJBDRQtMojygYDY/eyRpg/BoUoB3UoFhxBqpNX0cCfN81BJiJd
         OofL4GUwZL14fIP/AqdbmQMqbZOzFuNnFoDCX3MD1gclM5owYPTsOHe/weG7GBwQy0en
         irNqPKKw/YAqzupCxL1kIPBLzklG5+j/r52pQW6M4VHSxAPq/lrG5czPg82NBCyEZton
         g7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663232; x=1719268032;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMBjT8Al2sD0zx/2TxbjsA/q14tPjnRqGNYkshyClzw=;
        b=X0NwMJfj3muF6yuYLTuOFZyyewi9I8SdFjTSOjelpmKjwuBxHFMJBdKS8weYk9WvnJ
         ZPs8fbFuWcDBl7re80UlspP0UbiZ1n8ETDXbpOzb4qeUJ+YJn3RGV5+fd3jy9g/FNvgr
         K7u3zFnAAnnVwJlCAEugDuGpjGNt1duBrde50CA2EtvT6WLuBdJy8Hyvkyujxowhjdwf
         fTz5yxfcpsZfBB4s2lKmO+2OrdHxkIxUGM0gNH8x0DqOtHkn7oqIFEFENkl4UnmJVO7i
         6aI4qVceBcR38D6H/TVc3T4epXmEG0aUfzcmdftYnDSvAGKQt/zFQfRUNmiRKMu+N5vX
         ltcA==
X-Forwarded-Encrypted: i=1; AJvYcCWNzRtItkKEduROInAbTPIM9uNKTIjGbuK78G+ObVvTSC3F5zZCV+NlOI5nrdQ30fmfHbaFelN1ZYKOQz1SicjREBxFUBf7+nLwVtMUvYJipy+sbu/QZm6/1sphw7jxxTDF
X-Gm-Message-State: AOJu0YwxpGCG8l+LPapeuk7cSiQr/VT9KdP6H8fXrQup85OZftJrPCVr
	b4xBxkmMu/dHuLZ2p8kB9VPWZgpg2mPf33WEcp5LJv3AtmnnNbUgMgHUb/bY
X-Google-Smtp-Source: AGHT+IHQgXV5vsXoGAY6eP8vT70v2iSUJ4ltZh8KlMaRRxRmPodtK0jK6KJ9dJZJHmZ+nELl08vF1w==
X-Received: by 2002:a05:6871:890:b0:24c:bbe3:c567 with SMTP id 586e51a60fabf-258428f76e1mr11680225fac.18.1718663232413;
        Mon, 17 Jun 2024 15:27:12 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb9195asm7804858b3a.209.2024.06.17.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:27:12 -0700 (PDT)
Message-ID: <90031b58d659e359aaf569565d40757b63a6b72c.camel@gmail.com>
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii <andrii@kernel.org>, acme@kernel.org, 
 daniel@iogearbox.net, mhiramat@kernel.org, song@kernel.org,
 haoluo@google.com,  yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 17 Jun 2024 15:27:07 -0700
In-Reply-To: <66e5356f-6b92-450c-b57e-7a8644a80ebf@oracle.com>
References: <20240608140835.965949-1-dolinux.peng@gmail.com>
	 <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com>
	 <CAErzpmsvvi_dhiJs+Fmyy7R-gKqh3TkiuJCj4U5K6XXJyV6pJA@mail.gmail.com>
	 <CAErzpmsBBnGNEgBzUfZyRcSeV1KLuNKvFfhuCap6NFbxG=qoKw@mail.gmail.com>
	 <66e5356f-6b92-450c-b57e-7a8644a80ebf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 15:18 +0100, Alan Maguire wrote:

[...]

> If the plan is to fold the sorting into dedup, pahole will inherit it by
> default I suppose. Would it be worth making sorting optional (or at
> least providing a way to switch if off) via a dedup_opts option? If we
> had an on/off switch we could control sorting via a --btf_features
> option to pahole.

I'd avoid adding more flags if not absolutely necessary.

> One thing we lose with sorting is that currently the base and often-used
> types tend to cluster at initial BTF ids, so in some cases linear
> searches find what they're looking for pretty quickly. Would it be worth
> maintaining a name-sorted index for BTF perhaps? That would mean not
> changing type id order (so linear search is unaffected), but for
> btf_find_by_name_kind() searches the index could be used.

Instrumented kernel code as follows:

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -555,10 +555,13 @@ s32 btf_find_by_name_kind(const struct btf *btf, cons=
t char *name, u8 kind)
                        continue;
=20
                tname =3D btf_name_by_offset(btf, t->name_off);
-               if (!strcmp(tname, name))
+               if (!strcmp(tname, name)) {
+                       printk("btf_find_by_name_kind: kind=3D%d, name=3D'%=
s', id=3D%d\n", kind, name, i);
                        return i;
+               }
        }
=20
+       printk("btf_find_by_name_kind: kind=3D%d, name=3D'%s', id=3D-1\n", =
kind, name);
        return -ENOENT;
 }

And analyzed the log generated when test_progs are run.
The summary of results is as follows:

| # of lookups | kind | name                | id     |
|--------------+------+---------------------+--------|
|         3480 |    4 | bpf_refcount        |     -1 |
|         3439 |    4 | bpf_rb_root         |     -1 |
|         3434 |    4 | bpf_rb_node         |     -1 |
|         3340 |    4 | bpf_list_head       |     -1 |
|         3339 |    4 | bpf_list_node       |     -1 |
|         3165 |    4 | bpf_spin_lock       |     -1 |
|          759 |    4 | foo                 |     30 |
|          659 |    4 | bpf_cpumask         |  65569 |
|          194 |    4 | prog_test_ref_kfunc |  29619 |
|          146 |    4 | bpf_spin_lock       |      8 |
|          123 |    4 | bpf_list_node       |     31 |
|          123 |    4 | bpf_list_head       |     11 |
|          116 |    4 | bar                 |     38 |
|      ...  59 rows, 10<N<100 lookups each ...       |
|      ... 227 rows,    N<10  lookups each ...       |

(24680 lookups in total)

I'd say that 'bpf_spin_lock', 'bpf_list_node' and 'bpf_list_head'
could be considered as types that would be found quickly by the linear
search. Their total share is ~1.6% of all lookups. I don't think we
should add a special case for such low number of "hot" cases.
Also, the share of -1 results is surprising.

[...]

