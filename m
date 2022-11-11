Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AD626326
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKUp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiKKUp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:45:56 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB18833A2;
        Fri, 11 Nov 2022 12:45:55 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id g24so5121613plq.3;
        Fri, 11 Nov 2022 12:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnI7n9XZqmIR17w46t8MUJxKc1QyxlQoFQRbOEAeGo8=;
        b=ghpI9XVfAJyyM74p2KldKROpseFBFk3gc6WoZn3NY8JZd0SHq+m18oXuM/3J4ye5TX
         n3fDjzmj2Kqc2pZY9VqmaE7aNoYsh9A756wN+cKfWv48JlI0KSHwjkj56NSXAl+iGuaM
         hBti4WA3TPRIzbeijIY7FgCeFqlv4XPAatmwEyZTRhakGZy8FbEfiNrMjcoFGEyHzQM2
         AahitdOsfddBSTP6fkwFEk7txIrX0MUVKoDzzPVl1xgcJkgaD9+1MrN8EUzUEj/HPTBX
         91Z6dMetU1365RCsUQKPMko7wKdNksi0QyBGc65tobb4sFbfi2OX8/NwyeVKzE20QcWU
         W7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnI7n9XZqmIR17w46t8MUJxKc1QyxlQoFQRbOEAeGo8=;
        b=MS6FJ4mXrKoKMFN79rvWp5OanxXZluc/YZ3mZU+NDafD0Rug4QBOj5wtrk6pnvsWWP
         RKQTzgRusgaAHFZq3FkZUl8nHXG7RXQsEptzHLY6qNh3jSqOgxlGtZ/5VPVB/82oBsBk
         rY0cfC5ZiIXx6K88ptYyqHDsb+S1+/oy1q3HckWXnovKpC4T8D0vcj+Qmu57+L4aeuW2
         59+DgImYxpH3vVfrq9e4a9zpy/Xpn+OkqzOy3GHCvxp3yhPPx9lRxf2lcIdyTbQzzKRH
         NXyA99JnXhohLZq5P/luyUj9y8TXsIlPzNyD5qYVE6Ckxg2GWgoXgxLY+PInG4Mop4ar
         lJLw==
X-Gm-Message-State: ANoB5pnMS7mERC6Lzb3QApQ+fILdE79tBlu4RWVTC0P4m15/Pf4ylULr
        mlq1hALCEglIgGDqGMGYHZBQaxObWuBwQA==
X-Google-Smtp-Source: AA0mqf4CfHK/0b5SOuNYZ7g/gl3mQmf/15k+g4zZRHPmt2xQ/5BDNClybz09JeHVS+G42dkHiLREjw==
X-Received: by 2002:a17:902:d151:b0:186:7db1:d294 with SMTP id t17-20020a170902d15100b001867db1d294mr4334140plt.68.1668199554918;
        Fri, 11 Nov 2022 12:45:54 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm2138027plh.158.2022.11.11.12.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:45:54 -0800 (PST)
Date:   Sat, 12 Nov 2022 02:15:47 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     sdf@google.com
Cc:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix offset calculation error in
 __copy_map_value and zero_map_value
Message-ID: <20221111204547.lyeim477afgfgkhh@apollo>
References: <20221111125620.754855-1-xukuohai@huaweicloud.com>
 <Y26f4H7buQXKqQFd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26f4H7buQXKqQFd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 12, 2022 at 12:47:52AM IST, sdf@google.com wrote:
> On 11/11, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
>
> > Function __copy_map_value and zero_map_value miscalculated copy offset,
> > resulting in possible copy of unwanted data to user or kernel.
>
> > Fix it.
>
> > Fixes: cc48755808c6 ("bpf: Add zero_map_value to zero map value with
> > special fields")
> > Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> >   include/linux/bpf.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 74c6f449d81e..c1bd1bd10506 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -315,7 +315,7 @@ static inline void __copy_map_value(struct bpf_map
> > *map, void *dst, void *src, b
> >   		u32 next_off = map->off_arr->field_off[i];
>
> >   		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> > -		curr_off += map->off_arr->field_sz[i];
> > +		curr_off = next_off + map->off_arr->field_sz[i];
> >   	}
> >   	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
> >   }
> > @@ -344,7 +344,7 @@ static inline void zero_map_value(struct bpf_map
> > *map, void *dst)
> >   		u32 next_off = map->off_arr->field_off[i];
>
> >   		memset(dst + curr_off, 0, next_off - curr_off);
> > -		curr_off += map->off_arr->field_sz[i];
> > +		curr_off = next_off + map->off_arr->field_sz[i];
> >   	}
> >   	memset(dst + curr_off, 0, map->value_size - curr_off);
> >   }
>
> Hmm, does it mean that it currently works only for the cases where
> these special fields are first/last?
>
> Also, what about bpf-next? The same problem seem to exist there?
>

Replied with the patch in the other email.

> Might be a good idea to have some selftest to exercise this?
>

I agree, there was another bug in the same code before this, so I think we
should add tests for this (I should have done that with the commit being
fixed...).

Xu, if you have cycles, can you work on testing a few edge cases and make sure
we don't regress in the future? Otherwise I will take a look next week.
