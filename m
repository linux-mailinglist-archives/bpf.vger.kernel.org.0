Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962495A08D6
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 08:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiHYG3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYG3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 02:29:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B29F8C5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:29:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so17045263pgb.4
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=xN6ix5QqMvCzHdKCZRghSQjKhZolGhFYirvCfNMJwm4=;
        b=VGFXpHAXG74OwfpnWZVMx+8MKd6qJN12XuXgtIm9TApmsIHExDaH1uCbHX0okWeeZK
         bg5lX5V6hQdBo84TPP1pNG1itw1AWDwhCIylGsMig1g/usG7u8KH+kxwyzhF0CouIPAM
         u4wSPeuhRoGiON1gE0uWKusEj6/Q1txPG/tzLFa5FwPrEtiDFsoCBoqNIzk35D5SwQaP
         bkCowqMPLeJHVmwLDxmqZDikaZK+JynXIttS6Su3MSavB0yehUzroZ/q+qOpzG2B8iPJ
         5HEoO6QrmuRiEpIakRlHBv66vE9q27DGG/Ihj13qAYfonm/dp7KOnvBDj/1KcJcjtrMb
         Yq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=xN6ix5QqMvCzHdKCZRghSQjKhZolGhFYirvCfNMJwm4=;
        b=WykNqrTjOKM/ME3n56/F1fCTVW4aXwE4U+Au40C3m5iHmceDEqvmfwnEr1SNCExVdt
         drmLypexmPL7X3kyL6i0YOXtttPxmMFzMWgDrs+EYoaPT6Rq9P2kb7NN8p0l9Bp/KNt/
         GnhvbjaXuLPMcCqlN/2cO2OAjNH5mTwXoFyXHzBHyEiTARCScHsIaSJuqqS+pDK9NO2Y
         CWvGje+5olBcnYGOQmiQyQ9hs43nK0JfrzblzMx4lG3AvYRIvFvNH1LWsf8sm/LX6MzU
         nqeCWAHoTPDKVcLz9FIGncSywKXFeHXx2ojLI9A+NubHm3GE4dpu3hO1kFADOi85TjmD
         JNbQ==
X-Gm-Message-State: ACgBeo0yU07oQ8uUFjAea+EJ5uYScVhiv+67cgcZDyIvk2p7w2eSsDR4
        koTYmCcB/6blUjc76jf4THY=
X-Google-Smtp-Source: AA6agR5DyslL9y11JoCLXtcHz2ineChQwQ+EaI1nngs9k2EiNACM1jdYCAdQwFvpuahRw7aF6LABXA==
X-Received: by 2002:a63:86c2:0:b0:42a:42d5:a4a6 with SMTP id x185-20020a6386c2000000b0042a42d5a4a6mr2021763pgd.189.1661408978050;
        Wed, 24 Aug 2022 23:29:38 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id q67-20020a634346000000b004161e62a3a5sm12290260pga.78.2022.08.24.23.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:29:37 -0700 (PDT)
Date:   Wed, 24 Aug 2022 23:29:36 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Lam Thai <lamthai@arista.com>, bpf@vger.kernel.org
Cc:     Lam Thai <lamthai@arista.com>
Message-ID: <630716d02ebbe_e1c39208c3@john.notmuch>
In-Reply-To: <20220824225859.9038-1-lamthai@arista.com>
References: <20220824225859.9038-1-lamthai@arista.com>
Subject: RE: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lam Thai wrote:
> When `data` points to a boolean value, casting it to `int *` is problematic
> and could lead to a wrong value being passed to `jsonw_bool`. Change the
> cast to `bool *` instead.

How is it problematic? Its from BTF_KIND_INT by my quick reading.

> 
> Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
> Signed-off-by: Lam Thai <lamthai@arista.com>
> ---

for bpf-next looks like a nice cleanup, I don't think its needed for bpf
tree?

>  tools/bpf/bpftool/btf_dumper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 125798b0bc5d..19924b6ce796 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -452,7 +452,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
>  					     *(char *)data);
>  		break;
>  	case BTF_INT_BOOL:
> -		jsonw_bool(jw, *(int *)data);
> +		jsonw_bool(jw, *(bool *)data);
>  		break;
>  	default:
>  		/* shouldn't happen */
> 
> base-commit: 6fc2838b148f8fe6aa14fc435e666984a0505018
> -- 
> 2.37.0
> 


