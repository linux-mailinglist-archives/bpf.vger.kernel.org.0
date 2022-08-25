Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7E5A08C7
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiHYGVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYGVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 02:21:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77F979F2
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:21:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pm13so10410207pjb.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc;
        bh=y2KmF1FHB2cUq19gxZvIaOf+AbwfAXViCh2dUqLapuA=;
        b=B0liBOdPFulUBwoUBTrcea1wSEgqbELCjYc1OIr6GCaamYx6XLyUfYPxWiC04gVbap
         uN3VzOyHxkoBT+Q8DNgbs2VXDX1vD48qdGQcIMRixS6DVrDQRrAz0iNGPxZuLCKKaOUH
         e6fc0+SFs/ikaJzPs675tJoSHU1jWeC5a/IcJBHSB0GahsDItz+d1rFQD4/R16RQWynT
         x5EZgxJCVzhar7jLt2DgjXcERktEunN+/wBkecyxEkiFBz9P4BW6vYy7yZfbg6YHbS9D
         4WNYY0Yf2HPKl4Q0UW0Ff6h3Q+2Jm+ZAhMKJalJzYUrHWtevALsv5hu+Gj4b8bZMHVR+
         hLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc;
        bh=y2KmF1FHB2cUq19gxZvIaOf+AbwfAXViCh2dUqLapuA=;
        b=eTXBopkgo4J47TQZFi41xL6SuNGWydniTdCpPLWuOB6UraNAFvRHOeX1Lv71w65IFR
         geIlSOD+m7LJvM631vNOflwqVwcPoq0iTWg9iyJX6lnKdl/bjZZrjMIjvQ+MSdYV/bjt
         ImHrw1rW3kDJc/fEAatJ+VHezuYH/pgvYVWNQ3p2OsUzO419AxihRQvWeOJnMsdmvx9m
         pH/0G84zN28wajkolSkXl7BUMIbGWW0dWHkwdwEF63mW5JwMISJBLCzGS7YmAipZymhj
         S8ica0X3eQstSu3NaqOLu3FG7qoA4CrsiJ6hS0/UsCpVcVs8zHzsIa+o/63WLUUBAabO
         JGqw==
X-Gm-Message-State: ACgBeo0brNvK8TKTlPZqqefo/kUJ3SlHSdp50EWYxtyiiP9/m81zkC1S
        k1jNNnmQZg13PjHThkjK25s=
X-Google-Smtp-Source: AA6agR4s09ttes2H36G2Qnz1Zg2pgQ8DRcoUmExjWoI955nN8HnCnME7G9RDO+AwmDSE5DDC4Cxmhw==
X-Received: by 2002:a17:90a:b00f:b0:1f7:67c6:5df5 with SMTP id x15-20020a17090ab00f00b001f767c65df5mr2882653pjq.59.1661408498859;
        Wed, 24 Aug 2022 23:21:38 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902f35200b0016be834d54asm13528268ple.306.2022.08.24.23.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:21:38 -0700 (PDT)
Date:   Wed, 24 Aug 2022 23:21:37 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Message-ID: <630714f155a8_e1c39208a1@john.notmuch>
In-Reply-To: <f040525326088f63201d2ef76a7b759f44f38350.camel@gmail.com>
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-2-eddyz87@gmail.com>
 <63055fa5a080e_292a8208db@john.notmuch>
 <f040525326088f63201d2ef76a7b759f44f38350.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
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

Eduard Zingerman wrote:
> > On Tue, 2022-08-23 at 16:15 -0700, John Fastabend wrote:
> 
> Hi John,
> 
> Thank you for commenting!
> 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 2c1f8069f7b7..c48d34625bfd 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> > >  	return type & PTR_MAYBE_NULL;
> > >  }
> > >  
> > > +static bool type_is_pointer(enum bpf_reg_type type)
> > > +{
> > > +	return type != NOT_INIT && type != SCALAR_VALUE;
> > > +}
> > > +
> > 
> > Instead of having another helper is_pointer_value() could work here?
> > Checking if we need NOT_INIT in that helper now.
> 
> Do you mean modifying the `__is_pointer_value` by adding a check
> `reg->type != NOT_INIT`?
> 
> I tried this out and tests are passing, but __is_pointer_value /
> is_pointer_value are used in a lot of places, seem to be a scary
> change, to be honest.

Agree it looks scary I wanted to play around with it more. I agree
its not the same and off to investigate a few places we use
__is_pointer_value now. Might add a few more tests while I'm at it.

> 
> Thanks,
> Eduard


