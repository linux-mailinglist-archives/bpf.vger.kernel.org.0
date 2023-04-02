Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2E6D37B7
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDBLot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBLos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 07:44:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232423B61
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 04:44:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b20so106850012edd.1
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680435885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmJ6Y6EUITUAUzI6TPLRxm8u6tp9IMbrl54rL0mLlNc=;
        b=fxIDuGlOwIPqFGCJG7Ki0L8vJtYNj1tEGwxH0qzo4ki8JUoyGFdU1PY3aHhPs9GBGe
         xhmSiSzEdI4FIkdheWFMwM2uolS3xB/0jvuYW2tbggPi1XhNiLMlXaHIeGyZfYk0qlXI
         JxJx31geVupve001Sc7m0EcSEMS104izWHcP7775hLsnTeOFdfLMpodfHiBS04TfKKP+
         V8wkRnzcpr2/4b+mrgxyUnzKLMbvL54eyVq0ZmCS0Ee+kSR/CieD2nukY+e8uSyHI/X8
         CC1CTjySHVaxiqfdVQwaVIL75PukK6xGwlGYS9ShxIBisZlZE9uxHJFFdZepeunWeadB
         3QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680435885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmJ6Y6EUITUAUzI6TPLRxm8u6tp9IMbrl54rL0mLlNc=;
        b=TaCqIVdVF8crrXLIcmqVD3BNDQ6pAVMgu7dgWWnx8wxo+UZcsEmjaWuDi5frRfCh/G
         F6WLdsXbW2RmoqWCBqzejPla06czQdbbhuxR+brjOVz+hQ1+WZG2qZbKpRGJcnlDD5ae
         DI1DFzAYGBgm6XdqTa/Px2lKlkAY70Nh/Em55V4EnlcKOTRMIh4pNAjnET3sVddoRX0K
         JpUPLPvXzmjjD3Zr9WZdwsYi6rJaq69QdIprYl4+uUrWVGtUzKJ+ettX7RAXomoH+RNO
         VPLuKapkuwdpYyZUkzosiSMFKqobYNum08uktpui1KFWn4ENmXsAF8JVeNtlJi5pC749
         ITyg==
X-Gm-Message-State: AAQBX9dAi/UR/stUSxF26Nkq9n/W8OaBRqmXvJAzlGdg3u4c4a8H3wDm
        Vh0YdEg+fNgimRJdlsGu7BVLCw==
X-Google-Smtp-Source: AKy350Y/dNEyBj1RdGr181/2z9J4/padp/MH9Mc6mANFFnUB9F/ObQW9vJMrkGLXYuK5fbK/ASZp3w==
X-Received: by 2002:a05:6402:6d1:b0:502:24a4:b0ae with SMTP id n17-20020a05640206d100b0050224a4b0aemr32214653edy.14.1680435884976;
        Sun, 02 Apr 2023 04:44:44 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id t17-20020a1709060c5100b00927341bf69dsm3129816ejf.88.2023.04.02.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 04:44:44 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:45:32 +0000
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: optimize hashmap lookups when key_size
 is divisible by 4
Message-ID: <ZClq3Eh3V37eCjDN@zh-lab-node-5>
References: <20230401200602.3275-1-aspsk@isovalent.com>
 <CAADnVQJpF+rYo969niqpPPh_=Sv-2jztA0GpRYBfi-jPE65ZyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJpF+rYo969niqpPPh_=Sv-2jztA0GpRYBfi-jPE65ZyQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 01, 2023 at 03:10:46PM -0700, Alexei Starovoitov wrote:
> On Sat, Apr 1, 2023 at 1:05 PM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > [...]
> >
> >  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> >  {
> > +       if (likely(key_len % 4 == 0))
> > +               return jhash2(key, key_len / 4, hashrnd);
> >         return jhash(key, key_len, hashrnd);
> >  }
> 
> This looks much cleaner than v1. Applied.

Thanks!

> Do you mind doing similar patch for bloomfilter?
> (removing aligned_u32_count variable)

Sure, done.
