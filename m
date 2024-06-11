Return-Path: <bpf+bounces-31880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F176A9045C7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE2B2560F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E281411ED;
	Tue, 11 Jun 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+ldGZU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA474D8A8
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137885; cv=none; b=Lv5BbgPPMV7iGZZkQ2YYC+nNDb1nobIthdHRey0jsnFxjGiF6obQBCDXZ7vaCH4Yf0aj/oZXZpNRngUdYsYjcnSl9Mdm3vlcA9rsm5oO6QS6VLVh52hE+txrYUUPV6nFodjEqfqBchN+n2zzsVWrb6wp/Rtg6VfHDTqv38IEOcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137885; c=relaxed/simple;
	bh=/tFSmc3TZyr6BRdo0jDPUdgZIvh/LMt4wDS5USHSNNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsHtnS0NpQ6IzzPRk3/kP8Et41qEmJo7rWF3QHl3Sg719CUpAKmQXXxRUoPJ/BltK3qJVbur0GynQE82FLFLxLPrfuOD0VgHoMq+J9+QS8oTOvMenujf0aiLtcswbdY9kmVinkU9b/TuDigGaMnx/tLbW5SLpzeduL/ygroHuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+ldGZU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6a837e9a3so37060775ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718137883; x=1718742683; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tFSmc3TZyr6BRdo0jDPUdgZIvh/LMt4wDS5USHSNNk=;
        b=E4+ldGZUX4MulPUpaSGCH/DnTV4q4C7skLWuplwKsR8asI/NeTnJw3Ki9mKG5ktXwu
         08P1F67fsZZtJsLPMQ7e6Q3IX6Bu2f1DDkeiuooO/DaDo1eJlHAG0Vpg6nPWcdI3P0w6
         TzgtCsHI+O1JRnWSWiNRSswfeI5w61szlV4bGGz3cGNpa335m7L9cBF0RFHsvcVAm8le
         BS9kBnIvPuWDvPbt4FVsxgzgzGrx896sv+Ahwd+PCqMPv2dE6o78Pjw7u+WNXxperj89
         9UkPAkKwhZzQXTpDE4J4vHbX5YDyLPSmugb4hmr1WH84mAYfHB4DfqAf0hYTrXDlg1/R
         5xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137883; x=1718742683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tFSmc3TZyr6BRdo0jDPUdgZIvh/LMt4wDS5USHSNNk=;
        b=r/BnZKMA2Hn4wmB+oUs1OBogky4WGQOHaa8NjI4DrIO447K1ejKe1XRYb41VxbosWp
         60wqtopUrmSWlwuzj14dwKZmHVPLii/ts9OB3YR5WGCR2TObfOBTRdp2eAbNNXOrwek4
         cDghGj3kB/ibguVnmTTpIS5YUR3zuwbsQmVr2brNAmAg0RdIn/L7IThaAEUFFzKL60Hs
         6zDsZMbfwYtPKbeyAIKEidHBInS8wbjtedqTRGQbLAqT+dwkkjhK6qW9WEyeYbV398mr
         XcNaYopEpeo4mKZQhK1AQHdybCsWJtq5zEe2S2833ruo4OllitHvSQ91DROW64ucOA3z
         Vrzw==
X-Forwarded-Encrypted: i=1; AJvYcCUdIbmg16mKbmWqr5SXbak2OC0Gz/hNDCyLu1Ct1rmjfdOfm3MIUBYiXA/qvh4vl5ZuCjiEA8zgGcHCTuvMmsHdhliI
X-Gm-Message-State: AOJu0YyEsD51uvG+cE7qW3ybQ3icNDIA6XbL0WLVEN03oF4NlmFJx0BQ
	n8XRBReCuGvrYQuiEB1AVZqYpl6McktE2/Q19PuZ8i/29rO8odn2
X-Google-Smtp-Source: AGHT+IF/Bwk1X/t9b2ukkP0/a/zsQb7WBpPcVjuVxU4UYQiBXcdMwyZEJwWi55C5kI4NoO5XlzzkRg==
X-Received: by 2002:a17:902:ea06:b0:1f6:e306:1786 with SMTP id d9443c01a7336-1f6e3061ee2mr114311545ad.54.1718137883191;
        Tue, 11 Jun 2024 13:31:23 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e42c0sm105895675ad.222.2024.06.11.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:31:22 -0700 (PDT)
Message-ID: <db0ca9f4dcd146d56b350c28b0d26468b8c54b00.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Relax tuple len requirement for sk
 helpers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Tue, 11 Jun 2024 13:31:17 -0700
In-Reply-To: <20240610230849.80820-2-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
	 <20240610230849.80820-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 16:08 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> __bpf_skc_lookup() safely handles incorrect values of tuple len,
> hence we can allow zero to be passed as tuple len.
> This patch alone doesn't make an observable verifier difference.
> It's a trivial improvement that might simplify bpf programs.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

All seems correct.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

