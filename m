Return-Path: <bpf+bounces-76549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8653CBA37B
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 03:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41AF33056567
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA212F0690;
	Sat, 13 Dec 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6UcTR53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8392ECEBC
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765594354; cv=none; b=ArNlYCm7560MoHPXi5CFAVM7PBTTdycB7BVi6OWpw1vX2Xob10U0T1McJU+QbTGLMN8K0u7/IIq2h/c00Hs9s00LBZQxiPeGWk55e19G587XdKdxchnK8OGVICNrIOFMPO1uLqJxQi48ALOoz/gS0qxslnohD7yRYk+GYa3Iwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765594354; c=relaxed/simple;
	bh=c4DdOgJc4Vpxs6PMnmslSP7tyBi+CwUSMeFbIRk59uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKW1ds/G8BiEbnhhtHOqLiJeZwpCa/dEOjYJLNRRArIveF/WZKn2pCQRYyQoz5831yjSg/AJjEwXPBv8APYiT2uc3tZ+k7LK8GVZwb4KN0cB1t5q58kz9CVBBo9p1+1JezIVuWqDv61cfbONw8yAFUYe+k3flf/X5+8j/f415IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6UcTR53; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343d73d08faso947000a91.0
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 18:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765594351; x=1766199151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1xekd7jNRvWyejeiz/Mjp08XhFxQMXlao7baAbp6Y8=;
        b=E6UcTR53vYwKKDZobg0hG7DP1axGlUTInb33kDaPVtP6xpiyOX8zAH3gz/Am75XCdL
         JHWfcd82LLstD1PtWziRmMTRWgb7eQrqEfTgWPC/6njF9ZcqST4NsArvC+rvHrFldeh5
         hNozZHa/NShLZOxQZv46jdSxhr94PZmAP/JXil943hSPP6PC7aIKIMe3IauKwug7kPmk
         atyeKxH7Y8594FB5ClAkRCUnghqMGzHVLqTI8/HAyb0L/aATzcAodaPP5y3rhjJWL7hT
         +dBGZOKEAqXvZ2DXjGI5Ea1hmA49kJ3qqK1nyF4QosGm6oLsLO42Wbs8W+AJg8ziKaS5
         7RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765594351; x=1766199151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1xekd7jNRvWyejeiz/Mjp08XhFxQMXlao7baAbp6Y8=;
        b=Gvy8kqATsRhBGq081oe85M6Wj0exFjAK+ZnAQ2fkZKh2LJ1HQM5kNYjhNsLYhD2NTU
         pKPfmCy1tzJBdtiOG/LvNaGI6SYbS5m4zI28UTdXn52TVVffhasrNGhkz6CeZ6X2bvwJ
         PK5cC58hmE/LN7vauVvXUG6Pv7D+KIrN6HnBDcOlROy0mGkdUWD9+BQsE8kQVmhxOA8d
         0JsyKgymjuWSstqf4HYaXLGSx8MCAmOlAx0MknorRev+8eTdzxKVAXP8HQvp4KTL4nWZ
         zNGY+lqZmMaSx+pDg7KqrxmFuRLFLT0cstLF31yBTXLF1ucWWUFYoLC1dtR3vEqeJyhO
         hMxw==
X-Forwarded-Encrypted: i=1; AJvYcCWvpVC7aPzkWcZeyrDdaodD2aMxGrlWDYGvDrlDCJtH5J1ohx+DNlD7BsvkTWjPaGG5ihs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGuMJCIzQnIj8lKiyXA4ffbGr206GNozvLI+cIUk6yb18GfEv
	BR4GwKoJH79kP2seZBPiJuLTWfiMzeBIBBUQDksXDAUE8LvMRyyfDO9AYlEtcw==
X-Gm-Gg: AY/fxX4JYLDH7U8m7seut/S1PIfWVFR4tclnYnxm49zazIn14yfNYmLVLxyewjHk6gD
	9xqa9YjMtmaBtQE6VTZd43sPIR2XZqXwuo8wlOy0L+HRYTTmaVtMwLiwpRehZPBETbSA73kOFU8
	n1JAIFiT2h50NCyQt6YX9K238tX4dBrHAC2fY9hAFx/JuXL4ktmi7d8HYdgrjCxlDoo6eV7sxl0
	PxNnaLAjvY2RlYmMGGZpdP6DfjaNtNITbqJW+uZdDho6+xsC6L8Qxgn9uDY7Iuh7TuUlCmpqII/
	T2/gCNu4WqALNhtKbkd36s5uchp7x/Iq6HvoxfysewdRYW34der0EQiUTIuYX1Ttz/UIRIKPcQv
	uQcXp11Rd/BxtLNQ3VgXH/md4k2MaiZaGeHrgLGUIdBV8P5QdWGaxi9DePE4EybTvjTXVAks9Fo
	MCYDwSlLwyT9XDxsClmuelb3T3DR0DX0k14Bm7HLFAFrd8rvhd2smTFgVzfls=
X-Google-Smtp-Source: AGHT+IH+NhW6YC3uwIelwrTgwRfZUi4wpFc/C9iTv1mkfJzZ9vTbO6xofyNxjPpW9k8p4n3ujswBng==
X-Received: by 2002:a17:90b:580f:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34a925f4a0fmr6595372a91.2.1765594350793;
        Fri, 12 Dec 2025 18:52:30 -0800 (PST)
Received: from [10.200.5.118] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c206cf429sm6528080a12.0.2025.12.12.18.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 18:52:30 -0800 (PST)
Message-ID: <64a618b5-d14a-496e-8295-60e495098a7c@gmail.com>
Date: Sat, 13 Dec 2025 02:52:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, ttreyer@meta.com
References: <20251210203243.814529-1-alan.maguire@oracle.com>
 <20251210203243.814529-2-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251210203243.814529-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 20:32, Alan Maguire wrote:
> BTF kind layouts provide information to parse BTF kinds. By separating
> parsing BTF from using all the information it provides, we allow BTF
> to encode new features even if they cannot be used by readers. This
> will be helpful in particular for cases where older tools are used
> to parse newer BTF with kinds the older tools do not recognize;
> the BTF can still be parsed in such cases using kind layout.
>
> The intent is to support encoding of kind layouts optionally so that
> tools like pahole can add this information. For each kind, we record
>
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
>
> The ideas here were discussed at [1], [2]; hence
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
> ---
>   include/uapi/linux/btf.h       | 10 ++++++++++
>   tools/include/uapi/linux/btf.h | 10 ++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..64dd681274f4 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,14 @@
>   #define BTF_MAGIC	0xeB9F
>   #define BTF_VERSION	1
>   
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
We switched to kernel style comments in the new code:
/*
  * comment
  */

instead of
/* comment
  */
> +struct btf_kind_layout {
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
>   struct btf_header {
>   	__u16	magic;
>   	__u8	version;
> @@ -19,6 +27,8 @@ struct btf_header {
>   	__u32	type_len;	/* length of type section	*/
>   	__u32	str_off;	/* offset of string section	*/
>   	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
>   };
>   
>   /* Max # of type identifier */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c07..64dd681274f4 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -8,6 +8,14 @@
>   #define BTF_MAGIC	0xeB9F
>   #define BTF_VERSION	1
>   
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
>   struct btf_header {
>   	__u16	magic;
>   	__u8	version;
> @@ -19,6 +27,8 @@ struct btf_header {
>   	__u32	type_len;	/* length of type section	*/
>   	__u32	str_off;	/* offset of string section	*/
>   	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
>   };
>   
>   /* Max # of type identifier */


