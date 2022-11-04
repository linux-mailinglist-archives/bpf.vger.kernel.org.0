Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F2C6191F6
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKDH2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKDH2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:28:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB7178B8
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:28:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so3925242pjd.4
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rj7IFiGXn0AAbpAiHGFR2G1nnVitFzbnIp3gRESbHDo=;
        b=qQt1+BUW4AOA1x3WE0K4Sq/dOjBlb13Jgl8dJ/eCk4PR8oEzm/FFnszyF5wLZ8ii/U
         lVZysmb7rsaHJs1Ld4XVZrxKdeAtA3o5JSOIKaD5TQ9A8E+6BKu2q45UK+AvtGpTab4g
         MAgQpFnUopPqRCb67d5liK+Tl8uCW9301YMK3djc8hVkXoCfTT7GuWQ5WLcyW1uXtQFL
         HOq6YPMg96PhY2nhXD75JCUlVsMAOBY9ek8l3SOQy748YU1b921X1MFjczq3c//aMFKW
         ZhygIlBBF22WD8gG0hisO9AnD/MrkUjDJvHMkoNY8/7KBOfHRcXdEuCitrondCIlge0X
         Iu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj7IFiGXn0AAbpAiHGFR2G1nnVitFzbnIp3gRESbHDo=;
        b=7EHDBm8XjEEecZQrav9VDjrVl/QryJo0WeZOghn/xnR8FyRs6JVEe/Aam9f1Bgn/N+
         hAL7O/Wv3CsMhqAlHE4yXpqrJPt+PpBuArX3vGWfreMq42NM51NLT5ohfJtCsr1kKLKs
         U3HArf9a97P9Aq1DEzXc9wzLz1T6kgn/QECb9f0xW/PER08Q+zCK8rztPZh9iefTS8Mc
         OZL7z+A5hK2GX0jJ5IO29oNsQDyTyyu7dNcgQWnCwgVWcwvzkYy9/GWxbGgsH72aPTtS
         i0O7TcCDbnKO2S1ZcxDnDpIV1+hCeYR9IzC4ZuRPV+q117ln7pgAqshAB3jFoxgKobno
         cVNw==
X-Gm-Message-State: ACrzQf3HDirLvRe9fzZLgNk6RpJGEIMbqZRcnIEWpxKCgG5Zx1xpTO2b
        7JJRI+XiSXpSh3KN8eOUPCU=
X-Google-Smtp-Source: AMsMyM6ebeNs95BNCqUmjgiay183LsFFBQsuM0Sqr+rvjjuN1U+XV8Ssgirq4Mckw92jR9aCrnLJiw==
X-Received: by 2002:a17:902:f252:b0:186:9efb:7203 with SMTP id j18-20020a170902f25200b001869efb7203mr33455306plc.12.1667546903415;
        Fri, 04 Nov 2022 00:28:23 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i134-20020a62878c000000b00561dcfa700asm1941319pfe.107.2022.11.04.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:28:23 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:57:58 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104072758.rr6uleke3arkpwxt@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
 <20221104030028.muy5ui3an3vkdfqg@macbook-pro-5.dhcp.thefacebook.com>
 <20221104070241.sa2v7ertneocowcq@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104070241.sa2v7ertneocowcq@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:32:41PM IST, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 04, 2022 at 08:30:28AM IST, Alexei Starovoitov wrote:
> > On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >  		else
> > > @@ -311,11 +344,12 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
> > >  		return;
> > >  	}
> > >
> > > -	for (i = 0; i < map->off_arr->cnt; i++) {
> > > -		u32 next_off = map->off_arr->field_off[i];
> > > +	for (i = 0; i < map->field_offs->cnt; i++) {
> > > +		u32 next_off = map->field_offs->field_off[i];
> > > +		u32 sz = next_off - curr_off;
> > >
> > > -		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> > > -		curr_off += map->off_arr->field_sz[i];
> > > +		memcpy(dst + curr_off, src + curr_off, sz);
> > > +		curr_off += map->field_offs->field_sz[i] + sz;
> >
> > This is a clear bug. The kernel is crashing with this change.
> > How did you test this?
> >
>
> For me it is crashing at bpf-next now without this.
>
> When for map value with size 48, having fields at:
> off: 0, 16, 32
> sz:  4, 16, 16
>
> The above produces:
>
> memcpy(dst + 0, src + 0, 0)
> memcpy(dst + 4, src + 4, 12)
> memcpy(dst + 32, src + 32, 0)
> memcpy(dst + 48, src + 48, 0)
>
> Without it, it becomes:
>
> memcpy(dst + 0, src + 0, 0)
> memcpy(dst + 4, src + 4, 12)
> memcpy(dst + 20, src + 20, 12)
> memcpy(dst + 36, src + 36, 12)
>
> I will send a follow up fix.
>

I think this is broken in the original code, I didn't realise this at first but
it's effectively the same in that commit. So it should have Fixes: tag for that.
