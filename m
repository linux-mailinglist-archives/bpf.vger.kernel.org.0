Return-Path: <bpf+bounces-1598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536ED71EF27
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3421C2111B
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFF171D6;
	Thu,  1 Jun 2023 16:34:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F45D533
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:34:22 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97CE48
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:34:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30c4775d05bso607226f8f.2
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685637241; x=1688229241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtX9jxjoU/mKddkOk7C3zYkrnNJRUUYjKjwxt36RXfs=;
        b=ZIGJEkcIUVDc49RQuj4svTXbJEafO0ocLCQgecd9rrKU93Py5Hs3lCugscP21a2gf2
         KhJIG21naMu7TZ/0VfcbfNl9Hj7iqBN4Hw8idk/v7sb5Ct+JAoYzU5TKQKptsFTMMPBf
         ck4ThPbbQyYpjbKPKG8q34fI1mEenfRwgDkmDKJpR0NOwReHqe1oBqMAymuJvi49hE6P
         oxRdn2oB6ZHYzAzX/n4nRzJsI18Kbud2eqEHEX1puygWqd980HzcngLEmgh8m4+haiVQ
         niSRtCjFWWVg5vUxl+d45ilMlMl7IMfCOTjPRpzIQeRsidl6kgV2C4CUo2fqStOPTBTO
         0grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637241; x=1688229241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtX9jxjoU/mKddkOk7C3zYkrnNJRUUYjKjwxt36RXfs=;
        b=OLOpPc454d5iHASmfDRbxl4kYUD2hVYhkdzrRA8hIzyfibhmgSP+F8JHUvoQ+C7mc2
         0iB+5nRRYgxSozEvRM4kFC6xZuFCiJfmIvpoD7JuV+EtwO+eGqNB5IES1oBgmpue2Mvn
         hGbsNlqSocWbQ5M0c8tAjaH+x2HHDaHDA2rwUxuCW0ZxLOKwIfJ+LetiV7fRSc2KLTiy
         SFPc6FD8FWRWY19XjnZytZEXKq3jjA5lBMfzPVR8h2KQqopHPeP78GLzO0eJy+XgFjX9
         MfMpJAWrFO9o+v4YQS976smbmpaxirX4RHyAkTv3k1RGmihdEuvL+QeFDnnDQXmi+5Vh
         ruCw==
X-Gm-Message-State: AC+VfDxIe+ZJw1BwOv0HxgWhHLhgjPc3ANAHJgFElOoqMAKgsj3GW2Cx
	U90gdc+1qCdTL5HefXOA1AEaqA==
X-Google-Smtp-Source: ACHHUZ6Yiu9HvWtogcJgEZR8D6CWO10AOPyosTPtE3xdn7rLsBbx44To+4CcbW82s/QxvHszMBflfw==
X-Received: by 2002:a5d:4707:0:b0:307:9d1f:ad11 with SMTP id y7-20020a5d4707000000b003079d1fad11mr2188843wrq.56.1685637241055;
        Thu, 01 Jun 2023 09:34:01 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2802:66d1:c817:5d8b? ([2a02:8011:e80c:0:2802:66d1:c817:5d8b])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4103000000b003047d5b8817sm10742935wrp.80.2023.06.01.09.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:34:00 -0700 (PDT)
Message-ID: <7c8ecb4f-9db0-cbae-77ca-aea5d51196de@isovalent.com>
Date: Thu, 1 Jun 2023 17:33:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC bpf-next 7/8] bpftool: add BTF dump "format meta" to dump
 header/metadata
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-8-alan.maguire@oracle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230531201936.1992188-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-31 21:19 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> Provide a way to dump BTF header and metadata info via
> bpftool; for example
> 
> $ bpftool btf dump file vmliux format meta

Typo: vmliux

> BTF: data size 4963656
> Header: magic 0xeb9f, version 1, flags 0x0, hdr_len 32
> Types: len 2927556, offset 0
> Strings: len 2035881, offset 2927556
> Metadata header found: len 184, offset 4963440, flags 0x1
> Description: 'generated by dwarves v1.25'
> CRC 0x6da2a930 ; base CRC 0x0
> Kind metadata for 20 kinds:
>        BTF_KIND_UNKN[ 0] flags 0x0    info_sz  0 elem_sz  0
>         BTF_KIND_INT[ 1] flags 0x0    info_sz  4 elem_sz  0
>         BTF_KIND_PTR[ 2] flags 0x0    info_sz  0 elem_sz  0
>       BTF_KIND_ARRAY[ 3] flags 0x0    info_sz 12 elem_sz  0
>      BTF_KIND_STRUCT[ 4] flags 0x0    info_sz  0 elem_sz 12
>       BTF_KIND_UNION[ 5] flags 0x0    info_sz  0 elem_sz 12
>        BTF_KIND_ENUM[ 6] flags 0x0    info_sz  0 elem_sz  8
>         BTF_KIND_FWD[ 7] flags 0x0    info_sz  0 elem_sz  0
>     BTF_KIND_TYPEDEF[ 8] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_VOLATILE[ 9] flags 0x0    info_sz  0 elem_sz  0
>       BTF_KIND_CONST[10] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_RESTRICT[11] flags 0x0    info_sz  0 elem_sz  0
>        BTF_KIND_FUNC[12] flags 0x0    info_sz  0 elem_sz  0
>  BTF_KIND_FUNC_PROTO[13] flags 0x0    info_sz  0 elem_sz  8
>         BTF_KIND_VAR[14] flags 0x0    info_sz  4 elem_sz  0
>     BTF_KIND_DATASEC[15] flags 0x0    info_sz  0 elem_sz 12
>       BTF_KIND_FLOAT[16] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_DECL_TAG[17] flags 0x1    info_sz  4 elem_sz  0
>    BTF_KIND_TYPE_TAG[18] flags 0x1    info_sz  0 elem_sz  0
>      BTF_KIND_ENUM64[19] flags 0x0    info_sz  0 elem_sz 12
> 

