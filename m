Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191DD58133B
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGZMj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGZMj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 08:39:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EDA2ED75
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:39:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g2so11913023wru.3
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=z5xcs0/ibjFl7emEF6oDUD87qcO8su765M8/TDBP+bc=;
        b=GNPW2DT1VOy+4Mhv2Au5ne5QAsTElAXOPaFQtTQx9X1RIqX1np+2AAO+jg/OPJ42aW
         jMV3QWoIKzPcsJR4z+URLkW8Ifhu7dyvl+6YlkSVBi7oip9zI03q6AtgsV8v26MvU/4c
         FHxA2OBjYsOGmoWLBUdtg/LV0nBFaxe2nWd8v3f8zN/UHJPp7Q5x/D+H8NlE0UHbYpd0
         N3lUKWnJQWlrZHRn+E060xF3EHkLbPiccOcjPg7Lv0W+dd66B1MzlO+AURlS/msnhibM
         WBEnd6eAj/BN4iW8tPZ/V7V9XEWSV/Ugb2pYfuVKp95nDXaFUpj0p4fOI9X12pZ2jd5T
         xxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=z5xcs0/ibjFl7emEF6oDUD87qcO8su765M8/TDBP+bc=;
        b=W9Z0NydnjzyyIslZmo6tLeeVlghcTCFmWJ9Ck2p1d7oUxP3257b3rItmGVPHTGtuUi
         X/V5zlj295LqDDGK7L0n8gVRhk2q+Gxv/JPAwtYzQH7dsJuAlfp1tupOiKCZgyokASjF
         qAjD7LgcMCsH4yA2xbQyr3ESH8ey62dcuigEOfrhJ4A6Nuk6zRK2aPy6cs1Vj6Q7IVeC
         eBZVLxVGshOaAFEO9803O9KgxnKe8huKSpCBFDThENtSbhbyiE7zpXStpkOtlLf8G1RQ
         Pr0hMcVCz1C4Gl8//vHgnaeaKgABQZbmRXFTuR9WOevjj8A6MGVDK2oZqI6nIShpncYG
         IxSw==
X-Gm-Message-State: AJIora9Ihk36pLjmVZetax/7qyLp8wV5yynBpRACZ5c8mh3T5/Hvr/Ip
        nJadQPGXUp9VlfO7ULTokJA=
X-Google-Smtp-Source: AGRyM1vB3u5zKcFrc5hCPtDU9XOD6v2tmtnSBojAuBQfhCBXlUBGGDFA8ArOZr4N5RtfigpyyKynKA==
X-Received: by 2002:a5d:6b89:0:b0:21e:b591:2b80 with SMTP id n9-20020a5d6b89000000b0021eb5912b80mr895268wrx.33.1658839195949;
        Tue, 26 Jul 2022 05:39:55 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003a32297598csm22828894wmq.43.2022.07.26.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:39:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 14:39:53 +0200
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ftokarev@gmail.com,
        jolsa@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: augment snprintf_btf tests with
 string overflow tests
Message-ID: <Yt/gmWx6gMIxLI5F@krava>
References: <1658734261-4951-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658734261-4951-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 25, 2022 at 08:31:01AM +0100, Alan Maguire wrote:
> add tests that verify bpf_snprintf_btf() behaviour with strings that
> 
> - exactly fit the buffer (string size + null terminator == buffer_size)
> - overrun the buffer (string size + null terminator == buffer size + 1)
> - overrun the buffer (string size + null terminator == buffer size + 2)
> 
> These tests require [1] ("bpf: btf: Fix vsnprintf return value check")
> 
> ...which has not landed yet.

patch looks good, but I have the test passing even without [1],
it should fail, right?

  #151     snprintf_btf:OK

jirka

> 
> [1] https://lore.kernel.org/bpf/20220711211317.GA1143610@laptop/
> 
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/progs/netif_receive_skb.c        | 41 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> index 1d8918d..9fc48e4 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -49,7 +49,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
>  }
>  
>  #if __has_builtin(__builtin_btf_type_id)
> -#define	TEST_BTF(_str, _type, _flags, _expected, ...)			\
> +#define	TEST_BTF_SIZE(_str, _size, _type, _flags, _expected, ...)			\
>  	do {								\
>  		static const char _expectedval[EXPECTED_STRSIZE] =	\
>  							_expected;	\
> @@ -69,10 +69,13 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
>  			ret = -EINVAL;					\
>  			break;						\
>  		}							\
> -		ret = bpf_snprintf_btf(_str, STRSIZE,			\
> +		ret = bpf_snprintf_btf(_str, _size,			\
>  				       &_ptr, sizeof(_ptr), _hflags);	\
> -		if (ret)						\
> +		if (ret	< 0) {						\
> +			bpf_printk("bpf_snprintf_btf_failed (%s): %d\n",\
> +				   _str, _expectedval, ret);		\
>  			break;						\
> +		}							\
>  		_cmp = __strncmp(_str, _expectedval, EXPECTED_STRSIZE);	\
>  		if (_cmp != 0) {					\
>  			bpf_printk("(%d) got %s", _cmp, _str);		\
> @@ -82,6 +85,10 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
>  			break;						\
>  		}							\
>  	} while (0)
> +
> +#define TEST_BTF(_str, _type, _flags, _expected, ...)			\
> +	TEST_BTF_SIZE(_str, STRSIZE, _type, _flags, _expected,		\
> +		      __VA_ARGS__)
>  #endif
>  
>  /* Use where expected data string matches its stringified declaration */
> @@ -98,7 +105,9 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
>  	static __u64 flags[] = { 0, BTF_F_COMPACT, BTF_F_ZERO, BTF_F_PTR_RAW,
>  				 BTF_F_NONAME, BTF_F_COMPACT | BTF_F_ZERO |
>  				 BTF_F_PTR_RAW | BTF_F_NONAME };
> +	static char _short_str[2] = {};
>  	static struct btf_ptr p = { };
> +	char *short_str = _short_str;
>  	__u32 key = 0;
>  	int i, __ret;
>  	char *str;
> @@ -141,6 +150,32 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
>  	TEST_BTF_C(str, int, 0, -4567);
>  	TEST_BTF(str, int, BTF_F_NONAME, "-4567", -4567);
>  
> +	/* overflow tests; first string + terminator fits, others do not. */
> +	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 1);
> +	if (ret != 1) {
> +		bpf_printk("bpf_snprintf_btf() should return 1 for '%s'/2-byte array",
> +			   short_str);
> +		ret = -ERANGE;
> +	}
> +	/* not enough space to write "10", write "1", return 2 for number of bytes we
> +	 * should have written.
> +	 */
> +	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 10);
> +	if (ret != 2) {
> +		bpf_printk("bpf_snprintf_btf() should return 2 for '%s'/2-byte array",
> +			   short_str);
> +		ret = -ERANGE;
> +	}
> +	/* not enough space to write "100", write "1", return 3 for number of bytes we
> +	 * should have written.
> +	 */
> +	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 100);
> +	if (ret != 3) {
> +		bpf_printk("bpf_snprintf_btf() should return 3 for '%s'/3-byte array",
> +			   short_str);
> +		ret = -ERANGE;
> +	}
> +
>  	/* simple char */
>  	TEST_BTF_C(str, char, 0, 100);
>  	TEST_BTF(str, char, BTF_F_NONAME, "100", 100);
> -- 
> 1.8.3.1
> 
