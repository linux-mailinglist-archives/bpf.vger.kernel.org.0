Return-Path: <bpf+bounces-7963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4052677F069
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B541C21275
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E1ECA;
	Thu, 17 Aug 2023 06:13:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3D395;
	Thu, 17 Aug 2023 06:13:53 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AEB1FCE;
	Wed, 16 Aug 2023 23:13:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso21792705ad.2;
        Wed, 16 Aug 2023 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692252832; x=1692857632;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIQK0eLLA/5IHOzyLFK5/WSkTXhC+TKrNrdcuUq4OeU=;
        b=OXh+qBPqbuc5hDlxrDKcYiuJvbZRLgcBkS1ufSEjcPhUxN1AZhUfo96kNfMua2heUJ
         6oghvvlC6k6wKR7wMbzA8nQE96r+TVfnCF2ZCRCbIH5HW0p0H8xzL29H3DCs6/oTEdsD
         KiNq5Igu1Zi9TBvRaXE2zbbbYMqmH75YkRuvk+FG4kqLpxttuAm1O/3S6p/pd/QlEYL2
         QV3qve80/QMeJthiAGzYkQ5cJXPGY489gCeV16N5ceqoKSHfA4Lm7eA7yO+OwsclUFR2
         +7xFRAhJihfkl5drp6HBn+xfjRDW1qJ+vvIRTu2+ahhCHQV62CpolAvRyh5BWR/DXjDw
         BJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692252832; x=1692857632;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RIQK0eLLA/5IHOzyLFK5/WSkTXhC+TKrNrdcuUq4OeU=;
        b=Ayg3+Uv79/OnTQH7ur4iQEftw4orba6rOhasO3l/jp25YzCsi4UMj2jQR4qNgxF8TT
         H/0NYqRy02a2svNkE0BIlzORyDgXLM8hLNFO9M5XJivxkbeRcIWzpfMh79gTX2umwg7z
         1zQ19NpONureRuGSwSLmKor0+o+zHon5XBODVV1kLeHPoZWezK/aeyiOMVX7G8Ed8LdY
         v40tZcqRZW3z/SuGeSFEozuWBGcDLqRj34Ab+FKbNaXy7+Q1zGvgBOj5ruaTENeaH2SM
         RRb25T08nU4qz+KIVHCwNGPf5opz0KCHCuRQ5EcwKiTbHzy8naztV75H54bAkn9hspE6
         PYtA==
X-Gm-Message-State: AOJu0YwmXrRBOLMK4fic2MS1n8kHS9LhAOfQm5nzadRIzgu3KVwQ7Ox+
	1tiAXP9HwlBobtnDUFy2jndrmDp4xjw=
X-Google-Smtp-Source: AGHT+IHd+dvQKaYoXKGGIwKmSq+hdqGvccB5D/7D7Ap5Knm6rb+8lKYHMAf2zBHt3PbSfwc3v1uqNw==
X-Received: by 2002:a17:902:e892:b0:1be:f2a1:22d8 with SMTP id w18-20020a170902e89200b001bef2a122d8mr4285921plg.14.1692252831855;
        Wed, 16 Aug 2023 23:13:51 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:6c3f:7684:5d26:5d62])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001b892aac5c9sm14189382plf.298.2023.08.16.23.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 23:13:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 23:13:50 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Liu Jian <liujian56@huawei.com>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 liujian56@huawei.com
Message-ID: <64ddba9e1df57_32c0720898@john.notmuch>
In-Reply-To: <20230811093237.3024459-2-liujian56@huawei.com>
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY flag
 for skmsg redirect
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward packets
> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only needs to
> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.
> 

I like the use case. Did you consider using

 long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)

This could be set to UINT32_MAX and then the BPF prog would only be run
every 0xfffffff bytes.

> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
> 
> Test results using netperf  TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> done
> 
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85

I suspect comparing against

  bpf_msg_redirect_hash(...)
  bpf_msg_apply_bytes(msg, UINT32_MAX)

the diff will be rather small. I agree the API is nicer though to simply
set the flag. Its too bad we didn't think to add a forever to apply_bytes.
I would prefer this API for example,

  bpf_msg_redirect_hash(...)
  bpf_msg_apply_bytes(msg, 0, PERMANENT);

Given we have apply_bytes is it still useful to have a PERMANENT flag
in your use case? Here we would just reset to UNINT32_MAX if we reached
max bytes.

> 
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  include/linux/skmsg.h          |  1 +
>  include/uapi/linux/bpf.h       |  7 +++++--
>  net/core/skmsg.c               |  1 +
>  net/core/sock_map.c            |  4 ++--
>  net/ipv4/tcp_bpf.c             | 21 +++++++++++++++------
>  tools/include/uapi/linux/bpf.h |  7 +++++--
>  6 files changed, 29 insertions(+), 12 deletions(-)

[...]

>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70da85200695..cf622ea4f018 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3004,7 +3004,8 @@ union bpf_attr {
>   * 		egress interfaces can be used for redirection. The
>   * 		**BPF_F_INGRESS** value in *flags* is used to make the
>   * 		distinction (ingress path is selected if the flag is present,
> - * 		egress path otherwise). This is the only flag supported for now.
> + * 		egress path otherwise). The **BPF_F_PERMANENTLY** value in
> + *		*flags* is used to indicates whether the eBPF result is permanent.

We at least need to document what happens if PERMANENTLY and apply_bytes are
used together.

>   * 	Return
>   * 		**SK_PASS** on success, or **SK_DROP** on error.
>   *

