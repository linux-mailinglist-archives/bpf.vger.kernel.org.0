Return-Path: <bpf+bounces-49073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F7A140DE
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8588F168D7F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15C22F15D;
	Thu, 16 Jan 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR7/S4qR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2022DC2B
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048588; cv=none; b=usGg4VlNGgcHz3XfWjKeIa/6ZKenfUcRaGmY3uRNKdlk0frkolfZ32QwEH1JaxJZB0CCZ8jaaFVgj5Ai/4QLV2yRzyOs9RtnQBrP6uBKUifnVGh4FrzfK/XOIj+Zsf4muS1SU9ATDLsCpltGbY98XKqAAQDskyNMRyuvQRiXqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048588; c=relaxed/simple;
	bh=A6oTALVnoCD3UWfTiQI8WU8vZuv1zX7Yg9y5q7e/f+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cZiexmlH6gIZ6x/kX/QhCVouvbwFYvGIXq2fWlHjcpXpG/i9jcjltjwFNKAhVhAvyNHg4VyAPKkGrvB2jv7Nx3W7KQOcY6dWwrLCV4egotjCSr7Lo/q0+cyCFmMFF5mnC2kYW6J0HWmV7eSMt7s9MLNbBe2b/+FGajdZCMOgJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR7/S4qR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso15039215ad.2
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737048586; x=1737653386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZr3BsN3e/+Hy2fvkLY3Mk7MCngxr56zDV0+9E+Htmw=;
        b=NR7/S4qR8OzSTzzjdtFBoFuc9MxhrXvwwWbqQfNtjd+fZgYWrAb5Pm40QQRu2tgsDh
         ebMJve26jmBXMBLaL3Y37Oh/uMCOs+rsrd6hfxfYG8GkVlt6JzHnRcSWhync1OtQacxY
         42EzXtHdsoO1qyIkAymDUCnD1p045l7z3s/8GR2gklS3Eon7Q1t/mEylPqynkFBv80ry
         GnFjxE4AjYM+19WcUQg51oKc3iHOa8Rqs8zc7upUrcmMn6LFNR6SdrFJnX8MweENzX2+
         lGm5iIV3zwN+4H/fTy2j/xQP/8+dDCF/Ugntq1vuz4pk+21XoW8ONXXy1aAOiMKNCeus
         dzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737048586; x=1737653386;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZr3BsN3e/+Hy2fvkLY3Mk7MCngxr56zDV0+9E+Htmw=;
        b=LWzG5rss1ETtRDJrN0Nba2uUcDzcYFAjX6dCcDD3/vAxjvkWFTIolFiyjvuhGkc3QL
         lJxRwGHTueUWSIWf6RqnNu/EwFTSR6dmDrNtNLnkGmnYGuhGXzGXc5RQHxrKbArcqf3G
         jb2a5j0xsJaNxEbYjSDHzLKoaJzQo6hegy8f9Vz/FV6T12recZ/dkou88C8KOtzwQuGF
         PTo9HAmyJj/ubw/34TLAORZ6M+WIRCrNfT0lmiY1gldR5wTtjf7FxUlkvegrBjOoc617
         c/2HJT0qza7oFGSE/fGbUc0hEnOGFo6bw8wsKdcB/4O6+jyKyXxkIf1ynWEoXrAvBaLw
         ZtKw==
X-Gm-Message-State: AOJu0YyTT6igJowIiSkwFpVLjVGVx8KkxXkmyMpcXAS55Slr4HPu9v8R
	tDN8fKbotczXtif7eF5aZf4Jyha4WvtZn3K9zsMNszjm8HZ5k1oDLlSZBA==
X-Gm-Gg: ASbGncvmYlKETDfJIjdcL8onUh9m4f5Kz6L+1MpJNce1LukWB31+Pzbtz2Kwgickj77
	7m9ogBTnJgD5uMZ4j+Z//fqf5lLQUR58DCcAzInFSRl/r5gXa4dkJ1poa0imdMLuxp3GJ84TlUT
	ftqg7ByL0fuFwD1Io5CjoxWdzkhSgxgjIxrSWBp++JUgPqR8xhuk7+0SV+ND21vmsnQAkxxAXRh
	FJcXebId/3qcMGImWIh6wqt7Jg=
X-Google-Smtp-Source: AGHT+IH1FAsbooWwp2frrFYrTTBO1uUxVEWyAFjS6gRXM+g1XC0Y41syePC6ExqlAI4ve8VUD1S5Mw==
X-Received: by 2002:a17:902:c948:b0:21c:1462:17ae with SMTP id d9443c01a7336-21c14621af8mr46140715ad.19.1737048585518;
        Thu, 16 Jan 2025 09:29:45 -0800 (PST)
Received: from [192.168.50.122] ([117.147.91.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9e911sm2884645ad.4.2025.01.16.09.29.44
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:29:45 -0800 (PST)
Message-ID: <2f71de06-b580-4b94-adcf-2e504bc68112@gmail.com>
Date: Fri, 17 Jan 2025 01:28:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sub bpf
From: Tao Chen <chen.dylane@gmail.com>
To: bpf@vger.kernel.org
References: <36df7768-1edb-4e1e-890b-3147150c1754@gmail.com>
In-Reply-To: <36df7768-1edb-4e1e-890b-3147150c1754@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/16 13:14, Tao Chen 写道:
> sub
sub bpf

-- 
Best Regards
Dylane Chen

