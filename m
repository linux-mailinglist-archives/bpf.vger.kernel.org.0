Return-Path: <bpf+bounces-2603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB93730796
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4DD28155F
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB2DF6E;
	Wed, 14 Jun 2023 18:47:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBEE7F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 18:47:32 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB31BF7
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 11:47:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3c578c602so27492195ad.2
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686768450; x=1689360450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmBNzHd4xcyc4CdrIRgzISzFmerz/N2gTUpIsAvhNYs=;
        b=Kd+j18HppH8gb5RMgj9jyZh6NO1kvl4NlxbxLHiQnWnF3B4mJB0wCVyOAuKUsfc60Z
         xveiHdxE0ZwLjOmOEa26Jg2ysPu/ROd5o7j9DeVaIo9qx4I3RkyG7pFb/VI6iH4BMvBt
         5FKgMJlyrf/Z/22xhetwswkshcgz8HVrA4lCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768450; x=1689360450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmBNzHd4xcyc4CdrIRgzISzFmerz/N2gTUpIsAvhNYs=;
        b=ho4l75mxTJ12vl2elgKExIeadytK6gKfnYUUCCcQr0ELyIH+Yjxffie6JDZgXyitHL
         KCeaiccVQ11reCZhNkIFLW6OoWVzXUOh+E2DAQQSbp1/YDV6I6/651SZZFkzOuZvyEzm
         Bp0d8dht760iJKw348C+qIM7KVxNJeRSq9++mJpIRRK1u8hihg2cOzCdtQHfrl7R+Vg6
         2HSUoJPx/A0jW5mjujIVyPFq8k+p3Sbl2oKBGBB2QUAWnDYcOjKx1fu0zHb9TBsE3zAv
         r/ml/AGbhUuqQPMjHQxk+xBF06+Oo9e+HrkUNoq9lDEsFdm9JRTmH/kM5infIRTP5IYn
         swrQ==
X-Gm-Message-State: AC+VfDwA4wiOhU+qTKGFPIKHmqQC/P4srvHy9uOaJQaolih64spYyFUQ
	l2c/6CFWBSs9wwliNR3tn4jpqA==
X-Google-Smtp-Source: ACHHUZ7zlhsSV5d4jOAU/rlQfVLCforWzQ+oqs5bRKQb6jc0WqHMV/kuHLcIOdeZ6dHSdFIzRhYBuA==
X-Received: by 2002:a17:902:ecc4:b0:1b2:665:d251 with SMTP id a4-20020a170902ecc400b001b20665d251mr14227281plh.47.1686768450634;
        Wed, 14 Jun 2023 11:47:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b0019a6cce2060sm5905193plb.57.2023.06.14.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:47:30 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: azeemshaikh38@gmail.com
Cc: Kees Cook <keescook@chromium.org>,
	mbenes@suse.cz,
	bpf@vger.kernel.org,
	maninder1.s@samsung.com,
	alan.maguire@oracle.com,
	peterz@infradead.org,
	thunder.leizhen@huawei.com,
	linux@weissschuh.net,
	christian.koenig@amd.com,
	mcgrof@kernel.org,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH] kallsyms: Replace all non-returning strlcpy with strscpy
Date: Wed, 14 Jun 2023 11:47:28 -0700
Message-Id: <168676844721.1964221.12024901543377074461.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
References: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 14 Jun 2023 01:03:54 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kallsyms: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/5a5d3a09dd76

-- 
Kees Cook


