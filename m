Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC50B44A702
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhKIGvc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 01:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbhKIGvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 01:51:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26DC061766
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 22:48:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso1049164wmd.3
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 22:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDg4EfYyQlktMfASerfzCufE4z7AwT0PxzRc+DnymYM=;
        b=y1To8VpQmwo5VU6Ze1EuRL4i8u1RkUTtv8zEzUfCqbW/HiuXbX8FTSszTfhOA/Df6i
         IjFmWuKGvP2pJ+lXDZuuDHQ4x7x9S5PiNTEVI/cd7xpc7v+kbKzddFkbjcthW0ZtJcKk
         +SxIg34aC25VrQJAne835WTNQJCQryCLl2v5Eq/oPIzrbU2pR/3rtdHlTO8ZCNbwcmEg
         bIQoPLSNrRqMJXw0zrsOKG3kMsvG3rNXL/LCtLZeUk35W2OQJ+F5Pv4zZ7UI0d5reZgd
         NlJbkTM9fPJ5GoJ6W8LU6ALOKlyu+h8oRsQr++lDDSxeRVU6/0gIO/CfaGmfYWGX3tV6
         Yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDg4EfYyQlktMfASerfzCufE4z7AwT0PxzRc+DnymYM=;
        b=MGN+Pzoslpz0wYP13ve0RuIFPIB9cPEj9R9EsyMeGGcxe++aLFBCA66axoxXss3eNs
         EWCcVP+X5eUSo/EJNrwEFZcwo/nZpLTue1ZwwEl1xuBwOEv5fg4OIzXpvmymA1rmnTFB
         q3AtV7mmXOR8+sZRxwcyTC+Am5+SkV/T9zggabb+luoWdz511KugSkdk07uwqlbxdhIO
         yu206aO8LYhKmdWTupu+DJW94/+3sCW6Vs3PIPPeQ4ULDPaNi4KeafItPf2VeFvZv+a5
         CRz+yyBMNZ3MEb7YdATvLUXVurGHrYwF5phByFJxExglTy9AGDZU6WB0Hyx4AVydFZ8C
         bs5A==
X-Gm-Message-State: AOAM533HulxUgmp41Blx9aB33nmsI6sSo1v/kuTrC26u0asQHKJ2xwOj
        dL4oiG+4k2OFpohFMVPucMiNEcZqOf+p9nPHZRY=
X-Google-Smtp-Source: ABdhPJzGmax9buTiHVqEJkHAzARS1fg5sYe4LbJYbfcnI3urUJklCzBxgH4DMtXJTSWBGwtCFFh5LQ==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr4540613wmf.55.1636440522693;
        Mon, 08 Nov 2021 22:48:42 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id o1sm19242782wru.91.2021.11.08.22.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 22:48:42 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:48:37 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com, john.stultz@linaro.org,
        sboyd@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        rosted@goodmis.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests for allowed helpers
Message-ID: <20211109064837.qtokqcxf6yj6zbig@amnesia>
References: <20211108164620.407305-1-me@ubique.spb.ru>
 <20211108164620.407305-3-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108164620.407305-3-me@ubique.spb.ru>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 08, 2021 at 08:46:20PM +0400, Dmitrii Banshchikov wrote:
> This patch adds tests that bpf_ktime_get_coarse_ns() and bpf_timer_* and
> bpf_spin_lock()/bpf_spin_unlock() helpers are forbidden in tracing
> progs as it may result in various locking issues.
> 
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>  tools/testing/selftests/bpf/test_verifier.c   |  36 +++-
>  .../selftests/bpf/verifier/helper_allowed.c   | 196 ++++++++++++++++++
>  2 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/helper_allowed.c
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 25afe423b3f0..e16eab6fc3a9 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -92,6 +92,7 @@ struct bpf_test {
>  	int fixup_map_event_output[MAX_FIXUPS];
>  	int fixup_map_reuseport_array[MAX_FIXUPS];
>  	int fixup_map_ringbuf[MAX_FIXUPS];
> +	int fixup_map_timer[MAX_FIXUPS];
>  	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
>  	 * Can be a tab-separated sequence of expected strings. An empty string
>  	 * means no log verification.
> @@ -605,7 +606,7 @@ static int create_cgroup_storage(bool percpu)
>   *   struct bpf_spin_lock l;
>   * };
>   */
> -static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l";
> +static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l\0bpf_timer\0";

There is extra null byte at the end.


-- 

Dmitrii Banshchikov