Thanks for this! For the non-RFC, can you please add the following:

- JSON output
- btf.c's do_help() update
- Documentation/bpftool-btf.rst update (cmd summary, and description)
- bash-completion/bpftool update (should be straightforward, we just
need to offer "metadata" after "format", like we already offer "c" and
"raw".

> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..da4257e00ba8 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -504,6 +504,47 @@ static int dump_btf_c(const struct btf *btf,
>  	return err;
>  }
>  
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +	const struct btf_header *hdr;
> +	const struct btf_metadata *m;
> +	const void *data;
> +	__u32 data_sz;
> +	__u8 i;
> +
> +	data = btf__raw_data(btf, &data_sz);
> +	if (!data)
> +		return -ENOMEM;
> +	hdr = data;
> +	printf("BTF: data size %u\n", data_sz);
> +	printf("Header: magic 0x%x, version %d, flags 0x%x, hdr_len %u\n",
> +	       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);

Nit: bpftool's output fields don't usually start with a capital letter
(save for acronyms, obviously). I don't mind much, though.

> +	printf("Types: len %u, offset %u\n", hdr->type_len, hdr->type_off);
> +	printf("Strings: len %u, offset %u\n", hdr->str_len, hdr->str_off);
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header) ||
> +	    hdr->meta_header.meta_len == 0 ||
> +	    hdr->meta_header.meta_off == 0)
> +		return 0;
> +
> +	m = (void *)hdr + hdr->hdr_len + hdr->meta_header.meta_off;
> +
> +	printf("Metadata header found: len %u, offset %u, flags 0x%x\n",
> +	       hdr->meta_header.meta_len, hdr->meta_header.meta_off, m->flags);
> +	if (m->description_off)
> +		printf("Description: '%s'\n", btf__name_by_offset(btf, m->description_off));
> +	printf("CRC 0x%x ; base CRC 0x%x\n", m->crc, m->base_crc);
> +	printf("Kind metadata for %d kinds:\n", m->kind_meta_cnt);
> +	for (i = 0; i < m->kind_meta_cnt; i++) {
> +		printf("%20s[%2d] flags 0x%-4x info_sz %2d elem_sz %2d\n",
> +		       btf__name_by_offset(btf, m->kind_meta[i].name_off),
> +		       i, m->kind_meta[i].flags, m->kind_meta[i].info_sz,
> +		       m->kind_meta[i].elem_sz);

Nit: I would maybe add a double space for separating the different
field, especially because we have some left padding for values < 10 in
your example and it looks strange to have numbers closer to the next
field name (on their right) rather than their own (on their left).

> +	}
> +
> +	return 0;
> +}
> +
>  static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
>  
>  static struct btf *get_vmlinux_btf_from_sysfs(void)
> @@ -553,6 +594,7 @@ static int do_dump(int argc, char **argv)
>  	__u32 root_type_ids[2];
>  	int root_type_cnt = 0;
>  	bool dump_c = false;
> +	bool dump_meta = false;
>  	__u32 btf_id = -1;
>  	const char *src;
>  	int fd = -1;
> @@ -654,6 +696,8 @@ static int do_dump(int argc, char **argv)
>  			}
>  			if (strcmp(*argv, "c") == 0) {
>  				dump_c = true;
> +			} else if (strcmp(*argv, "meta") == 0) {
> +				dump_meta = true;

We could use is_prefix() instead of strcmp() (same for "raw" below, by
the way), to make it possible to pass the keyword by prefix (as in
"bpftool b d f vmlinux f m".

>  			} else if (strcmp(*argv, "raw") == 0) {
>  				dump_c = false;
>  			} else {
> @@ -692,6 +736,8 @@ static int do_dump(int argc, char **argv)
>  			goto done;
>  		}
>  		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
> +	} else if (dump_meta) {
> +		err = dump_btf_meta(btf);
>  	} else {
>  		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
>  	}


