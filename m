Return-Path: <bpf+bounces-21053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6E8470D6
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B3A2905DE
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C25235;
	Fri,  2 Feb 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKsg/W6K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D61874
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879207; cv=none; b=Psq0ID7Mc1dwIx0+kUPbucyUS2fWHcgYERenYxTNN5/U3hX//GqvUFXZdY4sg1EXLEe0BkqZ+/s6HyMzuI77zL74zH0IFkib+iodZ1461TZmc7d+1JOihjVFEooJsnuq0R0Cw+W57YOCyb1tMyXyxhhJzeRMXHJ0sf0BvUtdkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879207; c=relaxed/simple;
	bh=M2dVabOscfCZzwJa42t/nHgY8bie+Vgj9Y5OptXX42k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO/mZYJve4pW84MrR5vh/W0xtQvZSJQ5D+CVoMCWgPEh0UJYDMkizBHfPGhWJ65G8ePyVssURXE3hv3b8pMvvXM3VmzvzosiaaV+PLFcC1z6AlL5ctmmT75Qo310HUgFYkYBAX/af+r4vtc13TnowAzHO7pzwtWgUwqAyy8wNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKsg/W6K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so18676315e9.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706879204; x=1707484004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxgjSIhK6TY3tURR0sYONrz51FDIuUpqG9htpTN/d7I=;
        b=IKsg/W6KcaRWZ0t/DK4dgssR7VBQa9Ja5AFRHBrTVcX2f3Pbt/FCM4fs7U/BrN6sO9
         TCX3NAL1xkHcy1tiP0+A/78l1DmMlJUUsuUPuscWhotEONo0jjUyytKvX405am45JdzY
         yNeZDAQ4qm0saSwlHKYlhtY6d6qiXe0Tu4rxmCMEkRz1++JJEQSXGGTC1q0+Z4QxNO8m
         EREq/KfpZz79HQHGKpjPETImkXj8vNqx9q7at1CKw5od6XrdkrRxVqFAT5eKlBTZA6N9
         P+l45viZrED9norZlIoxy/7+faWVU1YZABGu08qdJNOtXm7dCiV2WuKgqGud6uJJW7t6
         M/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879204; x=1707484004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxgjSIhK6TY3tURR0sYONrz51FDIuUpqG9htpTN/d7I=;
        b=M7ol6mHjOB6mpZMfVOmHx+5QyLWQ/o8CblbkWrVbrgGYADfI9sVp+tXRNTe2wsae+q
         KdFIWG9r8R5IUiqc2KkFqAMJjH/IQDuitmzUg7MYcsgx7EHoIUj9h5u1prbrd7sE2pCZ
         xcZFcL7Ovx25vgieaot0UKm9Cwl5CBiaMpPQE2oxX9Jch3m7kijQvOUugBsWz/kQqyhR
         ZL3YpwjX/iTirKcM7QSfv1vC6TOMOUCAe77tPR5tZMjQ0jN1bLeOkYN7N7wz9Tl9ZS0q
         oiwDOAXj+bEusEbPkOFoXHJIsWqROySMlUjeBOuoX1RqE7MSHFvjXJyVKPZkX6DCQSnI
         RVrQ==
X-Gm-Message-State: AOJu0YycuWvQeFsvsNTJne9RyD4ot91Wi+eE6UNLYUi5lyBr7v8wz9oK
	rSJrr3wTbR277BVnx+uYgkaLNuCzLj32N3Lrr4VN9awvmVyLwOjl
X-Google-Smtp-Source: AGHT+IEAFnzBbpw0A9sxiIQi/2ay0JUMHIivPlLbGtHyeJJq/6jKBPnyL0vJYxCNtP6XFhG8Tv2ENw==
X-Received: by 2002:a05:600c:198f:b0:40e:c06a:3ed5 with SMTP id t15-20020a05600c198f00b0040ec06a3ed5mr6717530wmq.2.1706879203563;
        Fri, 02 Feb 2024 05:06:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFgWROC6VCJ8AmaOITPbkio3u0KuVVLApfig95nYPVK71+mne9u+WLuzraQEp75jt75f0+n9wRQlJ3LXA2JGLZebJ46KwHcsp1ae6CXRinIhj/U3km7mgEhaAwe0LmLOK3+fBitH1RUxxyXPFoUbmpsQA7kL8Lz9XPTeghc/z0Q7lFF1OdMJJaNYtEVJJo3H+L/Cb3mhMJA8B1+kfXEyVVzJxUnX+ZEdFzTrWfGA3g0/dgRRib8RFOYnUJVJabcyDTsuCteYZiNhuD3aXTqeUtfV8EEOGZOG9FFH2VSTZQkyePXxd4vhU0iFHZsWZB+dTYxnQ/m36nMCQfBsAIKblXCYllGpJ0VfwtR3sv2A+JZ9PZ2k527IjFQiwftyYQgAdAXHetN81egR+wOAMIVLFhbxH8DBjxhykiYLcECbJ1Zd0Kra1kBnkjZ2P3NhA=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b0040eef7ec053sm197440wmb.0.2024.02.02.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:43 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Feb 2024 14:06:40 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
