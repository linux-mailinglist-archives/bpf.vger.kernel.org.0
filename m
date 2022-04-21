Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F550A961
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382742AbiDUTmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392059AbiDUTmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 15:42:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB34D61B
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:39:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h12so2328098plf.12
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdSJ80YjzFAv/0ifJ9BVe71E0hiRhLU7CMYyEbl2LDE=;
        b=Wf0XH/65xo8aobvK7vVWWKFBLHP24DtzWSHV4sbERSJ4uPxVj+uJ0Y6hZyICBn502E
         HEmE5WPySDtHq51CSQ67aSRpPLAcE27A1VvfW3ffAuA+eakjABTbCR+R5WGHE4Cut7Wt
         FIaaSiRI0CdXeQH2hyU7Eimv0N+zbZefHsJpFWG2OMaAHbKBuHTMVgeaGCKyBLgv7Lsu
         AENA+reaKx6Hn/EMHAwct7Qy6uJIrupgCj1lxFq67P9rMy3Vfwpg1gdBVFiX0AoH7qnL
         LkEM/5Dcf1yRqoR7tY1EnqRgFYCHdx3R9KTlY+pvil4xsfSZnzhBtnv/1fxaK2ASPbvX
         Cwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdSJ80YjzFAv/0ifJ9BVe71E0hiRhLU7CMYyEbl2LDE=;
        b=NdGANpBdAPPgCh1ozubK2TcAsfhKE0ag1zdblCeWUxKry6DtYHj/qjRixniKe0KwfG
         boVhKNazdAUhB0uyJrhxFMgjcXa60krqKqJj3gT+jKpf+TbNJwyYjN07h7LhrEfGNcwo
         QRn4dY2K7s7ozQ6R2ia6EeeQVtTFrWKM9U+Ro1W/b4e4IRCKB3DwH1yFxaM1iN7YV2Pp
         hE8Ib6HlVp0fTu3VY3kBmoCxO0dNEaVTYhktv75xFrOy1g4ZjwlhVyalj0QuQF81Wpm7
         HWFPgOR4tUEzpWm0mPxWnnBmzq/0eNF4JTg1QI0N0gjWWRdzR5XlN2X4VHvpZj7dWld+
         0HIA==
X-Gm-Message-State: AOAM5306A5Sq0ubNClTj3DPDoJAV7+wSDxI0gKBzeCZ0Fn0r7SUmt3Ua
        kcvbd5nKH29ZU7nqd2PBPrA=
X-Google-Smtp-Source: ABdhPJw87n98lrE9Xa2vRnZ3OOtoJqkw+HjkXeuSpmZsy3q133h3zkJtsMFUhPZ/+TMJ9KxMGP6R9g==
X-Received: by 2002:a17:90a:3e48:b0:1cd:34ec:c72f with SMTP id t8-20020a17090a3e4800b001cd34ecc72fmr12210838pjm.65.1650569980674;
        Thu, 21 Apr 2022 12:39:40 -0700 (PDT)
Received: from localhost ([157.49.241.21])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090a800300b001cd4989feb7sm3567062pjn.3.2022.04.21.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:39:40 -0700 (PDT)
Date:   Fri, 22 Apr 2022 01:09:53 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 09/13] bpf: Wire up freeing of referenced kptr
Message-ID: <20220421193953.zlh3z532ocxpwnuu@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-10-memxor@gmail.com>
 <20220421042651.sp45dcdzhyrbxbbg@MBP-98dd607d3435.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421042651.sp45dcdzhyrbxbbg@MBP-98dd607d3435.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 09:56:51AM IST, Alexei Starovoitov wrote:
> On Fri, Apr 15, 2022 at 09:33:50PM +0530, Kumar Kartikeya Dwivedi wrote:
> >  	return 0;
> >  }
> > @@ -386,6 +388,7 @@ static void array_map_free_timers(struct bpf_map *map)
> >  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> >  	int i;
> >
> > +	/* We don't reset or free kptr on uref dropping to zero. */
> >  	if (likely(!map_value_has_timer(map)))
>
> It was a copy paste mistake of mine to use likely() here in a cold
> function. Let's not repeat it.
>

Ok, will remove this and all the following ones that you pointed out.

> > [...]

--
Kartikeya
