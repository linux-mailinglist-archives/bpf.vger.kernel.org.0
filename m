Return-Path: <bpf+bounces-45802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A59DB1AE
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16016165269
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC684D29;
	Thu, 28 Nov 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrnnhnIL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EF83CC7;
	Thu, 28 Nov 2024 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763258; cv=none; b=aFqos2Ci0yfMnzzd7mDXkPLtW8px8zfzqFj2UCCa9xkiV4XGWVw9RK7KkjNcA72UtHzGNT/y4n1vo7yNf/8OiwIU7nyOM0Il7lw1BUnSCCgKrZoHSpzRcNaZM1s4Ksqt9WgET3aQkLTpbOe7Gk0ZThFuMKp8xazRLemCJyODbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763258; c=relaxed/simple;
	bh=YsIDpOfw9fxEXa9PMT+PJYap0TaX9XOpwLB1c1bglJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRacjlFfToIXQKUgIzaElq5UtqJI7WKHU8yWp2sZAq708YndpbAxef43FXaS4t1lFbz+wMqnK1oqtZJnG38/dbvx+JnS78gm/Jrm+ujZkBtOCx/o8jhb7hJhwSiSev2YCboxxVdYGvmVS3WuRJnJcPZ9Un82t10l5mfJCbFpdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrnnhnIL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434aabd688fso1580665e9.3;
        Wed, 27 Nov 2024 19:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763255; x=1733368055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsIDpOfw9fxEXa9PMT+PJYap0TaX9XOpwLB1c1bglJc=;
        b=VrnnhnILJbWt1l/yK4wEzwMV8XBPBOXgyx30xQpLH3/VJ/bBKiHB0UM5AKqQDmo+y7
         b1SfjTT7F3vIcUmjLdA/aJvWOFR9ElwAVEFIsn1UcQT2FNcLuAXLFiif+0Mt9eUvSg0u
         LZNjRyxrsFdDd+ZEQDurODP82oZlO4yyHhPEnZm7bi3NoWKRbzUc0voPZhaXRYy25T9P
         jDmK+Sq5NWbDndN+d23styo0Hy0lHrsuIxE983lpl3+GVzhDbd1MxnfrCtqJoCivAyox
         ePJGdU9+qxT08E5FhyQWlMb0fQ7K6uqvh73Ngk6CuN18iFEqtzPmu9I9cWnlpgEwWqWS
         ynEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763255; x=1733368055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsIDpOfw9fxEXa9PMT+PJYap0TaX9XOpwLB1c1bglJc=;
        b=ixfARMYqvl5T6/ZD6Nvq53JmpG8hbwjNsWr4EgZxDBDoVAskoepww9Sq3o5QaAdkc7
         wN9gdA/jOeC1aJTFuylxnl4kmh4wrfEy/Lghd8qFJ3U+5z7wiclV/ZVkUhfng9CvaGVS
         9q1U68gFAlq7hITGw45+0zO6R8iSQFEJ/2i3C/QrTFE95jDz6H0jibQyY/586tWX0P8D
         pUwmf3zBSwVcqoCf/Uigr8QlUY1iRkyhpK6VQ1YqW5yZqnfCiVbzzT7vAAJdEJYYe8Mj
         rZI1NbhSze1MZs0fKQa0FAR7UcLVn8gfmmq1Wb1Or2LZqHV+c30iLhH7BPxEfeQPk/Dx
         EicA==
X-Forwarded-Encrypted: i=1; AJvYcCWhByNCQ6lWIznT2B/RyOIgOyTVYNgh0WP0kU/Ol2MCVHenLjxAubluaCKe6q7snE+JLvIDs7Ts02T3n258@vger.kernel.org, AJvYcCXyAz7lpyUCWI0KwYfTLQAfZB5wvBoTbTPgGYpn/iXF73c6x73OP1nnzUzqqJ8K8iD2ewA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpimMxEhdaB98v/zpxwAbXecENQyIKsP3B9eam5KWPhf2ll5F
	YvpZ0SxHqhiPCcCADX3ZrsW/QuyPL3PQN9flI+pCOzzWsUCNW/prYKIhAU9r5spJjcyTpcmX+GM
	3LZPMtVH6QJuWDOsTgcNL8Zs0rzQ=
X-Gm-Gg: ASbGnctFq9NVFUaYNbt6G6GV2TQQ9EE9cvd3Wx+DuBDTruLQ/uqmBUc10S1QXJ2CXuj
	O+7oB6Mr+HeChsfwnM7OCBLpXzn7nZQ==
X-Google-Smtp-Source: AGHT+IGwJZd3dWNRU/Wf2cWRKAuvFJ2DWNq705Ncv4v/IP/G5Gl1SFi8i6ZoIfULly4LoWmgIPcVtboABgzDiUikuFE=
X-Received: by 2002:a05:6000:18ab:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-385c6edd52dmr4564193f8f.45.1732763255338; Wed, 27 Nov 2024
 19:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128025551.2868-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241128025551.2868-1-liujing@cmss.chinamobile.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Nov 2024 19:07:24 -0800
Message-ID: <CAADnVQJmTXvU-WZRVRTO7X661Voc6iaBzdUBWHQ+yxCgCVFx8A@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf: bpftool:Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:56=E2=80=AFPM liujing <liujing@cmss.chinamobile.c=
om> wrote:
>
> The output format of unsigned int should be %u, and the output
> format of int should be %d, so fix it.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

same issue. full name pls.

pw-bot: cr

