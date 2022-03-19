Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1154DEA2E
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiCSSoq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiCSSoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:44:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0F6B0B1
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:43:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so9546125plg.5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KdF9mM1JSziY5I8oPWR1AvEeCHnEYY/In5DmAOQU7wE=;
        b=jXtMIWk7ozcYZJP74l5ivKM0HpIsm0o0UcBuNB7j0jAa+TI/BOoyoX3iNItqVDp9ah
         gWJuEQ2ZymGOWva7MbqjQ7w84ZxdbFHInHThor+f7AEzHsSM28q+iIbQCDG1YRk+95cc
         ve2N5H+BD8fH6YoQWgp/yz3bPUDeKK3xaetb+wRBuVW+vXAVnFKaoWv4iMvosmHITXVq
         JYZxZLDPlnVqeQgheWKSp+rOWsyGzHtpCwl1mztGru5ur4LAwErGVigZFrXeD/sEBgOJ
         bkwXWecSQFWOtpLp45Z1tn10Aabvz7D5hwtfjk7ER/mYL9wVgmY4AQZ1pMMTcFnZYOsq
         poZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdF9mM1JSziY5I8oPWR1AvEeCHnEYY/In5DmAOQU7wE=;
        b=v485ee1GP1C2m4y3aED9OWpyhl29X2Z8XFjgNlDGNzh/va2BJkWGygKRGfto0a9lEJ
         kS9bAMt1YdGOjS1elO4X/njLXpVCNN7+dyGPuHTyk6V3b1GGONnW6SXB44NGKRM14xJc
         tDMaZOEkfr4FptX8VrfUzV1j8CsNlSBRWfWMlxnBn0oJpJ44+RPdQXlhKvP7CzmWp2mQ
         it6SuGeGNKMbjX8gN490RSfTXHOzFu9gt+AouRYVkKBo4Q58LD4RvXK/d5+dFSlLGGjK
         KZ6ssEXz2OE3JGOqsTRwv+ax+m2VBoLivZqftGWpQySxjKUdMATnyiw6AUiTA8UEQORm
         CoLw==
X-Gm-Message-State: AOAM533X8a8wtUU1cpHro8i+pqckF08fiuq39graM9gYVhZB7hWsM38R
        Dm/ND4VMRyWE8/6cqZQtE9Q=
X-Google-Smtp-Source: ABdhPJxzDEsaSEH/NKAUPHVnsLu6weAWZKvbDxZBKo0mLlQZg1x8FCTpE7v6ZcKVXjKyDP2R2xP+iA==
X-Received: by 2002:a17:90a:1596:b0:1bd:4af:6055 with SMTP id m22-20020a17090a159600b001bd04af6055mr28659373pja.139.1647715401702;
        Sat, 19 Mar 2022 11:43:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id s30-20020a056a001c5e00b004f75773f3fcsm13105848pfw.119.2022.03.19.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:43:21 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:43:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 09/15] bpf: Always raise reference in
 btf_get_module_btf
Message-ID: <20220319184319.ujder6cdtu4vtnpw@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-10-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:51PM +0530, Kumar Kartikeya Dwivedi wrote:
> Align it with helpers like bpf_find_btf_id, so all functions returning
> BTF in out parameter follow the same rule of raising reference
> consistently, regardless of module or vmlinux BTF.
> 
> Adjust existing callers to handle the change accordinly.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Applied this and 1st patches.
