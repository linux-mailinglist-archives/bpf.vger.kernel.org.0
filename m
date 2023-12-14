Return-Path: <bpf+bounces-17841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D558134DC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80711B20FED
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D25D4A3;
	Thu, 14 Dec 2023 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lxo++t2a"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C38E
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FMAOgPz6rYSTZVr/rBOgLg+IV5i2iJy9HhOeFZkiel8=; b=lxo++t2aVEirB+YnTI8gqpCCsB
	ymTBYOtnqwThOOC+q/ku5PZw/JvJZonREOKITR6Gn4vOECtIUgfdnNcgsK4UTmpS5uKgaAzjUjmNI
	VM93HDLY3D/USEFkp9yAVbEmxXGl2164cA2xagjwBxGS7bNtZJap1jXwKyIusj5awVWZUBEAL4VPa
	rURDlrA29C/2ZV5kzbO4rHc8e5FYpqeAw0LyHZeBP/1iWu8kCWba7VEPNsQ43K3bkvSb4k0oSM8Lw
	GAoiINQuckwVNPKzblcfDcGGWlKb1Jm5EY25WMaGlP5msQRkjDvaYxFoMWF9ReFdxVuteVNllXv2Z
	HOQBjobw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rDnjV-000LFw-17; Thu, 14 Dec 2023 16:34:41 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rDnjU-000Bjh-Pb; Thu, 14 Dec 2023 16:34:40 +0100
Subject: Re: [PATCH bpf-next] libbpf: Fix null pointer check in btf__add_str
To: Wentao Zhang <wentao.zhang@windriver.com>, ast@kernel.org
Cc: bpf@vger.kernel.org
References: <20231214075037.1981972-1-wentao.zhang@windriver.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ca122e6f-19dc-d319-54f8-75e1dfa988c3@iogearbox.net>
Date: Thu, 14 Dec 2023 16:34:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214075037.1981972-1-wentao.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27123/Thu Dec 14 10:37:47 2023)

On 12/14/23 8:50 AM, Wentao Zhang wrote:
> The function btf_str_by_offset may return NULL when used as an
> input argument for btf_add_str in the context of btf_rewrite_str.
> The added check ensures that both the input string (s) and the
> BTF object (btf) are non-null before proceeding with the function
> logic. If either is null, the function returns an error code
> indicating an invalid argument.
> 
> Found by our static analysis tool.
> 
> Signed-off-by: Wentao Zhang <wentao.zhang@windriver.com>
> ---
>   tools/lib/bpf/btf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index fd2309512978..a6a00bdc7151 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1612,6 +1612,8 @@ int btf__find_str(struct btf *btf, const char *s)
>   int btf__add_str(struct btf *btf, const char *s)
>   {
>   	int off;

(nit: empty line after declaration)

> +	if(!s || !btf)
> +		return libbpf_err(-EINVAL);
>   
>   	if (btf->base_btf) {
>   		off = btf__find_str(btf->base_btf, s);
> 

If feels a bit off that in this library helper function we'd validate the inputs
but not in others. Alternative could be :

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 63033c334320..18574fc017d9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1735,6 +1735,7 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
  {
  	struct btf_pipe *p = ctx;
  	long mapped_off;
+	const char *s;
  	int off, err;

  	if (!*str_off) /* nothing to do for empty strings */
@@ -1746,7 +1747,11 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
  		return 0;
  	}

-	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
+	s = btf__str_by_offset(p->src, *str_off);
+	if (!s)
+		return -EINVAL;
+
+	off = btf__add_str(p->dst, s);
  	if (off < 0)
  		return off;


