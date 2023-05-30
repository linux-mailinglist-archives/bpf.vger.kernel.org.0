Return-Path: <bpf+bounces-1471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B18A71717C
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 01:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A5F1C20D67
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46D34CF9;
	Tue, 30 May 2023 23:17:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865DA927
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 23:17:35 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E0EC
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b00ecabdf2so46316695ad.2
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=mnlm+bH6/fI+ZtXDTL9Lrmbx7ViXjTU7huF80OGn3FPSp8sLaGgLeMI/tbG51iToyf
         mHejWE7I8q4WGv1OLqXPEGPc2Sr9cyq04o4I5lYUkiMp+gXSQAX+P/Z32VBAzM9xpOe8
         TJlReIhaYPOcD9qAo6SrRLJQGDxkHsAZw9l3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=BsS09Gc80vQFuF6DUDE2vIvJ/D0xccKDF+NI8+4nEu3QoegH8NhBN52EQ8wEk+fQ+b
         64oLmBkupsHNzJruUVzldLbPr4bQsdDSOXfa8IjPgfH7iDITS6SefSWgt/8kxmMxfkiA
         0nASHA/mgkejgdqUTP2+vSz0TyJpaO5A/gr/MIWPNxGH7/PQGCZiXKO8WBP++s+a5qEC
         wfqr18c10osZ5FKRm1N15D79A9gCG1iNOiBZYdH3QGr4E+q0Z+K1WC9DsIfkPHO4sgEv
         cnAjC4cBQYeHDlDRfEsNpYV5A1dUBRRQ8Lgk1SiFZTtodM6m4z1femGXZLHCab5ezgMk
         7XGA==
X-Gm-Message-State: AC+VfDzNRgwDK0mGd/t6kipFtSQ696bGD4QFt4RgDkKY4TkqoUJokqWK
	rcEVYIlEnA6eZxhN8a5tYBgW1g==
X-Google-Smtp-Source: ACHHUZ4rzSiRcHEqELCHFhfbmEP90GAMJuKp2xmVuatTGNDqQav21vDNIxEXT/nfHYEkIEh+wIJLXg==
X-Received: by 2002:a17:902:b696:b0:1af:beae:c0b with SMTP id c22-20020a170902b69600b001afbeae0c0bmr2991202pls.22.1685488652497;
        Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001b0772fe3fdsm649636plb.265.2023.05.30.16.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:31 -0700 (PDT)
Date: Tue, 30 May 2023 16:17:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-hardening@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.EEB6B76B5B@keescook>
References: <20230530155659.309657-1-azeemshaikh38@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155659.309657-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 03:56:59PM +0000, Azeem Shaikh wrote:
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

