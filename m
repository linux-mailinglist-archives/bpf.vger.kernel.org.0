Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A14DEAF5
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiCSV1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSV1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 17:27:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66B17E18
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:26:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q5so484152plg.3
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkYm4YDdjEbLbIxThqiMLT122eer1K9c5CvWzAoVsRA=;
        b=jYgQGPv8yPjive8lMohp0stOiwkNpg9IVzRCJGOfnHsqZpn+V8OKiJK5tHuBgo/VgX
         hmDBL4VWNoY04NfoTm5+zOf6LKI2ZfnziN22XK3xcub1qFJ5rdfhP0KYb3M7TS/noClX
         EdmkL69Ni4Hehc/0iE+t/wVDA2PafujUSGNtEUfOsQIfxEMWvTs8HGzT31PcYHxKgiWM
         qPQEufFYpySr7/MPPJv3F23XhRnFb2g2KuV0r01aA1t0+ufvopkJz8nMWTnFjHvET+Hj
         inwp9qYPCI3G718xHSTAvae5c8TQrrjr8NXZZPG68TsHDCZEvXixjfc/ZkZWFcmWZccL
         aUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkYm4YDdjEbLbIxThqiMLT122eer1K9c5CvWzAoVsRA=;
        b=GaIBHL0HN2Tu47b7U7LNTkdluNRq4MQKlyhdMOgSF0bRTfyDXGDY/atRVxEF6/fmws
         XsdYtKRc9EyGFfMkz/KD1xsJ4f4N4F+2KjSLIx48mQHHQpgZ+Q+n80blsn7xDUK8aLlb
         Lf8cLZKwi2xKq82vUi8QfSuM6IosetU/SGYk83Mu8ZDNG97clWPy0alCqp0rx9PN+38O
         ehH+/7KRwpkVZRERCbEp1albPbSIX0cV6HN/qbEKHEN9hcDWMYQPd4wQQu6YneVtE6BV
         5cL/SuS7l3jcmxLA4HIt56/Kl5BnDPH4RRfnDm9zjKHSyOXMVawTuyIdYsAu+iUiFKpE
         gNgA==
X-Gm-Message-State: AOAM530X3qLPLBo0Myu7gQH0Ioj2bS6TuzDazsMPdBpL94MwuFIG9eBz
        bjQggOs/CSlC9Tr50AgNO60=
X-Google-Smtp-Source: ABdhPJzWtfGZ4QsjXMQjJpwQW0J+cfupoKtUdStuSDB1xYTA75xn8L5q9vIeMJvg24GMzHjGROaHMQ==
X-Received: by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP id a8-20020a170902900800b0014fb1f95271mr5640730plp.86.1647725183500;
        Sat, 19 Mar 2022 14:26:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004f6ff260c9dsm14611791pfk.154.2022.03.19.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:26:23 -0700 (PDT)
Date:   Sat, 19 Mar 2022 14:26:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Message-ID: <20220319212620.vbzfxsn2xitkzv5t@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-6-memxor@gmail.com>
 <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
 <20220319190409.7n3bkjdp67finojx@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319190409.7n3bkjdp67finojx@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 12:34:09AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sun, Mar 20, 2022 at 12:00:28AM IST, Alexei Starovoitov wrote:
> > On Thu, Mar 17, 2022 at 05:29:47PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
> > > map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
> > > of pointers accepting stores of such register types. On load, verifier
> > > marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
> > > PTR_MAYBE_NULL.
> > >
> > > Cc: Hao Luo <haoluo@google.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h   |  3 ++-
> > >  kernel/bpf/btf.c      | 13 ++++++++++---
> > >  kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
> > >  3 files changed, 33 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 702aa882e4a3..433f5cb161cf 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -161,7 +161,8 @@ enum {
> > >  };
> > >
> > >  enum {
> > > -	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> > > +	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> > > +	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
> >
> > What is the use case for storing __percpu pointer into a map?
> 
> No specific use case for me, just thought it would be useful, especially now
> that __percpu tag is understood by verifier for kernel BTF, so it may also refer
> to dynamically allocated per-CPU memory, not just global percpu variables. But
> fine with dropping both this and user kptr if you don't feel like keeping them.

I prefer to drop it for now.
The patch is trivial but kptr_percpu tag would stay forever.
Maybe we can allow storing percpu pointers in a map with just kptr tag.
The verifier should be able to understand from btf whether that pointer
is percpu or not.
