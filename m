Return-Path: <bpf+bounces-2956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8437376D6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 23:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF827281403
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70174182DB;
	Tue, 20 Jun 2023 21:53:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593C182B0
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 21:53:45 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BD1730
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 14:53:44 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a9db19d663so4800520fac.3
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687298023; x=1689890023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RwIKNQ/sDPYsUp9NuDpJUiZEp0xcKok6NHODtE8I9c=;
        b=WWw71WkF/DPp6D0SjQ27oPl+LRAmj1zPIne/kjytgtbV4rzR5V/z1w7m96lm7hQjCe
         zBK4mcTGTbF+sVmhCSUScdV6bQPu5UFcT/FBYOG3Q3bSvNv7si+KmdRCsGQjb813V0A4
         8Pi97NKnfvJ+YVCfBYX3AQCFwbGa5MkqnoLIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298023; x=1689890023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RwIKNQ/sDPYsUp9NuDpJUiZEp0xcKok6NHODtE8I9c=;
        b=CtCFlNcX6Y7vv78mCJRjp4q7lGNsgiuQD6yDw91PrJDBO9w1R/TiSgOT1YtAxnKbGr
         A8bTt3jIGI8SGdHJ9GJdDgqQsKkvdfR0nLaSZ5E/+KL5zhjqXKJVmZVHAxSLtdNh45GK
         BxdiPGDmO3yDw3/72YO5plTut2PfhpNg6JPudCINY4q2/EwmsT2B8PmvB7nJcHKqAmDB
         VVcS2SrTaV5hzfHZqABKL/CcPnhWQAusQ/jUH8p9LE0nYbrOXJZH/KPJnY/z40TZyXoK
         L+SOYHv+rk2X/eVD53xyyhkPA+YVah1BryWWZJewbF5I6IZ0HGsVZg9ppz48OUIbDXkb
         LdiQ==
X-Gm-Message-State: AC+VfDwKm0TINioCsWkVxej7WnUprlcNfdMX+ixBggzIJQO7rn8IPxtk
	fYNGjdr6JBiSsLTLgNLfXNnFPg==
X-Google-Smtp-Source: ACHHUZ4+K1t9bs+qIZsxYamDFjSpd6FoNM3t4NbbLejcLkWkDhPauqeB2BdJVQkRn97pIMlSeyDUNw==
X-Received: by 2002:a05:6870:5a8d:b0:1a0:bbee:c1d0 with SMTP id dt13-20020a0568705a8d00b001a0bbeec1d0mr10453257oab.42.1687298023735;
        Tue, 20 Jun 2023 14:53:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c49000000b0054fa8539681sm1822040pgm.34.2023.06.20.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:53:43 -0700 (PDT)
Date: Tue, 20 Jun 2023 14:53:42 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Subject: Re: [PATCH v2 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202306201452.95107E750@keescook>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616000441.3677441-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 02:04:39AM +0200, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:

Overall, I find this a much cleaner patch compared to the v1 -- thanks
for cleaning up how the loops are replaced. I'm looking forward to v3
(with the build fixes and other comments addressed), as I think the
performance benefit this series provides is significant.

Thanks!

-Kees

-- 
Kees Cook

