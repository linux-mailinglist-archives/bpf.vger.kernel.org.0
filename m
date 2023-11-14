Return-Path: <bpf+bounces-15046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A5E7EA9FA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 06:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82533281002
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F05C121;
	Tue, 14 Nov 2023 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="a+hsRVWK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A3BE6B
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 05:13:15 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220519F
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 21:13:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083740f92dso42340435e9.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 21:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1699938793; x=1700543593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8r3Tmn46WuF6qUi9negfzfDFjoxJ+5U/3trz3Lsiz7U=;
        b=a+hsRVWKUXE3Q29VbQFYbqRaH6lgll8IFtJ3ub+oKKMCs3ohzgGyzLvugz6tlGMQh1
         MoaL0VlhgNxTdYW4T9PSij+4CciOnWFlQyETSpC36oEdqBZd0W59zf55uQ9Q5B5G55LO
         vd8jVhFPb8Q5SuWDXzsoC4jv4Ox+G74h7hW3isQ1XOB2ThhxYJTieBcopb4VifvGCDoV
         QuMs/dTuR6ybkWEz8JDlfYsRCrdD5njFX7Vpm0xWolMtTQDrdTBXNBnnvoEzx8gQRfUC
         SA9rJl/uYgQJ0gykzATFYqLM/R9R9XpdPsFWb43G8NL7z3QARTfsf6t0xpo9v3LKYW6T
         lUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699938793; x=1700543593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r3Tmn46WuF6qUi9negfzfDFjoxJ+5U/3trz3Lsiz7U=;
        b=jvYzvwdznertna1+sp4UQhNHa5EtvNiIRmN3JMOcSxbSeeD/+/ltGD2oYrEoe7GQkC
         0/2EN4B0kbQN53SuRvRfM60m7D3Ed30Qs4JAJXOpxjC7PTpZJfSGvsBUzcHS8v1ogDo4
         nhaLWTvM99AF9Mp7jhJqkEFXzh35fKbRjLXuNfISVo0zpgRUO2Clucnk9fhML0SNslrw
         8ME6JVLEJ5Nte309Zmi7u/5QSouSEMzDTgYCuKMuTp89vBDp4Ys5A6JCwIHxvZU+2FAF
         mNMJtA1ZqKaUakOqBqwd4e+kFZfBuyfnh2e3LEITOvU19HTWNw7VFLctera/galpRN+2
         ScUQ==
X-Gm-Message-State: AOJu0YyL3YPXRKWbF0Soo9iODMP851i4XtSsVzigJopelqwFze7/jPVq
	ENsDw92tg9moknSSwsx6CLZkqg==
X-Google-Smtp-Source: AGHT+IHAnFCtF3Vz+6hVsMR5199TbR4WrBgzm+TkMWOlviSv44LSMIn8tVPIl+maN3v7Lw5GYREJeg==
X-Received: by 2002:a05:600c:4f87:b0:408:543d:5532 with SMTP id n7-20020a05600c4f8700b00408543d5532mr6775424wmq.31.1699938792833;
        Mon, 13 Nov 2023 21:13:12 -0800 (PST)
Received: from [192.168.97.254] ([37.168.99.178])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c2d0c00b0040a43d458c9sm12989703wmf.25.2023.11.13.21.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 21:13:12 -0800 (PST)
Message-ID: <1a9520a2-46cd-4f4a-b7d8-fc28c787240a@isovalent.com>
Date: Tue, 14 Nov 2023 05:12:48 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 11/17] bpftool: update doc to describe bpftool
 btf dump .. format meta
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, masahiroy@kernel.org, bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <20231112124834.388735-12-alan.maguire@oracle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231112124834.388735-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-12 12:49 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
> ...and provide an example of output.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index 342716f74ec4..ea8bb0a2041c 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -28,7 +28,7 @@ BTF COMMANDS
>  |	**bpftool** **btf help**
>  |
>  |	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> -|	*FORMAT* := { **raw** | **c** }
> +|	*FORMAT* := { **raw** | **c** | **meta** }
>  |	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>  |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
>  
> @@ -67,8 +67,8 @@ DESCRIPTION
>  		  typically produced by clang or pahole.
>  
>  		  **format** option can be used to override default (raw)
> -		  output format. Raw (**raw**) or C-syntax (**c**) output
> -		  formats are supported.
> +		  output format. Raw (**raw**), C-syntax (**c**) and
> +                  BTF metadata (**meta**) formats are supported.

Please fix the indent for this line (it should be two tabs then two
spaces - yes I know it's a pain, we're working on improving this [0]).

[0] https://github.com/libbpf/bpftool/pull/111

>  
>  	**bpftool btf help**
>  		  Print short help message.
> @@ -266,3 +266,27 @@ All the standard ways to specify map or program are supported:
>    [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
>    [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
>    [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
> +
> +
> +**# bpftool btf dump file vmlinux format meta**
> +
> +::
> +
> + size 5161076
> + magic 0xeb9f
> + version 1
> + flags 0x1
> + hdr_len 40
> + type_len 3036368
> + type_off 0
> + str_len 2124588
> + str_off 3036368
> + kind_layout_len 80
> + kind_layout_off 5160956
> + crc 0x64af901b
> + base_crc 0x0
> + kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
> + kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
> + kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
> + kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
> + kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0


