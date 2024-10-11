Return-Path: <bpf+bounces-41776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0368199AAFF
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9713284310
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB20F1C8FB7;
	Fri, 11 Oct 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qku9Teqc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA728BE5;
	Fri, 11 Oct 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671626; cv=none; b=DoOq5l9Wyp1pJKTc5yIcr4+hkxm2DqXhUJ4WGc7cAbia0w6NT7xcSa17qmXtX5pf9MfIOYhV+pNj1n1yMS6UP4C/oLRAWC8c+JP7UIx0jq22NrrS+Qy5kxfdqTn9lEwhYz/gUBdnXlj3lnOF8hkrJ5U+QlH7/L2YUlff0xTTssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671626; c=relaxed/simple;
	bh=VA3dR8RjM/E+LCE1ff8cMx7LD1WV2SPf4KkoFi7tZhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttg+1Wk6vPKXAypWQeuZkb2Fx6FsImts41jwfrjjMutc6odmfcPRZR/JP5mvtuUmUcoU2QjHBWLs9A33UzlViqAKKyBg1RYS8bV06TuY4Rtw/YrLwWCw2PqHjbfiO9tVNOwLaN73WfoU+ahlH7g6uFO664JYv9EFQNPWrjMFk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qku9Teqc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so1318336f8f.2;
        Fri, 11 Oct 2024 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671623; x=1729276423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zqw+eRG2MYmG15ACoCDgCZaSTwDwa5xCdf5S5ibxmN0=;
        b=Qku9Teqcrun6DBmOlN8D5Obq7KPspWbt/6Ct9nBmnslocng+TYbHrSahcOfxmdD852
         j4O9fhzNODDWZeHI8ClesrM5gwOBnebZ9wgrQOaXjG424rcegi6OudgvHGwrLtg2EB1o
         eGABkuZUKIxWuVL0kUnmESmC3IG5JXaRoJjR7ocRj8AJEhZOYx0SDWWkLkQSSM9NvcjC
         YuZEn9GX/L29ccUBSrg561K8vRVu/xw3y9ztbacDAyh5W68Ulgqy4trMVEfHnmHyru8s
         U1ltqxbm9xh/io+GsCWhXbfiYIyDZ2NKEjW4PIEex85EfVC3Fc5ufcklhRA4YqR4V9jZ
         VMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671623; x=1729276423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqw+eRG2MYmG15ACoCDgCZaSTwDwa5xCdf5S5ibxmN0=;
        b=rH6ANvFSYBFm+uHI79FVrh7L5KEWnVMTVf7pWGxcNN+voa5y61PjqZ4TZqOHpfL9sv
         Ovl4BP22s1JQ6vEKyf5upNNT+aZell0lxPuCzQIwDgD9ZEXedSjvXOPu64nBm2Hp2B5S
         vuo/USkhxM95vcC/FAtf18jar/zsQ60FnpO70WKLdnP7lDDVkPsCku8WWLjeV36KSKHu
         nO2fUndpSU9pGmiIlQT3Swv9UXBTyTLIfsxsEKDLL9SqxWYANNgLvVEON6umoyp/U4yY
         Um40XryEGbkeOAhxELIs68WOgiuMfm9vGZDELnZ0nFWeOP1BJWFtyy0cyI56JrXcwNh1
         hIwA==
X-Forwarded-Encrypted: i=1; AJvYcCWQfX504TJO9WWed1skbhNjsAnh227cme8ixETI06yeCFjaHlNY/iSvY/qD5NkDwNkky4GkyoqVAtkgj3sr@vger.kernel.org, AJvYcCXL92y47BKkZ0dGP9/wF5tMFavNvB694T9UT/8hPksahcUGbjCNYGeqwk7jQKVnuBul/uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQFfaYk1KfQcvTTGdq45UXhBoL1wpIyaLhsPXNORoFCZLGZ/F
	UO1i2OY6IMlDb8cAO3NBtmVsBKsVYJt6N+jCvYJ0zFr7QnzKdWHCKHEToyvwu74NbQRLE+cPpWf
	sylsN2z+iz0RPfbbWs94f/T2Uyxs=
X-Google-Smtp-Source: AGHT+IGAj/SGj+TtqfRfGd2P3lWGKqlm+1DElS1k2FoqBelgBt3R6bLLn+m/l+x2AOLBP39wrsRkToxZgrWVZPQClGI=
X-Received: by 2002:a05:6000:18a:b0:37d:41c5:a527 with SMTP id
 ffacd0b85a97d-37d5feaa088mr342022f8f.13.1728671622794; Fri, 11 Oct 2024
 11:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-2-namhyung@kernel.org>
In-Reply-To: <20241010232505.1339892-2-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 11:33:31 -0700
Message-ID: <CAADnVQ+5hq0g3K6B_uPWg4AzrTjus0kKyqtgd1-UyME9TPZL-w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The new "kmem_cache" iterator will traverse the list of slab caches
> and call attached BPF programs for each entry.  It should check the
> argument (ctx.s) if it's NULL before using it.
>
> Now the iteration grabs the slab_mutex only if it traverse the list and

traverses

> releases the mutex when it runs the BPF program.  The kmem_cache entry
> is protected by a refcount during the execution.
>
> It includes the internal "mm/slab.h" header to access kmem_cache,
> slab_caches and slab_mutex.  Hope it's ok to mm folks.

What was the reason you dropped Vlastimil's and Roman's acks
from this patch while keeping them in patch 2 ?

Folks pls Ack again if it looks ok.

I'm ready to apply, but would like the acks first.

Also I'd like to remove the above paragraph
from mm/slab.h from the commit log.
It was good to ask during v1, but looks odd at v5.

