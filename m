Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E7618F55
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 05:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiKDEBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 00:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDEBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 00:01:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F751D679
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:01:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v17so3825143plo.1
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 21:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LDpen9auzv65wySFq2IeraImjWTe2BH5sf2SSIkqlk=;
        b=MlHLteFIuvhYw5+8r4oAirYRsyrzy0h7BtbluFK7wS2DXfh0y2bK+JH4D0RqmUfWgK
         Wj2wa9IQSUPMz93QSUhsfNnfH47YJ3L3vDoHZvQPUtaySf8SjlQkztqTD0MajFyXUY+L
         K8UppWoFUB7M5+yD60K/m5DDRPWJ1RF2GWIjDzYPAqBNkriOUafxO3Ui7p1/MB/JZFmP
         yxAD1WL//SV1/t+eGk+hd5PBO4XUfcyyHtoDZTsPXcmldGJUvyHd6k0T9Qr1bKk8G/1x
         G+V45n9/EVbcHoLVQpwgwvZIFoLCofJ2y7JPNf9ANEx9y0Q89OdXxLDyziY4jZdGMDBu
         U4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LDpen9auzv65wySFq2IeraImjWTe2BH5sf2SSIkqlk=;
        b=17Z7OmUBqhkifW2yDukeUy5uJZ0+B9jPvzGbs54f0skC5hCoNUVO2Bh1Jvtq5Ok8sN
         O5a9OMlTm9okm84Yekjm8XUYo8f9N1qEl0EpBfVBWVtOWhEautGCd8ezA8PLcieGBGVR
         bR/ev0QxqDfGUbXF6oB+aG/ZfKnr4N8eCzdlOqG/2sSrKr5y4hGyNixZKQBqCm9miYRz
         9lHr/yngpqq6WCUMCAVKyaTaRW82q3cLI1fnfO9TdMPrFSPjDxH36N2pwHSMBx+CkIY8
         bIljkJNoKtEM63yZy0l9jGtZjktq7Req7KKpuHocbNYFooIldxfMMV9W+9WE5MzlP/ig
         fCFw==
X-Gm-Message-State: ACrzQf3lmeGooJ/GfQhh+V+DV1rdZxknlL8IqSBcN63Vag4AjhoW3QkL
        NHWi0LdHMxQdUL0FYlMIDq4=
X-Google-Smtp-Source: AMsMyM7tmkhI6SlrmCEKjIjxdOpMsLeG70MbAkd9yhQrQ/jAh/+AkYKU5JaKnUHmFN9ji5ls+hHMFQ==
X-Received: by 2002:a17:90b:4ac6:b0:213:ef82:b111 with SMTP id mh6-20020a17090b4ac600b00213ef82b111mr22903958pjb.170.1667534461414;
        Thu, 03 Nov 2022 21:01:01 -0700 (PDT)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:2035])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b0018658badef3sm1432876plg.232.2022.11.03.21.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 21:01:00 -0700 (PDT)
Date:   Thu, 3 Nov 2022 21:00:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104040058.mo4r62wf72clvhcb@macbook-pro-5.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
>  
> -enum bpf_kptr_type {
> -	BPF_KPTR_UNREF,
> -	BPF_KPTR_REF,
> +enum btf_field_type {
> +	BPF_KPTR_UNREF = (1 << 2),
> +	BPF_KPTR_REF   = (1 << 3),
> +	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
>  };

...

> +		for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
> +			switch (map->record->field_mask & (1 << i)) {
> +			case 0:
> +				continue;
> +			case BPF_KPTR_UNREF:
> +			case BPF_KPTR_REF:
> +				if (map->map_type != BPF_MAP_TYPE_HASH &&
> +				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> +				    map->map_type != BPF_MAP_TYPE_ARRAY &&
> +				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> +					ret = -EOPNOTSUPP;
> +					goto free_map_tab;
> +				}
> +				break;
> +			default:
> +				/* Fail if map_type checks are missing for a field type */
> +				ret = -EOPNOTSUPP;
> +				goto free_map_tab;
> +			}

With this patch alone this is also wrong.
And it breaks bisect.
Please make sure to do a full vmtest.sh for every patch in the series.
