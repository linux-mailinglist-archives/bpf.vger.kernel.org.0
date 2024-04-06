Return-Path: <bpf+bounces-26106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A089ADA6
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077E51F217C0
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 23:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83557887;
	Sat,  6 Apr 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf++4iTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233154E1BC
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712445539; cv=none; b=Qsoy1pDNt/MrM+FgLryjthP+UQzWfsfNseAyKF8y/popLp4bQXCqkqTZ4bPvaGVZsYMyzMGdQOWocu2KH/qc/aqam8KfO8LXV/SDVOOFnp0F7VW7jlMA/7wyupm3pcsAUsPW9WPzma7Vcgj7aBNgwirT1k72kLNBRa2KlKfCvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712445539; c=relaxed/simple;
	bh=YdzUXeUXLngHSLkIhFP25b0ONK+xDBHaGKXOHXdWbFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M99yqJwGVbgKtra/B8PduYLi7KwTEIQnncZPlrjNlKUTEN35HWbPK8JR9Wx03J8cL5zaGrDiKKbYq5XLBoehD14ylKPw6/ZG6cf0GN8rQ+/jIpkgG6Ts20lccZycKPe7ANGYXnTSNxO6e6PXMU3D73WlE/PvKDxomGMeK4wcPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf++4iTM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4164e7bd4c3so1756285e9.2
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712445536; x=1713050336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HBGTEAzKZ36twFnYaQSTfe0UPMpT9D5T1eTdXOE/7M=;
        b=Mf++4iTMn8hmwBpYA521soGhT5+Rm4H8E2eWmpiDOtSL5MJavITvrudGQwMZ251jA5
         PFCzHj+7mQzGUhfsV2/tLYo8hu2tuVIfr26JiT/khxD8nQZooxfGC3jTer+bS/1051kL
         xqchrdlRg9fm5tCYj8MASTHYUl+VLg1dklW88dzhIUx+Df3Vv0HUz2xeiXr5n4yavG4U
         5rGuq+vy5LtB6k+IMZmm2NQmUiOfO8ElRaQZHdmzMXHGx+6ec4kBVi6YjNRbENORWbTg
         thupt3sf/0Whgw79MyCDOImSGzHokot+ymuuizEFio3yi7hRPAHu3Zj2deZyw1SfMF7K
         Ftfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712445536; x=1713050336;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HBGTEAzKZ36twFnYaQSTfe0UPMpT9D5T1eTdXOE/7M=;
        b=DBr+iBs8NcpWkgqQsXINrnAA64O8jzYSInjMHK9w0zr1oFUPsqz5zjbuM/amEyJ2WS
         +TQnRzv3TV6orZGuOKFJ9A4YGOSCV2Lqf9OBO4m94UZ83XVBCbxgX6Yt7LX5T9Y6/wau
         DvEqPiJyhY42EW79aVBZcVRyYXOw6uIjJ8kQmAi+1piyaiRiz1dyItR72gmDECsAgwjX
         lR+/Pz5Aj5fc1qZMnQf0HiormbtecGVBMqDL0vgSI0p2W0PoHzurMRO59A1vUw2AmN2+
         6hH2CvuKrQS/Rj7C5+UwRCH/0w/y1NcS9lTbvIYskSSizJixgIVuIRK0Ldh5d2LnjG7L
         w4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Vqre6JvJa7BdwRPbyTiiUvMIzxfvQ8UMu1vMELnxoDxQvycK2Ovzwf0EwoJ8PMgFsV6//W2JnhgRsVqIqcyrAROg
X-Gm-Message-State: AOJu0YwPUNparzm4Tpki7mq7OOpjinvyXUzemLSbstu4RMKPc/xjxBUh
	HhYHCPpsQRChFUm4WMT84XZHTiPMtMEJ5fo7bGPO77xLIftreUTG
X-Google-Smtp-Source: AGHT+IFj5l/mLegiI7poGorWpd3vfH4+GWw+aGDp8wipiRcqdnQqhmmtQQ7IrQ5AGnf35whn6brgfQ==
X-Received: by 2002:a05:600c:6b13:b0:415:4b1a:683b with SMTP id jn19-20020a05600c6b1300b004154b1a683bmr3638918wmb.41.1712445536230;
        Sat, 06 Apr 2024 16:18:56 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b00415f496b9b7sm8950823wmo.39.2024.04.06.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 16:18:55 -0700 (PDT)
Message-ID: <7ade50c68b204816224f9eb51cdcb9ec53a4ff31.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Add bpf_link support for sk_msg
 and sk_skb progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Sun, 07 Apr 2024 02:18:53 +0300
In-Reply-To: <20240406160404.177055-1-yonghong.song@linux.dev>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
	 <20240406160404.177055-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 09:04 -0700, Yonghong Song wrote:

[...]

