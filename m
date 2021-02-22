Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0E32226F
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 23:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhBVW5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 17:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhBVW5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 17:57:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3CC061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 14:56:22 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 75so11165068pgf.13
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oMEyLHldf6jylYR750dmdVQVYOTW1/PXbP41XeNHHuc=;
        b=E+m6j8jJGjKqDgwAlP4MjJcqyAVTnS8+VN/ZnWYNlTI9xSuw21rpe16S2dy5tbyiwb
         U/VLFZ8my5anoNMqmBag6niSIiOGZFjqJwgVE6/oBUenNTEvjLXKx4YQiiJqUkq04zAe
         fGByTVp2RqKVogZfNfCUStKevlPxkquvZ44vWsODQ/Sp8GguJE3oz75V0+izLJle+CZW
         DCidmoo37uUrsN1Eer94V68KDZZddOmggGhDAN7lWiaXLQKKDmJgBsnMpbRTsaHmrEki
         qvou9ZKrpHMQkaVr8XaaBkvcxW+pUy+6isNB+emOqZi9Ha5/RLcQi5C6D+T4umIAFMqp
         LTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMEyLHldf6jylYR750dmdVQVYOTW1/PXbP41XeNHHuc=;
        b=Vt0uWKs2MJSCzEeaNB0J6uVC/Qzslbf5yaVJwM+H58nOPVrzInvEzX6jbK2JwwTefY
         ZFzp7MV4QUoM+8FkIm2Pe0tE363T3vw1qfQPxmowloRsQ62p90IzyxSkUB4Ui15N3ycs
         bKDGDX3ovImhn4yw/AZLyByBXUXdc0OPB8+rg+ns9kI8Indgjas6Aa06Mw7RE+1Q6mCl
         UFKlJo3YfcuCBoEDWYgFG3gtOdrjgBP39KeLKPUk47KC4iy6cRvMYaRbBbsh4mThjR3O
         Tzv5HAZEheiIBYBl5VG+PQGUJDXXRjOP9RYTgHiMbhJzsSXaRhTliPfeJir4rCeu9ZJ7
         p3JA==
X-Gm-Message-State: AOAM530AWtysiXGvwzz5uOEtLj7rZNBDf9X0YtNhJWbfZ8lUsiwkVkWp
        OMM/xDGY+Ni0dD/sF4bygJI=
X-Google-Smtp-Source: ABdhPJzgNfkWiOULZcz5zwcz/cHZLdbC9SmVYUVVKkkmSsqNA+B2ajFjHC8H63lf/cwG0NxtKw9fFw==
X-Received: by 2002:a63:f648:: with SMTP id u8mr10829792pgj.270.1614034581576;
        Mon, 22 Feb 2021 14:56:21 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b9ca])
        by smtp.gmail.com with ESMTPSA id 7sm20080734pfh.142.2021.02.22.14.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 14:56:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:56:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 05/11] bpf: add hashtab support for
 bpf_for_each_map_elem() helper
Message-ID: <20210222225619.iakpkks7htobsdlk@ast-mbp.dhcp.thefacebook.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181808.3190262-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217181808.3190262-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 10:18:08AM -0800, Yonghong Song wrote:
> +			ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
> +					(u64)(long)key, (u64)(long)val,
> +					(u64)(long)callback_ctx, 0);
> +			if (ret) {
> +				rcu_read_unlock();
> +				ret = (ret == 1) ? 0 : -EINVAL;
> +				goto out;

There is a tnum(0,1) check in patch 4.
I'm missing the purpose of this additional check.

> +			}
> +		}
> +		rcu_read_unlock();
> +	}
> +out:
> +	migrate_enable();
> +	return ret ?: num_calls;
> +}
