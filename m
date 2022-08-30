Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB565A60EF
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH3Kld (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3Klc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 06:41:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138B9A99D
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 03:41:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b5so13622977wrr.5
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=8Rj9+DjhOY3ujUKP9B2raP154GqlkoLt9zAowUyjN/g=;
        b=dGWBZdYPvts4zAo26KOCamW+0ojextozuXzYZyBqh8qM0tXprecUnruqiEm9ni3H3c
         5Xb4pP7qBtq52xJD8opKCPANWmizv078tfolheM/vMRrdlWA36siabkpcgZeTYeh2FEx
         xZzA/3C4Dhucl3K6vOSbcha9i7D5Oh9lBN+mQBsDr5Rc9bojof7+VblGwJ3QCogAGskf
         5ZcfTr2NnE9CS5KJAkl6F3h5xEhrVNio3VY09hDp5jtKgM522wjDbsmUfFtwVeiIiJX1
         9CTQyLR3zw/5KC+aF9O5BjSCIKJWFaKo+lSPQmebg6ruoZCL6ASEK0T+E8TLhPb+4Yso
         1W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=8Rj9+DjhOY3ujUKP9B2raP154GqlkoLt9zAowUyjN/g=;
        b=i4tBCb86M+0W1Q2+fnvzIinSXADeLX0tqT/tHv6sFgVIN0j3ZZqjeusZeWssLbHOo7
         j6sZ6iORG31RL45Iu75ynHK3hGjcnr/bo67AR+5wMBcFvMptvVY+vq3nfVjLfTjWZ3E5
         BgCI0hsx/ympWObPqnw7KPIbqXW6H2Zu/37Ag1ZxYz43MWO3k59vG+7C6s8pRrh/G9HK
         crGvLMYfw40DwyIxx5gCv+ekmVNOs+Bcjw+rR0IeAdH/CCT+MMf/arygXrcKPxCaFaTt
         z0CT5vYWLWmwNSI2lQkv5kNNU3nU8i+PPUFpd5FsnfJZ3OvZusRRWH2WfXLCHzd7FkKI
         gAQA==
X-Gm-Message-State: ACgBeo1XXQWmub5k4fhnsFf/q92SJ707GUT2raySXh4qBjf/MTASnIQ7
        NktCBuJzVy0dXzNDIRr1tPM=
X-Google-Smtp-Source: AA6agR5iLFYQapUrQnh1i2T9PKq5L7TAeJ0ZaiNng4pjjSYeHEk4EsfbCJoLm6aIhmTq+aQfC1mdyw==
X-Received: by 2002:a05:6000:1c1e:b0:225:84e6:658f with SMTP id ba30-20020a0560001c1e00b0022584e6658fmr8845265wrb.6.1661856090525;
        Tue, 30 Aug 2022 03:41:30 -0700 (PDT)
Received: from [192.168.1.24] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e3-20020adfe383000000b0021ef34124ebsm9694666wrm.11.2022.08.30.03.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:41:29 -0700 (PDT)
Message-ID: <83b97d563cd3f2041288fcffad1e830aac3bc2da.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Date:   Tue, 30 Aug 2022 13:41:28 +0300
In-Reply-To: <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
         <20220826172915.1536914-2-eddyz87@gmail.com>
         <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

Thank you for commenting.

> On Mon, 2022-08-29 at 16:23 +0200, Daniel Borkmann wrote:
> [...]
> >   kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 39 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0194a36d0b36..7585288e035b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> >   	return type & PTR_MAYBE_NULL;
> >   }
> >  =20
> > +static bool type_is_pointer(enum bpf_reg_type type)
> > +{
> > +	return type !=3D NOT_INIT && type !=3D SCALAR_VALUE;
> > +}
>=20
> We also have is_pointer_value(), semantics there are a bit different (and=
 mainly to
> prevent leakage under unpriv), but I wonder if this can be refactored to =
accommodate
> both. My worry is that if in future we extend one but not the other bugs =
might slip
> in.

John was concerned about this as well, guess I won't not dodging it :)
Suppose I do the following modification:

    static bool type_is_pointer(enum bpf_reg_type type)
    {
    	return type !=3D NOT_INIT && type !=3D SCALAR_VALUE;
    }
   =20
    static bool __is_pointer_value(bool allow_ptr_leaks,
    			       const struct bpf_reg_state *reg)
    {
    	if (allow_ptr_leaks)
    		return false;

-    	return reg->type !=3D SCALAR_VALUE;
+    	return type_is_pointer(reg->type);
    }
   =20
And check if there are test cases that have to be added because of the
change in the __is_pointer_value behavior (it does not check for
`NOT_INIT` right now). Does this sound like a plan?

[...]
> Could we consolidate the logic above with the one below which deals with =
R =3D=3D 0 checks?
> There are some similarities, e.g. !is_jmp32, both test for jeq/jne and wh=
ile one is based
> on K, the other one on X, though we could also add check X =3D=3D 0 for b=
elow. Anyway, just
> a though that it may be nice to consolidate the handling.

Ok, I will try to consolidate those.

Thanks,
Eduard
