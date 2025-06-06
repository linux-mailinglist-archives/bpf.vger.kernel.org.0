Return-Path: <bpf+bounces-59870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B33AD0506
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7310318996B1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9B27FB02;
	Fri,  6 Jun 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AtXqnNfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5519D071;
	Fri,  6 Jun 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223065; cv=none; b=a4+yMWltrpojeKRi08sVZVz39LSB6z3KWSgawtJS9SUI6rPrgkuiU6KrZX41L6uzuGo+xdAt+q2v3nHACXeSKLRRZpvaE7KEX0A6DnmgkJ1dtNISDkkfblvVkeZDZLgX3mVUrGzoWjBMtO4dyj0aPARJs9RC7es5XpqWTNyj08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223065; c=relaxed/simple;
	bh=3UnBpzUviYG1OvG09DHAzrYS1o7O3VgVe3waneM87ps=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzJ8nXMhvCnrTZbRo/3J8j5iVl8VYzdvAs8rnCezdsEvpKQZxTzpWhfS2yGlTJqgGfgm11kZTMmq9eHmU1qDRyZI2Gptv78+S1irtmJBcvhL48076F2zra6gWzMcxPEjVbyJ8wkw3609xWPjkuyY43aRZBGlfV8ukYAhwzmo/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AtXqnNfv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9ea8d08so15462905ad.1;
        Fri, 06 Jun 2025 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749223063; x=1749827863; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pvm1FZURgSU9OU+MVCUdN5gY3oGzxceKRQOHuHZzJBk=;
        b=AtXqnNfvNdVKn+HXtUePxysMehac26tFFtrqa2EUNnCCS+MwXkmJkb+xly3VKSOa7/
         9aCVQxqK3KNYa+gAzZISkyWV9zIBU0mxbMqMoeU2c7jcIF6ux+H8rWIL0dUHrYdrUTll
         ZAOmqezZFyYTiXjFNxaXMStKPQtu+jDiwP7TWx24AjCYzOM5qjKB++15MVVQ5uS/mgGC
         n4ElGcvzT4rbDao4I0L+4hKJeyy1iZcUeu+yl2FSaS4OAFUVr5tokOApXFCshGwIiUXt
         EkV3BnSXAb6Lth+4ZskTRMDc4rlowFCGVydVs9QG59RbRIwSUk24JSnF/Lq0SnP2S14p
         vPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749223063; x=1749827863;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvm1FZURgSU9OU+MVCUdN5gY3oGzxceKRQOHuHZzJBk=;
        b=RQi65xzp0LkwWIKBEetdELJ7XuD5KGAZScKOQH50YfHjGF8n9+2FPd0s5DfrlrpINQ
         1H4dBN/QeF+il6Kh0VlsUHRYKZBfv6O3FFChNdP9ORk5bQMvCY26jGie+VZW9wpEJ3h4
         6xGeiS4OpYE19qxjBRYH340geqcrVb+DlLVtKv6bL3ZdARfvkwviMDJttldzH782zSmt
         cSX4GAPXXFKyLG4HkuDpgP9U7SOg7iraAH2gLJUtk8tOEtQ0xzIJ3hh024NSR86kefaV
         a4z7Ui0Jq1l/+DIHwGK98Czd4s9kQAb/9RRg6ijyWiufxuXS8FpJS+vFBikKzLvRWn43
         ZLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpmtXysR8lJHtfOmZ+H/BPeksWXZYyVRImyFkpQ/ITtX2SDXCflEmAMuZxcWPBjxuZ64U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuaMQdE4N+lXvfLLbHZgGYY6WtHTjSN2AX8L48YyfBfQKq2Bz
	eWVBGlD68+cZxQBsohx+iFyjTHqaOotn2v8pn9Xtpq3PqlzMi0Y611hL1VR4yA==
X-Gm-Gg: ASbGncv91K9IDYu2f+pyRjQJ+phXHq9pdOi6XygnbsV3H2yJM6bypqMWtPNJcQ6UNHa
	DHsCqDwZZdOf1qUV/OL93317Si0Royxv0207njxqF4ylq/3AT5vI35MhT2/qSDBxkPRU/0Kg5Uy
	h4bO0fKMSp8Ch3yyTPbq6pZoOUb7N/BHGJ9L9rmhIdGMurP4TDeeT6KnrEGJS+JT4MqRF1k5kzY
	87aRGFcVxtPItSlU1FMC+OQrxMfrKZRS2tebkB3sbGhxAE4y5TREy1wDGbtifilDl5J9otQrHVn
	EqJSCs3EU4ZHx/bX7gtIV70gAmbyJPYMYUQ9ChSnqQWf+iDEgQjUw94FJ2XelzX3FaeR0bjoWuo
	=
X-Google-Smtp-Source: AGHT+IF7tFr98jpphQmWIkFrc/Bd5LYrI7G1X8jhiiA4jQkKgPeoIT0VWF3YItds7uvTxgZXzWVqKg==
X-Received: by 2002:a17:903:18f:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23601e21f1dmr56067835ad.5.1749223063503;
        Fri, 06 Jun 2025 08:17:43 -0700 (PDT)
Received: from ArmidaleLaptop ([2601:600:877f:ad30:85c9:29bc:53c5:fe3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405189sm13508385ad.148.2025.06.06.08.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:17:43 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Eslam Khafagy'" <eslam.medhat1993@gmail.com>,
	<void@manifault.com>,
	<ast@kernel.org>
Cc: <linux-doc@vger.kernel.org>,
	<skhan@linuxfoundation.org>,
	<bpf@vger.kernel.org>
References: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
In-Reply-To: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
Subject: RE: [PATCH bpf-next] Documentation: Fix spelling mistake.
Date: Fri, 6 Jun 2025 08:17:41 -0700
Message-ID: <04a101dbd6f6$2635cac0$72a16040$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDY3jRyHAFXzUPlJpq2nKQRCvydhLX8LziQ
Content-Language: en-us



> -----Original Message-----
> From: Eslam Khafagy <eslam.medhat1993@gmail.com>
> Sent: Friday, June 6, 2025 3:05 AM
> To: void@manifault.com; ast@kernel.org
> Cc: linux-doc@vger.kernel.org; skhan@linuxfoundation.org;
bpf@vger.kernel.org;
> Eslam Khafagy <eslam.medhat1993@gmail.com>
> Subject: [PATCH bpf-next] Documentation: Fix spelling mistake.
> 
> Fix typo "desination => destination"
> in file
> Documentation/bpf/standardization/instruction-set.rst
> 
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index fbe975585236..ac950a5bb6ad 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -350,9 +350,9 @@ Underflow and overflow are allowed during arithmetic
> operations, meaning  the 64-bit or 32-bit value will wrap. If BPF program
execution
> would  result in division by zero, the destination register is instead set
to zero.
>  Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
-dividing -1,
> the desination register is instead set to ``LLONG_MIN``. For
> +dividing -1, the destination register is instead set to ``LLONG_MIN``.
> +For
>  ``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
-desination register
> is instead set to ``INT_MIN``.
> +destination register is instead set to ``INT_MIN``.
> 
>  If execution would result in modulo by zero, for ``ALU64`` the value of
the
> destination register is unchanged whereas for ``ALU`` the upper
> --
> 2.43.0

For just the spelling correction:
Acked-by: Dave Thaler <dthaler1968@gmail.com>

However the phrase "dividing -1" is one I find confusing.  E.g.,
"INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
Perhaps "divided by" instead of "dividing" assuming the inverse is meant.

Dave