> @@ -1454,55 +1466,95 @@ static struct sk_psock_progs *sock_map_progs(stru=
ct bpf_map *map)
>  	return NULL;
>  }
> =20
> -static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***=
pprog,
> -				u32 which)
> +static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_pro=
g ***pprog,
> +				     struct bpf_link ***plink, struct bpf_link *link,
> +				     bool skip_link_check, u32 which)
>  {
>  	struct sk_psock_progs *progs =3D sock_map_progs(map);
> +	struct bpf_prog **cur_pprog;
> +	struct bpf_link **cur_plink;
> =20
>  	if (!progs)
>  		return -EOPNOTSUPP;
> =20
>  	switch (which) {
>  	case BPF_SK_MSG_VERDICT:
> -		*pprog =3D &progs->msg_parser;
> +		cur_pprog =3D &progs->msg_parser;
> +		cur_plink =3D &progs->msg_parser_link;
>  		break;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>  	case BPF_SK_SKB_STREAM_PARSER:
> -		*pprog =3D &progs->stream_parser;
> +		cur_pprog =3D &progs->stream_parser;
> +		cur_plink =3D &progs->stream_parser_link;
>  		break;
>  #endif
>  	case BPF_SK_SKB_STREAM_VERDICT:
>  		if (progs->skb_verdict)
>  			return -EBUSY;
> -		*pprog =3D &progs->stream_verdict;
> +		cur_pprog =3D &progs->stream_verdict;
> +		cur_plink =3D &progs->stream_verdict_link;
>  		break;
>  	case BPF_SK_SKB_VERDICT:
>  		if (progs->stream_verdict)
>  			return -EBUSY;
> -		*pprog =3D &progs->skb_verdict;
> +		cur_pprog =3D &progs->skb_verdict;
> +		cur_plink =3D &progs->skb_verdict_link;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> =20
> +	/* The link check will be skipped for link_detach case. */
> +	if (!skip_link_check) {
> +		/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
> +		 * exists for that prog.
> +		 */
> +		if (!link && *cur_plink)
> +			return -EBUSY;
> +
> +		/* for bpf_link based prog_update, return error if the stored bpf_link
> +		 * does not match the incoming bpf_link.
> +		 */
> +		if (link && link !=3D *cur_plink)
> +			return -EBUSY;
> +	}

I still think that this check should be factored out to callers,
this allows to reduce the number of function parameters,
and better separate unrelated logical error conditions.
E.g. like in the patch at the end of this email
(applied on top of the current patch).

[...]

---

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4af44277568e..a642215faa20 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1467,8 +1467,7 @@ static struct sk_psock_progs *sock_map_progs(struct b=
pf_map *map)
 }
=20
 static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog =
***pprog,
-				     struct bpf_link ***plink, struct bpf_link *link,
-				     bool skip_link_check, u32 which)
+				     struct bpf_link ***plink, u32 which)
 {
 	struct sk_psock_progs *progs =3D sock_map_progs(map);
 	struct bpf_prog **cur_pprog;
@@ -1504,21 +1503,6 @@ static int sock_map_prog_link_lookup(struct bpf_map =
*map, struct bpf_prog ***ppr
 		return -EOPNOTSUPP;
 	}
=20
-	/* The link check will be skipped for link_detach case. */
-	if (!skip_link_check) {
-		/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
-		 * exists for that prog.
-		 */
-		if (!link && *cur_plink)
-			return -EBUSY;
-
-		/* for bpf_link based prog_update, return error if the stored bpf_link
-		 * does not match the incoming bpf_link.
-		 */
-		if (link && link !=3D *cur_plink)
-			return -EBUSY;
-	}
-
 	*pprog =3D cur_pprog;
 	if (plink)
 		*plink =3D cur_plink;
@@ -1539,9 +1523,14 @@ static int sock_map_prog_update(struct bpf_map *map,=
 struct bpf_prog *prog,
 	struct bpf_link **plink;
 	int ret;
=20
-	ret =3D sock_map_prog_link_lookup(map, &pprog, &plink, NULL, link && !pro=
g, which);
+	ret =3D sock_map_prog_link_lookup(map, &pprog, &plink, which);
 	if (ret)
-		goto out;
+		return ret;
+	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
+	 * exists for that prog.
+	 */
+	if ((!link || prog) && *plink)
+		return -EBUSY;
=20
 	if (old) {
 		ret =3D psock_replace_prog(pprog, prog, old);
@@ -1553,8 +1542,7 @@ static int sock_map_prog_update(struct bpf_map *map, =
struct bpf_prog *prog,
 			*plink =3D link;
 	}
=20
-out:
-	return ret;
+	return 0;
 }
=20
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
@@ -1579,7 +1567,7 @@ int sock_map_bpf_prog_query(const union bpf_attr *att=
r,
=20
 	rcu_read_lock();
=20
-	ret =3D sock_map_prog_link_lookup(map, &pprog, NULL, NULL, true, attr->qu=
ery.attach_type);
+	ret =3D sock_map_prog_link_lookup(map, &pprog, NULL, attr->query.attach_t=
ype);
 	if (ret)
 		goto end;
=20
@@ -1770,10 +1758,15 @@ static int sock_map_link_update_prog(struct bpf_lin=
k *link,
 		goto out;
 	}
=20
-	ret =3D sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink, link=
, false,
+	ret =3D sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
 					sockmap_link->attach_type);
 	if (ret)
 		goto out;
+	/* for bpf_link based prog_update, return error if the stored bpf_link
+	 * does not match the incoming bpf_link.
+	 */
+	if (link !=3D *plink)
+		return -EBUSY;
=20
 	if (old) {
 		ret =3D psock_replace_prog(pprog, prog, old);

