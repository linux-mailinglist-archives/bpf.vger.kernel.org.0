Return-Path: <bpf+bounces-17650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDE810A93
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 07:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48273281E0C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60793107A9;
	Wed, 13 Dec 2023 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZL2mNBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB40AB
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 22:43:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so5839012b3a.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 22:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702449827; x=1703054627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rBiUA7/oDQqRUj4NNEFIVHuivnaFwe84BwKK+YG2Go=;
        b=VZL2mNBJCDD44jG+T4+k6E+qtpmPajFRgHBSL2lFFSEyXXsQmPlPH89sVesJ4r3oyN
         qTzGLN/RiHSt1u9EV5eCYpawKCBqXCFAqizva7ece57r+acm3VrkR0wS5IcJ/Wo1yi6V
         mmTyTuo7YNGQepsuhqT3LTwcGoVeYORkVYOag4vsblF169cU9pYnSaOVL9hE++XzscHO
         fMGI9VVsCvG8HgLKBzdX4Suaa+9OKNNh4etHUnEDTmIKVBKTmKj2QKyzl1NGLIr6myUj
         NCZhG7vb7s82BuuQwyWwFozDt0+hWXxzwlZhetFPFNXI51GGf1RB1TgN+Yfvv+9gKcIn
         oCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702449827; x=1703054627;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rBiUA7/oDQqRUj4NNEFIVHuivnaFwe84BwKK+YG2Go=;
        b=jChPWxj6hjI+dlUXwFf4hc6my2vIrN2g7NjrwSwaHKY6qhqfxJNa2VvYAYtao/RGAg
         neaujlzzCVxn9019RRWAGlzXuNYZpK8/JCSeGphYQ6tNba5Dn6JKbAa10fG4V290L1FP
         puA5dyuH4sjlOyY3X0aM17gVDV7alMX/KKzpOmqqhydvIgJT3xxYdZplM3GMcrSBP5RS
         7fiYDFDicZhffs0ro1VFVtCXNRHA5uyB6WY0UxxjmSakS56U+/YbCEmwpaxs4+2NorxZ
         lHgMVq7IDx2ZqUfSgxy+0j50lw3bgTUUoupIpZpuS9Wbsu3DkvREIs8RVB7xdQsFMU+X
         aVOg==
X-Gm-Message-State: AOJu0YwYZGRIPDeLPeunkpwlU4VCuXxK0FGDjc/t99XNm6JYRSVMCnef
	KtYtUrp/xS4BlWEP1N+gAwM=
X-Google-Smtp-Source: AGHT+IFskKv/LvCmvsHvPAWzJ5l+ops4+QPUuaiA32wNeERMCnNDgIisnvBTluAwif3jhLhBemi8mg==
X-Received: by 2002:a05:6a00:aca:b0:6ce:2731:e86a with SMTP id c10-20020a056a000aca00b006ce2731e86amr9549461pfl.49.1702449827161;
        Tue, 12 Dec 2023 22:43:47 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a000b5200b006ce835b77d9sm9290052pfo.20.2023.12.12.22.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:43:46 -0800 (PST)
Date: Tue, 12 Dec 2023 22:43:45 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: kernel-team@meta.com
Message-ID: <657952a11c7dc_26e9220857@john.notmuch>
In-Reply-To: <ba9770b8-90d8-4a91-a53d-511b1d3035e6@linux.dev>
References: <20231212225343.1723081-1-andrii@kernel.org>
 <ba9770b8-90d8-4a91-a53d-511b1d3035e6@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compiler warnings in
 RELEASE=1 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 12/12/23 2:53 PM, Andrii Nakryiko wrote:
> > When compiling BPF selftests with RELEASE=1, we get two new
> > warnings, which are treated as errors. Fix them.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

