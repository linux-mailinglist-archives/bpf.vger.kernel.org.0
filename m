Return-Path: <bpf+bounces-16559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4548029B8
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 02:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8DF280C62
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ABDA53;
	Mon,  4 Dec 2023 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMXJTU0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE64E4;
	Sun,  3 Dec 2023 17:10:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so8376365e9.0;
        Sun, 03 Dec 2023 17:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701652255; x=1702257055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7z1N5dO8NDm/DCrI/ELJ3ueqyVV5fe5hp80A3mLNf8g=;
        b=aMXJTU0QiWF/bPyMD+TlBDmXNrrLtvJPJjmS65i0njPkKJ/5iZr4fV1YkLxqgHVYq7
         vugl8Rx2noow7iQiYiu14hpUQ0Uw+xS4XHHQkxgXoih/UjSMPT8RGNsLtVTmKUkccpHO
         NEqpns+MlJcwtbl70ETAosh3q6cTEwIJqc/u+qQdMVjYQn/jDyhP2x2lgVXeUjeMImYu
         rQiKCcX7mK0HTdGd499iy7M+BozSR/sG7wbqItXuVsrvpRRcF9AWltvoJ4p4DHTiJRYE
         bD+vRXOu2y0QBeEDf5B34qq1nYNliqnJbrdQEiwR9anG/yxkmWfNSO/8AgsndRurI/6v
         bixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701652255; x=1702257055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z1N5dO8NDm/DCrI/ELJ3ueqyVV5fe5hp80A3mLNf8g=;
        b=wD5ZsT21f8iut+SI3ecSkxgF5/rJ7MoSAQhDw41EGWlWwK9l+zkb/sMAWymb0KEp7N
         Wq5qSAQTfpFnOL7+7FFvwzBttmXlmilu9/TYX/a9y5bdLJ7vyend7OqVNNIUFD4iLdnh
         yRS1pQ7pyUF+Nud57//IgM9TQmzAMTUzLaaFMgdFgoJtJPfwzlhfF39iYmAE63jVu5hl
         PjVjslGNLrD8J7xlxVpWW7ZgZQnmK2S4z2SBmJTxrCyGPnyPy/TSPGZp9OG1/bif1fne
         /TmskVV9X8XwbfW4dSabakrQswaqtMOaDxMmZxaOo63qmQI9/weLzgfOy41/XS44ynKF
         Qk+Q==
X-Gm-Message-State: AOJu0Ywjxz7RVj/V6vC1dwD8tPjiUMLhUd3pBfBHgV6VOy1tC68ljWzk
	1QaNmFd8Tc0LRyx6QhLQ6p1G/bvos7gR2blQxiojiI7XIo+CdQ==
X-Google-Smtp-Source: AGHT+IHbn6qn1Ma3CVdV3NIYkRzeuPMFp5sufb+8tQbZ6nBOrEWkpI/uAEFVTlCW1lU9CJ6dzRnY6SlSZAPvuSUjE/4=
X-Received: by 2002:a05:600c:2286:b0:40b:5e59:99e2 with SMTP id
 6-20020a05600c228600b0040b5e5999e2mr1408573wmf.258.1701652254691; Sun, 03 Dec
 2023 17:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
 <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
In-Reply-To: <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sun, 3 Dec 2023 20:10:43 -0500
Message-ID: <CABWLsetF=xAnL3go91u-J=uyZ_jf-TFrOPzSHt00DvJrKixymw@mail.gmail.com>
Subject: Re: [Bug Report] bpf: zero access_size of stack causes array indix
 oob in check_stack_range_initialized()
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fixing in https://lore.kernel.org/bpf/20231204010139.2038464-1-andreimatei1@gmail.com/T/#u

Thanks again for the report, Hao!

