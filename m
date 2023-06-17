Return-Path: <bpf+bounces-2775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E55733D41
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 02:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8E1C210B3
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CC809;
	Sat, 17 Jun 2023 00:40:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575F7F6
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 00:40:01 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44AD3A92
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:39:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666edfc50deso268159b3a.0
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686962399; x=1689554399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqGjiwYLULCrutZ7J4jNodCzAOn3CcdHrdsH/7XIZv8=;
        b=bg7vB2odG/1fAf7Dh4o2dA0rRZEa6YmHtHqwAcWZ5SJRBMMPT2+Auf/iBfpmu9d0yd
         BtipC6YJpo3xu/J3zwTIaeVm4UoLoj6Mt06ffDsm/ndXV2BqpfIgot8c/yH1QusKYMj+
         5ETveNaU5sZpIxf6d9nb8UqoPoCwTu95boe9otQjU0ZOP5k5qpXysssYDeJxNr/lcp2S
         TDxjfIbpTQGoR7GY1GF8xh+p16z9PJgSC05TKsmoxpNyh5gZmPczJ2pu9NE50X+58Thj
         xX4pABMzrKnclzBQD0rAMNStC3R0NnbKE9wldxV4Rv306+o6yME3mxYIo1WBPLPgXRff
         TD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686962399; x=1689554399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqGjiwYLULCrutZ7J4jNodCzAOn3CcdHrdsH/7XIZv8=;
        b=ZLhDLZbluvhe8xdkcEO0zf8+FxkFDb0xVcOj7IqeH/fY6iDb2sJ2jHjP5gYTeGKjtd
         bhJ3llf0QtQeNBPDA7LU8wJV+gfAruZRiPh5u17KS+CgvA04k+locVF6CKZDhJ4OBBII
         R7umLW77ejc1HhjEZ7fKa++CmB4B0n3satzmdHN/KtFm9ikPxtqfbx84gTJxB4QLG50x
         i3DEHypbxMe9IZWwgoq7PL7AhpuH1JAhrHGAZgmsi4meX5enJ/T9whqOP/jCa5owl/lv
         mf0MHr9kBRgmWrcpV0m5obT8qcFHKZHI1QJsUR83/+QxLvLzOow+6xUNx0t2WrIZDSBf
         5E5A==
X-Gm-Message-State: AC+VfDx4ZoC9WaQf1/5gzqQOjaLfwLhN0t+U1pSrx38GrnDFl1gsLbLQ
	nf3Di15ydoa2UmiUcASGGqE=
X-Google-Smtp-Source: ACHHUZ7MMi4werd8FTpykf2q0nkWVcCEc71e1I9Bb6ukXTulEwo5snEjPLHzkz1TCn/cCg+y/v0Y+w==
X-Received: by 2002:a05:6a21:7881:b0:104:a053:12dd with SMTP id bf1-20020a056a21788100b00104a05312ddmr4907728pzc.10.1686962399165;
        Fri, 16 Jun 2023 17:39:59 -0700 (PDT)
Received: from MacBook-Pro-8.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:39f3])
        by smtp.gmail.com with ESMTPSA id f11-20020aa782cb000000b00571cdbd0771sm14045215pfn.102.2023.06.16.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 17:39:58 -0700 (PDT)
Date: Fri, 16 Jun 2023 17:39:55 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, quentin@isovalent.com, jolsa@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to
 UAPI
Message-ID: <20230617003955.dmx7ohip7diiu3qi@MacBook-Pro-8.local.dhcp.thefacebook.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616171728.530116-2-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 06:17:19PM +0100, Alan Maguire wrote:
> BTF kind layouts provide information to parse BTF kinds.
> By separating parsing BTF from using all the information
> it provides, we allow BTF to encode new features even if
> they cannot be used.  This is helpful in particular for
> cases where newer tools for BTF generation run on an
> older kernel; BTF kinds may be present that the kernel
> cannot yet use, but at least it can parse the BTF
> provided.  Meanwhile userspace tools with newer libbpf
> may be able to use the newer information.
> 
> The intent is to support encoding of kind layouts
> optionally so that tools like pahole can add this
> information.  So for each kind we record
> 
> - kind-related flags
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
> 
> In addition we make space in the BTF header for
> CRC32s computed over the BTF along with a CRC for
> the base BTF; this allows split BTF to identify
> a mismatch explicitly.
> 
> The ideas here were discussed at [1], [2]; hence
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
> ---
>  include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index ec1798b6d3ff..cea9125ed953 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,22 @@
>  #define BTF_MAGIC	0xeB9F
>  #define BTF_VERSION	1
>  
> +/* is this information required? If so it cannot be sanitized safely. */
> +#define BTF_KIND_LAYOUT_OPTIONAL		(1 << 0)
> +
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +	__u16 flags;		/* see BTF_KIND_LAYOUT_* values above */
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
> +#define BTF_FLAG_CRC_SET		(1 << 0)
> +#define BTF_FLAG_BASE_CRC_SET		(1 << 1)
> +
>  struct btf_header {
>  	__u16	magic;
>  	__u8	version;
> @@ -19,8 +35,16 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
> +
> +	__u32	crc;		/* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
> +	__u32	base_crc;	/* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */

typo ? should be BTF_FLAG_CRC_SET ?

