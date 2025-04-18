Return-Path: <bpf+bounces-56235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195ACA93A55
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF0178FE7
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B7214A7D;
	Fri, 18 Apr 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OUc7G6LQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C264211261
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992525; cv=none; b=UrTLukJg6zLKyeaAoliXAj9RgewQ1UIa6wARzI4OtLwKYjQ6Lt+MDeZR+PPI1yMkXAed+KN2hTz75IY+QwxPY1P4LRZOEu0dqv5CJgI+pjJVClIbwNJE6ROho0YR7Eg5CGyOIj/s47dYZhjokcYIxVMRhH1kBSZLyKXZVuVd0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992525; c=relaxed/simple;
	bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1lpGzO6rUDTc+K/IKKFhNzcSKGNtf5Nd3edna6fRJxbr/hKn236G429/KapZtg6SbZfr7Xwskypk1AtK1Kc0OlijP/qHZZZVUnMs26RTRl0nbDWM7NCNh1tujh//01zapCXEKLKIznu+Y2Dw5i3z8duXNohRWpB3q+McMM4kAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OUc7G6LQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac289147833so378020166b.2
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992522; x=1745597322; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
        b=OUc7G6LQ73mGB3DSetYq+jgZEbW4ByPEhGZOhVLDWDlIX11Khz3KdmAJaLD7k+vveH
         q8oOBBBvxNkk0J9aApAIkkhXudc7L+kKIPlwaaV4IPHmUJjnAGwhneydTEl69jaIB+OR
         z1bIt9HDDFLliHRvUMG85CID1HNVNR+pSNWgJu1vqrszyX7PpCLNi1Nclg/sr8wYVpOz
         rckvt6+U1/KJ3XqkdeXsLQPh1a2pD+I0SSTBuAMbrkhHfUfpy/PiZ354IzR6NqFFd6/o
         5ZUzB38NSdvc4a1Eawm3VUeV87ROkIF/Zl5oIwm08/8NQTaZWzbN4V1BivP7hpiyzCwA
         N2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992522; x=1745597322;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTRsdQyPhwEI7P5aYqr8HqSfKQVDCSCnob+lAcXVoLw=;
        b=gGeZ7fz8TOesxq5AMLXh7T6Iig/NVbgXNIf6bRku/L9OrEYCwLQ4JeNusflLjDEEZr
         U2w7gj4+gX5O0VvrIKJWtziOavVE4mG5u1N2PJc7IeWXqh2WOrXuvQV8n2Wt1RwTzgze
         G9do0GJvuuhZJUHuOK/8EfjJy4q80jxil1pjYxeYKcczIHhMqVdMkIphER/u69ZK0kCu
         7LPAS99HU0oXoIaguOvCGcMq9f4CBMZXhEv5iJJA0NAhP1uxX7EoRn69/93ZQI0B7Pt6
         wJlmoapmKr/pfUFZNEvlfAsKsEKRtaP4Ry54FZuauO9l688cOWqSZ/oIH742PYf5XlcN
         lX+w==
X-Forwarded-Encrypted: i=1; AJvYcCUi1pU49HykWRvrecFoTEqpW/9BKlv7Hlw4O2Fcxuu4L+7XhYF/vbUcErcPNb92HQyndXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCQoEV2RUSqSW2ZtCN50VdRXw5l8TYUyQMLw7oVHPZ3RkyAOn
	fnRz78kqfOI2FDA8B8lW1ZmHBp66BtFO6j4Bw+Gvs2tvz85NYO7TOv1mTQngbDU=
X-Gm-Gg: ASbGncsEqoh3v5ybzlkfMYkvc3IulXCuZ7WSJCBoqcVcVJsz1ZP+ZSLLcNOTUvJYqvp
	pGhqWLBWPpc7jrZ0DNkjd8Z5mFfz7MV82u3tz/AgR1hNqd94P520bSUGkmh5ao+boUOAovrvpTj
	dFkhcDoSW9U1YGL2gk6qdWLjEsrAftg7hi3926TiWWRM8dGMvNpbum/GEwJCoQEB3OuGSz8t9qM
	vodAfDkR7ua8lXy8NusgvUnVNg0xNaY0b/WGwJBf0vw7Hchdxlx53bBsMKa1AzTTNat+lU5gYTa
	J5qY1QDhwltmFtJCUgVAzV/u8RVHpGOmEUoLfCsmXKQM
X-Google-Smtp-Source: AGHT+IHa4TgX8s0MmpF8GB8R16O010Ve/qC4qv/99ZOSj9/ybMOt/qI/ikL+RDoyJZEPVnEbqnzHwA==
X-Received: by 2002:a17:907:3fa1:b0:ac6:d0f6:c85c with SMTP id a640c23a62f3a-acb74b36c70mr264464766b.20.1744992521672;
        Fri, 18 Apr 2025 09:08:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec51601sm137723466b.74.2025.04.18.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:08:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/9] selftests/bpf: Add socket_kind_to_str()
 to socket_helpers
In-Reply-To: <20250411-selftests-sockmap-redir-v2-2-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:38 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-2-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:08:30 +0200
Message-ID: <87h62la1vl.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Add function that returns string representation of socket's domain/type.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

