Return-Path: <bpf+bounces-2602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3171730657
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 19:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEEA1C20D5D
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F73D308;
	Wed, 14 Jun 2023 17:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE917F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 17:53:25 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502431FF5
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 10:53:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3a82c8887so40044155ad.2
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686765204; x=1689357204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9fj86uPzHKHKPX1wldmULl0XqXDSPGGeaR3eMmaqoM=;
        b=g3wZP4kEF/0MGT5tCDD0ukqrS2SqYZB6jGjbDf/E8Joiv8RJrPZPnOOobgq3rKVC+L
         RB9GPYodgn3JF/MlworDXZZE5sW6PWFSH0ZqOYzbpN0QoKvPhgGt9lPZx/Ob2rcgKLsM
         euYoHENfjJ1jiKm6wHTYfUxTU47NznlaMimaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765204; x=1689357204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9fj86uPzHKHKPX1wldmULl0XqXDSPGGeaR3eMmaqoM=;
        b=IIn6sE5J9188Jfs94taTsjfv4WaVytzeX7WUOkkTcptYxSJ2iQoI6VZRslAqkfBA26
         1xeAG2msnIMno4MxcVJxv0kx+0XJLHjrlYRw7fFSoj0d4mKCNL9dsAlGU83RhXg+ylDw
         F05J/QC9rYi++k8+8s0xqxU1ZOmjeqAz5+OlEldm2lKj2aGS36m9j2DJzIIw94YZHZLw
         lWkxZhiKZEMzG0gD/eXffaFLPUlFj6Y4HvskRfR3eXfSnz7fTSrJcn/J0NvLeQIVexj1
         lz6z+3zvyHXr7+glIf86eHcJsQZCGSoFq0XR9KJo51HTxongwi4TmmfptRVYgmbxfo0B
         MFkw==
X-Gm-Message-State: AC+VfDwyOggKPv0IHu6oD/ZtpuL0/ebRs5k37qGasepPM4Tb3QhTLP99
	Nj+dSY3I85jPlQfJ9S25e6s+Eg==
X-Google-Smtp-Source: ACHHUZ73ificKnBEN4Y4oJNws11Nh+V2R8igTOiWQQVlZNLGClfQYikoltoGKYfCx04Yj9HDDKth1g==
X-Received: by 2002:a17:903:1104:b0:1b0:2d08:eb51 with SMTP id n4-20020a170903110400b001b02d08eb51mr16215661plh.12.1686765203877;
        Wed, 14 Jun 2023 10:53:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b045c9ababsm775899plj.264.2023.06.14.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:53:23 -0700 (PDT)
Date: Wed, 14 Jun 2023 10:53:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Maninder Singh <maninder1.s@samsung.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miroslav Benes <mbenes@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	bpf@vger.kernel.org
Subject: Re: [PATCH] kallsyms: Replace all non-returning strlcpy with strscpy
Message-ID: <202306141053.8C337829@keescook>
References: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 01:03:54AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

