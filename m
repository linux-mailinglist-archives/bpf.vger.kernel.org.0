Return-Path: <bpf+bounces-35019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD19935282
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE17A1C20B9B
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DD7D3E0;
	Thu, 18 Jul 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww3rsVoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051B1EA8F
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335725; cv=none; b=Wp7RU2xjGB9cVp0oGrfbq11CbJ/svMpi5+gCxclkd15Lyfh00cTyfAWvTvnvhIBXLnbjPceNOrAUDspOi9g29PQuQlKRM8mY12f1UqnHs/uykViVUZDED0jlge0vAto0cOA3YfL17sYbQG/2E+sqkusRHlUSTd3GelkqQHT0CDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335725; c=relaxed/simple;
	bh=MWWENyx77nHe65WKQAFRa0wS312LuJRvYQLRWpMKdag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hr3m7bNw4dCMElvRJVB5bEiIx3Knz8T+vxyfpDCqrXS19CJ5BKsquasAPS9f9H/bFtkVRRifE4L8lMSkTtNCMFQyIGmvUs3ByyRmAy705ZCffJfLpxZNG/OtBtB9TFjiOp3rCIJvqEV7yGngVGlRUC1PlVU/060GLjcrW9tCjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww3rsVoU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc2a194750so12594915ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721335723; x=1721940523; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWWENyx77nHe65WKQAFRa0wS312LuJRvYQLRWpMKdag=;
        b=Ww3rsVoUBjC8C6Sx2L83S2EEHYdS1e/tQsAGHAuBG4Z4SR3uKmnYsQqRon1pjg19DT
         FEQKgySX6l4SY1dlElabFUvpZFsEiNXPVN+rXpj0U9RKjZgpM+AxdEj4ETqX2H13cdgv
         AELYKn06n2VyxyNovzmJQ1klqOzTszXTzTR+38Mfha7rIuH96fXoue6Z8e+LLN51RHhb
         i28cQZ66ErKxaYJiw7MywKsllPe4b8T1ezDGCqc35cDBeGqzLISIgBZDIfMDZmrUbaTx
         ngpQnQTgpeZJDijRwEuQGaluLrIlahH/PHlNWiGIZg/qOFXsfY3J1jiWvloeO+o1RBMS
         TFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721335723; x=1721940523;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWWENyx77nHe65WKQAFRa0wS312LuJRvYQLRWpMKdag=;
        b=EzFFJObAeB+d9Of4uVECYwRyEDZsKbM/gJSIcu2LXvGNP9LoLzx619Q3hkgRJcF6+j
         lI2224Fvgjw6s7xCW3i/wexpJ4ooYPYRf59hJVKBOW2YgU3axZq/NT3JNrXh2KEBzt9x
         CETYK+wYZxdN28OpAIgu23stE9m7pVXf8O/TvuqEL0LvTYc7o0OT9YUpFUo6cSxXDFfW
         e5qN51KyxGXatn8/V2p7N2J/Zk31VkcnUgMvbtZVtRdrcOhYMsOdXVI0DBmR6Wuj1or4
         vw4b5Qj4g7HUrP4Qnc5+qya7oiAxhNpNI/5oB/XxgRGROxKeJfxsDu8auEoOHkywK4gD
         UOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVRAzpp/4QivOwr9ba9HdGLOpJmKPldpleaOhAiAHqilpVdpX3hUDJvuzONiUGIp32yurgtCWlvhc12m12EsNbRO3X+
X-Gm-Message-State: AOJu0YyRpQ82nU7U8Jhr2dKSuizlVjNypa6L4xsqinBOwJOIyECv9yor
	xfAMjjp8mhbjJ4UKmay5B/TuZzAYAnGMvNNa9HjmRg1gq6ci+TrA
X-Google-Smtp-Source: AGHT+IG5kfBACo6uur/5r/0nCzDBncCCxHJIFTgqfR2xYgup4NR8JUqhPm4R7Wj9ORxvOSl8uSM01A==
X-Received: by 2002:a17:902:e5c4:b0:1fb:396c:7532 with SMTP id d9443c01a7336-1fc4e6de98cmr49950365ad.56.1721335723161;
        Thu, 18 Jul 2024 13:48:43 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbbf792sm97489685ad.96.2024.07.18.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:48:42 -0700 (PDT)
Message-ID: <a0b85fe5f9d032e442f4684ee00609b0b701404e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add reg_bounds tests for
 ldsx and subreg compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 18 Jul 2024 13:48:37 -0700
In-Reply-To: <20240718052827.3753696-1-yonghong.song@linux.dev>
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
	 <20240718052827.3753696-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 22:28 -0700, Yonghong Song wrote:
> Add a few reg_bounds selftests to test 32/16/8-bit ldsx and subreg compar=
ison.
> Without the previous patch, all added tests will fail.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

