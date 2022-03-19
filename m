Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6F4DEAFB
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 22:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiCSVo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 17:44:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A286184ECA
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:43:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v4so10153278pjh.2
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UqtV0sA6am1PG8OrsaZwoVNFPOXqg06kiugHXJNvLeQ=;
        b=WU18js+rK16bib1QhvI03yI7kYULUGMKW9nv1dI9eXfe2mluLPgIirzeDjUJ4XlT2y
         yNr67a+T3sd/sXFTOfEpg7+OVQxSEeX6fh6FU97KR7IOleY2ejNVIjf3LmgifB0RyVSJ
         RLzN05a1+wgbQNtUq6AAvuDR8CZ6K4xCVaLaLrnjd96XdW95M6SOQOslFv1XN2tvPHMR
         ZfC6/tc7k5pbi54zaceULNs6c0g0s4jw10QaWu0H1tXjJrBfS5twU/wkXsz5I3YeCMSZ
         /0ZR1LvM5Il+y1dikf+6nODUNqfK/zN7J0Q8SoDlu6Vrn5b9+/iRRxdEh72jp+Y/gWCA
         9Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqtV0sA6am1PG8OrsaZwoVNFPOXqg06kiugHXJNvLeQ=;
        b=SePbR9REZCCN+PNjwOproZy1OcQ2GHviR1v7xG6EmfQGoy++uzTbvXNeMhKo8g1iWa
         aJ/JpbyLPBD0HSFIJ2mTGQ9po1P4s7OlCDU9yYH4pv2hOOYVnV92bOOSWruicrRc6oAS
         JUIYia2k1zxEwse5WLVpQI4L2NmGFlOs4e6LWjvhNseBFFkDWvy/DPbDyz3ye7a9Wf1X
         FCbRO4BCqVazIHdCzwbVAh+Bi75b/P+fW9/UoV0nln+e10YgGB8sKUcp2CoBXQhRSK3m
         r22FrvdEdyhL3uiHosSU8/fW66ZNG6YJeicsUu5ZQSskOAjveNlIMkmGyOCnvTwWhXHM
         EbdA==
X-Gm-Message-State: AOAM530J9W04U9F4HQA+FYndv+3BOl6uQ8Lw0tvpgVWTxBq1r90sbsGZ
        pFuzzhRDRobCTUJGPhCdEfc=
X-Google-Smtp-Source: ABdhPJy+QsHGjhQJmyVYaQGH6fnXI2vB/fqpMUaEdJ70K9M1mxqOrV9EVS8I4pWL8590mgRNiILz+w==
X-Received: by 2002:a17:902:a40d:b0:153:7213:1584 with SMTP id p13-20020a170902a40d00b0015372131584mr5818730plq.56.1647726185188;
        Sat, 19 Mar 2022 14:43:05 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00194c00b004f7c1da7dd5sm14236222pfk.1.2022.03.19.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:43:04 -0700 (PDT)
Date:   Sun, 20 Mar 2022 03:13:03 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220319214303.n3aogzbz3fjaohcy@apollo>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-5-memxor@gmail.com>
 <20220319182407.amdeiliph36zdwlg@ast-mbp.dhcp.thefacebook.com>
 <20220319185904.dq5h6tnspwx77dze@apollo>
 <20220319212320.oos7tao6mybsjt6i@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319212320.oos7tao6mybsjt6i@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 02:53:20AM IST, Alexei Starovoitov wrote:
> On Sun, Mar 20, 2022 at 12:29:04AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > >  	if (is_release_function(func_id)) {
> > > > -		err = release_reference(env, meta.ref_obj_id);
> > > > +		err = -EINVAL;
> > > > +		if (meta.ref_obj_id)
> > > > +			err = release_reference(env, meta.ref_obj_id);
> > > > +		/* Only bpf_kptr_xchg is a release function that accepts a
> > > > +		 * possibly NULL reg, hence meta.ref_obj_id can only be unset
> > > > +		 * for it.
> > >
> > > Could you rephrase the comment? I'm not following what it's trying to convey.
> > >
> >
> > All existing release helpers never take a NULL register, so their
> > meta.ref_obj_id will never be unset, but bpf_kptr_xchg can, so it needs some
> > special handling. In check_func_arg, when it jumps to skip_type_check label,
> > reg->ref_obj_id won't be set for NULL value.
>
> I still don't follow.
> What do you mean 'unset meta.ref_obj_id' ?
> It's either set or not.

By unset I meant it is the default (0).

> meta->ref_obj_id will stay zero when arg == NULL.
> Above 'if (meta.ref_obj_id)' makes sense.
> But the code below with extra func_id check looks like defensive programming again.
>

Ok, so I'll just write it like:

if (is_release_function(...) && meta.ref_obj_id) {
	err = release_reference(...);
	if (err)
		...
}

> > > > +		 */
> > > > +		else if (func_id == BPF_FUNC_kptr_xchg)
> > > > +			err = 0;

--
Kartikeya
