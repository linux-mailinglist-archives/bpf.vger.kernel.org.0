Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C84DEAF1
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiCSVYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiCSVYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 17:24:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DC167FE
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:23:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q11so9685865pln.11
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAeHV1hbq4iswalZs+s7qGQiKOff/xhjucoCTowRSsY=;
        b=S6cRmdM4tvszJTWIPV7NyTwWs64XJXBJi8oySeMudjgV64GudCfwpJZRzf0sI8geAb
         tQnKdd5SBkaT1fSSFbVTj6+t4xKKk3ytL7JX2FLc5aC1WTaVS2CQGqGmLdt5oDenVHry
         HtMzRPPPQRejFFUUdZZAIhfNa+MmrXNJ5yoola9q/OJqTINxPu8QskCTpAXShiR2/aFQ
         sR7MohbLlsPp9K/KLjtHaqxPT1kazRbds/I/nMMaLbYOVTtEL4FUkGEv8dk8ZbuMXrVl
         l+bLTg7V5L+rZNSI2RocD2ISkBuGjKQPWo0Hlu0qxSDJgw52XqDfcg18ET6YLe1hdDGd
         L4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAeHV1hbq4iswalZs+s7qGQiKOff/xhjucoCTowRSsY=;
        b=TtQs05NoGcH/Hr+L+1MV2HE8boAygUqyBSZGCI7KyRsJH8FAruaOHHrjO9WYZKfIXm
         RZLs3/G/AmBE7ol32z6Xn4/cJoAI0/wXWWomktydpV0OAzs9MSsBUfqvxJ+QN4ExBit5
         Xto3/nWypxqM7CtUoZxEAQMoIzuJOvsEg7/Xv61WE8A7x9WTnjw0keB7GgL5iSqFyM8p
         zief75MsFoZ6hgL3eJioNBEIddOm5RMCqO7eOv9S2/QaWDeJNJB7mH7GuYr7EBn1X18q
         VaJDhB83xykUiq14jlQzmxWZB63ku2fsHlKlbV0KThu89K66wTZNuEl7jIKd7MCV3/u2
         p1iQ==
X-Gm-Message-State: AOAM532tLBWcOcBZdtY5bMSlD/7DV8aJdvrerCZ0yHNzkbduyIywzj/2
        6qPDN/cZNKkq758peB3ZFkA=
X-Google-Smtp-Source: ABdhPJzznvV8ujzmnooM9jGBPWQSB+vsYSvBNSWwRrrsJDvKzww1EqowjKov9F4aJurFP0LtpEQaMg==
X-Received: by 2002:a17:90a:8a05:b0:1c6:e527:c613 with SMTP id w5-20020a17090a8a0500b001c6e527c613mr3360425pjn.143.1647725003539;
        Sat, 19 Mar 2022 14:23:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm14239849pfh.177.2022.03.19.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:23:23 -0700 (PDT)
Date:   Sat, 19 Mar 2022 14:23:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220319212320.oos7tao6mybsjt6i@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-5-memxor@gmail.com>
 <20220319182407.amdeiliph36zdwlg@ast-mbp.dhcp.thefacebook.com>
 <20220319185904.dq5h6tnspwx77dze@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319185904.dq5h6tnspwx77dze@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 12:29:04AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >
> > >  	if (is_release_function(func_id)) {
> > > -		err = release_reference(env, meta.ref_obj_id);
> > > +		err = -EINVAL;
> > > +		if (meta.ref_obj_id)
> > > +			err = release_reference(env, meta.ref_obj_id);
> > > +		/* Only bpf_kptr_xchg is a release function that accepts a
> > > +		 * possibly NULL reg, hence meta.ref_obj_id can only be unset
> > > +		 * for it.
> >
> > Could you rephrase the comment? I'm not following what it's trying to convey.
> >
> 
> All existing release helpers never take a NULL register, so their
> meta.ref_obj_id will never be unset, but bpf_kptr_xchg can, so it needs some
> special handling. In check_func_arg, when it jumps to skip_type_check label,
> reg->ref_obj_id won't be set for NULL value.

I still don't follow.
What do you mean 'unset meta.ref_obj_id' ?
It's either set or not.
meta->ref_obj_id will stay zero when arg == NULL.
Above 'if (meta.ref_obj_id)' makes sense.
But the code below with extra func_id check looks like defensive programming again.

> > > +		 */
> > > +		else if (func_id == BPF_FUNC_kptr_xchg)
> > > +			err = 0;
