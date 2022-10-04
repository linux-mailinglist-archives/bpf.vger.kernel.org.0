Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1591A5F4762
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJDQUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJDQUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183F33355
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 09:20:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so29976064ejc.5
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NueB4cWZGRPqKYAhnuxP451qfhK1PmfDbxC3+7wcGEQ=;
        b=XvKKdpld1QNSNaoV0y5Rwjfek8hwvcTx8tP7ipbOoJ/WGTABydwkI/3pTzLSVL3NoS
         nETGj/IeYAaBG3iKhKJ4uGwULuS05mGUHb/VG2OYjEx2RecLYHoqWknOwN/CCP1nxV3z
         7j0hvgzQaQn1CAqXHEtUA7psqEppWuPEckB/Q6Q5UKhuTrDPf8Zzzfg7lKUVY+Ts8/Qf
         WZZiijcIB9rw1Au3xBfEVPp7e+T2ZAo6VNJTZljrRJaL9c+UPnLnCNZCHS8OsbgU05lK
         Ps+ciaNa7I+IP7D6nRw+SdpSXYaI6MMMldfz3oUnY8/c+WBge6fA+8eNqK+an5q3W5f2
         NYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NueB4cWZGRPqKYAhnuxP451qfhK1PmfDbxC3+7wcGEQ=;
        b=tul6oE1UPpphgmikz0BOj8Xr1MFOyTx5pCUUoRKm4p9L0ULLUbFfCdRhYpseiqNaLl
         RDIjTs+B1zHzLb8L5wUFl3iwkXft6fnSAo6LaIfS+q2hFBAVPBMCGd5toVW+zQgRFtyy
         zMSqsiSo+eOpz0NHx6W7ozwlWtyNkGkx3dr7gkiASQVmHBUn5RJMdCsc9+c7JO9cIIcq
         xLB8e0moTGSEMDA+AjwMwyoG7fEZ/gMKM5yYQWQ9/KedIxJAZunEWHNr/1Nzm86ParjL
         LrRtW3z0IW6s/ZTspRd/bl1z5d8BT6uQasIVQrvswcMRDMUz5DeN2c/Ip2h+MsxkHuac
         4ijw==
X-Gm-Message-State: ACrzQf2CjvOfrbYjRmoeN9x/1QLzcbacbNrVVXwhu/b0VXXCGvRGceCq
        7qwyol6aYFZlgoxjlggFGuEu5kpUIZelBnvKjZj0IKRuusM=
X-Google-Smtp-Source: AMsMyM7TQn5JiS8CUHnM0NnAW8HQ/iPzTVsgQSLTPiS1eGvmJuLWtSSJPBLSORyjsQ27Mpu7XxxR7xxeBN1dSLpzVbA=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr20606767ejc.676.1664900409858; Tue, 04
 Oct 2022 09:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com> <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
 <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Oct 2022 09:19:58 -0700
Message-ID: <CAADnVQ+Vrm6g7FZ-PaqLkGfVzN+z8HBTq6Q3MmvR88J6H8cHPw@mail.gmail.com>
Subject: Re: [PATCH 11/15] ebpf-docs: Improve English readability
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 8:56 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> Also worth noting that Quentin has a script that I believe parses the appendix
> and uses it to generate a validator for ebpf programs.  (Which also
> helps validate the appendix).

The last thing I want to see is a document becoming a description
of the code.
We've always been doing it the other way around.
The documentation can live next to the code and docs automatically
generated from .h or .c files.
Doing the other way around sooner or later will be a disaster.
Imagine a typo in instruction-set.rst.
What should we do next? Fix a typo and say, look, the code
behaves differently, so we're fixing the doc.
If so, there is close to zero reason to add hex to the doc,
since it's not an authoritative answer.
On the other hand if instruction-set.rst is the source of
the truth then the code would have to change, which we obviously
cannot do. So let's not get us into the corner with
such tables.

> Dave
>
> > -----Original Message-----
> > From: Dave Thaler
> > Sent: Tuesday, October 4, 2022 8:55 AM
> > To: 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
> > Cc: bpf@vger.kernel.org
> > Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
> >
> > > > I found it very helpful in verifying that the Appendix table was
> > > > correct, and providing a correlation to the text here that shows the
> > > > construction of the value.  So I'd like to keep them.
> > >
> > > I think that means that the appendix table shouldn't be there either.
> > > I'd like to avoid both.
> >
> > I've heard from multiple people with different affiliations that the appendix
> > is the most useful part of the document, and what they wanted to see
> > added.  So I added by popular request.

These people should speak up then.
