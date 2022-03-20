Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9704E1946
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiCTA6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbiCTA6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 20:58:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE039A
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 17:57:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so2745962plg.12
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lwFNdTXHynCnER6PUoXk9ifidM64ZZKwDiYQ2gcS96M=;
        b=Uc7nKIUl5sx4pWc8HSG+Ty/p3CAMkdNgVyPVbgYJHQOWU8wgV7wVxKeEmSlMQS0ufP
         zA4sLP+iqoyQQKy69U3YJpy1JYoACovPciWOLYmxaxvWihiHRQMFxxVBu5fHtflkv+Vf
         +cHXNr05f99b01+vl1QuW/Uunn1qfJCfcbGdzUC7hU8h3z2vpK/YXgrdCRmhZAW1q1RQ
         n4JAkJwXOy252b6u2SkRlNQPVKE1ZepnCPHeXfopbsB7Rp9Ciqj9KIHV8+CunDWA0iG5
         BPm0DGzUdaQjDwUsZxWpnZqhjD34iUPpghYRDhVAajp2euEYqLTSeC+BffR3PhRPnQMa
         SZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwFNdTXHynCnER6PUoXk9ifidM64ZZKwDiYQ2gcS96M=;
        b=ERvPqWXq0es3FdZ16HtPpppN6dsecx6awNkSUmFX0fddeEplezFtT9qGAfAFiudDgE
         ZmtISEwaFcrgxjaTfMink77x590B2vcV6kooARYEQp7UVTP0khv2PNzKOTEZALSyLJ1H
         wm1yz5CJfpkSgt4v5BHeZUFrBJHgvh/Bj61g8UYmYtZJvCU+5MJSWLteDoZDE3n9PgTq
         DhKC2orNaXS6lNCJ+hiXJ1H7MHuAYp3I2j0oB7FNMYuqq1eNCF0kx4HYf9x6SjhohZ7h
         7bsicWgO6ZSjYYnR5hGl8AdT0lT5CZmJ+gRoHolEjul1lqDVtjIAo5thSdDPdTc4cgJZ
         cF1w==
X-Gm-Message-State: AOAM531UaaRQkjOa20p4VZA4spO0W4FxURqaiayyVl47iBmQX0haoGtb
        r+PVxr6uvLRrcs06nGlRO+M=
X-Google-Smtp-Source: ABdhPJyURcITzIYKkAtiAQlyacuRk3yeUrhOpTH/JKmhDH78pgaoOZVmTXNhMrH6CspYbq2UM4p4Ag==
X-Received: by 2002:a17:902:8ec7:b0:14a:c442:8ca2 with SMTP id x7-20020a1709028ec700b0014ac4428ca2mr6321031plo.12.1647737850157;
        Sat, 19 Mar 2022 17:57:30 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b004f79bb37b54sm15115980pfu.195.2022.03.19.17.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 17:57:29 -0700 (PDT)
Date:   Sun, 20 Mar 2022 06:27:27 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220320005727.w7n4rgd4u5ctkai5@apollo>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-5-memxor@gmail.com>
 <20220319182407.amdeiliph36zdwlg@ast-mbp.dhcp.thefacebook.com>
 <20220319185904.dq5h6tnspwx77dze@apollo>
 <20220319212320.oos7tao6mybsjt6i@ast-mbp.dhcp.thefacebook.com>
 <20220319214303.n3aogzbz3fjaohcy@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319214303.n3aogzbz3fjaohcy@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 03:13:03AM IST, Kumar Kartikeya Dwivedi wrote:
> On Sun, Mar 20, 2022 at 02:53:20AM IST, Alexei Starovoitov wrote:
> > On Sun, Mar 20, 2022 at 12:29:04AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > >
> > > > >  	if (is_release_function(func_id)) {
> > > > > -		err = release_reference(env, meta.ref_obj_id);
> > > > > +		err = -EINVAL;
> > > > > +		if (meta.ref_obj_id)
> > > > > +			err = release_reference(env, meta.ref_obj_id);
> > > > > +		/* Only bpf_kptr_xchg is a release function that accepts a
> > > > > +		 * possibly NULL reg, hence meta.ref_obj_id can only be unset
> > > > > +		 * for it.
> > > >
> > > > Could you rephrase the comment? I'm not following what it's trying to convey.
> > > >
> > >
> > > All existing release helpers never take a NULL register, so their
> > > meta.ref_obj_id will never be unset, but bpf_kptr_xchg can, so it needs some
> > > special handling. In check_func_arg, when it jumps to skip_type_check label,
> > > reg->ref_obj_id won't be set for NULL value.
> >
> > I still don't follow.
> > What do you mean 'unset meta.ref_obj_id' ?
> > It's either set or not.
>
> By unset I meant it is the default (0).
>
> > meta->ref_obj_id will stay zero when arg == NULL.
> > Above 'if (meta.ref_obj_id)' makes sense.
> > But the code below with extra func_id check looks like defensive programming again.
> >
>
> Ok, so I'll just write it like:
>
> if (is_release_function(...) && meta.ref_obj_id) {
> 	err = release_reference(...);
> 	if (err)
> 		...
> }
>

Ah, after reworking, bpf_sk_release(listen_sk) in verifier/ref_tracking.c is
failing, now I remember why I did it this way.

So meta.ref_obj_id may be 0 in many other cases, where reg->ref_obj_id is 0, not
just for the NULL register, so we need to special case the bpf_kptr_xchg. User
cannot pass any other reg with ref_obj_id == 0 to it because verifier will check
type to be PTR_TO_BTF_ID_OR_NULL, if register is not NULL.


> > > > > +		 */
> > > > > +		else if (func_id == BPF_FUNC_kptr_xchg)
> > > > > +			err = 0;
>
> --
> Kartikeya

--
Kartikeya
