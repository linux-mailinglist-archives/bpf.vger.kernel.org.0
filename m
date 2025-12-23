Return-Path: <bpf+bounces-77373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64205CDA1B9
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 18:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C20303D69E
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C16346E7A;
	Tue, 23 Dec 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dbJVK1ci"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437682FFDF8;
	Tue, 23 Dec 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510974; cv=none; b=DY+KqUZNgy3pjYrvr0/ui3CRATlRAwTQRjQzpGpHwaleaNJ0AITksmGmm1FxVMssZeY4cgnj5FcSDHgVeck0RhSNpt7xaVZ8q+VJNbWN8vDQioZFVx3zvE8IEgiKNqjtQPsImdgKb02Heneu7f2bHI61oT1qmju/WlSEbZS1bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510974; c=relaxed/simple;
	bh=ZnMNgOIJ96A3TljGb6Gjf1ywJrE3ikzcuoOhLH8WkI0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mYlZyL9gct2oZhUeQmBEnx7vHInO70DYxurJNccM0WETBT8NvoY16c5j8Tk8CTkfhk4MbZ5WDnlRwQFlH/Z9/9msPB3Z6lYPjfNOL5J/fwRqdwY3xCVLkBFsxHcVBFQWeWgL4Rw9HpjFdEPGkphuSxFQto9M/pmhWJyZy2xEPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dbJVK1ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B365C113D0;
	Tue, 23 Dec 2025 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766510973;
	bh=ZnMNgOIJ96A3TljGb6Gjf1ywJrE3ikzcuoOhLH8WkI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dbJVK1ciaKHHRK/29VJnkq+1MhARtI9KjDqmvMld4FXjdtp59K1OJPjOL7d1DTxWK
	 wJhgaPtpSfagISqSzNwxoc9rmZ2TskAJbzSMzfyukAMvfroDbUO8iCIHvteUEgJ75l
	 2VVev55R3S871W2NFc01T8rA4swhN5U9iEYfZImI=
Date: Tue, 23 Dec 2025 09:29:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com, Axel Rasmussen
 <axelrasmussen@google.com>, David Hildenbrand (Red Hat) <david@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@kernel.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu
 <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Omar Sandoval
 <osandov@fb.com>, Deepanshu Kartikey <kartikey406@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkman <daniel@iogearbox.net>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build
 ID
Message-Id: <20251223092932.0a804e046fc2e5de236ced69@linux-foundation.org>
In-Reply-To: <20251223103214.2412446-1-wangjinchao600@gmail.com>
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 18:32:07 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:

> __build_id_parse() only works on page-backed storage.  Its helper paths
> eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
> that do not map a regular file or lack valid address_space operations.
> 
> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>
> ...
>
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	int ret;
>  
>  	/* only works for page backed storage  */
> -	if (!vma->vm_file)
> +	if (!vma->vm_file ||
> +	    !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
> +	    !vma->vm_file->f_mapping->a_ops ||
> +	    !vma->vm_file->f_mapping->a_ops->read_folio)
>  		return -EINVAL;
>  
>  	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);

Thanks.  Seems this one needs additional paperwork.

I added the below:

Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Tested-by: <syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com>
  Link: https://lkml.kernel.org/r/694a67ab.050a0220.19928e.001c.GAE@google.com
Closes: https://lkml.kernel.org/r/693540fe.a70a0220.38f243.004c.GAE@google.com
Cc: <stable@vger.kernel.org>

and a large number of cc's which I scraped together from various
emails.

Could people please eyeball all of this and verify that everything is
good?



From: Jinchao Wang <wangjinchao600@gmail.com>
Subject: buildid: validate page-backed file before parsing build ID
Date: Tue, 23 Dec 2025 18:32:07 +0800

__build_id_parse() only works on page-backed storage.  Its helper paths
eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
that do not map a regular file or lack valid address_space operations.

Link: https://lkml.kernel.org/r/20251223103214.2412446-1-wangjinchao600@gmail.com
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reported-by: <syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com>
Tested-by: <syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com>
  Link: https://lkml.kernel.org/r/694a67ab.050a0220.19928e.001c.GAE@google.com
Closes: https://lkml.kernel.org/r/693540fe.a70a0220.38f243.004c.GAE@google.com
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/buildid.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/buildid.c~buildid-validate-page-backed-file-before-parsing-build-id
+++ a/lib/buildid.c
@@ -288,7 +288,10 @@ static int __build_id_parse(struct vm_ar
 	int ret;
 
 	/* only works for page backed storage  */
-	if (!vma->vm_file)
+	if (!vma->vm_file ||
+	    !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
+	    !vma->vm_file->f_mapping->a_ops ||
+	    !vma->vm_file->f_mapping->a_ops->read_folio)
 		return -EINVAL;
 
 	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
_


