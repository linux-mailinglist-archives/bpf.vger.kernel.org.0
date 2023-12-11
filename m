Return-Path: <bpf+bounces-17451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A227080DC50
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 22:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361FE28253F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DB54BCC;
	Mon, 11 Dec 2023 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTR0APuu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178F9F
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 13:02:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d075392ff6so38334915ad.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 13:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328520; x=1702933320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wYaM5uBzXBdxPCu9DUnv6g+CkAOzQyjg7jkdodY35Q=;
        b=HTR0APuua4s2ML9LBg166Q8a2F85fJ8xlkrevMnL66hV27LHIkRKOQNJZhNHOR7kpX
         86u3Au6eWEc7hMyY+0prq00wiMUqWZeZ6xMMMjhnFuV210HlXmapLB5ZhFizxmDFLbnW
         q8RfRg+n4+VdrzDJkKFkwUk+e8+qeCPRqnu9Q+QBFCsNN0znEb9lUsT/Vu2FXaPwmlCi
         XgbCpw5HkhVt57KpVyz8lEtQYhJeuox2jY342jOOPbf65ZwszAe/DekUL2YSH8OIpQpU
         9+4+8cUdAJ5IyC57xk1ljZoQLiBY7JY1xUClvG+9GYwd9PAVUIpfoyPiXgOrrtOzTVV7
         1d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328520; x=1702933320;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wYaM5uBzXBdxPCu9DUnv6g+CkAOzQyjg7jkdodY35Q=;
        b=wIvi/4CVYPOMgiP6a18P71RJT3AuZOwF1MBPqhyqDZEHg8ykBEJWJeQF0MJzjVQIX7
         5DbJWsEUcO/pM0SdSDTIEy1GMfqjh/IaCRfkS/DSbjAemQXtIuZ1q8ArALA0B/7NH24s
         9maE676n0BXb1ldzR1bURlRloOK/pG5jTylhcK7Feh6jXUUbZC0JnyrUZIbAZJyrNCdl
         kLIBpXca8Kl1bi5usm58Lm+h1CxxmwCZOx+NKl47i6RGYG84prXFTywRrMQrPBpg4X5Q
         x5qPq1YqYD4bFMvRYlE0sTLkeJ5dGBsE8+G5G+LQ06eFFUXyrTmtxzlzm8BWscu5LKrh
         Kh8w==
X-Gm-Message-State: AOJu0YzkBEzei+b8mV1dreynuUnPvXMY144lK6jQ+GcWR+msvZCovist
	JYlhKbFULFCCw7TlRJ1b1bU=
X-Google-Smtp-Source: AGHT+IGAH6SA8NhuGX/NNoIytlovq+KkeXlz1kXHDOpdwSQKN9CtwJnNh3J00jxd+PZXuf9NVKeZOQ==
X-Received: by 2002:a17:902:d2d1:b0:1d0:8e08:6a with SMTP id n17-20020a170902d2d100b001d08e08006amr6958843plc.6.1702328520503;
        Mon, 11 Dec 2023 13:02:00 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001d0969c5b68sm7095092plk.139.2023.12.11.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:01:59 -0800 (PST)
Date: Mon, 11 Dec 2023 13:01:58 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, 
 bpf@vger.kernel.org, 
 andrii@kernel.org, 
 daniel@iogearbox.net, 
 ast@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org
Message-ID: <657778c650992_edaa20895@john.notmuch>
In-Reply-To: <20231211180733.763025-1-chantr4@gmail.com>
References: <20231211180733.763025-1-chantr4@gmail.com>
Subject: RE: [PATCH bpf-next ] selftests/bpf: Fixes tests for filesystem
 kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Manu Bretelle wrote:
> `fs_kfuncs.c`'s `test_xattr` would fail the test even when the
> filesystem did not support xattr, for instance when /tmp is mounted as
> tmpfs.
> 
> This change checks errno when setxattr fail. If the failure is due to
> the operation being unsupported, we will skip the test (just like we
> would if verity was not enabled on the FS.
> 
> Before the change, fs_kfuncs test would fail in test_axattr:
> 

...

> Fixes: 341f06fdddf7 ("selftests/bpf: Add tests for filesystem kfuncs")
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

