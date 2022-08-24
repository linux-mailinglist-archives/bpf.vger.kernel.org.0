Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED85A03B8
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiHXWFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiHXWFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:05:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4376965
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:05:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kk26so6407310ejc.11
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=30rjKiVeWVCu2mnV1/tF3SCou3m7ew3Kx6STFe224gQ=;
        b=fMituNd4Hawqhoyzj/f1QRwhRu6gNr4Egv2wpZoQ78f4kQHVdhbKPJz6qkO+SgPBmH
         E8OwA75SHIXWuLP2P1RWcq6bdfmE7vjTJ+LNZuEukwwdtpbbuvkV+VlV7HfgQBOH5xYG
         S6gsG+zPS3OBpxbxY51bSnC0l8mJe987IQSPBO+fJfEtocM1PU2Uu9FAtbDPJ3mRvb/s
         NrI3j57mpxIS5syggL+tiqLNNNcwSQuLnuRyyT7/L0I0fFMib2dsjECQh1EpMrHSzkyi
         g4Awk90UDQgG/sGzWaT2frcpi0ZHCT2C08eIj5tDq2ZYLsEYRzQtBzOaWidxkWiVSc6M
         4ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=30rjKiVeWVCu2mnV1/tF3SCou3m7ew3Kx6STFe224gQ=;
        b=V+WKefV0gEqbP3Pg6NPzWCIJ0H63M0bbWY6CVeOVPLpqlyNXtDt9j8EV7jSuqYX/6X
         6exfSyUmUdXweKzHT4gPf25azp1cQT6q+VvHQRw/WjHVri9mtdpXxtpSS4GPxsPff8sD
         RYmC79Ek1VJn2eGRXr4BSDKPHcxKOQwe0U/UNGQ5oavOikV3Ujkco0OKioZRNUa9Dqg8
         UsnD+qU6p/2fSSEKrtymbIN04QEas6mSxcEokYe3OiEe9Ryp0cD8e5gl3o8/MeCPbxWi
         /yf2y2JNDpPGmsOwZaQyO5xJJcHbvRyhm9781O4hIls8Y/MyvidlUxrXdyK6r7wUBn63
         X8kQ==
X-Gm-Message-State: ACgBeo3lwZKamkInskBicQIHM2hxn/26MfaY70p8vuX9dlPmZisHLkKW
        z3eCiW4rG7E/mCzR3+PYguU=
X-Google-Smtp-Source: AA6agR5v53CylgRlmKwFyaQfjvxRIfqFIlGrjHbPNryWpkRYoTuNl3eQCqvTLLloM7GLBmK197PGRA==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr585928ejc.243.1661378734649;
        Wed, 24 Aug 2022 15:05:34 -0700 (PDT)
Received: from [192.168.1.24] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id kg5-20020a17090776e500b00730bbd81646sm1005348ejc.87.2022.08.24.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:05:33 -0700 (PDT)
Message-ID: <f040525326088f63201d2ef76a7b759f44f38350.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information
 for reg to reg comparisons
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Date:   Thu, 25 Aug 2022 01:05:31 +0300
In-Reply-To: <63055fa5a080e_292a8208db@john.notmuch>
References: <20220822094312.175448-1-eddyz87@gmail.com>
         <20220822094312.175448-2-eddyz87@gmail.com>
         <63055fa5a080e_292a8208db@john.notmuch>
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

> On Tue, 2022-08-23 at 16:15 -0700, John Fastabend wrote:

Hi John,

Thank you for commenting!

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2c1f8069f7b7..c48d34625bfd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> >  	return type & PTR_MAYBE_NULL;
> >  }
> > =20
> > +static bool type_is_pointer(enum bpf_reg_type type)
> > +{
> > +	return type !=3D NOT_INIT && type !=3D SCALAR_VALUE;
> > +}
> > +
>=20
> Instead of having another helper is_pointer_value() could work here?
> Checking if we need NOT_INIT in that helper now.

Do you mean modifying the `__is_pointer_value` by adding a check
`reg->type !=3D NOT_INIT`?

I tried this out and tests are passing, but __is_pointer_value /
is_pointer_value are used in a lot of places, seem to be a scary
change, to be honest.

Thanks,
Eduard
