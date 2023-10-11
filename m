Return-Path: <bpf+bounces-11847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F77C45EF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 02:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4B51C20E1C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAAA383;
	Wed, 11 Oct 2023 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfVp80U1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F2369
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 00:14:51 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E29B
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565334377d0so5018201a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983288; x=1697588088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCeSJPd8HQSJUW/ehPZETplrqc/WZGCTN4su2s0Zbg=;
        b=mfVp80U1B7KBJ71IzevXg/i3MVsyIy7mOuOu/Pr5I6FD3SUAO0nI93uGktOFHVC8c4
         iBGAKXIvcc0qvOyXRPetyyqTxq45xB3TUH9TjXUmdJUCaGxzXbSSdeqRG4ThNOWHYwwh
         9os+jMtkkZIVkjA9hhsQKLsL6UadgNVptM7oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983288; x=1697588088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUCeSJPd8HQSJUW/ehPZETplrqc/WZGCTN4su2s0Zbg=;
        b=tobTeOnD3tejuGJcG572hQBHcdmtEqrWHCoYWUsLZY5S0tvZwX5k9ni0UFv+C7aX3r
         xpZAa36SdQK2Db22PwZBNgPHVphrbA3yigEgG2Dus3GA6CXKsVsWiFVW4HDepkTjrYYv
         n+U1r7zoX0yv7GaxIn+3MxO5JnqD+61CycmA4JSO4svs6hELtTMIaK4XVIOgog/1AUl7
         px+I+EzGQlTzUibjG5q1rdPDY+1rgTlWTXEGnFmxNn5UcueT/SdM0hdLHo/yy5LLgTkn
         0Q4R1gJtQHZ9B/hmic0HbkcG/+EktooesvtL4YhF/fClpJ0lV6I7UQfR7hQoDmdg6Ca0
         IEtA==
X-Gm-Message-State: AOJu0YysAaT3PitmGjvs95yossQtuntx1F0G9OpXtbyk0YKUL+0ptZpg
	fFKiD7iK42TE4SR00IBEFR+tXw==
X-Google-Smtp-Source: AGHT+IEu0iHuIbKap0+Pgy72dLzHa/+bzOMU0Ip3s2PvOlQ15Wm9uvCQXCz63lutTjoXxYd+igxBRw==
X-Received: by 2002:a05:6a20:5483:b0:16b:80f2:c234 with SMTP id i3-20020a056a20548300b0016b80f2c234mr18020146pzk.59.1696983288122;
        Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e1-20020a63aa01000000b0057ab7d42a4dsm10695323pgf.86.2023.10.10.17.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:14:47 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:14:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 1/4] seccomp: Refactor filter copy/create for reuse
Message-ID: <202310101714.FFBD84BE@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-2-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-2-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:40:43PM +0000, Hengqi Chen wrote:
> This extracts two helpers for reuse in subsequent additions.
> No functional change intended, just a prep work.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Thanks! This looks like a clean refactoring. I actually think the error
handling is more obvious now too. :)

-- 
Kees Cook

