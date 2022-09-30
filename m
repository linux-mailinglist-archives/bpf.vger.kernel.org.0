Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A065F154D
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiI3V73 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3V71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:59:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA211F8992
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:59:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w20so5028342ply.12
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S5d/MCHAwW9ZmfiWEaoAdauA9vyG11bX6WAuqqXixPE=;
        b=iqhztrdN045+fePFJndNFN9RXP9+D493G1nFC0cnrvoFTDEZFzjvybfA0SK7cGehxo
         JZxrRfGnsvMc/BHANQxR8BX2GEKD1pzcEUhyvut2AMDOr+Hl65IdBAFf8DnBxiZ0mGws
         afnKqugGqpcc+mZ/ds5E5TdpzlbMyPZkKvDJSx1asdlmXkRbPElJgu+rJ7oe0987VK1V
         VAIH46BzSJBDuWE2cbDg5oOVl7hemeqnNYIfsb8p3p3FkQZmPbfQUYHm53X2QdI6pF/v
         ETPc9dF11wcxq3ttQ/9G7M7pJNwgOXNtBUwD1cbutRbJmfofdDfkS4i7KOKgwMYxWywz
         Tphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S5d/MCHAwW9ZmfiWEaoAdauA9vyG11bX6WAuqqXixPE=;
        b=zq36FL1JDJ8lMNshsXqhgLR/7k+uAvP7g7dn5J87hEv4st7o2sQEALafCOT6DJG6Pf
         BlJWDszYhQKM4W7p88+uAsxfIfG0z+iSo3hM1OtgPV6wSjoQyltBn4pQfA0LUCRjesFi
         09nJt/s2uJCZd/RxBEdxFRp3Flr6Dk/BQIPouYOTNeGF99d8B9FtO9wudE2LB9rsps7t
         z9dGKIdy0NcteZNoYCLGsLUguafNIYEbNgpTyFeuGhTj3G4tFJ+a53usvy4Vq/2BzFpJ
         DieA4B1EdH5ek1fYe7R2kviLZjQVGJOmfmPPiwiXiOcjp4pzJTTWBLJgQSFMnfdrrS1A
         opbA==
X-Gm-Message-State: ACrzQf31u0ReD3mxRX5e8eGvs/J8R6zByI4jtukpq5F2mM4RuEXRgLUV
        gBD6QWAXzzwH9iS0Kg3Klfk=
X-Google-Smtp-Source: AMsMyM4+VxwbNdyiLTQzpLcp7v7+MWkER0PNPSl3BCDr7WvdhEyv6O8LFlnhEpgg2SaE9MS0LmpjBw==
X-Received: by 2002:a17:902:dad2:b0:178:401c:f672 with SMTP id q18-20020a170902dad200b00178401cf672mr10440690plx.168.1664575157289;
        Fri, 30 Sep 2022 14:59:17 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709027c8300b001754e086eb3sm2336660pll.302.2022.09.30.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:59:16 -0700 (PDT)
Date:   Fri, 30 Sep 2022 14:59:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Message-ID: <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 09:54:17PM +0000, Dave Thaler wrote:
> [...]
> > > +Also note that the modulo operation often varies by language when the
> > > +dividend or divisor are negative, where Python, Ruby, etc.
> > > +differ from C, Go, Java, etc. This specification requires that modulo
> > > +use truncated division (where -13 % 3 == -1) as implemented in C, Go,
> > > +etc.:
> > > +
> > > +   a % n = a - n * trunc(a / n)
> > > +
> > 
> > Interesting bit of info, but I'm not sure how it relates to the ISA doc.
> 
> It's because there's multiple definitions of modulo out there as the paragraph notes,
> which differ in what they do with negative numbers.
> The ISA defines the modulo operation as being the specific version above.
> If you tried to implement the ISA in say Python and didn't know that,
> you'd have a non-compliant implementation.

Is it because the languages have weird rules to pick between signed vs unsigned mod?
At least from llvm pov the smod and umod have fixed behavior.
