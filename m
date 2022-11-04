Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A3619183
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKDHDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKDHDG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:03:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749B25EA4
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:03:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s196so3666051pgs.3
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTD7IOlWYohq+/hUNL7bZFogc8aR0kxMlum5Hp0+ngc=;
        b=PouVaWolyjXxKzJz4lBKPVg+1i3iSJI3XP620mWZ1Bv0X7Muv8WFpSeSEx/mf5jb2y
         /imw4HjPiiY0SN7NMiKFs/pkKdsZlRW47BrNKXWkcflX6+07T38ValUxVD9GukwTBTfH
         GMSeFMM/3gxL9wbNTpIvnV1RMX9lbHC2Feek+NyMSwjNl1naJ4pf5t1+LUS9os4onhJV
         FWprgtqUN2g0QvSsTlu/gBPjXCf8FiEyzFWIsGgrJGZS7ofZXNons04mnRxnz7cAx3Kj
         u7W9okvZbr766j9Dp0iVu8+L167jzjlnXs3f6VAWfPumFdbVPaFFMn3GrMLsQl1iCfVs
         f7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTD7IOlWYohq+/hUNL7bZFogc8aR0kxMlum5Hp0+ngc=;
        b=OGIbK3g74uT2f7RmdUvvKTJ20aJEOOoV1hrKO79jI+WKWD8DI8HORUtWy4dOfhxHWT
         EZ/IT0WfymWKLtZT2wZbxa9Cww2nGNRzOeVcKJCfcXo1Ex7+bpCUdyvKjPsWobRLmNZl
         AJBrNQXypTorZAwN8XLhzPaQoxrPdQanrg7Mog7zGBzLewm2E6OTW3afnYbONR0bmtv3
         JLvjKwJ3ZvMo39cExRo20BNfJBaz3Bjf8nXUY6CFKaK0BqWikI+KcQ3jzvE4xl6S/A7A
         pu5ch6DOJja9Abq5IgJJLUIz+D9gnxluCDPVxw5iy7/H1DXyQXEimy/f/75lKw+tPrP2
         bNGQ==
X-Gm-Message-State: ACrzQf2p9lR+FAPJ5fDFbchqXgYwo5OTSk1EEV3YBpVnRaoUTHWylVcZ
        elQ7YZ27KftREQQZ3O5mWnRPnHLK54gnwQ==
X-Google-Smtp-Source: AMsMyM5ZHsNcMenfhKL7HKE8yf0tZu39b0gv1bYZmIVOi+j5HiZwM3DB6wc39nn47CmrP1VPS3X7zA==
X-Received: by 2002:a63:1cb:0:b0:46f:a202:fa36 with SMTP id 194-20020a6301cb000000b0046fa202fa36mr24881471pgb.276.1667545384421;
        Fri, 04 Nov 2022 00:03:04 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id c193-20020a621cca000000b0056b9a740ec2sm1873369pfc.156.2022.11.04.00.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:03:04 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:32:41 +0530
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
Message-ID: <20221104070241.sa2v7ertneocowcq@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
 <20221104030028.muy5ui3an3vkdfqg@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104030028.muy5ui3an3vkdfqg@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 08:30:28AM IST, Alexei Starovoitov wrote:
> On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> >  		else
> > @@ -311,11 +344,12 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
> >  		return;
> >  	}
> >
> > -	for (i = 0; i < map->off_arr->cnt; i++) {
> > -		u32 next_off = map->off_arr->field_off[i];
> > +	for (i = 0; i < map->field_offs->cnt; i++) {
> > +		u32 next_off = map->field_offs->field_off[i];
> > +		u32 sz = next_off - curr_off;
> >
> > -		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> > -		curr_off += map->off_arr->field_sz[i];
> > +		memcpy(dst + curr_off, src + curr_off, sz);
> > +		curr_off += map->field_offs->field_sz[i] + sz;
>
> This is a clear bug. The kernel is crashing with this change.
> How did you test this?
>

For me it is crashing at bpf-next now without this.

When for map value with size 48, having fields at:
off: 0, 16, 32
sz:  4, 16, 16

The above produces:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 32, src + 32, 0)
memcpy(dst + 48, src + 48, 0)

Without it, it becomes:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 20, src + 20, 12)
memcpy(dst + 36, src + 36, 12)

I will send a follow up fix.

> >  	}
> >  	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
> >  }
> > @@ -335,16 +369,17 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
> >  	u32 curr_off = 0;
> >  	int i;
> >
> > -	if (likely(!map->off_arr)) {
> > +	if (likely(!map->field_offs)) {
> >  		memset(dst, 0, map->value_size);
> >  		return;
> >  	}
> >
> > -	for (i = 0; i < map->off_arr->cnt; i++) {
> > -		u32 next_off = map->off_arr->field_off[i];
> > +	for (i = 0; i < map->field_offs->cnt; i++) {
> > +		u32 next_off = map->field_offs->field_off[i];
> > +		u32 sz = next_off - curr_off;
> >
> > -		memset(dst + curr_off, 0, next_off - curr_off);
> > -		curr_off += map->off_arr->field_sz[i];
> > +		memset(dst + curr_off, 0, sz);
> > +		curr_off += map->field_offs->field_sz[i] + sz;
>
> same thing
