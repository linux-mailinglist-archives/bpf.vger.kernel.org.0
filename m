Return-Path: <bpf+bounces-38719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA0968C59
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EA61F24EA6
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA71AB6D2;
	Mon,  2 Sep 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a2uV9FV5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF11A304B
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295599; cv=none; b=jK0TnGRV/B9QuMLVPp8Bw6yZf6i6Wpd43TLdWfH2UIEUCoM8plq1KZOGQ5dgYWKT94N77tmuMd0SSGWMVaCSTDzg5f+7jNmIiszaid2YfR9RAv38zJApAXlwCehMUWqdrFl+zV9GGwB4IuGVTjBxlmqCZbUkJYOocdIduHYP3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295599; c=relaxed/simple;
	bh=zMMELN1tE6E74O3xxtbGC8H4TJHSm99WgSTsodREiy0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=egZJQz0Yruz6W7R2/NIqxFjJKr1aUg1SSl7IKRizreS4RYXg2vGyOpPdstzTICazGXh0mb1ucOeWCbCkTr5xNfy5/LOWtVHuaqjyICyWTzXgoy3Wgq51Qso1yHdq1EaP4OtCQTBcFOdKYSiLjZ46Jsvd16yUm2R2kmvu8QN8jXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a2uV9FV5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mf3A9kaJmW9sPh7iaDSb+UdmTGwpgzuAgCAWQLf56ZE=; b=a2uV9FV586p0w4pdTfiFleXb2/
	YRU4gUaXSELOJr0jGu4EQnvZPs844rAQtDHNhrkZK55O3S88EBdvLpP+VnseUpmk3zBgji42H0nBC
	vI/x+L5vy22umgeC81FfqO17wxQ3MRsLjuZMpfIQdMzjyqlJCH3hL0QdNSIBvVu0LWoH26qC9e0Ap
	vZe6/eGWDGTaau8UDnMP8OuRF3q1ayjuraAMIxWAf3IJ4UqtWmIjDIIk51elaF968phv9GJQ1nbjj
	VxFFiKaZrDLEvulJi54uDoQDB2+qo7nOjNlmlzsOuEAJ3NPrtRmMDZ9/EgmVd0JuOtgnfyP2sNNxl
	fkTFgp4g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sl9pG-000Htx-Hl; Mon, 02 Sep 2024 18:22:46 +0200
Received: from [178.197.248.23] (helo=linux-2.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sl9pF-0001lv-1R;
	Mon, 02 Sep 2024 18:22:45 +0200
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
To: "Mykyta Yatsenko mykyta.yatsenko5"@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240901213040.766724-1-yatsenko@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
Date: Mon, 2 Sep 2024 18:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240901213040.766724-1-yatsenko@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27386/Mon Sep  2 10:35:36 2024)

On 9/1/24 11:30 PM, "Mykyta Yatsenko mykyta.yatsenko5"@gmail.com wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Wrong function is used to access the first enum64 element.
> Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   tools/bpf/bpftool/btf.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6789c7a4d5ca..b0f12c511bb3 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -557,16 +557,23 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>   	const struct btf_type *t = btf__type_by_id(btf, index);
>   
>   	switch (btf_kind(t)) {
> -	case BTF_KIND_ENUM:
> -	case BTF_KIND_ENUM64: {
> +	case BTF_KIND_ENUM: {
>   		int name_off = t->name_off;
>   
>   		/* Use name of the first element for anonymous enums if allowed */
> -		if (!from_ref && !t->name_off && btf_vlen(t))
> +		if (!from_ref && !name_off && btf_vlen(t))
>   			name_off = btf_enum(t)->name_off;
>   
>   		return btf__name_by_offset(btf, name_off);
>   	}

Small nit, could we consolidate the logic into the below? Still somewhat nicer
than duplicating all of the rest.

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6789c7a4d5ca..aae6f5262c6a 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -562,8 +562,10 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
                 int name_off = t->name_off;

                 /* Use name of the first element for anonymous enums if allowed */
-               if (!from_ref && !t->name_off && btf_vlen(t))
-                       name_off = btf_enum(t)->name_off;
+               if (!from_ref && !name_off && btf_vlen(t))
+                       name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
+                                  btf_enum64(t)->name_off :
+                                  btf_enum(t)->name_off;

                 return btf__name_by_offset(btf, name_off);
         }

Thanks,
Daniel

