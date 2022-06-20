Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38429552871
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiFTX7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFTX7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:59:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5813D4A
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:59:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so3116341pju.1
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SR0fqIyYmzJ+huUGBTgMx94uNr6XK0/CduKasmw9trs=;
        b=Ev66yZctftXev+DMvVCVZ5peNuxm0LnZmxC5gPtWBu2uQtxlOj2zvz7SIycsJ4kWJs
         Saz8ySYIDZEnfiPQPu78cfpuv8X/U+11C8x5PFEMHZ2oJWCit3kL3WRxwo9vcy8BZsen
         dN0iU2ApiCv5jvzzLbCI3TXx0f44AWXxE7gOgG6Vj61wLUd/ddnuXb5eSic4cwlPT2Im
         tNyRbQj7g3cfMffWERzNFs+MBJD9+c4e2nHw8GA0WmKP8g59OaMG9NTVznW98fFzZMCe
         6Ayf2q/I0WG0atY4i4lxseii+lSKayc52yLhSeB0wehO4D+GFO/xg2MZVChGnta24Yx4
         xedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SR0fqIyYmzJ+huUGBTgMx94uNr6XK0/CduKasmw9trs=;
        b=dEctjcjwd0PnecB5jW5HrRkCd4DiQ6gzYC9PRT6Qe7k4Sm2EuAn+6prBLcdXDOjHly
         lsZX3dx+lOwYWxZhLuuUD+dd572D3FbFv6Bm+R0EGu+b7psZYWnNtQDwMnpBWtKQ6qJK
         Ko+DoedSBktX0swMMZaTMLYSXRdizGalpg6ZHOKmDkYsjeVVHWJb1oIXkLGv078P4gvw
         M6HfhQG+MlkLBu+gu2Gv4M+XJmR9tgP6fKiv/+7HVZAPrUASg/K3VtmV3AUM0aqxVrSt
         OsSrGsTuhyNGgZhjgXbn0XPGH/ynmvD+svFvaO8C35jqQ7dVOwwNinVkrR981v+EsJ0P
         ehOw==
X-Gm-Message-State: AJIora89BpQSjmLOzM9oL/GJT/0GnoHt9pdupr4np88sjKE3tp8j0Xdr
        PfnJnWqxHFqaTkZHHSPUajw=
X-Google-Smtp-Source: AGRyM1u5rJC0Hq4tyja2yMIT4Th4q66Tlt1KbsbUBvi0usL+q6u+Wz8i7s7PjvXkEn+IBLTQztaBog==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr26174090plh.92.1655769562443;
        Mon, 20 Jun 2022 16:59:22 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903120200b00168c523032fsm9258687plh.269.2022.06.20.16.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 16:59:21 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:59:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add type match support
Message-ID: <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-5-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620231713.2143355-5-deso@posteo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 11:17:10PM +0000, Daniel Müller wrote:
> +int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
> +			 const struct btf *targ_btf, __u32 targ_id)
> +{

The libbpf and kernel support for types_match looks nearly identical.
Maybe put in tools/lib/bpf/relo_core.c so it's one copy for both?