Message-ID: <Zbzo4HBVmmkikbhO@krava>
References: <cover.1706717857.git.vmalik@redhat.com>
 <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>

On Wed, Jan 31, 2024 at 05:24:08PM +0100, Viktor Malik wrote:
> Instead of using magic offsets to access BTF ID set data, leverage types
> from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
> layout of the data. Thanks to this change, set sorting should also
> continue working if the layout changes.
> 
> This requires to sync the definition of 'struct btf_id_set8' from
> include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
> the rest of the file at the moment, b/c that would require to also sync
> multiple dependent headers and we don't need any other defs from
> btf_ids.h.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 30 ++++++++++++++++++++++--------
>  tools/include/linux/btf_ids.h   |  9 +++++++++
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 27a23196d58e..7badf1557e5c 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -70,6 +70,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#include <linux/btf_ids.h>
>  #include <linux/rbtree.h>
>  #include <linux/zalloc.h>
>  #include <linux/err.h>
> @@ -78,7 +79,7 @@
>  #include <subcmd/parse-options.h>
>  
>  #define BTF_IDS_SECTION	".BTF_ids"
> -#define BTF_ID		"__BTF_ID__"
> +#define BTF_ID_PREFIX	"__BTF_ID__"

nit does not look necessary to me

>  
>  #define BTF_STRUCT	"struct"
>  #define BTF_UNION	"union"
> @@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
>  
>  static bool is_btf_id(const char *name)
>  {
> -	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
> +	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
>  }
>  
>  static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
> @@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
>  		 * __BTF_ID__TYPE__vfs_truncate__0
>  		 * prefix =  ^
>  		 */
> -		prefix = name + sizeof(BTF_ID) - 1;
> +		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
>  
>  		/* struct */
>  		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
> @@ -656,8 +657,8 @@ static int sets_patch(struct object *obj)
>  	while (next) {
>  		unsigned long addr, idx;
>  		struct btf_id *id;
> -		int *base;
> -		int cnt;
> +		void *base;
> +		int cnt, size;
>  
>  		id   = rb_entry(next, struct btf_id, rb_node);
>  		addr = id->addr[0];
> @@ -671,13 +672,26 @@ static int sets_patch(struct object *obj)
>  		}
>  
>  		idx = idx / sizeof(int);
> -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
> -		cnt = ptr[idx];
> +		if (id->is_set) {
> +			struct btf_id_set *set;
> +
> +			set = (struct btf_id_set *)&ptr[idx];
> +			base = set->ids;
> +			cnt = set->cnt;
> +			size = sizeof(set->ids[0]);
> +		} else {
> +			struct btf_id_set8 *set8;
> +
> +			set8 = (struct btf_id_set8 *)&ptr[idx];
> +			base = set8->pairs;
> +			cnt = set8->cnt;
> +			size = sizeof(set8->pairs[0]);
> +		}
>  
>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
>  			 (idx + 1) * sizeof(int), cnt, id->name);
>  
> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> +		qsort(base, cnt, size, cmp_id);

maybe we could call qsort on top of each set type, seems simpler:

 	while (next) {
+		struct btf_id_set8 *set8;
+		struct btf_id_set *set;
 		unsigned long addr, idx;
 		struct btf_id *id;
-		int *base;
-		int cnt;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
@@ -671,13 +672,16 @@ static int sets_patch(struct object *obj)
 		}
 
 		idx = idx / sizeof(int);
-		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
-		cnt = ptr[idx];
+		if (id->is_set) {
+			set = (struct btf_id_set *)&ptr[idx];
+			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
+		} else {
+			set8 = (struct btf_id_set8 *)&ptr[idx];
+			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
+		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-			 (idx + 1) * sizeof(int), cnt, id->name);
-
-		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
+			 (idx + 1) * sizeof(int), id->is_set ? set->cnt : set8->cnt, id->name);
 
 		next = rb_next(next);
 	}


jirka

