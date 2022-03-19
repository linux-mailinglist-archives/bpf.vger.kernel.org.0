Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200A4DEAF8
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 22:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiCSVcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVcU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 17:32:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE9393F5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:30:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so1014668pjb.1
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mzRt0Ecq5vUTgcXL2AlagUAbHVXIWDs3e7A3NyT6Zow=;
        b=cXr5iGq50tVD4bsDKi6G9qtd5GUVExVhVl3z8o9On0axtDdJdY+xL0AQaMISwXBE0J
         ev7V2AQegJNpaycTSL6d16R1DoA42j6rEJh+llJCMq8xxB1MTEw6xe6AX3J9LPFpzJxb
         8NzicOxcM2EMpmfvQ/8MQ8lLA4VMA4pP0TP1anzragDqdEwXpgG0dte8XwpMYL6XYP6Q
         H0ZmnHJeG0T61d6iEe1EP+sTVWJdhOlOS2MnnfMI4F17IKtEXY29XzU5A+c9UaXkVBPe
         9ay9Mvg6sv3thlYmX/smMqu0vWNQsUP0CylCLuxq3NBMEo5uIs0Np5IOGO619DnVP2be
         7oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzRt0Ecq5vUTgcXL2AlagUAbHVXIWDs3e7A3NyT6Zow=;
        b=TV5tWuTKCVtuhVgeqVD0Q/huYQPuaxC/6sthJZ6g99ycfMaG8tPwm9NWjR3IqnPfQf
         I+kQyWRnq7ZnZOhSnfVobAQL7rxB1Yayi837iFAqQKb5C7s9AJZN0UnNxVb8mHBm/S2c
         o21X/B5T2pUU3cpL2ZdjAdhf+qXj3UWyyk1T8IvZx6O9CmArEdSjQ635BP5CSC7kUzmT
         b19WbnNmG3NWeafeU2zg5lNxKCCPxts7BOqU+cxB/ksK/vE4SgWCWFKGH/n4nX012+Wg
         hOmCsXFxY/MuSOAej+uHS0rdcpnOD/Wdd1UmwH2hXE47tzFYXsCFhXBnG4wTrBexpCIE
         tjYQ==
X-Gm-Message-State: AOAM530AyebMcArF0GY4I5khvimvQtxRqXCfCu2vMGqNtNwOzn1S2QSM
        dEe55ryPTyT8otNQiXd/nuUaTW1lkqY=
X-Google-Smtp-Source: ABdhPJxqSzaQ7XT22FTl3ZwMOz+v6IxYonpNFOWH5uHPkNk9w6Oelb/HXMSWQkKlAVHG4AAigTl4Zw==
X-Received: by 2002:a17:90b:4f8d:b0:1c6:408b:6b0d with SMTP id qe13-20020a17090b4f8d00b001c6408b6b0dmr26487444pjb.90.1647725457833;
        Sat, 19 Mar 2022 14:30:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id kb10-20020a17090ae7ca00b001bfad03c750sm16791792pjb.26.2022.03.19.14.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:30:57 -0700 (PDT)
Date:   Sat, 19 Mar 2022 14:30:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Make btf_find_field more generic
Message-ID: <20220319213054.e27i6saz73s7snsi@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-3-memxor@gmail.com>
 <20220319175534.blttnx6vexrctych@ast-mbp.dhcp.thefacebook.com>
 <20220319193116.dwvhgxls4p6lapov@apollo>
 <20220319200641.om64ihmaaqkq2nof@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319200641.om64ihmaaqkq2nof@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 01:36:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >  			return -EINVAL;
> > > > +
> > > > +		switch (field_type) {
> > > > +		case BTF_FIELD_SPIN_LOCK:
> > > > +		case BTF_FIELD_TIMER:
> > >
> > > Since spin_lock vs timer is passed into btf_find_struct_field() as field_type
> > > argument there is no need to pass name, sz, align from the caller.
> > > Pls make btf_find_spin_lock() to pass BTF_FIELD_SPIN_LOCK only
> > > and in the above code do something like:
> > >  switch (field_type) {
> > >  case BTF_FIELD_SPIN_LOCK:
> > >      name = "bpf_spin_lock";
> > >      sz = ...
> > >      break;
> > >  case BTF_FIELD_TIMER:
> > >      name = "bpf_timer";
> > >      sz = ...
> > >      break;
> > >  }
> >
> > Would doing this in btf_find_field be better? Then we set these once instead of
> > doing it twice in btf_find_struct_field, and btf_find_datasec_var.

yeah. probably.

> >
> > >  switch (field_type) {
> > >  case BTF_FIELD_SPIN_LOCK:
> > >  case BTF_FIELD_TIMER:
> > > 	if (!__btf_type_is_struct(member_type))
> > > 		continue;
> > > 	if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> > >         ...
> > >         btf_find_field_struct(btf, member_type, off, sz, info);
> > >  }
> > >
> > > It will cleanup the later patch which passes NULL, sizeof(u64), alignof(u64)
> > > only to pass something into the function.
> > > With above suggestion it wouldn't need to pass dummy args. BTF_FIELD_KPTR will be enough.
> > >
> 
> Just to be clear, for the kptr case we still use size and align, only name is
> optional. size is used for datasec_var call, align is used in both struct_field
> and datasec_var. So I'm not sure whether moving it around has much effect,
> instead of the caller it will now be set based on field_type inside
> btf_find_field.

There is no use case to do BTF_FIELD_KPTR, sizeof(u64) and BTF_FIELD_KPTR, sizeof(u32), right?
So best to avoid such mistakes.
In other words consider every function to be a uapi.
Not in a way that it can never change, but from pov that you wouldn't want the user space
to specify all details for the kernel when BTF_FIELD_KPTR is enough to figure out the rest.
